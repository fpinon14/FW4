HA$PBExportHeader$w_a_spb_workflow.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le WorkFlow
forward
global type w_a_spb_workflow from w_8_accueil_workflow
end type
end forward

global type w_a_spb_workflow from w_8_accueil_workflow
integer width = 3456
integer height = 1772
event ue_workflow pbm_custom01
end type
global w_a_spb_workflow w_a_spb_workflow

type variables
Protected:

	String	isCodEtat
end variables

forward prototypes
public subroutine wf_trttrace (ref string asval[])
end prototypes

public subroutine wf_trttrace (ref string asval[]);//*-----------------------------------------------------------------
//*
//* Fonction		: W_A_Spb_WorkFlow::Wf_Trt_Trace (PROTECTED)
//* Auteur			: Erick John Stark
//* Date				: 19/11/1998 16:02:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ajout des informations $$HEX2$$e0002000$$ENDHEX$$tracer (Valable pour SINDI et SIMPA2)
//*
//* Arguments		: String			asVal[]			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau des valeurs $$HEX2$$e0002000$$ENDHEX$$tracer
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer		iNbVal	// Nombre de valeur du tableau avant ajout

iNbVal		= UpperBound ( asVal[] )

/*----------------------------------------------------------------------------*/
/* On ajoute des valeurs $$HEX2$$e0002000$$ENDHEX$$la fin des enregistrements de trace dans l'ordre   */
/* suivant.                                                                   */
/* ID_PROD, DTE_RECU, COD_TYP_RECU, COD_RECU, COD_I_PROV, DTE_COUR_CLI.       */
/*----------------------------------------------------------------------------*/

asVal[ iNbVal + 1 ] = String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_PROD" 	) )
asVal[ iNbVal + 2 ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "DTE_RECU" 		), "dd/mm/yyyy" )
asVal[ iNbVal + 3 ] = dw_1.GetItemString ( dw_1.ilLigneClick, "COD_TYP_RECU" 			)
asVal[ iNbVal + 4 ] = dw_1.GetItemString ( dw_1.ilLigneClick, "COD_RECU" 				)
asVal[ iNbVal + 5 ] = dw_1.GetItemString ( dw_1.ilLigneClick, "COD_I_PROV"				)
asVal[ iNbVal + 6 ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "DTE_COUR_CLI" ), "dd/mm/yyyy" )

end subroutine

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

dw_1.istCol[1].sDbName		=	"sysadm.w_queue.trv_cree_le"
dw_1.istCol[1].sResultSet	=	"trv_cree_le"
dw_1.istCol[1].sType			=	"datetime"
dw_1.istCol[1].sHeaderName	=	"Cr$$HEX1$$e900$$ENDHEX$$ation"
dw_1.istCol[1].sAlignement	= 	"1"
dw_1.istCol[1].ilargeur		=	15
dw_1.istCol[1].sInvisible	= 	"N"
dw_1.istCol[1].sFormat		=  "dd/mm/yy hh:mm"

dw_1.istCol[2].sDbName		=	"sysadm.w_queue.id_corb"
dw_1.istCol[2].sResultSet	=	"id_corb"
dw_1.istCol[2].sType			=	"char(3)"
dw_1.istCol[2].sHeaderName	=	"Crb"
dw_1.istCol[2].ilargeur		=	3
dw_1.istCol[2].sInvisible	= 	"N"
dw_1.istCol[2].sAlignement	=	"1"

dw_1.istCol[3].sDbName		=	"sysadm.w_queue.id_sin"
dw_1.istCol[3].sResultSet	=	"id_sin"
dw_1.istCol[3].sType			=	"char(10)"  // [PI062]
dw_1.istCol[3].sHeaderName	=	"Sin."
dw_1.istCol[3].ilargeur		=	10   // [PI062]
dw_1.istCol[3].sAlignement	=	"2"
dw_1.istCol[3].sInvisible	= 	"N"

dw_1.istCol[4].sDbName		=	"sysadm.w_queue.nom"
dw_1.istCol[4].sResultSet	=	"nom"
dw_1.istCol[4].sType			=	"char(71)"
dw_1.istCol[4].sHeaderName	=	"Nom"
dw_1.istCol[4].ilargeur		=	20
//Migration PB8-WYNIWYG-03/2006 FM
//dw_1.istCol[4].sAlignement	=	"3"
dw_1.istCol[4].sAlignement	=	"0"
//Fin Migration PB8-WYNIWYG-03/2006 FM
dw_1.istCol[4].sInvisible	= 	"N"

