HA$PBExportHeader$w_accueil_consultation.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil de consultation
forward
global type w_accueil_consultation from w_ancetre
end type
type pb_retour from u_8_pbretour within w_accueil_consultation
end type
type pb_interro from u_8_pbinterro within w_accueil_consultation
end type
type pb_tri from u_8_pbtrier within w_accueil_consultation
end type
type uo_onglet from u_onglets within w_accueil_consultation
end type
type dw_1 from u_datawindow_accueil within w_accueil_consultation
end type
type dw_2 from u_datawindow_accueil within w_accueil_consultation
end type
type dw_3 from u_datawindow_accueil within w_accueil_consultation
end type
type dw_4 from u_datawindow_accueil within w_accueil_consultation
end type
type dw_5 from u_datawindow_accueil within w_accueil_consultation
end type
type dw_6 from u_datawindow_accueil within w_accueil_consultation
end type
type uo_1 from u_bord3d within w_accueil_consultation
end type
type pb_imprimer from u_pbimprimer within w_accueil_consultation
end type
end forward

global type w_accueil_consultation from w_ancetre
integer width = 3963
integer height = 2256
boolean titlebar = true
string menuname = "m_main"
windowtype windowtype = main!
event ue_entreronglet011 pbm_custom47
event ue_quitteronglet011 pbm_custom46
event ue_entreronglet021 pbm_custom45
event ue_quitteronglet021 pbm_custom44
event ue_entreronglet031 pbm_custom43
event ue_quitteronglet031 pbm_custom42
event ue_entreronglet041 pbm_custom41
event ue_quitteronglet041 pbm_custom40
event ue_entreronglet051 pbm_custom39
event ue_quitteronglet051 pbm_custom38
event ue_entreronglet061 pbm_custom37
event ue_quitteronglet061 pbm_custom36
pb_retour pb_retour
pb_interro pb_interro
pb_tri pb_tri
uo_onglet uo_onglet
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
dw_6 dw_6
uo_1 uo_1
pb_imprimer pb_imprimer
end type
global w_accueil_consultation w_accueil_consultation

type variables
Private:
	Boolean			ibResetDw

Protected:

	u_datawindow_Accueil	iuDataWindow[6] 
	u_Datawindow_Accueil	iuAccueilCourrant

	String			isImportTri
	String			isTitreLst
	String			isListePart = ""
	String			isClauseFrancais = ""

	Boolean			ibModeMdi
	Long			ilNbFilleOuverte




end variables

forward prototypes
protected function boolean wf_creer_onglet (integer ainbaccueil, integer aidefaut, string asnomonglet[])
public function long wf_construire_chaine_tri ()
public subroutine wf_activer_mode_mdi (boolean abactiver)
public function boolean wf_is_mode_mdi ()
public subroutine wf_supprimer_fille ()
public function boolean wf_ajouter_fille ()
public subroutine wf_activer_resetdw (boolean abactiver)
private subroutine wf_lst_particuliere ()
private subroutine wf_lst_simple ()
protected subroutine wf_trtlstedt (ref string asval[])
end prototypes

event ue_entreronglet011;//*****************************************************************************
//
// Objet 		: w_Accueil_consultation
// Evenement 	: ue_entreronglet011
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Lorque que l'onglet est clicker, la datawindow courrnate cahnge.
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

iuAccueilCourrant = dw_1

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_entreronglet021;//*****************************************************************************
//
// Objet 		: w_Accueil_consultation
// Evenement 	: ue_entreronglet011
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Lorque que l'onglet est clicker, la datawindow courrnate cahnge.
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

iuAccueilCourrant = dw_2

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_entreronglet031;//*****************************************************************************
//
// Objet 		: w_Accueil_consultation
// Evenement 	: ue_entreronglet011
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Lorque que l'onglet est clicker, la datawindow courrnate cahnge.
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

iuAccueilCourrant = dw_3

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_entreronglet041;//*****************************************************************************
//
// Objet 		: w_Accueil_consultation
// Evenement 	: ue_entreronglet011
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Lorque que l'onglet est clicker, la datawindow courrnate cahnge.
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

