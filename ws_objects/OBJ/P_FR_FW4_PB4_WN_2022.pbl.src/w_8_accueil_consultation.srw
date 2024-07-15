HA$PBExportHeader$w_8_accueil_consultation.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil de consultation 800 x 600
forward
global type w_8_accueil_consultation from w_accueil_consultation
end type
end forward

global type w_8_accueil_consultation from w_accueil_consultation
end type
global w_8_accueil_consultation w_8_accueil_consultation

on w_8_accueil_consultation.create
call w_accueil_consultation::create
end on

on w_8_accueil_consultation.destroy
call w_accueil_consultation::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_accueil_consultation`pb_retour within w_8_accueil_consultation
int X=19
int Y=17
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_quit.bmp"
int TextSize=-7
end type

type pb_interro from w_accueil_consultation`pb_interro within w_8_accueil_consultation
int X=261
int Y=17
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_inter.bmp"
int TextSize=-7
end type

type pb_tri from w_accueil_consultation`pb_tri within w_8_accueil_consultation
int X=503
int Y=17
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_tri.bmp"
int TextSize=-7
end type

type pb_imprimer from w_accueil_consultation`pb_imprimer within w_8_accueil_consultation
int X=746
int Y=17
int Width=234
int Height=137
boolean Enabled=true
string PictureName="k:\pb4obj\bmp\8_imp.bmp"
int TextSize=-7
string FaceName="Arial"
end type

