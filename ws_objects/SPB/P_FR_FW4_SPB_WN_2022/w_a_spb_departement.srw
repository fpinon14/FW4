HA$PBExportHeader$w_a_spb_departement.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e900$$ENDHEX$$trage des d$$HEX1$$e900$$ENDHEX$$partements
forward
global type w_a_spb_departement from w_8_accueil
end type
end forward

global type w_a_spb_departement from w_8_accueil
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Gestion des d$$HEX1$$e900$$ENDHEX$$partements"
end type
global w_a_spb_departement w_a_spb_departement

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			:	W_A_Spb_Departement
//* Evenement 		:	OPEN - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	29/05/97 16:05:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Organisation de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le  
//						 	param$$HEX1$$e900$$ENDHEX$$trage des D$$HEX1$$e900$$ENDHEX$$partements de la SPB.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 CP
//String sTables[1]		//Tableau pour les tables d'ou proviennent les champs de la datawindow.
String sTables []
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Affecte l'object de transaction $$HEX2$$e0002000$$ENDHEX$$la variable d'instance.        */
/*------------------------------------------------------------------*/
iTrTrans = SQLCA

/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des D$$HEX1$$e900$$ENDHEX$$partements."

/*------------------------------------------------------------------*/
/* Description de la DW d'accueil                                   */
/*------------------------------------------------------------------*/
dw_1.istCol[1].sDbName		=	"sysadm.departement.id_dept"
dw_1.istCol[1].sType			=	"Number"
dw_1.istCol[1].sHeaderName	=	"D$$HEX1$$e900$$ENDHEX$$pt."
dw_1.istCol[1].ilargeur		=	3
dw_1.istCol[1].sAlignement	=	"2"
dw_1.istCol[1].sInvisible	= 	"N"

dw_1.istCol[2].sDbName		=	"sysadm.departement.lib_dept"
dw_1.istCol[2].sType			=	"char(35)"
dw_1.istCol[2].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_1.istCol[2].ilargeur		=	35
dw_1.istCol[2].sAlignement	=	"0"
dw_1.istCol[2].sInvisible	= 	"N"

dw_1.istCol[3].sDbName		=	"sysadm.departement.maj_le"
dw_1.istCol[3].sType			=	"datetime"
dw_1.istCol[3].sHeaderName	=	"Maj le"
dw_1.istCol[3].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol[3].ilargeur		=	19
dw_1.istCol[3].sAlignement	=	"2"
dw_1.istCol[3].sInvisible	= 	"N"

dw_1.istCol[4].sDbName		=	"sysadm.departement.maj_par"
dw_1.istCol[4].sType			=	"char(4)"
dw_1.istCol[4].sHeaderName	=	"Par"
dw_1.istCol[4].ilargeur		=	4
dw_1.istCol[4].sAlignement	=	"2"
dw_1.istCol[4].sInvisible	= 	"N"

sTables[ 1 ]	= "departement"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, iTrTrans )

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut sur l'identifiant des d$$HEX1$$e900$$ENDHEX$$partements.               */
/*------------------------------------------------------------------*/
dw_1.isTri = "#1 A"

wf_Construire_Chaine_Tri()

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/

pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des d$$HEX1$$e900$$ENDHEX$$partements"
pb_Interro.istInterro.sDataObject			= "d_spb_int_departement"
pb_Interro.istInterro.sCodeDw					= "DEPARTEMENT"

pb_Interro.istInterro.sData[1].sNom			= "id_dept"
pb_Interro.istInterro.sData[1].sDbName		= "sysadm.departement.id_dept"
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="
pb_Interro.istInterro.sData[1].sMoteur		= "MSS"

pb_Interro.istInterro.sData[2].sNom			= "lib_dept"
pb_Interro.istInterro.sData[2].sDbName		= "sysadm.departement.lib_dept"
pb_Interro.istInterro.sData[2].sType		= "STRING"
pb_Interro.istInterro.sData[2].sOperande	= "="


/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= False		// Utilisation de VALIDE uniquement

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_preparer_interro;call super::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet			:	W_A_Spb_Departement
//* Evenement 		:	ue_preparer_interro
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	29/05/97 16:11:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise l'object de transaction pour la dddw
//*					 	des d$$HEX1$$e900$$ENDHEX$$partements.
//* Commentaires	:	
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*
//*-----------------------------------------------------------------

DataWindowChild		dwDept

w_Interro.dw_1.Uf_SetTransObject ( itrTrans )

W_Interro.Dw_1.GetChild ( "ID_DEPT", dwDept )
dwDept.SetTransObject ( itrTrans )
dwDept.Retrieve ( )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_departement
//* Evenement 		:	UE_CREER - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	29/05/97 16:07:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX1$$e900$$ENDHEX$$ation d'un nouveau d$$HEX1$$e900$$ENDHEX$$partement.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

f_OuvreTraitement ( W_T_Spb_Departement, istPass )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			:	W_A_Spb_Departement
//* Evenement 		:	UE_MODIFIER - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	29/05/97 16:10:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification d'un D$$HEX1$$e900$$ENDHEX$$partement.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du d$$HEX1$$e900$$ENDHEX$$partement                            */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//istPass.sTab [ 1 ] 	= String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "DEPARTEMENT.ID_DEPT" ) )
istPass.sTab [ 1 ] 	= String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_DEPT" ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Autorise la suppression d'un d$$HEX1$$e900$$ENDHEX$$partement.                        */
/*------------------------------------------------------------------*/
istPass.bSupprime	= TRUE

f_OuvreTraitement ( W_T_Spb_Departement, istPass )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_a_spb_departement.create
call super::create
end on

on w_a_spb_departement.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_8_accueil`pb_retour within w_a_spb_departement
end type

type pb_interro from w_8_accueil`pb_interro within w_a_spb_departement
end type

type pb_creer from w_8_accueil`pb_creer within w_a_spb_departement
end type

type dw_1 from w_8_accueil`dw_1 within w_a_spb_departement
end type

event dw_1::rbuttondown;//Migration PB8-WYNIWYG-03/2006 FM
//ce code replace le code de l'anc$$HEX1$$ea00$$ENDHEX$$tre

If Row > 0 Then
	This.SetRow(Row)
	SelectRow(Row, True)
end if

call super::rButtonDown

Return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			: w_a_spb_departement
//* Evenement 		: constructor
//* Auteur			: PHG
//* Date				: 02/06/2006 14:54:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [PNOLIMIT]
//* Commentaires	: On enl$$HEX1$$e800$$ENDHEX$$ve la limite des 150 lignes
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------


ilMaxLig = 0

end event

type pb_tri from w_8_accueil`pb_tri within w_a_spb_departement
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_spb_departement
boolean visible = true
boolean enabled = true
end type

