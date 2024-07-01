HA$PBExportHeader$u_spb_suivi_travaux.sru
$PBExportComments$---} User Object pour divers traitements sur les travaux ( DCMP 990391 )
forward
global type u_spb_suivi_travaux from datawindow
end type
end forward

global type u_spb_suivi_travaux from datawindow
integer width = 494
integer height = 360
integer taborder = 1
boolean livescroll = true
end type
global u_spb_suivi_travaux u_spb_suivi_travaux

type variables
Private :

	String	isFichierIni	// Fichier Ini contenant le r$$HEX1$$e900$$ENDHEX$$pertoire de trace
	String	isCodOper	// Op$$HEX1$$e900$$ENDHEX$$rateur en cours
	String	isCodAppli	// Code de l'application
	String	isRepTrace	// R$$HEX1$$e900$$ENDHEX$$pertoire de stockage des fichiers de trace
	String	isFiltreInitial	// R$$HEX1$$e900$$ENDHEX$$pertoire de stockage des fichiers de trace

	u_transaction itrTrans

	Boolean	ibDddwChargee	// Indique si les Dddw sont charg$$HEX1$$e900$$ENDHEX$$es
end variables

forward prototypes
public function integer uf_trace ()
private function long uf_import (date addatedebut, date addatefin)
public function long uf_retrieve (integer aitrt, date addatedebut, date addatefin)
public subroutine uf_filtrer (string asdept)
public subroutine uf_initialisation (string asfichierini, string ascodoper, string ascodappli, string astrt, u_transaction atrtrans)
end prototypes

public function integer uf_trace ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Trace
//* Auteur			: DBI
//* Date				: 17/11/1998 09:50:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cr$$HEX1$$e900$$ENDHEX$$e le fichier de trace et d$$HEX1$$e900$$ENDHEX$$clenche son chargement s'il n'existe pas
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Long			 Nombre de lignes charg$$HEX1$$e900$$ENDHEX$$es ou
//*										-1 = Erreur sur retrieve
//*										-2 = Le fichier existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$
//*										-4 = Erreur de sauvegarde du fichier texte ( dans ce cas le fichier est supprim$$HEX2$$e9002000$$ENDHEX$$)
//*										-5 = Impossible de cr$$HEX1$$e900$$ENDHEX$$er le fichier de trace 
//*
//*-----------------------------------------------------------------

Long		lRet				// Retour de la fonction
Long		lCpt				// Compteur de boucle

String	sFicTrace		// Nom du fichier de trace
String	sNumMach			// Num$$HEX1$$e900$$ENDHEX$$ro de la machine courante

Integer	iFic				// Fichier de trace
Date		dNull				// Date null pour argument obligatoire uf_retrieve

SetNull ( dNull)

//u_DeclarationFuncky	uoDeclarationFuncky	// Uo Funcky pour nom machine
//
//uoDeclarationFuncky	= Create u_DeclarationFuncky
//
//sNumMach 	= uoDeclarationFuncky.Uf_GetEnv ( "SQL" )
//Destroy		uoDeclarationFuncky
//
/*----------------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du nom de la machine puis destruction du user object.         */
/*----------------------------------------------------------------------------*/
sNumMach 	= stGlb.uoWin.uf_getenvironment( "SQL" )

/*------------------------------------------------------------------*/
/* On initialise maintenant le nom du fichier de TRACE au format    */
/* JJMMAAAA.App (App correspond au code de l'application).          */
/* Pour connaitre le r$$HEX1$$e900$$ENDHEX$$pertoire qui contient le fichier de TRACE,   */
/* il faut lire la section TRACE du fichier INI de l'application.   */
/* La valeur REP_TRACE_S correspond au nom du r$$HEX1$$e900$$ENDHEX$$pertoire de trace   */
/* pour le solde des travaux                                        */
/*------------------------------------------------------------------*/

	sFicTrace 	= isRepTrace + String (Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )


