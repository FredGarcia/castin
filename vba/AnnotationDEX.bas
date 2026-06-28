'======================================================================
' AnnotationDEX.bas — Surlignage des champs CAST'IN dans un DEX Word
'----------------------------------------------------------------------
' Produit une COPIE ANNOTEE (<nom>_ANNOTE.docx) d'un DEX .docx ou chaque
' passage destine a un champ CAST'IN est surligne dans la couleur DE CE
' CHAMP. But : copier-coller manuel vers CAST'IN plus rapide et plus sur.
' Le DEX SOURCE N'EST JAMAIS MODIFIE (travail sur une copie disque).
'
' CONFIGURATION : fichier "AnnotationDEX.config.ini" (a cote du DEX, ou
' chemin CONFIG_CHEMIN ci-dessous). Absent -> valeurs par defaut integrees.
'   [couleurs]   teintes de base (hexa RRGGBB)
'   [categories] libelles des categories (colonne "Categorie")
'   [champs]     Libelle = categorie | couleur | type | mots-cles(; )
'                couleur = "<teinte> <nuance 1..9>" (clair->fonce) ou hexa
'                type = text | link | merge | appendix
'                       | idsolution | idauteur | idresponsable
'
' REPERAGE (regle 1, par NOM) : titres retrouves par leur texte normalise
' (numerotation/accents/casse/ponctuation ignores). Un paragraphe est un
' titre s'il a un style de titre Word OU s'il commence par une numerotation
' de chapitre ("2.1 ...", "6 ..."). Encarts d'aide (italique+couleur)
' ecartes (regle 2). Tableaux et images des sections reperees inclus.
'======================================================================

Option Explicit

Private Const CONFIG_CHEMIN As String = ""
Private Const CONFIG_NOM As String = "AnnotationDEX.config.ini"

' --- Teintes de base (cle -> Long RGB) -------------------------------
Private gDictCoul As Object

' --- Categories ------------------------------------------------------
Private gCatKey()   As String
Private gCatLabel() As String
Private gNbCat      As Long

' --- Champs ----------------------------------------------------------
Private gLabel()  As String
Private gCatOf()  As String
Private gTerm()   As String         ' terme de couleur ("jaune 2", hexa...)
Private gKind()   As String         ' text|link|merge|appendix|idsolution|idauteur|idresponsable
Private gKw()     As String         ' mots-cles normalises, separes par "|"
Private gCoul()   As Long           ' couleur resolue du champ
Private gTrouve() As Boolean
Private gSpans()  As Collection     ' spans de contenu [debut, fin]
Private gNbChamps As Long

' --- Caches de la structure du document ------------------------------
Private pPara()   As Paragraph
Private pLevel()  As Long
Private pIsHead() As Boolean
Private pNorm()   As String
Private pNum()    As String
Private pCount    As Long

Private gSourceConfig As String

'======================================================================
' POINT D'ENTREE
'======================================================================
Public Sub AnnoterDEX()
    Dim src As Document, ann As Document, fso As Object
    Dim cheminSrc As String, cheminAnn As String, dossier As String, base As String

    On Error GoTo Echec

    If Documents.Count = 0 Then
        MsgBox "Aucun document ouvert. Ouvrez d'abord le DEX a annoter.", vbExclamation
        Exit Sub
    End If

    Set src = ActiveDocument
    cheminSrc = src.FullName
    If src.Path = "" Then
        MsgBox "Le DEX doit d'abord etre enregistre sur le disque.", vbExclamation
        Exit Sub
    End If
    If Not src.Saved Then
        If MsgBox("Modifications non enregistrees : la copie annotee partira de la " & _
                  "derniere version enregistree. Continuer ?", vbQuestion + vbYesNo) = vbNo Then Exit Sub
    End If

    dossier = src.Path
    base = src.Name
    If InStrRev(base, ".") > 0 Then base = Left$(base, InStrRev(base, ".") - 1)
    cheminAnn = dossier & Application.PathSeparator & base & "_ANNOTE.docx"

    Set fso = CreateObject("Scripting.FileSystemObject")
    If fso.FileExists(cheminAnn) Then
        If MsgBox("Remplacer le fichier existant ?" & vbCrLf & cheminAnn, vbQuestion + vbYesNo) = vbNo Then Exit Sub
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
' CONFIGURATION
'======================================================================
Private Sub ChargerConfig(dossierDoc As String)
    Dim fso As Object, chemin As String, cand As String
    Set fso = CreateObject("Scripting.FileSystemObject")

    chemin = ""
    If Len(CONFIG_CHEMIN) > 0 Then
        If fso.FileExists(CONFIG_CHEMIN) Then chemin = CONFIG_CHEMIN
    End If
    If Len(chemin) = 0 Then
        cand = dossierDoc & Application.PathSeparator & CONFIG_NOM
        If fso.FileExists(cand) Then chemin = cand
    End If

    InitStructuresVides
    If Len(chemin) > 0 Then
        ParseIni chemin
        gSourceConfig = chemin
    End If
    If gNbChamps = 0 Or gNbCat = 0 Or gDictCoul.Count = 0 Then
        InitStructuresVides
        ChargerDefauts
        gSourceConfig = "valeurs par defaut integrees"
    End If

    ResoudreCouleurs
