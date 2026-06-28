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
'   du fichier sur disque.
'
' CONFIGURATION (couleurs, categories, repartition des champs)
'   Lue depuis un fichier INI externe "AnnotationDEX.config.ini" place
'   dans le meme dossier que le DEX (ou au chemin CONFIG_CHEMIN ci-dessous).
'   Si le fichier est absent, les valeurs PAR DEFAUT integrees sont
'   utilisees (cf. Sub ChargerDefauts).
'
' REPERAGE DES SECTIONS (regle 1 : par NOM)
'   Les titres sont retrouves par le texte NORMALISE de leur paragraphe
'   (numerotation, accents, casse, ponctuation ignores). Un paragraphe est
'   un TITRE s'il porte un style de titre Word (OutlineLevel) OU s'il est
'   court et commence par une numerotation de chapitre ("2.1 ...", "6 ...").
'   Tout le contenu d'une section reperee (texte, tableaux, images) est
'   surligne ; seuls les encarts d'aide (italique + couleur) sont ecartes
'   (regle 2).
'
' UTILISATION
'   1. Ouvrir le DEX .docx (enregistre sur disque).
'   2. Alt+F11 -> Insertion > Module -> coller ce code (ou importer le .bas).
'   3. Alt+F8 -> AnnoterDEX -> Executer.
'======================================================================

Option Explicit

