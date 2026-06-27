Attribute VB_Name = "AnnotationDEX"
'======================================================================
' AnnotationDEX.bas — Surlignage des champs CAST'IN dans un DEX Word
'----------------------------------------------------------------------
' OBJECTIF
'   Produire une COPIE ANNOTEE (<nom>_ANNOTE.docx) d'un Dossier
'   d'Exploitation (DEX) au format .docx, dans laquelle chaque passage
'   destine a un champ CAST'IN est surligne dans la couleur de sa
'   categorie. But : maximiser la VITESSE et la JUSTESSE du copier-coller
'   manuel vers CAST'IN (pas d'API CAST'IN disponible).
'
'   Le DEX SOURCE N'EST JAMAIS MODIFIE : la macro travaille sur une copie
'   du fichier sur disque. Les DEX d'origine n'ont aucune macro ; ce
'   module se lance depuis le modele Normal.dotm ou un classeur a part.
'
' INSPIRATION
'   Reprend fidelement la logique de "reprise" du projet CAST'IN :
'     - Regle 1 : reperage des sections PAR NOM (titre normalise :
'                 numerotation, accents, casse, ponctuation ignores) —
'                 jamais par numero de chapitre.
'     - Regle 2 : on ecarte les titres et les encarts explicatifs
'                 (paragraphe entierement en italique + couleur non
'                 standard). Seul le contenu utile est surligne.
'
' COULEURS (modifiables — voir Sub InitCouleurs ci-dessous)
'     rouge clair : identifiants (n# de solution, Auteur, Responsable)
'     orange      : Description detaillee (Lien Dossier Archi, Schema
'                   Applicatif, Description Fonctionnelle, Donnees de la
'                   solution, Description Technique)
'     jaune       : Plage de fonctionnement, Supervision, Observabilite,
'                   Log, Sauvegardes
'     vert        : Servitudes, Comptes et services, Certificats,
'                   Liste blanche
'     bleu        : Flux, Support, Changement et MEP, Matiere (repo)
'     indigo      : Procedure de restauration / reconstruction /
'                   resynchronisation, Informations supplementaires
'
' UTILISATION
'   1. Ouvrir le DEX .docx a traiter (il doit etre enregistre sur disque).
'   2. Alt+F11 -> importer ce fichier (.bas) -> revenir a Word.
'   3. Lancer la macro "AnnoterDEX" (Affichage > Macros, ou Alt+F8).
'   Une copie <nom>_ANNOTE.docx est creee, annotee, et ouverte.
'======================================================================

Option Explicit

' --- Couleurs de surlignage (RGB) — MODIFIABLES ICI -------------------
Private COUL_IDENT   As Long   ' rouge clair
Private COUL_DESC    As Long   ' orange
Private COUL_JAUNE   As Long   ' jaune
Private COUL_VERT    As Long   ' vert
Private COUL_BLEU    As Long   ' bleu
Private COUL_INDIGO  As Long   ' indigo

Private Sub InitCouleurs()
    ' Teintes pastel : le texte noir reste lisible par-dessus.
    ' Pour changer une couleur, modifier la valeur RGB(r, v, b) ci-dessous.
    COUL_IDENT = RGB(255, 153, 153)   ' rouge clair
    COUL_DESC = RGB(255, 178, 102)    ' orange
    COUL_JAUNE = RGB(255, 235, 120)   ' jaune
    COUL_VERT = RGB(146, 208, 110)    ' vert
    COUL_BLEU = RGB(142, 180, 227)    ' bleu
    COUL_INDIGO = RGB(159, 159, 224)  ' indigo
End Sub

' --- Tables de configuration des champs (remplies par ChargerChamps) --
Private gLabel()   As String   ' libelle exact du champ CAST'IN
Private gCoul()    As Long     ' couleur de surlignage du champ
Private gKw()      As String   ' mots-cles normalises, separes par "|"
Private gKind()    As String   ' "text" | "link" | "merge" | "appendix"
Private gOnglet()  As String   ' onglet CAST'IN (legende)
Private gTrouve()  As Boolean  ' renseigne pendant l'annotation
Private gNbChamps  As Long

