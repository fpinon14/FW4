$PBExportHeader$u_sesame.sru
$PBExportComments$----} UserObjet servant à toutes les fonctionnalités de connexion et de lancement de l'application
forward
global type u_sesame from nonvisualobject
end type
type us_parametre from structure within u_sesame
end type
end forward

type us_parametre from structure
    string sCodAppli
    string sCodOper
    string sFichierIni
    string sCodService
end type

global type u_sesame from nonvisualobject
end type
global u_sesame u_sesame

type variables
Public :
     u_Transaction                 itrEnvSpb	

	
end variables

forward prototypes
public function boolean uf_initialisation (application apapplication, ref s_glb astglb, ref s_message astmessage)
private function boolean uf_charge_env (ref s_glb astglb)
private function integer uf_chargefilenet (ref s_glb astglb)
public function boolean uf_fin_connexion (ref s_glb astglb)
public subroutine uf_popmenu (w_mdi awmdi, ref s_glb astglb)
public subroutine uf_charger_corb_oper (ref u_transaction atrtrans)
public function integer uf_applicationdejalance (string asnomapplication)
private function boolean uf_litparametre (string asnomapplication, string aslignecommande, ref us_parametre astparametre, ref boolean abmodecnx)
end prototypes

public function boolean uf_initialisation (application apapplication, ref s_glb astglb, ref s_message astmessage);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialisation (Public)
//* Auteur			: Erick John Stark
//* Date				: 02/09/1997 12:02:43
//* Libellé			: 
//* Commentaires	: Initialisation de la structure GLB
//*
//* Arguments		: Application	apApplication		(Val) Application Courante
//*					  astGLB			s_GLB					(Réf) Objet global à renseigner
//*					  astMessage	s_Message			(Réf) Structure Message
//*
//* Retourne		: Booléen		True	= Tout est OK
//*										False = L'initialisation ne se passe pas bien
//*
//*-----------------------------------------------------------------
//* MAJ 		PAR		Date				Modification
//* 			DGA		18/11/1996		Initialisation de la structure environnement
//* 			DGA		01/09/1997		Gestion d'une trace dans un fichier différent
//* 	#1 	DGA		19/09/2006		Gestion d'un répertoire temporaire DCMP-060643
//* 	#2 	PHG		17/10/2006		[DCMP060445] Controle de Cohérence Commune Identique Simpa2/Sherpa
//* 	#3		PHG		15/02/2008		[SUISSE].LOT3 : Lecture des clés de définiton de monnaie
//* 	#4 	PHG		15/02/2008		[SUISSE].LOT9 : Lecture de l'objet de gestion de commune
//*	#5		LBP		24/06/2010		[Recup vers SVN] : Ajout de la recup de la rev SVN
//*	#6		LBP		09/07/2010		[MAP2UNC] : Log en BD de la rev de connexion
//          JFF      24/04/2025     [LGY53_EQU_CNX]
//*-----------------------------------------------------------------

Boolean 			bRet, bMess					

Integer 			iRet, iSaisie, iValCleSESAME_LGY53_EQU_CNX

us_Parametre	stParametre				
Boolean bModeCnx
String sNomMachine, sRep, sFicTrace, sVal, sTab, sMaintenant, sLigne, sFicEssaiTrc
String sHeureMiniConnexion, sHeureMaxConnexion, sCommande, sMicroHelpDefaut		

ContextKeyword Cnx_KeyWord  // [LGY53_EQU_CNX]
String sRetContextKeyWords[] // [LGY53_EQU_CNX]

String			sJourSemaine [7] = { "Dimanche ", "Lundi ", "Mardi ", "Mercredi ", "Jeudi ", "Vendredi ", "Samedi " }
String			sMois [12] = { " Janvier ", " Février ", " Mars ", &
										" Avril ", " Mai ", " Juin ", " Juillet ", " Août ", " Septembre ", " Octobre ", &
										" Novembre ", " Décembre " }
n_cst_getFileInfo nFileInfo
String sObjClassName			// [SUISSE].LOT9 : Classe Name variable de stockage de classname pour instanciation dynamique
// [MIGPB11] [EMD] : Debut : [DETECTEAPPLI].REPTEMPO
boolean bInstanceMultiple  // [DETECTEAPPLI].REPTEMPO
integer iNbCnxOk            // [DETECTEAPPLI].REPTEMPO
// [MIGPB11] [EMD] : Fin
integer iNumRev


astGLB.sMessageErreur			=	""
bMess									= True
stMessage.sCode					= ""


/*------------------------------------------------------------------*/
/* Lecture des paramètres                                           */
/*------------------------------------------------------------------*/
//[Recup vers SVN] : Ajout de la recup modeCnx ou non pour affichage ds la barre de statut
bRet = Uf_LitParametre ( 	apApplication.AppName, CommandParm (), stParametre, bModeCnx )

If  bRet Then

	astGLB.sCodOper				= stParametre.sCodOper
	astGLB.sCodserv				= stParametre.sCodService
	astGLB.sCodAppli				= stParametre.sCodAppli
	astGLB.sFichierini				= stParametre.sFichierIni
	astGLB.bModeCnx 				= bModeCnx
	astGLB.sFichierErreur			= ProfileString ( stParametre.sFichierIni, "APPLICATION", "FICHIER_ERREUR", "")
	astGLB.sFichierErreurG		= ProfileString ( stParametre.sFichierIni, "APPLICATION", "FICHIER_ERREUR_G", "")
/*------------------------------------------------------------------*/
/* Création du pointeur pour les API Windows                        */
/*------------------------------------------------------------------*/
	astGLB.uoWin		= F_InitDeclarationWindows ( astGLB )
	astGLB.sWinDir 	= astGLB.uoWin.uf_GetWindowsDirectory ()
	

	astMessage.sFichier			=	stGLB.sFichierErreur
	astMessage.sFichierG			=	stGLB.sFichierErreurG
/*------------------------------------------------------------------*/	
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
/* Le répertoire final est au format                                */
/* C:\Temp\%USERNAME%\%CODEAPPLICATION%\                            */
/*------------------------------------------------------------------*/
/* [DETECTAPPLI].REPTEMPO On ne supprime les répertoire temporaire  */
/* si une seule instance d'application est détectée. 					  */
/* => Le code de Détection des instances d'application est ici      */
/* il était après la suppression des répertoire temporaires         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On vérifie le nombre de fois ou l'application peut-être lancée.  */
/*------------------------------------------------------------------*/
	iNbCnxOk = ProfileInt ( astGLB.sFichierIni, "APPLICATION", "NB_CONNEXIONS", 1 )
	Choose Case iNbCnxOk
	Case 0
/*------------------------------------------------------------------*/
/* Aucune connexion n'est autorisée.                                */
/*------------------------------------------------------------------*/

		//stMessage.sCode		= "APPLI01"
		stMessage.sCode		= "" // Pas de popup d'erreur à la fin de la fonction
										  // Msg affiché par msgbox enable non instancie
		Messagebox( "APPLI01 - Lancement du logiciel", &
						"Le lancement du logiciel~r~nn'est pas autorisé." &
						, StopSign!, Ok!, 1)

		bRet = False      

	Case IS>0
