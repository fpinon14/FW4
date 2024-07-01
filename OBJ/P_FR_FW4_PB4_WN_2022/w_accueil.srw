HA$PBExportHeader$w_accueil.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'acceuil
forward
global type w_accueil from w_ancetre
end type
type pb_retour from u_pbretour within w_accueil
end type
type pb_interro from u_pbinterro within w_accueil
end type
type pb_creer from u_pbcreer within w_accueil
end type
type dw_1 from u_datawindow_accueil within w_accueil
end type
type pb_tri from u_pbtrier within w_accueil
end type
type pb_imprimer from u_pbimprimer within w_accueil
end type
end forward

global type w_accueil from w_ancetre
integer width = 2313
integer height = 1540
boolean titlebar = true
string title = "Fen$$HEX1$$ea00$$ENDHEX$$tre d~'accueil"
string menuname = "m_main"
boolean controlmenu = true
boolean resizable = true
windowtype windowtype = main!
pb_retour pb_retour
pb_interro pb_interro
pb_creer pb_creer
dw_1 dw_1
pb_tri pb_tri
pb_imprimer pb_imprimer
end type
global w_accueil w_accueil

type variables
String             isImportTri

Protected :
    String         isTitreLst
    String         isListePart = ""

    String         isClauseFrancais = ""


end variables

forward prototypes
public function long wf_construire_chaine_tri ()
protected subroutine wf_trtlstedt (ref string asval[])
private subroutine wf_lst_simple ()
private subroutine wf_lst_particuliere ()
end prototypes

public function long wf_construire_chaine_tri ();//*******************************************************************************************
// Fonction            	: wf_Construire_Chaine_Tri
//	Auteur              	: Erick John Stark
//	Date 					 	: 22/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Construction de la chaine d'import pour le Tri
//
// Arguments				: 
//
// Retourne					: Long	
//								  
//*******************************************************************************************

String sTab, sNew, sImport
Long lCpt, lNbrCol, lRet

sTab			= "~t"
sNew			= "~r~n"

lRet			= 1
lNbrCol 		= UpperBound ( dw_1.istCol )

If	lNbrCol > 0 Then
	
	For	lCpt = 1 To lNbrCol
			If	dw_1.istCol[ lCpt ].sInvisible = "O" Then
				Continue

			Else

				sImport = sImport												+ &
							 dw_1.istCol[ lCpt ].sHeaderName	+ sTab	+ &
							 String ( lCpt )						+ sTab	+ &
							 dw_1.istCol[ lCpt ].sDbName		+ sNew
			End If
	Next

End If

isImportTri = sImport

Return ( lRet )
end function

