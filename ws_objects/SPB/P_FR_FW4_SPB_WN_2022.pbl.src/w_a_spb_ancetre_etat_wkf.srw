$PBExportHeader$w_a_spb_ancetre_etat_wkf.srw
$PBExportComments$----} Fenêtre Ancêtre pour l'édition des états de production journaliers. ( DCMP 990391 )
forward
global type w_a_spb_ancetre_etat_wkf from w_8_accueil
end type
type st_1 from statictext within w_a_spb_ancetre_etat_wkf
end type
type st_2 from statictext within w_a_spb_ancetre_etat_wkf
end type
type dw_2 from datawindow within w_a_spb_ancetre_etat_wkf
end type
type pb_excel from picturebutton within w_a_spb_ancetre_etat_wkf
end type
type dw_etat from u_spb_suivi_travaux within w_a_spb_ancetre_etat_wkf
end type
type uo_dte_deb from u_calendrier_w within w_a_spb_ancetre_etat_wkf
end type
type uo_dte_fin from u_calendrier_w within w_a_spb_ancetre_etat_wkf
end type
type cb_1 from commandbutton within w_a_spb_ancetre_etat_wkf
end type
type gb_dept from groupbox within w_a_spb_ancetre_etat_wkf
end type
end forward

global type w_a_spb_ancetre_etat_wkf from w_8_accueil
integer width = 3630
integer height = 2048
string title = "Production SIMPA2"
st_1 st_1
st_2 st_2
dw_2 dw_2
pb_excel pb_excel
dw_etat dw_etat
uo_dte_deb uo_dte_deb
uo_dte_fin uo_dte_fin
cb_1 cb_1
gb_dept gb_dept
end type
global w_a_spb_ancetre_etat_wkf w_a_spb_ancetre_etat_wkf

type variables
Protected :

	Date	idDateDebut
	Date	idDateFin
end variables

forward prototypes
private function boolean wf_controledates (ref date addtedebut, ref date addtefin)
protected subroutine wf_lancer ()
protected function long wf_retrieve (date adDateDebut, date adDateFin)
end prototypes

private function boolean wf_controledates (ref date addtedebut, ref date addtefin);//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_ControleDates ( PRIVATE )
//* Auteur			:	DBI
//* Date				:	19/11/98 14:16:30
//* Libellé			:	Contrôle les dates saisies 
//* Commentaires	:	
//*
//* Arguments		:	Date	adDteDebut (Ref)			Date de Début
//*						Date	adDteFin	  (Ref)			Date de Fin
//*
//* Retourne		:	Booléen 		Vrai si les dates sont correctes
//*
//*-----------------------------------------------------------------
//* N° Modif          Reçue Le          Effectuée Le          PAR
//*
//*-----------------------------------------------------------------

Boolean		bRet 			= True		//Valeur de retour
Boolean		bSuivant		= True		//On passe danse le test suivant
Date 			dDteDuJour 					//Date du jour
String		sDteDebLu, sDteFinLu		// Les deux dates (Deb et Fin) lu sur les objets
String 		sDateMiseProd				// Date de mise en production de SIMPA2

stMessage.sTitre    = "Contrôle des dates saisies"	
stMessage.bErreurG  = True
sDateMiseProd 		  = ProfileString ( stGlb.sFichierIni, "DIVERS", "DATE_PRODUCTION", "01/01/1995" )

sDteDebLu			  = uo_Dte_Deb.Sle_Affichage.Text
sDteFinLu 			  = uo_Dte_Fin.Sle_Affichage.Text



dDteDuJour 		= 	Today ()

/*----------------------------------------------------------------------------*/
/* Vérification de la validité de la date de début								      */
/*----------------------------------------------------------------------------*/
If bRet and bSuivant and uo_Dte_Deb.Visible Then

	If sDteDebLu = "" Then
	
		bRet = False
		stMessage.sCode   = "EWK0006"	
		stMessage.sVar[1]	= "de début"
		f_Message ( stMessage )

	Else

		If Not IsDate ( sDteDebLu ) Then

			bRet = False
			stMessage.sCode	= "GENE002"
			stMessage.sVar[1]	= "date de début de traitement"
			f_Message ( stMessage )

		Else 
	
			sDteDebLu 		= String ( Date ( sDteDebLu ), "dd/mm/yyyy" )
			adDteDebut		=	Date ( sDteDebLu )
	
		End If
	
	End If

