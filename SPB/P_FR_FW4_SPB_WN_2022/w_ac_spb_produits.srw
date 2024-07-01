HA$PBExportHeader$w_ac_spb_produits.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil de consultation des produits
forward
global type w_ac_spb_produits from w_8_accueil_consultation
end type
end forward

global type w_ac_spb_produits from w_8_accueil_consultation
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Consultation des produits"
end type
global w_ac_spb_produits w_ac_spb_produits

type variables
s_datainterro	stDataInterroNull[]
end variables

on ue_preparer_interro;call w_8_accueil_consultation::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_si_produit
//* Evenement 		:	ue_preparer_interro
//* Auteur			:	PLJ
//* Date				:	07/01/1999
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Charge les datawindows de la fen$$HEX1$$ea00$$ENDHEX$$tre d'int$$HEX1$$e900$$ENDHEX$$rrogation.
//* Commentaires	:	Chargement des produits
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild	dwcTemp

w_interro_consultation.dw_1.GetChild ( "ID_PROD", dwcTemp )
dwcTemp.SetTransObject ( itrTrans )
dwcTemp.Retrieve()
end on

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_produits
//* Evenement 		: Open
//* Auteur			: YP
//* Date				: 12/09/1997 16:07:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation des Dw d'accueil.
//* Commentaires	: Aucun
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	JCA		15/11/2006		DCMP 060825 - plus de limitation du nbr de ligne de retour
//*-----------------------------------------------------------------


//Migration PB8-WYNIWYG-03/2006 CP
//String 	sTables[2]		//Tableau des tables d'une DW.
String sTables []
//Fin Migration PB8-WYNIWYG-03/2006 CP


dw_1.ilMaxLig = 0 // #1

itrTrans = SQLCA

// .... Description de la DW d'accueil

/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des Produits."

/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil                                 */
/*------------------------------------------------------------------*/
dw_1.istCol[1].sDbName		=	"sysadm.produit.id_prod"
dw_1.istCol[1].sType			=	"number"
dw_1.istCol[1].sHeaderName	=	"Id Prod"
dw_1.istCol[1].ilargeur		=	8
dw_1.istCol[1].sAlignement	=	"2"
dw_1.istCol[1].sInvisible	= 	"N"

dw_1.istCol[2].sDbName		=	"sysadm.produit.lib_long"
dw_1.istCol[2].sType			=	"char(35)"
dw_1.istCol[2].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_1.istCol[2].ilargeur		=	30
dw_1.istCol[2].sAlignement	=	"0"
dw_1.istCol[2].sInvisible	= 	"N"

dw_1.istCol[3].sDbName		=	"sysadm.departement.lib_dept"
dw_1.istCol[3].sType			=	"char(35)"
dw_1.istCol[3].sHeaderName	=	"D$$HEX1$$e900$$ENDHEX$$partement"
dw_1.istCol[3].ilargeur		=	30
dw_1.istCol[3].sAlignement	=	"0"
dw_1.istCol[3].sInvisible	= 	"N"

dw_1.istCol[4].sDbName		=	"sysadm.produit.maj_le"
dw_1.istCol[4].sType			=	"Datetime"
dw_1.istCol[4].sHeaderName	=	"Maj Le"
dw_1.istCol[4].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol[4].ilargeur		=	20
dw_1.istCol[4].sAlignement	=	"2"
dw_1.istCol[4].sInvisible	= 	"N"

dw_1.istCol[5].sDbName		=	"sysadm.produit.maj_par"
dw_1.istCol[5].sType			=	"char(4)"
dw_1.istCol[5].sHeaderName	=	"Par"
dw_1.istCol[5].ilargeur		=	4
dw_1.istCol[5].sAlignement	=	"2"
dw_1.istCol[5].sInvisible	= 	"N"


sTables[ 2 ]   = "departement"
sTables[ 1 ]	= "produit"

dw_1.isJointure = "And sysadm.produit.id_dept = sysadm.departement.id_dept"

dw_1.isTri 		= "#1 A"

// .... Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil

dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, itrTrans )



// .... Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche

pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Consultation [Recherche]"
pb_Interro.istInterro.sDataObject			= "d_spb_int_c_produit"
pb_Interro.istInterro.sCodeDw					= "CONSULTATION"