' Chemin explicite d'un fichier de config (laisser "" pour chercher
' "AnnotationDEX.config.ini" a cote du DEX, puis retomber sur les defauts).
Private Const CONFIG_CHEMIN As String = ""
Private Const CONFIG_NOM As String = "AnnotationDEX.config.ini"

' --- Couleurs (cle -> Long RGB) --------------------------------------
Private gDictCoul As Object         ' Scripting.Dictionary : cle_couleur -> Long

' --- Categories (dans l'ordre d'affichage de la legende) -------------
Private gCatKey()     As String
Private gCatLabel()   As String
Private gCatCoulKey() As String     ' cle de couleur (brute, resolue ensuite)
Private gCatCoul()    As Long       ' couleur resolue
Private gNbCat        As Long

' --- Champs ----------------------------------------------------------
Private gLabel()    As String
Private gCatOf()    As String       ' cle de categorie du champ
Private gKind()     As String       ' text | link | merge | appendix
Private gKw()       As String       ' mots-cles normalises, separes par "|"
Private gCoul()     As Long         ' couleur resolue du champ
Private gTrouve()   As Boolean
Private gSpans()    As Collection   ' spans de contenu [debut, fin] reperes
Private gNbChamps   As Long

' --- Identifiants ----------------------------------------------------
Private gIdentSpans As Collection
Private gIdentCoul  As Long

' --- Caches de la structure du document ------------------------------
Private pPara()    As Paragraph
Private pLevel()   As Long
Private pIsHead()  As Boolean
Private pNorm()    As String
Private pNum()     As String        ' jeton de numerotation ("6", "12.2"), "" si style Word
Private pCount     As Long

' --- Divers ----------------------------------------------------------
Private gSourceConfig As String     ' origine de la config (pour le message final)

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

    dossier = src.Path
    base = src.Name
    If InStrRev(base, ".") > 0 Then base = Left$(base, InStrRev(base, ".") - 1)
    cheminAnn = dossier & Application.PathSeparator & base & "_ANNOTE.docx"

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
    ChargerConfig dossier
    ConstruireCacheStructure ann
    AnnoterIdentifiants ann
    AnnoterTousLesChamps ann
    InsererLegende ann
    ann.Save
    Application.ScreenUpdating = True

    MsgBox "Copie annotee creee :" & vbCrLf & cheminAnn & vbCrLf & vbCrLf & _
           "Le DEX source n'a pas ete modifie." & vbCrLf & _
           "Configuration : " & gSourceConfig, vbInformation, "Annotation DEX terminee"
    Exit Sub

Echec:
    Application.ScreenUpdating = True
    MsgBox "Erreur pendant l'annotation : " & Err.Description, vbCritical
End Sub

'======================================================================
' CONFIGURATION : fichier INI externe, sinon defauts integres
'======================================================================
Private Sub ChargerConfig(dossierDoc As String)
    Dim fso As Object, chemin As String
    Set fso = CreateObject("Scripting.FileSystemObject")

    chemin = ""
    If Len(CONFIG_CHEMIN) > 0 Then
        If fso.FileExists(CONFIG_CHEMIN) Then chemin = CONFIG_CHEMIN
    End If
    If Len(chemin) = 0 Then
        Dim cand As String
        cand = dossierDoc & Application.PathSeparator & CONFIG_NOM
        If fso.FileExists(cand) Then chemin = cand
    End If

    InitStructuresVides
    If Len(chemin) > 0 Then
        ParseIni chemin
        gSourceConfig = chemin
    End If
    ' Filet : config absente ou incomplete -> defauts integres
    If gNbChamps = 0 Or gNbCat = 0 Or gDictCoul.Count = 0 Then
        InitStructuresVides
        ChargerDefauts
        gSourceConfig = "valeurs par defaut integrees"
    End If

    ResoudreCouleurs
End Sub

Private Sub InitStructuresVides()
    Set gDictCoul = CreateObject("Scripting.Dictionary")
    gDictCoul.CompareMode = 1       ' insensible a la casse
    gNbCat = 0 : gNbChamps = 0
    ReDim gCatKey(1 To 40) : ReDim gCatLabel(1 To 40)
    ReDim gCatCoulKey(1 To 40) : ReDim gCatCoul(1 To 40)
    ReDim gLabel(1 To 60) : ReDim gCatOf(1 To 60) : ReDim gKind(1 To 60)
    ReDim gKw(1 To 60) : ReDim gCoul(1 To 60) : ReDim gTrouve(1 To 60)
    ReDim gSpans(1 To 60)
    Set gIdentSpans = New Collection
End Sub

Private Sub ParseIni(chemin As String)
    Dim contenu As String, lignes() As String, ln As String, sect As String
    Dim i As Long, pos As Long, k As String, v As String, parts() As String

    contenu = LireTexte(chemin)
    contenu = Replace(contenu, vbCrLf, vbLf)
    contenu = Replace(contenu, vbCr, vbLf)
    lignes = Split(contenu, vbLf)

    sect = ""
    For i = LBound(lignes) To UBound(lignes)
        ln = Trim$(lignes(i))
        If Len(ln) > 0 And Left$(ln, 1) <> ";" And Left$(ln, 1) <> "#" Then
            If Left$(ln, 1) = "[" And Right$(ln, 1) = "]" Then
                sect = LCase$(Trim$(Mid$(ln, 2, Len(ln) - 2)))
            Else
                pos = InStr(ln, "=")
                If pos > 0 Then
                    k = Trim$(Left$(ln, pos - 1))
                    v = Trim$(Mid$(ln, pos + 1))
                    Select Case sect
                        Case "couleurs"
                            gDictCoul(LCase$(k)) = HexVersCouleur(v)
                        Case "categories"
                            parts = Split(v, "|")
                            If UBound(parts) >= 1 Then
                                AjouterCategorie k, Trim$(parts(0)), LCase$(Trim$(parts(1)))
                            End If
                        Case "champs"
                            parts = Split(v, "|")
                            If UBound(parts) >= 2 Then
                                AjouterChamp k, LCase$(Trim$(parts(0))), LCase$(Trim$(parts(1))), _
                                             NormaliserMotsCles(parts(2))
                            End If
                    End Select
                End If
            End If
        End If
    Next i
End Sub

' "a ; b ;c" -> "a|b|c"  (mots-cles, deja normalises dans la config)
Private Function NormaliserMotsCles(s As String) As String
    Dim parts() As String, i As Long, acc As String
    parts = Split(s, ";")
    For i = LBound(parts) To UBound(parts)
        If Len(Trim$(parts(i))) > 0 Then
            If Len(acc) > 0 Then acc = acc & "|"
            acc = acc & Trim$(parts(i))
        End If
    Next i
    NormaliserMotsCles = acc
End Function

Private Sub AjouterCategorie(cle As String, libelle As String, cleCouleur As String)
    gNbCat = gNbCat + 1
    gCatKey(gNbCat) = LCase$(cle)
    gCatLabel(gNbCat) = libelle
    gCatCoulKey(gNbCat) = cleCouleur
End Sub

Private Sub AjouterChamp(libelle As String, cleCat As String, kind As String, kw As String)
    gNbChamps = gNbChamps + 1
    gLabel(gNbChamps) = libelle
    gCatOf(gNbChamps) = cleCat
    gKind(gNbChamps) = kind
    gKw(gNbChamps) = kw
    gTrouve(gNbChamps) = False
    Set gSpans(gNbChamps) = New Collection
End Sub

' Resout les couleurs des categories et des champs a partir du dictionnaire.
Private Sub ResoudreCouleurs()
    Dim i As Long
    For i = 1 To gNbCat
        gCatCoul(i) = CoulDepuisCle(gCatCoulKey(i))
    Next i
    For i = 1 To gNbChamps
        gCoul(i) = CoulCategorie(gCatOf(i))
    Next i
    gIdentCoul = CoulCategorie("ident")
End Sub

Private Function CoulDepuisCle(cle As String) As Long
    If gDictCoul.Exists(LCase$(cle)) Then
        CoulDepuisCle = gDictCoul(LCase$(cle))
    Else
        CoulDepuisCle = RGB(255, 235, 120)   ' jaune par defaut
    End If
End Function

Private Function CoulCategorie(cleCat As String) As Long
    Dim i As Long
    For i = 1 To gNbCat
        If gCatKey(i) = LCase$(cleCat) Then CoulCategorie = gCatCoul(i) : Exit Function
    Next i
    CoulCategorie = RGB(255, 235, 120)
End Function

' Valeurs PAR DEFAUT (identiques au fichier .ini fourni).
Private Sub ChargerDefauts()
    gDictCoul("ident") = HexVersCouleur("FF9999")
    gDictCoul("orange") = HexVersCouleur("FFB266")
    gDictCoul("jaune") = HexVersCouleur("FFEB78")
    gDictCoul("vert") = HexVersCouleur("92D06E")
    gDictCoul("bleu") = HexVersCouleur("8EB4E3")
    gDictCoul("indigo") = HexVersCouleur("9F9FE0")

    AjouterCategorie "ident", "Identifiants", "ident"
    AjouterCategorie "desc", "Description detaillee", "orange"
    AjouterCategorie "expl", "Exploitation courante", "jaune"
    AjouterCategorie "secu", "Securite / acces", "vert"
    AjouterCategorie "flux", "Echanges / livraison", "bleu"
    AjouterCategorie "reprise", "Reprise / annexes", "indigo"

    AjouterChamp "Lien Dossier Archi (DAP...)", "desc", "link", "architecture fonctionnelle applicative"
    AjouterChamp "Schema Applicatif (ADU...)", "desc", "link", "architecture fonctionnelle applicative|description de la solution|description fonctionnelle"
    AjouterChamp "Description Fonctionnelle", "desc", "text", "description de la solution|description fonctionnelle"
    AjouterChamp "Donnees de la solution", "desc", "text", "donnees"
    AjouterChamp "Description Technique", "desc", "text", "architecture technique"
    AjouterChamp "Plage de fonctionnement / maintenance", "expl", "text", "plage de fonctionnement|plages de fonctionnement"
    AjouterChamp "Supervision", "expl", "text", "supervision"
    AjouterChamp "Observabilite", "expl", "text", "metrologie"
    AjouterChamp "Log", "expl", "text", "diagnostic|diagnostique|log|trace"
    AjouterChamp "Sauvegardes", "expl", "text", "sauvegarde"
    AjouterChamp "Servitudes et ordonnancements", "secu", "text", "servitude"
    AjouterChamp "Comptes et services", "secu", "text", "compte de service|comptes de service"
    AjouterChamp "Certificats", "secu", "text", "certificat"
    AjouterChamp "Liste blanche", "secu", "text", "liste blanche|whitelist"
    AjouterChamp "Flux", "flux", "text", "flux et interdependance|flux et interdependances"
    AjouterChamp "Support", "flux", "text", "matrice de responsabilite|matrice des responsabilites|raci"
    AjouterChamp "Changement et MEP", "flux", "merge", "controle des operations|changements et mep|changement et mep"
    AjouterChamp "Matiere (repo)", "flux", "merge", "referentiel|repository|depot de code|matiere"
    AjouterChamp "Procedure de restauration", "reprise", "text", "restauration"
    AjouterChamp "Procedure de reconstruction", "reprise", "text", "reconstruction"
    AjouterChamp "Procedure de resynchronisation", "reprise", "text", "resynchronisation"
    AjouterChamp "Informations supplementaires", "reprise", "appendix", "assets mainframe"
End Sub

' Lit un fichier texte (ANSI). Conserver des libelles sans accents.
Private Function LireTexte(chemin As String) As String
    Dim fso As Object, ts As Object
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set ts = fso.OpenTextFile(chemin, 1, False)
    If Not ts.AtEndOfStream Then LireTexte = ts.ReadAll
    ts.Close
End Function

Private Function HexVersCouleur(ByVal h As String) As Long
    h = Trim$(h)
    If Left$(h, 1) = "#" Then h = Mid$(h, 2)
    If Len(h) <> 6 Then HexVersCouleur = RGB(255, 235, 120) : Exit Function
    Dim r As Long, g As Long, b As Long
    On Error GoTo Defaut
    r = CLng("&H" & Mid$(h, 1, 2))
    g = CLng("&H" & Mid$(h, 3, 2))
    b = CLng("&H" & Mid$(h, 5, 2))
    HexVersCouleur = RGB(r, g, b)
    Exit Function
Defaut:
    HexVersCouleur = RGB(255, 235, 120)
End Function

'======================================================================
' CACHE DE STRUCTURE : reperage des titres (style Word OU numerotation)
'======================================================================
Private Sub ConstruireCacheStructure(doc As Document)
    Dim n As Long, i As Long, p As Paragraph
    Dim estTitre As Boolean, niveau As Long, norm As String, numtok As String
    n = doc.Paragraphs.Count
    pCount = n
    ReDim pPara(1 To n) : ReDim pLevel(1 To n) : ReDim pIsHead(1 To n)
    ReDim pNorm(1 To n) : ReDim pNum(1 To n)

    i = 0
    For Each p In doc.Paragraphs
        i = i + 1
        Set pPara(i) = p
        DetecterTitre p, estTitre, niveau, norm, numtok
        pIsHead(i) = estTitre
        If estTitre Then
            pLevel(i) = niveau : pNorm(i) = norm : pNum(i) = numtok
        Else
            pLevel(i) = 99 : pNorm(i) = "" : pNum(i) = ""
        End If
    Next p
End Sub

Private Sub DetecterTitre(p As Paragraph, ByRef estTitre As Boolean, _
                          ByRef niveau As Long, ByRef norm As String, _
                          ByRef numtok As String)
    Dim ol As Long, brut As String, re As Object, m As Object
    estTitre = False : niveau = 99 : norm = "" : numtok = ""

    brut = NettoyerLigne(p.Range.Text)
    If Len(brut) = 0 Then Exit Sub

    ol = p.OutlineLevel
    If ol >= wdOutlineLevel1 And ol <= wdOutlineLevel9 Then
        estTitre = True : niveau = ol : norm = NormaliserTitre(brut) : numtok = ""
        Exit Sub
    End If

    If NbMots(brut) <= 8 Then
        Set re = CreerRegex("^\s*(\d+(?:\.\d+){0,4})\.?\s+\S")
        If re.Test(brut) Then
            Set m = re.Execute(brut)(0)
            numtok = m.SubMatches(0)
            estTitre = True
            niveau = UBound(Split(numtok, ".")) + 1
            norm = NormaliserTitre(brut)
        End If
    End If
End Sub

'======================================================================
' ANNOTATION DES CHAMPS
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

Private Sub AnnoterChampText(f As Long)
    Dim kws() As String, hi As Long, fin As Long
    kws = Split(gKw(f), "|")
    hi = TrouverSection(kws, 1)
    If hi > 0 Then
        fin = FinSection(hi)
        SurlignerPlage hi, fin, gCoul(f)
        EnregistrerSpan f, hi + 1, fin
        gTrouve(f) = True
    End If
End Sub

Private Sub AnnoterChampLink(f As Long)
    Dim kws() As String, hi As Long, fin As Long, curseur As Long
    kws = Split(gKw(f), "|")
    curseur = 1
    Do
        hi = TrouverSection(kws, curseur)
        If hi = 0 Then Exit Do
        fin = FinSection(hi)
        SurlignerPlage hi, fin, gCoul(f)
        EnregistrerSpan f, hi + 1, fin
        gTrouve(f) = True
        curseur = fin + 1
    Loop
End Sub

Private Sub AnnoterChampMerge(f As Long)
    Dim kws() As String, hi As Long, fin As Long
    kws = Split(gKw(f), "|")
    hi = TrouverSection(kws, 1)
    If hi > 0 Then
        fin = FinSection(hi)
        SurlignerPlage hi, fin, gCoul(f)
        EnregistrerSpan f, hi + 1, fin
        gTrouve(f) = True
        Dim hi2 As Long, fin2 As Long
        hi2 = TrouverSection(kws, fin + 1)
        If hi2 > 0 Then
            fin2 = FinSection(hi2)
            SurlignerPlage hi2, fin2, gCoul(f)
            EnregistrerSpan f, hi2 + 1, fin2
        End If
    End If
    If InStr(1, gLabel(f), "Matiere", vbTextCompare) > 0 Then
        Dim i As Long
        For i = 1 To pCount
            If Not pIsHead(i) Then
                If Not EstExplicatif(pPara(i)) Then
                    If InStr(1, pPara(i).Range.Text, "Merge Request", vbTextCompare) > 0 Then
                        SurlignerParagraphe pPara(i), gCoul(f)
                        EnregistrerSpan f, i, i
                        gTrouve(f) = True
                    End If
                End If
            End If
        Next i
    End If
End Sub

Private Sub AnnoterChampAppendix(f As Long)
    Dim kws() As String, hi As Long, fin As Long
    Dim resync() As String
    resync = Split("resynchronisation", "|")
    hi = TrouverSection(resync, 1)
    If hi > 0 Then
        fin = FinSection(hi)
        If fin < pCount Then
            SurlignerPlage fin + 1, pCount, gCoul(f)
            EnregistrerSpan f, fin + 1, pCount
            gTrouve(f) = True
        End If
    End If
    kws = Split(gKw(f), "|")
    hi = TrouverSection(kws, 1)
    If hi > 0 Then
        fin = FinSection(hi)
        SurlignerPlage hi, fin, gCoul(f)
        EnregistrerSpan f, hi + 1, fin
        gTrouve(f) = True
    End If
End Sub

Private Sub EnregistrerSpan(f As Long, debut As Long, fin As Long)
    If fin >= debut And debut >= 1 And fin <= pCount Then gSpans(f).Add Array(debut, fin)
End Sub

'======================================================================
' IDENTIFIANTS (categorie "ident") : n# de solution, Auteur, Responsable
'======================================================================
Private Sub AnnoterIdentifiants(doc As Document)
    Dim i As Long, txt As String, borne As Long
    Dim reSol As Object
    Set reSol = CreerRegex("(^|[^A-Za-z0-9])S\d{4,6}([^0-9]|$)")

    borne = pCount
    If borne > 80 Then borne = 80

    Dim solTrouve As Boolean, auteurTrouve As Boolean, respTrouve As Boolean
    For i = 1 To borne
        If Not pIsHead(i) Then
            txt = pPara(i).Range.Text
            If Not solTrouve Then
                If reSol.Test(txt) Then
                    SurlignerParagraphe pPara(i), gIdentCoul
                    gIdentSpans.Add Array(i, i)
                    solTrouve = True
                End If
            End If
            If Not auteurTrouve Then
                If CommencePar(txt, "auteur") Then
                    SurlignerParagraphe pPara(i), gIdentCoul
                    gIdentSpans.Add Array(i, i)
                    auteurTrouve = True
                End If
            End If
            If Not respTrouve Then
                If CommencePar(txt, "responsable") Or CommencePar(txt, "service") Then
                    SurlignerParagraphe pPara(i), gIdentCoul
                    gIdentSpans.Add Array(i, i)
                    respTrouve = True
                End If
            End If
        End If
    Next i
End Sub

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
Private Function TrouverSection(kws() As String, startAfter As Long) As Long
    Dim i As Long
    If startAfter < 1 Then startAfter = 1
    For i = startAfter To pCount
        If pIsHead(i) Then
            If TitreCorrespond(pNorm(i), kws) Then TrouverSection = i : Exit Function
        End If
    Next i
    TrouverSection = 0
End Function

' Fin (index inclus du dernier paragraphe de la section).
'  - Titre numerote : jusqu'au prochain titre qui n'est pas un sous-numero
'    du courant ("6" inclut "6.1" ; "11" s'arrete avant "12.2").
'  - Titre de style Word : jusqu'au prochain titre de niveau de plan <=.
Private Function FinSection(hi As Long) As Long
    Dim j As Long
    If Len(pNum(hi)) > 0 Then
        For j = hi + 1 To pCount
            If pIsHead(j) Then
                If Len(pNum(j)) = 0 Then
                    FinSection = j - 1 : Exit Function
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
                If pLevel(j) <= niveau Then FinSection = j - 1 : Exit Function
            End If
        Next j
    End If
    FinSection = pCount