iuAccueilCourrant = dw_4

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_entreronglet051;//*****************************************************************************
//
// Objet 		: w_Accueil_consultation
// Evenement 	: ue_entreronglet011
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Lorque que l'onglet est clicker, la datawindow courrnate cahnge.
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

iuAccueilCourrant = dw_5

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_entreronglet061;//*****************************************************************************
//
// Objet 		: w_Accueil_consultation
// Evenement 	: ue_entreronglet011
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Lorque que l'onglet est clicker, la datawindow courrnate cahnge.
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

iuAccueilCourrant = dw_6

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

protected function boolean wf_creer_onglet (integer ainbaccueil, integer aidefaut, string asnomonglet[])
//*******************************************************************************************
// Fonction            	: wf_Creer_Onglet
//	Auteur              	: La Recrue
//	Date 					 	: 14/01/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Construction des Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour la consultation
//
// Arguments				: aiNbAccueil		Nombre de fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil da 1 $$HEX2$$e0002000$$ENDHEX$$6
//								  aiDefaut			Onglet Afficher par defaut
//								  asNomOnglet[]	Tableau des noms pourles onglet.
//
// Retourne					: Boolean			True : Tout s'est bien pass$$HEX1$$e900$$ENDHEX$$
//								  
//*******************************************************************************************

Long lI

uo_onglet.Uf_Initialiser ( aiNbAccueil, 1 )

uo_onglet.Visible = True

For lI = 1 to aiNbAccueil

	uo_onglet.Uf_EnregistrerOnglet ( "0" + String ( li ), asNomOnglet[lI] ,"", iudatawindow[lI], ( li = aiDefaut ) )

	If ( li = aiDefaut ) Then
		iuaccueilcourrant = iuDataWindow[lI]
	End If

Next

Return True
end function

public function long wf_construire_chaine_tri ();//*******************************************************************************************
// Fonction            	: wf_Construire_Chaine_Tri
//	Auteur              	: La Recrue
//	Date 					 	: 15/01/1997
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Construction de la chaine d'import pour l'accueil courrant
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
lNbrCol 		= UpperBound ( iuAccueilCourrant.istCol )

If	lNbrCol > 0 Then
	
	For	lCpt = 1 To lNbrCol
			If	iuAccueilCourrant.istCol[ lCpt ].sInvisible = "O" Then
				Continue

			Else

				sImport = sImport														+ &
							 iuAccueilCourrant.istCol[ lCpt ].sHeaderName	+ sTab	+ &
							 String ( lCpt )											+ sTab	+ &
							 iuAccueilCourrant.istCol[ lCpt ].sDbName			+ sNew
			End If
	Next

End If

isImportTri = sImport

Return ( lRet )
end function

public subroutine wf_activer_mode_mdi (boolean abactiver);//*******************************************************************************************
// Fonction            	: wf_Activer_Mode_Mdi
//	Auteur              	: La Recrue
//	Date 					 	: 16/01/1997
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Activer lo mode d'ouverture de plusieurs fen$$HEX1$$ea00$$ENDHEX$$tres
//
// Arguments				: 
//
// Retourne					: Long	
//								  
//*******************************************************************************************

ibModeMdi = abActiver
end subroutine

public function boolean wf_is_mode_mdi ();//*******************************************************************************************
// Fonction            	: wf_Is_Mode_Mdi
//	Auteur              	: La Recrue
//	Date 					 	: 16/01/1997
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Retourne si l'on est en mode MDI ou non
//
// Arguments				: 
//
// Retourne					: Long	
//								  
//*******************************************************************************************

Return ( ibModeMdi )
end function

public subroutine wf_supprimer_fille ();//*******************************************************************************************
// Fonction            	: wf_Supprimer_Fille
//	Auteur              	: La Recrue
//	Date 					 	: 17/01/1997
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Diminue le compteur de fen$$HEX1$$ea00$$ENDHEX$$tre de fille
//
// Arguments				: 
//
// Retourne					: Long	
//								  
//*******************************************************************************************

ilnbFilleOuverte --
end subroutine

public function boolean wf_ajouter_fille ();//*******************************************************************************************
// Fonction            	: wf_Ajouter_Fille
//	Auteur              	: La Recrue
//	Date 					 	: 17/01/1997
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Augmente le compteur de fen$$HEX1$$ea00$$ENDHEX$$tre de fille
//
// Arguments				: 
//
// Retourne					: Long	
//								  
//*******************************************************************************************



