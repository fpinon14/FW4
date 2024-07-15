HA$PBExportHeader$w_trt_capture_click.srw
forward
global type w_trt_capture_click from window
end type
end forward

global type w_trt_capture_click from window
integer x = 4800
integer y = 16
integer width = 192
integer height = 232
boolean titlebar = true
string title = "Traitement des Click"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
end type
global w_trt_capture_click w_trt_capture_click

type variables
Private :
String isTypeTrt
end variables

on open;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Capture_Click
//* Evenement		: Open
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Armement de la variable d'instance isTypeTrt pour choisr le      */
/* type de traitement. Voir $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement Show.                         */
/*------------------------------------------------------------------*/
isTypeTrt = Message.StringParm


This.X = 50000
end on

event show;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Capture_Click
//* Evenement		: Show
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sWord
N_Cst_Word	nvWord

/*------------------------------------------------------------------*/
/* Cette fen$$HEX1$$ea00$$ENDHEX$$tre sert au lancement d'un WORD si le WORD n'est pas   */
/* charg$$HEX1$$e900$$ENDHEX$$. (Param$$HEX1$$e800$$ENDHEX$$tre isTypeTrt = "1"). Le lancement de             */
/* l'application dans le processus de Saisie/Validation pos$$HEX2$$e9002000$$ENDHEX$$des    */
/* probl$$HEX1$$e800$$ENDHEX$$mes. Il vaut mieux utiliser une fen$$HEX1$$ea00$$ENDHEX$$tre pour effectuer ce  */
/* Traitement. De plus, cette fen$$HEX1$$ea00$$ENDHEX$$tre sert $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$tourner les clicks   */
/* de souris (Param$$HEX1$$e800$$ENDHEX$$tre isTypeTrt = "").                            */
/*------------------------------------------------------------------*/
Choose Case isTypeTrt
Case "1"
	F_SetVersionWord ( nvWord, TRUE )		
// [Office2010] [FMU] : Debut : 
//	sWord = ProfileString ( stGLB.sFichierIni, "EDITION", "REP_WORD", "" )
	sWord = f_GetWordExe()
// [Office2010] [FMU] : Fin
	If	nvWord.uf_WordOuvert () = 0	Then Run ( sWord, Minimized! )

	F_SetVersionWord ( nvWord, FALSE )

	CloseWithReturn ( This, "" )
Case ""
/*------------------------------------------------------------------*/
/* L'ouverture de cette fen$$HEX1$$ea00$$ENDHEX$$tre permet de supprimer le 'bug' de     */
/* perte de focus du bouton VALIDER.                                */
/*------------------------------------------------------------------*/
// [MIGPB11] [LBP] : Debut Migration : Suite prob$$HEX1$$e800$$ENDHEX$$me ouverture de Word et bouton valider qui 
// dipara$$HEX1$$ee00$$ENDHEX$$t dans SAVANE. L'ouverture d'un courrier particulier est plus longue que celle d'un courrer
// auto. La tempo ne couvre pas l'int$$HEX1$$e900$$ENDHEX$$gralit$$HEX2$$e9002000$$ENDHEX$$du temps d'ouverture de Word. On augment la tempo
//Timer (0.055, This )
Timer (0.200, This )
// [MIGPB11] [LBP] : Fin Migration
	
End Choose
end event

on timer;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Capture_Click
//* Evenement		: Timer
//* Auteur			: Erick John Stark
//* Date				: 15/10/2000 16:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On arr$$HEX1$$ea00$$ENDHEX$$te le timer, et on ferme la fen$$HEX1$$ea00$$ENDHEX$$tre qui doit normalement  */
/* recevoir tous les CLICKS.                                        */
/*------------------------------------------------------------------*/
Timer ( 0, This )
CloseWithReturn ( This, "" )

end on

on w_trt_capture_click.create
end on

on w_trt_capture_click.destroy
end on

