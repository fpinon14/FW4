HA$PBExportHeader$w_accueil_workflow_deblocage.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le d$$HEX1$$e900$$ENDHEX$$blocage des travaux
forward
global type w_accueil_workflow_deblocage from w_accueil_workflow
end type
end forward

global type w_accueil_workflow_deblocage from w_accueil_workflow
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Fen$$HEX1$$ea00$$ENDHEX$$tre de d$$HEX1$$e900$$ENDHEX$$blocage des dossiers"
end type
global w_accueil_workflow_deblocage w_accueil_workflow_deblocage

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil_Workflow_Deblocage::Open
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 14/06/1997 19:06:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sTables[]

// .... Description de la DW d'accueil

dw_1.istCol[1].sDbName		=	"sysadm.w_queue.trv_cree_le"
dw_1.istCol[1].sType			=	"datetime"
dw_1.istCol[1].sResultSet	=	"trv_cree_le"
dw_1.istCol[1].sHeaderName	=	"Cr$$HEX1$$e900$$ENDHEX$$ation"
dw_1.istCol[1].sAlignement	= 	"1"
dw_1.istCol[1].ilargeur		=	8
dw_1.istCol[1].sInvisible	= 	"N"
dw_1.istCol[1].sFormat		=  "dd/mm/yy"

dw_1.istCol[2].sDbName		=	"sysadm.w_queue.id_corb"
dw_1.istCol[2].sType			=	"char(3)"
dw_1.istCol[2].sResultSet	=	"id_corb"
dw_1.istCol[2].sHeaderName	=	"Crb"
dw_1.istCol[2].ilargeur		=	3
dw_1.istCol[2].sInvisible	= 	"N"
dw_1.istCol[2].sAlignement	=	"1"

dw_1.istCol[3].sDbName		=	"sysadm.w_queue.id_sin"
//Migration PB8-WYNIWYG-03/2006 FM
//dw_1.istCol[3].sType			=	"char(6)"
dw_1.istCol[3].sType			=	"char(10)"   // [PI062]
//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_1.istCol[3].sResultSet	=	"id_sin"
dw_1.istCol[3].sHeaderName	=	"Sin."
dw_1.istCol[3].ilargeur		=	10   // [PI062]
dw_1.istCol[3].sAlignement	=	"2"
dw_1.istCol[3].sInvisible	= 	"N"

dw_1.istCol[4].sDbName		=	"sysadm.w_queue.nom"
//Migration PB8-WYNIWYG-03/2006 FM
//dw_1.istCol[4].sType			=	"char(30)"
dw_1.istCol[4].sType			=	"char(71)"
//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_1.istCol[4].sResultSet	=	"nom"
dw_1.istCol[4].sHeaderName	=	"Nom"
dw_1.istCol[4].ilargeur		=	20
dw_1.istCol[4].sAlignement	=	"3"
dw_1.istCol[4].sInvisible	= 	"N"

dw_1.istCol[5].sDbName		=	"sysadm.w_queue.dos_maj_le"
dw_1.istCol[5].sType			=	"datetime"
dw_1.istCol[5].sResultSet	=	"dos_maj_le"
dw_1.istCol[5].sHeaderName	=	"Maj le"
dw_1.istCol[5].sFormat		=  "dd/mm/yy hh:mm"
dw_1.istCol[5].ilargeur		=	14
dw_1.istCol[5].sAlignement	=	"2"
dw_1.istCol[5].sInvisible	= 	"N"

dw_1.istCol[6].sDbName		=	"sysadm.w_queue.dos_maj_par"
dw_1.istCol[6].sType			=	"char(4)"
dw_1.istCol[6].sResultSet	=	"dos_maj_par"
dw_1.istCol[6].sHeaderName	=	"Par"
dw_1.istCol[6].ilargeur		=	4
dw_1.istCol[6].sAlignement	=	"2"
dw_1.istCol[6].sInvisible	= 	"N"

