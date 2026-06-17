# Reprise DEX → CAST'IN — Automatisation Python

Automatisation de la reprise des **Dossiers d'Exploitation (DEX)** au format
Word (`.docx`) vers l'outil **CAST'IN**, conformément aux règles définies dans
le « Prompt de reprise DEX → CAST'IN » (`Prompt_Reprise_DEX_vers_CASTIN.md`).

Outil **mono-poste, zéro-dépendance** d'aide à la reprise des Dossiers d'Exploitation
(DEX) Word vers CAST'IN. Aucune API CAST'IN n'est utilisée : le collage final reste
**manuel**, guidé par une **copie en réalité augmentée** (cadres / étiquettes /
flèches par champ) et un **contenu prêt à coller** par champ. L'outil **ne devine
jamais** et **ne reformule jamais** le contenu métier (règles 7 et 8).

## Choix d'architecture : zéro dépendance, code commun partagé

Fichiers Python, **uniquement bibliothèque standard** (`zipfile`,
`xml.etree.ElementTree`, `http.server`, `re`, `json`...) :

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

| Fichier | Rôle |
|---|---|
| **`dex_castin_common.py`** | **Cœur commun** : lit un `.docx` (sans `python-docx`), repère les sections par leur **nom**, nettoie le contenu, et produit les 3 blocs de sortie (Identification / Champs CAST'IN / Points à vérifier). Importé par les deux scripts ci-dessous. |
| **`dex_castin_cli.py`** | **Utilisation autonome** (« sur DOS ») : ligne de commande, traite un ou plusieurs `.docx`, écrit un rapport `.md` (et `.json` sur demande). |
| **`dex_castin_word_addin_server.py`** | **Intégration Word via Office.js** : petit serveur HTTP local que le complément Office.js (dossier `addin/`) appelle pour analyser le document Word ouvert. |

Les deux scripts d'entrée **n'implémentent aucune règle métier** : toute la
logique de reprise est dans `dex_castin_common.py`, afin de garantir un
résultat **identique** quel que soit le mode d'utilisation.
Les **trois `.py` sont côte à côte** (le back importe le moteur). Les deux JSON de
`donnees/` sont **créés automatiquement** ; ne rien y déposer sauf éventuellement une copie canonique pour des valeurs de départ précises).
## Pré-requis

