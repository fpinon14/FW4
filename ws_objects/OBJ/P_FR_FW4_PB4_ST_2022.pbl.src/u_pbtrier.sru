HA$PBExportHeader$u_pbtrier.sru
$PBExportComments$----} UserObjet Picture Bouton Trier
forward
global type u_pbtrier from picturebutton
end type
end forward

global type u_pbtrier from picturebutton
int Width=266
int Height=153
int TabOrder=1
string Text="&Trier"
string PictureName="k:\pb4obj\bmp\tri.bmp"
boolean OriginalSize=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_pbtrier u_pbtrier

on clicked;Parent.TriggerEvent ( "Ue_Trier" )
end on

