HA$PBExportHeader$w_a_spb_ancetre_etat_wkf.srw
$PBExportComments$----} Fen$$HEX1$$ea00$$ENDHEX$$tre Anc$$HEX1$$ea00$$ENDHEX$$tre pour l'$$HEX1$$e900$$ENDHEX$$dition des $$HEX1$$e900$$ENDHEX$$tats de production journaliers. ( DCMP 990391 )
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
int Width=3630
int Height=2049
boolean TitleBar=true
string Title="Production SIMPA2"
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le les dates saisies 
//* Commentaires	:	
//*
//* Arguments		:	Date	adDteDebut (Ref)			Date de D$$HEX1$$e900$$ENDHEX$$but
//*						Date	adDteFin	  (Ref)			Date de Fin
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 		Vrai si les dates sont correctes
//*
//*-----------------------------------------------------------------
//* N$$HEX2$$b0002000$$ENDHEX$$Modif          Re$$HEX1$$e700$$ENDHEX$$ue Le          Effectu$$HEX1$$e900$$ENDHEX$$e Le          PAR
//*
//*-----------------------------------------------------------------

Boolean		bRet 			= True		//Valeur de retour
Boolean		bSuivant		= True		//On passe danse le test suivant
Date 			dDteDuJour 					//Date du jour
String		sDteDebLu, sDteFinLu		// Les deux dates (Deb et Fin) lu sur les objets
String 		sDateMiseProd				// Date de mise en production de SIMPA2

stMessage.sTitre    = "Contr$$HEX1$$f400$$ENDHEX$$le des dates saisies"	
stMessage.bErreurG  = True
sDateMiseProd 		  = ProfileString ( stGlb.sFichierIni, "DIVERS", "DATE_PRODUCTION", "01/01/1995" )

sDteDebLu			  = uo_Dte_Deb.Sle_Affichage.Text
sDteFinLu 			  = uo_Dte_Fin.Sle_Affichage.Text



dDteDuJour 		= 	Today ()

/*----------------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification de la validit$$HEX2$$e9002000$$ENDHEX$$de la date de d$$HEX1$$e900$$ENDHEX$$but								      */
/*----------------------------------------------------------------------------*/
If bRet and bSuivant and uo_Dte_Deb.Visible Then

	If sDteDebLu = "" Then
	
		bRet = False
		stMessage.sCode   = "EWK0006"	
		stMessage.sVar[1]	= "de d$$HEX1$$e900$$ENDHEX$$but"
		f_Message ( stMessage )

	Else

		If Not IsDate ( sDteDebLu ) Then

			bRet = False
			stMessage.sCode	= "GENE002"
			stMessage.sVar[1]	= "date de d$$HEX1$$e900$$ENDHEX$$but de traitement"
			f_Message ( stMessage )

		Else 
	
			sDteDebLu 		= String ( Date ( sDteDebLu ), "dd/mm/yyyy" )
			adDteDebut		=	Date ( sDteDebLu )
	
		End If
	
	End If

End IF


/*----------------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification de la validit$$HEX2$$e9002000$$ENDHEX$$de la date de fin								      */
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
/* Contr$$HEX1$$f400$$ENDHEX$$le uniquement la date de fin si la date de d$$HEX1$$e900$$ENDHEX$$but est invisible.      */
/*----------------------------------------------------------------------------*/
If bRet and bSuivant and Not uo_Dte_Deb.Visible Then

	/*----------------------------------------------------------------------------*/
	/* V$$HEX1$$e900$$ENDHEX$$rification que la date de fin soit inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date du jour.         */
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
	/* V$$HEX1$$e900$$ENDHEX$$rification que la date de d$$HEX1$$e900$$ENDHEX$$but soit sup$$HEX1$$e900$$ENDHEX$$rieure (ou $$HEX1$$e900$$ENDHEX$$gale) $$HEX2$$e0002000$$ENDHEX$$la date de  */
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
/* V$$HEX1$$e900$$ENDHEX$$rification que la date de d$$HEX1$$e900$$ENDHEX$$but soit inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date du jour.        */
/*----------------------------------------------------------------------------*/
If bRet and bSuivant and ( adDteDebut >= dDteDuJour ) Then

	bRet = False
	stMessage.sCode   = "EWK0004"	
	stMessage.sVar[1] = "de d$$HEX1$$e900$$ENDHEX$$but"	
	f_Message ( stMessage )

End If


/*----------------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification que la date de fin soit inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date du jour.          */
/*----------------------------------------------------------------------------*/
If bRet and bSuivant and ( adDteFin >= dDteDuJour ) Then

	bRet = False
	stMessage.sCode   = "EWK0004"	
	stMessage.sVar[1] = "de fin"
	f_Message ( stMessage )

End If


