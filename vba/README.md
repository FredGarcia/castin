# Macro VBA — Annotation des DEX pour la reprise CAST'IN

`AnnotationDEX.bas` produit, à partir d'un **DEX Word (.docx)**, une **copie
annotée** `<nom>_ANNOTE.docx` dans laquelle chaque passage destiné à un champ
CAST'IN est **surligné dans la couleur de sa catégorie**. But : rendre le
copier-coller manuel vers CAST'IN **plus rapide et plus sûr** (aucune API
CAST'IN disponible).

> **Le DEX source n'est jamais modifié.** La macro travaille sur une copie du
> fichier réalisée sur le disque ; les DEX d'origine restent intacts et sans
> macro.

## Logique de repérage (alignée sur le moteur de reprise du projet)

- **Règle 1 — repérage par NOM** : les sections sont retrouvées par le **texte
  normalisé de leur titre** (numérotation, accents, casse et ponctuation
  ignorés). Le numéro de chapitre (`~2.1`, `~13.3`…) n'est jamais utilisé comme
  critère de recherche.
- **Règle 2 — contenu utile uniquement** : les **encarts explicatifs**
  (paragraphe entièrement en *italique* + couleur non standard, typiquement le
  bleu d'aide du gabarit) ne sont **pas** surlignés.

**Détection des titres sans style Word.** Beaucoup de DEX ne stylent pas leurs
titres (pas de style « Titre N » / « Heading N », pas de niveau de plan). Un
paragraphe est donc considéré comme un **titre de section** s'il porte un style
de titre Word **ou** s'il est court et commence par une **numérotation de
chapitre** (`2.1 …`, `6 …`). Une section va jusqu'au prochain titre qui n'est
pas un **sous-numéro** du titre courant (`6` englobe `6.1`, mais `11` s'arrête
avant `12.2`) — robuste même quand la numérotation des chapitres n'est pas
croissante.

**Tout le contenu d'une section repérée est surligné** : texte, **tableaux**
(cellule par cellule) et **images** en ligne. Seuls les encarts explicatifs
sont écartés (règle 2).

Les mots-clés de chaque champ reprennent ceux de `app/dex_castin_common.py`
(`CASTIN_FIELDS`), pour un résultat cohérent avec le reste de la chaîne.

## Configuration (couleurs, catégories, champs)

Toute la configuration vit dans **`AnnotationDEX.config.ini`** (fourni ici),
pour la modifier **sans toucher au code**. Chaque **champ** a sa **propre
couleur**, exprimée par une **teinte de base + une nuance** (du clair au foncé) :

- `[couleurs]` : les **teintes de base**, en hexadécimal RVB (`RRGGBB`) ;
- `[categories]` : `clé = Libellé` (libellé affiché dans la colonne *Catégorie*,
  l'ordre fixe l'ordre des lignes de la légende) ;
- `[champs]` : `Libellé = catégorie | couleur | type | mots-clés (; )`
  - `couleur` = `<teinte> <nuance>` — ex. `jaune 2`, `bleu clair`, `vert fonce`
    — où la **nuance** va de `1` (très clair) à `5` (base) à `9` (très foncé),
    ou en mots `tres clair / clair / moyen / fonce / tres fonce` ; un **hexa**
    `RRGGBB` direct est aussi accepté ;
  - `type` ∈ `text | link | merge | appendix | idsolution | idauteur | idresponsable`.

Ainsi, à l'intérieur d'une catégorie, les champs se **déclinent du clair au
foncé** (ex. Plage `jaune 2` → Sauvegardes `jaune 6`), ce qui distingue d'un
coup d'œil deux sections voisines.

**Où le fichier est cherché** : d'abord la constante `CONFIG_CHEMIN` (en tête du
`.bas`, vide par défaut), puis `AnnotationDEX.config.ini` **dans le dossier du
DEX**. Introuvable → **valeurs par défaut intégrées** (identiques au `.ini`
fourni). Le message de fin indique la source utilisée.

> Le fichier `.ini` est un **simple fichier texte** posé **à côté du DEX** ; il
> ne s'importe **pas** dans l'éditeur VBA (seul `AnnotationDEX.bas` y est ajouté,
> comme **module standard** — pas un module de classe).

> Conserver des libellés **sans accents** dans le `.ini` (lecture ANSI).

### Renommer, supprimer ou ajouter un champ

Tout se fait dans la section **`[champs]`** du `.ini`, **sans toucher au code**.
Une ligne = un champ : `Libellé = catégorie | couleur | type | mots-clés (; )`.

- **Renommer** : changer le **libellé** (à gauche du `=`). Le libellé n'est qu'un
  texte d'affichage (colonne *Champ* de la légende) ; le repérage s'appuie sur
  les **mots-clés**, pas sur le libellé.
  ```ini
  Supervision & alertes = expl | jaune 3 | text | supervision
  ```