protected subroutine wf_trtlstedt (ref string asval[]);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_TrtLstEdt ( Protected )
//* Auteur			: Erick John Stark
//* Date				: 19/01/1997 17:17:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Traitement sp$$HEX1$$e900$$ENDHEX$$cifique pour les colonnes $$HEX3$$e0002000e900$$ENDHEX$$diter
//*
//* Arguments		: String			asVal[]			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau des valeurs $$HEX2$$e0002000$$ENDHEX$$traiter
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Il est possible d'ajouter des lignes au tableau                  */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Exemple de transformation d'une colonne (Data Value -> Display   */
/* Value)                                                           */
/* Cette colonne est la 8$$HEX1$$e900$$ENDHEX$$me du Tableau                             */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Transformation du Code Etat                                      */
/*------------------------------------------------------------------*/

//Choose Case asVal[8]
//Case "1"
//	asVal[8] = "Saisie"
//
//Case "3"
//	asVal[8] = "Edition"
//
//Case "5"
//	asVal[8] = "Validation"
//
//End Choose

/*------------------------------------------------------------------*/
/* Exemple de transformation d'une colonne en deux                  */
/* Ne pas oublier l'en-t$$HEX1$$ea00$$ENDHEX$$te de colonne.                             */
/* Ne pas oublier de modifier le fichier LISTE.INI                  */
/*------------------------------------------------------------------*/


/*------------------------------------------------------------------*/
/* Transformation de Ets en deux colonnes                           */
/*------------------------------------------------------------------*/

//lTot = UpperBound ( asVal )
//
//For	lCpt = lTot + 1 To 5 Step -1
//		asVal[ lCpt ] = asVal[ lCpt - 1 ]
//Next
//
//Choose Case Left ( asVal[ 4 ], 2 )
//Case "Co"
//// On modifie le Fichier LISTE.INI
//
//	SetProfileString ( "C:\WINNT\TEMP\LISTE.INI", "Liste", "Col", String ( lTot + 1 ) )
//	asVal[ 4 ] = "Type Pr$$HEX1$$ea00$$ENDHEX$$t"
//	asVal[ 5 ] = "Ets"
//
//Case "62"
//	asVal[ 4 ] = "Personnel"
//	asVal[ 5 ] = Right ( asVal[ 5 ], 5 )
//
//Case "63"
//	asVal[ 4 ] = "Immobilier"
//	asVal[ 5 ] = Right ( asVal[ 5 ], 5 )
//
//End Choose




end subroutine

private subroutine wf_lst_simple ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Lst_Simple ( Private )
//* Auteur			: Erick John Stark
//* Date				: 21/01/1997 09:18:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des editions (Liste Simple)
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* La premi$$HEX1$$e900$$ENDHEX$$re chose est de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer un fichier LISTE.INI dans le    */
/* r$$HEX1$$e900$$ENDHEX$$pertoire temporaire de Windows.                                */
/* Ce fichier se pr$$HEX1$$e900$$ENDHEX$$sente de la mani$$HEX1$$e800$$ENDHEX$$re suivante                    */
/*                                                                  */
/* [Liste]                                                          */
/* Col=XX                                                           */
/* Titre=XXXXXXXXX                                                  */
/*------------------------------------------------------------------*/

U_DeclarationWindows	nvWin
OleObject	oleWord
N_Cst_Word	nvWord
String sFicIni, sFicData, sTab, sNew, sText, sLigne, sNomCol, sRep
String sVal[], sVide[]
Long lTotCol, lTotLig, lCpt, lCpt1, lCpt2, lNbCol
Integer iFic, iRet

String sMacro, sModele

/*------------------------------------------------------------------*/
/* Si aucun enregistrement dans la DW d'accueil, on s'arr$$HEX1$$ea00$$ENDHEX$$te ici    */
/*------------------------------------------------------------------*/

If	dw_1.RowCount () < 1 Then
	Return 
End If

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nom du fichier $$HEX2$$e0002000$$ENDHEX$$cr$$HEX1$$e900$$ENDHEX$$er                            */
/*------------------------------------------------------------------*/
nvWin	= stGLB.uoWin
sRep	= nvWin.Uf_GetWindowsDirectory ()

/*------------------------------------------------------------------*/
/* On $$HEX1$$e900$$ENDHEX$$crit cette information dans le fichier WIN.INI, pour que     */
/* l'on puisse le relire dans WORD                                  */
/*------------------------------------------------------------------*/
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//SetProfileString ( sRep + "\WIN.INI", "PB4OBJ", "ListeWinDir", sRep )
//
//sFicIni 	= sRep + "\TEMP\LISTE.INI"
//sFicData	= sRep + "\TEMP\LISTE.TXT"
SetProfileString ( sRep + "\WIN.INI", "PB4OBJ", "ListeWinDir", stGlb.sRepTempo )
sFicIni 	= stGlb.sRepTempo +"LISTE.INI"
sFicData	= stGlb.sRepTempo +"LISTE.TXT"

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$termine le nombre de colonne $$HEX2$$e0002000$$ENDHEX$$cr$$HEX1$$e900$$ENDHEX$$er et on construit en     */
/* m$$HEX1$$ea00$$ENDHEX$$me temps l'en-t$$HEX1$$ea00$$ENDHEX$$te du tableau                                  */
/*------------------------------------------------------------------*/

lTotCol	= UpperBound ( dw_1.istCol )
sTab		= "~t"
sNew		= "~r~n"
lNbCol	= 0

For	lCpt = 1 To lTotCol
		If	dw_1.istCol[ lCpt ].sInvisible = "N" Then
			lNbCol ++
			sVal[ lNbCol ]	= dw_1.istCol[ lCpt].sHeaderName
		End If
Next

/*------------------------------------------------------------------*/
/* Modification de l'en-t$$HEX1$$ea00$$ENDHEX$$te, si besoin                             */
/*------------------------------------------------------------------*/

wf_TrtLstEdt ( sVal[] )

lNbCol	= UpperBound ( sVal[] )
sLigne	= ""

/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la derni$$HEX1$$e800$$ENDHEX$$re                      */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lNbCol - 1
		sLigne	= sLigne + sVal[ lCpt ] + sTab
Next
				
sLigne	= sLigne + sVal [ lNbCol ]
lTotLig	= dw_1.RowCount ()

/*------------------------------------------------------------------*/
/* On $$HEX1$$e900$$ENDHEX$$crit les informations dans le fichier LISTE.INI              */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//If	Not FileExists ( sFicIni ) Then
If	Not f_FileExists ( sFicIni ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP	
	
	
	sText =	"[Liste]" + sNew + 								&
				"Col=" + String ( lNbCol )		+ sNew + 	&
				"Lig=" + String ( lTotLig )	+ sNew + 	&
				"Clause=" + isClauseFrancais	+ sNew + 	&
				"Titre=" + isTitreLst + sNew

	f_EcrireFichierText ( sFicIni, sText )

Else

	SetProfileString ( sFicIni, "Liste", "Col", String ( lNbCol ) )
	SetProfileString ( sFicIni, "Liste", "Lig", String ( lTotLig ) )
	SetProfileString ( sFicIni, "Liste", "Clause", isClauseFrancais )
	SetProfileString ( sFicIni, "Liste", "Titre", isTitreLst ) 

End If

/*------------------------------------------------------------------*/
/* On va maintenant s'occuper du fichier des datas LISTE.TXT        */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On ouvre le fichier, et on $$HEX1$$e900$$ENDHEX$$crit l'en-t$$HEX1$$ea00$$ENDHEX$$te en laissant une ligne */
/* $$HEX2$$e0002000$$ENDHEX$$blanc                                                          */
/*------------------------------------------------------------------*/

iFic = FileOpen ( sFicData, LineMode!, Write!, LockReadWrite!, Replace! )

FileWrite ( iFic, sLigne )

/*------------------------------------------------------------------*/
/* En maintenant on $$HEX1$$e900$$ENDHEX$$crit toutes les donn$$HEX1$$e900$$ENDHEX$$es                        */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lTotLig
		lNbCol = 0
		sVal = sVide

		For	lCpt1 = 1 To lTotCol
				If		dw_1.istCol[ lCpt1 ].sInvisible = "N" Then
						sNomCol = dw_1.istCol[ lCpt1 ].sResultSet
						If	sNomCol = "" Or IsNull ( sNomCol ) Then
//Migration PB8-WYNIWYG-03/2006 FM
							//sNomCol = Mid ( dw_1.istCol[ lCpt1 ].sDbName, Pos ( dw_1.istCol[ lCpt1 ].sDbName, "." ) + 1 )
//le dbname comporte user.table.colonne, or il ne nous faut que la colonne
						string	ls_temp
						ls_temp = Reverse(dw_1.istCol[ lCpt1 ].sDbName)
						sNomCol = Mid(ls_temp, 1, Pos(ls_temp, ".", 1) - 1)
						sNomCol = Reverse(sNomCol)
//Fin Migration PB8-WYNIWYG-03/2006 FM
						End If

						lNbCol ++

						Choose Case Upper ( Left ( dw_1.istCol[ lCpt1 ].sType, 5 ) )
						Case	"CHAR("
								sVal[ lNbCol ] = Left ( dw_1.GetItemString ( lCpt, sNomCol ), dw_1.istCol[ lCpt1 ].ilargeur )

						Case	"DATET"
								sVal[ lNbCol ] = Left ( String ( dw_1.GetItemDateTime ( lCpt, sNomCol ), &
														dw_1.istCol[ lCpt1 ].sFormat ), dw_1.istCol[ lCpt1 ].ilargeur )

						Case	"DATE"
								sVal[ lNbCol ] = Left ( String ( dw_1.GetItemDate ( lCpt, sNomCol ), &
														dw_1.istCol[ lCpt1 ].sFormat ), dw_1.istCol[ lCpt1 ].ilargeur )

						Case 	"TIME"
								sVal[ lNbCol ] = Left ( String ( dw_1.GetItemTime ( lCpt, sNomCol ), &
														dw_1.istCol[ lCpt1 ].sFormat ), dw_1.istCol[ lCpt1 ].ilargeur )

						Case	"NUMBE"
								sVal[ lNbCol ] = Left ( String ( dw_1.GetItemNumber ( lCpt, sNomCol ) ), dw_1.istCol[ lCpt1 ].ilargeur )

						End Choose

						If	IsNull ( sVal[ lNbCol ] ) Then sVal[ lNbCol ] = ""

				End If
				
		Next

/*------------------------------------------------------------------*/
/* Modification des donn$$HEX1$$e900$$ENDHEX$$es, si besoin                              */
/*------------------------------------------------------------------*/

		wf_TrtLstEdt ( sVal[] )


/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la derni$$HEX1$$e800$$ENDHEX$$re. Pour terminer, on   */
/* ecrit la ligne                                                   */
/*------------------------------------------------------------------*/

		lNbCol = UpperBound ( sVal[] )
		sLigne = ""

		For	lCpt2 = 1 To lNbCol - 1
				sLigne = sLigne + sVal[ lCpt2 ] + sTab
		Next
				
		sLigne = sLigne + sVal [ lNbCol ]
		FileWrite ( iFic, sLigne )
	
Next

FileClose ( iFic )

/*------------------------------------------------------------------*/
/* On va maintenant commencer l'$$HEX1$$e900$$ENDHEX$$dition                             */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Il faut d'abord r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer les informations suivantes             */
/*  Mod$$HEX1$$e900$$ENDHEX$$le $$HEX2$$e0002000$$ENDHEX$$utiliser                                               */
/*  Macro $$HEX2$$e0002000$$ENDHEX$$lancer                                                  */
/*  Programme Edition                                               */
/*------------------------------------------------------------------*/

sMacro	= ProfileString ( stGLB.sFichierIni, "LISTE", "DEFAUTMACRO", "" )
sModele	= ProfileString ( stGLB.sFichierIni, "LISTE", "DEFAUTMODELE", "" )

If	sMacro = "" Or sModele = "" Then
	Return
End If

F_SetVersionWord ( nvWord, TRUE )
oleWord = Create oleObject

iRet = nvWord.uf_CreerOleObject_Word ( oleWord )

If	iRet < 0 Then
	F_SetVersionWord ( nvWord, FALSE )
	Destroy oleWord
	Return
End If

nvWord.uf_CommandeWord ( 1, sModele, oleWord )
nvWord.uf_CommandeWord ( 2, sMacro, oleWord )

/*------------------------------------------------------------------*/
/* Le 23/07/1998 : Il faut une temporisation entre la fin de la     */
/* macro Word et la fermeture de l'objet OLE. Si on ne fait pas     */
/* cela l'$$HEX1$$e900$$ENDHEX$$dition n'a pas le temps de sortir.                       */
/*------------------------------------------------------------------*/
stMessage.sTitre		= "Edition d'une liste d'accueil (Simple)"
stMessage.Icon			= Information!
stMessage.bErreurG	= TRUE
stMessage.sCode		= "GENE009"

f_Message ( stMessage )

F_SetVersionWord ( nvWord, FALSE )
Destroy oleWord

end subroutine

private subroutine wf_lst_particuliere ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Liste_Particuliere ( Private )
//* Auteur			: Erick John Stark
//* Date				: 19/01/1997 17:17:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Traitement des Listes particuli$$HEX1$$e900$$ENDHEX$$res
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* La premi$$HEX1$$e900$$ENDHEX$$re chose est le lire le fichier de l'application pour   */
/* savoir ou trouver le fichier INI contenant les listes            */
/* particuli$$HEX1$$e900$$ENDHEX$$res.                                                   */
/* Ensuite, si cette liste existe, on va d$$HEX1$$e900$$ENDHEX$$coder les colonnes $$HEX6$$e00020002000200020002000$$ENDHEX$$*/
/* inserer.                                                         */
/* 0=Nbr Colonne                                                    */
/* 1=N$$HEX2$$b0002000$$ENDHEX$$Col,En-t$$HEX1$$ea00$$ENDHEX$$te,Nbr Carac.,                                     */
/*------------------------------------------------------------------*/

U_DeclarationWindows	nvWin

String sRep, sRepLst, sLigne, sFicIni, sFicData, sTab, sNew, sText, sNomCol
String sVal[], sTitre[], sFormat[], sVide[]
Integer iFic, iRet
Integer iNumCol[], iNbrC[]
Long lNbCol, lCpt, lTotCol, lTotLig, lCpt1, lCpt2
String sModele, sMacro
oleObject oleWord
N_Cst_Word	nvWord

/*------------------------------------------------------------------*/
/* Si aucun enregistrement dans la DW d'accueil, on s'arr$$HEX1$$ea00$$ENDHEX$$te ici    */
/*------------------------------------------------------------------*/

If	dw_1.RowCount () < 1 Then
	Return 
End If

sTab		= "~t"
sNew		= "~r~n"

sRepLst = ProfileString ( stGLB.sFichierIni, "LISTE", "LST_PART", "" )
If	sRepLst = "" Then
	Return
End If

lTotCol = ProfileInt ( sRepLst, isListePart, "0", 0 )
If	lTotCol = 0 Then
	Return
End If

For	lCpt = 1 To lTotCol
		sLigne = ProfileString ( sRepLst, isListePart, String ( lCpt ), "" )
		f_DecomposerChaine ( sLigne, ",", sVal[] )

/*------------------------------------------------------------------*/
/* Le tableau de retour doit contenir 3 $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments qui sont :         */
/* 1 = Le num$$HEX1$$e900$$ENDHEX$$ro de la colonne                                      */
/* 2 = Le titre de la colonne                                       */
/* 3 = Le format que l'on doit utiliser pour Date,Time,DateTime     */
/* 4 = Le nombre de caract$$HEX1$$e800$$ENDHEX$$res                                      */
/*------------------------------------------------------------------*/

		iNumCol[ lCpt]		= Integer ( sVal[ 1 ] )
		sTitre[ lCpt ]		= sVal[ 2 ]
		sFormat[ lCpt ] 	= sVal[ 3 ]
		iNbrC[ lCpt ]		= Integer ( sVal[ 4 ] )
		
Next

/*------------------------------------------------------------------*/
/* Ensuite on g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$re fichier LISTE.INI dans le r$$HEX1$$e900$$ENDHEX$$pertoire           */
/* temporaire de Windows.                                           */
/* Ce fichier se pr$$HEX1$$e900$$ENDHEX$$sente de la mani$$HEX1$$e800$$ENDHEX$$re suivante                    */
/*                                                                  */
/* [Liste]                                                          */
/* Col=XX                                                           */
/* Titre=XXXXXXXXX                                                  */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nom du fichier $$HEX2$$e0002000$$ENDHEX$$cr$$HEX1$$e900$$ENDHEX$$er                            */
/*------------------------------------------------------------------*/

nvWin	= stGLB.uoWin

sRep = nvWin.Uf_GetWindowsDirectory ()

/*------------------------------------------------------------------*/
/* On $$HEX1$$e900$$ENDHEX$$crit cette information dans le fichier WIN.INI, pour que     */
/* l'on puisse le relire dans WORD                                  */
/*------------------------------------------------------------------*/
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//SetProfileString ( sRep + "\WIN.INI", "PB4OBJ", "ListeWinDir", sRep )
//
//sFicIni 	= sRep + "\TEMP\LISTE.INI"
//sFicData	= sRep + "\TEMP\LISTE.TXT"
SetProfileString ( sRep + "\WIN.INI", "PB4OBJ", "ListeWinDir", stGlb.sRepTempo )
sFicIni 	= stGlb.sRepTempo + "LISTE.INI"
sFicData	= stGlb.sRepTempo + "LISTE.TXT"

/*------------------------------------------------------------------*/
/* Modification de l'en-t$$HEX1$$ea00$$ENDHEX$$te, si besoin                             */
/*------------------------------------------------------------------*/

wf_TrtLstEdt ( sTitre[] )

lNbCol = UpperBound ( sTitre[] )
sLigne = ""

/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la derni$$HEX1$$e800$$ENDHEX$$re                      */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lNbCol - 1
		sLigne 	= sLigne + sTitre[ lCpt ] + sTab
Next
				
sLigne	= sLigne + sTitre [ lNbCol ]


/*------------------------------------------------------------------*/
/* On $$HEX1$$e900$$ENDHEX$$crit les informations dans le fichier LISTE.INI              */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//If	Not FileExists ( sFicIni ) Then
If	Not f_FileExists ( sFicIni ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP

	sText = "[Liste]" + sNew + "Col=" + String ( lNbCol ) + sNew + "Titre=" + isTitreLst + sNew
	f_EcrireFichierText ( sFicIni, sText )

Else

	SetProfileString ( sFicIni, "Liste", "Col", String ( lNbCol ) )
	SetProfileString ( sFicIni, "Liste", "Titre", isTitreLst ) 

End If

/*------------------------------------------------------------------*/
/* On va maintenant s'occuper du fichier des datas LISTE.TXT        */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On ouvre le fichier, et on $$HEX1$$e900$$ENDHEX$$crit l'en-t$$HEX1$$ea00$$ENDHEX$$te en laissant une ligne */
/* $$HEX2$$e0002000$$ENDHEX$$blanc                                                          */
/*------------------------------------------------------------------*/

iFic = FileOpen ( sFicData, LineMode!, Write!, LockReadWrite!, Replace! )

FileWrite ( iFic, sLigne )

/*------------------------------------------------------------------*/
/* En maintenant on $$HEX1$$e900$$ENDHEX$$crit toutes les donn$$HEX1$$e900$$ENDHEX$$es                        */
/*------------------------------------------------------------------*/

lTotLig	= dw_1.RowCount ()

For	lCpt = 1 To lTotLig
		sVal = sVide

		For	lCpt1 = 1 To lTotCol
				sNomCol = Mid ( dw_1.istCol[ iNumCol [ lCpt1 ] ].sDbName, Pos ( dw_1.istCol[ iNumCol[ lCpt1 ] ].sDbName, "." ) + 1 )

				Choose Case Upper ( Left ( dw_1.istCol[ iNumCol[ lCpt1 ] ].sType, 5 ) )
				Case	"CHAR("
					sVal[ lCpt1 ] = Left ( dw_1.GetItemString ( lCpt, sNomCol ), iNbrC[ lCpt1 ] )

				Case	"DATET"
					sVal[ lCpt1 ] = Left ( String ( dw_1.GetItemDateTime ( lCpt, sNomCol ), sFormat[ lCpt1 ] ), iNbrC[ lCpt1 ] )

				Case	"DATE"
					sVal[ lCpt1 ] = Left ( String ( dw_1.GetItemDate ( lCpt, sNomCol ), sFormat[ lCpt1 ] ), iNbrC[ lCpt1 ] )

				Case 	"TIME"
					sVal[ lCpt1 ] = Left ( String ( dw_1.GetItemTime ( lCpt, sNomCol ), sFormat[ lCpt1 ] ), iNbrC[ lCpt1 ] )

				Case	"NUMBE"
					sVal[ lCpt1 ] = Left ( String ( dw_1.GetItemNumber ( lCpt, sNomCol ) ), iNbrC[ lCpt1 ] )

				End Choose

				If	IsNull ( sVal[ lCpt1 ] ) Then sVal[ lCpt1 ] = ""
				
		Next

/*------------------------------------------------------------------*/
/* Modification des donn$$HEX1$$e900$$ENDHEX$$es, si besoin                              */
/*------------------------------------------------------------------*/

		wf_TrtLstEdt ( sVal[] )


/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la derni$$HEX1$$e800$$ENDHEX$$re. Pour terminer, on   */
/* ecrit la ligne                                                   */
/*------------------------------------------------------------------*/

		lNbCol = UpperBound ( sVal[] )
		sLigne = ""

		For	lCpt2 = 1 To lNbCol - 1
				sLigne = sLigne + sVal[ lCpt2 ] + sTab
		Next
				
		sLigne = sLigne + sVal [ lNbCol ]
		FileWrite ( iFic, sLigne )
	
Next

FileClose ( iFic )

/*------------------------------------------------------------------*/
/* On va maintenant commencer l'$$HEX1$$e900$$ENDHEX$$dition                             */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Il faut d'abord r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer les informations suivantes             */
/*  Mod$$HEX1$$e900$$ENDHEX$$le $$HEX2$$e0002000$$ENDHEX$$utiliser                                               */
/*  Macro $$HEX2$$e0002000$$ENDHEX$$lancer ( qui peut-$$HEX1$$ea00$$ENDHEX$$tre particuli$$HEX1$$e800$$ENDHEX$$re )                   */
/*  Programme Edition                                               */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On utilise toujours le mod$$HEX1$$e900$$ENDHEX$$le par d$$HEX1$$e900$$ENDHEX$$faut                         */
/*------------------------------------------------------------------*/

sModele	= ProfileString ( stGLB.sFichierIni, "LISTE", "DEFAUTMODELE", "" )

/*------------------------------------------------------------------*/
/* On peut sp$$HEX1$$e900$$ENDHEX$$cifier une macro particuli$$HEX1$$e800$$ENDHEX$$re pour cette $$HEX1$$e900$$ENDHEX$$dition,     */
/* sinon on utilise la macro par d$$HEX1$$e900$$ENDHEX$$faut.                            */
/*------------------------------------------------------------------*/

sMacro   = ProfileString ( sRepLst, isListePart, "Macro", "" )
If	sMacro = "" Or IsNull ( sMacro ) Then
	sMacro	= ProfileString ( stGLB.sFichierIni, "LISTE", "DEFAUTMACRO", "" )
End If

If	sMacro = "" Or sModele = "" Then
	Return
End If

F_SetVersionWord ( nvWord, TRUE )
oleWord = Create oleObject

iRet = nvWord.uf_CreerOleObject_Word ( oleWord )

If	iRet < 0 Then
	F_SetVersionWord ( nvWord, FALSE )
	Destroy oleWord
	Return
End If

nvWord.uf_CommandeWord ( 1, sModele, oleWord )
nvWord.uf_CommandeWord ( 2, sMacro, oleWord )

/*------------------------------------------------------------------*/
/* Le 23/07/1998 : Il faut une temporisation entre la fin de la     */
/* macro Word et la fermeture de l'objet OLE. Si on ne fait pas     */
/* cela l'$$HEX1$$e900$$ENDHEX$$dition n'a pas le temps de sortir.                       */
/*------------------------------------------------------------------*/
stMessage.sTitre		= "Edition d'une liste d'accueil (Particuli$$HEX1$$e800$$ENDHEX$$re)"
stMessage.Icon			= Information!
stMessage.bErreurG	= TRUE
stMessage.sCode		= "GENE009"

f_Message ( stMessage )

F_SetVersionWord ( nvWord, FALSE )
Destroy oleWord



end subroutine

on ue_imprimer;call w_ancetre::ue_imprimer;//*-----------------------------------------------------------------
//*
//* Objet 			: w_accueil
//* Evenement 		: Ue_Imprimer
//* Auteur			: Erick John Stark
//* Date				: 22/11/1996 15:10:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* S'agit-il d'une liste simple ou d'une liste personnalis$$HEX1$$e900$$ENDHEX$$e        */
/*------------------------------------------------------------------*/

Pointer AncienPointeur

AncienPointeur = SetPointer ( HourGlass! )

If isListePart = "" Then

	Wf_Lst_Simple ()

Else

	Wf_Lst_Particuliere ()

End If

SetPointer ( AncienPointeur )


end on

on ue_fin_interro;call w_ancetre::ue_fin_interro;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: UE_FIN_INTERRO
//	Auteur		: Erick John Stark
//	Date			: 06/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Lancement du retrieve suite au retour de la fen$$HEX1$$ea00$$ENDHEX$$tre INTERRO
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

String sClause
s_Pass stPass

SetPointer( HourGlass! )

stPass = Message.PowerObjectParm

sClause				= stPass.sTab[1]
isClauseFrancais	= stPass.sTab[2]

// .... Si la clause where g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e est vide on ne fait rien
// .... Il y a 2 cas pour cela
// .... Le gestionnaire a appuy$$HEX2$$e9002000$$ENDHEX$$sur retour
// .... Le gestionnaire n'a pas saisi de crit$$HEX1$$e800$$ENDHEX$$re d'interrogation

If	sClause <> "" Then

// .... On concatene le SELECT de la DW + la Clause WHERE + la jointure CLIENTE de la DW

	sClause = dw_1.isSelect + sClause + " " + dw_1.isJointure

// .... On modifie le select de la DW

	dw_1.Modify ( "DataWindow.Table.Select = ~"" + sClause + "~"" )

	dw_1.Visible = False
	dw_1.Retrieve ()

// .... On retaille la DW

	This.TriggerEvent( "Ue_TaillerHauteur" )
	dw_1.Visible = True

// .... On s$$HEX1$$e900$$ENDHEX$$lectionne la premi$$HEX1$$e800$$ENDHEX$$re ligne
//	dw_1.ilLigneClick = 1
//	dw_1.SelectRow ( 0, False )
//	dw_1.SelectRow ( dw_1.ilLigneClick, True )
	dw_1.SetFocus ()

End If

end on

on ue_enablefenetre;call w_ancetre::ue_enablefenetre;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: ue_EnableFenetre
//	Auteur		: D.Bizien
//	Date			: 22/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Activation de la fenetre lors de la fermeture d'une fenetre de traitement
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

pb_Retour.Enabled 	= True
pb_Interro.Enabled 	= True
pb_Creer.Enabled 		= True
pb_Tri.Enabled 		= True

If ( pb_Imprimer.Visible ) Then
	pb_Imprimer.Enabled = True
End If

Dw_1.Enabled 			= True

// Mettre le focus sur la DW
dw_1.SetFocus ()



end on

on ue_disablefenetre;call w_ancetre::ue_disablefenetre;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: ue_DisableFenetre
//	Auteur		: D.Bizien
//	Date			: 22/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Desactivation de la fenetre lors de l'ouverture d'une fenetre de traitement
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

pb_Retour.Enabled 	= False
pb_Interro.Enabled 	= False
pb_Creer.Enabled 		= False
pb_Tri.Enabled 		= False

If ( pb_Imprimer.Visible ) Then
	pb_Imprimer.Enabled = False
End If

Dw_1.Enabled 			= False


end on

on ue_interro;call w_ancetre::ue_interro;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: UE_INTERRO
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interrogation
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

SetPointer( HourGlass! )

OpenWithParm( w_Interro, pb_Interro.istInterro )

This.TriggerEvent( "UE_FIN_INTERRO" )




end on

on ue_item5;call w_ancetre::ue_item5;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: ue_Item6
//	Auteur		: La Recrue
//	Date			: 16/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Declanchement de la recherche sur menu contextuel
// Commentaires: 
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

This.TriggerEvent ( "ue_interro" )
end on

on ue_trier;call w_ancetre::ue_trier;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: UE_TRIER
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Ouverture de l'objet de Tri
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

String sRet
s_tri  stTri
Long lLigne

// .... Remplissage de la Structure de Tri

stTri.sImport		= This.isImportTri
stTri.sTriActuel	= dw_1.isTri

OpenWithParm ( w_Tri, stTri )

sRet = Message.StringParm

// .... Deux cas possibles
// .... sRet = NULL		-> La personne $$HEX2$$e0002000$$ENDHEX$$appuyer sur RETOUR
//								-> On ne fait rien
//
// .... sRet <> NULL 	-> La Chaine est Vide ou Non
//								-> On positionne la cha$$HEX1$$ee00$$ENDHEX$$ne de Tri et On Tri la DW

If	Not IsNull ( sRet ) Then

	dw_1.isTri = sRet
	dw_1.TriggerEvent ( "Ue_Trier" )

// .... Il faut positionner le pointeur sur l'enregistrement qui $$HEX1$$e900$$ENDHEX$$tait s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$avant le Tri

	lLigne = dw_1.GetSelectedRow ( 0 )

	If lLigne > 0 Then
// .... Il faut r$$HEX1$$e900$$ENDHEX$$armer la valeur d'instance de la DW qui donne la ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e

		dw_1.ilLigneClick = lLigne

// .... Repostionnement sur la ligne en cours si plusieurs pages

		dw_1.ScrollToRow ( lLigne )
		dw_1.SetRow ( lLigne )

	End If

End If

dw_1.SetFocus ()


end on

on ue_taillerhauteur;call w_ancetre::ue_taillerhauteur;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: UE_TAILLERHAUTEUR
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Centrage de la DW d'accueil dans la hauteur de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

dw_1.Uf_Hauteur ( This.Height, 0 )

If	dw_1.Visible = False Then
	dw_1.Visible = True
End If

end on

on ue_initialiser;call w_ancetre::ue_initialiser;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: Ue_Initialiser
//	Auteur		: Erick John Stark
//	Date			: 22/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Mettre le focus sur la DW
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

pb_Interro.SetFocus ()
end on

on open;call w_ancetre::open;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: Open
//	Auteur		: D.Bizien
//	Date			: 22/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de d'accueil
// Commentaires: Positionnement des $$HEX1$$e900$$ENDHEX$$lements d'appel de la structure de traitement
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

istPass.wParent			=	This			// Fenetre appelante pour fenetre de traitment
istPass.bEnableParent	= 	False			// Doit on rendre la fenetre appelante disable
													// lors de l'appel d'une fen$$HEX1$$ea00$$ENDHEX$$tre de traitement

This.TriggerEvent ( "ue_Initialiser" )
end on

on ue_majaccueil;call w_ancetre::ue_majaccueil;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: ue_MajAccueil
//	Auteur		: D.Bizien
//	Date			: 18/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Mise $$HEX2$$e0002000$$ENDHEX$$jour de la datawindow accueil apr$$HEX1$$e800$$ENDHEX$$s modification
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************


Dw_1.TriggerEvent ( "ue_majAccueil" )


end on

on ue_centreracc;call w_ancetre::ue_centreracc;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: UE_CENTRERACC
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Centrage de la DW d'accueil dans la largeur de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

dw_1.Uf_Largeur ( This.Width, 0 )


end on

on ue_modifier;call w_ancetre::ue_modifier;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: ue_Modifier
//	Auteur		: D.Bizien
//	Date			: 11/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Modification d'un  enregistrement
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

istPass.bInsert = False
end on

on ue_creer;call w_ancetre::ue_creer;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: ue_Creer
//	Auteur		: D.Bizien
//	Date			: 11/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Cr$$HEX1$$e900$$ENDHEX$$ation d'un nouvel enregistrement
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

istPass.bInsert = True
end on

on ue_retour;call w_ancetre::ue_retour;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: ue_Retour
//	Auteur		: D.Bizien
//	Date			: 22/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre de d'accueil
// Commentaires: 
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Close ( This )
end on

on w_accueil.create
int iCurrent
call super::create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.pb_retour=create pb_retour
this.pb_interro=create pb_interro
this.pb_creer=create pb_creer
this.dw_1=create dw_1
this.pb_tri=create pb_tri
this.pb_imprimer=create pb_imprimer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_retour
this.Control[iCurrent+2]=this.pb_interro
this.Control[iCurrent+3]=this.pb_creer
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.pb_tri
this.Control[iCurrent+6]=this.pb_imprimer
end on

on w_accueil.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_retour)
destroy(this.pb_interro)
destroy(this.pb_creer)
destroy(this.dw_1)
destroy(this.pb_tri)
destroy(this.pb_imprimer)
end on

type pb_retour from u_pbretour within w_accueil
integer x = 18
integer y = 16
integer width = 265
integer height = 152
integer taborder = 30
end type

type pb_interro from u_pbinterro within w_accueil
integer x = 567
integer y = 16
integer width = 265
integer height = 152
integer taborder = 50
end type

type pb_creer from u_pbcreer within w_accueil
integer x = 293
integer y = 16
integer width = 265
integer height = 152
integer taborder = 40
end type

type dw_1 from u_datawindow_accueil within w_accueil
boolean visible = false
integer x = 37
integer y = 224
integer width = 1865
integer height = 256
integer taborder = 20
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type pb_tri from u_pbtrier within w_accueil
integer x = 841
integer y = 16
integer width = 265
integer height = 152
integer taborder = 60
end type

type pb_imprimer from u_pbimprimer within w_accueil
boolean visible = false
integer x = 1115
integer y = 16
integer width = 265
integer height = 152
integer taborder = 10
boolean enabled = false
string disabledname = ""
end type

