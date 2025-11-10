HA$PBExportHeader$w_trt_choix_regen_courrier.srw
forward
global type w_trt_choix_regen_courrier from window
end type
type cb_continuer from commandbutton within w_trt_choix_regen_courrier
end type
type cb_arreter from commandbutton within w_trt_choix_regen_courrier
end type
type dw_1 from datawindow within w_trt_choix_regen_courrier
end type
end forward

global type w_trt_choix_regen_courrier from window
integer x = 215
integer y = 220
integer width = 1504
integer height = 580
boolean titlebar = true
string title = "Pr$$HEX1$$e900$$ENDHEX$$paration des courriers"
windowtype windowtype = response!
long backcolor = 12632256
cb_continuer cb_continuer
cb_arreter cb_arreter
dw_1 dw_1
end type
global w_trt_choix_regen_courrier w_trt_choix_regen_courrier

type variables
Private :
	S_Pass		invTrtAttrib

	Boolean		ibFermerFenetre

	String		isZn_IdInter

	String		isZn_CodInter
	String		isAutresDroits
end variables

forward prototypes
private subroutine wf_positionnerobjet ()
private subroutine wf_affecter_typdoc ()
end prototypes

private subroutine wf_positionnerobjet ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Choix_Regen_Courrier::Wf_PositionnerObjet		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 13/10/2001 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Positionnement dynamique des objets de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Position de la fen$$HEX1$$ea00$$ENDHEX$$tre.                                          */
/*------------------------------------------------------------------*/
This.X			=  900
This.Y			= 1500 
This.Width		= 3990
This.Height		=  750

/*------------------------------------------------------------------*/
/* Position de la DataWindow.                                       */
/*------------------------------------------------------------------*/
Dw_1.X			=   15
Dw_1.Y			=   35
Dw_1.Width		= 3940
Dw_1.Height		=  440

/*------------------------------------------------------------------*/
/* Position des Boutons de commande.                                */
/*------------------------------------------------------------------*/
Cb_Arreter.X	=  1560
Cb_Arreter.Y	=   530

Cb_Continuer.X	=  2030
Cb_Continuer.Y	=   530


end subroutine

private subroutine wf_affecter_typdoc ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Choix_Regen_Courrier::Wf_Affecter_TypDoc		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 13/10/2001 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	    Modification
//* #1		 JFF		04/05/04  DCMP 040020 SVE
//*-----------------------------------------------------------------

Long		lTotLig, lCpt, lLig, lTotInter
String	sRech

/*------------------------------------------------------------------*/
/* Pour SAVANE, on ne conserve pas le COD_BQ de l'interlocuteur de  */
/* type BANQUE, donc la gestion des courriers BNP est impossible.   */
/*------------------------------------------------------------------*/
If	invTrtAttrib.sTab[1] = "SAVANE" Then Return

/*------------------------------------------------------------------*/
/* Si le Code Banque appartient $$HEX2$$e0002000$$ENDHEX$$BNP, on le positionne dans le     */
/* type de document afin de pr$$HEX1$$e900$$ENDHEX$$venir le gestionnaire.               */
/*------------------------------------------------------------------*/
lTotLig		= dw_1.RowCount ()
lTotInter	= invTrtAttrib.dwTab[1].RowCount ()

For	lCpt = 1 To lTotLig 

/*------------------------------------------------------------------*/
/* #1 : Priorit$$HEX2$$e9002000$$ENDHEX$$au droits fournis par le BIN.                      */
/*------------------------------------------------------------------*/
/* Rang 9 : Gestionnaire DSC                                        */
/*------------------------------------------------------------------*/
		If Mid ( isAutresDroits, 9, 1 ) = "1" Then
			dw_1.SetItem ( lCpt, "ID_TYP_DOC", 5 ) 		// ... Retour DSC
			Continue			
		End If

		If Upper ( dw_1.GetItemString ( lCpt, "COD_INTER" ) ) = "B" Then