- **Python 3.10+** (utilisation de `from __future__ import annotations` et de
  l'union de types `X | None`).
 - Aucune installation (`pip install`) nécessaire.
 - Aucune installation tierce. 
 - Le service écoute sur `127.0.0.1` par défaut — **ne pas exposer hors du poste**.


## 1) Utilisation autonome (ligne de commande / invite de commandes Windows « DOS »)

```bat
cd dex_castin_automation
python dex_castin_cli.py "C:\dossiers\DEX_S12345_MaSolution.docx"
```

Options :

```bash
# Plusieurs fichiers, motif *.docx développé automatiquement (y compris sous Windows)
python dex_castin_cli.py *.docx

# 1) reprise par lot (existant)
python dex_castin_cli.py "DEX_S12345_MaSolution.docx" -o ./sorties --json

# Dossier de sortie dédié
python dex_castin_cli.py DEX_S12345.docx -o ./sorties

# Génère aussi un .json (utile pour un traitement automatisé / import CAST'IN)
python dex_castin_cli.py DEX_S12345.docx --json

# 2) poste assisté (back + front servi sur 127.0.0.1)
python dex_castin_server.py --front ./front
#   -> ouvrir http://127.0.0.1:8765

# 3) démonstration / non-régression du back
python outils/smoke_serveur.py
# python dex_castin_server.py --host 127.0.0.1 --port 8765 --data-dir ./donnees --front ./front
```

Pour chaque DEX, le script :

1. affiche à l'écran les **3 blocs** attendus (IDENTIFICATION, CONTENU PAR
   CHAMP CAST'IN, POINTS À VÉRIFIER) ;
2. écrit `<nom_du_fichier>_CASTIN.md` (et `.json` si demandé) dans le dossier
   de sortie.

Le fichier `.md` peut être ouvert à côté de CAST'IN pour copier-coller chaque
champ.

## 2) Intégration dans Word via Office.js

### a. Démarrer le service local

```bash
cd dex_castin_automation
python dex_castin_word_addin_server.py
```

Le service écoute par défaut sur `http://127.0.0.1:8943` et expose :

- `GET /api/health` — vérification de disponibilité ;
- `POST /api/process-dex` — `{ "filename": "...", "docx_base64": "..." }`
  → renvoie `{ identification, champs, points_a_verifier, markdown }`.

Variables d'environnement optionnelles :

| Variable | Rôle | Défaut |
|---|---|---|
| `DEX_HOST` | hôte d'écoute | `127.0.0.1` |
| `DEX_PORT` | port HTTP | `8943` |
| `DEX_ALLOWED_ORIGIN` | origine CORS autorisée pour le complément Office.js | `*` |

## Rappel des points traités par l'automatisation

Conformément au prompt de reprise (`Prompt_Reprise_DEX_vers_CASTIN.md`) :

- **Règle 1 — Repérage par NOM** : les sections sont retrouvées par le
  texte de leur titre (normalisé : numérotation, accents et casse ignorés),
  jamais par leur numéro de chapitre (qui varie d'un DEX à l'autre). Les
  numéros (`~2.1`, `~13.3`...) ne sont que des indices documentaires.
- **Règle 2 — Contenu utile uniquement** : les titres de section ne sont pas
  repris ; les paragraphes **entièrement en italique et en couleur**
  (texte explicatif type « bleu/italique ») sont détectés et **écartés**.
- **Règle 3 — Nettoyage des caractères parasites** : espaces insécables,
  caractères de contrôle, puces de polices « symboles » (Wingdings/Symbol),
  lignes vides en excès.
- **Règle 4 — Information absente** : tout champ dont la section source est
  introuvable est rempli avec exactement `Non concerné`.
- **Règle 5 — « Principes et décisions »** : toujours laissé vide.
- **Règle 6 — « Informations supplémentaires »** : optionnel (contenu après
  la section Resynchronisation + section « Assets mainframe » si présente).
- **Règle 7 — Pas de reformulation** : le contenu est nettoyé/réorganisé,
  jamais réécrit.
- **Règle 8 — Doute = signalement** : toute section introuvable, ambiguë ou
  toute identification (numéro de solution, auteur, responsable) non
  retrouvée est listée dans **« Points à vérifier auprès de l'Équipier
  Ops »** (`RAS` si aucun doute).

### Champs CAST'IN couverts

**Onglet « Description détaillée »** : Lien Dossier Archi (DAP…) [lien
uniquement], Schéma Applicatif (ADU…) [lien uniquement], Description
Fonctionnelle, Données de la solution, Principes et décisions (vide),
Description Technique.

**Onglet « DEX »** : Plage de fonctionnement / maintenance, Supervision,
Observabilité, Log, Sauvegardes, Servitudes et ordonnancements, Comptes et
services, Certificats, Liste blanche, Flux, Support, Changement et MEP,
Matière (repo) [+ recherche « Merge Request »], Procédure de restauration,
Procédure de reconstruction, Procédure de resynchronisation, Informations
supplémentaires (optionnel).

### Identification extraite

Numéro de solution (format `Sxxxx`, depuis le nom de fichier ou le début du
document), Auteur (page de garde), Responsable (page 2, ou nom du service à
défaut).

## Jeu de tests (DEX d'exemple, faux positifs / faux négatifs)

Le dossier `tests/` contient un jeu de DEX `.docx` synthétiques (générés par
`tests/docx_builder.py`) couvrant des cas nominaux et des cas volontairement
problématiques, avec un score de réussite par test et par règle métier :

```bash
cd dex_castin_automation/tests
python3 run_tests.py            # génère les .docx (si absents) et exécute les vérifications
python3 run_tests.py --rebuild  # régénère systématiquement les .docx
```

Le script affiche un rapport console et écrit `tests/RAPPORT_TESTS.md`
(score global, score par traitement/règle, détail par test).

| Test | Objectif | Type |
|---|---|---|
| `01_cas_nominal_complet` | DEX complet, toutes sections présentes, bien structurées | Vrais positifs |
| `02_sections_manquantes` | Sections absentes → `Non concerné` + signalement | Vrais négatifs |
| `03_faux_positif_italique_legitime` | Contenu métier légitime en italique/couleur → exclu à tort | **Faux positif connu** |
| `04_faux_negatif_titre_non_standard` | Section présente mais titre non reconnu → non détectée | **Faux négatif connu** |
| `05_numerotation_atypique` | Sections présentes mais numérotées très différemment → retrouvées par leur nom | Vrai positif (règle 1) |
| `06_liens_dap_adu_sections_separees` | Lien DAP et référence ADU dans des sections différentes → agrégés | Vrai positif (liens) |
| `07_servitudes_absentes_non_concerne` | Absence légitime de servitudes → `Non concerné` correct | Vrai négatif |
| `08_identification_absente` | Aucune identification présente → 3 signalements | Vrai positif (règle 8) |

Dernier score global mesuré : **50/52 (96 %)** — les 2 seuls écarts
correspondent aux deux cas **volontairement** faux positif/négatif (tests 03
et 04), qui matérialisent les limites ci-dessous (et non une régression).

## Limites connues (à vérifier manuellement)

- La détection des titres se base sur les styles **« Titre N » / « Heading N »**
  de Word (ou `outlineLvl`). Un DEX dont les titres ne sont pas mis en forme
  avec ces styles ne sera pas correctement segmenté.
- La détection des paragraphes « explicatifs » (italique + couleur) est une
  **heuristique** : un paragraphe légitime entièrement en italique et coloré
  serait, lui aussi, écarté. En cas de doute, relire le `.md` généré et
  comparer au DEX source.
- Le champ « Matière (repo) » et « Changement et MEP » combinent plusieurs
  sections : si la structure du DEX diffère fortement du gabarit standard,
  vérifier les « Points à vérifier ».
- Tous les cas signalés dans **« Points à vérifier auprès de l'Équipier
  Ops »** doivent être traités avant la saisie définitive dans CAST'IN
  (conformément à la règle 8 : « ne devine pas »).

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

### Calibration isotonique + routage par seuil (versionnés, rangés)

Pour rendre la confiance *fiable* et router l'attention de façon optimale :

```bash
python outils/calibrer.py                 # ajuste la carte score_brut→acceptation (PAV) -> candidat
python outils/calibrer.py --verifier --rules donnees/regles.candidate.json   # gate (monotonie + ECE)
# copier le candidat validé vers donnees/regles.json, fixer "seuil_routage" (>0), puis recharger
```

Défaut **neutre** (calibration inactive, seuil 0 → identique au moteur). Une fois
active, la calibration et le seuil sont des **artefacts versionnés rangés** : la
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
