HA$PBExportHeader$u_spb_gs_courtype.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux courriers type
forward
global type u_spb_gs_courtype from u_spb_gs_anc
end type
end forward

global type u_spb_gs_courtype from u_spb_gs_anc
end type
global u_spb_gs_courtype u_spb_gs_courtype

forward prototypes
public function boolean uf_gs_sup_courtype (string asidcour)
public function boolean uf_gs_id_cour (string asidcour)
end prototypes

public function boolean uf_gs_sup_courtype (string asidcour);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_sup_cour ()
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	17/06/1997 17:24:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'absence de courrier en relation
//*					 	avec le courrier type avant suppression de celui-ci
//* Commentaires	:	
//*
//* Arguments		:	String			asIdCourType	//Identifiant du courrier type
//*															//$$HEX2$$e0002000$$ENDHEX$$supprimer
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en
//*								
//*
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JCA	16/05/2007	DCMP 070051 - Fusion des tables [courrier] et [composition] en [cour_prod]
//*-----------------------------------------------------------------

Boolean	bRet				// Valeur de retour de la fonction.
Long 		lNbCourrier		// Nombre de courrier en relation avec 
								// le courrier type.

bRet			= True
lNbCourrier	= 0

/*------------------------------------------------------------------*/
/* Recherche du nombre de courrrier en relation avec le courrier    */
/* type.                                                            */
/*------------------------------------------------------------------*/
// #1
//itrTrans.IM_S02_COURRIER ( asIdCour, lNbCourrier )
itrTrans.IM_S01_COUR_PROD ( asIdCour, lNbCourrier )

//If ( lNbCourrier > 0 ) Or Not f_procedure ( stMessage, itrTrans, "IM_S02_COURRIER" ) Then
If ( lNbCourrier > 0 ) Or Not f_procedure ( stMessage, itrTrans, "IM_S01_COUR_PROD" ) Then
// #1 - FIN

	bRet = False

End If

Return ( bRet )
end function

public function boolean uf_gs_id_cour (string asidcour);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_id_cour ()
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	17/06/1997 17:06:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'unicit$$HEX2$$e9002000$$ENDHEX$$de l'identifiant des
//*					 	courriers type
//* Commentaires	:	
//*
//* Arguments		:	String	asIdCour		//Identifiant du courrier type
//*
//* Retourne		:	Boolean.
//*
//*-----------------------------------------------------------------

Boolean	bRet			// Variable de retour de la fonction.

String	sLibCour		// Libell$$HEX2$$e9002000$$ENDHEX$$du courrrier type correspondant $$HEX2$$e0002000$$ENDHEX$$l'identifiant 
							// pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$ea00$$ENDHEX$$tre.


sLibCour	= space ( 35 )
bRet 		= True
/*------------------------------------------------------------------*/
/* Recherche s'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un courrier type avec l'identifiant   */
/* pass$$HEX2$$e9002000$$ENDHEX$$en param$$HEX1$$ea00$$ENDHEX$$tre                                               */
/*------------------------------------------------------------------*/
itrtrans.IM_S01_COUR_TYPE ( asIdCour, slibCour )


If Not f_procedure ( stMessage, itrTrans, "IM_S01_COUR_TYPE" ) Then

	bRet = False

Else

	If ( Trim ( sLibCour ) <> "" ) Then

		bRet = False

		stMessage.sTitre  	= "Contr$$HEX1$$f400$$ENDHEX$$le de Gestion des Courriers Type"
		stMessage.sVar[1] 	= asIdCour
		stMessage.sVar[2] 	= "au courrier type"
		stMessage.sVar[3] 	= sLibCour
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "REFU001"

		f_Message ( stMessage )

	End If

End If

Return ( bRet )
end function

on u_spb_gs_courtype.create
call super::create
end on

on u_spb_gs_courtype.destroy
call super::destroy
end on