End Sub

Private Sub InitStructuresVides()
    Set gDictCoul = CreateObject("Scripting.Dictionary")
    gDictCoul.CompareMode = 1
    gNbCat = 0 : gNbChamps = 0
    ReDim gCatKey(1 To 40) : ReDim gCatLabel(1 To 40)
    ReDim gLabel(1 To 60) : ReDim gCatOf(1 To 60) : ReDim gTerm(1 To 60)
    ReDim gKind(1 To 60) : ReDim gKw(1 To 60) : ReDim gCoul(1 To 60)
    ReDim gTrouve(1 To 60) : ReDim gSpans(1 To 60)
End Sub

Private Sub ParseIni(chemin As String)
    Dim contenu As String, lignes() As String, ln As String, sect As String
    Dim i As Long, pos As Long, k As String, v As String, parts() As String, kw As String

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
                            AjouterCategorie k, Trim$(parts(0))
                        Case "champs"
                            parts = Split(v, "|")
                            If UBound(parts) >= 2 Then
                                If UBound(parts) >= 3 Then kw = NormaliserMotsCles(parts(3)) Else kw = ""
                                AjouterChamp k, LCase$(Trim$(parts(0))), Trim$(parts(1)), _
                                             LCase$(Trim$(parts(2))), kw
                            End If
                    End Select
                End If
            End If
        End If
    Next i
End Sub

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

Private Sub AjouterCategorie(cle As String, libelle As String)
    gNbCat = gNbCat + 1
    gCatKey(gNbCat) = LCase$(cle)
    gCatLabel(gNbCat) = libelle
End Sub

Private Sub AjouterChamp(libelle As String, cleCat As String, terme As String, _
                         kind As String, kw As String)
    gNbChamps = gNbChamps + 1
    gLabel(gNbChamps) = libelle
    gCatOf(gNbChamps) = cleCat
    gTerm(gNbChamps) = terme
    gKind(gNbChamps) = kind
    gKw(gNbChamps) = kw
    gTrouve(gNbChamps) = False
    Set gSpans(gNbChamps) = New Collection
End Sub

Private Sub ResoudreCouleurs()
    Dim i As Long
    For i = 1 To gNbChamps
        gCoul(i) = CouleurDepuisTerme(gTerm(i))
    Next i
End Sub

Private Function CatLabel(cleCat As String) As String
    Dim i As Long
    For i = 1 To gNbCat
        If gCatKey(i) = LCase$(cleCat) Then CatLabel = gCatLabel(i) : Exit Function
    Next i
    CatLabel = cleCat
End Function

