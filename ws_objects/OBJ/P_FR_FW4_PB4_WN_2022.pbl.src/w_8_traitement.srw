HA$PBExportHeader$w_8_traitement.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement 800 x 600
forward
global type w_8_traitement from w_traitement
end type
end forward

global type w_8_traitement from w_traitement
int Width=2469
int Height=1725
end type
global w_8_traitement w_8_traitement

on w_8_traitement.create
call w_traitement::create
end on

on w_8_traitement.destroy
call w_traitement::destroy
end on

type dw_1 from w_traitement`dw_1 within w_8_traitement
int X=709
int Y=565
int Width=910
int Height=501
end type

type pb_retour from w_traitement`pb_retour within w_8_traitement
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_quit.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_valider from w_traitement`pb_valider within w_8_traitement
int X=531
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_valid.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_imprimer from w_traitement`pb_imprimer within w_8_traitement
int X=1029
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_imp.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_controler from w_traitement`pb_controler within w_8_traitement
int X=284
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_ctl.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_supprimer from w_traitement`pb_supprimer within w_8_traitement
int X=778
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_annu.bmp"
int TextSize=-7
string FaceName="Arial"
end type