If ( ilnbFilleOuverte < 5 ) Then // Nombre maximum de fen$$HEX1$$ea00$$ENDHEX$$tre ouverte

	ilnbFilleOuverte ++
	Return ( True )
Else

	stMessage.bErreurG	= True
	stMessage.sTitre		= "Consultation"
	stMessage.Icon			= Information!
	stMessage.sCode		= "ANCE005"

	f_Message ( stMessage )			

	Return ( False )

End If


end function

public subroutine wf_activer_resetdw (boolean abactiver);//*******************************************************************************************
// Fonction            	: wf_Activer_ResetDw
//	Auteur              	: La Recrue
//	Date 					 	: 11/02/1997
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Activer le mode des reset des Dw sur le retrieve de celles-ci
//
// Arguments				: abActiver	Boolean	(Val)	Activer ou desactiver
//
// Retourne					: Rien
//								  
//*******************************************************************************************

ibResetDw = abActiver
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

String sRep, sLigne, sFicIni, sFicData, sTab, sNew, sText, sNomCol
String sVal[], sTitre[], sFormat[], sVide[]
Integer iFic
Integer iNumCol[], iNbrC[]
Long lNbCol, lCpt, lTotCol, lTotLig, lCpt1, lCpt2

sTab		= "~t"
sNew		= "~r~n"

sRep = ProfileString ( stGLB.sFichierIni, "LISTE", "LST_PART", "" )
If	sRep = "" Then
	Return
End If

lTotCol = ProfileInt ( sRep, isListePart, "0", 0 )
If	lTotCol = 0 Then
	Return
End If

For	lCpt = 1 To lTotCol
		sLigne = ProfileString ( sRep, isListePart, String ( lCpt ), "" )
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

//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//nvWin	= stGLB.uoWin
//sRep	= nvWin.Uf_GetWindowsDirectory ()
//sFicIni 	= sRep + "\TEMP\LISTE.INI"
//sFicData	= sRep + "\TEMP\LISTE.TXT"
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

lTotLig	= iuAccueilCourrant.RowCount ()

For	lCpt = 1 To lTotLig
		sVal = sVide

		For	lCpt1 = 1 To lTotCol
				sNomCol = Mid ( iuAccueilCourrant.istCol[ iNumCol [ lCpt1 ] ].sDbName, Pos ( iuAccueilCourrant.istCol[ iNumCol[ lCpt1 ] ].sDbName, "." ) + 1 )

				Choose Case Upper ( Left ( iuAccueilCourrant.istCol[ iNumCol[ lCpt1 ] ].sType, 5 ) )
				Case	"CHAR("
					sVal[ lCpt1 ] = Left ( iuAccueilCourrant.GetItemString ( lCpt, sNomCol ), iNbrC[ lCpt1 ] )

				Case	"DATET"
					sVal[ lCpt1 ] = Left ( String ( iuAccueilCourrant.GetItemDateTime ( lCpt, sNomCol ), sFormat[ lCpt1 ] ), iNbrC[ lCpt1 ] )

				Case	"DATE"
					sVal[ lCpt1 ] = Left ( String ( iuAccueilCourrant.GetItemDate ( lCpt, sNomCol ), sFormat[ lCpt1 ] ), iNbrC[ lCpt1 ] )

				Case 	"TIME"
					sVal[ lCpt1 ] = Left ( String ( iuAccueilCourrant.GetItemTime ( lCpt, sNomCol ), sFormat[ lCpt1 ] ), iNbrC[ lCpt1 ] )

				Case	"NUMBE"
					sVal[ lCpt1 ] = Left ( String ( iuAccueilCourrant.GetItemNumber ( lCpt, sNomCol ) ), iNbrC[ lCpt1 ] )

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
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
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
oleObject oleWord
String sFicIni, sFicData, sTab, sNew, sText, sLigne, sNomCol, sRep
String sVal[], sVide[]
Long lTotCol, lTotLig, lCpt, lCpt1, lCpt2, lNbCol
Integer iFic, iRet

