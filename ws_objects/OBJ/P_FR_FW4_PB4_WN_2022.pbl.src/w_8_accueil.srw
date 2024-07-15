HA$PBExportHeader$w_8_accueil.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil 800 x 600
forward
global type w_8_accueil from w_accueil
end type
end forward

global type w_8_accueil from w_accueil
end type
global w_8_accueil w_8_accueil

on w_8_accueil.create
call w_accueil::create
end on

on w_8_accueil.destroy
call w_accueil::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_accueil`pb_retour within w_8_accueil
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_quit.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_interro from w_accueil`pb_interro within w_8_accueil
int X=503
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_inter.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_creer from w_accueil`pb_creer within w_8_accueil
int X=261
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_creer.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_tri from w_accueil`pb_tri within w_8_accueil
int X=746
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_tri.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_imprimer from w_accueil`pb_imprimer within w_8_accueil
int X=988
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_imp.bmp"
int TextSize=-7
string FaceName="Arial"
end type

