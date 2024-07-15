HA$PBExportHeader$u_spb_gs_police.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux polices
forward
global type u_spb_gs_police from u_spb_gs_anc
end type
end forward

global type u_spb_gs_police from u_spb_gs_anc
end type
global u_spb_gs_police u_spb_gs_police

forward prototypes
public function boolean uf_gs_sup_police (long adcidpolice)
end prototypes

public function boolean uf_gs_sup_police (long adcidpolice);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_sup_police
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	10/06/97 14:22:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'absence de garantie en relation
//*						avec la police avant suppression de celle-ci.
//* Commentaires	: 
//*
//* Arguments		:	Decimal	adcIdPolice ( Val ) : Identifiant de la police
//*															    $$HEX2$$e0002000$$ENDHEX$$supprimer.
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*								
//*-----------------------------------------------------------------

Boolean bRet				// Valeur de retour de la fonction. 
Long	  lNbGarantie		// Nombre de garanties en relation avec la police.

lNbGarantie = 0
bRet			= True

/*------------------------------------------------------------------*/
/* Recherche du nombre de garantie en relation avec la police       */
/*------------------------------------------------------------------*/
itrTrans.IM_S02_GARANTIE ( adcIdPolice, lNbGarantie )

If ( lNbGarantie > 0 ) Or &
	Not f_Procedure ( stMessage , iTrTrans , "IM_S02_GARANTIE" )  Then bRet = False

Return ( bRet )

end function

on u_spb_gs_police.create
TriggerEvent( this, "constructor" )
end on

on u_spb_gs_police.destroy
TriggerEvent( this, "destructor" )
end on