String sMacro, sModele

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nom du fichier $$HEX2$$e0002000$$ENDHEX$$cr$$HEX1$$e900$$ENDHEX$$er                            */
/*------------------------------------------------------------------*/
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//nvWin	= stGLB.uoWin
//sRep	= nvWin.Uf_GetWindowsDirectory ()
//sFicIni 	= sRep + "\TEMP\LISTE.INI"
//sFicData	= sRep + "\TEMP\LISTE.TXT"

sFicIni 	= stGlb.sRepTempo + "LISTE.INI"
sFicData	= stGlb.sRepTempo + "LISTE.TXT"

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$termine le nombre de colonne $$HEX2$$e0002000$$ENDHEX$$cr$$HEX1$$e900$$ENDHEX$$er et on construit en     */
/* m$$HEX1$$ea00$$ENDHEX$$me temps l'en-t$$HEX1$$ea00$$ENDHEX$$te du tableau                                  */
/*------------------------------------------------------------------*/

lTotCol	= UpperBound ( iuAccueilCourrant.istCol )
sTab		= "~t"
sNew		= "~r~n"
lNbCol	= 0

For	lCpt = 1 To lTotCol
		If	iuAccueilCourrant.istCol[ lCpt ].sInvisible = "N" Then
			lNbCol ++
			sVal[ lNbCol ]	= iuAccueilCourrant.istCol[ lCpt].sHeaderName
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
lTotLig	= iuAccueilCourrant.RowCount ()

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
				If		iuAccueilCourrant.istCol[ lCpt1 ].sInvisible = "N" Then
//Migration PB8-WYNIWYG-03/2006 OR
//						sNomCol = Mid ( iuAccueilCourrant.istCol[ lCpt1 ].sDbName, Pos ( iuAccueilCourrant.istCol[ lCpt1 ].sDbName, "." ) + 1 )
//le dbname comporte user.table.colonne, or il ne nous faut que la colonne
						string	ls_temp
						ls_temp = Reverse(iuAccueilCourrant.istCol[ lCpt1 ].sDbName)
						sNomCol = Mid(ls_temp, 1, Pos(ls_temp, ".", 1) - 1)
						sNomCol = Reverse(sNomCol)
//Fin Migration PB8-WYNIWYG-03/2006 OR
						lNbCol ++

						Choose Case Upper ( Left ( iuAccueilCourrant.istCol[ lCpt1 ].sType, 5 ) )
						Case	"CHAR("
								sVal[ lNbCol ] = Left ( iuAccueilCourrant.GetItemString ( lCpt, sNomCol ), iuAccueilCourrant.istCol[ lCpt1 ].ilargeur )

						Case	"DATET"
								sVal[ lNbCol ] = Left ( String ( iuAccueilCourrant.GetItemDateTime ( lCpt, sNomCol ), &
														iuAccueilCourrant.istCol[ lCpt1 ].sFormat ), iuAccueilCourrant.istCol[ lCpt1 ].ilargeur )

						Case	"DATE"
								sVal[ lNbCol ] = Left ( String ( iuAccueilCourrant.GetItemDate ( lCpt, sNomCol ), &
														iuAccueilCourrant.istCol[ lCpt1 ].sFormat ), iuAccueilCourrant.istCol[ lCpt1 ].ilargeur )

						Case 	"TIME"
								sVal[ lNbCol ] = Left ( String ( iuAccueilCourrant.GetItemTime ( lCpt, sNomCol ), &
														iuAccueilCourrant.istCol[ lCpt1 ].sFormat ), iuAccueilCourrant.istCol[ lCpt1 ].ilargeur )

						Case	"NUMBE"
								sVal[ lNbCol ] = Left ( String ( iuAccueilCourrant.GetItemNumber ( lCpt, sNomCol ) ), iuAccueilCourrant.istCol[ lCpt1 ].ilargeur )

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

oleWord = Create oleObject

iRet = oleWord.ConnectToNewObject ( "word.basic" )

If	iRet <> 0 Then
	Destroy oleWord
	Return
End If

oleWord.FichierOuvrir ( sModele )
oleWord.OutilsMacro ( "LISTE", True )
oleWord.DisConnectObject ()
Destroy oleWord

end subroutine

protected subroutine wf_trtlstedt (ref string asval[]);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_TrtLstEdt
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



end subroutine

