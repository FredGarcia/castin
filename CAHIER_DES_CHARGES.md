# Cahier des charges — Automatisation « Reprise DEX → CAST'IN »

> Document de spécification recomposé **a posteriori** à partir des travaux
> réalisés (code, tests, documentation), pour servir de référence formelle au
> périmètre livré et aux évolutions futures. Il consolide le « Prompt de
> reprise DEX → CAST'IN » initial et les demandes complémentaires exprimées en
> cours de réalisation.

## 1. Contexte et objectif

Les **Dossiers d'Exploitation (DEX)** sont rédigés au format Word (`.docx`)
selon un gabarit standard, et doivent être **repris manuellement** dans
l'outil **CAST'IN** (saisie champ par champ, sans API disponible à ce jour).
Cette reprise est répétitive, source d'erreurs (copier-coller du mauvais
paragraphe, oubli de section, contenu explicatif copié par erreur...) et
chronophage.

**Objectif** : outiller cette reprise pour qu'un Équipier Ops puisse, à partir
d'un DEX `.docx`, obtenir rapidement :

1. le **contenu prêt à coller** pour chaque champ CAST'IN (texte nettoyé,
   liens isolés) ;
2. la liste des **points à vérifier** (information absente, ambiguë, ou non
   retrouvée) ;
3. une **copie surlignée du DEX d'origine**, pour identifier en un coup d'œil
   quel passage va dans quel champ CAST'IN.

Sans jamais reformuler le contenu métier, et sans appel à une API CAST'IN
(non disponible).

## 2. Périmètre

### 2.1 Dans le périmètre

- Lecture d'un DEX au format `.docx` (et uniquement ce format).
- Application des règles de reprise définies en §3 (règles 1 à 8 du prompt de
  référence).
- Production de trois sorties par DEX traité :
  - le **rendu structuré** (Markdown / JSON) des 23 champs CAST'IN +
    identification + points à vérifier ;
  - une **copie annotée** (`.docx`) du DEX d'origine, surlignée par champ ;
  - dans le cas du complément Word, un **affichage interactif** dans le volet
    Office avec copie en un clic.
- Deux modes d'exécution :
  - **autonome** (ligne de commande / DOS), sans environnement Word ;
  - **intégré à Word** via un complément Office.js + service local.
- Un jeu de tests automatisés (DEX synthétiques) mesurant la fiabilité de
  chaque règle métier.

### 2.2 Hors périmètre

- Toute **saisie automatique dans CAST'IN** (pas d'API CAST'IN disponible :
  la saisie finale reste manuelle, le copier-coller).
- La **génération** du contenu d'un DEX : le DEX `.docx` est une donnée
  d'entrée, jamais produite ni modifiée sur le fond (le contenu métier n'est
  ni reformulé ni réécrit, cf règle 7).
- La prise en charge de formats autres que `.docx` (pas de PDF, `.doc`
  binaire, etc.).
- L'authentification / la gestion multi-utilisateurs (outil mono-poste, local).

## 3. Règles métier de reprise (issues du prompt de référence)