dw_1.istCol[7].sDbName		=	"sysadm.w_queue.cod_etat"
dw_1.istCol[7].sType			=	"char(1)"
dw_1.istCol[7].sResultSet	=	"cod_etat"
dw_1.istCol[7].sHeaderName	=	"Etat"
dw_1.istCol[7].sAlignement	= 	"2"
dw_1.istCol[7].ilargeur		=	3
dw_1.istCol[7].sValues		= 	"Sai	1/Edt	3/Val	5"
dw_1.istCol[7].sInvisible	= 	"N"

dw_1.istCol[8].sDbName		=	"sysadm.w_queue.alt_occupe"
dw_1.istCol[8].sType			=	"char(1)"
dw_1.istCol[8].sResultSet	=	"alt_occupe"
dw_1.istCol[8].sHeaderName	=	"Oc"
dw_1.istCol[8].sAlignement	= 	"2"
dw_1.istCol[8].ilargeur		=	2
dw_1.istCol[8].sValues		= 	isBmpOccupe_Oui + "	O/" + isBmpOccupe_Non + " 	N"
dw_1.istCol[8].sInvisible	= 	"N"
dw_1.istCol[8].sBitMap		= 	"O"

dw_1.istCol[9].sDbName		=	"sysadm.w_queue.alt_bloc"
dw_1.istCol[9].sType			=	"char(1)"
dw_1.istCol[9].sResultSet	=	"alt_bloc"
dw_1.istCol[9].sHeaderName	=	"Bl"
dw_1.istCol[9].sAlignement	= 	"1"
dw_1.istCol[9].ilargeur		=	2
dw_1.istCol[9].sValues		= 	isBmpBloc_Oui + "	O/" + isBmpBloc_Non + " 	N"
dw_1.istCol[9].sInvisible	= 	"N"
dw_1.istCol[9].sBitMap		= 	"O"

dw_1.istCol[10].sDbName		=	"sysadm.w_queue.trv_route_le"
dw_1.istCol[10].sType		=	"datetime"
dw_1.istCol[10].sResultSet	=	"trv_route_le"
dw_1.istCol[10].sHeaderName=	"Route Le"
dw_1.istCol[10].sAlignement= 	"1"
dw_1.istCol[10].ilargeur	=	10
dw_1.istCol[10].sInvisible	= 	"O"

dw_1.istCol[11].sDbName		=	"sysadm.w_queue.trv_route_par"
dw_1.istCol[11].sType		=	"char(4)"
dw_1.istCol[11].sResultSet	=	"trv_route_par"
dw_1.istCol[11].sHeaderName=	"Route par"
dw_1.istCol[11].sAlignement= 	"1"
dw_1.istCol[11].ilargeur	=	4
dw_1.istCol[11].sInvisible	= 	"O"

dw_1.istCol[12].sDbName		=	"sysadm.w_queue.txt_mess1"
//Migration PB8-WYNIWYG-03/2006 FM
//dw_1.istCol[12].sType		=	"char(80)"
dw_1.istCol[12].sType		=	"char(254)"
//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_1.istCol[12].sResultSet	=	"txt_mess1"
dw_1.istCol[12].sHeaderName=	"Message"
dw_1.istCol[12].sAlignement= 	"1"
dw_1.istCol[12].ilargeur	=	1
dw_1.istCol[12].sInvisible	= 	"O"

dw_1.istCol[13].sDbName		=	"sysadm.w_queue.trv_maj_le"
dw_1.istCol[13].sType		=	"datetime"
dw_1.istCol[13].sResultSet	=	"trv_maj_le"
dw_1.istCol[13].sHeaderName=	"Maj le"
dw_1.istCol[13].sFormat		=  "dd/mm/yy hh:mm"
dw_1.istCol[13].ilargeur	=	1
dw_1.istCol[13].sInvisible	= 	"O"

