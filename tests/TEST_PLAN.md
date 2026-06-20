# Plan de tests — Reprise CAST'IN (jeu de 13 DEX)

## 1. Objectif

Vérifier le comportement de repérage et de scoring du moteur sur un jeu de DEX
couvrant les situations métier attendues : nominal, ambiguïté, sections absentes,
encarts d'aide, caractères parasites, champ « toujours vide », champ optionnel
absent, contenu court, liens, champ « merge », procédures, DEX minimal, et
identifiant de solution porté par le contenu plutôt que par le nom de fichier.

Les **résultats attendus** ci-dessous ont été **observés sur exécution réelle** des
24 fichiers à travers le moteur (`process_path` + règles par défaut). Ils servent
d'oracle de non-régression : toute évolution du moteur ou des règles doit laisser
ces sorties inchangées, sauf décision explicite.

## 2. Jeu de fichiers

Répertoire : `dex_tests/` (24 fichiers `.docx`). Chaque test — sauf le minimal —
part d'un DEX **complet** (les 23 champs repérables sont alimentés) auquel **une seule
variation** est appliquée, afin que l'écart attendu soit isolé et lisible.

Génération reproductible : `generer_dex_tests.py` (stdlib seule ; parts statiques
`styles/content-types/rels` reprises d'un DEX valide, seul `word/document.xml` varie).

## 3. Comment lancer

### 3.1 Par l'interface (recommandé — traitement par lot)

1. Démarrer le serveur, puis ouvrir l'interface dans le navigateur :
   `PYTHONPATH=/mnt/user-data/uploads python3 dex_castin_server.py --front front`
2. Onglet **« Reprise assistée »** → bouton **« …ou un dossier de DEX (traitement par
   lot) »** → sélectionner le dossier `dex_tests/`.
3. Le lot s'exécute séquentiellement ; la ligne de progression indique
   `n/total traité(s) — k ✓, j échec(s)`. Chaque DEX est journalisé.
4. Onglet **« Historique »** → table « Détail des DEX analysés » : une ligne par DEX,
   colonnes **Abouti / élevée / moyenne / faible / (vide) / ⚐ ambigus / points**.
   Comparer aux valeurs du tableau §4. Les compteurs **non nuls** sont cliquables :
   le clic **ouvre le DEX de la ligne** puis n'y **déplie que les cartes du groupe**
   de la colonne cliquée.

> Note d'environnement : la ré-ouverture depuis l'Historique s'appuie sur les fichiers
> **importés dans la session courante** (le navigateur n'expose pas les chemins absolus).
> Re-sélectionner le dossier rend les lignes ré-ouvrables.

### 3.2 En automatisé (hors interface)

```
cd <dossier de travail>
python3 generer_dex_tests.py                 # (re)génère dex_tests/
PYTHONPATH=/mnt/user-data/uploads python3 - <<'PY'
import glob, os, dex_castin_server as srv
for f in sorted(glob.glob("dex_tests/*.docx")):
    e = srv.process_path(f, os.path.basename(f), srv.DEFAULT_RULES)
    print(os.path.basename(f), srv._resume_analyse(e, os.path.basename(f)))
PY
```

## 4. Tableau récapitulatif (sortie attendue)

`abouti` = nombre de champs **repérés** (source localisée dans le document). Les bandes
de confiance couvrent **les 23 champs** (élevée + moyenne + faible + vide = 23).

| # | Fichier | Sol. | Abouti | élevée | moyenne | faible | (vide) | ⚐ | points | Démontre |
|---|---------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|---|
| 01 | DEX_S30001_Nominal.docx | S30001 | 22 | 19 | 3 | 0 | 1 | 0 | 0 | R2 — encart d'aide écarté |
| 02 | DEX_S30002_Ambigu.docx | S30002 | 22 | 18 | 4 | 0 | 1 | **1** | 1 | ambiguïté (2 titres « Supervision ») |
| 03 | DEX_S30003_SectionsManquantes.docx | S30003 | 18 | 15 | 3 | **4** | 1 | 0 | 4 | R4 ; « faible » = requis absents (0,3) |
| 04 | DEX_S30004_Encarts.docx | S30004 | 22 | 19 | 3 | 0 | 1 | 0 | 0 | R2 — encarts multiples écartés |
| 05 | DEX_S30005_Parasites.docx | S30005 | 22 | 19 | 3 | 0 | 1 | 0 | 0 | R3 — puce/espaces normalisés |
| 06 | DEX_S30006_PrincipesVide.docx | S30006 | 22 | 19 | 3 | 0 | 1 | 0 | 0 | R5 — « Principes » toujours vide |
| 07 | DEX_S30007_InfosSupplAbsent.docx | S30007 | 21 | 20 | 2 | 0 | 1 | 0 | 0 | R6 — optionnel absent → 0,85 |
| 08 | DEX_S30008_ContenuCourt.docx | S30008 | 22 | 15 | 7 | 0 | 1 | 0 | 0 | contenu court → moyenne 0,75 |
| 09 | DEX_S30009_LiensAbsents.docx | S30009 | 21 | 17 | 3 | **2** | 1 | 0 | 1 | lien absent ; repli par mot-clé |
| 10 | DEX_S30010_MergePartiel.docx | S30010 | 21 | 19 | 2 | 1 | 1 | 0 | 1 | champ merge partiel |
| 11 | DEX_S30011_ProceduresManquantes.docx | S30011 | 19 | 16 | 3 | **3** | 1 | 0 | 3 | R4 sur les 3 procédures |
| 12 | DEX_S30012_Minimal.docx | S30012 | 0 | 1 | 0 | **21** | 1 | 0 | 21 | DEX quasi vide |
| 13 | DEX_sans_identifiant_dans_le_nom.docx | S30013 | 22 | 19 | 3 | 0 | 1 | 0 | 1 | identifiant via le **contenu** |
| 14 | DEX_IdentifiantIntrouvable.docx | — | 22 | 19 | 3 | 0 | 1 | 0 | 1 | aucun identifiant → **solution=None** (pas d'erreur) |
| 15 | DEX_S30015_ItaliqueSeulConserve.docx | S30015 | 22 | 19 | 3 | 0 | 1 | 0 | 0 | italique **seul** → conservé (R2) |
| 16 | DEX_S30016_BleuSeulConserve.docx | S30016 | 22 | 19 | 3 | 0 | 1 | 0 | 0 | bleu **seul** → conservé (R2) |
| 17 | DEX_S30017_LiensTexte.docx | S30017 | 22 | 17 | 5 | 0 | 1 | 0 | 0 | DAP/ADU en **texte** → repérés via motif |
| 18 | DEX_S30018_SectionVide.docx | S30018 | 22 | 18 | 3 | 1 | 1 | 0 | 0 | section **vide** → « Non concerné » 0,3 (source localisée) |
| 19 | DEX_S30019_Tableau.docx | S30019 | 22 | 19 | 3 | 0 | 1 | 0 | 0 | contenu en **tableau** Word → lu |
| 20 | DEX_S30020_CasseAccents.docx | S30020 | 22 | 19 | 3 | 0 | 1 | 0 | 0 | titres **MAJUSCULES/accents** → repérés |
| 21 | DEX_S30021_IdentificationPartielle.docx | S30021 | 22 | 19 | 3 | 0 | 1 | 0 | 2 | auteur/responsable absents → None (2 points) |
| 22 | DEX_S30022_PucesVariees.docx | S30022 | 22 | 19 | 3 | 0 | 1 | 0 | 0 | palette de **puces** → normalisées (R3) |
| 23 | DEX_S30023_MergeRequestHorsSection.docx | S30023 | 21 | 19 | 2 | 1 | 1 | 0 | 0 | « merge request » → références listées (extra_search) |
| 24 | DEX_S30024_TitresDesordre.docx | S30024 | 22 | 19 | 3 | 0 | 1 | 0 | 0 | ordre inversé → **R1** inchangé |

### Lecture des bandes de confiance (sémantique du moteur)

- **(vide)** = 1 dans tous les cas : c'est **« Principes et décisions »**, champ
  systématiquement vide par règle (R5, `kind=empty`), indépendamment du contenu.
- **faible** correspond ici aux **champs requis absents** (confiance 0,3), et non à des
  repérages de mauvaise qualité — voir §5.3 et §5.11. C'est pourquoi un DEX très lacunaire
  (Minimal) affiche 21 « faible ».
- Un **champ optionnel absent** reste en **confiance élevée** (0,85) — voir §5.7.
- Un **contenu court** (< 15 caractères) bascule en **confiance moyenne** (0,75), pas
  « faible » — voir §5.8.
- Une **section présente mais vide** est comptée « **aboutie** » (source localisée) tout
  en restant en « faible » à **0,3** (« Non concerné ») — voir §5.18.
- Des **liens en texte court** (DAP/ADU sans hyperlien) sont repérés mais en **moyenne**
  (≈0,65, malus contenu court) — voir §5.17.
- Une **identification absente ou partielle** (numéro, auteur, responsable) génère des
  **points à vérifier** sans bloquer le traitement — voir §5.14 et §5.21.

## 5. Détail par scénario et assertions clés

### 5.1 — S30001 Nominal (+ encart d'aide)
- **Contenu** : DEX complet ; un paragraphe d'aide (italique + bleu `0070C0`) inséré sous
  « Description de la solution ».
- **Attendu** : 22 champs repérés, 0 ambiguïté, 0 point à vérifier.
- **Assertion R2** : le texte de l'encart **n'apparaît pas** dans le contenu de
  `description_fonctionnelle` ; confiance du champ = **0,90**.

### 5.2 — S30002 Ambigu
- **Contenu** : deux sections au **titre identique « Supervision »** (contenus distincts).
- **Attendu** : `supervision` **ambigu = vrai**, **2 candidats**, confiance **0,70**
  (plafonnée par le malus d'ambiguïté), sélection moteur = paragraphe 15 (1ʳᵉ occurrence) ;
  **1 ⚐ ambigu**, **1 point** à vérifier.
- **Vérif. interface** : badge ⚐ sur la carte, radiogroup « Confirmer la section » présent.

### 5.3 — S30003 Sections manquantes
- **Contenu** : retrait de 4 sections requises (Supervision, Log, Sauvegardes, Certificats).
- **Attendu** : ces 4 champs **non repérés** (`source_spans` vide), confiance **0,30**
  (requis absent) → 4 en bande « faible » ; **4 points** à vérifier ; 18 repérés.
- **Assertion R4** : `supervision` et `log` sans source localisée.

### 5.4 — S30004 Encarts à écarter (R2)
- **Contenu** : encarts d'aide (italique + bleu) **dans** Supervision et Sauvegardes.
- **Attendu** : agrégats identiques au nominal (les encarts n'altèrent rien).
- **Assertion R2** : contenu de `supervision` =
  `« Supervisee par Centreon ; sondes HTTP sur les services exposes. »` — **sans** les
  mentions « Rappel » / « Astuce ».

### 5.5 — S30005 Parasites (R3)
- **Contenu** : section Supervision avec **puce de police symbole** (`•`), **espaces
  insécables** et **espaces multiples**.
- **Attendu** : agrégats identiques au nominal.
- **Assertion R3** : contenu **normalisé** en
  `« - Supervisee par Centreon ; sondes HTTP sur les services exposes. »` (puce → « - »,
  espaces compressés), **sans changer le sens** (R7).

### 5.6 — S30006 « Principes et décisions » toujours vide (R5)
- **Contenu** : la section « Principes et décisions » est **renseignée**.
- **Attendu** : `principes_decisions` reste **vide** : `kind = empty`, contenu vide,
  confiance **None** (la bande « (vide) » du tableau). Les autres champs inchangés.

### 5.7 — S30007 Champ optionnel absent (R6)
- **Contenu** : section optionnelle « Assets mainframe » **absente**.
- **Attendu** : `informations_supplementaires` **non repéré** mais **non pénalisé** :
  confiance **0,85** (bande « élevée ») ; **0 point** à vérifier.

### 5.8 — S30008 Contenu court → confiance moyenne
- **Contenu** : 4 sections au contenu < 15 caractères (« OK. », « RAS », « TLS », « ELK »).
- **Attendu** : ces champs **repérés** mais en **confiance moyenne 0,75** (malus
  « contenu court ») → bande « moyenne » à 7 ; **pas** de bascule en « faible ».
- **Assertion** : `supervision` confiance **0,75**, contenu = `« OK. »`.

### 5.9 — S30009 Liens absents
- **Contenu** : section « Architecture fonctionnelle & applicative » **retirée**.
- **Attendu** : `lien_dossier_archi` **non repéré** (`source_spans` vide).
  **Nuance importante** : `schema_applicatif` **reste repéré** car son mot-clé
  « description de la solution » correspond à une **autre** section présente — le repli
  par mot-clé est donc bien observé. 2 en « faible », 1 point.

### 5.10 — S30010 Merge partiel
- **Contenu** : section « Référentiel / dépôt de code » **retirée**.
- **Attendu** : `matiere_repo` (champ `merge`) **non repéré** ; `changement_mep` (autre
  champ `merge`) **toujours repéré** via « Changements et MEP ». 1 en « faible », 1 point.

### 5.11 — S30011 Procédures manquantes
- **Contenu** : retrait des trois procédures (restauration, reconstruction, resynchronisation).
- **Attendu** : ces 3 champs **non repérés** (0,30) → 3 en « faible », **3 points**.
- **Assertion R4** : `procedure_restauration` et `procedure_resynchronisation` sans source.

### 5.12 — S30012 Minimal
- **Contenu** : page de garde seule.
- **Attendu** : **0 champ repéré** ; 21 champs requis absents en « faible », 1 « (vide) »
  (Principes), 1 « élevée » (l'optionnel « Assets mainframe », absent mais non pénalisé) ;
  **21 points** à vérifier.

### 5.13 — Identifiant porté par le contenu
- **Contenu** : nom de fichier **sans** `Sxxxx` ; le corps contient
  `« Reference solution : S30013 »`.
- **Attendu** : solution **extraite du contenu** = **S30013** (repli du nom de fichier vers
  le contenu) ; agrégats équivalents au nominal.

### 5.14 — Identifiant introuvable (robustesse)
- **Contenu** : DEX complet, mais **aucun** numéro de solution (ni dans le nom, ni dans le contenu).
- **Attendu** : `solution = None`, **aucune exception** ; le DEX est traité ; **1 point** (numéro
  de solution introuvable). Reste des agrégats ≈ nominal.

### 5.15 — Italique seul conservé (R2)
- **Contenu** : un paragraphe en **italique non bleu** inséré dans « Supervision ».
- **Attendu** : paragraphe **conservé** dans le contenu de `supervision` (R2 n'écarte que italique
  **ET** bleu). Agrégats = nominal.

### 5.16 — Bleu seul conservé (R2)
- **Contenu** : un paragraphe en **bleu non italique** dans « Supervision ».
- **Attendu** : paragraphe **conservé**. Agrégats = nominal.

### 5.17 — Liens en texte brut
- **Contenu** : DAP/ADU écrits **en texte** (pas d'hyperlien) sous « Architecture ».
- **Attendu** : `lien_dossier_archi` et `schema_applicatif` **repérés via le motif** (`DAP…`/`ADU…`) ;
  contenu court ⇒ **confiance moyenne** (≈0,65), d'où 5 en « moyenne ».

### 5.18 — Section présente mais vide
- **Contenu** : « Supervision » présente **sans contenu** (titre suivi d'un autre titre).
- **Attendu** : `supervision` = « **Non concerné** », confiance **0,3** ; **source localisée**
  (comptée dans « abouti » = 22) mais champ en « faible ».

### 5.19 — Contenu en tableau Word
- **Contenu** : le contenu de « Supervision » est placé dans un **tableau** (`w:tbl`).
- **Attendu** : texte du tableau **correctement lu** ; agrégats = nominal.

### 5.20 — Titres en majuscules / accentués
- **Contenu** : titres « **SUPERVISION** » et « **MÉTROLOGIE** ».
- **Attendu** : `supervision` et `observabilite` **repérés** (normalisation casse/accents) ;
  agrégats = nominal.

### 5.21 — Identification partielle
- **Contenu** : page de garde **sans** « Auteur : » ni « Responsable : » (numéro S30021 présent).
- **Attendu** : `solution = S30021`, `auteur = None`, `responsable = None` ; **2 points**
  (auteur + responsable introuvables).

### 5.22 — Palette de puces de police symbole (R3)
- **Contenu** : « Supervision » avec puces variées (`• ▪ ● ◦ ‣ ·`) et tabulations.
- **Attendu** : **toutes** normalisées en « - » (R3), sens inchangé (R7) ; agrégats = nominal.

### 5.23 — « Merge request » hors section dépôt
- **Contenu** : section « Référentiel/dépôt » **absente** ; mention « merge request » ailleurs.
- **Attendu** : `matiere_repo` **non repéré** (source vide, « faible ») mais son contenu **liste
  les références « Merge Request »** trouvées (recherche complémentaire `extra_search`).

### 5.24 — Sections dans le désordre
- **Contenu** : toutes les sections présentes mais dans l'**ordre inverse**.
- **Attendu** : **repérage inchangé** (R1 par nom, indépendant de l'ordre) → 22 champs repérés ;
  agrégats = nominal.

## 6. Couverture des règles métier

| Règle | Intitulé | Scénarios couvrant |
|------|----------|--------------------|
| R1 | Repérage **par nom** de section (jamais par numéro) | tous (+ 5.20 casse/accents, 5.24 ordre) |
| R2 | Écarter les **encarts** d'aide (italique + bleu) | 5.1, 5.4 ; **non-régression** 5.15 (italique seul), 5.16 (bleu seul) |
| R3 | Nettoyer les **caractères parasites** (puces symbole, espaces) | 5.5, 5.22 |
| R4 | **« Non concerné »** si section absente (ou vide) | 5.3, 5.9, 5.10, 5.11, 5.12, 5.18 |
| R5 | « Principes et décisions » **toujours vide** | 5.6 (et la bande « (vide) » partout) |
| R6 | « Informations supplémentaires » / « Assets mainframe » **optionnel** | 5.7 |
| R7 | **Ne jamais reformuler** le contenu | 5.4, 5.5, 5.22 (contenus comparés verbatim) |
| R8 | Doutes → **« Points à vérifier »** | 5.2, 5.3, 5.9, 5.10, 5.11, 5.12, 5.14, 5.21 |
| — | **Robustesse / lecture** (motif lien, tableau, normalisation, identification) | 5.14, 5.17, 5.19, 5.20, 5.21, 5.23, 5.24 |

## 7. Critères de réussite

Le jeu est **conforme** si, pour les 24 fichiers :

1. La colonne **Solution** et le tableau **§4** sont reproduits à l'identique.
2. Chaque **assertion clé** de §5 est vérifiée (contenus verbatim, bandes de confiance,
   ambiguïté, repérage / non-repérage).
3. Côté interface : le **traitement par lot** du dossier alimente l'Historique avec
   24 lignes, les **compteurs non nuls** sont cliquables, et un clic **ouvre le DEX de la
   ligne** puis **ne déplie que les cartes du groupe** correspondant (cf. `RECETTE_FRONT.md`,
   §5bis et §5bis.4b).