Private Sub ChargerDefauts()
    gDictCoul("rouge") = HexVersCouleur("E53935")
    gDictCoul("orange") = HexVersCouleur("FB8C00")
    gDictCoul("jaune") = HexVersCouleur("FDD835")
    gDictCoul("vert") = HexVersCouleur("7CB342")
    gDictCoul("bleu") = HexVersCouleur("1E88E5")
    gDictCoul("indigo") = HexVersCouleur("5C6BC0")

    AjouterCategorie "ident", "Identifiants"
    AjouterCategorie "desc", "Description detaillee"
    AjouterCategorie "expl", "Exploitation courante"
    AjouterCategorie "secu", "Securite / acces"
    AjouterCategorie "flux", "Echanges / livraison"
    AjouterCategorie "reprise", "Reprise / annexes"

    AjouterChamp "Numero de solution", "ident", "rouge 2", "idsolution", ""
    AjouterChamp "Auteur", "ident", "rouge 4", "idauteur", ""
    AjouterChamp "Responsable", "ident", "rouge 6", "idresponsable", ""
    AjouterChamp "Lien Dossier Archi (DAP...)", "desc", "orange 2", "link", "architecture fonctionnelle applicative"
    AjouterChamp "Schema Applicatif (ADU...)", "desc", "orange 3", "link", "architecture fonctionnelle applicative|description de la solution|description fonctionnelle"
    AjouterChamp "Description Fonctionnelle", "desc", "orange 4", "text", "description de la solution|description fonctionnelle"
    AjouterChamp "Donnees de la solution", "desc", "orange 5", "text", "donnees"
    AjouterChamp "Description Technique", "desc", "orange 6", "text", "architecture technique"
    AjouterChamp "Plage de fonctionnement / maintenance", "expl", "jaune 2", "text", "plage de fonctionnement|plages de fonctionnement"
    AjouterChamp "Supervision", "expl", "jaune 3", "text", "supervision"
    AjouterChamp "Observabilite", "expl", "jaune 4", "text", "metrologie"
    AjouterChamp "Log", "expl", "jaune 5", "text", "diagnostic|diagnostique|log|trace"
    AjouterChamp "Sauvegardes", "expl", "jaune 6", "text", "sauvegarde"
    AjouterChamp "Servitudes et ordonnancements", "secu", "vert 2", "text", "servitude"
    AjouterChamp "Comptes et services", "secu", "vert 3", "text", "compte de service|comptes de service"
    AjouterChamp "Certificats", "secu", "vert 4", "text", "certificat"
    AjouterChamp "Liste blanche", "secu", "vert 5", "text", "liste blanche|whitelist"
    AjouterChamp "Flux", "flux", "bleu 2", "text", "flux et interdependance|flux et interdependances"
    AjouterChamp "Support", "flux", "bleu 3", "text", "matrice de responsabilite|matrice des responsabilites|raci"
    AjouterChamp "Changement et MEP", "flux", "bleu 4", "merge", "controle des operations|changements et mep|changement et mep"
    AjouterChamp "Matiere (repo)", "flux", "bleu 5", "merge", "referentiel|repository|depot de code|matiere"
    AjouterChamp "Procedure de restauration", "reprise", "indigo 2", "text", "restauration"
    AjouterChamp "Procedure de reconstruction", "reprise", "indigo 3", "text", "reconstruction"
    AjouterChamp "Procedure de resynchronisation", "reprise", "indigo 4", "text", "resynchronisation"
    AjouterChamp "Informations supplementaires", "reprise", "indigo 5", "appendix", "assets mainframe"
End Sub

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
    If Not IsHex6(h) Then HexVersCouleur = RGB(253, 216, 53) : Exit Function
    Dim r As Long, g As Long, b As Long
    r = CLng("&H" & Mid$(h, 1, 2))
    g = CLng("&H" & Mid$(h, 3, 2))
    b = CLng("&H" & Mid$(h, 5, 2))
    HexVersCouleur = RGB(r, g, b)
End Function

Private Function IsHex6(ByVal s As String) As Boolean
    s = Trim$(s)
    If Len(s) <> 6 Then Exit Function
    Dim i As Long, c As String
    For i = 1 To 6
        c = LCase$(Mid$(s, i, 1))
        If InStr("0123456789abcdef", c) = 0 Then Exit Function
    Next i
    IsHex6 = True
End Function

' --- Couleur d'un champ a partir d'un terme "<teinte> <nuance>" -------
Private Function CouleurDepuisTerme(ByVal terme As String) As Long
    terme = Trim$(Replace(terme, "-", " "))
    If IsHex6(terme) Then CouleurDepuisTerme = HexVersCouleur(terme) : Exit Function

    Dim toks() As String, base As String, reste As String, i As Long, shade As Long, baseLong As Long
    toks = Split(terme, " ")
    base = LCase$(Trim$(toks(0)))
    reste = ""
    For i = 1 To UBound(toks)
        If Len(Trim$(toks(i))) > 0 Then reste = Trim$(reste & " " & toks(i))
    Next i
    shade = ShadeDepuisTexte(reste)

    If gDictCoul.Exists(base) Then baseLong = gDictCoul(base) Else baseLong = RGB(253, 216, 53)
    CouleurDepuisTerme = AppliquerNuance(baseLong, shade)
End Function

Private Function ShadeDepuisTexte(ByVal reste As String) As Long
    reste = LCase$(SansAccents(Trim$(reste)))
    If Len(reste) = 0 Then ShadeDepuisTexte = 5 : Exit Function
    If IsNumeric(reste) Then
        Dim n As Long : n = CLng(reste)
        If n < 1 Then n = 1
        If n > 9 Then n = 9
        ShadeDepuisTexte = n : Exit Function
    End If
    If InStr(reste, "tres clair") > 0 Then
        ShadeDepuisTexte = 2
    ElseIf InStr(reste, "clair") > 0 Then
        ShadeDepuisTexte = 3
    ElseIf InStr(reste, "tres fonce") > 0 Then
        ShadeDepuisTexte = 9
    ElseIf InStr(reste, "fonce") > 0 Then
        ShadeDepuisTexte = 7
    ElseIf InStr(reste, "moyen") > 0 Then
        ShadeDepuisTexte = 5
    Else
        ShadeDepuisTexte = 5
    End If
