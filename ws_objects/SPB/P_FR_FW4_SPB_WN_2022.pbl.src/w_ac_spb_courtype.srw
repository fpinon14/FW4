HA$PBExportHeader$w_ac_spb_courtype.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil de consultation des courriers type du param$$HEX1$$e800$$ENDHEX$$trage.
forward
global type w_ac_spb_courtype from w_8_accueil_consultation
end type
end forward

global type w_ac_spb_courtype from w_8_accueil_consultation
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Consultation des courriers type"
end type
global w_ac_spb_courtype w_ac_spb_courtype

type variables
s_datainterro	stDataInterroNull[]
end variables

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_si_courtype
//* Evenement 		: Open
//* Auteur			: YP
//* Date				: 22/09/1997 18:07:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation des Dw d'accueil.
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	JCA		15/11/2006		DCMP 060825 - plus de limitation du nbr de ligne de retour
//*-----------------------------------------------------------------


//Migration PB8-WYNIWYG-03/2006 CP
//String sTables [ 1 ]			// Table du SELECT
String sTables []
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Affecte l'object de transaction $$HEX2$$e0002000$$ENDHEX$$la variable d'instance.        */
/*------------------------------------------------------------------*/
iTrTrans = SQLCA

/*------------------------------------------------------------------*/
/* porte la limitation du nombre de lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$1000 au  */
/* lieu des 150 par d$$HEX1$$e900$$ENDHEX$$faut.                                         */
/*------------------------------------------------------------------*/
dw_1.ilMaxLig = 0 // #1

/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des Courriers Types."

/*----------------------------------------------------------------------------*/
/* Initialisation de la DW courante par d$$HEX1$$e900$$ENDHEX$$faut.                               */
/*----------------------------------------------------------------------------*/
iuAccueilCourrant = Dw_1

/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil                                 */
/*------------------------------------------------------------------*/
dw_1.istCol [ 1 ].sDbName		=	"sysadm.cour_type.id_cour"
dw_1.istCol [ 1 ].sType			=	"char(6)"
dw_1.istCol [ 1 ].sHeaderName	=	"Courrier"
dw_1.istCol [ 1 ].ilargeur		=	9
dw_1.istCol [ 1 ].sAlignement	=	"2"
dw_1.istCol [ 1 ].sInvisible	= 	"N"

dw_1.istCol [ 2 ].sDbName		=	"sysadm.cour_type.lib_cour"
dw_1.istCol [ 2 ].sType			=	"char(35)"
dw_1.istCol [ 2 ].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_1.istCol [ 2 ].ilargeur		=	36
dw_1.istCol [ 2 ].sAlignement	=	"0"
dw_1.istCol [ 2 ].sInvisible	= 	"N"

dw_1.istCol [ 3 ].sDbName		=	"sysadm.cour_type.maj_le"
dw_1.istCol [ 3 ].sType			=	"Datetime"
dw_1.istCol [ 3 ].sHeaderName	=	"Maj Le"
dw_1.istCol [ 3 ].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol [ 3 ].ilargeur		=	20
dw_1.istCol [ 3 ].sAlignement	=	"2"
dw_1.istCol [ 3 ].sInvisible	= 	"N"

dw_1.istCol [ 4 ].sDbName		=	"sysadm.cour_type.maj_par"
dw_1.istCol [ 4 ].sType			=	"char(4)"
dw_1.istCol [ 4 ].sHeaderName	=	"Par"
dw_1.istCol [ 4 ].ilargeur		=	4
dw_1.istCol [ 4 ].sAlignement	=	"2"
dw_1.istCol [ 4 ].sInvisible	= 	"N"

sTables  [  1  ]	=  "cour_type"

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut de la Data Window d'accueil.                      */
/*------------------------------------------------------------------*/
Dw_1.isTri = "#1 A"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, itrTrans )

wf_Construire_Chaine_Tri()

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des Courriers Types"
pb_Interro.istInterro.sDataObject			= "d_spb_int_courtype"
pb_Interro.istInterro.sCodeDw					= "COURTYP"

pb_Interro.istInterro.sData[1].sNom					= "id_cour"
pb_Interro.istInterro.sData[1].sDbNameConsult	= { "sysadm.cour_type.id_cour", "", "", "", "", "" } 
pb_Interro.istInterro.sData[1].sType				= "STRING"
pb_Interro.istInterro.sData[1].sOperande			= "="

pb_Interro.istInterro.sData[2].sNom					= "lib_cour"
pb_Interro.istInterro.sData[2].sDbNameConsult	= { "sysadm.cour_type.lib_cour", "", "", "", "", "" } 
pb_Interro.istInterro.sData[2].sType				= "STRING"
pb_Interro.istInterro.sData[2].sOperande			= "="

pb_Interro.istInterro.sData[3].sNom					= "maj_le1"
pb_Interro.istInterro.sData[3].sDbNameConsult	= { "sysadm.cour_type.maj_le", "", "", "", "", "" } 
pb_Interro.istInterro.sData[3].sType				= "DATETIME"
pb_Interro.istInterro.sData[3].sOperande			= ">="

