HA$PBExportHeader$u_pbcreer.sru
$PBExportComments$----} UserObjet Picture Bouton Creer
forward
global type u_pbcreer from picturebutton
end type
end forward

global type u_pbcreer from picturebutton
int Width=266
int Height=153
int TabOrder=1
string Text="&Cr$$HEX1$$e900$$ENDHEX$$er"
string PictureName="k:\pb4obj\bmp\creer.bmp"
boolean OriginalSize=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_pbcreer u_pbcreer

on clicked;Parent.TriggerEvent ( "ue_Creer" )
end on