dw_1.istCol[5].sDbName		=	"sysadm.w_queue.dos_maj_le"
dw_1.istCol[5].sResultSet	=	"dos_maj_le"
dw_1.istCol[5].sType			=	"datetime"
dw_1.istCol[5].sHeaderName	=	"Maj le"
dw_1.istCol[5].sFormat		=  "dd/mm/yy hh:mm"
dw_1.istCol[5].ilargeur		=	14
dw_1.istCol[5].sAlignement	=	"2"
dw_1.istCol[5].sInvisible	= 	"N"

dw_1.istCol[6].sDbName		=	"sysadm.w_queue.dos_maj_par"
dw_1.istCol[6].sResultSet	=	"dos_maj_par"
dw_1.istCol[6].sType			=	"char(4)"
dw_1.istCol[6].sHeaderName	=	"Par"
dw_1.istCol[6].ilargeur		=	4
dw_1.istCol[6].sAlignement	=	"2"
dw_1.istCol[6].sInvisible	= 	"N"

dw_1.istCol[7].sDbName		=	"sysadm.w_queue.cod_etat"
dw_1.istCol[7].sResultSet	=	"cod_etat"
dw_1.istCol[7].sType			=	"char(1)"
dw_1.istCol[7].sHeaderName	=	"Etat"
dw_1.istCol[7].sAlignement	= 	"2"
dw_1.istCol[7].ilargeur		=	3
dw_1.istCol[7].sValues		= 	"Sai	1/Edt	3/Val	5"
dw_1.istCol[7].sInvisible	= 	"O"

dw_1.istCol[8].sDbName		=	"sysadm.w_queue.alt_occupe"
dw_1.istCol[8].sResultSet	=	"alt_occupe"
dw_1.istCol[8].sType			=	"char(1)"
dw_1.istCol[8].sHeaderName	=	"Oc"
dw_1.istCol[8].sAlignement	= 	"2"
dw_1.istCol[8].ilargeur		=	2
dw_1.istCol[8].sValues		= 	isBmpOccupe_Oui + "	O/" + isBmpOccupe_Non + " 	N"
dw_1.istCol[8].sInvisible	= 	"N"
dw_1.istCol[8].sBitMap		= 	"O"

dw_1.istCol[9].sDbName		=	"sysadm.w_queue.alt_bloc"
dw_1.istCol[9].sResultSet	=	"alt_bloc"
dw_1.istCol[9].sType		   =	"char(1)"
dw_1.istCol[9].sHeaderName	=	"Bl"
dw_1.istCol[9].sAlignement	= 	"1"
dw_1.istCol[9].ilargeur		=	2
dw_1.istCol[9].sValues		= 	isBmpBloc_Oui + "	O/" + isBmpBloc_Non + " 	N"
dw_1.istCol[9].sInvisible	= 	"N"
dw_1.istCol[9].sBitMap		= 	"O"

dw_1.istCol[10].sDbName		=	"sysadm.w_queue.trv_route_le"
dw_1.istCol[10].sResultSet	=	"trv_route_le"
dw_1.istCol[10].sType		=	"datetime"
dw_1.istCol[10].sHeaderName=	"Route Le"
dw_1.istCol[10].sAlignement= 	"1"
dw_1.istCol[10].ilargeur	=	10
dw_1.istCol[10].sInvisible	= 	"O"

dw_1.istCol[11].sDbName		=	"sysadm.w_queue.trv_route_par"
dw_1.istCol[11].sResultSet	=	"trv_route_par"
dw_1.istCol[11].sType		=	"char(4)"
dw_1.istCol[11].sHeaderName=	"Ro"
dw_1.istCol[11].sAlignement= 	"1"
dw_1.istCol[11].ilargeur	=	2
dw_1.istCol[11].sFormat		= 	"'" + isBmpRout_Oui +"';"
dw_1.istCol[11].sInvisible	= 	"N"
dw_1.istCol[11].sBitMap		= 	"O"