End Function

Private Function EstDescendant(enfant As String, parent As String) As Boolean
    If enfant = parent Then Exit Function
    EstDescendant = (Left$(enfant, Len(parent) + 1) = parent & ".")
End Function

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
Private Sub SurlignerPlage(debut As Long, fin As Long, coul As Long)
    Dim i As Long
    If debut < 1 Then debut = 1
    If fin > pCount Then fin = pCount
    For i = debut To fin
        If Not EstExplicatif(pPara(i)) Then SurlignerParagraphe pPara(i), coul
    Next i
End Sub

Private Sub SurlignerParagraphe(p As Paragraph, coul As Long)
    Dim rng As Range
    Set rng = p.Range
    If EstVidePourSurlignage(rng) Then Exit Sub   ' vide / marqueur de tableau (erreur 4605)
    On Error Resume Next
    rng.Shading.BackgroundPatternColor = coul
    On Error GoTo 0
End Sub

Private Function EstVidePourSurlignage(rng As Range) As Boolean
    Dim t As String
    t = rng.Text
    t = Replace(t, Chr$(7), "")
    t = Replace(t, vbCr, "")
    t = Replace(t, vbLf, "")
    t = Replace(t, Chr$(11), "")
    EstVidePourSurlignage = (Len(Trim$(t)) = 0)