event ue_fin_interro;call super::ue_fin_interro;//*****************************************************************************
//
// Objet 		: w_Accueil_consultation
// Evenement 	: Open
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Retour de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interrogation.
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date				Modification
//	La Recrue	11/02/1997		Modification suite $$HEX2$$e0002000$$ENDHEX$$modif DGA sur le Retour Interro.
//	La Recrue	11/02/1997		Ajout de la gestion du Reset sur le Dw au Retrieve
//*****************************************************************************

s_Pass	stPass
String 	sClause, sRetour
Long		lCpt 

stPass	= Message.PowerObjectParm

sRetour				= stPass.sTab[1]
isClauseFrancais	= stPass.sTab[2]

// .... Si la clause where g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e est vide on ne fait rien
// .... Il y a 2 cas pour cela
// .... Le gestionnaire a appuy$$HEX2$$e9002000$$ENDHEX$$sur retour
// .... Le gestionnaire n'a pas saisi de crit$$HEX1$$e800$$ENDHEX$$re d'interrogation


If	sRetour <> "" Then

	lCpt = 1

	Do while Pos( sRetour, "~t" ) > 0

		sClause = Left( sRetour, Pos( sRetour, "~t" ) - 1 )
		
		If ( sClause <>"" ) Then

			sClause = iuDataWindow[lCpt].isSelect + sClause + iuDataWindow[lCpt].isJointure
			iuDataWindow[lCpt].Modify( "DataWindow.Table.Select = ~"" + sClause + "~"" )
			iuDataWindow[lCpt].Retrieve()

		Else

			If ( ibResetDw ) Then

				iuDataWindow[lCpt].Reset()

			End If

		End If

		sRetour = Right( sRetour, Len( sRetour ) - Pos( sRetour, "~t" ) )

		lCpt ++
	Loop

End If

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_disablefenetre;call super::ue_disablefenetre;//*****************************************************************************
//
// Objet 		: w_Accueil_Consultation
// Evenement 	: ue_EnableFenetre
//	Auteur		: La Recrue
//	Date			: 16/01/1997
// Libell$$HEX3$$e90009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$sActivation de la fenetre lors de l'ouverture d'une fenetre de traitement
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Long lI

pb_Retour.Enabled 	= False
pb_Interro.Enabled 	= False
pb_Tri.Enabled 		= False
uo_onglet.Enabled		= False

If ( pb_Imprimer.Visible ) Then
	pb_Imprimer.Enabled = False
End If

For li = 1 To 6
	iuDataWindow[lI].Enabled = False
Next

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_imprimer;call super::ue_imprimer;//*-----------------------------------------------------------------
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

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event open;call super::open;//*****************************************************************************
//
// Objet 		: w_Accueil_consultation
// Evenement 	: Open
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de d'accueil de consultation
// Commentaires: Initialisation des variables d'instance
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date				Modification
// La Recrue	11/02/1997		Ajout de la gestion de la variable ibRestDw
//*****************************************************************************


iuDatawindow[1] = dw_1
iuDatawindow[2] = dw_2
iuDatawindow[3] = dw_3
iuDatawindow[4] = dw_4
iuDatawindow[5] = dw_5
iuDatawindow[6] = dw_6

istPass.wParent			=	This			// Fen$$HEX1$$ea00$$ENDHEX$$tre appelante pour fenetre de traitment
istPass.bEnableParent	= 	False			// Doit on rendre la fenetre appelante disable
													// lors de l'appel d'une fen$$HEX1$$ea00$$ENDHEX$$tre de traitement
ibModeMdi					= False
iLnbFilleOuverte			= 0
ibResetDw					= True

This.TriggerEvent ( "ue_Initialiser" )

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event resize;call super::resize;//*****************************************************************************
//
// Objet 		: w_Accueil_consultation
// Evenement 	: Resize
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Retaillage de la fen$$HEX1$$ea00$$ENDHEX$$tre
// Commentaires: On retaile les Datawindow d'accueil
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