dw_1.istCol[12].sDbName		=	"sysadm.w_queue.txt_mess1"
dw_1.istCol[12].sResultSet	=	"txt_mess1"
dw_1.istCol[12].sType		=	"char(254)"
dw_1.istCol[12].sHeaderName=	"Message"
dw_1.istCol[12].sAlignement= 	"1"
dw_1.istCol[12].ilargeur	=	1
dw_1.istCol[12].sInvisible	= 	"O"

dw_1.istCol[13].sDbName		=	"sysadm.w_queue.trv_maj_le"
dw_1.istCol[13].sResultSet	=	"trv_maj_le"
dw_1.istCol[13].sType		=	"datetime"
dw_1.istCol[13].sHeaderName=	"Maj le"
dw_1.istCol[13].sFormat		=  "dd/mm/yy hh:mm"
dw_1.istCol[13].ilargeur	=	1
dw_1.istCol[13].sInvisible	= 	"O"

dw_1.istCol[14].sDbName		=	"sysadm.w_queue.trv_maj_par"
dw_1.istCol[14].sResultSet	=	"trv_maj_par"
dw_1.istCol[14].sType		=	"char(4)"
dw_1.istCol[14].sHeaderName=	"Par"
dw_1.istCol[14].ilargeur	=	4
dw_1.istCol[14].sInvisible	= 	"O"

dw_1.istCol[15].sDbName		=	"sysadm.w_queue.cod_action"
dw_1.istCol[15].sResultSet	=	"cod_action"
dw_1.istCol[15].sType		=	"char(1)"
dw_1.istCol[15].sHeaderName=	"Action"
dw_1.istCol[15].ilargeur	=	4
dw_1.istCol[15].sInvisible	= 	"O"

dw_1.istCol[16].sDbName		=	"sysadm.w_queue.trv_edite_le"
dw_1.istCol[16].sResultSet	=	"trv_edite_le"
dw_1.istCol[16].sType		=	"datetime"
dw_1.istCol[16].sHeaderName=	"Edite le"
dw_1.istCol[16].sFormat		=  "dd/mm/yy hh:mm"
dw_1.istCol[16].ilargeur	=	1
dw_1.istCol[16].sInvisible	= 	"O"

dw_1.istCol[17].sDbName		=	"sysadm.w_queue.trv_edite_par"
dw_1.istCol[17].sResultSet	=	"trv_edite_par"
dw_1.istCol[17].sType		=	"char(4)"
dw_1.istCol[17].sHeaderName=	"Par"
dw_1.istCol[17].ilargeur	=	4
dw_1.istCol[17].sInvisible	= 	"O"

dw_1.istCol[18].sDbName		=	"sysadm.w_queue.id_prod"
dw_1.istCol[18].sResultSet	=	"id_prod"
dw_1.istCol[18].sType		=	"number"
dw_1.istCol[18].sHeaderName=	"Pdt"
dw_1.istCol[18].ilargeur	=	7
dw_1.istCol[18].sInvisible	= 	"O"

dw_1.istCol[19].sDbName		=	"sysadm.w_queue.cod_recu"
dw_1.istCol[19].sResultSet	=	"cod_recu"
dw_1.istCol[19].sType		=	"char(1)"
dw_1.istCol[19].sHeaderName=	"Recu"
dw_1.istCol[19].ilargeur	=	1
dw_1.istCol[19].sInvisible	= 	"O"

dw_1.istCol[20].sDbName		=	"sysadm.w_queue.cod_i_prov"
dw_1.istCol[20].sResultSet	=	"cod_i_prov"
dw_1.istCol[20].sType		=	"char(1)"
dw_1.istCol[20].sHeaderName=	"Prov"
dw_1.istCol[20].ilargeur	=	1
dw_1.istCol[20].sInvisible	= 	"O"

dw_1.istCol[21].sDbName		=	"sysadm.w_queue.dte_recu"
dw_1.istCol[21].sResultSet	=	"dte_recu"
dw_1.istCol[21].sType		=	"datetime"
dw_1.istCol[21].sHeaderName=	"dte rec"
dw_1.istCol[21].ilargeur	=	1
dw_1.istCol[21].sInvisible	= 	"O"

dw_1.istCol[22].sDbName		=	"sysadm.w_queue.cod_typ_recu"
dw_1.istCol[22].sResultSet	=	"cod_typ_recu"
dw_1.istCol[22].sType		=	"char(1)"
dw_1.istCol[22].sHeaderName=	"t recu"
dw_1.istCol[22].ilargeur	=	1
dw_1.istCol[22].sInvisible	= 	"O"