End Function

Private Function EstExplicatif(p As Paragraph) As Boolean
    Dim rng As Range
    Set rng = p.Range
    If EstVidePourSurlignage(rng) Then Exit Function
    If rng.Italic <> True Then Exit Function
    Dim c As Long
    c = rng.Font.Color
    If c = wdColorAutomatic Then Exit Function
    If c = wdColorBlack Or c = RGB(0, 0, 0) Then Exit Function
    If c = wdUndefined Then Exit Function
    EstExplicatif = True
End Function

'======================================================================
' LEGENDE (en tete) : Couleur | Categorie | Champs | Contenu du document
'======================================================================
Private Sub InsererLegende(doc As Document)
    Dim r As Range, t As Table

    Set r = doc.Range(0, 0)
    r.InsertBefore "LEGENDE — Copie annotee pour reprise CAST'IN " & _
                   "(le DEX source n'est pas modifie)" & vbCr & vbCr
    r.Font.Bold = True
    r.Font.Size = 12

    Set r = doc.Paragraphs(2).Range
    Set t = doc.Tables.Add(r, gNbCat + 1, 4)
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

    Dim c As Long
    For c = 1 To gNbCat
        On Error Resume Next
        t.Cell(c + 1, 1).Shading.BackgroundPatternColor = gCatCoul(c)
        On Error GoTo 0
        t.Cell(c + 1, 2).Range.Text = gCatLabel(c)
        t.Cell(c + 1, 3).Range.Text = ChampsDeCategorie(gCatKey(c))
        RemplirContenu doc, t.Cell(c + 1, 4), gCatKey(c)
    Next c

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

