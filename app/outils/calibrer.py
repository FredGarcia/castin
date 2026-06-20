#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
calibrer.py — Calibrateur isotonique HORS-LIGNE (stdlib only).

Rôle dans la boucle de 2e ordre : à partir du journal de verdicts
(events.jsonl : score_brut -> accepté/signalé), AJUSTE une carte de calibration
isotonique (globale et par champ si le volume le permet) et écrit un CANDIDAT de
regles.json versionné, calibration active. Il ne PROMEUT rien : la décision
GO/NO-GO appartient au gate (outils/calibration_check.py, hors-échantillon) puis
au harness moteur. Workflow d'audit :

    1) python outils/calibrer.py --events ./donnees/events.jsonl \
                                 --rules ./regles.json \
                                 --sortie ./regles.candidate.json
    2) python outils/calibration_check.py --events ./donnees/events.jsonl   # GO ?
    3) (si GO + harness vert) copier regles.candidate.json -> regles.json
       puis POST /api/rules/reload  (le serveur revalide la monotonie au chargement)

Séparation des responsabilités assumée :
  - calibrer.py        : AJUSTE et rapporte (in-sample), sur le volume disponible.
  - calibration_check  : DÉCIDE (volume minimal + ECE hors-échantillon non dégradé).

La logique de fit + construction du patch est RÉUTILISÉE depuis le serveur
(_analyse_calibration) pour garantir l'absence de dérive avec l'endpoint
/api/calibration/proposer. (Refactor possible : hisser cette fonction dans
dex_castin_calibration si l'on veut découpler totalement l'outillage du serveur.)
"""
from __future__ import annotations
import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import dex_castin_server as srv  # noqa: E402  (import sûr : ne démarre pas le serveur)


def charger_events(path: Path) -> list[dict]:
    events: list[dict] = []
    if not path.exists():
        return events
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            events.append(json.loads(line))
        except json.JSONDecodeError:
            continue
    return events


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description="Calibrateur isotonique hors-ligne (produit un candidat versionné).")
    ap.add_argument("--events", type=Path, default=Path("./donnees/events.jsonl"),
                    help="Journal des verdicts (events.jsonl).")
    ap.add_argument("--rules", type=Path, default=Path("./regles.json"),
                    help="Règles versionnées de départ (overlay).")
    ap.add_argument("--sortie", type=Path, default=Path("./regles.candidate.json"),
                    help="Chemin du candidat à écrire.")
    ap.add_argument("--min-n", type=int, default=1,
                    help="Volume minimal pour AJUSTER (l'outil fitte dès ce seuil ; "
                         "le gate impose, lui, le seuil de PROMOTION, 30 par défaut).")
    ap.add_argument("--recommande-n", type=int, default=30,
                    help="Volume recommandé en dessous duquel un avertissement est émis.")
    ap.add_argument("--verifier", action="store_true",
                    help="Mode contrôle STRUCTUREL : vérifie qu'un fichier de règles (--rules) "
                         "porte une carte de calibration monotone et bornée (contrôle identique à "
                         "celui du serveur au chargement). Avec --events, rapporte aussi l'ECE "
                         "in-sample brut vs calibré. NB : le gate STATISTIQUE hors-échantillon "
                         "reste calibration_check.py.")
    args = ap.parse_args(argv)

    # --- Mode contrôle structurel (réutilise la validation du serveur) ------- #
    if args.verifier:
        rules = json.loads(args.rules.read_text(encoding="utf-8")) if args.rules.exists() else {}
        avert = srv.valider_regles(rules)
        if avert:
            print("CARTE INVALIDE — la calibration serait refusée au chargement :")
            for a in avert:
                print(f"  - {a}")
            return 1
        cal = (rules.get("calibration") or {})
        etat = "active" if cal.get("actif") else "inactive"
        print(f"Carte de calibration valide (monotone, bornée). Calibration {etat}.")
        events = charger_events(args.events)
        pairs = [(float(e["score_brut"]), 1.0 if e["verdict"] == "accepte" else 0.0)
                 for e in events
                 if isinstance(e.get("score_brut"), (int, float)) and e.get("verdict") in ("accepte", "signale")]
        if pairs:
            xs = [p[0] for p in pairs]
            ys = [p[1] for p in pairs]
            ece_brut, _ = srv.calib.ece(xs, ys)
            cal_scores = [srv.apply_calibration(x, e.get("champ"), rules)
                          for x, e in zip(xs, (e for e in events
                          if isinstance(e.get("score_brut"), (int, float)) and e.get("verdict") in ("accepte", "signale")))]
            ece_cal, _ = srv.calib.ece(cal_scores, ys)
            print(f"ECE in-sample sur {len(pairs)} verdicts : brut={ece_brut} -> calibré={ece_cal}")
            print("Rappel : décision GO/NO-GO = python outils/calibration_check.py (hors-échantillon).")
        return 0

    events = charger_events(args.events)
    rules = json.loads(args.rules.read_text(encoding="utf-8")) if args.rules.exists() else {}

    ana = srv._analyse_calibration(events, rules, min_n_global=args.min_n)
    n = ana.get("n", 0)

    if not ana.get("suffisant"):
        print(ana.get("message", f"Volume insuffisant pour ajuster ({n} < {args.min_n})."))
        print("Aucun candidat écrit. Poursuivez la validation (période de rodage).")
        return 1

    args.sortie.parent.mkdir(parents=True, exist_ok=True)
    args.sortie.write_text(json.dumps(ana["patch_regles"], ensure_ascii=False, indent=2), encoding="utf-8")

    champs = ana.get("champs_calibres", [])
    print(f"Candidat écrit : {args.sortie}")
    print(f"Version proposée : {rules.get('version', '0.0.0')} -> {ana['version_proposee']}")
    print(f"Volume calibrable : n={n}"
          + (f"  | champs calibrés par champ : {', '.join(champs)}" if champs else "  | carte globale seule"))
    print(f"ECE in-sample : brut={ana['ece_brut']}  ->  estimé={ana['ece_estime']}  (gain {ana['gain']})")
    if n < args.recommande_n:
        print(f"AVERTISSEMENT : n={n} < {args.recommande_n} recommandé. Candidat indicatif — "
              f"le gate (calibration_check) refusera la promotion tant que le volume/hors-échantillon "
              f"n'est pas satisfaisant.")
    print("Étapes suivantes : 1) gate hors-échantillon  2) harness moteur  3) promotion + /api/rules/reload.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
