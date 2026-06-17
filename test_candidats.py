#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Test unitaire de la désambiguïsation multi-candidats (sans docx).
Construit des `items` moteur directement et vérifie _field_candidates :
énumération fidèle, classement, drapeau d'ambiguïté, fidélité du contenu."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import dex_castin_common as dex
import dex_castin_server as srv

def H(t, lvl=2): return dex.Paragraph(runs=[dex.Run(text=t)], heading_level=lvl)
def P(t):        return dex.Paragraph(runs=[dex.Run(text=t)], heading_level=None)
RULES = dict(srv.DEFAULT_RULES)

def fdef(kw, kind="text"):
    return {"key": "x", "label": "X", "kind": kind, "tab": "DEX", "keywords": kw}

# 1) un seul candidat -> non ambigu
items = [H("Supervision"), P("contenu supervision")]
c, moteur, amb = srv._field_candidates(items, fdef(["supervision"]), RULES)
assert len(c) == 1 and amb is False and moteur == 0, (len(c), amb, moteur)
print("1) un candidat -> non ambigu : OK")

# 2) near-tie (singulier/pluriel) -> ambigu par marge
items = [H("Comptes de service"), P("A"), H("Comptes de services"), P("B")]
c, moteur, amb = srv._field_candidates(items, fdef(["compte de service", "comptes de service"]), RULES)
assert len(c) == 2 and amb is True, (len(c), amb, [x["score"] for x in c])
assert moteur == 0
print(f"2) near-tie -> ambigu : OK (scores {[x['score'] for x in c]})")

# 3) désaccord : le 1er match moteur n'est pas le mieux scoré -> ambigu
items = [H("Logs applicatifs des partenaires"), P("A"), H("Diagnostique"), P("B")]
kw = ["diagnostic", "diagnostique", "log", "trace"]
c, moteur, amb = srv._field_candidates(items, fdef(kw), RULES)
fs = dex.find_section(items, kw)            # ce que le MOTEUR choisit réellement
assert fs[0] == moteur == 0, (fs, moteur)   # 1er match = "Logs applicatifs..."
assert c[0]["titre"] == "Diagnostique"      # mais le mieux scoré est "Diagnostique"
assert amb is True
print(f"3) désaccord moteur/score -> ambigu : OK (top='{c[0]['titre']}', moteur=idx{moteur})")

# 4) fidélité du contenu : contenu candidat == section_text de son span
top = c[0]
attendu = dex.section_text(items, top["span"][0], top["span"][1])
assert top.get("contenu") == attendu == "B", (top.get("contenu"), attendu)
print("4) fidélité contenu (== section_text) : OK")

# 5) déterminisme : deux appels identiques -> même résultat
c2, m2, a2 = srv._field_candidates(items, fdef(kw), RULES)
assert [x["index"] for x in c2] == [x["index"] for x in c] and (m2, a2) == (moteur, amb)
print("5) déterminisme : OK")

print("\nTOUS LES TESTS CANDIDATS PASSES.")
