HA$PBExportHeader$w_erreur_system.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre qui appara$$HEX1$$ee00$$ENDHEX$$t pour donner un compl$$HEX1$$e900$$ENDHEX$$ment de d$$HEX1$$e900$$ENDHEX$$tail sur le message d'erreur (saisie utilisateur)
forward
global type w_erreur_system from Window
end type
type cb_continuer from commandbutton within w_erreur_system
end type
type cb_imprimer from commandbutton within w_erreur_system
end type
type st_1 from statictext within w_erreur_system
end type
type mle_message from multilineedit within w_erreur_system
end type
type dw_1 from datawindow within w_erreur_system
end type
type uo_ong1 from u_onglets within w_erreur_system
end type
type cb_retour from commandbutton within w_erreur_system
end type
type uo_1 from u_bord3d within w_erreur_system
end type
end forward

global type w_erreur_system from Window
int X=1335
int Y=689
int Width=2227
int Height=1889
boolean TitleBar=true
string Title="Erreur Syst$$HEX1$$e800$$ENDHEX$$me"
long BackColor=12632256
WindowType WindowType=response!
event lancement pbm_custom01
cb_continuer cb_continuer
cb_imprimer cb_imprimer
st_1 st_1
mle_message mle_message
dw_1 dw_1
uo_ong1 uo_ong1
cb_retour cb_retour
uo_1 uo_1
end type
global w_erreur_system w_erreur_system

type variables
Private :
    Boolean ibContinuer = False
end variables

on lancement;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Erreur_System::Lancement
//* Evenement 		: 
//* Auteur			: Erick John Stark
//* Date				: 06/08/1997 15:48:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uo_Ong1.Uf_Initialiser ( 1, 1 )
Uo_Ong1.Uf_EnregistrerOnglet ( "01", "D$$HEX1$$e900$$ENDHEX$$tail Erreur", "", dw_1, True )

dw_1.InsertRow ( 0 )

dw_1.SetItem ( 1, "iErreur", Error.Number )
dw_1.SetItem ( 1, "sWindow", Error.WindowMenu )
dw_1.SetItem ( 1, "sObject", Error.Object )
dw_1.SetItem ( 1, "sObjectEvent", Error.ObjectEvent )
dw_1.SetItem ( 1, "iLine", Error.Line )
dw_1.SetItem ( 1, "sText", Error.Text )

/*------------------------------------------------------------------*/
/* Dans le cas d'un op$$HEX1$$e900$$ENDHEX$$rateur informatique, on accepte de           */
/* continuer $$HEX2$$e0002000$$ENDHEX$$ses risques et p$$HEX1$$e900$$ENDHEX$$rils                                */
/*------------------------------------------------------------------*/

If	stGLB.sCodOper = "9" Then
	Cb_Continuer.Visible = True
	Cb_Continuer.Enabled = True
End If



end on

on open;//*-----------------------------------------------------------------
//*
//* Objet 			: 
//* Evenement 		: 
//* Auteur			: Erick John Stark
//* Date				: 03/08/1997 18:52:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.PostEvent ( "Lancement" )



end on

on w_erreur_system.create
this.cb_continuer=create cb_continuer
this.cb_imprimer=create cb_imprimer
this.st_1=create st_1
this.mle_message=create mle_message
this.dw_1=create dw_1
this.uo_ong1=create uo_ong1
this.cb_retour=create cb_retour
this.uo_1=create uo_1
this.Control[]={ this.cb_continuer,&
this.cb_imprimer,&
this.st_1,&
this.mle_message,&
this.dw_1,&
this.uo_ong1,&
this.cb_retour,&
this.uo_1}
end on

on w_erreur_system.destroy
destroy(this.cb_continuer)
destroy(this.cb_imprimer)
destroy(this.st_1)
destroy(this.mle_message)
destroy(this.dw_1)
destroy(this.uo_ong1)
destroy(this.cb_retour)
destroy(this.uo_1)
end on

type cb_continuer from commandbutton within w_erreur_system
int X=627
int Y=1637
int Width=261
int Height=109
int TabOrder=30
boolean Visible=false
boolean Enabled=false
string Text="&Continuer"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Cb_Continuer::Clicked
//* Evenement 		: 
//* Auteur			: Erick John Stark
//* Date				: 27/08/1997 15:54:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On accepte de continuer (Seul l'informatique peut faire cela)
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ibContinuer = True

Cb_Retour.PostEvent ( Clicked! )
end on

type cb_imprimer from commandbutton within w_erreur_system
int X=334
int Y=1637
int Width=261
int Height=109
int TabOrder=40
string Text="&Imprimer"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Cb_Imprimer::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 27/08/1997 15:34:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Impression de la DataWindow pour l'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

dw_1.Print ( False )


end on

type st_1 from statictext within w_erreur_system
int X=55
int Y=1013
int Width=2131
int Height=73
boolean Enabled=false
string Text="Expliquer en quelques mots, les actions effectu$$HEX1$$e900$$ENDHEX$$es avant que l'erreur se produise."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_message from multilineedit within w_erreur_system
int X=65
int Y=1117
int Width=2103
int Height=477
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_erreur_system
int X=138
int Y=165
int Width=1825
int Height=757
string DataObject="d_erreur_system"
boolean Border=false
boolean LiveScroll=true
end type

type uo_ong1 from u_onglets within w_erreur_system
int X=106
int Y=29
int Width=499
int Height=109
int TabOrder=0
boolean Border=false
boolean LiveScroll=false
end type

type cb_retour from commandbutton within w_erreur_system
int X=55
int Y=1637
int Width=247
int Height=109
int TabOrder=20
string Text="&Arr$$HEX1$$e900$$ENDHEX$$ter"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: cb_Arreter::Clicked
//* Evenement 		: 
//* Auteur			: Erick John Stark
//* Date				: 07/08/1997 10:45:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPass
String sMess

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie que la personne a renseigne la zone message. Sinon    */
/* on l'oblige $$HEX2$$e0002000$$ENDHEX$$saisir quelque chose.                              */
/*------------------------------------------------------------------*/
/* Sauf dans le cas des informaticiens qui d$$HEX1$$e900$$ENDHEX$$sirent continuer le    */
/* traitement $$HEX2$$e0002000$$ENDHEX$$leurs risques et p$$HEX1$$e900$$ENDHEX$$rils !!!.                        */
/*------------------------------------------------------------------*/

sMess = Trim ( mle_Message.Text )

If	( IsNull ( sMess ) Or sMess = "" ) And ( Not ibContinuer ) Then
	MessageBox ( "Message", "Veuillez saisir un message SVP" )
	Mle_Message.SetFocus ()

Else

	If ibContinuer Then
		stPass.sTab[ 1 ] = "Cnt."
	Else
		stPass.sTab[ 1 ] = "Ret."
	End If

	stPass.sTab[ 2 ] = sMess
	CloseWithReturn ( Parent, stPass )
End If

end on

type uo_1 from u_bord3d within w_erreur_system
int X=115
int Y=137
int Width=1902
int Height=841
end type

on uo_1.destroy
call u_bord3d::destroy
end on

