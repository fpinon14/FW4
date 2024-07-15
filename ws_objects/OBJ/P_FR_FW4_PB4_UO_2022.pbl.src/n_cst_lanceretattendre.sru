HA$PBExportHeader$n_cst_lanceretattendre.sru
$PBExportComments$------} NVUO pour lancer une application et attendre la fin de cette application avant de continuer le traitement.
forward
global type n_cst_lanceretattendre from nonvisualobject
end type
end forward

global type n_cst_lanceretattendre from nonvisualobject autoinstantiate
end type

type prototypes
Private :
/*------------------------------------------------------------------*/
/* Je pr$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$re d$$HEX1$$e900$$ENDHEX$$crire ces API en local. En effet, elles ne sont     */
/* utilis$$HEX1$$e900$$ENDHEX$$es que de mani$$HEX1$$e800$$ENDHEX$$re exceptionnelle.                         */
/*------------------------------------------------------------------*/
/* Cette fonction permet de cr$$HEX1$$e900$$ENDHEX$$er un processus. C'est $$HEX2$$e0002000$$ENDHEX$$dire de     */
/* lancer un ex$$HEX1$$e900$$ENDHEX$$cutable avec des param$$HEX1$$e800$$ENDHEX$$tres. Elle renvoie           */
/* imm$$HEX1$$e900$$ENDHEX$$diatement une valeur apr$$HEX1$$e900$$ENDHEX$$s avoir instanci$$HEX2$$e9002000$$ENDHEX$$un PROCESSUS.     */
/*------------------------------------------------------------------*/
/* L'ID du processus est positionn$$HEX2$$e9002000$$ENDHEX$$dans lProcess de                */
/* st_ProcessInformation.                                           */
/*------------------------------------------------------------------*/
FUNCTION Boolean CreateProcessA ( String sNomExe, String sParam, Long l1, Long l2, Boolean binh, Long lCreationFlagse, Long l3, String sDir, St_STARTUPINFO stStartUpInfo, ref st_ProcessInformation stPi ) LIBRARY "kernel32.dll" alias for "CreateProcessA;Ansi"
/*------------------------------------------------------------------*/
/* Cette fonction permet de savoir si le processus instanci$$HEX2$$e9002000$$ENDHEX$$par    */
/* la fonction pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente est encore actif. (En clair,              */
/* l'ex$$HEX1$$e900$$ENDHEX$$cutable est-il encore en train de tourner ?).               */
/*------------------------------------------------------------------*/
FUNCTION Long WaitForSingleObject ( uLong ulNotification, Long lMilliSecondes ) LIBRARY "kernel32.dll"
//FUNCTION Boolean CloseHandle ( ulong ulHandle ) LIBRARY "kernel32.dll"

end prototypes

forward prototypes
public function integer uf_lanceretattendre (string asnomexec, long aldureeattente)
end prototypes

public function integer uf_lanceretattendre (string asnomexec, long aldureeattente);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_LancerEtAttendre::uf_LancerEtAttendre (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 01/12/2001 14:39:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va lancer un ex$$HEX1$$e900$$ENDHEX$$cutable et attendre la fin de l'ex$$HEX1$$e900$$ENDHEX$$cution du processus avant de continuer l'application PB.
//*
//* Arguments		: (Val)		String		asNomExec
//*					  (Val)		Long			alDureeAttente (En MilliSecondes)
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

CONSTANT Long STARTF_USESHOWWINDOW		= 1
CONSTANT Long CREATE_NEW_CONSOLE			= 16
CONSTANT Long NORMAL_PRIORITY_CLASS		= 32

Long		lNul, lCreationFlags
String	sNul, sRepCourant

st_StartUpInfo				stStartUpInfo
st_ProcessInformation	stProcessInformation


SetNull ( lNul )
SetNull ( sNul )
SetNull ( sRepCourant )


stStartUpInfo.lCb					= 72
stStartUpInfo.lFlags				= STARTF_USESHOWWINDOW
stStartUpInfo.lShowWindow 		= 1

lCreationFlags						= CREATE_NEW_CONSOLE + NORMAL_PRIORITY_CLASS
/*------------------------------------------------------------------*/
/* On s'occupe de la cr$$HEX1$$e900$$ENDHEX$$ation du processus. (Lancement de           */
/* l'ex$$HEX1$$e900$$ENDHEX$$cutable et positionnement de lProcess dans la structure     */
/* st_ProcessInformation).                                          */
/*------------------------------------------------------------------*/
CreateProcessA ( sNul, asNomexec, lNul, lNul, FALSE, lCreationFlags, lNul, sRepCourant, stStartUpInfo, stProcessInformation )
/*------------------------------------------------------------------*/
/* On attend un certain nombre de secondes ou ind$$HEX1$$e900$$ENDHEX$$finiment (Valeur  */
/* -1 pour alDureeAttente).                                         */
/*------------------------------------------------------------------*/
Do	While	WaitForSingleObject ( stProcessInformation.ulProcess, alDureeAttente ) <> 0
	Yield ()
Loop	

Return ( 1 )


end function

on n_cst_lanceretattendre.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_lanceretattendre.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