End Function

' Nuance 1 (tres clair) .. 5 (base) .. 9 (tres fonce).
Private Function AppliquerNuance(c As Long, shade As Long) As Long
    Dim r As Long, g As Long, b As Long, t As Double
    r = c And 255
    g = (c \ 256) And 255
    b = (c \ 65536) And 255
    If shade < 5 Then
        t = (5 - shade) / 4 * 0.75            ' melange vers le blanc
        r = r + (255 - r) * t : g = g + (255 - g) * t : b = b + (255 - b) * t
    ElseIf shade > 5 Then
        t = (shade - 5) / 4 * 0.55            ' melange vers le noir
        r = r * (1 - t) : g = g * (1 - t) : b = b * (1 - t)
    End If
    AppliquerNuance = RGB(CLng(r), CLng(g), CLng(b))
End Function

'======================================================================
' CACHE DE STRUCTURE : titres (style Word OU numerotation)
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
            Case "text":          AnnoterChampText f
            Case "link":          AnnoterChampLink f
            Case "merge":         AnnoterChampMerge f
            Case "appendix":      AnnoterChampAppendix f
            Case "idsolution":    AnnoterIdentifiant f, "solution"
            Case "idauteur":      AnnoterIdentifiant f, "auteur"
            Case "idresponsable": AnnoterIdentifiant f, "responsable"
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
    Dim kws() As String, hi As Long, fin As Long, hi2 As Long, fin2 As Long, i As Long
    kws = Split(gKw(f), "|")
    hi = TrouverSection(kws, 1)
    If hi > 0 Then
        fin = FinSection(hi)
        SurlignerPlage hi, fin, gCoul(f)
        EnregistrerSpan f, hi + 1, fin
        gTrouve(f) = True
        hi2 = TrouverSection(kws, fin + 1)
        If hi2 > 0 Then
            fin2 = FinSection(hi2)
            SurlignerPlage hi2, fin2, gCoul(f)
            EnregistrerSpan f, hi2 + 1, fin2
        End If
    End If
    If InStr(1, gLabel(f), "Matiere", vbTextCompare) > 0 Then
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
    Dim kws() As String, hi As Long, fin As Long, resync() As String
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

' Identifiants : 1er paragraphe correspondant dans les 80 premiers.
Private Sub AnnoterIdentifiant(f As Long, quoi As String)
    Dim i As Long, borne As Long, txt As String, ok As Boolean
    Dim reSol As Object
    borne = pCount : If borne > 80 Then borne = 80
    If quoi = "solution" Then Set reSol = CreerRegex("(^|[^A-Za-z0-9])S\d{4,6}([^0-9]|$)")

    For i = 1 To borne
        If Not pIsHead(i) Then
            txt = pPara(i).Range.Text
            ok = False
            Select Case quoi
                Case "solution":    ok = reSol.Test(txt)
                Case "auteur":      ok = CommencePar(txt, "auteur")
                Case "responsable": ok = CommencePar(txt, "responsable") Or CommencePar(txt, "service")
            End Select
            If ok Then
                SurlignerParagraphe pPara(i), gCoul(f)
                EnregistrerSpan f, i, i
                gTrouve(f) = True
                Exit Sub
            End If
        End If
    Next i
End Sub

Private Sub EnregistrerSpan(f As Long, debut As Long, fin As Long)
    If fin >= debut And debut >= 1 And fin <= pCount Then gSpans(f).Add Array(debut, fin)
End Sub

Private Function CommencePar(txt As String, etiquette As String) As Boolean
    Dim s As String, suite As String
    s = LCase$(Trim$(SansAccents(txt)))
    If Left$(s, Len(etiquette)) = etiquette Then
        suite = Trim$(Mid$(s, Len(etiquette) + 1))
        If Left$(suite, 1) = ":" Or Left$(suite, 1) = vbTab Or InStr(txt, vbTab) > 0 Then CommencePar = True
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

Private Function FinSection(hi As Long) As Long
    Dim j As Long, niveau As Long
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
    If EstVidePourSurlignage(rng) Then Exit Sub   ' marqueur de tableau (erreur 4605)
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
    Dim rng As Range, c As Long
    Set rng = p.Range
    If EstVidePourSurlignage(rng) Then Exit Function
    If rng.Italic <> True Then Exit Function
    c = rng.Font.Color
    If c = wdColorAutomatic Then Exit Function
    If c = wdColorBlack Or c = RGB(0, 0, 0) Then Exit Function
    If c = wdUndefined Then Exit Function
    EstExplicatif = True
