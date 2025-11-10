HA$PBExportHeader$w_a_spb_wkf_edition.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil d'$$HEX1$$e900$$ENDHEX$$dition pour le WorkFlow
forward
global type w_a_spb_wkf_edition from w_8_accueil_edition
end type
end forward

global type w_a_spb_wkf_edition from w_8_accueil_edition
integer width = 3410
integer height = 1888
event ue_workflow pbm_custom01
end type
global w_a_spb_wkf_edition w_a_spb_wkf_edition

type variables
Private:

	String	isBmpOccupe_Oui
	String	isBmpOccupe_Non
	String	isBmpBloc_Oui
	String	isBmpBloc_Non
	String	isBmpRout_Oui
	String	isBmpRout_Non

end variables

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_accueil_edition_workflow
//* Evenement 		:	Open
//* Auteur			:	La Recrue
//* Date				:	09/09/97 13:39:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil $$HEX1$$e900$$ENDHEX$$dition standard pour le Workflow.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


//Migration PB8-WYNIWYG-03/2006 CP
//String sTables[1]
String sTables []
//Fin Migration PB8-WYNIWYG-03/2006 CP

// .... Description de la DW d'accueil

dw_1.istCol[1].sDbName		=	"sysadm.w_queue.trv_maj_le"
dw_1.istCol[1].sType			=	"datetime"
dw_1.istCol[1].sHeaderName	=	"Saisie le"
dw_1.istCol[1].sAlignement	= 	"1"
dw_1.istCol[1].ilargeur		=	8
dw_1.istCol[1].sInvisible	= 	"N"
dw_1.istCol[1].sFormat		=  "dd/mm/yy"

dw_1.istCol[2].sDbName		=	"sysadm.w_queue.id_corb"
dw_1.istCol[2].sType			=	"char(3)"
dw_1.istCol[2].sHeaderName	=	"Crb"
dw_1.istCol[2].ilargeur		=	3
dw_1.istCol[2].sInvisible	= 	"N"
dw_1.istCol[2].sAlignement	=	"1"

dw_1.istCol[3].sDbName		=	"sysadm.w_queue.id_sin"  
//Migration PB8-WYNIWYG-03/2006 FM
//dw_1.istCol[3].sType			=	"char(6)"
dw_1.istCol[3].sType			=	"char(10)"  // [PI062]
dw_1.istCol[3].sHeaderName	=	"Sin."
//dw_1.istCol[3].ilargeur		=	6
dw_1.istCol[3].ilargeur		=	10  // [PI062]
//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_1.istCol[3].sAlignement	=	"2"
dw_1.istCol[3].sInvisible	= 	"N"

dw_1.istCol[4].sDbName		=	"sysadm.w_queue.nom"
//Migration PB8-WYNIWYG-03/2006 FM
//dw_1.istCol[4].sType			=	"char(30)"
dw_1.istCol[4].sType			=	"char(71)"
//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_1.istCol[4].sHeaderName	=	"Nom"
dw_1.istCol[4].ilargeur		=	20
dw_1.istCol[4].sAlignement	=	"3"
dw_1.istCol[4].sInvisible	= 	"N"

dw_1.istCol[5].sDbName		=	"sysadm.w_queue.dos_maj_le"
dw_1.istCol[5].sType			=	"datetime"
dw_1.istCol[5].sHeaderName	=	"Maj le"
dw_1.istCol[5].sFormat		=  "dd/mm/yy hh:mm"
dw_1.istCol[5].ilargeur		=	14
dw_1.istCol[5].sAlignement	=	"2"
dw_1.istCol[5].sInvisible	= 	"N"

dw_1.istCol[6].sDbName		=	"sysadm.w_queue.dos_maj_par"
dw_1.istCol[6].sType			=	"char(4)"
dw_1.istCol[6].sHeaderName	=	"Par"
dw_1.istCol[6].ilargeur		=	4
dw_1.istCol[6].sAlignement	=	"2"
dw_1.istCol[6].sInvisible	= 	"N"

