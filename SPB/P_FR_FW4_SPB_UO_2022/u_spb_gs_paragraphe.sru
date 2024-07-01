HA$PBExportHeader$u_spb_gs_paragraphe.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux paragraphes
forward
global type u_spb_gs_paragraphe from u_spb_gs_anc
end type
end forward

global type u_spb_gs_paragraphe from u_spb_gs_anc
end type
global u_spb_gs_paragraphe u_spb_gs_paragraphe

forward prototypes
public function boolean uf_gs_id_para (string asidpara, string asidcanal)
end prototypes

public function boolean uf_gs_id_para (string asidpara, string asidcanal);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_id_para
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	13/06/1997 17:19:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'unicit$$HEX2$$e9002000$$ENDHEX$$de l'identifiant des
//*					 	paragraphes
//* Commentaires	:	Aucun
//*
//* Arguments		:	String		asIdPara		//Identifiant du paragraphe
//*                  String      asIdCanal   //Identifiant du paragraphe MADM 07/06/2006 : Projet DNTMAIL1
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*									
//*
//*-----------------------------------------------------------------

Boolean	bRet			= True		// Variable de retour de la fonction.

String	sLibPara						// Libell$$HEX2$$e9002000$$ENDHEX$$du paragraphe correspondant $$HEX2$$e0002000$$ENDHEX$$l'identifiant 
											// pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$e800$$ENDHEX$$tre.

sLibPara	= space ( 35 )

/*------------------------------------------------------------------*/
/* Recherche s'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un paragraphe avec l'identifiant      */
/* pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$e800$$ENDHEX$$tre 															  */
/* #1 MADM 07/06/2006 Projet DNTMAIL1 : Ajout du canal				  */
/*------------------------------------------------------------------*/
itrtrans.IM_S01_PARAGRAPHE ( asIdPara, asIdCanal, slibPara )

/*-----------------------------------------------------------------------------*/
/* Traitement si l'identifiant existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$.                                    */
/* #1 MADM 07/06/2006 Projet DNTMAIL1 : Ajout du canal pour le message REFU001 */
/*-----------------------------------------------------------------------------*/
If Trim ( sLibPara ) <> "" Then


	stMessage.sTitre  	= "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des Paragraphes"
	stMessage.sVar[1] 	= asIdPara
	stMessage.sVar[2] 	= asIdCanal
	stMessage.sVar[3] 	= "au paragraphe"
	stMessage.sVar[4] 	= sLibPara
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "REFU041"

	bRet					= False

	f_Message ( stMessage )

End If

Return ( bRet )
end function

on u_spb_gs_paragraphe.create
call super::create
end on

on u_spb_gs_paragraphe.destroy
call super::destroy
end on

