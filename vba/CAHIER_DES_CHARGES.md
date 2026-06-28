# Cahier des charges — Macro VBA d'annotation des DEX (`AnnotationDEX`)

> Document de spécification de l'outil **`AnnotationDEX`** (Word/VBA).
> Complète le cahier des charges général de la reprise DEX → CAST'IN
> (`CAHIER_DES_CHARGES.md`, `CDC.md` à la racine du projet) ; il en reprend
> les règles métier et les applique côté **Word**, sans dépendance externe.

---

## 1. Contexte

Les Dossiers d'Exploitation (DEX) sont rédigés au format **Word (.docx)** selon
un gabarit SharePoint. Leur reprise vers **CAST'IN** se fait **manuellement,
champ par champ** (aucune API CAST'IN disponible). Cette opération est
répétitive, chronophage et exposée aux erreurs (mauvais paragraphe, oubli de
section, texte explicatif copié par inadvertance).

La chaîne Python du projet (`app/`) produit déjà un rendu structuré et une copie
annotée. La macro VBA répond à un besoin **autonome, côté poste de travail** :
un opérateur qui a le DEX ouvert dans Word doit pouvoir, **sans installer Python
ni complément Office**, obtenir immédiatement une **copie annotée** mettant en
évidence quel passage va dans quel champ CAST'IN.

## 2. Objectif

À partir d'un DEX `.docx` ouvert dans Word, produire une **copie annotée**
`<nom>_ANNOTE.docx` dans laquelle **chaque passage destiné à un champ CAST'IN
est surligné dans la couleur propre à ce champ**, afin de **maximiser la vitesse
et la justesse du copier-coller manuel** vers CAST'IN.

**Exigence cardinale :** le **DEX source n'est jamais modifié**. L'annotation
porte exclusivement sur une copie réalisée sur le disque.

## 3. Périmètre

### Inclus
- Lecture d'un DEX `.docx` ouvert dans Word (document actif).
- Repérage des sections **par nom** (règle 1) et de leur contenu utile (règle 2).
- Surlignage par champ (fond de caractère) en couleur configurable.
- Repérage des **identifiants** : n° de solution (`Sxxxx`), Auteur, Responsable.
- Génération d'une **légende** récapitulative (une ligne par champ) en tête du
  document, avec restitution réduite du contenu repéré (texte, tableaux, images).
- Liste des **champs non repérés** (« Points à vérifier auprès de l'Équipier Ops »).
- **Configuration externe** (couleurs, catégories, champs) par fichier `.ini`.

### Exclus
- Toute saisie automatique dans CAST'IN (hors périmètre, pas d'API).
- La modification ou la reformulation du contenu du DEX (règle 7).
- Les formats autres que `.docx`.
- L'extraction « prête à coller » nettoyée caractère par caractère (assurée par
  la chaîne Python) : la macro **met en évidence**, elle ne réécrit pas.

## 4. Règles métier reprises

| # | Règle | Application dans la macro |
| --- | --- | --- |
| 1 | **Repérage par NOM** | Les titres sont retrouvés par leur **texte normalisé** (numérotation, accents, casse, ponctuation ignorés). Le numéro de chapitre n'est **jamais** un critère. |
| 2 | **Contenu utile uniquement** | Les **encarts d'aide** (paragraphe entièrement en *italique* + couleur de police non standard) sont **détectés et non surlignés**. |
| 5 | **« Principes et décisions » vide** | Ce champ n'existe pas dans la configuration : il n'est **jamais** surligné. |
| 7 | **Pas de reformulation** | Le contenu n'est ni modifié ni réécrit ; seul un **fond de couleur** est ajouté sur la copie. |
| 8 | **Doute = signalement** | Tout champ dont la section est introuvable est listé dans « Points à vérifier ». L'outil ne devine jamais. |

## 5. Détection de la structure (titres et sections)

Beaucoup de DEX **ne stylent pas** leurs titres (ni style « Titre N » / « Heading
N », ni niveau de plan). La détection ne peut donc pas reposer uniquement sur
`OutlineLevel`.

**Un paragraphe est un titre de section si :**
1. il porte un **style de titre Word** (`OutlineLevel` 1 à 9) ; **ou**
2. il est **court** (≤ 8 mots) et **commence par une numérotation de chapitre**
   (`2.1 …`, `6 …`, `12.2 …`).

**Bornage d'une section** (du titre jusqu'à sa fin) :
- titre **numéroté** : la section s'étend jusqu'au prochain titre qui **n'est pas
  un sous-numéro** du titre courant (`6` englobe `6.1` ; `11` s'arrête **avant**
  `12.2`). Ce critère est **robuste à une numérotation non monotone**, fréquente
  dans les DEX ;
