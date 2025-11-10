HA$PBExportHeader$w_8_traitement_master.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement master 800 x 600
forward
global type w_8_traitement_master from w_traitement_master
end type
end forward

global type w_8_traitement_master from w_traitement_master
end type
global w_8_traitement_master w_8_traitement_master

on w_8_traitement_master.create
call w_traitement_master::create
end on

on w_8_traitement_master.destroy
call w_traitement_master::destroy
end on

type dw_1 from w_traitement_master`dw_1 within w_8_traitement_master
int X=805
end type

type pb_retour from w_traitement_master`pb_retour within w_8_traitement_master
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_quit.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_valider from w_traitement_master`pb_valider within w_8_traitement_master
int X=522
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_valid.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_imprimer from w_traitement_master`pb_imprimer within w_8_traitement_master
int X=1006
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_imp.bmp"
string DisabledName=""
int TextSize=-7
string FaceName="Arial"
end type

type pb_controler from w_traitement_master`pb_controler within w_8_traitement_master
int X=279
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_ctl.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_supprimer from w_traitement_master`pb_supprimer within w_8_traitement_master
int X=764
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_annu.bmp"
int TextSize=-7
string FaceName="Arial"
end type

