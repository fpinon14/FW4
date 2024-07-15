HA$PBExportHeader$w_a_spb_travaux_routes.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre servant pour les stats des motifs de routage ( DCMP 990391 )
forward
global type w_a_spb_travaux_routes from w_a_spb_ancetre_etat_wkf
end type
type dw_oper from datawindow within w_a_spb_travaux_routes
end type
type st_3 from statictext within w_a_spb_travaux_routes
end type
type cb_oper from commandbutton within w_a_spb_travaux_routes
end type
type gb_1 from groupbox within w_a_spb_travaux_routes
end type
end forward

global type w_a_spb_travaux_routes from w_a_spb_ancetre_etat_wkf
integer width = 3625
string title = "Etat des Motifs de routage"
dw_oper dw_oper
st_3 st_3
cb_oper cb_oper
gb_1 gb_1
end type
global w_a_spb_travaux_routes w_a_spb_travaux_routes

forward prototypes
protected function long wf_retrieve (date addatedebut, date addatefin)
protected subroutine wf_initialiserdwoper ()
end prototypes

protected function long wf_retrieve (date addatedebut, date addatefin);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_retrieve ( Protected ) Override
//* Auteur			: DBI
//* Date				: 20/11/1998 09:22:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement de la datawindow
//* Commentaires	: 
//*
//* Arguments		: adDateDebut date	- date de d$$HEX1$$e900$$ENDHEX$$but de traitement
//*					  adDateFin   date	- date de fin de traitement
//* Retourne		: Long			Nb lignes charg$$HEX1$$e900$$ENDHEX$$es 
//*										
//*
//*-----------------------------------------------------------------

Long		lRet

lRet		=	Dw_Etat.uf_Retrieve ( 1, adDateDebut, adDateFin )

Dw_Oper.SetItem ( 1, "COD_OPER", "    " )  // Tous 

Return ( lRet )
end function

protected subroutine wf_initialiserdwoper ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_InitialiserDwOper ( Protected ) 
//* Auteur			: DBI
//* Date				: 15/09/1999 09:22:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement de la datawindow des op$$HEX1$$e900$$ENDHEX$$rateurs
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*					  
//* Retourne		: Rien
//*										
//*
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

String				sRepTemp
String				sFicOper
String				sOperLu
String				sOperActuel

Long 					lCpt

DataWindowChild	dddwLstOper

//********** Chargement de la liste des op$$HEX1$$e900$$ENDHEX$$rateurs
//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//sRepTemp = stGlb.sWinDir + "\TEMP\"
sRepTemp = stGlb.sRepTempo

sFicOper = "OPER" + stGlb.sCodAppli + ".TXT"

sFicOper = sRepTemp + sFicOper

Dw_Oper.InsertRow ( 0 )
Dw_Oper.GetChild ( "COD_OPER", dddwLstOper )

dddwLstOper.ImportFile ( sFicOper )

sOperActuel = dddwLstOper.GetItemString ( dddwLstOper.RowCount (), "COD_OPER" )

For lCpt = dddwLstOper.RowCount () -1 To 1 Step -1

	//********** J'enl$$HEX1$$e800$$ENDHEX$$ve les doublons

	sOperLu = dddwLstOper.GetItemString ( lCpt, "COD_OPER" )
	If sOperLu <> sOperActuel Then

		sOperActuel = sOperLu
	Else

		dddwLstOper.DeleteRow ( lCpt	)
	End If
Next

dddwLstOper.ImportString ( "0" + "~t" + "    " + "~t" +"-- TOUS --"  )

dddwLstOper.Sort ()

Dw_Oper.SetItem ( 1, "COD_OPER", "    " )
end subroutine

on ue_initialiser;call w_a_spb_ancetre_etat_wkf::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_travaux_routes
//* Evenement 		: ue_initialiser
//* Auteur			: DBI
//* Date				: 15/09/1999 09:15:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation Dw pour gestion travaux routes
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_Etat.uf_Initialisation ( stGlb.sFichierIni, stGlb.sCodOper, stGlb.sCodAppli, "R", itrTrans )

wf_InitialiserDwOper ( )
end on

on w_a_spb_travaux_routes.create
int iCurrent
call super::create
this.dw_oper=create dw_oper
this.st_3=create st_3
this.cb_oper=create cb_oper
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_oper
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.cb_oper
this.Control[iCurrent+4]=this.gb_1
end on

on w_a_spb_travaux_routes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_oper)
destroy(this.st_3)
destroy(this.cb_oper)
destroy(this.gb_1)
end on

