HA$PBExportHeader$w_8_accueil_archivage_blob_fn.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour la gestion de l'archivage des courriers sous FileNet. 800 x 600.
forward
global type w_8_accueil_archivage_blob_fn from w_accueil_archivage_blob_fn
end type
end forward

global type w_8_accueil_archivage_blob_fn from w_accueil_archivage_blob_fn
int X=1
int Y=1
int Width=3639
int Height=2001
end type
global w_8_accueil_archivage_blob_fn w_8_accueil_archivage_blob_fn

on w_8_accueil_archivage_blob_fn.create
call w_accueil_archivage_blob_fn::create
end on

on w_8_accueil_archivage_blob_fn.destroy
call w_accueil_archivage_blob_fn::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_accueil_archivage_blob_fn`pb_retour within w_8_accueil_archivage_blob_fn
int TabOrder=10
end type

type dw_1 from w_accueil_archivage_blob_fn`dw_1 within w_8_accueil_archivage_blob_fn
int TabOrder=30
end type

type pb_imprimer from w_accueil_archivage_blob_fn`pb_imprimer within w_8_accueil_archivage_blob_fn
int TabOrder=20
end type

