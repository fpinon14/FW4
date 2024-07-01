HA$PBExportHeader$w_8_accueil_edition.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'$$HEX1$$e900$$ENDHEX$$dition 800 x 600
forward
global type w_8_accueil_edition from w_accueil_edition
end type
end forward

global type w_8_accueil_edition from w_accueil_edition
end type
global w_8_accueil_edition w_8_accueil_edition

on w_8_accueil_edition.create
call w_accueil_edition::create
end on

on w_8_accueil_edition.destroy
call w_accueil_edition::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_accueil_edition`pb_retour within w_8_accueil_edition
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_quit.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_interro from w_accueil_edition`pb_interro within w_8_accueil_edition
int X=261
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_inter.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_tri from w_accueil_edition`pb_tri within w_8_accueil_edition
int X=503
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_tri.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_word from w_accueil_edition`pb_word within w_8_accueil_edition
int X=746
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_word.bmp"
string DisabledName="k:\pb4obj\bmp\8_word.bmp"
int TextSize=-7
end type

type cb_tous from w_accueil_edition`cb_tous within w_8_accueil_edition
boolean BringToTop=true
end type

type cb_aucun from w_accueil_edition`cb_aucun within w_8_accueil_edition
boolean BringToTop=true
end type

type st_1 from w_accueil_edition`st_1 within w_8_accueil_edition
boolean BringToTop=true
end type

type cbx_banner from w_accueil_edition`cbx_banner within w_8_accueil_edition
int X=1043
boolean BringToTop=true
end type

type cbx_pageblanche from w_accueil_edition`cbx_pageblanche within w_8_accueil_edition
int X=1043
boolean BringToTop=true
end type

