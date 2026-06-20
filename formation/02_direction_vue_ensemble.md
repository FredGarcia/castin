  direction  -
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
