HA$PBExportHeader$w_calendrier.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre pour l'apparition d'un calendrier dans les DW
forward
global type w_calendrier from Window
end type
type r_1 from rectangle within w_calendrier
end type
type ln_1 from line within w_calendrier
end type
type ln_2 from line within w_calendrier
end type
type uo_1 from u_calendrier within w_calendrier
end type
end forward

global type w_calendrier from Window
int X=439
int Y=457
int Width=782
int Height=737
long BackColor=12632256
WindowType WindowType=popup!
r_1 r_1
ln_1 ln_1
ln_2 ln_2
uo_1 uo_1
end type
global w_calendrier w_calendrier

type variables
Private :
    s_calendrier  istcal
end variables

on open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_calendrier
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 02/12/1996 16:11:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istCal = Message.PowerObjectParm
This.X = istCal.iX
This.Y = istCal.iY

/*------------------------------------------------------------------*/
/* La validit$$HEX2$$e9002000$$ENDHEX$$de la date est assur$$HEX2$$e9002000$$ENDHEX$$dans la fonction               */
/* Uf_ddCalculatrice                                                */
/*------------------------------------------------------------------*/

uo_1.Uf_InitCalendrier ( istCal.dInit )

end on

on deactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: w_calendrier
//* Evenement 		: Deasctivate
//* Auteur			: Erick John Stark
//* Date				: 02/12/1996 16:14:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Si on perd le Focus, on ferme la fen$$HEX1$$ea00$$ENDHEX$$tre
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Close ( This )

end on

on key;//*-----------------------------------------------------------------
//*
//* Objet 			: w_calendrier
//* Evenement 		: Key
//* Auteur			: Erick John Stark
//* Date				: 02/12/1996 16:14:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Si on appuie sur ESC, on ferme la fen$$HEX1$$ea00$$ENDHEX$$tre
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If KeyDown ( KeyEscape! ) Then
	Close ( This )
End If

end on

on w_calendrier.create
this.r_1=create r_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.uo_1=create uo_1
this.Control[]={ this.r_1,&
this.ln_1,&
this.ln_2,&
this.uo_1}
end on

on w_calendrier.destroy
destroy(this.r_1)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.uo_1)
end on

type r_1 from rectangle within w_calendrier
int Width=773
int Height=729
boolean Enabled=false
int LineThickness=9
long LineColor=16777215
long FillColor=12632256
end type

type ln_1 from line within w_calendrier
boolean Enabled=false
int BeginX=769
int EndX=769
int EndY=725
int LineThickness=9
long LineColor=8421504
end type

type ln_2 from line within w_calendrier
boolean Enabled=false
int BeginY=725
int EndX=769
int EndY=729
int LineThickness=9
long LineColor=8421504
end type

type uo_1 from u_calendrier within w_calendrier
int X=14
int Y=17
int Height=697
int TabOrder=1
boolean Border=false
end type

on ue_fermer;call u_calendrier::ue_fermer;//*-----------------------------------------------------------------
//*
//* Objet 			: uo_1
//* Evenement 		: Ue_Fermer
//* Auteur			: Erick John Stark
//* Date				: 03/12/1996 10:31:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*

Cette fen$$HEX1$$ea00$$ENDHEX$$tre est utilis$$HEX1$$e900$$ENDHEX$$e soit par 
	- Le user objet "u_DataWindow"			istCal.iChoix = 1
	- Le user objet "u_Calendrier_w"			istCal.iChoix = 2

*/

Choose Case istCal.iChoix
Case 1
	istCal.dwTrt.SetText ( String ( This.idEnCours ) )

Case 2
	istCal.sle_Affichage.Text	= Uo_1.Uf_AfficherDate ( istCal.iTypeDate, This.idEnCours )
	istCal.sle_Dte.Text			= String ( This.idEnCours )

End Choose

Close ( Parent )
end on

on uo_1.destroy
call u_calendrier::destroy
end on

