# Cahier des charges — Automatisation de la reprise des DEX vers CAST'IN
## Volet faisabilité (plugin Word ou autre moyen) — sans API CAST'IN

| | |
|---|---|
| **Objet** | Spécifier l'automatisation de la reprise des Dossiers d'Exploitation (DEX) Word vers CAST'IN, et statuer sur sa faisabilité par complément (plugin) Word, à défaut par un autre moyen. |
| **Contrainte structurante** | **Aucune action via API CAST'IN n'est envisageable.** L'appel d'offres confirme d'ailleurs que CAST'IN ne propose pas de reprise automatique du stock Word. La saisie finale dans CAST'IN reste donc, à ce stade, manuelle. |
| **Documents de référence** | Appel d'offres « Reprise DEX » (23/04/2026) ; `CAHIER_DES_CHARGES.md` (spécification de la solution déjà réalisée) ; `DOSSIER_TECHNICO_FONCTIONNEL.md`. |
| **Volumes** | Option A : 115 DEX — Option B : 907 DEX — Option C : 1227 DEX. Coût manuel de référence : **20 min/DEX**. Échéance : avant octobre 2026. |

---

## 1. Contexte et objet

La reprise consiste, pour chaque DEX, à ouvrir un document Word normé, à en extraire le contenu d'une vingtaine de sections, à le nettoyer, puis à le coller dans les champs correspondants de l'outil web CAST'IN (interface « Référentiel des Implémentations Techniques des Solutions »), avant de vérifier la complétude à 100 % et d'exporter un PDF. L'architecture des sections diffère entre le Word et CAST'IN : ce n'est pas un simple copier-coller, et la rigueur attendue est élevée (documents audités).

L'objet de ce cahier des charges est double :

1. décrire **ce qui doit être automatisé** et selon quelles règles métier ;
2. **statuer sur la faisabilité** de cette automatisation par complément Word, ou par tout autre moyen pertinent compte tenu de l'absence d'API CAST'IN.

L'automatisation visée ne reformule jamais le contenu métier : elle l'extrait, le nettoie et le présente prêt à coller. La décision finale reste à l'opérateur (Équipier Ops).

---

## 2. Périmètre de l'automatisation

### 2.1 Dans le périmètre

- Lecture d'un DEX au format `.docx`.
- Extraction, nettoyage et structuration du contenu des **23 champs CAST'IN** (cf. §6) selon les **8 règles métier** (cf. §6).
- Détection des sections absentes (→ « Non concerné ») et signalement des cas douteux à l'Équipier Ops.
- Production, par DEX, d'un **contenu prêt à coller** (rendu structuré) et d'une **copie annotée du DEX** (surlignage par champ), pour un copier-coller intuitif vers CAST'IN.
- Traitement **par lot** de l'ensemble du stock.

### 2.2 Hors périmètre

- Toute **écriture automatique dans CAST'IN** (pas d'API). Voir cependant l'option RPA en §4.3, hors solution de référence.
- La création ou la modification du contenu d'un DEX (le `.docx` est une donnée d'entrée).
- Les formats autres que `.docx`.

---

## 3. Décomposition du MODOP : ce qui est automatisable et ce qui ne l'est pas

Le processus manuel décrit dans l'appel d'offres se décompose en huit étapes. L'analyse ci-dessous distingue ce qu'un outil côté Word peut prendre en charge de ce qui dépend de l'interface CAST'IN.