End IF


/*----------------------------------------------------------------------------*/
/* Vérification de la validité de la date de fin								      */
/*----------------------------------------------------------------------------*/
If bRet and bSuivant Then

	If sDteFinLu = "" Then
	
		bRet = False
		stMessage.sCode   = "EWK0006"	
		stMessage.sVar[1]	= "de fin"
		f_Message ( stMessage )

	Else

		If  Not IsDate ( sDtefinLu ) Then

			bRet = False
			stMessage.sCode	= "GENE002"
			stMessage.sVar[1]	= "date de fin de traitement"
			f_Message ( stMessage )

		Else 
	
			sDteFinLu 	= String ( Date ( sDteFinLu ), "dd/mm/yyyy" )
			adDteFin		=	Date ( sDteFinLu )
		
		End If

	End If

End If



/*----------------------------------------------------------------------------*/
/* Contrôle uniquement la date de fin si la date de début est invisible.      */
/*----------------------------------------------------------------------------*/
If bRet and bSuivant and Not uo_Dte_Deb.Visible Then

	/*----------------------------------------------------------------------------*/
	/* Vérification que la date de fin soit inférieure à la date du jour.         */
	/*----------------------------------------------------------------------------*/
	If ( adDteFin > dDteDuJour ) Then

		bRet = False
		stMessage.sCode   = "EWK0004"	
		stMessage.sVar[1] = "de fin"	
		f_Message ( stMessage )

	Else

		adDteDebut	=	adDteFin
	End If


	/*----------------------------------------------------------------------------*/
	/* Vérification que la date de début soit supérieure (ou égale) à la date de  */
	/* mise en prod de SIMPA2																		*/
	/*----------------------------------------------------------------------------*/
	If bRet and adDteFin < Date ( sDateMiseProd ) Then

		bRet = False
		stMessage.sCode	= "EWK0007"
		stMessage.sVar[1]	= "de fin"
		stMessage.sVar[2]	= sDateMiseProd
		f_Message ( stMessage )

	End IF

	bSuivant = False

End If


/*----------------------------------------------------------------------------*/
/* Vérification que la date de début soit inférieure à la date du jour.        */
/*----------------------------------------------------------------------------*/
If bRet and bSuivant and ( adDteDebut >= dDteDuJour ) Then

	bRet = False
	stMessage.sCode   = "EWK0004"	
	stMessage.sVar[1] = "de début"	
	f_Message ( stMessage )

End If


/*----------------------------------------------------------------------------*/
/* Vérification que la date de fin soit inférieure à la date du jour.          */
/*----------------------------------------------------------------------------*/
If bRet and bSuivant and ( adDteFin >= dDteDuJour ) Then

	bRet = False
	stMessage.sCode   = "EWK0004"	
	stMessage.sVar[1] = "de fin"
	f_Message ( stMessage )

End If


/*----------------------------------------------------------------------------*/
/* Vérification que la date de début est inférieure à la date de fin.         */
/*----------------------------------------------------------------------------*/
If bRet and bSuivant and ( adDteDebut > adDteFin ) Then

	bRet = False
	stMessage.sCode   = "EWK0008"	
	stMessage.sVar[1] = "date de début"	
	stMessage.sVar[2] = "date de fin"	
	f_Message ( stMessage )
	
End If


/*----------------------------------------------------------------------------*/
/* Vérification que la date de début soit supérieure (ou égale) à la date de  */
/* mise en prod de SIMPA2																		*/
/*----------------------------------------------------------------------------*/
If bRet and bSuivant and adDteDebut < Date ( sDateMiseProd ) Then

	bRet = False
	stMessage.sCode	= "EWK0007"
	stMessage.sVar[1]	= "de début"
	stMessage.sVar[2]	= sDateMiseProd
	f_Message ( stMessage )

End IF

Return ( bRet )

end function

protected subroutine wf_lancer ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Lancer ( Protected )
//* Auteur			: DBI
//* Date				:  12:09:52
//* Libellé			: Chargement de la datawindow avec import des fichiers textes
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String 		sDept				// Département Spécifier si nécessaire
Date			dDateDebut		// Date de début de traitement
Date			dDateFin			// Date de fin de traitement
Long			lNbLig			// Nombre de lignes chargées 

