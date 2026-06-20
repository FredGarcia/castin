#!/usr/bin/env python3
"""Construit QUATRE installeurs Windows .cmd auto-extractibles, a repartition etanche.

NOUVEAU : le contenu TEXTE est embarque EN CLAIR (lisible/editable directement dans le
.cmd) ; seuls les fichiers BINAIRES (.docx, images...) sont en base64.

Mecanique : apres l'en-tete batch (qui sort via 'exit /b' avant les donnees), chaque
fichier est place entre marqueurs :
    #@FILE_TXT:<chemin>     ... contenu en clair ...      #@FILE_END
    #@FILE_BIN:<chemin>     ... base64 (binaires) ...      #@FILE_END
Le batch ne lit jamais les donnees (sortie avant) : les caracteres speciaux du contenu
texte ne sont donc pas interpretes. Un script PowerShell (passe en -EncodedCommand, donc
insensible au quoting DOS) relit le .cmd en UTF-8, ecrit le texte tel quel et ne decode en
base64 que les blocs binaires.
"""
import base64, os, glob

OUT = "/mnt/user-data/outputs"
UP = "/mnt/user-data/uploads"
BIN_EXT = {".docx", ".png", ".jpg", ".jpeg", ".gif", ".bmp", ".ico", ".pdf", ".zip", ".xlsx", ".pptx"}

MARK_TXT = "#@FILE_TXT:"
MARK_BIN = "#@FILE_BIN:"
MARK_END = "#@FILE_END"

# --- RUNTIME (aucun fichier de test) ---
APP_FILES = [
    (f"{UP}/dex_castin_common.py", "dex_castin_common.py"),
    (f"{UP}/dex_castin_cli.py", "dex_castin_cli.py"),
    (f"{OUT}/dex_castin_server.py", "dex_castin_server.py"),
    (f"{OUT}/dex_castin_calibration.py", "dex_castin_calibration.py"),
    (f"{OUT}/regles.json", "regles.json"),
    (f"{OUT}/regles.candidate.exemple.json", "regles.candidate.exemple.json"),
    (f"{OUT}/tableau_de_bord.config.json", "tableau_de_bord.config.json"),
    (f"{OUT}/front/index.html", "front/index.html"),
    (f"{OUT}/front/vue.global.prod.js", "front/vue.global.prod.js"),
    (f"{OUT}/outils/calibrer.py", "outils/calibrer.py"),
    (f"{OUT}/outils/calibration_check.py", "outils/calibration_check.py"),
]

# --- DOCUMENTATION PROJET (sans test) + cahier des charges ---
DOCS_FILES = [
    (f"{OUT}/SYNTHESE_REPRISE.md", "SYNTHESE_REPRISE.md"),
    (f"{OUT}/README.md", "README.md"),
    (f"{OUT}/README_SERVEUR.md", "README_SERVEUR.md"),
    (f"{OUT}/ENDPOINTS.md", "ENDPOINTS.md"),
    (f"{OUT}/ANNEXE_Boucle_2e_ordre.md", "ANNEXE_Boucle_2e_ordre.md"),
    (f"{OUT}/CAHIER_DES_CHARGES.md", "CAHIER_DES_CHARGES.md"),
    (f"{OUT}/CDC.md", "CDC.md"),
]

# --- TOUT LE TEST (seul installeur a en contenir) ---
TESTS_FILES = []
for f in sorted(glob.glob(f"{OUT}/dex_tests/*.docx")):
    TESTS_FILES.append((f, "dex_tests/" + os.path.basename(f)))
for f in sorted(glob.glob(f"{OUT}/dex_tests_self/*.docx")):
    TESTS_FILES.append((f, "dex_tests_self/" + os.path.basename(f)))
