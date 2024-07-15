HA$PBExportHeader$u_pbcontroler.sru
$PBExportComments$----} UserObjet Picture Bouton Controler
forward
global type u_pbcontroler from picturebutton
end type
end forward

global type u_pbcontroler from picturebutton
integer width = 265
integer height = 152
integer taborder = 1
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Contr$$HEX1$$f400$$ENDHEX$$ler"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\ctl.bmp"
end type
global u_pbcontroler u_pbcontroler

event clicked;Parent.TriggerEvent ( "ue_controler" )


end event

on u_pbcontroler.create
end on

on u_pbcontroler.destroy
end on