| # | Règle | Exigence |
|---|---|---|
| 1 | **Repérage par NOM** | Les sections sources sont retrouvées par le **texte normalisé de leur titre** (numérotation, accents, casse, ponctuation ignorés). Le numéro de chapitre indiqué dans le gabarit (`~2.1`, `~13.3`...) n'est qu'un **indice documentaire**, jamais un critère de recherche : la numérotation réelle varie d'un DEX à l'autre. |
| 2 | **Contenu utile uniquement** | Les titres de section ne sont pas repris. Les paragraphes **entièrement en italique et en couleur non standard** (encarts d'aide bleu/italique du gabarit) sont détectés et **écartés** du contenu repris. |
| 3 | **Nettoyage des caractères parasites** | Suppression/normalisation : espaces insécables et fines, caractères de contrôle et marqueurs invisibles (BOM, marques de direction, espaces de largeur nulle), puces de polices "symboles" (Wingdings/Symbol, zone Unicode *Private Use Area*) converties en `- `, espaces multiples et lignes vides en excès compressés. |
| 4 | **Information absente** | Tout champ dont la section source est introuvable est rempli avec **exactement** la chaîne `Non concerné` (et signalé, cf règle 8). |
| 5 | **« Principes et décisions »** | Toujours **laissé vide**, quel que soit le contenu du DEX. |
| 6 | **« Informations supplémentaires »** | **Optionnel** : vide si absent (pas de signalement), renseigné s'il existe un contenu après la section "Resynchronisation" et/ou une section "Assets mainframe". |
| 7 | **Pas de reformulation** | Le contenu est **nettoyé et réorganisé** (règles 2 et 3), jamais réécrit, paraphrasé ou résumé. |
| 8 | **Doute = signalement** | Toute section introuvable, ambiguë, ou toute information d'identification (n° de solution, auteur, responsable) non retrouvée est listée dans **« Points à vérifier auprès de l'Équipier Ops »**. La liste affiche `RAS` si aucun doute. **L'outil ne devine jamais.** |

## 4. Champs CAST'IN couverts (23 champs)

### 4.1 Onglet « Description détaillée »

| Champ | Type | Source (indicative, retrouvée par nom — règle 1) |
|---|---|---|
| Lien Dossier Archi (DAP…) | Lien uniquement | ~2.2 Architecture fonctionnelle & applicative |
| Schéma Applicatif (ADU…) | Lien uniquement | ~2.2 (ou ~2.1) Architecture fonctionnelle & applicative / Description de la solution |
| Description Fonctionnelle | Texte | ~2.1 Description de la solution |
| Données de la solution | Texte | ~2.3 Données |
| Principes et décisions | Vide (règle 5) | — |
| Description Technique | Texte | ~4.1 Architecture technique |

### 4.2 Onglet « DEX »

| Champ | Type | Source (indicative) |
|---|---|---|
| Plage de fonctionnement / maintenance | Texte | ~3.3 Plages de fonctionnement |
| Supervision | Texte (chapitre entier) | ~6 Supervision |
| Observabilité | Texte | ~9/11 Métrologie |
| Log | Texte | ~8.2 Diagnostique / LOG / Trace |
| Sauvegardes | Texte | ~7 Sauvegarde |
| Servitudes et ordonnancements | Texte | ~9 Servitudes (sinon `Non concerné`) |
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

### 4.3 Identification

| Information | Source |
|---|---|
| Numéro de solution (`Sxxxx`) | Nom de fichier en priorité, sinon ~60 premiers paragraphes |
| Auteur | Page de garde (avant le premier titre), motif `Auteur : ...` |
| Responsable | ~60 premiers paragraphes, motif `Responsable : ...` (sinon `Service : ...`, avec signalement) |

## 5. Exigences fonctionnelles — sorties attendues

### 5.1 Rendu structuré (3 blocs imposés)

Pour chaque DEX traité :

1. **IDENTIFICATION** : Solution / Auteur / Responsable (ou `Non concerné`).
2. **CONTENU PAR CHAMP CAST'IN** : un bloc `**[Nom du champ]**` par champ,
   contenu nettoyé ou `Non concerné` / `(laisser vide)`.
3. **POINTS À VÉRIFIER AUPRÈS DE L'ÉQUIPIER OPS** : liste à puces, ou `RAS`.

Formats de sortie : Markdown (`<nom>_CASTIN.md`, toujours) et JSON optionnel
(`<nom>_CASTIN.json`, sur demande / consommé par le complément Office.js).

### 5.2 Copie annotée du DEX d'origine (surlignage par champ)

> Exigence ajoutée en cours de projet : *« produire en plus du résultat les
> mêmes fichiers que ceux d'entrée avec les parties à conserver mises en
> évidence selon leur catégorie, pour permettre un copier-coller intuitif de
> chacune de ces parties vers un formulaire externe sans API donc en manuel
> pour l'instant »*.

- Une copie `.docx` de l'original (`<nom>_ANNOTE.docx`) où **chaque passage
  retenu pour un champ CAST'IN est surligné** (fond de caractère/cellule,
  `<w:shd>`) dans une **couleur dédiée à ce champ**.
