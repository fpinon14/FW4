HA$PBExportHeader$w_logoapp_soldetrv.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre de logo (descendant de w_logoapp) avec la gestion du solde des travaux
forward
global type w_logoapp_soldetrv from w_logoapp
end type
type dw_1 from u_spb_suivi_travaux within w_logoapp_soldetrv
end type
end forward

global type w_logoapp_soldetrv from w_logoapp
dw_1 dw_1
end type
global w_logoapp_soldetrv w_logoapp_soldetrv

forward prototypes
public subroutine wf_soldedestravaux ()
end prototypes

public subroutine wf_soldedestravaux ();//*-----------------------------------------------------------------
//*
//* Objet 			: w_LogoApp_Simpa2
//* Evenement 		: wf_soldedestravaux
//* Auteur			: DBI
//* Date				: 08/12/1998 17:54:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$termination du solde des travaux
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lRet

Dw_1.uf_Initialisation ( stGlb.sFichierIni, stGlb.sCodOper, stGlb.sCodAppli, "S", SQLCA )

lRet = Dw_1.uf_Trace ( )

Choose Case lRet

	Case 0, -1, -3, -4, -5
	stMessage.sCode 		= "EWK0001"
	stMessage.sVar [ 1 ] = String ( lRet )
	stMessage.sTitre		= "Solde des travaux"
	stMessage.bTrace 		= True
	stMessage.bErreurG	= True
	f_Message ( stMessage )			
End Choose
end subroutine

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_logoapp_soldetrv
//* Evenement 		: Open
//* Auteur			: Fabry JF
//* Date				: 15/03/1999 13:15:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre
//* Commentaires	: A l'ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre Logo, on lance le solde des travaux.
//*					  (uniquement pour le premier utilisateur de la journ$$HEX1$$e900$$ENDHEX$$e qui se connecte $$HEX2$$e0002000$$ENDHEX$$SIMPA2)
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

// [DCMP060260]-PHG-02/05/2006
// DEconnexion de la generation des solde de travaux par l'appli
// concerne aussis bien CINDI que SIMPA2
// Mise en commentaire de ci-dessous
// wf_SoldeDesTravaux ()
end event

on w_logoapp_soldetrv.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_logoapp_soldetrv.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_logo from w_logoapp`dw_logo within w_logoapp_soldetrv
integer taborder = 10
end type

type dw_1 from u_spb_suivi_travaux within w_logoapp_soldetrv
integer x = 2514
integer y = 596
integer taborder = 20
end type