' Liste des libelles de champs d'une categorie (colonne "Champs").
Private Function ChampsDeCategorie(cleCat As String) As String
    Dim f As Long, acc As String
    For f = 1 To gNbChamps
        If gCatOf(f) = LCase$(cleCat) Then
            If Len(acc) > 0 Then acc = acc & ", "
            acc = acc & gLabel(f)
        End If
    Next f
    If Len(acc) = 0 And LCase$(cleCat) = "ident" Then
        acc = "N# de solution, Auteur, Responsable"
    End If
    ChampsDeCategorie = acc
End Function

' Spans de contenu reperes pour une categorie (champs + identifiants).
Private Function SpansDeCategorie(cleCat As String) As Collection
    Dim res As New Collection, f As Long, k As Long
    If LCase$(cleCat) = "ident" Then
        For k = 1 To gIdentSpans.Count
            res.Add gIdentSpans(k)
        Next k
    End If
    For f = 1 To gNbChamps
        If gCatOf(f) = LCase$(cleCat) Then
            For k = 1 To gSpans(f).Count
                res.Add gSpans(f)(k)
            Next k
        End If
    Next f
    Set SpansDeCategorie = res
End Function

' Remplit la cellule "Contenu" : texte (tableaux restitues ligne par ligne)
' + miniatures des images des sections reperees.
Private Sub RemplirContenu(doc As Document, cell As Cell, cleCat As String)
    Dim spans As Collection, k As Long, arr, a As Long, b As Long, acc As String
    Set spans = SpansDeCategorie(cleCat)

    If spans.Count = 0 Then
        cell.Range.Text = "(aucune section reperee)"
        Exit Sub
    End If

    For k = 1 To spans.Count
        arr = spans(k) : a = arr(0) : b = arr(1)
        Dim bloc As String
        bloc = TexteContenu(a, b)
        If Len(bloc) > 0 Then
            If Len(acc) > 0 Then acc = acc & vbCr
            acc = acc & bloc
        End If
    Next k
    If Len(acc) = 0 Then acc = "(aucune section reperee)"

    On Error Resume Next
    cell.Range.Text = acc
    CollerMiniatures cell, spans
    On Error GoTo 0
