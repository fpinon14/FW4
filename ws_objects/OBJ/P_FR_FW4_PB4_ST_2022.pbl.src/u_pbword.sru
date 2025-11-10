HA$PBExportHeader$u_pbword.sru
$PBExportComments$----} UserObjet Picture Bouton Word
forward
global type u_pbword from picturebutton
end type
end forward

global type u_pbword from picturebutton
int Width=266
int Height=153
int TabOrder=1
string Text="Editer"
string PictureName="k:\pb4obj\bmp\winword.bmp"
boolean OriginalSize=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_pbword u_pbword

on clicked;Parent.TriggerEvent ( "Ue_word" )
end on

