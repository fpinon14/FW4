HA$PBExportHeader$w_8_traitement_detail.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement d$$HEX1$$e900$$ENDHEX$$tail 800 x 600
forward
global type w_8_traitement_detail from w_traitement_detail
end type
end forward

global type w_8_traitement_detail from w_traitement_detail
end type
global w_8_traitement_detail w_8_traitement_detail

on w_8_traitement_detail.create
call w_traitement_detail::create
end on

on w_8_traitement_detail.destroy
call w_traitement_detail::destroy
end on

type pb_retour from w_traitement_detail`pb_retour within w_8_traitement_detail
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_quit.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_valider from w_traitement_detail`pb_valider within w_8_traitement_detail
int X=531
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_valid.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_imprimer from w_traitement_detail`pb_imprimer within w_8_traitement_detail
int X=1025
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_imp.bmp"
string DisabledName=""
int TextSize=-7
string FaceName="Arial"
end type

type pb_controler from w_traitement_detail`pb_controler within w_8_traitement_detail
int X=284
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_ctl.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_supprimer from w_traitement_detail`pb_supprimer within w_8_traitement_detail
int X=778
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_annu.bmp"
int TextSize=-7
string FaceName="Arial"
end type

