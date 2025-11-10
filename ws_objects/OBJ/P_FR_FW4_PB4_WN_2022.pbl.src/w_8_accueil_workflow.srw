HA$PBExportHeader$w_8_accueil_workflow.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le workflow 800 x 600
forward
global type w_8_accueil_workflow from w_accueil_workflow
end type
end forward

global type w_8_accueil_workflow from w_accueil_workflow
int X=1
int Y=1
int Width=3639
int Height=2001
end type
global w_8_accueil_workflow w_8_accueil_workflow

on w_8_accueil_workflow.create
call w_accueil_workflow::create
end on

on w_8_accueil_workflow.destroy
call w_accueil_workflow::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_accueil_workflow`pb_retour within w_8_accueil_workflow
int Y=17
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_quit.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_interro from w_accueil_workflow`pb_interro within w_8_accueil_workflow
int X=261
int Y=17
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_inter.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_creer from w_accueil_workflow`pb_creer within w_8_accueil_workflow
int X=261
int Y=17
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_creer.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_tri from w_accueil_workflow`pb_tri within w_8_accueil_workflow
int X=503
int Y=17
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_tri.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type pb_imprimer from w_accueil_workflow`pb_imprimer within w_8_accueil_workflow
int X=746
int Y=17
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_imp.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type dw_libre from w_accueil_workflow`dw_libre within w_8_accueil_workflow
boolean BringToTop=true
end type

type mle_msg1 from w_accueil_workflow`mle_msg1 within w_8_accueil_workflow
int X=997
int Width=2391
boolean BringToTop=true
end type

type pb_debloc from w_accueil_workflow`pb_debloc within w_8_accueil_workflow
int X=686
int Y=17
int Width=234
int Height=137
string PictureName="k:\pb4obj\bmp\8_debloc.bmp"
int TextSize=-7
string FaceName="Arial"
end type

type dw_corbeille from w_accueil_workflow`dw_corbeille within w_8_accueil_workflow
boolean BringToTop=true
end type

type dw_workflow from w_accueil_workflow`dw_workflow within w_8_accueil_workflow
boolean BringToTop=true
end type