pb_Interro.istInterro.sData[1].sNom					= "id_prod"
pb_Interro.istInterro.sData[1].sDbNameConsult	= { "sysadm.produit.id_prod", "", "", "", "", "" } 
pb_Interro.istInterro.sData[1].sType				= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande			= "="
pb_Interro.istInterro.sData[1].sMoteur				= "MSS"

pb_Interro.istInterro.sData[2].sNom					= "lib_long"
pb_Interro.istInterro.sData[2].sDbNameConsult	= { "sysadm.produit.lib_long", "", "", "", "", "" }
pb_Interro.istInterro.sData[2].sType				= "STRING"
pb_Interro.istInterro.sData[2].sOperande			= "="

pb_Interro.istInterro.sData[3].sNom					= "maj_le1"
pb_Interro.istInterro.sData[3].sDbNameConsult	= { "sysadm.produit.maj_le", "", "", "", "", "" }
pb_Interro.istInterro.sData[3].sType				= "DATETIME"
pb_Interro.istInterro.sData[3].sOperande			= ">="

pb_Interro.istInterro.sData[4].sNom					= "maj_le2"
pb_Interro.istInterro.sData[4].sDbNameConsult	= { "sysadm.produit.maj_le", "", "", "", "", "" }
pb_Interro.istInterro.sData[4].sType				= "DATETIME"
pb_Interro.istInterro.sData[4].sOperande			= "<="


pb_Interro.istInterro.sData[5].sNom					= "maj_par"
pb_Interro.istInterro.sData[5].sDbNameConsult	= { "sysadm.produit.maj_par", "", "", "", "", "" }
pb_Interro.istInterro.sData[5].sType				= "STRING"
pb_Interro.istInterro.sData[5].sOperande			= "="

iuAccueilCourrant = Dw_1

istPass.trTrans 	= itrTrans


end event

on ue_taillerhauteur;call w_8_accueil_consultation::ue_taillerhauteur;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_produits
//* Evenement 		: ue_taillerhauteur
//* Auteur			: YP
//* Date				: 12/09/97 16:22:55
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
//* Objet 			: w_ac_spb_produits
//* Evenement 		: ue_fin_interro ( OVERRIDE )
//* Auteur			: YP
//* Date				: 12/09/97 16:15:51
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

CALL w_accueil_consultation::ue_fin_interro

This.TriggerEvent( "Ue_TaillerHauteur" )

Dw_1.Visible = TRUE

Dw_1.SetFocus ( )
end on

on ue_centreracc;call w_8_accueil_consultation::ue_centreracc;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_produits
//* Evenement 		: ue_centrerAcc
//* Auteur			: YP
//* Date				: 12/09/97 16:16:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Centre la DW dans la fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

dw_1.Uf_Largeur ( This.Width , 0 )


end on

on w_ac_spb_produits.create
int iCurrent
call super::create
end on

on w_ac_spb_produits.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_8_accueil_consultation`pb_retour within w_ac_spb_produits
end type

type pb_interro from w_8_accueil_consultation`pb_interro within w_ac_spb_produits
end type

type pb_tri from w_8_accueil_consultation`pb_tri within w_ac_spb_produits
end type

type uo_onglet from w_8_accueil_consultation`uo_onglet within w_ac_spb_produits
end type

type dw_1 from w_8_accueil_consultation`dw_1 within w_ac_spb_produits
integer y = 200
integer width = 690
integer height = 700
boolean border = true
end type

type dw_2 from w_8_accueil_consultation`dw_2 within w_ac_spb_produits
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
end type

type dw_3 from w_8_accueil_consultation`dw_3 within w_ac_spb_produits
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
end type

type dw_4 from w_8_accueil_consultation`dw_4 within w_ac_spb_produits
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
end type

type dw_5 from w_8_accueil_consultation`dw_5 within w_ac_spb_produits
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
end type

type dw_6 from w_8_accueil_consultation`dw_6 within w_ac_spb_produits
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
end type

type uo_1 from w_8_accueil_consultation`uo_1 within w_ac_spb_produits
boolean visible = false
integer x = 32
integer width = 3013
boolean enabled = false
end type

type pb_imprimer from w_8_accueil_consultation`pb_imprimer within w_ac_spb_produits
boolean visible = true
end type

