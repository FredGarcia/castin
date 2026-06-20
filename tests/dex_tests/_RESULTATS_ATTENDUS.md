# Jeu de tests DEX — résultats attendus (index du dossier)

**24 fichiers** `.docx` de test pour l'outil de reprise CAST'IN. Détail complet,
assertions par règle et mode opératoire : voir **`../TEST_PLAN.md`**. Régénération :
**`../generer_dex_tests.py`**.

**Lancement par lot** : onglet « Reprise assistée » → bouton « …ou un dossier de DEX
(traitement par lot) » → sélectionner **ce dossier** (ce `.md` est ignoré ; seuls les
`.docx` sont traités), puis onglet « Historique » pour confronter aux valeurs ci-dessous.

`Abouti` = champs repérés (source localisée). Bandes de confiance sur les 23 champs
(élevée + moyenne + faible + vide = 23).

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

Rappels de sémantique : « faible » = champ **requis absent** (0,3), pas un mauvais repérage ;
« contenu court » → **moyenne 0,75** ; « optionnel absent » → **0,85** ; « (vide) » = champ
« Principes et décisions » (R5, toujours 1). Une **section présente mais vide** est comptée
« aboutie » (source localisée) tout en restant à **0,3** (« Non concerné »).