/*----------------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification que la date de d$$HEX1$$e900$$ENDHEX$$but est inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la date de fin.         */
/*----------------------------------------------------------------------------*/
If bRet and bSuivant and ( adDteDebut > adDteFin ) Then

	bRet = False
	stMessage.sCode   = "EWK0008"	
	stMessage.sVar[1] = "date de d$$HEX1$$e900$$ENDHEX$$but"	
	stMessage.sVar[2] = "date de fin"	
	f_Message ( stMessage )
	
End If


/*----------------------------------------------------------------------------*/
/* V$$HEX1$$e900$$ENDHEX$$rification que la date de d$$HEX1$$e900$$ENDHEX$$but soit sup$$HEX1$$e900$$ENDHEX$$rieure (ou $$HEX1$$e900$$ENDHEX$$gale) $$HEX2$$e0002000$$ENDHEX$$la date de  */
/* mise en prod de SIMPA2																		*/
/*----------------------------------------------------------------------------*/
If bRet and bSuivant and adDteDebut < Date ( sDateMiseProd ) Then

	bRet = False
	stMessage.sCode	= "EWK0007"
	stMessage.sVar[1]	= "de d$$HEX1$$e900$$ENDHEX$$but"
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement de la datawindow avec import des fichiers textes
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String 		sDept				// D$$HEX1$$e900$$ENDHEX$$partement Sp$$HEX1$$e900$$ENDHEX$$cifier si n$$HEX1$$e900$$ENDHEX$$cessaire
Date			dDateDebut		// Date de d$$HEX1$$e900$$ENDHEX$$but de traitement
Date			dDateFin			// Date de fin de traitement
Long			lNbLig			// Nombre de lignes charg$$HEX1$$e900$$ENDHEX$$es 

/*----------------------------------------------------------------------------*/
/* Contr$$HEX1$$f400$$ENDHEX$$le des dates saisies.                                                */
/*----------------------------------------------------------------------------*/
If wf_ControleDates ( dDateDebut, dDateFin ) Then

	pb_Creer.Enabled 		= False
	pb_Imprimer.Enabled 	= False
	pb_Retour.Enabled 	= False
	pb_Excel.Enabled 		= False

	dw_Etat.SetRedraw ( False )
	SetPointer        ( HourGlass! )	
	/*----------------------------------------------------------------------------*/
	/* chargment de la datawindow $$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$aliser dans les fen$$HEX1$$ea00$$ENDHEX$$tres descendantes       */
	/*----------------------------------------------------------------------------*/
	lNbLig = wf_Retrieve ( dDateDebut, dDateFin )

	dw_Etat.SetRedraw ( True ) 
	SetPointer        ( Arrow! )	

	pb_Creer.Enabled 		= True
	pb_Imprimer.Enabled 	= True
	pb_Retour.Enabled 	= True
	pb_Excel.Enabled 		= True

	/*----------------------------------------------------------------------------*/
	/* Avertissement si aucune donn$$HEX1$$e900$$ENDHEX$$e n'a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trouv$$HEX1$$e900$$ENDHEX$$e.                            */
	/*----------------------------------------------------------------------------*/
	If ( lNbLig = 0 ) Then	

		stMessage.sTitre   = "R$$HEX1$$e900$$ENDHEX$$sultat de la recherche"
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement de la datawindow
//* Commentaires	: 
//*
//* Arguments		: adDateDebut Date - Date de d$$HEX1$$e900$$ENDHEX$$but de traitement
//*					  adDateFin   Date - Date de fin de traitement
//* Retourne		: Long			 Nb de lignes charg$$HEX1$$e900$$ENDHEX$$es
//*
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Cette fonction est $$HEX2$$e0002000$$ENDHEX$$surcodifier dans les descendants            */
/*------------------------------------------------------------------*/

Return ( 0 )
end function

on ue_initialiser;call w_8_accueil::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_a_sp_ancetre_etat_wkf
//* Evenement 		:	Ue_Initialiser - Extend
//* Auteur			:	DBI
//* Date				:	08/12/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation des objects de transaction pour Dw_2
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
/* Ajout d'une ligne pour la s$$HEX1$$e900$$ENDHEX$$lection de tous les d$$HEX1$$e900$$ENDHEX$$partements               */
/* indiff$$HEX1$$e900$$ENDHEX$$remment                                                             */
/*----------------------------------------------------------------------------*/

dwcDept.ImportString ( "-1~t-- TOUS --" )
dwcDept.SetSort ( "#1 A" )
dwcDept.Sort ()

Dw_2.InsertRow ( 0 )
Dw_2.SetItem   ( 1, "ID_DEPT", -1 )

end on

on w_a_spb_ancetre_etat_wkf.create
int iCurrent
call w_8_accueil::create
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
this.Control[iCurrent+1]=st_1
this.Control[iCurrent+2]=st_2
this.Control[iCurrent+3]=dw_2
this.Control[iCurrent+4]=pb_excel
this.Control[iCurrent+5]=dw_etat
this.Control[iCurrent+6]=uo_dte_deb
this.Control[iCurrent+7]=uo_dte_fin
this.Control[iCurrent+8]=cb_1
this.Control[iCurrent+9]=gb_dept
end on

