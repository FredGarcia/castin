#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Smoke-test du service back (stdlib only). Démarre le serveur sur un port
libre, exerce les endpoints sur un vrai DEX, et vérifie le scénario
'replay après patch de règle'. Sert aussi de documentation par l'exemple."""
from __future__ import annotations
import json, socket, subprocess, sys, time, urllib.request
from pathlib import Path

HERE = Path(__file__).resolve().parent.parent


def _find_dex() -> Path:
    """Localise le DEX nominal sans présumer du packaging.
    Ordre : variable d'env DEX_SMOKE, tests/, racine projet, uploads."""
    import os
    env = os.environ.get("DEX_SMOKE")
    candidates = []
    if env:
        candidates.append(Path(env))
    name = "DEX_S20001_Nominal.docx"
    candidates += [
        HERE / "tests" / name,
        HERE / name,
        Path("/mnt/user-data/uploads") / name,
    ]
    for c in candidates:
        if c.exists():
            return c
    raise SystemExit(
        "DEX de test introuvable. Placez 'DEX_S20001_Nominal.docx' à la racine "
        "ou dans tests/, ou exportez DEX_SMOKE=/chemin/vers/le.docx."
    )


DEX = _find_dex()


def free_port() -> int:
    s = socket.socket(); s.bind(("127.0.0.1", 0)); p = s.getsockname()[1]; s.close(); return p


def call(method, url, payload=None):
    data = json.dumps(payload).encode() if payload is not None else None
    req = urllib.request.Request(url, data=data, method=method,
                                 headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=15) as r:
        return json.loads(r.read().decode())


