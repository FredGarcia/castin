# Recette du front — Reprise DEX → CAST'IN (poste assisté)

Passe **visuelle, fonctionnelle et d'accessibilité** à exécuter dans le navigateur,
avant le rodage avec le développeur confirmé. Cochez chaque ligne ; reportez tout
écart dans la colonne *Notes* de la grille finale.

**Hors périmètre de cette recette** (couverts ailleurs) : l'exactitude de
l'extraction de contenu (harness moteur `tests/run_tests.py`), la qualité
statistique de la calibration (`outils/calibration_check.py` + self-test du module).
Ici on valide le **rendu, l'ergonomie, l'accessibilité, l'intégration et les invariants**.

---

## Préalables

- [ ] Moteur (`dex_castin_common.py`) présent à côté de `dex_castin_server.py`.
- [ ] Lancer le back : `python dex_castin_server.py` (defaut 127.0.0.1). Noter le port affiché.
- [ ] Ouvrir `http://127.0.0.1:<port>/` dans le navigateur cible (Chrome/Firefox/Edge).
- [ ] DEX de démonstration disponible : `DEX_S20001_Nominal.docx`.
- [ ] Bandeau d'état en haut : **« Service : connecté · règles 1.0.0 »** (sinon, le back n'est pas joignable).

---

## 0. Invariants mono-poste / confidentialité (DevTools → Réseau)

- [ ] **0.1** Onglet *Réseau* ouvert, recharger la page : **aucune requête vers un domaine externe / CDN**. Tout part vers `127.0.0.1` (Vue est vendoré en local `front/vue.global.prod.js`).
- [ ] **0.2** Pendant tout l'usage (traitement, validation, calibration), **aucun appel sortant** hors `127.0.0.1`.
- [ ] **0.3** *Application → Stockage* : pas d'usage de `localStorage` / `sessionStorage` (aucune persistance navigateur).
- [ ] **0.4** Après un traitement par **upload**, le DEX n'est pas conservé : seul le journal local (`donnees/events.jsonl`) et les instantanés (`donnees/runs/`) existent côté serveur.

---

## 1. Accessibilité (RGAA 4.1 / WCAG 2.2 / DSFR)

