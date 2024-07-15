HA$PBExportHeader$w_a_spb_groupe.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e900$$ENDHEX$$trage des $$HEX1$$e900$$ENDHEX$$tablissements
forward
global type w_a_spb_groupe from w_8_accueil
end type
end forward

global type w_a_spb_groupe from w_8_accueil
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Gestion des groupes"
end type
global w_a_spb_groupe w_a_spb_groupe

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_groupe
//* Evenement 		:	OPEN - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	21/07/97 14:06:21
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Organisation de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le 
//*					 	param$$HEX1$$e900$$ENDHEX$$trage des groupes.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	JCA		15/11/2006		DCMP 060825 - plus de limitation du nbr de ligne de retour
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 CP
//String sTables [ 1 ]		//Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la datawindow
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
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des Groupes"

/*------------------------------------------------------------------*/
/* Description de la DW d'accueil                                   */
/*------------------------------------------------------------------*/
dw_1.istCol [ 1 ].sDbName		=	"sysadm.groupe.id_grp"
dw_1.istCol [ 1 ].sType			=	"number"
dw_1.istCol [ 1 ].sHeaderName	=	"Contractant"
dw_1.istCol [ 1 ].ilargeur		=	11
dw_1.istCol [ 1 ].sAlignement	=	"2"
dw_1.istCol [ 1 ].sInvisible	= 	"N"

dw_1.istCol [ 2 ].sDbName		=	"sysadm.groupe.id_grp_base"
dw_1.istCol [ 2 ].sType			=	"number"
dw_1.istCol [ 2 ].sHeaderName	=	"Appartient"
dw_1.istCol [ 2 ].ilargeur		=	10
dw_1.istCol [ 2 ].sAlignement	=	"2"
dw_1.istCol [ 2 ].sInvisible	= 	"N"

dw_1.istCol [ 3 ].sDbName		=	"sysadm.groupe.lib_grp"
dw_1.istCol [ 3 ].sType			=	"char(35)"
dw_1.istCol [ 3 ].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_1.istCol [ 3 ].ilargeur		=	35
dw_1.istCol [ 3 ].sAlignement	=	"0"
dw_1.istCol [ 3 ].sInvisible	= 	"N"

dw_1.istCol [ 4 ].sDbName		=	"sysadm.groupe.maj_le"
dw_1.istCol [ 4 ].sType			=	"datetime"
dw_1.istCol [ 4 ].sHeaderName	=	"Maj le"
dw_1.istCol [ 4 ].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol [ 4 ].ilargeur		=	19
dw_1.istCol [ 4 ].sAlignement	=	"2"
dw_1.istCol [ 4 ].sInvisible	= 	"N"

dw_1.istCol [ 5 ].sDbName		=	"sysadm.groupe.maj_par"
dw_1.istCol [ 5 ].sType			=	"char(4)"
dw_1.istCol [ 5 ].sHeaderName	=	"Par"
dw_1.istCol [ 5 ].ilargeur		=	4
dw_1.istCol [ 5 ].sAlignement	=	"2"
dw_1.istCol [ 5 ].sInvisible	= 	"N"

sTables [ 1 ] = "groupe"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, iTrTrans )

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut sur l'identifiant des $$HEX1$$e900$$ENDHEX$$tablissements.             */
/*------------------------------------------------------------------*/
dw_1.isTri = "#2 A, #1 A"

wf_Construire_Chaine_Tri()

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre					= This
pb_Interro.istInterro.sTitre 						= "Recherche des Groupes"
pb_Interro.istInterro.sDataObject				= "d_spb_int_groupe"
pb_Interro.istInterro.sCodeDw						= "groupe"

pb_Interro.istInterro.sData [ 1 ].sNom			= "id_grp"
pb_Interro.istInterro.sData [ 1 ].sDbName		= "sysadm.groupe.id_grp"
pb_Interro.istInterro.sData [ 1 ].sType		= "NUMBER"
pb_Interro.istInterro.sData [ 1 ].sOperande	= "="
pb_Interro.istInterro.sData [ 1 ].sMoteur		= "MSS"

pb_Interro.istInterro.sData [ 2 ].sNom			= "id_grp_base"
pb_Interro.istInterro.sData [ 2 ].sDbName		= "sysadm.groupe.id_grp_base"
pb_Interro.istInterro.sData [ 2 ].sType		= "NUMBER"
pb_Interro.istInterro.sData [ 2 ].sOperande	= "="
pb_Interro.istInterro.sData [ 2 ].sMoteur		= "MSS"

pb_Interro.istInterro.sData [ 3 ].sNom			= "lib_grp"
pb_Interro.istInterro.sData [ 3 ].sDbName		= "sysadm.groupe.lib_grp"
pb_Interro.istInterro.sData [ 3 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 3 ].sOperande	= "="


/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= False		// Utilisation de VALIDE uniquement

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_groupe
//* Evenement 		:	UE_MODIFIER - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	21/07/1997 14:22:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification d'un groupe
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du groupe                                 */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//istPass.sTab [ 1 ] = String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "GROUPE.ID_GRP" ) )
istPass.sTab [ 1 ] = String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_GRP" ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Autorise la suppression d'un groupe.                             */
/*------------------------------------------------------------------*/
istPass.bSupprime	= TRUE


f_OuvreTraitement ( w_t_spb_groupe, istPass )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_preparer_interro;call super::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_groupe
//* Evenement 		:	ue_preparer_interro
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	21/07/1997 14:23:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise l'object de transaction pour la dddw
//*					 	des groupes.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DataWindowChild		dwGrp			// DDDW pour les contractants.
DataWindowChild		dwGrpBase	// DDDW pour le groupe de base.

w_Interro.dw_1.Uf_SetTransObject ( itrTrans )

W_Interro.Dw_1.GetChild ( "ID_GRP", dwGrp )
dwGrp.SetTransObject ( itrTrans )
dwGrp.Retrieve ( )

W_Interro.Dw_1.GetChild ( "ID_GRP_BASE", dwGrpBase )
dwGrpBase.SetTransObject ( itrTrans )
dwGrpBase.Retrieve ( )
dwGrpBase.SetFilter ( "ID_GRP = ID_GRP_BASE" )
dwGrpBase.Filter   ( )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_groupe
//* Evenement 		:	UE_CREER - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	21/07/1997 14:23:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX1$$e900$$ENDHEX$$ation d'un nouveau groupe.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

f_OuvreTraitement ( w_t_spb_groupe, istPass )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_a_spb_groupe.create
call super::create
end on

on w_a_spb_groupe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_8_accueil`pb_retour within w_a_spb_groupe
end type

type pb_interro from w_8_accueil`pb_interro within w_a_spb_groupe
end type

type pb_creer from w_8_accueil`pb_creer within w_a_spb_groupe
end type

type dw_1 from w_8_accueil`dw_1 within w_a_spb_groupe
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

type pb_tri from w_8_accueil`pb_tri within w_a_spb_groupe
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_spb_groupe
boolean visible = true
boolean enabled = true
end type

