HA$PBExportHeader$u_pbimprimer.sru
$PBExportComments$----} UserObjet Picture Bouton Imprimer
forward
global type u_pbimprimer from picturebutton
end type
end forward

global type u_pbimprimer from picturebutton
int Width=266
int Height=153
int TabOrder=1
string Text="I&mprimer"
string PictureName="k:\pb4obj\bmp\imp.bmp"
string DisabledName="k:\pb4obj\bmp\imp.bmp"
boolean OriginalSize=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_pbimprimer u_pbimprimer

on clicked;Parent.TriggerEvent ( "ue_Imprimer" )
end on