- [ ] **1.1** `lang="fr"` sur `<html>` ; titre d'onglet explicite (« Reprise DEX → CAST'IN — poste assisté »).
- [ ] **1.2** *Skip-link* (WCAG 2.4.1) : depuis le tout début, `Tab` fait apparaître **« Aller au contenu principal »** ; l'activer place le focus sur le contenu (`#principal`).
- [ ] **1.3** Onglets (WCAG 4.1.2 / 2.1.1) : focus sur la barre d'onglets (**Reprise / Dictionnaire / Tableau de bord / Historique / Administration**), **flèches ⬅/➡** font défiler **les cinq** onglets en boucle, `Entrée`/`Espace` activent, l'onglet actif porte l'état ARIA sélectionné.
- [ ] **1.4** *Focus visible* (WCAG 2.4.7) sur **tous** les contrôles (liens, boutons, champs, select, cases).
- [ ] **1.5** Tout est **opérable au clavier** (WCAG 2.1.1) : charger un DEX, sélectionner un champ, Copier, Accepter, Signaler + formulaire, Analyser la calibration, Recharger les règles. Pas de **piège clavier** (2.1.2).
- [ ] **1.6** *Messages de statut* (WCAG 4.1.3) : les confirmations et erreurs sont annoncées (zones `aria-live`/`role=status`). Tester au lecteur d'écran (NVDA/VoiceOver) si possible.
- [ ] **1.7** *Usage de la couleur* (WCAG 1.4.1 / RGAA 3.1) : la confiance n'est **pas** véhiculée par la seule couleur — vérifier la présence du **% + mot** à côté de la jauge ; le badge **« À revoir »** porte un texte, pas qu'une couleur.
- [ ] **1.8** *Contraste* (WCAG 1.4.3 / 1.4.11) : texte ≥ 4,5:1, composants ≥ 3:1. Vérifier en priorité les badges de confiance (faible/élevée), le badge « À revoir », les barres du diagramme de fiabilité, et les en-têtes de groupe collants.
- [ ] **1.9** *Information et relations* (WCAG 1.3.1) : les champs sont regroupés sous des **en-têtes d'onglet CAST'IN** (`<h3>` « Description détaillée », « DEX »…) ; la table acceptation/champ a des en-têtes de colonnes.
- [ ] **1.10** Le **diagramme de fiabilité** a une alternative : `aria-label` décrivant son contenu, **et** la table chiffrée acceptation/champ joue le rôle d'équivalent textuel.
- [ ] **1.11** Les **flèches AR** (`⟶ champ`) et la zone de glisser-déposer sont décoratives (`aria-hidden`) ; l'accès reste assuré par le texte et le `<input type=file>`.
- [ ] **1.12** *Animation réduite* (WCAG 2.3.3) : avec `prefers-reduced-motion: reduce` activé (OS/navigateur), aucune transition gênante. **⚠ À confirmer** — si une règle `@media (prefers-reduced-motion)` est absente du CSS, le noter comme correctif léger à prévoir.
- [ ] **1.13** *Reflow* (WCAG 1.4.10) : zoom **200 %** et fenêtre étroite — pas de perte d'information/fonction, pas de défilement horizontal parasite.
- [ ] **1.14** *Cartes rétractables* (WCAG 4.1.2) : le **chevron** de chaque carte est un `<button>` portant `aria-expanded` (true/false) et `aria-controls` vers le corps, avec un libellé explicite (« Replier/Déplier <champ> ») ; opérable au clavier, focus visible.
- [ ] **1.15** *Sélecteur de section* (WCAG 1.3.1 / 2.1.1) : pour un champ `text` ambigu, le groupe de **boutons radio** des candidats est navigable aux flèches, chaque option annonce **titre + score** (et « section moteur » pour le choix par défaut).
- [ ] **1.16** *Tables d'historique* (WCAG 1.3.1) : en-têtes de colonnes (`<th scope=col>`) présents, `caption` (visuellement masqué) décrivant chaque table ; lecture cohérente au lecteur d'écran.

---

## 2. Onglet « Reprise assistée » — flux nominal (régression métier)

- [ ] **2.1** État initial sans DEX : message **« Aucun DEX chargé. Choisissez un fichier ou saisissez un chemin local. »**
- [ ] **2.2** Charger via `<input type=file>` **ou** coller un chemin dans *« …ou chemin local sur le poste »* + **« Traiter le chemin »**. Le glisser-déposer fonctionne aussi (souris).
- [ ] **2.3** Après traitement : identification affichée (**solution S20001**, auteur, responsable).
- [ ] **2.4** **23 champs** présents, chaque carte **préfixée de son numéro d'intitulé** (ex. « 5. Supervision ») et affichée **dans l'ordre défini par le Dictionnaire** (par défaut l'ordre canonique). L'onglet CAST'IN reste visible via le **badge** de chaque carte.
- [ ] **2.5** Pour chaque champ : le **contenu pré-extrait** est visible et lisible.
- [ ] **2.6** Bouton **« Copier »** : coller dans un éditeur tiers et vérifier la **fidélité exacte** du texte (aucune reformulation — règle 7).
- [ ] **2.7** **« Principes et décisions »** : champ **vide** (règle 5), **sans** indicateur de confiance.
- [ ] **2.8** Champ optionnel absent → **« Non concerné »**/vide attendu (règle 4), sans alerte injustifiée.
- [ ] **2.9** Confiance : **% + mot + jauge** cohérents entre eux ; un champ « vide » n'affiche **pas** de confiance.
- [ ] **2.10** **Points à vérifier** : la liste sous les champs reflète les doutes du moteur (règle 8).

---

## 2bis. Cartes rétractables (accordéon / minimisable)

- [ ] **2bis.1** Chaque carte de champ affiche un **chevron** (▾ déplié / ▸ replié). Cliquer le chevron **replie** la carte : le corps (jauge, contenu, candidats, suggestions, actions) disparaît ; **l'en-tête reste visible** (libellé + badges de confiance / « à vérifier » / « ambigu »).
- [ ] **2bis.2** Re-cliquer **déplie** la carte ; le contenu et l'état (sélection, choix de section, formulaire de signalement éventuel) sont **préservés**.
- [ ] **2bis.3** Boutons globaux **« Tout replier »** / **« Tout déplier »** : agissent sur l'ensemble des cartes en une fois.
- [ ] **2bis.4** Le pli est **purement d'affichage** : il ne modifie ni le contenu, ni la confiance, ni les « Points à vérifier » (vérifier qu'un Copier après pli/dépli renvoie le même texte).
- [ ] **2bis.5** Cliquer le **libellé** d'un champ (≠ chevron) continue de **sélectionner** le champ (overlay AR) sans replier/déplier.
- [ ] **2bis.6** **Pli automatique au chargement** : les cartes **« Non concerné »** (champ sans repère dans le document) sont **repliées par défaut**, pour mettre en évidence les champs renseignés. Sur un DEX **complet** (ex. nominal), **aucune** carte n'est repliée.
- [ ] **2bis.7** **Exception** : un champ « Non concerné » **reste déplié** s'il porte une **ambiguïté** (⚐) ou un **routage d'attention** (⚠).
- [ ] **2bis.8** **Pastille de couleur** : chaque carte affiche, près du libellé, une **pastille** de la **même couleur** que dans la **légende** du document annoté (et que le cadre du champ dans le document) — pour le suivi visuel par couleur.

