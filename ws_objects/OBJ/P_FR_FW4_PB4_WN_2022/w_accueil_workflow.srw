HA$PBExportHeader$w_accueil_workflow.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil pour le WorkFlow (DCMP 9900391)
forward
global type w_accueil_workflow from w_accueil
end type
type dw_libre from datawindow within w_accueil_workflow
end type
type mle_msg1 from multilineedit within w_accueil_workflow
end type
type pb_debloc from u_pbdebloc within w_accueil_workflow
end type
type dw_corbeille from datawindow within w_accueil_workflow
end type
type dw_workflow from datawindow within w_accueil_workflow
end type
end forward

global type w_accueil_workflow from w_accueil
boolean visible = true
integer width = 2098
integer height = 2068
dw_libre dw_libre
mle_msg1 mle_msg1
pb_debloc pb_debloc
dw_corbeille dw_corbeille
dw_workflow dw_workflow
end type
global w_accueil_workflow w_accueil_workflow

type variables
Private :
   String          isFicTrace,        &
                     isFicTraceRout,  &
                     isNomMachine,   &
                     isMoteur

   String          isDosMajPar

   DateTime     idtDosMajLe

   Datawindow idwRoutage

Protected :
   Integer         iiNumCol[18]

   String          isBmpOccupe_Oui,    &
                     isBmpOccupe_Non,   &
                     isBmpBloc_Oui,         &
                     isBmpBloc_Non,        &
                     isBmpRout_Oui,         &
                     isBmpRout_Non,         &
                     isJointureCorbeille             

   Boolean        ibAfficherMessage,   &
                      ibContinuerModifier,  &
                      ibGestionErreur 
   
end variables

forward prototypes
private subroutine wf_affichermessage (long alligne)
private function boolean wf_gestionaltoccupe ()
public function string wf_str2dt (string asdatetime)
public function datetime wf_dt2dt (string asdatetime)
protected subroutine wf_trttrace (ref string asval[])
private subroutine wf_choixgestion (string asval[])
private function string wf_getitem (datawindow adw, long allig, integer aicol)
protected subroutine wf_init_dwlibre ()
private subroutine wf_recuperer_corbeille ()
private subroutine wf_trt_dwwork ()
private function string wf_executer_sql (integer aitype)
private subroutine wf_gestionerreur ()
private subroutine wf_tracemotifroutage (ref string astrace, ref datawindow adwmotif)
private function string wf_ecriretrace (string asdepart[], string asfin[])
end prototypes

