HA$PBExportHeader$w_a_spb_courtype.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le param$$HEX1$$e800$$ENDHEX$$trage des courriers type
forward
global type w_a_spb_courtype from w_8_accueil
end type
type dw_etat from datawindow within w_a_spb_courtype
end type
end forward

global type w_a_spb_courtype from w_8_accueil
integer x = 0
integer y = 0
integer width = 3639
integer height = 2000
string title = "Accueil - Biblioth$$HEX1$$e800$$ENDHEX$$que de courriers type"
dw_etat dw_etat
end type
global w_a_spb_courtype w_a_spb_courtype

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_courtype
//* Evenement 		:	open - extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 16:47:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//* Commentaires	:	
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

pb_Interro.istInterro.sData [ 1 ].sNom			= "id_cour"
pb_Interro.istInterro.sData [ 1 ].sDbName		= "sysadm.cour_type.id_cour"
pb_Interro.istInterro.sData [ 1 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 1 ].sOperande	= "="

pb_Interro.istInterro.sData [ 2 ].sNom			= "lib_cour"
pb_Interro.istInterro.sData [ 2 ].sDbName		= "sysadm.cour_type.lib_cour"
pb_Interro.istInterro.sData [ 2 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 2 ].sOperande	= "="

pb_Interro.istInterro.sData [ 3 ].sNom			= "maj_le1"
pb_Interro.istInterro.sData [ 3 ].sDbName		= "sysadm.cour_type.maj_le"
pb_Interro.istInterro.sData [ 3 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 3 ].sOperande	= ">="

pb_Interro.istInterro.sData [ 4 ].sNom			= "maj_le2"
pb_Interro.istInterro.sData [ 4 ].sDbName		= "sysadm.cour_type.maj_le"
pb_Interro.istInterro.sData [ 4 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 4 ].sOperande	= "<="

pb_Interro.istInterro.sData [ 5 ].sNom			= "maj_par"
pb_Interro.istInterro.sData [ 5 ].sDbName		= "sysadm.cour_type.maj_par"
pb_Interro.istInterro.sData [ 5 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 5 ].sOperande	= "="

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= False		// Utilisation du bouton VALIDER

Dw_Etat.SetTransObject ( itrTrans )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_courtype
//* Evenement 		:	ue_modifier
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 16:51:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification d'un enregistrement.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'identifiant du courrier type                          */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//istPass.sTab[1] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "COUR_TYPE.ID_COUR" )
istPass.sTab[1] 	= dw_1.GetItemString ( dw_1.ilLigneClick, "ID_COUR" )
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Autorise la suppression d'un courrier type.                      */
/*------------------------------------------------------------------*/
istPass.bSupprime	= TRUE

f_OuvreTraitement ( W_T_Spb_CourType, istPass )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_a_spb_courtype.create
int iCurrent
call super::create
this.dw_etat=create dw_etat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_etat
end on

on w_a_spb_courtype.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_etat)
end on

event ue_creer;call super::ue_creer;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_spb_courtype
//* Evenement 		:	ue_creer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 16:50:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX1$$e900$$ENDHEX$$ation d'un enregistrement - ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de
//*                	traitement.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

f_OuvreTraitement ( W_t_Spb_CourType, istPass )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type pb_retour from w_8_accueil`pb_retour within w_a_spb_courtype
integer taborder = 40
end type

type pb_interro from w_8_accueil`pb_interro within w_a_spb_courtype
integer taborder = 60
end type

type pb_creer from w_8_accueil`pb_creer within w_a_spb_courtype
integer taborder = 50
end type

type dw_1 from w_8_accueil`dw_1 within w_a_spb_courtype
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

type pb_tri from w_8_accueil`pb_tri within w_a_spb_courtype
integer taborder = 70
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_spb_courtype
boolean visible = true
boolean enabled = true
end type

event pb_imprimer::clicked;//*-----------------------------------------------------------------
//*
//* Objet			:	w_8_accueil::pb_imprimer
//* Evenement 		:	Clicked ( OverWrite )
//* Auteur			:	La Recrue
//* Date				:	03/12/97 16:41:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Impression du d$$HEX1$$e900$$ENDHEX$$tail du contenu de Dw_1
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Long	Li
Long	lRep

stMessage.Icon = Question!
stMessage.Bouton = YesNoCancel!
stMessage.sCode = "GENE019"


If ( Dw_1.RowCount() > 0 ) Then

	lRep = f_Message ( stMessage )
	If ( lRep = 1 ) Then

		SetPointer ( HourGlass! )

		OpenWithParm ( w_impression, "Impression des courriers types" )

		For Li = 1 To Dw_1.RowCount()

//Migration PB8-WYNIWYG-03/2006 FM
//			w_impression.Wf_Text( dw_1.GetItemString ( lI, "COUR_TYPE.LIB_COUR" ) )
//			dw_Etat.Reset ()
//			dw_Etat.Retrieve ( dw_1.GetItemString ( lI, "COUR_TYPE.ID_COUR" ) )
			w_impression.Wf_Text( dw_1.GetItemString ( lI, "LIB_COUR" ) )
			dw_Etat.Reset ()
			dw_Etat.Retrieve ( dw_1.GetItemString ( lI, "ID_COUR" ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM
			dw_Etat.GroupCalc()
			dw_Etat.Print( False )								

		Next

		Close ( w_impression )

	ElseIf ( lRep = 2 ) Then
		Call w_accueil`pb_imprimer::Clicked
	End If

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_etat from datawindow within w_a_spb_courtype
boolean visible = false
integer x = 2587
integer y = 116
integer width = 375
integer height = 240
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_spb_prt_courtype"
boolean livescroll = true
end type

event printstart;SetPointer ( HourGlass! )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event printend;SetPointer ( HourGlass! )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event printpage;SetPointer ( HourGlass! )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