' --- Caches de la structure du document ------------------------------
Private pPara()    As Paragraph ' paragraphe i
Private pLevel()   As Long      ' niveau de plan (1..9 = titre, 10 = corps)
Private pIsHead()  As Boolean   ' True si le paragraphe est un titre
Private pNorm()    As String    ' titre normalise (si titre)
Private pCount     As Long

'======================================================================
' POINT D'ENTREE
'======================================================================
Public Sub AnnoterDEX()
    Dim src As Document
    Dim cheminSrc As String, cheminAnn As String, dossier As String, base As String
    Dim ann As Document
    Dim fso As Object

    On Error GoTo Echec

    If Documents.Count = 0 Then
        MsgBox "Aucun document ouvert. Ouvrez d'abord le DEX a annoter.", vbExclamation
        Exit Sub
    End If

    Set src = ActiveDocument
    cheminSrc = src.FullName

    If src.Path = "" Then
        MsgBox "Le DEX doit d'abord etre enregistre sur le disque " & _
               "(la copie annotee est faite a partir du fichier source).", vbExclamation
        Exit Sub
    End If
    If Not src.Saved Then
        If MsgBox("Le document contient des modifications non enregistrees." & vbCrLf & _
                  "La copie annotee sera faite a partir de la DERNIERE VERSION ENREGISTREE." & vbCrLf & _
                  "Continuer ?", vbQuestion + vbYesNo) = vbNo Then Exit Sub
    End If

    ' Construction du chemin de la copie annotee : <nom>_ANNOTE.docx
    dossier = src.Path
    base = src.Name
    If InStrRev(base, ".") > 0 Then base = Left$(base, InStrRev(base, ".") - 1)
    cheminAnn = dossier & Application.PathSeparator & base & "_ANNOTE.docx"

    ' Copie du fichier source sur disque (le source reste intact)
    Set fso = CreateObject("Scripting.FileSystemObject")
    If fso.FileExists(cheminAnn) Then
        If MsgBox("Le fichier suivant existe deja et va etre remplace :" & vbCrLf & _
                  cheminAnn & vbCrLf & "Continuer ?", vbQuestion + vbYesNo) = vbNo Then Exit Sub
        ' Fermer la copie si elle est ouverte, pour pouvoir l'ecraser
        Dim d As Document
        For Each d In Documents
            If StrComp(d.FullName, cheminAnn, vbTextCompare) = 0 Then d.Close SaveChanges:=wdDoNotSaveChanges
        Next d
    End If
    fso.CopyFile cheminSrc, cheminAnn, True

    Set ann = Documents.Open(cheminAnn)

    Application.ScreenUpdating = False
    InitCouleurs
    ChargerChamps
    ConstruireCacheStructure ann
    AnnoterIdentifiants ann
    AnnoterTousLesChamps ann
    InsererLegende ann
    ann.Save
    Application.ScreenUpdating = True

    MsgBox "Copie annotee creee :" & vbCrLf & cheminAnn & vbCrLf & vbCrLf & _
           "Le DEX source n'a pas ete modifie.", vbInformation, "Annotation DEX terminee"
    Exit Sub

Echec:
    Application.ScreenUpdating = True
    MsgBox "Erreur pendant l'annotation : " & Err.Description, vbCritical
End Sub