---

## 3. Document annoté

- [ ] **3.0** Le titre de la zone est **« Document annoté »** (sans « réalité augmentée »), et la case **« Afficher tous les surlignages »** est **cochée par défaut** : à l'ouverture d'un DEX, **toutes** les annotations des champs trouvés sont visibles.
- [ ] **3.1** Le document du DEX est rendu **annoté** : cadres colorés par champ, **étiquettes**, **flèches directionnelles `⟶ champ`**, et une **légende** des couleurs.
- [ ] **3.2** Les **tableaux** du DEX (dont la page de garde) sont rendus correctement (pas de texte écrasé/illisible).
- [ ] **3.3** **Sélection synchronisée** : cliquer le **libellé d'un champ** (bouton) met le champ en état *pressé* (`aria-pressed`) et **met en évidence** la zone correspondante dans le document ; le bandeau « Champ sélectionné : … » s'affiche.
- [ ] **3.4** Cliquer une **zone source** fait **défiler** jusqu'au paragraphe visé (`#p-N`). Cliquer une **puce de suggestion** **redirige vers l'onglet Dictionnaire** à la ligne correspondante (voir section 4ter / Dictionnaire).
- [ ] **3.5** Décocher **« Afficher tous les surlignages »** : seul le champ **sélectionné** reste annoté ; recocher rétablit tout, sans casser la mise en page.
- [ ] **3.6** **Cohérence des couleurs** : pour un champ donné, la **pastille de la carte**, l'entrée de **légende** et le **cadre dans le document** sont de la **même couleur**.
- [ ] **3.7** Les annotations correspondent au **bon passage source** (cohérence avec ce qui est copié pour le champ).
- [ ] **3.8** Champ **introuvable** : pas de cadre dans le document, le champ est signalé et des **suggestions** de titres proches sont proposées.

---

## 4. Routage par seuil de confiance (fonctionnalité versionnée)

- [ ] **4.1** **Par défaut** (`seuil_routage = 0`, calibration inactive) : **aucun** badge « À revoir » — comportement strictement neutre, identique au moteur.
- [ ] **4.2** **Activer un seuil** : éditer `donnees/regles.json` → `"seuil_routage": 0.85` (+ incrémenter `"version"`), puis cliquer **« Recharger les règles (regles.json) »** (onglet Tableau de bord). Le bandeau d'état doit afficher la **nouvelle version**.
- [ ] **4.3** Re-traiter le DEX : les champs de **confiance < seuil** affichent le badge **« À revoir »** et apparaissent dans **« Points à vérifier »** (mention de confiance calibrée).
- [ ] **4.4** **Le contenu des champs n'est pas modifié** par le routage — seul l'affichage d'attention change (vérifier qu'un Copier renvoie le même texte qu'au 2.6).
- [ ] **4.5** Remettre `seuil_routage = 0` (+ version) et recharger : les badges « À revoir » disparaissent.