/*----------------------------------------------------------------------------*/
/* Contrôle des dates saisies.                                                */
/*----------------------------------------------------------------------------*/
If wf_ControleDates ( dDateDebut, dDateFin ) Then

	pb_Creer.Enabled 		= False
	pb_Imprimer.Enabled 	= False
	pb_Retour.Enabled 	= False
	pb_Excel.Enabled 		= False

	dw_Etat.SetRedraw ( False )
	SetPointer        ( HourGlass! )	
	/*----------------------------------------------------------------------------*/
	/* chargment de la datawindow à réaliser dans les fenêtres descendantes       */
	/*----------------------------------------------------------------------------*/
	lNbLig = wf_Retrieve ( dDateDebut, dDateFin )

	dw_Etat.SetRedraw ( True ) 
	SetPointer        ( Arrow! )	

	pb_Creer.Enabled 		= True
	pb_Imprimer.Enabled 	= True
	pb_Retour.Enabled 	= True
	pb_Excel.Enabled 		= True

	/*----------------------------------------------------------------------------*/
	/* Avertissement si aucune donnée n'a été trouvée.                            */
	/*----------------------------------------------------------------------------*/
	If ( lNbLig = 0 ) Then	

		stMessage.sTitre   = "Résultat de la recherche"
		stMessage.sCode    = "CTRL024"
		stMessage.bErreurG = TRUE
		f_Message ( stMessage )

	End If

End If

end subroutine

protected function long wf_retrieve (date adDateDebut, date adDateFin);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_retrieve
//* Auteur			: DBI
//* Date				: 20/11/1998 09:07:55
//* Libellé			: Chargement de la datawindow
//* Commentaires	: 
//*
//* Arguments		: adDateDebut Date - Date de début de traitement
//*					  adDateFin   Date - Date de fin de traitement
//* Retourne		: Long			 Nb de lignes chargées
//*
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Cette fonction est à surcodifier dans les descendants            */
/*------------------------------------------------------------------*/

Return ( 0 )
end function

on ue_initialiser;call w_8_accueil::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_ancetre_etat_wkf
//* Evenement 		:	Ue_Initialiser - Extend
//* Auteur			:	DBI
//* Date				:	08/12/1998
//* Libellé			:	Initialisation des objects de transaction pour Dw_2
//*						et des dddw
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

DatawindowChild 	dwcDept

itrTrans	=	SQLCA

Dw_2.SetTransObject ( itrTrans )
Dw_2.GetChild ( "ID_DEPT", dwcDept )


dwcDept.SetTransObject ( itrTrans )
dwcDept.Retrieve ( )

/*----------------------------------------------------------------------------*/
/* Ajout d'une ligne pour la sélection de tous les départements               */
/* indifféremment                                                             */
/*----------------------------------------------------------------------------*/

dwcDept.ImportString ( "-1~t-- TOUS --" )
dwcDept.SetSort ( "#1 A" )
dwcDept.Sort ()

Dw_2.InsertRow ( 0 )
Dw_2.SetItem   ( 1, "ID_DEPT", -1 )

end on

on w_a_spb_ancetre_etat_wkf.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.dw_2=create dw_2
this.pb_excel=create pb_excel
this.dw_etat=create dw_etat
this.uo_dte_deb=create uo_dte_deb
this.uo_dte_fin=create uo_dte_fin
this.cb_1=create cb_1
this.gb_dept=create gb_dept
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.pb_excel
this.Control[iCurrent+5]=this.dw_etat
this.Control[iCurrent+6]=this.uo_dte_deb
this.Control[iCurrent+7]=this.uo_dte_fin
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.gb_dept
end on

on w_a_spb_ancetre_etat_wkf.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_2)
destroy(this.pb_excel)
destroy(this.dw_etat)
destroy(this.uo_dte_deb)
destroy(this.uo_dte_fin)
destroy(this.cb_1)
destroy(this.gb_dept)
end on

type cb_debug from w_8_accueil`cb_debug within w_a_spb_ancetre_etat_wkf
end type

type pb_retour from w_8_accueil`pb_retour within w_a_spb_ancetre_etat_wkf
integer width = 242
integer height = 144
integer taborder = 60
end type

type pb_interro from w_8_accueil`pb_interro within w_a_spb_ancetre_etat_wkf
boolean visible = false
integer width = 242
integer height = 144
integer taborder = 90
end type

type pb_creer from w_8_accueil`pb_creer within w_a_spb_ancetre_etat_wkf
integer x = 270
integer width = 242
integer height = 144
integer taborder = 70
string text = "&Lancer"
end type

