HA$PBExportHeader$u_pbvalider.sru
$PBExportComments$----} UserObjet Picture Bouton Valider
forward
global type u_pbvalider from picturebutton
end type
end forward

global type u_pbvalider from picturebutton
int Width=266
int Height=153
int TabOrder=1
string Text="&Valider"
string PictureName="k:\pb4obj\bmp\valider.bmp"
boolean OriginalSize=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_pbvalider u_pbvalider

on clicked;Parent.TriggerEvent ( "ue_Valider" )
end on

