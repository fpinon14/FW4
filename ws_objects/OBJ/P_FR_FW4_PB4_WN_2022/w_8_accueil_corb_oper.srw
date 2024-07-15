HA$PBExportHeader$w_8_accueil_corb_oper.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour la gestion des Corbeilles/Op$$HEX1$$e900$$ENDHEX$$rateurs (W_TRT_CORB_OPER) 800 x 600
forward
global type w_8_accueil_corb_oper from w_accueil_corb_oper
end type
end forward

global type w_8_accueil_corb_oper from w_accueil_corb_oper
int X=1
int Y=1
int Width=3639
int Height=2001
end type
global w_8_accueil_corb_oper w_8_accueil_corb_oper

on w_8_accueil_corb_oper.create
call w_accueil_corb_oper::create
end on

on w_8_accueil_corb_oper.destroy
call w_accueil_corb_oper::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