---

## 4bis. Désambiguïsation multi-candidats (sélecteur de section)

Préparer un DEX **ambigu** : un document avec deux titres matchant le **même champ
`text`**, dont le mieux nommé n'est **pas** le premier (ex. pour le champ *Log* :
un titre « Logs applicatifs des partenaires » placé **avant** un titre « Diagnostique »).

- [ ] **4bis.1** Traiter ce DEX : le champ concerné affiche le badge **« ⚐ ambigu »**, une entrée apparaît dans **« Points à vérifier »** (« N sections candidates → choisir »), et la confiance est **abaissée** (malus d'ambiguïté).
- [ ] **4bis.2** Sous le contenu, un **sélecteur de section** (groupe de boutons radio) liste les candidats triés par score ; l'option marquée **« · section moteur »** est cochée par défaut et le contenu affiché correspond bien à cette section.
- [ ] **4bis.3** **Accessibilité** : naviguer le groupe radio **au clavier** (flèches), focus visible ; chaque option est annoncée avec son titre et son score.
- [ ] **4bis.4** **Choisir une autre section** : le **contenu à coller** et l'**overlay AR** (cadre/étiquette) basculent immédiatement sur la section choisie ; un message indique que le choix sera enregistré comme `mauvaise_section`.
- [ ] **4bis.5** Les boutons d'action deviennent **« Confirmer la section choisie »** + **« ↺ section moteur »**. *Confirmer* → l'événement est journalisé en **`signale` / `mauvaise_section`** avec la correction (vérifiable dans `donnees/events.jsonl` ou au Tableau de bord). *↺* → revient à la section moteur et restaure les actions Accepter/Signaler.
- [ ] **4bis.6** **Copier** renvoie exactement le contenu de la **section affichée** (moteur ou choisie), sans reformulation (règle 7).
- [ ] **4bis.7** **Non-régression** : sur un DEX **nominal**, **aucun** champ n'est marqué « ⚐ ambigu » et aucun sélecteur `text` n'apparaît (les champs `merge`/`link` peuvent afficher un repli « N sections détectées » en **information**, sans choix).

---

## 4ter. Dictionnaire (navigation) & signalement par e-mail

Préparer un DEX où un champ `text` est **introuvable** (section absente ou mal nommée) :
le champ doit afficher des **puces de suggestion** (titres proches).

- [ ] **4ter.1** Cliquer une **puce de suggestion** dans une carte : l'application **bascule sur l'onglet « Dictionnaire »** et **met en évidence la ligne** de l'intitulé correspondant (voir section « Onglet Dictionnaire »).
- [ ] **4ter.2** Depuis la ligne du Dictionnaire, **« Appliquer »** (champ `text`) revient sur « Reprise assistée », bascule le **contenu à coller** + l'**overlay AR**, et passe les actions en **« Confirmer la section choisie »** + **« ↺ section moteur »**.
- [ ] **4ter.3** **Confirmer** la section appliquée journalise un événement : `section_introuvable` **si le champ n'avait aucun match moteur**, sinon `mauvaise_section`, avec la `correction`. Vérifiable dans `donnees/events.jsonl`.
- [ ] **4ter.4** Pour un champ **non `text`** (`merge`/`link`), la ligne du Dictionnaire n'offre que **« Voir »** (pas d'application directe).
- [ ] **4ter.5** **Signalement par e-mail** : ouvrir **« Signaler… »**, choisir un type + commentaire, **« Envoyer le signalement »**. Attendu : (a) l'événement est **journalisé localement** (compteurs du Tableau de bord bougent) **et** (b) une **fenêtre d'aperçu** s'ouvre (dialogue) avec **Destinataire(s), Objet, Corps modifiables**. L'objet vaut **`<préfixe Admin>` + `<type>`**. Le **corps reprend toutes les infos de la carte** (DEX, gabarit, version de règles, champ + onglet, type de champ, type de signalement, confiance + libellé, score brut, raison, titre repéré, routage/ambiguïté, commentaire/section corrigée, **contenu**, suggestions, points à vérifier), encadré par l'intro et la salutation de l'Administration.
- [ ] **4ter.6** Dans l'aperçu : **modifier** un champ puis **« Ouvrir dans la messagerie »** → le client e-mail s'ouvre sur un brouillon reprenant les valeurs **éditées** (destinataires `;` convertis en `,`, corps **texte**). **« Annuler »** ferme sans ouvrir la messagerie. **`Échap`** ferme également.
- [ ] **4ter.6b** **Rendu HTML (Outlook)** : **« Copier la fiche en HTML »** met une version mise en forme (tableau + contenu) dans le presse-papier ; après ouverture du brouillon, **coller (Ctrl+V)** dans le corps Outlook rend le HTML. *(Le `mailto:` ne transmet que du texte : c'est la voie pour un rendu HTML sans serveur d'envoi.)*
- [ ] **4ter.7** **Confidentialité / homologation** : rien n'est **envoyé automatiquement** (le brouillon attend l'action) ; l'extrait inséré est le contenu **tel quel** (règle 7). C'est la **seule** sortie hors-poste de l'outil.
- [ ] **4ter.8** Si aucun client `mailto:` n'est configuré : le **signalement reste journalisé** (l'e-mail est un complément, il ne bloque pas l'enregistrement).
- [ ] **4ter.9** *Accessibilité du dialogue* (WCAG 4.1.2) : `role="dialog"` + `aria-modal`, titre lié (`aria-labelledby`), focus placé dans le dialogue à l'ouverture, opérable au clavier.