- Une **légende** est insérée en tête du document : tableau couleur ↔ champ
  CAST'IN ↔ onglet ↔ « section repérée » (oui/non).
- Le contenu **non surligné** (titres, paragraphes explicatifs écartés par la
  règle 2) **ne doit pas être copié**.
- Toutes les autres parties du `.docx` (styles, médias, relations) sont
  préservées à l'identique — seul le corps du document est modifié.
- Disponible dans les deux modes d'exécution (CLI et complément Word).

## 6. Exigences non fonctionnelles

| Exigence | Détail |
|---|---|
| **Zéro dépendance externe** | Uniquement la bibliothèque standard Python 3.10+ (`zipfile`, `xml.etree.ElementTree`, `re`, `http.server`, `json`, `unicodedata`...). Aucun `pip install`. |
| **Code commun unique** | Toute la logique métier réside dans `dex_castin_common.py`, importé sans duplication par les deux points d'entrée (CLI et serveur). Résultat **identique** quel que soit le mode d'utilisation. |
| **Portabilité** | Fonctionne sous Windows (invite de commandes / « DOS »), Linux, macOS. |
| **Sécurité / confidentialité** | Le service local n'écoute que sur `127.0.0.1` par défaut ; aucune donnée n'est conservée côté serveur (fichier temporaire supprimé après traitement) ; taille de fichier limitée à 50 Mo. |
| **Robustesse** | Une erreur sur un fichier ne doit pas interrompre le traitement des autres (mode multi-fichiers du CLI) ; codes de retour distincts (0 = OK même avec points à vérifier, 1 = au moins un fichier en erreur, 2 = aucun fichier trouvé). |
| **Non-régression mesurable** | Un jeu de tests automatisés doit accompagner toute évolution des règles métier, avec un score de réussite par règle. |

## 7. Architecture livrée

```
                 ┌───────────────────────────────┐
                 │      dex_castin_common.py       │
                 │  règles métier, nettoyage,      │
                 │  extraction, annotation/surlign.│
                 └───────────────┬─────────────────┘
                                  │ importé par
            ┌─────────────────────┴─────────────────────┐
            │                                             │
┌───────────────────────┐                 ┌──────────────────────────────────┐
│   dex_castin_cli.py     │                 │  dex_castin_word_addin_server.py  │
│ (ligne de commande)     │                 │  (service HTTP local 127.0.0.1)   │
└───────────┬─────────────┘                 └────────────────┬───────────────┘
            │ écrit                                            │ HTTP (localhost)
            ▼                                                  ▼
*_CASTIN.md / .json / _ANNOTE.docx            addin/ (Office.js : manifest,
                                               taskpane.html/.js) -> volet Word
```

Détail de l'implémentation : voir `DOSSIER_TECHNICO_FONCTIONNEL.md`. Détail
d'utilisation : voir `README.md`.

## 8. Livrables

| Livrable | Fichier(s) |
|---|---|
| Module commun (règles métier + annotation) | `dex_castin_common.py` |
| Utilitaire ligne de commande | `dex_castin_cli.py` |
| Service local pour le complément Word | `dex_castin_word_addin_server.py` |
| Complément Office.js (exemple) | `addin/manifest.xml`, `addin/taskpane.html`, `addin/taskpane.js` |
| Documentation d'utilisation | `README.md` |
| Dossier technico-fonctionnel | `DOSSIER_TECHNICO_FONCTIONNEL.md` |
| Cahier des charges (ce document) | `CAHIER_DES_CHARGES.md` |
| Jeu de tests + générateur de fixtures | `tests/run_tests.py`, `tests/docx_builder.py`, `tests/fixtures/*.docx` |
| Rapport de tests | `tests/RAPPORT_TESTS.md` |
| Exemples de résultats (3 blocs) | `tests/RESULTATS_EXEMPLES.md` |
| Exemples de DEX annotés (surlignage) | `tests/fixtures/annote/*_ANNOTE.docx` |