- titre **stylé Word** : jusqu'au prochain titre de **niveau de plan ≤**.

Le **titre lui-même est inclus** dans le surlignage de la section (repère visuel),
mais reste exclu du texte « contenu » remonté dans la légende.

## 6. Champs, catégories et couleurs

### 6.1 Champs CAST'IN couverts (22 + 3 identifiants)

- **Identifiants** : Numéro de solution, Auteur, Responsable.
- **Description détaillée** : Lien Dossier Archi (DAP), Schéma Applicatif (ADU),
  Description Fonctionnelle, Données de la solution, Description Technique.
- **DEX** : Plage de fonctionnement, Supervision, Observabilité, Log,
  Sauvegardes, Servitudes et ordonnancements, Comptes et services, Certificats,
  Liste blanche, Flux, Support, Changement et MEP, Matière (repo), Procédures de
  restauration / reconstruction / resynchronisation, Informations supplémentaires.

> *« Principes et décisions »* est **volontairement absent** (règle 5).

### 6.2 Types de repérage

| Type | Comportement |
| --- | --- |
| `text` | Première section dont le titre correspond aux mots-clés. |
| `link` | **Toutes** les sections candidates (ex. ADU présent dans plusieurs sections). |
| `merge` | Première **+ deuxième** section (ex. « Changement et MEP »). Pour « Matière (repo) », recherche additionnelle de « Merge Request » dans tout le document. |
| `appendix` | Contenu situé **après** la section « Resynchronisation » + section « Assets mainframe » (optionnel, règle 6). |
| `idsolution` / `idauteur` / `idresponsable` | Identifiants : premier paragraphe correspondant dans les **80 premiers** (motif `Sxxxx`, `Auteur :`, `Responsable :` / `Service :`). |

### 6.3 Couleurs : une teinte par champ, déclinée du clair au foncé

Chaque champ a **sa propre couleur**, exprimée par une **teinte de base** + une
**nuance** :
- les **teintes de base** (rouge, orange, jaune, vert, bleu, indigo) sont
  définies en hexadécimal ;
- la **nuance** va de `1` (très clair) à `5` (base) à `9` (très foncé) — ou en
  mots `tres clair / clair / moyen / fonce / tres fonce`. La couleur est dérivée
  par mélange vers le blanc (clair) ou vers le noir (foncé) ;
- un **code hexadécimal direct** (`RRGGBB`) est également accepté.

À l'intérieur d'une catégorie, les champs se déclinent **du clair au foncé**
(ex. Plage `jaune 2` → Sauvegardes `jaune 6`), ce qui distingue visuellement deux
sections voisines tout en conservant l'appartenance à une même famille.

Le surlignage emploie le **fond de caractère** (`Shading.BackgroundPatternColor`),
équivalent OOXML de `<w:shd>` : **toute valeur RGB** est admise.

## 7. Configuration externe (`AnnotationDEX.config.ini`)

La configuration vit dans un fichier INI, modifiable **sans toucher au code**.

```ini
[couleurs]               ; teintes de base, hexa RRGGBB
jaune = FDD835
...
[categories]             ; libellés affichés (colonne « Catégorie »)
expl = Exploitation courante
...
[champs]                 ; Libellé = categorie | couleur | type | mots-cles(; )
Supervision = expl | jaune 3 | text | supervision
```

**Recherche du fichier**, dans l'ordre :
1. le chemin de la constante `CONFIG_CHEMIN` (en tête du `.bas`, vide par défaut) ;
2. `AnnotationDEX.config.ini` **dans le dossier du DEX**.

S'il est **absent ou incomplet**, la macro retombe sur des **valeurs par défaut
intégrées**, identiques au `.ini` fourni : elle **fonctionne sans configuration**.
Le message de fin indique la source réellement utilisée.

> Les libellés doivent rester **sans accents** (lecture ANSI du fichier).

## 8. Sortie

