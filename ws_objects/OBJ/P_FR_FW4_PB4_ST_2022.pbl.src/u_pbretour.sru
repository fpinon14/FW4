HA$PBExportHeader$u_pbretour.sru
$PBExportComments$----} UserObjet Picture Bouton Retour
forward
global type u_pbretour from picturebutton
end type
end forward

global type u_pbretour from picturebutton
int Width=266
int Height=153
int TabOrder=1
string Text="&Retour"
string PictureName="k:\pb4obj\bmp\quitter.bmp"
boolean OriginalSize=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_pbretour u_pbretour

on clicked;Parent.TriggerEvent ( "ue_Retour", 1, 1 )
end on