dw_1.istCol[7].sDbName		=	"sysadm.w_queue.cod_etat"
dw_1.istCol[7].sType			=	"char(1)"
dw_1.istCol[7].sHeaderName	=	"Etat"
dw_1.istCol[7].sAlignement	= 	"2"
dw_1.istCol[7].ilargeur		=	3
dw_1.istCol[7].sValues		= 	"Sai	1/Edt	3/Val	5"
dw_1.istCol[7].sInvisible	= 	"O"

dw_1.istCol[8].sDbName		=	"sysadm.w_queue.alt_occupe"
dw_1.istCol[8].sType			=	"char(1)"
dw_1.istCol[8].sHeaderName	=	"Oc"
dw_1.istCol[8].sAlignement	= 	"2"
dw_1.istCol[8].ilargeur		=	2
dw_1.istCol[8].sValues		= 	isBmpOccupe_Oui + "	O/" + isBmpOccupe_Non + " 	N"
dw_1.istCol[8].sInvisible	= 	"N"
dw_1.istCol[8].sBitMap		= 	"O"

dw_1.istCol[9].sDbName		=	"sysadm.w_queue.alt_bloc"
dw_1.istCol[9].sType		=	"char(1)"
dw_1.istCol[9].sHeaderName=	"Bl"
dw_1.istCol[9].sAlignement= 	"1"
dw_1.istCol[9].ilargeur	=	2
dw_1.istCol[9].sValues		= 	isBmpBloc_Oui + "	O/" + isBmpBloc_Non + " 	N"
dw_1.istCol[9].sInvisible	= 	"N"
dw_1.istCol[9].sBitMap		= 	"O"

dw_1.istCol[10].sDbName		=	"sysadm.w_queue.trv_route_le"
dw_1.istCol[10].sType		=	"datetime"
dw_1.istCol[10].sHeaderName=	"Route Le"
dw_1.istCol[10].sAlignement= 	"1"
dw_1.istCol[10].ilargeur	=	10
dw_1.istCol[10].sInvisible	= 	"O"

dw_1.istCol[11].sDbName		=	"sysadm.w_queue.trv_route_par"
dw_1.istCol[11].sType		=	"char(4)"
dw_1.istCol[11].sHeaderName=	"Ro"
dw_1.istCol[11].sAlignement= 	"1"
dw_1.istCol[11].ilargeur	=	2
dw_1.istCol[11].sFormat		= 	"'" + isBmpRout_Oui +"';"
dw_1.istCol[11].sInvisible	= 	"N"
dw_1.istCol[11].sBitMap		= 	"O"

dw_1.istCol[12].sDbName		=	"sysadm.w_queue.txt_mess1"
dw_1.istCol[12].sType		=	"char(80)"
dw_1.istCol[12].sHeaderName=	"Message"
dw_1.istCol[12].sAlignement= 	"1"
dw_1.istCol[12].ilargeur	=	1
dw_1.istCol[12].sInvisible	= 	"O"

dw_1.istCol[13].sDbName		=	"sysadm.w_queue.trv_maj_le"
dw_1.istCol[13].sType		=	"datetime"
dw_1.istCol[13].sHeaderName=	"Maj le"
dw_1.istCol[13].sFormat		=  "dd/mm/yy hh:mm"
dw_1.istCol[13].ilargeur	=	1
dw_1.istCol[13].sInvisible	= 	"O"

dw_1.istCol[14].sDbName		=	"sysadm.w_queue.trv_maj_par"
dw_1.istCol[14].sType		=	"char(4)"
dw_1.istCol[14].sHeaderName=	"Par"
dw_1.istCol[14].ilargeur	=	4
dw_1.istCol[14].sInvisible	= 	"O"

dw_1.istCol[15].sDbName		=	"sysadm.w_queue.cod_action"
dw_1.istCol[15].sType		=	"char(1)"
dw_1.istCol[15].sHeaderName=	"Action"
dw_1.istCol[15].ilargeur	=	4
dw_1.istCol[15].sInvisible	= 	"O"

