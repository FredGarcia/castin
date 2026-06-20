# Cahier Des Charges

- **Contexte**
    - Gestion de solutions applicatives => Prise en charge de ces solutions par des personnes tierces
    - Les Dossiers d’Exploitation (DEX) sont créés et rédigés au format Word (.docx) selon un gabarit standard dans SharePoint
    - CAST'IN est un système centralisé de création et de gestion de documents d'exploitation (DEX)
    - CAST'IN permet de créer les DEX directement mais il ne permet pas une reprise des DEX existants au format Word de manière automatique
    - API CAST’IN non disponible à ce jour
- **Objectif général**
    
    Spécifier l'automatisation de la reprise des Dossiers d'Exploitation (DEX) Word vers CAST'IN
    
    - Reprendre le stock des DEX au format Word présents sur le SharePoint et de les migrer vers l'outil CAST'IN
    - Les DEX doivent être repris manuellement dans l’outil CAST’IN (saisie champ par champ)
    - Les documents d'exploitation (DEX) sont régulièrement audités et la plus grande rigueur est attendue dans la reprise du stock

- **Le dispositif cible**
    - un **module commun** porte toute la logique métier (repérage par nom, nettoyage, extraction, annotation) — résultat identique quel que soit le point d'entrée ;
    - un **utilitaire en ligne de commande** traite les DEX **par lot** (pré-génération du stock) ;
    - un **service local back** (`127.0.0.1`) alimente le **Service front VueJS** pour un usage interactif, DEX par DEX ;
    - deux sorties par DEX : le **rendu structuré** (Markdown / JSON) et la **copie annotée** `.docx` (surlignage par champ + légende).
    - Doit prend en compte l'ensemble des DEX identifiés dans le référentiel de reprise de stock
    - Doit être capable d'améliorer la clarté et la précision des instructions de migration pour la reprise manuelle dans l’outil CAST’IN en saisie champ par champ
    - En cas de doute, il faudra consulter l’équipier Ops responsable du DEX pour les questions complémentaires

- **Flux opérateur cible**
    
    Ouvrir le DEX → l'outil affiche les champs nettoyés + la copie annotée → traiter les points à vérifier → copier / coller dans CAST'IN → vérifier 100 % → exporter PDF
    
- **Contrainte**
    
    Contrainte structurante: Aucune action via API CAST'IN n'est envisageable. L'appel d'offres confirme d'ailleurs que CAST'IN ne propose pas de reprise automatique du stock Word. La saisie finale dans CAST'IN reste donc, à ce stade, manuelle.
    - Cette reprise est répétitive et confrontés aux exisgences, cela représente un risque de baisse d'attention, de problèmes de discernement et de stress  discernement
    - L'architecture de création des paragraphes du DEX est différente sur le fichier Word et sur l'outil CAST'IN.
    - Il s'agit de réaliser du copier-coller complexe avec des sources d’erreurs (mauvais paragraphe, oubli de section, contenu explicatif copié par inadvertance, etc…)
    - Chronophage

- **Objectif à partir d’un DEX .docx**
    - Obtenir le contenu prêt à coller pour chaque champ CAST’IN (texte nettoyé, liens isolés)
    - Obtenir la liste des points à vérifier (information absente, ambiguë, ou non retrouvée)
    - Obtenir une copie surlignée du DEX d’origine, pour identifier en un coup d’œil quel passage va dans quel champ CAST’IN et quels sont les manquants
    - Réaliser un copier-coller rapide et sûr du contenu métier

- **Périmètre**
    - Lecture d’un DEX au format .docx
    - Application des règles de reprise définies en tableau (règles 1 à 8 du prompt de référence)
    - Extraction, nettoyage et structuration du contenu des **23 champs CAST'IN**
    - Production du rendu structuré (Markdown / JSON) des 23 champs CAST’IN + identification + points à vérifier
    - Détection des sections absentes (« Non concerné ») et signalement des cas douteux
    - Production, par DEX, d'un contenu prêt à copier-coller (rendu structuré) et d'une copie annotée du DEX d’origine, surlignée par champ
    - Production d'Un jeu de tests automatisés (DEX synthétiques) mesurant la fiabilité de chaque règle métier
    - Traitement **par lot** de l'ensemble du stock
    - Un affichage interactif coté front avec copie en un clic

- **Mode d’exécution**
    - Fichier autonome en ligne de commande, en environnement Windows

