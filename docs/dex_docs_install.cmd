@echo off
setlocal
echo ============================================================
echo  Installeur documentation DEX -> CAST'IN (+ cahier des charges)
echo ============================================================
echo Extraction en cours...
set "DEXCMD_SELF=%~f0"
powershell -NoProfile -ExecutionPolicy Bypass -EncodedCommand JABFAHIAcgBvAHIAQQBjAHQAaQBvAG4AUAByAGUAZgBlAHIAZQBuAGMAZQAgAD0AIAAnAFMAdABvAHAAJwAKACQAcwBlAGwAZgAgAD0AIAAkAGUAbgB2ADoARABFAFgAQwBNAEQAXwBTAEUATABGAAoAaQBmACAAKAAtAG4AbwB0ACAAJABzAGUAbABmACkAIAB7ACAAVwByAGkAdABlAC0ASABvAHMAdAAgACcARQByAHIAZQB1AHIAIAA6ACAAYwBoAGUAbQBpAG4AIABkAHUAIABzAGMAcgBpAHAAdAAgAGkAbgB0AHIAbwB1AHYAYQBiAGwAZQAuACcAOwAgAGUAeABpAHQAIAAxACAAfQAKACQAcgBvAG8AdAAgAD0AIABTAHAAbABpAHQALQBQAGEAdABoACAALQBQAGEAcgBlAG4AdAAgACQAcwBlAGwAZgAKACQAdQB0AGYAOAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBUAGUAeAB0AC4AVQBUAEYAOABFAG4AYwBvAGQAaQBuAGcAKAAkAGYAYQBsAHMAZQApAAoAJABsAGkAbgBlAHMAIAA9ACAAWwBTAHkAcwB0AGUAbQAuAEkATwAuAEYAaQBsAGUAXQA6ADoAUgBlAGEAZABBAGwAbABMAGkAbgBlAHMAKAAkAHMAZQBsAGYALAAgAFsAUwB5AHMAdABlAG0ALgBUAGUAeAB0AC4ARQBuAGMAbwBkAGkAbgBnAF0AOgA6AFUAVABGADgAKQAKACQAaQAgAD0AIAAwAAoAJABjAG8AdQBuAHQAIAA9ACAAMAAKAHcAaABpAGwAZQAgACgAJABpACAALQBsAHQAIAAkAGwAaQBuAGUAcwAuAEwAZQBuAGcAdABoACkAIAB7AAoAIAAgACAAIAAkAGwAIAA9ACAAJABsAGkAbgBlAHMAWwAkAGkAXQAKACAAIAAgACAAJAB0AHgAdAAgAD0AIAAkAGwALgBTAHQAYQByAHQAcwBXAGkAdABoACgAJwAjAEAARgBJAEwARQBfAFQAWABUADoAJwApAAoAIAAgACAAIAAkAGIAaQBuACAAPQAgACQAbAAuAFMAdABhAHIAdABzAFcAaQB0AGgAKAAnACMAQABGAEkATABFAF8AQgBJAE4AOgAnACkACgAgACAAIAAgAGkAZgAgACgAJAB0AHgAdAAgAC0AbwByACAAJABiAGkAbgApACAAewAKACAAIAAgACAAIAAgACAAIAAkAHIAZQBsACAAPQAgACQAbAAuAFMAdQBiAHMAdAByAGkAbgBnACgAMQAxACkALgBSAGUAcABsAGEAYwBlACgAJwAvACcALAAgACcAXAAnACkACgAgACAAIAAgACAAIAAgACAAJABpACsAKwAKACAAIAAgACAAIAAgACAAIAAkAHMAdABhAHIAdAAgAD0AIAAkAGkACgAgACAAIAAgACAAIAAgACAAdwBoAGkAbABlACAAKAAkAGkAIAAtAGwAdAAgACQAbABpAG4AZQBzAC4ATABlAG4AZwB0AGgAIAAtAGEAbgBkACAAJABsAGkAbgBlAHMAWwAkAGkAXQAgAC0AbgBlACAAJwAjAEAARgBJAEwARQBfAEUATgBEACcAKQAgAHsAIAAkAGkAKwArACAAfQAKACAAIAAgACAAIAAgACAAIABpAGYAIAAoACQAaQAgAC0AZwB0ACAAJABzAHQAYQByAHQAKQAgAHsAIAAkAGIAbwBkAHkAIAA9ACAAJABsAGkAbgBlAHMAWwAkAHMAdABhAHIAdAAuAC4AKAAkAGkAIAAtACAAMQApAF0AIAB9ACAAZQBsAHMAZQAgAHsAIAAkAGIAbwBkAHkAIAA9ACAAQAAoACkAIAB9AAoAIAAgACAAIAAgACAAIAAgACQAZABlAHMAdAAgAD0AIABKAG8AaQBuAC0AUABhAHQAaAAgACQAcgBvAG8AdAAgACQAcgBlAGwACgAgACAAIAAgACAAIAAgACAAJABkAGkAcgAgAD0AIABTAHAAbABpAHQALQBQAGEAdABoACAALQBQAGEAcgBlAG4AdAAgACQAZABlAHMAdAAKACAAIAAgACAAIAAgACAAIABpAGYAIAAoACQAZABpAHIAIAAtAGEAbgBkACAALQBuAG8AdAAgACgAVABlAHMAdAAtAFAAYQB0AGgAIAAtAEwAaQB0AGUAcgBhAGwAUABhAHQAaAAgACQAZABpAHIAKQApACAAewAKACAAIAAgACAAIAAgACAAIAAgACAAIAAgAE4AZQB3AC0ASQB0AGUAbQAgAC0ASQB0AGUAbQBUAHkAcABlACAARABpAHIAZQBjAHQAbwByAHkAIAAtAEYAbwByAGMAZQAgAC0AUABhAHQAaAAgACQAZABpAHIAIAB8ACAATwB1AHQALQBOAHUAbABsAAoAIAAgACAAIAAgACAAIAAgAH0ACgAgACAAIAAgACAAIAAgACAAaQBmACAAKAAkAHQAeAB0ACkAIAB7AAoAIAAgACAAIAAgACAAIAAgACAAIAAgACAAJAB0AGUAeAB0ACAAPQAgAFsAcwB0AHIAaQBuAGcAXQA6ADoASgBvAGkAbgAoACIAYABuACIALAAgACQAYgBvAGQAeQApAAoAIAAgACAAIAAgACAAIAAgACAAIAAgACAAaQBmACAAKAAkAGIAbwBkAHkALgBMAGUAbgBnAHQAaAAgAC0AZwB0ACAAMAApACAAewAgACQAdABlAHgAdAAgAD0AIAAkAHQAZQB4AHQAIAArACAAIgBgAG4AIgAgAH0ACgAgACAAIAAgACAAIAAgACAAIAAgACAAIABbAFMAeQBzAHQAZQBtAC4ASQBPAC4ARgBpAGwAZQBdADoAOgBXAHIAaQB0AGUAQQBsAGwAVABlAHgAdAAoACQAZABlAHMAdAAsACAAJAB0AGUAeAB0ACwAIAAkAHUAdABmADgAKQAKACAAIAAgACAAIAAgACAAIAB9ACAAZQBsAHMAZQAgAHsACgAgACAAIAAgACAAIAAgACAAIAAgACAAIAAkAGIANgA0ACAAPQAgAFsAcwB0AHIAaQBuAGcAXQA6ADoASgBvAGkAbgAoACcAJwAsACAAJABiAG8AZAB5ACkACgAgACAAIAAgACAAIAAgACAAIAAgACAAIABbAFMAeQBzAHQAZQBtAC4ASQBPAC4ARgBpAGwAZQBdADoAOgBXAHIAaQB0AGUAQQBsAGwAQgB5AHQAZQBzACgAJABkAGUAcwB0ACwAIABbAEMAbwBuAHYAZQByAHQAXQA6ADoARgByAG8AbQBCAGEAcwBlADYANABTAHQAcgBpAG4AZwAoACQAYgA2ADQAKQApAAoAIAAgACAAIAAgACAAIAAgAH0ACgAgACAAIAAgACAAIAAgACAAVwByAGkAdABlAC0ASABvAHMAdAAgACgAIgAgACAAZQBjAHIAaQB0ACAAIAAgAHsAMAB9ACIAIAAtAGYAIAAkAHIAZQBsACkACgAgACAAIAAgACAAIAAgACAAJABjAG8AdQBuAHQAKwArAAoAIAAgACAAIAB9AAoAIAAgACAAIAAkAGkAKwArAAoAfQAKAFcAcgBpAHQAZQAtAEgAbwBzAHQAIAAnACcACgBXAHIAaQB0AGUALQBIAG8AcwB0ACAAKAAiAFQAZQByAG0AaQBuAGUAIAA6ACAAewAwAH0AIABmAGkAYwBoAGkAZQByACgAcwApACAAZQB4AHQAcgBhAGkAdAAoAHMAKQAgAGQAYQBuAHMAIAA6ACIAIAAtAGYAIAAkAGMAbwB1AG4AdAApAAoAVwByAGkAdABlAC0ASABvAHMAdAAgACgAIgAgACAAewAwAH0AIgAgAC0AZgAgACQAcgBvAG8AdAApAAoA
set "RC=%ERRORLEVEL%"
set "DEXCMD_SELF="
echo .
echo Documentation extraite. Commencez par SYNTHESE_REPRISE.md.
echo Cahier des charges : CAHIER_DES_CHARGES.md et CDC.md.
endlocal & exit /b %RC%
#@FILE_TXT:SYNTHESE_REPRISE.md
# Synthèse de reprise — Outil d'aide à la reprise de DEX vers CAST'IN

> **But de ce document** : permettre de **reprendre l'intégralité du projet depuis une
> nouvelle conversation**, sans contexte préalable. Il consolide objectif, contraintes,
> architecture, emplacements, API, fonctionnalités, conventions, tests et pistes ouvertes.
> L'application est **opérationnelle**.

---

## 0. Amorçage d'une nouvelle conversation

Dans la nouvelle conversation, fournir :

1. **Le moteur (lecture seule)** : `dex_castin_common.py`, `dex_castin_cli.py`.
2. **La référence** : `DEX_S20001_Nominal.docx` (+ `_CASTIN.json` / `_CASTIN.md`),
   `CDC.md` et/ou `Cahier_des_charges.pdf`.
3. **L'arborescence livrée** `outputs/` (serveur, front, outils, docs, `dex_tests/`).
4. **Ce document** comme brief de reprise.

Brief minimal à coller :

> Reprise du projet « aide à la reprise manuelle de DEX Word vers l'outil web CAST'IN »
> (appel d'offres CA-GIP). Outil **mono-poste 127.0.0.1**, **zéro dépendance** (Python
> stdlib + Vue global sans build), le **contenu n'est jamais reformulé** (R7), rien ne
> quitte le poste. Le **moteur** `dex_castin_common.py` + `dex_castin_cli.py` est
> **read-only** ; toute évolution se fait au niveau **serveur** (`dex_castin_server.py`)
> et **front** (`front/index.html`). Voir `SYNTHESE_REPRISE.md` pour l'état complet.

### Reconstitution éclair par installeurs Windows (.cmd)

**Quatre** installeurs **auto-extractibles** reconstituent l'arborescence à côté d'eux, sans
dépendance (PowerShell natif) et avec **fidélité octet par octet** (base64 interne). La
répartition est **étanche** : tout ce qui touche aux tests est dans **un seul** installeur,
les autres en sont dépourvus.

- **`dex_app_install.cmd`** — *runtime* : le moteur (`dex_castin_common.py`,
  `dex_castin_cli.py`), le serveur, la calibration (`dex_castin_calibration.py`,
  `outils/calibrer.py`, `outils/calibration_check.py`), `regles*.json`, la config et le
  front (`index.html` + `vue.global.prod.js`). Placer le `.cmd` dans un dossier cible,
  l'exécuter, puis : `python dex_castin_server.py --data-dir .data --front front`
  → `http://127.0.0.1:8765/`.
- **`dex_docs_install.cmd`** — *documentation projet* : `SYNTHESE_REPRISE.md`, `README.md`,
  `README_SERVEUR.md`, `ENDPOINTS.md`, `ANNEXE_Boucle_2e_ordre.md`, **le cahier des charges**
  (`CAHIER_DES_CHARGES.md`, `CDC.md`) — **aucune** information de test.
- **`dex_tests_install.cmd`** — *tout le test* (seul installeur à en contenir) : les 24 DEX
  de test **et** les 4 DEX auto-référentiels, leurs **résultats attendus**
  (`_RESULTATS_ATTENDUS*.md`), `TEST_PLAN.md`, `RECETTE_FRONT.md`, les générateurs
  (`generer_dex_tests.py`, `generer_dex_self.py`), les **outils de test**
  (`outils/smoke_serveur.py`, `outils/test_candidats.py`) et le **DEX de référence**.
- **`dex_formation_install.cmd`** — *formation* : les trois tutoriels (opérateurs, direction,
  managers) et leur index.

Régénérer les DEX de test après extraction (installeur tests) :
`python generer_dex_tests.py DEX_S20001_Nominal.docx` et
`python generer_dex_self.py DEX_S20001_Nominal.docx`.

> Mécanique : chaque fichier est encodé en base64 entre des marqueurs `###FILE:…###` /
> `###END###` placés après l'en-tête batch ; un script PowerShell (passé en
> `-EncodedCommand`, donc insensible au quoting DOS) relit le `.cmd` et réécrit les
> fichiers. Le batch sort (`exit /b`) avant d'atteindre les données.
>
> **Contenu en clair** : le texte (code, docs) est embarqué **lisible** dans le `.cmd` ; seuls les **binaires** (les `.docx` de test) sont en base64.

---

## 1. Contexte & objectif