## 9. Plan de test et critères d'acceptation

### 9.1 Jeu de tests

8 DEX `.docx` synthétiques, couvrant cas nominaux et cas volontairement
problématiques :

| Test | Objectif | Type |
|---|---|---|
| `01_cas_nominal_complet` | DEX complet, toutes sections présentes | Vrais positifs |
| `02_sections_manquantes` | Sections absentes → `Non concerné` + signalement | Vrais négatifs |
| `03_faux_positif_italique_legitime` | Contenu légitime en italique/couleur exclu à tort | Faux positif **connu/accepté** |
| `04_faux_negatif_titre_non_standard` | Titre non standard → section non détectée | Faux négatif **connu/accepté** |
| `05_numerotation_atypique` | Sections retrouvées malgré une numérotation différente | Vrai positif (règle 1) |
| `06_liens_dap_adu_sections_separees` | Liens DAP/ADU agrégés depuis des sections différentes | Vrai positif (liens) |
| `07_servitudes_absentes_non_concerne` | Absence légitime → `Non concerné` correct | Vrai négatif |
| `08_identification_absente` | Aucune identification → 3 signalements | Vrai positif (règle 8) |

### 9.2 Critère d'acceptation

- Score global ≥ **95 %** sur `tests/run_tests.py` (dernier score mesuré :
  **50/52, 96 %**), les seuls écarts tolérés étant les deux cas
  **volontairement** faux positif/négatif (tests 03 et 04), documentés en
  §10 — toute régression sur les autres tests doit être corrigée avant
  livraison.
- Pour chaque DEX de test, la copie annotée (`*_ANNOTE.docx`) doit être un
  `.docx` valide (ZIP + XML bien formé), avec légende et surlignage
  cohérents avec le résultat structuré.
- Le service local doit répondre sur `/api/health`, `/api/process-dex` et
  `/api/annotate-dex`.

## 10. Limites connues (acceptées, à vérifier manuellement)

- **Détection des titres** : basée sur les styles Word « Titre N » /
  « Heading N » (ou `outlineLvl`, y compris styles personnalisés via
  `basedOn`). Un DEX dont les titres ne suivent pas ces styles ne sera pas
  correctement segmenté (cf test 04).
- **Détection des paragraphes "explicatifs"** : heuristique (italique +
  couleur non standard). Un paragraphe métier légitime entièrement en
  italique et coloré serait, lui aussi, écarté (cf test 03).
- **Champs composés** (« Matière (repo) », « Changement et MEP ») : si la
  structure du DEX diffère fortement du gabarit standard, vérifier les
  « Points à vérifier ».
- **Annotation / surlignage** : en cas de chevauchement entre champs (rare),
  un même paragraphe ne peut porter qu'une seule couleur (la dernière
  appliquée dans l'ordre des champs CAST'IN).
- Tous les éléments listés dans « Points à vérifier auprès de l'Équipier
  Ops » doivent être traités avant la saisie définitive dans CAST'IN (règle
  8 : l'outil ne devine pas).

## 11. Évolutions possibles (hors périmètre actuel)

- Génération d'un export structuré pour import CAST'IN si une API ou un
  format d'import devient disponible (à partir du JSON déjà produit).
- Configuration externe (fichier JSON) des mots-clés de repérage de section,
  pour s'adapter à des gabarits DEX alternatifs sans modifier le code.
- Détection configurable de la couleur des paragraphes "explicatifs" selon
  l'organisation.
- Gestion fine des chevauchements de surlignage entre champs CAST'IN.
