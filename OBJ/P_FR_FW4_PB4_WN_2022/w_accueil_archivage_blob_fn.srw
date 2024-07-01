HA$PBExportHeader$w_accueil_archivage_blob_fn.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour la gestion de l'archivage des courriers sous FileNet.
forward
global type w_accueil_archivage_blob_fn from w_accueil
end type
end forward

global type w_accueil_archivage_blob_fn from w_accueil
int Height=1545
boolean TitleBar=true
string Title="Gestion de l'archivage des courriers sur le syst$$HEX1$$e800$$ENDHEX$$me FileNet"
end type
global w_accueil_archivage_blob_fn w_accueil_archivage_blob_fn

type variables

end variables

on ue_initialiser;call w_accueil::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil_Archivage_Blob_Fn::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 09/09/1997 15:41:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.itrTrans		= SQLCA
istPass.trTrans	= This.itrTrans
istPass.bControl	= False
istPass.bInsert	= True
istPass.bSupprime	= False

F_OuvreTraitement ( W_Tm_Archivage_Blob_Fn, istPass )



end on

on ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil_Archivage_Blob_Fn::Ue_MajAccueil
//* Evenement 		: Ue_MajAccueil 								(OVERRIDE)
//* Auteur			: Erick John Stark
//* Date				: 29/09/1997 15:35:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Retour de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* La fen$$HEX1$$ea00$$ENDHEX$$tre de traitement d$$HEX1$$e900$$ENDHEX$$clenche cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement. Comme on ne    */
/* veut rien mettre $$HEX2$$e0002000$$ENDHEX$$jour dans la DW d'accueil, on referme         */
/* automatiquement la fen$$HEX1$$ea00$$ENDHEX$$tre. Cela a pour effet de refermer cette  */
/* fen$$HEX1$$ea00$$ENDHEX$$tre et la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement.                             */
/*------------------------------------------------------------------*/
If	IsValid ( W_Tm_Archivage_Blob_Fn )	Then Close ( W_Tm_Archivage_Blob_Fn )

PostEvent ( This, "Ue_Retour" )






end on

on w_accueil_archivage_blob_fn.create
call w_accueil::create
end on

on w_accueil_archivage_blob_fn.destroy
call w_accueil::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_retour from w_accueil`pb_retour within w_accueil_archivage_blob_fn
int TabOrder=0
end type

type pb_interro from w_accueil`pb_interro within w_accueil_archivage_blob_fn
int X=842
int TabOrder=0
boolean Visible=false
boolean Enabled=false
end type

type pb_creer from w_accueil`pb_creer within w_accueil_archivage_blob_fn
int X=1116
int TabOrder=0
boolean Visible=false
boolean Enabled=false
end type

type dw_1 from w_accueil`dw_1 within w_accueil_archivage_blob_fn
int TabOrder=0
end type

type pb_tri from w_accueil`pb_tri within w_accueil_archivage_blob_fn
int X=293
int TabOrder=0
boolean Visible=false
boolean Enabled=false
end type

type pb_imprimer from w_accueil`pb_imprimer within w_accueil_archivage_blob_fn
int X=567
int TabOrder=0
end type