on w_a_spb_ancetre_etat_wkf.destroy
call w_8_accueil::destroy
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

type pb_retour from w_8_accueil`pb_retour within w_a_spb_ancetre_etat_wkf
int TabOrder=60
end type

type pb_interro from w_8_accueil`pb_interro within w_a_spb_ancetre_etat_wkf
int TabOrder=90
boolean Visible=false
end type

type pb_creer from w_8_accueil`pb_creer within w_a_spb_ancetre_etat_wkf
int X=270
int TabOrder=70
string Text="&Lancer"
end type

on pb_creer::clicked;call w_8_accueil`pb_creer::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_accueil::pb_creer
//* Evenement 		: Clicked
//* Auteur			: DBI
//* Date				: 14/08/1997 11:17:53
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement de la fen$$HEX1$$ea00$$ENDHEX$$tre par l'import des fichiers
//*					  de worflow 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*
//*	VCP	  28/8/97	Param$$HEX1$$e900$$ENDHEX$$trage du r$$HEX1$$e900$$ENDHEX$$pertoire de trace $$HEX2$$e0002000$$ENDHEX$$utiliser 
//*                     $$HEX2$$e0002000$$ENDHEX$$l'aide d'une fonction et non pas en dur.
//*-----------------------------------------------------------------

Wf_Lancer (  ) 
end on

type dw_1 from w_8_accueil`dw_1 within w_a_spb_ancetre_etat_wkf
int X=2090
int Y=33
int Width=467
int Height=149
int TabOrder=0
end type

type pb_tri from w_8_accueil`pb_tri within w_a_spb_ancetre_etat_wkf
int TabOrder=100
boolean Visible=false
end type

type pb_imprimer from w_8_accueil`pb_imprimer within w_a_spb_ancetre_etat_wkf
int X=522
int TabOrder=80
boolean Visible=true
boolean Enabled=true
end type

on pb_imprimer::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_8_accueil::pb_imprimer
//* Evenement 		: Clicked
//* Auteur			: DBI
//* Date				: 14/08/1997 14:27:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Impression de la datawindow
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_Etat.Print ()

end on

type st_1 from statictext within w_a_spb_ancetre_etat_wkf
int X=1372
int Y=213
int Width=275
int Height=73
boolean Enabled=false
boolean BringToTop=true
string Text="jusqu'au"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_a_spb_ancetre_etat_wkf
int X=375
int Y=213
int Width=325
int Height=73
boolean Enabled=false
boolean BringToTop=true
string Text="A partir du"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_a_spb_ancetre_etat_wkf
int X=2163
int Y=225
int Width=1002
int Height=177
int TabOrder=40
boolean BringToTop=true
string DataObject="d_spb_choix_departement"
boolean Border=false
boolean LiveScroll=true
end type

type pb_excel from picturebutton within w_a_spb_ancetre_etat_wkf
int X=773
int Y=17
int Width=234
int Height=137
int TabOrder=110
boolean BringToTop=true
string Text="&Excel"
string PictureName="k:\pb4obj\bmp\8_routag.bmp"
boolean OriginalSize=true
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Pb_Excel
//* Evenement 		: Clicked!
//* Auteur			: DBI
//* Date				: 11/05/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Sauvegarde de la datawindow au format excel
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sNomComplet, sNomFic

Int		iRetour

iRetour = GetFileSaveName( "Sauvegarde du fichier Excel", sNomComplet, sNomFic, "", &
	"Fichiers Excel (*.XLS),*.XLS, Tous Fichiers (*.*),*.*")

If iRetour = 1 Then

	Dw_Etat.SaveAs ( sNomComplet, Excel!, True )
End If

end on

type dw_etat from u_spb_suivi_travaux within w_a_spb_ancetre_etat_wkf
int X=55
int Y=425
int Width=3479
int Height=1345
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

type uo_dte_deb from u_calendrier_w within w_a_spb_ancetre_etat_wkf
int X=87
int Y=297
int Width=933
int TabOrder=10
end type

on uo_dte_deb.destroy
call u_calendrier_w::destroy
end on

type uo_dte_fin from u_calendrier_w within w_a_spb_ancetre_etat_wkf
int X=1057
int Y=297
int Width=915
int TabOrder=20
end type

on uo_dte_fin.destroy
call u_calendrier_w::destroy
end on

type cb_1 from commandbutton within w_a_spb_ancetre_etat_wkf
int X=3201
int Y=297
int Width=302
int Height=77
int TabOrder=30
boolean BringToTop=true
string Text="Appliquer"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: cb_1
//* Evenement 		: clicked
//* Auteur			: DBI
//* Date				: 16/09/1999 15:21:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Filtre la Dw En fonction d'un d$$HEX1$$e900$$ENDHEX$$partement
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
int X=2145
int Y=185
int Width=1386
int Height=225
int TabOrder=120
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