dw_1.istCol[14].sDbName		=	"sysadm.w_queue.trv_maj_par"
dw_1.istCol[14].sType		=	"char(4)"
dw_1.istCol[14].sResultSet	=	"trv_maj_par"
dw_1.istCol[14].sHeaderName=	"Par"
dw_1.istCol[14].ilargeur	=	4
dw_1.istCol[14].sInvisible	= 	"O"

dw_1.istCol[15].sDbName		=	"sysadm.w_queue.cod_action"
dw_1.istCol[15].sType		=	"char(1)"
dw_1.istCol[15].sResultSet	=	"cod_action"
dw_1.istCol[15].sHeaderName=	"Action"
dw_1.istCol[15].ilargeur	=	4
dw_1.istCol[15].sInvisible	= 	"O"

dw_1.istCol[16].sDbName		=	"sysadm.w_queue.trv_edite_le"
dw_1.istCol[16].sType		=	"datetime"
dw_1.istCol[16].sResultSet	=	"trv_edite_le"
dw_1.istCol[16].sHeaderName=	"Edite le"
dw_1.istCol[16].sFormat		=  "dd/mm/yy hh:mm"
dw_1.istCol[16].ilargeur	=	1
dw_1.istCol[16].sInvisible	= 	"O"

dw_1.istCol[17].sDbName		=	"sysadm.w_queue.trv_edite_par"
dw_1.istCol[17].sType		=	"char(4)"
dw_1.istCol[17].sResultSet	=	"trv_edite_par"
dw_1.istCol[17].sHeaderName=	"Par"
dw_1.istCol[17].ilargeur	=	4
dw_1.istCol[17].sInvisible	= 	"O"

sTables[ 1 ]		= "w_queue"

// .... Dw_1.isJointure est positionn$$HEX2$$e9002000$$ENDHEX$$sur les fen$$HEX1$$ea00$$ENDHEX$$tres descendantes

// .... Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil

dw_1.Uf_Creer_Tout ( dw_1.istCol, sTables, SQLCA )

wf_Construire_Chaine_Tri ()

pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Deblocage des Travaux"
pb_Interro.istInterro.sDataObject			= "d_int_blocage_travaux"
pb_Interro.istInterro.sCodeDw					= "DEBLOCAGE"

pb_Interro.istInterro.sData[1].sNom			= "alt_occupe"
pb_Interro.istInterro.sData[1].sDbName		= "w_queue.alt_occupe"
pb_Interro.istInterro.sData[1].sType		= "STRING"
pb_Interro.istInterro.sData[1].sOperande	= "="

pb_Interro.istInterro.sData[2].sNom			= "saisie"
pb_Interro.istInterro.sData[2].sDbName		= "w_queue.cod_etat"
pb_Interro.istInterro.sData[2].sType		= "STRING"
pb_Interro.istInterro.sData[2].sOperande	= "="

pb_Interro.istInterro.sData[3].sNom			= "validation"
pb_Interro.istInterro.sData[3].sDbName		= "w_queue.cod_etat"
pb_Interro.istInterro.sData[3].sType		= "STRING"
pb_Interro.istInterro.sData[3].sOperande	= "="

istPass.trTrans 	= SQLCA
istPass.bControl	= True		// Utilisation de CTRL + VAL
dw_1.isJointure 	= " ORDER BY sysadm.w_queue.trv_cree_le"



end event

on ue_initialiser;call w_accueil_workflow::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil_Workflow_Deblocage::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 14/06/1997 19:06:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.ibGestionErreur = True	// Cette fen$$HEX1$$ea00$$ENDHEX$$tre sert au d$$HEX1$$e900$$ENDHEX$$blocage des dossiers