- **Hors périmètre**
    - Toute saisie automatique dans CAST’IN (pas d’API CAST’IN disponible : la saisie finale reste manuelle, le copier-coller)
    - La génération du contenu d’un DEX est une donnée d’entrée, jamais produite ni modifiée, aucun contenu n’est reformulé ou réécrit (règle 7)
    - Pas de prise en charge de formats autres que .docx (pas de PDF, .doc binaire, etc.).
    L’authentification / la gestion multi-utilisateurs (outil mono-poste, local)

- **Règles métier de reprise**
 
     1 Repérage par NOM
        Les sections sources sont retrouvées par le texte normalisé de leur titre (numérotation, accents, casse, ponctuation ignorés)
        Le numéro de chapitre indiqué dans le gabarit (~2.1, ~13.3…) n’est qu’un indice documentaire, jamais un critère de recherche
        La numérotation réelle varie d’un DEX à l’autre.
        
    - 2 Contenu utile uniquement
        Les titres de section ne sont pas repris
        Les paragraphes entièrement en italique et en couleur non standard (encarts d’aide bleu/italique du gabarit) sont détectés et écartés du contenu repris
        
    - 3 Nettoyage des caractères parasites
        Suppression/normalisation :
        espaces insécables et fines
        Caractères de contrôle et marqueurs invisibles (BOM, marques de direction, espaces de largeur nulle)
        Puces de polices “symboles” (Wingdings/Symbol, zone Unicode Private Use Area) converties en -
        Espaces multiples et lignes vides en excès compressés
        
    - 4 Information absente
        Tout champ dont la section source est introuvable est rempli avec exactement la chaîne Non concerné (et signalé, cf règle 8)
        
    - 5 « Principes et décisions »
        Toujours laissé vide, quel que soit le contenu du DEX.
        
    - 6 « Informations supplémentaires »
        Optionnel :
        Vide si absent (pas de signalement)
        Renseigné s’il existe un contenu après la section “Resynchronisation” et/ou une section “Assets mainframe”.
        
    - 7 Pas de reformulation
        Le contenu est nettoyé et réorganisé (règles 2 et 3), jamais réécrit, paraphrasé ou résumé.
        
    - 8 Doute = signalement
        Toute section introuvable, ambiguë
        Toute information d’identification (n° de solution, auteur, responsable) non retrouvée
        Doit être listée dans « Points à vérifier auprès de l’Équipier Ops ».
        La liste affiche RAS si aucun doute
        L’outil ne devine jamais
        
- **Tableau des règles métier**
    
    | # | Règle | Exigence |
    | --- | --- | --- |
    | 1 | **Repérage par NOM** | Les sections sources sont retrouvées par le **texte normalisé de leur titre** (numérotation, -accents, casse, ponctuation ignorés). Le numéro de chapitre indiqué dans le gabarit (`~2.1`, `~13.3`…) n’est qu’un **indice documentaire**, jamais un critère de recherche : la numérotation réelle varie d’un DEX à l’autre. |
    | 2 | **Contenu utile uniquement** | Les titres de section ne sont pas repris. Les paragraphes **entièrement en italique et en couleur non standard** (encarts d’aide bleu/italique du gabarit) sont détectés et **écartés** du contenu repris. |
    | 3 | **Nettoyage des caractères parasites** | Suppression/normalisation : espaces insécables et fines, caractères de contrôle et marqueurs invisibles (BOM, marques de direction, espaces de largeur nulle), puces de polices “symboles” (Wingdings/Symbol, zone Unicode *Private Use Area*) converties en `-` , espaces multiples et lignes vides en excès compressés. |
    | 4 | **Information absente** | Tout champ dont la section source est introuvable est rempli avec **exactement** la chaîne `Non concerné` (et signalé, cf règle 8). |
    | 5 | **« Principes et décisions »** | Toujours **laissé vide**, quel que soit le contenu du DEX. |
    | 6 | **« Informations supplémentaires »** | **Optionnel** : vide si absent (pas de signalement), renseigné s’il existe un contenu après la section “Resynchronisation” et/ou une section “Assets mainframe”. |
    | 7 | **Pas de reformulation** | Le contenu est **nettoyé et réorganisé** (règles 2 et 3), jamais réécrit, paraphrasé ou résumé. |
    | 8 | **Doute = signalement** | Toute section introuvable, ambiguë, ou toute information d’identification (n° de solution, auteur, responsable) non retrouvée est listée dans **« Points à vérifier auprès de l’Équipier Ops »**. La liste affiche `RAS` si aucun doute. **L’outil ne devine jamais.**
     |