/*------------------------------------------------------------------*/
/* On recherche la ligne correspondant $$HEX2$$e0002000$$ENDHEX$$l'interlocuteur BANQUE     */
/* dans la liste des interlocuteurs.                                */
/*------------------------------------------------------------------*/
			Choose Case invTrtAttrib.sTab[1]
			Case "SAVANE"
				sRech	= isZn_IdInter + " = '" + String ( dw_1.GetItemNumber ( lCpt, "ID_INTER" ) ) + "'"
			Case "SIMPA2", "SINDI"
				sRech	= isZn_IdInter + " = " + String ( dw_1.GetItemNumber ( lCpt, "ID_INTER"  ) )
			End Choose

			lLig	= invTrtAttrib.dwTab[1].Find ( sRech, 1, lTotInter )
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie s'il s'agit de la BNP.                                */
/*------------------------------------------------------------------*/
			If invTrtAttrib.dwTab[1].GetItemString ( lLig, "COD_BQ" ) = "30004" Then
				dw_1.SetItem ( lCpt, "ID_TYP_DOC", 1 ) 		// ... BNP
			End If
		End If	

Next

end subroutine

event open;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Choix_Regen_Courrier
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 15/10/2001 14:58:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    JFF    04/05/2004  DCMP 04020 SVE
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* La structure de passage doit $$HEX1$$ea00$$ENDHEX$$tre arm$$HEX1$$e900$$ENDHEX$$e de la mani$$HEX1$$e800$$ENDHEX$$re suivante.  */
/*------------------------------------------------------------------*/
/* dwNorm[1] = Liste des types de documents.                        */
/* dwNorm[2] = Liste des courriers $$HEX2$$e0002000$$ENDHEX$$recopier dans Dw_1.            */
/*                                                                  */
/* dwTab[1]  = Liste des Interlocuteurs. U_DataWindow_Detail        */
/*                                                                  */
/* sTab[1]   = Nom de l'application (SAVANE,SIMPA2,SINDI)           */
/* sTab[2]   = Arm$$HEX1$$e900$$ENDHEX$$e en sortie de fen$$HEX1$$ea00$$ENDHEX$$tre par CONTINUER/ARRETER.    */
/*------------------------------------------------------------------*/

invTrtAttrib = Message.PowerObjectParm
DataWindowchild	dwChild, dwChild1
Long					lTotLigne
String 				sFiltre

/*------------------------------------------------------------------*/
/* Positionnement des objets dans la fen$$HEX1$$ea00$$ENDHEX$$tre.                       */
/*------------------------------------------------------------------*/
This.Wf_PositionnerObjet ()

/*------------------------------------------------------------------*/
/* Droit $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$couper (voir u_gs_sp_sinistre::uf_GetAutorisation)     */
/*------------------------------------------------------------------*/
isAutresDroits = invTrtAttrib.sTab[2]

/*------------------------------------------------------------------*/
/* En fonction de l'application SAVANE, SIMPA2, SINDI les noms de   */
/* colonnes sont diff$$HEX1$$e900$$ENDHEX$$rents. Il faut donc armer une constante pour  */
/* que cette fen$$HEX1$$ea00$$ENDHEX$$tre puisse fonctionner dans tous les cas de        */
/* figure.                                                          */
/*------------------------------------------------------------------*/
Choose Case invTrtAttrib.sTab[1]
Case "SAVANE"
	isZn_IdInter	= "ID_I"
	isZn_CodInter	= "COD_I"
Case "SIMPA2"
	isZn_IdInter	= "ID_I"
	isZn_CodInter	= "COD_INTER"
	dw_1.DataObject = "d_stk_choix_regen_courrier_sim2"
End Choose

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret
ll_ret = Dw_1.Reset ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

This.Title = "Pr$$HEX1$$e900$$ENDHEX$$paration des courriers."
dw_1.Modify ( "p_attention.filename = 'K:\PB4OBJ\BMP\EXCL2.BMP'" )
ibFermerFenetre = FALSE

/*------------------------------------------------------------------*/
/* Armement des DDDW.                                               */
/*------------------------------------------------------------------*/
ll_ret = dw_1.GetChild ( "ID_TYP_DOC", dwChild )	//dddw_spb_code
//Migration PB8-WYNIWYG-03/2006 FM
ll_ret = dwChild.SetTransObject(SQLCA)
//Fin Migration PB8-WYNIWYG-03/2006 FM
ll_ret = invTrtAttrib.dwNorm[1].ShareData ( dwChild )

