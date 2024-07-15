HA$PBExportHeader$u_pbeffacer.sru
$PBExportComments$----} UserObjet Picture Bouton Effacer
forward
global type u_pbeffacer from picturebutton
end type
end forward

global type u_pbeffacer from picturebutton
int Width=266
int Height=153
int TabOrder=1
string Text="&Effacer"
string PictureName="k:\pb4obj\bmp\efface.bmp"
boolean OriginalSize=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_pbeffacer u_pbeffacer

on clicked;Parent.TriggerEvent ( "ue_Effacer" )
end on