---

## 5. Onglet « Tableau de bord »

- [ ] **5.1** Valider quelques champs (Accepter/Signaler) côté Reprise, revenir au Tableau de bord, **Rafraîchir** : les compteurs bougent.
- [ ] **5.2** KPIs présents : **Brier global**, **ECE brut → calibré** (avec l'écart affiché), **débit médian**.
- [ ] **5.3** **Cible ECE** : modifier la valeur, **« Enregistrer la cible »** ; l'alerte ECE se recalcule en cohérence au rafraîchissement.
- [ ] **5.4** **Alertes** cohérentes avec les seuils (acceptation, débit, ECE) — ni absentes à tort, ni intempestives.
- [ ] **5.5** **Acceptation par champ** : table lisible, valeurs plausibles.
- [ ] **5.6** **Diagramme de fiabilité** : tranches affichées + diagonale de calibration ; cohérent avec la table chiffrée.

---

## 5bis. Onglet « Historique »

- [ ] **5bis.1** L'onglet **« Historique »** s'ouvre (4e onglet). Sans aucune analyse : message « Aucune analyse enregistrée… ».
- [ ] **5bis.2** Traiter **plusieurs DEX** (onglet Reprise), revenir à Historique, **« Rafraîchir »** : le compteur **« N DEX analysé(s) »** et la table se remplissent. *(Il n'y a plus qu'un seul tableau ; l'ancien « Par heure de passage » a été retiré.)*
- [ ] **5bis.3** Table **« Détail des DEX analysés »**, **une ligne par passage**. Colonnes, dans l'ordre : **Heure**, **Nom** (**nom de fichier complet**, ex. `DEX_S20001_Nominal.docx`), **DEX** (`dex_id`), **Gabarit**, **Abouti** (**nombre de repérages positifs** = champs effectivement localisés), **élevée / moyenne / faible / (vide)**, **⚐ ambigus**, **points**, **règles**.
- [ ] **5bis.4** **Tri** : cliquer **chaque en-tête** trie sur cette colonne ; re-cliquer **inverse** le sens (`aria-sort` + flèche ▲/▼). Tri par défaut : **Heure décroissante** (plus récent en tête).
- [ ] **5bis.4b** **Compteurs cliquables** : dans les colonnes **Abouti, élevée, moyenne, faible, (vide), ⚐ ambigus**, **chaque nombre est cliquable** → bascule sur « Reprise assistée » en **ne laissant dépliées que les cartes du groupe** correspondant (les autres sont repliées), pour le **DEX actuellement chargé**. Un message indique le nombre de cartes dépliées. *(Les compteurs viennent du DEX historisé ; le dépliage agit sur le DEX courant.)*
- [ ] **5bis.5** **Cohérence** : pour un DEX donné, **Abouti** + la répartition des confiances correspondent à l'onglet Reprise (ex. DEX nominal ≈ tout en « élevée », `Abouti` proche du nombre de champs concernés, 0 ambigu, 0 point).
- [ ] **5bis.6** **Persistance** : recharger la page puis rouvrir Historique → les analyses précédentes sont **toujours là** (journal `donnees/analyses.jsonl`, local). Les anciens enregistrements sans **Nom/Abouti** affichent « — ».
- [ ] **5bis.7** Un **replay** (onglet Reprise) **n'ajoute pas** de ligne d'historique (seul `process-dex` journalise une analyse).

---

## 5ter. Onglet « Administration » (valeurs par défaut de l'e-mail)

- [ ] **5ter.1** L'onglet **« Administration »** s'ouvre (4e onglet) et affiche les champs : **Destinataire(s)**, **Objet (préfixe)**, **Contenu (introduction)**, **Suffixe (salutation)**, pré-remplis avec les valeurs courantes (défaut : `fredgarcia@mail.fr`, `Castin ; `, vide, `Cordialement,`).
- [ ] **5ter.2** L'**aperçu** « Objet/corps générés » reflète en direct le préfixe + `<type>` et l'enchaînement intro / contenu de carte / salutation.
- [ ] **5ter.3** Modifier les valeurs, **« Enregistrer »** → confirmation `✓ enregistré`. Recharger la page : les valeurs sont **persistées** (config locale `tableau_de_bord.config.json`).
- [ ] **5ter.4** **Plusieurs destinataires** : saisir `a@x.fr ; b@y.fr`, déclencher un signalement → l'aperçu montre les deux ; à l'ouverture messagerie, ils sont en destinataires (séparés par `,`).
- [ ] **5ter.5** **Prise en compte immédiate** : après enregistrement, un nouveau signalement utilise bien le nouvel objet/préfixe, la nouvelle intro et la nouvelle salutation.
- [ ] **5ter.6** **« Rétablir les valeurs par défaut »** restaure les champs (puis Enregistrer pour persister).
- [ ] **5ter.7** **Bascule « pastille de confiance en couleur du champ »** (bas de l'onglet) : **on par défaut**. *On* → la pastille de confiance de chaque carte prend la **couleur du champ** (et la pastille de couleur séparée disparaît). *Off* → la pastille reprend le code **vert/orange/rouge** selon le niveau, et la **pastille de couleur** réapparaît. Le libellé (élevée/moyenne/faible) et la jauge restent lisibles dans les deux cas.
- [ ] **5ter.8** La bascule **s'applique immédiatement** (cartes de la Reprise) **et persiste** après rechargement de la page. Contraste du texte de la pastille colorée **lisible** quelle que soit la teinte.

---

## 5quater. Onglet « Dictionnaire »

- [ ] **5quater.1** L'onglet **« Dictionnaire »** (2e onglet) affiche un **tableau** (une ligne par **suggestion** ; un intitulé sans suggestion = une ligne). En tête : la phrase expliquant **« Appliquer cette section »**. Colonnes : **Ordre** (éditable), **N°**, **Catégorie** (éditable), **Intitulé** (éditable, **sans guillemets**), **Repérage**, **Titre proposé** (**éditable**, sans guillemets), **Proximité**, **Action**.
- [ ] **5quater.2** **Repérage** : pour un champ non repéré → **« Repérage non abouti »** ; pour un champ repéré → « Repéré (confiance …). »
- [ ] **5quater.2b** **Catégorie / Intitulé / Titre proposé éditables** : modifier la **catégorie**, l'**intitulé** ou le **titre proposé** d'une ligne ; catégorie et intitulé s'appliquent **aussi à la carte** correspondante de « Reprise assistée », et les trois **persistent** après rechargement (surcharges locales `intitules_cartes` / `titres_proposes`, ce dernier indexé par le titre d'origine). Le **N°** et le **contenu** repéré ne changent pas.
- [ ] **5quater.3** **Tri** : cliquer **chaque en-tête** trie le tableau sur cette colonne (Ordre, N°, Catégorie, Intitulé, Repérage, Titre proposé, Proximité) ; re-cliquer **inverse** le sens (`aria-sort` + flèche ▲/▼).
- [ ] **5quater.4** **Navigation depuis la Reprise** : cliquer une puce de suggestion d'un champ ouvre cet onglet et **met en évidence la ligne** de cette suggestion, visible **parmi les autres**.
- [ ] **5quater.5** **Ordre d'affichage** : modifier un numéro d'ordre puis vérifier que les **cartes de « Reprise assistée » se réordonnent** ; l'ordre est **enregistré** (persiste après rechargement). **« Rétablir l'ordre par défaut »** revient à l'ordre canonique.
- [ ] **5quater.6** Colonne **Action** : **« Appliquer »** (champ `text`) revient à la Reprise avec contenu/AR basculés (cf. 4ter) ; **« Voir »** revient à la Reprise, sélectionne le champ et fait défiler au passage.
- [ ] **5quater.7** Sans DEX traité : message d'invite. Les **N° d'intitulé** restent **fixes** quel que soit l'ordre d'affichage ou le tri.

---

## 6. Panneau « Calibration isotonique » (workflow d'audit visuel)

- [ ] **6.1** **Volume insuffisant** (< 30 verdicts) : **« Analyser la calibration »** affiche un message d'insuffisance, et **« Écrire regles.candidate.json » est désactivé**.
- [ ] **6.2** **Volume suffisant** (≥ 30 ; rejouer un lot ou réutiliser un journal de rodage) : **« Analyser »** affiche **n**, **ECE brut → estimé**, **gain**, **version proposée**, **champs calibrés**, et la **carte par défaut** (dépliable).
- [ ] **6.3** **« Écrire regles.candidate.json »** : message de statut (annoncé `aria-live`) confirmant le **chemin** + le **rappel du gate**.
- [ ] **6.4** **Rien n'est activé automatiquement** : tant qu'on n'a pas promu le candidat → `regles.json` puis rechargé, le bandeau ne montre **pas** « Calibration active ».
- [ ] **6.5** Après promotion + rechargement d'une carte **monotone** active : le bandeau affiche **« Calibration active · v… · seuil … »**.
- [ ] **6.6** (Négatif) Recharger une carte **non monotone** : la calibration est **désactivée** et un **avertissement** apparaît (réponse de `rules/reload`).

---

## 7. Replay

- [ ] **7.1** Après un patch de règles (étape 4.2), **« Rejouer le DEX courant »** affiche **version avant → après**, **champs modifiés**, **points résolus / nouveaux**.
- [ ] **7.2** Sans modification de règles, un replay ne montre **aucun** changement (cohérence/déterminisme).

---

## 8. Gestion d'erreurs (correctif 400)

- [ ] **8.1** Saisir un **chemin inexistant** → message d'erreur **clair et lisible** dans l'UI (annoncé), **pas** d'écran cassé ni de « 500 » brut.
- [ ] **8.2** Saisir un fichier **non `.docx`** → message « Le fichier doit être un .docx. ».
- [ ] **8.3** **Arrêter le back** puis tenter une action → message d'erreur gracieux ; au redémarrage, le bandeau repasse à **« connecté »**.

---

## 9. Déterminisme / reproductibilité (audit)

- [ ] **9.1** Traiter **deux fois** le **même DEX** sous la **même version de règles** → `score_brut`, confiance, `route_attention` **identiques** champ par champ.
- [ ] **9.2** Recharger une **version de règles** différente change la confiance de façon **attendue et expliquée** (cohérent avec le replay).

---

## 10. Navigateurs / responsive

- [ ] **10.1** OK sur le navigateur cible principal.
- [ ] **10.2** Vérifié sur un 2e navigateur.
- [ ] **10.3** Largeur étroite (≈ moitié d'écran) : mise en page tenable, contrôles atteignables.

---

## Grille de verdict

| Réf | Intitulé court | Attendu | OK / KO | Notes / écart |
|----|----------------|---------|---------|---------------|
| 0.1 | Aucun appel CDN | Tout sur 127.0.0.1 | | |
| 1.2 | Skip-link | Visible au focus + ancre | | |
| 1.3 | Onglets clavier | Flèches + Entrée | | |
| 1.7 | Couleur non seule | % + mot présents | | |
| 1.8 | Contraste badges | ≥ 4,5:1 / 3:1 | | |
| 1.12 | Reduced-motion | Pas d'anim. gênante | | |
| 2.6 | Fidélité Copier | Texte exact (R7) | | |
| 2.7 | Principes vides | Vide, sans confiance | | |
| 3.3 | Sélection sync. | Champ → zone document | | |
| 3.7 | Champ introuvable | Suggestions affichées | | |
| 4.1 | Routage neutre défaut | Aucun « À revoir » | | |
| 4.3 | Routage actif | Badge + Points à vérifier | | |
| 4.4 | Contenu intact | Copier inchangé | | |
| 2bis.1 | Cartes rétractables | Pli/dépli + en-tête visible | | |
| 2bis.4 | Pli sans effet contenu | Copier inchangé | | |
| 2bis.6 | Pli auto Non concerné | Repliés sf ambiguïté/⚠ | | |
| 3.0 | Surlignages par défaut | Case cochée à l'ouverture | | |
| 3.6 | Cohérence couleurs | Pastille = légende = cadre | | |
| 4bis.1 | Ambigu détecté | Badge ⚐ + Points + conf. abaissée | | |
| 4bis.4 | Choix section → AR/contenu | Bascule sur section choisie | | |
| 4ter.1 | Suggestion → Dictionnaire | Clic puce ouvre la ligne | | |
| 5quater.3 | Tri par en-tête | Chaque colonne triable ↑/↓ | | |
| 4ter.5 | Signaler → aperçu e-mail | Journalisé + dialogue éditable | | |
| 4ter.6 | Envoi validé | mailto avec valeurs éditées | | |
| 4ter.7 | Rien envoyé auto | Brouillon, extrait non reformulé | | |
| 5ter.3 | Config e-mail persistée | Conservée après reload | | |
| 5ter.4 | Multi-destinataires | `;` saisis → `,` dans mailto | | |
| 5ter.7 | Bascule pastille couleur | On défaut, off=vert/orange/rouge | | |
| 5quater.3 | Suggestion mise en évidence | Entrée ciblée + contexte | | |
| 5bis.3 | Historique : 1 table | Nom (fichier complet) + Abouti | | |
| 5bis.4 | Historique triable | Chaque colonne ↑/↓ | | |
| 5bis.4b | Compteurs cliquables | Déplie le groupe en Reprise | | |
| 5quater.2b | Catégorie/Intitulé/Titre éditables | Surcharges persistées | | |
| 5bis.6 | Historique persistant | Conservé après reload | | |
| 6.1 | Calibration < 30 | Bouton proposer désactivé | | |
| 6.4 | Aucune activation auto | Pas « active » sans reload | | |
| 6.6 | Carte non monotone | Refus + avertissement | | |
| 8.1 | Erreur chemin | Message clair (pas 500) | | |
| 9.1 | Déterminisme | Confiance identique 2× | | |

---

### Points connus à surveiller (issus de la revue de code)

- **Reduced-motion (1.12)** : à confirmer qu'une media-query `prefers-reduced-motion` neutralise les transitions/flèches ; sinon, correctif CSS léger.
- **Contraste des badges (1.8)** : les nuances « faible/élevée » et « À revoir » méritent une mesure au contrôleur de contraste DSFR.
- **Alternative du diagramme (1.10)** : confirmer que la table acceptation/champ suffit comme équivalent, ou ajouter un résumé textuel.

Une fois la grille remplie, les écarts « KO » se traitent par ordre : accessibilité (1.x) et invariants (0.x) d'abord (bloquants pour une livraison publique homologuée), puis ergonomie (3.x) et calibration (6.x).