def main() -> int:
    port = free_port()
    import tempfile
    data_dir = Path(tempfile.mkdtemp(prefix="dex_smoke_"))
    base = f"http://127.0.0.1:{port}"
    proc = subprocess.Popen(
        [sys.executable, str(HERE / "dex_castin_server.py"),
         "--host", "127.0.0.1", "--port", str(port), "--data-dir", str(data_dir)],
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    try:
        # attendre l'écoute
        for _ in range(50):
            try:
                h = call("GET", f"{base}/api/health"); break
            except Exception:
                time.sleep(0.1)
        else:
            print("Le serveur n'a pas démarré."); print(proc.stdout.read()); return 1

        assert h["status"] == "ok", h
        print(f"[health] ok — règles {h['rules_version']}, {h['n_champs']} champs")

        # process par chemin local
        res = call("POST", f"{base}/api/process-dex", {"path": str(DEX)})
        sol = res["identification"]["solution"]
        confs = {k: v["confiance"] for k, v in res["champs"].items()}
        n_spans = sum(1 for v in res["champs"].values() if v["source_spans"])
        print(f"[process] solution={sol} | signature={res['gabarit_signature']} | "
              f"champs avec span={n_spans}/{len(res['champs'])} | points={len(res['points_a_verifier'])}")
        assert sol == "S20001"
        assert confs["principes_decisions"] is None           # vide -> pas de confiance
        assert confs["supervision"] is not None and confs["supervision"] > 0.5
        assert res["champs"]["supervision"]["source_spans"]    # span présent
        assert any(d["is_explanatory"] for d in res["document"])  # encart d'aide détecté

        # quelques validations humaines (accepte / signale) avec confiance affichée
        def validate(champ, verdict, conf, **extra):
            return call("POST", f"{base}/api/validate",
                        {"dex_id": sol, "champ": champ, "verdict": verdict,
                         "confiance": conf, "score_brut": conf,
                         "gabarit_signature": res["gabarit_signature"],
                         "duree_traitement_s": 600, **extra})
        validate("supervision", "accepte", confs["supervision"], operateur_role="rodage")
        validate("observabilite", "accepte", confs["observabilite"], operateur_role="rodage")
        validate("flux", "accepte", confs["flux"])
        validate("log", "signale", confs["log"], type_signalement="mauvaise_section",
                 correction={"section_attendue": "Diagnostique"})
        validate("certificats", "accepte", confs["certificats"])
        print("[validate] 5 événements enregistrés")

        m = call("GET", f"{base}/api/metrics")
        print(f"[metrics] n={m['n_evenements']} calibrables={m['n_calibrables']} "
              f"Brier={m['brier_global']} ECE={m['ece']} (cible {m['cible_ece']}) "
              f"débit_médian={m['debit']['median_s']}s alertes={len(m['alertes'])}")
        assert m["n_evenements"] == 5
        assert m["brier_global"] is not None and m["ece"] is not None

        # --- scénario "replay après patch de règle" -----------------------
        # 1er replay sous v1.0.0 (instantané de référence créé au process ci-dessus)
        r1 = call("POST", f"{base}/api/replay", {"path": str(DEX), "dex_id": sol})
        print(f"[replay v1] instantané_precedent={r1['a_un_instantane_precedent']} "
              f"modifs={len(r1['champs_modifies'])} points {r1['n_points_avant']}->{r1['n_points_apres']}")

        # On simule un patch de lexique versionné : ajouter un mot-clé + bump version,
        # puis recharger les règles, puis rejouer pour mesurer l'effet.
        rules_path = data_dir / "regles.json"
        rules = json.loads(rules_path.read_text(encoding="utf-8"))
        rules["version"] = "1.1.0"
        rules.setdefault("extra_keywords", {}).setdefault("observabilite", []).append("supervision applicative")
        rules_path.write_text(json.dumps(rules, ensure_ascii=False, indent=2), encoding="utf-8")
        call("POST", f"{base}/api/rules/reload")
        h2 = call("GET", f"{base}/api/health")
        assert h2["rules_version"] == "1.1.0", h2
        r2 = call("POST", f"{base}/api/replay", {"path": str(DEX), "dex_id": sol})
        print(f"[replay v1.1] version {r2['version_avant']}->{r2['version_apres']} "
              f"modifs={len(r2['champs_modifies'])} points_resolus={len(r2['points_resolus'])} "
              f"points_nouveaux={len(r2['points_nouveaux'])}")
        assert r2["version_apres"] == "1.1.0"

        # --- calibrateur isotonique hors-ligne (produit un candidat versionné) ---
        import subprocess as sp
        cp = sp.run([sys.executable, str(HERE/"outils"/"calibrer.py"),
                     "--events", str(data_dir/"events.jsonl"),
                     "--rules", str(rules_path),
                     "--sortie", str(data_dir/"regles.candidat.json")],
                    capture_output=True, text=True)
        assert cp.returncode == 0, cp.stdout+cp.stderr
        assert (data_dir/"regles.candidat.json").exists()
        print("[calibrer] candidat produit :", [l for l in cp.stdout.splitlines() if "ECE" in l][-1:])

        # --- activer une calibration MONOTONE + un seuil de routage (versionnés) ---
        rules = json.loads(rules_path.read_text(encoding="utf-8"))
        rules["version"] = "1.2.0"
        rules["seuil_routage"] = 0.85
        rules["calibration"] = {"actif": True, "min_n_par_champ": 30, "par_champ": {},
                                "par_defaut": [[0.0,0.0],[0.3,0.2],[0.8,0.6],[0.9,0.7],[0.98,0.8]]}
        rules_path.write_text(json.dumps(rules, ensure_ascii=False, indent=2), encoding="utf-8")
        rr = call("POST", f"{base}/api/rules/reload")
        assert rr["calibration_active"] is True and not rr["avertissements"], rr
        res3 = call("POST", f"{base}/api/process-dex", {"path": str(DEX)})
        sup = res3["champs"]["supervision"]
        print(f"[calibration] supervision score_brut={sup['score_brut']} -> confiance={sup['confiance']} "
              f"route_attention={sup['route_attention']} | points={len(res3['points_a_verifier'])}")
        assert sup["score_brut"] == 0.9 and sup["confiance"] == 0.7      # carte: 0.9 -> 0.7
        assert sup["route_attention"] is True                            # 0.7 < seuil 0.85
        assert any("confiance calibrée" in p for p in res3["points_a_verifier"])

        # --- gate de monotonie : une carte NON monotone est refusée au chargement ---
        rules["calibration"]["par_defaut"] = [[0.0,0.5],[0.5,0.2]]       # décroissante -> invalide
        rules_path.write_text(json.dumps(rules, ensure_ascii=False, indent=2), encoding="utf-8")
        rr2 = call("POST", f"{base}/api/rules/reload")
        assert rr2["calibration_active"] is False and rr2["avertissements"], rr2
        print(f"[gate] carte non monotone -> calibration désactivée + avertissement : OK")

        print("\nTOUS LES CONTROLES SONT PASSES.")
        return 0
    finally:
        proc.terminate()
        try:
            proc.wait(timeout=5)
        except subprocess.TimeoutExpired:
            proc.kill()


if __name__ == "__main__":
    raise SystemExit(main())
