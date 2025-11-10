HA$PBExportHeader$w_8_ancetre_consultation.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre de consultation 800 x 600
forward
global type w_8_ancetre_consultation from w_ancetre_consultation
end type
end forward

global type w_8_ancetre_consultation from w_ancetre_consultation
end type
global w_8_ancetre_consultation w_8_ancetre_consultation

on w_8_ancetre_consultation.create
call w_ancetre_consultation::create
end on

on w_8_ancetre_consultation.destroy
call w_ancetre_consultation::destroy
end on

type pb_retour from w_ancetre_consultation`pb_retour within w_8_ancetre_consultation
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_quit.bmp"
int TextSize=-7
string FaceName="Arial"
end type

