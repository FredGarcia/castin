#!/usr/bin/env python3
"""Genere quelques DEX *auto-referentiels* : l'application de reprise DEX -> CAST'IN
decrite elle-meme comme une solution a reprendre (aspect quasi recursif). Le contenu
est tire des donnees reelles du projet (architecture stdlib, front Vue sans build,
Store events.jsonl / analyses.jsonl, mono-poste 127.0.0.1, regles R1-R8, etc.).

Ecrit dans le sous-dossier "dex_tests_self/" a cote de ce script.
Source des parts statiques : argument 1, ou $DEX_REFERENCE, ou repli sur un .docx
present dans ../dex_tests/ (voisin), sinon erreur.
"""
import os, sys, glob, zipfile, copy

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "dex_tests_self")
NS = ('xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" '
      'xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"')

SRC = (sys.argv[1] if len(sys.argv) > 1 else None) or os.environ.get("DEX_REFERENCE")
if not SRC:
    for c in sorted(glob.glob(os.path.join(HERE, "dex_tests", "*.docx"))):
        SRC = c
        break
if not SRC or not os.path.exists(SRC):
    sys.exit("Fournir un DEX .docx de reference (argument ou $DEX_REFERENCE).")

_z = zipfile.ZipFile(SRC)
STATIC = {n: _z.read(n) for n in _z.namelist() if n != "word/document.xml"}


def esc(t): return t.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
def p_txt(t): return f'<w:p><w:r><w:t xml:space="preserve">{esc(t)}</w:t></w:r></w:p>'
def p_head(t): return f'<w:p><w:pPr><w:pStyle w:val="Titre1"/></w:pPr><w:r><w:t xml:space="preserve">{esc(t)}</w:t></w:r></w:p>'
def p_encart(t): return (f'<w:p><w:r><w:rPr><w:i/><w:color w:val="0070C0"/></w:rPr>'
                         f'<w:t xml:space="preserve">{esc(t)}</w:t></w:r></w:p>')
def p_lien(t): return (f'<w:p><w:hyperlink r:id="rId1"><w:r>'
                       f'<w:t xml:space="preserve">{esc(t)}</w:t></w:r></w:hyperlink></w:p>')


def document(ps):
    return ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
            f'<w:document {NS}><w:body>' + "".join(ps) + "</w:body></w:document>")


def rendre(blocs):
    out = []
    for _id, titre, contenus in blocs:
        if titre is not None:
            out.append(p_head(titre))
        for c in contenus:
            if c.startswith("@LIEN:"):
                out.append(p_lien(c[6:]))
            elif c.startswith("@ENCART:"):
                out.append(p_encart(c[8:]))
            else:
                out.append(p_txt(c))
    return out


def build(name, blocs):
    os.makedirs(OUT, exist_ok=True)
    path = os.path.join(OUT, name)
    with zipfile.ZipFile(path, "w", zipfile.ZIP_DEFLATED) as zf:
        for n, b in STATIC.items():
            zf.writestr(n, b)
        zf.writestr("word/document.xml", document(rendre(blocs)))
    return path


GARDE = [("garde", None, ["Auteur : Equipe DEX-CASTIN",
                          "Responsable : Architecte (Axiome 7E)"])]