//Long lI
//
//SetRedraw ( False )
//
//For lI = 1 To 6
//
//	iuDatawindow[lI].Height	= This.height	- 500
//	iuDatawindow[lI].Width	= This.width	- 90
//
//Next
//
//uo_1.Height = iuDatawindow[1].height + 40
//uo_1.Width = iuDatawindow[1].width + 40
//
//SetRedraw ( True )

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_trier;call super::ue_trier;//*****************************************************************************
//
// Objet 		: w_Accueil_consultation
// Evenement 	: ue_Trier
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Trie de la datawindow d'accueil courrante
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

String sRet
s_tri  stTri
Long lLigne

wf_Construire_Chaine_Tri()

// .... Remplissage de la Structure de Tri

stTri.sImport		= This.isImportTri
stTri.sTriActuel	= iuAccueilCourrant.isTri

OpenWithParm ( w_Tri, stTri )

sRet = Message.StringParm

// .... Deux cas possibles
// .... sRet = NULL		-> La personne $$HEX2$$e0002000$$ENDHEX$$appuyer sur RETOUR
//								-> On ne fait rien
//
// .... sRet <> NULL 	-> La Chaine est Vide ou Non
//								-> On positionne la cha$$HEX1$$ee00$$ENDHEX$$ne de Tri et On Tri la DW

If	Not IsNull ( sRet ) Then

	iuAccueilCourrant.isTri = sRet
	iuAccueilCourrant.TriggerEvent ( "Ue_Trier" )

// .... Il faut positionner le pointeur sur l'enregistrement qui $$HEX1$$e900$$ENDHEX$$tait s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$avant le Tri

	lLigne = iuAccueilCourrant.GetSelectedRow ( 0 )

	If lLigne > 0 Then
// .... Il faut r$$HEX1$$e900$$ENDHEX$$armer la valeur d'instance de la DW qui donne la ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e

		iuAccueilCourrant.ilLigneClick = lLigne

// .... Repostionnement sur la ligne en cours si plusieurs pages

		iuAccueilCourrant.ScrollToRow ( lLigne )
		iuAccueilCourrant.SetRow ( lLigne )

	End If

End If

iuAccueilCourrant.SetFocus ()

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_item5;call super::ue_item5;TriggerEvent ( "ue_Interro" )

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_retour;call super::ue_retour;//*****************************************************************************
//
// Objet 		: w_Accueil_consultation
// Evenement 	: Open
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************


Close( This )

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

on w_accueil_consultation.create
int iCurrent
call super::create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.pb_retour=create pb_retour
this.pb_interro=create pb_interro
this.pb_tri=create pb_tri
this.uo_onglet=create uo_onglet
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.dw_6=create dw_6
this.uo_1=create uo_1
this.pb_imprimer=create pb_imprimer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_retour
this.Control[iCurrent+2]=this.pb_interro
this.Control[iCurrent+3]=this.pb_tri
this.Control[iCurrent+4]=this.uo_onglet
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.dw_5
this.Control[iCurrent+10]=this.dw_6
this.Control[iCurrent+11]=this.uo_1
this.Control[iCurrent+12]=this.pb_imprimer
end on

on w_accueil_consultation.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_retour)
destroy(this.pb_interro)
destroy(this.pb_tri)
destroy(this.uo_onglet)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.uo_1)
destroy(this.pb_imprimer)
end on

event ue_interro;call super::ue_interro;//*****************************************************************************
//
// Objet 		: w_Accueil_consultation
// Evenement 	: Open
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interrogation
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

OpenWithParm( w_Interro_consultation, pb_Interro.istInterro )

This.TriggerEvent( "UE_FIN_INTERRO" )

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_initialiser;call super::ue_initialiser;//*****************************************************************************
//
// Objet 		: w_Accueil
// Evenement 	: Ue_Initialiser
//	Auteur		: La recrue
//	Date			: 15/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Mettre le focus sur la DW
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

pb_Interro.SetFocus ()

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event ue_enablefenetre;call super::ue_enablefenetre;//*****************************************************************************
//
// Objet 		: w_Accueil_Consultation
// Evenement 	: ue_EnableFenetre
//	Auteur		: La Recrue
//	Date			: 16/01/1997
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Activation de la fenetre lors de la fermeture d'une fenetre de traitement
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Long lI

pb_Retour.Enabled 	= True
pb_Interro.Enabled 	= True
pb_Tri.Enabled 		= True
uo_onglet.Enabled		= True

