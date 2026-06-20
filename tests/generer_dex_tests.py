#!/usr/bin/env python3
"""Genere un jeu de DEX de test (.docx) couvrant les scenarios metier de la
reprise CAST'IN, ecrits dans le sous-dossier "dex_tests/" a cote de ce script.

Chaque test (sauf le minimal) part d'un DEX COMPLET (toutes les sections, contenu
suffisant) et applique UNE variation isolee, afin que le resultat attendu soit
lisible (la majorite des champs en confiance elevee, la variation bien visible).
Parts statiques (styles/content-types/rels) reprises d'un DEX .docx valide existant.

Source des parts statiques (au choix, dans l'ordre de priorite) :
  1. 1er argument de ligne de commande : python3 generer_dex_tests.py <ref.docx>
  2. variable d'environnement DEX_REFERENCE
  3. repli : un .docx deja present dans dex_tests/ (utile pour regenerer le jeu)
N'importe quel DEX au gabarit attendu convient (les parts statiques sont communes).
"""
import os, sys, glob, zipfile, copy

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "dex_tests")

SRC = (sys.argv[1] if len(sys.argv) > 1 else None) or os.environ.get("DEX_REFERENCE")
if not SRC:
    _cand = sorted(glob.glob(os.path.join(OUT, "*.docx")))
    SRC = _cand[0] if _cand else None
if not SRC or not os.path.exists(SRC):
    sys.exit("Fournir un DEX .docx de reference (argument ou $DEX_REFERENCE) "
             "pour les parts statiques (styles/content-types/rels).")

NS = ('xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" '
      'xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"')
_z = zipfile.ZipFile(SRC)
STATIC = {n: _z.read(n) for n in _z.namelist() if n != "word/document.xml"}


def esc(t): return t.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
def p_txt(t): return f'<w:p><w:r><w:t xml:space="preserve">{esc(t)}</w:t></w:r></w:p>'
def p_head(t): return f'<w:p><w:pPr><w:pStyle w:val="Titre1"/></w:pPr><w:r><w:t xml:space="preserve">{esc(t)}</w:t></w:r></w:p>'
def p_encart(t, it=True, blue=True):
    rpr = "<w:rPr>" + ("<w:i/>" if it else "") + ('<w:color w:val="0070C0"/>' if blue else "") + "</w:rPr>"
    return f'<w:p><w:r>{rpr}<w:t xml:space="preserve">{esc(t)}</w:t></w:r></w:p>'
def p_lien(t): return (f'<w:p><w:hyperlink r:id="rId1"><w:r>'
                       f'<w:t xml:space="preserve">{esc(t)}</w:t></w:r></w:hyperlink></w:p>')
def p_tbl(cell): return (f'<w:tbl><w:tr><w:tc><w:p><w:r>'
                         f'<w:t xml:space="preserve">{esc(cell)}</w:t></w:r></w:p></w:tc></w:tr></w:tbl>')


def document(xml_paras):
    return ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
            f'<w:document {NS}><w:body>' + "".join(xml_paras) + "</w:body></w:document>")


def build(name, xml_paras):
    os.makedirs(OUT, exist_ok=True)
    path = os.path.join(OUT, name)
    with zipfile.ZipFile(path, "w", zipfile.ZIP_DEFLATED) as zf:
        for n, b in STATIC.items():
            zf.writestr(n, b)
        zf.writestr("word/document.xml", document(xml_paras))
    return path


# Page de garde
GARDE = [("garde", None, ["Auteur : Alice Martin", "Responsable : Bob Lefevre"])]