> **Cadre contractuel (CA-GIP)** : appel d'offres du 23/04/2026 — reprise de **115 / 907 / 1 227** DEX selon l'option **A / B / C**, ~**20 min/DEX**, échéance **avant octobre 2026** ; livrable = DEX **exportés en PDF** ; gouvernance Paul BALARESQUE / Nadège SCHMITT / Baptistan HIOT. Détail et **MODOP officiel** (mapping section Word → champ CAST'IN) dans `CAHIER_DES_CHARGES.md` et `CDC.md`.

Outil **d'aide à la reprise MANUELLE** de fiches **DEX** (documents Word `.docx`) vers
l'outil web **CAST'IN**, dans le cadre d'un **appel d'offres CA-GIP**. Il **n'y a pas
d'API CAST'IN** : l'outil **assiste l'opérateur** (repérage, confiance, copier-coller),
il ne pilote pas CAST'IN.

Le moteur lit un DEX, **repère 23 champs CAST'IN par leur nom** (jamais par numéro),
en extrait le contenu, calcule une **confiance** par champ, signale **ambiguïtés** et
**points à vérifier**, et propose des **suggestions** de section quand le repérage est
incertain. Le front présente ce résultat et outille la reprise.

## 2. Contraintes non négociables

- **Zéro dépendance** : Python **stdlib** pur côté serveur ; Vue 3 **global** servi
  localement (`front/vue.global.prod.js`), **sans build, sans bundler, sans npm**.
- **R7 — le contenu n'est JAMAIS reformulé** : on extrait/normalise des caractères
  parasites, jamais on ne réécrit le texte métier.
- **Déterminisme** : même DEX → même sortie.
- **Mono-poste** : serveur HTTP sur **127.0.0.1**, **rien ne quitte le poste**
  (pas d'appel réseau sortant, e-mail = `mailto:` / copie presse-papier).
- **Accessibilité** : cible **RGAA / WCAG / DSFR** (radiogroups accessibles,
  `aria-sort`, contrastes calculés, navigation clavier, modale `role=dialog`).
- **Moteur intouchable** : `dex_castin_common.py` et `dex_castin_cli.py` sont
  **read-only** ; toute dérivation passe par le serveur.

## 3. Architecture

```
DEX .docx ──> [ MOTEUR read-only ]            dex_castin_common.py (+ cli.py)
                 process_dex / process_path
                 repérage par nom, extraction, kinds, suggestions
                       │  (importé, jamais modifié)
                       ▼
              [ SERVEUR stdlib HTTP 127.0.0.1 ] dex_castin_server.py
                 enrichit (confiance, ambiguïté, points, candidats)
                 config, calibration, historique, Store
                       │  JSON / REST
                       ▼
              [ FRONT Vue 3 global, sans build ] front/index.html
                 5 onglets, copier-coller assisté, signalement, dictionnaire
```

- Le **serveur** importe le moteur (via `PYTHONPATH` pointant sur le dossier du moteur)
  et **n'en modifie rien** : il **enrichit** le résultat (bandes de confiance, candidats,
  ambiguïté, points à vérifier), gère **config**, **calibration**, **historique**.
- Le **Store** (répertoire `--data-dir`) persiste : `events.jsonl` (validations),
  `analyses.jsonl` (**1 ligne par `process-dex`**, alimente l'Historique), `runs/`
  (instantanés d'analyse).

## 4. Emplacements des fichiers (verbatim)

### Lecture seule (moteur + références) — `/mnt/user-data/uploads/`
| Fichier | Rôle |
|---|---|
| `dex_castin_common.py` | **Moteur** (repérage par nom, extraction, kinds, suggestions). **Read-only.** |
| `dex_castin_cli.py` | CLI du moteur. **Read-only.** |
| `DEX_S20001_Nominal.docx` | DEX de **référence** (gabarit, exemple nominal). |
| `DEX_S20001_Nominal_CASTIN.json` / `.md` | Sortie attendue de référence. |
| `CDC.md`, `Cahier_des_charges.pdf` | Cahier des charges. |

### Livrables — `/mnt/user-data/outputs/`
| Fichier / dossier | Rôle |
|---|---|
| `dex_castin_server.py` | **Serveur** stdlib HTTP (enrichissement, config, calibration, historique, Store). |
| `front/index.html` | **Front** Vue 3 (5 onglets). À éditer **directement**. |
| `front/vue.global.prod.js` | Runtime Vue servi localement (zéro CDN). |
| `dex_castin_calibration.py` | Logique de calibration (proposition de seuils). |
| `regles.json` | Règles **actives** (chargées par `--rules`). |
| `regles.candidate.exemple.json` | Exemple de règles candidates (calibration). |
| `tableau_de_bord.config.json` | Config **active** régénérée depuis `DEFAULT_CONFIG`. |
| `outils/smoke_serveur.py` | Smoke test bout-en-bout du serveur. |
| `outils/test_candidats.py` | Tests du calcul de candidats/ambiguïté. |
| `outils/calibrer.py`, `outils/calibration_check.py` | Outils de calibration. |
| `dex_tests/` | **24 DEX de test** (`.docx`) traitables en lot. |
| `README.md` | Présentation générale. |
| `README_SERVEUR.md` | Doc serveur (démarrage, options, comportements). |
| `ENDPOINTS.md` | Contrat d'API (endpoints, payloads, config). |
| `RECETTE_FRONT.md` | **Recette** du front (grille de vérification onglet par onglet). |
| `TEST_PLAN.md` | **Plan de tests** des 24 DEX (sorties attendues, règles couvertes). |
| `ANNEXE_Boucle_2e_ordre.md` | Annexe (boucle de 2ᵉ ordre / calibration). |
| `CAHIER_DES_CHARGES.md` | **Cahier des charges** : synthèse du besoin, MODOP officiel, correspondance R1–R8. |
| `CDC.md` | Cahier des charges structuré complet (référence). |
| `dex_app_install.cmd` | **Installeur Windows** — runtime (voir §0). |
| `dex_docs_install.cmd` | **Installeur Windows** — documentation projet, sans tests (voir §0). |
| `dex_tests_install.cmd` | **Installeur Windows** — **tout le test** (DEX, résultats, plan, recette, générateurs, outils de test). Seul à contenir des infos de test. |
| `dex_formation_install.cmd` | **Installeur Windows** — formation (3 tutoriels + index). |
| `build_cmd_installers.py` | Générateur des quatre installeurs `.cmd` (reconstruction). |
| `formation/` | Tutoriels : opérateurs, direction, managers (+ index). |
| `dex_tests/` `dex_tests_self/` | Jeux de tests (24 synthétiques + 4 auto-référentiels) et leurs résultats attendus. |

> **Répertoire de travail/test recommandé** (copie inscriptible du moteur) :
> un dossier où l'on place une **copie** du serveur et où le moteur est **importable**
> via `PYTHONPATH=/mnt/user-data/uploads`. **Règle de copie** : le serveur peut être
> travaillé dans ce dossier puis **recopié vers `outputs/`** (source unique ; vérifier
> `diff -q` identiques). Le front s'édite **directement** dans `outputs/front/index.html`.
> Après tout ajout de clé de config, **régénérer** `tableau_de_bord.config.json` depuis
> `DEFAULT_CONFIG`.

## 5. Les 23 champs CAST'IN

Repérés **par nom** (R1). `kind` pilote l'extraction et le scoring.

| # | Clé | Libellé | Onglet | kind |
|---|-----|---------|--------|------|
| 1 | `lien_dossier_archi` | Lien Dossier Archi (DAP…) | Description détaillée | link |
| 2 | `schema_applicatif` | Schéma Applicatif (ADU…) | Description détaillée | link |
| 3 | `description_fonctionnelle` | Description Fonctionnelle | Description détaillée | text |
| 4 | `donnees_solution` | Données de la solution | Description détaillée | text |
| 5 | `principes_decisions` | Principes et décisions | Description détaillée | **empty** (R5) |
| 6 | `description_technique` | Description Technique | Description détaillée | text |
| 7 | `plage_fonctionnement` | Plage de fonctionnement / maintenance | DEX | text |
| 8 | `supervision` | Supervision | DEX | text |
| 9 | `observabilite` | Observabilité | DEX | text |
| 10 | `log` | Log | DEX | text |
| 11 | `sauvegardes` | Sauvegardes | DEX | text |
| 12 | `servitudes` | Servitudes et ordonnancements | DEX | text |
| 13 | `comptes_services` | Comptes et services | DEX | text |
| 14 | `certificats` | Certificats | DEX | text |
| 15 | `liste_blanche` | Liste blanche | DEX | text |
| 16 | `flux` | Flux | DEX | text |
| 17 | `support` | Support | DEX | text |
| 18 | `changement_mep` | Changement et MEP | DEX | **merge** |
| 19 | `matiere_repo` | Matière (repo) | DEX | **merge** |
| 20 | `procedure_restauration` | Procédure de restauration | DEX | text |
| 21 | `procedure_reconstruction` | Procédure de reconstruction | DEX | text |
| 22 | `procedure_resynchronisation` | Procédure de resynchronisation | DEX | text |
| 23 | `informations_supplementaires` | Informations supplémentaires | DEX | **appendix** (optionnel, R6) |

## 6. Règles métier (R1–R8)

- **R1** — Repérage **par nom** de section (jamais par numéro).
- **R2** — **Écarter les encarts** d'aide : paragraphes en **italique + bleu** (`0070C0`).
- **R3** — **Nettoyer les caractères parasites** : puces de police symbole (`•▪●◦‣·` → « - »),
  espaces insécables/multiples, caractères de contrôle. **Pas** la pagination ni les
  mentions de confidentialité.
- **R4** — **« Non concerné »** si la section est absente.
- **R5** — **« Principes et décisions » toujours vide** (`kind=empty`), quel que soit le contenu.
- **R6** — **« Informations supplémentaires » / « Assets mainframe » optionnel**
  (absence non pénalisée).
- **R7** — **Ne jamais reformuler** le contenu.
- **R8** — Doutes → **« Points à vérifier »**.

**Taxonomie de signalement (8 types)** : `section_introuvable`, `mauvaise_section`,
`encart_repris`, `contenu_ecarte`, `lien_errone`, `compose_mal_assemble`,
`identification_erronee`, `parasite_residuel`.

## 7. API du serveur

**Endpoints** (HTTP 127.0.0.1) :

- **GET** : `/api/health`, `/api/metrics`, `/api/config`, `/api/rules`,
  `/api/calibration`, `/api/history`
- **POST** : `/api/process-dex`, `/api/validate`, `/api/replay`, `/api/config`,
  `/api/rules/reload`, `/api/calibration/proposer`
- **OPTIONS** : préflight CORS

**`process-dex`** accepte `{path}` **ou** `{filename, content_base64}` et renvoie un
objet enrichi dont les clés sont : `identification`, `champs`, `ordre_champs`, `document`,
`schema`, `markdown`, `gabarit_signature`, `rules_version`, `points_a_verifier`,
`seuil_routage`, `calibration_active`.

**Champ enrichi** (clés) : `ambigu`, `candidats`, `confiance`, `content`, `kind`,
`label`, `raison`, `route_attention`, `score_brut`, `selection_moteur`, `source_spans`,
`suggestions`, `tab`, `titre_repere`.

**Enregistrement d'historique** (1 par `process-dex`, dans `analyses.jsonl`) :
`dex_id`, **`nom` = nom de fichier complet**, `gabarit_signature`, `rules_version`,
`n_champs`, **`n_abouti`** (champs repérés = `source_spans` non vide), `conf`
(`elevee`/`moyenne`/`faible`/`vide`), `n_ambigu`, `n_route_attention`, `n_points`.

**Règles** (`DEFAULT_RULES`, version **1.0.0**) : `confiance` (base_text 0.9 / base_link 0.8 /
base_compose 0.75 ; malus_match_faible 0.1 ; malus_contenu_court 0.15 ; seuil_contenu_court 15 ;
optionnel_absent 0.85 ; requis_absent 0.3 ; plafond_si_signale 0.4 ; malus_ambiguite 0.20),
`marge_ambiguite` 0.15, `max_candidats` 5.

**CLI** : `--host`, `--port`, `--data-dir`, `--front`, `--config`, `--rules`, `--allow-origin`.

## 8. Configuration (`DEFAULT_CONFIG`, 10 clés)

| Clé | Rôle |
|---|---|
| `cible_ece` (0.1) | Cible d'erreur de calibration (ECE). |
| `alerte_taux_acceptation_min` (0.85) | Seuil d'alerte du taux d'acceptation. |
| `alerte_duree_dex_max_s` (720) | Seuil d'alerte de durée par DEX. |
| `k_promotion_fixture` (5) | Seuil de promotion d'un cas en fixture. |
| `fenetre_glissante_n` (200) | Fenêtre glissante des métriques. |
| `pastille_confiance_couleur_champ` (bool, défaut **vrai**) | Pastille de confiance colorée selon la couleur du champ (texte contrasté calculé par luminance WCAG) ; sinon vert/orange/rouge sémantique. |
| `ordre_cartes` (`{}`) | Surcharge de **l'ordre d'affichage** des cartes (Dictionnaire). |
| `intitules_cartes` (`{}`) | Surcharges **catégorie/intitulé** par champ (`{key:{label,tab}}`). |
| `titres_proposes` (`{}`) | Surcharges **titre proposé** (`{key:{titre_origine:surcharge}}`). |
| `email` | `{adresses, objet_prefixe, contenu_prefixe, suffixe}` pour le signalement. |

`POST /api/config` applique une **whitelist** + coercitions de types ; les entrées invalides
sont ignorées.

## 9. Front — 5 onglets et fonctionnalités

Ordre de navigation : **Reprise assistée · Dictionnaire · Tableau de bord · Historique ·
Administration**.

**Reprise assistée** — Cœur de l'outil.
- Import : **fichier** `.docx`, **glisser-déposer**, ou **dossier (traitement par lot)**
  via bouton `webkitdirectory` (`surDossier`) : traite chaque `.docx` séquentiellement,
  progression `n/total — ✓/échecs`, charge le dernier, alimente l'Historique.
- Une **carte par champ** : libellé préfixé du N°, badge de catégorie, **pastille de
  confiance**, contenu repéré, boutons de **copie**, repli des cartes « Non concerné ».
- **Désambiguïsation** : badge ⚐, **radiogroup accessible** « Confirmer la section ».
- **Signalement par e-mail** : corps texte exhaustif de la carte + bouton **« Copier la
  fiche en HTML »** (pour Outlook) ; `mailto:` reste en texte (RFC 6068) ; modale
  `role=dialog`, fermeture Échap.

**Dictionnaire** — Tableau **triable**, **une ligne par suggestion**.
- Colonnes : **Ordre** (éditable → `ordre_cartes`), **N°**, **Catégorie** (éditable),
  **Intitulé** (éditable), **Repérage**, **Titre proposé** (**éditable**, surcharge
  `titres_proposes` indexée par titre d'origine), **Proximité**, **Action** (Appliquer/Voir).
- Catégorie/Intitulé s'appliquent **aussi aux cartes** de la Reprise ; les surcharges
  **persistent**. Depuis la Reprise, cliquer une suggestion amène à sa ligne.

**Tableau de bord** — Métriques (config `tableau_de_bord.config.json`).

**Historique** — **Un seul tableau triable** « Détail des DEX analysés ».
- Colonnes : Heure, **Nom** (fichier complet), DEX, Gabarit, **Abouti**, élevée, moyenne,
  faible, (vide), ⚐ ambigus, points, règles. Tri par défaut : Heure décroissante.
- **Compteurs cliquables sauf « 0 »** (Abouti / élevée / moyenne / faible / (vide) /
  ⚐ ambigus) : le clic **ouvre le DEX de la ligne** (`ouvrirEtFiltrer` via les sources de
  session) puis, en Reprise, **ne déplie que les cartes du groupe** de la colonne
  (`filtrerGroupe` ; « abouti » = repéré, « élevée » ≥0,8, « moyenne » [0,5–0,8[,
  « faible » <0,5, « vide » = sans confiance, « ambigus »). « points » n'est pas un groupe
  de cartes → non cliquable.

**Administration** — Réglages : recharge des règles, bascule
`pastille_confiance_couleur_champ`, e-mail, etc.

## 10. Jeu de tests — fourni séparément

Pour garder ce document **exempt de données de test**, le détail (cas, sorties attendues,
assertions) est **packagé à part** dans l'installeur **`dex_tests_install.cmd`** :

- **24 DEX** de test synthétiques + **4 DEX auto-référentiels** (l'application décrite
  elle-même), avec leurs **résultats attendus** observés sur exécution réelle ;
- le **plan** `TEST_PLAN.md`, la **recette** `RECETTE_FRONT.md`, les **générateurs**
  (`generer_dex_tests.py`, `generer_dex_self.py`) et les **outils de test**.

Exécution par lot : onglet **Reprise** → bouton **dossier** → `dex_tests/` puis
`dex_tests_self/` → confronter à l'**Historique** et aux fichiers `_RESULTATS_ATTENDUS*.md`.

## 11. Comment lancer / tester

**Démarrer le serveur + servir le front :**
```
PYTHONPATH=/mnt/user-data/uploads \
python3 dex_castin_server.py --port 8765 --data-dir ./.data --front front
# puis ouvrir http://127.0.0.1:8765/
```

**Tests automatisés (doivent passer avant de déclarer « terminé ») :**
```
PYTHONPATH=/mnt/user-data/uploads python3 outils/smoke_serveur.py     # bout-en-bout
PYTHONPATH=/mnt/user-data/uploads python3 outils/test_candidats.py    # candidats/ambiguïté
node --check <(extraction du <script> de front/index.html)            # syntaxe JS du front
```

**Jeu de tests par lot :** onglet **Reprise** → bouton **« …ou un dossier de DEX
(traitement par lot) »** → sélectionner `dex_tests/` → onglet **Historique** → comparer au
tableau §10 (et `TEST_PLAN.md`).

**Régénérer le jeu de tests :** `python3 generer_dex_tests.py`.

## 12. Conventions de travail (impératives)

- Répondre **en français**, registre **expert**, **concis**, **honnête/calibré** (pas de
  flagornerie ; pousser back de façon constructive).
- **Vérifier l'état réel sur disque** plutôt que se fier aux résumés.
- **Zéro dépendance** strictement (stdlib + Vue global).
- **Moteur read-only** ; **R7** (jamais reformuler).
- Code **production-grade**.
- **Source unique du serveur** : travailler dans un dossier inscriptible puis **recopier
  vers `outputs/`** ; vérifier `diff -q` identiques. Front édité **directement** dans
  `outputs/front/index.html`. Régénérer `tableau_de_bord.config.json` après tout ajout de
  clé de config.
- Livrables dans `/mnt/user-data/outputs/` ; **smoke + tests doivent passer** avant de
  déclarer terminé.
- **Axiome 7E** = axiome **génératif**, **pas** un cycle procédural à 7 phases.

## 13. Limites connues & pistes futures (différées)

**Limite assumée — ré-ouverture depuis l'Historique** : elle s'appuie sur les fichiers
**importés dans la session courante** (le navigateur n'expose pas les chemins absolus, y
compris via le sélecteur de dossier). Une ligne ancienne sans source en session affiche un
message invitant à re-sélectionner le dossier. Lever cette limite supposerait de **stocker
le `.docx`** (ou un chemin réutilisable côté serveur).

**Pistes ouvertes** :
- Export **`_ANNOTE.docx`** (DEX annoté des repérages/confiances).
- Génération **`.eml`** (HTML local sans SMTP) en alternative au copier-coller HTML.
- Raccourci **« Appliquer »** direct sur la puce de la Reprise.
- **Persistance du chemin source** pour ré-ouverture **cross-session**.
- **Lexique par famille de gabarit** ; **override de section primaire** pour les `merge`.

## 14. État actuel

**Opérationnel.** Dernières évolutions livrées et vérifiées : nom de fichier complet dans
l'Historique ; « Titre proposé » éditable et persistant ; compteurs d'Historique cliquables
sauf « 0 » qui **ouvrent le DEX de la ligne** puis **déplient le seul groupe** choisi ;
**traitement par lot** d'un dossier via bouton de sélection ; **24 DEX de test** + plan de
tests fondé sur exécution réelle. Serveur compile ; smoke + candidats verts ; front
`node --check` OK ; documentation à jour (`README_SERVEUR`, `ENDPOINTS`, `RECETTE_FRONT`,
`TEST_PLAN`).
#@FILE_END
#@FILE_TXT:README.md
# Reprise DEX → CAST'IN — outil de poste (assisté, boucle de 2e ordre)

Outil **mono-poste, zéro-dépendance** d'aide à la reprise des Dossiers d'Exploitation
(DEX) Word vers CAST'IN. Aucune API CAST'IN n'est utilisée : le collage final reste
**manuel**, guidé par une **copie en réalité augmentée** (cadres / étiquettes /
flèches par champ) et un **contenu prêt à coller** par champ. L'outil **ne devine
jamais** et **ne reformule jamais** le contenu métier (règles 7 et 8).

## Arborescence

```
<racine>/
  dex_castin_common.py            moteur de reprise (inchangé, validé par le harness)
  dex_castin_cli.py               reprise par lot, en ligne de commande
  dex_castin_server.py            service back local 127.0.0.1 + boucle de 2e ordre
  dex_castin_calibration.py       régression isotonique (PAV) + ECE/Brier (stdlib)
  regles.candidate.exemple.json   EXEMPLE de candidat (structure à inspecter ; non promouvable tel quel)
  README.md                       ce fichier
  README_SERVEUR.md               détail des endpoints du back
  front/
    index.html                    front Vue (sans build) — reprise assistée + dashboard
    vue.global.prod.js            Vue 3 vendoré localement (aucun appel CDN au runtime)
  donnees/                        créé au 1er lancement du back
    regles.json                   overlay VERSIONNÉ (lexique, poids, calibration, seuil routage)
    regles.candidate.json         candidat de calibration GÉNÉRÉ AU RUNTIME (/api/calibration/proposer ou outils/calibrer.py)
    tableau_de_bord.config.json   paramètres AJUSTABLES front (cible ECE, seuils…)
    events.jsonl                  journal des validations humaines (local)
    runs/                         instantanés de runs (pour le replay, local)
  outils/
    smoke_serveur.py              test/démonstration de bout en bout (stdlib)
    calibrer.py                   calibrateur isotonique hors-ligne -> candidat versionné (stdlib)
    calibration_check.py          gate hors-échantillon de la calibration (stdlib)
  tests/
    DEX_S20001_Nominal.docx       DEX de démonstration
    run_tests.py, docx_builder.py, fixtures/   (ton harness existant)
```

Les **trois `.py` sont côte à côte** (le back importe le moteur). Les deux JSON de
`donnees/` sont **créés automatiquement** ; tu n'as pas à les déposer (mais tu peux y
placer une copie canonique si tu veux des valeurs de départ précises).

## Démarrage

```bash
# 1) reprise par lot (existant)
python dex_castin_cli.py "DEX_S12345_MaSolution.docx" -o ./sorties --json

# 2) poste assisté (back + front servi sur 127.0.0.1)
python dex_castin_server.py --front ./front
#   -> ouvrir http://127.0.0.1:8765

# 3) démonstration / non-régression du back
python outils/smoke_serveur.py
```

Prérequis : Python 3.10+. Aucune installation tierce. Le service écoute sur
`127.0.0.1` par défaut — **ne pas exposer hors du poste**.

## Boucle d'amélioration de 2e ordre (résumé)

L'annexe `ANNEXE_Boucle_2e_ordre.md` du cahier des charges fait foi. En pratique :

1. **Capture** (par DEX, dans le front) : pour chaque champ, l'opérateur **Copie**,
   puis **Accepte** ou **Signale** (type d'erreur). Chaque verdict est envoyé au back
   avec la confiance affichée, la signature de gabarit et le rôle (rodage/production).
2. **Mesure** (onglet *Tableau de bord*) : acceptation par champ, **Brier**, **ECE**
   vs cible, débit, alertes, diagramme de fiabilité.
3. **Patch** : éditer `donnees/regles.json` (enrichir `extra_keywords` d'un champ,
   ajuster les poids de confiance) **et incrémenter `version`** ; ou, pour la
   **calibration**, *Analyser la calibration* puis *Écrire regles.candidate.json*
   (carte isotonique gelée, version incrémentée).
4. **Gate** : `python tests/run_tests.py` (contenu, ≥ 95 %, zéro régression hors
   tests 03/04) **et**, pour une carte de calibration,
   `python outils/calibration_check.py` (ECE hors-échantillon ne se dégrade pas)
   **avant** publication.
5. **Recharger + Replay** (onglet *Tableau de bord*) : promouvoir
   `regles.candidate.json` → `regles.json` si calibration, recharger les règles,
   puis rejouer le DEX courant pour **mesurer l'amélioration** (champs modifiés,
   points résolus/apparus, version avant→après).

### Calibration isotonique + routage par seuil (versionnés, gatés)

Pour rendre la confiance *fiable* et router l'attention de façon optimale :

```bash
python outils/calibrer.py                 # ajuste la carte score_brut→acceptation (PAV) -> candidat
python outils/calibrer.py --verifier --rules donnees/regles.candidate.json   # gate (monotonie + ECE)
# copier le candidat validé vers donnees/regles.json, fixer "seuil_routage" (>0), puis recharger
```

Défaut **neutre** (calibration inactive, seuil 0 → identique au moteur). Une fois
active, la calibration et le seuil sont des **artefacts versionnés gatés** : la
calibration ne touche pas l'extraction (le harness moteur reste vert) ; le chargement
**refuse toute carte non monotone**. Le tableau de bord affiche l'ECE **brut → calibré**.

Le **contenu reste déterministe** : `f(DEX, version_règles)`. La confiance et la
calibration sont *advisory* (elles n'altèrent aucun contenu). La **période de rodage**
(développeur confirmé sur les premiers DEX) sert à produire des **labels de validation
de haute qualité** qui amorcent la calibration — d'où le champ `operateur_role`.

## Frontières (cohérence cahier des charges)

- **Aucune saisie automatique dans CAST'IN** (pas d'API), **aucune RPA** : collage
  manuel depuis la copie augmentée.
- **Confidentialité** : aucune donnée DEX ne quitte le poste ; copies temporaires
  d'upload supprimées après traitement ; journal et instantanés **locaux**. Seule une
  télémétrie **sans contenu** (annexe A.3.2) serait candidate à une mutualisation
  inter-postes — non incluse (phase 2).
- **Accessibilité** : front conçu pour RGAA / WCAG (structure sémantique, navigation
  clavier, contrastes, équivalents textuels du graphique, régions `aria-live`),
  tokens d'inspiration DSFR (palette bleu France).

## Points restants connus

- Export `.docx _ANNOTE` (trace portable hors-front) non produit : l'AR vit dans le
  front. À ajouter si une trace `.docx` surlignée est exigée.
- Overlay de règles appliqué par extension additive de `CASTIN_FIELDS["keywords"]` au
  démarrage du back ; forme canonique future : `process_dex(..., fields=...)` côté moteur.
- Détail des endpoints : voir `README_SERVEUR.md`.
#@FILE_END
#@FILE_TXT:README_SERVEUR.md
# Service back local — DEX → CAST'IN (boucle de 2e ordre)

`dex_castin_server.py` expose le moteur `dex_castin_common` à un front (VueJS) sur
`127.0.0.1` et porte la **boucle d'amélioration de 2e ordre** décrite dans l'annexe
du cahier des charges. **Zéro dépendance** (bibliothèque standard Python 3.10+).

## Principe

Le **moteur n'est pas modifié** : il reste déterministe et validable par le harness
à l'identique. La **confiance par champ** et les **spans sources** (quel paragraphe
va dans quel champ) sont **dérivés dans la couche serveur**, en rejouant la même
logique de repérage que le moteur (règle 1). Le **contenu n'est jamais reformulé**
(règle 7) : la boucle agit sur le *repérage / la classification / la calibration*,
jamais sur le contenu métier.

Seul effet de bord sur le moteur : l'application **additive** de l'overlay de
mots-clés `regles.json` sur `dex.CASTIN_FIELDS["keywords"]` au démarrage — c'est le
**levier n°1** de la boucle (enrichissement de lexique). Cet overlay est versionné ;
tout patch doit **re-passer le harness** avant publication.

## Démarrage

```bash
python dex_castin_server.py
python dex_castin_server.py --host 127.0.0.1 --port 8765 --data-dir ./donnees
python dex_castin_server.py --front ./front/dist      # sert aussi la SPA bâtie
```

Au premier lancement, `regles.json` et `tableau_de_bord.config.json` sont créés dans
`--data-dir` s'ils sont absents (transparence). Le service écoute **uniquement sur
127.0.0.1** par défaut — ne pas exposer hors du poste.

## Endpoints

| Méthode | Route | Rôle |
| --- | --- | --- |
| GET | `/api/health` | État + version des règles chargées |
| POST | `/api/process-dex` | Traite un DEX, renvoie le résultat **enrichi** (voir ci-dessous) |
| POST | `/api/validate` | Enregistre un événement de validation humaine (journal local) |
| GET | `/api/metrics` | Acceptation/champ, **Brier**, **ECE**, fiabilité, débit, alertes |
| POST | `/api/replay` | Rejoue un DEX sous les règles courantes et compare au dernier instantané |
| GET / POST | `/api/config` | Lit / met à jour les paramètres **ajustables front** (cible ECE, seuils…) |
| GET | `/api/rules` | Version + overlay de règles courant |
| POST | `/api/rules/reload` | Recharge `regles.json` après un patch (sans redémarrer) |
| GET | `/api/calibration` | **Ajuste** une carte isotonique candidate (global + par champ), chiffre l'ECE brut → estimé |
| POST | `/api/calibration/proposer` | Écrit `regles.candidate.json` (carte gelée, version incrémentée) — **jamais auto-active** |
| GET | `/api/history` | Historique des DEX analysés (récents d'abord) + agrégat **par heure de passage** |

### Calibration isotonique + routage (VERSIONNÉS)

La **confiance brute** est un prior heuristique déterministe. La **calibration** apprend,
sur les verdicts (`accepté=1 / signalé=0`), une carte monotone *score brut → acceptation*
(régression isotonique PAV, `dex_castin_calibration.py`). Cycle :

1. `GET /api/calibration` ajuste une carte **candidate** et estime le gain d'ECE.
2. `POST /api/calibration/proposer` écrit `donnees/regles.candidate.json` (carte gelée,
   `version` incrémentée, `calibration.actif=true`). **Rien n'est activé.**
3. **Gate** : `python outils/calibration_check.py --events donnees/events.jsonl` valide
   que l'ECE **hors-échantillon** ne se dégrade pas (verdict GO/NO-GO), et le harness
   moteur reste vert.
4. Promotion : copier `regles.candidate.json` → `regles.json`, puis `POST /api/rules/reload`.

Une fois active, la carte est **versionnée dans `regles.json`** : la confiance affichée
et le routage redeviennent reproductibles (`f(DEX, version_règles)`). Le **routage** par
`seuil_routage` (versionné) porte à l'attention un champ *trouvé* mais de confiance
calibrée < seuil (`route_attention` par champ + entrée « à vérifier »), **sans toucher**
au `points_a_verifier` du moteur — donc le **harness moteur reste valide**. `valider_regles`
refuse au chargement toute carte non monotone (sécurité).

### `POST /api/process-dex`

Entrée — soit un **chemin local** (préféré, rien n'est copié), soit un **upload base64**
(copie temporaire supprimée après traitement, ≤ 50 Mo) :

```json
{ "path": "C:\\dossiers\\DEX_S12345_MaSolution.docx" }
{ "filename": "DEX_S12345.docx", "content_base64": "<...>" }
```

Sortie (extrait) — le front consomme `champs[*].source_spans` + `document[]` pour
l'overlay AR, `confiance`/`raison` pour la calibration, `suggestions` pour les
corrections proposées :

```json
{
  "rules_version": "1.0.0",
  "gabarit_signature": "0b15a9d4",
  "identification": { "solution": "S20001", "auteur": "...", "responsable": "..." },
  "points_a_verifier": [],
  "ordre_champs": ["lien_dossier_archi", "schema_applicatif", "..."],
  "champs": {
    "supervision": {
      "label": "Supervision", "tab": "DEX", "kind": "text",
      "content": "Supervisée par Centreon, ...",
      "score_brut": 0.9, "confiance": 0.9, "raison": "section repérée.",
      "route_attention": false,
      "ambigu": false, "candidats": [ ... ], "selection_moteur": 42,
      "titre_repere": "6 Supervision",
      "source_spans": [[start, end]],
      "suggestions": []
    }
  },
  "document": [ { "index": 0, "type": "paragraph", "text": "...",
                 "is_heading": false, "level": null, "is_explanatory": false } ],
  "markdown": "## 1. IDENTIFICATION\n..."
}
```

### Désambiguïsation multi-candidats (par champ)

Attaque la classe d'erreur **silencieuse** `mauvaise_section` : le moteur retient la
**première** section dont le titre matche les mots-clés ; si ce n'est pas la bonne,
l'opérateur risque d'accepter du contenu plausible issu de la mauvaise section.

Le serveur **dérive** (sans toucher au moteur) la liste des sections candidates :
même règle de matching que le moteur (`_heading_matches`), contenu d'un candidat
extrait par `section_text`/`section_links` — donc **identique** à ce que le moteur
produirait si cette section était la première. Pour chaque champ :

- `candidats[]` : sections matchantes triées par **score de proximité** décroissant
  (`difflib` + bonus de phrase, déterministe), chacune avec
  `index, titre, niveau, score, phrase, span, extrait` ; les champs `text` à ≥ 2
  candidats portent en plus le `contenu` complet (bascule d'affichage sans aller-retour).
- `selection_moteur` : index réellement retenu par le moteur (1er match, ordre
  document) = **défaut appliqué**.
- `ambigu` (**champs `text` uniquement**) : `true` si le top-1 et le top-2 sont plus
  proches que `marge_ambiguite`, **ou** si le mieux scoré n'est pas la sélection
  moteur (désaccord = risque de mauvaise section). Effets : malus de confiance
  (`confiance.malus_ambiguite`) + entrée dans `points_a_verifier`. Les champs
  `merge`/`link` matchent par nature plusieurs sections (agrégation **voulue**) :
  candidats exposés en information, jamais marqués `ambigu`.

Côté front : un sélecteur (radiogroup accessible) permet de **choisir** la section
pour les champs `text` ambigus ; l'overlay AR et le contenu à coller suivent le
choix. Choisir une autre section que celle du moteur est journalisé via
`/api/validate` comme **`signale` / `mauvaise_section`** avec une `correction`
`{section_choisie, section_moteur}` — donc **outcome 0** pour la calibration (l'auto-
sélection ayant été corrigée, elle était fausse), ce qui alimente proprement la boucle.

Le **choix de l'opérateur est un signal runtime** (journalisé), il ne mute pas le
pipeline : l'ensemble et l'ordre des candidats restent reproductibles à version de
règles donnée. Conforme à R1 (repérage par **nom** ; le numéro de chapitre du `hint`
ne sert jamais de filtre). Paramètres **versionnés** : `marge_ambiguite` (0.15),
`max_candidats` (5), `confiance.malus_ambiguite` (0.20).

### `POST /api/validate` (annexe A.3.1)

```json
{
  "dex_id": "S20001", "onglet": "dex", "champ": "log",
  "confiance": 0.9, "score_brut": 0.9, "verdict": "signale",
  "type_signalement": "mauvaise_section",
  "correction": { "section_attendue": "Diagnostique" },
  "gabarit_signature": "0b15a9d4",
  "duree_traitement_s": 600,
  "operateur_role": "rodage"
}
```

`verdict` ∈ `accepte | signale`. `type_signalement` suit la taxonomie de l'annexe
(`section_introuvable`, `mauvaise_section`, `encart_repris`, `contenu_ecarte`,
`lien_errone`, `compose_mal_assemble`, `identification_erronee`, `parasite_residuel`).
`operateur_role` (`rodage | production`) segmente les corrections de **rodage**
(développeur confirmé, labels de qualité) du régime courant. **`score_brut`** est le
score heuristique *avant* calibration : c'est le signal STABLE sur lequel on (re)calibre
(la `confiance` calibrée peut, elle, changer d'une version à l'autre).

### `GET /api/metrics`

```json
{
  "n_evenements": 5, "n_calibrables": 5,
  "brier_global": 0.17, "ece": 0.1, "cible_ece": 0.1,
  "brier_brut": 0.17, "ece_brut": 0.1, "amelioration_ece": 0.0,
  "fiabilite": [ { "bin": [0.9, 1.0], "n": 5, "confiance": 0.9, "acceptation": 0.8 } ],
  "par_champ": { "log": { "n": 1, "acceptation": 0.0, "brier": 0.81 } },
  "debit": { "n": 5, "median_s": 600.0 },
  "calibration": { "actif": false, "rules_version": "1.0.0", "seuil_routage": 0.0 },
  "alertes": []
}
```

Définitions : `o = 1` si `accepte`, `0` si `signale` ; `p` = confiance affichée.
`Brier = moyenne((p − o)²)` ; `ECE = Σ (|Bₘ|/N)·|acc(Bₘ) − conf(Bₘ)|` sur 10 buckets.
`ece` est calculé sur la confiance **calibrée**, `ece_brut` sur le **score brut** ;
`amelioration_ece = ece_brut − ece` (> 0 : la calibration a réduit l'ECE). Les champs
sans confiance (ex. « Principes et décisions ») sont **exclus** du calcul.

## Protocole de boucle (capture-continue → application-versionnée gatée par le harness)

1. **Capture** (continue, par DEX) : chaque verdict → `POST /api/validate`. La sortie
   d'un DEX reste `f(DEX, version_règles)` ; la confiance est advisory.
2. **Mesure** : `GET /api/metrics` (Brier/ECE/acceptation) — tableau de bord.
3. **Patch** : éditer `regles.json` (ajouter un mot-clé sous `extra_keywords`,
   ou ajuster les poids `confiance`) **et incrémenter `version`**.
4. **Gate harness** : `python tests/run_tests.py` doit rester ≥ 95 % (zéro régression
   hors tests 03/04) avant publication.
5. **Recharge + replay** : `POST /api/rules/reload`, puis `POST /api/replay` sur des
   DEX témoins → mesure l'amélioration (champs modifiés, points résolus/apparus).

### Calibration isotonique + routage par seuil (versionnés, gatés)

`regles.json` porte aussi `seuil_routage` et un bloc `calibration` — **défaut neutre**
(seuil 0, calibration inactive → identique au moteur). Cycle :

1. **Ajuster** : `python outils/calibrer.py` lit `events.jsonl` et ajuste une carte
   isotonique (PAV) `score_brut → acceptation`, globale et par champ (si volume ≥
   `min_n_par_champ`). Produit un **candidat** `regles.candidate.json` (version ++).
2. **Gater** : harness moteur (inchangé — la calibration ne touche pas l'extraction),
   puis `python outils/calibrer.py --verifier --rules regles.candidate.json` (refuse une
   carte **non monotone** ou qui **dégrade l'ECE** en échantillon).
3. **Activer** : copier le candidat vers `regles.json`, fixer `seuil_routage` (> 0),
   `POST /api/rules/reload`. Un champ TROUVÉ mais de **confiance calibrée < seuil** est
   alors porté en « Points à vérifier » (champ `route_attention` dans la sortie).

Le chargement applique un **gate de sûreté** : toute carte non monotone est refusée et
la calibration désactivée (voir `avertissements` dans la réponse de `rules/reload`).

Démonstration de bout en bout : `python outils/smoke_serveur.py` (stdlib, sur le DEX
de test réel ; exerce health/process/validate/metrics/replay, le calibrateur, le
routage et le gate de monotonie).

## Données et confidentialité

| Fichier | Contenu | Portée |
| --- | --- | --- |
| `donnees/events.jsonl` | Journal des validations (peut référencer du contenu via `correction`) | **Local** |
| `donnees/analyses.jsonl` | Historique des analyses (1 ligne/passage : compteurs de confiance, points — **pas de contenu**) | **Local** |
| `donnees/runs/<dex>/…json` | Instantanés de runs (contiennent le contenu extrait) | **Local** |
| `donnees/regles.json` | Overlay versionné (lexique + poids confiance) | Local / partageable |
| `donnees/tableau_de_bord.config.json` | Paramètres ajustables front | Local |

Le service écoute sur `127.0.0.1` ; les copies temporaires d'upload sont supprimées
après traitement. **Aucune donnée DEX ne quitte le poste.** Exception explicite côté
front : le bouton **« Signaler »** (et la confirmation d'une section corrigée) ouvre,
**en plus** de la journalisation locale, un **brouillon d'e-mail éditable** (objet,
destinataires, corps) que l'opérateur **valide avant l'envoi** ; le corps reprend
**toutes les informations de la carte** (métadonnées + **contenu** + suggestions +
points à vérifier). Un bouton **« Copier la fiche en HTML »** met une version mise en
forme dans le presse-papier (à coller dans Outlook) — le `mailto:` lui-même ne
transporte que du texte. Les valeurs par défaut (adresse(s) séparées par `;`,
préfixe d'objet, intro, salutation) se règlent dans l'**onglet Administration** et sont
persistées dans `tableau_de_bord.config.json` (clé `email`). C'est une action
déclenchée par l'opérateur (le client de messagerie s'ouvre, rien n'est envoyé
automatiquement), à garder à l'esprit pour l'homologation.
La seule projection candidate à une mutualisation inter-postes reste la télémétrie
**sans contenu** (`signal_agrege` de l'annexe A.3.2) — non incluse dans ce service (phase 2).

## Paramètres : ajustables front vs versionnés (rappel annexe A.3.4)

- **Ajustables front** (`tableau_de_bord.config.json`) — ne changent **aucune** sortie
  de DEX : `cible_ece`, seuils d'alerte, `k_promotion_fixture`, `fenetre_glissante_n`,
  le bloc `email` (valeurs par défaut du signalement par e-mail),
  `pastille_confiance_couleur_champ` (affichage de la pastille de confiance),
  `ordre_cartes` (ordre d'affichage des cartes ; vide = ordre canonique) et
  `intitules_cartes` (surcharges locales de **catégorie**/**intitulé** par champ) et
  `titres_proposes` (surcharges locales de **titre proposé**, indexées par titre
  d'origine), réglés dans les onglets Administration et Dictionnaire.
- **Versionnés et gatés** (`regles.json`) : lexique (`extra_keywords`), poids de
  confiance. Règle de partage : *si le paramètre peut changer ce qui est collé dans
  CAST'IN ou la liste des points à vérifier → versionné ; sinon → front.*

## Points restants connus

- **Copie annotée `_ANNOTE.docx`** : non produite par ce service. Le front rend l'AR
  via overlay SVG (cadres/étiquettes/flèches) à partir de `source_spans` + `document`.
  L'export `.docx` annoté (fond `<w:shd>` + bordures) reste à ajouter si une trace
  portable hors-front est exigée.
- **Externalisation profonde des règles** : seul l'enrichissement *additif* du lexique
  passe par `regles.json`. Sortir tout `CASTIN_FIELDS` (kinds, patterns, seuils de
  l'heuristique règle 2) en données est une étape ultérieure ; idéalement le moteur
  exposerait un `process_dex(..., fields=...)` pour éviter l'overlay par mutation.
- **Routage par seuil de confiance** : implémenté et **versionné** (`seuil_routage`,
  défaut 0). Au-delà du moteur (section requise introuvable), un champ trouvé mais de
  confiance calibrée trop basse est désormais routé en « Points à vérifier ».
- **Désambiguïsation multi-candidats** : **livrée** (champs `text`). Surface les
  sections candidates, signale les cas ambigus (near-tie ou désaccord moteur/score) et
  permet de choisir la bonne section côté front (journalisé `mauvaise_section`). Restes
  différés : override pour la **section primaire d'un `merge`** (le composé utilise
  plusieurs sections — choix d'une primaire alternative non implémenté) et promotion
  d'une **suggestion non-matchante** au rang de section choisie (couvert pour l'instant
  par le signalement `section_introuvable`).

## État et suite

Le front VueJS accessible est livré (`front/index.html`) : **cinq onglets**
(Reprise assistée, **Dictionnaire**, Tableau de bord, Historique, Administration).
Onglet Dictionnaire (**tableau triable** — une ligne par suggestion : **ordre
d'affichage** éditable des cartes, **N°**, **catégorie** et **intitulé éditables**
(surcharges appliquées aux cartes), repérage, **titre proposé éditable**, **proximité**,
avec « Appliquer » ; chaque en-tête triable ; cliquer une suggestion en Reprise amène à
la ligne) ; Tableau de bord (métriques + ECE
brut→calibré + alertes) ; onglet Historique (**un seul tableau triable** « Détail des DEX analysés », colonnes
**Nom** — nom de fichier complet — et **Abouti** — nombre de repérages positifs —
comprises ; les compteurs **Abouti / élevée / moyenne / faible / (vide) / ⚐ ambigus**
sont **cliquables** pour ne déplier en Reprise que les cartes du groupe, sur le DEX
courant) ; onglet Administration (valeurs par défaut du signalement par e-mail +
**bascule** « pastille de confiance en couleur du champ », on par défaut). Panneau par
champ : cartes **préfixées de leur numéro** et **ordonnées** selon le Dictionnaire,
**rétractables** (les « Non concerné » repliés par défaut sauf ambiguïté/attention),
avec Copier, confiance, **suggestions renvoyant au Dictionnaire**, **sélecteur de
section pour les champs `text` ambigus**, signalement typé ouvrant un **brouillon
e-mail éditable validé avant envoi** (corps = toutes les infos de la carte, + copie
HTML) ; overlay AR (« Document annoté », tous les surlignages affichés par défaut,
couleur de pastille = légende = cadre) et récapitulatif de replay. La calibration
isotonique, le routage par seuil et la désambiguïsation multi-candidats sont en place.

Pistes ouvertes : export `_ANNOTE.docx`, `process_dex(..., fields=...)` côté moteur,
calibration par famille de gabarit, override de section primaire pour les champs `merge`.
#@FILE_END
#@FILE_TXT:ENDPOINTS.md
# Endpoints — back local « Reprise DEX → CAST'IN »

Service HTTP **mono-poste** : `http://127.0.0.1:<port>/`. Échanges **JSON UTF-8**,
CORS restreint (`GET, POST, OPTIONS`), upload ≤ **50 Mo**, **aucun appel sortant**
(Vue est vendoré en local). Toutes les sorties sont déterministes : à version de
règles donnée, un même DEX produit le même résultat.

---

## GET

| Route | Paramètres | Réponse — clés principales |
|------|------------|----------------------------|
| `/api/health` | — | `status`, `schema`, `rules_version`, `n_champs`, `horodatage` |
| `/api/metrics` | — | `n_evenements`, `n_calibrables`, `brier_global`, `ece`, `brier_brut`, `ece_brut`, `amelioration_ece`, `cible_ece`, `fiabilite[]`, `par_champ{}`, `debit{}`, `alertes[]`, `calibration{actif, rules_version, seuil_routage}` |
| `/api/config` | — | paramètres ajustables : `cible_ece`, `alerte_taux_acceptation_min`, `alerte_duree_dex_max_s`, `k_promotion_fixture`, `fenetre_glissante_n`, `pastille_confiance_couleur_champ`, `ordre_cartes{}`, `intitules_cartes{}`, `titres_proposes{}`, `email{adresses, objet_prefixe, contenu_prefixe, suffixe}` |
| `/api/rules` | — | `version`, `extra_keywords`, `confiance`, `seuil_routage`, `calibration` |
| `/api/calibration` | — | `suffisant`, `n` ; si suffisant : `ece_brut`, `ece_estime`, `gain`, `par_defaut`, `par_champ`, `champs_calibres`, `version_proposee`, `patch_regles` |
| `/api/history` | — | `total`, `analyses[]` (récentes d'abord : `horodatage, dex_id, nom, gabarit_signature, rules_version, n_champs, n_abouti, conf{elevee,moyenne,faible,vide}, n_ambigu, n_route_attention, n_points`), `par_heure[]` (agrégat horaire, non affiché par le front) |
| `/` *(statique)* | chemin de fichier | sert `front/index.html` + assets (repli SPA) |

---

## POST

| Route | Corps attendu | Réponse — clés principales |
|------|---------------|----------------------------|
| `/api/process-dex` | `{path}` **ou** `{filename, content_base64}` | résultat **enrichi** : `identification`, `gabarit_signature`, `ordre_champs`, `champs{key:{label, tab, kind, content, score_brut, confiance, route_attention, ambigu, candidats[], selection_moteur, raison, titre_repere, source_spans, suggestions}}`, `document[]`, `points_a_verifier[]`, `markdown`, `rules_version`, `calibration_active`, `seuil_routage` |
| `/api/validate` | `{dex_id, onglet, champ, gabarit_signature, score_brut, confiance, verdict, type_signalement, correction, duree_traitement_s, operateur_role}` | `{status, id, horodatage}` |
| `/api/replay` | `{path` \| `content_base64, dex_id}` | `version_avant`, `version_apres`, `champs_modifies[]`, `points_resolus[]`, `points_nouveaux[]`, `n_points_avant`, `n_points_apres`, `resultat` |
| `/api/config` | sous-ensemble des clés ajustables | configuration mise à jour |
| `/api/rules/reload` | — | `{status, rules_version, calibration_active, seuil_routage, avertissements[]}` |
| `/api/calibration/proposer` | — | écrit `regles.candidate.json` ; `{status, chemin, version_proposee, ece_brut, ece_estime, gain, rappel}` — **409** si volume insuffisant |
| `OPTIONS *` | — | préflight CORS |

---

## Codes de retour

| Code | Signification |
|-----|----------------|
| `200` | Succès |
| `400` | Entrée client invalide (`ClientInputError` : chemin introuvable, non-`.docx`, > 50 Mo, corps absent) ou JSON malformé |
| `403` | Chemin statique hors de la racine du front |
| `404` | Route ou ressource inconnue |
| `409` | Volume insuffisant pour proposer une calibration |
| `500` | Erreur interne |

---

## Notes

- **`score_brut` vs `confiance`** : `score_brut` est le prior heuristique **stable** (déterministe, fonction du DEX et de la version des règles) ; `confiance` est la valeur **calibrée** affichée et utilisée pour le routage. La distinction court de `process-dex` → `validate` → `metrics` / `calibration` : c'est l'axe qui rend la boucle reproductible (on (re)calibre toujours sur `score_brut`).
- **`route_attention`** : un champ *trouvé* mais de `confiance` < `seuil_routage` (versionné) est porté à l'attention (badge « À revoir » + entrée dans `points_a_verifier`), **sans** modifier le contenu ni le `points_a_verifier` du moteur.
- **Désambiguïsation multi-candidats** (par champ, dans `process-dex`) : `candidats[]` énumère les sections dont le titre matche les mots-clés du champ (mêmes règles que le moteur), triées par score de proximité décroissant ; chaque candidat porte `index, titre, niveau, score, phrase, span, extrait` (+ `contenu` complet pour les champs `text` à ≥2 candidats, afin de basculer l'affichage sans appel supplémentaire). `selection_moteur` est l'index réellement retenu par le moteur (1er match, ordre document) — le **défaut appliqué**. `ambigu` (champs `text` seulement) vaut `true` quand le top-1 et le top-2 sont plus proches que `marge_ambiguite`, **ou** quand le mieux scoré n'est pas la sélection moteur (risque de *mauvaise section*) ; il abaisse la confiance (`malus_ambiguite`) et ajoute une entrée à `points_a_verifier`. Choisir une autre section côté front est journalisé via `/api/validate` comme `type_signalement="mauvaise_section"` + `correction` (l'auto-sélection était fausse → verdict `signale`, donc outcome 0 pour la calibration). Les champs `merge`/`link` matchent par nature plusieurs sections (agrégation voulue) : leurs candidats sont exposés en information, jamais marqués `ambigu`. Paramètres **versionnés** dans `regles.json` : `marge_ambiguite` (défaut 0.15), `max_candidats` (5), `confiance.malus_ambiguite` (0.20).
- **Historique des analyses** : chaque appel à `POST /api/process-dex` journalise une ligne **locale** dans `analyses.jsonl` (horodatage, `dex_id`, **`nom`** = nom de fichier complet, signature de gabarit, **`n_abouti`** = nombre de repérages positifs, répartition des confiances par bande, `n_ambigu`, `n_points`). `GET /api/history` renvoie ces analyses (récentes d'abord) ; le front en affiche **un seul tableau triable** (« Détail des DEX analysés », avec colonnes **Nom** = nom de fichier complet et **Abouti** ; les compteurs Abouti/élevée/moyenne/faible/(vide)/ambigus sont **cliquables** pour ne déplier en Reprise que les cartes du groupe, sur le DEX courant). Cela n'altère pas la réponse de `process-dex` et rien ne quitte le poste (au même titre qu'`events.jsonl`).
- **Suggestions applicables** : dans `process-dex`, chaque entrée de `suggestions[]` porte désormais `index, titre, score, span` (+ `contenu`/`extrait` pour les champs `text`). Le front peut donc **appliquer** une suggestion (basculer le contenu + l'overlay AR sur cette section) — utile quand le repérage par mots-clés a échoué — et journalise alors une `correction` (`section_introuvable` si le champ n'avait aucun match, sinon `mauvaise_section`).
- **Signalement par e-mail (onglet Administration)** : les valeurs par défaut du brouillon sont **persistées localement** via `POST /api/config` sous la clé `email` : `adresses` (une ou plusieurs, séparées par `;`), `objet_prefixe` (défaut `Castin ; `), `contenu_prefixe` (intro, peut être vide), `suffixe` (salutation). Le front compose l'**objet** = `objet_prefixe` + type de signalement, le **corps** (texte) reprenant **toutes les infos de la carte** (DEX, gabarit, champ, type, confiance, score brut, raison, titre repéré, routage/ambiguïté, commentaire/section corrigée, **contenu**, suggestions, points à vérifier) encadrées par `contenu_prefixe`/`suffixe`, et ouvre un **brouillon `mailto:` éditable** que l'opérateur valide avant l'envoi (les `;` des destinataires sont convertis en `,` pour le `mailto`). Un bouton **« Copier la fiche en HTML »** met une version mise en forme dans le presse-papier (le `mailto:` ne transmet que du texte) pour collage dans Outlook. C'est la seule sortie hors-poste, déclenchée par l'opérateur.
- **Onglet Dictionnaire (front)** : pas de nouvel endpoint — **tableau triable** (une ligne par **suggestion** ; un intitulé sans suggestion = une ligne) qui pilote l'**ordre d'affichage des cartes** (colonne éditable, persistée via `ordre_cartes` ; vide = ordre canonique) et **décompose** par colonnes : **N°**, **catégorie** et **intitulé** (tous deux **éditables**, surchargés via `intitules_cartes` et appliqués aux cartes), **repérage** (« Repérage non abouti »), **titre proposé** (**éditable**, surchargé via `titres_proposes`, indexé par titre d'origine) et **proximité** (depuis `suggestions[]` de `process-dex`), avec « Appliquer » pour les `text`. Chaque en-tête est **triable** (`aria-sort`). Les cartes de « Reprise assistée » sont **préfixées de leur numéro** et triées selon cet ordre. Le réglage `pastille_confiance_couleur_champ` (booléen, défaut `true`) commande l'affichage de la pastille de confiance (couleur du champ ou vert/orange/rouge).
- **Cycle de calibration** : `GET /api/calibration` (ajuste un candidat) → `POST /api/calibration/proposer` (écrit `regles.candidate.json`, **jamais auto-actif**) → gate `outils/calibration_check.py` (ECE hors-échantillon) + harness moteur → promotion (copie vers `regles.json`) → `POST /api/rules/reload` (revalide la monotonie). Détail commenté dans `README_SERVEUR.md`.

---

## Exemples (curl)

```bash
BASE=http://127.0.0.1:8765

# État du service
curl -s $BASE/api/health

# Traiter un DEX par chemin local
curl -s -X POST $BASE/api/process-dex \
  -H 'Content-Type: application/json' \
  -d '{"path":"/chemin/absolu/DEX_S20001_Nominal.docx"}'

# Enregistrer un verdict humain
curl -s -X POST $BASE/api/validate \
  -H 'Content-Type: application/json' \
  -d '{"dex_id":"S20001","champ":"supervision","verdict":"accepte","score_brut":0.9,"confiance":0.9,"duree_traitement_s":300}'

# Métriques (Brier, ECE brut -> calibré, fiabilité, alertes)
curl -s $BASE/api/metrics

# Historique des DEX analysés (+ agrégat par heure)
curl -s $BASE/api/history

# Ajuster une calibration candidate puis l'écrire
curl -s $BASE/api/calibration
curl -s -X POST $BASE/api/calibration/proposer

# Recharger les règles après un patch versionné
curl -s -X POST $BASE/api/rules/reload
```
#@FILE_END
#@FILE_TXT:ANNEXE_Boucle_2e_ordre.md
# Annexe — § Boucle d'amélioration de 2e ordre

> À appendre au `CAHIER_DES_CHARGES.md` comme nouveau paragraphe. L'annexe ne
> modifie aucune règle métier (R1–R8) ni le périmètre ; elle **referme la boucle**
> entre des pièces déjà spécifiées : règles externalisées, harness de
> non-régression (96 %), tableau de bord front, pilote de mesure sur stock réel.

---

## A.0 Principe

Cybernétique de 2e ordre = cybernétique des **systèmes observants** (von Foerster) :
l'observateur fait partie du système observé. Ici, l'observateur est l'Équipier Ops
au tableau de bord, et ses verdicts deviennent l'entrée d'apprentissage.

**Ce qui apprend** : la couche de **localisation / classification / calibration**
(quelle section est repérée, quel passage est retenu/écarté, avec quelle confiance).

**Ce qui n'apprend jamais** : le **contenu métier**. Conformément à la règle 7,
aucun texte de DEX n'est reformulé, paraphrasé ni résumé. Le système améliore
*quel passage il choisit* et *avec quelle confiance*, jamais *ce qu'il dit*.

### Invariants d'audit (garanties opposables en recette)

| # | Invariant |
| --- | --- |
| I1 | L'extraction et l'annotation d'un DEX sont une **fonction pure** de `(DEX, version_règles)`. Tout résultat est reproductible en ré-épinglant la version. |
| I2 | **Aucune règle ne mute pendant un lot.** Une version de règles est figée pour la durée d'un lot / d'une session déclarée. |
| I3 | Toute évolution de règles **passe le harness** (≥ 95 %, zéro régression hors tests 03/04) **avant** publication. |
| I4 | Tout patch est **réversible** (ré-épinglage de la version précédente). |
| I5 | La mutualisation inter-postes n'exporte que des **signaux agrégés sans contenu ni identifiant DEX** (cf. A.4, schéma `signal_agrege`). |

---

## A.1 Schéma de la double boucle (mappé É1–É7)

```
┌──────────────────────────── É7 · ENVIRONNEMENT ────────────────────────────┐
│   Comité hebdomadaire · Recette CA-GIP · Homologation poste · Audit DEX     │
│                  méta-observateur : sélectionne et valide                   │
└──────────────▲──────────────────────────────────────────────┬─────────────┘
               │ approuve le patch                             │ contraint
               │                                               ▼
        ╔══════╧═══════════════════ É6 · ÉVOLUTIF ════════════════════════╗
        ║            BOUCLE 2 — APPRENTISSAGE (hors-ligne, lente)          ║
        ║   agréger les signaux typés → proposer un patch `regles.json`    ║
        ║      → GATE HARNESS (>= 95 %, zéro régression hors 03/04)        ║
        ╚══════▲═══════════════════════════════════════════════╤═════════╝
               │ signaux typés (sans contenu)                  │ règles + lexique
               │                                               │ versionnés → É1/É2
   ┌───────────┴───────────────────────────────────────────────▼─────────────┐
   │                  BOUCLE 1 — RÉGULATION (en ligne, par DEX)                │
   │                                                                          │
   │  DEX.docx ─▶ É3 ENGENDRE ─────────▶ copie AR + rendu structuré           │
   │             (repérage · nettoyage ·          │                           │
   │              annotation · règles vN)         ▼                           │
   │                                   É4 ÉTAT — tableau de bord              │
   │                                   {extrait · section · confiance}        │
   │                                              │                           │
   │                                              ▼                           │
   │                                   É5 EXPRESSION — validation humaine     │
   │                              accepte ──┐        signale (typé) ──┐       │
   │                                        │                         │       │
   │       correction d'instance (immédiate, ce DEX) ◀────────────────┘       │
   │                                        │                                 │
   │                                        ▼                                 │
   │                      collage manuel CAST'IN · vérif 100 % · export PDF   │
   └──────────────────────────────────────────────────────────────────────────┘
```

- **Boucle 1 (régulation, par DEX)** : `É3 → É4 → É5 → correction d'instance`.
  Rapide, locale, immédiate. Stabilise *ce* DEX.
- **Boucle 2 (apprentissage)** : `É5 → É6 → [gate harness] → É7 → réinjection en É1/É2`.
  Lente, batchée, gatée, réversible. Fait évoluer *les règles*.

### Correspondance des slots

> Les rôles ci-dessous reconstruisent la sémantique des slots à partir de
> l'énoncé de l'axiome (*« les Éléments dans l'Espace Engendrent un État
> d'Expression Évolutif de l'Environnement »*). À ajuster à tes définitions
> canoniques si l'attribution diffère.
>
> **Statut : provisoire.** Attribution à **figer lors de la passe d'intégration**
> (fermeture de la boucle entre les pièces déjà spécifiées), le cas échéant en une
> seule fois. Cette table sert d'hypothèse de travail jusque-là.

| Slot | Mnémonique | Rôle dans la boucle | Composant concret |
| --- | --- | --- | --- |
| **É1** | Éléments | Matière première manipulée | Catalogue des 23 champs CAST'IN + base des 8 règles + paragraphes source |
| **É2** | Espace | Espace structuré de variation | Structure du gabarit (styles/titres) + **signature de gabarit** + espace de mapping champ↔section |
| **É3** | Engendrent | Acte génératif (le « faire ») | Moteur `dex_castin_common` : repérage · nettoyage · extraction · annotation → copie AR + rendu structuré |
| **É4** | État | État observable courant | Tableau de bord : par champ `{extrait, section repérée, confiance, complétude}` |
| **É5** | Expression | Verdict de l'observateur | Validation humaine **typée** : `accepte` / `signale(catégorie)` + correction |
| **É6** | Évolutif | Évolution récursive des règles | Boucle 2 : agrégation → patch `regles.json` → gate harness → version |
| **É7** | Environnement | Contexte qui sélectionne / valide | Gouvernance : comité hebdo (méta-observateur), recette, homologation, audit |

---

## A.2 Trois échelles de correction

C'est l'articulation qui rend *« le traitement corrigé après chaque DEX »* compatible
avec la reproductibilité d'un livrable audité.

| Échelle | Déclencheur | Ce qui est mis à jour | Garantie d'audit |
| --- | --- | --- | --- |
| **Instance** (immédiate) | Validation d'**un** DEX | La sortie de **ce** DEX : champ corrigé avant collage | Override humain **journalisé** ; sortie = `f(DEX, vN)` + correction tracée. Reproductible. |
| **Calibration** (glissante) | Chaque verdict | Confiance affichée + routage vers « Points à vérifier » | **N'altère jamais le contenu extrait** ; journal horodaté rejouable. |
| **Règles** (versionnée) | Patch validé en comité | Lexique de titres, seuils couleur/style, seuils de confiance | Gate harness ≥ 95 % ; version épinglée ; réversible (I3/I4). |

> Lecture : la phrase *« après chaque DEX traité, le traitement sera corrigé selon
> la validation humaine »* relève de l'**échelle instance** — réactivité totale,
> sans coût pour l'audit. Les **règles**, elles, n'évoluent que par versions gatées,
> de sorte que deux DEX traités à des moments différents avec la même version
> donnent un résultat identique (I1/I2).

---

## A.3 Contrat de données du tableau de bord

Deux schémas distincts, par respect de I5 : un **journal local** riche (peut
référencer du contenu, ne quitte pas le poste) et une **télémétrie agrégée**
sans contenu (seule candidate à une mutualisation inter-postes, phase 2).

### A.3.1 `evenement_validation` — journal **local** (poste)

| Champ | Type | Notes |
| --- | --- | --- |
| `id` | UUID | Local |
| `horodatage` | ISO 8601 | |
| `dex_id` | string | N° solution `Sxxxx` (identifiant) — **reste local** |
| `version_regles` | string | Version épinglée utilisée pour ce traitement (ex. `v1.3`) |
| `onglet` | enum | `description_detaillee` \| `dex` \| `identification` |
| `champ` | enum | Un des 23 champs CAST'IN |
| `gabarit_signature` | string | Empreinte (hash) des styles/titres du DEX |
| `confiance` | float `[0,1]` | Confiance affichée pour le champ |
| `verdict` | enum | `accepte` \| `signale` |
| `type_signalement` | enum \| null | Taxonomie A.3.3 ; `null` si `accepte` |
| `correction` | objet \| null | `{ section_attendue?, passage_ref?, commentaire? }` — **local, peut référencer du contenu** |
| `duree_traitement_s` | int | Pour la métrique de débit (A.4) |

```json
{
  "id": "8f1c…",
  "horodatage": "2026-06-17T14:32:05+02:00",
  "dex_id": "S1627",
  "version_regles": "v1.3",
  "onglet": "dex",
  "champ": "observabilite",
  "gabarit_signature": "g7a2e9",
  "confiance": 0.62,
  "verdict": "signale",
  "type_signalement": "section_introuvable",
  "correction": { "section_attendue": "Métrologie", "passage_ref": "ch.11 §2" },
  "duree_traitement_s": 540
}
```

### A.3.2 `signal_agrege` — télémétrie **hors-poste** (optionnelle, phase 2)

Dérivée du journal local par projection **sans contenu ni identifiant** :
pas de `id`, pas de `dex_id`, pas de texte de `correction`, confiance **bucketisée**.

| Champ | Type | Notes |
| --- | --- | --- |
| `type_signalement` | enum | Taxonomie A.3.3, ou `accepte` |
| `champ` | enum | Un des 23 champs |
| `onglet` | enum | |
| `gabarit_signature` | string | Hash uniquement |
| `confiance_bucket` | string | Ex. `0.6-0.7` |
| `corrige` | bool | `true` si `signale`, `false` si `accepte` |
| `version_regles` | string | |

```json
{ "type_signalement": "section_introuvable", "champ": "observabilite",
  "onglet": "dex", "gabarit_signature": "g7a2e9", "confiance_bucket": "0.6-0.7",
  "corrige": true, "version_regles": "v1.3" }
```

### A.3.3 Taxonomie de signalement (chaque type pointe la règle qu'il fait évoluer)

| `type_signalement` | Description | Règle | Levier dans `regles.json` |
| --- | --- | --- | --- |
| `section_introuvable` | Section existante non repérée | R1 | + entrée au lexique de titres |
| `mauvaise_section` | Mappé sur la mauvaise section | R1 | Désambiguïsation du lexique |
| `encart_repris` | Encart bleu/italique pris à tort (**FP**) | R2 | Seuil couleur/style |
| `contenu_ecarte` | Paragraphe métier écarté à tort (**FN**, cf. test 03) | R2 | Seuil couleur/style |
| `lien_errone` | Lien DAP/ADU manqué ou erroné | R1/lien | Motif de détection de lien |
| `compose_mal_assemble` | « Matière (repo) » / « Changement et MEP » mal recomposé | composition | Règle de composition |
| `identification_erronee` | `Sxxxx` / Auteur / Responsable | R8 | Motif d'identification |
| `parasite_residuel` | Nettoyage incomplet | R3 | Table de normalisation |

> Un signalement en **texte libre** n'apprend rien ; un signalement **typé** pointe
> directement le levier de règle. La taxonomie est donc le geste de design le plus
> rentable de la boucle.

### A.3.4 Paramètres — distinction **affichage/gouvernance** vs **déterministe/versionné**

Deux familles de paramètres, à **ne pas confondre** : seuls les seconds passent le harness
et entrent dans `regles.json` ; les premiers sont **ajustables depuis le front** et ne
déclenchent **ni re-gate harness ni bump de version**, car ils ne modifient **aucune** sortie
de DEX (ils ne font que colorer une métrique, alerter le comité, ou cadrer l'agrégation).

| Paramètre | Famille | Où | Effet sur la sortie d'un DEX |
| --- | --- | --- | --- |
| **Cible ECE** (défaut `0,10`) | Affichage / gouvernance | `tableau_de_bord.config.json` — **ajustable front** | **Aucun** (alarme de calibration uniquement) |
| Seuils d'alerte (taux d'acceptation/champ, débit) | Affichage / gouvernance | `tableau_de_bord.config.json` — ajustable front | Aucun |
| `k` — occurrences avant promotion en fixture | Gouvernance | `tableau_de_bord.config.json` — ajustable front | Aucun |
| Taille de fenêtre glissante (calibration, débit) | Affichage | `tableau_de_bord.config.json` — ajustable front | Aucun |
| **Seuil de confiance de routage** vers « Points à vérifier » | **Déterministe** | `regles.json` — **versionné, gaté** | **Oui** (change la liste « Points à vérifier ») |
| Lexique de titres, seuils couleur/style (R1, R2) | Déterministe | `regles.json` — versionné, gaté | Oui |

> Règle de partage : *« si le paramètre peut changer ce qui est collé dans CAST'IN ou la
> liste des points à vérifier, il est versionné et gaté ; sinon il est ajustable au front. »*
> La **cible ECE** tombe dans la seconde catégorie — elle pilote l'attention du comité,
> jamais l'extraction.

```json
// tableau_de_bord.config.json (ajustable depuis le front, hors harness)
{
  "cible_ece": 0.10,
  "alerte_taux_acceptation_min": 0.85,
  "alerte_duree_dex_max_s": 720,
  "k_promotion_fixture": 5,
  "fenetre_glissante_n": 200
}
```

---

## A.4 Métriques

`o_i` = issue observée (`1` si `accepte`, `0` si `signale`) ; `p_i` = confiance affichée.

**Taux d'acceptation par champ** (métrique opérationnelle de tête) :

```
taux_acceptation(c) = N_accepte(c) / N_traite(c)
```

**Score de Brier** (par champ et global), `[0,1]`, plus bas = mieux :

```
BS = (1/N) · Σ (p_i − o_i)²
```

**ECE** (Expected Calibration Error) sur `M` buckets de confiance :

```
ECE = Σ_m (|B_m|/N) · | acc(B_m) − conf(B_m) |
```

où `acc(B_m)` = taux d'acceptation empirique du bucket, `conf(B_m)` = confiance moyenne du bucket.

**Diagramme de fiabilité** : `acc(B_m)` vs `conf(B_m)` ; la diagonale = calibration parfaite.

**Débit** : durée médiane / DEX (fenêtre glissante) → suit l'hypothèse « ≈ 10 min/DEX ».

### Lien harness ↔ terrain (fermeture du risque « variance stock réel »)

- Le **harness** donne un score **par règle** sur fixtures synthétiques (hors-ligne).
- Le **tableau de bord** donne le taux d'acceptation **par champ** sur stock réel (en ligne).
- Leur **écart** est précisément la *« variance stock réel vs synthétique »* identifiée
  au CDC comme risque. **L'objectif de la boucle est de réduire cet écart.**
- Tout mode d'échec récurrent (≥ `k` occurrences) est **incarné en nouvelle fixture
  synthétique** → le harness grandit → couverture de test auto-étendue. C'est le
  deutero-apprentissage rendu concret : le système apprend à **tester** ce qu'il a
  appris à **traiter**.

---

## A.5 Protocole — capture-continue → application-versionnée gatée par le harness

| Phase | Cadence | Action | Sortie |
| --- | --- | --- | --- |
| **1. Capture** | Continue (par DEX) | Chaque verdict → `evenement_validation` + label de calibration. Correction d'instance appliquée à ce DEX. Calibration glissante mise à jour. **Aucune règle ne change.** | Journal local + métriques A.4 |
| **2. Agrégation** | Périodique (fin de session / hebdo) | Agréger les signaux par `(type × champ × gabarit_signature)`. Classer les modes d'échec par fréquence × impact. | Top des modes d'échec |
| **3. Proposition** | Assistée + humaine | Pour chaque mode prioritaire, dériver un **diff** sur `regles.json` (entrée de lexique, seuil couleur, seuil de confiance) + justification + signaux à l'appui. | Patch candidat |
| **4. Gate harness** | Obligatoire | `python tests/run_tests.py` sur les règles patchées. **Acceptation** : score global ≥ 95 % **et** zéro régression sur 01,02,05,06,07,08 (03/04 restent FP/FN tolérés). Ajout d'une fixture reproduisant le mode découvert. | Rapport harness |
| **5. Validation gouvernance** | Comité hebdo (É7) | Le comité approuve patch + rapport. Méta-observateur de la boucle 2. | GO / NO-GO |
| **6. Publication** | Sur GO | Incrément de version de `regles.json` (`MINOR` = ajout lexique ; `MAJOR` = changement de seuil/sémantique). Chaque DEX traité **enregistre sa `version_regles`** → reproductibilité (I1). | `regles.json` vN+1 épinglée |

**Rollback** : ré-épingler vN−1 (I4). Aucun retraitement requis tant que la version
d'origine de chaque DEX est journalisée.

---

## A.6 Critères d'acceptation de la boucle (Definition of Done)

| # | Critère | Cible |
| --- | --- | --- |
| 1 | **Calibration** | ECE global ≤ **cible ECE** (paramètre `tableau_de_bord.config.json`, **ajustable front**, défaut `0,10`, à recaler en pilote) **et** en amélioration sur fenêtre glissante |
| 2 | **Débit** | Durée médiane/DEX en baisse vers ≈ 10 min (hypothèse à valider sur stock réel) |
| 3 | **Couverture auto-étendue** | Tout `type_signalement` récurrent (≥ `k`) donne lieu à une fixture de non-régression |
| 4 | **Traçabilité** | 100 % des DEX traités portent leur `version_regles` ; tout patch a rapport harness + validation comité |
| 5 | **Confidentialité** | La télémétrie mutualisée ne contient **aucun contenu ni identifiant DEX** (vérifié par schéma `signal_agrege`) |
| 6 | **Non-régression** | Gate harness ≥ 95 %, zéro régression hors 03/04, à chaque publication |

---

## A.7 Rappel des frontières (cohérence avec le CDC)

- **Aucune API / aucune RPA CAST'IN.** Le collage reste manuel depuis la copie
  augmentée (cadres, étiquettes, nom de champ, flèches). La boucle n'agit **jamais**
  sur CAST'IN ; elle agit sur la qualité de la **carte visuelle** et sur la
  **calibration** des signalements.
- **Pas de microservices sur le poste.** La boucle 1 vit dans le monolithe modulaire
  existant (`common` + serveur local + front). Seule la **boucle 2** peut, en phase 2
  et **après pilote**, comporter un agrégateur **hors-poste sans contenu** (I5) — une
  décision de gouvernance, pas un prérequis de livraison.
- **Pilote d'abord.** La cybernétique reste au service du débit et de la qualité
  auditable. Le pilote valide la calibration et la cible ~10 min/DEX **avant** tout
  investissement dans l'infrastructure d'observation mutualisée.
#@FILE_END
#@FILE_TXT:CAHIER_DES_CHARGES.md
# Cahier des charges — synthèse, MODOP officiel et correspondance avec l'outil

*Référence du besoin (appel d'offres CA-GIP du 23/04/2026) et lien avec ce que fait l'outil.
Le cahier des charges structuré complet est dans `CDC.md`.*

---

## 1. Contexte et objectif

CA-GIP modernise sa gestion documentaire technique. Les **Dossiers d'Exploitation (DEX)**,
historiquement rédigés sous **Word (.docx)** et stockés sur **SharePoint**, doivent être
**repris dans l'outil web CAST'IN**. CAST'IN permet de créer des DEX mais **ne propose pas
de reprise automatique** du stock Word, et **aucune API n'est disponible** : la reprise est
donc **manuelle**, **champ par champ**, avec une **forte exigence de rigueur** (les DEX sont
audités).

> L'architecture des paragraphes diffère entre Word et CAST'IN : **ce n'est pas un simple
> copier-coller**. D'où des risques d'erreur (mauvais paragraphe, oubli de section, texte
> explicatif copié par inadvertance) sur une tâche **répétitive et chronophage**
> (~**20 min par DEX**).

**Ce que l'outil apporte** : il pré-repère les champs, nettoie le contenu, isole les liens,
signale les points à vérifier — pour **fiabiliser et accélérer** la saisie manuelle, sans la
remplacer.

---

## 2. Périmètre (options) et échéance

| Option | Volume à reprendre |
|--------|--------------------|
| **A** | **115** documents Word |
| **B** | **907** documents Word |
| **C** | **1 227** documents Word |

Repère de charge : **~20 minutes par DEX**. Échéance : **avant octobre 2026**. Réalisation
en autonomie avec **2 référents CA-GIP**, **suivi hebdomadaire**, et **reporting hebdomadaire**
des DEX repris.

## 3. Livrables et recette

- **Livrable principal** : dossier des DEX **exportés en PDF** après reprise dans CAST'IN.
- **Recette** : évaluation finale par CA-GIP sur la **qualité** et la **quantité** des reprises.

## 4. Gouvernance

- **Responsable projet (client)** : Paul BALARESQUE.
- **Comité de pilotage (hebdomadaire)** : Paul BALARESQUE, Nadège SCHMITT, Baptistan HIOT.
- **Validation des jalons** (cadrage, recette, livraison) : Nadège SCHMITT, Baptistan HIOT.

---

## 5. MODOP officiel — où reprendre chaque champ

Procédure CA-GIP : identifier la solution par le **nom de fichier** (élément commençant par
**`S****`**, ex. `S1627`), sélectionner la version **« En Production »**, puis remplir CAST'IN.

> **Consignes clés** : se référer au **nom de la section** (les **numéros peuvent changer**) ;
> **« Non concerné »** si l'information est absente ; **éviter les caractères spéciaux** ; ne
> copier **que le contenu, les liens et les schémas** — **pas** les noms de section ni les
> **textes explicatifs en bleu**.

### Onglet « Description détaillée » (section Métier)

| Champ CAST'IN | Emplacement dans le DEX Word | Remarque |
|---------------|------------------------------|----------|
| Lien « Dossier Archi (DAP…) » | 2.2 Architecture fonctionnelle & applicative | copier le lien, puis Entrée |
| Schéma Applicatif (ADU…) | 2.2, ou 2.1 « description de la solution » | Ctrl+F si le lien ADU est introuvable |
| Description Fonctionnelle | 2.1 « description de la solution » | |
| Données de la solution | 2.3 « Données » | |
| Principes et décisions | **Ne pas remplir** | |
| Description Technique | 4.1 « Architecture technique » | |

### Onglet « DEX » (+ Auteur / Responsable)

L'**Auteur** figure en page de garde ; à défaut de **Responsable** (page 2), reprendre le
**nom du service**.

| Champ CAST'IN | Emplacement dans le DEX Word | Remarque |
|---------------|------------------------------|----------|
| Plage de fonctionnement / maintenance | 3.3 « plages de fonctionnement » | |
| Supervision | chapitre 6 « Supervision » (tout le chapitre) | |
| Observabilité | « Métrologie » (chapitre 9 ou 11) | |
| Log | « Diagnostique », « LOG », « Trace » (chapitre 8.2) | |
| Sauvegardes | chapitre 7 « Sauvegarde » | |
| Servitudes et ordonnancements | chapitre 9 « Servitudes » | « Non concerné » si absent |
| Comptes et services | 12.2 « compte de service » | |
| Certificats | 12.3 « Certificats » | |
| Liste blanche | 12.4 | |
| Flux | 4.3 « Flux et interdépendances » | |
| Support | 8.1 « matrice responsabilité » | |
| Changement et MEP | chapitre 10 « contrôle des opérations » + chapitre 5 « Changements et MEP » | |
| Matière (repo) | 5.1 + rechercher « Merge Request » | |
| Procédure de restauration | 13.1 « Restauration » | |
| Procédure de reconstruction | 13.2 « Reconstruction » | |
| Procédure de resynchronisation | 13.3 « resynchronisation » | |
| Informations supplémentaires | après 13.3 et 4.2.2 « assets mainframe » | **optionnelle** |

**Contrôles avant export** : date de dernière mise à jour cohérente, **complétude DEX à
100 %**, puis **« Exporter PDF »** vers le dossier indiqué.

---

## 6. Correspondance exigences ↔ règles de l'outil

L'outil **opérationnalise** les consignes du MODOP :

| Exigence du cahier des charges | Règle / fonction de l'outil |
|--------------------------------|-----------------------------|
| Se référer au **nom de section** (numéros variables) | **R1** — repérage **par nom** |
| Ne pas copier les **textes explicatifs en bleu** | **R2** — écarter les encarts (italique + bleu) |
| **Éviter les caractères spéciaux** | **R3** — nettoyage des parasites |
| **« Non concerné »** si information absente | **R4** |
| **Principes et décisions : ne pas remplir** | **R5** — champ toujours vide |
| **Informations supplémentaires** optionnelle | **R6** |
| Ne copier **que le contenu** (fidélité) | **R7** — contenu **jamais reformulé** |
| **En cas de doute, contacter l'Ops** responsable | **R8** — « points à vérifier » + e-mail de signalement |
| Identifier par **`S****`**, version **En Production** | extraction d'identifiant (nom de fichier, sinon contenu) |
| **Complétude / qualité** attendues | confiance par champ, ambiguïtés, historique, métriques |

> En somme, le MODOP décrit **manuellement** ce que l'outil **assiste** : mêmes
> emplacements, mêmes règles d'écartement et de fidélité, avec en plus un **repérage
> automatique**, une **évaluation de confiance** et une **traçabilité**.

---

## 7. Planning du RFP (rappel)

| Étape | Date | Responsable |
|-------|------|-------------|
| Réunion de cadrage | 23/04/2026 | Achat + Prescripteurs |
| Envoi de l'appel d'offres | 27/04/2026 | Achat |
| Intention de répondre | 29/04/2026 | Fournisseur |
| Questions des soumissionnaires | 29/04/2026 | Fournisseur |
| Réponses aux questions | 04/05/2026 | Achat + Prescripteurs |
| Réception des offres | 11/05/2026 | Fournisseur |
| Analyse + short list | 13/05/2026 | Achat + Prescripteurs |
| Soutenances | semaine du 18/05/2026 | Tous |
| Négociations | jusqu'au 29/05/2026 | Achat + Fournisseurs |
| Démarrage mission | début juin 2026 | Fournisseur + Prescripteur |

---

> Documents de référence : **`CDC.md`** (cahier des charges structuré complet),
> `Cahier_des_charges.pdf` (appel d'offres d'origine). Ce résumé fait le pont entre le besoin
> exprimé et le comportement de l'outil — voir aussi `SYNTHESE_REPRISE.md` et `TEST_PLAN.md`.
#@FILE_END
#@FILE_TXT:CDC.md
# Cahier Des Charges

- **Contexte**
    - Gestion de solutions applicatives => Prise en charge de ces solutions par des personnes tierces
    - Les Dossiers d’Exploitation (DEX) sont créés et rédigés au format Word (.docx) selon un gabarit standard dans SharePoint
    - CAST'IN est un système centralisé de création et de gestion de documents d'exploitation (DEX)
    - CAST'IN permet de créer les DEX directement mais il ne permet pas une reprise des DEX existants au format Word de manière automatique
    - API CAST’IN non disponible à ce jour
- **Objectif général**
    
    Spécifier l'automatisation de la reprise des Dossiers d'Exploitation (DEX) Word vers CAST'IN
    
    - Reprendre le stock des DEX au format Word présents sur le SharePoint et de les migrer vers l'outil CAST'IN
    - Les DEX doivent être repris manuellement dans l’outil CAST’IN (saisie champ par champ)
    - Les documents d'exploitation (DEX) sont régulièrement audités et la plus grande rigueur est attendue dans la reprise du stock

- **Le dispositif cible**
    - un **module commun** porte toute la logique métier (repérage par nom, nettoyage, extraction, annotation) — résultat identique quel que soit le point d'entrée ;
    - un **utilitaire en ligne de commande** traite les DEX **par lot** (pré-génération du stock) ;
    - un **service local back** (`127.0.0.1`) alimente le **Service front VueJS** pour un usage interactif, DEX par DEX ;
    - deux sorties par DEX : le **rendu structuré** (Markdown / JSON) et la **copie annotée** `.docx` (surlignage par champ + légende).
    - Doit prend en compte l'ensemble des DEX identifiés dans le référentiel de reprise de stock
    - Doit être capable d'améliorer la clarté et la précision des instructions de migration pour la reprise manuelle dans l’outil CAST’IN en saisie champ par champ
    - En cas de doute, il faudra consulter l’équipier Ops responsable du DEX pour les questions complémentaires

- **Flux opérateur cible**
    
    Ouvrir le DEX → l'outil affiche les champs nettoyés + la copie annotée → traiter les points à vérifier → copier / coller dans CAST'IN → vérifier 100 % → exporter PDF
    
- **Contrainte**
    
    Contrainte structurante: Aucune action via API CAST'IN n'est envisageable. L'appel d'offres confirme d'ailleurs que CAST'IN ne propose pas de reprise automatique du stock Word. La saisie finale dans CAST'IN reste donc, à ce stade, manuelle.
    - Cette reprise est répétitive et confrontés aux exisgences, cela représente un risque de baisse d'attention, de problèmes de discernement et de stress  discernement
    - L'architecture de création des paragraphes du DEX est différente sur le fichier Word et sur l'outil CAST'IN.
    - Il s'agit de réaliser du copier-coller complexe avec des sources d’erreurs (mauvais paragraphe, oubli de section, contenu explicatif copié par inadvertance, etc…)
    - Chronophage

- **Objectif à partir d’un DEX .docx**
    - Obtenir le contenu prêt à coller pour chaque champ CAST’IN (texte nettoyé, liens isolés)
    - Obtenir la liste des points à vérifier (information absente, ambiguë, ou non retrouvée)
    - Obtenir une copie surlignée du DEX d’origine, pour identifier en un coup d’œil quel passage va dans quel champ CAST’IN et quels sont les manquants
    - Réaliser un copier-coller rapide et sûr du contenu métier

- **Périmètre**
    - Lecture d’un DEX au format .docx
    - Application des règles de reprise définies en tableau (règles 1 à 8 du prompt de référence)
    - Extraction, nettoyage et structuration du contenu des **23 champs CAST'IN**
    - Production du rendu structuré (Markdown / JSON) des 23 champs CAST’IN + identification + points à vérifier
    - Détection des sections absentes (« Non concerné ») et signalement des cas douteux
    - Production, par DEX, d'un contenu prêt à copier-coller (rendu structuré) et d'une copie annotée du DEX d’origine, surlignée par champ
    - Production d'Un jeu de tests automatisés (DEX synthétiques) mesurant la fiabilité de chaque règle métier
    - Traitement **par lot** de l'ensemble du stock
    - Un affichage interactif coté front avec copie en un clic

- **Mode d’exécution**
    - Fichier autonome en ligne de commande, en environnement Windows

- **Hors périmètre**
    - Toute saisie automatique dans CAST’IN (pas d’API CAST’IN disponible : la saisie finale reste manuelle, le copier-coller)
    - La génération du contenu d’un DEX est une donnée d’entrée, jamais produite ni modifiée, aucun contenu n’est reformulé ou réécrit (règle 7)
    - Pas de prise en charge de formats autres que .docx (pas de PDF, .doc binaire, etc.).
    L’authentification / la gestion multi-utilisateurs (outil mono-poste, local)

- **Règles métier de reprise**
 
     1 Repérage par NOM
        Les sections sources sont retrouvées par le texte normalisé de leur titre (numérotation, accents, casse, ponctuation ignorés)
        Le numéro de chapitre indiqué dans le gabarit (~2.1, ~13.3…) n’est qu’un indice documentaire, jamais un critère de recherche
        La numérotation réelle varie d’un DEX à l’autre.
        
    - 2 Contenu utile uniquement
        Les titres de section ne sont pas repris
        Les paragraphes entièrement en italique et en couleur non standard (encarts d’aide bleu/italique du gabarit) sont détectés et écartés du contenu repris
        
    - 3 Nettoyage des caractères parasites
        Suppression/normalisation :
        espaces insécables et fines
        Caractères de contrôle et marqueurs invisibles (BOM, marques de direction, espaces de largeur nulle)
        Puces de polices “symboles” (Wingdings/Symbol, zone Unicode Private Use Area) converties en -
        Espaces multiples et lignes vides en excès compressés
        
    - 4 Information absente
        Tout champ dont la section source est introuvable est rempli avec exactement la chaîne Non concerné (et signalé, cf règle 8)
        
    - 5 « Principes et décisions »
        Toujours laissé vide, quel que soit le contenu du DEX.
        
    - 6 « Informations supplémentaires »
        Optionnel :
        Vide si absent (pas de signalement)
        Renseigné s’il existe un contenu après la section “Resynchronisation” et/ou une section “Assets mainframe”.
        
    - 7 Pas de reformulation
        Le contenu est nettoyé et réorganisé (règles 2 et 3), jamais réécrit, paraphrasé ou résumé.
        
    - 8 Doute = signalement
        Toute section introuvable, ambiguë
        Toute information d’identification (n° de solution, auteur, responsable) non retrouvée
        Doit être listée dans « Points à vérifier auprès de l’Équipier Ops ».
        La liste affiche RAS si aucun doute
        L’outil ne devine jamais
        
- **Tableau des règles métier**
    
    | # | Règle | Exigence |
    | --- | --- | --- |
    | 1 | **Repérage par NOM** | Les sections sources sont retrouvées par le **texte normalisé de leur titre** (numérotation, -accents, casse, ponctuation ignorés). Le numéro de chapitre indiqué dans le gabarit (`~2.1`, `~13.3`…) n’est qu’un **indice documentaire**, jamais un critère de recherche : la numérotation réelle varie d’un DEX à l’autre. |
    | 2 | **Contenu utile uniquement** | Les titres de section ne sont pas repris. Les paragraphes **entièrement en italique et en couleur non standard** (encarts d’aide bleu/italique du gabarit) sont détectés et **écartés** du contenu repris. |
    | 3 | **Nettoyage des caractères parasites** | Suppression/normalisation : espaces insécables et fines, caractères de contrôle et marqueurs invisibles (BOM, marques de direction, espaces de largeur nulle), puces de polices “symboles” (Wingdings/Symbol, zone Unicode *Private Use Area*) converties en `-` , espaces multiples et lignes vides en excès compressés. |
    | 4 | **Information absente** | Tout champ dont la section source est introuvable est rempli avec **exactement** la chaîne `Non concerné` (et signalé, cf règle 8). |
    | 5 | **« Principes et décisions »** | Toujours **laissé vide**, quel que soit le contenu du DEX. |
    | 6 | **« Informations supplémentaires »** | **Optionnel** : vide si absent (pas de signalement), renseigné s’il existe un contenu après la section “Resynchronisation” et/ou une section “Assets mainframe”. |
    | 7 | **Pas de reformulation** | Le contenu est **nettoyé et réorganisé** (règles 2 et 3), jamais réécrit, paraphrasé ou résumé. |
    | 8 | **Doute = signalement** | Toute section introuvable, ambiguë, ou toute information d’identification (n° de solution, auteur, responsable) non retrouvée est listée dans **« Points à vérifier auprès de l’Équipier Ops »**. La liste affiche `RAS` si aucun doute. **L’outil ne devine jamais.**
     |
- **Mode opératoire**
    
    Impose de contacter l'Équipier Ops en cas de doute
    
    Le processus manuel décrit dans l'appel d'offres se décompose en huit étapes. L'analyse ci-dessous distingue ce qu'un outil côté Word peut prendre en charge de ce qui dépend de l'interface CAST'IN.
    
    | **#** | **Étape du MODOP** | **Automatisable ?** | **Moyen** |
    | --- | --- | --- | --- |
    | 1 | Identifier le n° de solution (`Sxxxx`) depuis le nom de fichier | **Oui, totalement** | Python script (motif `S\d{4}`) |
    | 2 | Se connecter à CAST'IN (compte `U…@ZOE.GCA`) | **Non** (hors RPA) | Authentification / SSO : manuel, ou RPA sous conditions |
    | 3 | Rechercher la solution puis sélectionner la version « En Production » | **Via script Python** (état propre à CAST'IN) | Manuel, ou RPA d'IHM |
    | 4 | Extraire le contenu des ~23 sections, repérées **par nom** | **Oui, totalement** | Script Python / script — *cœur de l'automatisation* |
    | 5 | Nettoyer : caractères spéciaux, retrait des titres et du texte explicatif bleu, conservation du contenu/liens/schémas | **Oui, totalement** | Script Python |
    | 6 | Détecter les sections absentes → « Non concerné » + signaler les doutes | **Oui, totalement** | Script Python |
    | 7 | Coller chaque champ dans l'éditeur CAST'IN (icône « Modifier », valider) | **Pas via plugin** (pas d'API) | **Manuel assisté** (copie en 1 clic), ou RPA d'IHM |
    | 8 | Vérifier complétude 100 % / 6 rubriques, puis exporter le PDF | **Partiellement** | Aide à la vérification côté outil ; export PDF manuel, ou RPA |
    
    **Lecture de ce tableau.** Tout le travail *côté source* (étapes 1, 4, 5, 6, et la préparation de 7) est automatisable de bout en bout. Tout le travail *côté cible CAST'IN* (étapes 2, 3, 7, 8) ne l'est pas sans API — sauf à piloter l'interface par un robot (RPA), avec les réserves exposées au §4.3. C'est cette frontière qui détermine la solution retenue.
    
- **Onglet « Description détaillée »**
    
    
    | Champ | Type | Source (indicative, retrouvée par nom — règle 1) |
    | --- | --- | --- |
    | Lien Dossier Archi (DAP…) | Lien uniquement | ~2.2 Architecture fonctionnelle & applicative |
    | Schéma Applicatif (ADU…) | Lien uniquement | ~2.2 (ou ~2.1) Architecture fonctionnelle & applicative / Description de la solution |
    | Description Fonctionnelle | Texte | ~2.1 Description de la solution |
    | Données de la solution | Texte | ~2.3 Données |
    | Principes et décisions | Vide (règle 5) | — |
    | Description Technique | Texte | ~4.1 Architecture technique |
- **Identification**
    
    
    | Information | Source |
    | --- | --- |
    | Numéro de solution (`Sxxxx`) | Nom de fichier en priorité, sinon ~60 premiers paragraphes |
    | Auteur | Page de garde (avant le premier titre), motif `Auteur : ...` |
    | Responsable | ~60 premiers paragraphes, motif `Responsable : ...` (sinon `Service : ...`, avec signalement) |
- **Onglet « DEX »**
    
    
    | Champ | Type | Source (indicative) |
    | --- | --- | --- |
    | Plage de fonctionnement / maintenance | Texte | ~3.3 Plages de fonctionnement |
    | Supervision | Texte (chapitre entier) | ~6 Supervision |
    | Observabilité | Texte | ~9/11 Métrologie |
    | Log | Texte | ~8.2 Diagnostique / LOG / Trace |
    | Sauvegardes | Texte | ~7 Sauvegarde |
    | Servitudes et ordonnancements | Texte | ~9 Servitudes (sinon `Non concerné`) |
    | Comptes et services | Texte | ~12.2 Compte de service |
    | Certificats | Texte | ~12.3 Certificats |
    | Liste blanche | Texte | ~12.4 |
    | Flux | Texte | ~4.3 Flux et interdépendances |
    | Support | Texte | ~8.1 Matrice de responsabilité (RACI) |
    | Changement et MEP | Composé | ~10 Contrôle des opérations + ~5 Changements et MEP |
    | Matière (repo) | Composé | ~5.1 Référentiel/Dépôt + recherche « Merge Request » dans tout le document |
    | Procédure de restauration | Texte | ~13.1 Restauration |
    | Procédure de reconstruction | Texte | ~13.2 Reconstruction |
    | Procédure de resynchronisation | Texte | ~13.3 Resynchronisation |
    | Informations supplémentaires | Annexe (optionnel, règle 6) | Contenu après ~13.3 + ~4.2.2 Assets mainframe si présent |
- **Rendu structuré (3 blocs imposés) pour chaque DEX**
    1. **IDENTIFICATION** : Solution / Auteur / Responsable (ou `Non concerné`).
    2. **CONTENU PAR CHAMP CAST'IN** : un bloc `*[Nom du champ]**` par champ, contenu nettoyé ou `Non concerné` / `(laisser vide)`.
    3. **POINTS À VÉRIFIER AUPRÈS DE L'ÉQUIPIER OPS** : liste à puces, ou `RAS`.
    
    Formats de sortie : Markdown `<nom>_CASTIN.md` ou JSON optionnel`<nom>_CASTIN.json`,  consommé par le script Office.js/Python).
    
- **Copie intégrale annotée du DEX d'origine (surlignage par champ)**
    
    > Exigence ajoutée en cours de projet : *« produire en plus du résultat lesmêmes fichiers que ceux d'entrée avec les parties à conserver mises enévidence selon leur catégorie, pour permettre un copier-coller intuitif dechacune de ces parties vers un formulaire externe sans API donc en manuelpour l'instant »*.
    > 
    - Une copie `.docx` de l'original (`<nom>_ANNOTE.docx`) où **chaque passageretenu pour un champ CAST'IN est surligné** (fond de caractère/cellule,`<w:shd>`) dans une **couleur dédiée à ce champ**.
    - Une **légende** est insérée en tête du document : tableau couleur ↔ champCAST'IN ↔ onglet ↔ « section repérée » (oui/non).
    - Le contenu **non surligné** (titres, paragraphes explicatifs écartés par larègle 2) **ne doit pas être copié**.
    - Toutes les autres parties du `.docx` (styles, médias, relations) sont préservées à l'identique — seul le corps du document est modifié.

- **Exigences fonctionnelles**
    
    La spécification détaillée figure dans `CAHIER_DES_CHARGES.md`. En synthèse :
    
    **Les 8 règles métier** : (1) repérage des sections **par nom** et non par numéro ; (2) **contenu utile uniquement** (titres et encarts explicatifs bleu/italique écartés) ; (3) **nettoyage** des caractères parasites ; (4) section absente → exactement « Non concerné » ; (5) « Principes et décisions » toujours **vide** ; (6) « Informations supplémentaires » **optionnel** ; (7) **aucune reformulation** ; (8) **doute = signalement** à l'Équipier Ops, l'outil ne devine jamais.
    
    **Les 23 champs CAST'IN** se répartissent en :
    - onglet *Description détaillée* (6 champs) : Lien Dossier Archi, Schéma Applicatif (liens), Description Fonctionnelle, Données de la solution, Principes et décisions (vide), Description Technique ;
    - onglet *DEX* (17 champs) : Plage de fonctionnement/maintenance, Supervision, Observabilité, Log, Sauvegardes, Servitudes et ordonnancements, Comptes et services, Certificats, Liste blanche, Flux, Support, Changement et MEP, Matière (repo), Procédures de restauration / reconstruction / resynchronisation, Informations supplémentaires ;
    - identification : n° de solution, Auteur, Responsable.
    
    **Sorties imposées** par DEX : bloc IDENTIFICATION, bloc CONTENU PAR CHAMP, bloc POINTS À VÉRIFIER (`RAS` si aucun) ; plus la copie `.docx` annotée.
    
- **Exigences non fonctionnelles**
    
    
    | **Exigence** | **Détail** |
    | --- | --- |
    | **Zéro dépendance externe** | Uniquement la bibliothèque standard Python 3.10+ (`zipfile`, `xml.etree.ElementTree`, `re`, `http.server`, `json`, `unicodedata`...). Aucun `pip install`. |
    | **Code commun unique** | Toute la logique métier réside dans `dex_castin_common.py`, importé sans duplication par les deux points d'entrée (CLI et serveur). Résultat **identique** quel que soit le mode d'utilisation. |
    | **Portabilité** | Fonctionne sous Windows (invite de commandes / « DOS »), Linux, macOS. |
    | **Sécurité / confidentialité** | Le service local n'écoute que sur `127.0.0.1` par défaut ; aucune donnée n'est conservée côté serveur (fichier temporaire supprimé après traitement) ; taille de fichier limitée à 50 Mo. |
    | **Robustesse** | Une erreur sur un fichier ne doit pas interrompre le traitement des autres (mode multi-fichiers du CLI) ; codes de retour distincts (0 = OK même avec points à vérifier, 1 = au moins un fichier en erreur, 2 = aucun fichier trouvé). |
    | **Non-régression mesurable** | Un jeu de tests automatisés doit accompagner toute évolution des règles métier, avec un score de réussite par règle. |
    |  |  |
- **Exigences techniques et de sécurité**
    
    
    | **Exigence** | **Détail** |
    | --- | --- |
    | Dépendances | Bibliothèque standard uniquement (pas d'installation tierce), pour faciliter l'homologation poste de travail. |
    | Confidentialité | Traitement **local** ; service à l'écoute sur `127.0.0.1` seulement ; **aucune donnée DEX ne quitte le poste** ; suppression des fichiers temporaires. Adapté au caractère audité/sensible des DEX. |
    | Portabilité | Windows (invite de commandes), Linux, macOS. |
    | Robustesse | Une erreur sur un fichier n'interrompt pas le lot ; codes retour distincts. |
    | Non-régression | Jeu de tests automatisés ; critère d'acceptation ≥ 95 % (score mesuré 96 %). |
- **Exemples de séquences**
    - Parcourir la structure du document (titres / styles), retrouver chaque section **par son nom normalisé** (numérotation, accents, casse ignorés), ce qui absorbe les variations de numérotation entre DEX ;
    - **Ecarter automatiquement** les titres de section et les encarts explicatifs (texte en bleu/italique du gabarit), grâce à la couleur et au style des caractères — c'est précisément le « texte encadré en jaune » à ne pas copier de l'exemple du MODOP ;
    - Isoler les **liens** (Dossier Archi, schéma ADU) et **nettoyer** les caractères parasites ;
    - Détecter les **sections manquantes** et lister les **points à vérifier** ;
    - Présenter, dans un volet, chaque champ CAST'IN avec un bouton **« Copier »** ; et produire une **copie annotée** du DEX où chaque passage est surligné dans la couleur de son champ cible
- **Architecture**
    
    ```
                     ┌─────────────────────────────────┐
                     │      dex_castin_common.py       │
                     │  règles métier, nettoyage,      │
                     │  extraction, annotation/surlign.│
                     └───────────────┬─────────────────┘
                                     │ importé par
                ┌────────────────────┴───────────────────────┐
                │                                            │
    ┌───────────────────────┐               ┌──────────────────────────────────┐
    │   dex_castin_cli.py   │               │  dex_castin_word_addin_server.py │
    │ (ligne de commande)   │               │  (service HTTP local 127.0.0.1)  │
    └───────────┬───────────┘               └────────────────┬─────────────────┘
                │ écrit                                      │ HTTP (localhost)
                ▼                                            ▼
    *_CASTIN.md / .json / _ANNOTE.docx            addin/ (Office.js : manifest,
                                                  taskpane.html/.js) -> volet Word
    ```
    
- **Livrables**
    
    
    | **Livrable** | **Fichier(s)** |
    | --- | --- |
    | Module commun (règles métier + annotation) | `dex_castin_common.py` |
    | Utilitaire ligne de commande | `dex_castin_cli.py` |
    | Service back local en script Python | `dex_castin_server.py` |
    | Service front VueJS | à compléter |
    | Documentation d'utilisation | `README.md` |
    | Dossier technico-fonctionnel | `DOSSIER_TECHNICO_FONCTIONNEL.md` |
    | Cahier des charges (ce document) | `CAHIER_DES_CHARGES.md` |
    | Jeu de tests + générateur de fixtures | `tests/run_tests.py`, `tests/docx_builder.py`, `tests/fixtures/*.docx` |
    | Rapport de tests | `tests/RAPPORT_TESTS.md` |
    | Exemples de résultats (3 blocs) | `tests/RESULTATS_EXEMPLES.md` |
    | Exemples de DEX annotés (surlignage) | `tests/fixtures/annote/*_ANNOTE.doc` |
- **Jeu de tests**
    
    8 DEX `.docx` synthétiques, couvrant cas nominaux et cas problématiques :
    
    | **Test** | **Objectif** | **Type** |
    | --- | --- | --- |
    | `01_cas_nominal_complet` | DEX complet, toutes sections présentes | Vrais positifs |
    | `02_sections_manquantes` | Sections absentes → `Non concerné` + signalement | Vrais négatifs |
    | `03_faux_positif_italique_legitime` | Contenu légitime en italique/couleur exclu à tort | Faux positif **connu/accepté** |
    | `04_faux_negatif_titre_non_standard` | Titre non standard → section non détectée | Faux négatif **connu/accepté** |
    | `05_numerotation_atypique` | Sections retrouvées malgré une numérotation différente | Vrai positif (règle 1) |
    | `06_liens_dap_adu_sections_separees` | Liens DAP/ADU agrégés depuis des sections différentes | Vrai positif (liens) |
    | `07_servitudes_absentes_non_concerne` | Absence légitime → `Non concerné` correct | Vrai négatif |
    | `08_identification_absente` | Aucune identification → 3 signalements | Vrai positif (règle 8) |
    
    ### **9**
    
- **Critères d'acceptation**
    - Score global ≥ **95 %** sur `tests/run_tests.py` (dernier score mesuré :**50/52, 96 %**), les seuls écarts tolérés étant les deux cas**volontairement** faux positif/négatif (tests 03 et 04), documentés en§10 — toute régression sur les autres tests doit être corrigée avantlivraison.
    - Pour chaque DEX de test, la copie annotée (`_ANNOTE.docx`) doit être un`.docx` valide (ZIP + XML bien formé), avec légende et surlignagecohérents avec le résultat structuré.
    - Le service local doit répondre sur `/api/health`, `/api/process-dex` et`/api/annotate-dex`.
- **Limites connues (à vérifier manuellement)**
    - **Détection des titres** : basée sur les styles Word « Titre N » /« Heading N » (ou `outlineLvl`, y compris styles personnalisés via`basedOn`). Un DEX dont les titres ne suivent pas ces styles ne sera pascorrectement segmenté (cf test 04).
    - **Détection des paragraphes "explicatifs"** : heuristique (italique +couleur non standard). Un paragraphe métier légitime entièrement enitalique et coloré serait, lui aussi, écarté (cf test 03).
    - **Champs composés** (« Matière (repo) », « Changement et MEP ») : si lastructure du DEX diffère fortement du gabarit standard, vérifier les« Points à vérifier ».
    - **Annotation / surlignage** : en cas de chevauchement entre champs (rare),un même paragraphe ne peut porter qu'une seule couleur (la dernièreappliquée dans l'ordre des champs CAST'IN).
    - Tous les éléments listés dans « Points à vérifier auprès de l'ÉquipierOps » doivent être traités avant la saisie définitive dans CAST'IN (règle8 : l'outil ne devine pas).
- **Gains attendus**
    
    La majeure partie des 20 min/DEX est consommée par la **localisation des sections, le tri du contenu à copier, le nettoyage et les vérifications** — précisément ce que l'outil supprime. Subsistent un **socle manuel incompressible** : connexion (amortie sur une session), recherche/sélection de version, les collages, la vérification et l'export PDF.
    
    > **Hypothèse à valider sur DEX réels** : objectif ≈ **10 min/DEX** en mode assisté, soit **~45–55 % de réduction**.
    > 
- **Risques et points à valider**
    - **Schémas / images** : confirmer que l'éditeur CAST'IN accepte le **collage d'images** (le MODOP demande de copier « les schémas »). La copie annotée facilite leur report manuel.
    - **Styles de titres** : la segmentation repose sur les styles « Titre N / Heading N ». Un DEX hors gabarit peut être mal découpé (limite connue).
    - **Heuristique du texte explicatif** : un contenu métier légitime entièrement en bleu/italique serait écarté à tort (limite connue).
    - **Variance du stock réel** vs jeux de tests synthétiques : à mesurer en pilote.
- **Évolutions possibles**
    - Plugin Word (Office.js et macro VBA ou Python)
    - Génération d'un export structuré pour import CAST'IN si une API ou unformat d'import devient disponible (à partir du JSON déjà produit).
    - Configuration externe (fichier JSON) des mots-clés de repérage de section,pour s'adapter à des gabarits DEX alternatifs sans modifier le code.
    - Détection configurable de la couleur des paragraphes "explicatifs" selonl'organisation.
    - Gestion fine des chevauchements de surlignage entre champs CAST'IN.
#@FILE_END