If ( pb_Imprimer.Visible ) Then
	pb_Imprimer.Enabled = True
End If

For li = 1 To 6
	iuDataWindow[lI].Enabled = True
Next

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

type pb_retour from u_8_pbretour within w_accueil_consultation
integer x = 41
integer y = 32
integer width = 265
integer height = 152
integer taborder = 110
integer textsize = -8
string picturename = "k:\pb4obj\bmp\quitter.bmp"
end type

type pb_interro from u_8_pbinterro within w_accueil_consultation
integer x = 320
integer y = 32
integer width = 265
integer height = 152
integer taborder = 120
integer textsize = -8
string picturename = "k:\pb4obj\bmp\interro.bmp"
end type

type pb_tri from u_8_pbtrier within w_accueil_consultation
integer x = 599
integer y = 32
integer width = 265
integer height = 152
integer taborder = 100
integer textsize = -8
string picturename = "k:\pb4obj\bmp\tri.bmp"
end type

type uo_onglet from u_onglets within w_accueil_consultation
boolean visible = false
integer x = 18
integer y = 196
integer width = 2939
integer height = 108
integer taborder = 20
boolean border = false
end type

type dw_1 from u_datawindow_accueil within w_accueil_consultation
boolean visible = false
integer x = 41
integer y = 304
integer width = 2885
integer height = 1096
integer taborder = 80
boolean vscrollbar = true
boolean border = false
end type

event ue_modifiermenu;call super::ue_modifiermenu;//*****************************************************************************
//
// Objet 		: dw_1
// Evenement 	: ue_ModifierMenu
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Pour la consultation le modifier se transforme en consulter
//					  Le rest disparait
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************



uf_Mnu_SupprimerItem ( 1 )
uf_Mnu_SupprimerItem ( 3 )
uf_Mnu_ChangerText ( 2, "Consulter" )
If ( ilLigneClick > 0 ) Then
	uf_Mnu_AutoriserItem ( 2 )
Else
	uf_Mnu_InterdirItem ( 2 )
End If

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event rbuttondown;//Migration PB8-WYNIWYG-03/2006 OR
//ce code remplace le code de l'anc$$HEX1$$ea00$$ENDHEX$$tre, 
//il permet la s$$HEX1$$e900$$ENDHEX$$lection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

type dw_2 from u_datawindow_accueil within w_accueil_consultation
boolean visible = false
integer x = 41
integer y = 304
integer width = 2885
integer height = 1096
integer taborder = 70
boolean vscrollbar = true
boolean border = false
end type

event ue_modifiermenu;call super::ue_modifiermenu;//*****************************************************************************
//
// Objet 		: dw_1
// Evenement 	: ue_ModifierMenu
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Pour la consultation le modifier se transforme en consulter
//					  Le rest disparait
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************



uf_Mnu_SupprimerItem ( 1 )
uf_Mnu_SupprimerItem ( 3 )
uf_Mnu_ChangerText ( 2, "Consulter" )
If ( ilLigneClick > 0 ) Then
	uf_Mnu_AutoriserItem ( 2 )
Else
	uf_Mnu_InterdirItem ( 2 )
End If

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event rbuttondown;//Migration PB8-WYNIWYG-03/2006 OR
//ce code remplace le code de l'anc$$HEX1$$ea00$$ENDHEX$$tre, 
//il permet la s$$HEX1$$e900$$ENDHEX$$lection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

type dw_3 from u_datawindow_accueil within w_accueil_consultation
boolean visible = false
integer x = 41
integer y = 304
integer width = 2885
integer height = 1096
integer taborder = 60
boolean vscrollbar = true
boolean border = false
end type

event ue_modifiermenu;call super::ue_modifiermenu;//*****************************************************************************
//
// Objet 		: dw_1
// Evenement 	: ue_ModifierMenu
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Pour la consultation le modifier se transforme en consulter
//					  Le rest disparait
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************



uf_Mnu_SupprimerItem ( 1 )
uf_Mnu_SupprimerItem ( 3 )
uf_Mnu_ChangerText ( 2, "Consulter" )
If ( ilLigneClick > 0 ) Then
	uf_Mnu_AutoriserItem ( 2 )
Else
	uf_Mnu_InterdirItem ( 2 )
