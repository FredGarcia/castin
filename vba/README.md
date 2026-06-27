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
  ignorés). Le numéro de chapitre (`~2.1`, `~13.3`…) n'est jamais utilisé.
- **Règle 2 — contenu utile uniquement** : les **titres** et les **encarts
  explicatifs** (paragraphe entièrement en *italique* + couleur non standard,
  typiquement le bleu d'aide du gabarit) ne sont **pas** surlignés.

Les mots-clés de chaque champ et la façon de découper les sections reprennent
ceux de `app/dex_castin_common.py` (`CASTIN_FIELDS`), pour un résultat cohérent
avec le reste de la chaîne.

## Couleurs par défaut (modifiables)

| Couleur | Catégorie | Champs |
| --- | --- | --- |
| 🔴 rouge clair | Identifiants | N° de solution, Auteur, Responsable |
| 🟠 orange | Description détaillée | Lien Dossier Archi, Schéma Applicatif, Description Fonctionnelle, Données de la solution, Description Technique |
| 🟡 jaune | Exploitation courante | Plage de fonctionnement, Supervision, Observabilité, Log, Sauvegardes |
| 🟢 vert | Sécurité / accès | Servitudes, Comptes et services, Certificats, Liste blanche |
| 🔵 bleu | Échanges / livraison | Flux, Support, Changement et MEP, Matière (repo) |
| 🟣 indigo | Reprise / annexes | Procédures de restauration / reconstruction / resynchronisation, Informations supplémentaires |

> *« Principes et décisions »* reste volontairement **vide** (règle 5) : il
> n'est donc jamais surligné.

**Pour changer une couleur**, modifier les lignes `RGB(...)` de la procédure
`InitCouleurs` en tête du fichier `.bas`. Le surlignage utilise un fond de
caractère (`Shading.BackgroundPatternColor`), équivalent du `<w:shd>` OOXML :
toute valeur RGB est donc acceptée.

## Installation et exécution

1. Ouvrir le DEX `.docx` à traiter (il doit être **enregistré sur disque**).
2. `Alt`+`F11` pour ouvrir l'éditeur VBA.
3. `Fichier > Importer un fichier…` → sélectionner `AnnotationDEX.bas`
   (ou copier son contenu dans un nouveau module).
4. Revenir à Word, `Alt`+`F8`, choisir **`AnnoterDEX`**, `Exécuter`.

La macro crée puis ouvre `<nom>_ANNOTE.docx` (dans le même dossier que le DEX),
surligne les champs, insère une **légende** en tête (couleur ↔ catégorie ↔
onglet ↔ champs) suivie de la liste des **sections non repérées** à vérifier
auprès de l'Équipier Ops (`RAS` si tout a été repéré).

## Limites

- Le repérage est volontairement **prudent** : en cas de doute, rien n'est
  deviné — la section non trouvée est listée dans la légende (règle 8).
- Le découpage des sections s'appuie sur les **niveaux de plan** Word
  (`OutlineLevel`). Un DEX dont les titres ne sont pas stylés en
  « Titre N » / « Heading N » (texte mis en gras « à la main ») sera moins bien
  repéré — comme pour le moteur Python.
