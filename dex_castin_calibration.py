#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
dex_castin_calibration.py — Calibration de la confiance (boucle de 2e ordre).

Bibliothèque standard UNIQUEMENT. Fournit :
  - fit_isotonic(xs, ys)      : régression isotonique non décroissante (PAV)
  - apply_calibration(x, map) : applique une carte gelée à un score brut
  - ece(scores, outcomes)     : Expected Calibration Error + diagramme de fiabilité
  - brier(scores, outcomes)   : score de Brier
  - bump_version(v)           : incrément SemVer mineur (patch de calibration = changement de comportement)

PRINCIPE
--------
La confiance "brute" est un prior heuristique déterministe f(DEX, version_règles).
La calibration apprend, sur les verdicts humains (accepté=1 / signalé=0), une carte
MONOTONE score_brut -> probabilité d'acceptation empirique. Une fois GELÉE dans
regles.json (versionnée), elle rend la confiance affichée fiable et reproductible :
deux exécutions d'un même DEX sous la même version donnent la même confiance et le
même routage. Le contenu métier n'est jamais touché (règle 7).
"""

from __future__ import annotations
from typing import Optional


def fit_isotonic(xs: list[float], ys: list[float], weights: Optional[list[float]] = None) -> dict:
    """Régression isotonique non décroissante par Pool Adjacent Violators (PAV).

    Retourne {"blocks": [{"x_lo", "x_hi", "y"}...], "n": N} où les blocs sont
    triés par x croissant et leurs valeurs y sont non décroissantes."""
    n = len(xs)
    if n == 0:
        return {"blocks": [], "n": 0}
    order = sorted(range(n), key=lambda i: xs[i])
    blocks: list[list[float]] = []  # [somme_wy, somme_w, x_lo, x_hi]
    for i in order:
        wi = 1.0 if weights is None else float(weights[i])
        blocks.append([float(ys[i]) * wi, wi, float(xs[i]), float(xs[i])])
        # fusionne tant que le bloc précédent viole la monotonie (moyenne >= suivante)
        while len(blocks) >= 2 and (blocks[-2][0] / blocks[-2][1]) >= (blocks[-1][0] / blocks[-1][1]) - 1e-12:
            b2 = blocks.pop()
            b1 = blocks.pop()
            blocks.append([b1[0] + b2[0], b1[1] + b2[1], b1[2], b2[3]])
    return {"blocks": [{"x_lo": round(b[2], 6), "x_hi": round(b[3], 6),
                        "y": round(b[0] / b[1], 6)} for b in blocks], "n": n}


def apply_calibration(x: Optional[float], calib: Optional[dict]) -> Optional[float]:
    """Applique une carte de calibration gelée à un score brut (fonction en
    escalier monotone). Identité si la carte est absente/vide ou x est None."""
    if x is None:
        return None
    if not calib or not calib.get("blocks"):
        return x
    blocks = calib["blocks"]
    y = blocks[0]["y"]
    for b in blocks:
        if b["x_lo"] <= x:
            y = b["y"]
        else:
            break
    return round(y, 4)


def ece(scores: list[float], outcomes: list[float], m: int = 10) -> tuple[Optional[float], list[dict]]:
    """Expected Calibration Error sur `m` tranches + diagramme de fiabilité.
    outcomes ∈ {0,1}. ECE = Σ (|Bₖ|/N)·|acceptation(Bₖ) − confiance(Bₖ)|."""
    n = len(scores)
    if n == 0:
        return None, []
    buckets: list[list[tuple[float, float]]] = [[] for _ in range(m)]
    for s, o in zip(scores, outcomes):
        sc = min(0.999999, max(0.0, float(s)))
        buckets[min(m - 1, int(sc * m))].append((sc, float(o)))
    e = 0.0
    rel: list[dict] = []
    for k, b in enumerate(buckets):
        lo, hi = k / m, (k + 1) / m
        if not b:
            rel.append({"bin": [round(lo, 2), round(hi, 2)], "n": 0, "confiance": None, "acceptation": None})
            continue
        conf = sum(s for s, _ in b) / len(b)
        acc = sum(o for _, o in b) / len(b)
        e += (len(b) / n) * abs(acc - conf)
        rel.append({"bin": [round(lo, 2), round(hi, 2)], "n": len(b),
                    "confiance": round(conf, 3), "acceptation": round(acc, 3)})
    return round(e, 4), rel


def brier(scores: list[float], outcomes: list[float]) -> Optional[float]:
    """Score de Brier = moyenne((score − issue)²). Plus bas = mieux. ∈ [0,1]."""
    if not scores:
        return None
    return round(sum((float(s) - float(o)) ** 2 for s, o in zip(scores, outcomes)) / len(scores), 4)


def fit_isotonic_map(xs: list[float], ys: list[float], weights: Optional[list[float]] = None) -> list[list[float]]:
    """Ajuste une carte de calibration au FORMAT POINTS `[[x,y], ...]` croissants,
    directement utilisable par le serveur (_interp_monotone / is_monotone_map).
    Construite depuis les blocs PAV, ancrée sur [0,1]."""
    fit = fit_isotonic(xs, ys, weights)
    blocks = fit["blocks"]
    if not blocks:
        return []
    pts: list[list[float]] = []
    for b in blocks:
        pts.append([round(b["x_lo"], 4), round(b["y"], 4)])
        if b["x_hi"] != b["x_lo"]:
            pts.append([round(b["x_hi"], 4), round(b["y"], 4)])
    if pts[0][0] > 0.0:
        pts.insert(0, [0.0, pts[0][1]])
    if pts[-1][0] < 1.0:
        pts.append([1.0, pts[-1][1]])
    out: list[list[float]] = []
    for p in pts:
        if out and abs(out[-1][0] - p[0]) < 1e-9:
            out[-1][1] = max(out[-1][1], p[1])  # même x : on garde le palier supérieur (monotone)
        else:
            out.append([p[0], p[1]])
    return out


def bump_version(version: str) -> str:
    """Incrément SemVer mineur (X.Y.Z -> X.(Y+1).0). Une carte de calibration
    qui pilote le routage est un changement de comportement => mineur."""
    parts = (version or "0.0.0").split(".")
    while len(parts) < 3:
        parts.append("0")
    try:
        return f"{int(parts[0])}.{int(parts[1]) + 1}.0"
    except ValueError:
        return "0.1.0"


# --------------------------------------------------------------------------- #
# Auto-test (python dex_castin_calibration.py)                                 #
# --------------------------------------------------------------------------- #

if __name__ == "__main__":
    import random

    # 1) Monotonie sur cas connu
    fit = fit_isotonic([0.1, 0.2, 0.3, 0.4], [1, 0, 1, 1])
    ys = [b["y"] for b in fit["blocks"]]
    assert ys == sorted(ys), ys
    print("isotonic cas simple:", fit["blocks"])

    # 2) Réduction d'ECE sur données sur-confiantes simulées
    random.seed(7)
    raw, out = [], []
    for _ in range(2000):
        # vraie proba ~ 0.6*score (le modèle brut est sur-confiant)
        s = random.random()
        p_true = 0.15 + 0.6 * s
        raw.append(s)
        out.append(1 if random.random() < p_true else 0)
    e_brut, _ = ece(raw, out)
    fit2 = fit_isotonic(raw, out)
    cal = [apply_calibration(s, fit2) for s in raw]
    e_cal, _ = ece(cal, out)
    print(f"ECE brut={e_brut}  ->  ECE calibré={e_cal}  (Brier {brier(raw,out)} -> {brier(cal,out)})")
    assert e_cal <= e_brut, (e_brut, e_cal)

    # 3) Application bornée et monotone
    xs = [i / 20 for i in range(21)]
    cs = [apply_calibration(x, fit2) for x in xs]
    assert all(0.0 <= c <= 1.0 for c in cs)
    assert cs == sorted(cs)
    assert bump_version("1.0.0") == "1.1.0"
    # 4) carte au format points : monotone, bornée, applicable par le serveur
    pmap = fit_isotonic_map(raw, out)
    xsm = [p[0] for p in pmap]; ysm = [p[1] for p in pmap]
    assert xsm == sorted(xsm) and ysm == sorted(ysm), pmap
    assert all(0.0 <= v <= 1.0 for v in xsm + ysm)
    print(f"carte points: {len(pmap)} points, bornée et monotone OK")
    print("bornes [0,1] OK, monotone OK, bump_version OK")
    print("TOUS LES CONTROLES CALIBRATION PASSES.")
