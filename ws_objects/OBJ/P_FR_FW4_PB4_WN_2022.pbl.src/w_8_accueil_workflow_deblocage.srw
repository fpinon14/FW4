HA$PBExportHeader$w_8_accueil_workflow_deblocage.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil 800*600 pour le d$$HEX1$$e900$$ENDHEX$$blocage des dossiers
forward
global type w_8_accueil_workflow_deblocage from w_accueil_workflow_deblocage
end type
end forward

global type w_8_accueil_workflow_deblocage from w_accueil_workflow_deblocage
end type
global w_8_accueil_workflow_deblocage w_8_accueil_workflow_deblocage

on w_8_accueil_workflow_deblocage.create
call super::create
end on

on w_8_accueil_workflow_deblocage.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_accueil_workflow_deblocage`cb_debug within w_8_accueil_workflow_deblocage
end type

type pb_retour from w_accueil_workflow_deblocage`pb_retour within w_8_accueil_workflow_deblocage
integer width = 242
integer height = 144
integer textsize = -7
string facename = "Arial"
string picturename = "k:\pb4obj\bmp\8_quit.bmp"
end type

type pb_interro from w_accueil_workflow_deblocage`pb_interro within w_8_accueil_workflow_deblocage
integer x = 261
integer width = 242
integer height = 144
integer textsize = -7
string facename = "Arial"
string picturename = "k:\pb4obj\bmp\8_inter.bmp"
end type

type pb_creer from w_accueil_workflow_deblocage`pb_creer within w_8_accueil_workflow_deblocage
boolean visible = false
integer x = 261
integer width = 242
integer height = 144
string picturename = "k:\pb4obj\bmp\8_creer.bmp"
end type

type dw_1 from w_accueil_workflow_deblocage`dw_1 within w_8_accueil_workflow_deblocage
end type

event dw_1::constructor;call super::constructor;ilMaxLig=-1 // FPI - 07/02/2014 - [20140207.FPI] - Suppression de la limite du nb de lignes
end event

type pb_tri from w_accueil_workflow_deblocage`pb_tri within w_8_accueil_workflow_deblocage
integer width = 233
integer height = 136
string picturename = "k:\pb4obj\bmp\8_tri.bmp"
end type

type pb_imprimer from w_accueil_workflow_deblocage`pb_imprimer within w_8_accueil_workflow_deblocage
integer x = 745
integer width = 242
integer height = 144
integer textsize = -7
string facename = "Arial"
string picturename = "k:\pb4obj\bmp\8_imp.bmp"
end type

type dw_libre from w_accueil_workflow_deblocage`dw_libre within w_8_accueil_workflow_deblocage
end type

type mle_msg1 from w_accueil_workflow_deblocage`mle_msg1 within w_8_accueil_workflow_deblocage
integer x = 997
integer width = 2391
end type

type pb_debloc from w_accueil_workflow_deblocage`pb_debloc within w_8_accueil_workflow_deblocage
integer x = 503
integer width = 242
integer height = 144
integer textsize = -7
string facename = "Arial"
string picturename = "k:\pb4obj\bmp\8_debloc.bmp"
end type

type dw_corbeille from w_accueil_workflow_deblocage`dw_corbeille within w_8_accueil_workflow_deblocage
end type

type dw_workflow from w_accueil_workflow_deblocage`dw_workflow within w_8_accueil_workflow_deblocage
end type