# Blocs decrivant l'application elle-meme (contenu factuel issu du projet).
BLOCS = [
    ("desc_solution", "2.1 Description de la solution",
     ["Outil mono-poste d'aide a la reprise MANUELLE de fiches DEX Word vers l'application "
      "web CAST'IN : repere 23 champs par leur nom, extrait le contenu, calcule une confiance "
      "par champ et signale ambiguites et points a verifier."]),
    ("archi", "2.2 Architecture fonctionnelle & applicative",
     ["Dossier d'architecture : DAP7001.",
      "Schema applicatif : ADU7001 (moteur, serveur HTTP, front Vue)."]),
    ("donnees", "2.3 Donnees",
     ["Etat persiste localement : events.jsonl (validations), analyses.jsonl (une ligne par "
      "DEX traite, alimente l'Historique), instantanes dans runs/. Aucune base externe."]),
    ("principes", "Principes et decisions",
     ["Zero dependance (Python stdlib et Vue global sans build), moteur en lecture seule, "
      "contenu jamais reformule (R7), determinisme, accessibilite RGAA/WCAG/DSFR."]),
    ("technique", "Architecture technique",
     ["Serveur HTTP Python de la bibliotheque standard sur 127.0.0.1 ; front Vue 3 global "
      "servi localement, sans build ni bundler ; API REST sous /api/ (process-dex, validate, "
      "config, calibration, history, metrics)."]),
    ("plage", "Plages de fonctionnement / maintenance",
     ["Usage poste a poste, a la demande ; aucune contrainte de haute disponibilite."]),
    ("supervision", "Supervision",
     ["Aucune supervision externe : application mono-poste locale ; l'etat est consultable "
      "via l'onglet Historique et l'endpoint /api/metrics."]),
    ("metrologie", "Metrologie",
     ["Metriques exposees par /api/metrics ; tableau de bord interne (fenetre glissante des "
      "validations, taux d'acceptation, duree par DEX)."]),
    ("log", "Logs et diagnostic",
     ["Journalisation locale append-only dans events.jsonl et analyses.jsonl, sous le "
      "repertoire indique par --data-dir."]),
    ("sauvegardes", "Sauvegardes",
     ["Sauvegarde = copie du repertoire de donnees (--data-dir) ; les instantanes d'analyse "
      "sont conserves dans runs/."]),
    ("servitudes", "Servitudes et ordonnancements",
     ["Aucun ordonnancement : lancement manuel du serveur (python dex_castin_server.py)."]),
    ("comptes", "Comptes de service",
     ["Aucun compte de service : execution locale sous le compte de l'operateur."]),
    ("certificats", "Certificats",
     ["Aucun certificat : service HTTP en boucle locale 127.0.0.1 (pas de TLS)."]),
    ("liste_blanche", "Liste blanche",
     ["Liaison restreinte a l'adresse de bouclage 127.0.0.1 ; aucune ouverture reseau."]),
    ("flux", "Flux et interdependances",
     ["Aucun flux sortant ; le front dialogue avec le serveur local via les routes /api/. "
      "Aucune dependance a une API CAST'IN (la reprise reste manuelle)."]),
    ("support", "Matrice des responsabilites (RACI)",
     ["Maintenance assuree par l'equipe projet ; signalements via l'e-mail genere depuis "
      "l'onglet Reprise assistee."]),
    ("changement", "Changements et MEP",
     ["Mise a jour par remplacement des fichiers via les installeurs .cmd, puis redemarrage "
      "du serveur. Controle des operations : verification smoke + tests avant livraison."]),
    ("matiere", "Referentiel (depot de code)",
     ["Code source du projet (moteur, serveur, front, outils, generateurs) ; livrables "
      "versionnes et reconstructibles depuis le depot de code."]),
    ("restauration", "Procedure de restauration",
     ["Restauration : reextraire dex_app_install.cmd et restaurer le repertoire --data-dir."]),
    ("reconstruction", "Procedure de reconstruction",
     ["Reconstruction : relancer dex_app_install.cmd dans un dossier vide puis demarrer le "
      "serveur (python dex_castin_server.py --front front)."]),
    ("resync", "Procedure de resynchronisation",
     ["Resynchronisation : sans objet (pas d'etat distribue) ; l'Historique se reconstitue "
      "en retraitant les DEX concernes."]),
    ("infos", "Assets mainframe",
     ["Sans objet : aucun actif mainframe (solution locale en Python et HTML/JS)."]),
]


def base(): return copy.deepcopy(GARDE + BLOCS)
def sans(blocs, *ids): return [b for b in blocs if b[0] not in ids]
def trouver(blocs, _id):
    for b in blocs:
        if b[0] == _id:
            return b
    return None


GENERES = []
def g(name, blocs, scenario):
    build(name, blocs)
    GENERES.append((name, scenario))


# 1. SELF Nominal : l'application entierement decrite
g("DEX_SELF_S70001_Nominal.docx", base(),
  "L'application DEX->CAST'IN entierement decrite (auto-reference) -> repérage maximal.")

# 2. SELF Mono-poste : champs sans objet pour une appli locale -> sections OMISES
g("DEX_SELF_S70002_MonoPoste.docx",
  sans(base(), "certificats", "comptes", "liste_blanche", "servitudes"),
  "Profil mono-poste : Certificats / Comptes de service / Liste blanche / Servitudes "
  "absents (sans objet en local) -> Non concerne.")

# 3. SELF Ambigu : deux sections 'Architecture technique' (doublon) -> ambiguite
b = base()
i = [k for k, blk in enumerate(b) if blk[0] == "technique"][0]
b.insert(i + 1, ("technique_bis", "Architecture technique",
                 ["Second bloc technique : memes composants, source d'ambiguite."]))
g("DEX_SELF_S70003_Ambigu.docx", b,
  "Deux sections 'Architecture technique' (doublon) -> champ Description technique ambigu.")

# 4. SELF Encart meta : une note expliquant R2 est elle-meme ecartee (clin d'oeil)
b = base()
trouver(b, "supervision")[2].insert(
    0, "@ENCART:Note de redaction (a NE PAS reprendre dans CAST'IN) : decrire ici l'outillage "
       "de supervision. Cet encart illustre la regle R2 et doit etre ecarte.")
g("DEX_SELF_S70004_EncartMeta.docx", b,
  "Un encart d'aide qui explique justement R2 -> ecarte du contenu (clin d'oeil recursif).")


if __name__ == "__main__":
    print(f"{len(GENERES)} DEX auto-referentiels generes dans {OUT}")
    for name, _ in GENERES:
        print("  -", name)
