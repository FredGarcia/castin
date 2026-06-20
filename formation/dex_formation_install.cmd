@echo off
setlocal
echo ============================================================
echo  Installeur FORMATION DEX -> CAST'IN (tutoriels)
echo ============================================================
echo Extraction en cours...
set "DEXCMD_SELF=%~f0"
powershell -NoProfile -ExecutionPolicy Bypass -EncodedCommand JABFAHIAcgBvAHIAQQBjAHQAaQBvAG4AUAByAGUAZgBlAHIAZQBuAGMAZQAgAD0AIAAnAFMAdABvAHAAJwAKACQAcwBlAGwAZgAgAD0AIAAkAGUAbgB2ADoARABFAFgAQwBNAEQAXwBTAEUATABGAAoAaQBmACAAKAAtAG4AbwB0ACAAJABzAGUAbABmACkAIAB7ACAAVwByAGkAdABlAC0ASABvAHMAdAAgACcARQByAHIAZQB1AHIAIAA6ACAAYwBoAGUAbQBpAG4AIABkAHUAIABzAGMAcgBpAHAAdAAgAGkAbgB0AHIAbwB1AHYAYQBiAGwAZQAuACcAOwAgAGUAeABpAHQAIAAxACAAfQAKACQAcgBvAG8AdAAgAD0AIABTAHAAbABpAHQALQBQAGEAdABoACAALQBQAGEAcgBlAG4AdAAgACQAcwBlAGwAZgAKACQAdQB0AGYAOAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBUAGUAeAB0AC4AVQBUAEYAOABFAG4AYwBvAGQAaQBuAGcAKAAkAGYAYQBsAHMAZQApAAoAJABsAGkAbgBlAHMAIAA9ACAAWwBTAHkAcwB0AGUAbQAuAEkATwAuAEYAaQBsAGUAXQA6ADoAUgBlAGEAZABBAGwAbABMAGkAbgBlAHMAKAAkAHMAZQBsAGYALAAgAFsAUwB5AHMAdABlAG0ALgBUAGUAeAB0AC4ARQBuAGMAbwBkAGkAbgBnAF0AOgA6AFUAVABGADgAKQAKACQAaQAgAD0AIAAwAAoAJABjAG8AdQBuAHQAIAA9ACAAMAAKAHcAaABpAGwAZQAgACgAJABpACAALQBsAHQAIAAkAGwAaQBuAGUAcwAuAEwAZQBuAGcAdABoACkAIAB7AAoAIAAgACAAIAAkAGwAIAA9ACAAJABsAGkAbgBlAHMAWwAkAGkAXQAKACAAIAAgACAAJAB0AHgAdAAgAD0AIAAkAGwALgBTAHQAYQByAHQAcwBXAGkAdABoACgAJwAjAEAARgBJAEwARQBfAFQAWABUADoAJwApAAoAIAAgACAAIAAkAGIAaQBuACAAPQAgACQAbAAuAFMAdABhAHIAdABzAFcAaQB0AGgAKAAnACMAQABGAEkATABFAF8AQgBJAE4AOgAnACkACgAgACAAIAAgAGkAZgAgACgAJAB0AHgAdAAgAC0AbwByACAAJABiAGkAbgApACAAewAKACAAIAAgACAAIAAgACAAIAAkAHIAZQBsACAAPQAgACQAbAAuAFMAdQBiAHMAdAByAGkAbgBnACgAMQAxACkALgBSAGUAcABsAGEAYwBlACgAJwAvACcALAAgACcAXAAnACkACgAgACAAIAAgACAAIAAgACAAJABpACsAKwAKACAAIAAgACAAIAAgACAAIAAkAHMAdABhAHIAdAAgAD0AIAAkAGkACgAgACAAIAAgACAAIAAgACAAdwBoAGkAbABlACAAKAAkAGkAIAAtAGwAdAAgACQAbABpAG4AZQBzAC4ATABlAG4AZwB0AGgAIAAtAGEAbgBkACAAJABsAGkAbgBlAHMAWwAkAGkAXQAgAC0AbgBlACAAJwAjAEAARgBJAEwARQBfAEUATgBEACcAKQAgAHsAIAAkAGkAKwArACAAfQAKACAAIAAgACAAIAAgACAAIABpAGYAIAAoACQAaQAgAC0AZwB0ACAAJABzAHQAYQByAHQAKQAgAHsAIAAkAGIAbwBkAHkAIAA9ACAAJABsAGkAbgBlAHMAWwAkAHMAdABhAHIAdAAuAC4AKAAkAGkAIAAtACAAMQApAF0AIAB9ACAAZQBsAHMAZQAgAHsAIAAkAGIAbwBkAHkAIAA9ACAAQAAoACkAIAB9AAoAIAAgACAAIAAgACAAIAAgACQAZABlAHMAdAAgAD0AIABKAG8AaQBuAC0AUABhAHQAaAAgACQAcgBvAG8AdAAgACQAcgBlAGwACgAgACAAIAAgACAAIAAgACAAJABkAGkAcgAgAD0AIABTAHAAbABpAHQALQBQAGEAdABoACAALQBQAGEAcgBlAG4AdAAgACQAZABlAHMAdAAKACAAIAAgACAAIAAgACAAIABpAGYAIAAoACQAZABpAHIAIAAtAGEAbgBkACAALQBuAG8AdAAgACgAVABlAHMAdAAtAFAAYQB0AGgAIAAtAEwAaQB0AGUAcgBhAGwAUABhAHQAaAAgACQAZABpAHIAKQApACAAewAKACAAIAAgACAAIAAgACAAIAAgACAAIAAgAE4AZQB3AC0ASQB0AGUAbQAgAC0ASQB0AGUAbQBUAHkAcABlACAARABpAHIAZQBjAHQAbwByAHkAIAAtAEYAbwByAGMAZQAgAC0AUABhAHQAaAAgACQAZABpAHIAIAB8ACAATwB1AHQALQBOAHUAbABsAAoAIAAgACAAIAAgACAAIAAgAH0ACgAgACAAIAAgACAAIAAgACAAaQBmACAAKAAkAHQAeAB0ACkAIAB7AAoAIAAgACAAIAAgACAAIAAgACAAIAAgACAAJAB0AGUAeAB0ACAAPQAgAFsAcwB0AHIAaQBuAGcAXQA6ADoASgBvAGkAbgAoACIAYABuACIALAAgACQAYgBvAGQAeQApAAoAIAAgACAAIAAgACAAIAAgACAAIAAgACAAaQBmACAAKAAkAGIAbwBkAHkALgBMAGUAbgBnAHQAaAAgAC0AZwB0ACAAMAApACAAewAgACQAdABlAHgAdAAgAD0AIAAkAHQAZQB4AHQAIAArACAAIgBgAG4AIgAgAH0ACgAgACAAIAAgACAAIAAgACAAIAAgACAAIABbAFMAeQBzAHQAZQBtAC4ASQBPAC4ARgBpAGwAZQBdADoAOgBXAHIAaQB0AGUAQQBsAGwAVABlAHgAdAAoACQAZABlAHMAdAAsACAAJAB0AGUAeAB0ACwAIAAkAHUAdABmADgAKQAKACAAIAAgACAAIAAgACAAIAB9ACAAZQBsAHMAZQAgAHsACgAgACAAIAAgACAAIAAgACAAIAAgACAAIAAkAGIANgA0ACAAPQAgAFsAcwB0AHIAaQBuAGcAXQA6ADoASgBvAGkAbgAoACcAJwAsACAAJABiAG8AZAB5ACkACgAgACAAIAAgACAAIAAgACAAIAAgACAAIABbAFMAeQBzAHQAZQBtAC4ASQBPAC4ARgBpAGwAZQBdADoAOgBXAHIAaQB0AGUAQQBsAGwAQgB5AHQAZQBzACgAJABkAGUAcwB0ACwAIABbAEMAbwBuAHYAZQByAHQAXQA6ADoARgByAG8AbQBCAGEAcwBlADYANABTAHQAcgBpAG4AZwAoACQAYgA2ADQAKQApAAoAIAAgACAAIAAgACAAIAAgAH0ACgAgACAAIAAgACAAIAAgACAAVwByAGkAdABlAC0ASABvAHMAdAAgACgAIgAgACAAZQBjAHIAaQB0ACAAIAAgAHsAMAB9ACIAIAAtAGYAIAAkAHIAZQBsACkACgAgACAAIAAgACAAIAAgACAAJABjAG8AdQBuAHQAKwArAAoAIAAgACAAIAB9AAoAIAAgACAAIAAkAGkAKwArAAoAfQAKAFcAcgBpAHQAZQAtAEgAbwBzAHQAIAAnACcACgBXAHIAaQB0AGUALQBIAG8AcwB0ACAAKAAiAFQAZQByAG0AaQBuAGUAIAA6ACAAewAwAH0AIABmAGkAYwBoAGkAZQByACgAcwApACAAZQB4AHQAcgBhAGkAdAAoAHMAKQAgAGQAYQBuAHMAIAA6ACIAIAAtAGYAIAAkAGMAbwB1AG4AdAApAAoAVwByAGkAdABlAC0ASABvAHMAdAAgACgAIgAgACAAewAwAH0AIgAgAC0AZgAgACQAcgBvAG8AdAApAAoA
set "RC=%ERRORLEVEL%"
set "DEXCMD_SELF="
echo .
echo Formation extraite dans formation\ :
echo   operateurs -> formation\01_operateurs_prise_en_main.md
echo   direction  -> formation\02_direction_vue_ensemble.md
echo   managers   -> formation\03_managers_guide_technique.md
endlocal & exit /b %RC%
#@FILE_TXT:formation/00_README_formation.md
# Formation & prise en main