End Sub

' Texte d'un span : paragraphes + tableaux restitues ligne par ligne.
Private Function TexteContenu(debut As Long, fin As Long) As String
    Dim i As Long, acc As String, p As Paragraph, t As String, tb As Table
    If debut < 1 Then debut = 1
    If fin > pCount Then fin = pCount
    i = debut
    Do While i <= fin
        Set p = pPara(i)
        If EnTableau(p) Then
            Set tb = Nothing
            On Error Resume Next
            Set tb = p.Range.Tables(1)
            On Error GoTo 0
            If Not tb Is Nothing Then
                acc = acc & RendreTable(tb)
                Do While i <= fin
                    If Not EnMemeTable(pPara(i), tb) Then Exit Do
                    i = i + 1
                Loop
            Else
                i = i + 1
            End If
        Else
            If Not pIsHead(i) And Not EstExplicatif(p) Then
                t = NettoyerLigne(p.Range.Text)
                If Len(t) > 0 Then acc = acc & t & vbCr
            End If
            i = i + 1
        End If
    Loop
    Do While Len(acc) > 0 And (Right$(acc, 1) = vbCr Or Right$(acc, 1) = vbLf)
        acc = Left$(acc, Len(acc) - 1)
    Loop
    TexteContenu = acc
End Function