iiNumCol[  1 ]		=	3			// Id_Sin
iiNumCol[  2 ]		=	2			// Id_Corb
iiNumCol[  3 ]		=	4			// Nom
iiNumCol[  4 ]		=	7			// Code Etat
iiNumCol[  5 ]		=	15			// Code Action	
iiNumCol[  6 ]		=	8			// Alt Occupe
iiNumCol[  7 ]		=	9			// Alt_Bloc
iiNumCol[  8 ]		=	1			// Trv Cree Le
iiNumCol[  9 ]		=	13			// Trv Maj Le
iiNumCol[ 10 ]		=	14			// Trv Maj Par
iiNumCol[ 11 ]		=	10			// Trv Route Le
iiNumCol[ 12 ]		=	11			// Trv Route Par
iiNumCol[ 13 ]		=	16			// Trv Edite Le
iiNumCol[ 14 ]		=	17			// Trv Edite Par
iiNumCol[ 15 ]		=	5			// Dos Maj Le
iiNumCol[ 16 ]		=	6			// Dos Maj Par
iiNumCol[ 17 ]		=	12			// Txt_Mess1
iiNumCol[ 18 ]		=	0			// Txt_Mess2


end on

on ue_fermer_interro;call w_accueil_workflow::ue_fermer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil_Workflow_Deblocage::Ue_Fermer_Interro
//* Evenement 		: Ue_Fermer_Interro
//* Auteur			: Erick John Stark
//* Date				: 15/06/1997 17:58:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sAltOccupe, sSaisie, sValidation, sSql

sAltOccupe	= w_Interro.dw_1.GetItemString ( 1, "ALT_OCCUPE" )
sSaisie		= w_Interro.dw_1.GetItemString ( 1, "SAISIE" )
sValidation	= w_Interro.dw_1.GetItemString ( 1, "VALIDATION" )

If		sAltOccupe = "N" Then
		sSql = " WHERE sysadm.w_queue.alt_occupe = 'N' AND sysadm.w_queue.cod_etat = '3' "
Else
		If			sSaisie = "1" And sValidation = "5" Then
			sSql = " WHERE sysadm.w_queue.alt_occupe = 'O' AND ( sysadm.w_queue.cod_etat = '1' OR sysadm.w_queue.cod_etat = '5' ) "
		ElseIf	sSaisie = "1" And sValidation = "0" Then
			sSql = " WHERE sysadm.w_queue.alt_occupe = 'O' AND sysadm.w_queue.cod_etat = '1' "
		ElseIf	sSaisie = "0" And sValidation = "5" Then
			sSql = " WHERE sysadm.w_queue.alt_occupe = 'O' AND sysadm.w_queue.cod_etat = '5' "
		Else
			sSql = " WHERE sysadm.w_queue.alt_occupe = 'O' AND sysadm.w_queue.cod_etat = '1' "
		End If
End If

w_Interro.isClause 			= sSql 
w_Interro.isClauseFrancais = sSql 
end on

on w_accueil_workflow_deblocage.create
call super::create
end on

on w_accueil_workflow_deblocage.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_accueil_workflow`cb_debug within w_accueil_workflow_deblocage
end type

type pb_retour from w_accueil_workflow`pb_retour within w_accueil_workflow_deblocage
end type

type pb_interro from w_accueil_workflow`pb_interro within w_accueil_workflow_deblocage
end type

type pb_creer from w_accueil_workflow`pb_creer within w_accueil_workflow_deblocage
end type

type dw_1 from w_accueil_workflow`dw_1 within w_accueil_workflow_deblocage
end type

type pb_tri from w_accueil_workflow`pb_tri within w_accueil_workflow_deblocage
boolean visible = false
integer y = 200
boolean enabled = false
end type

type pb_imprimer from w_accueil_workflow`pb_imprimer within w_accueil_workflow_deblocage
end type

type dw_libre from w_accueil_workflow`dw_libre within w_accueil_workflow_deblocage
end type

type mle_msg1 from w_accueil_workflow`mle_msg1 within w_accueil_workflow_deblocage
end type

type pb_debloc from w_accueil_workflow`pb_debloc within w_accueil_workflow_deblocage
boolean visible = true
integer width = 274
integer height = 160
boolean enabled = true
end type

type dw_corbeille from w_accueil_workflow`dw_corbeille within w_accueil_workflow_deblocage
end type

type dw_workflow from w_accueil_workflow`dw_workflow within w_accueil_workflow_deblocage
end type