//Migration PB8-WYNIWYG-03/2006 CP	
//	If Not FileExists ( sFicTrace ) Then
	If Not f_FileExists ( sFicTrace ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP


		/*----------------------------------------------------------------------------*/
		/* On cr$$HEX1$$e900$$ENDHEX$$e aussitot le fichier pour que personne d'autre ne puisse le cr$$HEX1$$e900$$ENDHEX$$er   */
		/*----------------------------------------------------------------------------*/

		iFic			= FileOpen ( sFicTrace, LineMode!, Write!, Shared!, Replace! )

		If iFic > 0 Then

			FileClose 	( iFic )	

			/*------------------------------------------------------------------*/
			/* lRet contiendra le nombre de lignes charg$$HEX1$$e900$$ENDHEX$$es.						  */
			/* Ce nombre doit $$HEX1$$ea00$$ENDHEX$$tre > 0 pour pouvoir continuer                   */
			/*------------------------------------------------------------------*/

			lRet = uf_Retrieve ( 0, dNull, dNull )

			If lRet > 0 Then

				/*------------------------------------------------------------------*/
				/* lRet contiendra le nombre de lignes charg$$HEX1$$e900$$ENDHEX$$es.						  */
				/* Ce nombre doit $$HEX1$$ea00$$ENDHEX$$tre > 0 pour pouvoir continuer                   */
				/*------------------------------------------------------------------*/

				For lCpt = 1 To lRet

					This.SetItem ( lCpt, "COD_APPLI", isCodAppli 	)			
					This.SetItem ( lCpt, "NUM_MACH",  sNumMach 			)			
					This.SetItem ( lCpt, "COD_OPER",   isCodOper 	)			
				Next

				If This.SaveAs ( sFicTrace, Text!, False ) < 0 Then
				/*------------------------------------------------------------------*/
				/* Si erreur de sauvegarde je supprime le fichier vide pour qu'un   */
				/* autre op$$HEX1$$e900$$ENDHEX$$rateur puisse g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rer le solde                          */
				/*------------------------------------------------------------------*/

					lRet = -4
					FileDelete ( sFicTrace )	
				End If
								
			End If
		Else

			lRet = -5			
		End If
	Else

		lRet	=	-2			// Fichier existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$on ne fait rien
	End If


Return lRet


end function

private function long uf_import (date addatedebut, date addatefin);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Import
//* Auteur			: DBI
//* Date				: 19/11/1998 16:18:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Import des fichiers de trace
//* Commentaires	: 
//*
//* Arguments		: Date	adDateDebut	- DAte du 1 er fichier $$HEX2$$e0002000$$ENDHEX$$importer
//*					  Date	adDatefin	- DAte du dernier fichier $$HEX2$$e0002000$$ENDHEX$$importer
//* Retourne		: Long			 - Nombre de lignes de la datawindow
//*
//*-----------------------------------------------------------------
//* #1 DGA              19/09/2006              Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire DCMP-060643
//*-----------------------------------------------------------------

String		sExtension 		// Extension des fichiers de trace
String		sNomFic			// Nom du fichier de trace sans extension
String		sNomFicTrace	// Nom du fichier de trace
String		sNomFicTxt		// Nom du fichier Texte Associ$$HEX1$$e900$$ENDHEX$$
String		sRepTmp			// R$$HEX1$$e900$$ENDHEX$$pertoire temporaire pour copie fichier TXT
Date			dDateEnCours	// Date en cours de traitement
Blob			blFic				// Contenu du fichier
Boolean		bOk	= True	// Retour
n_cst_string	lnvString // [MIGPB11] [EMD] : ImportFile d'une chaine vide

/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
sRepTmp = stGLB.sRepTempo

sExtension		=	"." + Left ( stGlb.sCodAppli, 3 )
dDateEnCours 	= 	adDateDebut

This.Reset ( )

stMessage.bErreurG = True					

/*----------------------------------------------------------------------------*/
/* Import des diff$$HEX1$$e900$$ENDHEX$$rents fichiers textes de workflow                          */
/*----------------------------------------------------------------------------*/
Do While dDateEnCours <= adDateFin

		sNomFic			=	String ( dDateEnCours, "dd" ) 	+  &
								String ( dDateEnCours, "mm" ) 	+  &
								String ( dDateEnCours, "yyyy" ) 	

		sNomFicTrace	=	isRepTrace + sNomFic + sExtension


//Migration PB8-WYNIWYG-03/2006 CP		
//		If FileExists ( sNomFicTrace ) Then
		If f_FileExists ( sNomFicTrace ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP


			If f_LireFichierBlob 	( blFic, sNomFicTrace ) Then

				sNomFicTxt	=	sRepTmp + sNomFic + ".TXT"

				If Not f_EcrireFichierBlob 	( blFic, sNomFicTxt ) Then

					bOk = False
					stMessage.sCode = "EWK0002"	
				End If

			Else

				bOk = False
				stMessage.sCode = "EWK0003"
	
			End If

		End If

		/*----------------------------------------------------------------------------*/
		/* Avertissement en cas d'erreur de lecture ou d'$$HEX1$$e900$$ENDHEX$$criture des fichiers de     */
		/* trace lors du traitement.                                                  */
		/*----------------------------------------------------------------------------*/
		If Not bOk Then 

			stMessage.sTitre = "Traitement des fichiers de trace"
			stMessage.bTrace = True
			f_Message ( stMessage )
			This.Reset ( )			
			Exit
			
		Else
			
			If Not lnvString.of_isEmpty ( sNomFicTxt ) Then // [MIGPB11] [EMD] : ImportFile d'une chaine vide

				This.ImportFile ( sNomFicTxt )
				This.Filter ()
				This.Sort()
				This.GroupCalc ()
				FileDelete ( sNomFicTxt )

			End If // [MIGPB11] [EMD] : ImportFile d'une chaine vide

		End If
		dDateEnCours = RelativeDate ( dDateEnCours, 1 )

Loop

Return ( This.RowCount ( ) )
end function

public function long uf_retrieve (integer aitrt, date addatedebut, date addatefin);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Retrieve
//* Auteur			: DBI
//* Date				: 19/11/1998 15:32:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement de la datawindow
//* Commentaires	: 
//*
//* Arguments		: Integer aiTrt			// Mode de chargement pour affichage ou ecriture fichier Texte
//*					  Date    adDateDebut 	// Date de d$$HEX1$$e900$$ENDHEX$$but de chargement
//*					  Date    adDateFin	 	// Date de fin de chargement
//*
//* Retourne		: Long - Nombre de lignes de la datawindow
//*					
//*
//*-----------------------------------------------------------------

Long					lRet
DataWindowChild	DddwDept, DddwDept1
DataWindowChild	DddwProd

If ( Not ibDddwChargee ) Then

	This.GetChild	( "ID_DEPT_DD", DddwDept )
	DddwDept.SetTransObject ( itrTrans )
	This.GetChild	( "ID_DEPT_DD1", DddwDept1 )
	DddwDept.SetTransObject ( itrTrans )
	This.GetChild	( "ID_PROD_DD", DddwProd )
	DddwProd.SetTransObject ( itrTrans )
End If

Choose Case aiTrt	

	Case 0	// Il s'agit d'un chargement pour $$HEX1$$e900$$ENDHEX$$criture du fichier de trace
/*------------------------------------------------------------------*/
/* On ne charge pas les DDDw sur dept et produit et on envoie le    */
/* retrieve sur la base de donn$$HEX1$$e900$$ENDHEX$$e                                   */
/*------------------------------------------------------------------*/
		If Not ibDddwChargee Then

			DddwDept.InsertRow ( 0 )
			DddwProd.InsertRow ( 0 )
			ibDddwChargee	=	True
		End If

		lRet	=	This.Retrieve ( )
		
	Case 1	// Il s'agit d'un import pour affichage
/*------------------------------------------------------------------*/
/* On charge les DDDw sur dept et produit et on r$$HEX1$$e900$$ENDHEX$$alise l'import    */
/* du fichier texte.                                                */
/*------------------------------------------------------------------*/
		lRet	= uf_Import ( adDateDebut, adDateFin )

		If Not ibDddwChargee Then

			DddwDept.Retrieve ( )
			DddwDept.ShareData ( DddwDept1 )
			DddwProd.Retrieve ( )
			ibDddwChargee	=	True
		End If

	Case 2	// Il s'agit d'un retrieve pour affichage
/*------------------------------------------------------------------*/
/* On charge les DDDw sur dept et produit et on envoie le retrieve  */
/* sur la base de donn$$HEX1$$e900$$ENDHEX$$e                                            */
/*------------------------------------------------------------------*/

		If Not ibDddwChargee Then

			DddwDept.Retrieve ( )
			DddwProd.Retrieve ( )
			ibDddwChargee	=	True
		End If

		lRet	=	This.Retrieve ( )
End Choose

Return lRet
end function

public subroutine uf_filtrer (string asdept);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Filtrer
//* Auteur			: DBI
//* Date				: 19/11/1998 17:56:21
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Filtre la datawindow en fonction d'un d$$HEX1$$e900$$ENDHEX$$partement
//* Commentaires	: 
//*
//* Arguments		: Long	alDept
//*
//* Retourne		: Rien
//*						
//*
//*-----------------------------------------------------------------

String	sFiltre
	
If asDept = "-1" Then 

	sFiltre = isFiltreInitial

Else

		/*----------------------------------------------------------------------------*/
		/* Si il n'y avait pas de filtre initialement pos$$HEX2$$e9002000$$ENDHEX$$sur la datawindow on       */
		/* positionne le filtre sur le d$$HEX1$$e900$$ENDHEX$$partement, sinon on concat$$HEX1$$e800$$ENDHEX$$ne les deux       */
		/* filtres.                                                                   */
		/*----------------------------------------------------------------------------*/
	If isFiltreInitial = "" Then

		sFiltre = "ID_DEPT_DD1 = " + asDept + ""

	Else 

		sFiltre = isFiltreInitial + " AND ID_DEPT_DD1 = " + asDept + ""
	End If

End If

This.SetFilter ( sFiltre )
This.Filter    ( )

end subroutine

public subroutine uf_initialisation (string asfichierini, string ascodoper, string ascodappli, string astrt, u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_initialisation
//* Auteur			: DBI
//* Date				: 19/11/1998 11:07:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation des variables d'instance
//* Commentaires	: 
//*
//* Arguments		: String			asFichierIni	(Val)	FichierIni de l'appli
//*                 String			asCodOper		(Val)	Nom de l'op$$HEX1$$e900$$ENDHEX$$rateur
//*                 String			asCodAppli		(Val)	Code de l'application
//*					  u_Transaction atrTrans		(ref) Objet de transaction
//*					  String			asTrt				(Val) Indique s'il s'agit trt solde des travaux, W trait$$HEX1$$e900$$ENDHEX$$s...
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------


isFichierIni		=	asFichierIni
isCodOper			=	asCodOper
isCodAppli			=	asCodAppli
itrTrans				=	atrTrans

Choose Case asTrt

	Case	"S"	// Gestion du solde des travaux

		isRepTrace			=	ProfileString 	( isFichierIni, "TRACE", "REP_TRACE_S", "" )
		This.DataObject	=	"D_SPB_WKF_SOLDE"
		This.SetTransObject ( itrTrans )

	Case	"W"	// Gestion de la trace w_queue

		isRepTrace			=	ProfileString 	( isFichierIni, "TRACE", "REP_TRACE", "" )
		This.DataObject	=	"D_SPB_WKF_TRAITE"

	Case	"C"	// Travaux Cr$$HEX2$$e900e900$$ENDHEX$$s

		isRepTrace			=	ProfileString 	( isFichierIni, "TRACE", "REP_TRACE_C", "" )
		This.DataObject	=	"D_SPB_WKF_CREE"

	Case  "OPV"  // Nbre de dossiers valid$$HEX1$$e900$$ENDHEX$$s, par personne qui valide, pour chaque gestionnaire 
		isRepTrace			=	ProfileString 	( isFichierIni, "TRACE", "REP_TRACE", "" )
		This.DataObject	=	"D_SPB_WKF_TRAITE_OPV"

	Case  "OPS"  // Pour chaque gestionnaire, pr$$HEX1$$e900$$ENDHEX$$sentation des personnes qui ont valid$$HEX1$$e900$$ENDHEX$$s leurs dossiers, et combien
		isRepTrace			=	ProfileString 	( isFichierIni, "TRACE", "REP_TRACE", "" )
		This.DataObject	=	"D_SPB_WKF_TRAITE_OPS"

	Case	"R"	// Gestion de la trace des motifs de routage

		isRepTrace			=	ProfileString 	( isFichierIni, "TRACE", "REP_TRACE_ROU", "" )
		This.DataObject	=	"D_SPB_WKF_TRAITE_MOT"

End Choose
/*----------------------------------------------------------------------------*/
/* Stockage du filtre initial de la datawindow, dans le cas o$$HEX2$$f9002000$$ENDHEX$$l'op$$HEX1$$e900$$ENDHEX$$rateur    */
/* sp$$HEX1$$e900$$ENDHEX$$cifierait un d$$HEX1$$e900$$ENDHEX$$partement pour limiter les donn$$HEX1$$e900$$ENDHEX$$es.                      */
/*----------------------------------------------------------------------------*/
If asTrt <> 'S' Then

	isFiltreInitial 	= This.Describe( "DataWindow.Table.Filter")

	If isFiltreInitial <> "?" Then

		isFiltreInitial = "(" + isFiltreInitial + ")"
	Else
	
		isFiltreInitial = ""
	End If
End If
end subroutine

on u_spb_suivi_travaux.create
end on

on u_spb_suivi_travaux.destroy
end on

