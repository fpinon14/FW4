HA$PBExportHeader$u_spb_gs_compagnie.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux compagnies
forward
global type u_spb_gs_compagnie from u_spb_gs_anc
end type
end forward

global type u_spb_gs_compagnie from u_spb_gs_anc
end type
global u_spb_gs_compagnie u_spb_gs_compagnie

forward prototypes
public function boolean uf_gs_sup_cie (long adcidcie)
public function boolean uf_gs_id_cie (long adcidcie)
public function integer uf_controler_aig (long alidcie, string aslibcie)
end prototypes

public function boolean uf_gs_sup_cie (long adcidcie);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_sup_cie
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	10/06/97 09:50:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	V$$HEX1$$e900$$ENDHEX$$rification de l'absence de police en relation
//*					   avec la compagnie avant suppression de celle-ci.
//*
//* Arguments		:	Long			adcIdCie		// Identifiant de la Compagnie 
//*														// $$HEX2$$e0002000$$ENDHEX$$supprimer.
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*								
//*
//*-----------------------------------------------------------------

Boolean	bRet			// Valeur de retour de la fonction.
Long 		lNbPolice	// Nombre de polices en relation avec la compagnie.

bRet		 = True
lNbPolice = 0

/*------------------------------------------------------------------*/
/* Recherche du nombre de polices en relation avec la compagnie     */
/*------------------------------------------------------------------*/
itrTrans.IM_S01_POLICE ( adcIdCie, lNbPolice )

If ( lNbPolice > 0 ) Or Not f_procedure ( stMessage, itrTrans, "IM_S01_POLICE" ) Then

	bRet = False

End If

Return ( bRet )
end function

public function boolean uf_gs_id_cie (long adcidcie);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_id_cie ()
//* Auteur			:	YP
//* Date				:	01/10/97 10:33:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	Contr$$HEX1$$f400$$ENDHEX$$le si ce code compagnie n'existe pas d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$.
//*
//* Arguments		:	Decimal		adcIdCie		( Val ) : Identifiant de la compagnie.
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en.
//*
//*-----------------------------------------------------------------
//* #1 JCA 118/05/2006 DCMP 60291 passage d'id_cie de 2 $$HEX2$$e0002000$$ENDHEX$$3 caract$$HEX1$$e800$$ENDHEX$$res
//*-----------------------------------------------------------------

Boolean	bRet			// Variable de retour de la fonction.

String	sLibCie		// Libell$$HEX2$$e9002000$$ENDHEX$$de la compagnie correspondant $$HEX2$$e0002000$$ENDHEX$$l'identifiant
							// pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$ea00$$ENDHEX$$tre.

bRet		= True
sLibCie	= space ( 35 )

/*------------------------------------------------------------------*/
/* Recherche s'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$une compagnie avec l'identifiant      */
/* pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$ea00$$ENDHEX$$tre                                               */
/*------------------------------------------------------------------*/
itrtrans.IM_S01_COMPAGNIE ( adcIdCie, sLibCie )

If Not f_procedure ( stMessage, itrTrans, "IM_S01_COMPAGNIE" ) Then

	bRet = False

Else

	/*------------------------------------------------------------------*/
	/* Traitement si l'identifiant existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$.                         */
	/*------------------------------------------------------------------*/
	If Trim ( sLibCie ) <> "" Then

		stMessage.sTitre  	= "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des Compagnies"
// #1
//		stMessage.sVar[1] 	= String ( adcIdCie, "00" )
		stMessage.sVar[1] 	= String ( adcIdCie, "000" )
// #1 FIN		
		stMessage.sVar[2] 	= "$$HEX2$$e0002000$$ENDHEX$$la compagnie"
		stMessage.sVar[3] 	= sLibCie
		stMessage.bErreurG	=	TRUE
		stMessage.sCode		= "REFU001"

		bRet					= False

		f_Message ( stMessage )

	End If

End If

Return ( bRet )
end function

public function integer uf_controler_aig (long alidcie, string aslibcie);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_controler_aig ()
//* Auteur			:	PHG
//* Date				:	30/05/2008
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	[DCMP070914] Message d'information si Libelle 
//*						contient 'AIG'	et que l'Id_compagnie n'est pas 
//*						dans la liste des compagnies associ$$HEX1$$e900$$ENDHEX$$e s
//*						au protocole AIG.
//*
//* Arguments		:	long		adcIdCie		( Val ) : Identifiant de la compagnie.
//*						string	asLibCie		( Val ) : Libelle de la Compagnie
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en.
//*
//*-----------------------------------------------------------------

n_cst_protocole_aig_param_gti luo_ProtocoleAig
datastore ldsPrefixe

if Pos(UPPER(asLibCie), 'AIG') > 0 Then
	luo_ProtocoleAig = create n_cst_protocole_aig_param_gti
	luo_ProtocoleAig.uf_init_prefixe( ldsPrefixe, SQLCA)
	if Not luo_ProtocoleAig.uf_CieEstAig( ldsPrefixe, alIdCie ) Then
		stMessage.sTitre  	= "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des Compagnies"
		stMessage.sVar[1] 	= String ( alIdCie, "000" )
		stMessage.bErreurG	=	TRUE
		stMessage.sCode		= luo_ProtocoleAig.K_MSG_PARAM_CIE
		f_Message ( stMessage )
	End If
End If

Return 1
end function

on u_spb_gs_compagnie.create
call super::create
end on

on u_spb_gs_compagnie.destroy
call super::destroy
end on

