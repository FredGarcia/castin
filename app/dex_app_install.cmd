@echo off
setlocal
echo ============================================================
echo  Installeur application DEX -> CAST'IN (runtime)
echo ============================================================
echo Extraction en cours...
set "DEXCMD_SELF=%~f0"
powershell -NoProfile -ExecutionPolicy Bypass -EncodedCommand JABFAHIAcgBvAHIAQQBjAHQAaQBvAG4AUAByAGUAZgBlAHIAZQBuAGMAZQAgAD0AIAAnAFMAdABvAHAAJwAKACQAcwBlAGwAZgAgAD0AIAAkAGUAbgB2ADoARABFAFgAQwBNAEQAXwBTAEUATABGAAoAaQBmACAAKAAtAG4AbwB0ACAAJABzAGUAbABmACkAIAB7ACAAVwByAGkAdABlAC0ASABvAHMAdAAgACcARQByAHIAZQB1AHIAIAA6ACAAYwBoAGUAbQBpAG4AIABkAHUAIABzAGMAcgBpAHAAdAAgAGkAbgB0AHIAbwB1AHYAYQBiAGwAZQAuACcAOwAgAGUAeABpAHQAIAAxACAAfQAKACQAcgBvAG8AdAAgAD0AIABTAHAAbABpAHQALQBQAGEAdABoACAALQBQAGEAcgBlAG4AdAAgACQAcwBlAGwAZgAKACQAdQB0AGYAOAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBUAGUAeAB0AC4AVQBUAEYAOABFAG4AYwBvAGQAaQBuAGcAKAAkAGYAYQBsAHMAZQApAAoAJABsAGkAbgBlAHMAIAA9ACAAWwBTAHkAcwB0AGUAbQAuAEkATwAuAEYAaQBsAGUAXQA6ADoAUgBlAGEAZABBAGwAbABMAGkAbgBlAHMAKAAkAHMAZQBsAGYALAAgAFsAUwB5AHMAdABlAG0ALgBUAGUAeAB0AC4ARQBuAGMAbwBkAGkAbgBnAF0AOgA6AFUAVABGADgAKQAKACQAaQAgAD0AIAAwAAoAJABjAG8AdQBuAHQAIAA9ACAAMAAKAHcAaABpAGwAZQAgACgAJABpACAALQBsAHQAIAAkAGwAaQBuAGUAcwAuAEwAZQBuAGcAdABoACkAIAB7AAoAIAAgACAAIAAkAGwAIAA9ACAAJABsAGkAbgBlAHMAWwAkAGkAXQAKACAAIAAgACAAJAB0AHgAdAAgAD0AIAAkAGwALgBTAHQAYQByAHQAcwBXAGkAdABoACgAJwAjAEAARgBJAEwARQBfAFQAWABUADoAJwApAAoAIAAgACAAIAAkAGIAaQBuACAAPQAgACQAbAAuAFMAdABhAHIAdABzAFcAaQB0AGgAKAAnACMAQABGAEkATABFAF8AQgBJAE4AOgAnACkACgAgACAAIAAgAGkAZgAgACgAJAB0AHgAdAAgAC0AbwByACAAJABiAGkAbgApACAAewAKACAAIAAgACAAIAAgACAAIAAkAHIAZQBsACAAPQAgACQAbAAuAFMAdQBiAHMAdAByAGkAbgBnACgAMQAxACkALgBSAGUAcABsAGEAYwBlACgAJwAvACcALAAgACcAXAAnACkACgAgACAAIAAgACAAIAAgACAAJABpACsAKwAKACAAIAAgACAAIAAgACAAIAAkAHMAdABhAHIAdAAgAD0AIAAkAGkACgAgACAAIAAgACAAIAAgACAAdwBoAGkAbABlACAAKAAkAGkAIAAtAGwAdAAgACQAbABpAG4AZQBzAC4ATABlAG4AZwB0AGgAIAAtAGEAbgBkACAAJABsAGkAbgBlAHMAWwAkAGkAXQAgAC0AbgBlACAAJwAjAEAARgBJAEwARQBfAEUATgBEACcAKQAgAHsAIAAkAGkAKwArACAAfQAKACAAIAAgACAAIAAgACAAIABpAGYAIAAoACQAaQAgAC0AZwB0ACAAJABzAHQAYQByAHQAKQAgAHsAIAAkAGIAbwBkAHkAIAA9ACAAJABsAGkAbgBlAHMAWwAkAHMAdABhAHIAdAAuAC4AKAAkAGkAIAAtACAAMQApAF0AIAB9ACAAZQBsAHMAZQAgAHsAIAAkAGIAbwBkAHkAIAA9ACAAQAAoACkAIAB9AAoAIAAgACAAIAAgACAAIAAgACQAZABlAHMAdAAgAD0AIABKAG8AaQBuAC0AUABhAHQAaAAgACQAcgBvAG8AdAAgACQAcgBlAGwACgAgACAAIAAgACAAIAAgACAAJABkAGkAcgAgAD0AIABTAHAAbABpAHQALQBQAGEAdABoACAALQBQAGEAcgBlAG4AdAAgACQAZABlAHMAdAAKACAAIAAgACAAIAAgACAAIABpAGYAIAAoACQAZABpAHIAIAAtAGEAbgBkACAALQBuAG8AdAAgACgAVABlAHMAdAAtAFAAYQB0AGgAIAAtAEwAaQB0AGUAcgBhAGwAUABhAHQAaAAgACQAZABpAHIAKQApACAAewAKACAAIAAgACAAIAAgACAAIAAgACAAIAAgAE4AZQB3AC0ASQB0AGUAbQAgAC0ASQB0AGUAbQBUAHkAcABlACAARABpAHIAZQBjAHQAbwByAHkAIAAtAEYAbwByAGMAZQAgAC0AUABhAHQAaAAgACQAZABpAHIAIAB8ACAATwB1AHQALQBOAHUAbABsAAoAIAAgACAAIAAgACAAIAAgAH0ACgAgACAAIAAgACAAIAAgACAAaQBmACAAKAAkAHQAeAB0ACkAIAB7AAoAIAAgACAAIAAgACAAIAAgACAAIAAgACAAJAB0AGUAeAB0ACAAPQAgAFsAcwB0AHIAaQBuAGcAXQA6ADoASgBvAGkAbgAoACIAYABuACIALAAgACQAYgBvAGQAeQApAAoAIAAgACAAIAAgACAAIAAgACAAIAAgACAAaQBmACAAKAAkAGIAbwBkAHkALgBMAGUAbgBnAHQAaAAgAC0AZwB0ACAAMAApACAAewAgACQAdABlAHgAdAAgAD0AIAAkAHQAZQB4AHQAIAArACAAIgBgAG4AIgAgAH0ACgAgACAAIAAgACAAIAAgACAAIAAgACAAIABbAFMAeQBzAHQAZQBtAC4ASQBPAC4ARgBpAGwAZQBdADoAOgBXAHIAaQB0AGUAQQBsAGwAVABlAHgAdAAoACQAZABlAHMAdAAsACAAJAB0AGUAeAB0ACwAIAAkAHUAdABmADgAKQAKACAAIAAgACAAIAAgACAAIAB9ACAAZQBsAHMAZQAgAHsACgAgACAAIAAgACAAIAAgACAAIAAgACAAIAAkAGIANgA0ACAAPQAgAFsAcwB0AHIAaQBuAGcAXQA6ADoASgBvAGkAbgAoACcAJwAsACAAJABiAG8AZAB5ACkACgAgACAAIAAgACAAIAAgACAAIAAgACAAIABbAFMAeQBzAHQAZQBtAC4ASQBPAC4ARgBpAGwAZQBdADoAOgBXAHIAaQB0AGUAQQBsAGwAQgB5AHQAZQBzACgAJABkAGUAcwB0ACwAIABbAEMAbwBuAHYAZQByAHQAXQA6ADoARgByAG8AbQBCAGEAcwBlADYANABTAHQAcgBpAG4AZwAoACQAYgA2ADQAKQApAAoAIAAgACAAIAAgACAAIAAgAH0ACgAgACAAIAAgACAAIAAgACAAVwByAGkAdABlAC0ASABvAHMAdAAgACgAIgAgACAAZQBjAHIAaQB0ACAAIAAgAHsAMAB9ACIAIAAtAGYAIAAkAHIAZQBsACkACgAgACAAIAAgACAAIAAgACAAJABjAG8AdQBuAHQAKwArAAoAIAAgACAAIAB9AAoAIAAgACAAIAAkAGkAKwArAAoAfQAKAFcAcgBpAHQAZQAtAEgAbwBzAHQAIAAnACcACgBXAHIAaQB0AGUALQBIAG8AcwB0ACAAKAAiAFQAZQByAG0AaQBuAGUAIAA6ACAAewAwAH0AIABmAGkAYwBoAGkAZQByACgAcwApACAAZQB4AHQAcgBhAGkAdAAoAHMAKQAgAGQAYQBuAHMAIAA6ACIAIAAtAGYAIAAkAGMAbwB1AG4AdAApAAoAVwByAGkAdABlAC0ASABvAHMAdAAgACgAIgAgACAAewAwAH0AIgAgAC0AZgAgACQAcgBvAG8AdAApAAoA
set "RC=%ERRORLEVEL%"
set "DEXCMD_SELF="
echo .
echo Application extraite. Pour la lancer :
echo   python dex_castin_server.py --data-dir .data --front front
echo   puis ouvrir http://127.0.0.1:8765/  (option --port pour changer de port)
endlocal & exit /b %RC%
#@FILE_TXT:dex_castin_common.py
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
dex_castin_common.py — Cœur commun de la reprise DEX (Word) → CAST'IN.

Ce module est PARTAGE par les deux automatisations :
  - dex_castin_cli.py            (utilisation autonome en ligne de commande / DOS)
  - dex_castin_word_addin_server.py (utilisation depuis Word via un complement Office.js)

Il NE DEPEND QUE DE LA BIBLIOTHEQUE STANDARD de Python 3 (zipfile, xml.etree,
re, unicodedata...) : un fichier .docx est une archive ZIP contenant du XML
(OOXML), lisible sans installer "python-docx".

OBJECTIF
--------
Reprendre le contenu d'un DEX (.docx) et produire, pour chaque champ CAST'IN
défini dans CASTIN_FIELDS, le contenu "prêt à coller" — en respectant les
règles impératives du prompt de reprise :

  1. Repérage des sections par leur NOM (jamais par leur numéro de chapitre,
     qui varie d'un DEX à l'autre). Les numéros indiqués dans CASTIN_FIELDS
     ne sont que des INDICES, jamais un critère de recherche.
  2. Seul le contenu utile (texte, liens, références de schémas) est repris ;
     les titres de section et les paragraphes "explicatifs" (italique +
     couleur, typiquement en bleu) sont écartés.
  3. Les caractères spéciaux parasites (puces Wingdings, espaces
     insécables, caractères de contrôle...) sont nettoyés.
  4. Une information absente est remplacée par exactement : "Non concerné".
  5. Le champ "Principes et décisions" reste VIDE.
  6. Le champ "Informations supplémentaires" est optionnel.
  7. Le contenu n'est ni reformulé ni réécrit : uniquement nettoyé/réorganisé.
  8. Toute ambiguïté ou information critique manquante est reportée dans la
     liste "Points à vérifier auprès de l'Équipier Ops" — RIEN n'est deviné.
"""

from __future__ import annotations

import re
import unicodedata
import xml.etree.ElementTree as ET
import zipfile
from dataclasses import dataclass, field
from typing import Optional


# --------------------------------------------------------------------------- #
# Espaces de noms OOXML (format .docx)                                        #
# --------------------------------------------------------------------------- #

NS = {
    "w": "http://schemas.openxmlformats.org/wordprocessingml/2006/main",
    "r": "http://schemas.openxmlformats.org/officeDocument/2006/relationships",
}


def _q(tag: str) -> str:
    """Qualifie un nom de balise OOXML avec l'espace de noms 'w:' (ex: 'p' -> '{...}p')."""
    return f"{{{NS['w']}}}{tag}"


# --------------------------------------------------------------------------- #
# Modèle de données                                                            #
# --------------------------------------------------------------------------- #

@dataclass
class Run:
    """Un morceau de texte avec sa mise en forme (utile pour repérer les
    paragraphes "explicatifs" en italique/couleur, et les hyperliens)."""

    text: str
    italic: bool = False
    color: Optional[str] = None          # couleur RRGGBB, ou None/"auto"
    hyperlink_target: Optional[str] = None


@dataclass
class Paragraph:
    """Un paragraphe du document, avec son éventuel niveau de titre."""

    runs: list[Run] = field(default_factory=list)
    heading_level: Optional[int] = None   # 1 = Titre 1 / Heading 1, etc. None = pas un titre

    @property
    def text(self) -> str:
        return "".join(r.text for r in self.runs)

    @property
    def is_heading(self) -> bool:
        return self.heading_level is not None

    def is_explanatory(self) -> bool:
        """Heuristique de la règle 2 : un paragraphe purement "explicatif" est
        entièrement en italique ET dans une couleur non standard (souvent
        bleu dans les DEX). Un tel paragraphe est écarté du contenu repris."""
        non_empty = [r for r in self.runs if r.text.strip()]
        if not non_empty:
            return False
        if not all(r.italic for r in non_empty):
            return False
        has_color = any(r.color and r.color.lower() not in ("auto", "000000") for r in non_empty)
        return has_color


@dataclass
class Table:
    """Un tableau du document, représenté ligne par ligne / cellule par cellule."""

    rows: list[list[str]] = field(default_factory=list)

    def to_text(self) -> str:
        lines = []
        for row in self.rows:
            cells = [clean_text(c) for c in row]
            if any(cells):
                lines.append(" | ".join(cells))
        return "\n".join(lines)


# Un "item" de contenu est soit un Paragraph, soit une Table
ContentItem = "Paragraph | Table"


# --------------------------------------------------------------------------- #
# Lecture du fichier .docx (ZIP + XML)                                         #
# --------------------------------------------------------------------------- #

def _resolve_heading_levels(styles_xml: Optional[bytes]) -> dict[str, int]:
    """Construit la table styleId -> niveau de titre (1, 2, 3...) à partir de
    word/styles.xml. Couvre les styles "Heading N" et "Titre N" (Word FR),
    ainsi que les styles personnalisés basés sur ceux-ci (chaîne basedOn)."""

    levels: dict[str, int] = {}
    if not styles_xml:
        return levels

    root = ET.fromstring(styles_xml)
    raw: dict[str, dict] = {}
    for style in root.findall(_q("style")):
        style_id = style.get(_q("styleId"))
        if not style_id:
            continue
        name_el = style.find(_q("name"))
        name = name_el.get(_q("val")) if name_el is not None else ""
        based_on_el = style.find(_q("basedOn"))
        based_on = based_on_el.get(_q("val")) if based_on_el is not None else None
        outline = None
        ppr = style.find(_q("pPr"))
        if ppr is not None:
            outline_el = ppr.find(_q("outlineLvl"))
            if outline_el is not None:
                try:
                    outline = int(outline_el.get(_q("val")))
                except (TypeError, ValueError):
                    outline = None
        raw[style_id] = {"name": name or "", "based_on": based_on, "outline": outline}

    heading_name_re = re.compile(r"^(?:heading|titre)\s*([0-9]+)$", re.IGNORECASE)

    def resolve(style_id: str, seen: set[str]) -> Optional[int]:
        if style_id not in raw or style_id in seen:
            return None
        seen.add(style_id)
        info = raw[style_id]
        if info["outline"] is not None:
            return info["outline"] + 1
        m = heading_name_re.match(info["name"].strip())
        if m:
            return int(m.group(1))
        if info["based_on"]:
            return resolve(info["based_on"], seen)
        return None

    for style_id in raw:
        lvl = resolve(style_id, set())
        if lvl:
            levels[style_id] = lvl

    return levels


def _resolve_relationships(rels_xml: Optional[bytes]) -> dict[str, str]:
    """Construit la table Id -> Target des relations (word/_rels/document.xml.rels),
    nécessaire pour retrouver l'URL cible des hyperliens (w:hyperlink r:id=...)."""

    rels: dict[str, str] = {}
    if not rels_xml:
        return rels
    root = ET.fromstring(rels_xml)
    rel_ns = "http://schemas.openxmlformats.org/package/2006/relationships"
    for rel in root.findall(f"{{{rel_ns}}}Relationship"):
        rid = rel.get("Id")
        target = rel.get("Target")
        if rid and target:
            rels[rid] = target
    return rels


_HYPERLINK_INSTR_RE = re.compile(r'HYPERLINK\s+"([^"]+)"', re.IGNORECASE)


def _extract_runs(elem: ET.Element, rels: dict[str, str], hyperlink_target: Optional[str] = None) -> list[Run]:
    """Extrait récursivement les "runs" (w:r) de texte d'un élément (paragraphe,
    hyperlien, cellule de tableau...), en conservant l'italique, la couleur et
    la cible d'hyperlien éventuelle."""

    runs: list[Run] = []
    for child in elem:
        tag = child.tag

        if tag == _q("hyperlink"):
            rid = child.get(f"{{{NS['r']}}}id")
            target = rels.get(rid) if rid else None
            runs.extend(_extract_runs(child, rels, hyperlink_target=target))

        elif tag == _q("fldSimple"):
            instr = child.get(_q("instr"), "")
            m = _HYPERLINK_INSTR_RE.search(instr)
            target = m.group(1) if m else hyperlink_target
            runs.extend(_extract_runs(child, rels, hyperlink_target=target))

        elif tag == _q("r"):
            text_parts: list[str] = []
            italic = False
            color = None
            rpr = child.find(_q("rPr"))
            if rpr is not None:
                if rpr.find(_q("i")) is not None or rpr.find(_q("iCs")) is not None:
                    italic = True
                color_el = rpr.find(_q("color"))
                if color_el is not None:
                    color = color_el.get(_q("val"))
            for sub in child:
                if sub.tag == _q("t"):
                    text_parts.append(sub.text or "")
                elif sub.tag == _q("tab"):
                    text_parts.append("\t")
                elif sub.tag in (_q("br"), _q("cr")):
                    text_parts.append("\n")
                elif sub.tag == _q("instrText"):
                    m = _HYPERLINK_INSTR_RE.search(sub.text or "")
                    if m and hyperlink_target is None:
                        hyperlink_target = m.group(1)
            text = "".join(text_parts)
            if text:
                runs.append(Run(text=text, italic=italic, color=color, hyperlink_target=hyperlink_target))

        else:
            # Autres conteneurs (w:smartTag, w:ins, w:sdt...) : on descend dedans.
            runs.extend(_extract_runs(child, rels, hyperlink_target))

    return runs


def _parse_paragraph(p_elem: ET.Element, rels: dict[str, str], heading_levels: dict[str, int]) -> Paragraph:
    heading_level = None
    ppr = p_elem.find(_q("pPr"))
    if ppr is not None:
        outline_el = ppr.find(_q("outlineLvl"))
        if outline_el is not None:
            try:
                heading_level = int(outline_el.get(_q("val"))) + 1
            except (TypeError, ValueError):
                heading_level = None
        if heading_level is None:
            pstyle = ppr.find(_q("pStyle"))
            if pstyle is not None:
                heading_level = heading_levels.get(pstyle.get(_q("val")))
    runs = _extract_runs(p_elem, rels)
    return Paragraph(runs=runs, heading_level=heading_level)


def _parse_table(tbl_elem: ET.Element, rels: dict[str, str]) -> Table:
    rows: list[list[str]] = []
    for tr in tbl_elem.findall(_q("tr")):
        cells: list[str] = []
        for tc in tr.findall(_q("tc")):
            cell_parts = []
            for p in tc.findall(_q("p")):
                runs = _extract_runs(p, rels)
                cell_parts.append("".join(r.text for r in runs))
            cells.append("\n".join(part for part in cell_parts if part))
        rows.append(cells)
    return Table(rows=rows)


def read_docx(path: str) -> list:
    """Lit un fichier .docx et retourne la liste ordonnée des paragraphes et
    tableaux du corps du document (objets Paragraph / Table)."""

    with zipfile.ZipFile(path) as zf:
        document_xml = zf.read("word/document.xml")
        try:
            rels_xml = zf.read("word/_rels/document.xml.rels")
        except KeyError:
            rels_xml = None
        try:
            styles_xml = zf.read("word/styles.xml")
        except KeyError:
            styles_xml = None

    rels = _resolve_relationships(rels_xml)
    heading_levels = _resolve_heading_levels(styles_xml)

    root = ET.fromstring(document_xml)
    body = root.find(_q("body"))
    if body is None:
        return []

    items: list = []
    for child in body:
        if child.tag == _q("p"):
            items.append(_parse_paragraph(child, rels, heading_levels))
        elif child.tag == _q("tbl"):
            items.append(_parse_table(child, rels))
    return items


# --------------------------------------------------------------------------- #
# Nettoyage du texte (règle 3)                                                 #
# --------------------------------------------------------------------------- #

# Puces issues de polices "symboles" (Wingdings/Symbol), espaces spéciaux,
# caractères de contrôle, etc. -> remplacés par une puce "-" ou supprimés.
_BULLET_CHARS = "•▪●◦‣·"
_BULLET_RE = re.compile(r"^[ \t]*[" + re.escape(_BULLET_CHARS) + r"][ \t]*")
_CONTROL_CHARS_RE = re.compile(r"[\x00-\x08\x0b\x0c\x0e-\x1f\x7f-​-‏]")
_MULTISPACE_RE = re.compile(r"[ \t]+")
_MULTIBLANKLINE_RE = re.compile(r"\n{3,}")


def clean_text(text: str) -> str:
    """Nettoie un texte extrait du DEX (règle 3 : caractères parasites) sans
    modifier le sens : normalisation des espaces, suppression des caractères
    de contrôle / icônes de puces de polices symboles, conversion des espaces
    insécables, et compression des lignes vides successives."""

    if text is None:
        return ""

    # Espace insécable / fine -> espace normal
    text = text.replace(" ", " ").replace(" ", " ")

    # Caractères de contrôle / icônes de puces "police symbole"
    text = _CONTROL_CHARS_RE.sub("", text)

    lines = []
    for raw_line in text.splitlines():
        line = _BULLET_RE.sub("- ", raw_line)
        line = _MULTISPACE_RE.sub(" ", line).strip()
        lines.append(line)

    cleaned = "\n".join(lines)
    cleaned = _MULTIBLANKLINE_RE.sub("\n\n", cleaned)
    return cleaned.strip()


# --------------------------------------------------------------------------- #
# Repérage des sections (règle 1 : par nom, pas par numéro)                   #
# --------------------------------------------------------------------------- #

def _normalize_heading(text: str) -> str:
    """Normalise un titre pour la comparaison : enlève la numérotation
    ("2.1", "12.3.", "4.2.2 - "), les accents, la ponctuation, et met en
    minuscules."""

    # Retire un préfixe de numérotation type "2.1", "12.3.4)", "Annexe 1 -"
    text = re.sub(r"^\s*([0-9]+\.)*[0-9]+[.)\-\s]*", "", text)
    text = unicodedata.normalize("NFKD", text)
    text = "".join(c for c in text if not unicodedata.combining(c))
    text = text.lower()
    text = re.sub(r"[^a-z0-9 ]+", " ", text)
    text = _MULTISPACE_RE.sub(" ", text).strip()
    return text


def _heading_matches(normalized_heading: str, keywords: list[str]) -> bool:
    """Un mot-clé correspond au titre normalisé :
    - mot-clé composé de plusieurs mots (ex: "architecture fonctionnelle
      applicative") : simple inclusion de la phrase ;
    - mot-clé d'un seul mot (ex: "servitude", "certificat", "log") : un mot
      du titre doit COMMENCER par ce mot-clé (gère le singulier/pluriel :
      "servitude" matche "servitudes"), ce qui évite par ailleurs les faux
      positifs par sous-chaîne (ex: "log" ne matche pas "metrologie", car
      aucun mot de "metrologie" ne commence par "log")."""

    words = normalized_heading.split()
    for kw in keywords:
        kw_words = kw.split()
        if len(kw_words) == 1:
            if any(w.startswith(kw) for w in words):
                return True
        elif kw in normalized_heading:
            return True
    return False


def find_section(
    items: list,
    keywords: list[str],
    *,
    start_after: int = 0,
) -> Optional[tuple[int, int, int]]:
    """Cherche, à partir de l'index `start_after`, le premier titre dont le
    texte normalisé contient un des `keywords`.

    Retourne (index_du_titre, index_de_debut_contenu, index_de_fin_exclu)
    où la fin est le prochain titre de niveau <= au titre trouvé (ou la fin
    du document). Retourne None si aucun titre ne correspond.
    """

    for i in range(start_after, len(items)):
        item = items[i]
        if isinstance(item, Paragraph) and item.is_heading:
            if _heading_matches(_normalize_heading(item.text), keywords):
                level = item.heading_level
                end = len(items)
                for j in range(i + 1, len(items)):
                    nxt = items[j]
                    if isinstance(nxt, Paragraph) and nxt.is_heading and nxt.heading_level <= level:
                        end = j
                        break
                return i, i + 1, end
    return None


def section_text(items: list, start: int, end: int) -> str:
    """Concatène le contenu utile (paragraphes non explicatifs + tableaux)
    entre deux index, nettoyé (règles 2 et 3). Les sous-titres rencontrés
    sont conservés (ils font partie du contenu utile d'un chapitre entier,
    ex: "Supervision")."""

    parts: list[str] = []
    for item in items[start:end]:
        if isinstance(item, Paragraph):
            if item.is_explanatory():
                continue
            text = item.text.strip()
            if not text:
                continue
            cleaned = clean_text(text)
            if cleaned:
                parts.append(cleaned)
        elif isinstance(item, Table):
            table_text = item.to_text()
            if table_text:
                parts.append(table_text)
    return "\n".join(parts).strip()


def section_links(items: list, start: int, end: int, text_pattern: Optional[re.Pattern] = None) -> list[str]:
    """Extrait uniquement les hyperliens (et, si `text_pattern` est fourni,
    les références textuelles correspondantes, ex: "DAP1234", "ADU5678")
    présents entre deux index. Utilisé pour les champs "LIEN UNIQUEMENT"
    (Dossier Archi / Schéma Applicatif)."""

    links: list[str] = []
    seen: set[str] = set()

    def add(value: str) -> None:
        value = value.strip()
        if value and value not in seen:
            seen.add(value)
            links.append(value)

    for item in items[start:end]:
        if not isinstance(item, Paragraph):
            continue
        for run in item.runs:
            if run.hyperlink_target:
                add(run.hyperlink_target)
            if text_pattern:
                for m in text_pattern.finditer(run.text):
                    add(m.group(0))
    return links


# --------------------------------------------------------------------------- #
# Définition des champs CAST'IN (règles métier du prompt de reprise)          #
# --------------------------------------------------------------------------- #

# Chaque champ est décrit par :
#   key        : identifiant interne
#   label      : libellé exact du champ CAST'IN (utilisé dans la sortie)
#   tab        : onglet CAST'IN ("Description détaillée" ou "DEX")
#   kind       : "text" | "link" | "empty" | "merge"
#   keywords   : mots-clés (normalisés) des titres de section source
#   hint       : indication du numéro de chapitre dans le DEX (~), pour info
#                 uniquement (NE PAS chercher par numéro, cf règle 1)
#   none_value : valeur si la section est absente ("Non concerné" sauf cas
#                 particuliers prévus par le prompt)
#   optional   : champ optionnel (Informations supplémentaires)

CASTIN_FIELDS = [
    # ---- Onglet "Description détaillée" -----------------------------------
    {
        "key": "lien_dossier_archi",
        "label": "Lien Dossier Archi (DAP…)",
        "tab": "Description détaillée",
        "kind": "link",
        "keywords": ["architecture fonctionnelle applicative"],
        "link_pattern": re.compile(r"\bDAP[0-9A-Z\-]*\b"),
        "hint": "~2.2 Architecture fonctionnelle & applicative",
        "none_value": "Non concerné",
    },
    {
        "key": "schema_applicatif",
        "label": "Schéma Applicatif (ADU…)",
        "tab": "Description détaillée",
        "kind": "link",
        "keywords": ["architecture fonctionnelle applicative", "description de la solution"],
        "link_pattern": re.compile(r"\bADU[0-9A-Z\-]*\b"),
        "hint": "~2.2 (ou ~2.1) Architecture fonctionnelle & applicative / Description de la solution",
        "none_value": "Non concerné",
    },
    {
        "key": "description_fonctionnelle",
        "label": "Description Fonctionnelle",
        "tab": "Description détaillée",
        "kind": "text",
        "keywords": ["description de la solution"],
        "hint": "~2.1 Description de la solution",
        "none_value": "Non concerné",
    },
    {
        "key": "donnees_solution",
        "label": "Données de la solution",
        "tab": "Description détaillée",
        "kind": "text",
        "keywords": ["donnees"],
        "hint": "~2.3 Données",
        "none_value": "Non concerné",
    },
    {
        "key": "principes_decisions",
        "label": "Principes et décisions",
        "tab": "Description détaillée",
        "kind": "empty",
        "keywords": [],
        "hint": "Champ volontairement vide (règle 5)",
        "none_value": "",
    },
    {
        "key": "description_technique",
        "label": "Description Technique",
        "tab": "Description détaillée",
        "kind": "text",
        "keywords": ["architecture technique"],
        "hint": "~4.1 Architecture technique",
        "none_value": "Non concerné",
    },
    # ---- Onglet "DEX" -------------------------------------------------------
    {
        "key": "plage_fonctionnement",
        "label": "Plage de fonctionnement / maintenance",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["plage de fonctionnement", "plages de fonctionnement"],
        "hint": "~3.3 Plages de fonctionnement",
        "none_value": "Non concerné",
    },
    {
        "key": "supervision",
        "label": "Supervision",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["supervision"],
        "hint": "~6 Supervision (chapitre entier)",
        "none_value": "Non concerné",
    },
    {
        "key": "observabilite",
        "label": "Observabilité",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["metrologie"],
        "hint": "~9 ou ~11 Métrologie",
        "none_value": "Non concerné",
    },
    {
        "key": "log",
        "label": "Log",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["diagnostic", "diagnostique", "log", "trace"],
        "hint": "~8.2 Diagnostique / LOG / Trace",
        "none_value": "Non concerné",
    },
    {
        "key": "sauvegardes",
        "label": "Sauvegardes",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["sauvegarde"],
        "hint": "~7 Sauvegarde",
        "none_value": "Non concerné",
    },
    {
        "key": "servitudes",
        "label": "Servitudes et ordonnancements",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["servitude"],
        "hint": "~9 Servitudes (si absent -> Non concerné)",
        "none_value": "Non concerné",
    },
    {
        "key": "comptes_services",
        "label": "Comptes et services",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["compte de service", "comptes de service"],
        "hint": "~12.2 Compte de service",
        "none_value": "Non concerné",
    },
    {
        "key": "certificats",
        "label": "Certificats",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["certificat"],
        "hint": "~12.3 Certificats",
        "none_value": "Non concerné",
    },
    {
        "key": "liste_blanche",
        "label": "Liste blanche",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["liste blanche", "whitelist"],
        "hint": "~12.4",
        "none_value": "Non concerné",
    },
    {
        "key": "flux",
        "label": "Flux",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["flux et interdependance", "flux et interdependances"],
        "hint": "~4.3 Flux et interdépendances",
        "none_value": "Non concerné",
    },
    {
        "key": "support",
        "label": "Support",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["matrice de responsabilite", "matrice des responsabilites", "raci"],
        "hint": "~8.1 Matrice responsabilité",
        "none_value": "Non concerné",
    },
    {
        "key": "changement_mep",
        "label": "Changement et MEP",
        "tab": "DEX",
        "kind": "merge",
        "keywords": ["controle des operations", "changements et mep", "changement et mep"],
        "hint": "~10 Contrôle des opérations + ~5 Changements et MEP",
        "none_value": "Non concerné",
    },
    {
        "key": "matiere_repo",
        "label": "Matière (repo)",
        "tab": "DEX",
        "kind": "merge",
        "keywords": ["referentiel", "repository", "depot de code", "matiere"],
        "extra_search": re.compile(r"merge request", re.IGNORECASE),
        "hint": "~5.1 + recherche \"Merge Request\"",
        "none_value": "Non concerné",
    },
    {
        "key": "procedure_restauration",
        "label": "Procédure de restauration",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["restauration"],
        "hint": "~13.1 Restauration",
        "none_value": "Non concerné",
    },
    {
        "key": "procedure_reconstruction",
        "label": "Procédure de reconstruction",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["reconstruction"],
        "hint": "~13.2 Reconstruction",
        "none_value": "Non concerné",
    },
    {
        "key": "procedure_resynchronisation",
        "label": "Procédure de resynchronisation",
        "tab": "DEX",
        "kind": "text",
        "keywords": ["resynchronisation"],
        "hint": "~13.3 Resynchronisation",
        "none_value": "Non concerné",
    },
    {
        "key": "informations_supplementaires",
        "label": "Informations supplémentaires",
        "tab": "DEX",
        "kind": "appendix",
        "keywords": ["assets mainframe"],
        "hint": "Contenu après ~13.3 + ~4.2.2 Assets mainframe (optionnel)",
        "none_value": "",
        "optional": True,
    },
]


# --------------------------------------------------------------------------- #
# Identification (numéro de solution, auteur, responsable)                    #
# --------------------------------------------------------------------------- #

_SOLUTION_RE = re.compile(r"(?<![A-Za-z0-9])S\d{4,6}(?!\d)")


def extract_identification(items: list, filename: str) -> dict:
    """Extrait le numéro de solution (Sxxxx), l'auteur (page de garde) et le
    responsable (page 2, ou nom du service si absent)."""

    result = {"solution": None, "auteur": None, "responsable": None}
    notes: list[str] = []

    # Numéro de solution : nom de fichier en priorité, sinon contenu du document.
    m = _SOLUTION_RE.search(filename or "")
    if m:
        result["solution"] = m.group(0)
    else:
        for item in items[:60]:
            if isinstance(item, Paragraph):
                m = _SOLUTION_RE.search(item.text)
                if m:
                    result["solution"] = m.group(0)
                    break
        if not result["solution"]:
            notes.append(
                "Numéro de solution (Sxxxx) introuvable dans le nom de fichier ni dans "
                "le début du document — à confirmer."
            )

    # Auteur : page de garde -> on cherche un paragraphe "Auteur : ..." dans le
    # tout début du document (avant le premier titre).
    first_heading = next((i for i, it in enumerate(items) if isinstance(it, Paragraph) and it.is_heading), len(items))
    cover_items = items[:first_heading]

    auteur = _find_labelled_value(cover_items, [r"auteur"])
    if auteur:
        result["auteur"] = auteur
    else:
        notes.append("Auteur du DEX introuvable sur la page de garde — à confirmer.")

    # Responsable : page 2 (on cherche jusqu'au 2e titre rencontré, large mais sûr).
    responsable_scope = items[:first_heading]
    for i, it in enumerate(items):
        if isinstance(it, Paragraph) and it.is_heading:
            responsable_scope = items[: i + 1]
            break

    responsable = _find_labelled_value(items[:60], [r"responsable"])
    if responsable:
        result["responsable"] = responsable
    else:
        service = _find_labelled_value(items[:60], [r"service"])
        if service:
            result["responsable"] = service
            notes.append("Responsable absent : nom du service repris à la place (à confirmer).")
        else:
            notes.append("Responsable (ou nom du service) introuvable en page 2 — à confirmer.")

    return {"values": result, "notes": notes}


def _find_labelled_value(items: list, label_patterns: list[str]) -> Optional[str]:
    """Cherche un paragraphe de la forme "Label : valeur" (ou "Label\\tvaleur")
    et retourne la valeur nettoyée."""

    for pattern in label_patterns:
        regex = re.compile(rf"^\s*{pattern}\s*[:\t]\s*(.+)$", re.IGNORECASE)
        for item in items:
            if isinstance(item, Paragraph):
                text = item.text.strip()
                m = regex.match(text)
                if m:
                    value = clean_text(m.group(1))
                    if value:
                        return value
    return None


# --------------------------------------------------------------------------- #
# Traitement complet                                                           #
# --------------------------------------------------------------------------- #

def process_dex(path: str, filename: Optional[str] = None) -> dict:
    """Traite un fichier DEX .docx et retourne un dictionnaire :

    {
      "identification": {"solution": ..., "auteur": ..., "responsable": ...},
      "champs": {champ_key: {"label", "tab", "content"}, ...},
      "points_a_verifier": [str, ...],
    }

    Conforme aux règles du prompt de reprise DEX -> CAST'IN.
    """

    filename = filename or path
    items = read_docx(path)

    points_a_verifier: list[str] = []

    ident = extract_identification(items, filename)
    points_a_verifier.extend(ident["notes"])

    champs: dict[str, dict] = {}

    for fdef in CASTIN_FIELDS:
        key = fdef["key"]
        label = fdef["label"]
        kind = fdef["kind"]

        if kind == "empty":
            # Règle 5 : "Principes et décisions" reste vide.
            champs[key] = {"label": label, "tab": fdef["tab"], "content": ""}
            continue

        if kind == "link":
            content, found = _extract_link_field(items, fdef)
        elif kind == "merge":
            content, found = _extract_merge_field(items, fdef)
        elif kind == "appendix":
            content, found = _extract_appendix_field(items, fdef)
        else:
            content, found = _extract_text_field(items, fdef)

        if not content:
            content = fdef["none_value"]
            if not fdef.get("optional") and not found:
                points_a_verifier.append(
                    f"Champ « {label} » : section source introuvable "
                    f"({fdef['hint']}) -> mis à \"{fdef['none_value'] or '(vide)'}\", à vérifier."
                )

        champs[key] = {"label": label, "tab": fdef["tab"], "content": content}

    return {
        "identification": ident["values"],
        "champs": champs,
        "points_a_verifier": points_a_verifier,
    }


def _extract_text_field(items: list, fdef: dict) -> tuple[str, bool]:
    section = find_section(items, fdef["keywords"])
    if section is None:
        return "", False
    _, start, end = section
    return section_text(items, start, end), True


def _extract_link_field(items: list, fdef: dict) -> tuple[str, bool]:
    """Champ "LIEN UNIQUEMENT" : peut être indiqué par le prompt dans
    plusieurs sections candidates (ex: ADU dans "Architecture fonctionnelle &
    applicative" OU "Description de la solution"). On parcourt TOUTES les
    sections correspondant aux mots-clés et on agrège les liens trouvés."""

    links: list[str] = []
    found_any = False
    cursor = 0
    while True:
        section = find_section(items, fdef["keywords"], start_after=cursor)
        if section is None:
            break
        _, start, end = section
        found_any = True
        for link in section_links(items, start, end, fdef.get("link_pattern")):
            if link not in links:
                links.append(link)
        cursor = end
    return "\n".join(links), found_any


def _extract_merge_field(items: list, fdef: dict) -> tuple[str, bool]:
    """Champ composé de plusieurs sections (ex: "Changement et MEP" =
    "Contrôle des opérations" + "Changements et MEP"), avec recherche
    additionnelle optionnelle (ex: "Merge Request" pour "Matière (repo)")."""

    parts: list[str] = []
    found_any = False

    section = find_section(items, fdef["keywords"])
    if section is not None:
        _, start, end = section
        text = section_text(items, start, end)
        if text:
            parts.append(text)
        found_any = True
        # Cherche une deuxième section distincte après la première (cas
        # "Changement et MEP" = deux chapitres séparés).
        second = find_section(items, fdef["keywords"], start_after=end)
        if second is not None:
            _, start2, end2 = second
            text2 = section_text(items, start2, end2)
            if text2:
                parts.append(text2)

    extra_pattern: Optional[re.Pattern] = fdef.get("extra_search")
    if extra_pattern is not None:
        extra_lines = []
        for item in items:
            if isinstance(item, Paragraph) and not item.is_heading and not item.is_explanatory():
                if extra_pattern.search(item.text):
                    cleaned = clean_text(item.text)
                    if cleaned:
                        extra_lines.append(cleaned)
        if extra_lines:
            parts.append("Références \"Merge Request\" trouvées dans le document :\n" + "\n".join(extra_lines))
            found_any = True

    return "\n\n".join(p for p in parts if p).strip(), found_any


def _extract_appendix_field(items: list, fdef: dict) -> tuple[str, bool]:
    """"Informations supplémentaires" (optionnel) = contenu situé après la
    section "Resynchronisation" (~13.3) + section "Assets mainframe" (~4.2.2)
    si elle existe ailleurs dans le document."""

    parts: list[str] = []
    found_any = False

    resync = find_section(items, ["resynchronisation"])
    if resync is not None:
        _, _, end = resync
        tail_items = items[end:]
        tail_text = section_text(tail_items, 0, len(tail_items))
        if tail_text:
            parts.append(tail_text)
            found_any = True

    mainframe = find_section(items, fdef["keywords"])
    if mainframe is not None:
        _, start, end = mainframe
        text = section_text(items, start, end)
        if text:
            parts.append("Assets mainframe :\n" + text)
            found_any = True

    return "\n\n".join(p for p in parts if p).strip(), found_any


# --------------------------------------------------------------------------- #
# Mise en forme de la sortie                                                   #
# --------------------------------------------------------------------------- #

def format_markdown(result: dict) -> str:
    """Produit les trois blocs de sortie attendus par le prompt de reprise."""

    lines: list[str] = []
    ident = result["identification"]

    lines.append("## 1. IDENTIFICATION")
    lines.append(f"Solution : {ident.get('solution') or 'Non concerné'}")
    lines.append(f"Auteur : {ident.get('auteur') or 'Non concerné'}")
    lines.append(f"Responsable : {ident.get('responsable') or 'Non concerné'}")
    lines.append("")

    lines.append("## 2. CONTENU PAR CHAMP CAST'IN")
    for fdef in CASTIN_FIELDS:
        champ = result["champs"][fdef["key"]]
        lines.append(f"**[{champ['label']}]**")
        if fdef["kind"] == "empty":
            lines.append("(laisser vide)")
        else:
            lines.append(champ["content"] or "Non concerné")
        lines.append("")

    lines.append("## 3. POINTS À VÉRIFIER AUPRÈS DE L'ÉQUIPIER OPS")
    points = result["points_a_verifier"]
    if points:
        for p in points:
            lines.append(f"- {p}")
    else:
        lines.append("RAS")

    return "\n".join(lines)


def to_json(result: dict) -> dict:
    """Représentation JSON (utilisée par le serveur Office.js) : un
    dictionnaire {champ_key: {label, tab, content}} + identification +
    points à vérifier + rendu markdown complet."""

    return {
        "identification": result["identification"],
        "champs": result["champs"],
        "points_a_verifier": result["points_a_verifier"],
        "markdown": format_markdown(result),
    }
#@FILE_END
#@FILE_TXT:dex_castin_cli.py
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
dex_castin_cli.py — Reprise DEX -> CAST'IN, en ligne de commande (autonome).

USAGE (Windows "DOS" / invite de commandes, Linux, macOS) :

    python dex_castin_cli.py "C:\\dossiers\\DEX_S12345_MaSolution.docx"

    python dex_castin_cli.py DEX_S12345.docx -o resultat.md
    python dex_castin_cli.py DEX_S12345.docx --json resultat.json
    python dex_castin_cli.py *.docx --out-dir ./sorties

Pour chaque fichier .docx fourni, ce script :
  1. lit le DEX (.docx) avec dex_castin_common.process_dex(),
  2. affiche à l'écran les trois blocs attendus par le prompt de reprise
     (IDENTIFICATION / CONTENU PAR CHAMP CAST'IN / POINTS À VÉRIFIER),
  3. écrit le résultat dans un fichier .md (et, sur demande, .json) prêt à
     être consulté pendant la saisie dans CAST'IN.

Ce script ne dépend QUE de la bibliothèque standard (argparse, pathlib, json)
et du module commun dex_castin_common.py, situé dans le même dossier.
"""

import argparse
import json
import sys
from pathlib import Path

# Le module commun doit être dans le même dossier que ce script.
sys.path.insert(0, str(Path(__file__).resolve().parent))

import dex_castin_common as dex  # noqa: E402


def process_one(docx_path: Path, out_dir: Path | None, write_json: bool) -> int:
    """Traite un fichier DEX et écrit les sorties associées.

    Retourne le nombre de "points à vérifier" détectés (0 = aucun doute,
    utile comme indicateur dans le résumé final)."""

    print(f"\n{'=' * 70}")
    print(f"DEX : {docx_path}")
    print("=" * 70)

    try:
        result = dex.process_dex(str(docx_path), filename=docx_path.name)
    except Exception as exc:  # noqa: BLE001 - on veut un message clair pour l'utilisateur
        print(f"[ERREUR] Impossible de traiter '{docx_path}' : {exc}")
        return -1

    markdown = dex.format_markdown(result)
    print(markdown)

    target_dir = out_dir if out_dir is not None else docx_path.parent
    target_dir.mkdir(parents=True, exist_ok=True)

    md_path = target_dir / (docx_path.stem + "_CASTIN.md")
    md_path.write_text(markdown, encoding="utf-8")
    print(f"\n--> Rendu Markdown écrit dans : {md_path}")

    if write_json:
        json_path = target_dir / (docx_path.stem + "_CASTIN.json")
        json_path.write_text(
            json.dumps(dex.to_json(result), ensure_ascii=False, indent=2),
            encoding="utf-8",
        )
        print(f"--> Rendu JSON écrit dans      : {json_path}")

    return len(result["points_a_verifier"])


def build_arg_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description=(
            "Reprise d'un ou plusieurs DEX (.docx) vers le format CAST'IN, "
            "selon les règles du prompt de reprise DEX -> CAST'IN."
        )
    )
    parser.add_argument(
        "fichiers",
        nargs="+",
        help="Un ou plusieurs fichiers DEX au format .docx (les motifs comme *.docx "
        "sont développés par l'invite de commandes elle-même sous Linux/macOS ; "
        "sous Windows, ce script les développe lui-même si nécessaire).",
    )
    parser.add_argument(
        "-o",
        "--out-dir",
        type=Path,
        default=None,
        help="Dossier de sortie pour les fichiers générés (*_CASTIN.md / .json). "
        "Par défaut : même dossier que le fichier source.",
    )
    parser.add_argument(
        "--json",
        dest="write_json",
        action="store_true",
        help="Génère en plus un fichier *_CASTIN.json (utile pour un traitement automatisé).",
    )
    return parser


def expand_inputs(patterns: list[str]) -> list[Path]:
    """Sous Windows (DOS), l'invite de commandes ne développe pas les motifs
    comme '*.docx' : on le fait nous-mêmes via Path.glob()."""

    paths: list[Path] = []
    for pattern in patterns:
        p = Path(pattern)
        if any(ch in pattern for ch in "*?[]"):
            base = p.parent if p.parent != Path("") else Path(".")
            paths.extend(sorted(base.glob(p.name)))
        else:
            paths.append(p)
    return paths


def main(argv: list[str] | None = None) -> int:
    args = build_arg_parser().parse_args(argv)
    files = expand_inputs(args.fichiers)

    if not files:
        print("Aucun fichier trouvé.", file=sys.stderr)
        return 2

    total_points = 0
    errors = 0

    for f in files:
        if not f.exists():
            print(f"[ERREUR] Fichier introuvable : {f}", file=sys.stderr)
            errors += 1
            continue
        if f.suffix.lower() != ".docx":
            print(f"[AVERTISSEMENT] '{f}' n'est pas un fichier .docx, ignoré.", file=sys.stderr)
            continue

        nb_points = process_one(f, args.out_dir, args.write_json)
        if nb_points < 0:
            errors += 1
        else:
            total_points += nb_points

    print(f"\n{'=' * 70}")
    print(f"Terminé. {len(files) - errors} fichier(s) traité(s), {total_points} point(s) à vérifier au total.")
    if errors:
        print(f"{errors} fichier(s) en erreur.")

    return 1 if errors else 0


if __name__ == "__main__":
    raise SystemExit(main())
#@FILE_END
#@FILE_TXT:dex_castin_server.py
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
#@FILE_END
#@FILE_TXT:dex_castin_calibration.py
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
#@FILE_END
#@FILE_TXT:regles.json
{
  "version": "1.0.0",
  "description": "Overlay de règles versionné. 'extra_keywords' enrichit ADDITIVEMENT le lexique de repérage par champ (règle 1). Tout changement doit re-passer le harness avant publication.",
  "extra_keywords": {},
  "confiance": {
    "base_text": 0.9,
    "base_link": 0.8,
    "base_compose": 0.75,
    "malus_match_faible": 0.1,
    "malus_contenu_court": 0.15,
    "seuil_contenu_court": 15,
    "optionnel_absent": 0.85,
    "requis_absent": 0.3,
    "plafond_si_signale": 0.4,
    "malus_ambiguite": 0.2
  },
  "seuil_routage": 0.0,
  "marge_ambiguite": 0.15,
  "max_candidats": 5,
  "calibration": {
    "actif": false,
    "min_n_par_champ": 30,
    "par_defaut": [],
    "par_champ": {}
  }
}
#@FILE_END
#@FILE_TXT:regles.candidate.exemple.json
{
  "version": "1.1.0",
  "description": "Overlay de règles versionné. 'extra_keywords' enrichit ADDITIVEMENT le lexique de repérage par champ (règle 1). Tout changement doit re-passer le harness avant publication.",
  "extra_keywords": {},
  "confiance": {
    "base_text": 0.9,
    "base_link": 0.8,
    "base_compose": 0.75,
    "malus_match_faible": 0.1,
    "malus_contenu_court": 0.15,
    "seuil_contenu_court": 15,
    "optionnel_absent": 0.85,
    "requis_absent": 0.3,
    "plafond_si_signale": 0.4
  },
  "seuil_routage": 0.0,
  "calibration": {
    "actif": true,
    "min_n_par_champ": 30,
    "par_defaut": [
      [
        0.0,
        0.4074
      ],
      [
        0.4526,
        0.4074
      ],
      [
        0.4926,
        0.4074
      ],
      [
        0.4947,
        0.4318
      ],
      [
        0.5626,
        0.4318
      ],
      [
        0.5665,
        0.6232
      ],
      [
        0.8545,
        0.6232
      ],
      [
        0.8575,
        0.6875
      ],
      [
        0.9216,
        0.6875
      ],
      [
        0.9239,
        0.72
      ],
      [
        0.9829,
        0.72
      ],
      [
        0.9834,
        0.75
      ],
      [
        0.9861,
        0.75
      ],
      [
        1.0,
        0.75
      ]
    ],
    "par_champ": {
      "supervision": [
        [
          0.0,
          0.0
        ],
        [
          0.4693,
          0.0
        ],
        [
          0.4729,
          0.125
        ],
        [
          0.5263,
          0.125
        ],
        [
          0.5467,
          0.6071
        ],
        [
          0.877,
          0.6071
        ],
        [
          0.8983,
          0.6667
        ],
        [
          0.9446,
          0.6667
        ],
        [
          0.9586,
          1.0
        ],
        [
          0.9783,
          1.0
        ],
        [
          1.0,
          1.0
        ]
      ],
      "observabilite": [
        [
          0.0,
          0.4286
        ],
        [
          0.4766,
          0.4286
        ],
        [
          0.5588,
          0.4286
        ],
        [
          0.5665,
          0.6667
        ],
        [
          0.8637,
          0.6667
        ],
        [
          0.8697,
          0.8
        ],
        [
          0.9823,
          0.8
        ],
        [
          1.0,
          0.8
        ]
      ],
      "log": [
        [
          0.0,
          0.0
        ],
        [
          0.4733,
          0.0
        ],
        [
          0.4811,
          0.4615
        ],
        [
          0.6085,
          0.4615
        ],
        [
          0.6092,
          0.5
        ],
        [
          0.6752,
          0.5
        ],
        [
          0.6862,
          0.7647
        ],
        [
          0.8395,
          0.7647
        ],
        [
          0.8495,
          1.0
        ],
        [
          0.9836,
          1.0
        ],
        [
          1.0,
          1.0
        ]
      ],
      "certificats": [
        [
          0.0,
          0.1667
        ],
        [
          0.4608,
          0.1667
        ],
        [
          0.4989,
          0.1667
        ],
        [
          0.5106,
          0.5
        ],
        [
          0.5506,
          0.5
        ],
        [
          0.5817,
          0.5556
        ],
        [
          0.6622,
          0.5556
        ],
        [
          0.6642,
          0.6429
        ],
        [
          0.8731,
          0.6429
        ],
        [
          0.8749,
          0.75
        ],
        [
          0.9124,
          0.75
        ],
        [
          0.9256,
          0.8
        ],
        [
          0.977,
          0.8
        ],
        [
          0.9834,
          1.0
        ],
        [
          1.0,
          1.0
        ]
      ],
      "description_fonctionnelle": [
        [
          0.0,
          0.0
        ],
        [
          0.4568,
          0.0
        ],
        [
          0.4645,
          0.0
        ],
        [
          0.4671,
          0.5
        ],
        [
          0.8384,
          0.5
        ],
        [
          0.8578,
          0.6364
        ],
        [
          0.9861,
          0.6364
        ],
        [
          1.0,
          0.6364
        ]
      ],
      "schema_applicatif": [
        [
          0.0,
          0.5
        ],
        [
          0.4526,
          0.5
        ],
        [
          0.609,
          0.5
        ],
        [
          0.6154,
          0.6364
        ],
        [
          0.9829,
          0.6364
        ],
        [
          1.0,
          0.6364
        ]
      ]
    }
  }
}
#@FILE_END
#@FILE_TXT:tableau_de_bord.config.json
{
  "cible_ece": 0.1,
  "alerte_taux_acceptation_min": 0.85,
  "alerte_duree_dex_max_s": 720,
  "k_promotion_fixture": 5,
  "fenetre_glissante_n": 200,
  "pastille_confiance_couleur_champ": true,
  "ordre_cartes": {},
  "intitules_cartes": {},
  "titres_proposes": {},
  "email": {
    "adresses": "fredgarcia@mail.fr",
    "objet_prefixe": "Castin ; ",
    "contenu_prefixe": "",
    "suffixe": "Cordialement,"
  }
}
#@FILE_END
#@FILE_TXT:front/index.html
<!doctype html>
<html lang="fr">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Reprise DEX → CAST'IN — poste assisté</title>
<style>
  :root{
    --bleu-france:#000091; --bleu-clair:#e3e3fd; --rouge:#e1000f;
    --texte:#1b1b35; --texte-doux:#3a3a55; --gris-bord:#cecece; --gris-fond:#f6f6f6;
    --blanc:#ffffff; --succes:#18753c; --succes-fond:#dffee6;
    --alerte:#b34000; --alerte-fond:#fff4e6; --erreur:#ce0500; --erreur-fond:#ffe9e9;
    --ombre:0 1px 3px rgba(0,0,16,.18); --rayon:6px;
    --police:system-ui,-apple-system,"Segoe UI",Roboto,Arial,sans-serif;
  }
  *{box-sizing:border-box}
  body{margin:0;font-family:var(--police);color:var(--texte);background:var(--gris-fond);line-height:1.5}
  a{color:var(--bleu-france)}
  h1,h2,h3{line-height:1.25;margin:.2em 0 .4em}
  h1{font-size:1.35rem} h2{font-size:1.15rem} h3{font-size:1rem}
  .skip{position:absolute;left:-9999px;top:0;background:var(--bleu-france);color:#fff;padding:.6rem 1rem;z-index:100}
  .skip:focus{left:.5rem;top:.5rem}
  :focus-visible{outline:3px solid var(--bleu-france);outline-offset:2px}
  header[role=banner]{background:var(--blanc);border-bottom:3px solid var(--bleu-france);padding:.7rem 1rem;
    display:flex;align-items:center;gap:1rem;flex-wrap:wrap}
  header .titre{font-weight:700;color:var(--bleu-france);font-size:1.15rem}
  header .sep{flex:1}
  .pastille{display:inline-flex;align-items:center;gap:.4rem;font-size:.85rem;color:var(--texte-doux)}
  .point{width:.7rem;height:.7rem;border-radius:50%;background:var(--gris-bord);display:inline-block}
  .point.ok{background:var(--succes)} .point.ko{background:var(--erreur)}
  .champ-role{display:flex;align-items:center;gap:.4rem;font-size:.85rem}
  select,input,button,textarea{font:inherit}
  select,input[type=text]{padding:.4rem .5rem;border:1px solid var(--gris-bord);border-radius:var(--rayon);background:#fff;color:var(--texte)}
  button{cursor:pointer;border:1px solid var(--bleu-france);background:var(--bleu-france);color:#fff;
    padding:.45rem .8rem;border-radius:var(--rayon);font-weight:600}
  button.secondaire{background:#fff;color:var(--bleu-france)}
  button.discret{background:#fff;color:var(--texte);border-color:var(--gris-bord);font-weight:500}
  button:disabled{opacity:.5;cursor:not-allowed}
  main{max-width:1500px;margin:0 auto;padding:1rem}
  [role=tablist]{display:flex;gap:.3rem;border-bottom:1px solid var(--gris-bord);margin-bottom:1rem}
  [role=tab]{background:transparent;color:var(--texte-doux);border:none;border-bottom:3px solid transparent;border-radius:0;
    padding:.6rem 1rem;font-weight:600}
  [role=tab][aria-selected=true]{color:var(--bleu-france);border-bottom-color:var(--bleu-france)}
  .barre-chargement{display:flex;gap:.6rem;align-items:flex-end;flex-wrap:wrap;background:#fff;border:1px solid var(--gris-bord);
    border-radius:var(--rayon);padding:1rem;box-shadow:var(--ombre)}
  .barre-chargement .bloc{display:flex;flex-direction:column;gap:.25rem}
  .zone-depot{border:2px dashed var(--bleu-france);border-radius:var(--rayon);padding:.7rem 1rem;background:var(--bleu-clair);
    color:var(--texte);font-size:.9rem}
  .statut{margin:.6rem 0;min-height:1.4rem;font-size:.9rem}
  .statut .ok{color:var(--succes)} .alerte-boite{background:var(--erreur-fond);border:1px solid var(--erreur);
    color:#7a0000;padding:.5rem .8rem;border-radius:var(--rayon)}
  .espace{display:grid;grid-template-columns:minmax(380px,2fr) 3fr;gap:1rem;align-items:start}
  @media(max-width:1100px){.espace{grid-template-columns:1fr}}
  .colonne{background:#fff;border:1px solid var(--gris-bord);border-radius:var(--rayon);box-shadow:var(--ombre);
    padding:.8rem;max-height:78vh;overflow:auto}
  .ident{background:var(--gris-fond);border:1px solid var(--gris-bord);border-radius:var(--rayon);padding:.6rem .8rem;margin-bottom:.8rem;font-size:.9rem}
  .ident dt{font-weight:700;color:var(--texte-doux)} .ident dd{margin:0 0 .3rem}
  .groupe-titre{position:sticky;top:0;background:#fff;padding:.3rem 0;border-bottom:1px solid var(--gris-bord);z-index:2}
  .carte{border:1px solid var(--gris-bord);border-left:6px solid var(--coul,var(--gris-bord));border-radius:var(--rayon);
    padding:.6rem;margin:.6rem 0;background:#fff}
  .carte.active{box-shadow:0 0 0 2px var(--bleu-france)}
  .carte .entete{display:flex;align-items:center;gap:.5rem;flex-wrap:wrap}
  .carte .lib{font-weight:700;flex:1;text-align:left;background:none;border:none;color:var(--texte);padding:0;cursor:pointer}
  .etiq{font-size:.72rem;font-weight:700;padding:.1rem .4rem;border-radius:10px;background:var(--bleu-clair);color:var(--bleu-france);white-space:nowrap}
  .conf{font-size:.78rem;font-weight:700;padding:.1rem .45rem;border-radius:10px;white-space:nowrap}
  .conf.elevee{background:var(--succes-fond);color:var(--succes)}
  .conf.moyenne{background:var(--alerte-fond);color:var(--alerte)}
  .conf.faible{background:var(--erreur-fond);color:var(--erreur)}
  .conf.na{background:var(--gris-fond);color:var(--texte-doux)}
  .jauge{height:.4rem;border-radius:3px;background:var(--gris-fond);margin:.35rem 0;overflow:hidden}
  .jauge>span{display:block;height:100%;background:var(--coul,var(--bleu-france))}
  .raison{font-size:.8rem;color:var(--texte-doux);margin:.2rem 0}
  textarea.contenu{width:100%;min-height:3.2rem;max-height:14rem;resize:vertical;border:1px solid var(--gris-bord);
    border-radius:var(--rayon);padding:.4rem;font-size:.85rem;background:var(--gris-fond);color:var(--texte)}
  .actions{display:flex;gap:.4rem;flex-wrap:wrap;margin-top:.4rem;align-items:center}
  .suggestions{display:flex;gap:.3rem;flex-wrap:wrap;margin-top:.3rem}
  .suggestions .puce{font-size:.78rem;background:var(--gris-fond);border:1px solid var(--gris-bord);border-radius:10px;padding:.15rem .5rem;color:var(--texte)}
  .form-signal{margin-top:.4rem;padding:.5rem;background:var(--gris-fond);border:1px dashed var(--gris-bord);border-radius:var(--rayon);
    display:flex;gap:.4rem;flex-wrap:wrap;align-items:flex-end}
  .valide-ok{color:var(--succes);font-weight:700;font-size:.82rem}
  .valide-sig{color:var(--alerte);font-weight:700;font-size:.82rem}
  /* document annoté */
  .doc-outils{display:flex;gap:.6rem;align-items:center;flex-wrap:wrap;margin-bottom:.5rem}
  .legende{display:flex;gap:.4rem;flex-wrap:wrap;font-size:.75rem;margin-bottom:.5rem}
  .legende .item{display:inline-flex;align-items:center;gap:.3rem}
  .legende .pal{width:.8rem;height:.8rem;border-radius:2px;border:1px solid #0003}
  .para{padding:.15rem .4rem;border-radius:3px;font-size:.88rem;margin:.05rem 0;white-space:pre-wrap}
  .para.titre{font-weight:700;color:var(--bleu-france);margin-top:.5rem}
  .para.explicatif{color:#8a8aa0;font-style:italic}
  .para.surligne{border-left:4px solid var(--coul);background:var(--coulfond);padding-left:.5rem}
  .para .badge-fleche{display:inline-block;font-size:.72rem;font-weight:700;color:#fff;background:var(--coul);
    border-radius:3px;padding:0 .35rem;margin-right:.4rem}
  .vh{position:absolute!important;width:1px;height:1px;padding:0;margin:-1px;overflow:hidden;clip:rect(0 0 0 0);white-space:nowrap;border:0}
  /* tableau de bord */
  .cartes-kpi{display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:.8rem;margin:.6rem 0}
  .kpi{background:#fff;border:1px solid var(--gris-bord);border-radius:var(--rayon);padding:.7rem;box-shadow:var(--ombre)}
  .kpi .v{font-size:1.5rem;font-weight:700} .kpi .l{font-size:.8rem;color:var(--texte-doux)}
  .kpi.bon{border-top:4px solid var(--succes)} .kpi.mauvais{border-top:4px solid var(--erreur)}
  table{border-collapse:collapse;width:100%;font-size:.85rem;background:#fff}
  caption{text-align:left;font-weight:700;padding:.3rem 0}
  th,td{border:1px solid var(--gris-bord);padding:.35rem .5rem;text-align:left}
  th[scope=col]{background:var(--gris-fond)}
  .alertes li{color:#7a0000}
  .panneau{background:#fff;border:1px solid var(--gris-bord);border-radius:var(--rayon);box-shadow:var(--ombre);padding:.9rem;margin-bottom:1rem}
  .replay-modif{border-left:4px solid var(--bleu-france);padding:.3rem .6rem;margin:.3rem 0;background:var(--gris-fond);font-size:.85rem}
  del{color:#7a0000} ins{color:var(--succes);text-decoration:none;background:var(--succes-fond)}
  .muet{color:var(--texte-doux);font-size:.85rem}
  .candidats{border:1px solid var(--gris-bord);border-radius:var(--rayon);padding:.4rem .6rem;margin:.4rem 0}
  .candidats legend{font-size:.82rem;font-weight:700;padding:0 .3rem}
  .cand-opt{display:grid;grid-template-columns:auto 1fr;gap:.1rem .5rem;align-items:start;padding:.25rem;border-radius:var(--rayon);cursor:pointer}
  .cand-opt:hover{background:#f4f6ff}
  .cand-opt.actif{background:#eef2ff;outline:2px solid var(--bleu-france)}
  .cand-opt input{grid-row:1/3;align-self:center}
  .cand-titre{font-weight:600}
  .cand-extrait{grid-column:2;font-size:.8rem}
  .candidats-info{margin:.4rem 0;font-size:.85rem}
  .candidats-info summary{cursor:pointer}
  .chevron{border:0;background:transparent;cursor:pointer;font-size:.95rem;line-height:1;padding:.1rem .35rem;color:var(--bleu-france);border-radius:6px}
  .chevron:hover{background:#eef2ff}
  .corps{margin-top:.25rem}
  table.hist{border-collapse:collapse;width:100%;font-size:.86rem;margin:.3rem 0 1rem}
  table.hist th,table.hist td{border:1px solid var(--gris-bord);padding:.3rem .5rem;text-align:left}
  table.hist thead th{background:#f4f6ff;position:sticky;top:0}
  table.hist td.num,table.hist th.num{text-align:right;font-variant-numeric:tabular-nums}
  table.hist tbody tr:nth-child(even){background:#fafbff}
  table.hist .tri{background:none;border:0;font:inherit;font-weight:700;cursor:pointer;color:var(--texte);padding:0;text-align:left;width:100%}
  table.hist .tri:hover{text-decoration:underline}
  table.hist .tri:focus-visible{outline:2px solid var(--bleu-france);outline-offset:2px}
  table.hist code{font-size:.8rem}
  .conf-e{color:#0a6b2e}.conf-m{color:#8a6d00}.conf-f{color:#a10b0b}
  .admin-form{display:flex;flex-direction:column;gap:.7rem;max-width:680px}
  .admin-form label{display:flex;flex-direction:column;gap:.25rem;font-weight:600}
  .admin-form input,.admin-form textarea{font:inherit;padding:.4rem .5rem;border:1px solid var(--gris-bord);border-radius:var(--rayon);width:100%}
  .apercu-corps{white-space:pre-wrap;background:#f6f8ff;border:1px solid var(--gris-bord);border-radius:var(--rayon);padding:.5rem;font-size:.85rem}
  .modale-fond{position:fixed;inset:0;background:rgba(20,25,40,.45);display:flex;align-items:center;justify-content:center;padding:1rem;z-index:1000}
  .modale{background:#fff;border-radius:10px;padding:1rem 1.2rem;max-width:680px;width:100%;max-height:90vh;overflow:auto;box-shadow:0 10px 40px rgba(0,0,0,.3)}
  .modale label{display:flex;flex-direction:column;gap:.25rem;font-weight:600;margin:.5rem 0}
  .modale input,.modale textarea{font:inherit;padding:.4rem .5rem;border:1px solid var(--gris-bord);border-radius:var(--rayon);width:100%}
  .arbre{list-style:none;padding-left:0}
  .arbre>li{margin:.4rem 0;padding-left:.2rem}
  .arbre ul{list-style:none;padding-left:1.1rem;border-left:2px solid var(--gris-bord);margin:.3rem 0}
  .arbre-champ{padding:.2rem 0}
  .arbre-sugg{padding:.4rem .5rem;border:1px solid var(--gris-bord);border-radius:var(--rayon);margin:.35rem 0}
  .arbre-sugg.cible{outline:3px solid var(--bleu-france);background:#eef2ff}
  .sugg-texte{font-size:.86rem;margin:.3rem 0}
  .bascule{display:flex;align-items:flex-start;gap:.5rem;font-weight:600}
  .bascule input{margin-top:.2rem}
  .num-intitule{color:var(--bleu-france);font-weight:700}
  table.dico{border-collapse:collapse;width:100%;font-size:.86rem;margin:.3rem 0 1rem}
  table.dico th,table.dico td{border:1px solid var(--gris-bord);padding:.35rem .5rem;text-align:left;vertical-align:top}
  table.dico thead th{background:#f4f6ff;position:sticky;top:0}
  table.dico td.num,table.dico th.num{text-align:right;font-variant-numeric:tabular-nums;white-space:nowrap}
  table.dico tbody tr:nth-child(even){background:#fafbff}
  table.dico tr.cible{outline:3px solid var(--bleu-france);background:#eef2ff}
  input.ord{width:4.5rem;font:inherit;padding:.2rem .3rem;border:1px solid var(--gris-bord);border-radius:var(--rayon);text-align:right}
  table.dico input.cat{width:9rem;font:inherit;padding:.2rem .3rem;border:1px solid var(--gris-bord);border-radius:var(--rayon)}
  table.dico input.intitule{width:100%;min-width:11rem;font:inherit;padding:.2rem .3rem;border:1px solid var(--gris-bord);border-radius:var(--rayon)}
  table.dico input.titre-prop{width:100%;min-width:11rem;font:inherit;padding:.2rem .3rem;border:1px solid var(--gris-bord);border-radius:var(--rayon)}
  .lien-nombre{background:none;border:0;font:inherit;color:var(--bleu-france);cursor:pointer;padding:0;text-decoration:underline;font-variant-numeric:tabular-nums}
  .lien-nombre:hover{text-decoration:none}
  .lien-nombre:focus-visible{outline:2px solid var(--bleu-france);outline-offset:2px}
  table.dico .tri{background:none;border:0;font:inherit;font-weight:700;cursor:pointer;color:var(--texte);padding:0;text-align:left;width:100%}
  table.dico .tri:hover{text-decoration:underline}
  table.dico .tri:focus-visible{outline:2px solid var(--bleu-france);outline-offset:2px}
  ul.dico-sugg{list-style:none;padding-left:0;margin:0}
  ul.dico-sugg li{margin:.2rem 0}
  .dico-action{background:#f6f8ff;border:1px solid var(--gris-bord);border-radius:var(--rayon);padding:.5rem .7rem;font-size:.9rem}
</style>

</head>
<body>
<a class="skip" href="#principal">Aller au contenu principal</a>
<div id="app">
  <header role="banner">
    <span class="titre">Reprise DEX → CAST'IN</span>
    <span class="pastille"><span class="point" :class="backOk?'ok':'ko'"></span>
      Service : {{ backOk ? 'connecté' : 'déconnecté' }}<span v-if="health"> · règles {{ health.rules_version }}</span></span>
    <span class="sep"></span>
    <label class="champ-role" for="role">Rôle opérateur
      <select id="role" v-model="role">
        <option value="rodage">Rodage (développeur confirmé)</option>
        <option value="production">Production</option>
      </select>
    </label>
  </header>

  <main id="principal">
    <nav aria-label="Sections de l'outil">
      <div role="tablist" aria-label="Sections">
        <button role="tab" id="tab-reprise" :aria-selected="onglet==='reprise'" :tabindex="onglet==='reprise'?0:-1"
                aria-controls="panneau-reprise" @click="onglet='reprise'" @keydown="navOnglets($event)">Reprise assistée</button>
        <button role="tab" id="tab-dico" :aria-selected="onglet==='dictionnaire'" :tabindex="onglet==='dictionnaire'?0:-1"
                aria-controls="panneau-dico" @click="allerDictionnaire()" @keydown="navOnglets($event)">Dictionnaire</button>
        <button role="tab" id="tab-dash" :aria-selected="onglet==='dashboard'" :tabindex="onglet==='dashboard'?0:-1"
                aria-controls="panneau-dash" @click="allerDashboard()" @keydown="navOnglets($event)">Tableau de bord</button>
        <button role="tab" id="tab-hist" :aria-selected="onglet==='historique'" :tabindex="onglet==='historique'?0:-1"
                aria-controls="panneau-hist" @click="allerHistorique()" @keydown="navOnglets($event)">Historique</button>
        <button role="tab" id="tab-admin" :aria-selected="onglet==='admin'" :tabindex="onglet==='admin'?0:-1"
                aria-controls="panneau-admin" @click="allerAdmin()" @keydown="navOnglets($event)">Administration</button>
      </div>
    </nav>

    <p class="statut" role="status" aria-live="polite"><span class="ok" v-if="statut">{{ statut }}</span></p>
    <p class="statut" role="alert" aria-live="assertive" v-if="erreur"><span class="alerte-boite">{{ erreur }}</span></p>

    <!-- ====================== ONGLET REPRISE ====================== -->
    <section role="tabpanel" id="panneau-reprise" aria-labelledby="tab-reprise" v-show="onglet==='reprise'">
      <div class="barre-chargement">
        <div class="bloc">
          <label for="fichier"><strong>Charger un DEX (.docx)</strong></label>
          <input id="fichier" type="file" accept=".docx" @change="surFichier($event)">
        </div>
        <div class="bloc">
          <label for="dossier"><strong>…ou un dossier de DEX (traitement par lot)</strong></label>
          <input id="dossier" type="file" webkitdirectory directory multiple @change="surDossier($event)" :disabled="chargement">
        </div>
        <div class="zone-depot" @dragover.prevent @drop.prevent="surDepot($event)" aria-hidden="true">
          Glisser-déposer un .docx ici
        </div>
      </div>
      <p v-if="lot" class="muet" role="status" style="margin:.3rem 0">
        Lot : {{ lot.fait }}/{{ lot.total }} traité(s) — {{ lot.ok }} ✓, {{ lot.ko }} échec(s).
        <span v-if="lot.erreurs && lot.erreurs.length"> ({{ lot.erreurs.join(' ; ') }})</span>
      </p>

      <div v-if="resultat" class="espace" style="margin-top:1rem">
        <!-- Colonne champs -->
        <div class="colonne" aria-labelledby="t-champs">
          <h2 id="t-champs">Champs CAST'IN</h2>
          <dl class="ident">
            <dt>Solution</dt><dd>{{ resultat.identification.solution || 'Non concerné' }}</dd>
            <dt>Auteur</dt><dd>{{ resultat.identification.auteur || 'Non concerné' }}</dd>
            <dt>Responsable</dt><dd>{{ resultat.identification.responsable || 'Non concerné' }}</dd>
            <dt>Signature de gabarit</dt><dd>{{ resultat.gabarit_signature }}</dd>
          </dl>

          <div class="doc-outils">
            <button class="secondaire" @click="replierTout(true)">Tout replier</button>
            <button class="secondaire" @click="replierTout(false)">Tout déplier</button>
          </div>
          <template v-for="key in ordreKeys" :key="key">
            <div class="carte"
                 :class="{active:selection===key}"
                 :style="styleCarte(key)">
              <div class="entete">
                <button class="chevron" @click="basculerCarte(key)"
                        :aria-expanded="!replie[key]" :aria-controls="'corps-'+key"
                        :aria-label="(replie[key]?'Déplier':'Replier')+' '+labelCarte(key)">{{ replie[key] ? '▸' : '▾' }}</button>
                <span class="pal" v-if="!pastilleConfCouleur" :style="{background:couleurs[key].bord}" aria-hidden="true"></span>
                <button class="lib" @click="selectionner(key)"
                        :aria-pressed="selection===key"><span class="num-intitule">{{ numeros[key] }}.</span> {{ labelCarte(key) }}</button>
                <span class="etiq">{{ tabCarte(key) }}</span>
                <span class="conf"
                      :class="pastilleConfCouleur ? '' : classeConf(resultat.champs[key].confiance)"
                      :style="pastilleConfCouleur ? {background:couleurs[key].bord, color:couleurs[key].txt, borderColor:couleurs[key].bord} : null">
                  {{ libelleConf(resultat.champs[key].confiance) }}</span>
                <span v-if="resultat.champs[key].route_attention" class="conf faible"
                      title="Routé en Points à vérifier par le seuil de confiance">⚠ à vérifier</span>
                <span v-if="resultat.champs[key].ambigu" class="conf faible"
                      title="Plusieurs sections candidates — choisir la bonne section">⚐ ambigu</span>
              </div>
              <div class="corps" v-show="!replie[key]" :id="'corps-'+key">
              <div class="jauge" v-if="resultat.champs[key].confiance!=null" aria-hidden="true">
                <span :style="{width:(resultat.champs[key].confiance*100)+'%'}"></span>
              </div>
              <p class="raison">{{ resultat.champs[key].raison }}</p>
              <label class="vh" :for="'c-'+key">Contenu prêt à coller — {{ resultat.champs[key].label }}</label>
              <textarea class="contenu" :id="'c-'+key" readonly rows="2"
                        :value="resultat.champs[key].kind==='empty' ? '(laisser vide)' : (contenuAffiche(key) || 'Non concerné')"></textarea>

              <fieldset class="candidats" v-if="resultat.champs[key].kind==='text' && resultat.champs[key].candidats.length>=2">
                <legend>Section source — {{ resultat.champs[key].candidats.length }} candidates
                  <span v-if="resultat.champs[key].ambigu" class="conf faible">ambigu</span></legend>
                <label v-for="c in resultat.champs[key].candidats" :key="c.index" class="cand-opt"
                       :class="{actif:(choix[key]?choix[key].index:resultat.champs[key].selection_moteur)===c.index}">
                  <input type="radio" :name="'cand-'+key" :value="c.index"
                         :checked="(choix[key]?choix[key].index:resultat.champs[key].selection_moteur)===c.index"
                         @change="choisirCandidat(key,c)">
                  <span class="cand-titre">{{ c.titre }}
                    <span class="muet" style="font-weight:400">— score {{ c.score }}<template v-if="c.index===resultat.champs[key].selection_moteur"> · section moteur</template></span>
                  </span>
                  <span class="cand-extrait">{{ c.extrait || '(section vide)' }}</span>
                </label>
                <p v-if="choixDiffere(key)" class="muet">Section choisie ≠ section moteur → enregistrée comme <strong>mauvaise_section</strong> (avec correction).</p>
              </fieldset>
              <details class="candidats-info" v-else-if="resultat.champs[key].candidats.length>=2">
                <summary>{{ resultat.champs[key].candidats.length }} sections détectées (agrégées par le moteur)</summary>
                <ul><li v-for="c in resultat.champs[key].candidats" :key="c.index"><strong>{{ c.titre }}</strong> — {{ c.extrait || '(vide)' }}</li></ul>
              </details>

              <div class="suggestions" v-if="resultat.champs[key].suggestions && resultat.champs[key].suggestions.length">
                <span class="muet">Suggestions :</span>
                <button class="puce" v-for="(s,si) in resultat.champs[key].suggestions" :key="s.index"
                        @click="allerLigneDico(key,si)"
                        :title="'Voir cette suggestion dans le Dictionnaire'">{{ s.titre }} ({{ s.score }})</button>
              </div>

              <div class="actions" v-if="resultat.champs[key].kind!=='empty'">
                <button class="secondaire" @click="copier(key)"
                        :aria-label="'Copier le contenu du champ '+resultat.champs[key].label">Copier</button>
                <template v-if="choixDiffere(key)">
                  <button @click="confirmerSection(key)">Confirmer la section choisie</button>
                  <button class="discret" @click="reinitChoix(key)">↺ section moteur</button>
                </template>
                <template v-else>
                  <button class="discret" @click="valider(key,'accepte')">Accepter</button>
                  <button class="discret" @click="ouvrirSignalement(key)">Signaler…</button>
                </template>
                <span class="valide-ok" v-if="etat(key).envoye==='accepte'" role="status">✓ accepté</span>
                <span class="valide-sig" v-if="etat(key).envoye==='signale'" role="status">⚑ signalé ({{ etat(key).type }})</span>
              </div>

              <div class="form-signal" v-if="etat(key).formulaire">
                <label :for="'ty-'+key">Type
                  <select :id="'ty-'+key" v-model="etat(key).type">
                    <option v-for="t in taxonomie" :key="t.v" :value="t.v">{{ t.l }}</option>
                  </select>
                </label>
                <label :for="'co-'+key" style="flex:1;min-width:160px">Correction (facultatif)
                  <input :id="'co-'+key" type="text" v-model="etat(key).correction" placeholder="ex. section attendue, passage…">
                </label>
                <button @click="envoyerSignalement(key)">Envoyer le signalement</button>
                <button class="discret" @click="etat(key).formulaire=false">Annuler</button>
              </div>
              </div><!-- /corps -->
            </div>
          </template>

          <h3>Points à vérifier auprès de l'Équipier Ops</h3>
          <ul v-if="resultat.points_a_verifier.length"><li v-for="(p,i) in resultat.points_a_verifier" :key="i">{{ p }}</li></ul>
          <p v-else class="muet">RAS</p>
        </div>

        <!-- Colonne document annoté -->
        <div class="colonne" aria-labelledby="t-doc">
          <h2 id="t-doc">Document annoté</h2>
          <div class="doc-outils">
            <label><input type="checkbox" v-model="toutAnnoter"> Afficher tous les surlignages</label>
            <span class="muet" v-if="selection">Champ sélectionné : <strong>{{ resultat.champs[selection].label }}</strong></span>
          </div>
          <div class="legende" v-if="legende.length">
            <span class="item" v-for="l in legende" :key="l.key">
              <span class="pal" :style="{background:l.coul}"></span>{{ resultat.champs[l.key].label }}</span>
          </div>
          <div>
            <div v-for="d in resultat.document" :key="d.index" :id="'p-'+d.index"
                 class="para"
                 :class="{titre:d.is_heading, explicatif:d.is_explanatory, surligne: surlignage(d.index).actif}"
                 :style="surlignage(d.index).style">
              <span class="badge-fleche" v-for="(lab,li) in surlignage(d.index).labels" :key="li">⟶ {{ lab }}</span>
              {{ d.text || '·' }}
            </div>
          </div>
        </div>
      </div>
      <p v-else class="muet" style="margin-top:1rem">Aucun DEX chargé. Choisissez un fichier .docx ou un dossier de DEX (lot).</p>
    </section>

    <!-- ====================== ONGLET TABLEAU DE BORD ====================== -->
    <section role="tabpanel" id="panneau-dash" aria-labelledby="tab-dash" v-show="onglet==='dashboard'">
      <div class="panneau">
        <div style="display:flex;align-items:center;gap:1rem;flex-wrap:wrap">
          <h2 style="margin:0">Calibration et qualité</h2>
          <span v-if="metriques && metriques.calibration && metriques.calibration.actif" class="conf elevee"
            title="Carte isotonique active (versionnée)">Calibration active · v{{ metriques.calibration.rules_version }}
            <template v-if="metriques.calibration.seuil_routage>0"> · seuil routage {{ metriques.calibration.seuil_routage }}</template></span>
          <span v-else-if="metriques" class="conf na">Calibration inactive</span>
          <button class="secondaire" @click="chargerMetriques()">Rafraîchir</button>
          <label for="ece">Cible ECE (ajustable)
            <input id="ece" type="text" inputmode="decimal" v-model="cibleEceInput" style="width:5rem">
          </label>
          <button class="discret" @click="enregistrerCible()">Enregistrer la cible</button>
        </div>

        <div v-if="metriques">
          <div class="cartes-kpi">
            <div class="kpi"><div class="v">{{ metriques.n_evenements }}</div><div class="l">Validations enregistrées</div></div>
            <div class="kpi"><div class="v">{{ fmt(metriques.brier_global) }}</div><div class="l">Score de Brier (plus bas = mieux)</div></div>
            <div class="kpi" :class="classeEce">
              <div class="v">{{ fmt(metriques.ece) }}</div><div class="l">ECE calibré (cible {{ metriques.cible_ece }})</div></div>
            <div class="kpi"><div class="v">{{ fmt(metriques.ece_brut) }} → {{ fmt(metriques.ece) }}</div>
              <div class="l">ECE brut → calibré<span v-if="metriques.amelioration_ece!=null"> ({{ metriques.amelioration_ece>=0?'−':'+' }}{{ Math.abs(metriques.amelioration_ece) }})</span></div></div>
            <div class="kpi"><div class="v">{{ metriques.debit.median_s!=null ? metriques.debit.median_s+' s' : '—' }}</div><div class="l">Débit médian / DEX</div></div>
          </div>

          <h3>Alertes</h3>
          <ul class="alertes" v-if="metriques.alertes.length"><li v-for="(a,i) in metriques.alertes" :key="i">{{ a }}</li></ul>
          <p v-else class="muet">Aucune alerte.</p>

          <h3>Acceptation par champ</h3>
          <table>
            <caption>Taux d'acceptation et Brier, par champ CAST'IN (verdicts humains).</caption>
            <thead><tr><th scope="col">Champ</th><th scope="col">n</th><th scope="col">Acceptation</th><th scope="col">Brier</th></tr></thead>
            <tbody>
              <tr v-for="(m,champ) in metriques.par_champ" :key="champ">
                <td>{{ champ }}</td><td>{{ m.n }}</td>
                <td>{{ m.acceptation!=null ? Math.round(m.acceptation*100)+' %' : '—' }}</td>
                <td>{{ fmt(m.brier) }}</td>
              </tr>
              <tr v-if="!Object.keys(metriques.par_champ).length"><td colspan="4" class="muet">Aucune donnée.</td></tr>
            </tbody>
          </table>

          <h3>Diagramme de fiabilité</h3>
          <svg viewBox="0 0 320 200" width="320" height="200" role="img"
               aria-label="Diagramme de fiabilité : acceptation observée par tranche de confiance, comparée à la diagonale de calibration parfaite.">
            <line x1="40" y1="170" x2="300" y2="170" stroke="#999"></line>
            <line x1="40" y1="10" x2="40" y2="170" stroke="#999"></line>
            <line x1="40" y1="170" x2="300" y2="10" stroke="#bbb" stroke-dasharray="4 3"></line>
            <template v-for="(b,i) in metriques.fiabilite" :key="i">
              <rect v-if="b.n" :x="40 + i*26 + 4" :y="170 - (b.acceptation*160)" width="18"
                    :height="b.acceptation*160" :fill="b.acceptation>=b.confiance? '#18753c':'#b34000'"></rect>
            </template>
          </svg>
          <table>
            <caption class="vh">Données du diagramme de fiabilité</caption>
            <thead><tr><th scope="col">Tranche confiance</th><th scope="col">n</th><th scope="col">Confiance moy.</th><th scope="col">Acceptation</th></tr></thead>
            <tbody>
              <tr v-for="(b,i) in metriques.fiabilite" :key="i" v-show="b.n">
                <td>{{ b.bin[0] }} – {{ b.bin[1] }}</td><td>{{ b.n }}</td>
                <td>{{ b.confiance }}</td><td>{{ b.acceptation }}</td>
              </tr>
            </tbody>
          </table>
        </div>
        <p v-else class="muet">Aucune métrique pour l'instant. Validez des champs dans l'onglet « Reprise assistée ».</p>
      </div>

      <div class="panneau">
        <h2>Calibration isotonique</h2>
        <p class="muet">Ajuste une carte monotone <em>score brut → acceptation</em> à partir des verdicts.
          La carte est <strong>candidate</strong> : elle n'est pas activée ici. Après le gate
          (<code>calibration_check.py</code> + harness), copier <code>regles.candidate.json</code> →
          <code>regles.json</code> et recharger.</p>
        <div style="display:flex;gap:.6rem;flex-wrap:wrap;align-items:center">
          <button class="secondaire" @click="analyserCalibration()">Analyser la calibration</button>
          <button @click="proposerCalibration()" :disabled="!calibrationAnalyse || !calibrationAnalyse.suffisant">
            Écrire regles.candidate.json</button>
        </div>
        <div v-if="calibrationAnalyse" style="margin-top:.7rem">
          <p v-if="!calibrationAnalyse.suffisant" class="muet">{{ calibrationAnalyse.message }}</p>
          <div v-else>
            <div class="cartes-kpi">
              <div class="kpi"><div class="v">{{ calibrationAnalyse.n }}</div><div class="l">Verdicts exploités</div></div>
              <div class="kpi" :class="(calibrationAnalyse.gain||0)>=0?'bon':'mauvais'">
                <div class="v">{{ fmt(calibrationAnalyse.ece_brut) }} → {{ fmt(calibrationAnalyse.ece_estime) }}</div>
                <div class="l">ECE brut → estimé (in-sample)</div></div>
              <div class="kpi"><div class="v">v{{ calibrationAnalyse.version_proposee }}</div><div class="l">Version proposée</div></div>
            </div>
            <p class="muet">Champs calibrés individuellement :
              <span v-if="calibrationAnalyse.champs_calibres.length">{{ calibrationAnalyse.champs_calibres.join(', ') }}</span>
              <span v-else>aucun (volume par champ insuffisant ; carte par défaut appliquée)</span>.</p>
            <details>
              <summary>Carte par défaut ({{ calibrationAnalyse.par_defaut.length }} points)</summary>
              <p class="muet" style="font-family:monospace">{{ JSON.stringify(calibrationAnalyse.par_defaut) }}</p>
            </details>
          </div>
        </div>
        <p class="statut" role="status" aria-live="polite" v-if="calibrationStatut">{{ calibrationStatut }}</p>
      </div>

      <div class="panneau">
        <h2>Replay — mesurer l'amélioration après modification</h2>
        <p class="muet">Après un patch de règles (édition de <code>regles.json</code> + rechargement),
          rejouez le DEX courant pour comparer au dernier instantané.</p>
        <div style="display:flex;gap:.6rem;flex-wrap:wrap;align-items:center">
          <button @click="rejouer()" :disabled="!resultat">Rejouer le DEX courant</button>
          <button class="discret" @click="rechargerRegles()">Recharger les règles (regles.json)</button>
          <span class="muet" v-if="!resultat">Chargez d'abord un DEX dans l'onglet « Reprise ».</span>
        </div>

        <div v-if="replay" style="margin-top:.8rem">
          <p><strong>Version</strong> : {{ replay.version_avant || '—' }} → {{ replay.version_apres }} ·
             <strong>Points</strong> : {{ replay.n_points_avant }} → {{ replay.n_points_apres }}
             <span v-if="!replay.a_un_instantane_precedent" class="muet">(pas d'instantané précédent)</span></p>
          <h3>Champs modifiés ({{ replay.champs_modifies.length }})</h3>
          <div v-for="m in replay.champs_modifies" :key="m.champ" class="replay-modif">
            <strong>{{ m.label }}</strong> — confiance {{ fmt(m.avant.confiance) }} → {{ fmt(m.apres.confiance) }}
            <div v-if="m.avant.content!==m.apres.content">
              <del>{{ (m.avant.content||'∅').slice(0,160) }}</del><br><ins>{{ (m.apres.content||'∅').slice(0,160) }}</ins>
            </div>
          </div>
          <p v-if="!replay.champs_modifies.length" class="muet">Aucun champ modifié.</p>
          <p v-if="replay.points_resolus.length"><strong class="valide-ok">Points résolus :</strong></p>
          <ul><li v-for="(p,i) in replay.points_resolus" :key="i">{{ p }}</li></ul>
          <p v-if="replay.points_nouveaux.length"><strong class="valide-sig">Points nouveaux :</strong></p>
          <ul><li v-for="(p,i) in replay.points_nouveaux" :key="i">{{ p }}</li></ul>
        </div>
      </div>
    </section>

    <!-- ====================== ONGLET HISTORIQUE ====================== -->
    <section role="tabpanel" id="panneau-hist" aria-labelledby="tab-hist" v-show="onglet==='historique'">
      <div class="doc-outils">
        <button class="secondaire" @click="chargerHistorique()">Rafraîchir</button>
        <span class="muet" v-if="historique">{{ historique.total }} DEX analysé(s) sur ce poste</span>
      </div>

      <p v-if="!historique || !historique.total" class="muet">Aucune analyse enregistrée pour l'instant. Les DEX traités dans l'onglet « Reprise assistée » apparaîtront ici.</p>

      <template v-if="historique && historique.total">
        <h2>Détail des DEX analysés</h2>
        <table class="hist">
          <caption class="vh">Liste des DEX analysés. Triable sur chaque en-tête.</caption>
          <thead><tr>
            <th scope="col" :aria-sort="ariaSortH('horodatage')"><button class="tri" @click="trierHist('horodatage')">Heure{{ flecheH('horodatage') }}</button></th>
            <th scope="col" :aria-sort="ariaSortH('nom')"><button class="tri" @click="trierHist('nom')">Nom{{ flecheH('nom') }}</button></th>
            <th scope="col" :aria-sort="ariaSortH('dex_id')"><button class="tri" @click="trierHist('dex_id')">DEX{{ flecheH('dex_id') }}</button></th>
            <th scope="col" :aria-sort="ariaSortH('gabarit')"><button class="tri" @click="trierHist('gabarit')">Gabarit{{ flecheH('gabarit') }}</button></th>
            <th scope="col" class="num" :aria-sort="ariaSortH('abouti')"><button class="tri" @click="trierHist('abouti')">Abouti{{ flecheH('abouti') }}</button></th>
            <th scope="col" class="num conf-e" :aria-sort="ariaSortH('elevee')"><button class="tri" @click="trierHist('elevee')">élevée{{ flecheH('elevee') }}</button></th>
            <th scope="col" class="num conf-m" :aria-sort="ariaSortH('moyenne')"><button class="tri" @click="trierHist('moyenne')">moyenne{{ flecheH('moyenne') }}</button></th>
            <th scope="col" class="num conf-f" :aria-sort="ariaSortH('faible')"><button class="tri" @click="trierHist('faible')">faible{{ flecheH('faible') }}</button></th>
            <th scope="col" class="num" :aria-sort="ariaSortH('vide')"><button class="tri" @click="trierHist('vide')">(vide){{ flecheH('vide') }}</button></th>
            <th scope="col" class="num" :aria-sort="ariaSortH('ambigu')"><button class="tri" @click="trierHist('ambigu')">⚐ ambigus{{ flecheH('ambigu') }}</button></th>
            <th scope="col" class="num" :aria-sort="ariaSortH('points')"><button class="tri" @click="trierHist('points')">points{{ flecheH('points') }}</button></th>
            <th scope="col" :aria-sort="ariaSortH('regles')"><button class="tri" @click="trierHist('regles')">règles{{ flecheH('regles') }}</button></th>
          </tr></thead>
          <tbody>
            <tr v-for="a in analysesTriees" :key="a.id">
              <td>{{ horodatageLisible(a.horodatage) }}</td>
              <td>{{ a.nom || '—' }}</td>
              <td>{{ a.dex_id }}</td>
              <td><code>{{ a.gabarit_signature }}</code></td>
              <td class="num"><button v-if="a.n_abouti" class="lien-nombre" @click="ouvrirEtFiltrer(a,'abouti')" title="Ouvrir ce DEX et déplier ce groupe">{{ a.n_abouti }}</button><span v-else class="muet">{{ a.n_abouti==null ? '—' : 0 }}</span></td>
              <td class="num conf-e"><button v-if="a.conf.elevee" class="lien-nombre" @click="ouvrirEtFiltrer(a,'elevee')" title="Ouvrir ce DEX et déplier ce groupe">{{ a.conf.elevee }}</button><span v-else class="muet">0</span></td>
              <td class="num conf-m"><button v-if="a.conf.moyenne" class="lien-nombre" @click="ouvrirEtFiltrer(a,'moyenne')" title="Ouvrir ce DEX et déplier ce groupe">{{ a.conf.moyenne }}</button><span v-else class="muet">0</span></td>
              <td class="num conf-f"><button v-if="a.conf.faible" class="lien-nombre" @click="ouvrirEtFiltrer(a,'faible')" title="Ouvrir ce DEX et déplier ce groupe">{{ a.conf.faible }}</button><span v-else class="muet">0</span></td>
              <td class="num"><button v-if="a.conf.vide" class="lien-nombre" @click="ouvrirEtFiltrer(a,'vide')" title="Ouvrir ce DEX et déplier ce groupe">{{ a.conf.vide }}</button><span v-else class="muet">0</span></td>
              <td class="num"><button v-if="a.n_ambigu" class="lien-nombre" @click="ouvrirEtFiltrer(a,'ambigu')" title="Ouvrir ce DEX et déplier ce groupe">{{ a.n_ambigu }}</button><span v-else class="muet">0</span></td>
              <td class="num">{{ a.n_points }}</td>
              <td>{{ a.rules_version }}</td>
            </tr>
          </tbody>
        </table>
      </template>
    </section>

    <!-- ====================== ONGLET ADMINISTRATION ====================== -->
    <section role="tabpanel" id="panneau-admin" aria-labelledby="tab-admin" v-show="onglet==='admin'">
      <h2>Administration — signalement par e-mail</h2>
      <p class="muet">Valeurs par défaut du brouillon ouvert par « Signaler ». Elles sont enregistrées sur le poste (configuration locale) et peuvent être modifiées au cas par cas avant l'envoi.</p>
      <div class="admin-form">
        <label for="adm-adr">Destinataire(s) <span class="muet">— une ou plusieurs adresses séparées par « ; »</span>
          <input id="adm-adr" type="text" v-model="adminEmail.adresses" placeholder="prenom.nom@mail.fr ; equipe@mail.fr">
        </label>
        <label for="adm-obj">Objet (préfixe) <span class="muet">— l'objet final = ce préfixe + le type de signalement</span>
          <input id="adm-obj" type="text" v-model="adminEmail.objet_prefixe" placeholder="Castin ; ">
        </label>
        <label for="adm-int">Contenu (introduction) <span class="muet">— précède le contenu de la carte signalée (peut rester vide)</span>
          <textarea id="adm-int" rows="2" v-model="adminEmail.contenu_prefixe" placeholder="(facultatif)"></textarea>
        </label>
        <label for="adm-suf">Suffixe (salutation) <span class="muet">— ajouté en fin de corps</span>
          <textarea id="adm-suf" rows="2" v-model="adminEmail.suffixe" placeholder="Cordialement,"></textarea>
        </label>
        <div class="doc-outils">
          <button @click="enregistrerAdmin()">Enregistrer</button>
          <button class="discret" @click="reinitAdmin()">Rétablir les valeurs par défaut</button>
          <span class="valide-ok" v-if="adminEnregistre" role="status">✓ enregistré</span>
        </div>
        <details>
          <summary>Aperçu de l'objet/corps générés</summary>
          <p><strong>Objet :</strong> <code>{{ adminEmail.objet_prefixe }}&lt;type&gt;</code></p>
          <p><strong>Corps :</strong></p>
          <pre class="apercu-corps">{{ apercuCorps }}</pre>
        </details>
      </div>

      <h2>Affichage</h2>
      <div class="admin-form">
        <label class="bascule">
          <input type="checkbox" v-model="pastilleConfCouleur" @change="enregistrerPastille()">
          La pastille de confiance prend la <strong>couleur du champ</strong> <span class="muet">(au lieu de vert / orange / rouge ; le niveau reste lisible par le libellé et la jauge)</span>
        </label>
        <p class="muet">« On » (défaut) : la pastille de chaque carte reprend la couleur du champ — même repère visuel que la légende et les cadres du document. « Off » : la pastille reprend un code vert / orange / rouge selon le niveau de confiance, et une pastille de couleur séparée assure le suivi.</p>
      </div>
    </section>

    <!-- ====================== ONGLET DICTIONNAIRE ====================== -->
    <section role="tabpanel" id="panneau-dico" aria-labelledby="tab-dico" v-show="onglet==='dictionnaire'">
      <h2>Dictionnaire des intitulés</h2>
      <p class="muet">Tableau des intitulés (cartes) : règle l'<strong>ordre d'affichage</strong> des cartes de « Reprise assistée » et donne, pour chaque intitulé, son numéro, son terme, son statut de repérage et les suggestions proposées. Depuis « Reprise assistée », cliquer une suggestion amène à la ligne correspondante.</p>
      <p v-if="!resultat" class="muet">Traitez un DEX dans « Reprise assistée » pour alimenter le dictionnaire.</p>
      <template v-else>
        <p class="dico-action"><strong>« Appliquer cette section »</strong> remplace le contenu du champ par celui de cette section et l'encadre dans le document ; à la confirmation, l'écart est journalisé (<code>section_introuvable</code> ou <code>mauvaise_section</code>) pour enrichir le lexique.</p>
        <div class="doc-outils">
          <button class="secondaire" @click="enregistrerOrdre()">Enregistrer l'ordre</button>
          <button class="discret" @click="reinitOrdre()">Rétablir l'ordre par défaut</button>
          <span class="valide-ok" v-if="ordreEnregistre" role="status">✓ ordre enregistré</span>
        </div>
        <table class="dico">
          <caption class="vh">Dictionnaire des intitulés : ordre d'affichage, numéro, intitulé, repérage, titre proposé, proximité. Triable sur chaque en-tête.</caption>
          <thead><tr>
            <th scope="col" class="num" :aria-sort="ariaSort('ordre')"><button class="tri" @click="trierDico('ordre')">Ordre{{ flecheTri('ordre') }}</button></th>
            <th scope="col" class="num" :aria-sort="ariaSort('numero')"><button class="tri" @click="trierDico('numero')">N°{{ flecheTri('numero') }}</button></th>
            <th scope="col" :aria-sort="ariaSort('tab')"><button class="tri" @click="trierDico('tab')">Catégorie{{ flecheTri('tab') }}</button></th>
            <th scope="col" :aria-sort="ariaSort('label')"><button class="tri" @click="trierDico('label')">Intitulé{{ flecheTri('label') }}</button></th>
            <th scope="col" :aria-sort="ariaSort('repere')"><button class="tri" @click="trierDico('repere')">Repérage{{ flecheTri('repere') }}</button></th>
            <th scope="col" :aria-sort="ariaSort('titre')"><button class="tri" @click="trierDico('titre')">Titre proposé{{ flecheTri('titre') }}</button></th>
            <th scope="col" class="num" :aria-sort="ariaSort('score')"><button class="tri" @click="trierDico('score')">Proximité{{ flecheTri('score') }}</button></th>
            <th scope="col">Action</th>
          </tr></thead>
          <tbody>
            <tr v-for="r in dictionnaireTriee" :key="r.key+'-'+r.idx" :id="'dico-'+r.key+'-'+r.idx" :class="{cible: suggCible===r.key+'-'+r.idx}">
              <td class="num">
                <label class="vh" :for="'ord-'+r.key+'-'+r.idx">Ordre d'affichage de {{ r.label }}</label>
                <input class="ord" type="number" min="1" :id="'ord-'+r.key+'-'+r.idx"
                       :value="r.ordre" @change="majOrdre(r.key,$event.target.value); enregistrerOrdre()">
              </td>
              <td class="num">{{ r.numero }}</td>
              <td>
                <label class="vh" :for="'cat-'+r.key+'-'+r.idx">Catégorie de {{ r.label }}</label>
                <input class="cat" type="text" :id="'cat-'+r.key+'-'+r.idx"
                       :value="r.tab" @change="majIntitule(r.key,{tab:$event.target.value}); enregistrerIntitules()">
              </td>
              <td>
                <label class="vh" :for="'int-'+r.key+'-'+r.idx">Intitulé de {{ r.label }}</label>
                <input class="intitule" type="text" :id="'int-'+r.key+'-'+r.idx"
                       :value="r.label" @change="majIntitule(r.key,{label:$event.target.value}); enregistrerIntitules()">
              </td>
              <td class="muet">{{ r.repere }}</td>
              <td>
                <template v-if="r.sugg">
                  <label class="vh" :for="'tit-'+r.key+'-'+r.idx">Titre proposé pour {{ r.label }}</label>
                  <input class="titre-prop" type="text" :id="'tit-'+r.key+'-'+r.idx"
                         :value="r.titreVue" @change="majTitre(r.key,r.titre,$event.target.value); enregistrerTitres()">
                </template>
                <span v-else class="muet">—</span>
              </td>
              <td class="num">{{ r.score==null ? '—' : r.score }}</td>
              <td>
                <template v-if="r.sugg">
                  <button class="puce" v-if="r.kind==='text' && r.contenu!=null" @click="appliquerDepuisSuggestion(r.key,r.sugg)">Appliquer</button>
                  <button class="puce discret" @click="voirDansDocument(r.key,r.sugg)">Voir</button>
                </template>
                <span v-else class="muet">—</span>
              </td>
            </tr>
          </tbody>
        </table>
      </template>
    </section>
  </main>

  <!-- ====================== APERÇU / VALIDATION DU MAIL ====================== -->
  <div class="modale-fond" v-if="mail" @click.self="annulerMail">
    <div class="modale" role="dialog" aria-modal="true" aria-labelledby="mail-titre" @keydown.esc="annulerMail">
      <h2 id="mail-titre">Signalement par e-mail — {{ mail.champLabel }}</h2>
      <p class="muet">Le signalement a été enregistré localement. Vérifiez/modifiez le message ci-dessous, puis envoyez (votre client de messagerie s'ouvrira). Le corps reprend toutes les infos de la carte. <strong>Astuce Outlook</strong> : pour un rendu mis en forme, utilisez « Copier la fiche en HTML » puis collez (Ctrl+V) dans le corps du message — le <code>mailto:</code> lui-même ne transmet que du texte.</p>
      <label for="mail-dest">Destinataire(s)
        <input id="mail-dest" type="text" v-model="mail.dest" ref="mailDest">
      </label>
      <label for="mail-obj">Objet
        <input id="mail-obj" type="text" v-model="mail.objet">
      </label>
      <label for="mail-corps">Corps du message (texte)
        <textarea id="mail-corps" rows="16" v-model="mail.corps"></textarea>
      </label>
      <div class="doc-outils">
        <button @click="envoyerMail()">Ouvrir dans la messagerie</button>
        <button class="secondaire" @click="copierFicheHtml()">Copier la fiche en HTML</button>
        <button class="discret" @click="annulerMail()">Annuler</button>
      </div>
    </div>
  </div>
</div>

<script src="./vue.global.prod.js"></script>
<script>
const { createApp } = Vue;
createApp({
  data(){ return {
    backOk:false, health:null, role:'rodage', onglet:'reprise',
    cheminInput:'', chargement:false, resultat:null, source:null,
    selection:null, toutAnnoter:true, etats:{}, choix:{}, replie:{}, historique:null, debutTs:null,
    adminEmail:{adresses:'fredgarcia@mail.fr', objet_prefixe:'Castin ; ', contenu_prefixe:'', suffixe:'Cordialement,'},
    adminEnregistre:false, mail:null, pastilleConfCouleur:true, suggCible:null, ordreCartes:{}, ordreEnregistre:false,
    dicoTri:{col:'ordre',sens:1}, intitulesCartes:{}, titresProposes:{}, histTri:{col:'horodatage',sens:-1},
    sourcesLot:{}, lot:null,
    statut:'', erreur:'',
    metriques:null, cibleEceInput:'', replay:null,
    calibrationAnalyse:null, calibrationStatut:'',
    taxonomie:[
      {v:'section_introuvable',l:'Section introuvable'},
      {v:'mauvaise_section',l:'Mauvaise section'},
      {v:'encart_repris',l:'Encart repris à tort'},
      {v:'contenu_ecarte',l:'Contenu écarté à tort'},
      {v:'lien_errone',l:'Lien erroné'},
      {v:'compose_mal_assemble',l:'Composé mal assemblé'},
      {v:'identification_erronee',l:'Identification erronée'},
      {v:'parasite_residuel',l:'Parasite résiduel'},
    ],
  };},
  computed:{
    couleurs(){
      const out={}; if(!this.resultat) return out;
      const ks=this.resultat.ordre_champs, n=ks.length||1;
      // luminance relative WCAG d'une couleur HSL -> choix d'un texte (#fff/#1a1a1a) à contraste sûr
      const lum=(h,s,l)=>{ s/=100; l/=100;
        const c=(1-Math.abs(2*l-1))*s, x=c*(1-Math.abs((h/60)%2-1)), m=l-c/2;
        let r,g,b;
        if(h<60){r=c;g=x;b=0;} else if(h<120){r=x;g=c;b=0;} else if(h<180){r=0;g=c;b=x;}
        else if(h<240){r=0;g=x;b=c;} else if(h<300){r=x;g=0;b=c;} else {r=c;g=0;b=x;}
        const lin=u=>{u+=m; return u<=0.03928? u/12.92 : Math.pow((u+0.055)/1.055,2.4);};
        return 0.2126*lin(r)+0.7152*lin(g)+0.0722*lin(b); };
      ks.forEach((k,i)=>{ const h=Math.round(i*360/n); const L=lum(h,60,42);
        const txt = (1.05/(L+0.05)) >= ((L+0.05)/0.05) ? '#fff' : '#1a1a1a';
        out[k]={bord:`hsl(${h} 60% 42%)`, fond:`hsl(${h} 82% 95%)`, txt}; });
      return out;
    },
    groupes(){
      if(!this.resultat) return [];
      const dd=[],dx=[];
      this.resultat.ordre_champs.forEach(k=>{ (this.resultat.champs[k].tab==='DEX'?dx:dd).push(k); });
      return [{tab:'Description détaillée',keys:dd},{tab:'DEX',keys:dx}];
    },
    legende(){
      if(!this.resultat) return [];
      const set = this.toutAnnoter ? this.resultat.ordre_champs : (this.selection?[this.selection]:[]);
      return set.filter(k=>this.spansAffiches(k).length)
                .map(k=>({key:k, coul:this.couleurs[k].bord}));
    },
    classeEce(){ if(!this.metriques||this.metriques.ece==null) return '';
      return this.metriques.ece<=this.metriques.cible_ece ? 'bon':'mauvais'; },
    apercuCorps(){ return [this.adminEmail.contenu_prefixe, '<contenu de la carte signalée>', this.adminEmail.suffixe]
        .filter(x=>x && String(x).trim()).join('\n\n'); },
    numeros(){ const out={}; if(!this.resultat) return out;
      this.resultat.ordre_champs.forEach((k,i)=>{ out[k]=i+1; }); return out; },
    ordreKeys(){ if(!this.resultat) return [];
      return this.resultat.ordre_champs
        .map((k,i)=>({k, num:i+1, ordre:(this.ordreCartes[k]!=null? Number(this.ordreCartes[k]) : i+1)}))
        .sort((a,b)=> (a.ordre-b.ordre) || (a.num-b.num))
        .map(x=>x.k); },
    dictionnaire(){
      if(!this.resultat) return [];
      const rows=[];
      this.resultat.ordre_champs.forEach((k,i)=>{
        const c=this.resultat.champs[k]; const sg=c.suggestions||[];
        const ordre=(this.ordreCartes[k]!=null? Number(this.ordreCartes[k]) : i+1);
        const commun={key:k, numero:i+1, ordre, label:this.labelCarte(k), tab:this.tabCarte(k), kind:c.kind};
        if(sg.length){
          sg.forEach((s,si)=>rows.push({...commun, idx:si, repere:"Repérage non abouti",
            titre:s.titre, titreVue:this.titreAffiche(k,s.titre), score:s.score, contenu:s.contenu, sugg:s}));
        } else {
          rows.push({...commun, idx:0, repere:`Repéré (confiance ${this.libelleConf(c.confiance)}).`,
            titre:'', titreVue:'', score:null, contenu:null, sugg:null});
        }
      });
      return rows; },
    dictionnaireTriee(){
      const rows=this.dictionnaire.slice(); const {col,sens}=this.dicoTri;
      const val=r=>{ switch(col){
        case 'numero': return r.numero;
        case 'tab': return (r.tab||'').toLowerCase();
        case 'label': return (r.label||'').toLowerCase();
        case 'repere': return (r.repere||'').toLowerCase();
        case 'titre': return (r.titreVue||r.titre||'').toLowerCase();
        case 'score': return r.score==null? -1 : r.score;
        default: return r.ordre; } };
      rows.sort((a,b)=>{ const x=val(a), y=val(b);
        if(x<y) return -sens; if(x>y) return sens;
        return (a.ordre-b.ordre)||(a.numero-b.numero)||(a.idx-b.idx); });
      return rows; },
    analysesTriees(){
      const recs=(this.historique && this.historique.analyses) ? this.historique.analyses.slice() : [];
      const {col,sens}=this.histTri;
      const val=r=>{ switch(col){
        case 'nom': return (r.nom||'').toLowerCase();
        case 'dex_id': return (r.dex_id||'').toLowerCase();
        case 'gabarit': return (r.gabarit_signature||'').toLowerCase();
        case 'abouti': return r.n_abouti!=null? r.n_abouti : -1;
        case 'elevee': return (r.conf||{}).elevee||0;
        case 'moyenne': return (r.conf||{}).moyenne||0;
        case 'faible': return (r.conf||{}).faible||0;
        case 'vide': return (r.conf||{}).vide||0;
        case 'ambigu': return r.n_ambigu||0;
        case 'points': return r.n_points||0;
        case 'regles': return (r.rules_version||'').toLowerCase();
        default: return r.horodatage||''; } };
      recs.sort((a,b)=>{ const x=val(a), y=val(b);
        if(x<y) return -sens; if(x>y) return sens; return (a.horodatage||'')<(b.horodatage||'')?1:-1; });
      return recs; },
  },
  methods:{
    async api(method,path,body){
      const opt={method,headers:{'Content-Type':'application/json'}};
      if(body!==undefined) opt.body=JSON.stringify(body);
      const r=await fetch(path,opt);
      const j=await r.json().catch(()=>({error:'réponse illisible'}));
      if(!r.ok) throw new Error(j.error||('HTTP '+r.status));
      return j;
    },
    async sante(){ try{ this.health=await this.api('GET','/api/health'); this.backOk=true; }
      catch(e){ this.backOk=false; } },
    info(m){ this.statut=m; this.erreur=''; },
    err(e){ this.erreur=(e&&e.message)||String(e); },
    surFichier(ev){ const f=ev.target.files&&ev.target.files[0]; if(f) this.lireFichier(f); },
    surDepot(ev){ const f=ev.dataTransfer.files&&ev.dataTransfer.files[0];
      if(f){ if(!f.name.toLowerCase().endsWith('.docx')){ this.err('Le fichier doit être un .docx.'); return;} this.lireFichier(f);} },
    lireFichier(f){ const rd=new FileReader();
      rd.onload=()=>{ const b64=String(rd.result).split(',')[1];
        this.source={filename:f.name, content_base64:b64}; this.traiter(); };
      rd.onerror=()=>this.err('Lecture du fichier impossible.'); rd.readAsDataURL(f); },
    traiterDepuisChemin(){ this.source={path:this.cheminInput.trim()}; this.traiter(); },
    async traiter(){
      this.chargement=true; this.info('Traitement en cours…'); this.replay=null;
      try{
        this.resultat=await this.api('POST','/api/process-dex', this.source);
        this._memoriserSource();
        this.initApresTraitement();
        const pts=this.resultat.points_a_verifier.length;
        this.info(`DEX ${this.resultat.identification.solution||''} traité — ${pts} point(s) à vérifier.`);
        this.sante();
      }catch(e){ this.err(e); this.resultat=null; } finally{ this.chargement=false; }
    },
    _memoriserSource(){ // mémorise la source par nom de fichier pour ré-ouverture depuis l'Historique
      const s=this.source||{}; let fn=s.filename;
      if(!fn && s.path) fn=String(s.path).split(/[\\/]/).pop();
      if(fn) this.sourcesLot={...this.sourcesLot,[fn]:{...s}}; },
    initApresTraitement(){
      this.etats={}; this.choix={};
      // Pli initial : on replie les cadres « Non concerné » (sans repère dans le
      // document) sauf si une ambiguïté ou un routage d'attention y est signalé.
      const r={};
      this.resultat.ordre_champs.forEach(k=>{ const c=this.resultat.champs[k];
        r[k] = this.estNonConcerne(k) && !c.ambigu && !c.route_attention; });
      this.replie=r;
      this.resultat.ordre_champs.forEach(k=>{ this.etats[k]={formulaire:false,type:'section_introuvable',correction:'',envoye:null}; });
      this.debutTs=Date.now();
      this.selection=this.resultat.ordre_champs.find(k=>this.resultat.champs[k].source_spans.length)||null;
    },
    fichierEnBase64(f){ return new Promise((res,rej)=>{ const rd=new FileReader();
      rd.onload=()=>res(String(rd.result).split(',')[1]); rd.onerror=()=>rej(new Error('lecture impossible')); rd.readAsDataURL(f); }); },
    async surDossier(ev){ const liste=Array.from(ev.target.files||[]); ev.target.value='';
      const docx=liste.filter(f=>f.name.toLowerCase().endsWith('.docx'));
      if(!docx.length){ this.err('Aucun fichier .docx dans le dossier sélectionné.'); return; }
      this.chargement=true; this.lot={total:docx.length, fait:0, ok:0, ko:0, erreurs:[]};
      let dernier=null, derniereSrc=null;
      for(const f of docx){
        try{ const b64=await this.fichierEnBase64(f); const src={filename:f.name, content_base64:b64};
          this.sourcesLot={...this.sourcesLot,[f.name]:src};
          dernier=await this.api('POST','/api/process-dex', src); derniereSrc=src; this.lot.ok++;
        }catch(e){ this.lot.ko++; this.lot.erreurs.push(f.name+' : '+(e.message||e)); }
        this.lot.fait++;
      }
      if(dernier){ this.source=derniereSrc; this.resultat=dernier; this.initApresTraitement(); }
      this.chargement=false;
      this.info(`Lot terminé : ${this.lot.ok} DEX traité(s), ${this.lot.ko} échec(s).`);
      this.sante(); },
    // ré-ouverture depuis l'Historique : ouvrir le fichier de la ligne puis déplier le groupe
    async ouvrirEtFiltrer(a, groupe){
      const src=this.sourcesLot[a.nom];
      if(src){ this.source={...src}; await this.traiter(); if(this.resultat) this.filtrerGroupe(groupe); }
      else { this.onglet='reprise';
        this.err(`Fichier « ${a.nom} » non disponible dans cette session : re-sélectionnez le dossier pour le ré-ouvrir.`);
        if(this.resultat) this.filtrerGroupe(groupe); } },
    ecoule(){ return this.debutTs ? Math.round((Date.now()-this.debutTs)/1000) : null; },
    styleCarte(key){ const c=this.couleurs[key]||{}; return {'--coul':c.bord,'--coulfond':c.fond}; },
    selectionner(key){ this.selection=key; this.allerPremierSpan(key); },
    allerPremierSpan(key){ const sp=this.spansAffiches(key);
      if(sp.length) this.allerParagraphe(sp[0][0]); },
    // --- Pli des cartes (accordéon / minimisable) ---
    estNonConcerne(key){ const c=this.resultat.champs[key];
      return c.kind!=='empty' && (!c.source_spans || !c.source_spans.length); },
    basculerCarte(key){ this.replie={...this.replie,[key]:!this.replie[key]}; },
    replierTout(val){ const m={}; if(this.resultat) this.resultat.ordre_champs.forEach(k=>{ m[k]=val; }); this.replie=m; },
    // --- Désambiguïsation : la section affichée = choix (candidat OU suggestion), sinon moteur ---
    //     this.choix[key] = {index, titre, span, contenu} | undefined
    sectionChoisie(key){ return this.choix[key]; },
    spansAffiches(key){ const c=this.resultat.champs[key]; const o=this.choix[key];
      if(o && o.index!==c.selection_moteur && c.kind==='text' && o.span) return [o.span];
      return c.source_spans; },
    contenuAffiche(key){ const c=this.resultat.champs[key]; const o=this.choix[key];
      if(o && o.index!==c.selection_moteur && c.kind==='text' && o.contenu!=null) return o.contenu;
      return c.content; },
    choixDiffere(key){ const c=this.resultat.champs[key]; const o=this.choix[key];
      return !!o && o.index!==c.selection_moteur; },
    choisirCandidat(key,c){ this.choix={...this.choix,[key]:{index:c.index,titre:c.titre,span:c.span,contenu:c.contenu}};
      this.selection=key; if(c.span) this.allerParagraphe(c.span[0]); },
    choisirSuggestion(key,s){ const c=this.resultat.champs[key]; this.selection=key;
      if(c.kind==='text' && s.contenu!=null){
        this.choix={...this.choix,[key]:{index:s.index,titre:s.titre,span:s.span,contenu:s.contenu}};
        if(s.span) this.allerParagraphe(s.span[0]);
      } else { this.allerParagraphe(s.index); } },
    reinitChoix(key){ const m={...this.choix}; delete m[key]; this.choix=m; this.selectionner(key); },
    confirmerSection(key){ const c=this.resultat.champs[key]; const o=this.choix[key]||{};
      const moteur=(c.candidats||[]).find(x=>x.index===c.selection_moteur)||{};
      // section moteur absente => le champ n'était pas trouvé : section_introuvable ; sinon mauvaise_section
      const type = c.selection_moteur==null ? 'section_introuvable' : 'mauvaise_section';
      const corr={section_choisie:{index:o.index,titre:o.titre},
                  section_moteur:{index:c.selection_moteur,titre:moteur.titre||null}};
      this.valider(key,'signale',type,corr);
      this.preparerMail(key, type, corr); },
    allerParagraphe(idx){ this.$nextTick(()=>{ const el=document.getElementById('p-'+idx);
      if(el) el.scrollIntoView({block:'center', behavior:'smooth'}); }); },
    // --- Historique ---
    allerHistorique(){ this.onglet='historique'; this.chargerHistorique(); },
    async chargerHistorique(){ try{ this.historique=await this.api('GET','/api/history'); }catch(e){ this.err(e); } },
    heureLisible(h){ if(!h) return '—'; const [d,hh]=h.split('T'); return (d? d.split('-').reverse().join('/') : '')+' '+(hh||'')+'h'; },
    horodatageLisible(iso){ if(!iso) return '—'; try{ return new Date(iso).toLocaleString('fr-FR'); }catch(e){ return iso; } },
    // --- Onglet Dictionnaire (tableau des intitulés + navigation depuis la Reprise) ---
    allerDictionnaire(){ this.onglet='dictionnaire'; },
    trierDico(col){ if(this.dicoTri.col===col){ this.dicoTri={col,sens:-this.dicoTri.sens}; } else { this.dicoTri={col,sens:1}; } },
    ariaSort(col){ if(this.dicoTri.col!==col) return 'none'; return this.dicoTri.sens>0?'ascending':'descending'; },
    flecheTri(col){ if(this.dicoTri.col!==col) return ''; return this.dicoTri.sens>0?' ▲':' ▼'; },
    // surcharges d'intitulé/catégorie (éditables dans le Dictionnaire, persistées en config)
    labelCarte(key){ const o=this.intitulesCartes[key]; return (o && o.label!=null && o.label!=='') ? o.label : (this.resultat ? this.resultat.champs[key].label : key); },
    tabCarte(key){ const o=this.intitulesCartes[key]; return (o && o.tab!=null && o.tab!=='') ? o.tab : (this.resultat ? this.resultat.champs[key].tab : ''); },
    majIntitule(key,patch){ const cur={...(this.intitulesCartes[key]||{})}; Object.assign(cur,patch); this.intitulesCartes={...this.intitulesCartes,[key]:cur}; },
    async enregistrerIntitules(){ try{ await this.api('POST','/api/config',{intitules_cartes:this.intitulesCartes}); }catch(e){ this.err(e); } },
    // surcharge du titre proposé (éditable dans le Dictionnaire, persistée ; clé = titre d'origine)
    titreAffiche(key,orig){ const m=this.titresProposes[key]; const v=m&&m[orig]; return (v!=null&&v!=='')? v : orig; },
    majTitre(key,orig,val){ const cur={...(this.titresProposes[key]||{})}; cur[orig]=val; this.titresProposes={...this.titresProposes,[key]:cur}; },
    async enregistrerTitres(){ try{ await this.api('POST','/api/config',{titres_proposes:this.titresProposes}); }catch(e){ this.err(e); } },
    // filtre par groupe : déplie en Reprise les seules cartes du groupe choisi
    estDuGroupe(key,g){ const c=this.resultat.champs[key]; const conf=c.confiance;
      switch(g){
        case 'abouti': return !!(c.source_spans && c.source_spans.length);
        case 'elevee': return conf!=null && conf>=0.8;
        case 'moyenne': return conf!=null && conf>=0.5 && conf<0.8;
        case 'faible': return conf!=null && conf<0.5;
        case 'vide':   return conf==null;
        case 'ambigu': return !!c.ambigu;
        default: return false; } },
    libelleGroupe(g){ return {abouti:'abouti',elevee:'confiance élevée',moyenne:'confiance moyenne',faible:'confiance faible',vide:'champ vide',ambigu:'ambigus'}[g]||g; },
    filtrerGroupe(g){
      if(!this.resultat){ this.onglet='reprise'; this.info('Traitez un DEX pour explorer ce groupe.'); return; }
      const membres={}; this.resultat.ordre_champs.forEach(k=>{ membres[k]=this.estDuGroupe(k,g); });
      const nv={}; this.resultat.ordre_champs.forEach(k=>{ nv[k]=!membres[k]; });  // replié sauf membres du groupe
      this.replie=nv; this.onglet='reprise';
      const premier=this.ordreKeys.find(k=>membres[k]);
      if(premier) this.$nextTick(()=>{ const el=document.getElementById('c-'+premier); if(el) el.scrollIntoView({block:'center',behavior:'smooth'}); });
      const n=Object.values(membres).filter(Boolean).length;
      this.info(`${n} carte(s) du groupe « ${this.libelleGroupe(g)} » dépliée(s).`); },
    // tri de l'historique
    trierHist(col){ if(this.histTri.col===col){ this.histTri={col,sens:-this.histTri.sens}; } else { this.histTri={col,sens:1}; } },
    ariaSortH(col){ if(this.histTri.col!==col) return 'none'; return this.histTri.sens>0?'ascending':'descending'; },
    flecheH(col){ if(this.histTri.col!==col) return ''; return this.histTri.sens>0?' ▲':' ▼'; },
    allerLigneDico(key,si){ this.onglet='dictionnaire'; const idx=(si==null?0:si); this.suggCible=key+'-'+idx;
      this.$nextTick(()=>{ const el=document.getElementById('dico-'+key+'-'+idx)||document.querySelector('[id^="dico-'+key+'-"]'); if(el) el.scrollIntoView({block:'center',behavior:'smooth'}); }); },
    appliquerDepuisSuggestion(key,s){ this.choisirSuggestion(key,s);
      this.replie={...this.replie,[key]:false}; this.onglet='reprise'; this.selection=key;
      this.$nextTick(()=>{ const el=document.getElementById('c-'+key); if(el) el.scrollIntoView({block:'center',behavior:'smooth'}); }); },
    voirDansDocument(key,s){ this.onglet='reprise'; this.selection=key;
      this.$nextTick(()=>{ this.allerParagraphe(s.index); }); },
    // --- Administration : valeurs par défaut de l'e-mail (config locale) ---
    allerAdmin(){ this.onglet='admin'; this.chargerConfig(); },
    async chargerConfig(){ try{ const cfg=await this.api('GET','/api/config');
      if(cfg && cfg.email) this.adminEmail={...this.adminEmail, ...cfg.email};
      if(cfg) this.pastilleConfCouleur = cfg.pastille_confiance_couleur_champ !== false;
      if(cfg && cfg.ordre_cartes) this.ordreCartes = {...cfg.ordre_cartes};
      if(cfg && cfg.intitules_cartes) this.intitulesCartes = {...cfg.intitules_cartes};
      if(cfg && cfg.titres_proposes) this.titresProposes = {...cfg.titres_proposes};
    }catch(e){ /* défauts conservés */ } },
    async enregistrerOrdre(){ try{ const m={};
      Object.keys(this.ordreCartes).forEach(k=>{ const v=parseInt(this.ordreCartes[k],10); if(!isNaN(v)) m[k]=v; });
      this.ordreCartes=m;
      await this.api('POST','/api/config',{ordre_cartes:m});
      this.ordreEnregistre=true; setTimeout(()=>{ this.ordreEnregistre=false; }, 2500);
    }catch(e){ this.err(e); } },
    async reinitOrdre(){ this.ordreCartes={}; try{ await this.api('POST','/api/config',{ordre_cartes:{}});
      this.ordreEnregistre=true; setTimeout(()=>{ this.ordreEnregistre=false; }, 2500); }catch(e){ this.err(e); } },
    majOrdre(key,val){ const v=parseInt(val,10); this.ordreCartes={...this.ordreCartes,[key]:(isNaN(v)?undefined:v)}; },
    async enregistrerPastille(){ try{ await this.api('POST','/api/config',{pastille_confiance_couleur_champ:this.pastilleConfCouleur}); }catch(e){ this.err(e); } },
    async enregistrerAdmin(){ try{ const cfg=await this.api('POST','/api/config',{email:{...this.adminEmail}});
      if(cfg && cfg.email) this.adminEmail={...this.adminEmail, ...cfg.email};
      this.adminEnregistre=true; setTimeout(()=>{ this.adminEnregistre=false; }, 2500);
      this.info('Configuration e-mail enregistrée.'); }catch(e){ this.err(e); } },
    reinitAdmin(){ this.adminEmail={adresses:'fredgarcia@mail.fr', objet_prefixe:'Castin ; ', contenu_prefixe:'', suffixe:'Cordialement,'}; },
    // --- Signalement par e-mail : préparer un brouillon ÉDITABLE puis envoyer ---
    //     Le corps reprend TOUTES les infos de la carte. mailto = texte brut ;
    //     une version HTML est disponible (bouton) pour coller dans Outlook.
    ficheCarte(key,type,extra){
      const c=this.resultat.champs[key];
      const dex=this.resultat.identification.solution||this.resultat.gabarit_signature||'inconnu';
      const date=new Date().toLocaleString('fr-FR');
      const contenu=this.contenuAffiche(key)||'(vide)';
      const sug=(c.suggestions||[]).map(s=>`${s.titre} (proximité ${s.score})`);
      const champs=[
        ['DEX', dex],
        ['Gabarit', this.resultat.gabarit_signature||'—'],
        ['Version de règles', this.resultat.rules_version||'—'],
        ['Date', date],
        ['Champ CAST\u2019IN', `${this.labelCarte(key)} (${this.tabCarte(key)})`],
        ['Type de champ', c.kind],
        ['Type de signalement', type],
        ['Confiance', `${c.confiance==null?'—':c.confiance} (${this.libelleConf(c.confiance)})`],
        ['Score brut', c.score_brut==null?'—':c.score_brut],
        ['Raison', c.raison||'—'],
        ['Repérage (titre)', c.titre_repere||'(non repéré)'],
        ['À vérifier (routage)', c.route_attention?'oui':'non'],
        ['Ambigu', c.ambigu?'oui':'non'],
      ];
      if(extra && extra.section_choisie) champs.push(['Section choisie',
        `${extra.section_choisie.titre||'?'}${extra.section_moteur&&extra.section_moteur.titre?' (au lieu de '+extra.section_moteur.titre+')':''}`]);
      if(extra && extra.commentaire) champs.push(['Commentaire', extra.commentaire]);

      // --- texte brut ---
      const T=[];
      if(this.adminEmail.contenu_prefixe && this.adminEmail.contenu_prefixe.trim()) T.push(this.adminEmail.contenu_prefixe.trim(),'');
      T.push('Signalement CAST\u2019IN','===================');
      champs.forEach(([k,v])=>T.push(`${k} : ${v}`));
      T.push('','Contenu de la carte :', contenu);
      if(sug.length){ T.push('','Suggestions :'); sug.forEach(s=>T.push('- '+s)); }
      if(this.resultat.points_a_verifier && this.resultat.points_a_verifier.length){
        T.push('','Points à vérifier (DEX) :'); this.resultat.points_a_verifier.forEach(p=>T.push('- '+p)); }
      if(this.adminEmail.suffixe && this.adminEmail.suffixe.trim()) T.push('', this.adminEmail.suffixe.trim());

      // --- HTML (pour coller dans Outlook) ---
      const esc=s=>String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
      const H=[];
      H.push('<div style="font-family:Segoe UI,Arial,sans-serif;font-size:14px;color:#1a1a1a">');
      if(this.adminEmail.contenu_prefixe && this.adminEmail.contenu_prefixe.trim()) H.push('<p>'+esc(this.adminEmail.contenu_prefixe.trim())+'</p>');
      H.push('<h3 style="margin:0 0 .4em">Signalement CAST\u2019IN</h3>');
      H.push('<table cellpadding="6" cellspacing="0" style="border-collapse:collapse;border:1px solid #ccc">');
      champs.forEach(([k,v])=>H.push(`<tr><td style="border:1px solid #ccc;background:#f4f6ff;font-weight:bold">${esc(k)}</td><td style="border:1px solid #ccc">${esc(v)}</td></tr>`));
      H.push('</table>');
      H.push('<p style="font-weight:bold;margin:.8em 0 .2em">Contenu de la carte :</p>');
      H.push('<pre style="white-space:pre-wrap;font-family:inherit;background:#f6f8ff;border:1px solid #ddd;padding:8px;margin:0">'+esc(contenu)+'</pre>');
      if(sug.length){ H.push('<p style="font-weight:bold;margin:.8em 0 .2em">Suggestions :</p><ul>'+sug.map(s=>'<li>'+esc(s)+'</li>').join('')+'</ul>'); }
      if(this.resultat.points_a_verifier && this.resultat.points_a_verifier.length){
        H.push('<p style="font-weight:bold;margin:.8em 0 .2em">Points à vérifier (DEX) :</p><ul>'+this.resultat.points_a_verifier.map(p=>'<li>'+esc(p)+'</li>').join('')+'</ul>'); }
      if(this.adminEmail.suffixe && this.adminEmail.suffixe.trim()) H.push('<p>'+esc(this.adminEmail.suffixe.trim())+'</p>');
      H.push('</div>');

      return { texte:T.join('\n'), html:H.join('') };
    },
    preparerMail(key,type,extra){
      const c=this.resultat.champs[key];
      const f=this.ficheCarte(key,type,extra);
      this.mail={ key, champLabel:c.label,
        dest:this.adminEmail.adresses||'',
        objet:(this.adminEmail.objet_prefixe||'')+type,
        corps:f.texte, html:f.html };
      this.$nextTick(()=>{ const el=this.$refs.mailDest; if(el&&el.focus) el.focus(); });
    },
    async copierFicheHtml(){
      if(!this.mail) return;
      try{
        const blobH=new Blob([this.mail.html||''],{type:'text/html'});
        const blobT=new Blob([this.mail.corps||''],{type:'text/plain'});
        await navigator.clipboard.write([new ClipboardItem({'text/html':blobH,'text/plain':blobT})]);
        this.info('Fiche HTML copiée — collez-la (Ctrl+V) dans le corps du message Outlook.');
      }catch(e){ this.err('Copie HTML non disponible sur ce navigateur ; utilisez le corps texte.'); }
    },
    envoyerMail(){
      if(!this.mail) return;
      const dest=(this.mail.dest||'').split(';').map(s=>s.trim()).filter(Boolean).join(',');  // mailto : adresses séparées par ','
      const url='mailto:'+encodeURIComponent(dest).replace(/%2C/g,',')
        +'?subject='+encodeURIComponent(this.mail.objet||'')
        +'&body='+encodeURIComponent(this.mail.corps||'');
      try{ window.location.href=url; }catch(e){ this.err('Impossible d\'ouvrir la messagerie.'); }
      this.info('Brouillon e-mail ouvert dans la messagerie.');
      this.mail=null;
    },
    annulerMail(){ this.mail=null; },
    surlignage(idx){
      if(!this.resultat) return {actif:false,labels:[],style:{}};
      const set = this.toutAnnoter ? this.resultat.ordre_champs : (this.selection?[this.selection]:[]);
      let coul=null, fond=null; const labels=[];
      for(const k of set){
        for(const [s,e] of this.spansAffiches(k)){
          if(idx>=s && idx<e){ const c=this.couleurs[k];
            if(!coul){coul=c.bord;fond=c.fond;}
            if(idx===s) labels.push(this.resultat.champs[k].label);
          }
        }
      }
      return {actif:!!coul, labels, style:coul?{'--coul':coul,'--coulfond':fond}:{}};
    },
    classeConf(c){ if(c==null) return 'na'; if(c>=0.8) return 'elevee'; if(c>=0.5) return 'moyenne'; return 'faible'; },
    libelleConf(c){ if(c==null) return 'champ vide';
      const p=Math.round(c*100)+' %'; if(c>=0.8) return 'confiance élevée '+p;
      if(c>=0.5) return 'confiance moyenne '+p; return 'confiance faible '+p; },
    etat(key){ if(!this.etats[key]) this.etats[key]={formulaire:false,type:'section_introuvable',correction:'',envoye:null};
      return this.etats[key]; },
    ouvrirSignalement(key){ this.etat(key).formulaire=true; },
    async copier(key){
      const txt=this.contenuAffiche(key)||'';
      try{ await navigator.clipboard.writeText(txt); }
      catch(e){ const ta=document.getElementById('c-'+key); ta.select(); try{document.execCommand('copy');}catch(_){} }
      this.info('Copié : '+this.resultat.champs[key].label);
    },
    async valider(key,verdict,type,correction){
      try{
        await this.api('POST','/api/validate',{
          dex_id:this.resultat.identification.solution||this.resultat.gabarit_signature,
          onglet:this.resultat.champs[key].tab==='DEX'?'dex':'description_detaillee',
          champ:key, confiance:this.resultat.champs[key].confiance,
          score_brut:this.resultat.champs[key].score_brut, verdict,
          type_signalement:type||null, correction:correction||null,
          gabarit_signature:this.resultat.gabarit_signature,
          duree_traitement_s:this.ecoule(), operateur_role:this.role,
        });
        this.etat(key).envoye=verdict;
        this.info((verdict==='accepte'?'Accepté : ':'Signalé : ')+this.resultat.champs[key].label);
        this.chargerMetriques();
      }catch(e){ this.err(e); }
    },
    envoyerSignalement(key){ const s=this.etat(key);
      const corr = s.correction ? {commentaire:s.correction} : null;
      this.valider(key,'signale',s.type, corr);
      this.preparerMail(key, s.type, corr);
      s.formulaire=false; },
    allerDashboard(){ this.onglet='dashboard'; this.chargerMetriques(); },
    async chargerMetriques(){ try{ this.metriques=await this.api('GET','/api/metrics');
      if(this.cibleEceInput==='') this.cibleEceInput=String(this.metriques.cible_ece); }catch(e){ this.err(e); } },
    async enregistrerCible(){ const v=parseFloat(String(this.cibleEceInput).replace(',','.'));
      if(isNaN(v)||v<0||v>1){ this.err('La cible ECE doit être un nombre entre 0 et 1.'); return; }
      try{ await this.api('POST','/api/config',{cible_ece:v}); this.info('Cible ECE enregistrée : '+v); this.chargerMetriques(); }
      catch(e){ this.err(e); } },
    async rechargerRegles(){ try{ const r=await this.api('POST','/api/rules/reload'); this.info('Règles rechargées (version '+r.rules_version+').'); this.sante(); }
      catch(e){ this.err(e); } },
    async analyserCalibration(){ this.calibrationStatut='';
      try{ this.calibrationAnalyse=await this.api('GET','/api/calibration');
        this.calibrationStatut = this.calibrationAnalyse.suffisant
          ? `Carte ajustée sur ${this.calibrationAnalyse.n} verdicts.`
          : ''; }
      catch(e){ this.err(e); } },
    async proposerCalibration(){ try{ const r=await this.api('POST','/api/calibration/proposer');
        this.calibrationStatut = `Candidate écrite : ${r.chemin} (v${r.version_proposee}). ${r.rappel}`; }
      catch(e){ this.err(e); } },
    async rejouer(){ if(!this.resultat) return;      try{ const body=Object.assign({dex_id:this.resultat.identification.solution||this.resultat.gabarit_signature}, this.source);
        this.replay=await this.api('POST','/api/replay', body);
        this.info('Replay effectué.'); this.chargerMetriques();
      }catch(e){ this.err(e); } },
    fmt(x){ return (x==null)?'—':x; },
    navOnglets(ev){ const ordre=['reprise','dictionnaire','dashboard','historique','admin']; const i=ordre.indexOf(this.onglet);
      if(ev.key==='ArrowRight'||ev.key==='ArrowLeft'){ ev.preventDefault();
        const j=(i+(ev.key==='ArrowRight'?1:ordre.length-1))%ordre.length; const cible=ordre[j];
        const acts={dictionnaire:()=>this.allerDictionnaire(),dashboard:()=>this.allerDashboard(),historique:()=>this.allerHistorique(),admin:()=>this.allerAdmin(),reprise:()=>{this.onglet='reprise';}};
        acts[cible]();
        this.$nextTick(()=>{ const id={reprise:'tab-reprise',dictionnaire:'tab-dico',dashboard:'tab-dash',historique:'tab-hist',admin:'tab-admin'}[cible]; const el=document.getElementById(id); if(el) el.focus(); });
      } },
  },
  mounted(){ this.sante(); this.chargerConfig(); setInterval(this.sante, 15000); },
}).mount('#app');
</script>
</body>
</html>
#@FILE_END
#@FILE_TXT:front/vue.global.prod.js
/**
* vue v3.5.13
* (c) 2018-present Yuxi (Evan) You and Vue contributors
* @license MIT
**/var Vue=function(e){"use strict";var t,n;let r,i,l,s,o,a,c,u,d,p,f,h,m;function g(e){let t=Object.create(null);for(let n of e.split(","))t[n]=1;return e=>e in t}let y={},b=[],_=()=>{},S=()=>!1,x=e=>111===e.charCodeAt(0)&&110===e.charCodeAt(1)&&(e.charCodeAt(2)>122||97>e.charCodeAt(2)),C=e=>e.startsWith("onUpdate:"),k=Object.assign,T=(e,t)=>{let n=e.indexOf(t);n>-1&&e.splice(n,1)},N=Object.prototype.hasOwnProperty,w=(e,t)=>N.call(e,t),A=Array.isArray,E=e=>"[object Map]"===V(e),I=e=>"[object Set]"===V(e),R=e=>"[object Date]"===V(e),O=e=>"[object RegExp]"===V(e),P=e=>"function"==typeof e,M=e=>"string"==typeof e,L=e=>"symbol"==typeof e,$=e=>null!==e&&"object"==typeof e,D=e=>($(e)||P(e))&&P(e.then)&&P(e.catch),F=Object.prototype.toString,V=e=>F.call(e),B=e=>V(e).slice(8,-1),U=e=>"[object Object]"===V(e),j=e=>M(e)&&"NaN"!==e&&"-"!==e[0]&&""+parseInt(e,10)===e,H=g(",key,ref,ref_for,ref_key,onVnodeBeforeMount,onVnodeMounted,onVnodeBeforeUpdate,onVnodeUpdated,onVnodeBeforeUnmount,onVnodeUnmounted"),q=g("bind,cloak,else-if,else,for,html,if,model,on,once,pre,show,slot,text,memo"),W=e=>{let t=Object.create(null);return n=>t[n]||(t[n]=e(n))},K=/-(\w)/g,z=W(e=>e.replace(K,(e,t)=>t?t.toUpperCase():"")),J=/\B([A-Z])/g,G=W(e=>e.replace(J,"-$1").toLowerCase()),X=W(e=>e.charAt(0).toUpperCase()+e.slice(1)),Q=W(e=>e?`on${X(e)}`:""),Z=(e,t)=>!Object.is(e,t),Y=(e,...t)=>{for(let n=0;n<e.length;n++)e[n](...t)},ee=(e,t,n,r=!1)=>{Object.defineProperty(e,t,{configurable:!0,enumerable:!1,writable:r,value:n})},et=e=>{let t=parseFloat(e);return isNaN(t)?e:t},en=e=>{let t=M(e)?Number(e):NaN;return isNaN(t)?e:t},er=()=>r||(r="undefined"!=typeof globalThis?globalThis:"undefined"!=typeof self?self:"undefined"!=typeof window?window:"undefined"!=typeof global?global:{}),ei=g("Infinity,undefined,NaN,isFinite,isNaN,parseFloat,parseInt,decodeURI,decodeURIComponent,encodeURI,encodeURIComponent,Math,Number,Date,Array,Object,Boolean,String,RegExp,Map,Set,JSON,Intl,BigInt,console,Error,Symbol");function el(e){if(A(e)){let t={};for(let n=0;n<e.length;n++){let r=e[n],i=M(r)?ec(r):el(r);if(i)for(let e in i)t[e]=i[e]}return t}if(M(e)||$(e))return e}let es=/;(?![^(]*\))/g,eo=/:([^]+)/,ea=/\/\*[^]*?\*\//g;function ec(e){let t={};return e.replace(ea,"").split(es).forEach(e=>{if(e){let n=e.split(eo);n.length>1&&(t[n[0].trim()]=n[1].trim())}}),t}function eu(e){let t="";if(M(e))t=e;else if(A(e))for(let n=0;n<e.length;n++){let r=eu(e[n]);r&&(t+=r+" ")}else if($(e))for(let n in e)e[n]&&(t+=n+" ");return t.trim()}let ed=g("html,body,base,head,link,meta,style,title,address,article,aside,footer,header,hgroup,h1,h2,h3,h4,h5,h6,nav,section,div,dd,dl,dt,figcaption,figure,picture,hr,img,li,main,ol,p,pre,ul,a,b,abbr,bdi,bdo,br,cite,code,data,dfn,em,i,kbd,mark,q,rp,rt,ruby,s,samp,small,span,strong,sub,sup,time,u,var,wbr,area,audio,map,track,video,embed,object,param,source,canvas,script,noscript,del,ins,caption,col,colgroup,table,thead,tbody,td,th,tr,button,datalist,fieldset,form,input,label,legend,meter,optgroup,option,output,progress,select,textarea,details,dialog,menu,summary,template,blockquote,iframe,tfoot"),ep=g("svg,animate,animateMotion,animateTransform,circle,clipPath,color-profile,defs,desc,discard,ellipse,feBlend,feColorMatrix,feComponentTransfer,feComposite,feConvolveMatrix,feDiffuseLighting,feDisplacementMap,feDistantLight,feDropShadow,feFlood,feFuncA,feFuncB,feFuncG,feFuncR,feGaussianBlur,feImage,feMerge,feMergeNode,feMorphology,feOffset,fePointLight,feSpecularLighting,feSpotLight,feTile,feTurbulence,filter,foreignObject,g,hatch,hatchpath,image,line,linearGradient,marker,mask,mesh,meshgradient,meshpatch,meshrow,metadata,mpath,path,pattern,polygon,polyline,radialGradient,rect,set,solidcolor,stop,switch,symbol,text,textPath,title,tspan,unknown,use,view"),ef=g("annotation,annotation-xml,maction,maligngroup,malignmark,math,menclose,merror,mfenced,mfrac,mfraction,mglyph,mi,mlabeledtr,mlongdiv,mmultiscripts,mn,mo,mover,mpadded,mphantom,mprescripts,mroot,mrow,ms,mscarries,mscarry,msgroup,msline,mspace,msqrt,msrow,mstack,mstyle,msub,msubsup,msup,mtable,mtd,mtext,mtr,munder,munderover,none,semantics"),eh=g("area,base,br,col,embed,hr,img,input,link,meta,param,source,track,wbr"),em=g("itemscope,allowfullscreen,formnovalidate,ismap,nomodule,novalidate,readonly");function eg(e,t){if(e===t)return!0;let n=R(e),r=R(t);if(n||r)return!!n&&!!r&&e.getTime()===t.getTime();if(n=L(e),r=L(t),n||r)return e===t;if(n=A(e),r=A(t),n||r)return!!n&&!!r&&function(e,t){if(e.length!==t.length)return!1;let n=!0;for(let r=0;n&&r<e.length;r++)n=eg(e[r],t[r]);return n}(e,t);if(n=$(e),r=$(t),n||r){if(!n||!r||Object.keys(e).length!==Object.keys(t).length)return!1;for(let n in e){let r=e.hasOwnProperty(n),i=t.hasOwnProperty(n);if(r&&!i||!r&&i||!eg(e[n],t[n]))return!1}}return String(e)===String(t)}function ey(e,t){return e.findIndex(e=>eg(e,t))}let ev=e=>!!(e&&!0===e.__v_isRef),eb=e=>M(e)?e:null==e?"":A(e)||$(e)&&(e.toString===F||!P(e.toString))?ev(e)?eb(e.value):JSON.stringify(e,e_,2):String(e),e_=(e,t)=>ev(t)?e_(e,t.value):E(t)?{[`Map(${t.size})`]:[...t.entries()].reduce((e,[t,n],r)=>(e[eS(t,r)+" =>"]=n,e),{})}:I(t)?{[`Set(${t.size})`]:[...t.values()].map(e=>eS(e))}:L(t)?eS(t):!$(t)||A(t)||U(t)?t:String(t),eS=(e,t="")=>{var n;return L(e)?`Symbol(${null!=(n=e.description)?n:t})`:e};class ex{constructor(e=!1){this.detached=e,this._active=!0,this.effects=[],this.cleanups=[],this._isPaused=!1,this.parent=i,!e&&i&&(this.index=(i.scopes||(i.scopes=[])).push(this)-1)}get active(){return this._active}pause(){if(this._active){let e,t;if(this._isPaused=!0,this.scopes)for(e=0,t=this.scopes.length;e<t;e++)this.scopes[e].pause();for(e=0,t=this.effects.length;e<t;e++)this.effects[e].pause()}}resume(){if(this._active&&this._isPaused){let e,t;if(this._isPaused=!1,this.scopes)for(e=0,t=this.scopes.length;e<t;e++)this.scopes[e].resume();for(e=0,t=this.effects.length;e<t;e++)this.effects[e].resume()}}run(e){if(this._active){let t=i;try{return i=this,e()}finally{i=t}}}on(){i=this}off(){i=this.parent}stop(e){if(this._active){let t,n;for(t=0,this._active=!1,n=this.effects.length;t<n;t++)this.effects[t].stop();for(t=0,this.effects.length=0,n=this.cleanups.length;t<n;t++)this.cleanups[t]();if(this.cleanups.length=0,this.scopes){for(t=0,n=this.scopes.length;t<n;t++)this.scopes[t].stop(!0);this.scopes.length=0}if(!this.detached&&this.parent&&!e){let e=this.parent.scopes.pop();e&&e!==this&&(this.parent.scopes[this.index]=e,e.index=this.index)}this.parent=void 0}}}let eC=new WeakSet;class ek{constructor(e){this.fn=e,this.deps=void 0,this.depsTail=void 0,this.flags=5,this.next=void 0,this.cleanup=void 0,this.scheduler=void 0,i&&i.active&&i.effects.push(this)}pause(){this.flags|=64}resume(){64&this.flags&&(this.flags&=-65,eC.has(this)&&(eC.delete(this),this.trigger()))}notify(){(!(2&this.flags)||32&this.flags)&&(8&this.flags||eN(this))}run(){if(!(1&this.flags))return this.fn();this.flags|=2,eD(this),eA(this);let e=l,t=eP;l=this,eP=!0;try{return this.fn()}finally{eE(this),l=e,eP=t,this.flags&=-3}}stop(){if(1&this.flags){for(let e=this.deps;e;e=e.nextDep)eO(e);this.deps=this.depsTail=void 0,eD(this),this.onStop&&this.onStop(),this.flags&=-2}}trigger(){64&this.flags?eC.add(this):this.scheduler?this.scheduler():this.runIfDirty()}runIfDirty(){eI(this)&&this.run()}get dirty(){return eI(this)}}let eT=0;function eN(e,t=!1){if(e.flags|=8,t){e.next=o,o=e;return}e.next=s,s=e}function ew(){let e;if(!(--eT>0)){if(o){let e=o;for(o=void 0;e;){let t=e.next;e.next=void 0,e.flags&=-9,e=t}}for(;s;){let t=s;for(s=void 0;t;){let n=t.next;if(t.next=void 0,t.flags&=-9,1&t.flags)try{t.trigger()}catch(t){e||(e=t)}t=n}}if(e)throw e}}function eA(e){for(let t=e.deps;t;t=t.nextDep)t.version=-1,t.prevActiveLink=t.dep.activeLink,t.dep.activeLink=t}function eE(e){let t;let n=e.depsTail,r=n;for(;r;){let e=r.prevDep;-1===r.version?(r===n&&(n=e),eO(r),function(e){let{prevDep:t,nextDep:n}=e;t&&(t.nextDep=n,e.prevDep=void 0),n&&(n.prevDep=t,e.nextDep=void 0)}(r)):t=r,r.dep.activeLink=r.prevActiveLink,r.prevActiveLink=void 0,r=e}e.deps=t,e.depsTail=n}function eI(e){for(let t=e.deps;t;t=t.nextDep)if(t.dep.version!==t.version||t.dep.computed&&(eR(t.dep.computed)||t.dep.version!==t.version))return!0;return!!e._dirty}function eR(e){if(4&e.flags&&!(16&e.flags)||(e.flags&=-17,e.globalVersion===eF))return;e.globalVersion=eF;let t=e.dep;if(e.flags|=2,t.version>0&&!e.isSSR&&e.deps&&!eI(e)){e.flags&=-3;return}let n=l,r=eP;l=e,eP=!0;try{eA(e);let n=e.fn(e._value);(0===t.version||Z(n,e._value))&&(e._value=n,t.version++)}catch(e){throw t.version++,e}finally{l=n,eP=r,eE(e),e.flags&=-3}}function eO(e,t=!1){let{dep:n,prevSub:r,nextSub:i}=e;if(r&&(r.nextSub=i,e.prevSub=void 0),i&&(i.prevSub=r,e.nextSub=void 0),n.subs===e&&(n.subs=r,!r&&n.computed)){n.computed.flags&=-5;for(let e=n.computed.deps;e;e=e.nextDep)eO(e,!0)}t||--n.sc||!n.map||n.map.delete(n.key)}let eP=!0,eM=[];function eL(){eM.push(eP),eP=!1}function e$(){let e=eM.pop();eP=void 0===e||e}function eD(e){let{cleanup:t}=e;if(e.cleanup=void 0,t){let e=l;l=void 0;try{t()}finally{l=e}}}let eF=0;class eV{constructor(e,t){this.sub=e,this.dep=t,this.version=t.version,this.nextDep=this.prevDep=this.nextSub=this.prevSub=this.prevActiveLink=void 0}}class eB{constructor(e){this.computed=e,this.version=0,this.activeLink=void 0,this.subs=void 0,this.map=void 0,this.key=void 0,this.sc=0}track(e){if(!l||!eP||l===this.computed)return;let t=this.activeLink;if(void 0===t||t.sub!==l)t=this.activeLink=new eV(l,this),l.deps?(t.prevDep=l.depsTail,l.depsTail.nextDep=t,l.depsTail=t):l.deps=l.depsTail=t,function e(t){if(t.dep.sc++,4&t.sub.flags){let n=t.dep.computed;if(n&&!t.dep.subs){n.flags|=20;for(let t=n.deps;t;t=t.nextDep)e(t)}let r=t.dep.subs;r!==t&&(t.prevSub=r,r&&(r.nextSub=t)),t.dep.subs=t}}(t);else if(-1===t.version&&(t.version=this.version,t.nextDep)){let e=t.nextDep;e.prevDep=t.prevDep,t.prevDep&&(t.prevDep.nextDep=e),t.prevDep=l.depsTail,t.nextDep=void 0,l.depsTail.nextDep=t,l.depsTail=t,l.deps===t&&(l.deps=e)}return t}trigger(e){this.version++,eF++,this.notify(e)}notify(e){eT++;try{for(let e=this.subs;e;e=e.prevSub)e.sub.notify()&&e.sub.dep.notify()}finally{ew()}}}let eU=new WeakMap,ej=Symbol(""),eH=Symbol(""),eq=Symbol("");function eW(e,t,n){if(eP&&l){let t=eU.get(e);t||eU.set(e,t=new Map);let r=t.get(n);r||(t.set(n,r=new eB),r.map=t,r.key=n),r.track()}}function eK(e,t,n,r,i,l){let s=eU.get(e);if(!s){eF++;return}let o=e=>{e&&e.trigger()};if(eT++,"clear"===t)s.forEach(o);else{let i=A(e),l=i&&j(n);if(i&&"length"===n){let e=Number(r);s.forEach((t,n)=>{("length"===n||n===eq||!L(n)&&n>=e)&&o(t)})}else switch((void 0!==n||s.has(void 0))&&o(s.get(n)),l&&o(s.get(eq)),t){case"add":i?l&&o(s.get("length")):(o(s.get(ej)),E(e)&&o(s.get(eH)));break;case"delete":!i&&(o(s.get(ej)),E(e)&&o(s.get(eH)));break;case"set":E(e)&&o(s.get(ej))}}ew()}function ez(e){let t=tx(e);return t===e?t:(eW(t,"iterate",eq),t_(e)?t:t.map(tk))}function eJ(e){return eW(e=tx(e),"iterate",eq),e}let eG={__proto__:null,[Symbol.iterator](){return eX(this,Symbol.iterator,tk)},concat(...e){return ez(this).concat(...e.map(e=>A(e)?ez(e):e))},entries(){return eX(this,"entries",e=>(e[1]=tk(e[1]),e))},every(e,t){return eZ(this,"every",e,t,void 0,arguments)},filter(e,t){return eZ(this,"filter",e,t,e=>e.map(tk),arguments)},find(e,t){return eZ(this,"find",e,t,tk,arguments)},findIndex(e,t){return eZ(this,"findIndex",e,t,void 0,arguments)},findLast(e,t){return eZ(this,"findLast",e,t,tk,arguments)},findLastIndex(e,t){return eZ(this,"findLastIndex",e,t,void 0,arguments)},forEach(e,t){return eZ(this,"forEach",e,t,void 0,arguments)},includes(...e){return e0(this,"includes",e)},indexOf(...e){return e0(this,"indexOf",e)},join(e){return ez(this).join(e)},lastIndexOf(...e){return e0(this,"lastIndexOf",e)},map(e,t){return eZ(this,"map",e,t,void 0,arguments)},pop(){return e1(this,"pop")},push(...e){return e1(this,"push",e)},reduce(e,...t){return eY(this,"reduce",e,t)},reduceRight(e,...t){return eY(this,"reduceRight",e,t)},shift(){return e1(this,"shift")},some(e,t){return eZ(this,"some",e,t,void 0,arguments)},splice(...e){return e1(this,"splice",e)},toReversed(){return ez(this).toReversed()},toSorted(e){return ez(this).toSorted(e)},toSpliced(...e){return ez(this).toSpliced(...e)},unshift(...e){return e1(this,"unshift",e)},values(){return eX(this,"values",tk)}};function eX(e,t,n){let r=eJ(e),i=r[t]();return r===e||t_(e)||(i._next=i.next,i.next=()=>{let e=i._next();return e.value&&(e.value=n(e.value)),e}),i}let eQ=Array.prototype;function eZ(e,t,n,r,i,l){let s=eJ(e),o=s!==e&&!t_(e),a=s[t];if(a!==eQ[t]){let t=a.apply(e,l);return o?tk(t):t}let c=n;s!==e&&(o?c=function(t,r){return n.call(this,tk(t),r,e)}:n.length>2&&(c=function(t,r){return n.call(this,t,r,e)}));let u=a.call(s,c,r);return o&&i?i(u):u}function eY(e,t,n,r){let i=eJ(e),l=n;return i!==e&&(t_(e)?n.length>3&&(l=function(t,r,i){return n.call(this,t,r,i,e)}):l=function(t,r,i){return n.call(this,t,tk(r),i,e)}),i[t](l,...r)}function e0(e,t,n){let r=tx(e);eW(r,"iterate",eq);let i=r[t](...n);return(-1===i||!1===i)&&tS(n[0])?(n[0]=tx(n[0]),r[t](...n)):i}function e1(e,t,n=[]){eL(),eT++;let r=tx(e)[t].apply(e,n);return ew(),e$(),r}let e2=g("__proto__,__v_isRef,__isVue"),e3=new Set(Object.getOwnPropertyNames(Symbol).filter(e=>"arguments"!==e&&"caller"!==e).map(e=>Symbol[e]).filter(L));function e6(e){L(e)||(e=String(e));let t=tx(this);return eW(t,"has",e),t.hasOwnProperty(e)}class e4{constructor(e=!1,t=!1){this._isReadonly=e,this._isShallow=t}get(e,t,n){if("__v_skip"===t)return e.__v_skip;let r=this._isReadonly,i=this._isShallow;if("__v_isReactive"===t)return!r;if("__v_isReadonly"===t)return r;if("__v_isShallow"===t)return i;if("__v_raw"===t)return n===(r?i?tf:tp:i?td:tu).get(e)||Object.getPrototypeOf(e)===Object.getPrototypeOf(n)?e:void 0;let l=A(e);if(!r){let e;if(l&&(e=eG[t]))return e;if("hasOwnProperty"===t)return e6}let s=Reflect.get(e,t,tN(e)?e:n);return(L(t)?e3.has(t):e2(t))?s:(r||eW(e,"get",t),i)?s:tN(s)?l&&j(t)?s:s.value:$(s)?r?tg(s):th(s):s}}class e8 extends e4{constructor(e=!1){super(!1,e)}set(e,t,n,r){let i=e[t];if(!this._isShallow){let t=tb(i);if(t_(n)||tb(n)||(i=tx(i),n=tx(n)),!A(e)&&tN(i)&&!tN(n))return!t&&(i.value=n,!0)}let l=A(e)&&j(t)?Number(t)<e.length:w(e,t),s=Reflect.set(e,t,n,tN(e)?e:r);return e===tx(r)&&(l?Z(n,i)&&eK(e,"set",t,n):eK(e,"add",t,n)),s}deleteProperty(e,t){let n=w(e,t);e[t];let r=Reflect.deleteProperty(e,t);return r&&n&&eK(e,"delete",t,void 0),r}has(e,t){let n=Reflect.has(e,t);return L(t)&&e3.has(t)||eW(e,"has",t),n}ownKeys(e){return eW(e,"iterate",A(e)?"length":ej),Reflect.ownKeys(e)}}class e5 extends e4{constructor(e=!1){super(!0,e)}set(e,t){return!0}deleteProperty(e,t){return!0}}let e9=new e8,e7=new e5,te=new e8(!0),tt=new e5(!0),tn=e=>e,tr=e=>Reflect.getPrototypeOf(e);function ti(e){return function(...t){return"delete"!==e&&("clear"===e?void 0:this)}}function tl(e,t){let n=function(e,t){let n={get(n){let r=this.__v_raw,i=tx(r),l=tx(n);e||(Z(n,l)&&eW(i,"get",n),eW(i,"get",l));let{has:s}=tr(i),o=t?tn:e?tT:tk;return s.call(i,n)?o(r.get(n)):s.call(i,l)?o(r.get(l)):void(r!==i&&r.get(n))},get size(){let t=this.__v_raw;return e||eW(tx(t),"iterate",ej),Reflect.get(t,"size",t)},has(t){let n=this.__v_raw,r=tx(n),i=tx(t);return e||(Z(t,i)&&eW(r,"has",t),eW(r,"has",i)),t===i?n.has(t):n.has(t)||n.has(i)},forEach(n,r){let i=this,l=i.__v_raw,s=tx(l),o=t?tn:e?tT:tk;return e||eW(s,"iterate",ej),l.forEach((e,t)=>n.call(r,o(e),o(t),i))}};return k(n,e?{add:ti("add"),set:ti("set"),delete:ti("delete"),clear:ti("clear")}:{add(e){t||t_(e)||tb(e)||(e=tx(e));let n=tx(this);return tr(n).has.call(n,e)||(n.add(e),eK(n,"add",e,e)),this},set(e,n){t||t_(n)||tb(n)||(n=tx(n));let r=tx(this),{has:i,get:l}=tr(r),s=i.call(r,e);s||(e=tx(e),s=i.call(r,e));let o=l.call(r,e);return r.set(e,n),s?Z(n,o)&&eK(r,"set",e,n):eK(r,"add",e,n),this},delete(e){let t=tx(this),{has:n,get:r}=tr(t),i=n.call(t,e);i||(e=tx(e),i=n.call(t,e)),r&&r.call(t,e);let l=t.delete(e);return i&&eK(t,"delete",e,void 0),l},clear(){let e=tx(this),t=0!==e.size,n=e.clear();return t&&eK(e,"clear",void 0,void 0),n}}),["keys","values","entries",Symbol.iterator].forEach(r=>{n[r]=function(...n){let i=this.__v_raw,l=tx(i),s=E(l),o="entries"===r||r===Symbol.iterator&&s,a=i[r](...n),c=t?tn:e?tT:tk;return e||eW(l,"iterate","keys"===r&&s?eH:ej),{next(){let{value:e,done:t}=a.next();return t?{value:e,done:t}:{value:o?[c(e[0]),c(e[1])]:c(e),done:t}},[Symbol.iterator](){return this}}}}),n}(e,t);return(t,r,i)=>"__v_isReactive"===r?!e:"__v_isReadonly"===r?e:"__v_raw"===r?t:Reflect.get(w(n,r)&&r in t?n:t,r,i)}let ts={get:tl(!1,!1)},to={get:tl(!1,!0)},ta={get:tl(!0,!1)},tc={get:tl(!0,!0)},tu=new WeakMap,td=new WeakMap,tp=new WeakMap,tf=new WeakMap;function th(e){return tb(e)?e:ty(e,!1,e9,ts,tu)}function tm(e){return ty(e,!1,te,to,td)}function tg(e){return ty(e,!0,e7,ta,tp)}function ty(e,t,n,r,i){if(!$(e)||e.__v_raw&&!(t&&e.__v_isReactive))return e;let l=i.get(e);if(l)return l;let s=e.__v_skip||!Object.isExtensible(e)?0:function(e){switch(e){case"Object":case"Array":return 1;case"Map":case"Set":case"WeakMap":case"WeakSet":return 2;default:return 0}}(B(e));if(0===s)return e;let o=new Proxy(e,2===s?r:n);return i.set(e,o),o}function tv(e){return tb(e)?tv(e.__v_raw):!!(e&&e.__v_isReactive)}function tb(e){return!!(e&&e.__v_isReadonly)}function t_(e){return!!(e&&e.__v_isShallow)}function tS(e){return!!e&&!!e.__v_raw}function tx(e){let t=e&&e.__v_raw;return t?tx(t):e}function tC(e){return!w(e,"__v_skip")&&Object.isExtensible(e)&&ee(e,"__v_skip",!0),e}let tk=e=>$(e)?th(e):e,tT=e=>$(e)?tg(e):e;function tN(e){return!!e&&!0===e.__v_isRef}function tw(e){return tE(e,!1)}function tA(e){return tE(e,!0)}function tE(e,t){return tN(e)?e:new tI(e,t)}class tI{constructor(e,t){this.dep=new eB,this.__v_isRef=!0,this.__v_isShallow=!1,this._rawValue=t?e:tx(e),this._value=t?e:tk(e),this.__v_isShallow=t}get value(){return this.dep.track(),this._value}set value(e){let t=this._rawValue,n=this.__v_isShallow||t_(e)||tb(e);Z(e=n?e:tx(e),t)&&(this._rawValue=e,this._value=n?e:tk(e),this.dep.trigger())}}function tR(e){return tN(e)?e.value:e}let tO={get:(e,t,n)=>"__v_raw"===t?e:tR(Reflect.get(e,t,n)),set:(e,t,n,r)=>{let i=e[t];return tN(i)&&!tN(n)?(i.value=n,!0):Reflect.set(e,t,n,r)}};function tP(e){return tv(e)?e:new Proxy(e,tO)}class tM{constructor(e){this.__v_isRef=!0,this._value=void 0;let t=this.dep=new eB,{get:n,set:r}=e(t.track.bind(t),t.trigger.bind(t));this._get=n,this._set=r}get value(){return this._value=this._get()}set value(e){this._set(e)}}function tL(e){return new tM(e)}class t${constructor(e,t,n){this._object=e,this._key=t,this._defaultValue=n,this.__v_isRef=!0,this._value=void 0}get value(){let e=this._object[this._key];return this._value=void 0===e?this._defaultValue:e}set value(e){this._object[this._key]=e}get dep(){return function(e,t){let n=eU.get(e);return n&&n.get(t)}(tx(this._object),this._key)}}class tD{constructor(e){this._getter=e,this.__v_isRef=!0,this.__v_isReadonly=!0,this._value=void 0}get value(){return this._value=this._getter()}}function tF(e,t,n){let r=e[t];return tN(r)?r:new t$(e,t,n)}class tV{constructor(e,t,n){this.fn=e,this.setter=t,this._value=void 0,this.dep=new eB(this),this.__v_isRef=!0,this.deps=void 0,this.depsTail=void 0,this.flags=16,this.globalVersion=eF-1,this.next=void 0,this.effect=this,this.__v_isReadonly=!t,this.isSSR=n}notify(){if(this.flags|=16,!(8&this.flags)&&l!==this)return eN(this,!0),!0}get value(){let e=this.dep.track();return eR(this),e&&(e.version=this.dep.version),this._value}set value(e){this.setter&&this.setter(e)}}let tB={},tU=new WeakMap;function tj(e,t=!1,n=h){if(n){let t=tU.get(n);t||tU.set(n,t=[]),t.push(e)}}function tH(e,t=1/0,n){if(t<=0||!$(e)||e.__v_skip||(n=n||new Set).has(e))return e;if(n.add(e),t--,tN(e))tH(e.value,t,n);else if(A(e))for(let r=0;r<e.length;r++)tH(e[r],t,n);else if(I(e)||E(e))e.forEach(e=>{tH(e,t,n)});else if(U(e)){for(let r in e)tH(e[r],t,n);for(let r of Object.getOwnPropertySymbols(e))Object.prototype.propertyIsEnumerable.call(e,r)&&tH(e[r],t,n)}return e}function tq(e,t,n,r){try{return r?e(...r):e()}catch(e){tK(e,t,n)}}function tW(e,t,n,r){if(P(e)){let i=tq(e,t,n,r);return i&&D(i)&&i.catch(e=>{tK(e,t,n)}),i}if(A(e)){let i=[];for(let l=0;l<e.length;l++)i.push(tW(e[l],t,n,r));return i}}function tK(e,t,n,r=!0){t&&t.vnode;let{errorHandler:i,throwUnhandledErrorInProduction:l}=t&&t.appContext.config||y;if(t){let r=t.parent,l=t.proxy,s=`https://vuejs.org/error-reference/#runtime-${n}`;for(;r;){let t=r.ec;if(t){for(let n=0;n<t.length;n++)if(!1===t[n](e,l,s))return}r=r.parent}if(i){eL(),tq(i,null,10,[e,l,s]),e$();return}}!function(e,t,n,r=!0,i=!1){if(i)throw e;console.error(e)}(e,0,0,r,l)}let tz=[],tJ=-1,tG=[],tX=null,tQ=0,tZ=Promise.resolve(),tY=null;function t0(e){let t=tY||tZ;return e?t.then(this?e.bind(this):e):t}function t1(e){if(!(1&e.flags)){let t=t8(e),n=tz[tz.length-1];!n||!(2&e.flags)&&t>=t8(n)?tz.push(e):tz.splice(function(e){let t=tJ+1,n=tz.length;for(;t<n;){let r=t+n>>>1,i=tz[r],l=t8(i);l<e||l===e&&2&i.flags?t=r+1:n=r}return t}(t),0,e),e.flags|=1,t2()}}function t2(){tY||(tY=tZ.then(function e(t){try{for(tJ=0;tJ<tz.length;tJ++){let e=tz[tJ];!e||8&e.flags||(4&e.flags&&(e.flags&=-2),tq(e,e.i,e.i?15:14),4&e.flags||(e.flags&=-2))}}finally{for(;tJ<tz.length;tJ++){let e=tz[tJ];e&&(e.flags&=-2)}tJ=-1,tz.length=0,t4(),tY=null,(tz.length||tG.length)&&e()}}))}function t3(e){A(e)?tG.push(...e):tX&&-1===e.id?tX.splice(tQ+1,0,e):1&e.flags||(tG.push(e),e.flags|=1),t2()}function t6(e,t,n=tJ+1){for(;n<tz.length;n++){let t=tz[n];if(t&&2&t.flags){if(e&&t.id!==e.uid)continue;tz.splice(n,1),n--,4&t.flags&&(t.flags&=-2),t(),4&t.flags||(t.flags&=-2)}}}function t4(e){if(tG.length){let e=[...new Set(tG)].sort((e,t)=>t8(e)-t8(t));if(tG.length=0,tX){tX.push(...e);return}for(tQ=0,tX=e;tQ<tX.length;tQ++){let e=tX[tQ];4&e.flags&&(e.flags&=-2),8&e.flags||e(),e.flags&=-2}tX=null,tQ=0}}let t8=e=>null==e.id?2&e.flags?-1:1/0:e.id,t5=null,t9=null;function t7(e){let t=t5;return t5=e,t9=e&&e.type.__scopeId||null,t}function ne(e,t=t5,n){if(!t||e._n)return e;let r=(...n)=>{let i;r._d&&im(-1);let l=t7(t);try{i=e(...n)}finally{t7(l),r._d&&im(1)}return i};return r._n=!0,r._c=!0,r._d=!0,r}function nt(e,t,n,r){let i=e.dirs,l=t&&t.dirs;for(let s=0;s<i.length;s++){let o=i[s];l&&(o.oldValue=l[s].value);let a=o.dir[r];a&&(eL(),tW(a,n,8,[e.el,o,e,t]),e$())}}let nn=Symbol("_vte"),nr=e=>e.__isTeleport,ni=e=>e&&(e.disabled||""===e.disabled),nl=e=>e&&(e.defer||""===e.defer),ns=e=>"undefined"!=typeof SVGElement&&e instanceof SVGElement,no=e=>"function"==typeof MathMLElement&&e instanceof MathMLElement,na=(e,t)=>{let n=e&&e.to;return M(n)?t?t(n):null:n},nc={name:"Teleport",__isTeleport:!0,process(e,t,n,r,i,l,s,o,a,c){let{mc:u,pc:d,pbc:p,o:{insert:f,querySelector:h,createText:m,createComment:g}}=c,y=ni(t.props),{shapeFlag:b,children:_,dynamicChildren:S}=t;if(null==e){let e=t.el=m(""),c=t.anchor=m("");f(e,n,r),f(c,n,r);let d=(e,t)=>{16&b&&(i&&i.isCE&&(i.ce._teleportTarget=e),u(_,e,t,i,l,s,o,a))},p=()=>{let e=t.target=na(t.props,h),n=np(e,t,m,f);e&&("svg"!==s&&ns(e)?s="svg":"mathml"!==s&&no(e)&&(s="mathml"),y||(d(e,n),nd(t,!1)))};y&&(d(n,c),nd(t,!0)),nl(t.props)?rB(()=>{p(),t.el.__isMounted=!0},l):p()}else{if(nl(t.props)&&!e.el.__isMounted){rB(()=>{nc.process(e,t,n,r,i,l,s,o,a,c),delete e.el.__isMounted},l);return}t.el=e.el,t.targetStart=e.targetStart;let u=t.anchor=e.anchor,f=t.target=e.target,m=t.targetAnchor=e.targetAnchor,g=ni(e.props),b=g?n:f;if("svg"===s||ns(f)?s="svg":("mathml"===s||no(f))&&(s="mathml"),S?(p(e.dynamicChildren,S,b,i,l,s,o),rK(e,t,!0)):a||d(e,t,b,g?u:m,i,l,s,o,!1),y)g?t.props&&e.props&&t.props.to!==e.props.to&&(t.props.to=e.props.to):nu(t,n,u,c,1);else if((t.props&&t.props.to)!==(e.props&&e.props.to)){let e=t.target=na(t.props,h);e&&nu(t,e,null,c,0)}else g&&nu(t,f,m,c,1);nd(t,y)}},remove(e,t,n,{um:r,o:{remove:i}},l){let{shapeFlag:s,children:o,anchor:a,targetStart:c,targetAnchor:u,target:d,props:p}=e;if(d&&(i(c),i(u)),l&&i(a),16&s){let e=l||!ni(p);for(let i=0;i<o.length;i++){let l=o[i];r(l,t,n,e,!!l.dynamicChildren)}}},move:nu,hydrate:function(e,t,n,r,i,l,{o:{nextSibling:s,parentNode:o,querySelector:a,insert:c,createText:u}},d){let p=t.target=na(t.props,a);if(p){let a=ni(t.props),f=p._lpa||p.firstChild;if(16&t.shapeFlag){if(a)t.anchor=d(s(e),t,o(e),n,r,i,l),t.targetStart=f,t.targetAnchor=f&&s(f);else{t.anchor=s(e);let o=f;for(;o;){if(o&&8===o.nodeType){if("teleport start anchor"===o.data)t.targetStart=o;else if("teleport anchor"===o.data){t.targetAnchor=o,p._lpa=t.targetAnchor&&s(t.targetAnchor);break}}o=s(o)}t.targetAnchor||np(p,t,u,c),d(f&&s(f),t,p,n,r,i,l)}}nd(t,a)}return t.anchor&&s(t.anchor)}};function nu(e,t,n,{o:{insert:r},m:i},l=2){0===l&&r(e.targetAnchor,t,n);let{el:s,anchor:o,shapeFlag:a,children:c,props:u}=e,d=2===l;if(d&&r(s,t,n),(!d||ni(u))&&16&a)for(let e=0;e<c.length;e++)i(c[e],t,n,2);d&&r(o,t,n)}function nd(e,t){let n=e.ctx;if(n&&n.ut){let r,i;for(t?(r=e.el,i=e.anchor):(r=e.targetStart,i=e.targetAnchor);r&&r!==i;)1===r.nodeType&&r.setAttribute("data-v-owner",n.uid),r=r.nextSibling;n.ut()}}function np(e,t,n,r){let i=t.targetStart=n(""),l=t.targetAnchor=n("");return i[nn]=l,e&&(r(i,e),r(l,e)),l}let nf=Symbol("_leaveCb"),nh=Symbol("_enterCb");function nm(){let e={isMounted:!1,isLeaving:!1,isUnmounting:!1,leavingVNodes:new Map};return n0(()=>{e.isMounted=!0}),n3(()=>{e.isUnmounting=!0}),e}let ng=[Function,Array],ny={mode:String,appear:Boolean,persisted:Boolean,onBeforeEnter:ng,onEnter:ng,onAfterEnter:ng,onEnterCancelled:ng,onBeforeLeave:ng,onLeave:ng,onAfterLeave:ng,onLeaveCancelled:ng,onBeforeAppear:ng,onAppear:ng,onAfterAppear:ng,onAppearCancelled:ng},nv=e=>{let t=e.subTree;return t.component?nv(t.component):t};function nb(e){let t=e[0];if(e.length>1){for(let n of e)if(n.type!==io){t=n;break}}return t}let n_={name:"BaseTransition",props:ny,setup(e,{slots:t}){let n=iL(),r=nm();return()=>{let i=t.default&&nN(t.default(),!0);if(!i||!i.length)return;let l=nb(i),s=tx(e),{mode:o}=s;if(r.isLeaving)return nC(l);let a=nk(l);if(!a)return nC(l);let c=nx(a,s,r,n,e=>c=e);a.type!==io&&nT(a,c);let u=n.subTree&&nk(n.subTree);if(u&&u.type!==io&&!ib(a,u)&&nv(n).type!==io){let e=nx(u,s,r,n);if(nT(u,e),"out-in"===o&&a.type!==io)return r.isLeaving=!0,e.afterLeave=()=>{r.isLeaving=!1,8&n.job.flags||n.update(),delete e.afterLeave,u=void 0},nC(l);"in-out"===o&&a.type!==io?e.delayLeave=(e,t,n)=>{nS(r,u)[String(u.key)]=u,e[nf]=()=>{t(),e[nf]=void 0,delete c.delayedLeave,u=void 0},c.delayedLeave=()=>{n(),delete c.delayedLeave,u=void 0}}:u=void 0}else u&&(u=void 0);return l}}};function nS(e,t){let{leavingVNodes:n}=e,r=n.get(t.type);return r||(r=Object.create(null),n.set(t.type,r)),r}function nx(e,t,n,r,i){let{appear:l,mode:s,persisted:o=!1,onBeforeEnter:a,onEnter:c,onAfterEnter:u,onEnterCancelled:d,onBeforeLeave:p,onLeave:f,onAfterLeave:h,onLeaveCancelled:m,onBeforeAppear:g,onAppear:y,onAfterAppear:b,onAppearCancelled:_}=t,S=String(e.key),x=nS(n,e),C=(e,t)=>{e&&tW(e,r,9,t)},k=(e,t)=>{let n=t[1];C(e,t),A(e)?e.every(e=>e.length<=1)&&n():e.length<=1&&n()},T={mode:s,persisted:o,beforeEnter(t){let r=a;if(!n.isMounted){if(!l)return;r=g||a}t[nf]&&t[nf](!0);let i=x[S];i&&ib(e,i)&&i.el[nf]&&i.el[nf](),C(r,[t])},enter(e){let t=c,r=u,i=d;if(!n.isMounted){if(!l)return;t=y||c,r=b||u,i=_||d}let s=!1,o=e[nh]=t=>{s||(s=!0,t?C(i,[e]):C(r,[e]),T.delayedLeave&&T.delayedLeave(),e[nh]=void 0)};t?k(t,[e,o]):o()},leave(t,r){let i=String(e.key);if(t[nh]&&t[nh](!0),n.isUnmounting)return r();C(p,[t]);let l=!1,s=t[nf]=n=>{l||(l=!0,r(),n?C(m,[t]):C(h,[t]),t[nf]=void 0,x[i]!==e||delete x[i])};x[i]=e,f?k(f,[t,s]):s()},clone(e){let l=nx(e,t,n,r,i);return i&&i(l),l}};return T}function nC(e){if(nq(e))return(e=iT(e)).children=null,e}function nk(e){if(!nq(e))return nr(e.type)&&e.children?nb(e.children):e;let{shapeFlag:t,children:n}=e;if(n){if(16&t)return n[0];if(32&t&&P(n.default))return n.default()}}function nT(e,t){6&e.shapeFlag&&e.component?(e.transition=t,nT(e.component.subTree,t)):128&e.shapeFlag?(e.ssContent.transition=t.clone(e.ssContent),e.ssFallback.transition=t.clone(e.ssFallback)):e.transition=t}function nN(e,t=!1,n){let r=[],i=0;for(let l=0;l<e.length;l++){let s=e[l],o=null==n?s.key:String(n)+String(null!=s.key?s.key:l);s.type===il?(128&s.patchFlag&&i++,r=r.concat(nN(s.children,t,o))):(t||s.type!==io)&&r.push(null!=o?iT(s,{key:o}):s)}if(i>1)for(let e=0;e<r.length;e++)r[e].patchFlag=-2;return r}function nw(e,t){return P(e)?k({name:e.name},t,{setup:e}):e}function nA(e){e.ids=[e.ids[0]+e.ids[2]+++"-",0,0]}function nE(e,t,n,r,i=!1){if(A(e)){e.forEach((e,l)=>nE(e,t&&(A(t)?t[l]:t),n,r,i));return}if(nj(r)&&!i){512&r.shapeFlag&&r.type.__asyncResolved&&r.component.subTree.component&&nE(e,t,n,r.component.subTree);return}let l=4&r.shapeFlag?iW(r.component):r.el,s=i?null:l,{i:o,r:a}=e,c=t&&t.r,u=o.refs===y?o.refs={}:o.refs,d=o.setupState,p=tx(d),f=d===y?()=>!1:e=>w(p,e);if(null!=c&&c!==a&&(M(c)?(u[c]=null,f(c)&&(d[c]=null)):tN(c)&&(c.value=null)),P(a))tq(a,o,12,[s,u]);else{let t=M(a),r=tN(a);if(t||r){let o=()=>{if(e.f){let n=t?f(a)?d[a]:u[a]:a.value;i?A(n)&&T(n,l):A(n)?n.includes(l)||n.push(l):t?(u[a]=[l],f(a)&&(d[a]=u[a])):(a.value=[l],e.k&&(u[e.k]=a.value))}else t?(u[a]=s,f(a)&&(d[a]=s)):r&&(a.value=s,e.k&&(u[e.k]=s))};s?(o.id=-1,rB(o,n)):o()}}}let nI=!1,nR=()=>{nI||(console.error("Hydration completed but contains mismatches."),nI=!0)},nO=e=>e.namespaceURI.includes("svg")&&"foreignObject"!==e.tagName,nP=e=>e.namespaceURI.includes("MathML"),nM=e=>{if(1===e.nodeType){if(nO(e))return"svg";if(nP(e))return"mathml"}},nL=e=>8===e.nodeType;function n$(e){let{mt:t,p:n,o:{patchProp:r,createText:i,nextSibling:l,parentNode:s,remove:o,insert:a,createComment:c}}=e,u=(n,r,o,c,b,_=!1)=>{_=_||!!r.dynamicChildren;let S=nL(n)&&"["===n.data,x=()=>h(n,r,o,c,b,S),{type:C,ref:k,shapeFlag:T,patchFlag:N}=r,w=n.nodeType;r.el=n,-2===N&&(_=!1,r.dynamicChildren=null);let A=null;switch(C){case is:3!==w?""===r.children?(a(r.el=i(""),s(n),n),A=n):A=x():(n.data!==r.children&&(nR(),n.data=r.children),A=l(n));break;case io:y(n)?(A=l(n),g(r.el=n.content.firstChild,n,o)):A=8!==w||S?x():l(n);break;case ia:if(S&&(w=(n=l(n)).nodeType),1===w||3===w){A=n;let e=!r.children.length;for(let t=0;t<r.staticCount;t++)e&&(r.children+=1===A.nodeType?A.outerHTML:A.data),t===r.staticCount-1&&(r.anchor=A),A=l(A);return S?l(A):A}x();break;case il:A=S?f(n,r,o,c,b,_):x();break;default:if(1&T)A=1===w&&r.type.toLowerCase()===n.tagName.toLowerCase()||y(n)?d(n,r,o,c,b,_):x();else if(6&T){r.slotScopeIds=b;let e=s(n);if(A=S?m(n):nL(n)&&"teleport start"===n.data?m(n,n.data,"teleport end"):l(n),t(r,e,null,o,c,nM(e),_),nj(r)&&!r.type.__asyncResolved){let t;S?(t=iC(il)).anchor=A?A.previousSibling:e.lastChild:t=3===n.nodeType?iN(""):iC("div"),t.el=n,r.component.subTree=t}}else 64&T?A=8!==w?x():r.type.hydrate(n,r,o,c,b,_,e,p):128&T&&(A=r.type.hydrate(n,r,o,c,nM(s(n)),b,_,e,u))}return null!=k&&nE(k,null,c,r),A},d=(e,t,n,i,l,s)=>{s=s||!!t.dynamicChildren;let{type:a,props:c,patchFlag:u,shapeFlag:d,dirs:f,transition:h}=t,m="input"===a||"option"===a;if(m||-1!==u){let a;f&&nt(t,null,n,"created");let b=!1;if(y(e)){b=rW(null,h)&&n&&n.vnode.props&&n.vnode.props.appear;let r=e.content.firstChild;b&&h.beforeEnter(r),g(r,e,n),t.el=e=r}if(16&d&&!(c&&(c.innerHTML||c.textContent))){let r=p(e.firstChild,t,e,n,i,l,s);for(;r;){nV(e,1)||nR();let t=r;r=r.nextSibling,o(t)}}else if(8&d){let n=t.children;"\n"===n[0]&&("PRE"===e.tagName||"TEXTAREA"===e.tagName)&&(n=n.slice(1)),e.textContent!==n&&(nV(e,0)||nR(),e.textContent=t.children)}if(c){if(m||!s||48&u){let t=e.tagName.includes("-");for(let i in c)(m&&(i.endsWith("value")||"indeterminate"===i)||x(i)&&!H(i)||"."===i[0]||t)&&r(e,i,null,c[i],void 0,n)}else if(c.onClick)r(e,"onClick",null,c.onClick,void 0,n);else if(4&u&&tv(c.style))for(let e in c.style)c.style[e]}(a=c&&c.onVnodeBeforeMount)&&iR(a,n,t),f&&nt(t,null,n,"beforeMount"),((a=c&&c.onVnodeMounted)||f||b)&&ir(()=>{a&&iR(a,n,t),b&&h.enter(e),f&&nt(t,null,n,"mounted")},i)}return e.nextSibling},p=(e,t,r,s,o,c,d)=>{d=d||!!t.dynamicChildren;let p=t.children,f=p.length;for(let t=0;t<f;t++){let h=d?p[t]:p[t]=iw(p[t]),m=h.type===is;e?(m&&!d&&t+1<f&&iw(p[t+1]).type===is&&(a(i(e.data.slice(h.children.length)),r,l(e)),e.data=h.children),e=u(e,h,s,o,c,d)):m&&!h.children?a(h.el=i(""),r):(nV(r,1)||nR(),n(null,h,r,null,s,o,nM(r),c))}return e},f=(e,t,n,r,i,o)=>{let{slotScopeIds:u}=t;u&&(i=i?i.concat(u):u);let d=s(e),f=p(l(e),t,d,n,r,i,o);return f&&nL(f)&&"]"===f.data?l(t.anchor=f):(nR(),a(t.anchor=c("]"),d,f),f)},h=(e,t,r,i,a,c)=>{if(nV(e.parentElement,1)||nR(),t.el=null,c){let t=m(e);for(;;){let n=l(e);if(n&&n!==t)o(n);else break}}let u=l(e),d=s(e);return o(e),n(null,t,d,u,r,i,nM(d),a),r&&(r.vnode.el=t.el,r8(r,t.el)),u},m=(e,t="[",n="]")=>{let r=0;for(;e;)if((e=l(e))&&nL(e)&&(e.data===t&&r++,e.data===n)){if(0===r)return l(e);r--}return e},g=(e,t,n)=>{let r=t.parentNode;r&&r.replaceChild(e,t);let i=n;for(;i;)i.vnode.el===t&&(i.vnode.el=i.subTree.el=e),i=i.parent},y=e=>1===e.nodeType&&"TEMPLATE"===e.tagName;return[(e,t)=>{if(!t.hasChildNodes()){n(null,e,t),t4(),t._vnode=e;return}u(t.firstChild,e,null,null,null),t4(),t._vnode=e},u]}let nD="data-allow-mismatch",nF={0:"text",1:"children",2:"class",3:"style",4:"attribute"};function nV(e,t){if(0===t||1===t)for(;e&&!e.hasAttribute(nD);)e=e.parentElement;let n=e&&e.getAttribute(nD);if(null==n)return!1;if(""===n)return!0;{let e=n.split(",");return!!(0===t&&e.includes("children"))||n.split(",").includes(nF[t])}}let nB=er().requestIdleCallback||(e=>setTimeout(e,1)),nU=er().cancelIdleCallback||(e=>clearTimeout(e)),nj=e=>!!e.type.__asyncLoader;function nH(e,t){let{ref:n,props:r,children:i,ce:l}=t.vnode,s=iC(e,r,i);return s.ref=n,s.ce=l,delete t.vnode.ce,s}let nq=e=>e.type.__isKeepAlive;function nW(e,t){return A(e)?e.some(e=>nW(e,t)):M(e)?e.split(",").includes(t):!!O(e)&&(e.lastIndex=0,e.test(t))}function nK(e,t){nJ(e,"a",t)}function nz(e,t){nJ(e,"da",t)}function nJ(e,t,n=iM){let r=e.__wdc||(e.__wdc=()=>{let t=n;for(;t;){if(t.isDeactivated)return;t=t.parent}return e()});if(nQ(t,r,n),n){let e=n.parent;for(;e&&e.parent;)nq(e.parent.vnode)&&function(e,t,n,r){let i=nQ(t,e,r,!0);n6(()=>{T(r[t],i)},n)}(r,t,n,e),e=e.parent}}function nG(e){e.shapeFlag&=-257,e.shapeFlag&=-513}function nX(e){return 128&e.shapeFlag?e.ssContent:e}function nQ(e,t,n=iM,r=!1){if(n){let i=n[e]||(n[e]=[]),l=t.__weh||(t.__weh=(...r)=>{eL();let i=i$(n),l=tW(t,n,e,r);return i(),e$(),l});return r?i.unshift(l):i.push(l),l}}let nZ=e=>(t,n=iM)=>{iV&&"sp"!==e||nQ(e,(...e)=>t(...e),n)},nY=nZ("bm"),n0=nZ("m"),n1=nZ("bu"),n2=nZ("u"),n3=nZ("bum"),n6=nZ("um"),n4=nZ("sp"),n8=nZ("rtg"),n5=nZ("rtc");function n9(e,t=iM){nQ("ec",e,t)}let n7="components",re=Symbol.for("v-ndc");function rt(e,t,n=!0,r=!1){let i=t5||iM;if(i){let n=i.type;if(e===n7){let e=iK(n,!1);if(e&&(e===t||e===z(t)||e===X(z(t))))return n}let l=rn(i[e]||n[e],t)||rn(i.appContext[e],t);return!l&&r?n:l}}function rn(e,t){return e&&(e[t]||e[z(t)]||e[X(z(t))])}let rr=e=>e?iF(e)?iW(e):rr(e.parent):null,ri=k(Object.create(null),{$:e=>e,$el:e=>e.vnode.el,$data:e=>e.data,$props:e=>e.props,$attrs:e=>e.attrs,$slots:e=>e.slots,$refs:e=>e.refs,$parent:e=>rr(e.parent),$root:e=>rr(e.root),$host:e=>e.ce,$emit:e=>e.emit,$options:e=>rp(e),$forceUpdate:e=>e.f||(e.f=()=>{t1(e.update)}),$nextTick:e=>e.n||(e.n=t0.bind(e.proxy)),$watch:e=>rQ.bind(e)}),rl=(e,t)=>e!==y&&!e.__isScriptSetup&&w(e,t),rs={get({_:e},t){let n,r,i;if("__v_skip"===t)return!0;let{ctx:l,setupState:s,data:o,props:a,accessCache:c,type:u,appContext:d}=e;if("$"!==t[0]){let r=c[t];if(void 0!==r)switch(r){case 1:return s[t];case 2:return o[t];case 4:return l[t];case 3:return a[t]}else{if(rl(s,t))return c[t]=1,s[t];if(o!==y&&w(o,t))return c[t]=2,o[t];if((n=e.propsOptions[0])&&w(n,t))return c[t]=3,a[t];if(l!==y&&w(l,t))return c[t]=4,l[t];ru&&(c[t]=0)}}let p=ri[t];return p?("$attrs"===t&&eW(e.attrs,"get",""),p(e)):(r=u.__cssModules)&&(r=r[t])?r:l!==y&&w(l,t)?(c[t]=4,l[t]):w(i=d.config.globalProperties,t)?i[t]:void 0},set({_:e},t,n){let{data:r,setupState:i,ctx:l}=e;return rl(i,t)?(i[t]=n,!0):r!==y&&w(r,t)?(r[t]=n,!0):!w(e.props,t)&&!("$"===t[0]&&t.slice(1)in e)&&(l[t]=n,!0)},has({_:{data:e,setupState:t,accessCache:n,ctx:r,appContext:i,propsOptions:l}},s){let o;return!!n[s]||e!==y&&w(e,s)||rl(t,s)||(o=l[0])&&w(o,s)||w(r,s)||w(ri,s)||w(i.config.globalProperties,s)},defineProperty(e,t,n){return null!=n.get?e._.accessCache[t]=0:w(n,"value")&&this.set(e,t,n.value,null),Reflect.defineProperty(e,t,n)}},ro=k({},rs,{get(e,t){if(t!==Symbol.unscopables)return rs.get(e,t,e)},has:(e,t)=>"_"!==t[0]&&!ei(t)});function ra(){let e=iL();return e.setupContext||(e.setupContext=iq(e))}function rc(e){return A(e)?e.reduce((e,t)=>(e[t]=null,e),{}):e}let ru=!0;function rd(e,t,n){tW(A(e)?e.map(e=>e.bind(t.proxy)):e.bind(t.proxy),t,n)}function rp(e){let t;let n=e.type,{mixins:r,extends:i}=n,{mixins:l,optionsCache:s,config:{optionMergeStrategies:o}}=e.appContext,a=s.get(n);return a?t=a:l.length||r||i?(t={},l.length&&l.forEach(e=>rf(t,e,o,!0)),rf(t,n,o)):t=n,$(n)&&s.set(n,t),t}function rf(e,t,n,r=!1){let{mixins:i,extends:l}=t;for(let s in l&&rf(e,l,n,!0),i&&i.forEach(t=>rf(e,t,n,!0)),t)if(r&&"expose"===s);else{let r=rh[s]||n&&n[s];e[s]=r?r(e[s],t[s]):t[s]}return e}let rh={data:rm,props:rb,emits:rb,methods:rv,computed:rv,beforeCreate:ry,created:ry,beforeMount:ry,mounted:ry,beforeUpdate:ry,updated:ry,beforeDestroy:ry,beforeUnmount:ry,destroyed:ry,unmounted:ry,activated:ry,deactivated:ry,errorCaptured:ry,serverPrefetch:ry,components:rv,directives:rv,watch:function(e,t){if(!e)return t;if(!t)return e;let n=k(Object.create(null),e);for(let r in t)n[r]=ry(e[r],t[r]);return n},provide:rm,inject:function(e,t){return rv(rg(e),rg(t))}};function rm(e,t){return t?e?function(){return k(P(e)?e.call(this,this):e,P(t)?t.call(this,this):t)}:t:e}function rg(e){if(A(e)){let t={};for(let n=0;n<e.length;n++)t[e[n]]=e[n];return t}return e}function ry(e,t){return e?[...new Set([].concat(e,t))]:t}function rv(e,t){return e?k(Object.create(null),e,t):t}function rb(e,t){return e?A(e)&&A(t)?[...new Set([...e,...t])]:k(Object.create(null),rc(e),rc(null!=t?t:{})):t}function r_(){return{app:null,config:{isNativeTag:S,performance:!1,globalProperties:{},optionMergeStrategies:{},errorHandler:void 0,warnHandler:void 0,compilerOptions:{}},mixins:[],components:{},directives:{},provides:Object.create(null),optionsCache:new WeakMap,propsCache:new WeakMap,emitsCache:new WeakMap}}let rS=0,rx=null;function rC(e,t){if(iM){let n=iM.provides,r=iM.parent&&iM.parent.provides;r===n&&(n=iM.provides=Object.create(r)),n[e]=t}}function rk(e,t,n=!1){let r=iM||t5;if(r||rx){let i=rx?rx._context.provides:r?null==r.parent?r.vnode.appContext&&r.vnode.appContext.provides:r.parent.provides:void 0;if(i&&e in i)return i[e];if(arguments.length>1)return n&&P(t)?t.call(r&&r.proxy):t}}let rT={},rN=()=>Object.create(rT),rw=e=>Object.getPrototypeOf(e)===rT;function rA(e,t,n,r){let i;let[l,s]=e.propsOptions,o=!1;if(t)for(let a in t){let c;if(H(a))continue;let u=t[a];l&&w(l,c=z(a))?s&&s.includes(c)?(i||(i={}))[c]=u:n[c]=u:r1(e.emitsOptions,a)||a in r&&u===r[a]||(r[a]=u,o=!0)}if(s){let t=tx(n),r=i||y;for(let i=0;i<s.length;i++){let o=s[i];n[o]=rE(l,t,o,r[o],e,!w(r,o))}}return o}function rE(e,t,n,r,i,l){let s=e[n];if(null!=s){let e=w(s,"default");if(e&&void 0===r){let e=s.default;if(s.type!==Function&&!s.skipFactory&&P(e)){let{propsDefaults:l}=i;if(n in l)r=l[n];else{let s=i$(i);r=l[n]=e.call(null,t),s()}}else r=e;i.ce&&i.ce._setProp(n,r)}s[0]&&(l&&!e?r=!1:s[1]&&(""===r||r===G(n))&&(r=!0))}return r}let rI=new WeakMap;function rR(e){return!("$"===e[0]||H(e))}let rO=e=>"_"===e[0]||"$stable"===e,rP=e=>A(e)?e.map(iw):[iw(e)],rM=(e,t,n)=>{if(t._n)return t;let r=ne((...e)=>rP(t(...e)),n);return r._c=!1,r},rL=(e,t,n)=>{let r=e._ctx;for(let n in e){if(rO(n))continue;let i=e[n];if(P(i))t[n]=rM(n,i,r);else if(null!=i){let e=rP(i);t[n]=()=>e}}},r$=(e,t)=>{let n=rP(t);e.slots.default=()=>n},rD=(e,t,n)=>{for(let r in t)(n||"_"!==r)&&(e[r]=t[r])},rF=(e,t,n)=>{let r=e.slots=rN();if(32&e.vnode.shapeFlag){let e=t._;e?(rD(r,t,n),n&&ee(r,"_",e,!0)):rL(t,r)}else t&&r$(e,t)},rV=(e,t,n)=>{let{vnode:r,slots:i}=e,l=!0,s=y;if(32&r.shapeFlag){let e=t._;e?n&&1===e?l=!1:rD(i,t,n):(l=!t.$stable,rL(t,i)),s=t}else t&&(r$(e,t),s={default:1});if(l)for(let e in i)rO(e)||null!=s[e]||delete i[e]},rB=ir;function rU(e){return rj(e,n$)}function rj(e,t){var n;let r,i;er().__VUE__=!0;let{insert:l,remove:s,patchProp:o,createElement:a,createText:u,createComment:d,setText:p,setElementText:f,parentNode:h,nextSibling:m,setScopeId:g=_,insertStaticContent:S}=e,x=(e,t,n,r=null,i=null,l=null,s,o=null,a=!!t.dynamicChildren)=>{if(e===t)return;e&&!ib(e,t)&&(r=eo(e),et(e,i,l,!0),e=null),-2===t.patchFlag&&(a=!1,t.dynamicChildren=null);let{type:c,ref:u,shapeFlag:d}=t;switch(c){case is:C(e,t,n,r);break;case io:T(e,t,n,r);break;case ia:null==e&&N(t,n,r,s);break;case il:U(e,t,n,r,i,l,s,o,a);break;default:1&d?R(e,t,n,r,i,l,s,o,a):6&d?j(e,t,n,r,i,l,s,o,a):64&d?c.process(e,t,n,r,i,l,s,o,a,eu):128&d&&c.process(e,t,n,r,i,l,s,o,a,eu)}null!=u&&i&&nE(u,e&&e.ref,l,t||e,!t)},C=(e,t,n,r)=>{if(null==e)l(t.el=u(t.children),n,r);else{let n=t.el=e.el;t.children!==e.children&&p(n,t.children)}},T=(e,t,n,r)=>{null==e?l(t.el=d(t.children||""),n,r):t.el=e.el},N=(e,t,n,r)=>{[e.el,e.anchor]=S(e.children,t,n,r,e.el,e.anchor)},E=({el:e,anchor:t},n,r)=>{let i;for(;e&&e!==t;)i=m(e),l(e,n,r),e=i;l(t,n,r)},I=({el:e,anchor:t})=>{let n;for(;e&&e!==t;)n=m(e),s(e),e=n;s(t)},R=(e,t,n,r,i,l,s,o,a)=>{"svg"===t.type?s="svg":"math"===t.type&&(s="mathml"),null==e?O(t,n,r,i,l,s,o,a):F(e,t,i,l,s,o,a)},O=(e,t,n,r,i,s,c,u)=>{let d,p;let{props:h,shapeFlag:m,transition:g,dirs:y}=e;if(d=e.el=a(e.type,s,h&&h.is,h),8&m?f(d,e.children):16&m&&L(e.children,d,null,r,i,rH(e,s),c,u),y&&nt(e,null,r,"created"),M(d,e,e.scopeId,c,r),h){for(let e in h)"value"===e||H(e)||o(d,e,null,h[e],s,r);"value"in h&&o(d,"value",null,h.value,s),(p=h.onVnodeBeforeMount)&&iR(p,r,e)}y&&nt(e,null,r,"beforeMount");let b=rW(i,g);b&&g.beforeEnter(d),l(d,t,n),((p=h&&h.onVnodeMounted)||b||y)&&rB(()=>{p&&iR(p,r,e),b&&g.enter(d),y&&nt(e,null,r,"mounted")},i)},M=(e,t,n,r,i)=>{if(n&&g(e,n),r)for(let t=0;t<r.length;t++)g(e,r[t]);if(i){let n=i.subTree;if(t===n||r5(n.type)&&(n.ssContent===t||n.ssFallback===t)){let t=i.vnode;M(e,t,t.scopeId,t.slotScopeIds,i.parent)}}},L=(e,t,n,r,i,l,s,o,a=0)=>{for(let c=a;c<e.length;c++)x(null,e[c]=o?iA(e[c]):iw(e[c]),t,n,r,i,l,s,o)},F=(e,t,n,r,i,l,s)=>{let a;let c=t.el=e.el,{patchFlag:u,dynamicChildren:d,dirs:p}=t;u|=16&e.patchFlag;let h=e.props||y,m=t.props||y;if(n&&rq(n,!1),(a=m.onVnodeBeforeUpdate)&&iR(a,n,t,e),p&&nt(t,e,n,"beforeUpdate"),n&&rq(n,!0),(h.innerHTML&&null==m.innerHTML||h.textContent&&null==m.textContent)&&f(c,""),d?V(e.dynamicChildren,d,c,n,r,rH(t,i),l):s||X(e,t,c,null,n,r,rH(t,i),l,!1),u>0){if(16&u)B(c,h,m,n,i);else if(2&u&&h.class!==m.class&&o(c,"class",null,m.class,i),4&u&&o(c,"style",h.style,m.style,i),8&u){let e=t.dynamicProps;for(let t=0;t<e.length;t++){let r=e[t],l=h[r],s=m[r];(s!==l||"value"===r)&&o(c,r,l,s,i,n)}}1&u&&e.children!==t.children&&f(c,t.children)}else s||null!=d||B(c,h,m,n,i);((a=m.onVnodeUpdated)||p)&&rB(()=>{a&&iR(a,n,t,e),p&&nt(t,e,n,"updated")},r)},V=(e,t,n,r,i,l,s)=>{for(let o=0;o<t.length;o++){let a=e[o],c=t[o],u=a.el&&(a.type===il||!ib(a,c)||70&a.shapeFlag)?h(a.el):n;x(a,c,u,null,r,i,l,s,!0)}},B=(e,t,n,r,i)=>{if(t!==n){if(t!==y)for(let l in t)H(l)||l in n||o(e,l,t[l],null,i,r);for(let l in n){if(H(l))continue;let s=n[l],a=t[l];s!==a&&"value"!==l&&o(e,l,a,s,i,r)}"value"in n&&o(e,"value",t.value,n.value,i)}},U=(e,t,n,r,i,s,o,a,c)=>{let d=t.el=e?e.el:u(""),p=t.anchor=e?e.anchor:u(""),{patchFlag:f,dynamicChildren:h,slotScopeIds:m}=t;m&&(a=a?a.concat(m):m),null==e?(l(d,n,r),l(p,n,r),L(t.children||[],n,p,i,s,o,a,c)):f>0&&64&f&&h&&e.dynamicChildren?(V(e.dynamicChildren,h,n,i,s,o,a),(null!=t.key||i&&t===i.subTree)&&rK(e,t,!0)):X(e,t,n,p,i,s,o,a,c)},j=(e,t,n,r,i,l,s,o,a)=>{t.slotScopeIds=o,null==e?512&t.shapeFlag?i.ctx.activate(t,n,r,s,a):q(t,n,r,i,l,s,a):W(e,t,a)},q=(e,t,n,r,i,l,s)=>{let o=e.component=function(e,t,n){let r=e.type,i=(t?t.appContext:e.appContext)||iO,l={uid:iP++,vnode:e,type:r,parent:t,appContext:i,root:null,next:null,subTree:null,effect:null,update:null,job:null,scope:new ex(!0),render:null,proxy:null,exposed:null,exposeProxy:null,withProxy:null,provides:t?t.provides:Object.create(i.provides),ids:t?t.ids:["",0,0],accessCache:null,renderCache:[],components:null,directives:null,propsOptions:function e(t,n,r=!1){let i=r?rI:n.propsCache,l=i.get(t);if(l)return l;let s=t.props,o={},a=[],c=!1;if(!P(t)){let i=t=>{c=!0;let[r,i]=e(t,n,!0);k(o,r),i&&a.push(...i)};!r&&n.mixins.length&&n.mixins.forEach(i),t.extends&&i(t.extends),t.mixins&&t.mixins.forEach(i)}if(!s&&!c)return $(t)&&i.set(t,b),b;if(A(s))for(let e=0;e<s.length;e++){let t=z(s[e]);rR(t)&&(o[t]=y)}else if(s)for(let e in s){let t=z(e);if(rR(t)){let n=s[e],r=o[t]=A(n)||P(n)?{type:n}:k({},n),i=r.type,l=!1,c=!0;if(A(i))for(let e=0;e<i.length;++e){let t=i[e],n=P(t)&&t.name;if("Boolean"===n){l=!0;break}"String"===n&&(c=!1)}else l=P(i)&&"Boolean"===i.name;r[0]=l,r[1]=c,(l||w(r,"default"))&&a.push(t)}}let u=[o,a];return $(t)&&i.set(t,u),u}(r,i),emitsOptions:function e(t,n,r=!1){let i=n.emitsCache,l=i.get(t);if(void 0!==l)return l;let s=t.emits,o={},a=!1;if(!P(t)){let i=t=>{let r=e(t,n,!0);r&&(a=!0,k(o,r))};!r&&n.mixins.length&&n.mixins.forEach(i),t.extends&&i(t.extends),t.mixins&&t.mixins.forEach(i)}return s||a?(A(s)?s.forEach(e=>o[e]=null):k(o,s),$(t)&&i.set(t,o),o):($(t)&&i.set(t,null),null)}(r,i),emit:null,emitted:null,propsDefaults:y,inheritAttrs:r.inheritAttrs,ctx:y,data:y,props:y,attrs:y,slots:y,refs:y,setupState:y,setupContext:null,suspense:n,suspenseId:n?n.pendingId:0,asyncDep:null,asyncResolved:!1,isMounted:!1,isUnmounted:!1,isDeactivated:!1,bc:null,c:null,bm:null,m:null,bu:null,u:null,um:null,bum:null,da:null,a:null,rtg:null,rtc:null,ec:null,sp:null};return l.ctx={_:l},l.root=t?t.root:l,l.emit=r0.bind(null,l),e.ce&&e.ce(l),l}(e,r,i);nq(e)&&(o.ctx.renderer=eu),function(e,t=!1,n=!1){t&&c(t);let{props:r,children:i}=e.vnode,l=iF(e);(function(e,t,n,r=!1){let i={},l=rN();for(let n in e.propsDefaults=Object.create(null),rA(e,t,i,l),e.propsOptions[0])n in i||(i[n]=void 0);n?e.props=r?i:tm(i):e.type.props?e.props=i:e.props=l,e.attrs=l})(e,r,l,t),rF(e,i,n),l&&function(e,t){let n=e.type;e.accessCache=Object.create(null),e.proxy=new Proxy(e.ctx,rs);let{setup:r}=n;if(r){eL();let n=e.setupContext=r.length>1?iq(e):null,i=i$(e),l=tq(r,e,0,[e.props,n]),s=D(l);if(e$(),i(),(s||e.sp)&&!nj(e)&&nA(e),s){if(l.then(iD,iD),t)return l.then(n=>{iB(e,n,t)}).catch(t=>{tK(t,e,0)});e.asyncDep=l}else iB(e,l,t)}else ij(e,t)}(e,t),t&&c(!1)}(o,!1,s),o.asyncDep?(i&&i.registerDep(o,K,s),e.el||T(null,o.subTree=iC(io),t,n)):K(o,e,t,n,i,l,s)},W=(e,t,n)=>{let r=t.component=e.component;if(function(e,t,n){let{props:r,children:i,component:l}=e,{props:s,children:o,patchFlag:a}=t,c=l.emitsOptions;if(t.dirs||t.transition)return!0;if(!n||!(a>=0))return(!!i||!!o)&&(!o||!o.$stable)||r!==s&&(r?!s||r4(r,s,c):!!s);if(1024&a)return!0;if(16&a)return r?r4(r,s,c):!!s;if(8&a){let e=t.dynamicProps;for(let t=0;t<e.length;t++){let n=e[t];if(s[n]!==r[n]&&!r1(c,n))return!0}}return!1}(e,t,n)){if(r.asyncDep&&!r.asyncResolved){J(r,t,n);return}r.next=t,r.update()}else t.el=e.el,r.vnode=t},K=(e,t,n,r,l,s,o)=>{let a=()=>{if(e.isMounted){let t,{next:n,bu:r,u:i,parent:c,vnode:u}=e;{let t=function e(t){let n=t.subTree.component;if(n)return n.asyncDep&&!n.asyncResolved?n:e(n)}(e);if(t){n&&(n.el=u.el,J(e,n,o)),t.asyncDep.then(()=>{e.isUnmounted||a()});return}}let d=n;rq(e,!1),n?(n.el=u.el,J(e,n,o)):n=u,r&&Y(r),(t=n.props&&n.props.onVnodeBeforeUpdate)&&iR(t,c,n,u),rq(e,!0);let p=r2(e),f=e.subTree;e.subTree=p,x(f,p,h(f.el),eo(f),e,l,s),n.el=p.el,null===d&&r8(e,p.el),i&&rB(i,l),(t=n.props&&n.props.onVnodeUpdated)&&rB(()=>iR(t,c,n,u),l)}else{let o;let{el:a,props:c}=t,{bm:u,m:d,parent:p,root:f,type:h}=e,m=nj(t);if(rq(e,!1),u&&Y(u),!m&&(o=c&&c.onVnodeBeforeMount)&&iR(o,p,t),rq(e,!0),a&&i){let t=()=>{e.subTree=r2(e),i(a,e.subTree,e,l,null)};m&&h.__asyncHydrate?h.__asyncHydrate(a,e,t):t()}else{f.ce&&f.ce._injectChildStyle(h);let i=e.subTree=r2(e);x(null,i,n,r,e,l,s),t.el=i.el}if(d&&rB(d,l),!m&&(o=c&&c.onVnodeMounted)){let e=t;rB(()=>iR(o,p,e),l)}(256&t.shapeFlag||p&&nj(p.vnode)&&256&p.vnode.shapeFlag)&&e.a&&rB(e.a,l),e.isMounted=!0,t=n=r=null}};e.scope.on();let c=e.effect=new ek(a);e.scope.off();let u=e.update=c.run.bind(c),d=e.job=c.runIfDirty.bind(c);d.i=e,d.id=e.uid,c.scheduler=()=>t1(d),rq(e,!0),u()},J=(e,t,n)=>{t.component=e;let r=e.vnode.props;e.vnode=t,e.next=null,function(e,t,n,r){let{props:i,attrs:l,vnode:{patchFlag:s}}=e,o=tx(i),[a]=e.propsOptions,c=!1;if((r||s>0)&&!(16&s)){if(8&s){let n=e.vnode.dynamicProps;for(let r=0;r<n.length;r++){let s=n[r];if(r1(e.emitsOptions,s))continue;let u=t[s];if(a){if(w(l,s))u!==l[s]&&(l[s]=u,c=!0);else{let t=z(s);i[t]=rE(a,o,t,u,e,!1)}}else u!==l[s]&&(l[s]=u,c=!0)}}}else{let r;for(let s in rA(e,t,i,l)&&(c=!0),o)t&&(w(t,s)||(r=G(s))!==s&&w(t,r))||(a?n&&(void 0!==n[s]||void 0!==n[r])&&(i[s]=rE(a,o,s,void 0,e,!0)):delete i[s]);if(l!==o)for(let e in l)t&&w(t,e)||(delete l[e],c=!0)}c&&eK(e.attrs,"set","")}(e,t.props,r,n),rV(e,t.children,n),eL(),t6(e),e$()},X=(e,t,n,r,i,l,s,o,a=!1)=>{let c=e&&e.children,u=e?e.shapeFlag:0,d=t.children,{patchFlag:p,shapeFlag:h}=t;if(p>0){if(128&p){Z(c,d,n,r,i,l,s,o,a);return}if(256&p){Q(c,d,n,r,i,l,s,o,a);return}}8&h?(16&u&&es(c,i,l),d!==c&&f(n,d)):16&u?16&h?Z(c,d,n,r,i,l,s,o,a):es(c,i,l,!0):(8&u&&f(n,""),16&h&&L(d,n,r,i,l,s,o,a))},Q=(e,t,n,r,i,l,s,o,a)=>{let c;e=e||b,t=t||b;let u=e.length,d=t.length,p=Math.min(u,d);for(c=0;c<p;c++){let r=t[c]=a?iA(t[c]):iw(t[c]);x(e[c],r,n,null,i,l,s,o,a)}u>d?es(e,i,l,!0,!1,p):L(t,n,r,i,l,s,o,a,p)},Z=(e,t,n,r,i,l,s,o,a)=>{let c=0,u=t.length,d=e.length-1,p=u-1;for(;c<=d&&c<=p;){let r=e[c],u=t[c]=a?iA(t[c]):iw(t[c]);if(ib(r,u))x(r,u,n,null,i,l,s,o,a);else break;c++}for(;c<=d&&c<=p;){let r=e[d],c=t[p]=a?iA(t[p]):iw(t[p]);if(ib(r,c))x(r,c,n,null,i,l,s,o,a);else break;d--,p--}if(c>d){if(c<=p){let e=p+1,d=e<u?t[e].el:r;for(;c<=p;)x(null,t[c]=a?iA(t[c]):iw(t[c]),n,d,i,l,s,o,a),c++}}else if(c>p)for(;c<=d;)et(e[c],i,l,!0),c++;else{let f;let h=c,m=c,g=new Map;for(c=m;c<=p;c++){let e=t[c]=a?iA(t[c]):iw(t[c]);null!=e.key&&g.set(e.key,c)}let y=0,_=p-m+1,S=!1,C=0,k=Array(_);for(c=0;c<_;c++)k[c]=0;for(c=h;c<=d;c++){let r;let u=e[c];if(y>=_){et(u,i,l,!0);continue}if(null!=u.key)r=g.get(u.key);else for(f=m;f<=p;f++)if(0===k[f-m]&&ib(u,t[f])){r=f;break}void 0===r?et(u,i,l,!0):(k[r-m]=c+1,r>=C?C=r:S=!0,x(u,t[r],n,null,i,l,s,o,a),y++)}let T=S?function(e){let t,n,r,i,l;let s=e.slice(),o=[0],a=e.length;for(t=0;t<a;t++){let a=e[t];if(0!==a){if(e[n=o[o.length-1]]<a){s[t]=n,o.push(t);continue}for(r=0,i=o.length-1;r<i;)e[o[l=r+i>>1]]<a?r=l+1:i=l;a<e[o[r]]&&(r>0&&(s[t]=o[r-1]),o[r]=t)}}for(r=o.length,i=o[r-1];r-- >0;)o[r]=i,i=s[i];return o}(k):b;for(f=T.length-1,c=_-1;c>=0;c--){let e=m+c,d=t[e],p=e+1<u?t[e+1].el:r;0===k[c]?x(null,d,n,p,i,l,s,o,a):S&&(f<0||c!==T[f]?ee(d,n,p,2):f--)}}},ee=(e,t,n,r,i=null)=>{let{el:s,type:o,transition:a,children:c,shapeFlag:u}=e;if(6&u){ee(e.component.subTree,t,n,r);return}if(128&u){e.suspense.move(t,n,r);return}if(64&u){o.move(e,t,n,eu);return}if(o===il){l(s,t,n);for(let e=0;e<c.length;e++)ee(c[e],t,n,r);l(e.anchor,t,n);return}if(o===ia){E(e,t,n);return}if(2!==r&&1&u&&a){if(0===r)a.beforeEnter(s),l(s,t,n),rB(()=>a.enter(s),i);else{let{leave:e,delayLeave:r,afterLeave:i}=a,o=()=>l(s,t,n),c=()=>{e(s,()=>{o(),i&&i()})};r?r(s,o,c):c()}}else l(s,t,n)},et=(e,t,n,r=!1,i=!1)=>{let l;let{type:s,props:o,ref:a,children:c,dynamicChildren:u,shapeFlag:d,patchFlag:p,dirs:f,cacheIndex:h}=e;if(-2===p&&(i=!1),null!=a&&nE(a,null,n,e,!0),null!=h&&(t.renderCache[h]=void 0),256&d){t.ctx.deactivate(e);return}let m=1&d&&f,g=!nj(e);if(g&&(l=o&&o.onVnodeBeforeUnmount)&&iR(l,t,e),6&d)el(e.component,n,r);else{if(128&d){e.suspense.unmount(n,r);return}m&&nt(e,null,t,"beforeUnmount"),64&d?e.type.remove(e,t,n,eu,r):u&&!u.hasOnce&&(s!==il||p>0&&64&p)?es(u,t,n,!1,!0):(s===il&&384&p||!i&&16&d)&&es(c,t,n),r&&en(e)}(g&&(l=o&&o.onVnodeUnmounted)||m)&&rB(()=>{l&&iR(l,t,e),m&&nt(e,null,t,"unmounted")},n)},en=e=>{let{type:t,el:n,anchor:r,transition:i}=e;if(t===il){ei(n,r);return}if(t===ia){I(e);return}let l=()=>{s(n),i&&!i.persisted&&i.afterLeave&&i.afterLeave()};if(1&e.shapeFlag&&i&&!i.persisted){let{leave:t,delayLeave:r}=i,s=()=>t(n,l);r?r(e.el,l,s):s()}else l()},ei=(e,t)=>{let n;for(;e!==t;)n=m(e),s(e),e=n;s(t)},el=(e,t,n)=>{let{bum:r,scope:i,job:l,subTree:s,um:o,m:a,a:c}=e;rz(a),rz(c),r&&Y(r),i.stop(),l&&(l.flags|=8,et(s,e,t,n)),o&&rB(o,t),rB(()=>{e.isUnmounted=!0},t),t&&t.pendingBranch&&!t.isUnmounted&&e.asyncDep&&!e.asyncResolved&&e.suspenseId===t.pendingId&&(t.deps--,0===t.deps&&t.resolve())},es=(e,t,n,r=!1,i=!1,l=0)=>{for(let s=l;s<e.length;s++)et(e[s],t,n,r,i)},eo=e=>{if(6&e.shapeFlag)return eo(e.component.subTree);if(128&e.shapeFlag)return e.suspense.next();let t=m(e.anchor||e.el),n=t&&t[nn];return n?m(n):t},ea=!1,ec=(e,t,n)=>{null==e?t._vnode&&et(t._vnode,null,null,!0):x(t._vnode||null,e,t,null,null,null,n),t._vnode=e,ea||(ea=!0,t6(),t4(),ea=!1)},eu={p:x,um:et,m:ee,r:en,mt:q,mc:L,pc:X,pbc:V,n:eo,o:e};return t&&([r,i]=t(eu)),{render:ec,hydrate:r,createApp:(n=r,function(e,t=null){P(e)||(e=k({},e)),null==t||$(t)||(t=null);let r=r_(),i=new WeakSet,l=[],s=!1,o=r.app={_uid:rS++,_component:e,_props:t,_container:null,_context:r,_instance:null,version:iX,get config(){return r.config},set config(v){},use:(e,...t)=>(i.has(e)||(e&&P(e.install)?(i.add(e),e.install(o,...t)):P(e)&&(i.add(e),e(o,...t))),o),mixin:e=>(r.mixins.includes(e)||r.mixins.push(e),o),component:(e,t)=>t?(r.components[e]=t,o):r.components[e],directive:(e,t)=>t?(r.directives[e]=t,o):r.directives[e],mount(i,l,a){if(!s){let c=o._ceVNode||iC(e,t);return c.appContext=r,!0===a?a="svg":!1===a&&(a=void 0),l&&n?n(c,i):ec(c,i,a),s=!0,o._container=i,i.__vue_app__=o,iW(c.component)}},onUnmount(e){l.push(e)},unmount(){s&&(tW(l,o._instance,16),ec(null,o._container),delete o._container.__vue_app__)},provide:(e,t)=>(r.provides[e]=t,o),runWithContext(e){let t=rx;rx=o;try{return e()}finally{rx=t}}};return o})}}function rH({type:e,props:t},n){return"svg"===n&&"foreignObject"===e||"mathml"===n&&"annotation-xml"===e&&t&&t.encoding&&t.encoding.includes("html")?void 0:n}function rq({effect:e,job:t},n){n?(e.flags|=32,t.flags|=4):(e.flags&=-33,t.flags&=-5)}function rW(e,t){return(!e||e&&!e.pendingBranch)&&t&&!t.persisted}function rK(e,t,n=!1){let r=e.children,i=t.children;if(A(r)&&A(i))for(let e=0;e<r.length;e++){let t=r[e],l=i[e];!(1&l.shapeFlag)||l.dynamicChildren||((l.patchFlag<=0||32===l.patchFlag)&&((l=i[e]=iA(i[e])).el=t.el),n||-2===l.patchFlag||rK(t,l)),l.type===is&&(l.el=t.el)}}function rz(e){if(e)for(let t=0;t<e.length;t++)e[t].flags|=8}let rJ=Symbol.for("v-scx");function rG(e,t){return rX(e,null,{flush:"sync"})}function rX(e,t,n=y){let{immediate:r,deep:l,flush:s,once:o}=n,a=k({},n),c=iM;a.call=(e,t,n)=>tW(e,c,t,n);let u=!1;return"post"===s?a.scheduler=e=>{rB(e,c&&c.suspense)}:"sync"!==s&&(u=!0,a.scheduler=(e,t)=>{t?e():t1(e)}),a.augmentJob=e=>{t&&(e.flags|=4),u&&(e.flags|=2,c&&(e.id=c.uid,e.i=c))},function(e,t,n=y){let r,l,s,o;let{immediate:a,deep:c,once:u,scheduler:d,augmentJob:p,call:f}=n,m=e=>c?e:t_(e)||!1===c||0===c?tH(e,1):tH(e),g=!1,b=!1;if(tN(e)?(l=()=>e.value,g=t_(e)):tv(e)?(l=()=>m(e),g=!0):A(e)?(b=!0,g=e.some(e=>tv(e)||t_(e)),l=()=>e.map(e=>tN(e)?e.value:tv(e)?m(e):P(e)?f?f(e,2):e():void 0)):l=P(e)?t?f?()=>f(e,2):e:()=>{if(s){eL();try{s()}finally{e$()}}let t=h;h=r;try{return f?f(e,3,[o]):e(o)}finally{h=t}}:_,t&&c){let e=l,t=!0===c?1/0:c;l=()=>tH(e(),t)}let S=i,x=()=>{r.stop(),S&&S.active&&T(S.effects,r)};if(u&&t){let e=t;t=(...t)=>{e(...t),x()}}let C=b?Array(e.length).fill(tB):tB,k=e=>{if(1&r.flags&&(r.dirty||e)){if(t){let e=r.run();if(c||g||(b?e.some((e,t)=>Z(e,C[t])):Z(e,C))){s&&s();let n=h;h=r;try{let n=[e,C===tB?void 0:b&&C[0]===tB?[]:C,o];f?f(t,3,n):t(...n),C=e}finally{h=n}}}else r.run()}};return p&&p(k),(r=new ek(l)).scheduler=d?()=>d(k,!1):k,o=e=>tj(e,!1,r),s=r.onStop=()=>{let e=tU.get(r);if(e){if(f)f(e,4);else for(let t of e)t();tU.delete(r)}},t?a?k(!0):C=r.run():d?d(k.bind(null,!0),!0):r.run(),x.pause=r.pause.bind(r),x.resume=r.resume.bind(r),x.stop=x,x}(e,t,a)}function rQ(e,t,n){let r;let i=this.proxy,l=M(e)?e.includes(".")?rZ(i,e):()=>i[e]:e.bind(i,i);P(t)?r=t:(r=t.handler,n=t);let s=i$(this),o=rX(l,r.bind(i),n);return s(),o}function rZ(e,t){let n=t.split(".");return()=>{let t=e;for(let e=0;e<n.length&&t;e++)t=t[n[e]];return t}}let rY=(e,t)=>"modelValue"===t||"model-value"===t?e.modelModifiers:e[`${t}Modifiers`]||e[`${z(t)}Modifiers`]||e[`${G(t)}Modifiers`];function r0(e,t,...n){let r;if(e.isUnmounted)return;let i=e.vnode.props||y,l=n,s=t.startsWith("update:"),o=s&&rY(i,t.slice(7));o&&(o.trim&&(l=n.map(e=>M(e)?e.trim():e)),o.number&&(l=n.map(et)));let a=i[r=Q(t)]||i[r=Q(z(t))];!a&&s&&(a=i[r=Q(G(t))]),a&&tW(a,e,6,l);let c=i[r+"Once"];if(c){if(e.emitted){if(e.emitted[r])return}else e.emitted={};e.emitted[r]=!0,tW(c,e,6,l)}}function r1(e,t){return!!(e&&x(t))&&(w(e,(t=t.slice(2).replace(/Once$/,""))[0].toLowerCase()+t.slice(1))||w(e,G(t))||w(e,t))}function r2(e){let t,n;let{type:r,vnode:i,proxy:l,withProxy:s,propsOptions:[o],slots:a,attrs:c,emit:u,render:d,renderCache:p,props:f,data:h,setupState:m,ctx:g,inheritAttrs:y}=e,b=t7(e);try{if(4&i.shapeFlag){let e=s||l;t=iw(d.call(e,e,p,f,m,h,g)),n=c}else t=iw(r.length>1?r(f,{attrs:c,slots:a,emit:u}):r(f,null)),n=r.props?c:r3(c)}catch(n){ic.length=0,tK(n,e,1),t=iC(io)}let _=t;if(n&&!1!==y){let e=Object.keys(n),{shapeFlag:t}=_;e.length&&7&t&&(o&&e.some(C)&&(n=r6(n,o)),_=iT(_,n,!1,!0))}return i.dirs&&((_=iT(_,null,!1,!0)).dirs=_.dirs?_.dirs.concat(i.dirs):i.dirs),i.transition&&nT(_,i.transition),t=_,t7(b),t}let r3=e=>{let t;for(let n in e)("class"===n||"style"===n||x(n))&&((t||(t={}))[n]=e[n]);return t},r6=(e,t)=>{let n={};for(let r in e)C(r)&&r.slice(9)in t||(n[r]=e[r]);return n};function r4(e,t,n){let r=Object.keys(t);if(r.length!==Object.keys(e).length)return!0;for(let i=0;i<r.length;i++){let l=r[i];if(t[l]!==e[l]&&!r1(n,l))return!0}return!1}function r8({vnode:e,parent:t},n){for(;t;){let r=t.subTree;if(r.suspense&&r.suspense.activeBranch===e&&(r.el=e.el),r===e)(e=t.vnode).el=n,t=t.parent;else break}}let r5=e=>e.__isSuspense,r9=0;function r7(e,t){let n=e.props&&e.props[t];P(n)&&n()}function ie(e,t,n,r,i,l,s,o,a,c,u=!1){let d;let{p:p,m:f,um:h,n:m,o:{parentNode:g,remove:y}}=c,b=function(e){let t=e.props&&e.props.suspensible;return null!=t&&!1!==t}(e);b&&t&&t.pendingBranch&&(d=t.pendingId,t.deps++);let _=e.props?en(e.props.timeout):void 0,S=l,x={vnode:e,parent:t,parentComponent:n,namespace:s,container:r,hiddenContainer:i,deps:0,pendingId:r9++,timeout:"number"==typeof _?_:-1,activeBranch:null,pendingBranch:null,isInFallback:!u,isHydrating:u,isUnmounted:!1,effects:[],resolve(e=!1,n=!1){let{vnode:r,activeBranch:i,pendingBranch:s,pendingId:o,effects:a,parentComponent:c,container:u}=x,p=!1;x.isHydrating?x.isHydrating=!1:e||((p=i&&s.transition&&"out-in"===s.transition.mode)&&(i.transition.afterLeave=()=>{o===x.pendingId&&(f(s,u,l===S?m(i):l,0),t3(a))}),i&&(g(i.el)===u&&(l=m(i)),h(i,c,x,!0)),p||f(s,u,l,0)),ii(x,s),x.pendingBranch=null,x.isInFallback=!1;let y=x.parent,_=!1;for(;y;){if(y.pendingBranch){y.effects.push(...a),_=!0;break}y=y.parent}_||p||t3(a),x.effects=[],b&&t&&t.pendingBranch&&d===t.pendingId&&(t.deps--,0!==t.deps||n||t.resolve()),r7(r,"onResolve")},fallback(e){if(!x.pendingBranch)return;let{vnode:t,activeBranch:n,parentComponent:r,container:i,namespace:l}=x;r7(t,"onFallback");let s=m(n),c=()=>{x.isInFallback&&(p(null,e,i,s,r,null,l,o,a),ii(x,e))},u=e.transition&&"out-in"===e.transition.mode;u&&(n.transition.afterLeave=c),x.isInFallback=!0,h(n,r,null,!0),u||c()},move(e,t,n){x.activeBranch&&f(x.activeBranch,e,t,n),x.container=e},next:()=>x.activeBranch&&m(x.activeBranch),registerDep(e,t,n){let r=!!x.pendingBranch;r&&x.deps++;let i=e.vnode.el;e.asyncDep.catch(t=>{tK(t,e,0)}).then(l=>{if(e.isUnmounted||x.isUnmounted||x.pendingId!==e.suspenseId)return;e.asyncResolved=!0;let{vnode:o}=e;iB(e,l,!1),i&&(o.el=i);let a=!i&&e.subTree.el;t(e,o,g(i||e.subTree.el),i?null:m(e.subTree),x,s,n),a&&y(a),r8(e,o.el),r&&0==--x.deps&&x.resolve()})},unmount(e,t){x.isUnmounted=!0,x.activeBranch&&h(x.activeBranch,n,e,t),x.pendingBranch&&h(x.pendingBranch,n,e,t)}};return x}function it(e){let t;if(P(e)){let n=ih&&e._c;n&&(e._d=!1,id()),e=e(),n&&(e._d=!0,t=iu,ip())}return A(e)&&(e=function(e,t=!0){let n;for(let t=0;t<e.length;t++){let r=e[t];if(!iv(r))return;if(r.type!==io||"v-if"===r.children){if(n)return;n=r}}return n}(e)),e=iw(e),t&&!e.dynamicChildren&&(e.dynamicChildren=t.filter(t=>t!==e)),e}function ir(e,t){t&&t.pendingBranch?A(e)?t.effects.push(...e):t.effects.push(e):t3(e)}function ii(e,t){e.activeBranch=t;let{vnode:n,parentComponent:r}=e,i=t.el;for(;!i&&t.component;)i=(t=t.component.subTree).el;n.el=i,r&&r.subTree===n&&(r.vnode.el=i,r8(r,i))}let il=Symbol.for("v-fgt"),is=Symbol.for("v-txt"),io=Symbol.for("v-cmt"),ia=Symbol.for("v-stc"),ic=[],iu=null;function id(e=!1){ic.push(iu=e?null:[])}function ip(){ic.pop(),iu=ic[ic.length-1]||null}let ih=1;function im(e,t=!1){ih+=e,e<0&&iu&&t&&(iu.hasOnce=!0)}function ig(e){return e.dynamicChildren=ih>0?iu||b:null,ip(),ih>0&&iu&&iu.push(e),e}function iy(e,t,n,r,i){return ig(iC(e,t,n,r,i,!0))}function iv(e){return!!e&&!0===e.__v_isVNode}function ib(e,t){return e.type===t.type&&e.key===t.key}let i_=({key:e})=>null!=e?e:null,iS=({ref:e,ref_key:t,ref_for:n})=>("number"==typeof e&&(e=""+e),null!=e?M(e)||tN(e)||P(e)?{i:t5,r:e,k:t,f:!!n}:e:null);function ix(e,t=null,n=null,r=0,i=null,l=e===il?0:1,s=!1,o=!1){let a={__v_isVNode:!0,__v_skip:!0,type:e,props:t,key:t&&i_(t),ref:t&&iS(t),scopeId:t9,slotScopeIds:null,children:n,component:null,suspense:null,ssContent:null,ssFallback:null,dirs:null,transition:null,el:null,anchor:null,target:null,targetStart:null,targetAnchor:null,staticCount:0,shapeFlag:l,patchFlag:r,dynamicProps:i,dynamicChildren:null,appContext:null,ctx:t5};return o?(iE(a,n),128&l&&e.normalize(a)):n&&(a.shapeFlag|=M(n)?8:16),ih>0&&!s&&iu&&(a.patchFlag>0||6&l)&&32!==a.patchFlag&&iu.push(a),a}let iC=function(e,t=null,n=null,r=0,i=null,l=!1){var s;if(e&&e!==re||(e=io),iv(e)){let r=iT(e,t,!0);return n&&iE(r,n),ih>0&&!l&&iu&&(6&r.shapeFlag?iu[iu.indexOf(e)]=r:iu.push(r)),r.patchFlag=-2,r}if(P(s=e)&&"__vccOpts"in s&&(e=e.__vccOpts),t){let{class:e,style:n}=t=ik(t);e&&!M(e)&&(t.class=eu(e)),$(n)&&(tS(n)&&!A(n)&&(n=k({},n)),t.style=el(n))}let o=M(e)?1:r5(e)?128:nr(e)?64:$(e)?4:P(e)?2:0;return ix(e,t,n,r,i,o,l,!0)};function ik(e){return e?tS(e)||rw(e)?k({},e):e:null}function iT(e,t,n=!1,r=!1){let{props:i,ref:l,patchFlag:s,children:o,transition:a}=e,c=t?iI(i||{},t):i,u={__v_isVNode:!0,__v_skip:!0,type:e.type,props:c,key:c&&i_(c),ref:t&&t.ref?n&&l?A(l)?l.concat(iS(t)):[l,iS(t)]:iS(t):l,scopeId:e.scopeId,slotScopeIds:e.slotScopeIds,children:o,target:e.target,targetStart:e.targetStart,targetAnchor:e.targetAnchor,staticCount:e.staticCount,shapeFlag:e.shapeFlag,patchFlag:t&&e.type!==il?-1===s?16:16|s:s,dynamicProps:e.dynamicProps,dynamicChildren:e.dynamicChildren,appContext:e.appContext,dirs:e.dirs,transition:a,component:e.component,suspense:e.suspense,ssContent:e.ssContent&&iT(e.ssContent),ssFallback:e.ssFallback&&iT(e.ssFallback),el:e.el,anchor:e.anchor,ctx:e.ctx,ce:e.ce};return a&&r&&nT(u,a.clone(u)),u}function iN(e=" ",t=0){return iC(is,null,e,t)}function iw(e){return null==e||"boolean"==typeof e?iC(io):A(e)?iC(il,null,e.slice()):iv(e)?iA(e):iC(is,null,String(e))}function iA(e){return null===e.el&&-1!==e.patchFlag||e.memo?e:iT(e)}function iE(e,t){let n=0,{shapeFlag:r}=e;if(null==t)t=null;else if(A(t))n=16;else if("object"==typeof t){if(65&r){let n=t.default;n&&(n._c&&(n._d=!1),iE(e,n()),n._c&&(n._d=!0));return}{n=32;let r=t._;r||rw(t)?3===r&&t5&&(1===t5.slots._?t._=1:(t._=2,e.patchFlag|=1024)):t._ctx=t5}}else P(t)?(t={default:t,_ctx:t5},n=32):(t=String(t),64&r?(n=16,t=[iN(t)]):n=8);e.children=t,e.shapeFlag|=n}function iI(...e){let t={};for(let n=0;n<e.length;n++){let r=e[n];for(let e in r)if("class"===e)t.class!==r.class&&(t.class=eu([t.class,r.class]));else if("style"===e)t.style=el([t.style,r.style]);else if(x(e)){let n=t[e],i=r[e];i&&n!==i&&!(A(n)&&n.includes(i))&&(t[e]=n?[].concat(n,i):i)}else""!==e&&(t[e]=r[e])}return t}function iR(e,t,n,r=null){tW(e,t,7,[n,r])}let iO=r_(),iP=0,iM=null,iL=()=>iM||t5;a=e=>{iM=e},c=e=>{iV=e};let i$=e=>{let t=iM;return a(e),e.scope.on(),()=>{e.scope.off(),a(t)}},iD=()=>{iM&&iM.scope.off(),a(null)};function iF(e){return 4&e.vnode.shapeFlag}let iV=!1;function iB(e,t,n){P(t)?e.render=t:$(t)&&(e.setupState=tP(t)),ij(e,n)}function iU(e){u=e,d=e=>{e.render._rc&&(e.withProxy=new Proxy(e.ctx,ro))}}function ij(e,t,n){let r=e.type;if(!e.render){if(!t&&u&&!r.render){let t=r.template||rp(e).template;if(t){let{isCustomElement:n,compilerOptions:i}=e.appContext.config,{delimiters:l,compilerOptions:s}=r,o=k(k({isCustomElement:n,delimiters:l},i),s);r.render=u(t,o)}}e.render=r.render||_,d&&d(e)}{let t=i$(e);eL();try{!function(e){let t=rp(e),n=e.proxy,r=e.ctx;ru=!1,t.beforeCreate&&rd(t.beforeCreate,e,"bc");let{data:i,computed:l,methods:s,watch:o,provide:a,inject:c,created:u,beforeMount:d,mounted:p,beforeUpdate:f,updated:h,activated:m,deactivated:g,beforeDestroy:y,beforeUnmount:b,destroyed:S,unmounted:x,render:C,renderTracked:k,renderTriggered:T,errorCaptured:N,serverPrefetch:w,expose:E,inheritAttrs:I,components:R,directives:O,filters:L}=t;if(c&&function(e,t,n=_){for(let n in A(e)&&(e=rg(e)),e){let r;let i=e[n];tN(r=$(i)?"default"in i?rk(i.from||n,i.default,!0):rk(i.from||n):rk(i))?Object.defineProperty(t,n,{enumerable:!0,configurable:!0,get:()=>r.value,set:e=>r.value=e}):t[n]=r}}(c,r,null),s)for(let e in s){let t=s[e];P(t)&&(r[e]=t.bind(n))}if(i){let t=i.call(n,n);$(t)&&(e.data=th(t))}if(ru=!0,l)for(let e in l){let t=l[e],i=P(t)?t.bind(n,n):P(t.get)?t.get.bind(n,n):_,s=iz({get:i,set:!P(t)&&P(t.set)?t.set.bind(n):_});Object.defineProperty(r,e,{enumerable:!0,configurable:!0,get:()=>s.value,set:e=>s.value=e})}if(o)for(let e in o)!function e(t,n,r,i){let l=i.includes(".")?rZ(r,i):()=>r[i];if(M(t)){let e=n[t];P(e)&&rX(l,e,void 0)}else if(P(t)){var s;s=t.bind(r),rX(l,s,void 0)}else if($(t)){if(A(t))t.forEach(t=>e(t,n,r,i));else{let e=P(t.handler)?t.handler.bind(r):n[t.handler];P(e)&&rX(l,e,t)}}}(o[e],r,n,e);if(a){let e=P(a)?a.call(n):a;Reflect.ownKeys(e).forEach(t=>{rC(t,e[t])})}function D(e,t){A(t)?t.forEach(t=>e(t.bind(n))):t&&e(t.bind(n))}if(u&&rd(u,e,"c"),D(nY,d),D(n0,p),D(n1,f),D(n2,h),D(nK,m),D(nz,g),D(n9,N),D(n5,k),D(n8,T),D(n3,b),D(n6,x),D(n4,w),A(E)){if(E.length){let t=e.exposed||(e.exposed={});E.forEach(e=>{Object.defineProperty(t,e,{get:()=>n[e],set:t=>n[e]=t})})}else e.exposed||(e.exposed={})}C&&e.render===_&&(e.render=C),null!=I&&(e.inheritAttrs=I),R&&(e.components=R),O&&(e.directives=O)}(e)}finally{e$(),t()}}}let iH={get:(e,t)=>(eW(e,"get",""),e[t])};function iq(e){return{attrs:new Proxy(e.attrs,iH),slots:e.slots,emit:e.emit,expose:t=>{e.exposed=t||{}}}}function iW(e){return e.exposed?e.exposeProxy||(e.exposeProxy=new Proxy(tP(tC(e.exposed)),{get:(t,n)=>n in t?t[n]:n in ri?ri[n](e):void 0,has:(e,t)=>t in e||t in ri})):e.proxy}function iK(e,t=!0){return P(e)?e.displayName||e.name:e.name||t&&e.__name}let iz=(e,t)=>(function(e,t,n=!1){let r,i;return P(e)?r=e:(r=e.get,i=e.set),new tV(r,i,n)})(e,0,iV);function iJ(e,t,n){let r=arguments.length;return 2!==r?(r>3?n=Array.prototype.slice.call(arguments,2):3===r&&iv(n)&&(n=[n]),iC(e,t,n)):!$(t)||A(t)?iC(e,null,t):iv(t)?iC(e,null,[t]):iC(e,t)}function iG(e,t){let n=e.memo;if(n.length!=t.length)return!1;for(let e=0;e<n.length;e++)if(Z(n[e],t[e]))return!1;return ih>0&&iu&&iu.push(e),!0}let iX="3.5.13",iQ="undefined"!=typeof window&&window.trustedTypes;if(iQ)try{m=iQ.createPolicy("vue",{createHTML:e=>e})}catch(e){}let iZ=m?e=>m.createHTML(e):e=>e,iY="undefined"!=typeof document?document:null,i0=iY&&iY.createElement("template"),i1="transition",i2="animation",i3=Symbol("_vtc"),i6={name:String,type:String,css:{type:Boolean,default:!0},duration:[String,Number,Object],enterFromClass:String,enterActiveClass:String,enterToClass:String,appearFromClass:String,appearActiveClass:String,appearToClass:String,leaveFromClass:String,leaveActiveClass:String,leaveToClass:String},i4=k({},ny,i6),i8=((t=(e,{slots:t})=>iJ(n_,i7(e),t)).displayName="Transition",t.props=i4,t),i5=(e,t=[])=>{A(e)?e.forEach(e=>e(...t)):e&&e(...t)},i9=e=>!!e&&(A(e)?e.some(e=>e.length>1):e.length>1);function i7(e){let t={};for(let n in e)n in i6||(t[n]=e[n]);if(!1===e.css)return t;let{name:n="v",type:r,duration:i,enterFromClass:l=`${n}-enter-from`,enterActiveClass:s=`${n}-enter-active`,enterToClass:o=`${n}-enter-to`,appearFromClass:a=l,appearActiveClass:c=s,appearToClass:u=o,leaveFromClass:d=`${n}-leave-from`,leaveActiveClass:p=`${n}-leave-active`,leaveToClass:f=`${n}-leave-to`}=e,h=function(e){if(null==e)return null;if($(e))return[en(e.enter),en(e.leave)];{let t=en(e);return[t,t]}}(i),m=h&&h[0],g=h&&h[1],{onBeforeEnter:y,onEnter:b,onEnterCancelled:_,onLeave:S,onLeaveCancelled:x,onBeforeAppear:C=y,onAppear:T=b,onAppearCancelled:N=_}=t,w=(e,t,n,r)=>{e._enterCancelled=r,lt(e,t?u:o),lt(e,t?c:s),n&&n()},A=(e,t)=>{e._isLeaving=!1,lt(e,d),lt(e,f),lt(e,p),t&&t()},E=e=>(t,n)=>{let i=e?T:b,s=()=>w(t,e,n);i5(i,[t,s]),ln(()=>{lt(t,e?a:l),le(t,e?u:o),i9(i)||li(t,r,m,s)})};return k(t,{onBeforeEnter(e){i5(y,[e]),le(e,l),le(e,s)},onBeforeAppear(e){i5(C,[e]),le(e,a),le(e,c)},onEnter:E(!1),onAppear:E(!0),onLeave(e,t){e._isLeaving=!0;let n=()=>A(e,t);le(e,d),e._enterCancelled?(le(e,p),la()):(la(),le(e,p)),ln(()=>{e._isLeaving&&(lt(e,d),le(e,f),i9(S)||li(e,r,g,n))}),i5(S,[e,n])},onEnterCancelled(e){w(e,!1,void 0,!0),i5(_,[e])},onAppearCancelled(e){w(e,!0,void 0,!0),i5(N,[e])},onLeaveCancelled(e){A(e),i5(x,[e])}})}function le(e,t){t.split(/\s+/).forEach(t=>t&&e.classList.add(t)),(e[i3]||(e[i3]=new Set)).add(t)}function lt(e,t){t.split(/\s+/).forEach(t=>t&&e.classList.remove(t));let n=e[i3];n&&(n.delete(t),n.size||(e[i3]=void 0))}function ln(e){requestAnimationFrame(()=>{requestAnimationFrame(e)})}let lr=0;function li(e,t,n,r){let i=e._endId=++lr,l=()=>{i===e._endId&&r()};if(null!=n)return setTimeout(l,n);let{type:s,timeout:o,propCount:a}=ll(e,t);if(!s)return r();let c=s+"end",u=0,d=()=>{e.removeEventListener(c,p),l()},p=t=>{t.target===e&&++u>=a&&d()};setTimeout(()=>{u<a&&d()},o+1),e.addEventListener(c,p)}function ll(e,t){let n=window.getComputedStyle(e),r=e=>(n[e]||"").split(", "),i=r(`${i1}Delay`),l=r(`${i1}Duration`),s=ls(i,l),o=r(`${i2}Delay`),a=r(`${i2}Duration`),c=ls(o,a),u=null,d=0,p=0;t===i1?s>0&&(u=i1,d=s,p=l.length):t===i2?c>0&&(u=i2,d=c,p=a.length):p=(u=(d=Math.max(s,c))>0?s>c?i1:i2:null)?u===i1?l.length:a.length:0;let f=u===i1&&/\b(transform|all)(,|$)/.test(r(`${i1}Property`).toString());return{type:u,timeout:d,propCount:p,hasTransform:f}}function ls(e,t){for(;e.length<t.length;)e=e.concat(e);return Math.max(...t.map((t,n)=>lo(t)+lo(e[n])))}function lo(e){return"auto"===e?0:1e3*Number(e.slice(0,-1).replace(",","."))}function la(){return document.body.offsetHeight}let lc=Symbol("_vod"),lu=Symbol("_vsh");function ld(e,t){e.style.display=t?e[lc]:"none",e[lu]=!t}let lp=Symbol("");function lf(e,t){if(1===e.nodeType){let n=e.style,r="";for(let e in t)n.setProperty(`--${e}`,t[e]),r+=`--${e}: ${t[e]};`;n[lp]=r}}let lh=/(^|;)\s*display\s*:/,lm=/\s*!important$/;function lg(e,t,n){if(A(n))n.forEach(n=>lg(e,t,n));else if(null==n&&(n=""),t.startsWith("--"))e.setProperty(t,n);else{let r=function(e,t){let n=lv[t];if(n)return n;let r=z(t);if("filter"!==r&&r in e)return lv[t]=r;r=X(r);for(let n=0;n<ly.length;n++){let i=ly[n]+r;if(i in e)return lv[t]=i}return t}(e,t);lm.test(n)?e.setProperty(G(r),n.replace(lm,""),"important"):e[r]=n}}let ly=["Webkit","Moz","ms"],lv={},lb="http://www.w3.org/1999/xlink";function l_(e,t,n,r,i,l=em(t)){r&&t.startsWith("xlink:")?null==n?e.removeAttributeNS(lb,t.slice(6,t.length)):e.setAttributeNS(lb,t,n):null==n||l&&!(n||""===n)?e.removeAttribute(t):e.setAttribute(t,l?"":L(n)?String(n):n)}function lS(e,t,n,r,i){if("innerHTML"===t||"textContent"===t){null!=n&&(e[t]="innerHTML"===t?iZ(n):n);return}let l=e.tagName;if("value"===t&&"PROGRESS"!==l&&!l.includes("-")){let r="OPTION"===l?e.getAttribute("value")||"":e.value,i=null==n?"checkbox"===e.type?"on":"":String(n);r===i&&"_value"in e||(e.value=i),null==n&&e.removeAttribute(t),e._value=n;return}let s=!1;if(""===n||null==n){let r=typeof e[t];if("boolean"===r){var o;n=!!(o=n)||""===o}else null==n&&"string"===r?(n="",s=!0):"number"===r&&(n=0,s=!0)}try{e[t]=n}catch(e){}s&&e.removeAttribute(i||t)}function lx(e,t,n,r){e.addEventListener(t,n,r)}let lC=Symbol("_vei"),lk=/(?:Once|Passive|Capture)$/,lT=0,lN=Promise.resolve(),lw=()=>lT||(lN.then(()=>lT=0),lT=Date.now()),lA=e=>111===e.charCodeAt(0)&&110===e.charCodeAt(1)&&e.charCodeAt(2)>96&&123>e.charCodeAt(2),lE={};function lI(e,t,n){let r=nw(e,t);U(r)&&k(r,t);class i extends lO{constructor(e){super(r,e,n)}}return i.def=r,i}let lR="undefined"!=typeof HTMLElement?HTMLElement:class{};class lO extends lR{constructor(e,t={},n=l9){super(),this._def=e,this._props=t,this._createApp=n,this._isVueCE=!0,this._instance=null,this._app=null,this._nonce=this._def.nonce,this._connected=!1,this._resolved=!1,this._numberProps=null,this._styleChildren=new WeakSet,this._ob=null,this.shadowRoot&&n!==l9?this._root=this.shadowRoot:!1!==e.shadowRoot?(this.attachShadow({mode:"open"}),this._root=this.shadowRoot):this._root=this,this._def.__asyncLoader||this._resolveProps(this._def)}connectedCallback(){if(!this.isConnected)return;this.shadowRoot||this._parseSlots(),this._connected=!0;let e=this;for(;e=e&&(e.parentNode||e.host);)if(e instanceof lO){this._parent=e;break}this._instance||(this._resolved?(this._setParent(),this._update()):e&&e._pendingResolve?this._pendingResolve=e._pendingResolve.then(()=>{this._pendingResolve=void 0,this._resolveDef()}):this._resolveDef())}_setParent(e=this._parent){e&&(this._instance.parent=e._instance,this._instance.provides=e._instance.provides)}disconnectedCallback(){this._connected=!1,t0(()=>{this._connected||(this._ob&&(this._ob.disconnect(),this._ob=null),this._app&&this._app.unmount(),this._instance&&(this._instance.ce=void 0),this._app=this._instance=null)})}_resolveDef(){if(this._pendingResolve)return;for(let e=0;e<this.attributes.length;e++)this._setAttr(this.attributes[e].name);this._ob=new MutationObserver(e=>{for(let t of e)this._setAttr(t.attributeName)}),this._ob.observe(this,{attributes:!0});let e=(e,t=!1)=>{let n;this._resolved=!0,this._pendingResolve=void 0;let{props:r,styles:i}=e;if(r&&!A(r))for(let e in r){let t=r[e];(t===Number||t&&t.type===Number)&&(e in this._props&&(this._props[e]=en(this._props[e])),(n||(n=Object.create(null)))[z(e)]=!0)}this._numberProps=n,t&&this._resolveProps(e),this.shadowRoot&&this._applyStyles(i),this._mount(e)},t=this._def.__asyncLoader;t?this._pendingResolve=t().then(t=>e(this._def=t,!0)):e(this._def)}_mount(e){this._app=this._createApp(e),e.configureApp&&e.configureApp(this._app),this._app._ceVNode=this._createVNode(),this._app.mount(this._root);let t=this._instance&&this._instance.exposed;if(t)for(let e in t)w(this,e)||Object.defineProperty(this,e,{get:()=>tR(t[e])})}_resolveProps(e){let{props:t}=e,n=A(t)?t:Object.keys(t||{});for(let e of Object.keys(this))"_"!==e[0]&&n.includes(e)&&this._setProp(e,this[e]);for(let e of n.map(z))Object.defineProperty(this,e,{get(){return this._getProp(e)},set(t){this._setProp(e,t,!0,!0)}})}_setAttr(e){if(e.startsWith("data-v-"))return;let t=this.hasAttribute(e),n=t?this.getAttribute(e):lE,r=z(e);t&&this._numberProps&&this._numberProps[r]&&(n=en(n)),this._setProp(r,n,!1,!0)}_getProp(e){return this._props[e]}_setProp(e,t,n=!0,r=!1){if(t!==this._props[e]&&(t===lE?delete this._props[e]:(this._props[e]=t,"key"===e&&this._app&&(this._app._ceVNode.key=t)),r&&this._instance&&this._update(),n)){let n=this._ob;n&&n.disconnect(),!0===t?this.setAttribute(G(e),""):"string"==typeof t||"number"==typeof t?this.setAttribute(G(e),t+""):t||this.removeAttribute(G(e)),n&&n.observe(this,{attributes:!0})}}_update(){l5(this._createVNode(),this._root)}_createVNode(){let e={};this.shadowRoot||(e.onVnodeMounted=e.onVnodeUpdated=this._renderSlots.bind(this));let t=iC(this._def,k(e,this._props));return this._instance||(t.ce=e=>{this._instance=e,e.ce=this,e.isCE=!0;let t=(e,t)=>{this.dispatchEvent(new CustomEvent(e,U(t[0])?k({detail:t},t[0]):{detail:t}))};e.emit=(e,...n)=>{t(e,n),G(e)!==e&&t(G(e),n)},this._setParent()}),t}_applyStyles(e,t){if(!e)return;if(t){if(t===this._def||this._styleChildren.has(t))return;this._styleChildren.add(t)}let n=this._nonce;for(let t=e.length-1;t>=0;t--){let r=document.createElement("style");n&&r.setAttribute("nonce",n),r.textContent=e[t],this.shadowRoot.prepend(r)}}_parseSlots(){let e;let t=this._slots={};for(;e=this.firstChild;){let n=1===e.nodeType&&e.getAttribute("slot")||"default";(t[n]||(t[n]=[])).push(e),this.removeChild(e)}}_renderSlots(){let e=(this._teleportTarget||this).querySelectorAll("slot"),t=this._instance.type.__scopeId;for(let n=0;n<e.length;n++){let r=e[n],i=r.getAttribute("name")||"default",l=this._slots[i],s=r.parentNode;if(l)for(let e of l){if(t&&1===e.nodeType){let n;let r=t+"-s",i=document.createTreeWalker(e,1);for(e.setAttribute(r,"");n=i.nextNode();)n.setAttribute(r,"")}s.insertBefore(e,r)}else for(;r.firstChild;)s.insertBefore(r.firstChild,r);s.removeChild(r)}}_injectChildStyle(e){this._applyStyles(e.styles,e)}_removeChildStyle(e){}}function lP(e){let t=iL();return t&&t.ce||null}let lM=new WeakMap,lL=new WeakMap,l$=Symbol("_moveCb"),lD=Symbol("_enterCb"),lF=(n={name:"TransitionGroup",props:k({},i4,{tag:String,moveClass:String}),setup(e,{slots:t}){let n,r;let i=iL(),l=nm();return n2(()=>{if(!n.length)return;let t=e.moveClass||`${e.name||"v"}-move`;if(!function(e,t,n){let r=e.cloneNode(),i=e[i3];i&&i.forEach(e=>{e.split(/\s+/).forEach(e=>e&&r.classList.remove(e))}),n.split(/\s+/).forEach(e=>e&&r.classList.add(e)),r.style.display="none";let l=1===t.nodeType?t:t.parentNode;l.appendChild(r);let{hasTransform:s}=ll(r);return l.removeChild(r),s}(n[0].el,i.vnode.el,t))return;n.forEach(lV),n.forEach(lB);let r=n.filter(lU);la(),r.forEach(e=>{let n=e.el,r=n.style;le(n,t),r.transform=r.webkitTransform=r.transitionDuration="";let i=n[l$]=e=>{(!e||e.target===n)&&(!e||/transform$/.test(e.propertyName))&&(n.removeEventListener("transitionend",i),n[l$]=null,lt(n,t))};n.addEventListener("transitionend",i)})}),()=>{let s=tx(e),o=i7(s),a=s.tag||il;if(n=[],r)for(let e=0;e<r.length;e++){let t=r[e];t.el&&t.el instanceof Element&&(n.push(t),nT(t,nx(t,o,l,i)),lM.set(t,t.el.getBoundingClientRect()))}r=t.default?nN(t.default()):[];for(let e=0;e<r.length;e++){let t=r[e];null!=t.key&&nT(t,nx(t,o,l,i))}return iC(a,null,r)}}},delete n.props.mode,n);function lV(e){let t=e.el;t[l$]&&t[l$](),t[lD]&&t[lD]()}function lB(e){lL.set(e,e.el.getBoundingClientRect())}function lU(e){let t=lM.get(e),n=lL.get(e),r=t.left-n.left,i=t.top-n.top;if(r||i){let t=e.el.style;return t.transform=t.webkitTransform=`translate(${r}px,${i}px)`,t.transitionDuration="0s",e}}let lj=e=>{let t=e.props["onUpdate:modelValue"]||!1;return A(t)?e=>Y(t,e):t};function lH(e){e.target.composing=!0}function lq(e){let t=e.target;t.composing&&(t.composing=!1,t.dispatchEvent(new Event("input")))}let lW=Symbol("_assign"),lK={created(e,{modifiers:{lazy:t,trim:n,number:r}},i){e[lW]=lj(i);let l=r||i.props&&"number"===i.props.type;lx(e,t?"change":"input",t=>{if(t.target.composing)return;let r=e.value;n&&(r=r.trim()),l&&(r=et(r)),e[lW](r)}),n&&lx(e,"change",()=>{e.value=e.value.trim()}),t||(lx(e,"compositionstart",lH),lx(e,"compositionend",lq),lx(e,"change",lq))},mounted(e,{value:t}){e.value=null==t?"":t},beforeUpdate(e,{value:t,oldValue:n,modifiers:{lazy:r,trim:i,number:l}},s){if(e[lW]=lj(s),e.composing)return;let o=(l||"number"===e.type)&&!/^0\d/.test(e.value)?et(e.value):e.value,a=null==t?"":t;o===a||document.activeElement===e&&"range"!==e.type&&(r&&t===n||i&&e.value.trim()===a)||(e.value=a)}},lz={deep:!0,created(e,t,n){e[lW]=lj(n),lx(e,"change",()=>{let t=e._modelValue,n=lZ(e),r=e.checked,i=e[lW];if(A(t)){let e=ey(t,n),l=-1!==e;if(r&&!l)i(t.concat(n));else if(!r&&l){let n=[...t];n.splice(e,1),i(n)}}else if(I(t)){let e=new Set(t);r?e.add(n):e.delete(n),i(e)}else i(lY(e,r))})},mounted:lJ,beforeUpdate(e,t,n){e[lW]=lj(n),lJ(e,t,n)}};function lJ(e,{value:t,oldValue:n},r){let i;if(e._modelValue=t,A(t))i=ey(t,r.props.value)>-1;else if(I(t))i=t.has(r.props.value);else{if(t===n)return;i=eg(t,lY(e,!0))}e.checked!==i&&(e.checked=i)}let lG={created(e,{value:t},n){e.checked=eg(t,n.props.value),e[lW]=lj(n),lx(e,"change",()=>{e[lW](lZ(e))})},beforeUpdate(e,{value:t,oldValue:n},r){e[lW]=lj(r),t!==n&&(e.checked=eg(t,r.props.value))}},lX={deep:!0,created(e,{value:t,modifiers:{number:n}},r){let i=I(t);lx(e,"change",()=>{let t=Array.prototype.filter.call(e.options,e=>e.selected).map(e=>n?et(lZ(e)):lZ(e));e[lW](e.multiple?i?new Set(t):t:t[0]),e._assigning=!0,t0(()=>{e._assigning=!1})}),e[lW]=lj(r)},mounted(e,{value:t}){lQ(e,t)},beforeUpdate(e,t,n){e[lW]=lj(n)},updated(e,{value:t}){e._assigning||lQ(e,t)}};function lQ(e,t){let n=e.multiple,r=A(t);if(!n||r||I(t)){for(let i=0,l=e.options.length;i<l;i++){let l=e.options[i],s=lZ(l);if(n){if(r){let e=typeof s;"string"===e||"number"===e?l.selected=t.some(e=>String(e)===String(s)):l.selected=ey(t,s)>-1}else l.selected=t.has(s)}else if(eg(lZ(l),t)){e.selectedIndex!==i&&(e.selectedIndex=i);return}}n||-1===e.selectedIndex||(e.selectedIndex=-1)}}function lZ(e){return"_value"in e?e._value:e.value}function lY(e,t){let n=t?"_trueValue":"_falseValue";return n in e?e[n]:t}function l0(e,t,n,r,i){let l=function(e,t){switch(e){case"SELECT":return lX;case"TEXTAREA":return lK;default:switch(t){case"checkbox":return lz;case"radio":return lG;default:return lK}}}(e.tagName,n.props&&n.props.type)[i];l&&l(e,t,n,r)}let l1=["ctrl","shift","alt","meta"],l2={stop:e=>e.stopPropagation(),prevent:e=>e.preventDefault(),self:e=>e.target!==e.currentTarget,ctrl:e=>!e.ctrlKey,shift:e=>!e.shiftKey,alt:e=>!e.altKey,meta:e=>!e.metaKey,left:e=>"button"in e&&0!==e.button,middle:e=>"button"in e&&1!==e.button,right:e=>"button"in e&&2!==e.button,exact:(e,t)=>l1.some(n=>e[`${n}Key`]&&!t.includes(n))},l3={esc:"escape",space:" ",up:"arrow-up",left:"arrow-left",right:"arrow-right",down:"arrow-down",delete:"backspace"},l6=k({patchProp:(e,t,n,r,i,l)=>{let s="svg"===i;"class"===t?function(e,t,n){let r=e[i3];r&&(t=(t?[t,...r]:[...r]).join(" ")),null==t?e.removeAttribute("class"):n?e.setAttribute("class",t):e.className=t}(e,r,s):"style"===t?function(e,t,n){let r=e.style,i=M(n),l=!1;if(n&&!i){if(t){if(M(t))for(let e of t.split(";")){let t=e.slice(0,e.indexOf(":")).trim();null==n[t]&&lg(r,t,"")}else for(let e in t)null==n[e]&&lg(r,e,"")}for(let e in n)"display"===e&&(l=!0),lg(r,e,n[e])}else if(i){if(t!==n){let e=r[lp];e&&(n+=";"+e),r.cssText=n,l=lh.test(n)}}else t&&e.removeAttribute("style");lc in e&&(e[lc]=l?r.display:"",e[lu]&&(r.display="none"))}(e,n,r):x(t)?C(t)||function(e,t,n,r,i=null){let l=e[lC]||(e[lC]={}),s=l[t];if(r&&s)s.value=r;else{let[n,o]=function(e){let t;if(lk.test(e)){let n;for(t={};n=e.match(lk);)e=e.slice(0,e.length-n[0].length),t[n[0].toLowerCase()]=!0}return[":"===e[2]?e.slice(3):G(e.slice(2)),t]}(t);r?lx(e,n,l[t]=function(e,t){let n=e=>{if(e._vts){if(e._vts<=n.attached)return}else e._vts=Date.now();tW(function(e,t){if(!A(t))return t;{let n=e.stopImmediatePropagation;return e.stopImmediatePropagation=()=>{n.call(e),e._stopped=!0},t.map(e=>t=>!t._stopped&&e&&e(t))}}(e,n.value),t,5,[e])};return n.value=e,n.attached=lw(),n}(r,i),o):s&&(!function(e,t,n,r){e.removeEventListener(t,n,r)}(e,n,s,o),l[t]=void 0)}}(e,t,0,r,l):("."===t[0]?(t=t.slice(1),0):"^"===t[0]?(t=t.slice(1),1):!function(e,t,n,r){if(r)return!!("innerHTML"===t||"textContent"===t||t in e&&lA(t)&&P(n));if("spellcheck"===t||"draggable"===t||"translate"===t||"form"===t||"list"===t&&"INPUT"===e.tagName||"type"===t&&"TEXTAREA"===e.tagName)return!1;if("width"===t||"height"===t){let t=e.tagName;if("IMG"===t||"VIDEO"===t||"CANVAS"===t||"SOURCE"===t)return!1}return!(lA(t)&&M(n))&&t in e}(e,t,r,s))?e._isVueCE&&(/[A-Z]/.test(t)||!M(r))?lS(e,z(t),r,l,t):("true-value"===t?e._trueValue=r:"false-value"===t&&(e._falseValue=r),l_(e,t,r,s)):(lS(e,t,r),e.tagName.includes("-")||"value"!==t&&"checked"!==t&&"selected"!==t||l_(e,t,r,s,l,"value"!==t))}},{insert:(e,t,n)=>{t.insertBefore(e,n||null)},remove:e=>{let t=e.parentNode;t&&t.removeChild(e)},createElement:(e,t,n,r)=>{let i="svg"===t?iY.createElementNS("http://www.w3.org/2000/svg",e):"mathml"===t?iY.createElementNS("http://www.w3.org/1998/Math/MathML",e):n?iY.createElement(e,{is:n}):iY.createElement(e);return"select"===e&&r&&null!=r.multiple&&i.setAttribute("multiple",r.multiple),i},createText:e=>iY.createTextNode(e),createComment:e=>iY.createComment(e),setText:(e,t)=>{e.nodeValue=t},setElementText:(e,t)=>{e.textContent=t},parentNode:e=>e.parentNode,nextSibling:e=>e.nextSibling,querySelector:e=>iY.querySelector(e),setScopeId(e,t){e.setAttribute(t,"")},insertStaticContent(e,t,n,r,i,l){let s=n?n.previousSibling:t.lastChild;if(i&&(i===l||i.nextSibling))for(;t.insertBefore(i.cloneNode(!0),n),i!==l&&(i=i.nextSibling););else{i0.innerHTML=iZ("svg"===r?`<svg>${e}</svg>`:"mathml"===r?`<math>${e}</math>`:e);let i=i0.content;if("svg"===r||"mathml"===r){let e=i.firstChild;for(;e.firstChild;)i.appendChild(e.firstChild);i.removeChild(e)}t.insertBefore(i,n)}return[s?s.nextSibling:t.firstChild,n?n.previousSibling:t.lastChild]}}),l4=!1;function l8(){return p=l4?p:rU(l6),l4=!0,p}let l5=(...e)=>{(p||(p=rj(l6))).render(...e)},l9=(...e)=>{let t=(p||(p=rj(l6))).createApp(...e),{mount:n}=t;return t.mount=e=>{let r=st(e);if(!r)return;let i=t._component;P(i)||i.render||i.template||(i.template=r.innerHTML),1===r.nodeType&&(r.textContent="");let l=n(r,!1,se(r));return r instanceof Element&&(r.removeAttribute("v-cloak"),r.setAttribute("data-v-app","")),l},t},l7=(...e)=>{let t=l8().createApp(...e),{mount:n}=t;return t.mount=e=>{let t=st(e);if(t)return n(t,!0,se(t))},t};function se(e){return e instanceof SVGElement?"svg":"function"==typeof MathMLElement&&e instanceof MathMLElement?"mathml":void 0}function st(e){return M(e)?document.querySelector(e):e}let sn=Symbol(""),sr=Symbol(""),si=Symbol(""),sl=Symbol(""),ss=Symbol(""),so=Symbol(""),sa=Symbol(""),sc=Symbol(""),su=Symbol(""),sd=Symbol(""),sp=Symbol(""),sf=Symbol(""),sh=Symbol(""),sm=Symbol(""),sg=Symbol(""),sy=Symbol(""),sv=Symbol(""),sb=Symbol(""),s_=Symbol(""),sS=Symbol(""),sx=Symbol(""),sC=Symbol(""),sk=Symbol(""),sT=Symbol(""),sN=Symbol(""),sw=Symbol(""),sA=Symbol(""),sE=Symbol(""),sI=Symbol(""),sR=Symbol(""),sO=Symbol(""),sP=Symbol(""),sM=Symbol(""),sL=Symbol(""),s$=Symbol(""),sD=Symbol(""),sF=Symbol(""),sV=Symbol(""),sB=Symbol(""),sU={[sn]:"Fragment",[sr]:"Teleport",[si]:"Suspense",[sl]:"KeepAlive",[ss]:"BaseTransition",[so]:"openBlock",[sa]:"createBlock",[sc]:"createElementBlock",[su]:"createVNode",[sd]:"createElementVNode",[sp]:"createCommentVNode",[sf]:"createTextVNode",[sh]:"createStaticVNode",[sm]:"resolveComponent",[sg]:"resolveDynamicComponent",[sy]:"resolveDirective",[sv]:"resolveFilter",[sb]:"withDirectives",[s_]:"renderList",[sS]:"renderSlot",[sx]:"createSlots",[sC]:"toDisplayString",[sk]:"mergeProps",[sT]:"normalizeClass",[sN]:"normalizeStyle",[sw]:"normalizeProps",[sA]:"guardReactiveProps",[sE]:"toHandlers",[sI]:"camelize",[sR]:"capitalize",[sO]:"toHandlerKey",[sP]:"setBlockTracking",[sM]:"pushScopeId",[sL]:"popScopeId",[s$]:"withCtx",[sD]:"unref",[sF]:"isRef",[sV]:"withMemo",[sB]:"isMemoSame"},sj={start:{line:1,column:1,offset:0},end:{line:1,column:1,offset:0},source:""};function sH(e,t,n,r,i,l,s,o=!1,a=!1,c=!1,u=sj){return e&&(o?(e.helper(so),e.helper(e.inSSR||c?sa:sc)):e.helper(e.inSSR||c?su:sd),s&&e.helper(sb)),{type:13,tag:t,props:n,children:r,patchFlag:i,dynamicProps:l,directives:s,isBlock:o,disableTracking:a,isComponent:c,loc:u}}function sq(e,t=sj){return{type:17,loc:t,elements:e}}function sW(e,t=sj){return{type:15,loc:t,properties:e}}function sK(e,t){return{type:16,loc:sj,key:M(e)?sz(e,!0):e,value:t}}function sz(e,t=!1,n=sj,r=0){return{type:4,loc:n,content:e,isStatic:t,constType:t?3:r}}function sJ(e,t=sj){return{type:8,loc:t,children:e}}function sG(e,t=[],n=sj){return{type:14,loc:n,callee:e,arguments:t}}function sX(e,t,n=!1,r=!1,i=sj){return{type:18,params:e,returns:t,newline:n,isSlot:r,loc:i}}function sQ(e,t,n,r=!0){return{type:19,test:e,consequent:t,alternate:n,newline:r,loc:sj}}function sZ(e,{helper:t,removeHelper:n,inSSR:r}){if(!e.isBlock){var i,l;e.isBlock=!0,n((i=e.isComponent,r||i?su:sd)),t(so),t((l=e.isComponent,r||l?sa:sc))}}let sY=new Uint8Array([123,123]),s0=new Uint8Array([125,125]);function s1(e){return e>=97&&e<=122||e>=65&&e<=90}function s2(e){return 32===e||10===e||9===e||12===e||13===e}function s3(e){return 47===e||62===e||s2(e)}function s6(e){let t=new Uint8Array(e.length);for(let n=0;n<e.length;n++)t[n]=e.charCodeAt(n);return t}let s4={Cdata:new Uint8Array([67,68,65,84,65,91]),CdataEnd:new Uint8Array([93,93,62]),CommentEnd:new Uint8Array([45,45,62]),ScriptEnd:new Uint8Array([60,47,115,99,114,105,112,116]),StyleEnd:new Uint8Array([60,47,115,116,121,108,101]),TitleEnd:new Uint8Array([60,47,116,105,116,108,101]),TextareaEnd:new Uint8Array([60,47,116,101,120,116,97,114,101,97])};function s8(e){throw e}function s5(e){}function s9(e,t,n,r){let i=SyntaxError(String(`https://vuejs.org/error-reference/#compiler-${e}`));return i.code=e,i.loc=t,i}let s7=e=>4===e.type&&e.isStatic;function oe(e){switch(e){case"Teleport":case"teleport":return sr;case"Suspense":case"suspense":return si;case"KeepAlive":case"keep-alive":return sl;case"BaseTransition":case"base-transition":return ss}}let ot=/^\d|[^\$\w\xA0-\uFFFF]/,on=e=>!ot.test(e),or=/[A-Za-z_$\xA0-\uFFFF]/,oi=/[\.\?\w$\xA0-\uFFFF]/,ol=/\s+[.[]\s*|\s*[.[]\s+/g,os=e=>4===e.type?e.content:e.loc.source,oo=e=>{let t=os(e).trim().replace(ol,e=>e.trim()),n=0,r=[],i=0,l=0,s=null;for(let e=0;e<t.length;e++){let o=t.charAt(e);switch(n){case 0:if("["===o)r.push(n),n=1,i++;else if("("===o)r.push(n),n=2,l++;else if(!(0===e?or:oi).test(o))return!1;break;case 1:"'"===o||'"'===o||"`"===o?(r.push(n),n=3,s=o):"["===o?i++:"]"!==o||--i||(n=r.pop());break;case 2:if("'"===o||'"'===o||"`"===o)r.push(n),n=3,s=o;else if("("===o)l++;else if(")"===o){if(e===t.length-1)return!1;--l||(n=r.pop())}break;case 3:o===s&&(n=r.pop(),s=null)}}return!i&&!l},oa=/^\s*(async\s*)?(\([^)]*?\)|[\w$_]+)\s*(:[^=]+)?=>|^\s*(async\s+)?function(?:\s+[\w$]+)?\s*\(/,oc=e=>oa.test(os(e));function ou(e,t,n=!1){for(let r=0;r<e.props.length;r++){let i=e.props[r];if(7===i.type&&(n||i.exp)&&(M(t)?i.name===t:t.test(i.name)))return i}}function od(e,t,n=!1,r=!1){for(let i=0;i<e.props.length;i++){let l=e.props[i];if(6===l.type){if(n)continue;if(l.name===t&&(l.value||r))return l}else if("bind"===l.name&&(l.exp||r)&&op(l.arg,t))return l}}function op(e,t){return!!(e&&s7(e)&&e.content===t)}function of(e){return 5===e.type||2===e.type}function oh(e){return 7===e.type&&"slot"===e.name}function om(e){return 1===e.type&&3===e.tagType}function og(e){return 1===e.type&&2===e.tagType}let oy=new Set([sw,sA]);function ov(e,t,n){let r,i;let l=13===e.type?e.props:e.arguments[2],s=[];if(l&&!M(l)&&14===l.type){let e=function e(t,n=[]){if(t&&!M(t)&&14===t.type){let r=t.callee;if(!M(r)&&oy.has(r))return e(t.arguments[0],n.concat(t))}return[t,n]}(l);l=e[0],i=(s=e[1])[s.length-1]}if(null==l||M(l))r=sW([t]);else if(14===l.type){let e=l.arguments[0];M(e)||15!==e.type?l.callee===sE?r=sG(n.helper(sk),[sW([t]),l]):l.arguments.unshift(sW([t])):ob(t,e)||e.properties.unshift(t),r||(r=l)}else 15===l.type?(ob(t,l)||l.properties.unshift(t),r=l):(r=sG(n.helper(sk),[sW([t]),l]),i&&i.callee===sA&&(i=s[s.length-2]));13===e.type?i?i.arguments[0]=r:e.props=r:i?i.arguments[0]=r:e.arguments[2]=r}function ob(e,t){let n=!1;if(4===e.key.type){let r=e.key.content;n=t.properties.some(e=>4===e.key.type&&e.key.content===r)}return n}function o_(e,t){return`_${t}_${e.replace(/[^\w]/g,(t,n)=>"-"===t?"_":e.charCodeAt(n).toString())}`}let oS=/([\s\S]*?)\s+(?:in|of)\s+(\S[\s\S]*)/,ox={parseMode:"base",ns:0,delimiters:["{{","}}"],getNamespace:()=>0,isVoidTag:S,isPreTag:S,isIgnoreNewlineTag:S,isCustomElement:S,onError:s8,onWarn:s5,comments:!1,prefixIdentifiers:!1},oC=ox,ok=null,oT="",oN=null,ow=null,oA="",oE=-1,oI=-1,oR=0,oO=!1,oP=null,oM=[],oL=new class{constructor(e,t){this.stack=e,this.cbs=t,this.state=1,this.buffer="",this.sectionStart=0,this.index=0,this.entityStart=0,this.baseState=1,this.inRCDATA=!1,this.inXML=!1,this.inVPre=!1,this.newlines=[],this.mode=0,this.delimiterOpen=sY,this.delimiterClose=s0,this.delimiterIndex=-1,this.currentSequence=void 0,this.sequenceIndex=0}get inSFCRoot(){return 2===this.mode&&0===this.stack.length}reset(){this.state=1,this.mode=0,this.buffer="",this.sectionStart=0,this.index=0,this.baseState=1,this.inRCDATA=!1,this.currentSequence=void 0,this.newlines.length=0,this.delimiterOpen=sY,this.delimiterClose=s0}getPos(e){let t=1,n=e+1;for(let r=this.newlines.length-1;r>=0;r--){let i=this.newlines[r];if(e>i){t=r+2,n=e-i;break}}return{column:n,line:t,offset:e}}peek(){return this.buffer.charCodeAt(this.index+1)}stateText(e){60===e?(this.index>this.sectionStart&&this.cbs.ontext(this.sectionStart,this.index),this.state=5,this.sectionStart=this.index):this.inVPre||e!==this.delimiterOpen[0]||(this.state=2,this.delimiterIndex=0,this.stateInterpolationOpen(e))}stateInterpolationOpen(e){if(e===this.delimiterOpen[this.delimiterIndex]){if(this.delimiterIndex===this.delimiterOpen.length-1){let e=this.index+1-this.delimiterOpen.length;e>this.sectionStart&&this.cbs.ontext(this.sectionStart,e),this.state=3,this.sectionStart=e}else this.delimiterIndex++}else this.inRCDATA?(this.state=32,this.stateInRCDATA(e)):(this.state=1,this.stateText(e))}stateInterpolation(e){e===this.delimiterClose[0]&&(this.state=4,this.delimiterIndex=0,this.stateInterpolationClose(e))}stateInterpolationClose(e){e===this.delimiterClose[this.delimiterIndex]?this.delimiterIndex===this.delimiterClose.length-1?(this.cbs.oninterpolation(this.sectionStart,this.index+1),this.inRCDATA?this.state=32:this.state=1,this.sectionStart=this.index+1):this.delimiterIndex++:(this.state=3,this.stateInterpolation(e))}stateSpecialStartSequence(e){let t=this.sequenceIndex===this.currentSequence.length;if(t?s3(e):(32|e)===this.currentSequence[this.sequenceIndex]){if(!t){this.sequenceIndex++;return}}else this.inRCDATA=!1;this.sequenceIndex=0,this.state=6,this.stateInTagName(e)}stateInRCDATA(e){if(this.sequenceIndex===this.currentSequence.length){if(62===e||s2(e)){let t=this.index-this.currentSequence.length;if(this.sectionStart<t){let e=this.index;this.index=t,this.cbs.ontext(this.sectionStart,t),this.index=e}this.sectionStart=t+2,this.stateInClosingTagName(e),this.inRCDATA=!1;return}this.sequenceIndex=0}(32|e)===this.currentSequence[this.sequenceIndex]?this.sequenceIndex+=1:0===this.sequenceIndex?this.currentSequence!==s4.TitleEnd&&(this.currentSequence!==s4.TextareaEnd||this.inSFCRoot)?this.fastForwardTo(60)&&(this.sequenceIndex=1):this.inVPre||e!==this.delimiterOpen[0]||(this.state=2,this.delimiterIndex=0,this.stateInterpolationOpen(e)):this.sequenceIndex=Number(60===e)}stateCDATASequence(e){e===s4.Cdata[this.sequenceIndex]?++this.sequenceIndex===s4.Cdata.length&&(this.state=28,this.currentSequence=s4.CdataEnd,this.sequenceIndex=0,this.sectionStart=this.index+1):(this.sequenceIndex=0,this.state=23,this.stateInDeclaration(e))}fastForwardTo(e){for(;++this.index<this.buffer.length;){let t=this.buffer.charCodeAt(this.index);if(10===t&&this.newlines.push(this.index),t===e)return!0}return this.index=this.buffer.length-1,!1}stateInCommentLike(e){e===this.currentSequence[this.sequenceIndex]?++this.sequenceIndex===this.currentSequence.length&&(this.currentSequence===s4.CdataEnd?this.cbs.oncdata(this.sectionStart,this.index-2):this.cbs.oncomment(this.sectionStart,this.index-2),this.sequenceIndex=0,this.sectionStart=this.index+1,this.state=1):0===this.sequenceIndex?this.fastForwardTo(this.currentSequence[0])&&(this.sequenceIndex=1):e!==this.currentSequence[this.sequenceIndex-1]&&(this.sequenceIndex=0)}startSpecial(e,t){this.enterRCDATA(e,t),this.state=31}enterRCDATA(e,t){this.inRCDATA=!0,this.currentSequence=e,this.sequenceIndex=t}stateBeforeTagName(e){33===e?(this.state=22,this.sectionStart=this.index+1):63===e?(this.state=24,this.sectionStart=this.index+1):s1(e)?(this.sectionStart=this.index,0===this.mode?this.state=6:this.inSFCRoot?this.state=34:this.inXML?this.state=6:116===e?this.state=30:this.state=115===e?29:6):47===e?this.state=8:(this.state=1,this.stateText(e))}stateInTagName(e){s3(e)&&this.handleTagName(e)}stateInSFCRootTagName(e){if(s3(e)){let t=this.buffer.slice(this.sectionStart,this.index);"template"!==t&&this.enterRCDATA(s6("</"+t),0),this.handleTagName(e)}}handleTagName(e){this.cbs.onopentagname(this.sectionStart,this.index),this.sectionStart=-1,this.state=11,this.stateBeforeAttrName(e)}stateBeforeClosingTagName(e){s2(e)||(62===e?(this.state=1,this.sectionStart=this.index+1):(this.state=s1(e)?9:27,this.sectionStart=this.index))}stateInClosingTagName(e){(62===e||s2(e))&&(this.cbs.onclosetag(this.sectionStart,this.index),this.sectionStart=-1,this.state=10,this.stateAfterClosingTagName(e))}stateAfterClosingTagName(e){62===e&&(this.state=1,this.sectionStart=this.index+1)}stateBeforeAttrName(e){62===e?(this.cbs.onopentagend(this.index),this.inRCDATA?this.state=32:this.state=1,this.sectionStart=this.index+1):47===e?this.state=7:60===e&&47===this.peek()?(this.cbs.onopentagend(this.index),this.state=5,this.sectionStart=this.index):s2(e)||this.handleAttrStart(e)}handleAttrStart(e){118===e&&45===this.peek()?(this.state=13,this.sectionStart=this.index):46===e||58===e||64===e||35===e?(this.cbs.ondirname(this.index,this.index+1),this.state=14,this.sectionStart=this.index+1):(this.state=12,this.sectionStart=this.index)}stateInSelfClosingTag(e){62===e?(this.cbs.onselfclosingtag(this.index),this.state=1,this.sectionStart=this.index+1,this.inRCDATA=!1):s2(e)||(this.state=11,this.stateBeforeAttrName(e))}stateInAttrName(e){(61===e||s3(e))&&(this.cbs.onattribname(this.sectionStart,this.index),this.handleAttrNameEnd(e))}stateInDirName(e){61===e||s3(e)?(this.cbs.ondirname(this.sectionStart,this.index),this.handleAttrNameEnd(e)):58===e?(this.cbs.ondirname(this.sectionStart,this.index),this.state=14,this.sectionStart=this.index+1):46===e&&(this.cbs.ondirname(this.sectionStart,this.index),this.state=16,this.sectionStart=this.index+1)}stateInDirArg(e){61===e||s3(e)?(this.cbs.ondirarg(this.sectionStart,this.index),this.handleAttrNameEnd(e)):91===e?this.state=15:46===e&&(this.cbs.ondirarg(this.sectionStart,this.index),this.state=16,this.sectionStart=this.index+1)}stateInDynamicDirArg(e){93===e?this.state=14:(61===e||s3(e))&&(this.cbs.ondirarg(this.sectionStart,this.index+1),this.handleAttrNameEnd(e))}stateInDirModifier(e){61===e||s3(e)?(this.cbs.ondirmodifier(this.sectionStart,this.index),this.handleAttrNameEnd(e)):46===e&&(this.cbs.ondirmodifier(this.sectionStart,this.index),this.sectionStart=this.index+1)}handleAttrNameEnd(e){this.sectionStart=this.index,this.state=17,this.cbs.onattribnameend(this.index),this.stateAfterAttrName(e)}stateAfterAttrName(e){61===e?this.state=18:47===e||62===e?(this.cbs.onattribend(0,this.sectionStart),this.sectionStart=-1,this.state=11,this.stateBeforeAttrName(e)):s2(e)||(this.cbs.onattribend(0,this.sectionStart),this.handleAttrStart(e))}stateBeforeAttrValue(e){34===e?(this.state=19,this.sectionStart=this.index+1):39===e?(this.state=20,this.sectionStart=this.index+1):s2(e)||(this.sectionStart=this.index,this.state=21,this.stateInAttrValueNoQuotes(e))}handleInAttrValue(e,t){(e===t||this.fastForwardTo(t))&&(this.cbs.onattribdata(this.sectionStart,this.index),this.sectionStart=-1,this.cbs.onattribend(34===t?3:2,this.index+1),this.state=11)}stateInAttrValueDoubleQuotes(e){this.handleInAttrValue(e,34)}stateInAttrValueSingleQuotes(e){this.handleInAttrValue(e,39)}stateInAttrValueNoQuotes(e){s2(e)||62===e?(this.cbs.onattribdata(this.sectionStart,this.index),this.sectionStart=-1,this.cbs.onattribend(1,this.index),this.state=11,this.stateBeforeAttrName(e)):(39===e||60===e||61===e||96===e)&&this.cbs.onerr(18,this.index)}stateBeforeDeclaration(e){91===e?(this.state=26,this.sequenceIndex=0):this.state=45===e?25:23}stateInDeclaration(e){(62===e||this.fastForwardTo(62))&&(this.state=1,this.sectionStart=this.index+1)}stateInProcessingInstruction(e){(62===e||this.fastForwardTo(62))&&(this.cbs.onprocessinginstruction(this.sectionStart,this.index),this.state=1,this.sectionStart=this.index+1)}stateBeforeComment(e){45===e?(this.state=28,this.currentSequence=s4.CommentEnd,this.sequenceIndex=2,this.sectionStart=this.index+1):this.state=23}stateInSpecialComment(e){(62===e||this.fastForwardTo(62))&&(this.cbs.oncomment(this.sectionStart,this.index),this.state=1,this.sectionStart=this.index+1)}stateBeforeSpecialS(e){e===s4.ScriptEnd[3]?this.startSpecial(s4.ScriptEnd,4):e===s4.StyleEnd[3]?this.startSpecial(s4.StyleEnd,4):(this.state=6,this.stateInTagName(e))}stateBeforeSpecialT(e){e===s4.TitleEnd[3]?this.startSpecial(s4.TitleEnd,4):e===s4.TextareaEnd[3]?this.startSpecial(s4.TextareaEnd,4):(this.state=6,this.stateInTagName(e))}startEntity(){}stateInEntity(){}parse(e){for(this.buffer=e;this.index<this.buffer.length;){let e=this.buffer.charCodeAt(this.index);switch(10===e&&this.newlines.push(this.index),this.state){case 1:this.stateText(e);break;case 2:this.stateInterpolationOpen(e);break;case 3:this.stateInterpolation(e);break;case 4:this.stateInterpolationClose(e);break;case 31:this.stateSpecialStartSequence(e);break;case 32:this.stateInRCDATA(e);break;case 26:this.stateCDATASequence(e);break;case 19:this.stateInAttrValueDoubleQuotes(e);break;case 12:this.stateInAttrName(e);break;case 13:this.stateInDirName(e);break;case 14:this.stateInDirArg(e);break;case 15:this.stateInDynamicDirArg(e);break;case 16:this.stateInDirModifier(e);break;case 28:this.stateInCommentLike(e);break;case 27:this.stateInSpecialComment(e);break;case 11:this.stateBeforeAttrName(e);break;case 6:this.stateInTagName(e);break;case 34:this.stateInSFCRootTagName(e);break;case 9:this.stateInClosingTagName(e);break;case 5:this.stateBeforeTagName(e);break;case 17:this.stateAfterAttrName(e);break;case 20:this.stateInAttrValueSingleQuotes(e);break;case 18:this.stateBeforeAttrValue(e);break;case 8:this.stateBeforeClosingTagName(e);break;case 10:this.stateAfterClosingTagName(e);break;case 29:this.stateBeforeSpecialS(e);break;case 30:this.stateBeforeSpecialT(e);break;case 21:this.stateInAttrValueNoQuotes(e);break;case 7:this.stateInSelfClosingTag(e);break;case 23:this.stateInDeclaration(e);break;case 22:this.stateBeforeDeclaration(e);break;case 25:this.stateBeforeComment(e);break;case 24:this.stateInProcessingInstruction(e);break;case 33:this.stateInEntity()}this.index++}this.cleanup(),this.finish()}cleanup(){this.sectionStart!==this.index&&(1===this.state||32===this.state&&0===this.sequenceIndex?(this.cbs.ontext(this.sectionStart,this.index),this.sectionStart=this.index):(19===this.state||20===this.state||21===this.state)&&(this.cbs.onattribdata(this.sectionStart,this.index),this.sectionStart=this.index))}finish(){this.handleTrailingData(),this.cbs.onend()}handleTrailingData(){let e=this.buffer.length;this.sectionStart>=e||(28===this.state?this.currentSequence===s4.CdataEnd?this.cbs.oncdata(this.sectionStart,e):this.cbs.oncomment(this.sectionStart,e):6===this.state||11===this.state||18===this.state||17===this.state||12===this.state||13===this.state||14===this.state||15===this.state||16===this.state||20===this.state||19===this.state||21===this.state||9===this.state||this.cbs.ontext(this.sectionStart,e))}emitCodePoint(e,t){}}(oM,{onerr:oQ,ontext(e,t){oB(oF(e,t),e,t)},ontextentity(e,t,n){oB(e,t,n)},oninterpolation(e,t){if(oO)return oB(oF(e,t),e,t);let n=e+oL.delimiterOpen.length,r=t-oL.delimiterClose.length;for(;s2(oT.charCodeAt(n));)n++;for(;s2(oT.charCodeAt(r-1));)r--;let i=oF(n,r);i.includes("&")&&(i=oC.decodeEntities(i,!1)),oz({type:5,content:oX(i,!1,oJ(n,r)),loc:oJ(e,t)})},onopentagname(e,t){let n=oF(e,t);oN={type:1,tag:n,ns:oC.getNamespace(n,oM[0],oC.ns),tagType:0,props:[],children:[],loc:oJ(e-1,t),codegenNode:void 0}},onopentagend(e){oV(e)},onclosetag(e,t){let n=oF(e,t);if(!oC.isVoidTag(n)){let r=!1;for(let e=0;e<oM.length;e++)if(oM[e].tag.toLowerCase()===n.toLowerCase()){r=!0,e>0&&oM[0].loc.start.offset;for(let n=0;n<=e;n++)oU(oM.shift(),t,n<e);break}r||oj(e,60)}},onselfclosingtag(e){let t=oN.tag;oN.isSelfClosing=!0,oV(e),oM[0]&&oM[0].tag===t&&oU(oM.shift(),e)},onattribname(e,t){ow={type:6,name:oF(e,t),nameLoc:oJ(e,t),value:void 0,loc:oJ(e)}},ondirname(e,t){let n=oF(e,t),r="."===n||":"===n?"bind":"@"===n?"on":"#"===n?"slot":n.slice(2);if(oO||""===r)ow={type:6,name:n,nameLoc:oJ(e,t),value:void 0,loc:oJ(e)};else if(ow={type:7,name:r,rawName:n,exp:void 0,arg:void 0,modifiers:"."===n?[sz("prop")]:[],loc:oJ(e)},"pre"===r){oO=oL.inVPre=!0,oP=oN;let e=oN.props;for(let t=0;t<e.length;t++)7===e[t].type&&(e[t]=function(e){let t={type:6,name:e.rawName,nameLoc:oJ(e.loc.start.offset,e.loc.start.offset+e.rawName.length),value:void 0,loc:e.loc};if(e.exp){let n=e.exp.loc;n.end.offset<e.loc.end.offset&&(n.start.offset--,n.start.column--,n.end.offset++,n.end.column++),t.value={type:2,content:e.exp.content,loc:n}}return t}(e[t]))}},ondirarg(e,t){if(e===t)return;let n=oF(e,t);if(oO)ow.name+=n,oG(ow.nameLoc,t);else{let r="["!==n[0];ow.arg=oX(r?n:n.slice(1,-1),r,oJ(e,t),r?3:0)}},ondirmodifier(e,t){let n=oF(e,t);if(oO)ow.name+="."+n,oG(ow.nameLoc,t);else if("slot"===ow.name){let e=ow.arg;e&&(e.content+="."+n,oG(e.loc,t))}else{let r=sz(n,!0,oJ(e,t));ow.modifiers.push(r)}},onattribdata(e,t){oA+=oF(e,t),oE<0&&(oE=e),oI=t},onattribentity(e,t,n){oA+=e,oE<0&&(oE=t),oI=n},onattribnameend(e){let t=oF(ow.loc.start.offset,e);7===ow.type&&(ow.rawName=t),oN.props.some(e=>(7===e.type?e.rawName:e.name)===t)},onattribend(e,t){oN&&ow&&(oG(ow.loc,t),0!==e&&(oA.includes("&")&&(oA=oC.decodeEntities(oA,!0)),6===ow.type?("class"===ow.name&&(oA=oK(oA).trim()),ow.value={type:2,content:oA,loc:1===e?oJ(oE,oI):oJ(oE-1,oI+1)},oL.inSFCRoot&&"template"===oN.tag&&"lang"===ow.name&&oA&&"html"!==oA&&oL.enterRCDATA(s6("</template"),0)):(ow.exp=oX(oA,!1,oJ(oE,oI),0,0),"for"===ow.name&&(ow.forParseResult=function(e){let t=e.loc,n=e.content,r=n.match(oS);if(!r)return;let[,i,l]=r,s=(e,n,r=!1)=>{let i=t.start.offset+n,l=i+e.length;return oX(e,!1,oJ(i,l),0,r?1:0)},o={source:s(l.trim(),n.indexOf(l,i.length)),value:void 0,key:void 0,index:void 0,finalized:!1},a=i.trim().replace(oD,"").trim(),c=i.indexOf(a),u=a.match(o$);if(u){let e;a=a.replace(o$,"").trim();let t=u[1].trim();if(t&&(e=n.indexOf(t,c+a.length),o.key=s(t,e,!0)),u[2]){let r=u[2].trim();r&&(o.index=s(r,n.indexOf(r,o.key?e+t.length:c+a.length),!0))}}return a&&(o.value=s(a,c,!0)),o}(ow.exp)))),(7!==ow.type||"pre"!==ow.name)&&oN.props.push(ow)),oA="",oE=oI=-1},oncomment(e,t){oC.comments&&oz({type:3,content:oF(e,t),loc:oJ(e-4,t+3)})},onend(){let e=oT.length;for(let t=0;t<oM.length;t++)oU(oM[t],e-1),oM[t].loc.start.offset},oncdata(e,t){0!==oM[0].ns&&oB(oF(e,t),e,t)},onprocessinginstruction(e){(oM[0]?oM[0].ns:oC.ns)===0&&oQ(21,e-1)}}),o$=/,([^,\}\]]*)(?:,([^,\}\]]*))?$/,oD=/^\(|\)$/g;function oF(e,t){return oT.slice(e,t)}function oV(e){oL.inSFCRoot&&(oN.innerLoc=oJ(e+1,e+1)),oz(oN);let{tag:t,ns:n}=oN;0===n&&oC.isPreTag(t)&&oR++,oC.isVoidTag(t)?oU(oN,e):(oM.unshift(oN),(1===n||2===n)&&(oL.inXML=!0)),oN=null}function oB(e,t,n){{let t=oM[0]&&oM[0].tag;"script"!==t&&"style"!==t&&e.includes("&")&&(e=oC.decodeEntities(e,!1))}let r=oM[0]||ok,i=r.children[r.children.length-1];i&&2===i.type?(i.content+=e,oG(i.loc,n)):r.children.push({type:2,content:e,loc:oJ(t,n)})}function oU(e,t,n=!1){n?oG(e.loc,oj(t,60)):oG(e.loc,function(e,t){let n=e;for(;62!==oT.charCodeAt(n)&&n<oT.length-1;)n++;return n}(t,0)+1),oL.inSFCRoot&&(e.children.length?e.innerLoc.end=k({},e.children[e.children.length-1].loc.end):e.innerLoc.end=k({},e.innerLoc.start),e.innerLoc.source=oF(e.innerLoc.start.offset,e.innerLoc.end.offset));let{tag:r,ns:i,children:l}=e;if(!oO&&("slot"===r?e.tagType=2:function({tag:e,props:t}){if("template"===e){for(let e=0;e<t.length;e++)if(7===t[e].type&&oH.has(t[e].name))return!0}return!1}(e)?e.tagType=3:function({tag:e,props:t}){var n;if(oC.isCustomElement(e))return!1;if("component"===e||(n=e.charCodeAt(0))>64&&n<91||oe(e)||oC.isBuiltInComponent&&oC.isBuiltInComponent(e)||oC.isNativeTag&&!oC.isNativeTag(e))return!0;for(let e=0;e<t.length;e++){let n=t[e];if(6===n.type&&"is"===n.name&&n.value&&n.value.content.startsWith("vue:"))return!0}return!1}(e)&&(e.tagType=1)),oL.inRCDATA||(e.children=oW(l)),0===i&&oC.isIgnoreNewlineTag(r)){let e=l[0];e&&2===e.type&&(e.content=e.content.replace(/^\r?\n/,""))}0===i&&oC.isPreTag(r)&&oR--,oP===e&&(oO=oL.inVPre=!1,oP=null),oL.inXML&&(oM[0]?oM[0].ns:oC.ns)===0&&(oL.inXML=!1)}function oj(e,t){let n=e;for(;oT.charCodeAt(n)!==t&&n>=0;)n--;return n}let oH=new Set(["if","else","else-if","for","slot"]),oq=/\r\n/g;function oW(e,t){let n="preserve"!==oC.whitespace,r=!1;for(let t=0;t<e.length;t++){let i=e[t];if(2===i.type){if(oR)i.content=i.content.replace(oq,"\n");else if(function(e){for(let t=0;t<e.length;t++)if(!s2(e.charCodeAt(t)))return!1;return!0}(i.content)){let l=e[t-1]&&e[t-1].type,s=e[t+1]&&e[t+1].type;!l||!s||n&&(3===l&&(3===s||1===s)||1===l&&(3===s||1===s&&function(e){for(let t=0;t<e.length;t++){let n=e.charCodeAt(t);if(10===n||13===n)return!0}return!1}(i.content)))?(r=!0,e[t]=null):i.content=" "}else n&&(i.content=oK(i.content))}}return r?e.filter(Boolean):e}function oK(e){let t="",n=!1;for(let r=0;r<e.length;r++)s2(e.charCodeAt(r))?n||(t+=" ",n=!0):(t+=e[r],n=!1);return t}function oz(e){(oM[0]||ok).children.push(e)}function oJ(e,t){return{start:oL.getPos(e),end:null==t?t:oL.getPos(t),source:null==t?t:oF(e,t)}}function oG(e,t){e.end=oL.getPos(t),e.source=oF(e.start.offset,t)}function oX(e,t=!1,n,r=0,i=0){return sz(e,t,n,r)}function oQ(e,t,n){oC.onError(s9(e,oJ(t,t)))}function oZ(e,t){let{children:n}=e;return 1===n.length&&1===t.type&&!og(t)}function oY(e,t){let{constantCache:n}=t;switch(e.type){case 1:if(0!==e.tagType)return 0;let r=n.get(e);if(void 0!==r)return r;let i=e.codegenNode;if(13!==i.type||i.isBlock&&"svg"!==e.tag&&"foreignObject"!==e.tag&&"math"!==e.tag)return 0;if(void 0!==i.patchFlag)return n.set(e,0),0;{let r=3,c=o1(e,t);if(0===c)return n.set(e,0),0;c<r&&(r=c);for(let i=0;i<e.children.length;i++){let l=oY(e.children[i],t);if(0===l)return n.set(e,0),0;l<r&&(r=l)}if(r>1)for(let i=0;i<e.props.length;i++){let l=e.props[i];if(7===l.type&&"bind"===l.name&&l.exp){let i=oY(l.exp,t);if(0===i)return n.set(e,0),0;i<r&&(r=i)}}if(i.isBlock){var l,s,o,a;for(let t=0;t<e.props.length;t++)if(7===e.props[t].type)return n.set(e,0),0;t.removeHelper(so),t.removeHelper((l=t.inSSR,s=i.isComponent,l||s?sa:sc)),i.isBlock=!1,t.helper((o=t.inSSR,a=i.isComponent,o||a?su:sd))}return n.set(e,r),r}case 2:case 3:return 3;case 9:case 11:case 10:default:return 0;case 5:case 12:return oY(e.content,t);case 4:return e.constType;case 8:let c=3;for(let n=0;n<e.children.length;n++){let r=e.children[n];if(M(r)||L(r))continue;let i=oY(r,t);if(0===i)return 0;i<c&&(c=i)}return c;case 20:return 2}}let o0=new Set([sT,sN,sw,sA]);function o1(e,t){let n=3,r=o2(e);if(r&&15===r.type){let{properties:e}=r;for(let r=0;r<e.length;r++){let i;let{key:l,value:s}=e[r],o=oY(l,t);if(0===o)return o;if(o<n&&(n=o),0===(i=4===s.type?oY(s,t):14===s.type?function e(t,n){if(14===t.type&&!M(t.callee)&&o0.has(t.callee)){let r=t.arguments[0];if(4===r.type)return oY(r,n);if(14===r.type)return e(r,n)}return 0}(s,t):0))return i;i<n&&(n=i)}}return n}function o2(e){let t=e.codegenNode;if(13===t.type)return t.props}function o3(e,t){t.currentNode=e;let{nodeTransforms:n}=t,r=[];for(let i=0;i<n.length;i++){let l=n[i](e,t);if(l&&(A(l)?r.push(...l):r.push(l)),!t.currentNode)return;e=t.currentNode}switch(e.type){case 3:t.ssr||t.helper(sp);break;case 5:t.ssr||t.helper(sC);break;case 9:for(let n=0;n<e.branches.length;n++)o3(e.branches[n],t);break;case 10:case 11:case 1:case 0:!function(e,t){let n=0,r=()=>{n--};for(;n<e.children.length;n++){let i=e.children[n];M(i)||(t.grandParent=t.parent,t.parent=e,t.childIndex=n,t.onNodeRemoved=r,o3(i,t))}}(e,t)}t.currentNode=e;let i=r.length;for(;i--;)r[i]()}function o6(e,t){let n=M(e)?t=>t===e:t=>e.test(t);return(e,r)=>{if(1===e.type){let{props:i}=e;if(3===e.tagType&&i.some(oh))return;let l=[];for(let s=0;s<i.length;s++){let o=i[s];if(7===o.type&&n(o.name)){i.splice(s,1),s--;let n=t(e,o,r);n&&l.push(n)}}return l}}}let o4="/*@__PURE__*/",o8=e=>`${sU[e]}: _${sU[e]}`;function o5(e,t,{helper:n,push:r,newline:i,isTS:l}){let s=n("component"===t?sm:sy);for(let n=0;n<e.length;n++){let o=e[n],a=o.endsWith("__self");a&&(o=o.slice(0,-6)),r(`const ${o_(o,t)} = ${s}(${JSON.stringify(o)}${a?", true":""})${l?"!":""}`),n<e.length-1&&i()}}function o9(e,t){let n=e.length>3;t.push("["),n&&t.indent(),o7(e,t,n),n&&t.deindent(),t.push("]")}function o7(e,t,n=!1,r=!0){let{push:i,newline:l}=t;for(let s=0;s<e.length;s++){let o=e[s];M(o)?i(o,-3):A(o)?o9(o,t):ae(o,t),s<e.length-1&&(n?(r&&i(","),l()):r&&i(", "))}}function ae(e,t){if(M(e)){t.push(e,-3);return}if(L(e)){t.push(t.helper(e));return}switch(e.type){case 1:case 9:case 11:case 12:ae(e.codegenNode,t);break;case 2:!function(e,t){t.push(JSON.stringify(e.content),-3,e)}(e,t);break;case 4:at(e,t);break;case 5:!function(e,t){let{push:n,helper:r,pure:i}=t;i&&n(o4),n(`${r(sC)}(`),ae(e.content,t),n(")")}(e,t);break;case 8:an(e,t);break;case 3:!function(e,t){let{push:n,helper:r,pure:i}=t;i&&n(o4),n(`${r(sp)}(${JSON.stringify(e.content)})`,-3,e)}(e,t);break;case 13:!function(e,t){let n;let{push:r,helper:i,pure:l}=t,{tag:s,props:o,children:a,patchFlag:c,dynamicProps:u,directives:d,isBlock:p,disableTracking:f,isComponent:h}=e;c&&(n=String(c)),d&&r(i(sb)+"("),p&&r(`(${i(so)}(${f?"true":""}), `),l&&r(o4),r(i(p?t.inSSR||h?sa:sc:t.inSSR||h?su:sd)+"(",-2,e),o7(function(e){let t=e.length;for(;t--&&null==e[t];);return e.slice(0,t+1).map(e=>e||"null")}([s,o,a,n,u]),t),r(")"),p&&r(")"),d&&(r(", "),ae(d,t),r(")"))}(e,t);break;case 14:!function(e,t){let{push:n,helper:r,pure:i}=t,l=M(e.callee)?e.callee:r(e.callee);i&&n(o4),n(l+"(",-2,e),o7(e.arguments,t),n(")")}(e,t);break;case 15:!function(e,t){let{push:n,indent:r,deindent:i,newline:l}=t,{properties:s}=e;if(!s.length){n("{}",-2,e);return}let o=s.length>1;n(o?"{":"{ "),o&&r();for(let e=0;e<s.length;e++){let{key:r,value:i}=s[e];!function(e,t){let{push:n}=t;8===e.type?(n("["),an(e,t),n("]")):e.isStatic?n(on(e.content)?e.content:JSON.stringify(e.content),-2,e):n(`[${e.content}]`,-3,e)}(r,t),n(": "),ae(i,t),e<s.length-1&&(n(","),l())}o&&i(),n(o?"}":" }")}(e,t);break;case 17:o9(e.elements,t);break;case 18:!function(e,t){let{push:n,indent:r,deindent:i}=t,{params:l,returns:s,body:o,newline:a,isSlot:c}=e;c&&n(`_${sU[s$]}(`),n("(",-2,e),A(l)?o7(l,t):l&&ae(l,t),n(") => "),(a||o)&&(n("{"),r()),s?(a&&n("return "),A(s)?o9(s,t):ae(s,t)):o&&ae(o,t),(a||o)&&(i(),n("}")),c&&n(")")}(e,t);break;case 19:!function(e,t){let{test:n,consequent:r,alternate:i,newline:l}=e,{push:s,indent:o,deindent:a,newline:c}=t;if(4===n.type){let e=!on(n.content);e&&s("("),at(n,t),e&&s(")")}else s("("),ae(n,t),s(")");l&&o(),t.indentLevel++,l||s(" "),s("? "),ae(r,t),t.indentLevel--,l&&c(),l||s(" "),s(": ");let u=19===i.type;!u&&t.indentLevel++,ae(i,t),!u&&t.indentLevel--,l&&a(!0)}(e,t);break;case 20:!function(e,t){let{push:n,helper:r,indent:i,deindent:l,newline:s}=t,{needPauseTracking:o,needArraySpread:a}=e;a&&n("[...("),n(`_cache[${e.index}] || (`),o&&(i(),n(`${r(sP)}(-1`),e.inVOnce&&n(", true"),n("),"),s(),n("(")),n(`_cache[${e.index}] = `),ae(e.value,t),o&&(n(`).cacheIndex = ${e.index},`),s(),n(`${r(sP)}(1),`),s(),n(`_cache[${e.index}]`),l()),n(")"),a&&n(")]")}(e,t);break;case 21:o7(e.body,t,!0,!1)}}function at(e,t){let{content:n,isStatic:r}=e;t.push(r?JSON.stringify(n):n,-3,e)}function an(e,t){for(let n=0;n<e.children.length;n++){let r=e.children[n];M(r)?t.push(r,-3):ae(r,t)}}let ar=o6(/^(if|else|else-if)$/,(e,t,n)=>(function(e,t,n,r){if("else"!==t.name&&(!t.exp||!t.exp.content.trim())){let r=t.exp?t.exp.loc:e.loc;n.onError(s9(28,t.loc)),t.exp=sz("true",!1,r)}if("if"===t.name){var i;let l=ai(e,t),s={type:9,loc:oJ((i=e.loc).start.offset,i.end.offset),branches:[l]};if(n.replaceNode(s),r)return r(s,l,!0)}else{let i=n.parent.children,l=i.indexOf(e);for(;l-- >=-1;){let s=i[l];if(s&&3===s.type||s&&2===s.type&&!s.content.trim().length){n.removeNode(s);continue}if(s&&9===s.type){"else-if"===t.name&&void 0===s.branches[s.branches.length-1].condition&&n.onError(s9(30,e.loc)),n.removeNode();let i=ai(e,t);s.branches.push(i);let l=r&&r(s,i,!1);o3(i,n),l&&l(),n.currentNode=null}else n.onError(s9(30,e.loc));break}}})(e,t,n,(e,t,r)=>{let i=n.parent.children,l=i.indexOf(e),s=0;for(;l-- >=0;){let e=i[l];e&&9===e.type&&(s+=e.branches.length)}return()=>{r?e.codegenNode=al(t,s,n):function(e){for(;;)if(19===e.type){if(19!==e.alternate.type)return e;e=e.alternate}else 20===e.type&&(e=e.value)}(e.codegenNode).alternate=al(t,s+e.branches.length-1,n)}}));function ai(e,t){let n=3===e.tagType;return{type:10,loc:e.loc,condition:"else"===t.name?void 0:t.exp,children:n&&!ou(e,"for")?e.children:[e],userKey:od(e,"key"),isTemplateIf:n}}function al(e,t,n){return e.condition?sQ(e.condition,as(e,t,n),sG(n.helper(sp),['""',"true"])):as(e,t,n)}function as(e,t,n){let{helper:r}=n,i=sK("key",sz(`${t}`,!1,sj,2)),{children:l}=e,s=l[0];if(1!==l.length||1!==s.type){if(1!==l.length||11!==s.type)return sH(n,r(sn),sW([i]),l,64,void 0,void 0,!0,!1,!1,e.loc);{let e=s.codegenNode;return ov(e,i,n),e}}{let e=s.codegenNode,t=14===e.type&&e.callee===sV?e.arguments[1].returns:e;return 13===t.type&&sZ(t,n),ov(t,i,n),e}}let ao=(e,t,n)=>{let{modifiers:r,loc:i}=e,l=e.arg,{exp:s}=e;if(s&&4===s.type&&!s.content.trim()&&(s=void 0),!s){if(4!==l.type||!l.isStatic)return n.onError(s9(52,l.loc)),{props:[sK(l,sz("",!0,i))]};aa(e),s=e.exp}return 4!==l.type?(l.children.unshift("("),l.children.push(') || ""')):l.isStatic||(l.content=`${l.content} || ""`),r.some(e=>"camel"===e.content)&&(4===l.type?l.isStatic?l.content=z(l.content):l.content=`${n.helperString(sI)}(${l.content})`:(l.children.unshift(`${n.helperString(sI)}(`),l.children.push(")"))),!n.inSSR&&(r.some(e=>"prop"===e.content)&&ac(l,"."),r.some(e=>"attr"===e.content)&&ac(l,"^")),{props:[sK(l,s)]}},aa=(e,t)=>{let n=e.arg,r=z(n.content);e.exp=sz(r,!1,n.loc)},ac=(e,t)=>{4===e.type?e.isStatic?e.content=t+e.content:e.content=`\`${t}\${${e.content}}\``:(e.children.unshift(`'${t}' + (`),e.children.push(")"))},au=o6("for",(e,t,n)=>{let{helper:r,removeHelper:i}=n;return function(e,t,n,r){if(!t.exp){n.onError(s9(31,t.loc));return}let i=t.forParseResult;if(!i){n.onError(s9(32,t.loc));return}ad(i);let{addIdentifiers:l,removeIdentifiers:s,scopes:o}=n,{source:a,value:c,key:u,index:d}=i,p={type:11,loc:t.loc,source:a,valueAlias:c,keyAlias:u,objectIndexAlias:d,parseResult:i,children:om(e)?e.children:[e]};n.replaceNode(p),o.vFor++;let f=r&&r(p);return()=>{o.vFor--,f&&f()}}(e,t,n,t=>{let l=sG(r(s_),[t.source]),s=om(e),o=ou(e,"memo"),a=od(e,"key",!1,!0);a&&7===a.type&&!a.exp&&aa(a);let c=a&&(6===a.type?a.value?sz(a.value.content,!0):void 0:a.exp),u=a&&c?sK("key",c):null,d=4===t.source.type&&t.source.constType>0,p=d?64:a?128:256;return t.codegenNode=sH(n,r(sn),void 0,l,p,void 0,void 0,!0,!d,!1,e.loc),()=>{let a;let{children:p}=t,f=1!==p.length||1!==p[0].type,h=og(e)?e:s&&1===e.children.length&&og(e.children[0])?e.children[0]:null;if(h)a=h.codegenNode,s&&u&&ov(a,u,n);else if(f)a=sH(n,r(sn),u?sW([u]):void 0,e.children,64,void 0,void 0,!0,void 0,!1);else{var m,g,y,b,_,S,x,C;a=p[0].codegenNode,s&&u&&ov(a,u,n),!d!==a.isBlock&&(a.isBlock?(i(so),i((m=n.inSSR,g=a.isComponent,m||g?sa:sc))):i((y=n.inSSR,b=a.isComponent,y||b?su:sd))),(a.isBlock=!d,a.isBlock)?(r(so),r((_=n.inSSR,S=a.isComponent,_||S?sa:sc))):r((x=n.inSSR,C=a.isComponent,x||C?su:sd))}if(o){let e=sX(ap(t.parseResult,[sz("_cached")]));e.body={type:21,body:[sJ(["const _memo = (",o.exp,")"]),sJ(["if (_cached",...c?[" && _cached.key === ",c]:[],` && ${n.helperString(sB)}(_cached, _memo)) return _cached`]),sJ(["const _item = ",a]),sz("_item.memo = _memo"),sz("return _item")],loc:sj},l.arguments.push(e,sz("_cache"),sz(String(n.cached.length))),n.cached.push(null)}else l.arguments.push(sX(ap(t.parseResult),a,!0))}})});function ad(e,t){e.finalized||(e.finalized=!0)}function ap({value:e,key:t,index:n},r=[]){return function(e){let t=e.length;for(;t--&&!e[t];);return e.slice(0,t+1).map((e,t)=>e||sz("_".repeat(t+1),!1))}([e,t,n,...r])}let af=sz("undefined",!1),ah=(e,t)=>{if(1===e.type&&(1===e.tagType||3===e.tagType)){let n=ou(e,"slot");if(n)return n.exp,t.scopes.vSlot++,()=>{t.scopes.vSlot--}}},am=(e,t,n,r)=>sX(e,n,!1,!0,n.length?n[0].loc:r);function ag(e,t,n){let r=[sK("name",e),sK("fn",t)];return null!=n&&r.push(sK("key",sz(String(n),!0))),sW(r)}let ay=new WeakMap,av=(e,t)=>function(){let n,r,i,l,s;if(!(1===(e=t.currentNode).type&&(0===e.tagType||1===e.tagType)))return;let{tag:o,props:a}=e,c=1===e.tagType,u=c?function(e,t,n=!1){let{tag:r}=e,i=aS(r),l=od(e,"is",!1,!0);if(l){if(i){let e;if(6===l.type?e=l.value&&sz(l.value.content,!0):(e=l.exp)||(e=sz("is",!1,l.arg.loc)),e)return sG(t.helper(sg),[e])}else 6===l.type&&l.value.content.startsWith("vue:")&&(r=l.value.content.slice(4))}let s=oe(r)||t.isBuiltInComponent(r);return s?(n||t.helper(s),s):(t.helper(sm),t.components.add(r),o_(r,"component"))}(e,t):`"${o}"`,d=$(u)&&u.callee===sg,p=0,f=d||u===sr||u===si||!c&&("svg"===o||"foreignObject"===o||"math"===o);if(a.length>0){let r=ab(e,t,void 0,c,d);n=r.props,p=r.patchFlag,l=r.dynamicPropNames;let i=r.directives;s=i&&i.length?sq(i.map(e=>(function(e,t){let n=[],r=ay.get(e);r?n.push(t.helperString(r)):(t.helper(sy),t.directives.add(e.name),n.push(o_(e.name,"directive")));let{loc:i}=e;if(e.exp&&n.push(e.exp),e.arg&&(e.exp||n.push("void 0"),n.push(e.arg)),Object.keys(e.modifiers).length){e.arg||(e.exp||n.push("void 0"),n.push("void 0"));let t=sz("true",!1,i);n.push(sW(e.modifiers.map(e=>sK(e,t)),i))}return sq(n,e.loc)})(e,t))):void 0,r.shouldUseBlock&&(f=!0)}if(e.children.length>0){if(u===sl&&(f=!0,p|=1024),c&&u!==sr&&u!==sl){let{slots:n,hasDynamicSlots:i}=function(e,t,n=am){t.helper(s$);let{children:r,loc:i}=e,l=[],s=[],o=t.scopes.vSlot>0||t.scopes.vFor>0,a=ou(e,"slot",!0);if(a){let{arg:e,exp:t}=a;e&&!s7(e)&&(o=!0),l.push(sK(e||sz("default",!0),n(t,void 0,r,i)))}let c=!1,u=!1,d=[],p=new Set,f=0;for(let e=0;e<r.length;e++){let i,h,m,g;let y=r[e];if(!om(y)||!(i=ou(y,"slot",!0))){3!==y.type&&d.push(y);continue}if(a){t.onError(s9(37,i.loc));break}c=!0;let{children:b,loc:_}=y,{arg:S=sz("default",!0),exp:x,loc:C}=i;s7(S)?h=S?S.content:"default":o=!0;let k=ou(y,"for"),T=n(x,k,b,_);if(m=ou(y,"if"))o=!0,s.push(sQ(m.exp,ag(S,T,f++),af));else if(g=ou(y,/^else(-if)?$/,!0)){let n,i=e;for(;i--&&3===(n=r[i]).type;);if(n&&om(n)&&ou(n,/^(else-)?if$/)){let e=s[s.length-1];for(;19===e.alternate.type;)e=e.alternate;e.alternate=g.exp?sQ(g.exp,ag(S,T,f++),af):ag(S,T,f++)}else t.onError(s9(30,g.loc))}else if(k){o=!0;let e=k.forParseResult;e?(ad(e),s.push(sG(t.helper(s_),[e.source,sX(ap(e),ag(S,T),!0)]))):t.onError(s9(32,k.loc))}else{if(h){if(p.has(h)){t.onError(s9(38,C));continue}p.add(h),"default"===h&&(u=!0)}l.push(sK(S,T))}}if(!a){let e=(e,t)=>sK("default",n(e,void 0,t,i));c?d.length&&d.some(e=>(function e(t){return 2!==t.type&&12!==t.type||(2===t.type?!!t.content.trim():e(t.content))})(e))&&(u?t.onError(s9(39,d[0].loc)):l.push(e(void 0,d))):l.push(e(void 0,r))}let h=o?2:!function e(t){for(let n=0;n<t.length;n++){let r=t[n];switch(r.type){case 1:if(2===r.tagType||e(r.children))return!0;break;case 9:if(e(r.branches))return!0;break;case 10:case 11:if(e(r.children))return!0}}return!1}(e.children)?1:3,m=sW(l.concat(sK("_",sz(h+"",!1))),i);return s.length&&(m=sG(t.helper(sx),[m,sq(s)])),{slots:m,hasDynamicSlots:o}}(e,t);r=n,i&&(p|=1024)}else if(1===e.children.length&&u!==sr){let n=e.children[0],i=n.type,l=5===i||8===i;l&&0===oY(n,t)&&(p|=1),r=l||2===i?n:e.children}else r=e.children}l&&l.length&&(i=function(e){let t="[";for(let n=0,r=e.length;n<r;n++)t+=JSON.stringify(e[n]),n<r-1&&(t+=", ");return t+"]"}(l)),e.codegenNode=sH(t,u,n,r,0===p?void 0:p,i,s,!!f,!1,c,e.loc)};function ab(e,t,n=e.props,r,i,l=!1){let s;let{tag:o,loc:a,children:c}=e,u=[],d=[],p=[],f=c.length>0,h=!1,m=0,g=!1,y=!1,b=!1,_=!1,S=!1,C=!1,k=[],T=e=>{u.length&&(d.push(sW(a_(u),a)),u=[]),e&&d.push(e)},N=()=>{t.scopes.vFor>0&&u.push(sK(sz("ref_for",!0),sz("true")))},w=({key:e,value:n})=>{if(s7(e)){let l=e.content,s=x(l);s&&(!r||i)&&"onclick"!==l.toLowerCase()&&"onUpdate:modelValue"!==l&&!H(l)&&(_=!0),s&&H(l)&&(C=!0),s&&14===n.type&&(n=n.arguments[0]),20===n.type||(4===n.type||8===n.type)&&oY(n,t)>0||("ref"===l?g=!0:"class"===l?y=!0:"style"===l?b=!0:"key"===l||k.includes(l)||k.push(l),r&&("class"===l||"style"===l)&&!k.includes(l)&&k.push(l))}else S=!0};for(let i=0;i<n.length;i++){let s=n[i];if(6===s.type){let{loc:e,name:t,nameLoc:n,value:r}=s;if("ref"===t&&(g=!0,N()),"is"===t&&(aS(o)||r&&r.content.startsWith("vue:")))continue;u.push(sK(sz(t,!0,n),sz(r?r.content:"",!0,r?r.loc:e)))}else{let{name:n,arg:i,exp:c,loc:g,modifiers:y}=s,b="bind"===n,_="on"===n;if("slot"===n){r||t.onError(s9(40,g));continue}if("once"===n||"memo"===n||"is"===n||b&&op(i,"is")&&aS(o)||_&&l)continue;if((b&&op(i,"key")||_&&f&&op(i,"vue:before-update"))&&(h=!0),b&&op(i,"ref")&&N(),!i&&(b||_)){S=!0,c?b?(N(),T(),d.push(c)):T({type:14,loc:g,callee:t.helper(sE),arguments:r?[c]:[c,"true"]}):t.onError(s9(b?34:35,g));continue}b&&y.some(e=>"prop"===e.content)&&(m|=32);let x=t.directiveTransforms[n];if(x){let{props:n,needRuntime:r}=x(s,e,t);l||n.forEach(w),_&&i&&!s7(i)?T(sW(n,a)):u.push(...n),r&&(p.push(s),L(r)&&ay.set(s,r))}else!q(n)&&(p.push(s),f&&(h=!0))}}if(d.length?(T(),s=d.length>1?sG(t.helper(sk),d,a):d[0]):u.length&&(s=sW(a_(u),a)),S?m|=16:(y&&!r&&(m|=2),b&&!r&&(m|=4),k.length&&(m|=8),_&&(m|=32)),!h&&(0===m||32===m)&&(g||C||p.length>0)&&(m|=512),!t.inSSR&&s)switch(s.type){case 15:let A=-1,E=-1,I=!1;for(let e=0;e<s.properties.length;e++){let t=s.properties[e].key;s7(t)?"class"===t.content?A=e:"style"===t.content&&(E=e):t.isHandlerKey||(I=!0)}let R=s.properties[A],O=s.properties[E];I?s=sG(t.helper(sw),[s]):(R&&!s7(R.value)&&(R.value=sG(t.helper(sT),[R.value])),O&&(b||4===O.value.type&&"["===O.value.content.trim()[0]||17===O.value.type)&&(O.value=sG(t.helper(sN),[O.value])));break;case 14:break;default:s=sG(t.helper(sw),[sG(t.helper(sA),[s])])}return{props:s,directives:p,patchFlag:m,dynamicPropNames:k,shouldUseBlock:h}}function a_(e){let t=new Map,n=[];for(let r=0;r<e.length;r++){let i=e[r];if(8===i.key.type||!i.key.isStatic){n.push(i);continue}let l=i.key.content,s=t.get(l);s?("style"===l||"class"===l||x(l))&&(17===s.value.type?s.value.elements.push(i.value):s.value=sq([s.value,i.value],s.loc)):(t.set(l,i),n.push(i))}return n}function aS(e){return"component"===e||"Component"===e}let ax=(e,t)=>{if(og(e)){let{children:n,loc:r}=e,{slotName:i,slotProps:l}=function(e,t){let n,r='"default"',i=[];for(let t=0;t<e.props.length;t++){let n=e.props[t];if(6===n.type)n.value&&("name"===n.name?r=JSON.stringify(n.value.content):(n.name=z(n.name),i.push(n)));else if("bind"===n.name&&op(n.arg,"name")){if(n.exp)r=n.exp;else if(n.arg&&4===n.arg.type){let e=z(n.arg.content);r=n.exp=sz(e,!1,n.arg.loc)}}else"bind"===n.name&&n.arg&&s7(n.arg)&&(n.arg.content=z(n.arg.content)),i.push(n)}if(i.length>0){let{props:r,directives:l}=ab(e,t,i,!1,!1);n=r,l.length&&t.onError(s9(36,l[0].loc))}return{slotName:r,slotProps:n}}(e,t),s=[t.prefixIdentifiers?"_ctx.$slots":"$slots",i,"{}","undefined","true"],o=2;l&&(s[2]=l,o=3),n.length&&(s[3]=sX([],n,!1,!1,r),o=4),t.scopeId&&!t.slotted&&(o=5),s.splice(o),e.codegenNode=sG(t.helper(sS),s,r)}},aC=(e,t,n,r)=>{let i;let{loc:l,modifiers:s,arg:o}=e;if(e.exp||s.length,4===o.type){if(o.isStatic){let e=o.content;e.startsWith("vue:")&&(e=`vnode-${e.slice(4)}`),i=sz(0!==t.tagType||e.startsWith("vnode")||!/[A-Z]/.test(e)?Q(z(e)):`on:${e}`,!0,o.loc)}else i=sJ([`${n.helperString(sO)}(`,o,")"])}else(i=o).children.unshift(`${n.helperString(sO)}(`),i.children.push(")");let a=e.exp;a&&!a.content.trim()&&(a=void 0);let c=n.cacheHandlers&&!a&&!n.inVOnce;if(a){let e=oo(a),t=!(e||oc(a)),n=a.content.includes(";");(t||c&&e)&&(a=sJ([`${t?"$event":"(...args)"} => ${n?"{":"("}`,a,n?"}":")"]))}let u={props:[sK(i,a||sz("() => {}",!1,l))]};return r&&(u=r(u)),c&&(u.props[0].value=n.cache(u.props[0].value)),u.props.forEach(e=>e.key.isHandlerKey=!0),u},ak=(e,t)=>{if(0===e.type||1===e.type||11===e.type||10===e.type)return()=>{let n;let r=e.children,i=!1;for(let e=0;e<r.length;e++){let t=r[e];if(of(t)){i=!0;for(let i=e+1;i<r.length;i++){let l=r[i];if(of(l))n||(n=r[e]=sJ([t],t.loc)),n.children.push(" + ",l),r.splice(i,1),i--;else{n=void 0;break}}}}if(i&&(1!==r.length||0!==e.type&&(1!==e.type||0!==e.tagType||e.props.find(e=>7===e.type&&!t.directiveTransforms[e.name]))))for(let e=0;e<r.length;e++){let n=r[e];if(of(n)||8===n.type){let i=[];(2!==n.type||" "!==n.content)&&i.push(n),t.ssr||0!==oY(n,t)||i.push("1"),r[e]={type:12,content:n,loc:n.loc,codegenNode:sG(t.helper(sf),i)}}}}},aT=new WeakSet,aN=(e,t)=>{if(1===e.type&&ou(e,"once",!0)&&!aT.has(e)&&!t.inVOnce&&!t.inSSR)return aT.add(e),t.inVOnce=!0,t.helper(sP),()=>{t.inVOnce=!1;let e=t.currentNode;e.codegenNode&&(e.codegenNode=t.cache(e.codegenNode,!0,!0))}},aw=(e,t,n)=>{let r;let{exp:i,arg:l}=e;if(!i)return n.onError(s9(41,e.loc)),aA();let s=i.loc.source.trim(),o=4===i.type?i.content:s,a=n.bindingMetadata[s];if("props"===a||"props-aliased"===a)return i.loc,aA();if(!o.trim()||!oo(i))return n.onError(s9(42,i.loc)),aA();let c=l||sz("modelValue",!0),u=l?s7(l)?`onUpdate:${z(l.content)}`:sJ(['"onUpdate:" + ',l]):"onUpdate:modelValue",d=n.isTS?"($event: any)":"$event";r=sJ([`${d} => ((`,i,") = $event)"]);let p=[sK(c,e.exp),sK(u,r)];if(e.modifiers.length&&1===t.tagType){let t=e.modifiers.map(e=>e.content).map(e=>(on(e)?e:JSON.stringify(e))+": true").join(", "),n=l?s7(l)?`${l.content}Modifiers`:sJ([l,' + "Modifiers"']):"modelModifiers";p.push(sK(n,sz(`{ ${t} }`,!1,e.loc,2)))}return aA(p)};function aA(e=[]){return{props:e}}let aE=new WeakSet,aI=(e,t)=>{if(1===e.type){let n=ou(e,"memo");if(!(!n||aE.has(e)))return aE.add(e),()=>{let r=e.codegenNode||t.currentNode.codegenNode;r&&13===r.type&&(1!==e.tagType&&sZ(r,t),e.codegenNode=sG(t.helper(sV),[n.exp,sX(void 0,r),"_cache",String(t.cached.length)]),t.cached.push(null))}}},aR=Symbol(""),aO=Symbol(""),aP=Symbol(""),aM=Symbol(""),aL=Symbol(""),a$=Symbol(""),aD=Symbol(""),aF=Symbol(""),aV=Symbol(""),aB=Symbol("");!function(e){Object.getOwnPropertySymbols(e).forEach(t=>{sU[t]=e[t]})}({[aR]:"vModelRadio",[aO]:"vModelCheckbox",[aP]:"vModelText",[aM]:"vModelSelect",[aL]:"vModelDynamic",[a$]:"withModifiers",[aD]:"withKeys",[aF]:"vShow",[aV]:"Transition",[aB]:"TransitionGroup"});let aU={parseMode:"html",isVoidTag:eh,isNativeTag:e=>ed(e)||ep(e)||ef(e),isPreTag:e=>"pre"===e,isIgnoreNewlineTag:e=>"pre"===e||"textarea"===e,decodeEntities:function(e,t=!1){return(f||(f=document.createElement("div")),t)?(f.innerHTML=`<div foo="${e.replace(/"/g,"&quot;")}">`,f.children[0].getAttribute("foo")):(f.innerHTML=e,f.textContent)},isBuiltInComponent:e=>"Transition"===e||"transition"===e?aV:"TransitionGroup"===e||"transition-group"===e?aB:void 0,getNamespace(e,t,n){let r=t?t.ns:n;if(t&&2===r){if("annotation-xml"===t.tag){if("svg"===e)return 1;t.props.some(e=>6===e.type&&"encoding"===e.name&&null!=e.value&&("text/html"===e.value.content||"application/xhtml+xml"===e.value.content))&&(r=0)}else/^m(?:[ions]|text)$/.test(t.tag)&&"mglyph"!==e&&"malignmark"!==e&&(r=0)}else t&&1===r&&("foreignObject"===t.tag||"desc"===t.tag||"title"===t.tag)&&(r=0);if(0===r){if("svg"===e)return 1;if("math"===e)return 2}return r}},aj=(e,t)=>sz(JSON.stringify(ec(e)),!1,t,3),aH=g("passive,once,capture"),aq=g("stop,prevent,self,ctrl,shift,alt,meta,exact,middle"),aW=g("left,right"),aK=g("onkeyup,onkeydown,onkeypress"),az=(e,t,n,r)=>{let i=[],l=[],s=[];for(let n=0;n<t.length;n++){let r=t[n].content;aH(r)?s.push(r):aW(r)?s7(e)?aK(e.content.toLowerCase())?i.push(r):l.push(r):(i.push(r),l.push(r)):aq(r)?l.push(r):i.push(r)}return{keyModifiers:i,nonKeyModifiers:l,eventOptionModifiers:s}},aJ=(e,t)=>s7(e)&&"onclick"===e.content.toLowerCase()?sz(t,!0):4!==e.type?sJ(["(",e,`) === "onClick" ? "${t}" : (`,e,")"]):e,aG=(e,t)=>{1===e.type&&0===e.tagType&&("script"===e.tag||"style"===e.tag)&&t.removeNode()},aX=[e=>{1===e.type&&e.props.forEach((t,n)=>{6===t.type&&"style"===t.name&&t.value&&(e.props[n]={type:7,name:"bind",arg:sz("style",!0,t.loc),exp:aj(t.value.content,t.loc),modifiers:[],loc:t.loc})})}],aQ={cloak:()=>({props:[]}),html:(e,t,n)=>{let{exp:r,loc:i}=e;return r||n.onError(s9(53,i)),t.children.length&&(n.onError(s9(54,i)),t.children.length=0),{props:[sK(sz("innerHTML",!0,i),r||sz("",!0))]}},text:(e,t,n)=>{let{exp:r,loc:i}=e;return r||n.onError(s9(55,i)),t.children.length&&(n.onError(s9(56,i)),t.children.length=0),{props:[sK(sz("textContent",!0),r?oY(r,n)>0?r:sG(n.helperString(sC),[r],i):sz("",!0))]}},model:(e,t,n)=>{let r=aw(e,t,n);if(!r.props.length||1===t.tagType)return r;e.arg&&n.onError(s9(58,e.arg.loc));let{tag:i}=t,l=n.isCustomElement(i);if("input"===i||"textarea"===i||"select"===i||l){let s=aP,o=!1;if("input"===i||l){let r=od(t,"type");if(r){if(7===r.type)s=aL;else if(r.value)switch(r.value.content){case"radio":s=aR;break;case"checkbox":s=aO;break;case"file":o=!0,n.onError(s9(59,e.loc))}}else t.props.some(e=>7===e.type&&"bind"===e.name&&(!e.arg||4!==e.arg.type||!e.arg.isStatic))&&(s=aL)}else"select"===i&&(s=aM);o||(r.needRuntime=n.helper(s))}else n.onError(s9(57,e.loc));return r.props=r.props.filter(e=>!(4===e.key.type&&"modelValue"===e.key.content)),r},on:(e,t,n)=>aC(e,t,n,t=>{let{modifiers:r}=e;if(!r.length)return t;let{key:i,value:l}=t.props[0],{keyModifiers:s,nonKeyModifiers:o,eventOptionModifiers:a}=az(i,r,n,e.loc);if(o.includes("right")&&(i=aJ(i,"onContextmenu")),o.includes("middle")&&(i=aJ(i,"onMouseup")),o.length&&(l=sG(n.helper(a$),[l,JSON.stringify(o)])),s.length&&(!s7(i)||aK(i.content.toLowerCase()))&&(l=sG(n.helper(aD),[l,JSON.stringify(s)])),a.length){let e=a.map(X).join("");i=s7(i)?sz(`${i.content}${e}`,!0):sJ(["(",i,`) + "${e}"`])}return{props:[sK(i,l)]}}),show:(e,t,n)=>{let{exp:r,loc:i}=e;return!r&&n.onError(s9(61,i)),{props:[],needRuntime:n.helper(aF)}}},aZ=Object.create(null);function aY(e,t){if(!M(e)){if(!e.nodeType)return _;e=e.innerHTML}let n=e+JSON.stringify(t,(e,t)=>"function"==typeof t?t.toString():t),r=aZ[n];if(r)return r;if("#"===e[0]){let t=document.querySelector(e);e=t?t.innerHTML:""}let i=k({hoistStatic:!0,onError:void 0,onWarn:_},t);i.isCustomElement||"undefined"==typeof customElements||(i.isCustomElement=e=>!!customElements.get(e));let{code:l}=function(e,t={}){return function(e,t={}){let n=t.onError||s8,r="module"===t.mode;!0===t.prefixIdentifiers?n(s9(47)):r&&n(s9(48)),t.cacheHandlers&&n(s9(49)),t.scopeId&&!r&&n(s9(50));let i=k({},t,{prefixIdentifiers:!1}),l=M(e)?function(e,t){if(oL.reset(),oN=null,ow=null,oA="",oE=-1,oI=-1,oM.length=0,oT=e,oC=k({},ox),t){let e;for(e in t)null!=t[e]&&(oC[e]=t[e])}oL.mode="html"===oC.parseMode?1:"sfc"===oC.parseMode?2:0,oL.inXML=1===oC.ns||2===oC.ns;let n=t&&t.delimiters;n&&(oL.delimiterOpen=s6(n[0]),oL.delimiterClose=s6(n[1]));let r=ok=function(e,t=""){return{type:0,source:t,children:e,helpers:new Set,components:[],directives:[],hoists:[],imports:[],cached:[],temps:0,codegenNode:void 0,loc:sj}}([],e);return oL.parse(oT),r.loc=oJ(0,e.length),r.children=oW(r.children),ok=null,r}(e,i):e,[s,o]=[[aN,ar,aI,au,ax,av,ah,ak],{on:aC,bind:ao,model:aw}];return!function(e,t){let n=function(e,{filename:t="",prefixIdentifiers:n=!1,hoistStatic:r=!1,hmr:i=!1,cacheHandlers:l=!1,nodeTransforms:s=[],directiveTransforms:o={},transformHoist:a=null,isBuiltInComponent:c=_,isCustomElement:u=_,expressionPlugins:d=[],scopeId:p=null,slotted:f=!0,ssr:h=!1,inSSR:m=!1,ssrCssVars:g="",bindingMetadata:b=y,inline:S=!1,isTS:x=!1,onError:C=s8,onWarn:k=s5,compatConfig:T}){let N=t.replace(/\?.*$/,"").match(/([^/\\]+)\.\w+$/),w={filename:t,selfName:N&&X(z(N[1])),prefixIdentifiers:n,hoistStatic:r,hmr:i,cacheHandlers:l,nodeTransforms:s,directiveTransforms:o,transformHoist:a,isBuiltInComponent:c,isCustomElement:u,expressionPlugins:d,scopeId:p,slotted:f,ssr:h,inSSR:m,ssrCssVars:g,bindingMetadata:b,inline:S,isTS:x,onError:C,onWarn:k,compatConfig:T,root:e,helpers:new Map,components:new Set,directives:new Set,hoists:[],imports:[],cached:[],constantCache:new WeakMap,temps:0,identifiers:Object.create(null),scopes:{vFor:0,vSlot:0,vPre:0,vOnce:0},parent:null,grandParent:null,currentNode:e,childIndex:0,inVOnce:!1,helper(e){let t=w.helpers.get(e)||0;return w.helpers.set(e,t+1),e},removeHelper(e){let t=w.helpers.get(e);if(t){let n=t-1;n?w.helpers.set(e,n):w.helpers.delete(e)}},helperString:e=>`_${sU[w.helper(e)]}`,replaceNode(e){w.parent.children[w.childIndex]=w.currentNode=e},removeNode(e){let t=w.parent.children,n=e?t.indexOf(e):w.currentNode?w.childIndex:-1;e&&e!==w.currentNode?w.childIndex>n&&(w.childIndex--,w.onNodeRemoved()):(w.currentNode=null,w.onNodeRemoved()),w.parent.children.splice(n,1)},onNodeRemoved:_,addIdentifiers(e){},removeIdentifiers(e){},hoist(e){M(e)&&(e=sz(e)),w.hoists.push(e);let t=sz(`_hoisted_${w.hoists.length}`,!1,e.loc,2);return t.hoisted=e,t},cache(e,t=!1,n=!1){let r=function(e,t,n=!1,r=!1){return{type:20,index:e,value:t,needPauseTracking:n,inVOnce:r,needArraySpread:!1,loc:sj}}(w.cached.length,e,t,n);return w.cached.push(r),r}};return w}(e,t);o3(e,n),t.hoistStatic&&function e(t,n,r,i=!1,l=!1){let{children:s}=t,o=[];for(let n=0;n<s.length;n++){let a=s[n];if(1===a.type&&0===a.tagType){let e=i?0:oY(a,r);if(e>0){if(e>=2){a.codegenNode.patchFlag=-1,o.push(a);continue}}else{let e=a.codegenNode;if(13===e.type){let t=e.patchFlag;if((void 0===t||512===t||1===t)&&o1(a,r)>=2){let t=o2(a);t&&(e.props=r.hoist(t))}e.dynamicProps&&(e.dynamicProps=r.hoist(e.dynamicProps))}}}else if(12===a.type&&(i?0:oY(a,r))>=2){o.push(a);continue}if(1===a.type){let n=1===a.tagType;n&&r.scopes.vSlot++,e(a,t,r,!1,l),n&&r.scopes.vSlot--}else if(11===a.type)e(a,t,r,1===a.children.length,!0);else if(9===a.type)for(let n=0;n<a.branches.length;n++)e(a.branches[n],t,r,1===a.branches[n].children.length,l)}let a=!1;if(o.length===s.length&&1===t.type){if(0===t.tagType&&t.codegenNode&&13===t.codegenNode.type&&A(t.codegenNode.children))t.codegenNode.children=c(sq(t.codegenNode.children)),a=!0;else if(1===t.tagType&&t.codegenNode&&13===t.codegenNode.type&&t.codegenNode.children&&!A(t.codegenNode.children)&&15===t.codegenNode.children.type){let e=u(t.codegenNode,"default");e&&(e.returns=c(sq(e.returns)),a=!0)}else if(3===t.tagType&&n&&1===n.type&&1===n.tagType&&n.codegenNode&&13===n.codegenNode.type&&n.codegenNode.children&&!A(n.codegenNode.children)&&15===n.codegenNode.children.type){let e=ou(t,"slot",!0),r=e&&e.arg&&u(n.codegenNode,e.arg);r&&(r.returns=c(sq(r.returns)),a=!0)}}if(!a)for(let e of o)e.codegenNode=r.cache(e.codegenNode);function c(e){let t=r.cache(e);return l&&r.hmr&&(t.needArraySpread=!0),t}function u(e,t){if(e.children&&!A(e.children)&&15===e.children.type){let n=e.children.properties.find(e=>e.key===t||e.key.content===t);return n&&n.value}}o.length&&r.transformHoist&&r.transformHoist(s,r,t)}(e,void 0,n,oZ(e,e.children[0])),t.ssr||function(e,t){let{helper:n}=t,{children:r}=e;if(1===r.length){let n=r[0];if(oZ(e,n)&&n.codegenNode){let r=n.codegenNode;13===r.type&&sZ(r,t),e.codegenNode=r}else e.codegenNode=n}else r.length>1&&(e.codegenNode=sH(t,n(sn),void 0,e.children,64,void 0,void 0,!0,void 0,!1))}(e,n),e.helpers=new Set([...n.helpers.keys()]),e.components=[...n.components],e.directives=[...n.directives],e.imports=n.imports,e.hoists=n.hoists,e.temps=n.temps,e.cached=n.cached,e.transformed=!0}(l,k({},i,{nodeTransforms:[...s,...t.nodeTransforms||[]],directiveTransforms:k({},o,t.directiveTransforms||{})})),function(e,t={}){let n=function(e,{mode:t="function",prefixIdentifiers:n="module"===t,sourceMap:r=!1,filename:i="template.vue.html",scopeId:l=null,optimizeImports:s=!1,runtimeGlobalName:o="Vue",runtimeModuleName:a="vue",ssrRuntimeModuleName:c="vue/server-renderer",ssr:u=!1,isTS:d=!1,inSSR:p=!1}){let f={mode:t,prefixIdentifiers:n,sourceMap:r,filename:i,scopeId:l,optimizeImports:s,runtimeGlobalName:o,runtimeModuleName:a,ssrRuntimeModuleName:c,ssr:u,isTS:d,inSSR:p,source:e.source,code:"",column:1,line:1,offset:0,indentLevel:0,pure:!1,map:void 0,helper:e=>`_${sU[e]}`,push(e,t=-2,n){f.code+=e},indent(){h(++f.indentLevel)},deindent(e=!1){e?--f.indentLevel:h(--f.indentLevel)},newline(){h(f.indentLevel)}};function h(e){f.push("\n"+"  ".repeat(e),0)}return f}(e,t);t.onContextCreated&&t.onContextCreated(n);let{mode:r,push:i,prefixIdentifiers:l,indent:s,deindent:o,newline:a,scopeId:c,ssr:u}=n,d=Array.from(e.helpers),p=d.length>0,f=!l&&"module"!==r;(function(e,t){let{ssr:n,prefixIdentifiers:r,push:i,newline:l,runtimeModuleName:s,runtimeGlobalName:o,ssrRuntimeModuleName:a}=t,c=Array.from(e.helpers);if(c.length>0&&(i(`const _Vue = ${o}
`,-1),e.hoists.length)){let e=[su,sd,sp,sf,sh].filter(e=>c.includes(e)).map(o8).join(", ");i(`const { ${e} } = _Vue
`,-1)}(function(e,t){if(!e.length)return;t.pure=!0;let{push:n,newline:r}=t;r();for(let i=0;i<e.length;i++){let l=e[i];l&&(n(`const _hoisted_${i+1} = `),ae(l,t),r())}t.pure=!1})(e.hoists,t),l(),i("return ")})(e,n);let h=(u?["_ctx","_push","_parent","_attrs"]:["_ctx","_cache"]).join(", ");if(i(`function ${u?"ssrRender":"render"}(${h}) {`),s(),f&&(i("with (_ctx) {"),s(),p&&(i(`const { ${d.map(o8).join(", ")} } = _Vue
`,-1),a())),e.components.length&&(o5(e.components,"component",n),(e.directives.length||e.temps>0)&&a()),e.directives.length&&(o5(e.directives,"directive",n),e.temps>0&&a()),e.temps>0){i("let ");for(let t=0;t<e.temps;t++)i(`${t>0?", ":""}_temp${t}`)}return(e.components.length||e.directives.length||e.temps)&&(i(`
`,0),a()),u||i("return "),e.codegenNode?ae(e.codegenNode,n):i("null"),f&&(o(),i("}")),o(),i("}"),{ast:e,code:n.code,preamble:"",map:n.map?n.map.toJSON():void 0}}(l,i)}(e,k({},aU,t,{nodeTransforms:[aG,...aX,...t.nodeTransforms||[]],directiveTransforms:k({},aQ,t.directiveTransforms||{}),transformHoist:null}))}(e,i),s=Function(l)();return s._rc=!0,aZ[n]=s}return iU(aY),e.BaseTransition=n_,e.BaseTransitionPropsValidators=ny,e.Comment=io,e.DeprecationTypes=null,e.EffectScope=ex,e.ErrorCodes={SETUP_FUNCTION:0,0:"SETUP_FUNCTION",RENDER_FUNCTION:1,1:"RENDER_FUNCTION",NATIVE_EVENT_HANDLER:5,5:"NATIVE_EVENT_HANDLER",COMPONENT_EVENT_HANDLER:6,6:"COMPONENT_EVENT_HANDLER",VNODE_HOOK:7,7:"VNODE_HOOK",DIRECTIVE_HOOK:8,8:"DIRECTIVE_HOOK",TRANSITION_HOOK:9,9:"TRANSITION_HOOK",APP_ERROR_HANDLER:10,10:"APP_ERROR_HANDLER",APP_WARN_HANDLER:11,11:"APP_WARN_HANDLER",FUNCTION_REF:12,12:"FUNCTION_REF",ASYNC_COMPONENT_LOADER:13,13:"ASYNC_COMPONENT_LOADER",SCHEDULER:14,14:"SCHEDULER",COMPONENT_UPDATE:15,15:"COMPONENT_UPDATE",APP_UNMOUNT_CLEANUP:16,16:"APP_UNMOUNT_CLEANUP"},e.ErrorTypeStrings=null,e.Fragment=il,e.KeepAlive={name:"KeepAlive",__isKeepAlive:!0,props:{include:[String,RegExp,Array],exclude:[String,RegExp,Array],max:[String,Number]},setup(e,{slots:t}){let n=iL(),r=n.ctx,i=new Map,l=new Set,s=null,o=n.suspense,{renderer:{p:a,m:c,um:u,o:{createElement:d}}}=r,p=d("div");function f(e){nG(e),u(e,n,o,!0)}function h(e){i.forEach((t,n)=>{let r=iK(t.type);r&&!e(r)&&m(n)})}function m(e){let t=i.get(e);!t||s&&ib(t,s)?s&&nG(s):f(t),i.delete(e),l.delete(e)}r.activate=(e,t,n,r,i)=>{let l=e.component;c(e,t,n,0,o),a(l.vnode,e,t,n,l,o,r,e.slotScopeIds,i),rB(()=>{l.isDeactivated=!1,l.a&&Y(l.a);let t=e.props&&e.props.onVnodeMounted;t&&iR(t,l.parent,e)},o)},r.deactivate=e=>{let t=e.component;rz(t.m),rz(t.a),c(e,p,null,1,o),rB(()=>{t.da&&Y(t.da);let n=e.props&&e.props.onVnodeUnmounted;n&&iR(n,t.parent,e),t.isDeactivated=!0},o)},rX(()=>[e.include,e.exclude],([e,t])=>{e&&h(t=>nW(e,t)),t&&h(e=>!nW(t,e))},{flush:"post",deep:!0});let g=null,y=()=>{null!=g&&(r5(n.subTree.type)?rB(()=>{i.set(g,nX(n.subTree))},n.subTree.suspense):i.set(g,nX(n.subTree)))};return n0(y),n2(y),n3(()=>{i.forEach(e=>{let{subTree:t,suspense:r}=n,i=nX(t);if(e.type===i.type&&e.key===i.key){nG(i);let e=i.component.da;e&&rB(e,r);return}f(e)})}),()=>{if(g=null,!t.default)return s=null;let n=t.default(),r=n[0];if(n.length>1)return s=null,n;if(!iv(r)||!(4&r.shapeFlag)&&!(128&r.shapeFlag))return s=null,r;let o=nX(r);if(o.type===io)return s=null,o;let a=o.type,c=iK(nj(o)?o.type.__asyncResolved||{}:a),{include:u,exclude:d,max:p}=e;if(u&&(!c||!nW(u,c))||d&&c&&nW(d,c))return o.shapeFlag&=-257,s=o,r;let f=null==o.key?a:o.key,h=i.get(f);return o.el&&(o=iT(o),128&r.shapeFlag&&(r.ssContent=o)),g=f,h?(o.el=h.el,o.component=h.component,o.transition&&nT(o,o.transition),o.shapeFlag|=512,l.delete(f),l.add(f)):(l.add(f),p&&l.size>parseInt(p,10)&&m(l.values().next().value)),o.shapeFlag|=256,s=o,r5(r.type)?r:o}}},e.ReactiveEffect=ek,e.Static=ia,e.Suspense={name:"Suspense",__isSuspense:!0,process(e,t,n,r,i,l,s,o,a,c){if(null==e)(function(e,t,n,r,i,l,s,o,a){let{p:c,o:{createElement:u}}=a,d=u("div"),p=e.suspense=ie(e,i,r,t,d,n,l,s,o,a);c(null,p.pendingBranch=e.ssContent,d,null,r,p,l,s),p.deps>0?(r7(e,"onPending"),r7(e,"onFallback"),c(null,e.ssFallback,t,n,r,null,l,s),ii(p,e.ssFallback)):p.resolve(!1,!0)})(t,n,r,i,l,s,o,a,c);else{if(l&&l.deps>0&&!e.suspense.isInFallback){t.suspense=e.suspense,t.suspense.vnode=t,t.el=e.el;return}(function(e,t,n,r,i,l,s,o,{p:a,um:c,o:{createElement:u}}){let d=t.suspense=e.suspense;d.vnode=t,t.el=e.el;let p=t.ssContent,f=t.ssFallback,{activeBranch:h,pendingBranch:m,isInFallback:g,isHydrating:y}=d;if(m)d.pendingBranch=p,ib(p,m)?(a(m,p,d.hiddenContainer,null,i,d,l,s,o),d.deps<=0?d.resolve():g&&!y&&(a(h,f,n,r,i,null,l,s,o),ii(d,f))):(d.pendingId=r9++,y?(d.isHydrating=!1,d.activeBranch=m):c(m,i,d),d.deps=0,d.effects.length=0,d.hiddenContainer=u("div"),g?(a(null,p,d.hiddenContainer,null,i,d,l,s,o),d.deps<=0?d.resolve():(a(h,f,n,r,i,null,l,s,o),ii(d,f))):h&&ib(p,h)?(a(h,p,n,r,i,d,l,s,o),d.resolve(!0)):(a(null,p,d.hiddenContainer,null,i,d,l,s,o),d.deps<=0&&d.resolve()));else if(h&&ib(p,h))a(h,p,n,r,i,d,l,s,o),ii(d,p);else if(r7(t,"onPending"),d.pendingBranch=p,512&p.shapeFlag?d.pendingId=p.component.suspenseId:d.pendingId=r9++,a(null,p,d.hiddenContainer,null,i,d,l,s,o),d.deps<=0)d.resolve();else{let{timeout:e,pendingId:t}=d;e>0?setTimeout(()=>{d.pendingId===t&&d.fallback(f)},e):0===e&&d.fallback(f)}})(e,t,n,r,i,s,o,a,c)}},hydrate:function(e,t,n,r,i,l,s,o,a){let c=t.suspense=ie(t,r,n,e.parentNode,document.createElement("div"),null,i,l,s,o,!0),u=a(e,c.pendingBranch=t.ssContent,n,c,l,s);return 0===c.deps&&c.resolve(!1,!0),u},normalize:function(e){let{shapeFlag:t,children:n}=e,r=32&t;e.ssContent=it(r?n.default:n),e.ssFallback=r?it(n.fallback):iC(io)}},e.Teleport=nc,e.Text=is,e.TrackOpTypes={GET:"get",HAS:"has",ITERATE:"iterate"},e.Transition=i8,e.TransitionGroup=lF,e.TriggerOpTypes={SET:"set",ADD:"add",DELETE:"delete",CLEAR:"clear"},e.VueElement=lO,e.assertNumber=function(e,t){},e.callWithAsyncErrorHandling=tW,e.callWithErrorHandling=tq,e.camelize=z,e.capitalize=X,e.cloneVNode=iT,e.compatUtils=null,e.compile=aY,e.computed=iz,e.createApp=l9,e.createBlock=iy,e.createCommentVNode=function(e="",t=!1){return t?(id(),iy(io,null,e)):iC(io,null,e)},e.createElementBlock=function(e,t,n,r,i,l){return ig(ix(e,t,n,r,i,l,!0))},e.createElementVNode=ix,e.createHydrationRenderer=rU,e.createPropsRestProxy=function(e,t){let n={};for(let r in e)t.includes(r)||Object.defineProperty(n,r,{enumerable:!0,get:()=>e[r]});return n},e.createRenderer=function(e){return rj(e)},e.createSSRApp=l7,e.createSlots=function(e,t){for(let n=0;n<t.length;n++){let r=t[n];if(A(r))for(let t=0;t<r.length;t++)e[r[t].name]=r[t].fn;else r&&(e[r.name]=r.key?(...e)=>{let t=r.fn(...e);return t&&(t.key=r.key),t}:r.fn)}return e},e.createStaticVNode=function(e,t){let n=iC(ia,null,e);return n.staticCount=t,n},e.createTextVNode=iN,e.createVNode=iC,e.customRef=tL,e.defineAsyncComponent=function(e){let t;P(e)&&(e={loader:e});let{loader:n,loadingComponent:r,errorComponent:i,delay:l=200,hydrate:s,timeout:o,suspensible:a=!0,onError:c}=e,u=null,d=0,p=()=>(d++,u=null,f()),f=()=>{let e;return u||(e=u=n().catch(e=>{if(e=e instanceof Error?e:Error(String(e)),c)return new Promise((t,n)=>{c(e,()=>t(p()),()=>n(e),d+1)});throw e}).then(n=>e!==u&&u?u:(n&&(n.__esModule||"Module"===n[Symbol.toStringTag])&&(n=n.default),t=n,n)))};return nw({name:"AsyncComponentWrapper",__asyncLoader:f,__asyncHydrate(e,n,r){let i=s?()=>{let t=s(r,t=>(function(e,t){if(nL(e)&&"["===e.data){let n=1,r=e.nextSibling;for(;r;){if(1===r.nodeType){if(!1===t(r))break}else if(nL(r)){if("]"===r.data){if(0==--n)break}else"["===r.data&&n++}r=r.nextSibling}}else t(e)})(e,t));t&&(n.bum||(n.bum=[])).push(t)}:r;t?i():f().then(()=>!n.isUnmounted&&i())},get __asyncResolved(){return t},setup(){let e=iM;if(nA(e),t)return()=>nH(t,e);let n=t=>{u=null,tK(t,e,13,!i)};if(a&&e.suspense)return f().then(t=>()=>nH(t,e)).catch(e=>(n(e),()=>i?iC(i,{error:e}):null));let s=tw(!1),c=tw(),d=tw(!!l);return l&&setTimeout(()=>{d.value=!1},l),null!=o&&setTimeout(()=>{if(!s.value&&!c.value){let e=Error(`Async component timed out after ${o}ms.`);n(e),c.value=e}},o),f().then(()=>{s.value=!0,e.parent&&nq(e.parent.vnode)&&e.parent.update()}).catch(e=>{n(e),c.value=e}),()=>s.value&&t?nH(t,e):c.value&&i?iC(i,{error:c.value}):r&&!d.value?iC(r):void 0}})},e.defineComponent=nw,e.defineCustomElement=lI,e.defineEmits=function(){return null},e.defineExpose=function(e){},e.defineModel=function(){},e.defineOptions=function(e){},e.defineProps=function(){return null},e.defineSSRCustomElement=(e,t)=>lI(e,t,l7),e.defineSlots=function(){return null},e.devtools=void 0,e.effect=function(e,t){e.effect instanceof ek&&(e=e.effect.fn);let n=new ek(e);t&&k(n,t);try{n.run()}catch(e){throw n.stop(),e}let r=n.run.bind(n);return r.effect=n,r},e.effectScope=function(e){return new ex(e)},e.getCurrentInstance=iL,e.getCurrentScope=function(){return i},e.getCurrentWatcher=function(){return h},e.getTransitionRawChildren=nN,e.guardReactiveProps=ik,e.h=iJ,e.handleError=tK,e.hasInjectionContext=function(){return!!(iM||t5||rx)},e.hydrate=(...e)=>{l8().hydrate(...e)},e.hydrateOnIdle=(e=1e4)=>t=>{let n=nB(t,{timeout:e});return()=>nU(n)},e.hydrateOnInteraction=(e=[])=>(t,n)=>{M(e)&&(e=[e]);let r=!1,i=e=>{r||(r=!0,l(),t(),e.target.dispatchEvent(new e.constructor(e.type,e)))},l=()=>{n(t=>{for(let n of e)t.removeEventListener(n,i)})};return n(t=>{for(let n of e)t.addEventListener(n,i,{once:!0})}),l},e.hydrateOnMediaQuery=e=>t=>{if(e){let n=matchMedia(e);if(!n.matches)return n.addEventListener("change",t,{once:!0}),()=>n.removeEventListener("change",t);t()}},e.hydrateOnVisible=e=>(t,n)=>{let r=new IntersectionObserver(e=>{for(let n of e)if(n.isIntersecting){r.disconnect(),t();break}},e);return n(e=>{if(e instanceof Element){if(function(e){let{top:t,left:n,bottom:r,right:i}=e.getBoundingClientRect(),{innerHeight:l,innerWidth:s}=window;return(t>0&&t<l||r>0&&r<l)&&(n>0&&n<s||i>0&&i<s)}(e))return t(),r.disconnect(),!1;r.observe(e)}}),()=>r.disconnect()},e.initCustomFormatter=function(){},e.initDirectivesForSSR=_,e.inject=rk,e.isMemoSame=iG,e.isProxy=tS,e.isReactive=tv,e.isReadonly=tb,e.isRef=tN,e.isRuntimeOnly=()=>!u,e.isShallow=t_,e.isVNode=iv,e.markRaw=tC,e.mergeDefaults=function(e,t){let n=rc(e);for(let e in t){if(e.startsWith("__skip"))continue;let r=n[e];r?A(r)||P(r)?r=n[e]={type:r,default:t[e]}:r.default=t[e]:null===r&&(r=n[e]={default:t[e]}),r&&t[`__skip_${e}`]&&(r.skipFactory=!0)}return n},e.mergeModels=function(e,t){return e&&t?A(e)&&A(t)?e.concat(t):k({},rc(e),rc(t)):e||t},e.mergeProps=iI,e.nextTick=t0,e.normalizeClass=eu,e.normalizeProps=function(e){if(!e)return null;let{class:t,style:n}=e;return t&&!M(t)&&(e.class=eu(t)),n&&(e.style=el(n)),e},e.normalizeStyle=el,e.onActivated=nK,e.onBeforeMount=nY,e.onBeforeUnmount=n3,e.onBeforeUpdate=n1,e.onDeactivated=nz,e.onErrorCaptured=n9,e.onMounted=n0,e.onRenderTracked=n5,e.onRenderTriggered=n8,e.onScopeDispose=function(e,t=!1){i&&i.cleanups.push(e)},e.onServerPrefetch=n4,e.onUnmounted=n6,e.onUpdated=n2,e.onWatcherCleanup=tj,e.openBlock=id,e.popScopeId=function(){t9=null},e.provide=rC,e.proxyRefs=tP,e.pushScopeId=function(e){t9=e},e.queuePostFlushCb=t3,e.reactive=th,e.readonly=tg,e.ref=tw,e.registerRuntimeCompiler=iU,e.render=l5,e.renderList=function(e,t,n,r){let i;let l=n&&n[r],s=A(e);if(s||M(e)){let n=s&&tv(e),r=!1;n&&(r=!t_(e),e=eJ(e)),i=Array(e.length);for(let n=0,s=e.length;n<s;n++)i[n]=t(r?tk(e[n]):e[n],n,void 0,l&&l[n])}else if("number"==typeof e){i=Array(e);for(let n=0;n<e;n++)i[n]=t(n+1,n,void 0,l&&l[n])}else if($(e)){if(e[Symbol.iterator])i=Array.from(e,(e,n)=>t(e,n,void 0,l&&l[n]));else{let n=Object.keys(e);i=Array(n.length);for(let r=0,s=n.length;r<s;r++){let s=n[r];i[r]=t(e[s],s,r,l&&l[r])}}}else i=[];return n&&(n[r]=i),i},e.renderSlot=function(e,t,n={},r,i){if(t5.ce||t5.parent&&nj(t5.parent)&&t5.parent.ce)return"default"!==t&&(n.name=t),id(),iy(il,null,[iC("slot",n,r&&r())],64);let l=e[t];l&&l._c&&(l._d=!1),id();let s=l&&function e(t){return t.some(t=>!iv(t)||!!(t.type!==io&&(t.type!==il||e(t.children))))?t:null}(l(n)),o=n.key||s&&s.key,a=iy(il,{key:(o&&!L(o)?o:`_${t}`)+(!s&&r?"_fb":"")},s||(r?r():[]),s&&1===e._?64:-2);return!i&&a.scopeId&&(a.slotScopeIds=[a.scopeId+"-s"]),l&&l._c&&(l._d=!0),a},e.resolveComponent=function(e,t){return rt(n7,e,!0,t)||e},e.resolveDirective=function(e){return rt("directives",e)},e.resolveDynamicComponent=function(e){return M(e)?rt(n7,e,!1)||e:e||re},e.resolveFilter=null,e.resolveTransitionHooks=nx,e.setBlockTracking=im,e.setDevtoolsHook=_,e.setTransitionHooks=nT,e.shallowReactive=tm,e.shallowReadonly=function(e){return ty(e,!0,tt,tc,tf)},e.shallowRef=tA,e.ssrContextKey=rJ,e.ssrUtils=null,e.stop=function(e){e.effect.stop()},e.toDisplayString=eb,e.toHandlerKey=Q,e.toHandlers=function(e,t){let n={};for(let r in e)n[t&&/[A-Z]/.test(r)?`on:${r}`:Q(r)]=e[r];return n},e.toRaw=tx,e.toRef=function(e,t,n){return tN(e)?e:P(e)?new tD(e):$(e)&&arguments.length>1?tF(e,t,n):tw(e)},e.toRefs=function(e){let t=A(e)?Array(e.length):{};for(let n in e)t[n]=tF(e,n);return t},e.toValue=function(e){return P(e)?e():tR(e)},e.transformVNodeArgs=function(e){},e.triggerRef=function(e){e.dep&&e.dep.trigger()},e.unref=tR,e.useAttrs=function(){return ra().attrs},e.useCssModule=function(e="$style"){return y},e.useCssVars=function(e){let t=iL();if(!t)return;let n=t.ut=(n=e(t.proxy))=>{Array.from(document.querySelectorAll(`[data-v-owner="${t.uid}"]`)).forEach(e=>lf(e,n))},r=()=>{let r=e(t.proxy);t.ce?lf(t.ce,r):function e(t,n){if(128&t.shapeFlag){let r=t.suspense;t=r.activeBranch,r.pendingBranch&&!r.isHydrating&&r.effects.push(()=>{e(r.activeBranch,n)})}for(;t.component;)t=t.component.subTree;if(1&t.shapeFlag&&t.el)lf(t.el,n);else if(t.type===il)t.children.forEach(t=>e(t,n));else if(t.type===ia){let{el:e,anchor:r}=t;for(;e&&(lf(e,n),e!==r);)e=e.nextSibling}}(t.subTree,r),n(r)};n1(()=>{t3(r)}),n0(()=>{rX(r,_,{flush:"post"});let e=new MutationObserver(r);e.observe(t.subTree.el.parentNode,{childList:!0}),n6(()=>e.disconnect())})},e.useHost=lP,e.useId=function(){let e=iL();return e?(e.appContext.config.idPrefix||"v")+"-"+e.ids[0]+e.ids[1]++:""},e.useModel=function(e,t,n=y){let r=iL(),i=z(t),l=G(t),s=rY(e,i),o=tL((s,o)=>{let a,c;let u=y;return rG(()=>{let t=e[i];Z(a,t)&&(a=t,o())}),{get:()=>(s(),n.get?n.get(a):a),set(e){let s=n.set?n.set(e):e;if(!Z(s,a)&&!(u!==y&&Z(e,u)))return;let d=r.vnode.props;d&&(t in d||i in d||l in d)&&(`onUpdate:${t}`in d||`onUpdate:${i}`in d||`onUpdate:${l}`in d)||(a=e,o()),r.emit(`update:${t}`,s),Z(e,s)&&Z(e,u)&&!Z(s,c)&&o(),u=e,c=s}}});return o[Symbol.iterator]=()=>{let e=0;return{next:()=>e<2?{value:e++?s||y:o,done:!1}:{done:!0}}},o},e.useSSRContext=()=>{},e.useShadowRoot=function(){let e=lP();return e&&e.shadowRoot},e.useSlots=function(){return ra().slots},e.useTemplateRef=function(e){let t=iL(),n=tA(null);return t&&Object.defineProperty(t.refs===y?t.refs={}:t.refs,e,{enumerable:!0,get:()=>n.value,set:e=>n.value=e}),n},e.useTransitionState=nm,e.vModelCheckbox=lz,e.vModelDynamic={created(e,t,n){l0(e,t,n,null,"created")},mounted(e,t,n){l0(e,t,n,null,"mounted")},beforeUpdate(e,t,n,r){l0(e,t,n,r,"beforeUpdate")},updated(e,t,n,r){l0(e,t,n,r,"updated")}},e.vModelRadio=lG,e.vModelSelect=lX,e.vModelText=lK,e.vShow={beforeMount(e,{value:t},{transition:n}){e[lc]="none"===e.style.display?"":e.style.display,n&&t?n.beforeEnter(e):ld(e,t)},mounted(e,{value:t},{transition:n}){n&&t&&n.enter(e)},updated(e,{value:t,oldValue:n},{transition:r}){!t!=!n&&(r?t?(r.beforeEnter(e),ld(e,!0),r.enter(e)):r.leave(e,()=>{ld(e,!1)}):ld(e,t))},beforeUnmount(e,{value:t}){ld(e,t)}},e.version=iX,e.warn=_,e.watch=function(e,t,n){return rX(e,t,n)},e.watchEffect=function(e,t){return rX(e,null,t)},e.watchPostEffect=function(e,t){return rX(e,null,{flush:"post"})},e.watchSyncEffect=rG,e.withAsyncContext=function(e){let t=iL(),n=e();return iD(),D(n)&&(n=n.catch(e=>{throw i$(t),e})),[n,()=>i$(t)]},e.withCtx=ne,e.withDefaults=function(e,t){return null},e.withDirectives=function(e,t){if(null===t5)return e;let n=iW(t5),r=e.dirs||(e.dirs=[]);for(let e=0;e<t.length;e++){let[i,l,s,o=y]=t[e];i&&(P(i)&&(i={mounted:i,updated:i}),i.deep&&tH(l),r.push({dir:i,instance:n,value:l,oldValue:void 0,arg:s,modifiers:o}))}return e},e.withKeys=(e,t)=>{let n=e._withKeys||(e._withKeys={}),r=t.join(".");return n[r]||(n[r]=n=>{if(!("key"in n))return;let r=G(n.key);if(t.some(e=>e===r||l3[e]===r))return e(n)})},e.withMemo=function(e,t,n,r){let i=n[r];if(i&&iG(i,e))return i;let l=t();return l.memo=e.slice(),l.cacheIndex=r,n[r]=l},e.withModifiers=(e,t)=>{let n=e._withMods||(e._withMods={}),r=t.join(".");return n[r]||(n[r]=(n,...r)=>{for(let e=0;e<t.length;e++){let r=l2[t[e]];if(r&&r(n,t))return}return e(n,...r)})},e.withScopeId=e=>ne,e}({});
#@FILE_END
#@FILE_TXT:outils/calibrer.py
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
#@FILE_END
#@FILE_TXT:outils/calibration_check.py
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
#@FILE_END