pb_Interro.istInterro.sData[4].sNom					= "maj_le2"
pb_Interro.istInterro.sData[4].sDbNameConsult	= { "sysadm.cour_type.maj_le", "", "", "", "", "" } 
pb_Interro.istInterro.sData[4].sType				= "DATETIME"
pb_Interro.istInterro.sData[4].sOperande			= "<="

pb_Interro.istInterro.sData[5].sNom					= "maj_par"
pb_Interro.istInterro.sData[5].sDbNameConsult	= { "sysadm.cour_type.maj_par", "", "", "", "", "" } 
pb_Interro.istInterro.sData[5].sType				= "STRING"
pb_Interro.istInterro.sData[5].sOperande			= "="

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= False		// Utilisation du bouton VALIDER


end event

on ue_taillerhauteur;call w_8_accueil_consultation::ue_taillerhauteur;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_si_courtype
//* Evenement 		: ue_taillerhauteur
//* Auteur			: YP
//* Date				: 23/09/97 10:56:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Retaille la fen$$HEX1$$ea00$$ENDHEX$$tre en hauteur.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

dw_1.Uf_Hauteur ( This.Height, 0 )

If Dw_1.Visible = False Then Dw_1.Visible = TRUE
end on

on ue_fin_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_si_courtype
//* Evenement 		: ue_fin_interro ( OVERRIDE )
//* Auteur			: YP
//* Date				: 23/09/97 10:56:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Retaille la fen$$HEX1$$ea00$$ENDHEX$$tre en hauteur.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* Le Visible FALSE/TRUE permet d'$$HEX1$$e900$$ENDHEX$$viter des probl$$HEX1$$e800$$ENDHEX$$mes de flicking.           */
/*----------------------------------------------------------------------------*/
Dw_1.Visible = FALSE

Call w_accueil_consultation::ue_fin_interro

This.TriggerEvent( "Ue_TaillerHauteur" )

Dw_1.Visible = TRUE

Dw_1.SetFocus ( )
end on

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_courtype
//* Evenement 		: ue_modifier
//* Auteur			: YP
//* Date				: 23/09/1997 10:57:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des d$$HEX1$$e900$$ENDHEX$$tails.
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
w_ancetre_consultation	wTemp		//Instance de fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre de consultation.
s_Pass						stPass	//Structure de passage de param$$HEX1$$e800$$ENDHEX$$tre.

stPass = istPass

stPass.bEnableParent = False

If Dw_1.IlLigneClick > 0 Then

//Migration PB8-WYNIWYG-03/2006 FM
//	stPass.sTab[ 1 ] = dw_1.GetItemString( dw_1.ilLigneClick, "COUR_TYPE.ID_COUR" )
	stPass.sTab[ 1 ] = dw_1.GetItemString( dw_1.ilLigneClick, "ID_COUR" )
//Fin Migration PB8-WYNIWYG-03/2006 FM

	If ( wf_Is_Mode_Mdi () ) Then

		f_OuvreConsultation (  wtemp, "w_dc_spb_courtype", stPass )

	Else

		f_OuvreConsultation (  w_dc_spb_courtype, "", stPass )

	End If

End If

end event

on ue_centreracc;call w_8_accueil_consultation::ue_centreracc;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_si_courtype
//* Evenement 		: ue_centrerAcc
//* Auteur			: YP
//* Date				: 23/09/97 10:56:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Centre la DW dans la fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

dw_1.Uf_Largeur ( This.Width , 0 )
end on

on w_ac_spb_courtype.create
int iCurrent
call super::create
end on

on w_ac_spb_courtype.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_8_accueil_consultation`pb_retour within w_ac_spb_courtype
end type

type pb_interro from w_8_accueil_consultation`pb_interro within w_ac_spb_courtype
end type

type pb_tri from w_8_accueil_consultation`pb_tri within w_ac_spb_courtype
end type

type uo_onglet from w_8_accueil_consultation`uo_onglet within w_ac_spb_courtype
end type

type dw_1 from w_8_accueil_consultation`dw_1 within w_ac_spb_courtype
integer y = 200
integer width = 690
integer height = 700
boolean border = true
end type

type dw_2 from w_8_accueil_consultation`dw_2 within w_ac_spb_courtype
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
end type

type dw_3 from w_8_accueil_consultation`dw_3 within w_ac_spb_courtype
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
end type

type dw_4 from w_8_accueil_consultation`dw_4 within w_ac_spb_courtype
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
end type

type dw_5 from w_8_accueil_consultation`dw_5 within w_ac_spb_courtype
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
end type

type dw_6 from w_8_accueil_consultation`dw_6 within w_ac_spb_courtype
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
end type

type uo_1 from w_8_accueil_consultation`uo_1 within w_ac_spb_courtype
boolean visible = false
integer x = 32
integer width = 3013
boolean enabled = false
end type

type pb_imprimer from w_8_accueil_consultation`pb_imprimer within w_ac_spb_courtype
boolean visible = true
end type

