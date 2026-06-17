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
python dex_castin_server.py --host 127.0.0.1 --port 8765 --data-dir ./tests --front ./front
python dex_castin_server.py --host 127.0.0.1 --port 8765 --data-dir ./donnees
python dex_castin_server.py --host 127.0.0.1 --port 8765 --data-dir ./donnees --front ./front/dist      # sert aussi la SPA bâtie
```

Au premier lancement, `regles.json` et `tableau_de_bord.config.json` sont créés dans
`--data-dir` s'ils sont absents (transparence). Le service écoute **uniquement sur
127.0.0.1** par défaut — ne pas exposer hors du poste.

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
| `/api/config` | — | paramètres ajustables : `cible_ece`, `alerte_taux_acceptation_min`, `alerte_duree_dex_max_s`, `k_promotion_fixture`, `fenetre_glissante_n` |
| `/api/rules` | — | `version`, `extra_keywords`, `confiance`, `seuil_routage`, `calibration` |
| `/api/calibration` | — | `suffisant`, `n` ; si suffisant : `ece_brut`, `ece_estime`, `gain`, `par_defaut`, `par_champ`, `champs_calibres`, `version_proposee`, `patch_regles` |
| `/` *(statique)* | chemin de fichier | sert `front/index.html` + assets (repli SPA) |

---

## POST

| Route | Corps attendu | Réponse — clés principales |
|------|---------------|----------------------------|
| `/api/process-dex` | `{path}` **ou** `{filename, content_base64}` | résultat **enrichi** : `identification`, `gabarit_signature`, `ordre_champs`, `champs{key:{label, tab, kind, content, score_brut, confiance, route_attention, raison, titre_repere, source_spans, suggestions}}`, `document[]`, `points_a_verifier[]`, `markdown`, `rules_version`, `calibration_active`, `seuil_routage` |
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

# Ajuster une calibration candidate puis l'écrire
curl -s $BASE/api/calibration
curl -s -X POST $BASE/api/calibration/proposer

# Recharger les règles après un patch versionné
curl -s -X POST $BASE/api/rules/reload
```

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
      "confiance": 0.9, "raison": "section repérée.",
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

### `POST /api/validate` (annexe A.3.1)

```json
{
  "dex_id": "S20001", "onglet": "dex", "champ": "log",
  "confiance": 0.9, "verdict": "signale",
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
`operateur_role` (`rodage | production`) permet de segmenter les corrections de
**rodage** (développeur confirmé, labels de qualité) du régime courant.

### `GET /api/metrics`

```json
{
  "n_evenements": 5, "n_calibrables": 5,
  "brier_global": 0.17, "ece": 0.1, "cible_ece": 0.1,
  "fiabilite": [ { "bin": [0.9, 1.0], "n": 5, "confiance": 0.9, "acceptation": 0.8 } ],
  "par_champ": { "log": { "n": 1, "acceptation": 0.0, "brier": 0.81 } },
  "debit": { "n": 5, "median_s": 600.0 },
  "alertes": []
}
```

Définitions : `o = 1` si `accepte`, `0` si `signale` ; `p` = confiance affichée.
`Brier = moyenne((p − o)²)` ; `ECE = Σ (|Bₘ|/N)·|acc(Bₘ) − conf(Bₘ)|` sur 10 buckets.
Les champs sans confiance (ex. « Principes et décisions ») sont **exclus** du calcul.

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

Démonstration de bout en bout : `python outils/smoke_serveur.py` (stdlib, sur le DEX
de test réel ; exerce health/process/validate/metrics/replay et le scénario de patch).

## Données et confidentialité

| Fichier | Contenu | Portée |
| --- | --- | --- |
| `donnees/events.jsonl` | Journal des validations (peut référencer du contenu via `correction`) | **Local** |
| `donnees/runs/<dex>/…json` | Instantanés de runs (contiennent le contenu extrait) | **Local** |
| `donnees/regles.json` | Overlay versionné (lexique + poids confiance) | Local / partageable |
| `donnees/tableau_de_bord.config.json` | Paramètres ajustables front | Local |

Le service écoute sur `127.0.0.1` ; les copies temporaires d'upload sont supprimées
après traitement. **Aucune donnée DEX ne quitte le poste.** La seule projection
candidate à une mutualisation inter-postes est la télémétrie **sans contenu**
(`signal_agrege` de l'annexe A.3.2) — non incluse dans ce service (phase 2).

## Paramètres : ajustables front vs versionnés (rappel annexe A.3.4)

- **Ajustables front** (`tableau_de_bord.config.json`) — ne changent **aucune** sortie
  de DEX : `cible_ece`, seuils d'alerte, `k_promotion_fixture`, `fenetre_glissante_n`.
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
- **Routage par seuil de confiance** : actuellement le signalement « Points à vérifier »
  suit le moteur (section requise introuvable). Ajouter un seuil de confiance *versionné*
  qui route aussi les matchs faibles est possible (il changerait la liste → `regles.json`).

## Prochaine étape

Front **VueJS** accessible (RGAA / WCAG / DSFR) : tableau de bord (métriques + alertes),
panneau par champ (contenu, bouton **Copier**, confiance, suggestions, boutons de
signalement typés), **overlay AR** sur le DEX (cadres/étiquettes/flèches via
`source_spans`/`document`), et **récapitulatif de replay** pour évaluer l'amélioration
après modification.
