HA$PBExportHeader$u_pbinterro.sru
$PBExportComments$----} UserObjet Picture Bouton Interro
forward
global type u_pbinterro from picturebutton
end type
end forward

global type u_pbinterro from picturebutton
int Width=261
int Height=141
int TabOrder=1
string Text="&Interro."
string PictureName="k:\pb4obj\bmp\interro.bmp"
boolean OriginalSize=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_pbinterro u_pbinterro

type variables
s_Interro       istInterro



end variables

on clicked;Parent.TriggerEvent ( "ue_Interro" )
end on

