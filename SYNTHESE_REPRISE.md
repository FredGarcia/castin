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