- **Supprimer** : effacer la ligne (ou la commenter avec `;` en début de ligne).
  Le champ n'est alors plus surligné ni listé.
  ```ini
  ; Liste blanche = secu | vert 5 | text | liste blanche ; whitelist
  ```
- **Ajouter** : ajouter une ligne en choisissant la **catégorie**, la **couleur**
  (`teinte nuance` ou hexa), le **type** et les **mots-clés**.
  ```ini
  Plan de reprise d'activite = reprise | indigo 6 | text | pra ; plan de reprise ; continuite
  ```

Points d'attention :

1. **Mots-clés normalisés** : les écrire **en minuscules et sans accents**
   (`metrologie`, pas `Métrologie`) — ils sont comparés au **titre normalisé**
   de la section. Un mot-clé d'un seul mot reconnaît les pluriels (`certificat`
   trouve « Certificats ») ; un mot-clé de plusieurs mots doit être **contenu
   tel quel** dans le titre.
2. **Nouvelle catégorie** : si un champ référence une catégorie absente, l'ajouter
   dans `[categories]` (`clé = Libellé`). Au besoin, ajouter aussi une **teinte de
   base** dans `[couleurs]`.
3. **`type`** doit valoir l'une des valeurs :
   `text | link | merge | appendix | idsolution | idauteur | idresponsable`.
4. **Ordre** : l'ordre des lignes de `[champs]` fixe l'ordre des lignes de la
   légende (et l'ordre de traitement).

Après modification : **enregistrer le `.ini`** et **relancer `AnnoterDEX`**
(aucune recompilation).

### Teintes de base par défaut

| Teinte | Hexa | Catégorie | Champs (du clair au foncé) |
| --- | --- | --- | --- |
| 🔴 rouge | `E53935` | Identifiants | N° de solution, Auteur, Responsable |
| 🟠 orange | `FB8C00` | Description détaillée | Lien Dossier Archi, Schéma Applicatif, Description Fonctionnelle, Données de la solution, Description Technique |
| 🟡 jaune | `FDD835` | Exploitation courante | Plage de fonctionnement, Supervision, Observabilité, Log, Sauvegardes |
| 🟢 vert | `7CB342` | Sécurité / accès | Servitudes, Comptes et services, Certificats, Liste blanche |
| 🔵 bleu | `1E88E5` | Échanges / livraison | Flux, Support, Changement et MEP, Matière (repo) |
| 🟣 indigo | `5C6BC0` | Reprise / annexes | Procédures de restauration / reconstruction / resynchronisation, Informations supplémentaires |

> *« Principes et décisions »* reste volontairement **vide** (règle 5) : il
> n'est donc jamais surligné. Le surlignage utilise un fond de caractère
> (`Shading.BackgroundPatternColor`), équivalent du `<w:shd>` OOXML.

## Installation et exécution

1. Ouvrir le DEX `.docx` à traiter (il doit être **enregistré sur disque**).
2. `Alt`+`F11` pour ouvrir l'éditeur VBA.
3. Ajouter le code, au choix :
   - **Import** : `Fichier > Importer un fichier…` → sélectionner
     `AnnotationDEX.bas` ; ou
   - **Copier-coller** : `Insertion > Module`, puis coller tout le contenu du
     fichier dans la fenêtre de code.
4. Revenir à Word, `Alt`+`F8`, choisir **`AnnoterDEX`**, `Exécuter`.

> Le fichier ne contient **pas** de ligne `Attribute VB_Name = …` : un
> copier-coller direct dans un module ne provoque donc pas d'erreur de syntaxe.
> (Lors d'un import, Word recrée cette métadonnée automatiquement.)

La macro crée puis ouvre `<nom>_ANNOTE.docx` (dans le même dossier que le DEX),
surligne les champs, et insère en tête une **légende** avec **une ligne par
champ** :

| Couleur | Catégorie | Champ | Contenu repéré dans ce document |
| --- | --- | --- | --- |

La colonne **« Contenu repéré dans ce document »** reprend ce qui a été capté
pour **ce** champ, **collé en réduit** (police 7 pt) : les **tableaux** sont
recopiés tels quels (en petit) et les **images** réduites en **miniatures**
(hauteur ≤ 36 pt). La légende est suivie de la liste des **champs non repérés**
à vérifier auprès de l'Équipier Ops (`RAS` si tout a été repéré).

## Limites

- Le repérage est volontairement **prudent** : en cas de doute, rien n'est
  deviné — la section non trouvée est listée sous la légende (règle 8).
- La détection des titres « par numérotation » suppose des titres **courts**
  commençant par un numéro de chapitre. Un titre sans numéro **et** sans style
  Word (texte simplement mis en gras « à la main ») ne sera pas reconnu comme
  une frontière de section.
- Les **miniatures** ne concernent que les images **en ligne**
  (`InlineShapes`) ; une image **ancrée/flottante** n'est pas reprise dans la
  légende.
- Le collage réduit du contenu utilise le presse-papiers ; en cas d'échec sur
  un passage, la macro bascule automatiquement sur une **restitution texte** de
  ce passage (aucune interruption).