'======================================================================
' CONFIGURATION DES 22 CHAMPS CAST'IN (Principes et decisions = vide,
' donc non surligne). Mots-cles deja normalises (accents/casse retires)
' pour coller au moteur de reprise.
'======================================================================
Private Sub ChargerChamps()
    gNbChamps = 0
    ReDim gLabel(1 To 40)
    ReDim gCoul(1 To 40)
    ReDim gKw(1 To 40)
    ReDim gKind(1 To 40)
    ReDim gOnglet(1 To 40)
    ReDim gTrouve(1 To 40)

    Dim O As String, X As String
    O = "Description detaillee" : X = "DEX"

    ' --- orange : Description detaillee --------------------------------
    AjouterChamp "Lien Dossier Archi (DAP...)", COUL_DESC, "link", _
        "architecture fonctionnelle applicative", O
    AjouterChamp "Schema Applicatif (ADU...)", COUL_DESC, "link", _
        "architecture fonctionnelle applicative|description de la solution", O
    AjouterChamp "Description Fonctionnelle", COUL_DESC, "text", _
        "description de la solution", O
    AjouterChamp "Donnees de la solution", COUL_DESC, "text", _
        "donnees", O
    AjouterChamp "Description Technique", COUL_DESC, "text", _
        "architecture technique", O

    ' --- jaune ---------------------------------------------------------
    AjouterChamp "Plage de fonctionnement / maintenance", COUL_JAUNE, "text", _
        "plage de fonctionnement", X
    AjouterChamp "Supervision", COUL_JAUNE, "text", _
        "supervision", X
    AjouterChamp "Observabilite", COUL_JAUNE, "text", _
        "metrologie", X
    AjouterChamp "Log", COUL_JAUNE, "text", _
        "diagnostic|diagnostique|log|trace", X
    AjouterChamp "Sauvegardes", COUL_JAUNE, "text", _
        "sauvegarde", X

    ' --- vert ----------------------------------------------------------
    AjouterChamp "Servitudes et ordonnancements", COUL_VERT, "text", _
        "servitude", X
    AjouterChamp "Comptes et services", COUL_VERT, "text", _
        "compte de service|comptes de service", X
    AjouterChamp "Certificats", COUL_VERT, "text", _
        "certificat", X
    AjouterChamp "Liste blanche", COUL_VERT, "text", _
        "liste blanche|whitelist", X

    ' --- bleu ----------------------------------------------------------
    AjouterChamp "Flux", COUL_BLEU, "text", _
        "flux et interdependance|flux et interdependances", X
    AjouterChamp "Support", COUL_BLEU, "text", _
        "matrice de responsabilite|matrice des responsabilites|raci", X
    AjouterChamp "Changement et MEP", COUL_BLEU, "merge", _
        "controle des operations|changements et mep|changement et mep", X
    AjouterChamp "Matiere (repo)", COUL_BLEU, "merge", _
        "referentiel|repository|depot de code|matiere", X

    ' --- indigo --------------------------------------------------------
    AjouterChamp "Procedure de restauration", COUL_INDIGO, "text", _
        "restauration", X
    AjouterChamp "Procedure de reconstruction", COUL_INDIGO, "text", _
        "reconstruction", X
    AjouterChamp "Procedure de resynchronisation", COUL_INDIGO, "text", _
        "resynchronisation", X
    AjouterChamp "Informations supplementaires", COUL_INDIGO, "appendix", _
        "assets mainframe", X
End Sub

Private Sub AjouterChamp(libelle As String, coul As Long, kind As String, _
                         kw As String, onglet As String)
    gNbChamps = gNbChamps + 1
    gLabel(gNbChamps) = libelle
    gCoul(gNbChamps) = coul
    gKind(gNbChamps) = kind
    gKw(gNbChamps) = kw
    gOnglet(gNbChamps) = onglet
    gTrouve(gNbChamps) = False
End Sub

'======================================================================
' CACHE DE STRUCTURE : niveaux de plan + titres normalises
'======================================================================
Private Sub ConstruireCacheStructure(doc As Document)
    Dim n As Long, i As Long, p As Paragraph, ol As Long
    n = doc.Paragraphs.Count
    pCount = n
    ReDim pPara(1 To n)
    ReDim pLevel(1 To n)
    ReDim pIsHead(1 To n)
    ReDim pNorm(1 To n)

    i = 0
    For Each p In doc.Paragraphs
        i = i + 1
        Set pPara(i) = p
        ol = p.OutlineLevel                     ' wdOutlineLevel1..9 = titre
        pLevel(i) = ol
        pIsHead(i) = (ol >= wdOutlineLevel1 And ol <= wdOutlineLevel9)
        If pIsHead(i) Then
            pNorm(i) = NormaliserTitre(p.Range.Text)
        Else
            pNorm(i) = ""
        End If
    Next p
End Sub

'======================================================================
' ANNOTATION DE TOUS LES CHAMPS
'======================================================================
Private Sub AnnoterTousLesChamps(doc As Document)
    Dim f As Long
    For f = 1 To gNbChamps
        Select Case gKind(f)
            Case "text":     AnnoterChampText f
            Case "link":     AnnoterChampLink f
            Case "merge":    AnnoterChampMerge f
            Case "appendix": AnnoterChampAppendix f
        End Select
    Next f
End Sub

' --- champ "text" : 1re section trouvee -------------------------------
Private Sub AnnoterChampText(f As Long)
    Dim kws() As String, hi As Long, fin As Long
    kws = Split(gKw(f), "|")
    hi = TrouverSection(kws, 1)
    If hi > 0 Then
        fin = FinSection(hi)
        SurlignerSection hi + 1, fin, gCoul(f)
        gTrouve(f) = True
    End If
End Sub

' --- champ "link" : toutes les sections candidates --------------------
Private Sub AnnoterChampLink(f As Long)
    Dim kws() As String, hi As Long, fin As Long, curseur As Long
    kws = Split(gKw(f), "|")
    curseur = 1
    Do
        hi = TrouverSection(kws, curseur)
        If hi = 0 Then Exit Do
        fin = FinSection(hi)
        SurlignerSection hi + 1, fin, gCoul(f)
        gTrouve(f) = True
        curseur = fin
    Loop
End Sub

' --- champ "merge" : 1re + 2e section (+ "Merge Request" pour Matiere) -
Private Sub AnnoterChampMerge(f As Long)
    Dim kws() As String, hi As Long, fin As Long
    kws = Split(gKw(f), "|")
    hi = TrouverSection(kws, 1)
    If hi > 0 Then
        fin = FinSection(hi)
        SurlignerSection hi + 1, fin, gCoul(f)
        gTrouve(f) = True
        Dim hi2 As Long, fin2 As Long
        hi2 = TrouverSection(kws, fin)
        If hi2 > 0 Then
            fin2 = FinSection(hi2)
            SurlignerSection hi2 + 1, fin2, gCoul(f)
        End If
    End If
    ' "Matiere (repo)" : recherche additionnelle de "Merge Request" partout
    If InStr(1, gLabel(f), "Matiere", vbTextCompare) > 0 Then
        Dim i As Long
        For i = 1 To pCount
            If Not pIsHead(i) Then
                If Not EstExplicatif(pPara(i)) Then
                    If InStr(1, pPara(i).Range.Text, "Merge Request", vbTextCompare) > 0 Then
                        SurlignerParagraphe pPara(i), gCoul(f)
                        gTrouve(f) = True
                    End If
                End If
            End If
        Next i
    End If
End Sub

' --- champ "appendix" : contenu apres Resynchronisation + Assets mainframe
Private Sub AnnoterChampAppendix(f As Long)
    Dim kws() As String, hi As Long, fin As Long
    Dim resync() As String
    resync = Split("resynchronisation", "|")
    hi = TrouverSection(resync, 1)
    If hi > 0 Then
        fin = FinSection(hi)
        If fin <= pCount Then
            SurlignerSection fin + 1, pCount, gCoul(f)  ' tout ce qui suit la section
            gTrouve(f) = True
        End If
    End If
    kws = Split(gKw(f), "|")        ' "assets mainframe"
    hi = TrouverSection(kws, 1)
    If hi > 0 Then
        fin = FinSection(hi)
        SurlignerSection hi + 1, fin, gCoul(f)
        gTrouve(f) = True
    End If
End Sub

'======================================================================
' IDENTIFIANTS (rouge clair) : n# de solution, Auteur, Responsable
'======================================================================
Private Sub AnnoterIdentifiants(doc As Document)
    Dim i As Long, txt As String, borne As Long
    Dim reSol As Object
    Set reSol = CreerRegex("(^|[^A-Za-z0-9])S\d{4,6}([^0-9]|$)")

    borne = pCount
    If borne > 80 Then borne = 80   ' identifiants en debut de document

    Dim solTrouve As Boolean, auteurTrouve As Boolean, respTrouve As Boolean
    For i = 1 To borne
        If Not pIsHead(i) Then
            txt = pPara(i).Range.Text
            If Not solTrouve Then
                If reSol.Test(txt) Then
                    SurlignerParagraphe pPara(i), COUL_IDENT
                    solTrouve = True
                End If
            End If
            If Not auteurTrouve Then
                If CommencePar(txt, "auteur") Then
                    SurlignerParagraphe pPara(i), COUL_IDENT
                    auteurTrouve = True
                End If
            End If
            If Not respTrouve Then
                If CommencePar(txt, "responsable") Or CommencePar(txt, "service") Then
                    SurlignerParagraphe pPara(i), COUL_IDENT
                    respTrouve = True
                End If
            End If
        End If
    Next i
End Sub

' Vrai si le texte (apres nettoyage) commence par "<etiquette> :" ou "<etiquette><tab>"
Private Function CommencePar(txt As String, etiquette As String) As Boolean
    Dim s As String
    s = LCase$(Trim$(SansAccents(txt)))
    If Left$(s, Len(etiquette)) = etiquette Then
        Dim suite As String
        suite = Trim$(Mid$(s, Len(etiquette) + 1))
        If Left$(suite, 1) = ":" Or Left$(suite, 1) = vbTab Or InStr(txt, vbTab) > 0 Then
            CommencePar = True
        End If
    End If
End Function

'======================================================================
' REPERAGE PAR NOM (regle 1)
'======================================================================
' Cherche, a partir de l'index startAfter, le 1er titre dont le texte
' normalise correspond a un des mots-cles. Renvoie l'index du titre, ou 0.
Private Function TrouverSection(kws() As String, startAfter As Long) As Long
    Dim i As Long
    If startAfter < 1 Then startAfter = 1
    For i = startAfter To pCount
        If pIsHead(i) Then
            If TitreCorrespond(pNorm(i), kws) Then
                TrouverSection = i
                Exit Function
            End If
        End If
    Next i
    TrouverSection = 0
End Function

' Fin (index inclus du dernier paragraphe de la section) : juste avant le
' prochain titre de niveau <= a celui du titre courant (sinon fin du doc).
Private Function FinSection(hi As Long) As Long
    Dim niveau As Long, j As Long
    niveau = pLevel(hi)
    For j = hi + 1 To pCount
        If pIsHead(j) Then
            If pLevel(j) <= niveau Then
                FinSection = j - 1
                Exit Function
            End If
        End If
    Next j
    FinSection = pCount
End Function

' Correspondance titre normalise <-> mots-cles (miroir de _heading_matches) :
'   mot-cle multi-mots -> inclusion de la phrase ;
'   mot-cle d'un seul mot -> un mot du titre doit COMMENCER par le mot-cle
'   (gere singulier/pluriel, evite les faux positifs par sous-chaine).
Private Function TitreCorrespond(norm As String, kws() As String) As Boolean
    Dim mots() As String, k As Long, w As Long, kw As String
    mots = Split(norm, " ")
    For k = LBound(kws) To UBound(kws)
        kw = Trim$(kws(k))
        If Len(kw) > 0 Then
            If InStr(kw, " ") > 0 Then
                If InStr(1, norm, kw) > 0 Then TitreCorrespond = True : Exit Function
            Else
                For w = LBound(mots) To UBound(mots)
                    If Len(mots(w)) > 0 Then
                        If Left$(mots(w), Len(kw)) = kw Then TitreCorrespond = True : Exit Function
                    End If
                Next w
            End If
        End If
    Next k
    TitreCorrespond = False
End Function

'======================================================================
' SURLIGNAGE (regle 2 : on saute les titres et les encarts explicatifs)
'======================================================================
Private Sub SurlignerSection(debut As Long, fin As Long, coul As Long)
    Dim i As Long
    If debut < 1 Then debut = 1
    If fin > pCount Then fin = pCount
    For i = debut To fin
        If Not pIsHead(i) Then
            If Not EstExplicatif(pPara(i)) Then
                SurlignerParagraphe pPara(i), coul
            End If
        End If
    Next i
End Sub

Private Sub SurlignerParagraphe(p As Paragraph, coul As Long)
    Dim rng As Range
    Set rng = p.Range
    If Len(Trim$(rng.Text)) = 0 Then Exit Sub   ' paragraphe vide : rien a surligner
    ' Fond de caractere (equivalent de <w:shd>) : couleur RGB exacte, modifiable.
    rng.Shading.BackgroundPatternColor = coul
End Sub

' Encart explicatif (regle 2) : paragraphe entierement en italique ET dans
' une couleur de police non standard (typiquement bleu dans les gabarits DEX).
Private Function EstExplicatif(p As Paragraph) As Boolean
    Dim rng As Range
    Set rng = p.Range
    If Len(Trim$(rng.Text)) = 0 Then Exit Function
    If rng.Italic <> True Then Exit Function     ' True = tout le paragraphe en italique
    Dim c As Long
    c = rng.Font.Color
    If c = wdColorAutomatic Then Exit Function
    If c = wdColorBlack Or c = RGB(0, 0, 0) Then Exit Function
    If c = wdUndefined Then Exit Function          ' couleur mixte -> on ne tranche pas
    EstExplicatif = True
End Function

'======================================================================
' NORMALISATION DES TITRES (regle 1)
'======================================================================
Private Function NormaliserTitre(ByVal s As String) As String
    Dim re As Object
    ' Retire le caractere de fin de paragraphe
    s = Replace(s, vbCr, "")
    s = Replace(s, vbLf, "")
    s = Replace(s, Chr$(7), "")        ' marque de cellule
    ' Retire un prefixe de numerotation : "2.1", "12.3.4)", "4 - "
    Set re = CreerRegex("^\s*([0-9]+\.)*[0-9]+[.\)\-\s]*")
    s = re.Replace(s, "")
    ' Accents -> sans accents, minuscules
    s = LCase$(SansAccents(s))
    ' Tout ce qui n'est pas [a-z0-9 ] -> espace
    Set re = CreerRegex("[^a-z0-9 ]+")
    s = re.Replace(s, " ")
    ' Espaces multiples -> un seul
    Set re = CreerRegex("\s+")
    s = re.Replace(s, " ")
    NormaliserTitre = Trim$(s)
End Function

Private Function SansAccents(ByVal s As String) As String
    Dim src As String, dst As String, i As Long, ch As String, pos As Long
    src = "àáâãäåçèéêëìíîïñòóôõöùúûüýÿœæ" & "ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝŒÆ"
    dst = "aaaaaaceeeeiiiinooooouuuuyyoa" & "AAAAAACEEEEIIIINOOOOOUUUUYOA"
    ' (œ/æ approximes en 'o'/'a' — sans impact sur le reperage par mots-cles)
    For i = 1 To Len(s)
        ch = Mid$(s, i, 1)
        pos = InStr(src, ch)
        If pos > 0 Then
            SansAccents = SansAccents & Mid$(dst, pos, 1)
        Else
            SansAccents = SansAccents & ch
        End If
    Next i
End Function

Private Function CreerRegex(motif As String) As Object
    Dim re As Object
    Set re = CreateObject("VBScript.RegExp")
    re.Global = True
    re.IgnoreCase = True
    re.Pattern = motif
    Set CreerRegex = re
End Function

'======================================================================
' LEGENDE (inseree en tete de la copie annotee)
'======================================================================
Private Sub InsererLegende(doc As Document)
    Dim r As Range, t As Table
    Set r = doc.Range(0, 0)
    r.InsertBefore "LEGENDE — Copie annotee pour reprise CAST'IN " & _
                   "(le DEX source n'est pas modifie)" & vbCr & vbCr
    r.Font.Bold = True
    r.Font.Size = 12

    ' Tableau couleur <-> categorie <-> onglet <-> champs
    Dim lignes(1 To 6, 1 To 4) As String
    lignes(1, 2) = "Identifiants" : lignes(1, 3) = "Identification"
    lignes(1, 4) = "N# de solution, Auteur, Responsable"
    lignes(2, 2) = "Description detaillee" : lignes(2, 3) = "Description detaillee"
    lignes(2, 4) = "Lien Dossier Archi, Schema Applicatif, Description Fonctionnelle, Donnees de la solution, Description Technique"
    lignes(3, 2) = "Exploitation courante" : lignes(3, 3) = "DEX"
    lignes(3, 4) = "Plage de fonctionnement, Supervision, Observabilite, Log, Sauvegardes"
    lignes(4, 2) = "Securite / acces" : lignes(4, 3) = "DEX"
    lignes(4, 4) = "Servitudes, Comptes et services, Certificats, Liste blanche"
    lignes(5, 2) = "Echanges / livraison" : lignes(5, 3) = "DEX"
    lignes(5, 4) = "Flux, Support, Changement et MEP, Matiere (repo)"
    lignes(6, 2) = "Reprise / annexes" : lignes(6, 3) = "DEX"
    lignes(6, 4) = "Proc. restauration / reconstruction / resynchronisation, Informations supplementaires"

    Dim couls(1 To 6) As Long
    couls(1) = COUL_IDENT : couls(2) = COUL_DESC : couls(3) = COUL_JAUNE
    couls(4) = COUL_VERT : couls(5) = COUL_BLEU : couls(6) = COUL_INDIGO

    Set r = doc.Paragraphs(2).Range   ' apres le titre + la ligne vide
    Set t = doc.Tables.Add(r, 7, 4)
    t.Borders.Enable = True
    t.AllowAutoFit = True

    t.Cell(1, 1).Range.Text = "Couleur"
    t.Cell(1, 2).Range.Text = "Categorie"
    t.Cell(1, 3).Range.Text = "Onglet CAST'IN"
    t.Cell(1, 4).Range.Text = "Champs"
    t.Rows(1).Range.Font.Bold = True

    Dim i As Long
    For i = 1 To 6
        t.Cell(i + 1, 1).Shading.BackgroundPatternColor = couls(i)
        t.Cell(i + 1, 2).Range.Text = lignes(i, 2)
        t.Cell(i + 1, 3).Range.Text = lignes(i, 3)
        t.Cell(i + 1, 4).Range.Text = lignes(i, 4)
    Next i

    ' Points a verifier : sections non reperees
    Dim manque As String, f As Long
    manque = ""
    For f = 1 To gNbChamps
        If Not gTrouve(f) Then manque = manque & "- " & gLabel(f) & vbCr
    Next f

    Dim rFin As Range
    Set rFin = t.Range
    rFin.Collapse wdCollapseEnd
    rFin.InsertParagraphAfter
    rFin.Collapse wdCollapseEnd
    If Len(manque) > 0 Then
        rFin.InsertAfter vbCr & "Points a verifier aupres de l'Equipier Ops " & _
            "(sections non reperees automatiquement) :" & vbCr & manque
    Else
        rFin.InsertAfter vbCr & "Points a verifier aupres de l'Equipier Ops : RAS " & _
            "(toutes les sections ont ete reperees)." & vbCr
    End If
    rFin.InsertAfter vbCr
End Sub
