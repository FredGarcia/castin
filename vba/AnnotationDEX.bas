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
' REPERAGE DES SECTIONS (regle 1 : par NOM)
'   Les titres sont retrouves par le texte NORMALISE de leur paragraphe
'   (numerotation, accents, casse, ponctuation ignores). Un paragraphe est
'   considere comme un TITRE soit parce qu'il porte un style de titre Word
'   (OutlineLevel), soit parce qu'il commence par une numerotation de
'   chapitre ("2.1 ...", "6 ...") — beaucoup de DEX ne stylent pas leurs
'   titres. Tout le contenu d'une section reperee (texte, tableaux, images)
'   est surligne ; seuls les encarts d'aide explicatifs (paragraphe tout
'   en italique + couleur non standard) sont ecartes (regle 2).
'
' COULEURS (modifiables — voir Sub InitCouleurs)
'     rouge clair : identifiants (n# de solution, Auteur, Responsable)
'     orange      : Description detaillee
'     jaune       : Plage de fonctionnement, Supervision, Observabilite,
'                   Log, Sauvegardes
'     vert        : Servitudes, Comptes et services, Certificats, Liste blanche
'     bleu        : Flux, Support, Changement et MEP, Matiere (repo)
'     indigo      : Procedures de restauration / reconstruction /
'                   resynchronisation, Informations supplementaires
'
' UTILISATION
'   1. Ouvrir le DEX .docx a traiter (il doit etre enregistre sur disque).
'   2. Alt+F11 -> importer ce fichier (.bas) -> revenir a Word.
'   3. Lancer la macro "AnnoterDEX" (Alt+F8).
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
Private gLabel()    As String   ' libelle exact du champ CAST'IN
Private gCoul()     As Long     ' couleur de surlignage du champ
Private gKw()       As String   ' mots-cles normalises, separes par "|"
Private gKind()     As String   ' "text" | "link" | "merge" | "appendix"
Private gTrouve()   As Boolean  ' renseigne pendant l'annotation
Private gContenu()  As String   ' contenu repere dans CE document (legende)
Private gNbChamps   As Long
Private gIdentTexte As String    ' contenu des identifiants reperes (legende)

' --- Caches de la structure du document ------------------------------
Private pPara()    As Paragraph ' paragraphe i
Private pLevel()   As Long      ' niveau de titre (1..9), 99 si corps
Private pIsHead()  As Boolean   ' True si le paragraphe est un titre
Private pNorm()    As String    ' titre normalise (si titre)
Private pNum()     As String    ' jeton de numerotation du titre ("6", "12.2"), "" si style Word
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
' donc non surligne). Mots-cles deja normalises (accents/casse retires).
'======================================================================
Private Sub ChargerChamps()
    gNbChamps = 0
    gIdentTexte = ""
    ReDim gLabel(1 To 40)
    ReDim gCoul(1 To 40)
    ReDim gKw(1 To 40)
    ReDim gKind(1 To 40)
    ReDim gTrouve(1 To 40)
    ReDim gContenu(1 To 40)

    ' --- orange : Description detaillee --------------------------------
    AjouterChamp "Lien Dossier Archi (DAP...)", COUL_DESC, "link", _
        "architecture fonctionnelle applicative"
    AjouterChamp "Schema Applicatif (ADU...)", COUL_DESC, "link", _
        "architecture fonctionnelle applicative|description de la solution|description fonctionnelle"
    AjouterChamp "Description Fonctionnelle", COUL_DESC, "text", _
        "description de la solution|description fonctionnelle"
    AjouterChamp "Donnees de la solution", COUL_DESC, "text", _
        "donnees"
    AjouterChamp "Description Technique", COUL_DESC, "text", _
        "architecture technique"

    ' --- jaune ---------------------------------------------------------
    AjouterChamp "Plage de fonctionnement / maintenance", COUL_JAUNE, "text", _
        "plage de fonctionnement|plages de fonctionnement"
    AjouterChamp "Supervision", COUL_JAUNE, "text", _
        "supervision"
    AjouterChamp "Observabilite", COUL_JAUNE, "text", _
        "metrologie"
    AjouterChamp "Log", COUL_JAUNE, "text", _
        "diagnostic|diagnostique|log|trace"
    AjouterChamp "Sauvegardes", COUL_JAUNE, "text", _
        "sauvegarde"

    ' --- vert ----------------------------------------------------------
    AjouterChamp "Servitudes et ordonnancements", COUL_VERT, "text", _
        "servitude"
    AjouterChamp "Comptes et services", COUL_VERT, "text", _
        "compte de service|comptes de service"
    AjouterChamp "Certificats", COUL_VERT, "text", _
        "certificat"
    AjouterChamp "Liste blanche", COUL_VERT, "text", _
        "liste blanche|whitelist"

    ' --- bleu ----------------------------------------------------------
    AjouterChamp "Flux", COUL_BLEU, "text", _
        "flux et interdependance|flux et interdependances"
    AjouterChamp "Support", COUL_BLEU, "text", _
        "matrice de responsabilite|matrice des responsabilites|raci"
    AjouterChamp "Changement et MEP", COUL_BLEU, "merge", _
        "controle des operations|changements et mep|changement et mep"
    AjouterChamp "Matiere (repo)", COUL_BLEU, "merge", _
        "referentiel|repository|depot de code|matiere"

    ' --- indigo --------------------------------------------------------
    AjouterChamp "Procedure de restauration", COUL_INDIGO, "text", _
        "restauration"
    AjouterChamp "Procedure de reconstruction", COUL_INDIGO, "text", _
        "reconstruction"
    AjouterChamp "Procedure de resynchronisation", COUL_INDIGO, "text", _
        "resynchronisation"
    AjouterChamp "Informations supplementaires", COUL_INDIGO, "appendix", _
        "assets mainframe"
End Sub

Private Sub AjouterChamp(libelle As String, coul As Long, kind As String, kw As String)
    gNbChamps = gNbChamps + 1
    gLabel(gNbChamps) = libelle
    gCoul(gNbChamps) = coul
    gKind(gNbChamps) = kind
    gKw(gNbChamps) = kw
    gTrouve(gNbChamps) = False
    gContenu(gNbChamps) = ""
End Sub

'======================================================================
' CACHE DE STRUCTURE : reperage des titres (style Word OU numerotation)
'======================================================================
Private Sub ConstruireCacheStructure(doc As Document)
    Dim n As Long, i As Long, p As Paragraph
    Dim estTitre As Boolean, niveau As Long, norm As String, numtok As String
    n = doc.Paragraphs.Count
    pCount = n
    ReDim pPara(1 To n)
    ReDim pLevel(1 To n)
    ReDim pIsHead(1 To n)
    ReDim pNorm(1 To n)
    ReDim pNum(1 To n)

    i = 0
    For Each p In doc.Paragraphs
        i = i + 1
        Set pPara(i) = p
        DetecterTitre p, estTitre, niveau, norm, numtok
        pIsHead(i) = estTitre
        If estTitre Then
            pLevel(i) = niveau
            pNorm(i) = norm
            pNum(i) = numtok
        Else
            pLevel(i) = 99
            pNorm(i) = ""
            pNum(i) = ""
        End If
    Next p
End Sub

' Determine si un paragraphe est un TITRE de section, son niveau, son texte
' normalise et son jeton de numerotation. Titre = style de titre Word
' (OutlineLevel 1..9) OU paragraphe court (<=8 mots) commencant par une
' numerotation "N", "N.N"... (beaucoup de DEX ne stylent pas leurs titres).
Private Sub DetecterTitre(p As Paragraph, ByRef estTitre As Boolean, _
                          ByRef niveau As Long, ByRef norm As String, _
                          ByRef numtok As String)
    Dim ol As Long, brut As String, re As Object, m As Object
    estTitre = False : niveau = 99 : norm = "" : numtok = ""

    brut = NettoyerLigne(p.Range.Text)
    If Len(brut) = 0 Then Exit Sub

    ol = p.OutlineLevel
    If ol >= wdOutlineLevel1 And ol <= wdOutlineLevel9 Then
        estTitre = True
        niveau = ol
        norm = NormaliserTitre(brut)
        numtok = ""            ' titre style Word -> bornage par niveau de plan
        Exit Sub
    End If

    ' Numerotation de chapitre en debut de ligne, titre court
    If NbMots(brut) <= 8 Then
        Set re = CreerRegex("^\s*(\d+(?:\.\d+){0,4})\.?\s+\S")
        If re.Test(brut) Then
            Set m = re.Execute(brut)(0)
            numtok = m.SubMatches(0)               ' ex: "2.1", "12.2", "6"
            estTitre = True
            niveau = UBound(Split(numtok, ".")) + 1 ' profondeur = niveau
            norm = NormaliserTitre(brut)
        End If
    End If
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
        SurlignerPlage hi, fin, gCoul(f)
        AjouterContenu f, TexteContenu(hi + 1, fin)
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
        SurlignerPlage hi, fin, gCoul(f)
        AjouterContenu f, TexteContenu(hi + 1, fin)
        gTrouve(f) = True
        curseur = fin + 1
    Loop
End Sub

' --- champ "merge" : 1re + 2e section (+ "Merge Request" pour Matiere) -
Private Sub AnnoterChampMerge(f As Long)
    Dim kws() As String, hi As Long, fin As Long
    kws = Split(gKw(f), "|")
    hi = TrouverSection(kws, 1)
    If hi > 0 Then
        fin = FinSection(hi)
        SurlignerPlage hi, fin, gCoul(f)
        AjouterContenu f, TexteContenu(hi + 1, fin)
        gTrouve(f) = True
        Dim hi2 As Long, fin2 As Long
        hi2 = TrouverSection(kws, fin + 1)
        If hi2 > 0 Then
            fin2 = FinSection(hi2)
            SurlignerPlage hi2, fin2, gCoul(f)
            AjouterContenu f, TexteContenu(hi2 + 1, fin2)
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
                        AjouterContenu f, NettoyerLigne(pPara(i).Range.Text)
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
        If fin < pCount Then
            SurlignerPlage fin + 1, pCount, gCoul(f)   ' tout ce qui suit la section
            AjouterContenu f, TexteContenu(fin + 1, pCount)
            gTrouve(f) = True
        End If
    End If
    kws = Split(gKw(f), "|")        ' "assets mainframe"
    hi = TrouverSection(kws, 1)
    If hi > 0 Then
        fin = FinSection(hi)
        SurlignerPlage hi, fin, gCoul(f)
        AjouterContenu f, TexteContenu(hi + 1, fin)
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
                    gIdentTexte = gIdentTexte & "Solution : " & NettoyerLigne(txt) & vbCr
                    solTrouve = True
                End If
            End If
            If Not auteurTrouve Then
                If CommencePar(txt, "auteur") Then
                    SurlignerParagraphe pPara(i), COUL_IDENT
                    gIdentTexte = gIdentTexte & NettoyerLigne(txt) & vbCr
                    auteurTrouve = True
                End If
            End If
            If Not respTrouve Then
                If CommencePar(txt, "responsable") Or CommencePar(txt, "service") Then
                    SurlignerParagraphe pPara(i), COUL_IDENT
                    gIdentTexte = gIdentTexte & NettoyerLigne(txt) & vbCr
                    respTrouve = True
                End If
            End If
        End If
    Next i
End Sub

' Vrai si le texte commence par "<etiquette> :" ou "<etiquette><tab>"
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

' Fin (index inclus du dernier paragraphe de la section).
'  - Titre numerote ("6", "12.2") : la section va jusqu'au prochain titre
'    qui N'EST PAS un sous-numero du titre courant ("6" inclut "6.1" mais
'    "11" s'arrete avant "12.2"). Robuste meme si la numerotation des
'    chapitres n'est pas monotone (cas frequent dans les DEX).
'  - Titre de style Word : jusqu'au prochain titre de niveau de plan <=.
Private Function FinSection(hi As Long) As Long
    Dim j As Long
    If Len(pNum(hi)) > 0 Then
        For j = hi + 1 To pCount
            If pIsHead(j) Then
                If Len(pNum(j)) = 0 Then
                    FinSection = j - 1 : Exit Function          ' titre style Word -> frontiere
                ElseIf Not EstDescendant(pNum(j), pNum(hi)) Then
                    FinSection = j - 1 : Exit Function
                End If
            End If
        Next j
    Else
        Dim niveau As Long
        niveau = pLevel(hi)
        For j = hi + 1 To pCount
            If pIsHead(j) Then
                If pLevel(j) <= niveau Then
                    FinSection = j - 1 : Exit Function
                End If
            End If
        Next j
    End If
    FinSection = pCount
End Function

' Vrai si le jeton "enfant" est un sous-numero strict de "parent"
' (ex: "6.1" descend de "6", mais "12.2" ne descend pas de "11").
Private Function EstDescendant(enfant As String, parent As String) As Boolean
    If enfant = parent Then Exit Function
    EstDescendant = (Left$(enfant, Len(parent) + 1) = parent & ".")
End Function

' Correspondance titre normalise <-> mots-cles (miroir de _heading_matches) :
'   mot-cle multi-mots -> inclusion de la phrase ;
'   mot-cle d'un seul mot -> un mot du titre doit COMMENCER par le mot-cle.
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
' SURLIGNAGE
'======================================================================
' Surligne tous les paragraphes d'une plage (titre inclus, tableaux et
' images compris), en ecartant les encarts explicatifs (regle 2).
Private Sub SurlignerPlage(debut As Long, fin As Long, coul As Long)
    Dim i As Long
    If debut < 1 Then debut = 1
    If fin > pCount Then fin = pCount
    For i = debut To fin
        If Not EstExplicatif(pPara(i)) Then
            SurlignerParagraphe pPara(i), coul
        End If
    Next i
End Sub

Private Sub SurlignerParagraphe(p As Paragraph, coul As Long)
    Dim rng As Range
    Set rng = p.Range
    ' Ignore les paragraphes vides ET les marques de fin de cellule / ligne
    ' de tableau (Chr(7)), non surlignables (erreur 4605).
    If EstVidePourSurlignage(rng) Then Exit Sub
    ' Fond de caractere (equivalent de <w:shd>) : couleur RGB exacte, modifiable.
    On Error Resume Next    ' filet de securite : marqueur de tableau residuel
    rng.Shading.BackgroundPatternColor = coul
    On Error GoTo 0
End Sub

' Vrai si le paragraphe ne contient aucun texte surlignable une fois retirees
' les marques de fin de cellule / ligne de tableau et les fins de paragraphe.
Private Function EstVidePourSurlignage(rng As Range) As Boolean
    Dim t As String
    t = rng.Text
    t = Replace(t, Chr$(7), "")     ' marque de cellule / fin de ligne de tableau
    t = Replace(t, vbCr, "")
    t = Replace(t, vbLf, "")
    t = Replace(t, Chr$(11), "")    ' saut de ligne manuel
    EstVidePourSurlignage = (Len(Trim$(t)) = 0)
End Function

' Texte de contenu d'une plage (pour la colonne "Contenu" de la legende) :
' on saute les titres et les encarts explicatifs.
Private Function TexteContenu(debut As Long, fin As Long) As String
    Dim i As Long, acc As String, t As String
    If debut < 1 Then debut = 1
    If fin > pCount Then fin = pCount
    For i = debut To fin
        If Not pIsHead(i) And Not EstExplicatif(pPara(i)) Then
            t = NettoyerLigne(pPara(i).Range.Text)
            If Len(t) > 0 Then acc = acc & t & " / "
        End If
    Next i
    If Len(acc) >= 3 Then acc = Left$(acc, Len(acc) - 3)  ' retire le dernier " / "
    TexteContenu = acc
End Function

Private Sub AjouterContenu(f As Long, texte As String)
    If Len(Trim$(texte)) = 0 Then Exit Sub
    If Len(gContenu(f)) > 0 Then gContenu(f) = gContenu(f) & " / "
    gContenu(f) = gContenu(f) & texte
End Sub

' Encart explicatif (regle 2) : paragraphe entierement en italique ET dans
' une couleur de police non standard (typiquement bleu dans les gabarits).
Private Function EstExplicatif(p As Paragraph) As Boolean
    Dim rng As Range
    Set rng = p.Range
    If EstVidePourSurlignage(rng) Then Exit Function   ' vide / marqueur de tableau
    If rng.Italic <> True Then Exit Function     ' True = tout le paragraphe en italique
    Dim c As Long
    c = rng.Font.Color
    If c = wdColorAutomatic Then Exit Function
    If c = wdColorBlack Or c = RGB(0, 0, 0) Then Exit Function
    If c = wdUndefined Then Exit Function          ' couleur mixte -> on ne tranche pas
    EstExplicatif = True
End Function

'======================================================================
' NORMALISATION / OUTILS TEXTE
'======================================================================
Private Function NormaliserTitre(ByVal s As String) As String
    Dim re As Object
    s = NettoyerLigne(s)
    ' Retire un prefixe de numerotation : "2.1", "12.3.4)", "4 - "
    Set re = CreerRegex("^\s*([0-9]+\.)*[0-9]+[.\)\-\s]*")
    s = re.Replace(s, "")
    s = LCase$(SansAccents(s))
    Set re = CreerRegex("[^a-z0-9 ]+")
    s = re.Replace(s, " ")
    Set re = CreerRegex("\s+")
    s = re.Replace(s, " ")
    NormaliserTitre = Trim$(s)
End Function

' Nettoie une ligne brute Word : retire fins de paragraphe / marques de
' cellule, compresse les espaces.
Private Function NettoyerLigne(ByVal s As String) As String
    Dim re As Object
    s = Replace(s, vbCr, " ")
    s = Replace(s, vbLf, " ")
    s = Replace(s, Chr$(7), " ")        ' marque de fin de cellule
    s = Replace(s, Chr$(11), " ")       ' saut de ligne manuel
    s = Replace(s, Chr$(160), " ")      ' espace insecable
    Set re = CreerRegex("\s+")
    s = re.Replace(s, " ")
    NettoyerLigne = Trim$(s)
End Function

Private Function NbMots(ByVal s As String) As Long
    s = Trim$(s)
    If Len(s) = 0 Then NbMots = 0 Else NbMots = UBound(Split(s, " ")) + 1
End Function

Private Function SansAccents(ByVal s As String) As String
    Dim src As String, dst As String, i As Long, ch As String, pos As Long
    src = "àáâãäåçèéêëìíîïñòóôõöùúûüýÿœæ" & "ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝŒÆ"
    dst = "aaaaaaceeeeiiiinooooouuuuyyoa" & "AAAAAACEEEEIIIINOOOOOUUUUYOA"
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
'   Colonnes : Couleur | Categorie | Champs | Contenu (du document)
'======================================================================
Private Sub InsererLegende(doc As Document)
    Dim r As Range, t As Table

    Set r = doc.Range(0, 0)
    r.InsertBefore "LEGENDE — Copie annotee pour reprise CAST'IN " & _
                   "(le DEX source n'est pas modifie)" & vbCr & vbCr
    r.Font.Bold = True
    r.Font.Size = 12

    ' Libelles "Champs" et couleur de chaque categorie
    Dim cat(1 To 6) As String, champs(1 To 6) As String, couls(1 To 6) As Long
    cat(1) = "Identifiants"
    champs(1) = "N# de solution, Auteur, Responsable" : couls(1) = COUL_IDENT
    cat(2) = "Description detaillee"
    champs(2) = "Lien Dossier Archi, Schema Applicatif, Description Fonctionnelle, Donnees de la solution, Description Technique" : couls(2) = COUL_DESC
    cat(3) = "Exploitation courante"
    champs(3) = "Plage de fonctionnement, Supervision, Observabilite, Log, Sauvegardes" : couls(3) = COUL_JAUNE
    cat(4) = "Securite / acces"
    champs(4) = "Servitudes, Comptes et services, Certificats, Liste blanche" : couls(4) = COUL_VERT
    cat(5) = "Echanges / livraison"
    champs(5) = "Flux, Support, Changement et MEP, Matiere (repo)" : couls(5) = COUL_BLEU
    cat(6) = "Reprise / annexes"
    champs(6) = "Proc. restauration / reconstruction / resynchronisation, Informations supplementaires" : couls(6) = COUL_INDIGO

    ' Contenu repere dans CE document, par categorie
    Dim contenu(1 To 6) As String
    contenu(1) = gIdentTexte
    Dim cIdx As Long, f As Long
    For cIdx = 2 To 6
        Dim acc As String
        acc = ""
        For f = 1 To gNbChamps
            If gCoul(f) = couls(cIdx) Then
                If Len(gContenu(f)) > 0 Then
                    acc = acc & gLabel(f) & " : " & gContenu(f) & vbCr
                End If
            End If
        Next f
        contenu(cIdx) = acc
    Next cIdx

    Set r = doc.Paragraphs(2).Range   ' apres le titre + la ligne vide
    Set t = doc.Tables.Add(r, 7, 4)
    t.Borders.Enable = True
    t.AllowAutoFit = True
    t.PreferredWidthType = wdPreferredWidthPercent
    t.Columns(1).PreferredWidth = 8
    t.Columns(2).PreferredWidth = 16
    t.Columns(3).PreferredWidth = 30
    t.Columns(4).PreferredWidth = 46

    t.Cell(1, 1).Range.Text = "Couleur"
    t.Cell(1, 2).Range.Text = "Categorie"
    t.Cell(1, 3).Range.Text = "Champs"
    t.Cell(1, 4).Range.Text = "Contenu repere dans ce document"
    t.Rows(1).Range.Font.Bold = True

    Dim i As Long, txt As String
    For i = 1 To 6
        t.Cell(i + 1, 1).Shading.BackgroundPatternColor = couls(i)
        t.Cell(i + 1, 2).Range.Text = cat(i)
        t.Cell(i + 1, 3).Range.Text = champs(i)
        txt = contenu(i)
        If Len(Trim$(txt)) = 0 Then txt = "(aucune section reperee)"
        ' Retire un dernier saut de paragraphe superflu
        Do While Right$(txt, 1) = vbCr Or Right$(txt, 1) = vbLf
            txt = Left$(txt, Len(txt) - 1)
        Loop
        t.Cell(i + 1, 4).Range.Text = txt
    Next i

    ' Points a verifier : sections non reperees
    Dim manque As String
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
