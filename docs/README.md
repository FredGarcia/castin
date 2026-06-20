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