# Blocs complets : (id, titre, [contenus]). id sert a manipuler ; titre None = paragraphes libres.
BLOCS = [
    ("desc_solution", "2.1 Description de la solution",
     ["La solution gere les commandes clients en temps reel via une API REST."]),
    ("archi", "2.2 Architecture fonctionnelle & applicative",
     ["@LIEN:DAP1001", "Schema applicatif : ADU2002 (microservices conteneurises)."]),
    ("donnees", "2.3 Donnees",
     ["Base Oracle, schema CMD_PROD, retention 36 mois."]),
    ("principes", "Principes et decisions",
     ["Decision : adoption du pattern CQRS pour la lecture/ecriture."]),
    ("technique", "Architecture technique",
     ["Cluster Kubernetes 3 noeuds, ingress NGINX, stockage NFS."]),
    ("plage", "Plages de fonctionnement / maintenance",
     ["Service 24/7, fenetre de maintenance le dimanche 2h-4h."]),
    ("supervision", "Supervision",
     ["Supervisee par Centreon ; sondes HTTP sur les services exposes."]),
    ("metrologie", "Metrologie",
     ["Metriques Prometheus, tableaux Grafana, retention 15 jours."]),
    ("log", "Logs et diagnostic",
     ["Logs centralises ELK, niveau INFO en production, rotation quotidienne."]),
    ("sauvegardes", "Sauvegardes",
     ["Sauvegarde Oracle RMAN quotidienne, retention 30 jours, copie hors-site."]),
    ("servitudes", "Servitudes et ordonnancements",
     ["Ordonnancement Control-M, chaine CMD_NIGHTLY a 1h."]),
    ("comptes", "Comptes de service",
     ["Compte svc_cmd_app (LDAP), compte svc_cmd_batch pour l'ordonnanceur."]),
    ("certificats", "Certificats",
     ["Certificat TLS *.cmd.intra, echeance 2027-03, renouvellement automatise."]),
    ("liste_blanche", "Liste blanche",
     ["Whitelist IP : 10.20.0.0/16 et 10.21.4.10 pour l'admin."]),
    ("flux", "Flux et interdependances",
     ["Flux entrant depuis le portail web, flux sortant vers le SI facturation."]),
    ("support", "Matrice des responsabilites (RACI)",
     ["RACI : exploitation responsable, etudes consultee, metier informee."]),
    ("changement", "Changements et MEP",
     ["Controle des operations : MEP mensuelle validee en CAB."]),
    ("matiere", "Referentiel (depot de code)",
     ["Repository Git interne, depot de code gitlab/cmd, CI GitLab."]),
    ("restauration", "Procedure de restauration",
     ["Restauration : restore RMAN du dernier backup, controle d'integrite."]),
    ("reconstruction", "Procedure de reconstruction",
     ["Reconstruction : redeploiement Helm depuis les manifestes versionnes."]),
    ("resync", "Procedure de resynchronisation",
     ["Resynchronisation : rejeu des evenements depuis le bus Kafka."]),
    ("infos", "Assets mainframe",
     ["Assets mainframe : aucun (solution full cloud)."]),
]


def rendre(blocs):
    """Transforme une liste de blocs en paragraphes XML."""
    out = []
    for _id, titre, contenus in blocs:
        if titre is not None:
            out.append(p_head(titre))
        for c in contenus:
            if c.startswith("@LIEN:"):
                out.append(p_lien(c[len("@LIEN:"):]))
            elif c.startswith("@ENCART:"):
                out.append(p_encart(c[len("@ENCART:"):]))
            elif c.startswith("@ENCART_I:"):           # italique seul (doit etre conserve)
                out.append(p_encart(c[len("@ENCART_I:"):], it=True, blue=False))
            elif c.startswith("@ENCART_B:"):           # bleu seul (doit etre conserve)
                out.append(p_encart(c[len("@ENCART_B:"):], it=False, blue=True))
            elif c.startswith("@TBL:"):                # contenu dans un tableau Word
                out.append(p_tbl(c[len("@TBL:"):]))
            else:
                out.append(p_txt(c))
    return out


def base():
    return copy.deepcopy(GARDE + BLOCS)


def sans(blocs, *ids):
    return [b for b in blocs if b[0] not in ids]


def trouver(blocs, _id):
    for b in blocs:
        if b[0] == _id:
            return b
    return None


GENERES = []
def g(name, blocs, scenario):
    build(name, rendre(blocs))
    GENERES.append((name, scenario))


# 1. Nominal complet + 1 encart d'aide (R2) dans 'Description de la solution'
b = base()
trouver(b, "desc_solution")[2].append("@ENCART:Texte d'aide a ne pas reprendre dans CAST'IN.")
g("DEX_S30001_Nominal.docx", b,
  "Nominal complet : toutes les sections renseignees + 1 encart d'aide.")

# 2. Ambigu : DEUXIEME section 'Supervision' identique -> ambiguite (champ text)
b = base()
i = [k for k, blk in enumerate(b) if blk[0] == "supervision"][0]
b.insert(i + 1, ("supervision_bis", "Supervision",
                 ["Deuxieme bloc Supervision (doublon), source d'ambiguite."]))
