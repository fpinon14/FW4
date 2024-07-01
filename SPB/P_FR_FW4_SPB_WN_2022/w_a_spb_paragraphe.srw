HA$PBExportHeader$w_a_spb_paragraphe.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e900$$ENDHEX$$trage des paragraphes.
forward
global type w_a_spb_paragraphe from w_8_accueil
end type
end forward

global type w_a_spb_paragraphe from w_8_accueil
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Gestion des paragraphes"
end type
global w_a_spb_paragraphe w_a_spb_paragraphe

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_paragraphe
//* Evenement 		:	open - extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	13/06/97 17:09:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil 
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1 MADM	 07/06/2006 Projet DNTMAIL1 : Ajout de la colonne ID_CANAL			  
//* #2	JCA		15/11/2006		DCMP 060825 - plus de limitation du nbr de ligne de retour
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
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des Paragraphes."

/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil                                 */
/*------------------------------------------------------------------*/
dw_1.istCol [ 1 ].sDbName		=	"sysadm.paragraphe.id_para"
dw_1.istCol [ 1 ].sType			=	"char(4)"
dw_1.istCol [ 1 ].sHeaderName	=	"Id Para"
dw_1.istCol [ 1 ].ilargeur		=	8
dw_1.istCol [ 1 ].sAlignement	=	"2"
dw_1.istCol [ 1 ].sInvisible	= 	"N"

/*--------------------------------------------------------------------*/
/* #1 MADM	 07/06/2006 Projet DNTMAIL1 : Ajout de la colonne ID_CANAL*/
/* Avec un d$$HEX1$$e900$$ENDHEX$$calage de l'ordre des colonnes									 */
/*--------------------------------------------------------------------*/
dw_1.istCol [ 2 ].sDbName		=	"sysadm.paragraphe.id_canal"
dw_1.istCol [ 2 ].sType			=	"char(2)"
dw_1.istCol [ 2 ].sHeaderName	=	"Id Canal"
dw_1.istCol [ 2 ].ilargeur		=	8
dw_1.istCol [ 2 ].sAlignement	=	"2"
dw_1.istCol [ 2 ].sInvisible	= 	"N"
//Fin MADM

dw_1.istCol [ 3 ].sDbName		=	"sysadm.paragraphe.cpt_ver"
dw_1.istCol [ 3 ].sType			=	"char(3)"
dw_1.istCol [ 3 ].sHeaderName	=	"Version"
dw_1.istCol [ 3 ].ilargeur		=	8
dw_1.istCol [ 3 ].sAlignement	=	"2"
dw_1.istCol [ 3 ].sInvisible	= 	"N"

dw_1.istCol [ 4 ].sDbName		=	"sysadm.paragraphe.lib_para"
dw_1.istCol [ 4 ].sType			=	"char(35)"
dw_1.istCol [ 4 ].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_1.istCol [ 4 ].ilargeur		=	36
dw_1.istCol [ 4 ].sAlignement	=	"0"
dw_1.istCol [ 4 ].sInvisible	= 	"N"

dw_1.istCol [ 5 ].sDbName		=	"sysadm.paragraphe.maj_le"
dw_1.istCol [ 5 ].sType			=	"Datetime"
dw_1.istCol [ 5 ].sHeaderName	=	"Maj Le"
dw_1.istCol [ 5 ].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol [ 5 ].ilargeur		=	20
dw_1.istCol [ 5 ].sAlignement	=	"2"
dw_1.istCol [ 5 ].sInvisible	= 	"N"

dw_1.istCol [ 6 ].sDbName		=	"sysadm.paragraphe.maj_par"
dw_1.istCol [ 6 ].sType			=	"char(4)"
dw_1.istCol [ 6 ].sHeaderName	=	"Par"
dw_1.istCol [ 6 ].ilargeur		=	4
dw_1.istCol [ 6 ].sAlignement	=	"2"
dw_1.istCol [ 6 ].sInvisible	= 	"N"


sTables [ 1 ] = "paragraphe"