dw_1.istCol[16].sDbName		=	"sysadm.w_queue.trv_edite_le"
dw_1.istCol[16].sType		=	"datetime"
dw_1.istCol[16].sHeaderName=	"Edite le"
dw_1.istCol[16].sFormat		=  "dd/mm/yy hh:mm"
dw_1.istCol[16].ilargeur	=	1
dw_1.istCol[16].sInvisible	= 	"O"

dw_1.istCol[17].sDbName		=	"sysadm.w_queue.trv_edite_par"
dw_1.istCol[17].sType		=	"char(4)"
dw_1.istCol[17].sHeaderName=	"Par"
dw_1.istCol[17].ilargeur	=	4
dw_1.istCol[17].sInvisible	= 	"O"

dw_1.istCol[18].sDbName		=	"sysadm.w_queue.id_prod"
dw_1.istCol[18].sType		=	"char(5)"
dw_1.istCol[18].sHeaderName=	"Prod"
dw_1.istCol[18].ilargeur	=	1
dw_1.istCol[18].sInvisible	= 	"O"

dw_1.istCol[19].sDbName		=	"sysadm.w_queue.cod_recu"
dw_1.istCol[19].sType		=	"char(1)"
dw_1.istCol[19].sHeaderName=	"Recu"
dw_1.istCol[19].ilargeur	=	1
dw_1.istCol[19].sInvisible	= 	"O"

dw_1.istCol[20].sDbName		=	"sysadm.w_queue.cod_i_prov"
dw_1.istCol[20].sType		=	"char(1)"
dw_1.istCol[20].sHeaderName=	"Prov"
dw_1.istCol[20].ilargeur	=	1
dw_1.istCol[20].sInvisible	= 	"O"

dw_1.istCol[21].sDbName		=	"sysadm.w_queue.dte_recu"
dw_1.istCol[21].sType		=	 "datetime" // [PI056] date=> datetime
dw_1.istCol[21].sHeaderName=	"dte rec"
dw_1.istCol[21].ilargeur	=	1
dw_1.istCol[21].sInvisible	= 	"O"

dw_1.istCol[22].sDbName		=	"sysadm.w_queue.cod_typ_recu"
dw_1.istCol[22].sType		=	"char(1)"
dw_1.istCol[22].sHeaderName=	"t recu"
dw_1.istCol[22].ilargeur	=	1
dw_1.istCol[22].sInvisible	= 	"O"

dw_1.istCol[23].sDbName		=	"sysadm.w_queue.dte_cour_cli"
dw_1.istCol[23].sType		=	"datetime" // [PI056] date=> datetime
dw_1.istCol[23].sHeaderName=	"dte cour"
dw_1.istCol[23].ilargeur	=	1
dw_1.istCol[23].sInvisible	= 	"O"


sTables[ 1 ]		= "w_queue"

// .... D$$HEX1$$e900$$ENDHEX$$finition Cliente des colonnes suppl$$HEX1$$e900$$ENDHEX$$mentaires du cod etat et de la sturcture d'interro

this.TriggerEvent( "ue_WorkFlow" )


// .... Dw_1.isJointure est positionn$$HEX2$$e9002000$$ENDHEX$$Grace au code $$HEX1$$e900$$ENDHEX$$tat positionn$$HEX2$$e9002000$$ENDHEX$$dans le client
Dw_1.isJointure 	= " and sysadm.w_queue.cod_etat = '3' order by sysadm.w_queue.trv_maj_le"

