HA$PBExportHeader$u_spb_gs_departement.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux d$$HEX1$$e900$$ENDHEX$$partements
forward
global type u_spb_gs_departement from u_spb_gs_anc
end type
end forward

global type u_spb_gs_departement from u_spb_gs_anc
end type
global u_spb_gs_departement u_spb_gs_departement

forward prototypes
public function boolean uf_gs_sup_dept (long adciddept)
public function boolean uf_gs_id_dept (long adciddept)
end prototypes

public function boolean uf_gs_sup_dept (long adciddept);//*-----------------------------------------------------------------
//*
//* Fonction		:	Uf_Gs_Sup_Dept ()
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 11:24:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'absence de produit en relation
//*					 	avec le d$$HEX1$$e900$$ENDHEX$$partement avant suppression de celui-ci.
//* Commentaires	: 
//*
//* Arguments		:	Decimal	asIdDept ( Val ) : Identifiant du d$$HEX1$$e900$$ENDHEX$$partement 
//*															 $$HEX2$$e0002000$$ENDHEX$$supprimer.
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*								
//*-----------------------------------------------------------------

Boolean	bRet			// Valeur de retour de la fonction.

Long 		lNbProd		// Nombre de produit en relation avec 
							// le d$$HEX1$$e900$$ENDHEX$$partement.


bRet		= True

lNbProd	= 0

/*------------------------------------------------------------------*/
/* Recherche du nombre de produits en relation avec le d$$HEX1$$e900$$ENDHEX$$partements */
/*------------------------------------------------------------------*/
itrTrans.IM_S02_PRODUIT ( adcIdDept, lNbProd )

If ( lNbProd > 0 ) Or Not f_procedure ( stMessage, itrTrans, "IM_S02_PRODUIT" ) Then

	bRet = False

End If

Return ( bRet )
end function

public function boolean uf_gs_id_dept (long adciddept);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_id_dept ()
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	30/05/97 11:02:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	Contr$$HEX1$$f400$$ENDHEX$$le si ce code d$$HEX1$$e900$$ENDHEX$$partement n'existe pas d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$.
//*
//* Arguments		:	Decimal		adIdDept		( Val ) : Identifiant du d$$HEX1$$e900$$ENDHEX$$partement.
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en.
//*
//*-----------------------------------------------------------------

Boolean	bRet			// Variable de retour de la fonction.

String	sLibDept		// Libell$$HEX2$$e9002000$$ENDHEX$$du d$$HEX1$$e900$$ENDHEX$$partement correspondant $$HEX2$$e0002000$$ENDHEX$$l'identifiant 
							// pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$ea00$$ENDHEX$$tre.

bRet		= True
sLibDept	= space ( 35 )

/*------------------------------------------------------------------*/
/* Recherche s'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un d$$HEX1$$e900$$ENDHEX$$partement avec l'identifiant     */
/* pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$ea00$$ENDHEX$$tre                                               */
/*------------------------------------------------------------------*/
itrtrans.IM_S01_DEPARTEMENT ( adcIdDept, slibDept )

If Not f_procedure ( stMessage, itrTrans, "IM_S01_DEPARTEMENT" ) Then

	bRet = False

Else

	/*------------------------------------------------------------------*/
	/* Traitement si l'identifiant existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$.                         */
	/*------------------------------------------------------------------*/
	If Trim ( sLibDept ) <> "" Then

		stMessage.sTitre  	= "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des D$$HEX1$$e900$$ENDHEX$$partements"
		stMessage.sVar[1] 	= String ( adcIdDept, "0" )
		stMessage.sVar[2] 	= "au d$$HEX1$$e900$$ENDHEX$$partement"
		stMessage.sVar[3] 	= sLibDept
		stMessage.bErreurG	=	TRUE
		stMessage.sCode		= "REFU001"

		bRet					= False

		f_Message ( stMessage )

	End If

End If

Return ( bRet )
end function

on u_spb_gs_departement.create
TriggerEvent( this, "constructor" )
end on

on u_spb_gs_departement.destroy
TriggerEvent( this, "destructor" )
end on

