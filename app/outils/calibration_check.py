#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
calibration_check.py — Gate de la carte de calibration (hors-ligne, stdlib).

La carte isotonique est apprise des données ; avant de la GELER dans regles.json,
on vérifie qu'elle améliore (ou au moins ne dégrade pas) l'ECE sur un jeu d'événements
TENU À L'ÉCART (validation croisée simple train/test). C'est le pendant, côté
calibration, du harness moteur qui valide le contenu.

USAGE
-----
    python outils/calibration_check.py --events ./donnees/events.jsonl
    python outils/calibration_check.py --events ./donnees/events.jsonl --test-ratio 0.3 --seed 1 --tolerance 0.0

Sortie : ECE hors-échantillon brut vs calibré, et un verdict GO / NO-GO.
Code de sortie 0 si GO (calibration ne dégrade pas l'ECE au-delà de la tolérance), 1 sinon.
"""
from __future__ import annotations
import argparse
import json
import random
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import dex_castin_calibration as calib  # noqa: E402


def charger_pairs(events_path: Path):
    pairs = []
    if not events_path.exists():
        return pairs
    for line in events_path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            e = json.loads(line)
        except json.JSONDecodeError:
            continue
        sb = e.get("score_brut")
        v = e.get("verdict")
        if isinstance(sb, (int, float)) and v in ("accepte", "signale"):
            pairs.append((float(sb), 1.0 if v == "accepte" else 0.0))
    return pairs


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description="Gate hors-échantillon de la calibration isotonique.")
    ap.add_argument("--events", type=Path, default=Path("./donnees/events.jsonl"))
    ap.add_argument("--test-ratio", type=float, default=0.3)
    ap.add_argument("--seed", type=int, default=1)
    ap.add_argument("--min-n", type=int, default=30, help="Volume minimal pour statuer.")
    ap.add_argument("--tolerance", type=float, default=0.0,
                    help="Dégradation d'ECE tolérée (NO-GO si ece_calibré > ece_brut + tolérance).")
    args = ap.parse_args(argv)

    pairs = charger_pairs(args.events)
    n = len(pairs)
    if n < args.min_n:
        print(f"Volume insuffisant : {n} < {args.min_n}. NO-GO (continuer la validation).")
        return 1

    rnd = random.Random(args.seed)
    idx = list(range(n))
    rnd.shuffle(idx)
    n_test = max(1, int(n * args.test_ratio))
    test_i = set(idx[:n_test])
    train = [pairs[i] for i in range(n) if i not in test_i]
    test = [pairs[i] for i in range(n) if i in test_i]

    fit_map = calib.fit_isotonic_map([p[0] for p in train], [p[1] for p in train])

    xs_t = [p[0] for p in test]
    ys_t = [p[1] for p in test]
    ece_brut, _ = calib.ece(xs_t, ys_t)
    cal_scores = [_interp(fit_map, x) for x in xs_t]
    ece_cal, _ = calib.ece(cal_scores, ys_t)
    brier_brut = calib.brier(xs_t, ys_t)
    brier_cal = calib.brier(cal_scores, ys_t)

    print(f"n={n}  train={len(train)}  test={len(test)}")
    print(f"ECE hors-échantillon : brut={ece_brut}  ->  calibré={ece_cal}")
    print(f"Brier hors-échantillon : brut={brier_brut}  ->  calibré={brier_cal}")
    go = (ece_cal is not None and ece_brut is not None and ece_cal <= ece_brut + args.tolerance)
    print("VERDICT :", "GO (la calibration ne dégrade pas l'ECE)" if go
          else "NO-GO (la calibration dégrade l'ECE au-delà de la tolérance)")
    return 0 if go else 1


def _interp(pts, x):
    """Interpolation linéaire bornée (même sémantique que le serveur)."""
    if not pts:
        return x
    if x <= pts[0][0]:
        return float(pts[0][1])
    if x >= pts[-1][0]:
        return float(pts[-1][1])
    for i in range(1, len(pts)):
        x0, y0 = pts[i - 1]
        x1, y1 = pts[i]
        if x <= x1:
            if x1 == x0:
                return float(y1)
            t = (x - x0) / (x1 - x0)
            return float(y0 + t * (y1 - y0))
    return float(pts[-1][1])


if __name__ == "__main__":
    raise SystemExit(main())