// .... Si aucune structure d'int$$HEX1$$e900$$ENDHEX$$rrogation n'est d$$HEX1$$e900$$ENDHEX$$finie on d$$HEX1$$e900$$ENDHEX$$finie celle par d$$HEX1$$e900$$ENDHEX$$faut
If ( pb_Interro.istInterro.sDataObject = "" ) Then

	pb_Interro.istInterro.wAncetre				= This
	pb_Interro.istInterro.sTitre 					= "Recherche des Travaux"
	pb_Interro.istInterro.sDataObject			= "d_spb_int_travaux"
	pb_Interro.istInterro.sCodeDw					= "TRAVAUX"

	pb_Interro.istInterro.sData[1].sNom			= "trv_maj_par"
	pb_Interro.istInterro.sData[1].sDbName		= "sysadm.w_queue.dos_maj_par"
	pb_Interro.istInterro.sData[1].sType		= "STRING"
	pb_Interro.istInterro.sData[1].sOperande	= "="

	pb_Interro.istInterro.sData[2].sNom			= "id_corb"
	pb_Interro.istInterro.sData[2].sDbName		= "sysadm.w_queue.id_corb"
	pb_Interro.istInterro.sData[2].sType		= "STRING"
	pb_Interro.istInterro.sData[2].sOperande	= "="

	pb_Interro.istInterro.sData[3].sNom			= "id_sin"
	pb_Interro.istInterro.sData[3].sDbName		= "sysadm.w_queue.id_sin"
	pb_Interro.istInterro.sData[3].sType		= "STRING"
	pb_Interro.istInterro.sData[3].sOperande	= "="

	pb_Interro.istInterro.sData[4].sNom			= "nom"
	pb_Interro.istInterro.sData[4].sDbName		= "sysadm.w_queue.nom"
	pb_Interro.istInterro.sData[4].sType		= "STRING"
	pb_Interro.istInterro.sData[4].sOperande	= "="

End If

istPass.trTrans 	= SQLCA
istPass.bControl	= True		// Utilisation de CTRL + VAL

// .... Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil

dw_1.Uf_Creer_Tout ( dw_1.istCol, sTables, SQLCA )
wf_Construire_Chaine_Tri ()


end event

on ue_initialiser;call w_8_accueil_edition::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_accueil_edition_workflow
//* Evenement 		:	Ue_initialiser
//* Auteur			:	La Recrue
//* Date				:	09/09/97 13:47:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des bitmap pour le 800*600
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


	This.isBmpOccupe_Oui		= "K:\PB4OBJ\BMP\8_OCC_O.BMP"
	This.isBmpOccupe_Non		= ""

	This.isBmpBloc_Oui		= "K:\PB4OBJ\BMP\8_BLO_O.BMP"
	This.isBmpBloc_Non		= ""

	This.isBmpRout_Oui		= "K:\PB4OBJ\BMP\8_ROU_O.BMP"
	This.isBmpRout_Non		= ""

end on

on w_a_spb_wkf_edition.create
call super::create
end on

on w_a_spb_wkf_edition.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_8_accueil_edition`cb_debug within w_a_spb_wkf_edition
end type

type pb_retour from w_8_accueil_edition`pb_retour within w_a_spb_wkf_edition
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil_edition`pb_interro within w_a_spb_wkf_edition
integer x = 270
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil_edition`pb_creer within w_a_spb_wkf_edition
end type

type dw_1 from w_8_accueil_edition`dw_1 within w_a_spb_wkf_edition
integer y = 740
integer width = 3264
end type

type pb_tri from w_8_accueil_edition`pb_tri within w_a_spb_wkf_edition
integer x = 521
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil_edition`pb_imprimer within w_a_spb_wkf_edition
end type

type pb_word from w_8_accueil_edition`pb_word within w_a_spb_wkf_edition
integer x = 773
integer width = 242
integer height = 144
end type

type mle_rapport from w_8_accueil_edition`mle_rapport within w_a_spb_wkf_edition
integer x = 32
integer y = 192
integer width = 3269
integer height = 408
end type

type cb_tous from w_8_accueil_edition`cb_tous within w_a_spb_wkf_edition
integer y = 620
end type

type cb_aucun from w_8_accueil_edition`cb_aucun within w_a_spb_wkf_edition
integer y = 620
end type

type st_1 from w_8_accueil_edition`st_1 within w_a_spb_wkf_edition
integer x = 2231
integer y = 632
end type

type st_nombre from w_8_accueil_edition`st_nombre within w_a_spb_wkf_edition
integer x = 3003
integer y = 628
end type

type cbx_banner from w_8_accueil_edition`cbx_banner within w_a_spb_wkf_edition
end type

type cbx_pageblanche from w_8_accueil_edition`cbx_pageblanche within w_a_spb_wkf_edition
end type

