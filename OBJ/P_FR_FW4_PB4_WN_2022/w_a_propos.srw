HA$PBExportHeader$w_a_propos.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre A Propos De
forward
global type w_a_propos from w_logoapp
end type
type pb_retour from u_pbretour within w_a_propos
end type
end forward

global type w_a_propos from w_logoapp
int Width=2346
int Height=1697
WindowType WindowType=response!
boolean Enabled=true
boolean TitleBar=true
string Title="A Propos De ..."
pb_retour pb_retour
end type
global w_a_propos w_a_propos

on ue_retour;call w_logoapp::ue_retour;//*****************************************************************************
//
// Objet 		: w_A_Propos
// Evenement 	: Ue_Retour
//	Auteur		: D.Bizien
//	Date			: 27/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre A Propos
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Close ( This )
end on

on w_a_propos.create
int iCurrent
call w_logoapp::create
this.pb_retour=create pb_retour
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=pb_retour
end on

on w_a_propos.destroy
call w_logoapp::destroy
destroy(this.pb_retour)
end on

type dw_logo from w_logoapp`dw_logo within w_a_propos
int X=83
int TabOrder=10
end type

type pb_retour from u_pbretour within w_a_propos
int X=1015
int Y=1401
int TabOrder=20
end type

