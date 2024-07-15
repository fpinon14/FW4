HA$PBExportHeader$u_archivage_fn.sru
$PBExportComments$----} UserObjet servant $$HEX2$$e0002000$$ENDHEX$$toutes les fonctionnalit$$HEX1$$e900$$ENDHEX$$s de la sauvegarde des courriers sous FileNet.
forward
global type u_archivage_fn from nonvisualobject
end type
end forward

global type u_archivage_fn from nonvisualobject
end type
global u_archivage_fn u_archivage_fn

type variables
Private :
	u_Transaction		itrTrans
	Transaction		itrTransBlob

	u_DataWindow		idw_Master

	u_DataWindow_Detail	idw_LstTrt
	u_DataWindow_Detail	idw_LstDossier

	u_Onglets		iUoOng

	u_DeclarationFilenet	iUoFn

	String			isFicIniFileNet
	String			isRepWinTemp
	String			isMoteur

	Blob			iblData
	Blob			iblPart
	Blob			iblPce
	Blob			iblPs

	Long			ilData
	Long			ilPart
	Long			ilPce
	Long			ilPs









end variables

forward prototypes
public subroutine uf_traitement (integer aitype, ref s_pass astpass)
public subroutine uf_initialisation (ref u_datawindow adw_master, ref u_transaction atrtrans, ref u_onglets auonglet)
public subroutine uf_initialiser_dw (ref u_datawindow_detail adw_LstDossier, ref u_datawindow_detail adw_LstTrt)
private subroutine uf_initialiserfenetre ()
private subroutine uf_preparerinserer (ref s_pass astpass)
private subroutine uf_recuperation (ref s_pass astpass)
private subroutine uf_archivage (ref s_pass astpass)
private function boolean uf_lire_blob (ref blob ablblob, string astypblob, long alligne)
private subroutine uf_gestion_erreur (integer aitype, integer aivaleur, long alligne)
private function boolean uf_gestion_blob_ecrire (long alligne)
private function boolean uf_gestion_blob_lire (long alligne)
private function boolean uf_ecrire_blob (ref blob ablblob, string astypblob, long alligne)
private function boolean uf_gestion_sql_archive (long alligne)
end prototypes

