HA$PBExportHeader$u_calendrier_w.sru
$PBExportComments$------} UserObjet Calendrier utilis$$HEX2$$e9002000$$ENDHEX$$dans les fen$$HEX1$$ea00$$ENDHEX$$tres
forward
global type u_calendrier_w from UserObject
end type
type sle_date from singlelineedit within u_calendrier_w
end type
type p_ddlb from picture within u_calendrier_w
end type
type sle_affichage from singlelineedit within u_calendrier_w
end type
end forward

global type u_calendrier_w from UserObject
int Width=910
int Height=97
long BackColor=12632256
sle_date sle_date
p_ddlb p_ddlb
sle_affichage sle_affichage
end type
global u_calendrier_w u_calendrier_w

type variables
Private : 
    window             iwParent

Protected :
    Integer              iiTypeDate
end variables

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Calendrier_w
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 19/11/1996 18:46:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation du User Objet
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iwParent = Parent

iiTypeDate = 1
end on

on u_calendrier_w.create
this.sle_date=create sle_date
this.p_ddlb=create p_ddlb
this.sle_affichage=create sle_affichage
this.Control[]={ this.sle_date,&
this.p_ddlb,&
this.sle_affichage}
end on

on u_calendrier_w.destroy
destroy(this.sle_date)
destroy(this.p_ddlb)
destroy(this.sle_affichage)
end on

type sle_date from singlelineedit within u_calendrier_w
int X=1011
int Y=25
int Width=247
int Height=89
int TabOrder=20
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_ddlb from picture within u_calendrier_w
int X=823
int Y=5
int Width=78
int Height=89
string PictureName="k:\pb4obj\bmp\ddlb.bmp"
boolean FocusRectangle=false
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: p_ddlb
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 19/11/1996 18:46:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Activation/D$$HEX1$$e900$$ENDHEX$$sactivation du calendrier
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Calendrier stCal
Environment stEnv
Integer iX, iY, iCalendrierHauteur
String sText

SetPointer ( HourGlass! )

/*------------------------------------------------------------------*/
/* Si la date n'est pas bonne on ressort tout de suite              */
/*------------------------------------------------------------------*/

sText = sle_Affichage.Text
If	sText = "" Or sText = "01/01/1900" Or IsNull ( sText ) Then sText = String ( Today () )

If	Not IsDate ( sText ) And iiTypeDate = 2 Then	
	sText = sle_Date.Text
	sle_Affichage.Text = sText
End If

If Not IsDate ( sText ) Then Return

stCal.dInit 	= Date ( sText )

iX		= Parent.X
iY		= Parent.Y

stCal.iX = iwParent.WorkSpaceX () + iX + sle_Affichage.X - 2
stCal.iY = iwParent.WorkSpaceY () + iY + sle_Affichage.Y + sle_Affichage.Height + 12

iCalendrierHauteur = 695
GetEnvironment ( stEnv )

/*------------------------------------------------------------------*/
/* Je populise expr$$HEX1$$e900$$ENDHEX$$s une structure bas$$HEX1$$e900$$ENDHEX$$e sur l'environnement,      */
/* bien que celle-ci puisse exister dans stGLB                      */
/*------------------------------------------------------------------*/

If	stCal.iY + iCalendrierHauteur > PixelsToUnits ( stEnv.ScreenHeight, YPixelsToUnits! ) Then
	stCal.iY -= sle_Affichage.Height + iCalendrierHauteur + 72
End If

stCal.sle_Affichage 	= sle_Affichage
stCal.sle_Dte			= sle_Date
stCal.iTypeDate		= Parent.iiTypeDate
stCal.iChoix			= 2

OpenWithParm ( w_Calendrier, stCal )

end on

type sle_affichage from singlelineedit within u_calendrier_w
int X=10
int Y=9
int Width=810
int Height=81
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