private subroutine wf_affichermessage (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Workflow::Wf_AfficherMessage ( Private )
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 14:57:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des Messages
//*
//* Arguments		: Long			alLigne			(Val)	Ligne de la DW accueil
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sTrvRouteLe, sTrvRoutePar, sTxtMess

sTrvRouteLe		= String ( dw_1.GetItemDateTime ( alLigne, "TRV_ROUTE_LE" ), "dd/mm/yyyy" )
sTrvRoutePar	= dw_1.GetItemString ( alLigne, "TRV_ROUTE_PAR" )
sTxtMess			= Trim ( dw_1.GetItemString ( alLigne, "TXT_MESS1" ) )

If	Not IsNull ( sTxtMess ) And sTxtMess <> "" Then
	If	Not IsNull ( sTrvRouteLe + sTrvRoutePar ) Then
		mle_Msg1.Text = "Rout$$HEX2$$e9002000$$ENDHEX$$Le : " + sTrvRouteLe + " Par : " + sTrvRoutePar + "~r~n" + sTxtMess
	Else
		mle_Msg1.Text = "Message :~r~n" + sTxtMess
	End If
	mle_Msg1.Visible = True
Else
	mle_Msg1.Visible = False
End If



	


end subroutine

private function boolean wf_gestionaltoccupe ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Workflow::Wf_GestionAltOccupe ( Private )
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 16:01:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion de ALT_OCCUPE
//*
//* Arguments		: Aucun
//*
//* Retourne		: Booleen		Vrai 	= Tout est OK
//											False = Probl$$HEX1$$e800$$ENDHEX$$me
//
//*-----------------------------------------------------------------

String sIdSin, sIdCorb, sMess, sSql
String sCodEtatLu, sAltBlocLu, sTrvMajParLu, sTrvMajParNouveau
String sCodEtat, sAltBloc, sCodOper
String sMaintenant

DateTime dtTrvMajLeLu
DateTime dtMaintenant

Long lRet

/*------------------------------------------------------------------*/
/* Le 07/06/1999. Modif DGA. R$$HEX1$$e900$$ENDHEX$$initialisation des variables         */
/* d'instances $$HEX2$$e0002000$$ENDHEX$$NULL.                                              */
/*------------------------------------------------------------------*/
SetNull ( idtDosMajLe )
SetNull ( isDosMajPar )

If	dw_1.ilLigneClick > 0 Then

/*------------------------------------------------------------------*/
/* Puisque la ligne est bonne, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le N$$HEX2$$b0002000$$ENDHEX$$de sinistre et le  */
/* N$$HEX2$$b0002000$$ENDHEX$$de corbeille                                                  */
/* Ces valeurs doivent $$HEX1$$ea00$$ENDHEX$$tre uniques dans la table W_QUEUE           */
/*------------------------------------------------------------------*/

	sIdSin 	= dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" )
	sIdCorb	= dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" )

	sCodEtat	= dw_1.GetItemString ( dw_1.ilLigneClick, "COD_ETAT" )
	sAltBloc	= dw_1.GetItemString ( dw_1.ilLigneClick, "ALT_BLOC" )

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si le travail est toujours libre                      */
/*------------------------------------------------------------------*/

	lRet = dw_Libre.Retrieve ( sIdSin, sIdCorb )

/*------------------------------------------------------------------*/
/* 1Er Cas : Le travail affich$$HEX2$$e9002000$$ENDHEX$$n'existe plus, il a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$valid$$HEX7$$e900200020002000200020002000$$ENDHEX$$*/
/*------------------------------------------------------------------*/

	If	lRet = 0 Then

		stMessage.bErreurG	= True
		stMessage.sVar[1]		= "Ce travail"
		stMessage.sTitre		= "- WorkFlow - "
		stMessage.Icon			= Information!
		stMessage.sCode 		= "ANCE040"

		f_Message ( stMessage )

		Return ( False )
	Else

		sCodEtatLu		= dw_Libre.GetItemString ( 1, "COD_ETAT" )
		sAltBlocLu		= dw_Libre.GetItemString ( 1, "ALT_BLOC" )
		sTrvMajParLu	= dw_Libre.GetItemString ( 1, "TRV_MAJ_PAR" )
		dtTrvMajLeLu	= dw_Libre.GetItemDateTime ( 1, "TRV_MAJ_LE" )
		
	End If

/*------------------------------------------------------------------*/
/* 2$$HEX1$$e900$$ENDHEX$$me Cas : Le travail ne poss$$HEX1$$e900$$ENDHEX$$de plus le m$$HEX1$$ea00$$ENDHEX$$me COD_ETAT           */
/* On affiche le nouvel $$HEX1$$e900$$ENDHEX$$tat et la personne ayant pris le travail   */
/*------------------------------------------------------------------*/

	If		sCodEtat <> sCodEtatLu Then
			Choose Case sCodEtatLu
			Case "1"
				sMess = "Le travail est en attente de saisie"

			Case "3"
				sMess = "Le travail est en attente d'$$HEX1$$e900$$ENDHEX$$dition"

			Case "5"
				sMess = "Le travail est en attente de validation"
			
			End Choose

			stMessage.bErreurG	= True
			stMessage.sVar[1]		= sTrvMajParLu
			stMessage.sVar[2]		= sMess
			stMessage.sTitre		= "- WorkFlow - "
			stMessage.Icon			= Exclamation!
			stMessage.sCode 		= "ANCE041"

			f_Message ( stMessage )

			Return ( False )

	End If

/*------------------------------------------------------------------*/
/* 3$$HEX1$$e900$$ENDHEX$$me Cas : Le travail affich$$HEX2$$e9002000$$ENDHEX$$a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$bloqu$$HEX2$$e9002000$$ENDHEX$$par qq'un d'autre ou  */
/* le travail a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$rebloqu$$HEX2$$e9002000$$ENDHEX$$par qq'un d'autre.                     */
/* On affiche un message $$HEX2$$e0002000$$ENDHEX$$l'utilisateur pour lui expliquer cela.   */
/* S'il choisit de ne pas prendre le travail, on ne fait rien.      */
/*------------------------------------------------------------------*/

	If	( sAltBloc <> sAltBlocLu ) Or ( sAltBloc = "O" And sTrvMajParLu <> stGLB.sCodOper ) Then

			stMessage.bErreurG	= True
			stMessage.sVar[1]		= sTrvMajParLu
			stMessage.sTitre		= "- WorkFlow - "
			stMessage.Bouton		= YesNo!
			stMessage.Icon			= Question!
			stMessage.sCode 		= "ANCE042"

			If	f_Message ( stMessage ) = 2 Then Return ( False )

	End If


/*------------------------------------------------------------------*/
/* Maintenant, on va mettre $$HEX2$$e0002000$$ENDHEX$$jour les informations de W_QUEUE.     */
/*                                                                  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Si on est en saisie ou en validation (COD_ETAT=1) (COD_ETAT=5)   */
/* 	On positionne 	TRV_MAJ_LE 		= Maintenant                    */
/* 						TRV_MAJ_PAR 	= stGLB.sCodOper                */
/* 						ALT_OCCUPE		= Oui                           */
/* 						                                               */
/* 	On ne touche pas $$HEX2$$e0002000$$ENDHEX$$DOS_MAJ_LE et DOS_MAJ_PAR                  */
/* 	On ne touche pas $$HEX2$$e0002000$$ENDHEX$$TRV_EDITE_LE et TRV_EDITE_PAR              */
/*------------------------------------------------------------------*/

	If	sCodEtat = "1" Or sCodEtat = "5" Then
		dtMaintenant	= DateTime ( Today(), Now() )
		Choose Case isMoteur
		Case "GUP"

			sMaintenant 	= "'" + String ( dtMaintenant, "yyyy-mm-dd hh:mm:ss.ff" ) + "'"

         // ... Cas sp$$HEX1$$e900$$ENDHEX$$cifique pour savane : M$$HEX1$$ea00$$ENDHEX$$me en SQLSERVER on continue d'utiliser
         //     les commandes de GUPTA

		// [MIGPB11] [EMD] : Debut Migration : support du DBMS SNC
         //If Left ( Upper ( itrTrans.DBMS ), 3 ) = "MSS" Then
		//If Left ( Upper ( itrTrans.DBMS ), 3 ) = "MSS" or Left ( Upper ( itrTrans.DBMS ), 3 ) = "SNC" Then
		If Left ( Upper ( itrTrans.DBMS ), 3 ) <> "GUP" Then // [PI056]
		// [MIGPB11] [EMD] : Fin Migration
                                                          
				sMaintenant 	= "'" + String ( dtMaintenant, "dd/mm/yyyy hh:mm:ss.ff" ) + "'"

            sIdSin  = "'" + sIdSin  + "'"  // ... Formattage pour SqlServer
            sIdCorb = "'" + sIdCorb + "'"  // ... Formattage pour SqlServer
 
         End If

			sSql = "EXECUTE sysadm.w_as_queue_u1 "

         

		Case "MSS"

			sMaintenant 	= "'" + String ( dtMaintenant, "dd/mm/yyyy hh:mm:ss.ff" ) + "'"
			sIdSin			= "'" + sIdSin + "'"
			sIdCorb			= "'" + sIdCorb + "'"
			sSql = "EXECUTE sysadm.IM_U01_W_QUEUE "

		End Choose

/*------------------------------------------------------------------*/
/* Le 05/05/1998                                                    */
/* Il y a un probl$$HEX1$$e800$$ENDHEX$$me avec MSS. Si le code op$$HEX1$$e900$$ENDHEX$$rateur correspond $$HEX4$$e000200020002000$$ENDHEX$$*/
/* un mot r$$HEX1$$e900$$ENDHEX$$serv$$HEX2$$e9002000$$ENDHEX$$(OF, IS), le moteur ne parvient pas $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$coder le  */
/* SELECT. Je positionne donc tous les codes op$$HEX1$$e900$$ENDHEX$$rateurs avec des    */
/* quotes.                                                          */
/*------------------------------------------------------------------*/
		sCodOper = "'" + stGLB.sCodOper + "'"

		sSql = 	sSql 												+ &
					sMaintenant								+ "," + &
					sCodOper									+ "," + &
					sIdSin									+ "," + &
					sIdCorb

		If Not F_Execute ( sSql , itrTrans ) Then

/*------------------------------------------------------------------*/
/* Il y a une erreur de MAJ. Normalement, ce cas ne doit pas        */
/* arriver sauf erreur particuli$$HEX1$$e800$$ENDHEX$$re (R$$HEX1$$e900$$ENDHEX$$seau, Cable, Serveur)        */
/*------------------------------------------------------------------*/

			stMessage.bErreurG	= True
			stMessage.sVar[1]		= "de mise $$HEX2$$e0002000$$ENDHEX$$jour sur W_QUEUE"
			stMessage.sVar[2]		= itrTrans.SqlErrText
			stMessage.sTitre		= "- WorkFlow - "
			stMessage.Icon			= Exclamation!
			stMessage.sCode 		= "ANCE043"

/*------------------------------------------------------------------*/
/* Il faut faire le ROOLBACK apr$$HEX1$$e900$$ENDHEX$$s. Sinon la zone SqlErrText est    */
/* remise $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro                                                    */
/*------------------------------------------------------------------*/

//			ROLLBACK USING	itrTrans	;
			F_COMMIT ( itrTrans, FALSE) // [PI056][TRANCOUNT][JFF][24/01/2020]

			f_Message ( stMessage )

			Return ( False )
		
		ElseIf	itrTrans.SqlnRows = 0 Then

/*------------------------------------------------------------------*/
/* On ne trouve aucune ligne $$HEX2$$e0002000$$ENDHEX$$mettre $$HEX2$$e0002000$$ENDHEX$$jour. Deux cas sont         */
/* possibles.                                                       */
/* 1 - Le travail vient d'$$HEX1$$ea00$$ENDHEX$$tre pris pas quelqu'un en saisie donc    */
/* ALT_OCCUPE = OUI                                                 */
/* 2 - Le travail n'existe plus. Cas tr$$HEX1$$e900$$ENDHEX$$s improbable                */
/*------------------------------------------------------------------*/

//			ROLLBACK USING	itrTrans	;
			F_COMMIT ( itrTrans, FALSE) // [PI056][TRANCOUNT][JFF][24/01/2020]

			SELECT	sysadm.w_queue.trv_maj_par
			INTO		:sTrvMajParNouveau
			FROM		sysadm.w_queue
			WHERE		id_sin	= :sIdSin
			AND		id_corb	= :sIdCorb
			USING		itrTrans		;

			If	itrTrans.SqlnRows = 1 Then

				stMessage.bErreurG	= True
				stMessage.sVar[1]		= sTrvMajParNouveau
				stMessage.sTitre		= "- WorkFlow - "
				stMessage.Icon			= Information!
				stMessage.sCode 		= "ANCE044"

				f_Message ( stMessage )
				Return ( False )

			Else

				stMessage.bErreurG	= True
				stMessage.sVar[1]		= "Ce dossier"
				stMessage.sTitre		= "- WorkFlow - "
				stMessage.Icon			= Information!
				stMessage.sCode 		= "ANCE040"

				f_Message ( stMessage )
				Return ( False )

			End If

		Else

/*------------------------------------------------------------------*/
/* Sinon tout se passe bien, on valide la transaction et on met     */
/* les informations $$HEX2$$e0002000$$ENDHEX$$jour de mani$$HEX1$$e800$$ENDHEX$$re visuelle.                     */
/* ALT_OCCUPE	= OUI                                                */
/* TRV_MAJ_LE	= Maintenant                                         */
/* TRV_MAJ_PAR	= stGLB.ScodOper                                     */
/* DOS_MAJ_LE	= Maintenant                                         */
/* DOS_MAJ_PAR	= stGLB.ScodOper                                     */
/*------------------------------------------------------------------*/
//			COMMIT	USING itrTrans		;
			F_COMMIT ( itrTrans, TRUE ) // [PI056][TRANCOUNT][JFF][24/01/2020]

			dw_1.SetItem ( dw_1.ilLigneClick, "ALT_OCCUPE", "O" )

			dw_1.SetItem ( dw_1.ilLigneClick, "TRV_MAJ_LE", dtMaintenant )
			dw_1.SetItem ( dw_1.ilLigneClick, "TRV_MAJ_PAR", stGLB.sCodOper )

/*------------------------------------------------------------------*/
/* Le 07/06/1999. Modif DGA. Il faur garder en variable d'instance  */
/* DOS_MAJ_PAR, DOS_MAJ_LE. Ces valeurs seront utilis$$HEX1$$e900$$ENDHEX$$es dans le    */
/* cas d'un RETOUR (Choix 12/52) dans la fonction Wf_Choix_Gestion. */
/*------------------------------------------------------------------*/
			isDosMajPar	= dw_1.GetItemString ( dw_1.ilLigneClick, "DOS_MAJ_PAR" )
			idtDosMajLe	= dw_1.GetItemDateTime ( dw_1.ilLigneClick, "DOS_MAJ_LE" )

			dw_1.SetItem ( dw_1.ilLigneClick, "DOS_MAJ_LE", dtMaintenant )
			dw_1.SetItem ( dw_1.ilLigneClick, "DOS_MAJ_PAR", stGLB.sCodOper )

		End If
	End If

End If

Return ( True )


end function

public function string wf_str2dt (string asdatetime);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Workflow::Wf_Str2Dt ( Private )
//* Auteur			: Erick John Stark
//* Date				: 30/05/1997 17:46:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Transforme une cha$$HEX1$$ee00$$ENDHEX$$ne au format DT en une autre cha$$HEX1$$ee00$$ENDHEX$$ne dans un autre format DT
//*
//* Arguments		: String			asDateTime			(Val)	Valeur de la date $$HEX2$$e0002000$$ENDHEX$$convertir
//*
//* Retourne		: String
//*
//*-----------------------------------------------------------------

String sRet
Date dDte
Time tTime

/*------------------------------------------------------------------*/
/* On part du principe que la date est au format "JJ/MM/YYYY        */
/* hh:mm:ss.ff"                                                     */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On la transforme au format YYYY-MM-DD HH:MM:SS.FF                */
/*------------------------------------------------------------------*/

Choose Case isMoteur
Case "GUP"
	If	IsNull ( asDateTime ) Or asDateTime = "" Then
		sRet = "''"
	Else
		dDte	= Date ( Left ( asDateTime, 10 ) ) 
		tTime	= Time ( Right ( asDateTime, 11 ) )

		sRet = "'" + String ( DateTime ( dDte, tTime ), "yyyy-mm-dd hh:mm:ss.ff" ) + "'"

		// ... Pour SAVANE en SQLSERVER on utilise les noms de commandes de GUPTA mais
      //     on formate pour SqlServer

	// [MIGPB11] [EMD] : Debut Migration : support du DBMS SNC
	//If Upper ( Left ( itrtrans.DBMS, 3 ) ) = "MSS" Then
	//If Upper ( Left ( itrtrans.DBMS, 3 ) ) = "MSS" or Upper ( Left ( itrtrans.DBMS, 3 ) ) = "SNC" Then
	If Left ( Upper ( itrTrans.DBMS ), 3 ) <> "GUP" Then // [PI056]
	// [MIGPB11] [EMD] : Fin Migration
  			sRet = "'" + String ( DateTime ( dDte, tTime ), "dd/mm/yyyy hh:mm:ss.ff" ) + "'"
      End If
	
	End If

Case "MSS"
	If	IsNull ( asDateTime ) Or asDateTime = "" Then
		sRet = "null"
	Else
		dDte	= Date ( Left ( asDateTime, 10 ) ) 
		tTime	= Time ( Right ( asDateTime, 11 ) )

		sRet = "'" + String ( DateTime ( dDte, tTime ), "dd/mm/yyyy hh:mm:ss.ff" ) + "'"
	End If

End Choose

Return ( sRet )


end function

public function datetime wf_dt2dt (string asdatetime);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Workflow::Wf_Dt2Dt ( Private )
//* Auteur			: Erick John Stark
//* Date				: 30/05/1997 17:46:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Transforme une Chaine au format DT en une DateTime
//*
//* Arguments		: String			asDateTime			(Val)	Valeur de la date $$HEX2$$e0002000$$ENDHEX$$convertir
//*
//* Retourne		: DateTime
//*
//*-----------------------------------------------------------------

DateTime dtRet
Date dDte
Time tTime

/*------------------------------------------------------------------*/
/* On part du principe que la date est au format "JJ/MM/YYYY        */
/* hh:mm:ss.ff"                                                     */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On la transforme au format DateTime                              */
/*------------------------------------------------------------------*/

dDte	= Date ( Left ( asDateTime, 10 ) ) 
tTime	= Time ( Right ( asDateTime, 11 ) )

dtRet = DateTime ( dDte, tTime )

Return ( dtRet )


end function

protected subroutine wf_trttrace (ref string asval[]);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Workflow::Wf_TrtTrace ( Protected )
//* Auteur			: Erick John Stark
//* Date				: 19/01/1997 17:17:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Traitement sp$$HEX1$$e900$$ENDHEX$$cifique pour les valeurs de la trace
//*
//* Arguments		: String			asVal[]			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau des valeurs $$HEX2$$e0002000$$ENDHEX$$traiter
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Il est possible d'ajouter des lignes au tableau                  */
/*------------------------------------------------------------------*/


end subroutine

private subroutine wf_choixgestion (string asval[]);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Workflow::Wf_ChoixGestion ( Private )
//* Auteur			: Erick John Stark
//* Date				: 19/01/1997 17:17:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Traitement de gestion pour le WorkFlow
//*
//* Arguments		: String			asVal[]			(Val)	Tableau des valeurs $$HEX2$$e0002000$$ENDHEX$$traiter
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* N$$HEX2$$b0002000$$ENDHEX$$Modif          Re$$HEX1$$e700$$ENDHEX$$ue Le          Effectu$$HEX1$$e900$$ENDHEX$$e Le          PAR
//*
//* 001					05/08/1997				05/08/1997				DGA	
//* #1 DBI le 30/08/1999 DCMP 990391 : Gestion des motifs de routage
//		01/03/2017	FPI	[ITSM447855] d$$HEX1$$e900$$ENDHEX$$sactivation du message ANCE043
//*-----------------------------------------------------------------


String sChoix, sSql, sLigne
String sTrace[ 7 ]

Boolean bSupprimeTravail	= False
Boolean bMajTravail 			= False
Boolean bCasserTravail 		= False
Boolean bDebloquerEdition	= False
Boolean bTraceMotifRoutage	= False

Long lTot

/*------------------------------------------------------------------*/
/* Une partie des valeurs de la trace est initialis$$HEX1$$e900$$ENDHEX$$e ici. Cela     */
/* correspond aux valeurs de d$$HEX1$$e900$$ENDHEX$$part.                                */
/*------------------------------------------------------------------*/

sTrace[ 1 ]	= dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" )																// ID_CORB
sTrace[ 2 ]	= dw_1.GetItemString ( dw_1.ilLigneClick, "NOM" )																	// NOM
sTrace[ 3 ]	= dw_1.GetItemString ( dw_1.ilLigneClick, "COD_ETAT" )															//	COD_ETAT
sTrace[ 4 ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_MAJ_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )		// TRV_MAJ_LE (D$$HEX1$$e900$$ENDHEX$$part)
sTrace[ 5 ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_CREE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )	// TRV_CREE_LE
sTrace[ 6 ] = ""																																// TRV_EDITE_LE
sTrace[ 7 ] = ""																																// TRV_EDITE_PAR

dw_WorkFlow.Reset ()
dw_WorkFlow.InsertRow ( 0 )

sChoix = asVal[ iiNumCol [ 4 ] ] + asVal[ iiNumCol [ 5 ] ]

/*------------------------------------------------------------------*/
/* 	10	-> Saisie				Erreur Application Gestion            */
/* 	11	-> Saisie				CTL+VAL                               */
/* 	12	-> Saisie				Retour                                */
/* 	13	-> Saisie				Routage                               */
/* 	14	-> Saisie				CTL+VAL (Blocage du dossier)          */
/* 	15	-> Saisie				CTL+VAL (pas d'$$HEX1$$e900$$ENDHEX$$dition)               */
/*                                                                  */
/* 	30	-> Edition				Erreur Application Gestion            */
/* 	31	-> Edition				Edition                               */
/* 	32	-> Edition				R$$HEX2$$e900e900$$ENDHEX$$dition                             */
/*                                                                  */
/* 	50	-> Validation			Erreur Application Gestion            */
/* 	51	-> Validation			VAL                                   */
/* 	52	-> Validation			Retour                                */
/* 	53	-> Validation			Routage                               */
/*------------------------------------------------------------------*/

Choose Case sChoix
Case "10"

	dw_WorkFlow.SetItem ( 1, "sIdSin", 			asVal[ iiNumCol [  1 ] ] )
	dw_WorkFlow.SetItem ( 1, "sIdCorbAvt", 	asVal[ iiNumCol [  2 ] ] )
	dw_WorkFlow.SetItem ( 1, "sIdCorbApr",		asVal[ iiNumCol [  2 ] ] )
	dw_WorkFlow.SetItem ( 1, "sNom",				asVal[ iiNumCol [  3 ] ] ) 
	dw_WorkFlow.SetItem ( 1, "sCodEtat",		asVal[ iiNumCol [  4 ] ] )
	dw_WorkFlow.SetItem ( 1, "sCodAction",		asVal[ iiNumCol [  5 ] ] )
	dw_WorkFlow.SetItem ( 1, "sAltBloc",		asVal[ iiNumCol [  7 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTxtMess1",		asVal[ iiNumCol [ 17 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvMajLe",		asVal[ iiNumCol [  9 ] ] )

	asVal[ iiNumCol[ 09 ] ] = String ( DateTime ( Today(), Now() ), "dd/mm/yyyy hh:mm:ss" )
/*----------------------------------------------------------------------------*/
/* On laisse la valeur actuelle pour la mise $$HEX2$$e0002000$$ENDHEX$$jour sur le moteur, par        */
/* contre on postionne l'instant pr$$HEX1$$e900$$ENDHEX$$cis du d$$HEX1$$e900$$ENDHEX$$blocage.                         */
/*----------------------------------------------------------------------------*/
	dw_WorkFlow.SetItem ( 1, "sTrvMajPar",		asVal[ iiNumCol [ 10 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvRouteLe",	asVal[ iiNumCol [ 11 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvRoutePar",	asVal[ iiNumCol [ 12 ] ] )
	
	dw_WorkFlow.SetItem ( 1, "sDosMajLe",		asVal[ iiNumCol [ 15 ] ] )
	dw_WorkFlow.SetItem ( 1, "sDosMajPar",		asVal[ iiNumCol [ 16 ] ] )

	bSupprimeTravail	= True
	bMajTravail			= False
	bCasserTravail		= False

Case "11"
	dw_WorkFlow.SetItem ( 1, "sIdSin", 			dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" 	) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbAvt", 	dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" 	) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbApr",		asVal[ iiNumCol [  2 ] ] )
	dw_WorkFlow.SetItem ( 1, "sNom",				asVal[ iiNumCol [  3 ] ] )

	dw_WorkFlow.SetItem ( 1, "sCodEtat",		"3" )
	dw_WorkFlow.SetItem ( 1, "sCodAction",		"1" )
	dw_WorkFlow.SetItem ( 1, "sAltBloc",		"N" )
	dw_WorkFlow.SetItem ( 1, "sTxtMess1",		asVal[ iiNumCol [ 17 ] ] )

	dw_WorkFlow.SetItem ( 1, "sTrvMajLe",		asVal[ iiNumCol [  9 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvMajPar",		stGLB.sCodOper )

	dw_WorkFlow.SetItem ( 1, "sDosMajLe",		asVal[ iiNumCol [  9 ] ] )
	dw_WorkFlow.SetItem ( 1, "sDosMajPar",		stGLB.sCodOper )

	If	stGLB.bSaiValEdt	Then
		dw_WorkFlow.SetItem ( 1, "sCodEtat",		"5" )
	End If

	bSupprimeTravail	= True
	bMajTravail			= False
	bCasserTravail		= False

Case "12"
	dw_WorkFlow.SetItem ( 1, "sIdSin", 			dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" 		) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbAvt", 	dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" 		) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbApr", 	dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" 		) )
	dw_WorkFlow.SetItem ( 1, "sNom",				dw_1.GetItemString ( dw_1.ilLigneClick, "NOM" 			) )

	dw_WorkFlow.SetItem ( 1, "sCodEtat",		"1" )
	dw_WorkFlow.SetItem ( 1, "sCodAction",		"2" )
	dw_WorkFlow.SetItem ( 1, "sAltBloc",		dw_1.GetItemString ( dw_1.ilLigneClick, "ALT_BLOC" 	) )
	dw_WorkFlow.SetItem ( 1, "sTxtMess1",		dw_1.GetItemString ( dw_1.ilLigneClick, "TXT_MESS1" 	) )

	dw_WorkFlow.SetItem ( 1, "sTrvMajLe",		asVal[ iiNumCol [  9 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvMajPar",		stGLB.sCodOper )

	dw_WorkFlow.SetItem ( 1, "sTrvRouteLe",	String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_ROUTE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" ) )
	dw_WorkFlow.SetItem ( 1, "sTrvRoutePar",	dw_1.GetItemString ( dw_1.ilLigneClick, "TRV_ROUTE_PAR" ) )

/*------------------------------------------------------------------*/
/* Le 07/06/1999. Modif DGA.                                        */
/* Pour DOS_MAJ_LE, DOS_MAJ_PAR, on positionne les valeurs          */
/* initiales.                                                       */
/*------------------------------------------------------------------*/
	dw_WorkFlow.SetItem ( 1, "sDosMajLe",		String ( idtDosMajLe, "dd/mm/yyyy hh:mm:ss.ff" ) )
	dw_WorkFlow.SetItem ( 1, "sDosMajPar",		isDosMajPar )

	bSupprimeTravail	= False
	bMajTravail			= True
	bCasserTravail		= False

Case "13"
	dw_WorkFlow.SetItem ( 1, "sIdSin", 			dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" 		) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbAvt", 	dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" 		) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbApr", 	asVal[ iiNumCol [ 2 ] ] )
	dw_WorkFlow.SetItem ( 1, "sNom",				dw_1.GetItemString ( dw_1.ilLigneClick, "NOM" 			) )

	dw_WorkFlow.SetItem ( 1, "sCodEtat",		"1" )
	dw_WorkFlow.SetItem ( 1, "sCodAction",		"3" )
	dw_WorkFlow.SetItem ( 1, "sAltBloc",		dw_1.GetItemString ( dw_1.ilLigneClick, "ALT_BLOC" 	) )
	dw_WorkFlow.SetItem ( 1, "sTxtMess1",		asVal[ iiNumCol [ 17 ] ] )

	dw_WorkFlow.SetItem ( 1, "sTrvMajLe",		asVal[ iiNumCol [  9 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvMajPar",		stGLB.sCodOper )

	dw_WorkFlow.SetItem ( 1, "sTrvRouteLe",	asVal[ iiNumCol [ 11 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvRoutePar",	stGLB.sCodOper )

/*------------------------------------------------------------------*/
/* On se sert de la zone DOS_MAJ_PAR pour avoir le nom de           */
/* l'op$$HEX1$$e900$$ENDHEX$$rateur qui a trait$$HEX2$$e9002000$$ENDHEX$$le dossier en dernier.                  */
/* La zone ROUTE_PAR est ensuite forc$$HEX1$$e900$$ENDHEX$$e a stGLB.sCodOper.           */
/* La zone DOS_MAJ_PAR est positionn$$HEX1$$e900$$ENDHEX$$e avec le nom de l'op$$HEX1$$e900$$ENDHEX$$rateur   */
/* $$HEX2$$e0002000$$ENDHEX$$qui l'on route le dossier. Cet op$$HEX1$$e900$$ENDHEX$$rateur ne correspond pas     */
/* forc$$HEX1$$e900$$ENDHEX$$ment $$HEX2$$e0002000$$ENDHEX$$celui qui a trait$$HEX2$$e9002000$$ENDHEX$$le dossier en dernier. Or cette   */
/* information est importante.                                      */
/*------------------------------------------------------------------*/

	dw_WorkFlow.SetItem ( 1, "sDosMajLe",		asVal[ iiNumCol [ 15 ] ] )
	dw_WorkFlow.SetItem ( 1, "sDosMajPar",		asVal[ iiNumCol [ 12 ] ] )

	bSupprimeTravail	= False
	bMajTravail			= True
	bCasserTravail		= False

Case "14"
	dw_WorkFlow.SetItem ( 1, "sIdSin", 			dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" 		) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbAvt", 	dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" 		) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbApr", 	asVal[ iiNumCol [ 2 ] ] )
	dw_WorkFlow.SetItem ( 1, "sNom",				asVal[ iiNumCol [ 3 ] ] )

	dw_WorkFlow.SetItem ( 1, "sCodEtat",		"1" )
	dw_WorkFlow.SetItem ( 1, "sCodAction",		"4" )
	dw_WorkFlow.SetItem ( 1, "sAltBloc",		"O" )
	dw_WorkFlow.SetItem ( 1, "sTxtMess1",		asVal[ iiNumCol [ 17 ] ] )

	dw_WorkFlow.SetItem ( 1, "sTrvMajLe",		asVal[ iiNumCol [  9 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvMajPar",		stGLB.sCodOper )

	dw_WorkFlow.SetItem ( 1, "sDosMajLe",		asVal[ iiNumCol [  9 ] ] )
	dw_WorkFlow.SetItem ( 1, "sDosMajPar",		stGLB.sCodOper )

	bSupprimeTravail	= False
	bMajTravail			= True
	bCasserTravail		= False

Case "15"
	dw_WorkFlow.SetItem ( 1, "sIdSin", 			dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" 		) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbAvt", 	dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" 		) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbApr", 	asVal[ iiNumCol [  2 ] ] )
	dw_WorkFlow.SetItem ( 1, "sNom",				asVal[ iiNumCol [  3 ] ] )

	dw_WorkFlow.SetItem ( 1, "sCodEtat",		"5" )
	dw_WorkFlow.SetItem ( 1, "sCodAction",		"1" )
	dw_WorkFlow.SetItem ( 1, "sAltBloc",		"N" )
	dw_WorkFlow.SetItem ( 1, "sTxtMess1",		asVal[ iiNumCol [ 17 ] ] )

	dw_WorkFlow.SetItem ( 1, "sTrvMajLe",		asVal[ iiNumCol [  9 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvMajPar",		stGLB.sCodOper )

	dw_WorkFlow.SetItem ( 1, "sDosMajLe",		asVal[ iiNumCol [  9 ] ] )
	dw_WorkFlow.SetItem ( 1, "sDosMajPar",		stGLB.sCodOper )

	bSupprimeTravail	= True
	bMajTravail			= False
	bCasserTravail		= False

Case "30"
	dw_WorkFlow.SetItem ( 1, "sIdSin", 			asVal[ iiNumCol [  1 ] ] )
	dw_WorkFlow.SetItem ( 1, "sIdCorbAvt", 	asVal[ iiNumCol [  2 ] ] )

	asVal[ iiNumCol[ 9 ] ] = String ( DateTime ( Today(), Now() ), "dd/mm/yyyy hh:mm:ss" )
/*----------------------------------------------------------------------------*/
/* On laisse la valeur actuelle pour la mise $$HEX2$$e0002000$$ENDHEX$$jour sur le moteur, par        */
/* contre on positionne l'instant pr$$HEX1$$e900$$ENDHEX$$cis du d$$HEX1$$e900$$ENDHEX$$blocage.                        */
/*----------------------------------------------------------------------------*/

	bSupprimeTravail	= True
	bDebloquerEdition	= True
	bMajTravail			= False
	bCasserTravail		= False

Case "50"
	dw_WorkFlow.SetItem ( 1, "sIdSin", 			asVal[ iiNumCol [  1 ] ] )
	dw_WorkFlow.SetItem ( 1, "sIdCorbAvt", 	asVal[ iiNumCol [  2 ] ] )
	dw_WorkFlow.SetItem ( 1, "sIdCorbApr", 	asVal[ iiNumCol [  2 ] ] )
	dw_WorkFlow.SetItem ( 1, "sNom",				asVal[ iiNumCol [  3 ] ] )

	dw_WorkFlow.SetItem ( 1, "sCodEtat",		asVal[ iiNumCol [  4 ] ] )
	dw_WorkFlow.SetItem ( 1, "sCodAction",		asVal[ iiNumCol [  5 ] ] )
	dw_WorkFlow.SetItem ( 1, "sAltBloc",		asVal[ iiNumCol [  7 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTxtMess1",		asVal[ iiNumCol [ 17 ] ] )

	dw_WorkFlow.SetItem ( 1, "sTrvMajLe",		asVal[ iiNumCol [  9 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvMajPar",		asVal[ iiNumCol [ 10 ] ] )

/*----------------------------------------------------------------------------*/
/* On laisse la valeur actuelle pour la mise $$HEX2$$e0002000$$ENDHEX$$jour sur le moteur, par        */
/* contre on postionne l'instant pr$$HEX1$$e900$$ENDHEX$$cis du d$$HEX1$$e900$$ENDHEX$$blocage.                         */
/*----------------------------------------------------------------------------*/
	asVal[ iiNumCol[ 9 ] ] = String ( DateTime ( Today(), Now() ), "dd/mm/yyyy hh:mm:ss" )

	dw_WorkFlow.SetItem ( 1, "sTrvRouteLe",	asVal[ iiNumCol [ 11 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvRoutePar",	asVal[ iiNumCol [ 12 ] ] )

	dw_WorkFlow.SetItem ( 1, "sTrvEditeLe",	asVal[ iiNumCol [ 13 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvEditePar",	asVal[ iiNumCol [ 14 ] ] )

	sTrace[ 6 ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_EDITE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )
	sTrace[ 7 ] = dw_WorkFlow.GetItemString ( 1, "sTrvEditePar" )

	If IsNull ( sTrace[ 7 ] ) Then sTrace[ 7 ] = "''"

	dw_WorkFlow.SetItem ( 1, "sDosMajLe",		asVal[ iiNumCol [ 15 ] ] )
	dw_WorkFlow.SetItem ( 1, "sDosMajPar",		asVal[ iiNumCol [ 16 ] ] )

	bSupprimeTravail	= True
	bMajTravail			= False
	bCasserTravail		= False

Case "51"
	dw_WorkFlow.SetItem ( 1, "sIdSin", 			dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" ) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbAvt", 	dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" ) )

	sTrace[ 6 ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_EDITE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )
	sTrace[ 7 ] = dw_1.GetItemString ( dw_1.ilLigneClick, "TRV_EDITE_PAR" )

	bSupprimeTravail	= True
	bMajTravail			= False
	bCasserTravail		= True

Case "52"
	dw_WorkFlow.SetItem ( 1, "sIdSin", 			dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" 		) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbAvt", 	dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" 		) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbApr", 	dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" 		) )
	dw_WorkFlow.SetItem ( 1, "sNom",				dw_1.GetItemString ( dw_1.ilLigneClick, "NOM" 			) )

	dw_WorkFlow.SetItem ( 1, "sCodEtat",		"5" )
	dw_WorkFlow.SetItem ( 1, "sCodAction",		"2" )
	dw_WorkFlow.SetItem ( 1, "sAltBloc",		"N" )
	dw_WorkFlow.SetItem ( 1, "sTxtMess1",		dw_1.GetItemString ( dw_1.ilLigneClick, "TXT_MESS1" 	) )

	dw_WorkFlow.SetItem ( 1, "sTrvMajLe",		asVal[ iiNumCol [  9 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvMajPar",		stGLB.sCodOper )

	dw_WorkFlow.SetItem ( 1, "sTrvRouteLe",	String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_ROUTE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" ) )
	dw_WorkFlow.SetItem ( 1, "sTrvRoutePar",	dw_1.GetItemString ( dw_1.ilLigneClick, "TRV_ROUTE_PAR" ) )
	
	dw_WorkFlow.SetItem ( 1, "sTrvEditeLe",	String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_EDITE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" ) )
	dw_WorkFlow.SetItem ( 1, "sTrvEditePar",	dw_1.GetItemString ( dw_1.ilLigneClick, "TRV_EDITE_PAR" ) )

	sTrace[ 6 ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_EDITE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )
	sTrace[ 7 ] = dw_1.GetItemString ( dw_1.ilLigneClick, "TRV_EDITE_PAR" )

/*------------------------------------------------------------------*/
/* Le 07/06/1999. Modif DGA.                                        */
/* Pour DOS_MAJ_LE, DOS_MAJ_PAR, on positionne les valeurs          */
/* initiales.                                                       */
/*------------------------------------------------------------------*/
	dw_WorkFlow.SetItem ( 1, "sDosMajLe",		String ( idtDosMajLe, "dd/mm/yyyy hh:mm:ss.ff" ) )
	dw_WorkFlow.SetItem ( 1, "sDosMajPar",		isDosMajPar )

/*------------------------------------------------------------------*/
/* Le 05/08/1997 MOD_000                                            */
/* Si le dossier vient directement de la saisie	'TRV_EDITE_PAR'     */
/* peut $$HEX1$$ea00$$ENDHEX$$te $$HEX2$$e0002000$$ENDHEX$$NULL et donc faire sauter la commande pr$$HEX1$$e900$$ENDHEX$$compil$$HEX1$$e900$$ENDHEX$$e.    */
/*------------------------------------------------------------------*/

	asVal[ iiNumCol [ 11 ] ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_ROUTE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )
	asVal[ iiNumCol [ 12 ] ] = dw_1.GetItemString ( dw_1.ilLigneClick, "TRV_ROUTE_PAR" )

	asVal[ iiNumCol [ 13 ] ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_EDITE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )
	asVal[ iiNumCol [ 14 ] ] = dw_1.GetItemString ( dw_1.ilLigneClick, "TRV_EDITE_PAR" )

	bSupprimeTravail	= False
	bMajTravail			= True
	bCasserTravail		= False

Case "53"
	dw_WorkFlow.SetItem ( 1, "sIdSin", 			dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" 		) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbAvt", 	dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" 		) )
	dw_WorkFlow.SetItem ( 1, "sIdCorbApr", 	asVal[ iiNumCol [ 2 ] ] )
	dw_WorkFlow.SetItem ( 1, "sNom",				dw_1.GetItemString ( dw_1.ilLigneClick, "NOM" 			) )

	dw_WorkFlow.SetItem ( 1, "sCodEtat",		"1" )
	dw_WorkFlow.SetItem ( 1, "sCodAction",		"1" )
	dw_WorkFlow.SetItem ( 1, "sAltBloc",		"N" )
	dw_WorkFlow.SetItem ( 1, "sTxtMess1",		asVal[ iiNumCol [ 17 ] ] )

	dw_WorkFlow.SetItem ( 1, "sTrvMajLe",		asVal[ iiNumCol [  9 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvMajPar",		stGLB.sCodOper )

	dw_WorkFlow.SetItem ( 1, "sTrvRouteLe",	asVal[ iiNumCol [ 11 ] ] )
	dw_WorkFlow.SetItem ( 1, "sTrvRoutePar",	stGLB.sCodOper )

	sTrace[ 6 ]	= String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_EDITE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )
	sTrace[ 7 ] = dw_1.GetItemString ( dw_1.ilLigneClick, "TRV_EDITE_PAR" )

	dw_WorkFlow.SetItem ( 1, "sDosMajLe",		asVal[ iiNumCol [ 15 ] ] )
	dw_WorkFlow.SetItem ( 1, "sDosMajPar",		asVal[ iiNumCol [ 12 ] ] )

	bSupprimeTravail	= True
	bMajTravail			= False
	bCasserTravail		= False
	bTraceMotifRoutage= True

End Choose

Wf_Trt_DwWork ()

If	bCasserTravail Then
	sSql = Wf_Executer_Sql ( 1 )
Else
	If	bDebloquerEdition Then
		sSql = Wf_Executer_Sql ( 2 )
	Else
		sSql = Wf_Executer_Sql ( 3 )
	End If
End If

F_Execute ( sSql , itrTrans )

If	itrTrans.SqlnRows <> 1 Then

	stMessage.bErreurG	= True
	stMessage.sVar[1]		= "de mise $$HEX2$$e0002000$$ENDHEX$$jour sur W_QUEUE. Le travail " + asVal[ iiNumCol [ 1 ] ] + " reste bloqu$$HEX1$$e900$$ENDHEX$$."
	stMessage.sVar[2]		= itrTrans.SqlErrText
	stMessage.sTitre		= "- WorkFlow - "
	stMessage.Icon			= Exclamation!
	stMessage.sCode 		= "ANCE043"

//	ROLLBACK	USING	itrTrans		;
	F_COMMIT ( itrTrans, FALSE) // [PI056][TRANCOUNT][JFF][24/01/2020]

	// f_Message ( stMessage ) // [ITSM447855]
	
Else
//	COMMIT USING	itrTrans		;
	F_COMMIT ( itrTrans, TRUE ) // [PI056][TRANCOUNT][JFF][24/01/2020]

/*------------------------------------------------------------------*/
/* #1 : Modif dbi w_ecrire trace retourne chaine $$HEX1$$e900$$ENDHEX$$crite dans trace_w*/
/*------------------------------------------------------------------*/

	sLigne = Wf_EcrireTrace ( sTrace[], asVal[] )
	
	If bTraceMotifRoutage Then

		wf_TraceMotifRoutage ( sligne, iDwRoutage )
	End If

// #1
/*------------------------------------------------------------------*/
/* On supprime la ligne de dw_1. (Dans certains cas)                */
/*------------------------------------------------------------------*/

	If	bSupprimeTravail Then

		dw_1.DeleteRow ( dw_1.ilLigneClick )
		dw_1.SelectRow ( 0, False )
		dw_1.TriggerEvent ( "ue_Trier" )
		lTot	= dw_1.RowCount ()

/*------------------------------------------------------------------*/
/* On s$$HEX1$$e900$$ENDHEX$$lectionne la ligne suivante si possible. Sinon, on          */
/* s$$HEX1$$e900$$ENDHEX$$lectionne la premi$$HEX1$$e800$$ENDHEX$$re ligne, si elle existe.                   */
/*------------------------------------------------------------------*/

		If ( lTot > 0 And dw_1.ilLigneClick <= lTot ) Then

			dw_1.SetRow ( dw_1.ilLigneClick )
			dw_1.ScrollToRow ( dw_1.ilLigneClick )
			dw_1.SelectRow ( dw_1.ilLigneClick, True )

		ElseIf	lTot <> 0 Then
			dw_1.SetRow ( 1 )
			dw_1.ScrollToRow ( 1 )
			dw_1.SelectRow ( 1, True )
			dw_1.ilLigneClick = 1

		ElseIf	lTot = 0 Then
			mle_Msg1.Visible = False
		End If

/*------------------------------------------------------------------*/
/* On retaille la data window en hauteur.                           */
/*------------------------------------------------------------------*/

		This.TriggerEvent ( "ue_TaillerHauteur" )

	End If

/*------------------------------------------------------------------*/
/* On met la ligne $$HEX2$$e0002000$$ENDHEX$$jour dans dw_1. (Dans certains cas)            */
/*------------------------------------------------------------------*/

	If	bMajTravail Then
		dw_1.SetItem ( dw_1.ilLigneClick, "ALT_OCCUPE", "N" )

		dw_1.SetItem ( dw_1.ilLigneClick, "TRV_MAJ_LE", Wf_Dt2Dt ( asVal [ iiNumCol [ 9 ] ] ) )
		dw_1.SetItem ( dw_1.ilLigneClick, "TRV_MAJ_PAR", stGLB.sCodOper )

/*------------------------------------------------------------------*/
/* Le 07/06/1999. Modif DGA.                                        */
/* Pour DOS_MAJ_LE, DOS_MAJ_PAR, on positionne les valeurs          */
/* initiales.                                                       */
/*------------------------------------------------------------------*/
		dw_1.SetItem ( dw_1.ilLigneClick, "DOS_MAJ_LE",	idtDosMajLe )
		dw_1.SetItem ( dw_1.ilLigneClick, "DOS_MAJ_PAR", isDosMajPar )


		dw_1.SetItem ( dw_1.ilLigneClick, "ALT_BLOC", dw_WorkFlow.GetItemString ( 1, "sAltBloc" ) )

		dw_1.SetItem ( dw_1.ilLigneClick, "NOM", asVal [ iiNumCol [ 3  ] ] )

		dw_1.SetItem ( dw_1.ilLigneClick, "TXT_MESS1", asVal [ iiNumCol [ 17 ] ] )

/*------------------------------------------------------------------*/
/* Le 23/07/1997                                                    */
/* On rajoute la zone ROUTE_PAR, cette zone est n$$HEX1$$e900$$ENDHEX$$cessaire pour     */
/* l'affichage du BitMap                                            */
/*------------------------------------------------------------------*/
		If	sChoix = "13" Or sChoix = "53" Then
			dw_1.SetItem ( dw_1.ilLigneClick, "TRV_ROUTE_PAR", stGLB.sCodOper )
			dw_1.SetItem ( dw_1.ilLigneClick, "TRV_ROUTE_LE", Wf_Dt2Dt ( asVal [ iiNumCol [ 11 ] ] ) )
		End If

		Wf_AfficherMessage ( dw_1.ilLigneClick )

	End If

End If


end subroutine

private function string wf_getitem (datawindow adw, long allig, integer aicol);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Workflow::Wf_GetItem (Private)
//* Auteur			: Erick John Stark
//* Date				: 30/05/1997 17:46:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: GetItem en fonction du type de la colonne
//*
//* Arguments		: DataWindow	aDw					(Val)	Data Window source pour le GetItemX
//* 					  Long			alLig					(Val)	Num$$HEX1$$e900$$ENDHEX$$ro de la ligne
//* 					  Integer		aiCol					(Val)	Num$$HEX1$$e900$$ENDHEX$$ro de la colonne
//*
//* Retourne		: String		Valeur sous forme de cha$$HEX1$$ee00$$ENDHEX$$ne.
//*
//*-----------------------------------------------------------------

String sRet, sType

sType 	=  Left ( aDw.Describe ( "#" + String ( aiCol ) + ".coltype" ), 5 )

Choose Case sType

Case "char("

	sRet = aDw.GetItemString ( alLig, aiCol )

Case "decim", "numbe"

	sRet = String ( aDw.GetItemNumber ( alLig, aiCol ) )

Case "date"

	sRet = String ( aDw.GetItemDate ( alLig, aiCol ), "dd/mm/yyyy" )

Case "datet"

	sRet = String ( aDw.GetItemDateTime ( alLig, aiCol ), "dd/mm/yyyy hh:mm:ss.ff" )

Case "time"

	sRet = String ( aDw.GetItemTime ( alLig, aiCol ), "hh:mm:ss.ffffff" )

End Choose

If IsNull ( sRet ) Then 
	sRet = ""
End If

Return ( sRet )
end function

protected subroutine wf_init_dwlibre ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Workflow::Wf_Init_DwLibre ( Protected )
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 16:01:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de DW_Libre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//
//*-----------------------------------------------------------------

String sDataObject

/*------------------------------------------------------------------*/
/* Le type de moteur que l'on utilise est positionn$$HEX2$$e9002000$$ENDHEX$$dans la        */
/* fonction Wf_Recuperer_Corbeille.                                 */
/*------------------------------------------------------------------*/

sDataObject	= "d_Libre_WorkFlow_"

/*------------------------------------------------------------------*/
/* On assigne le DataObject en fonction du moteur.                  */
/*------------------------------------------------------------------*/

Choose Case isMoteur
Case "GUP"
	sDataObject = sDataObject + isMoteur
	
Case "MSS"
	sDataObject = sDataObject + isMoteur

End Choose

dw_Libre.DataObject = sDataObject
dw_Libre.SetTransObject ( itrTrans )

end subroutine

private subroutine wf_recuperer_corbeille ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Recuperer_Corbeille ( Private )
//* Auteur			: Erick John Stark
//* Date				: 01/10/1997 15:45:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des Corbeilles que l'op$$HEX1$$e900$$ENDHEX$$rateur peut utiliser.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sDataObject, sCorb, sSql

DataWindowChild		dwChild

Long lTotCorb, lCpt

/*------------------------------------------------------------------*/
/* La premi$$HEX1$$e800$$ENDHEX$$re chose $$HEX2$$e0002000$$ENDHEX$$faire est de d$$HEX1$$e900$$ENDHEX$$terminer le type de moteur    */
/* que l'on utilise.                                                */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On part du principe que la variable d'instance itrTrans de la    */
/* fen$$HEX1$$ea00$$ENDHEX$$tre est bien arm$$HEX1$$e900$$ENDHEX$$e.                                          */
/*------------------------------------------------------------------*/

isMoteur = Left ( Upper ( itrTrans.DBMS ), 3 )

// [MIGPB11] [EMD] : Debut Migration : modif de la variable isMoteur, si SNC on y met MSS
//If isMoteur = "SNC" Then
If isMoteur <> "GUP"  Then // [PI056]
	isMoteur = "MSS"	
End If
// [MIGPB11] [EMD] : Fin Migration

   /*-------------------------------------------------------------------*/
	/* Pour l'application SAVANE on continue d'utiliser les dataobjects  */
   /* de gupta : ces derniers ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$migr$$HEX1$$e900$$ENDHEX$$s pour fonctionner avec une  */
   /* base SqlServer                                                    */
   /*-------------------------------------------------------------------*/
	// [I027].BUG2 : Test fiable du code applif_IsApplication('savane')
	//If Left( stGlb.sCodAppli , 2 ) = 'SA' And isMoteur = "MSS" Then isMoteur = 'GUP'
	If f_IsApplication('savane') And isMoteur = "MSS" Then isMoteur = 'GUP'

   // ... Fin de modification

sDataObject	= "d_wkf_Corbeille_"

/*------------------------------------------------------------------*/
/* On assigne le DataObject en fonction du moteur.                  */
/*------------------------------------------------------------------*/

Choose Case isMoteur

 Case "GUP"
	sDataObject = sDataObject + isMoteur
	
Case "MSS"
	sDataObject = sDataObject + isMoteur

End Choose

dw_Corbeille.DataObject = sDataObject
dw_Corbeille.SetTransObject ( itrTrans )

If	isMoteur = "MSS" Then
	dw_Corbeille.GetChild ( "ID_CORB", dwChild )
	dwChild.SetTransObject ( This.itrTrans )
	dwChild.Retrieve ( "-CO" )	
End If
	
lTotCorb = dw_Corbeille.Retrieve ( stGLB.sCodOper )

If	lTotCorb <= 0 Then

/*------------------------------------------------------------------*/
/* Si l'op$$HEX1$$e900$$ENDHEX$$rateur ne poss$$HEX1$$e900$$ENDHEX$$de aucun acc$$HEX1$$e900$$ENDHEX$$s aux corbeilles, on         */
/* affiche un message que l'on trace.                               */
/*------------------------------------------------------------------*/

	stMessage.bErreurG	= True
	stMessage.bTrace		= True
	stMessage.sTitre		= "- WorkFlow - "
	stMessage.Icon			= Exclamation!
	stMessage.sCode 		= "ANCE048"

	f_Message ( stMessage )

/*------------------------------------------------------------------*/
/* On assigne une jointure impossible $$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$aliser. L'op$$HEX1$$e900$$ENDHEX$$rateur n'a   */
/* acc$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$rien.                                                    */
/*------------------------------------------------------------------*/

	sSql = "AND sysadm.w_queue.id_corb = 'XXX' "

Else
/*------------------------------------------------------------------*/
/* Sinon, on g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$re une chaine de jointure qui correspond aux       */
/* corbeilles disponibles.                                          */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On s'occupe des (n-1) premi$$HEX1$$e800$$ENDHEX$$res corbeilles.                      */
/*------------------------------------------------------------------*/

	For	lCpt = 1 To lTotCorb - 1
			Choose Case isMoteur
			Case "GUP"
				sCorb	= "'" + dw_Corbeille.GetItemString ( lCpt, "ID_CORB" ) + "', "
				sSql	= sSql + sCorb

			Case "MSS"
				sCorb	= "'" + String ( dw_Corbeille.GetItemNumber ( lCpt, "ID_CORB" ) ) + "', "
				sSql	= sSql + sCorb

			End Choose
	Next

/*------------------------------------------------------------------*/
/* On s'occupe de la derni$$HEX1$$e800$$ENDHEX$$re corbeille.                            */
/*------------------------------------------------------------------*/

	Choose Case isMoteur
	Case "GUP"
		sCorb	= "'" + dw_Corbeille.GetItemString ( lTotCorb, "ID_CORB" ) + "' ) "
		sSql	= sSql + sCorb

	Case "MSS"
		sCorb	= "'" + String ( dw_Corbeille.GetItemNumber ( lTotCorb, "ID_CORB" ) ) + "' ) "
		sSql	= sSql + sCorb

	End Choose

/*------------------------------------------------------------------*/
/* On g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$re la chaine finale.                                      */
/*------------------------------------------------------------------*/

	sSql = "AND sysadm.w_queue.id_corb IN ( " + sSql

End If

/*------------------------------------------------------------------*/
/* On assigne la cha$$HEX1$$ee00$$ENDHEX$$ne de jointure $$HEX2$$e0002000$$ENDHEX$$une variable d'instance. Le   */
/* script client devra utiliser cette variable dans                 */
/* dw_1.isJointure.                                                 */
/*------------------------------------------------------------------*/

isJointureCorbeille = sSql 

end subroutine

private subroutine wf_trt_dwwork ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Trt_DwWork (Private)
//* Auteur			: Erick John Stark
//* Date				: 20/11/1997 17:35:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------


String  sMoteur



// ... Modification pour SAVANE SQLSERVER
//     Utilisation des formats de SqlServer

sMoteur = isMoteur
// [MIGPB11] [EMD] : Debut Migration : support du DBMS SNC
//If Upper ( Left ( itrtrans.DBMS, 3 ) ) = "MSS" And isMoteur = "GUP" Then sMoteur = "MSS"
//If ( Upper ( Left ( itrtrans.DBMS, 3 ) ) = "MSS" or Upper ( Left ( itrtrans.DBMS, 3 ) ) = "SNC" ) &
// [PI056] Moteur MSS par d$$HEX1$$e900$$ENDHEX$$faut
If  Upper ( Left ( itrtrans.DBMS, 3 ) ) <> "GUP" & 
	And isMoteur = "GUP" Then &
		sMoteur = "MSS"
// [MIGPB11] [EMD] : Fin Migration

Choose Case sMoteur

Case "GUP"

	dw_WorkFlow.SetItem ( 1, "sNom", "'" + dw_WorkFlow.GetItemString ( 1, "sNom" ) + "'" )

	If	IsNull ( dw_WorkFlow.GetItemString ( 1, "sTxtMess1" ) ) Then
		dw_WorkFlow.SetItem ( 1, "sTxtMess1", "''" )
	Else
		dw_WorkFlow.SetItem ( 1, "sTxtMess1", "'" + dw_WorkFlow.GetItemString ( 1, "sTxtMess1" ) + "'" )	
	End If

	dw_WorkFlow.SetItem ( 1, "sTrvMajLe", Wf_Str2Dt ( dw_WorkFlow.GetItemString ( 1, "sTrvMajLe" ) ) )

	dw_WorkFlow.SetItem ( 1, "sDosMajLe", Wf_Str2Dt ( dw_WorkFlow.GetItemString ( 1, "sDosMajLe" ) ) )

//Routage
	dw_WorkFlow.SetItem ( 1, "sTrvRouteLe", Wf_Str2Dt ( dw_WorkFlow.GetItemString ( 1, "sTrvRouteLe" ) ) )
	If	IsNull ( dw_WorkFlow.GetItemString ( 1, "sTrvRoutePar" ) ) Then	dw_WorkFlow.SetItem ( 1, "sTrvRoutePar", "''" )

//Edition
	dw_WorkFlow.SetItem ( 1, "sTrvEditeLe", Wf_Str2Dt ( dw_WorkFlow.GetItemString ( 1, "sTrvEditeLe" ) ) )
	If	IsNull ( dw_WorkFlow.GetItemString ( 1, "sTrvEditePar" ) ) Then	dw_WorkFlow.SetItem ( 1, "sTrvEditePar", "''" )

Case "MSS"
/*------------------------------------------------------------------*/
/* Le 05/05/1998                                                    */
/* Il y a un probl$$HEX1$$e800$$ENDHEX$$me avec MSS. Si le code op$$HEX1$$e900$$ENDHEX$$rateur correspond $$HEX4$$e000200020002000$$ENDHEX$$*/
/* un mot r$$HEX1$$e900$$ENDHEX$$serv$$HEX2$$e9002000$$ENDHEX$$(OF, IS), le moteur ne parvient pas $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$coder le  */
/* SELECT. Je positionne donc tous les codes op$$HEX1$$e900$$ENDHEX$$rateurs avec des    */
/* quotes.                                                          */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le 29/09/1998                                                    */
/* On autorise maintenant la saisie des QUOTES (') pour les zones   */
/* NOM, PRENOM, TXT_MESS1. Il faut donc mettre des doubles QUOTES   */
/* (") pour bien formater la zone. Cette modification n'est         */
/* valable que pour SQL Server.                                     */
/*------------------------------------------------------------------*/
	dw_WorkFlow.SetItem ( 1, "sIdSin", 		"'" + dw_WorkFlow.GetItemString ( 1, "sIdSin" ) 		+ "'" )
	dw_WorkFlow.SetItem ( 1, "sIdCorbAvt", "'" + dw_WorkFlow.GetItemString ( 1, "sIdCorbAvt" )	+ "'" )
	dw_WorkFlow.SetItem ( 1, "sIdCorbApr", "'" + dw_WorkFlow.GetItemString ( 1, "sIdCorbApr" )	+ "'" )
	dw_WorkFlow.SetItem ( 1, "sCodEtat",	"'" + dw_WorkFlow.GetItemString ( 1, "sCodEtat" )		+ "'" )
	dw_WorkFlow.SetItem ( 1, "sCodAction", "'" + dw_WorkFlow.GetItemString ( 1, "sCodAction" )	+ "'" )

	dw_WorkFlow.SetItem ( 1, "sNom", "~"" + dw_WorkFlow.GetItemString ( 1, "sNom" ) + "~"" )

	If	IsNull ( dw_WorkFlow.GetItemString ( 1, "sTxtMess1" ) ) Then
		dw_WorkFlow.SetItem ( 1, "sTxtMess1", "null" )
	Else
		dw_WorkFlow.SetItem ( 1, "sTxtMess1", "~"" + dw_WorkFlow.GetItemString ( 1, "sTxtMess1" ) + "~"" )	
	End If

	dw_WorkFlow.SetItem ( 1, "sTrvMajPar", "'" + dw_WorkFlow.GetItemString ( 1, "sTrvMajPar" ) + "'" )
	dw_WorkFlow.SetItem ( 1, "sTrvMajLe", Wf_Str2Dt ( dw_WorkFlow.GetItemString ( 1, "sTrvMajLe" ) ) )

	dw_WorkFlow.SetItem ( 1, "sDosMajPar", "'" + dw_WorkFlow.GetItemString ( 1, "sDosMajPar" ) + "'" )
	dw_WorkFlow.SetItem ( 1, "sDosMajLe", Wf_Str2Dt ( dw_WorkFlow.GetItemString ( 1, "sDosMajLe" ) ) )

//Routage
	dw_WorkFlow.SetItem ( 1, "sTrvRouteLe", Wf_Str2Dt ( dw_WorkFlow.GetItemString ( 1, "sTrvRouteLe" ) ) )
	If	IsNull ( dw_WorkFlow.GetItemString ( 1, "sTrvRoutePar" ) ) Then	
		dw_WorkFlow.SetItem ( 1, "sTrvRoutePar", "null" )
	Else
		dw_WorkFlow.SetItem ( 1, "sTrvRoutePar", "'" + dw_WorkFlow.GetItemString ( 1, "sTrvRoutePar" ) + "'" )
	End If

//Edition
	dw_WorkFlow.SetItem ( 1, "sTrvEditeLe", Wf_Str2Dt ( dw_WorkFlow.GetItemString ( 1, "sTrvEditeLe" ) ) )
	If	IsNull ( dw_WorkFlow.GetItemString ( 1, "sTrvEditePar" ) ) Then	
		dw_WorkFlow.SetItem ( 1, "sTrvEditePar", "null" )
	Else
		dw_WorkFlow.SetItem ( 1, "sTrvEditePar", "'" + dw_WorkFlow.GetItemString ( 1, "sTrvEditePar" ) + "'" )
	End If

End Choose


end subroutine

private function string wf_executer_sql (integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Executer_Sql (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 03/12/1997 14:39:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ex$$HEX1$$e900$$ENDHEX$$cution d'une commande SQL en fonction du moteur
//*
//* Arguments		: Integer		aiType				(Val)	Commande $$HEX2$$e0002000$$ENDHEX$$lancer
//*
//* Retourne		: String			Chaine $$HEX2$$e0002000$$ENDHEX$$ex$$HEX1$$e900$$ENDHEX$$cuter
//*
//*-----------------------------------------------------------------

String	sSql
String	sIdSin, sDosMAJPar, sMajParWsin
Long		lIdSin
Int		iTrv

sSql = ""


Choose Case aiType
Case 1					// Ex$$HEX1$$e900$$ENDHEX$$cution pour suppression du travail
	Choose Case isMoteur
	Case "GUP"
		sSql = 	"EXECUTE sysadm.w_as_queue_d "
	Case "MSS"
		sSql = 	"EXECUTE sysadm.IM_D01_W_QUEUE "
	End Choose

	sSql =	sSql															+ &
				dw_WorkFlow.GetItemString ( 1, "sIdSin" 		)	+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sIdCorbAvt"	)


Case 2					// Ex$$HEX1$$e900$$ENDHEX$$cution pour d$$HEX1$$e900$$ENDHEX$$bloquer un travail en $$HEX1$$e900$$ENDHEX$$dition
	Choose Case isMoteur
	Case "GUP"
		sSql = 	"EXECUTE sysadm.w_as_queue_u3 "
	Case "MSS"
		sSql = 	"EXECUTE sysadm.IM_U03_W_QUEUE "
	End Choose

	sSql =	sSql 															+ &
				dw_WorkFlow.GetItemString ( 1, "sIdSin" 		)	+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sIdCorbAvt" 	)

Case 3					// Ex$$HEX1$$e900$$ENDHEX$$cution de la mise $$HEX2$$e0002000$$ENDHEX$$jour de W_QUEUE
	Choose Case isMoteur
	Case "GUP"
		sSql = 	"EXECUTE sysadm.w_as_queue_u2 "

		/*------------------------------------------------------------------*/
		/* LE 05/09/01 par JFF, un probl$$HEX1$$e800$$ENDHEX$$me r$$HEX1$$e900$$ENDHEX$$curant appara$$HEX1$$ee00$$ENDHEX$$t sur savane,   */
		/* le d$$HEX1$$e900$$ENDHEX$$blocage des dossiers est souvent impossible car             */
		/* DOS_MAJ_PAR est $$HEX2$$e0002000$$ENDHEX$$null, je place donc une correction afin que    */
		/* le d$$HEX1$$e900$$ENDHEX$$blocage puisse se faire.                                    */
		/*------------------------------------------------------------------*/
		sDosMajPar = dw_WorkFlow.GetItemString ( 1, "sDosMajPar"		) 
		If IsNull ( sDosMajPar ) Or sDosMajPar = "" Then

			sIdSin = dw_WorkFlow.GetItemString ( 1, "sIdSin" )

			iTrv = 0
			SELECT COUNT ( * ) INTO :iTrv FROM sysadm.w_queue WHERE id_sin = :sIdSin USING SQLCA ;

			If iTrv > 0 Then 

				lIdSin = Long ( sIdSin )
				SELECT maj_par INTO :sMajParWsin FROM sysadm.w_sin WHERE id_sin = :lIdSin USING SQLCA ;
				If IsNull ( sMajParWSin ) Or sMajParWsin = "" Then sMajParWSin = "CREE"

				dw_WorkFlow.SetItem ( 1, "sDosMajPar", Upper ( sMajParWSin ) )

				UPDATE w_queue	
				SET dos_maj_par = :sMajParWsin
				WHERE id_sin    = :sIdSin
				USING SQLCA ;

//				COMMIT USING SQLCA ;
				F_COMMIT ( SQLCA, TRUE ) // [PI056][TRANCOUNT][JFF][24/01/2020]

			End If
	
		End If

	Case "MSS"
		sSql = 	"EXECUTE sysadm.IM_U02_W_QUEUE "
	End Choose

	sSql =	sSql 																			+ &
				dw_WorkFlow.GetItemString ( 1, "sNom"				)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sIdCorbApr"		)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sCodEtat"			)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sCodAction"		)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sAltBloc"			)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sTxtMess1"		)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sTrvMajLe"		)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sTrvMajPar"		)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sTrvRouteLe"		)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sTrvRoutePar"	)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sDosMajLe"		)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sDosMajPar"		)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sTrvEditeLe"		)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sTrvEditePar"	)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sIdSin"			)		+ "," + &
				dw_WorkFlow.GetItemString ( 1, "sIdCorbAvt"		)


End Choose

Return ( sSql )
end function

private subroutine wf_gestionerreur ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_GestionErreur (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 01/07/1997 10:58:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$blocage des dossiers suite a une erreur
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1 FS  le 03/09/02 : Suite pb d$$HEX1$$e900$$ENDHEX$$blocage des dossiers : J'utilise
//*                      la fonction f_getitem2 pour bien interpr$$HEX1$$e900$$ENDHEX$$ter les
//*                      quotes
//* #2 FS  le 12/11/02 : Les guillemets posent pb
//* #3 JFF le 11/04/03 : F_GetItem2 ne r$$HEX1$$e900$$ENDHEX$$sout rien, je vire les caract$$HEX1$$e800$$ENDHEX$$re suivant ' "
//*-----------------------------------------------------------------
String sVal []
String sValQuote, sValFinale
Long	 lCpt1
Int	 iCpt, iPos
If	dw_1.RowCount () > 0 And dw_1.ilLigneClick > 0 Then

	sVal[ iiNumCol [  1 ] ] = dw_1.GetItemString ( dw_1.ilLigneClick, "ID_SIN" )
	sVal[ iiNumCol [  2 ] ] = dw_1.GetItemString ( dw_1.ilLigneClick, "ID_CORB" )
	sVal[ iiNumCol [  3 ] ] = dw_1.GetItemString ( dw_1.ilLigneClick, "NOM" )

	sVal[ iiNumCol [  4 ] ] = dw_1.GetItemString ( dw_1.ilLigneClick, "COD_ETAT" )

	sVal[ iiNumCol [  5 ] ] = "0"
	sVal[ iiNumCol [  6 ] ] = "N"
	sVal[ iiNumCol [  7 ] ] = dw_1.GetItemString ( dw_1.ilLigneClick, "ALT_BLOC" )

	sVal[ iiNumCol [  8 ] ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_CREE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )	
	sVal[ iiNumCol [  9 ] ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_MAJ_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )	
	sVal[ iiNumCol [ 10 ] ] = dw_1.GetItemString ( dw_1.ilLigneClick, "TRV_MAJ_PAR" )

	sVal[ iiNumCol [ 11 ] ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_ROUTE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )	
	sVal[ iiNumCol [ 12 ] ] = dw_1.GetItemString ( dw_1.ilLigneClick, "TRV_ROUTE_PAR" )

	sVal[ iiNumCol [ 13 ] ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "TRV_EDITE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )	
	sVal[ iiNumCol [ 14 ] ] = dw_1.GetItemString ( dw_1.ilLigneClick, "TRV_EDITE_PAR" )

	sVal[ iiNumCol [ 15 ] ] = String ( dw_1.GetItemDateTime ( dw_1.ilLigneClick, "DOS_MAJ_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )	
	sVal[ iiNumCol [ 16 ] ] = dw_1.GetItemString ( dw_1.ilLigneClick, "DOS_MAJ_PAR" )

//	sVal[ iiNumCol [ 17 ] ] = dw_1.GetItemString ( dw_1.ilLigneClick, "TXT_MESS1" )

	sVal[ iiNumCol [ 17 ] ] = f_getitem2 ( dw_1, dw_1.ilLigneClick, "TXT_MESS1" )  // ... #1

	/*------------------------------------------------------------------*/
	/* #3 JFF le 11/04/2003                                             */
	/*------------------------------------------------------------------*/
	sValFinale = sVal[ iiNumCol [ 17 ] ]
	For lCpt1 = 1 To 2
		iCpt 	= 1
		iPos	= 1

		Choose Case lCpt1
			Case 	1
				sValQuote = Char ( 34 ) // "
			Case  2
				sValQuote = Char ( 39 ) // '
		End Choose 

		Do While iPos > 0

			iPos = Pos ( sValFinale, sValQuote , iPos)
			If  iPos > 0 Then
				sValFinale = Replace ( sValFinale, iPos, 1, " " )
				iPos += 1
			Else
				Exit
			End If
		Loop
	Next

	sVal[ iiNumCol [ 17 ] ] = 	sValFinale
	/*------------------------------------------------------------------*/
	/* FIN #3 																		     */
	/*------------------------------------------------------------------*/



	Wf_ChoixGestion ( sVal )

End If





end subroutine

private subroutine wf_tracemotifroutage (ref string astrace, ref datawindow adwmotif);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_TraceMotifRoutage
//* Auteur			: DBI
//* Date				: 31/08/1999 10:54:53
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Enregistre les motifs de routage le cas $$HEX1$$e900$$ENDHEX$$ch$$HEX1$$e900$$ENDHEX$$ant.
//* Commentaires	: DCMP 990391 
//*
//* Arguments		: 	String			asTrace			(ref)	Chaine de trace
//*						DataWindow		adwMotif			(ref) DataWindow des 
//*																		motifs de routage
//* Retourne		: Rien
//*							
//*
//*-----------------------------------------------------------------

String	sMotif
String	sTab	=	"~t", sCr 
String	sCategorie, sCodeMotif, sErreur, sCoeffMotif, sCoeffMax, sTotMotif

Integer	iCptErr = 1
Long		lCpt, lNbLig

/*------------------------------------------------------------------*/
/* On ne trace que si la DataWindow des motifs de routage est       */
/* renseign$$HEX1$$e900$$ENDHEX$$e                                                       */
/*------------------------------------------------------------------*/

sMotif	=	""
sCr		=  ""

If isValid ( adwMotif ) Then
	
	lNbLig	=	adwMotif.RowCount ( )
	For lCpt	=	1 To lNbLig

		If adwMotif.GetItemString ( lCpt, "ALT_ERR" ) = "O" Then

			sCategorie	= adwMotif.GetItemString ( lCpt, "CATEGORIE" )
			sCodeMotif	= adwMotif.GetItemString ( lCpt, "COD_MOT"   )
			sErreur		= adwMotif.GetItemString ( lCpt, "ERREUR"    )
			sCoeffMotif	= String ( adwMotif.GetItemNumber ( lCpt, "COEFF"     ), "0.00" )

/*------------------------------------------------------------------*/
/* Seule la Premi$$HEX1$$e800$$ENDHEX$$re ligne contient les totaux pour pouvoir faire   */
/* des sommes                                                       */
/* sur plusieurs dossiers                                           */
/*------------------------------------------------------------------*/

			If iCptErr = 1 Then

				sTotMotif 	= String ( adwMotif.GetItemNumber ( lCpt, "TOT_ERR"   ), "0.00"   )
				sCoeffMax	= String ( adwMotif.GetItemNumber ( lCpt, "COEFF_MAX" ), "0.00" )
			Else

				sTotMotif 	= "0.00"
				sCoeffMax	= "0.00"
			End If

			sMotif = sMotif + sCr + asTrace 				+ sTab + &
											String ( iCptErr )+ sTab + &
										   sCategorie			+ sTab + &
											sCodeMotif			+ sTab + &
											sErreur				+ sTab + &
											sCoeffMotif			+ sTab + &
											sTotMotif			+ sTab + &
											sCoeffMax			


			sCr = "~r~n"
			iCptErr ++
		End If

	Next
	
End If

/*------------------------------------------------------------------*/
/* Si au moins 1 motif de routage, on trace                         */
/*------------------------------------------------------------------*/
If iCptErr > 1 Then

	f_EcrireFichierText ( isFicTraceRout, sMotif )
End If
end subroutine

private function string wf_ecriretrace (string asdepart[], string asfin[]);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Workflow::Wf_EcrireTrace ( Private )
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 14:57:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String			asDepart[]			(Val)	Tableau des valeurs arm$$HEX1$$e900$$ENDHEX$$s au d$$HEX1$$e900$$ENDHEX$$part
//* 					  String			asFin[]				(Val)	Tableau des valeurs arm$$HEX1$$e900$$ENDHEX$$s par le client dans sa fen$$HEX1$$ea00$$ENDHEX$$tre sp$$HEX1$$e900$$ENDHEX$$cifique
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1 FS le 16/12/2002 Dcmp 20430 Ajt 1 colonne code etat
//*-----------------------------------------------------------------

String sTrace[]

Long lTot, lCpt

String sTab, sLigne

/*------------------------------------------------------------------*/
/* On va ecrire une trace dans le fichier.                          */
/* Cette trace contient dans l'ordre                                */
/*                                                                  */
/* COD_APPLI						01                                    */
/* N$$HEX2$$b0002000$$ENDHEX$$Machine						02                                    */
/* COD_SERVICE						03                                    */
/* ID_SIN							04                                    */
/* ID_CORB (D$$HEX1$$e900$$ENDHEX$$part)				05                                    */
/* NOM (D$$HEX1$$e900$$ENDHEX$$part)					06                                    */
/* COD_ETAT (D$$HEX1$$e900$$ENDHEX$$part)				07                                    */
/* COD_ACTION (Fin)				08                                    */
/* ALT_BLOC (Fin)					09                                    */
/* TRV_CREE_LE (D$$HEX1$$e900$$ENDHEX$$part)			10                                    */
/* TRV_MAJ_LE (D$$HEX1$$e900$$ENDHEX$$part)			11                                    */
/* TRV_MAJ_LE (Fin)				12                                    */
/* TRV_MAJ_PAR (Fin)				13                                    */
/* TRV_ROUTE_LE (Fin)			14                                    */
/* TRV_ROUTE_PAR (Fin)			15                                    */
/* TRV_EDITE_LE (Fin)			16                                    */
/* TRV_EDITE_PAR (Fin)			17                                    */
/* DOS_MAJ_LE (Fin)				18                                    */
/* DOS_MAJ_PAR (Fin)				19                                    */
/* DOS_MAJ_PAR (Fin) (Routage)20                                    */
/*------------------------------------------------------------------*/
/* COD_ETAT_SIN               21 #1                                 */
/*------------------------------------------------------------------*/
sTab = "~t"

sTrace[ 1 ]  = stGLB.sCodAppli
sTrace[ 2 ]  = isNomMachine
sTrace[ 3 ]  = stGLB.sCodServ
sTrace[ 4 ]  = asFin[ iiNumCol [ 1 ] ]					// ID_SIN
sTrace[ 5 ]  = asDepart[ 1 ]								// ID_CORB	(Valeur de d$$HEX1$$e900$$ENDHEX$$part arm$$HEX1$$e900$$ENDHEX$$e sur dw_1)
sTrace[ 6 ]  = asDepart[ 2 ]								// NOM		(Valeur de d$$HEX1$$e900$$ENDHEX$$part arm$$HEX1$$e900$$ENDHEX$$e sur dw_1)
sTrace[ 7 ]  = asDepart[ 3 ]								// COD_ETAT	(Valeur de d$$HEX1$$e900$$ENDHEX$$part arm$$HEX1$$e900$$ENDHEX$$e sur dw_1)
sTrace[ 8 ]  = asFin[ iiNumCol [ 5 ] ]					// COD_ACTION

Choose Case sTrace[ 7 ] + sTrace[ 8 ]
Case "14"
	sTrace[ 9 ] = "O"											// ALT_BLOC
Case "10"
	sTrace[ 9 ] = asFin[ iiNumCol [ 7 ] ]				// ALT_BLOC
Case Else
	sTrace[ 9 ] = "N"											// ALT_BLOC
End Choose

sTrace[ 10 ] = asDepart[ 5 ]								// TRV_CREE_LE
sTrace[ 11 ] = asDepart[ 4 ]								// TRV_MAJ_LE (D$$HEX1$$e900$$ENDHEX$$but)
sTrace[ 12 ] = asFin[ iiNumCol [ 9 ] ]					// TRV_MAJ_LE (Fin)
sTrace[ 13 ] = stGLB.sCodOper								// TRV_MAJ_PAR
sTrace[ 14 ] = asFin[ iiNumCol [ 11 ] ]				// TRV_ROUTE_LE

If	sTrace[ 14 ] = "" Or IsNull ( sTrace[ 14 ] ) Then
	sTrace[ 15 ] = ""
	sTrace[ 20 ] = ""
Else
	Choose Case sTrace[ 7 ] + sTrace[ 8 ]
	Case "10"
		sTrace[ 15 ] = asFin[ iiNumCol [ 12 ] ]			// TRV_ROUTE_PAR
		sTrace[ 20 ] = ""											// Dernier op$$HEX1$$e900$$ENDHEX$$rateur ayant trait$$HEX2$$e9002000$$ENDHEX$$le dossier
	Case Else
		sTrace[ 15 ] = stGLB.sCodOper							// TRV_ROUTE_PAR
		sTrace[ 20 ] = asFin[ iiNumCol [ 12 ] ]			// Dernier op$$HEX1$$e900$$ENDHEX$$rateur ayant trait$$HEX2$$e9002000$$ENDHEX$$le dossier
	End Choose
End If

sTrace[ 16 ] = asDepart[ 6 ]								// TRV_EDITE_LE
sTrace[ 17 ] = asDepart[ 7 ] 								// TRV_EDITE_PAR
sTrace[ 18 ] = asFin[ iiNumCol [ 15 ] ]				// DOS_MAJ_LE (Fin)
sTrace[ 19 ] = asFin[ iiNumCol [ 16 ] ]				// DOS_MAJ_PAR


/*------------------------------------------------------------------*/
/* Modification des donn$$HEX1$$e900$$ENDHEX$$es, si besoin                              */
/*------------------------------------------------------------------*/

wf_TrtTrace ( sTrace[] )


/*------------------------------------------------------------------*/
/* #1 SINDI  asFin contient 18 $$HEX1$$e900$$ENDHEX$$lements                             */
/*    SIMPA  asFin contient 17 $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments                             */
/*    SAVANE asFin contient 17 $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments                             */
/* => Dans le cas de 18 elt on ajoute le code $$HEX1$$e900$$ENDHEX$$tat en fin de tableau*/
/*------------------------------------------------------------------*/

If UpperBound( asFin ) = 18 Then
   lTot = UpperBound ( sTrace[] ) + 1
   sTrace [ lTot ] = asFin [ 18 ]
End If


/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la derni$$HEX1$$e800$$ENDHEX$$re. Pour terminer, on   */
/* ecrit la ligne                                                   */
/*------------------------------------------------------------------*/

lTot 		= UpperBound ( sTrace[] )
sLigne	= ""

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie qu'il n'y ait plus de cha$$HEX1$$ee00$$ENDHEX$$ne nulle.                   */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lTot
		If	IsNull ( sTrace[ lCpt ] ) Or sTrace[ lCpt ] = "''" Then
			sTrace[ lCpt ] = ""
		End If
Next

/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la derni$$HEX1$$e800$$ENDHEX$$re. Pour terminer, on   */
/* ecrit la ligne                                                   */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lTot - 1
		sLigne = sLigne + sTrace[ lCpt ] + sTab
Next

sLigne = sLigne + sTrace[ lTot ]

f_EcrireFichierText ( isFicTrace, sLigne )

Return ( sLigne )
end function

on ue_initialiser;call w_accueil::ue_initialiser;//*****************************************************************************
//
// Objet 		: w_Accueil_WorkFlow
// Evenement 	: Ue_Initialiser (Append)
//	Auteur		: Erick John Stark
//	Date			: 26/04/1997
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Initialisation des valeurs par d$$HEX1$$e900$$ENDHEX$$faut
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

String sRep, sRepRout
Environment Env
U_DeclarationWindows	nvWin

GetEnvironment ( Env )

This.ibAfficherMessage	= True		// On g$$HEX1$$e900$$ENDHEX$$re l'affichage des "post_it" (Messages clients des applications)
This.ibGestionErreur		= False		// Cette fen$$HEX1$$ea00$$ENDHEX$$tre ne sert pas au d$$HEX1$$e900$$ENDHEX$$blocage des dossiers

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re maintenant le nom de la machine. On part du principe */
/* que ce nom est positionn$$HEX2$$e9002000$$ENDHEX$$dans la valeur Dos (SQL=XXX)           */
/*------------------------------------------------------------------*/
nvWin				= stGLB.uoWin
isNomMachine	= nvWin.uf_GetEnvironment ( "SQL" )

/*------------------------------------------------------------------*/
/* On initialise maintenant le nom du fichier de TRACE au format    */
/* JJMMAAAA.App (App correspond au code de l'application).          */
/* Pour connaitre le r$$HEX1$$e900$$ENDHEX$$pertoire qui contient le fichier de TRACE,   */
/* il faut lire la section TRACE du fichier INI de l'application.   */
/*------------------------------------------------------------------*/

sRep = ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE", "" )

isFicTrace = sRep + String (Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )

sRepRout = ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_ROU", "" )

isFicTraceRout = sRepRout + String (Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )

/*------------------------------------------------------------------*/
/* En Fonction de la taille de l'$$HEX1$$e900$$ENDHEX$$cran, on ajuste les bitmaps       */
/* utilis$$HEX1$$e900$$ENDHEX$$s pour ALT_OCCUPE, ALT_BLOC, COD_ETAT                     */
/*------------------------------------------------------------------*/

If	Env.ScreenWidth > 800 Then
	This.isBmpOccupe_Oui		= "K:\PB4OBJ\BMP\OCC_O.BMP"
	This.isBmpOccupe_Non		= ""

	This.isBmpBloc_Oui		= "K:\PB4OBJ\BMP\BLO_O.BMP"
	This.isBmpBloc_Non		= ""

	This.isBmpRout_Oui		= "K:\PB4OBJ\BMP\ROU_O.BMP"
	This.isBmpRout_Non		= ""
Else
	This.isBmpOccupe_Oui		= "K:\PB4OBJ\BMP\8_OCC_O.BMP"
	This.isBmpOccupe_Non		= ""

	This.isBmpBloc_Oui		= "K:\PB4OBJ\BMP\8_BLO_O.BMP"
	This.isBmpBloc_Non		= ""

	This.isBmpRout_Oui		= "K:\PB4OBJ\BMP\8_ROU_O.BMP"
	This.isBmpRout_Non		= ""
End If


/*------------------------------------------------------------------*/
/* Sur cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement, il faut initialiser le Tableau iiNumCol[],    */
/* qui correspond aux valeurs suivantes                             */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* 1  -> ID_SIN                                                     */
/* 2  -> ID_CORB                                                    */
/* 3  -> NOM                                                        */
/* 4  -> COD_ETAT                                                   */
/* 5  -> COD_ACTION                                                 */
/* 6  -> ALT_OCCUPE                                                 */
/* 7  -> ALT_BLOC                                                   */
/* 8  -> TRV_CREE_LE                                                */
/* 9  -> TRV_MAJ_LE                                                 */
/* 10 -> TRV_MAJ_PAR                                                */
/* 11 -> TRV_ROUTE_LE                                               */
/* 12 -> TRV_ROUTE_PAR                                              */
/* 13 -> TRV_EDITE_LE                                               */
/* 14 -> TRV_EDITE_PAR                                              */
/* 15 -> DOS_MAJ_LE                                                 */
/* 16 -> DOS_MAJ_PAR                                                */
/* 17 -> TXT_MESS1                                                  */
/* 18 -> TXT_MESS2                                                  */
/*------------------------------------------------------------------*/

This.itrTrans = SQLCA

Wf_Recuperer_Corbeille ()

Wf_Init_DwLibre ()



end on

on ue_modifier;call w_accueil::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil_Workflow::Ue_Modifier
//* Evenement 		: Ue_Modifier (Extend)
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 15:57:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Mise $$HEX2$$e0002000$$ENDHEX$$jour de ALT_OCCUPE
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si le travail n'est pas accessible, et cela pour diverses        */
/* raisons, on rafra$$HEX1$$ee00$$ENDHEX$$chit les informations                          */
/* De plus, on positionne une variable d'instance pour demander au  */
/* descendant de ne rien faire.                                     */
/*------------------------------------------------------------------*/

ibContinuerModifier = True

If	Not ibGestionErreur Then

	If	Not Wf_GestionAltOccupe () Then
		ibContinuerModifier = False

		dw_1.Visible = False
		dw_1.Retrieve ()

// .... On retaille la DW

		This.TriggerEvent( "Ue_TaillerHauteur" )
		dw_1.Visible = True

		dw_1.SetFocus ()

End If

End If




end on

on ue_enablefenetre;call w_accueil::ue_enablefenetre;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil_Workflow::Ue_EnableFenetre
//* Evenement 		: Ue_EnableFenetre
//* Auteur			: Erick John Stark
//* Date				: 06/12/1997 18:31:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne le bouton de d$$HEX1$$e900$$ENDHEX$$blocage pour qu'il soit actif.      */
/*------------------------------------------------------------------*/

If	This.ibGestionErreur Then
	pb_Debloc.Enabled = True
End If

end on

on ue_disablefenetre;call w_accueil::ue_disablefenetre;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil_Workflow::Ue_DisableFenetre
//* Evenement 		: Ue_DisableFenetre
//* Auteur			: Erick John Stark
//* Date				: 06/12/1997 18:31:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Pendant le retrieve de la DataWindow, on positionne le bouton    */
/* de d$$HEX1$$e900$$ENDHEX$$blocage pour qu'il ne soit pas accessible. Et cela          */
/* uniquement pour le d$$HEX1$$e900$$ENDHEX$$blocage des dossiers.                       */
/*------------------------------------------------------------------*/

If	This.ibGestionErreur Then
	pb_Debloc.Enabled = False
End If

end on

on ue_item7;call w_accueil::ue_item7;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil_WorkFlow::Ue_Item7
//* Evenement 		: Ue_Item (Extend)
//* Auteur			: Erick John Stark
//* Date				: 03/06/1997 11:59:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Apparition de la fen$$HEX1$$ea00$$ENDHEX$$tre plus de d$$HEX1$$e900$$ENDHEX$$tails
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lLig, lTot, lCpt
String sVal, sTab

s_Pass stPara 

lLig	= dw_1.ilLigneClick
sTab	= "~t"

If	dw_1.ilLigneClick > 0 Then

	lTot = UpperBound ( iiNumCol[] )

	For	lCpt = 1 To ( lTot - 1 )
			sVal = sVal + Wf_GetItem ( dw_1, lLig, iiNumCol[ lCpt ] ) + sTab
	Next

	sVal = sVal + Wf_GetItem ( dw_1, lLig, iiNumCol[ lTot ] )

	stPara.sTab[ 1 ] = sVal

	OpenWithParm ( W_Plus_Detail_WorkFlow, stPara )


End If
end on

on w_accueil_workflow.create
int iCurrent
call super::create
this.dw_libre=create dw_libre
this.mle_msg1=create mle_msg1
this.pb_debloc=create pb_debloc
this.dw_corbeille=create dw_corbeille
this.dw_workflow=create dw_workflow
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_libre
this.Control[iCurrent+2]=this.mle_msg1
this.Control[iCurrent+3]=this.pb_debloc
this.Control[iCurrent+4]=this.dw_corbeille
this.Control[iCurrent+5]=this.dw_workflow
end on

on w_accueil_workflow.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_libre)
destroy(this.mle_msg1)
destroy(this.pb_debloc)
destroy(this.dw_corbeille)
destroy(this.dw_workflow)
end on

type cb_debug from w_accueil`cb_debug within w_accueil_workflow
end type

type pb_retour from w_accueil`pb_retour within w_accueil_workflow
integer y = 12
integer width = 274
integer height = 160
integer taborder = 40
end type

type pb_interro from w_accueil`pb_interro within w_accueil_workflow
integer x = 293
integer y = 12
integer width = 274
integer height = 160
end type

type pb_creer from w_accueil`pb_creer within w_accueil_workflow
integer y = 12
integer width = 274
integer height = 160
integer taborder = 0
end type

type dw_1 from w_accueil`dw_1 within w_accueil_workflow
integer y = 408
integer taborder = 30
end type

on dw_1::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil_Workflow::dw_1
//* Evenement 		: Ue_MajAccueil (OverRide) !!
//* Auteur			: Erick John Stark
//* Date				: 25/05/1997 17:13:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va s'occuper de la mise $$HEX2$$e0002000$$ENDHEX$$jour 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*	#1 DBI le 30/08/1999 DCMP 990391 : Gestion des motifs de routage			  
//*-----------------------------------------------------------------

s_Pass stPass
String sValAcc
String sVal[]

Parent.SetRedraw ( False )

stPass = Message.PowerObjectParm

/*------------------------------------------------------------------*/
/* On va initialiser en variable d'instance, les valeurs pass$$HEX1$$e900$$ENDHEX$$es.   */
/* La premi$$HEX1$$e800$$ENDHEX$$re correspond au type de traitement (AUTomatique ou     */
/* MANuel), la seconde correspond $$HEX2$$e0002000$$ENDHEX$$la chaine d'import pour la dw   */
/* d'accueil (dans le cas d'une mise $$HEX2$$e0002000$$ENDHEX$$jour automatique).           */
/*------------------------------------------------------------------*/

sValAcc	= stPass.sTab[ 2 ]

/*------------------------------------------------------------------*/
/* Quel type de mise $$HEX2$$e0002000$$ENDHEX$$jour est attendue ?                          */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* La structure stPass explique le fonctionnement de la mise $$HEX2$$e0002000$$ENDHEX$$jour */
/*------------------------------------------------------------------*/

Choose Case stPass.sTab[ 1 ]
Case "AUT", "SMA"

/*------------------------------------------------------------------*/
/* La structure stPass contient en seconde position la cha$$HEX1$$ee00$$ENDHEX$$ne $$HEX6$$e00020002000200020002000$$ENDHEX$$*/
/* importer dans la DW.                                             */
/* La premi$$HEX1$$e800$$ENDHEX$$re chose $$HEX2$$e0002000$$ENDHEX$$faire est de parser cette cha$$HEX1$$ee00$$ENDHEX$$ne dans un     */
/* tableau                                                          */
/*------------------------------------------------------------------*/

	f_DecomposerChaine ( sValAcc, "~t", sVal )

/*------------------------------------------------------------------*/
/* Gestion automatique et semi-automatique de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil. */
/*------------------------------------------------------------------*/

	If stPass.sTab[3] = "ROU"	Then	// #1 Gestion des motifs de routage
	
		idwRoutage = stPass.DwNorm [1]
	End If

	Wf_ChoixGestion ( sVal [] )

	This.SetFocus ()

Case "MAN"

/*------------------------------------------------------------------*/
/* L'utilisateur veut une action non programm$$HEX1$$e900$$ENDHEX$$e. D$$HEX1$$e900$$ENDHEX$$clenchement      */
/* d'un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement sur la fen$$HEX1$$ea00$$ENDHEX$$tre "Ue_MajWorkFlow".                  */
/*------------------------------------------------------------------*/

	Parent.TriggerEvent ( "Ue_MajWorkFlow" )

End Choose

Parent.SetRedraw ( True )

end on

on dw_1::ue_modifiermenu;call w_accueil`dw_1::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil::dw_1::Ue_ModifierMenu
//* Evenement 		: Ue_ModifierMenu (Extend)
//* Auteur			: Erick John Stark
//* Date				: 03/06/1997 11:59:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affichage du menu contextuel avec option "Plus de d$$HEX1$$e900$$ENDHEX$$tails"
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	This.RowCount () > 0 And This.ilLigneClick > 0 Then

	uf_Mnu_AjouterItem ( 6, "-" )
	uf_Mnu_AjouterItem ( 7, "Plus de d$$HEX1$$e900$$ENDHEX$$tail" )

Else

/*------------------------------------------------------------------*/
/* Il faut d'abord cr$$HEX1$$e900$$ENDHEX$$er la ligne dans le menu pour pouvoir         */
/* l'interdire.                                                     */
/*------------------------------------------------------------------*/

	uf_Mnu_AjouterItem ( 6, "-" )
	uf_Mnu_AjouterItem ( 7, "Plus de d$$HEX1$$e900$$ENDHEX$$tail" )
	uf_Mnu_InterdirItem ( 7 )

End If

uf_Mnu_InterdirItem ( 1 )


end on

on dw_1::rowfocuschanged;call w_accueil`dw_1::rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil::dw_1::RowFocusChanged
//* Evenement 		: RowFocusChanged (Extend)
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 15:52:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion de l'affichage d'un message au format Post_It
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	This.ilLigneClick > 0 And This.ilNbrLig > 0 And ibAfficherMessage = True Then
	wf_AfficherMessage ( This.ilLigneClick )
End If





end on

on dw_1::retrieveend;call w_accueil`dw_1::retrieveend;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Accueil::dw_1::RetrieveEnd
//* Evenement 		: RetrieveEnd (Extend)
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 15:55:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On enleve le pOst-It si aucune ligne de trouv$$HEX1$$e900$$ENDHEX$$e
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If This.RowCount() = 0 Then mle_Msg1.Visible = False
end on

type pb_tri from w_accueil`pb_tri within w_accueil_workflow
integer x = 567
integer y = 12
integer width = 274
integer height = 160
integer taborder = 80
end type

type pb_imprimer from w_accueil`pb_imprimer within w_accueil_workflow
boolean visible = true
integer x = 841
integer y = 12
integer width = 274
integer height = 160
integer taborder = 20
boolean enabled = true
end type

type dw_libre from datawindow within w_accueil_workflow
boolean visible = false
integer x = 41
integer y = 208
integer width = 165
integer height = 76
boolean bringtotop = true
boolean enabled = false
end type

type mle_msg1 from multilineedit within w_accueil_workflow
boolean visible = false
integer x = 1115
integer y = 12
integer width = 901
integer height = 196
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 65535
boolean autovscroll = true
boolean displayonly = true
boolean hideselection = false
end type

type pb_debloc from u_pbdebloc within w_accueil_workflow
boolean visible = false
integer x = 567
integer y = 12
integer width = 265
integer height = 152
integer taborder = 10
boolean enabled = false
end type

on clicked;call u_pbdebloc::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Pb_Debloc::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 04/12/1997 18:22:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: D$$HEX1$$e900$$ENDHEX$$blocage des dossiers
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Wf_GestionErreur ()
end on

type dw_corbeille from datawindow within w_accueil_workflow
boolean visible = false
integer x = 261
integer y = 208
integer width = 165
integer height = 76
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
boolean livescroll = true
end type

type dw_workflow from datawindow within w_accueil_workflow
boolean visible = false
integer x = 480
integer y = 208
integer width = 165
integer height = 76
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_workflow_stockage"
boolean livescroll = true
end type

