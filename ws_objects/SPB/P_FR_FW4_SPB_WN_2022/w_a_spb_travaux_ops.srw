HA$PBExportHeader$w_a_spb_travaux_ops.srw
$PBExportComments$---} Stat pr$$HEX1$$e900$$ENDHEX$$sentant pour chaque gestinnaire, qui a valid$$HEX2$$e9002000$$ENDHEX$$ses dossiers.
forward
global type w_a_spb_travaux_ops from w_a_spb_ancetre_etat_wkf
end type
end forward

global type w_a_spb_travaux_ops from w_a_spb_ancetre_etat_wkf
boolean TitleBar=true
string Title="Saisi Par-Valid$$HEX2$$e9002000$$ENDHEX$$Par"
end type
global w_a_spb_travaux_ops w_a_spb_travaux_ops

forward prototypes
protected function long wf_retrieve (date addatedebut, date addatefin)
end prototypes

protected function long wf_retrieve (date addatedebut, date addatefin);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_retrieve ( Protected ) Override
//* Auteur			: JFF
//* Date				: 20/11/1998 09:22:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement de la datawindow
//* Commentaires	: 
//*
//* Arguments		: adDateDebut date	- date de d$$HEX1$$e900$$ENDHEX$$but de traitement
//*					  adDateFin   date	- date de fin de traitement
//* Retourne		: Long			Nb lignes charg$$HEX1$$e900$$ENDHEX$$es 
//*										
//*
//*-----------------------------------------------------------------

Long		lRet

lRet		=	Dw_Etat.uf_Retrieve ( 1, adDateDebut, adDateFin )

Return ( lRet )
end function

on ue_initialiser;call w_a_spb_ancetre_etat_wkf::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_travaux_ops
//* Evenement 		: ue_initialiser
//* Auteur			: JFF
//* Date				: 13/11/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation Dw 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_Etat.uf_Initialisation ( stGlb.sFichierIni, stGlb.sCodOper, stGlb.sCodAppli, "OPS", itrTrans )

end on

on w_a_spb_travaux_ops.create
call w_a_spb_ancetre_etat_wkf::create
end on

on w_a_spb_travaux_ops.destroy
call w_a_spb_ancetre_etat_wkf::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_1 from w_a_spb_ancetre_etat_wkf`st_1 within w_a_spb_travaux_ops
boolean BringToTop=true
end type

type st_2 from w_a_spb_ancetre_etat_wkf`st_2 within w_a_spb_travaux_ops
boolean BringToTop=true
end type

type dw_2 from w_a_spb_ancetre_etat_wkf`dw_2 within w_a_spb_travaux_ops
boolean BringToTop=true
end type

type pb_excel from w_a_spb_ancetre_etat_wkf`pb_excel within w_a_spb_travaux_ops
boolean BringToTop=true
end type