/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut sur l'identifiant des paragraphes.                */
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
pb_Interro.istInterro.sTitre 					= "Recherche des paragraphes"
pb_Interro.istInterro.sDataObject			= "d_spb_int_paragraphe"
pb_Interro.istInterro.sCodeDw					= "PARAGRAPHE"

pb_Interro.istInterro.sData [ 1 ].sNom			= "id_para"
pb_Interro.istInterro.sData [ 1 ].sDbName		= "sysadm.paragraphe.id_para"
pb_Interro.istInterro.sData [ 1 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 1 ].sOperande	= "="

/*--------------------------------------------------------------------*/
/* #1 MADM	 07/06/2006 Projet DNTMAIL1 : Ajout de la colonne ID_CANAL*/
/* Avec un d$$HEX1$$e900$$ENDHEX$$calage de l'ordre des colonnes                           */
/*--------------------------------------------------------------------*/
pb_Interro.istInterro.sData [ 2 ].sNom			= "id_canal"
pb_Interro.istInterro.sData [ 2 ].sDbName		= "sysadm.paragraphe.id_canal"
pb_Interro.istInterro.sData [ 2 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 2 ].sOperande	= "="
//Fin MADM

pb_Interro.istInterro.sData [ 3 ].sNom			= "lib_para"
pb_Interro.istInterro.sData [ 3 ].sDbName		= "sysadm.paragraphe.lib_para"
pb_Interro.istInterro.sData [ 3 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 3 ].sOperande	= "="

pb_Interro.istInterro.sData [ 4 ].sNom			= "maj_le1"
pb_Interro.istInterro.sData [ 4 ].sDbName		= "sysadm.paragraphe.maj_le"
pb_Interro.istInterro.sData [ 4 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 4 ].sOperande	= ">="

pb_Interro.istInterro.sData [ 5 ].sNom			= "maj_le2"
pb_Interro.istInterro.sData [ 5 ].sDbName		= "sysadm.paragraphe.maj_le"
pb_Interro.istInterro.sData [ 5 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 5 ].sOperande	= "<="

pb_Interro.istInterro.sData [ 6 ].sNom			= "maj_par"
pb_Interro.istInterro.sData [ 6 ].sDbName		= "sysadm.paragraphe.maj_par"
pb_Interro.istInterro.sData [ 6 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 6  ].sOperande	= "="

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= False		// Utilisation du bouton VALIDER

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_paragraphe
//* Evenement 		:	ue_modifier
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	13/06/97 17:14:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification d'un paragraphe
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1 MADM	 07/06/2006 Projet DNTMAIL1 : Ajout de la colonne ID_CANAL				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du paragraphe                             */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//istPass.sTab[1] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "PARAGRAPHE.ID_PARA" )
istPass.sTab[1] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "ID_PARA" )
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* #1 R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'ID CANAL qui est identifiant du paragraphe         */
/*------------------------------------------------------------------*/
istPass.sTab[2]   = dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CANAL" ) 

/*------------------------------------------------------------------*/
/* Autorise la suppression d'un paragraphe.                         */
/*------------------------------------------------------------------*/
istPass.bSupprime	= TRUE

f_OuvreTraitement ( W_T_Spb_Paragraphe, istPass ) 

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_paragraphe
//* Evenement 		:	ue_creer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	13/06/97 17:13:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX1$$e900$$ENDHEX$$ation d'un paragraphe - ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de
//*                	traitement.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

f_OuvreTraitement ( W_T_Spb_Paragraphe, istPass )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_a_spb_paragraphe.create
call super::create
end on

on w_a_spb_paragraphe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_8_accueil`pb_retour within w_a_spb_paragraphe
end type

type pb_interro from w_8_accueil`pb_interro within w_a_spb_paragraphe
end type

type pb_creer from w_8_accueil`pb_creer within w_a_spb_paragraphe
end type

type dw_1 from w_8_accueil`dw_1 within w_a_spb_paragraphe
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

type pb_tri from w_8_accueil`pb_tri within w_a_spb_paragraphe
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_spb_paragraphe
boolean visible = true
boolean enabled = true
end type