ll_ret = dw_1.GetChild ( "COD_INTER", ( dwChild ) )	//dddw_sp_code_car
//Migration PB8-WYNIWYG-03/2006 FM
ll_ret = dwChild.SetTransObject(SQLCA)
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case invTrtAttrib.sTab[1]
	Case "SAVANE"
		invTrtAttrib.dwTab[1].GetChild ( "COD_I", ( dwChild1 ) )
	Case "SIMPA2"
		ll_ret = invTrtAttrib.dwTab[1].GetChild ( "COD_INTER", ( dwChild1 ) )
End Choose


ll_ret = dwChild1.ShareData ( dwChild )


/*------------------------------------------------------------------*/
/* Recopie des lignes dans Dw_1.                                    */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//ll_ret = Dw_1.Reset ()
//Fin Migration PB8-WYNIWYG-03/2006 FM
lTotLigne = invTrtAttrib.dwNorm[2].RowCount ()
invTrtAttrib.dwNorm[2].RowsCopy ( 1, lTotLigne, Primary!, dw_1, 1, Primary! )

/*------------------------------------------------------------------*/
/* Affectation des types de documents.                              */
/*------------------------------------------------------------------*/
This.wf_Affecter_TypDoc ()

/*------------------------------------------------------------------*/
/* On positionne le focus sur le bouton Continuer.                  */
/*------------------------------------------------------------------*/
cb_Continuer.SetFocus ()

end event

on w_trt_choix_regen_courrier.create
this.cb_continuer=create cb_continuer
this.cb_arreter=create cb_arreter
this.dw_1=create dw_1
this.Control[]={this.cb_continuer,&
this.cb_arreter,&
this.dw_1}
end on

on w_trt_choix_regen_courrier.destroy
destroy(this.cb_continuer)
destroy(this.cb_arreter)
destroy(this.dw_1)
end on

type cb_continuer from commandbutton within w_trt_choix_regen_courrier
integer x = 910
integer y = 44
integer width = 306
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Continuer"
boolean default = true
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Choix_Regen_Courrier::Cb_Continuer
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 15/10/2001 14:58:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1    DGA   01/02/2002   Gestion du WORD
//* 
//*-----------------------------------------------------------------

Long lTotLig, lCpt, lCpt1
String sWord
N_Cst_Word	nvWord

SetPointer ( HourGlass! )

/*------------------------------------------------------------------*/
/* On recopie la DataWindow Dw_1 dans la structure de passage. On   */
/* positionne l'option qui indique que l'on peut continuer le       */
/* traitement.                                                      */
/*------------------------------------------------------------------*/
invTrtAttrib.dwNorm[2].Reset ()
lTotLig = dw_1.RowCount ()

dw_1.RowsCopy ( 1, lTotLig, Primary!, invTrtAttrib.dwNorm[2], 1, Primary! )
ibFermerFenetre = TRUE

invTrtAttrib.sTab[2] = "CONTINUER"
		
//F_SetVersionWord ( nvWord, TRUE )																	// #1  MISE EN COMMENTAIRE DE CES LIGNES
//sWord = ProfileString ( stGLB.sFichierIni, "EDITION", "REP_WORD", "" )				// #1  CF fonction 
//If	nvWord.uf_WordOuvert () = 0	Then Run ( sWord, Minimized! )						// #1  w_tm_sa_sinistre::Wf_Script_Client_Focus 
//
//For	lCpt = 1 To 5000																					// #1
//		Yield ()																								// #1
//		Yield ()																								// #1
//Next																										// #1
//
//F_SetVersionWord ( nvWord, FALSE )																// #1

CloseWithReturn ( Parent, invTrtAttrib )
end on

type cb_arreter from commandbutton within w_trt_choix_regen_courrier
integer x = 567
integer y = 44
integer width = 306
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Arr$$HEX1$$ea00$$ENDHEX$$ter"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Choix_Regen_Courrier::Cb_Arreter
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 15/10/2001 14:58:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: 
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------


SetPointer ( HourGlass! )

ibFermerFenetre = TRUE

invTrtAttrib.sTab[2] = "ARRETER"

CloseWithReturn ( Parent, invTrtAttrib )


end on

type dw_1 from datawindow within w_trt_choix_regen_courrier
integer x = 23
integer y = 44
integer width = 494
integer height = 360
integer taborder = 10
string dataobject = "d_stk_choix_regen_courrier"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