End Function

'======================================================================
' LEGENDE : une ligne PAR CHAMP -> Couleur | Categorie | Champ | Contenu
'======================================================================
Private Sub InsererLegende(doc As Document)
    Dim r As Range, t As Table, f As Long

    Set r = doc.Range(0, 0)
    r.InsertBefore "LEGENDE — Copie annotee pour reprise CAST'IN " & _
                   "(le DEX source n'est pas modifie)" & vbCr & vbCr
    r.Font.Bold = True
    r.Font.Size = 12

    Set r = doc.Paragraphs(2).Range
    Set t = doc.Tables.Add(r, gNbChamps + 1, 4)
    t.Borders.Enable = True
    t.AllowAutoFit = True
    t.PreferredWidthType = wdPreferredWidthPercent
    t.Columns(1).PreferredWidth = 7
    t.Columns(2).PreferredWidth = 17
    t.Columns(3).PreferredWidth = 24
    t.Columns(4).PreferredWidth = 52

    t.Cell(1, 1).Range.Text = "Couleur"
    t.Cell(1, 2).Range.Text = "Categorie"
    t.Cell(1, 3).Range.Text = "Champ"
    t.Cell(1, 4).Range.Text = "Contenu repere dans ce document"
    t.Rows(1).Range.Font.Bold = True

    For f = 1 To gNbChamps
        On Error Resume Next
        t.Cell(f + 1, 1).Shading.BackgroundPatternColor = gCoul(f)
        On Error GoTo 0
        t.Cell(f + 1, 2).Range.Text = CatLabel(gCatOf(f))
        t.Cell(f + 1, 3).Range.Text = gLabel(f)
        RemplirContenuChamp doc, t.Cell(f + 1, 4), f
    Next f

    ' Points a verifier : champs non reperes
    Dim manque As String
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
            "(non reperes automatiquement) :" & vbCr & manque
    Else
        rFin.InsertAfter vbCr & "Points a verifier aupres de l'Equipier Ops : RAS." & vbCr
    End If
    rFin.InsertAfter vbCr
End Sub

' Colle le contenu repere du champ dans la cellule, en REDUIT (tableaux
' et images compris), pour un recapitulatif compact.
Private Sub RemplirContenuChamp(doc As Document, cell As Cell, f As Long)
    Dim k As Long, arr, a As Long, b As Long, src As Range, dest As Range, colle As Boolean
    VideCellule cell
    If gSpans(f).Count = 0 Then
        cell.Range.Text = "(non repere)"
        Exit Sub
    End If

    colle = False
    For k = 1 To gSpans(f).Count
        arr = gSpans(f)(k) : a = arr(0) : b = arr(1)
        If a >= 1 And b <= pCount And b >= a Then
            Set src = doc.Range(pPara(a).Range.Start, pPara(b).Range.End)
            On Error Resume Next
            Set dest = FinCellule(cell)
            If colle Then dest.InsertParagraphAfter : Set dest = FinCellule(cell)
            src.Copy
            Err.Clear
            dest.Paste
            If Err.Number <> 0 Then
                Err.Clear
                Set dest = FinCellule(cell)
                dest.InsertAfter NettoyerLigne(src.Text)
            End If
            On Error GoTo 0
            colle = True
        End If
    Next k

    If Not colle Then cell.Range.Text = "(non repere)" : Exit Sub
    RetaillerContenu cell
End Sub

Private Function FinCellule(cell As Cell) As Range
    Dim r As Range
    Set r = cell.Range
    If r.End - 1 >= r.Start Then r.End = r.End - 1
    r.Collapse wdCollapseEnd
    Set FinCellule = r
End Function

Private Sub VideCellule(cell As Cell)
    Dim r As Range
    Set r = cell.Range
    If r.End - 1 >= r.Start Then r.End = r.End - 1
    r.Delete
End Sub

' Reduit le contenu colle : petite police, tableaux ajustes, miniatures.
Private Sub RetaillerContenu(cell As Cell)
    Dim tb As Table, shp As InlineShape
    On Error Resume Next
    cell.Range.Font.Size = 7
    cell.Range.ParagraphFormat.SpaceAfter = 0
    For Each tb In cell.Range.Tables
        tb.AutoFitBehavior wdAutoFitWindow
        tb.Range.Font.Size = 7
    Next tb
    For Each shp In cell.Range.InlineShapes
        shp.LockAspectRatio = msoTrue
        If shp.Height > 36 Then shp.Height = 36
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
