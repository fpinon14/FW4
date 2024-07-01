HA$PBExportHeader$u_spb_gs_code.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux codes
forward
global type u_spb_gs_code from u_spb_gs_anc
end type
end forward

global type u_spb_gs_code from u_spb_gs_anc
end type
global u_spb_gs_code u_spb_gs_code

forward prototypes
public function boolean uf_gs_id_code (string asidtypcode, long adcidcode)
end prototypes

public function boolean uf_gs_id_code (string asidtypcode, long adcidcode);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_id_code
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 13:50:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	V$$HEX1$$e900$$ENDHEX$$rification de l'unicit$$HEX2$$e9002000$$ENDHEX$$de l'identifiant des
//*					 	codes.
//*
//* Arguments		: String		asIdTypCode		//Identifiant du type de Code
//*									adcIdCode			//Identifiant du Code
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*
//*-----------------------------------------------------------------

Boolean bRet					// Variable de retour de la fonction.

String 	sLibCode				// Libell$$HEX2$$e9002000$$ENDHEX$$du Code correspondant aux identifiants 
									// pass$$HEX1$$e900$$ENDHEX$$s en parametre.

bRet 		= True
sLibCode = space ( 35 )

/*------------------------------------------------------------------*/
/* Recherche s'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un code avec l'identifiant pass$$HEX2$$e9002000$$ENDHEX$$en   */
/* parametre                                                        */
/*------------------------------------------------------------------*/
itrtrans.IM_S01_CODE ( asIdTypCode, adcIdCode, slibCode )

/*------------------------------------------------------------------*/
/* Traitement si l'identifiant existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$.                         */
/*------------------------------------------------------------------*/

If Trim ( sLibCode ) <> "" Or Not f_Procedure ( stMessage, itrTrans, "IM_S01_CODE" ) Then

	stMessage.sTitre  	= "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des Codes"
	stMessage.sVar[1] 	= String ( adcIdCode )
	stMessage.sVar[2] 	= "au code"
	stMessage.sVar[3] 	= sLibCode
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "REFU001"

	bRet					= False

	f_Message ( stMessage )

End If

Return ( bRet )
end function

on u_spb_gs_code.create
TriggerEvent( this, "constructor" )
end on

on u_spb_gs_code.destroy
TriggerEvent( this, "destructor" )
end on