- **Mode opératoire**
    
    Impose de contacter l'Équipier Ops en cas de doute
    
    Le processus manuel décrit dans l'appel d'offres se décompose en huit étapes. L'analyse ci-dessous distingue ce qu'un outil côté Word peut prendre en charge de ce qui dépend de l'interface CAST'IN.
    
    | **#** | **Étape du MODOP** | **Automatisable ?** | **Moyen** |
    | --- | --- | --- | --- |
    | 1 | Identifier le n° de solution (`Sxxxx`) depuis le nom de fichier | **Oui, totalement** | Python script (motif `S\d{4}`) |
    | 2 | Se connecter à CAST'IN (compte `U…@ZOE.GCA`) | **Non** (hors RPA) | Authentification / SSO : manuel, ou RPA sous conditions |
    | 3 | Rechercher la solution puis sélectionner la version « En Production » | **Via script Python** (état propre à CAST'IN) | Manuel, ou RPA d'IHM |
    | 4 | Extraire le contenu des ~23 sections, repérées **par nom** | **Oui, totalement** | Script Python / script — *cœur de l'automatisation* |
    | 5 | Nettoyer : caractères spéciaux, retrait des titres et du texte explicatif bleu, conservation du contenu/liens/schémas | **Oui, totalement** | Script Python |
    | 6 | Détecter les sections absentes → « Non concerné » + signaler les doutes | **Oui, totalement** | Script Python |
    | 7 | Coller chaque champ dans l'éditeur CAST'IN (icône « Modifier », valider) | **Pas via plugin** (pas d'API) | **Manuel assisté** (copie en 1 clic), ou RPA d'IHM |
    | 8 | Vérifier complétude 100 % / 6 rubriques, puis exporter le PDF | **Partiellement** | Aide à la vérification côté outil ; export PDF manuel, ou RPA |
    
    **Lecture de ce tableau.** Tout le travail *côté source* (étapes 1, 4, 5, 6, et la préparation de 7) est automatisable de bout en bout. Tout le travail *côté cible CAST'IN* (étapes 2, 3, 7, 8) ne l'est pas sans API — sauf à piloter l'interface par un robot (RPA), avec les réserves exposées au §4.3. C'est cette frontière qui détermine la solution retenue.
    
- **Onglet « Description détaillée »**
    
    
    | Champ | Type | Source (indicative, retrouvée par nom — règle 1) |
    | --- | --- | --- |
    | Lien Dossier Archi (DAP…) | Lien uniquement | ~2.2 Architecture fonctionnelle & applicative |
    | Schéma Applicatif (ADU…) | Lien uniquement | ~2.2 (ou ~2.1) Architecture fonctionnelle & applicative / Description de la solution |
    | Description Fonctionnelle | Texte | ~2.1 Description de la solution |
    | Données de la solution | Texte | ~2.3 Données |
    | Principes et décisions | Vide (règle 5) | — |
    | Description Technique | Texte | ~4.1 Architecture technique |
- **Identification**
    
    
    | Information | Source |
    | --- | --- |
    | Numéro de solution (`Sxxxx`) | Nom de fichier en priorité, sinon ~60 premiers paragraphes |
    | Auteur | Page de garde (avant le premier titre), motif `Auteur : ...` |
    | Responsable | ~60 premiers paragraphes, motif `Responsable : ...` (sinon `Service : ...`, avec signalement) |
- **Onglet « DEX »**
    
    
    | Champ | Type | Source (indicative) |
    | --- | --- | --- |
    | Plage de fonctionnement / maintenance | Texte | ~3.3 Plages de fonctionnement |
    | Supervision | Texte (chapitre entier) | ~6 Supervision |
    | Observabilité | Texte | ~9/11 Métrologie |
    | Log | Texte | ~8.2 Diagnostique / LOG / Trace |
    | Sauvegardes | Texte | ~7 Sauvegarde |
    | Servitudes et ordonnancements | Texte | ~9 Servitudes (sinon `Non concerné`) |
    | Comptes et services | Texte | ~12.2 Compte de service |
    | Certificats | Texte | ~12.3 Certificats |
    | Liste blanche | Texte | ~12.4 |
    | Flux | Texte | ~4.3 Flux et interdépendances |
    | Support | Texte | ~8.1 Matrice de responsabilité (RACI) |
    | Changement et MEP | Composé | ~10 Contrôle des opérations + ~5 Changements et MEP |
    | Matière (repo) | Composé | ~5.1 Référentiel/Dépôt + recherche « Merge Request » dans tout le document |
    | Procédure de restauration | Texte | ~13.1 Restauration |
    | Procédure de reconstruction | Texte | ~13.2 Reconstruction |
    | Procédure de resynchronisation | Texte | ~13.3 Resynchronisation |
    | Informations supplémentaires | Annexe (optionnel, règle 6) | Contenu après ~13.3 + ~4.2.2 Assets mainframe si présent |
- **Rendu structuré (3 blocs imposés) pour chaque DEX**
    1. **IDENTIFICATION** : Solution / Auteur / Responsable (ou `Non concerné`).
    2. **CONTENU PAR CHAMP CAST'IN** : un bloc `*[Nom du champ]**` par champ, contenu nettoyé ou `Non concerné` / `(laisser vide)`.
    3. **POINTS À VÉRIFIER AUPRÈS DE L'ÉQUIPIER OPS** : liste à puces, ou `RAS`.
    
    Formats de sortie : Markdown `<nom>_CASTIN.md` ou JSON optionnel`<nom>_CASTIN.json`,  consommé par le script Office.js/Python).
    
- **Copie intégrale annotée du DEX d'origine (surlignage par champ)**
    
    > Exigence ajoutée en cours de projet : *« produire en plus du résultat lesmêmes fichiers que ceux d'entrée avec les parties à conserver mises enévidence selon leur catégorie, pour permettre un copier-coller intuitif dechacune de ces parties vers un formulaire externe sans API donc en manuelpour l'instant »*.
    > 
    - Une copie `.docx` de l'original (`<nom>_ANNOTE.docx`) où **chaque passageretenu pour un champ CAST'IN est surligné** (fond de caractère/cellule,`<w:shd>`) dans une **couleur dédiée à ce champ**.
    - Une **légende** est insérée en tête du document : tableau couleur ↔ champCAST'IN ↔ onglet ↔ « section repérée » (oui/non).
    - Le contenu **non surligné** (titres, paragraphes explicatifs écartés par larègle 2) **ne doit pas être copié**.
    - Toutes les autres parties du `.docx` (styles, médias, relations) sont préservées à l'identique — seul le corps du document est modifié.

- **Exigences fonctionnelles**
    
    La spécification détaillée figure dans `CAHIER_DES_CHARGES.md`. En synthèse :
    
    **Les 8 règles métier** : (1) repérage des sections **par nom** et non par numéro ; (2) **contenu utile uniquement** (titres et encarts explicatifs bleu/italique écartés) ; (3) **nettoyage** des caractères parasites ; (4) section absente → exactement « Non concerné » ; (5) « Principes et décisions » toujours **vide** ; (6) « Informations supplémentaires » **optionnel** ; (7) **aucune reformulation** ; (8) **doute = signalement** à l'Équipier Ops, l'outil ne devine jamais.
    
    **Les 23 champs CAST'IN** se répartissent en :
    - onglet *Description détaillée* (6 champs) : Lien Dossier Archi, Schéma Applicatif (liens), Description Fonctionnelle, Données de la solution, Principes et décisions (vide), Description Technique ;
    - onglet *DEX* (17 champs) : Plage de fonctionnement/maintenance, Supervision, Observabilité, Log, Sauvegardes, Servitudes et ordonnancements, Comptes et services, Certificats, Liste blanche, Flux, Support, Changement et MEP, Matière (repo), Procédures de restauration / reconstruction / resynchronisation, Informations supplémentaires ;
    - identification : n° de solution, Auteur, Responsable.
    
    **Sorties imposées** par DEX : bloc IDENTIFICATION, bloc CONTENU PAR CHAMP, bloc POINTS À VÉRIFIER (`RAS` si aucun) ; plus la copie `.docx` annotée.
    
- **Exigences non fonctionnelles**
    
    
    | **Exigence** | **Détail** |
    | --- | --- |
    | **Zéro dépendance externe** | Uniquement la bibliothèque standard Python 3.10+ (`zipfile`, `xml.etree.ElementTree`, `re`, `http.server`, `json`, `unicodedata`...). Aucun `pip install`. |
    | **Code commun unique** | Toute la logique métier réside dans `dex_castin_common.py`, importé sans duplication par les deux points d'entrée (CLI et serveur). Résultat **identique** quel que soit le mode d'utilisation. |
    | **Portabilité** | Fonctionne sous Windows (invite de commandes / « DOS »), Linux, macOS. |
    | **Sécurité / confidentialité** | Le service local n'écoute que sur `127.0.0.1` par défaut ; aucune donnée n'est conservée côté serveur (fichier temporaire supprimé après traitement) ; taille de fichier limitée à 50 Mo. |
    | **Robustesse** | Une erreur sur un fichier ne doit pas interrompre le traitement des autres (mode multi-fichiers du CLI) ; codes de retour distincts (0 = OK même avec points à vérifier, 1 = au moins un fichier en erreur, 2 = aucun fichier trouvé). |
    | **Non-régression mesurable** | Un jeu de tests automatisés doit accompagner toute évolution des règles métier, avec un score de réussite par règle. |
    |  |  |
- **Exigences techniques et de sécurité**
    
    
    | **Exigence** | **Détail** |
    | --- | --- |
    | Dépendances | Bibliothèque standard uniquement (pas d'installation tierce), pour faciliter l'homologation poste de travail. |
    | Confidentialité | Traitement **local** ; service à l'écoute sur `127.0.0.1` seulement ; **aucune donnée DEX ne quitte le poste** ; suppression des fichiers temporaires. Adapté au caractère audité/sensible des DEX. |
    | Portabilité | Windows (invite de commandes), Linux, macOS. |
    | Robustesse | Une erreur sur un fichier n'interrompt pas le lot ; codes retour distincts. |
    | Non-régression | Jeu de tests automatisés ; critère d'acceptation ≥ 95 % (score mesuré 96 %). |
- **Exemples de séquences**
    - Parcourir la structure du document (titres / styles), retrouver chaque section **par son nom normalisé** (numérotation, accents, casse ignorés), ce qui absorbe les variations de numérotation entre DEX ;
    - **Ecarter automatiquement** les titres de section et les encarts explicatifs (texte en bleu/italique du gabarit), grâce à la couleur et au style des caractères — c'est précisément le « texte encadré en jaune » à ne pas copier de l'exemple du MODOP ;
    - Isoler les **liens** (Dossier Archi, schéma ADU) et **nettoyer** les caractères parasites ;
    - Détecter les **sections manquantes** et lister les **points à vérifier** ;
    - Présenter, dans un volet, chaque champ CAST'IN avec un bouton **« Copier »** ; et produire une **copie annotée** du DEX où chaque passage est surligné dans la couleur de son champ cible
- **Architecture**
    
    ```
                     ┌─────────────────────────────────┐
                     │      dex_castin_common.py       │
                     │  règles métier, nettoyage,      │
                     │  extraction, annotation/surlign.│
                     └───────────────┬─────────────────┘
                                     │ importé par
                ┌────────────────────┴───────────────────────┐
                │                                            │
    ┌───────────────────────┐               ┌──────────────────────────────────┐
    │   dex_castin_cli.py   │               │  dex_castin_word_addin_server.py │
    │ (ligne de commande)   │               │  (service HTTP local 127.0.0.1)  │
    └───────────┬───────────┘               └────────────────┬─────────────────┘
                │ écrit                                      │ HTTP (localhost)
                ▼                                            ▼
    *_CASTIN.md / .json / _ANNOTE.docx            addin/ (Office.js : manifest,
                                                  taskpane.html/.js) -> volet Word
    ```
    
- **Livrables**
    
    
    | **Livrable** | **Fichier(s)** |
    | --- | --- |
    | Module commun (règles métier + annotation) | `dex_castin_common.py` |
    | Utilitaire ligne de commande | `dex_castin_cli.py` |
    | Service back local en script Python | `dex_castin_server.py` |
    | Service front VueJS | à compléter |
    | Documentation d'utilisation | `README.md` |
    | Dossier technico-fonctionnel | `DOSSIER_TECHNICO_FONCTIONNEL.md` |
    | Cahier des charges (ce document) | `CAHIER_DES_CHARGES.md` |
    | Jeu de tests + générateur de fixtures | `tests/run_tests.py`, `tests/docx_builder.py`, `tests/fixtures/*.docx` |
    | Rapport de tests | `tests/RAPPORT_TESTS.md` |
    | Exemples de résultats (3 blocs) | `tests/RESULTATS_EXEMPLES.md` |
    | Exemples de DEX annotés (surlignage) | `tests/fixtures/annote/*_ANNOTE.doc` |
- **Jeu de tests**
    
    8 DEX `.docx` synthétiques, couvrant cas nominaux et cas problématiques :
    
    | **Test** | **Objectif** | **Type** |
    | --- | --- | --- |
    | `01_cas_nominal_complet` | DEX complet, toutes sections présentes | Vrais positifs |
    | `02_sections_manquantes` | Sections absentes → `Non concerné` + signalement | Vrais négatifs |
    | `03_faux_positif_italique_legitime` | Contenu légitime en italique/couleur exclu à tort | Faux positif **connu/accepté** |
    | `04_faux_negatif_titre_non_standard` | Titre non standard → section non détectée | Faux négatif **connu/accepté** |
    | `05_numerotation_atypique` | Sections retrouvées malgré une numérotation différente | Vrai positif (règle 1) |
    | `06_liens_dap_adu_sections_separees` | Liens DAP/ADU agrégés depuis des sections différentes | Vrai positif (liens) |
    | `07_servitudes_absentes_non_concerne` | Absence légitime → `Non concerné` correct | Vrai négatif |
    | `08_identification_absente` | Aucune identification → 3 signalements | Vrai positif (règle 8) |
    
    ### **9**
    
- **Critères d'acceptation**
    - Score global ≥ **95 %** sur `tests/run_tests.py` (dernier score mesuré :**50/52, 96 %**), les seuls écarts tolérés étant les deux cas**volontairement** faux positif/négatif (tests 03 et 04), documentés en§10 — toute régression sur les autres tests doit être corrigée avantlivraison.
    - Pour chaque DEX de test, la copie annotée (`_ANNOTE.docx`) doit être un`.docx` valide (ZIP + XML bien formé), avec légende et surlignagecohérents avec le résultat structuré.
    - Le service local doit répondre sur `/api/health`, `/api/process-dex` et`/api/annotate-dex`.
- **Limites connues (à vérifier manuellement)**
    - **Détection des titres** : basée sur les styles Word « Titre N » /« Heading N » (ou `outlineLvl`, y compris styles personnalisés via`basedOn`). Un DEX dont les titres ne suivent pas ces styles ne sera pascorrectement segmenté (cf test 04).
    - **Détection des paragraphes "explicatifs"** : heuristique (italique +couleur non standard). Un paragraphe métier légitime entièrement enitalique et coloré serait, lui aussi, écarté (cf test 03).
    - **Champs composés** (« Matière (repo) », « Changement et MEP ») : si lastructure du DEX diffère fortement du gabarit standard, vérifier les« Points à vérifier ».
    - **Annotation / surlignage** : en cas de chevauchement entre champs (rare),un même paragraphe ne peut porter qu'une seule couleur (la dernièreappliquée dans l'ordre des champs CAST'IN).
    - Tous les éléments listés dans « Points à vérifier auprès de l'ÉquipierOps » doivent être traités avant la saisie définitive dans CAST'IN (règle8 : l'outil ne devine pas).
- **Gains attendus**
    
    La majeure partie des 20 min/DEX est consommée par la **localisation des sections, le tri du contenu à copier, le nettoyage et les vérifications** — précisément ce que l'outil supprime. Subsistent un **socle manuel incompressible** : connexion (amortie sur une session), recherche/sélection de version, les collages, la vérification et l'export PDF.
    
    > **Hypothèse à valider sur DEX réels** : objectif ≈ **10 min/DEX** en mode assisté, soit **~45–55 % de réduction**.
    > 
- **Risques et points à valider**
    - **Schémas / images** : confirmer que l'éditeur CAST'IN accepte le **collage d'images** (le MODOP demande de copier « les schémas »). La copie annotée facilite leur report manuel.
    - **Styles de titres** : la segmentation repose sur les styles « Titre N / Heading N ». Un DEX hors gabarit peut être mal découpé (limite connue).
    - **Heuristique du texte explicatif** : un contenu métier légitime entièrement en bleu/italique serait écarté à tort (limite connue).
    - **Variance du stock réel** vs jeux de tests synthétiques : à mesurer en pilote.
- **Évolutions possibles**
    - Plugin Word (Office.js et macro VBA ou Python)
    - Génération d'un export structuré pour import CAST'IN si une API ou unformat d'import devient disponible (à partir du JSON déjà produit).
    - Configuration externe (fichier JSON) des mots-clés de repérage de section,pour s'adapter à des gabarits DEX alternatifs sans modifier le code.
    - Détection configurable de la couleur des paragraphes "explicatifs" selonl'organisation.
    - Gestion fine des chevauchements de surlignage entre champs CAST'IN.