type pb_retour from w_a_spb_ancetre_etat_wkf`pb_retour within w_a_spb_travaux_routes
integer taborder = 80
end type

type pb_interro from w_a_spb_ancetre_etat_wkf`pb_interro within w_a_spb_travaux_routes
integer taborder = 110
end type

type pb_creer from w_a_spb_ancetre_etat_wkf`pb_creer within w_a_spb_travaux_routes
integer taborder = 90
end type

type dw_1 from w_a_spb_ancetre_etat_wkf`dw_1 within w_a_spb_travaux_routes
end type

type pb_tri from w_a_spb_ancetre_etat_wkf`pb_tri within w_a_spb_travaux_routes
integer taborder = 120
end type

type pb_imprimer from w_a_spb_ancetre_etat_wkf`pb_imprimer within w_a_spb_travaux_routes
integer taborder = 100
end type

type st_1 from w_a_spb_ancetre_etat_wkf`st_1 within w_a_spb_travaux_routes
integer y = 300
end type

type st_2 from w_a_spb_ancetre_etat_wkf`st_2 within w_a_spb_travaux_routes
integer y = 300
end type

type dw_2 from w_a_spb_ancetre_etat_wkf`dw_2 within w_a_spb_travaux_routes
integer x = 2153
integer y = 304
integer taborder = 60
end type

type pb_excel from w_a_spb_ancetre_etat_wkf`pb_excel within w_a_spb_travaux_routes
integer taborder = 130
end type

type dw_etat from w_a_spb_ancetre_etat_wkf`dw_etat within w_a_spb_travaux_routes
integer y = 504
integer taborder = 70
end type

type uo_dte_deb from w_a_spb_ancetre_etat_wkf`uo_dte_deb within w_a_spb_travaux_routes
integer y = 384
end type

type uo_dte_fin from w_a_spb_ancetre_etat_wkf`uo_dte_fin within w_a_spb_travaux_routes
integer y = 384
end type

type cb_1 from w_a_spb_ancetre_etat_wkf`cb_1 within w_a_spb_travaux_routes
integer x = 3154
integer y = 372
integer width = 343
integer taborder = 40
end type

on cb_1::clicked;call w_a_spb_ancetre_etat_wkf`cb_1::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_spb_ancetre_etat_wkf::cb_1 ( Extend )
//* Evenement 		: Clicked
//* Auteur			: DBI
//* Date				: 18/09/1999 10:38:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: REpositionnement aucun filtre sur Dw_Oper
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_Oper.SetItem ( 1, "COD_OPER", "    " )
end on

type gb_dept from w_a_spb_ancetre_etat_wkf`gb_dept within w_a_spb_travaux_routes
integer x = 2135
integer y = 268
end type

type dw_oper from datawindow within w_a_spb_travaux_routes
integer x = 2153
integer y = 132
integer width = 997
integer height = 76
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_spb_oper_motif_rout"
boolean border = false
boolean livescroll = true
end type

on losefocus;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_oper
//* Evenement 		: losefocus
//* Auteur			: DBI
//* Date				: 16/09/1999 15:21:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.AcceptText ( )

end on

type st_3 from statictext within w_a_spb_travaux_routes
integer x = 2478
integer y = 72
integer width = 306
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Op$$HEX1$$e900$$ENDHEX$$rateur"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_oper from commandbutton within w_a_spb_travaux_routes
integer x = 3154
integer y = 132
integer width = 343
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Appliquer"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: cb_appliquer
//* Evenement 		: clicked
//* Auteur			: DBI
//* Date				: 16/09/1999 15:21:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Filtre la Dw En fonction d'un operateur
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sCodOper

If Dw_Etat.DataObject <> "" Then

	sCodOper = Dw_Oper.GetItemString ( 1, "COD_OPER" )

	If sCodOper <> "    " Then		// Tous les op$$HEX1$$e900$$ENDHEX$$rateurs

		Dw_Etat.SetFilter ( "DOS_MAJ_PAR = ~'" + sCodOper + "~'")
	Else

		Dw_Etat.SetFilter ( "" )
	End If
	Dw_Etat.Filter ( ) 
End If

//------- Repositionnement aucun filtre sur Dept

Dw_2.SetItem ( 1, "ID_DEPT", -1 )
end on

type gb_1 from groupbox within w_a_spb_travaux_routes
integer x = 2135
integer y = 28
integer width = 1385
integer height = 224
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