g("DEX_S30002_Ambigu.docx", b,
  "Deux sections au titre identique 'Supervision' -> champ ambigu (proximites egales).")

# 3. Sections manquantes : retrait de 4 sections requises
g("DEX_S30003_SectionsManquantes.docx",
  sans(base(), "supervision", "log", "sauvegardes", "certificats"),
  "4 sections requises absentes (Supervision, Log, Sauvegardes, Certificats) -> Non concerne.")

# 4. Encarts a ecarter (R2) dans Supervision et Sauvegardes
b = base()
trouver(b, "supervision")[2].insert(0, "@ENCART:Rappel : decrire l'outillage de supervision.")
trouver(b, "supervision")[2].append("@ENCART:Astuce : ne pas oublier les seuils.")
trouver(b, "sauvegardes")[2].append("@ENCART:Modele : preciser la retention.")
g("DEX_S30004_Encarts.docx", b,
  "Encarts d'aide (italique/bleu) DANS Supervision et Sauvegardes -> ecartes du contenu (R2).")

# 5. Parasites (R3) dans Supervision et Certificats
b = base()
# puce de police symbole + espaces insecables + espaces multiples (ce que R3 normalise)
trouver(b, "supervision")[2][:] = [
    "\u2022\u00a0Supervisee par Centreon\u00a0; sondes  HTTP   sur les services exposes."]
g("DEX_S30005_Parasites.docx", b,
  "Caracteres parasites (puce symbole, espaces insecables/multiples) -> normalises par R3 "
  "(puce -> '- ', espaces compresses), sans changer le sens.")

# 6. Principes et decisions renseigne -> doit rester vide (R5)
g("DEX_S30006_PrincipesVide.docx", base(),
  "'Principes et decisions' est renseigne dans le nominal -> champ neanmoins VIDE (R5).")

# 7. 'Assets mainframe' (optionnel) absent
g("DEX_S30007_InfosSupplAbsent.docx", sans(base(), "infos"),
  "Section optionnelle 'Assets mainframe' absente -> informations_supplementaires non penalise.")

# 8. Confiance faible : contenus tres courts (< 15 caracteres) sur 4 sections
b = base()
for sid, court in [("supervision", "OK."), ("sauvegardes", "RAS"),
                   ("certificats", "TLS"), ("log", "ELK")]:
    trouver(b, sid)[2][:] = [court]
g("DEX_S30008_ContenuCourt.docx", b,
  "4 sections a contenu tres court (<15 car.) -> malus 'contenu court' -> confiance MOYENNE (~0.75).")

# 9. Liens absents : on retire la section Architecture (liens DAP/ADU manquants)
g("DEX_S30009_LiensAbsents.docx", sans(base(), "archi"),
  "Section Architecture absente -> champs lien (Dossier Archi, Schema) Non concernes.")

# 10. Merge : on retire matiere -> changement_mep partiel, matiere_repo absent
g("DEX_S30010_MergePartiel.docx", sans(base(), "matiere"),
  "Section 'Referentiel/depot' absente -> champ 'Matiere (repo)' (merge) impacte.")

# 11. Procedures manquantes : retrait des 3 procedures
g("DEX_S30011_ProceduresManquantes.docx",
  sans(base(), "restauration", "reconstruction", "resync"),
  "Les trois procedures absentes -> 3 champs Non concernes.")

# 12. Minimal : page de garde seule
g("DEX_S30012_Minimal.docx", copy.deepcopy(GARDE),
  "DEX minimal (page de garde seule) -> quasiment tous les champs Non concerne.")

# 13. Identifiant absent du nom mais present dans le contenu
b = [("garde", None, ["Reference solution : S30013", "Auteur : Carol Durand"])] + copy.deepcopy(BLOCS)
g("DEX_sans_identifiant_dans_le_nom.docx", b,
  "Numero de solution (S30013) absent du nom de fichier mais present dans le contenu -> extrait du contenu.")

# ------------------------------------------------------------------ #
# Cas supplementaires (comportements verifies par sondage du moteur)  #
# ------------------------------------------------------------------ #

# 14. Identifiant introuvable (ni nom, ni contenu) -> solution=None, traite quand meme
g("DEX_IdentifiantIntrouvable.docx", base(),
  "Aucun numero de solution (ni nom, ni contenu) -> solution=None (pas d'erreur), DEX traite.")