| # | Étape du MODOP | Automatisable ? | Moyen |
|---|---|---|---|
| 1 | Identifier le n° de solution (`Sxxxx`) depuis le nom de fichier | **Oui, totalement** | Plugin Word / script (motif `S\d{4}`) |
| 2 | Se connecter à CAST'IN (compte `U…@ZOE.GCA`) | **Non** (hors RPA) | Authentification / SSO : manuel, ou RPA sous conditions |
| 3 | Rechercher la solution puis sélectionner la version « En Production » | **Non via plugin** (état propre à CAST'IN) | Manuel, ou RPA d'IHM |
| 4 | Extraire le contenu des ~23 sections, repérées **par nom** | **Oui, totalement** | Plugin Word / script — *cœur de l'automatisation* |
| 5 | Nettoyer : caractères spéciaux, retrait des titres et du texte explicatif bleu, conservation du contenu/liens/schémas | **Oui, totalement** | Plugin Word / script |
| 6 | Détecter les sections absentes → « Non concerné » + signaler les doutes | **Oui, totalement** | Plugin Word / script |
| 7 | Coller chaque champ dans l'éditeur CAST'IN (icône « Modifier », valider) | **Non via plugin** (pas d'API) | **Manuel assisté** (copie en 1 clic), ou RPA d'IHM |
| 8 | Vérifier complétude 100 % / 6 rubriques, puis exporter le PDF | **Partiellement** | Aide à la vérification côté outil ; export PDF manuel, ou RPA |

**Lecture de ce tableau.** Tout le travail *côté source* (étapes 1, 4, 5, 6, et la préparation de 7) est automatisable de bout en bout. Tout le travail *côté cible CAST'IN* (étapes 2, 3, 7, 8) ne l'est pas sans API — sauf à piloter l'interface par un robot (RPA), avec les réserves exposées au §4.3. C'est cette frontière qui détermine la solution retenue.

---

## 4. Étude de faisabilité par approche

### 4.1 API / import natif CAST'IN — **écarté**

L'appel d'offres indique explicitement que CAST'IN ne permet pas de reprise automatique du stock Word, et l'absence d'API est posée comme contrainte. Cette voie, qui serait la plus fiable, **n'est donc pas disponible**. À conserver toutefois comme évolution : le rendu structuré JSON déjà produit alimenterait directement un import si une API ou un format d'import apparaissait (cf. §11).

### 4.2 Plugin Word (complément Office.js, à défaut macro VBA) — **faisable côté source**

Un plugin Word peut, de façon fiable :

- parcourir la structure du document (titres / styles), retrouver chaque section **par son nom normalisé** (numérotation, accents, casse ignorés), ce qui absorbe les variations de numérotation entre DEX ;
- **écarter automatiquement** les titres de section et les encarts explicatifs (texte en bleu/italique du gabarit), grâce à la couleur et au style des caractères — c'est précisément le « texte encadré en jaune » à ne pas copier de l'exemple du MODOP ;
- isoler les **liens** (Dossier Archi, schéma ADU) et **nettoyer** les caractères parasites ;
- détecter les **sections manquantes** et lister les **points à vérifier** ;
- présenter, dans un volet, chaque champ CAST'IN avec un bouton **« Copier »** ; et produire une **copie annotée** du DEX où chaque passage est surligné dans la couleur de son champ cible.

En revanche, un plugin Word **ne peut pas écrire dans CAST'IN** (pas d'API). Il prépare la donnée ; l'opérateur réalise le collage.

> Forme technique recommandée : **complément Office.js** plutôt que macro VBA. Le complément est cloisonné, déployable de façon centralisée, et n'est pas bloqué par les politiques de sécurité des macros, fréquemment restrictives en environnement bancaire. Une macro VBA signée (.dotm) reste une solution de repli si le déploiement d'un complément n'est pas autorisé.

### 4.3 RPA / automatisation de l'IHM CAST'IN — **possible en option, sous conditions**

Un robot logiciel (par ex. Power Automate Desktop, UiPath, Playwright/Selenium) peut piloter l'interface CAST'IN : cliquer sur « Modifier », coller depuis le presse-papiers, enregistrer, exporter le PDF. Combiné à l'extraction côté Word, il permettrait une automatisation quasi complète. Cette piste répond à « par un autre moyen » mais comporte des réserves sérieuses :

- **Fragilité** : CAST'IN est un outil tiers, dont l'IHM (sélecteurs, DOM) peut évoluer sans préavis et casser le robot.
- **Authentification** : compte `U…@ZOE.GCA` / SSO, gestion des sessions et expirations.
- **Gouvernance** : faire tourner un robot sur un référentiel interne **audité** requiert l'autorisation explicite de CA-GIP et peut être proscrit par la politique de sécurité.
- **Jugement humain** : le MODOP impose de **contacter l'Équipier Ops en cas de doute** — un robot ne sait pas arbitrer ces cas.
- **Cadre contractuel** : l'appel d'offres formule la prestation comme une reprise manuelle.

**Verdict** : à n'envisager qu'en **phase ultérieure**, sous forme de **POC encadré** sur un environnement de test, après autorisation de CA-GIP, et seulement si le gain net dépasse celui de la migration assistée. Non retenue comme approche principale.

### 4.4 Solution hybride — migration assistée — **retenue**

Le plugin / script automatise toute l'extraction, le nettoyage, l'annotation et la mise à disposition « prête à coller » ; l'opérateur réalise le collage, exerce le jugement (cas douteux), vérifie la complétude et exporte le PDF. C'est le meilleur compromis valeur / risque : il respecte la gouvernance et la règle « doute = Ops », réduit fortement le temps par DEX, et **correspond à la solution déjà spécifiée et réalisée** dans `CAHIER_DES_CHARGES.md`.

### 4.5 Synthèse comparative

| Approche | Couvre côté source | Couvre côté CAST'IN | Risque | Verdict |
|---|---|---|---|---|
| API / import CAST'IN | — | Oui | — | **Écartée** (indisponible) |
| Plugin Word seul | Oui | Non | Faible | **Retenue** (volet source) |
| RPA d'IHM | (via couplage) | Oui | **Élevé** | **Option phase 2**, sous conditions |
| **Hybride (assistée)** | **Oui** | **Manuel assisté** | **Faible** | **Solution de référence** |

---

## 5. Solution cible retenue

Architecture de la migration assistée (cohérente avec l'existant) :

- un **module commun** porte toute la logique métier (repérage par nom, nettoyage, extraction, annotation) — résultat identique quel que soit le point d'entrée ;
- un **utilitaire en ligne de commande** traite les DEX **par lot** (pré-génération du stock) ;
- un **service local** (`127.0.0.1`) alimente le **complément Word** pour un usage interactif, DEX par DEX ;
- deux sorties par DEX : le **rendu structuré** (Markdown / JSON) et la **copie annotée** `.docx` (surlignage par champ + légende).

Le flux opérateur cible est : *ouvrir le DEX → l'outil affiche les champs nettoyés + la copie annotée → copier (1 clic) / coller dans CAST'IN → traiter les points à vérifier → vérifier 100 % → exporter PDF.*

---

## 6. Exigences fonctionnelles (rappel synthétique)

La spécification détaillée figure dans `CAHIER_DES_CHARGES.md`. En synthèse :

**Les 8 règles métier** : (1) repérage des sections **par nom** et non par numéro ; (2) **contenu utile uniquement** (titres et encarts explicatifs bleu/italique écartés) ; (3) **nettoyage** des caractères parasites ; (4) section absente → exactement « Non concerné » ; (5) « Principes et décisions » toujours **vide** ; (6) « Informations supplémentaires » **optionnel** ; (7) **aucune reformulation** ; (8) **doute = signalement** à l'Équipier Ops, l'outil ne devine jamais.

**Les 23 champs CAST'IN** se répartissent en :

- onglet *Description détaillée* (6 champs) : Lien Dossier Archi, Schéma Applicatif (liens), Description Fonctionnelle, Données de la solution, Principes et décisions (vide), Description Technique ;
- onglet *DEX* (17 champs) : Plage de fonctionnement/maintenance, Supervision, Observabilité, Log, Sauvegardes, Servitudes et ordonnancements, Comptes et services, Certificats, Liste blanche, Flux, Support, Changement et MEP, Matière (repo), Procédures de restauration / reconstruction / resynchronisation, Informations supplémentaires ;
- identification : n° de solution, Auteur, Responsable.

**Sorties imposées** par DEX : bloc IDENTIFICATION, bloc CONTENU PAR CHAMP, bloc POINTS À VÉRIFIER (`RAS` si aucun) ; plus la copie `.docx` annotée.

---

## 7. Exigences techniques et de sécurité

| Exigence | Détail |
|---|---|
| Dépendances | Bibliothèque standard uniquement (pas d'installation tierce), pour faciliter l'homologation poste de travail. |
| Confidentialité | Traitement **local** ; service à l'écoute sur `127.0.0.1` seulement ; **aucune donnée DEX ne quitte le poste** ; suppression des fichiers temporaires. Adapté au caractère audité/sensible des DEX. |
| Portabilité | Windows (invite de commandes), Linux, macOS. |
| Robustesse | Une erreur sur un fichier n'interrompt pas le lot ; codes retour distincts. |
| Déploiement du complément | Hébergement du manifeste + chargement latéral centralisé, **à valider avec la DSI/sécurité CA-GIP** ; repli macro VBA signée si nécessaire. |
| Non-régression | Jeu de tests automatisés ; critère d'acceptation ≥ 95 % (score mesuré 96 %). |

---

## 8. Gains attendus et dimensionnement A / B / C

La majeure partie des 20 min/DEX est consommée par la **localisation des sections, le tri du contenu à copier, le nettoyage et les vérifications** — précisément ce que l'outil supprime. Subsistent un **socle manuel incompressible** : connexion (amortie sur une session), recherche/sélection de version, les collages, la vérification et l'export PDF.

> **Hypothèse à valider sur DEX réels** : objectif ≈ **10 min/DEX** en mode assisté, soit **~45–55 % de réduction**.

| Option | Volume | Effort manuel (20 min) | Effort assisté (~10 min, à valider) |
|---|---|---|---|
| A | 115 | ≈ 38 h | ≈ 19 h |
| B | 907 | ≈ 302 h | ≈ 151 h |
| C | 1227 | ≈ 409 h | ≈ 205 h |

Ces ordres de grandeur servent à **dimensionner le nombre de prestataires et la tarification** des forfaits A/B/C de la réponse à l'appel d'offres ; ils doivent être **confirmés par un pilote sur DEX réels** (cf. §11).

---

## 9. Risques et points à valider

- **Schémas / images** : confirmer que l'éditeur CAST'IN accepte le **collage d'images** (le MODOP demande de copier « les schémas »). La copie annotée facilite leur report manuel.
- **Styles de titres** : la segmentation repose sur les styles « Titre N / Heading N ». Un DEX hors gabarit peut être mal découpé (limite connue).
- **Heuristique du texte explicatif** : un contenu métier légitime entièrement en bleu/italique serait écarté à tort (limite connue).
- **Variance du stock réel** vs jeux de tests synthétiques : à mesurer en pilote.
- **Déploiement & homologation** du complément Word côté CA-GIP.

---

## 10. Intégration à la gouvernance (valeur ajoutée)

L'appel d'offres impose un **suivi hebdomadaire** listant les DEX repris, et un dossier final de **PDF exportés**. Le rendu **JSON** produit par l'outil peut alimenter automatiquement un **tableau de suivi** (DEX, solution, date, complétude, points à vérifier), automatisant ainsi le livrable hebdomadaire de pilotage attendu par Paul BALARESQUE / Nadège SCHMITT / Baptistan HIOT.

---

## 11. Trajectoire et prochaines étapes

> Recommandation principale : la prochaine étape n'est pas de développer davantage, mais de **valider la solution assistée sur des DEX réels** afin de produire des **métriques fiables** (précision et temps réel par DEX) — car les tests actuels reposent sur des DEX synthétiques, et la réponse à l'appel d'offres a besoin de chiffres réels pour dimensionner et chiffrer A/B/C.

**Phase 0 — Cadrage et prérequis** (avec les 2 référents CA-GIP)
- Obtenir un **échantillon représentatif de DEX réels** (10–20, plusieurs familles de solutions) issus du SharePoint.
- Obtenir un accès **CAST'IN de test** pour chronométrer le collage réel.
- Faire **confirmer** le code couleur du texte explicatif et les styles de titres réellement utilisés en production ; confirmer le **collage d'images** dans CAST'IN.

**Phase 1 — Pilote sur DEX réels**
- Exécuter l'outil existant sur l'échantillon ; mesurer la **précision par règle/champ** et le **temps réel/DEX** vs 20 min.
- Ajuster les mots-clés de repérage et l'heuristique d'exclusion sur données réelles.
- Produire les **métriques de chiffrage** A/B/C pour la réponse à l'appel d'offres.

**Phase 2 — Industrialisation de la migration assistée**
- **Packager et déployer** le complément Word (ou VBA signée) avec validation DSI/sécurité CA-GIP.
- **Pré-générer le stock par lot** (rendu structuré + copie annotée) pour que l'opérateur n'ait plus qu'à copier / coller / vérifier / exporter.
- Automatiser le **livrable de suivi hebdomadaire** depuis les JSON.

**Phase 3 — (optionnelle, sous autorisation CA-GIP) POC d'automatisation IHM (RPA)**
- POC restreint sur l'environnement de test pour automatiser collage + enregistrement + export PDF.
- **Décision go/no-go** sur l'automatisation complète selon la robustesse mesurée, en conservant l'humain pour les cas « doute = Ops ».

**Phase 4 — Pérennisation**
- Externaliser la configuration des mots-clés de section (gabarits alternatifs).
- Maintenir l'export JSON prêt pour un futur import / API CAST'IN.

---

*Document à valider en comité de pilotage. Les estimations de gain (§8) sont des hypothèses à confirmer en phase 1 (pilote sur DEX réels).*