dw_1.istCol[23].sDbName		=	"sysadm.w_queue.dte_cour_cli"
dw_1.istCol[23].sResultSet	=	"dte_cour_cli"
dw_1.istCol[23].sType		=	"datetime"
dw_1.istCol[23].sHeaderName=	"dte cour"
dw_1.istCol[23].ilargeur	=	1
dw_1.istCol[23].sInvisible	= 	"O"

sTables[ 1 ]		= "w_queue"

// .... D$$HEX1$$e900$$ENDHEX$$finition Cliente des colonnes suppl$$HEX1$$e900$$ENDHEX$$mentaires du cod etat et de la sturcture d'interro

This.TriggerEvent( "ue_WorkFlow" )

// .... Dw_1.isJointure est positionn$$HEX2$$e9002000$$ENDHEX$$Grace au code $$HEX1$$e900$$ENDHEX$$tat positionn$$HEX2$$e9002000$$ENDHEX$$dans le client
Dw_1.isJointure 	=  isJointureCorbeille + " and sysadm.w_queue.cod_etat = '" + isCodEtat + "' order by sysadm.w_queue.trv_maj_le"

// .... Si aucune structure d'int$$HEX1$$e900$$ENDHEX$$rrogation n'est d$$HEX1$$e900$$ENDHEX$$finie on d$$HEX1$$e900$$ENDHEX$$finie celle par d$$HEX1$$e900$$ENDHEX$$faut
If ( pb_Interro.istInterro.sDataObject = "" ) Then

	pb_Interro.istInterro.wAncetre				= This
	pb_Interro.istInterro.sTitre 					= "Recherche des Travaux"
	pb_Interro.istInterro.sDataObject			= "d_spb_int_w_queue"
	pb_Interro.istInterro.sCodeDw					= "TRAVAUX "

	pb_Interro.istInterro.sData[1].sNom			= "id_sin"
	pb_Interro.istInterro.sData[1].sDbName		= "sysadm.w_queue.id_sin"
	pb_Interro.istInterro.sData[1].sType		= "STRING"
	pb_Interro.istInterro.sData[1].sOperande	= "="

	pb_Interro.istInterro.sData[2].sNom			= "id_corb"
	pb_Interro.istInterro.sData[2].sDbName		= "sysadm.w_queue.id_corb"
	pb_Interro.istInterro.sData[2].sType		= "STRING"
	pb_Interro.istInterro.sData[2].sOperande	= "="

	pb_Interro.istInterro.sData[3].sNom			= "trv_maj_par"
	pb_Interro.istInterro.sData[3].sDbName		= "sysadm.w_queue.dos_maj_par"
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

on ue_initialiser;call w_8_accueil_workflow::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_A_Spb_Workflow::Ue_Initialiser
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

on w_a_spb_workflow.create
call super::create
end on

on w_a_spb_workflow.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_8_accueil_workflow`cb_debug within w_a_spb_workflow
end type

type pb_retour from w_8_accueil_workflow`pb_retour within w_a_spb_workflow
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil_workflow`pb_interro within w_a_spb_workflow
integer width = 242
integer height = 144
end type

type pb_creer from w_8_accueil_workflow`pb_creer within w_a_spb_workflow
integer width = 242
integer height = 144
end type

type dw_1 from w_8_accueil_workflow`dw_1 within w_a_spb_workflow
end type

type pb_tri from w_8_accueil_workflow`pb_tri within w_a_spb_workflow
integer width = 242
integer height = 144
end type

type pb_imprimer from w_8_accueil_workflow`pb_imprimer within w_a_spb_workflow
integer width = 242
integer height = 144
end type

type dw_libre from w_8_accueil_workflow`dw_libre within w_a_spb_workflow
end type

type mle_msg1 from w_8_accueil_workflow`mle_msg1 within w_a_spb_workflow
end type

type pb_debloc from w_8_accueil_workflow`pb_debloc within w_a_spb_workflow
end type

type dw_corbeille from w_8_accueil_workflow`dw_corbeille within w_a_spb_workflow
end type

type dw_workflow from w_8_accueil_workflow`dw_workflow within w_a_spb_workflow
end type