# 15. Italique SEUL (non bleu) -> conserve (R2 ne filtre que italique ET bleu)
b = base()
trouver(b, "supervision")[2].insert(0, "@ENCART_I:Phrase en italique simple, a CONSERVER.")
g("DEX_S30015_ItaliqueSeulConserve.docx", b,
  "Paragraphe en italique seul (non bleu) -> CONSERVE dans le contenu (R2 exige italique ET bleu).")

# 16. Bleu SEUL (non italique) -> conserve
b = base()
trouver(b, "supervision")[2].insert(0, "@ENCART_B:Phrase en bleu simple, a CONSERVER.")
g("DEX_S30016_BleuSeulConserve.docx", b,
  "Paragraphe en bleu seul (non italique) -> CONSERVE dans le contenu (R2 exige italique ET bleu).")

# 17. Liens DAP/ADU en TEXTE brut (pas d'hyperlien) -> reperes via motif
b = base()
trouver(b, "archi")[2][:] = ["Dossier d'architecture : DAP9876.", "Schema applicatif : ADU5555."]
g("DEX_S30017_LiensTexte.docx", b,
  "Liens Dossier Archi (DAP) et Schema (ADU) en texte brut, sans hyperlien -> reperes via le motif.")

# 18. Section presente mais VIDE (titre sans contenu) -> Non concerne, conf 0.3
b = base()
trouver(b, "supervision")[2][:] = []
g("DEX_S30018_SectionVide.docx", b,
  "Section 'Supervision' presente mais sans contenu -> 'Non concerne', confiance 0,3 (source localisee).")

# 19. Contenu dans un TABLEAU Word -> lu
b = base()
trouver(b, "supervision")[2][:] = ["@TBL:Supervisee par Centreon ; sondes HTTP, via un tableau."]
g("DEX_S30019_Tableau.docx", b,
  "Contenu de la section Supervision place dans un tableau Word -> correctement lu.")

# 20. Titres en MAJUSCULES + accents -> reperes (normalisation)
b = base()
isup = [k for k, blk in enumerate(b) if blk[0] == "supervision"][0]
b[isup] = ("supervision", "SUPERVISION", b[isup][2])
imet = [k for k, blk in enumerate(b) if blk[0] == "metrologie"][0]
b[imet] = ("metrologie", "MÉTROLOGIE", b[imet][2])
g("DEX_S30020_CasseAccents.docx", b,
  "Titres en MAJUSCULES et accentues (SUPERVISION, METROLOGIE) -> reperes via normalisation.")

# 21. Identification partielle : Auteur/Responsable absents (mais Sxxxx present)
b = [("garde", None, ["Note interne S30021, document de reprise."])] + copy.deepcopy(BLOCS)
g("DEX_S30021_IdentificationPartielle.docx", b,
  "Auteur et Responsable absents de la page de garde -> identification partielle (auteur/responsable = None).")

# 22. Palette complete de puces symbole + tabulations -> normalisees (R3)
b = base()
trouver(b, "supervision")[2][:] = [
    "\u2022 Sonde HTTP", "\u25aa Sonde TCP", "\u25cf Sonde ICMP",
    "\u25e6 Seuil warning\t90%", "\u2023 Seuil critique", "\u00b7 Retention 15 jours"]
g("DEX_S30022_PucesVariees.docx", b,
  "Palette de puces de police symbole (et tabulations) -> toutes normalisees en '- ' (R3).")

# 23. 'Merge request' hors section depot -> matiere_repo liste les references (extra_search)
b = sans(base(), "matiere")
trouver(b, "changement")[2].append("La reprise du code se fait via une merge request validee en revue.")
g("DEX_S30023_MergeRequestHorsSection.docx", b,
  "Section 'Referentiel/depot' absente mais 'merge request' mentionnee ailleurs -> matiere_repo non "
  "repere (source vide) mais references 'Merge Request' listees (extra_search).")

# 24. Sections dans le desordre -> toutes reperees (R1 independant de l'ordre)
b = copy.deepcopy(GARDE) + list(reversed(copy.deepcopy(BLOCS)))
g("DEX_S30024_TitresDesordre.docx", b,
  "Sections presentees dans l'ordre inverse -> repérage par nom inchange (R1 independant de l'ordre).")


if __name__ == "__main__":
    print(f"{len(GENERES)} DEX de test generes dans {OUT}")
    for name, _ in GENERES:
        print("  -", name)
