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