public subroutine uf_traitement (integer aitype, ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Traitement (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:29:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Integer		aiType			(Val)	Type de traitement
//*					  s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Choose Case aiType
Case 1					// INITIALISATION		(Ue_Initialiser de la fen$$HEX1$$ea00$$ENDHEX$$tre)
	Uf_InitialiserFenetre ()

Case 2					// INSERTION			(Wf_PreparerIns$$HEX1$$e900$$ENDHEX$$rer)
	Uf_PreparerInserer ( astPass )

Case 3					// RECUPERATION DES DOSSIERS A TRAITER
	Uf_Recuperation ( astPass )

Case 4					// ARCHIVAGE
	Uf_Archivage 	( astPass )

Case 7					// VALIDER	(Wf_Valider) ( La fonction anc$$HEX1$$ea00$$ENDHEX$$tre est totalement r$$HEX2$$e900e900$$ENDHEX$$crite. )
//	Uf_Valider ( astPass )


End Choose



end subroutine

public subroutine uf_initialisation (ref u_datawindow adw_master, ref u_transaction atrtrans, ref u_onglets auonglet);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialisation (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow				adw_Master		(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow de traitement du Master
//*					  u_Transaction			atrTrans			(R$$HEX1$$e900$$ENDHEX$$f)	Objet de transaction
//*					  u_Onglets					auOnglet			(R$$HEX1$$e900$$ENDHEX$$f)	Onglet
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idw_Master	= adw_Master
itrTrans		= atrTrans
iuoOng		= auOnglet


/*------------------------------------------------------------------*/
/* Il faut pr$$HEX1$$e900$$ENDHEX$$voir un autre objet de transaction pour               */
/* l'application SAVANE. En effet, les BLOBS sont stock$$HEX1$$e900$$ENDHEX$$es dans     */
/* une autre base. (SAVABLOB)                                       */
/*------------------------------------------------------------------*/
isMoteur = Left ( Upper ( atrTrans.DBMS ), 3 )	
// [MIGPB11] [EMD] : Debut Migration : modif de la variable isMoteur, si SNC on y met MSS
// [PI056] Moteur MSS par d$$HEX1$$e900$$ENDHEX$$faut
//If isMoteur = "SNC" Then
If isMoteur <> "GUP" Then
	isMoteur = "MSS"
End If
// [MIGPB11] [EMD] : Fin Migration
If	isMoteur = "GUP"	Then
	itrTransBlob = Create TRANSACTION
End If
end subroutine

public subroutine uf_initialiser_dw (ref u_datawindow_detail adw_LstDossier, ref u_datawindow_detail adw_LstTrt);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser_Dw (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des instances pour le NVUO
//*
//* Arguments		: U_DataWindow_Detail	adw_LstDossier		(R$$HEX1$$e900$$ENDHEX$$f)	U_DataWindow sur les dossiers $$HEX2$$e0002000$$ENDHEX$$traiter
//*					  U_DataWindow_Detail	adw_LstTrt			(R$$HEX1$$e900$$ENDHEX$$f)	U_DataWindow pour la liste de traitements pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dents
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* DataWindow sur les DOSSIERS. Liste => U_DataWindow_Detail.       */
/*------------------------------------------------------------------*/
idw_LstDossier	= adw_LstDossier
idw_LstDossier.Uf_SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* DataWindow sur les TRAITEMENTS PRECEDENTS. Liste => U_DataWindow_Detail.*/
/*------------------------------------------------------------------*/
idw_LstTrt	= adw_LstTrt
idw_LstTrt.Uf_SetTransObject ( This.itrTrans )


end subroutine

private subroutine uf_initialiserfenetre ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_InitialiserFenetre (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1 DGA              19/09/2006              Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire DCMP-060643
//*-----------------------------------------------------------------

DataWindowChild		dwChild, dwChild1
U_Archivage_Fn_Creer_Lst	UoArchivageFnCreerLst

String sCol [9]

/*------------------------------------------------------------------*/
/* On initialise l'objet de transaction de la DataWindow MASTER.    */
/* (Cela ne sert pas $$HEX2$$e0002000$$ENDHEX$$grand chose, car il s'agit d'un fichier      */
/* TEXTE, mais c'est pour une bonne utilisation des fonctions       */
/* anc$$HEX1$$ea00$$ENDHEX$$tres).                                                       */
/*------------------------------------------------------------------*/
idw_Master.Uf_SetTransObject ( This.itrTrans )

/*------------------------------------------------------------------*/
/* On va maintenant cr$$HEX1$$e900$$ENDHEX$$er la DW pour le d$$HEX1$$e900$$ENDHEX$$tail (Table ARCHIVE).     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* C'est dans ce NVUO que l'on positionne le nombre maximum de      */
/* dossiers $$HEX2$$e0002000$$ENDHEX$$traiter.                                              */
/*------------------------------------------------------------------*/

uoArchivageFnCreerLst	= Create U_Archivage_Fn_Creer_Lst
uoArchivageFnCreerLst.Uf_Creer_Detail ( 1, idw_LstDossier, itrTrans )
Destroy uoArchivageFnCreerLst

/*------------------------------------------------------------------*/
/* On initialise la variable d'instance pour le r$$HEX1$$e900$$ENDHEX$$pertoire          */
/* temporaire de WINDOWS. Ce r$$HEX1$$e900$$ENDHEX$$pertoire va servir $$HEX3$$e0002000e900$$ENDHEX$$crire les      */
/* blobs sous forme de fichier.                                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//isRepWinTemp = stGLB.sWinDir + "\TEMP\"
isRepWinTemp = stGLB.sRepTempo






end subroutine

private subroutine uf_preparerinserer (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerModifier (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Pr$$HEX1$$e900$$ENDHEX$$paration de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Boolean bRet

bRet = True

/*------------------------------------------------------------------*/
/* On initialise la DW sur les dossiers.                            */
/*------------------------------------------------------------------*/
idw_LstDossier.Reset ()

/*------------------------------------------------------------------*/
/* On initialise la DW de d$$HEX1$$e900$$ENDHEX$$tail sur les traitements pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dents.    */
/*------------------------------------------------------------------*/
idw_LstTrt.Reset ()
idw_LstTrt.Retrieve ()

/*------------------------------------------------------------------*/
/* S'il n'existe aucun traitement pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dents, on d$$HEX1$$e900$$ENDHEX$$sactive          */
/* l'onglet correspondant.                                          */
/*------------------------------------------------------------------*/
If	idw_LstTrt.RowCount () > 0	Then
	iuoOng.Uf_ActiverOnglet ( "02", True )
Else
	iuoOng.Uf_ActiverOnglet ( "02", False )
End If

/*------------------------------------------------------------------*/
/* On bascule le focus sur le 1er Onglet par d$$HEX1$$e900$$ENDHEX$$faut.                */
/*------------------------------------------------------------------*/
iuoOng.Uf_ChangerOnglet ( "01" )
		
astPass.bRetour = bRet

end subroutine

private subroutine uf_recuperation (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Recuperation (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va d$$HEX1$$e900$$ENDHEX$$clencher la r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des dossiers $$HEX2$$e0002000$$ENDHEX$$traiter
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Boolean bRet
DateTime dtRecupDeb

/*------------------------------------------------------------------*/
/* On positionne le DateTime de DEBUT de traitement.                */
/*------------------------------------------------------------------*/
dtRecupDeb	= DateTime ( Today (), Now () )
idw_Master.SetItem ( 1, "RECUP_DEB", dtRecupDeb )

/*------------------------------------------------------------------*/
/* On lance le RETRIEVE des dossiers $$HEX2$$e0002000$$ENDHEX$$traiter.                     */
/*------------------------------------------------------------------*/
idw_LstDossier.Retrieve ()

		
astPass.bRetour = bRet

end subroutine

private subroutine uf_archivage (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Archivage (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va d$$HEX1$$e900$$ENDHEX$$clencher l'archivage des dossiers
//*
//* Arguments		: s_Pass			astPass			(R$$HEX1$$e900$$ENDHEX$$f) Structure de passage
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Boolean bRet
DateTime dtTrtDeb, dtFnDeb, dtFnFin, dtTrtFin
Long lRet, lTotDossier, lCpt

bRet = False

/*------------------------------------------------------------------*/
/* On positionne le DateTime de DEBUT d'archivage.                  */
/*------------------------------------------------------------------*/
dtTrtDeb	= DateTime ( Today (), Now () )
idw_Master.SetItem ( 1, "TRT_DEB", dtTrtDeb )

/*------------------------------------------------------------------*/
/* On se connecte sur le syst$$HEX1$$e800$$ENDHEX$$me FileNet en tant que SysAdmin.      */
/*------------------------------------------------------------------*/
lRet = iuoFn.FN_Logon ( "SysAdmin", "SysAdmin" )

For	lCpt = 1 To 5
		Yield ()
Next

/*------------------------------------------------------------------*/
/* Tout se passe bien, on va pouvoir lancer le traitement. On       */
/* affiche l'heure de connexion FileNet.                            */
/*------------------------------------------------------------------*/
If	lRet >= 0	Then
	dtFnDeb	= DateTime ( Today (), Now () )
	idw_Master.SetItem ( 1, "FN_DEB", dtFnDeb )

	lTotDossier = idw_LstDossier.RowCount ()

	For	lCpt = 1 To lTotDossier
			Yield ()

/*------------------------------------------------------------------*/
/* On initialise les blobs (DT,PS,PCE,PART) $$HEX2$$e0002000$$ENDHEX$$NULL.                 */
/*------------------------------------------------------------------*/
			SetNull ( iblData )
			SetNull ( iblPs )
			SetNull ( iblPce )
			SetNull ( iblPart )

/*------------------------------------------------------------------*/
/* On va s'occuper de lire les BLOBS dans les variables pr$$HEX1$$e900$$ENDHEX$$vues $$HEX4$$e000200020002000$$ENDHEX$$*/
/* cet effet.                                                       */
/*------------------------------------------------------------------*/
			bRet = Uf_Gestion_Blob_Lire ( lCpt )
			If	Not bRet	Then Exit

			Yield ()

/*------------------------------------------------------------------*/
/* On va $$HEX1$$e900$$ENDHEX$$crire les BLOBS sur FileNet et positionner les DOCID      */
/* r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es dans la DW.                                           */
/*------------------------------------------------------------------*/
			bRet = Uf_Gestion_Blob_Ecrire ( lCpt )
			If	Not bRet	Then Exit

			Yield ()

/*------------------------------------------------------------------*/
/* On va envoyer la transaction pour positionner les valeurs de     */
/* DOC_ID dans ARCHIVE et supprimer les BLOBS de ARCHIVE_BLOB.      */
/*------------------------------------------------------------------*/
			bRet = Uf_Gestion_Sql_Archive ( lCpt )
			If	Not bRet	Then Exit

			Yield ()

/*------------------------------------------------------------------*/
/* On se positionne sur la ligne en cours de traitement.            */
/*------------------------------------------------------------------*/
			idw_LstDossier.SetRow ( lCpt )

	Next

/*------------------------------------------------------------------*/
/* On se d$$HEX1$$e900$$ENDHEX$$connecte du syst$$HEX1$$e800$$ENDHEX$$me FileNet.                             */
/*------------------------------------------------------------------*/
	dtFnFin	= DateTime ( Today (), Now () )
	idw_Master.SetItem ( 1, "FN_FIN", dtFnFin )

	iuoFn.FN_Logoff ()

/*------------------------------------------------------------------*/
/* On positionne le DateTime de FIN d'archivage.                    */
/*------------------------------------------------------------------*/
	dtTrtFin	= DateTime ( Today (), Now () )
	idw_Master.SetItem ( 1, "TRT_FIN", dtTrtFin )

/*------------------------------------------------------------------*/
/* On $$HEX1$$e900$$ENDHEX$$crit les informations sur ARCHIVE_FN.                        */
/*------------------------------------------------------------------*/
	If	idw_Master.Update () > 0	Then
		F_Commit ( itrTrans, True )
	Else
/*------------------------------------------------------------------*/
/* On charge les valeurs de la structure Message avec les valeurs   */
/* de itrTrans, avant de faire un ROLLBACK.                         */
/*------------------------------------------------------------------*/
		stMessage.sTitre		= "Archivage sur le syst$$HEX1$$e800$$ENDHEX$$me FileNet"
		stMessage.Icon			= StopSign!
		stMessage.bErreurG	= True
		stMessage.Bouton		= OK!
		stMessage.sCode		= "FN0004"
/*------------------------------------------------------------------*/
/* On peut envoyer le ROLLBACK.                                     */
/*------------------------------------------------------------------*/
		F_Commit ( itrTrans, False )
/*------------------------------------------------------------------*/
/* On peut afficher le message sans risques.                        */
/*------------------------------------------------------------------*/
		F_Message ( stMessage )
/*------------------------------------------------------------------*/
/* On sauvegarde un fichier C:\DGA.TXT pour effectuer l'insertion   */
/* si besoin.                                                       */
/*------------------------------------------------------------------*/
		idw_Master.SaveAs ( "C:\DGA.TXT", Text!, False )

	End If
End If


astPass.bRetour = bRet

end subroutine

private function boolean uf_lire_blob (ref blob ablblob, string astypblob, long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Archivage_Fn::Uf_Lire_Blob	(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 29/06/1999 17:16:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Lecture du blob dans la table
//*
//* Arguments		: Blob			ablBlob				(R$$HEX1$$e900$$ENDHEX$$f)	Zone de stockage du BLOB
//* 					: String			asTypBlob			(Val)	Type du Blob (DT/PS/PC/CP)
//* 					: Long			alLigne				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la ligne en cours de traitement
//*
//* Retourne		: Boolean		Vrai	= La lecture est OK
//*										Faux	= La lecture pose probl$$HEX1$$e800$$ENDHEX$$me
//*    JFF   11/01/2011    [DECIMAL_PAPILLON]
//*-----------------------------------------------------------------

Long lIdSin, lIdInter, lIdDoc
Boolean bRet
String sIdDoc
//Migration PB8-WYNIWYG-03/2006 FM
boolean	lb_ac
//Fin Migration PB8-WYNIWYG-03/2006 FM
Decimal {2} dcIdsin2, dcIdInter2, dcIdDoc2

Choose Case isMoteur
Case "MSS"
	lIdSin		= idw_LstDossier.GetItemNumber ( alLigne, "ID_SIN" )
	lIdInter		= idw_LstDossier.GetItemNumber ( alLigne, "ID_INTER" )
	lIdDoc		= idw_LstDossier.GetItemNumber ( alLigne, "ID_DOC" )


	dcIdsin2 = Dec ( lIdSin )
	dcIdInter2 = Dec ( lIdInter )
	dcIdDoc2 = Dec ( lIdDoc )


//Migration PB8-WYNIWYG-03/2006 FM
	lb_ac = itrTrans.autocommit
	itrTrans.autocommit = true
//Fin Migration PB8-WYNIWYG-03/2006 FM
	SELECTBLOB	txt_blob
	INTO			:ablBlob
	FROM			sysadm.archive_blob
	WHERE			id_sin			= :dcIdsin2		AND
					id_inter			= :dcIdInter2		AND
					id_doc			= :dcIdDoc2		AND
					id_typ_blob		= :asTypBlob
	USING			itrTrans										;
//Migration PB8-WYNIWYG-03/2006 FM
	itrTrans.autocommit = lb_ac
//Fin Migration PB8-WYNIWYG-03/2006 FM

	If	itrTrans.SqlCode = 0	And itrTrans.SqlDbCode = 0 Then
		bRet = True
	End If

Case "GUP"

	sIdDoc		= idw_LstDossier.GetItemString ( alLigne, "ID_DOC" )

/*------------------------------------------------------------------*/
/* Attention!!.                                                     */
/* Dans la table ARCHIVE_BLOB, le type AUTRE PIECE n'est pas        */
/* codifi$$HEX2$$e9002000$$ENDHEX$$(PC) mais (AP). Il faut donc le changer maintenant.      */
/*------------------------------------------------------------------*/
	If	asTypBlob = "PC"	Then	asTypBlob = "AP"

	SELECTBLOB	txt_blob
	INTO			:ablBlob
	FROM			sysadm.archive_blob
	WHERE			id_doc			= :sIdDoc		AND
					id_typ_blob		= :asTypBlob
	USING			itrTransBlob								;

	If	itrTransBlob.SqlCode = 0 And itrTransBlob.SqlDbCode = 0 Then
		bRet = True
	End If

End Choose

Return ( bRet )

end function

private subroutine uf_gestion_erreur (integer aitype, integer aivaleur, long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Archivage_Fn::Uf_Gestion_Erreur	(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 29/06/1999 17:32:36
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On g$$HEX1$$e900$$ENDHEX$$re l'affichage des les diff$$HEX1$$e900$$ENDHEX$$rentes erreurs
//*
//* Arguments		: Integer		aiType				(Val)	Type d'erreur
//* 					: Integer		aiValeur				(Val)	Valeur de l'erreur
//* 					: Long			alLigne				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la ligne en cours de traitement
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lIdSin, lIdInter, lIdDoc


stMessage.sTitre		= "Archivage sur le syst$$HEX1$$e800$$ENDHEX$$me FileNet"
stMessage.Icon			= StopSign!
stMessage.Bouton		= OK!
stMessage.bErreurG	= TRUE


Choose	Case aiType
Case 1					// Erreur sur la lecture des BLOBS

	stMessage.sCode			= "FN0001"
	lIdSin 						= idw_LstDossier.GetItemNumber ( alLigne, "ID_SIN" )
	lIdInter						= idw_LstDossier.GetItemNumber ( alLigne, "ID_INTER" )
	lIdDoc						= idw_LstDossier.GetItemNumber ( alLigne, "ID_DOC" )

	Choose	Case aiValeur
	Case 1				// BLOB des DATAS
		stMessage.sVar[1] = "des DATAS"
		stMessage.sVar[2] = String ( lIdSin ) + " / " + String ( lIdInter ) + " / " + String ( lIdDoc )

	Case 2				// BLOB du COURRIER PARTICULIER
		stMessage.sVar[1] = "du COURRIER PARTICULIER"
		stMessage.sVar[2] = String ( lIdSin ) + " / " + String ( lIdInter ) + " / " + String ( lIdDoc )

	Case 3				// BLOB AUTRE PIECE
		stMessage.sVar[1] = "pour AUTRE PIECE"
		stMessage.sVar[2] = String ( lIdSin ) + " / " + String ( lIdInter ) + " / " + String ( lIdDoc )

	Case 4				// BLOB POST-SCRIPTUM
		stMessage.sVar[1] = "du POST-SCRIPTUM"
		stMessage.sVar[2] = String ( lIdSin ) + " / " + String ( lIdInter ) + " / " + String ( lIdDoc )

	End Choose

Case 2					// Erreur sur l'$$HEX1$$e900$$ENDHEX$$criture des BLOBS

	stMessage.sCode			= "FN0002"
	lIdSin 						= idw_LstDossier.GetItemNumber ( alLigne, "ID_SIN" )
	lIdInter						= idw_LstDossier.GetItemNumber ( alLigne, "ID_INTER" )
	lIdDoc						= idw_LstDossier.GetItemNumber ( alLigne, "ID_DOC" )

	Choose	Case aiValeur
	Case 1				// BLOB des DATAS
		stMessage.sVar[1] = "des DATAS"
		stMessage.sVar[2] = String ( lIdSin ) + " / " + String ( lIdInter ) + " / " + String ( lIdDoc )

	Case 2				// BLOB du COURRIER PARTICULIER
		stMessage.sVar[1] = "du COURRIER PARTICULIER"
		stMessage.sVar[2] = String ( lIdSin ) + " / " + String ( lIdInter ) + " / " + String ( lIdDoc )

	Case 3				// BLOB AUTRE PIECE
		stMessage.sVar[1] = "pour AUTRE PIECE"
		stMessage.sVar[2] = String ( lIdSin ) + " / " + String ( lIdInter ) + " / " + String ( lIdDoc )

	Case 4				// BLOB POST-SCRIPTUM
		stMessage.sVar[1] = "du POST-SCRIPTUM"
		stMessage.sVar[2] = String ( lIdSin ) + " / " + String ( lIdInter ) + " / " + String ( lIdDoc )

	End Choose

End Choose

F_Message ( stMessage )


end subroutine

private function boolean uf_gestion_blob_ecrire (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gestion_Blob_Ecrire (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va $$HEX1$$e900$$ENDHEX$$crire les BLOBS sur FileNet
//*
//* Arguments		: Long			alLigne			(Val) N$$HEX2$$b0002000$$ENDHEX$$de la ligne en cours de traitement
//*
//* Retourne		: Boolean			Vrai = Tout est OK
//*											Faux = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

Boolean bRet
String sAltPart, sAltPce, sAltPs

/*------------------------------------------------------------------*/
/* Ecriture syst$$HEX1$$e900$$ENDHEX$$matique du blob des DATA.                          */
/*------------------------------------------------------------------*/
bRet = Uf_Ecrire_Blob ( iblData, "DT", alLigne )
If	Not bRet	Then
	Uf_Gestion_Erreur ( 2, 1, alLigne )
Else
	ilData ++
End If

/*------------------------------------------------------------------*/
/* Ecriture $$HEX1$$e900$$ENDHEX$$ventuelle d'un COURRIER PARTICULIER.                   */
/*------------------------------------------------------------------*/
sAltPart = idw_LstDossier.GetItemString ( alLigne, "ALT_PART" )
If	sAltPart = "O"	And bRet Then
	bRet = Uf_Ecrire_Blob ( iblPart, "CP", alLigne )

	If	Not bRet	Then
		Uf_Gestion_Erreur ( 2, 2, alLigne )
	Else
		ilPart ++
	End If
End If

/*------------------------------------------------------------------*/
/* Ecriture $$HEX1$$e900$$ENDHEX$$ventuelle d'une AUTRE PIECE.                           */
/*------------------------------------------------------------------*/
sAltPce = idw_LstDossier.GetItemString ( alLigne, "ALT_PCE" )
If	sAltPce = "O" And bRet Then
	bRet = Uf_Ecrire_Blob ( iblPce, "PC", alLigne )

	If	Not bRet	Then
		Uf_Gestion_Erreur ( 2, 3, alLigne )
	Else
		ilPce ++
	End If
End If

/*------------------------------------------------------------------*/
/* Ecriture $$HEX1$$e900$$ENDHEX$$ventuelle du POST-SCRIPTUM.                            */
/*------------------------------------------------------------------*/
sAltPs = idw_LstDossier.GetItemString ( alLigne, "ALT_PS" )
If	sAltPs = "O" And bRet Then
	bRet = Uf_Ecrire_Blob ( iblPs, "PS", alLigne )

	If	Not bRet	Then
		Uf_Gestion_Erreur ( 2, 4, alLigne )
	Else
		ilPs ++
	End If
End If

/*------------------------------------------------------------------*/
/* On positionne les valeurs pour les compteurs en affichage.       */
/*------------------------------------------------------------------*/
idw_Master.SetItem ( 1, "NBR_DT", ilData )
idw_Master.SetItem ( 1, "NBR_PS", ilPs )
idw_Master.SetItem ( 1, "NBR_PCE", ilPce )
idw_Master.SetItem ( 1, "NBR_PART", ilPart )

Return ( bRet )
end function

private function boolean uf_gestion_blob_lire (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gestion_Blob_Lire (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des diff$$HEX1$$e900$$ENDHEX$$rents BLOBS
//*
//* Arguments		: Long			alLigne			(Val) N$$HEX2$$b0002000$$ENDHEX$$de la ligne en cours de traitement
//*
//* Retourne		: Boolean			Vrai = Tout est OK
//*											Faux = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

Boolean bRet
String sAltPart, sAltPce, sAltPs

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration syst$$HEX1$$e900$$ENDHEX$$matique du blob des DATA.                      */
/*------------------------------------------------------------------*/
bRet = Uf_Lire_Blob ( iblData, "DT", alLigne )
If	Not bRet	Then
	Uf_Gestion_Erreur ( 1, 1, alLigne )
End If

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration $$HEX1$$e900$$ENDHEX$$ventuelle d'un COURRIER PARTICULIER.               */
/*------------------------------------------------------------------*/
sAltPart = idw_LstDossier.GetItemString ( alLigne, "ALT_PART" )
If	sAltPart = "O"	And bRet Then
	bRet = Uf_Lire_Blob ( iblPart, "CP", alLigne )

	If	Not bRet	Then
		Uf_Gestion_Erreur ( 1, 2, alLigne )
	End If
End If

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration $$HEX1$$e900$$ENDHEX$$ventuelle d'une AUTRE PIECE.                       */
/*------------------------------------------------------------------*/
sAltPce = idw_LstDossier.GetItemString ( alLigne, "ALT_PCE" )
If	sAltPce = "O" And bRet Then
	bRet = Uf_Lire_Blob ( iblPce, "PC", alLigne )

	If	Not bRet	Then
		Uf_Gestion_Erreur ( 1, 3, alLigne )
	End If
End If

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration $$HEX1$$e900$$ENDHEX$$ventuelle du POST-SCRIPTUM.                        */
/*------------------------------------------------------------------*/
sAltPs = idw_LstDossier.GetItemString ( alLigne, "ALT_PS" )
If	sAltPs = "O" And bRet Then
	bRet = Uf_Lire_Blob ( iblPs, "PS", alLigne )

	If	Not bRet	Then
		Uf_Gestion_Erreur ( 1, 4, alLigne )
	End If
End If

Return ( bRet )
end function

private function boolean uf_ecrire_blob (ref blob ablblob, string astypblob, long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Archivage_Fn::Uf_Ecrire_Blob	(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 29/06/1999 17:16:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ecrire du blob sous la forme d'un fichier er archivage dans FileNet
//*
//* Arguments		: Blob			ablBlob				(R$$HEX1$$e900$$ENDHEX$$f)	Zone de stockage du BLOB
//* 					: String			asTypBlob			(Val)	Type du Blob (DT/PS/PC/CP)
//* 					: Long			alLigne				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la ligne en cours de traitement
//*
//* Retourne		: Boolean		Vrai	= L'$$HEX1$$e900$$ENDHEX$$criture est OK
//*										Faux	= L'$$HEX1$$e900$$ENDHEX$$criture pose probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

Long lLngTot, lPos, lDocId

String sIdSin, sIdInter, sIdDoc, sVal

Boolean bRet, bLng
String sFic
Integer iFic, iNbEcr, iCpt
Blob blResult

bRet	= False
bLng	= False

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les informations ID_SIN, ID_INTER, ID_DOC.           */
/*------------------------------------------------------------------*/
Choose Case isMoteur
Case "MSS"
	sIdSin		= String ( idw_LstDossier.GetItemNumber ( alLigne, "ID_SIN" ) )
	sIdInter		= String ( idw_LstDossier.GetItemNumber ( alLigne, "ID_INTER" ), "00" )
	sIdDoc		= String ( idw_LstDossier.GetItemNumber ( alLigne, "ID_DOC" ), "00" )

Case "GUP"
	sIdSin		= idw_LstDossier.GetItemString ( alLigne, "ID_SIN" )
	sIdInter		= String ( idw_LstDossier.GetItemString ( alLigne, "ID_INTER" ), "00" )
	sIdDoc		= String ( idw_LstDossier.GetItemString ( alLigne, "ID_DOC" ), "00" )
End Choose

/*------------------------------------------------------------------*/
/* On positionne le nom du fichier que l'on va ouvrir au format     */
/* ID_SIN + ID_INTER.ID_TYP_BLOB + ID_INTER (99999999.X99)          */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DT		-> (D)                                                     */
/* CP		-> (X)                                                     */
/* PC		-> (C)                                                     */
/* PS		-> (S)                                                     */
/*------------------------------------------------------------------*/
Choose Case asTypBlob
Case	"DT"
	sVal = "D"

Case "CP"
	sVal = "X"

Case "PC"
	sVal = "C"

Case "PS"
	sVal = "S"

End Choose

sFic			= isRepWinTemp + sIdSin + sIdInter + "." + sVal + sIdDoc

/*------------------------------------------------------------------*/
/* On ouvre le fichier, on positionne le nombre d'$$HEX1$$e900$$ENDHEX$$criture $$HEX2$$e0002000$$ENDHEX$$1.     */
/*------------------------------------------------------------------*/
iFic			= FileOpen ( sFic, StreamMode!, Write!, LockReadWrite!, Replace! )
iNbEcr		= 1

If	iFic > 0	Then
/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$termine la longueur du BLOB.                                */
/*------------------------------------------------------------------*/
	lLngTot 		= Len ( ablBlob )
	If	lLngTot	> 32765	Then
		bLng = True
/*------------------------------------------------------------------*/
/* Si cette longueur d$$HEX1$$e900$$ENDHEX$$passe 32765, on d$$HEX1$$e900$$ENDHEX$$termine le nombre          */
/* d'$$HEX1$$e900$$ENDHEX$$criture n$$HEX1$$e900$$ENDHEX$$cessaires dans le fichier.                          */
/*------------------------------------------------------------------*/
		If	Mod ( lLngTot, 32765 ) = 0	Then
			iNbEcr = lLngTot / 32765
		Else
			iNbEcr = Int ( lLngTot / 32765 ) + 1
		End If
	End If

/*------------------------------------------------------------------*/
/* On commence l'$$HEX1$$e900$$ENDHEX$$criture du BLOB dans le fichier.                  */
/*------------------------------------------------------------------*/
	lPos		= 1

	For	iCpt = 1 To iNbEcr
			If	lLngTot - lPos > 32765	Then
				blResult = BlobMid ( ablBlob, lPos, 32765 )
				FileWrite ( iFic, blResult )
			Else
				blResult = BlobMid ( ablBlob, lPos )
				FileWrite ( iFic, blResult )
			End If

			lPos += 32765
			FileSeek ( iFic, lPos, FromBeginning! )
	Next

/*------------------------------------------------------------------*/
/* On referme le fichier qui contient maintenant le BLOB.           */
/*------------------------------------------------------------------*/
	FileClose ( iFic )

/*------------------------------------------------------------------*/
/* On va $$HEX1$$e900$$ENDHEX$$crire le BLOB dans FileNet. Si la valeur du DOC_ID en     */
/* retour est n$$HEX1$$e900$$ENDHEX$$gative, on arr$$HEX1$$e900$$ENDHEX$$te tout, sinon on positionne cette   */
/* valeur dans la DW.                                               */
/*------------------------------------------------------------------*/

	lDocId = iuoFn.FN_Archive_Fichier ( sFic )

	If	lDocId > 0	Then
		bRet = True

		Choose Case asTypBlob
		Case "DT"
			idw_LstDossier.SetItem ( alLigne, "REF_DOC_DT", lDocId )

		Case "CP"
			idw_LstDossier.SetItem ( alLigne, "REF_DOC_CP", lDocId )

		Case "PC"
			idw_LstDossier.SetItem ( alLigne, "REF_DOC_PC", lDocId )

		Case "PS"
			idw_LstDossier.SetItem ( alLigne, "REF_DOC_PS", lDocId )

		End Choose
	End If
End If

/*------------------------------------------------------------------*/
/* On supprime le fichier qui contient le BLOB.                     */
/*------------------------------------------------------------------*/
If	Not bLng	Then
	FileDelete ( sFic )
End If

Return ( bRet )




end function

private function boolean uf_gestion_sql_archive (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gestion_Sql_Archive (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va $$HEX1$$e900$$ENDHEX$$crire les DOCID dans ARCHIVE 
//*
//* Arguments		: Long			alLigne			(Val) N$$HEX2$$b0002000$$ENDHEX$$de la ligne en cours de traitement
//*
//* Retourne		: Boolean			Vrai = Tout est OK
//*											Faux = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

Boolean bRet
Long lDocIdDt, lDocIdCp, lDocIdPc, lDocIdPs, lNbrSupp
Long dcIdSin, dcIdInter, dcIdDoc
String sProc

lDocIdDt 	= idw_LstDossier.GetItemNumber ( alLigne, "REF_DOC_DT" )
lDocIdCp 	= idw_LstDossier.GetItemNumber ( alLigne, "REF_DOC_CP" )
lDocIdPc 	= idw_LstDossier.GetItemNumber ( alLigne, "REF_DOC_PC" )
lDocIdPs 	= idw_LstDossier.GetItemNumber ( alLigne, "REF_DOC_PS" )

dcIdSin 		= idw_LstDossier.GetItemNumber ( alLigne, "ID_SIN" )
dcIdInter 	= idw_LstDossier.GetItemNumber ( alLigne, "ID_INTER" )
dcIdDoc 		= idw_LstDossier.GetItemNumber ( alLigne, "ID_DOC" )

If	Not IsNull ( lDocIdDt )	Then lNbrSupp ++
If	Not IsNull ( lDocIdCp )	Then lNbrSupp ++
If	Not IsNull ( lDocIdPc )	Then lNbrSupp ++
If	Not IsNull ( lDocIdPs )	Then lNbrSupp ++

sProc			= Space ( 60 )
bRet			= True

//itrTrans.PS_U01_ARCHIVE		(	dcIdSin,				&
//										dcIdInter,			&
//										dcIdDoc,				&
//										lDocIdDt,			&
//										lDocIdCp,			&
//										lDocIdPc,			&
//										lDocIdPs,			&
//										lNbrSupp,			&
//										sProc )

/*------------------------------------------------------------------*/
/* La zone sProc est pass$$HEX1$$e900$$ENDHEX$$e par r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence. Elle est arm$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$''      */
/* dans la proc$$HEX1$$e900$$ENDHEX$$dure. Si une erreur survient, on arme cette cha$$HEX1$$ee00$$ENDHEX$$ne  */
/* pour expliquer ou est survenue l'erreur.                         */
/*------------------------------------------------------------------*/
sProc = Trim ( sProc )

If	sProc <> "" Then bRet = False

/*------------------------------------------------------------------*/
/* Si SqlDbCode est arm$$HEX1$$e900$$ENDHEX$$, on part du principe qu'il y a eu une      */
/* erreur, et ce quel que soit la valeur de sProc.                  */
/*------------------------------------------------------------------*/
If itrTrans.SqlCode <> 0	Then bRet = False

/*------------------------------------------------------------------*/
/* On s'occupe maintenant du COMMIT, ou du ROLLBACK.                */
/*------------------------------------------------------------------*/
If	bRet	Then
		F_Commit ( itrTrans, True )
	Else
/*------------------------------------------------------------------*/
/* On charge les valeurs de la structure Message avec les valeurs   */
/* de itrTrans, avant de faire un ROLLBACK.                         */
/*------------------------------------------------------------------*/
		stMessage.sTitre		= "Archivage sur le syst$$HEX1$$e800$$ENDHEX$$me FileNet"
		stMessage.Icon			= StopSign!
		stMessage.Bouton		= OK!
		stMessage.bErreurG	= True

		stMessage.sVar[1] 	= sProc
		stMessage.sVar[2] 	= String ( itrTrans.SqlDbCode )
		stMessage.sVar[3] 	= itrTrans.SqlErrText
		stMessage.sVar[4] 	= String ( dcIdSin ) + " / " + String ( dcIdInter ) + " / " + String ( dcIdDoc )

		stMessage.sCode		= "FN0003"

/*------------------------------------------------------------------*/
/* On peut envoyer le ROLLBACK.                                     */
/*------------------------------------------------------------------*/
		F_Commit ( itrTrans, False )
/*------------------------------------------------------------------*/
/* On peut afficher le message sans risques.                        */
/*------------------------------------------------------------------*/
		F_Message ( stMessage )
End If

Return ( bRet )
end function

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Archivage_Fn::Constructor
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 29/06/1999 15:59:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On supprime l'instance pour la declaration FileNet
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On va initialiser le UserObject pour les fonctions FileNet.      */
/* Cette instance sera supprim$$HEX1$$e900$$ENDHEX$$e sur le DESTRUCTOR du NVUO.         */
/*------------------------------------------------------------------*/
iuoFn	= Create U_DeclarationFileNet

/*------------------------------------------------------------------*/
/* Gestion du fichier d'environnement. (Important pour la CLASSE    */
/* de document).                                                    */
/*------------------------------------------------------------------*/
isFicIniFileNet = ProfileString ( stGLB.sFichierIni, "FileNet", "REP_INI", "" )

iuoFn.FN_Lw_SetEnviron ( isFicIniFileNet )




end on

on destructor;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Archivage_Fn::Destructor
//* Evenement 		: Destructor
//* Auteur			: Erick John Stark
//* Date				: 29/06/1999 15:59:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On supprime l'instance pour la declaration FileNet
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On supprime toutes les r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences au NVUO sur FileNet.           */
/*------------------------------------------------------------------*/
Destroy iuoFn

/*------------------------------------------------------------------*/
/* On supprime toutes les r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences $$HEX2$$e0002000$$ENDHEX$$l'objet de TRANSACTION pour  */
/* les BLOBS. (S'il existe)                                         */
/*------------------------------------------------------------------*/
If	IsValid ( itrTransBlob )	Then
	Destroy itrTransBlob
End If




end on

on u_archivage_fn.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_archivage_fn.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

