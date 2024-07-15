HA$PBExportHeader$w_a_spb_travaux_solde.srw
forward
global type w_a_spb_travaux_solde from w_a_spb_ancetre_etat_wkf
end type
end forward

global type w_a_spb_travaux_solde from w_a_spb_ancetre_etat_wkf
boolean TitleBar=true
string Title="Travaux restants $$HEX2$$e0002000$$ENDHEX$$traiter"
end type
global w_a_spb_travaux_solde w_a_spb_travaux_solde

forward prototypes
protected function long wf_retrieve (date addatedebut, date addatefin)
end prototypes

protected function long wf_retrieve (date addatedebut, date addatefin);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_retrieve ( Protected ) Override
//* Auteur			: DBI
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
//* Objet 			: w_a_sp_travaux_traites
//* Evenement 		: ue_initialiser
//* Auteur			: DBI
//* Date				: 20/11/1998 09:15:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation Dw pour gestion travaux trait$$HEX1$$e900$$ENDHEX$$s
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_Etat.uf_Initialisation ( stGlb.sFichierIni, stGlb.sCodOper, stGlb.sCodAppli, "S", itrTrans )

end on

on w_a_spb_travaux_solde.create
call w_a_spb_ancetre_etat_wkf::create
end on

on w_a_spb_travaux_solde.destroy
call w_a_spb_ancetre_etat_wkf::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_1 from w_a_spb_ancetre_etat_wkf`st_1 within w_a_spb_travaux_solde
boolean BringToTop=true
string Text="Solde au"
end type

type st_2 from w_a_spb_ancetre_etat_wkf`st_2 within w_a_spb_travaux_solde
boolean Visible=false
boolean BringToTop=true
end type

type dw_2 from w_a_spb_ancetre_etat_wkf`dw_2 within w_a_spb_travaux_solde
boolean BringToTop=true
end type

type pb_excel from w_a_spb_ancetre_etat_wkf`pb_excel within w_a_spb_travaux_solde
boolean BringToTop=true
end type

type uo_dte_deb from w_a_spb_ancetre_etat_wkf`uo_dte_deb within w_a_spb_travaux_solde
boolean Visible=false
end type

