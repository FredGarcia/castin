# Jeu de tests **auto-référentiel** — résultats attendus

Ces DEX décrivent **l'application de reprise elle-même** (serveur stdlib sur 127.0.0.1,
front Vue sans build, Store `events.jsonl` / `analyses.jsonl`, mono-poste, règles R1–R8)
comme une **solution à reprendre dans CAST'IN** : l'outil qui aide à reprendre des DEX est
lui-même décrit dans un DEX qu'il traite — d'où l'aspect quasi **récursif**. Le contenu est
tiré des **données réelles du projet**.

**Lancement par lot** : onglet « Reprise assistée » → bouton « …ou un dossier de DEX
(traitement par lot) » → sélectionner **ce dossier** (`dex_tests_self/`). Régénération :
`python generer_dex_self.py <un_DEX_de_reference.docx>`.

`Abouti` = champs repérés (source localisée). Bandes de confiance sur les 23 champs.

| # | Fichier | Sol. | Abouti | élevée | moyenne | faible | (vide) | ⚐ | points | Démontre |
|---|---------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|---|
| 1 | DEX_SELF_S70001_Nominal.docx | S70001 | 22 | 17 | 5 | 0 | 1 | 0 | 0 | l'application **entièrement décrite** → repérage maximal ; *Principes* (décisions d'archi réelles) **ignoré par R5** ; liens DAP/ADU en texte → moyenne |
| 2 | DEX_SELF_S70002_MonoPoste.docx | S70002 | 18 | 13 | 5 | **4** | 1 | 0 | 4 | Certificats / Comptes / Liste blanche / Servitudes **sans objet en local** → Non concerné (4 points à confirmer comme légitimes) |
| 3 | DEX_SELF_S70003_Ambigu.docx | S70003 | 22 | 16 | 6 | 0 | 1 | **1** | 1 | doublon « Architecture technique » → *Description technique* **ambiguë** |
| 4 | DEX_SELF_S70004_EncartMeta.docx | S70004 | 22 | 17 | 5 | 0 | 1 | 0 | 0 | un encart qui **explique R2** est lui-même **écarté** (clin d'œil récursif) |

## Détail et assertions

### S70001 — Application décrite (nominal auto-référentiel)
- **Attendu** : `solution=S70001`, auteur « Equipe DEX-CASTIN », responsable « Architecte
  (Axiome 7E) ». 22 champs repérés, **0 point**.
- **Clin d'œil R5** : la section *Principes et décisions* contient les vraies décisions du
  projet (zéro dépendance, moteur read-only, R7, déterminisme, RGAA/WCAG/DSFR) — et reste
  **vide** (`kind=empty`). L'outil **ignore les principes du projet qui l'a engendré**.
- **Liens** : DAP7001 / ADU7001 en **texte** → repérés via motif, contenu propre, **confiance
  moyenne 0,65** (contenu court).

### S70002 — Profil mono-poste (Non concerné légitimes)
- **Contenu** : sections *Certificats*, *Comptes de service*, *Liste blanche*, *Servitudes*
  **omises** car **sans objet** pour un service local 127.0.0.1.
- **Attendu** : ces 4 champs « **Non concerné** » (confiance **0,3** → 4 « faible »), **4 points**.
- **Lecture** : agrégats identiques à un DEX « sections manquantes », mais ici l'absence est
  **légitime** — l'opérateur confirmera « Non concerné » plutôt que de corriger.

### S70003 — Ambiguïté technique
- **Contenu** : **deux** sections « Architecture technique » (doublon).
- **Attendu** : *Description technique* **ambiguë** (badge ⚐), **2 candidats**, confiance
  **0,70** (plafond ambiguïté), **1 point**.

### S70004 — Encart méta (récursif)
- **Contenu** : un **encart d'aide** (italique + bleu) qui **décrit la règle R2** elle-même.
- **Attendu** : l'encart est **écarté** du contenu (R2) — la note expliquant qu'il faut écarter
  les encarts est, elle aussi, écartée. Agrégats = nominal.

## Note de sémantique

« faible » = champ **requis absent** (0,3) ; « (vide) » = *Principes et décisions* (R5,
toujours 1) ; liens en **texte court** → **moyenne** (~0,65). Ces oracles sont **observés sur
exécution réelle** du moteur.
