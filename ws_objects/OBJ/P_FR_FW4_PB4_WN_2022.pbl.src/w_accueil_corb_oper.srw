HA$PBExportHeader$w_accueil_corb_oper.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour la gestion des Corbeilles/Op$$HEX1$$e900$$ENDHEX$$rateurs (W_TRT_CORB_OPER)
forward
global type w_accueil_corb_oper from w_accueil
end type
end forward

global type w_accueil_corb_oper from w_accueil
int Height=1545
boolean TitleBar=true
string Title="Corbeilles/Op$$HEX1$$e900$$ENDHEX$$rateurs"
end type
global w_accueil_corb_oper w_accueil_corb_oper

type variables

end variables

on ue_initialiser;call w_accueil::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil_Corb_Oper::Ue_Initialiser
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
istPass.bInsert	= False
istPass.bSupprime	= False
istPass.lTab[1]	= UnitsToPixels ( This.Width, XUnitsToPixels! )

f_OuvreTraitement ( W_Trt_Corb_Oper_New, istPass )



end on

on ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil_Corb_Oper::Ue_MajAccueil
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

PostEvent ( This, "Ue_Retour" )
end on

on w_accueil_corb_oper.create
call w_accueil::create
end on

on w_accueil_corb_oper.destroy
call w_accueil::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type pb_interro from w_accueil`pb_interro within w_accueil_corb_oper
boolean Visible=false
boolean Enabled=false
end type

type pb_creer from w_accueil`pb_creer within w_accueil_corb_oper
boolean Visible=false
boolean Enabled=false
end type

on dw_1::ue_majaccueil;call w_accueil`dw_1::ue_majaccueil;
PostEvent ( Parent, "Ue_Retour" )
end on

type pb_tri from w_accueil`pb_tri within w_accueil_corb_oper
int X=293
end type

type pb_imprimer from w_accueil`pb_imprimer within w_accueil_corb_oper
int X=567
boolean Visible=true
boolean Enabled=true
end type