TESTS_FILES += [
    (f"{OUT}/dex_tests/_RESULTATS_ATTENDUS.md", "dex_tests/_RESULTATS_ATTENDUS.md"),
    (f"{OUT}/dex_tests_self/_RESULTATS_ATTENDUS_SELF.md", "dex_tests_self/_RESULTATS_ATTENDUS_SELF.md"),
    (f"{OUT}/TEST_PLAN.md", "TEST_PLAN.md"),
    (f"{OUT}/RECETTE_FRONT.md", "RECETTE_FRONT.md"),
    (f"{OUT}/generer_dex_tests.py", "generer_dex_tests.py"),
    (f"{OUT}/generer_dex_self.py", "generer_dex_self.py"),
    (f"{OUT}/outils/smoke_serveur.py", "outils/smoke_serveur.py"),
    (f"{OUT}/outils/test_candidats.py", "outils/test_candidats.py"),
    (f"{UP}/DEX_S20001_Nominal.docx", "DEX_S20001_Nominal.docx"),
]

# --- FORMATION ---
FORM_FILES = [
    (f"{OUT}/formation/00_README_formation.md", "formation/00_README_formation.md"),
    (f"{OUT}/formation/01_operateurs_prise_en_main.md", "formation/01_operateurs_prise_en_main.md"),
    (f"{OUT}/formation/02_direction_vue_ensemble.md", "formation/02_direction_vue_ensemble.md"),
    (f"{OUT}/formation/03_managers_guide_technique.md", "formation/03_managers_guide_technique.md"),
]

# Script PowerShell d'extraction : texte en clair + binaires base64 (lecture/ecriture UTF-8).
PS = r'''$ErrorActionPreference = 'Stop'
$self = $env:DEXCMD_SELF
if (-not $self) { Write-Host 'Erreur : chemin du script introuvable.'; exit 1 }
$root = Split-Path -Parent $self
$utf8 = New-Object System.Text.UTF8Encoding($false)
$lines = [System.IO.File]::ReadAllLines($self, [System.Text.Encoding]::UTF8)
$i = 0
$count = 0
while ($i -lt $lines.Length) {
    $l = $lines[$i]
    $txt = $l.StartsWith('#@FILE_TXT:')
    $bin = $l.StartsWith('#@FILE_BIN:')
    if ($txt -or $bin) {
        $rel = $l.Substring(11).Replace('/', '\')
        $i++
        $start = $i
        while ($i -lt $lines.Length -and $lines[$i] -ne '#@FILE_END') { $i++ }
        if ($i -gt $start) { $body = $lines[$start..($i - 1)] } else { $body = @() }
        $dest = Join-Path $root $rel
        $dir = Split-Path -Parent $dest
        if ($dir -and -not (Test-Path -LiteralPath $dir)) {
            New-Item -ItemType Directory -Force -Path $dir | Out-Null
        }
        if ($txt) {
            $text = [string]::Join("`n", $body)
            if ($body.Length -gt 0) { $text = $text + "`n" }
            [System.IO.File]::WriteAllText($dest, $text, $utf8)
        } else {
            $b64 = [string]::Join('', $body)
            [System.IO.File]::WriteAllBytes($dest, [Convert]::FromBase64String($b64))
        }
        Write-Host ("  ecrit   {0}" -f $rel)
        $count++
    }
    $i++
}
Write-Host ''
Write-Host ("Termine : {0} fichier(s) extrait(s) dans :" -f $count)
Write-Host ("  {0}" -f $root)
'''
PS_B64 = base64.b64encode(PS.encode("utf-16-le")).decode("ascii")


def est_binaire(src):
    if os.path.splitext(src)[1].lower() in BIN_EXT:
        return True
    try:
        open(src, "rb").read().decode("utf-8")
        return False
    except UnicodeDecodeError:
        return True


