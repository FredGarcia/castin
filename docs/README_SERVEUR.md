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