on pb_creer::clicked;call w_8_accueil`pb_creer::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_accueil::pb_creer
//* Evenement 		: Clicked
//* Auteur			: DBI
//* Date				: 14/08/1997 11:17:53
//* Libellé			: Chargement de la fenêtre par l'import des fichiers
//*					  de worflow 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*
//*	VCP	  28/8/97	Paramétrage du répertoire de trace à utiliser 
//*                     à l'aide d'une fonction et non pas en dur.
//*-----------------------------------------------------------------

Wf_Lancer (  ) 
end on

type dw_1 from w_8_accueil`dw_1 within w_a_spb_ancetre_etat_wkf
integer x = 2089
integer y = 32
integer width = 466
integer height = 148
integer taborder = 0
end type

type pb_tri from w_8_accueil`pb_tri within w_a_spb_ancetre_etat_wkf
boolean visible = false
integer width = 242
integer height = 144
integer taborder = 100
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_spb_ancetre_etat_wkf
boolean visible = true
integer x = 521
integer width = 242
integer height = 144
integer taborder = 80
boolean enabled = true
end type

on pb_imprimer::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_accueil::pb_imprimer
//* Evenement 		: Clicked
//* Auteur			: DBI
//* Date				: 14/08/1997 14:27:19
//* Libellé			: Impression de la datawindow
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_Etat.Print ()

end on

type st_1 from statictext within w_a_spb_ancetre_etat_wkf
integer x = 1371
integer y = 212
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "jusqu~'au"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_a_spb_ancetre_etat_wkf
integer x = 375
integer y = 212
integer width = 325
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "A partir du"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_a_spb_ancetre_etat_wkf
integer x = 2162
integer y = 224
integer width = 1001
integer height = 176
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_spb_choix_departement"
boolean border = false
boolean livescroll = true
end type

type pb_excel from picturebutton within w_a_spb_ancetre_etat_wkf
integer x = 773
integer y = 16
integer width = 242
integer height = 144
integer taborder = 110
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Excel"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_routag.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Pb_Excel
//* Evenement 		: Clicked!
//* Auteur			: DBI
//* Date				: 11/05/1998
//* Libellé			: Sauvegarde de la datawindow au format excel
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* FPI				19/07/2024	[MIG_PB2022] Type de saveAs en Excel! remplacé par Excel8!				  
//*-----------------------------------------------------------------

String	sNomComplet, sNomFic

Int		iRetour

iRetour = GetFileSaveName( "Sauvegarde du fichier Excel", sNomComplet, sNomFic, "", &
	"Fichiers Excel (*.XLS),*.XLS, Tous Fichiers (*.*),*.*")

If iRetour = 1 Then

	Dw_Etat.SaveAs ( sNomComplet, Excel8!, True ) // [MIG_PB2022] ald Excel!
End If

end event

type dw_etat from u_spb_suivi_travaux within w_a_spb_ancetre_etat_wkf
integer x = 55
integer y = 424
integer width = 3479
integer height = 1344
integer taborder = 50
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type uo_dte_deb from u_calendrier_w within w_a_spb_ancetre_etat_wkf
integer x = 87
integer y = 296
integer width = 933
integer height = 96
integer taborder = 10
end type

on uo_dte_deb.destroy
call u_calendrier_w::destroy
end on

type uo_dte_fin from u_calendrier_w within w_a_spb_ancetre_etat_wkf
integer x = 1056
integer y = 296
integer width = 914
integer height = 96
integer taborder = 20
end type

on uo_dte_fin.destroy
call u_calendrier_w::destroy
end on

type cb_1 from commandbutton within w_a_spb_ancetre_etat_wkf
integer x = 3200
integer y = 296
integer width = 302
integer height = 76
integer taborder = 30
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
//* Objet 			: cb_1
//* Evenement 		: clicked
//* Auteur			: DBI
//* Date				: 16/09/1999 15:21:47
//* Libellé			: Filtre la Dw En fonction d'un département
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sCodDept

If Dw_Etat.DataObject <> "" Then

	sCodDept = String ( Dw_2.GetItemNumber ( 1, "ID_DEPT" ) )

	Dw_Etat.Uf_Filtrer ( sCodDept )
End If

end on

type gb_dept from groupbox within w_a_spb_ancetre_etat_wkf
integer x = 2144
integer y = 184
integer width = 1385
integer height = 224
integer taborder = 120
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

