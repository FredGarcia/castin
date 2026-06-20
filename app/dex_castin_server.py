#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
dex_castin_server.py — Service back LOCAL de la reprise DEX -> CAST'IN.

Rôle
----
Expose, sur 127.0.0.1, le moteur `dex_castin_common` à un front (VueJS) et
porte la *boucle d'amélioration de 2e ordre* (annexe du cahier des charges) :

  - /api/health        état du service + version des règles chargées
  - /api/process-dex   traite un DEX (.docx) et renvoie le résultat ENRICHI
                       (contenu par champ + confiance + spans sources +
                        suggestions + paragraphes du document pour l'overlay AR)
  - /api/validate      enregistre un événement de validation humaine (journal local)
  - /api/metrics       calcule acceptation/champ, Brier, ECE, fiabilité, débit
  - /api/replay        rejoue un DEX sous les règles courantes et compare au
                       dernier instantané (montre l'amélioration après modif)
  - /api/config        lit / met à jour les paramètres AJUSTABLES côté front
                       (cible ECE, seuils d'alerte, k, fenêtre) — hors harness
  - /api/rules         lit la version + l'overlay de règles courant (regles.json)

Principes (cahier des charges)
------------------------------
  * Zéro dépendance externe : bibliothèque standard Python 3.10+ uniquement.
  * Le MOTEUR n'est PAS modifié : il reste déterministe et validable par le
    harness. La confiance et les spans sont dérivés ICI (couche serveur),
    en rejouant la même logique de repérage que le moteur (règle 1).
  * Confidentialité : écoute sur 127.0.0.1 par défaut ; aucune donnée DEX ne
    QUITTE le poste ; les copies temporaires (upload base64) sont supprimées
    après traitement. Le journal et les instantanés restent LOCAUX (ils
    peuvent contenir du contenu DEX, par conception, sur le poste seulement).
  * Le contenu n'est jamais reformulé (règle 7). La boucle n'agit que sur le
    REPÉRAGE / la CLASSIFICATION / la CALIBRATION, jamais sur le contenu métier.

Le seul "effet de bord" sur le moteur est l'application ADDITIVE de l'overlay
de mots-clés (regles.json) sur `dex.CASTIN_FIELDS["keywords"]` au démarrage —
c'est le levier n°1 de la boucle (enrichissement de lexique, règle 1). Cet
overlay est rejouable et versionné ; tout patch doit re-passer le harness.

USAGE
-----
    python dex_castin_server.py
    python dex_castin_server.py --host 127.0.0.1 --port 8765 --data-dir ./donnees
    python dex_castin_server.py --front ./front/dist     # sert aussi le front bâti
"""

from __future__ import annotations

import argparse
import base64
import hashlib
import json
import mimetypes
import os
import re
import statistics
import tempfile
import threading
import uuid
from datetime import datetime, timezone
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from typing import Any, Optional
from urllib.parse import urlparse, parse_qs

# Le moteur de reprise doit être dans le même dossier.
import sys
sys.path.insert(0, str(Path(__file__).resolve().parent))
import dex_castin_common as dex  # noqa: E402
import dex_castin_calibration as calib  # noqa: E402


# --------------------------------------------------------------------------- #
# Constantes et chemins                                                        #
# --------------------------------------------------------------------------- #

MAX_DOCX_BYTES = 50 * 1024 * 1024  # 50 Mo (cahier des charges)
SCHEMA_VERSION = "1.0"

# Capture des mots-clés "de base" du moteur AVANT tout overlay, pour pouvoir
# réappliquer regles.json de façon idempotente (base + extra).
_BASE_KEYWORDS: dict[str, list[str]] = {f["key"]: list(f["keywords"]) for f in dex.CASTIN_FIELDS}
_FIELD_ORDER: list[str] = [f["key"] for f in dex.CASTIN_FIELDS]
_FIELD_BY_KEY: dict[str, dict] = {f["key"]: f for f in dex.CASTIN_FIELDS}


class ClientInputError(ValueError):
    """Entrée fournie par le client invalide (mauvais chemin, format, taille).
    Mappée en HTTP 400, par opposition aux erreurs internes (500)."""


def _now_iso() -> str:
    return datetime.now(timezone.utc).astimezone().isoformat(timespec="seconds")


# --------------------------------------------------------------------------- #
# Config front-ajustable (hors harness) et règles versionnées (overlay)        #
# --------------------------------------------------------------------------- #

DEFAULT_CONFIG: dict[str, Any] = {
    "cible_ece": 0.10,                 # ajustable depuis le front (alarme calibration)
    "alerte_taux_acceptation_min": 0.85,
    "alerte_duree_dex_max_s": 720,
    "k_promotion_fixture": 5,
    "fenetre_glissante_n": 200,
    "pastille_confiance_couleur_champ": True,   # on : la pastille de confiance prend la couleur du champ (sinon vert/orange/rouge)
    "ordre_cartes": {},                # { "<champ_key>": ordre } — ordre d'affichage des cartes (vide = ordre naturel)
    "intitules_cartes": {},            # { "<champ_key>": {"label": "...", "tab": "..."} } — surcharges d'intitulé/catégorie
    "titres_proposes": {},             # { "<champ_key>": {"<titre_origine>": "<titre_surcharge>"} } — surcharges de titre proposé
    "ordre_cartes": {},                # ordre d'affichage des cartes : { "<champ_key>": <rang_int> } ; vide = ordre canonique
    "email": {                         # valeurs par défaut du signalement par e-mail (onglet Administration)
        "adresses": "fredgarcia@mail.fr",   # une ou plusieurs adresses séparées par ';'
        "objet_prefixe": "Castin ; ",       # objet = ce préfixe + le type de signalement
        "contenu_prefixe": "",              # intro ; corps = préfixe + contenu de la carte + suffixe
        "suffixe": "Cordialement,",         # salutation en fin de corps
    },
}

DEFAULT_RULES: dict[str, Any] = {
    "version": "1.0.0",
    "description": "Overlay de règles versionné. 'extra_keywords' enrichit "
                   "ADDITIVEMENT le lexique de repérage par champ (règle 1). "
                   "Tout changement doit re-passer le harness avant publication.",
    "extra_keywords": {},              # { "<champ_key>": ["mot cle normalise", ...] }
    "confiance": {                     # poids advisory (n'altèrent PAS le contenu)
        "base_text": 0.90,
        "base_link": 0.80,
        "base_compose": 0.75,
        "malus_match_faible": 0.10,
        "malus_contenu_court": 0.15,
        "seuil_contenu_court": 15,
        "optionnel_absent": 0.85,
        "requis_absent": 0.30,
        "plafond_si_signale": 0.40,
        "malus_ambiguite": 0.20,       # malus quand plusieurs sections candidates (ambiguïté de repérage)
    },
    # --- Calibration + routage (VERSIONNÉS, gatés). Défaut NEUTRE = identique
    #     au moteur : calibration inactive et seuil de routage nul. ---
    "seuil_routage": 0.0,              # > 0 : un champ TROUVÉ mais de confiance
                                       # calibrée < seuil est routé en "Points à
                                       # vérifier" (change la liste -> versionné).
    "marge_ambiguite": 0.15,           # VERSIONNÉ : si |score_top1 - score_top2| < marge => ambigu (near-tie)
    "max_candidats": 5,                # nb max de sections candidates exposées par champ
    "calibration": {                   # carte isotonique (PAV) score_brut -> proba
        "actif": False,
        "min_n_par_champ": 30,         # volume minimal pour une carte par champ
        "par_defaut": [],              # [[x,y], ...] croissants ; [] = identité
        "par_champ": {},               # { "<champ_key>": [[x,y], ...] }
    },
}


def _load_json(path: Path, default: dict) -> dict:
    try:
        if path.exists():
            data = json.loads(path.read_text(encoding="utf-8"))
            merged = {**default, **data}
            # fusion fine pour le sous-dictionnaire 'confiance'
            if "confiance" in default and isinstance(data.get("confiance"), dict):
                merged["confiance"] = {**default["confiance"], **data["confiance"]}
            # fusion fine pour le sous-dictionnaire 'email' (config)
            if "email" in default and isinstance(data.get("email"), dict):
                merged["email"] = {**default["email"], **data["email"]}
            return merged
    except (OSError, json.JSONDecodeError) as exc:
        print(f"[AVERTISSEMENT] Lecture {path.name} impossible ({exc}); valeurs par défaut.")
    return dict(default)


def apply_rules_overlay(rules: dict) -> None:
    """Réapplique (idempotent) l'overlay de mots-clés sur le moteur :
    keywords = base + extra_keywords[champ]. Levier n°1 de la boucle."""
    extra = rules.get("extra_keywords", {}) or {}
    for f in dex.CASTIN_FIELDS:
        base = list(_BASE_KEYWORDS.get(f["key"], []))
        for kw in extra.get(f["key"], []) or []:
            norm = dex._normalize_heading(kw) if hasattr(dex, "_normalize_heading") else str(kw).lower().strip()
            if norm and norm not in base:
                base.append(norm)
        f["keywords"] = base


def _interp_monotone(pts: list, x: float) -> float:
    """Interpolation linéaire bornée sur une carte de points [x,y] croissants."""
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


def is_monotone_map(pts: list) -> bool:
    """Vrai si la carte est valide : x et y croissants, valeurs dans [0,1]."""
    if not pts:
        return True
    try:
        xs = [float(p[0]) for p in pts]
        ys = [float(p[1]) for p in pts]
    except (TypeError, ValueError, IndexError):
        return False
    if any(not (0.0 <= v <= 1.0) for v in xs + ys):
        return False
    return all(xs[i] <= xs[i + 1] for i in range(len(xs) - 1)) and \
           all(ys[i] <= ys[i + 1] for i in range(len(ys) - 1))


def apply_calibration(score: Optional[float], champ: str, rules: dict) -> Optional[float]:
    """Applique la carte isotonique (par champ sinon par défaut) si la
    calibration est active. Sinon, renvoie le score brut inchangé.
    INVARIANT : fonction pure de (score, champ, version_règles)."""
    if score is None:
        return None
    cal = rules.get("calibration", {}) or {}
    if not cal.get("actif"):
        return float(score)
    pts = (cal.get("par_champ", {}) or {}).get(champ) or cal.get("par_defaut") or []
    if not pts:
        return float(score)
    return round(_interp_monotone(pts, float(score)), 4)


def valider_regles(rules: dict) -> list[str]:
    """Contrôle de sûreté des règles versionnées (gate de chargement). Refuse
    une calibration non monotone (sécurité : désactive + signale)."""
    avert: list[str] = []
    cal = rules.get("calibration", {}) or {}
    if cal.get("actif"):
        maps = [("par_defaut", cal.get("par_defaut") or [])]
        maps += [(f"par_champ[{k}]", v) for k, v in (cal.get("par_champ", {}) or {}).items()]
        for nom, pts in maps:
            if not is_monotone_map(pts):
                avert.append(f"Calibration {nom} non monotone ou hors [0,1] -> calibration DÉSACTIVÉE.")
                cal["actif"] = False
    try:
        s = float(rules.get("seuil_routage", 0.0) or 0.0)
        if not (0.0 <= s <= 1.0):
            avert.append("seuil_routage hors [0,1] -> ramené à 0.")
            rules["seuil_routage"] = 0.0
    except (TypeError, ValueError):
        rules["seuil_routage"] = 0.0
    try:
        m = float(rules.get("marge_ambiguite", 0.15) or 0.15)
        if not (0.0 <= m <= 1.0):
            avert.append("marge_ambiguite hors [0,1] -> ramenée à 0.15.")
            rules["marge_ambiguite"] = 0.15
    except (TypeError, ValueError):
        rules["marge_ambiguite"] = 0.15
    try:
        if int(rules.get("max_candidats", 5)) < 1:
            avert.append("max_candidats < 1 -> ramené à 5.")
            rules["max_candidats"] = 5
    except (TypeError, ValueError):
        rules["max_candidats"] = 5
    return avert


# --------------------------------------------------------------------------- #
# Boucle 2e ordre — dérivations (confiance, spans, suggestions, signature)      #
# --------------------------------------------------------------------------- #

def gabarit_signature(items: list) -> str:
    """Empreinte courte de la STRUCTURE du DEX (suite des titres normalisés +
    niveaux). Sert à regrouper des familles de gabarits SANS exposer de
    contenu (les titres normalisés sont peu sensibles ; aucun contenu)."""
    parts = []
    for it in items:
        if isinstance(it, dex.Paragraph) and it.is_heading:
            parts.append(f"{it.heading_level}:{dex._normalize_heading(it.text)}")
    digest = hashlib.sha1("\n".join(parts).encode("utf-8")).hexdigest()
    return digest[:8]


def _field_spans(items: list, fdef: dict) -> tuple[list[list[int]], Optional[str], bool]:
    """Rejoue le repérage du moteur pour CE champ et renvoie :
      - la liste des spans [debut, fin[ (index de paragraphes) à surligner,
      - le titre repéré (pour l'affichage),
      - match_fort : True si un mot-clé multi-mots a matché (repérage robuste),
        False si seul un mot-clé d'un seul mot a matché par préfixe (plus faible).
    Miroir fidèle de find_section / link / merge / appendix du moteur."""
    kind = fdef["kind"]
    if kind == "empty":
        return [], None, True

    keywords = fdef.get("keywords", [])
    spans: list[list[int]] = []
    matched_heading: Optional[str] = None
    matched_multiword = False  # un mot-clé multi-mots a matché le titre (repérage robuste)

    def _match_strength(heading_text: str) -> None:
        nonlocal matched_heading, matched_multiword
        if matched_heading is None:
            matched_heading = heading_text
        norm = dex._normalize_heading(heading_text)
        for kw in keywords:
            if len(kw.split()) > 1 and kw in norm:
                matched_multiword = True
                return

    if kind in ("text",):
        sec = dex.find_section(items, keywords)
        if sec is not None:
            hi, start, end = sec
            spans.append([start, end])
            _match_strength(items[hi].text)

    elif kind == "link":
        cursor = 0
        while True:
            sec = dex.find_section(items, keywords, start_after=cursor)
            if sec is None:
                break
            hi, start, end = sec
            spans.append([start, end])
            _match_strength(items[hi].text)
            cursor = end

    elif kind == "merge":
        sec = dex.find_section(items, keywords)
        if sec is not None:
            hi, start, end = sec
            spans.append([start, end])
            _match_strength(items[hi].text)
            sec2 = dex.find_section(items, keywords, start_after=end)
            if sec2 is not None:
                hi2, start2, end2 = sec2
                spans.append([start2, end2])

    elif kind == "appendix":
        resync = dex.find_section(items, ["resynchronisation"])
        if resync is not None:
            _, _, end = resync
            if end < len(items):
                spans.append([end, len(items)])
        mf = dex.find_section(items, keywords)
        if mf is not None:
            hi, start, end = mf
            spans.append([start, end])
            matched_heading = matched_heading or items[hi].text

    found = bool(spans)
    has_multiword_kw = any(len(k.split()) > 1 for k in keywords)
    # Repérage "fort" si un mot-clé multi-mots a matché, OU si le champ n'a que
    # des mots-clés simples (un match par préfixe est alors le meilleur signal
    # possible : on ne pénalise pas). "Faible" = des mots-clés multi-mots
    # existent mais seul un mot-clé simple a matché.
    match_fort = matched_multiword or (found and not has_multiword_kw)
    return spans, matched_heading, match_fort


def _candidate_suggestions(items: list, fdef: dict, topn: int = 3) -> list[dict]:
    """Propose les titres du document les plus proches des mots-clés/libellé du
    champ (difflib, stdlib). Sert aux 'suggestions de correction par
    l'application' quand le repérage a échoué ou paraît faible."""
    import difflib
    cible = dex._normalize_heading(" ".join(fdef.get("keywords", []) or [fdef["label"]]))
    cands: list[dict] = []
    for i, it in enumerate(items):
        if isinstance(it, dex.Paragraph) and it.is_heading:
            norm = dex._normalize_heading(it.text)
            if not norm:
                continue
            score = difflib.SequenceMatcher(None, cible, norm).ratio()
            cands.append({"index": i, "titre": it.text.strip(), "score": round(score, 3)})
    cands.sort(key=lambda c: c["score"], reverse=True)
    return cands[:topn]


def _heading_end(items: list, i: int) -> int:
    """Index de fin (exclu) de la section dont le titre est à l'index i — même
    règle que find_section : prochain titre de niveau <= (ou fin du document)."""
    level = items[i].heading_level
    for j in range(i + 1, len(items)):
        nxt = items[j]
        if isinstance(nxt, dex.Paragraph) and nxt.is_heading and nxt.heading_level <= level:
            return j
    return len(items)


def _candidate_score(keywords: list[str], normalized_title: str) -> tuple[float, bool]:
    """Score [0,1] de proximité titre <-> mots-clés (difflib, déterministe), avec
    bonus pour l'inclusion d'une phrase multi-mots. NB : c'est un score de
    CLASSEMENT pour aider l'opérateur, il ne FILTRE jamais (R1)."""
    import difflib
    best = 0.0
    phrase = False
    for kw in keywords:
        r = difflib.SequenceMatcher(None, kw, normalized_title).ratio()
        if len(kw.split()) > 1 and kw in normalized_title:
            phrase = True
            r = max(r, 0.95)
        best = max(best, r)
    return round(best, 4), phrase


def _field_candidates(items: list, fdef: dict, rules: dict) -> tuple[list[dict], Optional[int], bool]:
    """Énumère, dans l'ordre du document, les titres candidats qui matchent les
    mots-clés du champ (mêmes règles que le moteur via _heading_matches), les
    score, et calcule la sélection moteur (1er match) + le drapeau d'ambiguïté.

    Fidélité moteur : le contenu d'un candidat est extrait par section_text /
    section_links — donc identique à ce que le moteur produirait si cette
    section était la première. Le DÉFAUT appliqué reste la sélection moteur.
    Ambiguïté (champs 'text' uniquement) si : top-1 et top-2 plus proches que
    marge_ambiguite, OU le mieux scoré n'est pas le 1er match moteur (risque de
    mauvaise_section). 'merge'/'link' matchent par nature plusieurs sections
    (agrégation voulue) : candidats exposés en info, jamais 'ambigu'."""
    kind = fdef["kind"]
    if kind == "empty":
        return [], None, False
    keywords = fdef.get("keywords", []) or []
    max_n = int(rules.get("max_candidats", 5) or 5)
    cands: list[dict] = []
    index_moteur: Optional[int] = None
    for i, it in enumerate(items):
        if isinstance(it, dex.Paragraph) and it.is_heading:
            norm = dex._normalize_heading(it.text)
            if dex._heading_matches(norm, keywords):
                if index_moteur is None:
                    index_moteur = i
                end = _heading_end(items, i)
                score, phrase = _candidate_score(keywords, norm)
                if kind == "link":
                    contenu = "\n".join(dex.section_links(items, i + 1, end, fdef.get("link_pattern")))
                else:
                    contenu = dex.section_text(items, i + 1, end)
                extrait = contenu[:280] + ("…" if len(contenu) > 280 else "")
                cands.append({"index": i, "titre": it.text.strip(), "niveau": it.heading_level,
                              "score": score, "phrase": phrase, "span": [i + 1, end],
                              "extrait": extrait, "contenu": contenu})
    cands.sort(key=lambda c: (-c["score"], c["index"]))
    cands = cands[:max_n]

    ambigu = False
    if kind == "text" and len(cands) >= 2:
        marge = float(rules.get("marge_ambiguite", 0.15) or 0.15)
        proche = (cands[0]["score"] - cands[1]["score"]) < marge
        desaccord = cands[0]["index"] != index_moteur
        ambigu = bool(proche or desaccord)

    # Le contenu complet n'est utile (bascule front) que pour le choix sur champ
    # 'text' multi-candidats ; ailleurs on n'expose que l'extrait (payload borné).
    garder_contenu = (kind == "text" and len(cands) >= 2)
    for c in cands:
        if not garder_contenu:
            c.pop("contenu", None)
    return cands, index_moteur, ambigu


def _confidence(fdef: dict, content: str, found: bool, match_fort: bool,
                in_points: bool, ambigu: bool, w: dict) -> tuple[Optional[float], str]:
    """Confiance advisory [0,1] + raison courte. N'altère AUCUN contenu :
    sert l'affichage, le routage d'attention et la calibration (Brier/ECE)."""
    kind = fdef["kind"]
    if kind == "empty":
        return None, "Champ toujours vide (règle 5)."

    optional = fdef.get("optional", False)
    none_value = fdef.get("none_value", "")

    if not found or not content or content == none_value:
        if optional:
            return round(w["optionnel_absent"], 2), "Section absente — champ optionnel laissé vide (attendu)."
        return round(w["requis_absent"], 2), "Section source introuvable — mis à « Non concerné », à vérifier."

    if kind == "link":
        base = w["base_link"]
    elif kind in ("merge", "appendix"):
        base = w["base_compose"]
    else:
        base = w["base_text"]

    raisons = ["section repérée"]
    if not match_fort:
        base -= w["malus_match_faible"]
        raisons.append("repérage par mot-clé simple (à confirmer)")
    if len(content) < w["seuil_contenu_court"]:
        base -= w["malus_contenu_court"]
        raisons.append("contenu très court")
    if ambigu:
        base -= w.get("malus_ambiguite", 0.20)
        raisons.append("plusieurs sections candidates (choix à confirmer)")
    if in_points:
        base = min(base, w["plafond_si_signale"])
        raisons.append("signalé")

    return round(max(0.05, min(0.98, base)), 2), ", ".join(raisons) + "."


def enrich(result: dict, items: list, rules: dict) -> dict:
    """Construit le résultat ENRICHI consommé par le front."""
    w = rules.get("confiance", DEFAULT_RULES["confiance"])
    seuil_routage = float(rules.get("seuil_routage", 0.0) or 0.0)
    champs_out: dict[str, dict] = {}
    points_routage: list[str] = []
    points_ambig: list[str] = []

    for key in _FIELD_ORDER:
        fdef = _FIELD_BY_KEY[key]
        base = result["champs"][key]
        content = base["content"]
        spans, matched_heading, match_fort = _field_spans(items, fdef)
        found = bool(spans)
        # Candidats multi-sections (désambiguïsation) — fidèles au moteur.
        candidats, selection_moteur, ambigu = _field_candidates(items, fdef, rules)
        # in_points : même condition que le moteur (requis & introuvable)
        in_points = (not found) and (not fdef.get("optional", False)) and fdef["kind"] != "empty"
        # score_brut = heuristique (prior) ; confiance = score calibré (isotonique)
        score_brut, raison = _confidence(fdef, content, found, match_fort, in_points, ambigu, w)
        conf = apply_calibration(score_brut, key, rules)

        # Routage par seuil VERSIONNÉ : un champ TROUVÉ mais de confiance calibrée
        # < seuil est explicitement porté à l'attention (change la liste des
        # points -> versionné/déterministe). Les champs introuvables requis sont
        # déjà couverts par le moteur ; on ne les double pas.
        route_attention = (conf is not None and found and fdef["kind"] != "empty"
                           and seuil_routage > 0.0 and conf < seuil_routage)
        if route_attention:
            points_routage.append(
                f"Champ « {base['label']} » : confiance calibrée {conf} < seuil {seuil_routage} "
                f"-> à vérifier (contenu présent)."
            )
        # Ambiguïté de repérage : plusieurs sections candidates -> choix à confirmer.
        if ambigu:
            titres = ", ".join(f"« {c['titre']} »" for c in candidats[:3])
            points_ambig.append(
                f"Champ « {base['label']} » : {len(candidats)} sections candidates ({titres}) "
                f"-> choisir la bonne section."
            )

        suggestions: list[dict] = []
        if fdef["kind"] not in ("empty",) and (not found or (conf is not None and conf < 0.6)):
            suggestions = _candidate_suggestions(items, fdef)
            # Rendre les suggestions APPLICABLES : span de la section + contenu
            # (champs 'text' uniquement) extrait fidèlement par section_text.
            for s in suggestions:
                end = _heading_end(items, s["index"])
                s["span"] = [s["index"] + 1, end]
                if fdef["kind"] == "text":
                    txt = dex.section_text(items, s["index"] + 1, end)
                    s["contenu"] = txt
                    s["extrait"] = txt[:200] + ("…" if len(txt) > 200 else "")

        champs_out[key] = {
            "label": base["label"],
            "tab": base["tab"],
            "kind": fdef["kind"],
            "content": content,
            "score_brut": score_brut,
            "confiance": conf,
            "route_attention": route_attention,
            "ambigu": ambigu,
            "candidats": candidats,
            "selection_moteur": selection_moteur,
            "raison": raison,
            "titre_repere": matched_heading,
            "source_spans": spans,
            "suggestions": suggestions,
        }

    document = [
        {
            "index": i,
            "type": "table" if isinstance(it, dex.Table) else "paragraph",
            "text": (it.to_text() if isinstance(it, dex.Table) else it.text.strip()),
            "is_heading": (isinstance(it, dex.Paragraph) and it.is_heading),
            "level": (it.heading_level if isinstance(it, dex.Paragraph) else None),
            "is_explanatory": (isinstance(it, dex.Paragraph) and it.is_explanatory()),
        }
        for i, it in enumerate(items)
    ]

    return {
        "schema": SCHEMA_VERSION,
        "rules_version": rules.get("version", "?"),
        "calibration_active": bool((rules.get("calibration") or {}).get("actif")),
        "seuil_routage": seuil_routage,
        "gabarit_signature": gabarit_signature(items),
        "identification": result["identification"],
        "points_a_verifier": list(result["points_a_verifier"]) + points_routage + points_ambig,
        "ordre_champs": list(_FIELD_ORDER),
        "champs": champs_out,
        "document": document,
        "markdown": dex.format_markdown(result),
    }


def process_path(path: str, filename: Optional[str], rules: dict) -> dict:
    result = dex.process_dex(path, filename=filename or Path(path).name)
    items = dex.read_docx(path)
    return enrich(result, items, rules)


# --------------------------------------------------------------------------- #
# Journal de validation + métriques (Brier / ECE / acceptation / débit)        #
# --------------------------------------------------------------------------- #

class Store:
    """Stockage LOCAL : journal d'événements (JSONL) + instantanés de runs."""

    def __init__(self, data_dir: Path):
        self.dir = data_dir
        self.events_path = data_dir / "events.jsonl"
        self.analyses_path = data_dir / "analyses.jsonl"
        self.runs_dir = data_dir / "runs"
        self.dir.mkdir(parents=True, exist_ok=True)
        self.runs_dir.mkdir(parents=True, exist_ok=True)
        self._lock = threading.Lock()

    def append_event(self, ev: dict) -> dict:
        ev.setdefault("id", uuid.uuid4().hex)
        ev.setdefault("horodatage", _now_iso())
        with self._lock:
            with self.events_path.open("a", encoding="utf-8") as fh:
                fh.write(json.dumps(ev, ensure_ascii=False) + "\n")
        return ev

    def read_events(self) -> list[dict]:
        if not self.events_path.exists():
            return []
        out = []
        for line in self.events_path.read_text(encoding="utf-8").splitlines():
            line = line.strip()
            if line:
                try:
                    out.append(json.loads(line))
                except json.JSONDecodeError:
                    continue
        return out

    def append_analysis(self, rec: dict) -> dict:
        """Journalise une analyse de DEX (1 ligne par passage de process-dex).
        Léger et local : alimente l'onglet Historique. Ne sort jamais du poste."""
        rec.setdefault("id", uuid.uuid4().hex)
        rec.setdefault("horodatage", _now_iso())
        with self._lock:
            with self.analyses_path.open("a", encoding="utf-8") as fh:
                fh.write(json.dumps(rec, ensure_ascii=False) + "\n")
        return rec

    def read_analyses(self) -> list[dict]:
        if not self.analyses_path.exists():
            return []
        out = []
        for line in self.analyses_path.read_text(encoding="utf-8").splitlines():
            line = line.strip()
            if line:
                try:
                    out.append(json.loads(line))
                except json.JSONDecodeError:
                    continue
        return out

    def save_snapshot(self, dex_id: str, rules_version: str, enriched: dict) -> None:
        safe = re.sub(r"[^A-Za-z0-9_.-]", "_", dex_id or "inconnu")
        d = self.runs_dir / safe
        d.mkdir(parents=True, exist_ok=True)
        payload = {"horodatage": _now_iso(), "rules_version": rules_version, "resultat": enriched}
        (d / f"{int(datetime.now().timestamp()*1000)}__{rules_version}.json").write_text(
            json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")

    def latest_snapshot(self, dex_id: str) -> Optional[dict]:
        safe = re.sub(r"[^A-Za-z0-9_.-]", "_", dex_id or "inconnu")
        d = self.runs_dir / safe
        if not d.exists():
            return None
        files = sorted(d.glob("*.json"))
        if not files:
            return None
        try:
            return json.loads(files[-1].read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            return None


def _brier_ece(events: list[dict], key: str, M: int = 10) -> tuple[Optional[float], Optional[float]]:
    """Brier et ECE calculés sur la clé `key` (ex: 'confiance' calibrée, ou
    'score_brut'). Permet de chiffrer l'apport de la calibration."""
    pts = [(float(e[key]), 1.0 if e["verdict"] == "accepte" else 0.0) for e in events
           if isinstance(e.get(key), (int, float)) and e.get("verdict") in ("accepte", "signale")]
    n = len(pts)
    if not n:
        return None, None
    brier = round(sum((p - o) ** 2 for p, o in pts) / n, 4)
    buckets: list[list] = [[] for _ in range(M)]
    for p, o in pts:
        buckets[min(M - 1, int(min(0.999999, max(0.0, p)) * M))].append((p, o))
    ece = 0.0
    for b in buckets:
        if not b:
            continue
        conf_avg = sum(p for p, _ in b) / len(b)
        acc = sum(o for _, o in b) / len(b)
        ece += (len(b) / n) * abs(acc - conf_avg)
    return brier, round(ece, 4)


def _resume_analyse(enriched: dict, filename: Optional[str] = None) -> dict:
    """Enregistrement COMPACT d'une analyse de DEX (1 par passage de process-dex)
    pour l'historique : distribution des confiances par bande + points à vérifier."""
    buckets = {"elevee": 0, "moyenne": 0, "faible": 0, "vide": 0}
    n_ambigu = n_route = n_abouti = 0
    for c in (enriched.get("champs") or {}).values():
        conf = c.get("confiance")
        if conf is None:
            buckets["vide"] += 1
        elif conf >= 0.8:
            buckets["elevee"] += 1
        elif conf >= 0.5:
            buckets["moyenne"] += 1
        else:
            buckets["faible"] += 1
        if c.get("ambigu"):
            n_ambigu += 1
        if c.get("route_attention"):
            n_route += 1
        if c.get("source_spans"):           # repérage positif (section trouvée dans le document)
            n_abouti += 1
    dex_id = (enriched.get("identification") or {}).get("solution") or "inconnu"
    return {
        "dex_id": dex_id,
        "nom": filename or "",              # nom de fichier complet
        "gabarit_signature": enriched.get("gabarit_signature"),
        "rules_version": enriched.get("rules_version"),
        "n_champs": len(enriched.get("champs") or {}),
        "n_abouti": n_abouti,
        "conf": buckets,
        "n_ambigu": n_ambigu,
        "n_route_attention": n_route,
        "n_points": len(enriched.get("points_a_verifier") or []),
    }


def _historique(analyses: list[dict]) -> dict:
    """Payload de l'onglet Historique : analyses (plus récentes d'abord) +
    agrégat par heure de passage."""
    analyses = sorted(analyses, key=lambda a: a.get("horodatage", ""), reverse=True)
    par_heure: dict[str, dict] = {}
    for a in analyses:
        h = (a.get("horodatage") or "")[:13]  # YYYY-MM-DDTHH
        slot = par_heure.setdefault(h, {"heure": h, "n_dex": 0, "n_points": 0, "n_ambigu": 0,
                                        "conf": {"elevee": 0, "moyenne": 0, "faible": 0, "vide": 0}})
        slot["n_dex"] += 1
        slot["n_points"] += int(a.get("n_points", 0) or 0)
        slot["n_ambigu"] += int(a.get("n_ambigu", 0) or 0)
        for k in ("elevee", "moyenne", "faible", "vide"):
            slot["conf"][k] += int((a.get("conf") or {}).get(k, 0) or 0)
    return {"total": len(analyses), "analyses": analyses,
            "par_heure": sorted(par_heure.values(), key=lambda s: s["heure"], reverse=True)}


def compute_metrics(events: list[dict], config: dict) -> dict:
    """Acceptation par champ, Brier (global + par champ), ECE + diagramme de
    fiabilité, débit médian. Exclut les champs sans confiance (ex: vide)."""
    cal = [e for e in events if isinstance(e.get("confiance"), (int, float)) and e.get("verdict") in ("accepte", "signale")]
    n = len(cal)

    def brier(evs: list[dict]) -> Optional[float]:
        if not evs:
            return None
        s = 0.0
        for e in evs:
            o = 1.0 if e["verdict"] == "accepte" else 0.0
            p = float(e["confiance"])
            s += (p - o) ** 2
        return round(s / len(evs), 4)

    # par champ
    par_champ: dict[str, dict] = {}
    by_field: dict[str, list[dict]] = {}
    for e in events:
        if e.get("verdict") in ("accepte", "signale"):
            by_field.setdefault(e.get("champ", "?"), []).append(e)
    for champ, evs in by_field.items():
        n_acc = sum(1 for e in evs if e["verdict"] == "accepte")
        cal_f = [e for e in evs if isinstance(e.get("confiance"), (int, float))]
        par_champ[champ] = {
            "n": len(evs),
            "acceptation": round(n_acc / len(evs), 4) if evs else None,
            "brier": brier(cal_f),
        }

    # ECE + fiabilité (10 buckets)
    M = 10
    buckets = [[] for _ in range(M)]
    for e in cal:
        p = min(0.999999, max(0.0, float(e["confiance"])))
        buckets[min(M - 1, int(p * M))].append(e)
    reliability = []
    ece = 0.0
    for b_idx, b in enumerate(buckets):
        lo, hi = b_idx / M, (b_idx + 1) / M
        if not b:
            reliability.append({"bin": [round(lo, 2), round(hi, 2)], "n": 0, "confiance": None, "acceptation": None})
            continue
        conf_avg = sum(float(e["confiance"]) for e in b) / len(b)
        acc = sum(1 for e in b if e["verdict"] == "accepte") / len(b)
        ece += (len(b) / n) * abs(acc - conf_avg)
        reliability.append({"bin": [round(lo, 2), round(hi, 2)], "n": len(b),
                            "confiance": round(conf_avg, 3), "acceptation": round(acc, 3)})

    durees = [float(e["duree_traitement_s"]) for e in events
              if isinstance(e.get("duree_traitement_s"), (int, float))]
    debit = {"n": len(durees),
             "median_s": round(statistics.median(durees), 1) if durees else None}

    cible_ece = config.get("cible_ece", DEFAULT_CONFIG["cible_ece"])
    alertes = []
    if n and round(ece, 4) > cible_ece:
        alertes.append(f"ECE global {round(ece,4)} > cible {cible_ece}.")
    seuil_acc = config.get("alerte_taux_acceptation_min", DEFAULT_CONFIG["alerte_taux_acceptation_min"])
    for champ, m in par_champ.items():
        if m["acceptation"] is not None and m["n"] >= 5 and m["acceptation"] < seuil_acc:
            alertes.append(f"Champ « {champ} » : acceptation {m['acceptation']} < {seuil_acc} (n={m['n']}).")
    seuil_duree = config.get("alerte_duree_dex_max_s", DEFAULT_CONFIG["alerte_duree_dex_max_s"])
    if debit["median_s"] is not None and debit["median_s"] > seuil_duree:
        alertes.append(f"Débit médian {debit['median_s']} s > seuil {seuil_duree} s.")

    brier_brut, ece_brut = _brier_ece(events, "score_brut")
    ece_cal = round(ece, 4) if n else None
    amelioration_ece = (round(ece_brut - ece_cal, 4) if (ece_brut is not None and ece_cal is not None) else None)

    return {
        "schema": SCHEMA_VERSION,
        "n_evenements": len(events),
        "n_calibrables": n,
        "brier_global": brier(cal),
        "ece": ece_cal,
        "brier_brut": brier_brut,
        "ece_brut": ece_brut,
        "amelioration_ece": amelioration_ece,
        "cible_ece": cible_ece,
        "fiabilite": reliability,
        "par_champ": par_champ,
        "debit": debit,
        "alertes": alertes,
    }


def replay(store: Store, path: str, dex_id: str, rules: dict) -> dict:
    """Rejoue un DEX sous les règles courantes et compare au dernier
    instantané : montre les champs modifiés et les points résolus/apparus."""
    avant_snap = store.latest_snapshot(dex_id)
    apres = process_path(path, dex_id, rules)
    store.save_snapshot(dex_id, rules.get("version", "?"), apres)

    diff = []
    pts_avant: list[str] = []
    av_version = None
    if avant_snap:
        av = avant_snap["resultat"]
        av_version = avant_snap.get("rules_version")
        pts_avant = av.get("points_a_verifier", [])
        for key in apres["ordre_champs"]:
            ca = av["champs"].get(key, {})
            cb = apres["champs"][key]
            if ca.get("content") != cb["content"] or ca.get("confiance") != cb["confiance"]:
                diff.append({
                    "champ": key, "label": cb["label"],
                    "avant": {"content": ca.get("content"), "confiance": ca.get("confiance")},
                    "apres": {"content": cb["content"], "confiance": cb["confiance"]},
                })

    pts_apres = apres.get("points_a_verifier", [])
    resolus = [p for p in pts_avant if p not in pts_apres]
    nouveaux = [p for p in pts_apres if p not in pts_avant]

    return {
        "schema": SCHEMA_VERSION,
        "dex_id": dex_id,
        "version_avant": av_version,
        "version_apres": rules.get("version", "?"),
        "a_un_instantane_precedent": avant_snap is not None,
        "champs_modifies": diff,
        "points_resolus": resolus,
        "points_nouveaux": nouveaux,
        "n_points_avant": len(pts_avant),
        "n_points_apres": len(pts_apres),
        "resultat": apres,
    }


def _analyse_calibration(events: list[dict], rules: dict, min_n_global: int = 30) -> dict:
    """Ajuste une carte de calibration isotonique CANDIDATE depuis les verdicts
    (score_brut -> acceptation), globalement et par champ (si assez de volume),
    chiffre l'apport (ECE brut -> estimé, in-sample) et construit un PATCH de
    regles.json prêt à geler (version incrémentée, calibration active). La carte
    n'est JAMAIS activée ici : elle doit passer le gate (calibration_check +
    harness) puis être copiée dans regles.json."""
    pairs = [(float(e["score_brut"]), 1.0 if e["verdict"] == "accepte" else 0.0)
             for e in events
             if isinstance(e.get("score_brut"), (int, float)) and e.get("verdict") in ("accepte", "signale")]
    n = len(pairs)
    res: dict = {"schema": SCHEMA_VERSION, "n": n, "min_n_global": min_n_global}
    if n < min_n_global:
        res.update({"suffisant": False,
                    "message": f"Volume insuffisant pour calibrer ({n} < {min_n_global}). "
                               f"Continuez la validation (période de rodage)."})
        return res

    xs = [p[0] for p in pairs]
    ys = [p[1] for p in pairs]
    par_defaut = calib.fit_isotonic_map(xs, ys)

    by_field: dict[str, list[dict]] = {}
    for e in events:
        if isinstance(e.get("score_brut"), (int, float)) and e.get("verdict") in ("accepte", "signale"):
            by_field.setdefault(e.get("champ", "?"), []).append(e)
    min_champ = int((rules.get("calibration", {}) or {}).get("min_n_par_champ", 30))
    par_champ: dict[str, list] = {}
    n_par_champ: dict[str, int] = {}
    for champ, evs in by_field.items():
        n_par_champ[champ] = len(evs)
        if len(evs) >= min_champ:
            cx = [float(e["score_brut"]) for e in evs]
            cy = [1.0 if e["verdict"] == "accepte" else 0.0 for e in evs]
            par_champ[champ] = calib.fit_isotonic_map(cx, cy)

    ece_brut, _ = calib.ece(xs, ys)

    def _cal(e: dict) -> float:
        m = par_champ.get(e.get("champ")) or par_defaut
        return _interp_monotone(m, float(e["score_brut"]))
    cal_scores = [_cal(e) for e in events
                  if isinstance(e.get("score_brut"), (int, float)) and e.get("verdict") in ("accepte", "signale")]
    ece_estime, _ = calib.ece(cal_scores, ys)

    version_proposee = calib.bump_version(rules.get("version", "0.0.0"))
    patch = json.loads(json.dumps(rules))  # copie profonde (règles sérialisables JSON)
    patch["version"] = version_proposee
    patch.setdefault("calibration", {})
    patch["calibration"]["actif"] = True
    patch["calibration"]["par_defaut"] = par_defaut
    patch["calibration"]["par_champ"] = par_champ
    patch["calibration"].setdefault("min_n_par_champ", min_champ)

    res.update({
        "suffisant": True,
        "n_par_champ": n_par_champ,
        "champs_calibres": sorted(par_champ.keys()),
        "ece_brut": ece_brut,
        "ece_estime": ece_estime,
        "gain": (round(ece_brut - ece_estime, 4) if (ece_brut is not None and ece_estime is not None) else None),
        "par_defaut": par_defaut,
        "par_champ": par_champ,
        "version_proposee": version_proposee,
        "patch_regles": patch,
    })
    return res


# --------------------------------------------------------------------------- #
# Serveur HTTP                                                                 #
# --------------------------------------------------------------------------- #

class App:
    def __init__(self, data_dir: Path, config_path: Path, rules_path: Path, front_dir: Optional[Path]):
        self.config_path = config_path
        self.rules_path = rules_path
        self.front_dir = front_dir
        self.store = Store(data_dir)
        self.config = _load_json(config_path, DEFAULT_CONFIG)
        self.rules = _load_json(rules_path, DEFAULT_RULES)
        for a in valider_regles(self.rules):
            print(f"[GATE RÈGLES] {a}")
        apply_rules_overlay(self.rules)
        # écrit les fichiers par défaut s'ils n'existent pas (transparence)
        if not config_path.exists():
            config_path.write_text(json.dumps(self.config, ensure_ascii=False, indent=2), encoding="utf-8")
        if not rules_path.exists():
            rules_path.write_text(json.dumps(self.rules, ensure_ascii=False, indent=2), encoding="utf-8")

    def reload_rules(self) -> list[str]:
        self.rules = _load_json(self.rules_path, DEFAULT_RULES)
        avert = valider_regles(self.rules)
        apply_rules_overlay(self.rules)
        return avert

    def save_config(self, patch: dict) -> dict:
        clean = {k: v for k, v in patch.items() if k in DEFAULT_CONFIG}
        # Le sous-dictionnaire 'email' alimente un mailto : on borne aux clés
        # connues et on force des chaînes (défauts pour les manquantes).
        if "email" in clean:
            base = dict(DEFAULT_CONFIG["email"])
            recu = clean["email"] if isinstance(clean["email"], dict) else {}
            for k in base:
                if recu.get(k) is not None:
                    base[k] = str(recu[k])
            clean["email"] = base
        if "pastille_confiance_couleur_champ" in clean:
            clean["pastille_confiance_couleur_champ"] = bool(clean["pastille_confiance_couleur_champ"])
        if "ordre_cartes" in clean:
            recu = clean["ordre_cartes"] if isinstance(clean["ordre_cartes"], dict) else {}
            ordre = {}
            for k, v in recu.items():
                try:
                    ordre[str(k)] = int(v)
                except (TypeError, ValueError):
                    continue
            clean["ordre_cartes"] = ordre
        if "intitules_cartes" in clean:
            recu = clean["intitules_cartes"] if isinstance(clean["intitules_cartes"], dict) else {}
            inti = {}
            for k, v in recu.items():
                if isinstance(v, dict):
                    o = {}
                    if v.get("label") is not None:
                        o["label"] = str(v["label"])
                    if v.get("tab") is not None:
                        o["tab"] = str(v["tab"])
                    if o:
                        inti[str(k)] = o
            clean["intitules_cartes"] = inti
        if "titres_proposes" in clean:
            recu = clean["titres_proposes"] if isinstance(clean["titres_proposes"], dict) else {}
            tp = {}
            for k, v in recu.items():
                if isinstance(v, dict):
                    m = {str(o): str(s) for o, s in v.items() if s is not None}
                    if m:
                        tp[str(k)] = m
            clean["titres_proposes"] = tp
        if "ordre_cartes" in clean:
            recu = clean["ordre_cartes"] if isinstance(clean["ordre_cartes"], dict) else {}
            norm = {}
            for k, v in recu.items():
                try:
                    norm[str(k)] = int(v)
                except (TypeError, ValueError):
                    continue
            clean["ordre_cartes"] = norm
        self.config = {**self.config, **clean}
        self.config_path.write_text(json.dumps(self.config, ensure_ascii=False, indent=2), encoding="utf-8")
        return self.config


def make_handler(app: App, allowed_origins: list[str]):
    class Handler(BaseHTTPRequestHandler):
        server_version = "DexCastinBack/1.0"

        # --- utilitaires de réponse ---------------------------------------- #
        def _cors(self):
            origin = self.headers.get("Origin", "")
            allow = origin if (origin in allowed_origins or "*" in allowed_origins) else (allowed_origins[0] if allowed_origins else "")
            if allow:
                self.send_header("Access-Control-Allow-Origin", allow)
                self.send_header("Vary", "Origin")
            self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
            self.send_header("Access-Control-Allow-Headers", "Content-Type")

        def _json(self, obj, status=200):
            body = json.dumps(obj, ensure_ascii=False).encode("utf-8")
            self.send_response(status)
            self.send_header("Content-Type", "application/json; charset=utf-8")
            self.send_header("Content-Length", str(len(body)))
            self._cors()
            self.end_headers()
            self.wfile.write(body)

        def _err(self, msg, status=400):
            self._json({"error": msg}, status=status)

        def _read_json_body(self) -> dict:
            length = int(self.headers.get("Content-Length", 0) or 0)
            if length <= 0:
                return {}
            raw = self.rfile.read(length)
            return json.loads(raw.decode("utf-8"))

        def log_message(self, *args):  # silencieux par défaut
            pass

        # --- préflight CORS -------------------------------------------------- #
        def do_OPTIONS(self):
            self.send_response(204)
            self._cors()
            self.end_headers()

        # --- GET ------------------------------------------------------------- #
        def do_GET(self):
            parsed = urlparse(self.path)
            route = parsed.path
            try:
                if route == "/api/health":
                    return self._json({
                        "status": "ok", "schema": SCHEMA_VERSION,
                        "rules_version": app.rules.get("version"),
                        "n_champs": len(_FIELD_ORDER),
                        "horodatage": _now_iso(),
                    })
                if route == "/api/metrics":
                    m = compute_metrics(app.store.read_events(), app.config)
                    cal = app.rules.get("calibration", {}) or {}
                    m["calibration"] = {"actif": bool(cal.get("actif")),
                                        "rules_version": app.rules.get("version"),
                                        "seuil_routage": float(app.rules.get("seuil_routage", 0.0) or 0.0)}
                    return self._json(m)
                if route == "/api/config":
                    return self._json(app.config)
                if route == "/api/rules":
                    return self._json({"version": app.rules.get("version"),
                                       "extra_keywords": app.rules.get("extra_keywords", {}),
                                       "confiance": app.rules.get("confiance", {}),
                                       "seuil_routage": app.rules.get("seuil_routage", 0.0),
                                       "calibration": app.rules.get("calibration", {})})
                if route == "/api/calibration":
                    return self._json(_analyse_calibration(app.store.read_events(), app.rules))
                if route == "/api/history":
                    return self._json(_historique(app.store.read_analyses()))
                return self._serve_static(route)
            except ClientInputError as exc:
                return self._err(str(exc), 400)
            except Exception as exc:  # noqa: BLE001
                return self._err(f"Erreur interne : {exc}", 500)

        def _serve_static(self, route: str):
            if app.front_dir is None:
                return self._err("Ressource introuvable.", 404)
            rel = route.lstrip("/") or "index.html"
            target = (app.front_dir / rel).resolve()
            if not str(target).startswith(str(app.front_dir.resolve())):
                return self._err("Chemin invalide.", 403)
            if target.is_dir():
                target = target / "index.html"
            if not target.exists():
                target = app.front_dir / "index.html"  # SPA fallback
                if not target.exists():
                    return self._err("Ressource introuvable.", 404)
            ctype = mimetypes.guess_type(str(target))[0] or "application/octet-stream"
            data = target.read_bytes()
            self.send_response(200)
            self.send_header("Content-Type", ctype)
            self.send_header("Content-Length", str(len(data)))
            self._cors()
            self.end_headers()
            self.wfile.write(data)

        # --- POST ------------------------------------------------------------ #
        def do_POST(self):
            parsed = urlparse(self.path)
            route = parsed.path
            try:
                if route == "/api/process-dex":
                    return self._process()
                if route == "/api/validate":
                    return self._validate()
                if route == "/api/replay":
                    return self._replay()
                if route == "/api/config":
                    body = self._read_json_body()
                    return self._json(app.save_config(body))
                if route == "/api/rules/reload":
                    avert = app.reload_rules()
                    cal = app.rules.get("calibration", {}) or {}
                    return self._json({"status": "ok", "rules_version": app.rules.get("version"),
                                       "calibration_active": bool(cal.get("actif")),
                                       "seuil_routage": float(app.rules.get("seuil_routage", 0.0) or 0.0),
                                       "avertissements": avert})
                if route == "/api/calibration/proposer":
                    ana = _analyse_calibration(app.store.read_events(), app.rules)
                    if not ana.get("suffisant"):
                        return self._err(ana.get("message", "Volume insuffisant pour calibrer."), 409)
                    cand = app.rules_path.parent / "regles.candidate.json"
                    cand.write_text(json.dumps(ana["patch_regles"], ensure_ascii=False, indent=2), encoding="utf-8")
                    return self._json({
                        "status": "ok", "chemin": str(cand),
                        "version_proposee": ana["version_proposee"],
                        "ece_brut": ana["ece_brut"], "ece_estime": ana["ece_estime"], "gain": ana["gain"],
                        "rappel": "Gate avant activation : python outils/calibration_check.py "
                                  "+ harness moteur, puis copier regles.candidate.json -> regles.json "
                                  "et POST /api/rules/reload.",
                    })
                return self._err("Route inconnue.", 404)
            except json.JSONDecodeError:
                return self._err("Corps JSON invalide.")
            except ClientInputError as exc:
                return self._err(str(exc), 400)
            except Exception as exc:  # noqa: BLE001
                return self._err(f"Erreur interne : {exc}", 500)

        def _resolve_docx(self, body: dict) -> tuple[str, Optional[str], Optional[str]]:
            """Renvoie (chemin_a_traiter, filename, chemin_temporaire_a_supprimer).
            Accepte soit {path} (fichier local, préféré, rien à supprimer), soit
            {filename, content_base64} (upload, copie temporaire supprimée ensuite)."""
            if body.get("path"):
                p = Path(body["path"])
                if not p.exists():
                    raise ClientInputError(f"Fichier introuvable : {p}")
                if p.suffix.lower() != ".docx":
                    raise ClientInputError("Le fichier doit être un .docx.")
                if p.stat().st_size > MAX_DOCX_BYTES:
                    raise ClientInputError("Fichier trop volumineux (> 50 Mo).")
                return str(p), p.name, None
            if body.get("content_base64"):
                raw = base64.b64decode(body["content_base64"])
                if len(raw) > MAX_DOCX_BYTES:
                    raise ClientInputError("Fichier trop volumineux (> 50 Mo).")
                fd, tmp = tempfile.mkstemp(suffix=".docx")
                with os.fdopen(fd, "wb") as fh:
                    fh.write(raw)
                return tmp, body.get("filename") or "upload.docx", tmp
            raise ClientInputError("Fournir 'path' (fichier local) ou 'content_base64'.")

        def _process(self):
            body = self._read_json_body()
            path, filename, tmp = self._resolve_docx(body)
            try:
                enriched = process_path(path, filename, app.rules)
            finally:
                if tmp:  # confidentialité : suppression de la copie temporaire
                    try:
                        os.remove(tmp)
                    except OSError:
                        pass
            dex_id = enriched["identification"].get("solution") or (filename or "inconnu")
            app.store.save_snapshot(dex_id, app.rules.get("version", "?"), enriched)
            try:  # historique (journal léger, local) — n'altère jamais la réponse
                app.store.append_analysis(_resume_analyse(enriched, filename))
            except Exception:  # noqa: BLE001
                pass
            return self._json(enriched)

        def _validate(self):
            """Enregistre un événement de validation humaine (annexe A.3.1).
            Champs attendus : dex_id, champ, confiance, verdict
            ('accepte'|'signale'), type_signalement?, correction?, onglet?,
            gabarit_signature?, duree_traitement_s?, operateur_role?
            ('rodage'|'production')."""
            body = self._read_json_body()
            verdict = body.get("verdict")
            if verdict not in ("accepte", "signale"):
                return self._err("'verdict' doit valoir 'accepte' ou 'signale'.")
            ev = {
                "schema": SCHEMA_VERSION,
                "dex_id": body.get("dex_id"),
                "version_regles": app.rules.get("version"),
                "onglet": body.get("onglet"),
                "champ": body.get("champ"),
                "gabarit_signature": body.get("gabarit_signature"),
                "score_brut": body.get("score_brut"),   # signal STABLE pour (re)calibrer
                "confiance": body.get("confiance"),      # valeur affichée/utilisée (calibrée)
                "verdict": verdict,
                "type_signalement": body.get("type_signalement"),
                "correction": body.get("correction"),
                "duree_traitement_s": body.get("duree_traitement_s"),
                "operateur_role": body.get("operateur_role"),
            }
            saved = app.store.append_event(ev)
            return self._json({"status": "ok", "id": saved["id"], "horodatage": saved["horodatage"]})

        def _replay(self):
            body = self._read_json_body()
            path, filename, tmp = self._resolve_docx(body)
            dex_id = body.get("dex_id") or (filename or "inconnu")
            try:
                out = replay(app.store, path, dex_id, app.rules)
            finally:
                if tmp:
                    try:
                        os.remove(tmp)
                    except OSError:
                        pass
            return self._json(out)

    return Handler


def build_arg_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(description="Service back local de la reprise DEX -> CAST'IN (boucle 2e ordre).")
    p.add_argument("--host", default="127.0.0.1", help="Adresse d'écoute (défaut 127.0.0.1 ; ne pas exposer).")
    p.add_argument("--port", type=int, default=8765)
    p.add_argument("--data-dir", type=Path, default=Path("./donnees"))
    p.add_argument("--config", type=Path, default=None, help="Défaut: <data-dir>/tableau_de_bord.config.json")
    p.add_argument("--rules", type=Path, default=None, help="Défaut: <data-dir>/regles.json")
    p.add_argument("--front", type=Path, default=None, help="Dossier du front bâti (sert la SPA si fourni).")
    p.add_argument("--allow-origin", action="append", default=None,
                   help="Origine CORS autorisée (répétable). Défaut: localhost dev usuels.")
    return p


def main(argv: Optional[list[str]] = None) -> int:
    args = build_arg_parser().parse_args(argv)
    data_dir = args.data_dir
    config_path = args.config or (data_dir / "tableau_de_bord.config.json")
    rules_path = args.rules or (data_dir / "regles.json")
    front_dir = args.front if (args.front and args.front.exists()) else None

    app = App(data_dir, config_path, rules_path, front_dir)
    origins = args.allow_origin or ["http://localhost:5173", "http://127.0.0.1:5173",
                                     "http://localhost:4173", "http://127.0.0.1:4173"]
    handler = make_handler(app, origins)
    httpd = ThreadingHTTPServer((args.host, args.port), handler)

    print(f"DEX -> CAST'IN — service back local")
    print(f"  écoute        : http://{args.host}:{args.port}  (ne pas exposer hors du poste)")
    print(f"  données       : {data_dir.resolve()}")
    print(f"  règles        : {rules_path}  (version {app.rules.get('version')})")
    print(f"  config front  : {config_path}  (cible ECE {app.config.get('cible_ece')})")
    print(f"  front statique : {front_dir if front_dir else '— (non fourni)'}")
    print(f"  endpoints     : /api/health /api/process-dex /api/validate /api/metrics /api/replay /api/config /api/rules /api/calibration")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nArrêt.")
    finally:
        httpd.server_close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