### 8.1 Copie annotée
- Fichier `<nom>_ANNOTE.docx` créé **dans le dossier du DEX** (confirmation
  demandée avant écrasement d'une copie existante).
- Le **corps du document est préservé** ; seul un fond de couleur est ajouté sur
  les passages repérés.

### 8.2 Légende (en tête de la copie)
Tableau **à une ligne par champ** :

| Couleur | Catégorie | Champ | Contenu repéré dans ce document |
| --- | --- | --- | --- |

- **Couleur** : pastille de la couleur du champ.
- **Contenu repéré** : ce qui a été capté pour ce champ, **collé en réduit**
  (police 7 pt) — **tableaux** recopiés en petit, **images** réduites en
  **miniatures** (hauteur ≤ 36 pt). En cas d'échec du collage enrichi sur un
  passage, **repli automatique en texte**.
- Sous le tableau : « Points à vérifier auprès de l'Équipier Ops » listant les
  **champs non repérés** (`RAS` si tous repérés).

## 9. Architecture du module (procédures clés)

| Procédure | Rôle |
| --- | --- |
| `AnnoterDEX` | Point d'entrée : copie disque, chargement config, annotation, légende, sauvegarde. |
| `ChargerConfig` / `ParseIni` / `ChargerDefauts` | Configuration (INI ou défauts). |
| `CouleurDepuisTerme` / `AppliquerNuance` | Résolution d'une couleur « teinte + nuance ». |
| `ConstruireCacheStructure` / `DetecterTitre` | Cache des paragraphes ; détection des titres (style/numérotation). |
| `TrouverSection` / `FinSection` / `TitreCorrespond` | Repérage par nom et bornage des sections. |
| `AnnoterChampText/Link/Merge/Appendix` / `AnnoterIdentifiant` | Annotation par type de champ. |
| `SurlignerPlage` / `SurlignerParagraphe` / `EstExplicatif` | Surlignage et exclusion des encarts. |
| `InsererLegende` / `RemplirContenuChamp` / `RetaillerContenu` | Construction de la légende et collage réduit. |
| `NormaliserTitre` / `NettoyerLigne` / `SansAccents` | Normalisation du texte (règle 1). |

Le module **ne dépend que de Word** et des objets COM standard
(`Scripting.FileSystemObject`, `VBScript.RegExp`) ; aucune référence externe
n'est requise.

## 10. Exigences non fonctionnelles

- **Innocuité** : le fichier source n'est ni ouvert en écriture, ni modifié.
- **Autonomie** : aucun composant à installer ; copier-coller du `.bas` dans un
  module suffit (pas de ligne `Attribute VB_Name`, qui empêcherait le collage).
- **Robustesse** :
  - les **marques de fin de cellule / ligne de tableau** (`Chr(7)`) sont
    ignorées au surlignage (évite l'erreur d'exécution **4605**) ;
  - le collage enrichi du contenu est protégé (repli texte) ;
  - une couleur, catégorie ou clé absente de la config retombe sur une valeur
    sûre par défaut.
- **Déterminisme** : à configuration égale, le résultat est identique d'un poste
  à l'autre ; aucun appel réseau.
- **Configurabilité** : couleurs, catégories et répartition des champs sans
  modification du code.

## 11. Cas limites et comportements attendus

| Situation | Comportement |
| --- | --- |
| DEX sans titres stylés | Détection par **numérotation** (§5). |
| Numérotation des chapitres non croissante | Bornage par **sous-numéro** (`11` ≠ parent de `12.2`). |
| Section introuvable | Champ listé dans « Points à vérifier ». |
| Encart d'aide bleu/italique | **Non** surligné (règle 2). |
| Tableau dans une section | Cellules surlignées ; restituées **en petit** dans la légende. |
| Image en ligne dans une section | Reprise en **miniature** dans la légende. |
| Copie `_ANNOTE.docx` déjà ouverte/existante | Confirmation puis remplacement. |
| DEX jamais enregistré (sans chemin) | Opération refusée avec message. |

## 12. Limites connues

- Un titre **sans numéro et sans style Word** (texte simplement mis en gras
  « à la main ») n'est pas reconnu comme frontière de section.
- Seules les **images en ligne** (`InlineShapes`) sont reprises en miniature ;
  les images **ancrées/flottantes** ne le sont pas.
- La lecture du `.ini` est **ANSI** : conserver des libellés sans accents.

## 13. Installation et exécution

1. Ouvrir le DEX `.docx` (il doit être **enregistré sur disque**).
2. `Alt`+`F11` → `Insertion > Module` → coller `AnnotationDEX.bas`
   (ou `Fichier > Importer un fichier…`).
3. (Optionnel) déposer `AnnotationDEX.config.ini` dans le dossier du DEX.
4. `Alt`+`F8` → **`AnnoterDEX`** → `Exécuter`.

## 14. Validation

- **Jeu de référence** : `tests/dex_tests/DEX_S30001_Nominal.docx` et l'exemple
  `DEX_S20001_Nominal.docx` (titres **non stylés**, tableaux et image).
- **Critères** : les 22 champs + identifiants repérés correctement, sections
  voisines distinguées par la nuance, tableaux et images restitués en réduit
  dans la légende, aucune modification du fichier source, copie `_ANNOTE.docx`
  ouvrable sans avertissement.
- **Réserve** : la logique de repérage a été validée par simulation sur l'exemple
  fourni ; le **rendu visuel** (collage réduit, miniatures) requiert un essai
  réel dans Word.

---

*Voir `vba/README.md` pour le mode d'emploi opérationnel et `vba/AnnotationDEX.bas`
pour l'implémentation.*
