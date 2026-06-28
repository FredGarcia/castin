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

## Configuration (couleurs, catégories, répartition des champs)

Toute la configuration vit dans un fichier **`AnnotationDEX.config.ini`**
(fourni dans ce dossier), pour la modifier **sans toucher au code** :

- `[couleurs]` : une couleur par clé, en **hexadécimal RVB** (`RRGGBB`) ;
- `[categories]` : `clé = Libellé | clé_de_couleur` (l'ordre fixe l'ordre des
  lignes de la légende) ;
- `[champs]` : `Libellé du champ = catégorie | type | mots-clés (séparés par ;)`
  où `type` ∈ `text | link | merge | appendix`.

**Où le fichier est cherché** : d'abord le chemin de la constante
`CONFIG_CHEMIN` (en tête du `.bas`, vide par défaut), puis
`AnnotationDEX.config.ini` **dans le dossier du DEX**. S'il est introuvable, la
macro utilise des **valeurs par défaut intégrées** (identiques au `.ini` fourni)
— elle fonctionne donc sans configuration. Le message de fin indique quelle
source a été utilisée.

> Conserver des libellés **sans accents** dans le `.ini` (lecture ANSI), ou
> enregistrer le fichier en ANSI.

### Couleurs et catégories par défaut

| Couleur | Catégorie | Champs |
| --- | --- | --- |
| 🔴 `FF9999` rouge clair | Identifiants | N° de solution, Auteur, Responsable |
| 🟠 `FFB266` orange | Description détaillée | Lien Dossier Archi, Schéma Applicatif, Description Fonctionnelle, Données de la solution, Description Technique |
| 🟡 `FFEB78` jaune | Exploitation courante | Plage de fonctionnement, Supervision, Observabilité, Log, Sauvegardes |
| 🟢 `92D06E` vert | Sécurité / accès | Servitudes, Comptes et services, Certificats, Liste blanche |
| 🔵 `8EB4E3` bleu | Échanges / livraison | Flux, Support, Changement et MEP, Matière (repo) |
| 🟣 `9F9FE0` indigo | Reprise / annexes | Procédures de restauration / reconstruction / resynchronisation, Informations supplémentaires |

> *« Principes et décisions »* reste volontairement **vide** (règle 5) : il
> n'est donc jamais surligné. Le surlignage utilise un fond de caractère
> (`Shading.BackgroundPatternColor`), équivalent du `<w:shd>` OOXML : toute
> valeur RGB est acceptée.

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
surligne les champs, et insère en tête une **légende** sous forme de tableau :

| Couleur | Catégorie | Champs | Contenu repéré dans ce document |
| --- | --- | --- | --- |

La colonne **« Contenu repéré dans ce document »** reprend, pour chaque
catégorie, ce qui a été effectivement capté dans **ce** DEX :

- les **tableaux** sont restitués **ligne par ligne** (`cellule | cellule | …`),
  et non plus aplatis ;
- les **images** des sections repérées sont collées en **miniatures**
  (hauteur ≤ 48 pt).

La légende est suivie de la liste des **sections non repérées** à vérifier
auprès de l'Équipier Ops (`RAS` si tout a été repéré).

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