End If

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event rbuttondown;//Migration PB8-WYNIWYG-03/2006 OR
//ce code remplace le code de l'anc$$HEX1$$ea00$$ENDHEX$$tre, 
//il permet la s$$HEX1$$e900$$ENDHEX$$lection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

type dw_4 from u_datawindow_accueil within w_accueil_consultation
boolean visible = false
integer x = 41
integer y = 304
integer width = 2885
integer height = 1096
integer taborder = 50
boolean vscrollbar = true
boolean border = false
end type

event ue_modifiermenu;call super::ue_modifiermenu;//*****************************************************************************
//
// Objet 		: dw_1
// Evenement 	: ue_ModifierMenu
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Pour la consultation le modifier se transforme en consulter
//					  Le rest disparait
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************



uf_Mnu_SupprimerItem ( 1 )
uf_Mnu_SupprimerItem ( 3 )
uf_Mnu_ChangerText ( 2, "Consulter" )
If ( ilLigneClick > 0 ) Then
	uf_Mnu_AutoriserItem ( 2 )
Else
	uf_Mnu_InterdirItem ( 2 )
End If

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event rbuttondown;//Migration PB8-WYNIWYG-03/2006 OR
//ce code remplace le code de l'anc$$HEX1$$ea00$$ENDHEX$$tre, 
//il permet la s$$HEX1$$e900$$ENDHEX$$lection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

type dw_5 from u_datawindow_accueil within w_accueil_consultation
boolean visible = false
integer x = 41
integer y = 304
integer width = 2885
integer height = 1096
integer taborder = 40
boolean vscrollbar = true
boolean border = false
end type

event ue_modifiermenu;call super::ue_modifiermenu;//*****************************************************************************
//
// Objet 		: dw_1
// Evenement 	: ue_ModifierMenu
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Pour la consultation le modifier se transforme en consulter
//					  Le rest disparait
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************



uf_Mnu_SupprimerItem ( 1 )
uf_Mnu_SupprimerItem ( 3 )
uf_Mnu_ChangerText ( 2, "Consulter" )
If ( ilLigneClick > 0 ) Then
	uf_Mnu_AutoriserItem ( 2 )
Else
	uf_Mnu_InterdirItem ( 2 )
End If

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event rbuttondown;//Migration PB8-WYNIWYG-03/2006 OR
//ce code remplace le code de l'anc$$HEX1$$ea00$$ENDHEX$$tre, 
//il permet la s$$HEX1$$e900$$ENDHEX$$lection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

type dw_6 from u_datawindow_accueil within w_accueil_consultation
boolean visible = false
integer x = 41
integer y = 304
integer width = 2885
integer height = 1096
integer taborder = 30
boolean vscrollbar = true
boolean border = false
end type

event ue_modifiermenu;call super::ue_modifiermenu;//*****************************************************************************
//
// Objet 		: dw_1
// Evenement 	: ue_ModifierMenu
//	Auteur		: La Recrue
//	Date			: 15/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Pour la consultation le modifier se transforme en consulter
//					  Le rest disparait
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************



uf_Mnu_SupprimerItem ( 1 )
uf_Mnu_SupprimerItem ( 3 )
uf_Mnu_ChangerText ( 2, "Consulter" )
If ( ilLigneClick > 0 ) Then
	uf_Mnu_AutoriserItem ( 2 )
Else
	uf_Mnu_InterdirItem ( 2 )
End If

//Migration PB8-WYNIWYG-03/2006 OR
return 0
//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

event rbuttondown;//Migration PB8-WYNIWYG-03/2006 OR
//ce code remplace le code de l'anc$$HEX1$$ea00$$ENDHEX$$tre, 
//il permet la s$$HEX1$$e900$$ENDHEX$$lection de la ligne sur le click droit

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 OR

end event

type uo_1 from u_bord3d within w_accueil_consultation
integer x = 27
integer y = 292
integer width = 2907
integer height = 1116
integer taborder = 90
end type

on uo_1.destroy
call u_bord3d::destroy
end on

type pb_imprimer from u_pbimprimer within w_accueil_consultation
boolean visible = false
integer x = 878
integer y = 32
integer width = 265
integer height = 152
integer taborder = 10
boolean enabled = false
string disabledname = ""
end type

