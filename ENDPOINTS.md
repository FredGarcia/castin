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
| `/api/process-dex` | `{path}` **ou** `{filename, content_base64}` | résultat **enrichi** : `identification`, `gabarit_signature`, `ordre_champs`, `champs{key:{label, tab, kind, content, score_brut, confiance, route_attention, ambigu, candidats[], selection_moteur, raison, titre_repere, source_spans, suggestions}}`, `document[]`, `points_a_verifier[]`, `markdown`, `rules_version`, `calibration_active`, `seuil_routage` |
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
- **Désambiguïsation multi-candidats** (par champ, dans `process-dex`) : `candidats[]` énumère les sections dont le titre matche les mots-clés du champ (mêmes règles que le moteur), triées par score de proximité décroissant ; chaque candidat porte `index, titre, niveau, score, phrase, span, extrait` (+ `contenu` complet pour les champs `text` à ≥2 candidats, afin de basculer l'affichage sans appel supplémentaire). `selection_moteur` est l'index réellement retenu par le moteur (1er match, ordre document) — le **défaut appliqué**. `ambigu` (champs `text` seulement) vaut `true` quand le top-1 et le top-2 sont plus proches que `marge_ambiguite`, **ou** quand le mieux scoré n'est pas la sélection moteur (risque de *mauvaise section*) ; il abaisse la confiance (`malus_ambiguite`) et ajoute une entrée à `points_a_verifier`. Choisir une autre section côté front est journalisé via `/api/validate` comme `type_signalement="mauvaise_section"` + `correction` (l'auto-sélection était fausse → verdict `signale`, donc outcome 0 pour la calibration). Les champs `merge`/`link` matchent par nature plusieurs sections (agrégation voulue) : leurs candidats sont exposés en information, jamais marqués `ambigu`. Paramètres **versionnés** dans `regles.json` : `marge_ambiguite` (défaut 0.15), `max_candidats` (5), `confiance.malus_ambiguite` (0.20).
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