Private Function RendreTable(tb As Table) As String
    Dim ro As Row, ce As Cell, ligne As String, acc As String, txt As String
    For Each ro In tb.Rows
        ligne = ""
        On Error Resume Next
        For Each ce In ro.Cells
            txt = NettoyerLigne(ce.Range.Text)
            If Len(ligne) = 0 Then ligne = txt Else ligne = ligne & " | " & txt
        Next ce
        On Error GoTo 0
        acc = acc & ligne & vbCr
    Next ro
    RendreTable = acc
End Function

Private Function EnTableau(p As Paragraph) As Boolean
    On Error Resume Next
    EnTableau = p.Range.Information(wdWithInTable)
    On Error GoTo 0
End Function

Private Function EnMemeTable(p As Paragraph, tb As Table) As Boolean
    Dim t As Table
    On Error Resume Next
    If p.Range.Information(wdWithInTable) Then
        Set t = p.Range.Tables(1)
        If Not t Is Nothing Then EnMemeTable = (t.Range.Start = tb.Range.Start)
    End If
    On Error GoTo 0
End Function

' Colle, en fin de cellule, une miniature pour chaque image des sections.
Private Sub CollerMiniatures(cell As Cell, spans As Collection)
    Dim k As Long, arr, a As Long, b As Long, i As Long, shp As InlineShape, dest As Range
    For k = 1 To spans.Count
        arr = spans(k) : a = arr(0) : b = arr(1)
        For i = a To b
            If i >= 1 And i <= pCount Then
                For Each shp In pPara(i).Range.InlineShapes
                    On Error Resume Next
                    shp.Range.Copy
                    Set dest = cell.Range
                    If dest.End - 1 >= dest.Start Then dest.End = dest.End - 1
                    dest.Collapse wdCollapseEnd
                    dest.InsertParagraphAfter
                    dest.Collapse wdCollapseEnd
                    dest.Paste
                    On Error GoTo 0
                Next shp
            End If
        Next i
    Next k
    ReduireImages cell