/*------------------------------------------------------------------*/
/* Une connexion par poste est autorisée.                           */
/*------------------------------------------------------------------*/
		// [DETECTEAPPLI].REPTEMPO
		bInstanceMultiple = (uf_ApplicationDejaLance(Upper ( apApplication.AppName )) < 0 )
		if bInstanceMultiple and iNbCnxOk = 1 THen
			//stMessage.sCode		= "APPLI02"
			stMessage.sCode		= "" // Pas de popup d'erreur à la fin de la fonction
											  // Msg affiché par msgbox enable non instancie
			Messagebox( "APPLI02 - Lancement du logiciel", "Le logiciel est déjà lancé.", StopSign!, Ok!, 1)
			bRet = False		
		End If
	End Choose
	if bRet Then
		astGLB.sRepTempo	= ProfileString ( stParametre.sFichierIni, "APPLICATION", "REP_TEMPO", "C:\TEMP\" )	
		astGLB.sRepTempo	= astGLB.sRepTempo + astGLB.sCodOper + "\" + astGLB.sCodAppli + "\"
		// [DETECTEAPPLI].REPTEMPO On initialise le repertoire temporaire que si
		// une seule instance
		// OU
		// (Nombre de connexion autorisé > 1 et instance multiple detectée et que le repertoire n'existe pas )
		if (Not bInstanceMultiple) or &
			(	bInstanceMultiple and &
				iNbCnxOk > 1 		and &
				Not DirectoryExists ( left(astGLB.sRepTempo, len(astGLB.sRepTempo)-1) ) &
			)	Then 
			bRet = (F_initdirectory(astGLB.sRepTempo) = 1) // On Crée l'arborescence si elle n'existe pas
		End If
		
		if Not bRet then
			stMessage.sTitre		= "Erreur dans U_Sesame - Initialisation Répertoire Temporaire"
			stMessage.Icon			= StopSign!
			stMessage.bErreurG	= TRUE
			stMessage.sCode		= "APPLI10"
			stMessage.bTrace  	= False

			stMessage.sVar[1] = astGlb.sRepTempo				
		End If
	End If	
//

	If bRet Then	

	/*------------------------------------------------------------------*/
	/* Le 25/04/2001.                                                   */
	/*------------------------------------------------------------------*/
	/*------------------------------------------------------------------*/
	/* Chargement du format d'affichage pour la monnaie. Cette valeur   */
	/* est utilisé dans N_Cst_Passage_Euro et U_Consultation_Euro.      */
	/*------------------------------------------------------------------*/
	/* #3 [SUISSE].LOT3 : Lecture du Symbole Désiré et du Format/symbole   */
	/* actuel                                                           */
		astGLB.sMonnaieFormatDesire	= ProfileString ( stParametre.sFichierIni, "MONNAIE", "Format_Desire", "EURO" )
		astGLB.sMonnaieSymboleDesire	= ProfileString ( stParametre.sFichierIni, "MONNAIE", "Symbole_Desire", "€" )
		astGLB.sMonnaieLitteralDesire	= ProfileString ( stParametre.sFichierIni, "MONNAIE", "Litteral_Desire", "Euro" )
		astGLB.sMonnaieFormatActuel	= ProfileString ( stParametre.sFichierIni, "MONNAIE", "Format_Actuel", "EURO" )
		astGLB.sMonnaieSymboleActuel	= ProfileString ( stParametre.sFichierIni, "MONNAIE", "Symbole_Actuel", "€" )
		astGLB.sMonnaieLitteralActuel	= ProfileString ( stParametre.sFichierIni, "MONNAIE", "Litteral_Actuel", "Euro" )
	//
	
	/*------------------------------------------------------------------*/
	/* Le 16/10/2001. Modif DGA                                         */
	/* Gestion Saisie/Validation.                                       */
	/*------------------------------------------------------------------*/
		iSaisie = ProfileInt ( stParametre.sFichierIni, "APPLICATION", "SaiValEdt", 0 )
		If	iSaisie = 1	Then astGLB.bSaiValEdt = TRUE
	/*------------------------------------------------------------------*/
	/* Initialisation du Tx de conversion pour l'EURO.                  */
	/*------------------------------------------------------------------*/
		astGLB.Tx_Euro = 6.55957
	
	/*------------------------------------------------------------------*/
	/* Initialisation de l'environnement                                */
	/*------------------------------------------------------------------*/
		F_LireEnvironnement ( astGLB )
	
	/*------------------------------------------------------------------*/
	/* On continue à renseigner la structure s_GLB                      */
	/*------------------------------------------------------------------*/
	
		astGLB.sLibAppli						= Upper ( apApplication.AppName ) + " - "
		apApplication.ToolBarText 			= Upper ( ProfileString ( stParametre.sFichierIni, "APPLICATION", "TOOLBARTEXT", "TRUE" ) ) = "TRUE"
		apApplication.ToolBarUserControl = Upper ( ProfileString ( stParametre.sFichierIni, "APPLICATION", "TOOLBARUSERCONTROL", "FALSE" ) ) = "TRUE"
	
//	/*------------------------------------------------------------------*/
//	/* On vérifie le nombre de fois ou l'application peut-être lancée.  */
//	/*------------------------------------------------------------------*/
//	
//		Choose Case ProfileInt ( astGLB.sFichierIni, "APPLICATION", "NB_CONNEXIONS", 1 )
//		Case 0
//	/*------------------------------------------------------------------*/
//	/* Aucune connexion n'est autorisée.                                */
//	/*------------------------------------------------------------------*/
//	
//			stMessage.sCode		= "APPLI01"
//	
//			bRet = False		
//	
//		Case 1
//	/*------------------------------------------------------------------*/
//	/* Une connexion par poste est autorisée.                           */
//	/*------------------------------------------------------------------*/
//	// [DETECTEAPPLI]
//	//		IF Handle ( apApplication, True ) > 0 Then
//	//
//	//			stMessage.sCode		= "APPLI02"
//	//			bRet = False		
//	//		End If
//	// remplacé par
//		IF uf_ApplicationDejaLance(Upper ( apApplication.AppName )) < 0 Then
//				stMessage.sCode		= "APPLI02"
//				bRet = False		
//			End If
//	
//		End Choose
	
	/*------------------------------------------------------------------*/
	/* On vérifie ensuite la plage horaire de lancement.                */
	/*------------------------------------------------------------------*/
	
		sHeureMiniConnexion = ProfileString ( astGLB.sFichierIni, "APPLICATION", "H_MIN_CONNECT", "00:00")
		sHeureMaxConnexion  = ProfileString ( astGLB.sFichierIni, "APPLICATION", "H_MAX_CONNECT", "23:59")
	
		If ( Now () < Time ( sHeureMiniConnexion ) ) Or ( Now () > Time ( sHeureMaxConnexion ) ) And bRet Then
	
			stMessage.sCode		= "APPLI03"
			stMessage.sVar[1]		= sHeureMiniConnexion
			stMessage.sVar[2]		= sHeureMaxConnexion
			bRet = False		
		End If
	End If // Fin test creation repertoire tempo

/*------------------------------------------------------------------*/
/* Chargement de tout l'environnement à partir d'ENVSPB.            */
/*------------------------------------------------------------------*/
	If bRet Then

		bRet	=	Uf_Charge_Env ( astGLB )

		If Not bRet Then

/*------------------------------------------------------------------*/
/* Deux cas                                                         */
/* Soit la connexion a échoué et il faut renseigner les valeurs de  */
/* l'objet de transaction.                                          */
/* Soit le select ne renvoie rien pour l'opérateur spécifié, et     */
/* dans ce cas on ne fait rien.                                     */
/*------------------------------------------------------------------*/

			stMessage.sCode		= astGLB.sMessageErreur
			If	stMessage.sCode = "APPLI07" Then
				stMessage.sVar[1]		= String ( itrEnvSpb.SQLDBCode )
				stMessage.sVar[2]		= itrEnvSpb.SQLErrText
				stMessage.sVar[3]		= itrEnvSpb.DBMS
				stMessage.sVar[4]		= itrEnvSpb.Database
				stMessage.sVar[5]		= itrEnvSpb.UserId
				stMessage.sVar[6]		= itrEnvSpb.Lock
			End If
	
		Else

/*------------------------------------------------------------------*/
/* On initialise la MicroHelp avec une valeur par défaut.           */
/*------------------------------------------------------------------*/
			If bRet Then
				
				// [LGY53_EQU_CNX]
				Select valeur
				Into :iValCleSESAME_LGY53_EQU_CNX
				From sysadm.cle
				Where id_cle = "LGY53_EQU_CNX"
				Using itrEnvSpb ; 
				
				If IsNull ( iValCleSESAME_LGY53_EQU_CNX ) Then iValCleSESAME_LGY53_EQU_CNX = 0
				
				IF iValCleSESAME_LGY53_EQU_CNX > 0 Then
				
					GetContextService ( "Keyword", Cnx_KeyWord )
					Cnx_KeyWord.GetContextKeyWords ( "SQL", sRetContextKeyWords )
					
					if UpperBound ( sRetContextKeyWords ) = 1 Then
						If	IsNull ( sRetContextKeyWords[1] ) Or Len ( Trim ( sRetContextKeyWords[1] ) ) = 0	Then
							sRetContextKeyWords[1] = ""
						End If
						
						astglb.ts_vm_cnx =Trim ( sRetContextKeyWords[1] )
//						astglb.ts_vm_cnx = "TS2016DE" // [TODO]
					End if
				End If 
				// [LGY53_EQU_CNX]	
							
				
				
				//[Recup vers SVN] -> Récupération de la revision Svn Du fichier
				astGLB.sRevisionSvn = ""
				
				//bRet = nFileInfo.getStringVariableInfo( astGLB.sNomApplication, "Revision SVN", astGLB.sRevisionSvn)
				
				if not bModeCnx then
					// On utilise le nom de l'appli obtnu à partir de sesame (Vu PHG le 25/06/10)
					bRet = nFileInfo.getStringVariableInfo( astGLB.sNomApplication, "Revision SVN", astGLB.sRevisionSvn)
				else
					// On utilise le nom de l'application obtneue à partir de GetProcessName (ne fonctionne pas
					// en mode Deug  (Vu PHG le 25/06/10)
					bRet = nFileInfo.getStringVariableInfo( "", "Revision SVN", astGLB.sRevisionSvn)
				end if
				
				if bRet = false or astGLB.sRevisionSvn= "" then astGLB.sRevisionSvn= "????"
				
				// Dans tous les cas on continue
				bRet = true 
			end if
				
			//[Recup vers SVN] -> Modification de la bare de statut : Ajout de la revision SVN
			/*
			sMicroHelpDefaut				= astGLB.sLibCourtAppli + " - Version " + &
												  astGLB.sVersionAppli + " - " + sJourSemaine[ DayNumber ( Today () )] + &
												  String ( Day ( Today () ) ) + sMois [ Month ( Today () ) ] + String ( Year ( Today ()) )
			*/
			// [LGY53_EQU_CNX]
			IF iValCleSESAME_LGY53_EQU_CNX > 0 Then
/*
*/											


				sMicroHelpDefaut	=  astGLB.sLibCourtAppli + " (" + astGLB.scodappli + ")" &
											+ " - " + sJourSemaine[ DayNumber ( Today () )]  &
											+ String ( Day ( Today () ) ) + sMois [ Month ( Today () ) ] + String ( Year ( Today ()) )  &
											+ " - Version : " + astGLB.sRevisionSvn &
											+ " - TS : " + astglb.ts_vm_cnx + &
											+ " - Env : " + astGLB.sCodEnv + &
											+ " - Oper : " + astGLB.sCodOper + &
											+ " - Niv : " + astGLB.sLibNiveauOper
			Else 

				sMicroHelpDefaut	=  astGLB.sLibCourtAppli &
											+ " - " + sJourSemaine[ DayNumber ( Today () )]  &
											+ String ( Day ( Today () ) ) + sMois [ Month ( Today () ) ] + String ( Year ( Today ()) )  &
											+ " - Version : " + astGLB.sRevisionSvn &
											+ " - Env : " + astGLB.sCodEnv
			End IF 
			
			if bModeCnx then
				// [LGY53_EQU_CNX]
				IF NOT ( iValCleSESAME_LGY53_EQU_CNX > 0 ) Then
					sMicroHelpDefaut = sMicroHelpDefaut + " - CNX : " + astGLB.sFichierIni
				End If 
			end if
			
			
			apApplication.MicroHelpDefault = ProfileString ( stParametre.sFichierIni, "APPLICATION", "MICROHELPDEFAULT", sMicroHelpDefaut )

/*------------------------------------------------------------------*/
/* Initialisation de FileNet si besoin.                             */
/*------------------------------------------------------------------*/

			iRet	= Uf_ChargeFilenet ( astGLB )
			If iRet <> -32 Then

/*------------------------------------------------------------------*/
/* Dans le cas ou la connexion FileNet échoue, on n'arréte pas le   */
/* chargement de l'application. Seul un message d'erreur apparaît.  */
/*------------------------------------------------------------------*/
				stMessage.sCode		= "APPLI06"
				stMessage.sVar[1]		= String ( iRet )

			End If
			
			// #2 [DCMP060445] Chargement de l'objet des communes et placement dans stglb.
			if (Today() >= Date ( ProfileString ( stGlb.sFichierIni, "DATE_MEP", "DCMP_060445",'' ) ) ) then
				// #4 [SUISSE].LOT9 Gestion de l'objet des communes, par  defaut, objet france
				sObjClassName = ProfileString ( stGlb.sFichierIni, "APPLICATION", "OBJ_COMMUNE_CLASSNAME","u_spb_ds_commune" )
				astGLB.uocommune = CREATE USING sObjClassName
				astGLB.uocommune.uf_chargecommune( itrEnvSpb, stParametre.sFichierIni )
			End If

			// #5 [SUISSE].LOT9 Chargement du fournisseur de fonction globale spécifique au pays
			sObjClassName = ProfileString ( stGlb.sFichierIni, "APPLICATION", "OBJ_GFP_CLASSNAME","n_cst_gfp_standard" )
			astGLB.uoGFP = CREATE USING sObjClassName
			
		End If
	End If
Else

/*------------------------------------------------------------------*/
/* La lecture des paramètres a échoué. Aucune initialisation n'est  */
/* possible. On affiche directement un MessageBox ()                */
/*------------------------------------------------------------------*/
	astGLB.sMessageErreur	= "Erreur de Chargement des paramètres de l'application"
	bMess							= False

End If

If bRet Then

/*------------------------------------------------------------------*/
/* Tout c'est bien passé, on met à jour le suivi des connexions.    */
/*------------------------------------------------------------------*/
	// [MAP2UNC] : Ajout LBP le 09/07/10 -> Log en BD de la rev de connexion
	If isnumber(astGLB.sRevisionSvn) Then
		iNumRev = integer(astGLB.sRevisionSvn)
	Else
		iNumRev = -1
	End if
	

	// [LGY53_EQU_CNX]
	IF iValCleSESAME_LGY53_EQU_CNX > 0 Then
		
		sCommande = "EXECUTE sysadm.IM_U01_CONNEXION_V02 'CNX', '" + astGLB.sCodOper + "','" +  astGLB.sCodAppli + "'," +  string(iNumRev) + ", '" + astglb.ts_vm_cnx + "'"
		
		// [LGY53_EQU_CNX] astGLB.lIdCnx obtenu en retour par réf
		itrEnvSpb.PS_IU_EQUI_TS_CNX ( "CNX", stGLB.sCodOper, astGLB.sCodAppli, iNumRev, astglb.ts_vm_cnx, astGLB.lIdCnx ) 
		
	Else 
		sCommande = "EXECUTE sysadm.IM_U01_CONNEXION_V01 CNX, '" + astGLB.sCodOper + "','" +  astGLB.sCodAppli + "'," +  string(iNumRev) 
	End IF 
	// [LGY53_EQU_CNX]
	
	If Not f_Execute ( sCommande, itrEnvSpb ) Then

		stMessage.sCode		= "APPLI07"
		stMessage.sVar[1]		= String ( itrEnvSpb.SQLDBCode )
		stMessage.sVar[2]		= itrEnvSpb.SQLErrText
		stMessage.sVar[3]		= itrEnvSpb.DBMS
		stMessage.sVar[4]		= itrEnvSpb.Database
		stMessage.sVar[5]		= itrEnvSpb.UserId
		stMessage.sVar[6]		= itrEnvSpb.Lock

		bRet = False
	
	End If

	f_Commit ( itrEnvSpb, bRet )
	
End If

/*------------------------------------------------------------------*/
/* Si l'initialisation de la structure globale est correcte on      */
/* peut tracer la connection.                                       */
/*------------------------------------------------------------------*/

If	bMess Then
/*------------------------------------------------------------------*/
/* On initialise maintenant le nom du fichier de TRACE au format    */
/* JJMMAAAA.App (App correspond au code de l'application).          */
/* Pour connaitre le répertoire qui contient le fichier de TRACE,   */
/* il faut lire la section TRACE du fichier INI de l'application.   */
/*------------------------------------------------------------------*/
	sNomMachine 	= astGLB.uoWin.uf_GetEnvironment ( "SQL" )
	sRep 				= ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_L", "ERREUR" )
	sFicTrace 		= sRep + String ( Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )

	sFicEssaiTrc	= sRep + stGLB.sCodOper + String ( Today (), "ddmm" ) + ".TMP"

	sTab				= "~t"
	sMaintenant 	= String ( DateTime ( Today(), Now() ), "dd/mm/yyyy hh:mm:ss" )

	If	bRet Then
		sVal = "0"
	Else
		sVal = "1"
	End If

	If	sRep <> "" Then

		sLigne = sMaintenant 			+ sTab + &
					astGLB.sCodAppli		+ sTab + &
					sNomMachine 			+ sTab + &
					astGLB.sCodOper		+ sTab + &
					"CNX"						+ sTab + &
					sVal

/*------------------------------------------------------------------*/
/* Le 27/05/1999.                                                   */
/* Modif DGA. On vérifie si la personne posséde les droits          */
/* nécessaires pour ecrire la TRACE.	Si ce n'est pas le cas, on   */
/* arrete tout.                                                     */
/*------------------------------------------------------------------*/

			If	F_Verifier_Ecriture_Trace ( sFicEssaiTrc ) < 0	Then

				stMessage.sTitre		= "Erreur dans U_EnvSpb - Ecriture TRACE"
				stMessage.Icon			= StopSign!
				stMessage.bErreurG	= TRUE
				stMessage.sCode		= "APPLI09"
			   stMessage.bTrace  	= False

				F_Message ( stMessage )
				stMessage.sCode = ""				
				bRet = False

			Else

				F_EcrireFichierText ( sFicTrace, sLigne )

			End If

	End If

/*------------------------------------------------------------------*/
/* Si on veut afficher un message d'erreur, on le fait maintenant.  */
/* On ne peut pas tester la valeur bRet a cause du chargement de    */
/* FileNet qui n'est pas une erreur. Donc on utilise                */
/* stMessage.sCode, qui est initialisé au début de la fonction.     */
/*------------------------------------------------------------------*/

	If	stMessage.sCode <> "" Then
		stMessage.sTitre		= "Erreur dans U_EnvSpb - Connexion"
		stMessage.Icon			= StopSign!
		stMessage.bErreurG	= True
		stMessage.bTrace		= True

		f_Message ( stMessage )
	End If

End If

Return ( bRet )
end function

private function boolean uf_charge_env (ref s_glb astglb);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Charge_Env (Private)
//* Auteur			: Erick John Stark
//* Date				: 02/09/1997 15:17:07
//* Libellé			: 
//* Commentaires	: Chargement de toutes les éléments nécessaires 
//*					  à la personnalisation de l'environnement par utilisateur
//*
//* Arguments		: s_GLB			astGLB				(Réf)	Structure globale
//*
//* Retourne		: Booléen		True	= Tout est OK
//*										False = Problème
//*-----------------------------------------------------------------
//* MAJ 		PAR		Date				Modification
//*	#1		LBP		24/06/2010		[Recup vers SVN] : Ajout de la recup de la rev SVN
//          JFF      24/04/2025     [LGY53_EQU_CNX]
//*-----------------------------------------------------------------

Boolean	bRet	= False	
Long	  	lRet				
Int		iIdDept, iValCleSESAME_LGY53_EQU_CNX

/*------------------------------------------------------------------*/
/* Connexion à la base de paramètre.                                */
/*------------------------------------------------------------------*/

If F_ConnectSqlServer ( astGLB.sFichierIni, "SESAME BASE", itrEnvSpb, astGLB.sMessageErreur, "SESAME", astGlb.sCodOper ) Then

/*------------------------------------------------------------------*/
/* Initialisation de la DataWindow pour lancer la recherche.        */
/*------------------------------------------------------------------*/
	w_Invisible.dw_Data.Uf_DataObject ( "d_sesame_libelle" )			
	w_Invisible.dw_Data.Uf_SetTransObject ( itrEnvSpb )

	// [LGY53_EQU_CNX]
	Select valeur
	Into :iValCleSESAME_LGY53_EQU_CNX
	From sysadm.cle
	Where id_cle = "LGY53_EQU_CNX"
	Using itrEnvSpb ; 
	
	If IsNull ( iValCleSESAME_LGY53_EQU_CNX ) Then iValCleSESAME_LGY53_EQU_CNX = 0

/*------------------------------------------------------------------*/
/* Chargement du libelle service et du type opérateur pour          */
/* l'application.                                                   */
/*------------------------------------------------------------------*/

	iIdDept	= Integer ( astGLB.sCodServ )
	lRet	=	w_Invisible.dw_Data.Retrieve ( astGLB.sCodAppli, astGLB.sCodOper, iIdDept )

	If  ( lRet > 0 ) Then
		astGLB.sLibAppli 			= w_Invisible.dw_Data.GetItemString ( 1, "lib_libelle" )
		astGLB.sLibServ  			= w_Invisible.dw_Data.GetItemString ( 2, "lib_libelle" )
		astGLB.sTypOper  			= w_Invisible.dw_Data.GetItemString ( 3, "lib_libelle" )
		astGLB.sLibCourtAppli  	= w_Invisible.dw_Data.GetItemString ( 4, "lib_libelle" )
		astGLB.sVersionAppli  	= w_Invisible.dw_Data.GetItemString ( 5, "lib_libelle" )
		astGLB.sDteDerCnx		  	= w_Invisible.dw_Data.GetItemString ( 6, "lib_libelle" )
		astGLB.sDteDerDCnx		= w_Invisible.dw_Data.GetItemString ( 7, "lib_libelle" )
		astGLB.sNomOper			= w_Invisible.dw_Data.GetItemString ( 8, "lib_libelle" )
		astGLB.sPrenomOper		= w_Invisible.dw_Data.GetItemString ( 9, "lib_libelle" )
		
		//[Recup vers SVN] : Si on tourne avec nouvelle PS de connexion on récupère nom appli et code env
		// if lRet = 11 then  [LGY53_EQU_CNX]
			//[Recup vers SVN] 
			astGLB.sNomApplication		= w_Invisible.dw_Data.GetItemString ( 10, "lib_libelle" )
			astGLB.sCodEnv		= w_Invisible.dw_Data.GetItemString ( 11, "lib_libelle" )
		// end if [LGY53_EQU_CNX]
		
		// [LGY53_EQU_CNX]
		IF iValCleSESAME_LGY53_EQU_CNX > 0 Then
			astGLB.slibniveauoper = w_Invisible.dw_Data.GetItemString ( 12, "lib_libelle" )
		End IF 
	
		bRet = True
	Else
		astGLB.sMessageErreur = "APPLI04"
	End If
Else

/*------------------------------------------------------------------*/
/* Cas ou la base n'est pas installée ou autre problème. Faire      */
/* apparaître le message d'erreur de la Base.                       */
/*------------------------------------------------------------------*/
	astGLB.sMessageErreur = "APPLI07"
End If 

Return ( bRet )
end function

private function integer uf_chargefilenet (ref s_glb astglb);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ChargeFileNet (Private)
//* Auteur			: Erick John Stark
//* Date				: 02/09/1997 15:33:27
//* Libellé			: 
//* Commentaires	: Lancement de la couche de communication FileNet
//*
//* Arguments		: s_GLB			astGLB				(Réf)	Structure globale
//*
//* Retourne		: Integer			 -32 	= Tout est OK.
//*											 -33 	= L'exécutable FileNet n'existe pas.
//*										0 à -31	= Erreur sur WinExec.
//*											 -34	= La connexion à l'IMS échoue.
//*
//*-----------------------------------------------------------------
//* #1 DGA		19/09/2006		Gestion d'un répertoire temporaire DCMP-060643
//*-----------------------------------------------------------------

Integer			iRet = 1					// Valeur de retour

uInt				uiHandleFileNet_Exe	// -- Handle du Filenet.exe si il est lancé
uInt				uiRetExec				// -- Retour du la fonction Winexec

Time				tMaintenant				// -- Sert à tester l'heure actuelle
Time				tFin						// -- Sert à tester l'heure de fin de boucle pour la connexion IMS
String			sFileNetExe				// -- Executable Filenet
String			sEnvFileNet				// -- Fichier d'environnement Filenet
String			sVisible					// -- Fenêtre de Logon Visible 1, Invisible 0

Boolean			bOk = True

// -- Récupération de la localisation du filenet.exe suivi du .ini dans 
// -- le .ini de l'application 
// -- ex : F:\APPLI\FILENET\FILENET.EXE F:\APPLI\FILENET\FILENET.INI

sFileNetExe		=	ProfileString ( astGLB.sFichierIni, "APPLICATION","FILENET_EXE","Pas Trouve" )
sEnvFileNet		=	ProfileString ( astGLB.sFichierIni, "APPLICATION","FILENET_ENV","Pas Trouve" )
sVisible			=	ProfileString ( astGLB.sFichierIni, "APPLICATION","FILENET_VISIBLE","1" )

If sFileNetExe = "Pas Trouve" Then

	iRet	=	-32

ElseIf sEnvFileNet = "Pas trouve" Then

	iRet	=	-33

Else
											// -- La fonction FindWindow permet de récupérer le handle d'une tache
											// -- Windows. Elle sert pour déterminer si Filenet.exe est déjà lancé

	uiHandleFileNet_Exe = astGLB.uoWin.Uf_FindWindow ( "FNWND040", "Connexion Filenet" )

	If uiHandleFileNet_Exe = 0 Then				

		// .... Destruction des flag
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
		FileDelete( astGLB.sRepTempo + "FILENET.OK" )
		FileDelete( astGLB.sRepTempo + "FILENET.NOK" )
//		FileDelete( astGLB.sWinDir + "\TEMP\FILENET.OK" )
//		FileDelete( astGLB.sWinDir + "\TEMP\FILENET.NOK")

		// .... Activation de la fenêtre de connexion

		uiRetExec = astGLB.uoWin.Uf_WinExec ( sFileNetExe + " " + sEnvFileNet, Integer( sVisible ) )

											// -- la fonction WinExec lance un exe Windows et 
											// -- retourne le handle de tache ( numéro de process )
											// -- qui lui est assigné
											// -- Si la valeur est inférieure à 32 une Erreur est intervenue

		If uiRetExec < 32 Then

			// .... Erreur dans la fenêtre de connexion

			iRet = uiRetExec * -1

		Else

			// .... Attendre le fin de la connexion 20 secondes au plus		

			tMaintenant 	= Now ()
			tFin				= RelativeTime ( Now (), 20 ) 
			
			Do While tMaintenant < tFin

				Yield()
			

//Migration PB8-WYNIWYG-03/2006 CP				
//				If FileExists( astGLB.sWinDir + "\TEMP\FILENET.OK" )	Then		// .... Connexion IMS Terminée
//				If f_FileExists( astGLB.sWinDir + "\TEMP\FILENET.OK" )	Then		// .... Connexion IMS Terminée				
//Fin Migration PB8-WYNIWYG-03/2006 CP				
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
				If	f_FileExists( astGLB.sRepTempo + "FILENET.OK" )	Then		// .... Connexion IMS Terminée				
					Exit
				End If

//Migration PB8-WYNIWYG-03/2006 CP
//				If FileExists( astGLB.sWinDir + "\TEMP\FILENET.NOK")	Then 		// .... Connexion IMS en Erreur
//				If f_FileExists( astGLB.sWinDir + "\TEMP\FILENET.NOK")	Then 		// .... Connexion IMS en Erreur
//Fin Migration PB8-WYNIWYG-03/2006 CP
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
				If f_FileExists( astGLB.sRepTempo + "FILENET.NOK")	Then 		// .... Connexion IMS en Erreur
					bOk = False
					Exit
				End if
					
				tMaintenant = Now ()
			Loop
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//			FileDelete( astGLB.sWinDir + "\TEMP\FILENET.OK" )
//			FileDelete( astGLB.sWinDir + "\TEMP\FILENET.NOK")
			FileDelete( astGLB.sRepTempo + "FILENET.OK" )
			FileDelete( astGLB.sRepTempo + "FILENET.NOK" )

			If bOk Then
				iRet = -32
			Else
				iRet = -34					// -- La connexion à l'IMS a échouée
			End If

		End If
	
	Else
			// -- Le message pbm_custom74 dans FileNet.exe correspond à 
			// -- l'incrémentation du nombre d'application utilisant la connexion
			// -- le n° message windows est calculé en ajoutant 1023 au 
			// -- n° message pbm_customXX de PowerBuilder
			// -- pbm_custom74 = 1023 + 74 = 1097
							
		Post ( uiHandleFileNet_Exe, 1097, 0, 0 )
		iRet	=	-32

	End If

End If
	
Return iRet
end function

public function boolean uf_fin_connexion (ref s_glb astglb);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Fin_Connexion (Public)
//* Auteur			: Erick John Stark
//* Date				: 03/09/1997 11:46:03
//* Libellé			: 
//* Commentaires	: Enregistrement de la date et heure de sortie de l'application 
//*
//* Arguments		: s_GLB			astGLB			(Réf)	Structure globale
//*
//* Retourne		: Boleean		True	= Sortie Ok
//*										False = Problème en sortie
//*
//*-----------------------------------------------------------------
//       JFF   24/04/2025 [LGY53_EQU_CNX]
//*-----------------------------------------------------------------

Boolean 		bRet = False	

String		sCommande
String		sNomMachine, sRep, sFicTrace, sTab, sMaintenant, sVal, sLigne
Integer 		iValCleSESAME_LGY53_EQU_CNX

U_DeclarationWindows	nvWin

/*------------------------------------------------------------------*/
/* Cette fonction est appelée par F_FermeMdi () lors de la          */
/* fermeture de l'application.                                      */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Connexion à la base de paramètre et mise à jour de la date et    */
/* heure de sortie.                                                 */
/*------------------------------------------------------------------*/

If	F_ConnectSqlServer ( astGLB.sFichierIni, "SESAME BASE", itrEnvSpb, astGLB.sMessageErreur, "SESAME", astGlb.sCodOper ) Then

	//sCommande = "EXECUTE sysadm.IM_U01_CONNEXION SOR, '" + astGLB.sCodOper + "'," +  astGLB.sCodAppli
	sCommande = "EXECUTE sysadm.IM_U01_CONNEXION 'SOR', '" + astGLB.sCodOper + "','" +  astGLB.sCodAppli + "'" // [PI037]

	// [LGY53_EQU_CNX]
	Select valeur
	Into :iValCleSESAME_LGY53_EQU_CNX
	From sysadm.cle
	Where id_cle = "LGY53_EQU_CNX"
	Using itrEnvSpb ; 
	
	If IsNull ( iValCleSESAME_LGY53_EQU_CNX ) Then iValCleSESAME_LGY53_EQU_CNX = 0
	
	IF iValCleSESAME_LGY53_EQU_CNX > 0 Then
		// [LGY53_EQU_CNX] astGLB.lIdCnx obtenu en retour par réf
		itrEnvSpb.PS_IU_EQUI_TS_CNX ( "SOR", "", "", 0, astglb.ts_vm_cnx, astGLB.lIdCnx ) 
	End If 
	// [LGY53_EQU_CNX]

	If f_Execute ( sCommande, itrEnvSpb ) Then

		bRet = True

	Else

		stMessage.sCode		= "APPLI07"
		stMessage.sVar[1]		= String ( itrEnvSpb.SQLDBCode )
		stMessage.sVar[2]		= itrEnvSpb.SQLErrText
		stMessage.sVar[3]		= itrEnvSpb.DBMS
		stMessage.sVar[4]		= itrEnvSpb.Database
		stMessage.sVar[5]		= itrEnvSpb.UserId
		stMessage.sVar[6]		= itrEnvSpb.Lock
	
	End If

	f_Commit ( itrEnvSpb, bRet )

End If 

/*------------------------------------------------------------------*/
/* On initialise maintenant le nom du fichier de TRACE au format    */
/* JJMMAAAA.App (App correspond au code de l'application).          */
/* Pour connaitre le répertoire qui contient le fichier de TRACE,   */
/* il faut lire la section TRACE du fichier INI de l'application.   */
/*------------------------------------------------------------------*/
nvWin			= stGLB.uoWin
sNomMachine = nvWin.uf_GetEnvironment ( "SQL" )

sRep 			= ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_L", "" )
sFicTrace 	= sRep + String ( Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )

sTab			= "~t"
sMaintenant = String ( DateTime ( Today(), Now() ), "dd/mm/yyyy hh:mm:ss" )

If	bRet Then
	sVal = "0"
Else
	sVal = "1"
End If

/*------------------------------------------------------------------*/
/* On écrit la déconnexion dans un fichier de trace s'il existe.    */
/*------------------------------------------------------------------*/

If	sRep <> "" Then

	sLigne = sMaintenant 			+ sTab + &
				astGLB.sCodAppli		+ sTab + &
				sNomMachine 			+ sTab + &
				astGLB.sCodOper		+ sTab + &
				"DCNX"					+ sTab + &
				sVal

	f_EcrireFichierText ( sFicTrace, sLigne )

End If

/*------------------------------------------------------------------*/
/* On affiche maintenant le message d'erreur si la déconnexion se   */
/* passe mal. (Erreur de base en général). Cette erreur est tracée. */
/*------------------------------------------------------------------*/

If	Not bRet Then
	stMessage.sTitre		= "Erreur dans U_EnvSpb - Déconnexion"
	stMessage.Icon			= StopSign!
	stMessage.bErreurG	= True
	stMessage.bTrace		= True

	f_Message ( stMessage )
End If

Return ( bRet )

end function

public subroutine uf_popmenu (w_mdi awmdi, ref s_glb astglb);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PopMenu (Public)
//* Auteur			: Erick John Stark
//* Date				: 03/09/1997 14:09:10
//* Libellé			: 
//* Commentaires	: Chargement dans la structure astGLB.stModule[] des informations 
//*					  relatives aux différents menus.
//*
//* Arguments		: W_Mdi			awMdi				(Val)	Fenêtre MDI de l'application
//*					  s_GLB			astGLB			(Réf) Structure globale
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Cette fonction est appelée sur l'open de la fenêtre MDI de       */
/* l'application. L'instanciation de U_EnvSpb est encore active,    */
/* donc la fenêtre W_Invisible est toujours ouverte. De plus, si    */
/* on arrive à cet endroit c'est que la structure stGLB est         */
/* correctement initialisée. (stMessage particulièrement)           */
/*------------------------------------------------------------------*/

Long		lCpt, lCpt1, lLig, lNbLig, lNbLig1, lTotModule, lTotMenu

Integer	iUpBound, iCpt, iAcces

String	sNomModule, sCreationTrv, sSaisieSin, sConsult, sEdtSin, sValSin, sModule, sMenu

lCpt 	= 1
lCpt1 = 1

/*------------------------------------------------------------------*/
/* On initialise les DataObjects et les objets de transaction.      */
/*------------------------------------------------------------------*/

W_Invisible.dw_Data.Uf_DataObject ( "d_sesame_module_autorise" )
W_Invisible.dw_Data.Uf_SetTransObject ( itrEnvSpb )

W_Invisible.dw_Data2.Uf_DataObject ( "d_sesame_menus_invisible" )				
W_Invisible.dw_Data2.Uf_SetTransObject ( itrEnvSpb )

/*------------------------------------------------------------------*/
/* Chargement du Code module,                                       */
/*               Libelle du module,(Apparait sur le bouton)         */
/*               Niveau d'accés,                                    */
/*               Désignation module (Libelle long)                  */
/* en fonction de l'opérateur et de l'application.                  */
/*------------------------------------------------------------------*/

W_Invisible.dw_Data.Retrieve ( astGLB.sCodAppli, astGLB.sCodOper )

lNbLig = W_Invisible.dw_Data.Rowcount ()

iUpBound		=	UpperBound ( awMdi.MenuId.Item )

For	iCpt = 1 To iUpBound
/*------------------------------------------------------------------*/
/* On récupére la liste des menus présents dans l'application et    */
/* on les rend invisibles.                                          */
/*------------------------------------------------------------------*/
		awMdi.MenuId.Item[ iCpt ].Visible	=	False

/*------------------------------------------------------------------*/
/* On cherche le module correspondant dans la DataWindow. Si on le  */
/* trouve, on va rendre le module visible, et on va populiser les   */
/* menus associés en fonction du niveau d'accés de l'opérateur à    */
/* ce module.                                                       */
/*------------------------------------------------------------------*/

		sNomModule = Upper ( awMdi.MenuId.Item[ iCpt ].Text )

		lLig	=	W_Invisible.dw_Data.Find ( "id_mod = '" + sNomModule + "'", 0, lNbLig )

/*------------------------------------------------------------------*/
/* Si le nom du module est égal à 'QUITTER', on l'affiche dans      */
/* tous les cas. Ce module n'est pas géré dans la gestion des       */
/* accés.                                                           */
/*------------------------------------------------------------------*/

		If sNomModule = "QUITTER" Or sNomModule = "&QUITTER" Then
			awMdi.MenuId.Item[ iCpt ].ToolBarItemVisible	=	True
		Else

			If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On assigne au module, le nom spécifié dans la gestion des        */
/* accés.                                                           */
/* On populise la structure globale, et on recherche les menus du   */
/* module en fonction du niveau d'accés.                            */
/*------------------------------------------------------------------*/

				awMdi.MenuId.Item[ iCpt ].ToolBarItemVisible	=	True
				awMdi.MenuId.Item[ iCpt ].ToolBarItemText		=	W_Invisible.dw_Data.GetItemString ( lLig, "LIB_ENTREE_MENU" )

				astGLB.stModule[ lCpt ].sCodModule	=	sNomModule
				iAcces										=	W_Invisible.dw_Data.GetItemNumber ( lLig, "COD_ACCES"  )
				astGLB.stModule[ lCpt ].sLibModule	=	W_Invisible.dw_Data.GetItemString ( lLig, "LIB_MOD" )

/*------------------------------------------------------------------*/
/* On récupére la liste des menus auxquels l'opérateur n'a pas      */
/* accés. Ces menus seront rendus invisibles dans la fonction       */
/* wf_PopMenu (), événement Open de W_MAIN.                         */
/*------------------------------------------------------------------*/

				lNbLig1	=	W_Invisible.dw_Data2.Retrieve ( astGLB.sCodAppli, sNomModule, iAcces )

				For lCpt1 = 1 To lNbLig1

					astGLB.stModule[ lCpt ].sCodMenu[ lCpt1 ] = W_Invisible.dw_Data2.GetItemString ( lCpt1, "ID_MENU"  )
					astGLB.stModule[ lCpt ].sTypMenu[ lCpt1 ] = W_Invisible.dw_Data2.GetItemString ( lCpt1, "TYP_MENU" )

				Next
				lCpt ++
			Else
/*------------------------------------------------------------------*/
/* Dans le cas ou le module n'est pas trouvé, on empêche            */
/* l'apparition du bouton. (Ce module est inaccessible à            */
/* l'opérateur).                                                    */
/* Le simple fait de rendre l'Item invisible n'est pas suffisant.   */
/*------------------------------------------------------------------*/
				awMdi.MenuId.Item[ iCpt ].ToolBarItemVisible	=	False
			End If
		End If	
Next

/*------------------------------------------------------------------*/
/* Le 11/05/2001.                                                   */
/* Modification pour les droits dans la gestion de CONTACT.         */
/*------------------------------------------------------------------*/
sCreationTrv	= ProfileString ( astGlb.sFichierIni, "DROITS CONTACTS", "CreationTrv", "" )
sSaisieSin		= ProfileString ( astGlb.sFichierIni, "DROITS CONTACTS", "SaisieSin", "" )
sConsult			= ProfileString ( astGlb.sFichierIni, "DROITS CONTACTS", "Consult", "" )
sEdtSin			= ProfileString ( astGlb.sFichierIni, "DROITS CONTACTS", "EdtSin", "" )
sValSin			= ProfileString ( astGlb.sFichierIni, "DROITS CONTACTS", "ValSin", "" )

lTotModule		= UpperBound ( astGlb.stModule )
/*------------------------------------------------------------------*/
/* CREATION D'UN TRAVAIL.                                           */
/*------------------------------------------------------------------*/
If	sCreationTrv = ""	Then 
	astGLB.bCreationTrv = False
Else
	sModule	= Upper ( Left ( sCreationTrv, 4 ) )
	sMenu		= Right ( sCreationTrv, 3 )
	For	lCpt = 1 To lTotModule
			If	astGlb.stModule[ lCpt ].sCodModule = sModule	Then
				lTotMenu = UpperBound ( astGlb.stModule[ lCpt ].sCodMenu )

				astGLB.bCreationTrv = TRUE
				For	lCpt1 = 1 To lTotMenu
						If astGlb.stModule[ lCpt ].sCodMenu[ lCpt1 ] = sMenu	Then
							astGLB.bCreationTrv = FALSE
							Exit
						End If
				Next
				Exit
			End If
	Next
End If

/*------------------------------------------------------------------*/
/* SAISIE D'UN SINISTRE.                                            */
/*------------------------------------------------------------------*/
If	sSaisieSin = ""	Then 
	astGLB.bSaisieSin = False
Else
	sModule	= Upper ( Left ( sSaisieSin, 4 ) )
	sMenu		= Right ( sSaisieSin, 3 )
	For	lCpt = 1 To lTotModule
			If	astGlb.stModule[ lCpt ].sCodModule = sModule	Then
				lTotMenu = UpperBound ( astGlb.stModule[ lCpt ].sCodMenu )

				astGLB.bSaisieSin = TRUE
				For	lCpt1 = 1 To lTotMenu
						If astGlb.stModule[ lCpt ].sCodMenu[ lCpt1 ] = sMenu	Then
							astGLB.bSaisieSin = FALSE
							Exit
						End If
				Next
				Exit
			End If
	Next
End If

/*------------------------------------------------------------------*/
/* Edition D'UN SINISTRE.                                           */
/*------------------------------------------------------------------*/
If	sEdtSin = ""	Then 
	astGLB.bEdtSin = False
Else
	sModule	= Upper ( Left ( sEdtSin, 4 ) )
	sMenu		= Right ( sEdtSin, 3 )
	For	lCpt = 1 To lTotModule
			If	astGlb.stModule[ lCpt ].sCodModule = sModule	Then
				lTotMenu = UpperBound ( astGlb.stModule[ lCpt ].sCodMenu )

				astGLB.bEdtSin = TRUE
				For	lCpt1 = 1 To lTotMenu
						If astGlb.stModule[ lCpt ].sCodMenu[ lCpt1 ] = sMenu	Then
							astGLB.bEdtSin = FALSE
							Exit
						End If
				Next
				Exit
			End If
	Next
End If

/*------------------------------------------------------------------*/
/* Validation D'UN SINISTRE.                                        */
/*------------------------------------------------------------------*/
If	sValSin = ""	Then 
	astGLB.bValSin = False
Else
	sModule	= Upper ( Left ( sValSin, 4 ) )
	sMenu		= Right ( sValSin, 3 )
	For	lCpt = 1 To lTotModule
			If	astGlb.stModule[ lCpt ].sCodModule = sModule	Then
				lTotMenu = UpperBound ( astGlb.stModule[ lCpt ].sCodMenu )

				astGLB.bValSin = TRUE
				For	lCpt1 = 1 To lTotMenu
						If astGlb.stModule[ lCpt ].sCodMenu[ lCpt1 ] = sMenu	Then
							astGLB.bValSin = FALSE
							Exit
						End If
				Next
				Exit
			End If
	Next
End If


/*------------------------------------------------------------------*/
/* CONSULTATION DES DOSSIERS.                                       */
/*------------------------------------------------------------------*/
If	sConsult = ""	Then 
	astGLB.bConsult = False
Else
	sModule	= Upper ( Left ( sConsult, 4 ) )
	sMenu		= Right ( sConsult, 3 )
	For	lCpt = 1 To lTotModule
			If	astGlb.stModule[ lCpt ].sCodModule = sModule	Then
				lTotMenu = UpperBound ( astGlb.stModule[ lCpt ].sCodMenu )

				astGLB.bConsult = TRUE
				For	lCpt1 = 1 To lTotMenu
						If astGlb.stModule[ lCpt ].sCodMenu[ lCpt1 ] = sMenu	Then
							astGLB.bConsult = FALSE
							Exit
						End If
				Next
				Exit
			End If
	Next
End If

end subroutine

public subroutine uf_charger_corb_oper (ref u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Charger_Corb_Oper::U_EnvSpb (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 10/11/1998 09:55:03
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: U_Transaction		atrTrans		(Réf)	Moteur ou se trouve la table CORB_OPER
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ	PAR      Date			Modification
//* #2	JFF   11/09/2003		Pour PLJ, écriture d'un fichier Text sur C:\Winnt\Temp
//*								   contenant tous les users de l'appli en cours.
//* #3	DGA	19/09/2006		Gestion d'un répertoire temporaire DCMP-060643
//*		 PHG	06/04/2011		[I027].BUG2 : Correction détection application Savane
//*									pour le chargement des corbeille.
//*-----------------------------------------------------------------

String sMoteur, sDataCorb, sDataOper, sCodOper, sFicCorb, sFicOper, sFicOperAppli, sRepWin
String sIdOperLu, sIdOper, sNom, sRech, sDataOpar, sCodAppli
Long lTotData3, lTotData4, lCpt, lLig

U_DeclarationWindows	nvWin

/*------------------------------------------------------------------*/
/* Le but de cette fonction est de créer deux fichiers dans le      */
/* répertoire temporaire de WINDOWS. Le premier fichier contient    */
/* la liste de toutes les corbeilles accessibles pour l'opérateur   */
/* en cours. Le second contient la liste de tous les opérateurs     */
/* pouvant accéder aux corbeilles que l'on vient de récupérer.      */
/*------------------------------------------------------------------*/
sMoteur		= Left ( Upper ( atrTrans.DBMS ), 3 )

// [MIGPB11] [EMD] : Debut Migration : support du DBMS SNC
//If sMoteur = "SNC" Then sMoteur = "MSS" 
If sMoteur <> "GUP" Then sMoteur = "MSS" // [PI056] Moteur MSS par défaut
// [MIGPB11] [EMD] : Fin Migration

// ... #1 Début de modification
//     Pour l'application SAVANE on force GUP pour continuer à utiliser
//     les anciens data objets


//[I027].BUG2 - Détetection de l'application savane par le classname et non plus
// par le code appli...
//If Left( stGlb.sCodAppli , 2 ) = 'SA' And sMoteur = "MSS" Then sMoteur = 'GUP'
If f_IsApplication('savane') And sMoteur = "MSS" Then sMoteur = 'GUP'

// ... #1 Fin de modification
sDataCorb	= "d_Routage_Corb_"
sDataOper	= "d_Routage_Oper_"
// #2
sDataOpar	= "d_utilisateur_appli"
sCodOper		= stGLB.sCodOper
// #2
sCodAppli	= stGLB.sCodAppli

/*------------------------------------------------------------------*/
/* Le nom des fichiers se décompose de la manière suivante.         */
/* CORB + stGLB.sCodAppli + ".TXT"                                  */
/* OPER + stGLB.sCodAppli + ".TXT"                                  */
/*------------------------------------------------------------------*/
nvWin		= stGLB.uoWin
sRepWin	= nvWin.Uf_GetWindowsDirectory ()

/*------------------------------------------------------------------*/  
/* #3. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sFicCorb	= sRepWin + "\TEMP\" + "CORB" + stGLB.sCodAppli + ".TXT"
//sFicOper	= sRepWin + "\TEMP\" + "OPER" + stGLB.sCodAppli + ".TXT"
sFicCorb	= stGLB.sRepTempo			+ "CORB" + stGLB.sCodAppli + ".TXT"
sFicOper	= stGLB.sRepTempo			+ "OPER" + stGLB.sCodAppli + ".TXT"
// #2
sFicOperAppli = stGLB.sRepTempo	+ "OPAR" + stGLB.sCodAppli + ".TXT"

/*------------------------------------------------------------------*/
/* On supprime les fichiers existants.                              */
/*------------------------------------------------------------------*/
FileDelete ( sFicCorb )
FileDelete ( sFicOper )
// #2
FileDelete ( sFicOperAppli )

/*------------------------------------------------------------------*/
/* On assigne le DataObject en fonction du moteur.                  */
/*------------------------------------------------------------------*/

Choose Case sMoteur
Case "GUP"
	sDataCorb = sDataCorb + sMoteur
	sDataOper = sDataOper + sMoteur
	
Case "MSS"
	sDataCorb = sDataCorb + sMoteur
	sDataOper = sDataOper + sMoteur

End Choose

/*------------------------------------------------------------------*/
/* #1																					  */
/* On traite le fichier des Operateur ARCHIVE							  */
/* J'utilse Data3 pour cela, je pense que ça ne gêne pas, puisque   */
/* au final DATA3 contiendra bien les corbeille, voir tout suivant  */
/*------------------------------------------------------------------*/
w_Invisible.dw_Data3.DataObject = sDataOpar
w_Invisible.dw_Data3.SetTransObject ( itrEnvSpb )
w_Invisible.dw_Data3.Retrieve ( sCodAppli )

w_Invisible.dw_Data3.SaveAs ( sFicOperAppli, TEXT!, False )


/*------------------------------------------------------------------*/
/* On traite le fichier des corbeilles.                             */
/*------------------------------------------------------------------*/
w_Invisible.dw_Data3.DataObject = sDataCorb
w_Invisible.dw_Data3.SetTransObject ( atrTrans )
w_Invisible.dw_Data3.Retrieve ( sCodOper )

w_Invisible.dw_Data3.SaveAs ( sFicCorb, TEXT!, False )

/*------------------------------------------------------------------*/
/* On traite le fichier des opérateurs.                             */
/*------------------------------------------------------------------*/
w_Invisible.dw_Data3.DataObject = sDataOper
w_Invisible.dw_Data3.SetTransObject ( atrTrans )
w_Invisible.dw_Data3.Retrieve ( sCodOper )

/*------------------------------------------------------------------*/
/* On récupére le nom de tous les opérateurs ayant accés à ce       */
/* produit sur ENVSPB.                                              */
/*------------------------------------------------------------------*/
w_Invisible.dw_Data4.DataObject = "d_Routage_Nom_MSS"
w_Invisible.dw_Data4.SetTransObject ( itrEnvSpb )
w_Invisible.dw_Data4.Retrieve ( stGLB.sCodAppli )

/*------------------------------------------------------------------*/
/* On positionne le nom récupéré de ENVSPB dans la DW sur les       */
/* opérateurs.                                                      */
/*------------------------------------------------------------------*/
lTotData3 = w_Invisible.dw_Data3.RowCount ()
lTotData4 = w_Invisible.dw_Data4.RowCount ()
sIdOperLu = ""

For	lCpt = 1 To lTotData3
		sIdOper = w_Invisible.dw_Data3.GetItemString ( lCpt, "ID_OPER" )
		If	sIdOperLu <> sIdOper	Then
			sRech = "ID_OPER = '" + sIdOper + "'"
			lLig = w_Invisible.dw_Data4.Find ( sRech, 1, lTotData4 )
			If	lLig > 0 Then
				sNom = w_Invisible.dw_Data4.GetItemString ( lLig, "NOM" )
				w_Invisible.dw_Data3.SetItem ( lCpt, "NOM", sNom )
				sIdOperLu = sIdOper
			End If
		Else
			w_Invisible.dw_Data3.SetItem ( lCpt, "NOM", sNom )
		End If
Next

/*------------------------------------------------------------------*/
/* On sauvegarde le fichier des opérateurs.                         */
/*------------------------------------------------------------------*/
w_Invisible.dw_Data3.SaveAs ( sFicOper, TEXT!, False )





end subroutine

public function integer uf_applicationdejalance (string asnomapplication);//*-----------------------------------------------------------------
//*
//* Fonction		: u_sesame::uf_ApplicationDejaLance
//* Auteur			: PHG
//* Date				: 05/04/2006
//* Libellé			: On detecte si le Mutex correspondant à l'application a déja eté lancée
//* Commentaires	: [DETECTEAPPLI]
//*
//* Arguments		: string asNomApplication
//*
//* Retourne		: -1 l'application tourne deja
//*					: Pas d'instance précédente de l'application
//*
//*-----------------------------------------------------------------

UnsignedLong	ulResult1, ulResult2
Boolean bInitial
Integer iRet

bInitial = FALSE

/*------------------------------------------------------------------*/
/* Création du Mutex ( Mutually Exclusive ) (Voir Document          */
/* ID:47615)                                                        */
/*------------------------------------------------------------------*/
ulResult1 = stGLB.uoWin.uf_CreateMutex ( bInitial, asNomApplication )
stGLB.uoWin.uf_SetMutexRef(ulResult1)
/*------------------------------------------------------------------*/
/* On récupére la dernière erreur survenue.                         */
/*------------------------------------------------------------------*/
ulResult2 = stGLB.uoWin.uf_GetLastError ()
If	ulResult2 = 183	Then
	iRet = -1
/*------------------------------------------------------------------*/
/* On referme l'objet Mutex.                                        */
/*------------------------------------------------------------------*/
	stGLB.uoWin.uf_CloseHandle ( ulResult1 )
Else
/*------------------------------------------------------------------*/
/* A priori, la fermeture de l'application PB, détruira             */
/* automatiqement l'objet MUTEX. (A Suivre et à vérifier)           */
/*------------------------------------------------------------------*/
	iRet = 1
End If

Return ( iRet )
end function

private function boolean uf_litparametre (string asnomapplication, string aslignecommande, ref us_parametre astparametre, ref boolean abmodecnx);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_LitParametre (Private)
//* Auteur			: Erick John Stark
//* Date				: 02/09/1997 14:15:42
//* Libellé			: 
//* Commentaires	: Chargement des paramètres passés par l'objet de connexion
//*
//* Arguments		: 	String				asNomApplication		(Val)	Nom de l'application appelante
//*					  	String				asLigneCommande	(Val) Paramètres passés à l'application
//*					  	us_Parametre	astParametre			(Réf) Structure de stockage
//*						Boolean			abmodecnx				(Réf) Retourne si un CNX est present ou non
//*
//* Retourne		: Booléen		True	= Tout est OK
//*										False = Il y a un problème
//*
//* MAJ 		PAR		Date				Modification
//* 			LBP		24/06/2010		[Recup vers SVN] -> Renvoi si l'appli tourne avec un CNX
//*
//*-----------------------------------------------------------------

Boolean	bRet			= False			// Valeur de retour de la fonction

String 	sParam[4]						// Tableau temporaire pour le chargement des parametres
String	sFichierCNX						// Fichier CNX si il existe

Integer	iCpt								// Compteur de boucle
Integer	iPos								// Indice pour la lecture de la ligne de commande

U_DeclarationWindows	nvWin
nvWin 		= F_InitDeclarationWindows ( stGLB )
sFichierCNX	=	nvWin.uf_GetWindowsDirectory() + "\TEMP\" + asNomApplication + ".CNX"
//Migration PB8-WYNIWYG-03/2006 FM
//DESTROY nvWin
If IsValid(nvWin) Then DESTROY nvWin
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Si le fichier CNX existe, ce sont les paramètres qu'il contient  */
/* qui seront pris en compte                                        */
/*------------------------------------------------------------------*/
abmodecnx = false

//Migration PB8-WYNIWYG-03/2006 CP
//If FileExists ( sFichierCNX ) Then
If f_FileExists ( sFichierCNX ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP

	astParametre.sCodAppli		=	ProfileString ( sFichierCNX, "PARAM", "Application",	"" )
	astParametre.sCodOper		=	ProfileString ( sFichierCNX, "PARAM", "Operateur",		"" )
	astParametre.sFichierIni	=	ProfileString ( sFichierCNX, "PARAM", "FichierIni",	"" ) 
	astParametre.sCodService	=	ProfileString ( sFichierCNX, "PARAM", "Service",		"" )
	abmodecnx = true
Else

/*------------------------------------------------------------------*/
/* On découpe la ligne de commande. Chaque élément est séparé par   */
/* un espace dans la chaine composée par le lanceur SPB.            */
/*------------------------------------------------------------------*/

	iCpt	=	 1
	iPos	=	-1

	asLigneCommande = RightTrim ( asLigneCommande )

	Do While asLigneCommande <> "" And iPos <> 0

		iPos 	= 	Pos ( asLigneCommande, " " )

		If iPos <> 0 Then
			sParam[iCpt] 			= 	Left ( asLigneCommande,iPos - 1 )
			asLigneCommande 		= 	Mid  ( asLigneCommande,iPos + 1,Len ( asLigneCommande ) - iPos )
			iCpt++
		Else
			sParam[iCpt] 			= 	asLigneCommande
		End if		

	Loop

	astParametre.sCodAppli			=	sParam[1]
	astParametre.sCodOper			=	sParam[2]
	astParametre.sFichierIni		=	sParam[3]
	astParametre.sCodService		=	sParam[4]

End If

/*------------------------------------------------------------------*/
/* Si toutes les valeurs sont bien reseignées, dans ce cas tout     */
/* est OK.                                                          */
/*------------------------------------------------------------------*/

If astParametre.sCodAppli   <> "" And astParametre.sCodOper    <> ""  And &
   astParametre.sFichierIni <> "" And astParametre.sCodService <> "" Then

	bRet = True
End If

Return ( bRet )
end function

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Envspb::Constructor
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 02/09/1997 12:00:06
//* Libellé			: 
//* Commentaires	: Création des objets nécessaires à ENVSPB
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

itrEnvSpb					= CREATE u_Transaction

/*------------------------------------------------------------------*/
/* Ouverture de la fenêtre qui contient les DataWindows pour        */
/* populiser les menus.                                             */
/*------------------------------------------------------------------*/

Open ( w_Invisible )


end on

on destructor;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Envspb::Destructor
//* Evenement 		: Destructor
//* Auteur			: Erick John Stark
//* Date				: 02/09/1997 11:58:53
//* Libellé			: 
//* Commentaires	: Destruction des objets relatifs à ENVSPB
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


DISCONNECT USING itrEnvSpb ;
DESTROY itrEnvSpb

Close ( w_Invisible )
end on

on u_sesame.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_sesame.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

