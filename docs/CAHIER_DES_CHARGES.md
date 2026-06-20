# Cahier des charges — synthèse, MODOP officiel et correspondance avec l'outil

*Référence du besoin (appel d'offres CA-GIP du 23/04/2026) et lien avec ce que fait l'outil.
Le cahier des charges structuré complet est dans `CDC.md`.*

---

## 1. Contexte et objectif

CA-GIP modernise sa gestion documentaire technique. Les **Dossiers d'Exploitation (DEX)**,
historiquement rédigés sous **Word (.docx)** et stockés sur **SharePoint**, doivent être
**repris dans l'outil web CAST'IN**. CAST'IN permet de créer des DEX mais **ne propose pas
de reprise automatique** du stock Word, et **aucune API n'est disponible** : la reprise est
donc **manuelle**, **champ par champ**, avec une **forte exigence de rigueur** (les DEX sont
audités).

> L'architecture des paragraphes diffère entre Word et CAST'IN : **ce n'est pas un simple
> copier-coller**. D'où des risques d'erreur (mauvais paragraphe, oubli de section, texte
> explicatif copié par inadvertance) sur une tâche **répétitive et chronophage**
> (~**20 min par DEX**).

**Ce que l'outil apporte** : il pré-repère les champs, nettoie le contenu, isole les liens,
signale les points à vérifier — pour **fiabiliser et accélérer** la saisie manuelle, sans la
remplacer.

---

## 2. Périmètre (options) et échéance

| Option | Volume à reprendre |
|--------|--------------------|
| **A** | **115** documents Word |
| **B** | **907** documents Word |
| **C** | **1 227** documents Word |

Repère de charge : **~20 minutes par DEX**. Échéance : **avant octobre 2026**. Réalisation
en autonomie avec **2 référents CA-GIP**, **suivi hebdomadaire**, et **reporting hebdomadaire**
des DEX repris.

## 3. Livrables et recette

- **Livrable principal** : dossier des DEX **exportés en PDF** après reprise dans CAST'IN.
- **Recette** : évaluation finale par CA-GIP sur la **qualité** et la **quantité** des reprises.

## 4. Gouvernance

- **Responsable projet (client)** : Paul BALARESQUE.
- **Comité de pilotage (hebdomadaire)** : Paul BALARESQUE, Nadège SCHMITT, Baptistan HIOT.
- **Validation des jalons** (cadrage, recette, livraison) : Nadège SCHMITT, Baptistan HIOT.

---

## 5. MODOP officiel — où reprendre chaque champ

Procédure CA-GIP : identifier la solution par le **nom de fichier** (élément commençant par
**`S****`**, ex. `S1627`), sélectionner la version **« En Production »**, puis remplir CAST'IN.

> **Consignes clés** : se référer au **nom de la section** (les **numéros peuvent changer**) ;
> **« Non concerné »** si l'information est absente ; **éviter les caractères spéciaux** ; ne
> copier **que le contenu, les liens et les schémas** — **pas** les noms de section ni les
> **textes explicatifs en bleu**.

### Onglet « Description détaillée » (section Métier)

| Champ CAST'IN | Emplacement dans le DEX Word | Remarque |
|---------------|------------------------------|----------|
| Lien « Dossier Archi (DAP…) » | 2.2 Architecture fonctionnelle & applicative | copier le lien, puis Entrée |
| Schéma Applicatif (ADU…) | 2.2, ou 2.1 « description de la solution » | Ctrl+F si le lien ADU est introuvable |
| Description Fonctionnelle | 2.1 « description de la solution » | |
| Données de la solution | 2.3 « Données » | |
| Principes et décisions | **Ne pas remplir** | |
| Description Technique | 4.1 « Architecture technique » | |

### Onglet « DEX » (+ Auteur / Responsable)

L'**Auteur** figure en page de garde ; à défaut de **Responsable** (page 2), reprendre le
**nom du service**.

| Champ CAST'IN | Emplacement dans le DEX Word | Remarque |
|---------------|------------------------------|----------|
| Plage de fonctionnement / maintenance | 3.3 « plages de fonctionnement » | |
| Supervision | chapitre 6 « Supervision » (tout le chapitre) | |
| Observabilité | « Métrologie » (chapitre 9 ou 11) | |
| Log | « Diagnostique », « LOG », « Trace » (chapitre 8.2) | |
| Sauvegardes | chapitre 7 « Sauvegarde » | |
| Servitudes et ordonnancements | chapitre 9 « Servitudes » | « Non concerné » si absent |
| Comptes et services | 12.2 « compte de service » | |
| Certificats | 12.3 « Certificats » | |
| Liste blanche | 12.4 | |
| Flux | 4.3 « Flux et interdépendances » | |
| Support | 8.1 « matrice responsabilité » | |
| Changement et MEP | chapitre 10 « contrôle des opérations » + chapitre 5 « Changements et MEP » | |
| Matière (repo) | 5.1 + rechercher « Merge Request » | |
| Procédure de restauration | 13.1 « Restauration » | |
| Procédure de reconstruction | 13.2 « Reconstruction » | |
| Procédure de resynchronisation | 13.3 « resynchronisation » | |
| Informations supplémentaires | après 13.3 et 4.2.2 « assets mainframe » | **optionnelle** |

**Contrôles avant export** : date de dernière mise à jour cohérente, **complétude DEX à
100 %**, puis **« Exporter PDF »** vers le dossier indiqué.

---

## 6. Correspondance exigences ↔ règles de l'outil

L'outil **opérationnalise** les consignes du MODOP :

| Exigence du cahier des charges | Règle / fonction de l'outil |
|--------------------------------|-----------------------------|
| Se référer au **nom de section** (numéros variables) | **R1** — repérage **par nom** |
| Ne pas copier les **textes explicatifs en bleu** | **R2** — écarter les encarts (italique + bleu) |
| **Éviter les caractères spéciaux** | **R3** — nettoyage des parasites |
| **« Non concerné »** si information absente | **R4** |
| **Principes et décisions : ne pas remplir** | **R5** — champ toujours vide |
| **Informations supplémentaires** optionnelle | **R6** |
| Ne copier **que le contenu** (fidélité) | **R7** — contenu **jamais reformulé** |
| **En cas de doute, contacter l'Ops** responsable | **R8** — « points à vérifier » + e-mail de signalement |
| Identifier par **`S****`**, version **En Production** | extraction d'identifiant (nom de fichier, sinon contenu) |
| **Complétude / qualité** attendues | confiance par champ, ambiguïtés, historique, métriques |

> En somme, le MODOP décrit **manuellement** ce que l'outil **assiste** : mêmes
> emplacements, mêmes règles d'écartement et de fidélité, avec en plus un **repérage
> automatique**, une **évaluation de confiance** et une **traçabilité**.

---

## 7. Planning du RFP (rappel)

| Étape | Date | Responsable |
|-------|------|-------------|
| Réunion de cadrage | 23/04/2026 | Achat + Prescripteurs |
| Envoi de l'appel d'offres | 27/04/2026 | Achat |
| Intention de répondre | 29/04/2026 | Fournisseur |
| Questions des soumissionnaires | 29/04/2026 | Fournisseur |
| Réponses aux questions | 04/05/2026 | Achat + Prescripteurs |
| Réception des offres | 11/05/2026 | Fournisseur |
| Analyse + short list | 13/05/2026 | Achat + Prescripteurs |
| Soutenances | semaine du 18/05/2026 | Tous |
| Négociations | jusqu'au 29/05/2026 | Achat + Fournisseurs |
| Démarrage mission | début juin 2026 | Fournisseur + Prescripteur |

---

> Documents de référence : **`CDC.md`** (cahier des charges structuré complet),
> `Cahier_des_charges.pdf` (appel d'offres d'origine). Ce résumé fait le pont entre le besoin
> exprimé et le comportement de l'outil — voir aussi `SYNTHESE_REPRISE.md` et `TEST_PLAN.md`.
