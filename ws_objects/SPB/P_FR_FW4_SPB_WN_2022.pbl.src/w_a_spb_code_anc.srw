HA$PBExportHeader$w_a_spb_code_anc.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e900$$ENDHEX$$trage des codes : fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre.
forward
global type w_a_spb_code_anc from w_8_accueil
end type
end forward

global type w_a_spb_code_anc from w_8_accueil
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Gestion des codes"
event ue_config pbm_custom01
end type
global w_a_spb_code_anc w_a_spb_code_anc

type variables
Boolean		ibVisible
end variables

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_code_anc
//* Evenement 		:	OPEN - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 12:00:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Organisation de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le  
//*					 	param$$HEX1$$e900$$ENDHEX$$trage des Codes des applications SPB
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	JCA		15/11/2006		DCMP 060825 - plus de limitation du nbr de ligne de retour
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 CP
//String sTables [ 1 ]		//Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la datawindow
String sTables []          //Tableau pour les tables d'o$$HEX2$$f9002000$$ENDHEX$$proviennent les champs de la datawindow
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
/* Permet de configurer la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour les besion de la  */
/* gestion des types de codes, des codes pi$$HEX1$$e800$$ENDHEX$$ces, des natures        */
/* d'exclusion.                                                     */
/*------------------------------------------------------------------*/
This.TriggerEvent ( "ue_config" )


/*------------------------------------------------------------------*/
/* Description de la DW d'accueil                                   */
/*------------------------------------------------------------------*/
dw_1.istCol [ 1 ].sDbName		=	"sysadm.code.id_typ_code"
dw_1.istCol [ 1 ].sType			=	"char(3)"
dw_1.istCol [ 1 ].sHeaderName	=	"Type"
dw_1.istCol [ 1 ].ilargeur		=	3
dw_1.istCol [ 1 ].sAlignement	=	"2"

If ibVisible	Then

	dw_1.istCol [ 1 ].sInvisible	= 	"N"

Else

	dw_1.istCol [ 1 ].sInvisible	= 	"O"

End If


dw_1.istCol [ 2 ].sDbName		=	"sysadm.code.id_code"
dw_1.istCol [ 2 ].sType			=	"number"
dw_1.istCol [ 2 ].sHeaderName	=	"Code"
dw_1.istCol [ 2 ].ilargeur		=	6
dw_1.istCol [ 2 ].sAlignement	=	"2"
dw_1.istCol [ 2 ].sInvisible	= 	"N"

dw_1.istCol [ 3 ].sDbName		=	"sysadm.code.lib_code"
dw_1.istCol [ 3 ].sType			=	"char(35)"
dw_1.istCol [ 3 ].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_1.istCol [ 3 ].ilargeur		=	35
dw_1.istCol [ 3 ].sAlignement	=	"0"
dw_1.istCol [ 3 ].sInvisible	= 	"N"

dw_1.istCol [ 4 ].sDbName		=	"sysadm.code.maj_le"
dw_1.istCol [ 4 ].sType			=	"datetime"
dw_1.istCol [ 4 ].sHeaderName	=	"Maj le"
dw_1.istCol [ 4 ].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol [ 4 ].ilargeur		=	19
dw_1.istCol [ 4 ].sAlignement	=	"2"
dw_1.istCol [ 4 ].sInvisible	= 	"N"

dw_1.istCol [ 5 ].sDbName		=	"sysadm.code.maj_par"
dw_1.istCol [ 5 ].sType			=	"char(4)"
dw_1.istCol [ 5 ].sHeaderName	=	"Par"
dw_1.istCol [ 5 ].ilargeur		=	4
dw_1.istCol [ 5 ].sAlignement	=	"2"
dw_1.istCol [ 5 ].sInvisible	= 	"N"

sTables [  1  ]	= "code"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, itrTrans )


wf_Construire_Chaine_Tri()


/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= False		// Utilisation de VALIDE uniquement
end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_code_anc
//* Evenement 		:	UE_MODIFIER - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 12:06:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification d'un Code
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du code                                   */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//istPass.sTab [ 1 ] = dw_1.GetItemString ( dw_1.ilLigneClick, "CODE.ID_TYP_CODE" )
//istPass.sTab [ 2 ] = String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "CODE.ID_CODE" ) )
istPass.sTab [ 1 ] = dw_1.GetItemString ( dw_1.ilLigneClick, "ID_TYP_CODE" )
istPass.sTab [ 2 ] = String ( dw_1.GetItemNumber ( dw_1.ilLigneClick, "ID_CODE" ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Autorise la suppression d'un code.                               */
/*------------------------------------------------------------------*/
istPass.bSupprime	= TRUE

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_a_spb_code_anc.create
call super::create
end on

on w_a_spb_code_anc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_8_accueil`pb_retour within w_a_spb_code_anc
end type

type pb_interro from w_8_accueil`pb_interro within w_a_spb_code_anc
end type

type pb_creer from w_8_accueil`pb_creer within w_a_spb_code_anc
end type

type dw_1 from w_8_accueil`dw_1 within w_a_spb_code_anc
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

type pb_tri from w_8_accueil`pb_tri within w_a_spb_code_anc
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_spb_code_anc
boolean visible = true
boolean enabled = true
end type