End Sub

Private Sub ReduireImages(cell As Cell)
    Dim shp As InlineShape
    On Error Resume Next
    For Each shp In cell.Range.InlineShapes
        shp.LockAspectRatio = msoTrue
        If shp.Height > 48 Then shp.Height = 48
    Next shp
    On Error GoTo 0
End Sub

'======================================================================
' NORMALISATION / OUTILS TEXTE
'======================================================================
Private Function NormaliserTitre(ByVal s As String) As String
    Dim re As Object
    s = NettoyerLigne(s)
    Set re = CreerRegex("^\s*([0-9]+\.)*[0-9]+[.\)\-\s]*")
    s = re.Replace(s, "")
    s = LCase$(SansAccents(s))
    Set re = CreerRegex("[^a-z0-9 ]+")
    s = re.Replace(s, " ")
    Set re = CreerRegex("\s+")
    s = re.Replace(s, " ")
    NormaliserTitre = Trim$(s)
End Function

Private Function NettoyerLigne(ByVal s As String) As String
    Dim re As Object
    s = Replace(s, vbCr, " ")
    s = Replace(s, vbLf, " ")
    s = Replace(s, Chr$(7), " ")
    s = Replace(s, Chr$(11), " ")
    s = Replace(s, Chr$(160), " ")
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
