HA$PBExportHeader$u_pbsupprimer.sru
$PBExportComments$----} UserObjet Picture Bouton Supprimer
forward
global type u_pbsupprimer from picturebutton
end type
end forward

global type u_pbsupprimer from picturebutton
int Width=266
int Height=153
int TabOrder=1
string Text="&Supprimer"
string PictureName="k:\pb4obj\bmp\annuler.bmp"
boolean OriginalSize=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_pbsupprimer u_pbsupprimer

on clicked;Parent.TriggerEvent ( "ue_supprimer" )
end on