def bloc_fichier(src, rel):
    if est_binaire(src):
        b64 = base64.b64encode(open(src, "rb").read()).decode("ascii")
        lignes = [b64[k:k + 120] for k in range(0, len(b64), 120)] or [""]
        return f"{MARK_BIN}{rel}\r\n" + "\r\n".join(lignes) + f"\r\n{MARK_END}\r\n"
    # texte EN CLAIR
    texte = open(src, "rb").read().decode("utf-8")
    lignes = texte.split("\n")
    if lignes and lignes[-1] == "":
        lignes = lignes[:-1]  # eviter une ligne vide finale parasite
    for ln in lignes:
        if ln == MARK_END or ln.startswith(MARK_TXT) or ln.startswith(MARK_BIN):
            raise SystemExit(f"Collision de marqueur dans {rel} (ligne: {ln!r})")
    corps = "\r\n".join(ln.replace("\r", "") for ln in lignes)
    return f"{MARK_TXT}{rel}\r\n" + corps + f"\r\n{MARK_END}\r\n"


def construire(nom_cmd, titre, fichiers, hints):
    parts = ["@echo off\r\n", "setlocal\r\n",
             "echo ============================================================\r\n",
             f"echo  {titre}\r\n",
             "echo ============================================================\r\n",
             "echo Extraction en cours...\r\n",
             'set "DEXCMD_SELF=%~f0"\r\n',
             f"powershell -NoProfile -ExecutionPolicy Bypass -EncodedCommand {PS_B64}\r\n",
             'set "RC=%ERRORLEVEL%"\r\n', 'set "DEXCMD_SELF="\r\n']
    for h in hints:
        parts.append(f"echo {h}\r\n")
    parts.append("endlocal & exit /b %RC%\r\n")
    for src, rel in fichiers:
        parts.append(bloc_fichier(src, rel))
    contenu = "".join(parts)
    path = os.path.join(OUT, nom_cmd)
    with open(path, "w", encoding="utf-8", newline="") as f:
        f.write(contenu)
    return path, len(contenu)


APP_HINTS = [".", "Application extraite. Pour la lancer :",
             "  python dex_castin_server.py --data-dir .data --front front",
             "  puis ouvrir http://127.0.0.1:8765/  (option --port pour changer de port)"]
DOCS_HINTS = [".", "Documentation extraite. Commencez par SYNTHESE_REPRISE.md.",
              "Cahier des charges : CAHIER_DES_CHARGES.md et CDC.md."]
TESTS_HINTS = [".", "Jeux de tests extraits (dex_tests\\ et dex_tests_self\\).",
               "Lot : onglet Reprise -> bouton dossier -> dex_tests puis dex_tests_self.",
               "Regenerer : python generer_dex_tests.py DEX_S20001_Nominal.docx",
               "           python generer_dex_self.py  DEX_S20001_Nominal.docx",
               "Resultats attendus : TEST_PLAN.md et fichiers _RESULTATS_ATTENDUS*.md"]
FORM_HINTS = [".", "Formation extraite dans formation\\ :",
              "  operateurs -> formation\\01_operateurs_prise_en_main.md",
              "  direction  -> formation\\02_direction_vue_ensemble.md",
              "  managers   -> formation\\03_managers_guide_technique.md"]

if __name__ == "__main__":
    for nom, titre, fichiers, hints in [
        ("dex_app_install.cmd", "Installeur application DEX -> CAST'IN (runtime)", APP_FILES, APP_HINTS),
        ("dex_docs_install.cmd", "Installeur documentation DEX -> CAST'IN (+ cahier des charges)", DOCS_FILES, DOCS_HINTS),
        ("dex_tests_install.cmd", "Installeur TESTS DEX -> CAST'IN (DEX + resultats attendus)", TESTS_FILES, TESTS_HINTS),
        ("dex_formation_install.cmd", "Installeur FORMATION DEX -> CAST'IN (tutoriels)", FORM_FILES, FORM_HINTS),
    ]:
        p, n = construire(nom, titre, fichiers, hints)
        nb_bin = sum(1 for s, _ in fichiers if est_binaire(s))
        print(f"{os.path.basename(p):28s} {n:>8d} o, {len(fichiers):2d} fichiers ({nb_bin} binaire(s) en base64)")