Trois parcours pédagogiques selon le public, du plus simple au plus technique :

| Public | Fichier | Pré-requis |
|--------|---------|------------|
| **Opérateurs** | `01_operateurs_prise_en_main.md` | Aucune notion informatique. Pas-à-pas, zéro jargon. |
| **Direction** | `02_direction_vue_ensemble.md` | Quelques notions. Valeur, cadre, indicateurs, limites. |
| **Managers** | `03_managers_guide_technique.md` | Bonne aisance technique. Architecture, règles, API, tests. |

> Tous les documents contiennent des **diagrammes** (ASCII, lisibles partout ; le guide
> managers ajoute des diagrammes **Mermaid** rendus par les lecteurs compatibles —
> GitHub, VS Code, Obsidian…).

Ordre conseillé de diffusion : opérateurs pour la mise en main quotidienne ; direction pour
la décision et le cadrage ; managers pour le pilotage technique et le déploiement.
#@FILE_END
#@FILE_TXT:formation/01_operateurs_prise_en_main.md
# Prise en main — Guide opérateur

*Pour reprendre une fiche DEX dans CAST'IN, pas à pas. Aucune connaissance informatique
nécessaire.*

---

## 1. À quoi sert cet outil ?

Vous devez recopier des informations depuis un document Word (appelé **DEX**) vers une
application web (appelée **CAST'IN**). C'est long et on peut se tromper.

Cet outil **vous aide** : il lit le document, **retrouve tout seul** les bonnes
informations, et vous les présente **prêtes à copier**. Vous gardez la main : c'est
**vous** qui validez et qui collez dans CAST'IN.

> **À retenir** : l'outil ne réécrit jamais votre texte. Ce qu'il affiche est **exactement**
> ce qui est écrit dans le document. Il vous fait juste gagner du temps.

Et rassurez-vous : **rien ne sort de votre ordinateur**. Tout se passe en local.

---

## 2. Les mots à connaître (juste 4)

| Mot | Ce que ça veut dire |
|-----|---------------------|
| **DEX** | Le document Word de départ (la fiche à reprendre). |
| **CAST'IN** | L'application web dans laquelle vous recopiez. |
| **Champ** | Une case à remplir dans CAST'IN (ex. « Supervision », « Sauvegardes »). |
| **Pastille** | La petite **pastille de couleur** qui vous dit si l'info est sûre. |

---

## 3. Le parcours en 5 étapes

```
   +-----------------------------------------------------------+
   |  1. J'ouvre l'outil dans le navigateur                    |
   +-----------------------------------------------------------+
                              |
                              v
   +-----------------------------------------------------------+
   |  2. Je dépose le document Word (le DEX)                    |
   +-----------------------------------------------------------+
                              |
                              v
   +-----------------------------------------------------------+
   |  3. Je regarde les pastilles de couleur                   |
   |       vert = sûr   orange = à relire   rouge = à vérifier |
   +-----------------------------------------------------------+
                              |
                              v
   +-----------------------------------------------------------+
   |  4. Je copie chaque information et je la colle dans CAST'IN|
   +-----------------------------------------------------------+
                              |
                              v
   +-----------------------------------------------------------+
   |  5. Si quelque chose cloche : je signale                  |
   +-----------------------------------------------------------+
```

---

## 4. Étape par étape

### Étape 1 — Ouvrir l'outil

Ouvrez le **raccourci** (ou l'**adresse**) qu'on vous a indiqué. Une page s'affiche dans
votre navigateur habituel, avec des onglets en haut. Restez sur le premier :
**« Reprise assistée »**.

> Si la page ne s'ouvre pas, prévenez la personne qui vous a installé l'outil. Ce n'est
> pas de votre faute.

### Étape 2 — Déposer le document

Deux façons, au choix :

- **Glisser-déposer** : attrapez le fichier Word avec la souris et lâchez-le sur la zone
  prévue.
- **Choisir un fichier** : cliquez sur **« Charger un DEX »** et sélectionnez le document.

Vous avez **plusieurs documents** à traiter ? Cliquez sur **« …ou un dossier de DEX »** et
choisissez le dossier : l'outil les traite **tous, l'un après l'autre**.

### Étape 3 — Lire les pastilles

L'outil affiche une **carte** par information à reprendre. Chaque carte a une **pastille** :

```
   ( vert )    L'information a été trouvée avec certitude.
               -> Vous pouvez la copier telle quelle.

   ( orange )  L'information a été trouvée, mais à relire.
               -> Jetez un oeil avant de copier.

   ( rouge )   Information douteuse ou très courte.
               -> Vérifiez dans le document.

   ( gris )    Rien n'a été trouvé pour ce champ.
               -> C'est peut-être normal (voir plus bas).
```

> **« Non concerné »** : si une carte indique « Non concerné », cela veut souvent dire que
> le sujet **n'existe pas** dans ce document (par exemple, pas de certificat). Ce n'est pas
> une erreur ; confirmez simplement que c'est bien le cas.

### Étape 4 — Copier dans CAST'IN

Sur chaque carte, un bouton permet de **copier** le contenu. Cliquez, puis **collez**
(Ctrl + V) dans le **champ correspondant** de CAST'IN. Le nom de la carte vous indique
quel champ remplir.

### Étape 5 — Les cas particuliers

- **Deux possibilités (badge ⚐)** : parfois l'outil hésite entre deux passages du
  document. Il vous propose de **choisir** le bon. Lisez les deux et cliquez sur celui qui
  convient.
- **« Points à vérifier »** : une petite liste de choses à **revérifier** à la main. Prenez
  le temps de les regarder.
- **Quelque chose est faux ?** Utilisez le bouton de **signalement** : il prépare un
  e-mail tout fait que vous pouvez envoyer à l'équipe. Vous n'avez rien à rédiger.

---

## 5. Les bons réflexes

- ✔ **Faites confiance au vert**, **relisez l'orange**, **vérifiez le rouge**.
- ✔ En cas de doute, **ouvrez le document Word** pour comparer.
- ✔ Si une carte dit « Non concerné », **confirmez** que le sujet n'existe pas.
- ✔ Un souci ? **Signalez** plutôt que de deviner.
- ✘ Ne vous inquiétez pas de « casser » quelque chose : l'outil **ne modifie pas** votre
  document et **n'envoie rien** sur Internet.

---

## 6. Questions fréquentes

**« Je me trompe d'onglet, c'est grave ? »**
Non. Revenez sur **« Reprise assistée »** et continuez.

**« L'outil a-t-il rempli CAST'IN tout seul ? »**
Non, et c'est normal : **c'est vous** qui copiez-collez. L'outil prépare, vous validez.

**« Une information manque, que faire ? »**
Regardez d'abord si c'est « Non concerné » (sujet absent). Sinon, ouvrez le document pour
vérifier, et au besoin **signalez**.

**« Mes données partent-elles quelque part ? »**
Non. Tout reste **sur votre poste**.

---

> Besoin d'aide ? Adressez-vous à la personne référente de l'outil. Ce guide est là pour
> vous accompagner : allez à votre rythme.
#@FILE_END
#@FILE_TXT:formation/02_direction_vue_ensemble.md
# Prise en main — Note pour la direction

*Comprendre ce que fait l'outil, la valeur qu'il apporte et le cadre dans lequel il opère.
Quelques notions informatiques suffisent.*

---

## 1. En une phrase

Un outil **local** qui assiste la **reprise manuelle** des fiches techniques **DEX** (Word)
vers l'application **CAST'IN** : il repère automatiquement les informations, en évalue la
fiabilité, et laisse l'opérateur **valider** — plus vite et avec moins d'erreurs.

---

## 2. Le problème adressé

La reprise des DEX se fait aujourd'hui **à la main** : on lit un document Word, on retrouve
la bonne section, on recopie dans CAST'IN. C'est **chronophage**, **répétitif** et **propice
aux erreurs** (oublis, mauvaise section, copier-coller approximatif).

## 3. La valeur apportée

- **Gain de temps** : les informations sont **pré-repérées** et prêtes à copier.
- **Moins d'erreurs** : un **code couleur** signale les passages sûrs et ceux à revérifier.
- **Traçabilité** : un **historique** des fiches traitées est conservé localement (utile
  pour le suivi et l'audit interne).
- **Zéro friction d'installation** : un simple fichier à exécuter, **sans logiciel lourd**.

---

## 4. Ce que l'outil fait — et ne fait pas

```
   Document DEX (Word)                                 CAST'IN (web)
        |                                                   ^
        |                                                   |
        v                                                   |  copier-coller
   +---------------------------+      l'opérateur valide     |  (manuel)
   |   OUTIL D'AIDE (local)    | -------------------------->-+
   |  - repère les 23 champs   |
   |  - évalue la confiance    |     Rien ne sort du poste.
   |  - signale les doutes     |     Pas de connexion à CAST'IN.
   +---------------------------+
```

- ✔ Il **repère**, **évalue** et **présente** l'information.
- ✔ Il **signale** les ambiguïtés et les points à vérifier.
- ✘ Il **ne remplit pas** CAST'IN automatiquement (pas de connexion à CAST'IN) :
  **l'humain reste dans la boucle**.
- ✘ Il **ne réécrit jamais** le contenu : ce qui est affiché est fidèle au document.

> Ce choix est **volontaire** : l'opérateur garde le contrôle et la responsabilité de la
> validation. L'outil est une **aide à la décision**, pas un automate.

---

## 5. Un signal qualité simple : trois couleurs

Chaque information reçoit une **pastille** :

| Couleur | Signification | Action attendue |
|---------|---------------|-----------------|
| **Vert** | Repérage fiable | Copier tel quel |
| **Orange** | Repérage à confirmer | Relire avant de copier |
| **Rouge** | Douteux ou très court | Vérifier dans le document |
| **Gris** | Non trouvé / « Non concerné » | Confirmer que le sujet est bien absent |

Ce code couleur permet de **concentrer l'attention** là où elle est utile.

---

## 6. Indicateurs de pilotage

L'outil expose des indicateurs simples, consultables localement :

- **Taux d'acceptation** : proportion d'informations validées sans correction.
- **Points à vérifier** : nombre de contrôles manuels signalés par fiche.
- **Historique** : liste des fiches traitées (date, fiche, qualité du repérage).

Ces éléments aident à **mesurer la charge** et à **repérer les DEX mal structurés**.

---

## 7. Cadre et conformité

- **Confidentialité** : l'outil fonctionne **uniquement en local** (adresse de bouclage
  127.0.0.1). **Aucune donnée ne quitte le poste**, aucune dépendance à un service externe.
- **Accessibilité** : conçu selon les référentiels **RGAA / WCAG / DSFR** (navigation
  clavier, contrastes, libellés).
- **Robustesse** : résultat **déterministe** (même document → même résultat), **sans
  installation lourde** ni dépendance technique.
- **Auditabilité** : un **jeu de tests** documente le comportement attendu de l'outil.

---

## 8. Limites à connaître (en toute transparence)

- L'outil **assiste**, il ne se substitue pas au jugement : un DEX **mal structuré** donnera
  un repérage moins net (davantage d'orange/rouge).
- La **ré-ouverture** d'une fiche depuis l'historique fonctionne **pendant la session de
  travail** ; après fermeture, on re-sélectionne le dossier.
- Il **ne se connecte pas** à CAST'IN : la saisie finale reste **manuelle** (par choix de
  maîtrise et de sécurité).

---

## 9. Déploiement en bref

Un **fichier unique** à exécuter installe l'outil sur un poste ; un autre fournit la
**documentation**, un autre les **tests**, un autre la **formation**. Aucun serveur central,
aucune base de données à administrer.

> **En résumé** : un outil **sobre**, **local** et **maîtrisé**, qui fait gagner du temps sur
> une tâche fastidieuse tout en gardant l'humain décideur.
#@FILE_END
#@FILE_TXT:formation/03_managers_guide_technique.md
# Prise en main — Guide technique (managers)

*Vue technique de l'outil : architecture, règles de repérage, modèle de confiance, API,
déploiement et tests. Destiné à un public à l'aise avec l'informatique.*

---

## 1. Positionnement

Outil **mono-poste** d'aide à la reprise **manuelle** de DEX (Word `.docx`) vers
l'application web **CAST'IN**. Il **n'y a pas d'API CAST'IN** : l'outil produit un repérage
assisté (contenu + confiance + points à vérifier), la saisie reste humaine.

Contraintes structurantes : **zéro dépendance** (Python *stdlib* + Vue 3 *global* sans
build), **contenu jamais reformulé** (règle R7), **déterminisme**, **127.0.0.1** (rien ne
quitte le poste), **accessibilité RGAA/WCAG/DSFR**.

---

## 2. Architecture

```
   DEX .docx
      |
      v
  +--------------------------------------+
  |  MOTEUR  (lecture seule)             |   dex_castin_common.py / _cli.py
  |  - lit le document                   |
  |  - repère 23 champs PAR LEUR NOM     |
  |  - extrait le contenu, propose des   |
  |    sections candidates               |
  +--------------------------------------+
      |  (importé, jamais modifié)
      v
  +--------------------------------------+
  |  SERVEUR  (HTTP stdlib, 127.0.0.1)   |   dex_castin_server.py
  |  - enrichit : confiance, ambiguïté,  |
  |    points à vérifier, candidats      |
  |  - config, calibration, historique   |
  |  - Store : events / analyses / runs  |
  +--------------------------------------+
      |  REST /api/*  (JSON)
      v
  +--------------------------------------+
  |  FRONT  (Vue 3 global, sans build)   |   front/index.html
  |  5 onglets : Reprise · Dictionnaire  |
  |  · Tableau de bord · Historique ·    |
  |  Administration                      |
  +--------------------------------------+
```

Équivalent Mermaid (si votre lecteur le rend) :

```mermaid
flowchart TD
    A[DEX .docx] --> B[Moteur lecture seule<br/>repérage par nom]
    B --> C[Serveur stdlib 127.0.0.1<br/>confiance, ambiguïté, points]
    C -->|REST /api/*| D[Front Vue 3 sans build<br/>5 onglets]
    C --> E[(Store<br/>events / analyses / runs)]
```

**Principe clé** : le **moteur est read-only**. Toute évolution se fait au **serveur** (qui
l'enrichit) ou au **front**. Cela protège le cœur de repérage et garantit la reproductibilité.

---

## 3. Données : 23 champs, 5 natures

Les 23 champs CAST'IN sont repérés **par nom** (jamais par numéro — règle R1). Chaque champ
a une **nature** (`kind`) qui pilote l'extraction et le score :

| Nature | Sens | Exemple de champ |
|--------|------|------------------|
| `text` | Contenu rédigé | Supervision, Sauvegardes, Description technique |
| `link` | Référence repérée par motif | Lien Dossier Archi (DAP…), Schéma (ADU…) |
| `empty` | **Toujours vide** par règle (R5) | Principes et décisions |
| `merge` | Assemblé de plusieurs apports | Changement et MEP, Matière (repo) |
| `appendix` | **Optionnel** (R6) | Informations supplémentaires |

---

## 4. Règles métier (R1–R8)

| Règle | Énoncé |
|------|--------|
| **R1** | Repérage **par nom** de section (jamais par numéro). |
| **R2** | **Écarter les encarts** d'aide (paragraphes *italique + bleu*). |
| **R3** | **Nettoyer** les caractères parasites (puces de police symbole, espaces). |
| **R4** | **« Non concerné »** si la section est absente. |
| **R5** | **« Principes et décisions » toujours vide** (`kind=empty`). |
| **R6** | **« Informations supplémentaires »** optionnel (absence non pénalisée). |
| **R7** | **Ne jamais reformuler** le contenu. |
| **R8** | Doutes → **« Points à vérifier »**. |

---

## 5. Modèle de confiance

Chaque champ reçoit une **confiance** (0 à 1), agrégée en quatre bandes (élevée ≥ 0,8 ;
moyenne [0,5–0,8[ ; faible < 0,5 ; vide = sans confiance).

```
   base (selon la nature)            texte 0.90  /  lien 0.80  /  composé 0.75
        |
        +--  malus contenu court (< 15 car.)     -0.15
        +--  malus correspondance faible         -0.10
        +--  malus ambiguïté                     -0.20  (plafonné à 0.40 si signalé)
        |
   requis absent ............................. 0.30   (-> bande « faible »)
   optionnel absent .......................... 0.85   (-> bande « élevée »)
```

Points d'attention (observés) :
- **« faible » ≠ mauvais repérage** : c'est surtout un **champ requis absent** (0,30).
- **Contenu court** → **moyenne 0,75** (pas faible).
- Une **section présente mais vide** est comptée « aboutie » (source localisée) tout en
  restant à 0,30.

---

## 6. Ambiguïté & points à vérifier

Quand plusieurs sections peuvent correspondre à un même champ (écart de score sous la marge,
ou meilleur candidat ≠ sélection moteur), le champ est marqué **ambigu** (badge ⚐) : le front
propose un **radiogroup** pour confirmer la bonne section. Les doutes alimentent la liste des
**points à vérifier** (R8).

---

## 7. API REST (127.0.0.1)

```
GET   /api/health        /api/metrics      /api/config
      /api/rules         /api/calibration  /api/history
POST  /api/process-dex   /api/validate     /api/replay
      /api/config        /api/rules/reload /api/calibration/proposer
```

Séquence type d'un traitement :

```mermaid
sequenceDiagram
    participant F as Front
    participant S as Serveur
    participant M as Moteur (RO)
    participant T as Store
    F->>S: POST /api/process-dex (chemin ou base64)
    S->>M: process_path(...)
    M-->>S: champs + sections candidates
    S->>S: confiance, ambiguïté, points
    S->>T: analyses.jsonl (1 ligne)
    S-->>F: DEX enrichi (JSON)
    F->>S: POST /api/validate (acceptations)
    S->>T: events.jsonl
```

---

## 8. Historique, métriques, calibration

- **Store** (`--data-dir`) : `events.jsonl` (validations), `analyses.jsonl` (une ligne par
  DEX traité, alimente l'Historique), `runs/` (instantanés).
- **Métriques** : fenêtre glissante, **taux d'acceptation**, durée par DEX, points.
- **Calibration** : boucle de 2ᵉ ordre (proposition de seuils/règles candidates) — voir
  `ANNEXE_Boucle_2e_ordre.md`. Le moteur restant figé, la calibration agit côté **règles**.

---

## 9. Déploiement (installeurs `.cmd`)

Quatre installeurs Windows **auto-extractibles** (base64 + PowerShell, fidélité octet par
octet) :

| Installeur | Contenu |
|------------|---------|
| `dex_app_install.cmd` | **Runtime** : moteur, serveur, calibration, règles, config, front, outils de calibration. |
| `dex_docs_install.cmd` | **Documentation** projet (hors tests). |
| `dex_tests_install.cmd` | **Tout le test** : DEX de test + auto-référentiels, résultats attendus, plan, recette, générateurs, outils de test. |
| `dex_formation_install.cmd` | **Formation** : ces trois tutoriels. |

Lancement après extraction de l'app :

```
python dex_castin_server.py --data-dir .data --front front
# puis http://127.0.0.1:8765/   (option --port pour changer)
```

---

## 10. Tests

Jeu de **24 DEX** synthétiques + **4 DEX auto-référentiels** (l'application décrite
elle-même). Chaque cas a une **sortie attendue observée sur exécution réelle** (oracle de
non-régression) — voir `TEST_PLAN.md` et les fichiers `_RESULTATS_ATTENDUS*.md`.

Exécution par lot : onglet **Reprise** → bouton **dossier** → sélectionner `dex_tests/`
(puis `dex_tests_self/`), et confronter à l'Historique. Régénération :
`python generer_dex_tests.py <DEX_réf.docx>` et `python generer_dex_self.py <DEX_réf.docx>`.

---

## 11. Limites & extension

- **Moteur read-only** : les évolutions de logique passent par le **serveur** (enrichissement)
  ou des **règles** ; on ne modifie pas le cœur de repérage.
- **Pas d'API CAST'IN** : saisie finale manuelle (choix de maîtrise).
- **Ré-ouverture** depuis l'historique : **portée session** (le navigateur n'expose pas les
  chemins absolus). Persistance cross-session = piste ouverte.
- **Ambiguïté sur champ lien** : non déclenchée par le moteur (comportement constaté).
- Pistes : export DEX annoté, `.eml` local, lexique par famille de gabarit, persistance du
  chemin source.

---

> **Synthèse** : un cœur de repérage **figé et testé**, enrichi par un serveur **local et
> sobre**, piloté par un front **sans build**. La maîtrise prime : reproductible, auditable,
> hors-ligne, et explicitement **assisté** plutôt qu'automatique.
#@FILE_END
