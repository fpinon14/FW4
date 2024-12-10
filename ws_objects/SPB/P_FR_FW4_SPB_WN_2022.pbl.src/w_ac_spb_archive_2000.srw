$PBExportHeader$w_ac_spb_archive_2000.srw
$PBExportComments$---} Fenêtre ancêtre d'accueil de consultation sinistre, comprenant la gestion archive.
forward
global type w_ac_spb_archive_2000 from w_8_accueil_consultation
end type
end forward

global type w_ac_spb_archive_2000 from w_8_accueil_consultation
event ue_word pbm_custom35
end type
global w_ac_spb_archive_2000 w_ac_spb_archive_2000

type variables
Protected : 
	String			isFicEntete
	String			isFicConsult
	String			isFicConsultFinal

Private :
	U_DeclarationFileNet	iUoFn

	String			isFic[4]

end variables

forward prototypes
private subroutine wf_positionnerobjets ()
private function boolean wf_gestion_filenet (long alligne)
private function boolean wf_gestion_blob_lire (long alligne)
private function boolean wf_lire_blob (long aldocid, string astypblob, long alligne)
private function boolean wf_lire_fichier_fob (string asnomfic, ref blob ablBlob)
private subroutine wf_gestion_erreur (integer aitype, long alligne, long aldocid)
private subroutine wf_ecrire_trace_fn (boolean abret, long alligne)
protected subroutine wf_consultercourrier (string asrepcourrier, string asmodele, string asentete, string ascleedition)
end prototypes

on ue_word;call w_8_accueil_consultation::ue_word;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_archive
//* Evenement 		: Ue_Word
//* Auteur			: PLJ
//* Date				: 09/06/1998
//* Libellé			: Déclenche la consultation du courrier sélectionné.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* JFF			29/10/98 On ne Teste plus la présence d'un Word ouvert.
//*-----------------------------------------------------------------

Long		lNumlig			// N° de ligne sélectionnée.


lNumLig = Dw_3.GetRow ( )

If lNumLig >  0 And Dw_3.RowCount ( ) > 0 Then

	SetPointer ( HourGlass! )


	/*----------------------------------------------------------------------------*/
	/* On ne Teste plus la présence d'un WORD ouvert, car de toutes    				*/
	/* façons, la Création de l'objet WordBasic (et sa connexion), ouvrira un WORD*/
	/* s'il n'y en a pas d'ouvert, ou on utilisera le WORD ouvert s'il y en a un. */
	/* De cette façons, nous n'executons plus la macro "AperçuOff", qui ne s'exe- */
	/* cutait que si le modèle COURRIER.DOT était présent .								*/
	/* Ainsi l'utilisateur peut fermer le modèle sans fermer WORD, cela n'aura    */
	/* aucune incidence.																				*/
	/* ATTENTION : Si l'utilisateur laisse un document ouvert en mode APERCU, là	*/
	/* il y aura plantage lors de l'ouverture d'un prochain courrier, mais on ne	*/
	/* peut pas tester cela sans faire appel à une macro, dont le modèle où elle	*/
	/* se trouve, pourrait éventuellement ne pas être ouvert. 							*/
	/*																						JFF			*/
	/*----------------------------------------------------------------------------*/

//		If ( Not iuoCourrier.uf_initCourrier( stGlb, stMessage ) ) Then
//
//			stMessage.sTitre = "consultation des courriers"
//			stMessage.Icon  = Information!
//			stMessage.sCode = "PARA004"
//
//			f_Message ( stMessage )
//
//			return 
//
//		End If

End If

Wf_ConsulterCourrier ( "", "", "", "EDITION" )

SetPointer ( Arrow! )
end on

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_ac_si_dossier::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: PLJ
//* Date				: 29/04/1998
//* Libellé			: 
//* Commentaires	: On positionne et on taille tous les objets
//*                 sauf uo_1 qui est positionné et taillé
//*                 par son constructor
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne tous les objets nécessaires à la gestion, pour     */
/* faciliter le développement. (On peut bouger les objets).         */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Barre Onglet                                                     */
/*------------------------------------------------------------------*/
Uo_Onglet.X			=   19
Uo_Onglet.Y			=  197 + 1
Uo_Onglet.Height	=  109

/*------------------------------------------------------------------*/
/* Dw_1  DataWindow :                                               */
/*------------------------------------------------------------------*/
Dw_1.X			=   60
Dw_1.Y			=  365
Dw_1.Width		= 3490
Dw_1.Height		= 1269

/*------------------------------------------------------------------*/
/* Dw_2  DataWindow :                                               */
/*------------------------------------------------------------------*/
Dw_2.X    		= Dw_1.X	
Dw_2.Y			= Dw_1.Y
Dw_2.Width		= Dw_1.Width
Dw_2.Height		= Dw_1.Height


/*------------------------------------------------------------------*/
/* Dw_3  DataWindow : liste des dossiers en archive                 */
/*------------------------------------------------------------------*/
Dw_3.X    		= Dw_1.X	
Dw_3.Y			= Dw_1.Y
Dw_3.Width		= Dw_1.Width
Dw_3.Height		= Dw_1.Height


end subroutine

private function boolean wf_gestion_filenet (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Gestion_FileNet	(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 06/07/1999 11:33:12
//* Libellé			: 
//* Commentaires	: On va lire les BLOBS sur FileNet
//*
//* Arguments		: Long			alLigne				(Val)	N° de la ligne en cours de traitement
//*
//* Retourne		: Boolean		Vrai = Tout se passe bien
//*										Faux = Il y a un problème
//*
//*-----------------------------------------------------------------

Boolean bRet

String sFicIniFileNet
Long lRet, lCpt

/*------------------------------------------------------------------*/
/* On va initialiser le UserObject pour les fonctions FileNet.      */
/*------------------------------------------------------------------*/
If	Not IsValid ( iuoFn ) Then iUoFn	= Create U_DeclarationFileNet

/*------------------------------------------------------------------*/
/* Gestion du fichier d'environnement. (Important pour la CLASSE    */
/* de document).                                                    */
/*------------------------------------------------------------------*/
sFicIniFileNet = ProfileString ( stGLB.sFichierIni, "FileNet", "REP_INI", "" )

iuoFn.FN_Lw_SetEnviron ( sFicIniFileNet )

/*------------------------------------------------------------------*/
/* On se connecte sur le système FileNet en tant que SysAdmin.      */
/*------------------------------------------------------------------*/
lRet = iuoFn.FN_Logon ( "SysAdmin", "SysAdmin" )

For	lCpt = 1 To 5
		Yield ()
Next

If	lRet >= 0	Then
/*------------------------------------------------------------------*/
/* On arme le tableau pour les fichiers que l'on va lire sur        */
/* FileNet à NULL.                                                  */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To 4
			SetNull ( isFic[lCpt] )
	Next

	bRet = Wf_Gestion_Blob_Lire ( alLigne )
Else
/*------------------------------------------------------------------*/
/* On affiche un message d'erreur.                                  */
/*------------------------------------------------------------------*/
	Wf_Gestion_Erreur ( 2, 0, 0 )	
	bRet = False
End If

iuoFn.FN_Logoff ()

Return ( bRet )
end function

private function boolean wf_gestion_blob_lire (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Lire_Blob (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 07/01/1998 10:49:34
//* Libellé			: 
//* Commentaires	: Gestion des différents BLOBS
//*
//* Arguments		: Long			alLigne			(Val) N° de la ligne en cours de traitement
//*
//* Retourne		: Boolean			Vrai = Tout est OK
//*											Faux = Il y a un problème
//*
//*-----------------------------------------------------------------

Boolean bRet
String sAltPart, sAltPce, sAltPs
Long lDocId

/*------------------------------------------------------------------*/
/* Récupération systématique du blob des DATA.                      */
/*------------------------------------------------------------------*/
lDocId = dw_3.GetItemNumber ( alLigne, "REF_DOC_DT" )
bRet = wf_Lire_Blob ( lDocId, "DT", alLigne )

If	Not bRet	Then
	wf_Gestion_Erreur ( 1, alLigne, lDocId )
End If

/*------------------------------------------------------------------*/
/* Récupération éventuelle d'un COURRIER PARTICULIER.               */
/*------------------------------------------------------------------*/
sAltPart = dw_3.GetItemString ( alLigne, "ALT_PART" )
If	sAltPart = "O"	And bRet Then
	lDocId = dw_3.GetItemNumber ( alLigne, "REF_DOC_CP" )
	bRet = wf_Lire_Blob ( lDocId, "CP", alLigne )

	If	Not bRet	Then
		wf_Gestion_Erreur ( 1, alLigne, lDocId )
	End If
End If

/*------------------------------------------------------------------*/
/* Récupération éventuelle d'une AUTRE PIECE.                       */
/*------------------------------------------------------------------*/
sAltPce = dw_3.GetItemString ( alLigne, "ALT_PCE" )
If	sAltPce = "O" And bRet Then
	lDocId = dw_3.GetItemNumber ( alLigne, "REF_DOC_PC" )
	bRet = wf_Lire_Blob ( lDocId, "PC", alLigne )

	If	Not bRet	Then
		wf_Gestion_Erreur ( 1, alLigne, lDocId )
	End If
End If

/*------------------------------------------------------------------*/
/* Récupération éventuelle du POST-SCRIPTUM.                        */
/*------------------------------------------------------------------*/
sAltPs = dw_3.GetItemString ( alLigne, "ALT_PS" )
If	sAltPs = "O" And bRet Then
	lDocId = dw_3.GetItemNumber ( alLigne, "REF_DOC_PS" )
	bRet = wf_Lire_Blob ( lDocId, "PS", alLigne )

	If	Not bRet	Then
		wf_Gestion_Erreur ( 1, alLigne, lDocId )
	End If
End If

Return ( bRet )
end function

private function boolean wf_lire_blob (long aldocid, string astypblob, long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Lire_Blob	(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 29/06/1999 17:16:51
//* Libellé			: 
//* Commentaires	: Lecture du Blob dans FileNet
//*
//* Arguments		: Long			alDocId				(Val)	N° du DOC_ID
//* 					: String			asTypBlob			(Val)	Type du Blob (DT/PS/PC/CP)
//* 					: Long			alLigne				(Val)	N° de la ligne en cours de traitement
//*
//* Retourne		: Boolean		Vrai	= L'écriture est OK
//*										Faux	= L'écriture pose problème
//*
//*-----------------------------------------------------------------

Long lRet, lCpt
String sFic

Boolean bRet

bRet	= False

/*------------------------------------------------------------------*/
/* On récupére le BLOB de FileNet grace au DOC_ID.                  */
/*------------------------------------------------------------------*/
lRet = iuoFn.Fn_Recupere_Fichier ( alDocId, sFic )

/*------------------------------------------------------------------*/
/* Le fichier est de type FOB.                                      */
/*------------------------------------------------------------------*/
Choose Case asTypBlob
Case	"DT"
	isFic[1] = sFic

Case "CP"
	isFic[2] = sFic

Case "PC"
	isFic[3] = sFic

Case "PS"
	isFic[4] = sFic

End Choose

If	lRet >= 0	Then
	bRet = True
End If

/*------------------------------------------------------------------*/
/* On effectue une petite temporisation.                            */
/*------------------------------------------------------------------*/
For	lCpt = 1 To 10
		Yield ()
Next

Return ( bRet )




end function

private function boolean wf_lire_fichier_fob (string asnomfic, ref blob ablBlob);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Lire_Fichier_Fob	(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 06/07/1999 17:26:04
//* Libellé			: 
//* Commentaires	: Lecture du fichier pour le transformer en BLOB
//*
//* Arguments		: String			asNomFic				(Val)	Nom du fichier
//* 					: Blob			ablBlob				(Réf)	BLOB en retour
//*
//* Retourne		: Boolean		Vrai = La lecture se passe bien
//*										Faux = Il y a un problème
//*
//*-----------------------------------------------------------------

Integer iFic, iNbLec, iCpt
Long lLngTot, lPos, lNbLu
Boolean bRet

Blob blResult, blLect

iFic			= FileOpen ( asNomFic, StreamMode!, Read!, Shared! )
iNbLec		= 1

If	iFic > 0	Then
	bRet = True
/*------------------------------------------------------------------*/
/* On détermine la longueur du FICHIER FOB.                         */
/*------------------------------------------------------------------*/
	lLngTot 		= FileLength ( asNomFic )
	If	lLngTot	> 32765	Then

/*------------------------------------------------------------------*/
/* Si cette longueur dépasse 32765, on détermine le nombre          */
/* de lecture nécessaires dans le fichier.                          */
/*------------------------------------------------------------------*/
		If	Mod ( lLngTot, 32765 ) = 0	Then
			iNbLec = lLngTot / 32765
		Else
			iNbLec = Int ( lLngTot / 32765 ) + 1
		End If
	End If

/*------------------------------------------------------------------*/
/* On commence la lecture du fichier dans le BLOB.                  */
/*------------------------------------------------------------------*/
	lPos		= 1

	For	iCpt = 1 To iNbLec
			lNbLu 	= FileRead ( iFic, blLect )
			blResult = blResult + blLect
			lPos		= lPos + lNbLu

			FileSeek ( iFic, lPos, FromBeginning! )
	Next

/*------------------------------------------------------------------*/
/* On referme le fichier qui contient maintenant le BLOB.           */
/*------------------------------------------------------------------*/
	FileClose ( iFic )

	ablBlob = blResult

End If

Return ( bRet )



end function

private subroutine wf_gestion_erreur (integer aitype, long alligne, long aldocid);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Gestion_Erreur	(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 29/06/1999 17:32:36
//* Libellé			: 
//* Commentaires	: On gére l'affichage des les différentes erreurs
//*
//* Arguments		: Integer		aiType				(Val)	Type d'erreur
//* 					: Long			alLigne				(Val)	N° de la ligne en cours de traitement
//* 					: Long			alDocId				(Val)	N° du DOCID
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

stMessage.sTitre		= "Consultation sur le système FileNet"
stMessage.Icon			= Information!
stMessage.Bouton		= OK!
stMessage.bErreurG	= TRUE

Choose	Case aiType
Case 1					// Erreur sur la lecture des BLOBS

	stMessage.sCode	= "FN0005"
	stMessage.sVar[1] = String ( alDocId )

Case 2					// Impossible de se connecter sur le système

	stMessage.sCode	= "FN0006"

End Choose

F_Message ( stMessage )


end subroutine

private subroutine wf_ecrire_trace_fn (boolean abret, long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Ecrire_Trace_FN ( Private )
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 14:57:25
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: Boolean		abRet				(Val) Les opérations FileNet se sont-elles bien passées ?
//* 					: Long			alLigne			(Val) N° de la ligne en cours de traitement
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lTot, lCpt
//U_DeclarationFuncky	uoDeclarationFuncky

String sTrace[5]
String sLigne, sTab, sNomMachine, sRep, sFicTrace

/*------------------------------------------------------------------*/
/* On va ecrire une trace dans le fichier.                          */
/* Cette trace contient dans l'ordre                                */
/*                                                                  */
/* COD_APPLI						01                                    */
/* N° Machine						02                                    */
/* COD_SERVICE						03                                    */
/* ID_SIN							04                                    */
/* ETAT FN							05                                    */
/*------------------------------------------------------------------*/

sTab = "~t"
lTot = UpperBound ( sTrace )

/*------------------------------------------------------------------*/
/* On récupére maintenant le nom de la machine. On part du principe */
/* que ce nom est positionné dans la valeur Dos (SQL=XXX)           */
/*------------------------------------------------------------------*/
//uoDeclarationFuncky = Create u_DeclarationFuncky
//[I037] Migration FUNCKy
//sNomMachine = uoDeclarationFuncky.Uf_GetEnv ( "SQL" )
sNomMachine = stGlb.uoWin.uf_getenvironment("SQL")
//Destroy uoDeclarationFuncky

/*------------------------------------------------------------------*/
/* On initialise maintenant le nom du fichier de TRACE au format    */
/* JJMMAAAA.App (App correspond au code de l'application).          */
/* Pour connaitre le répertoire qui contient le fichier de TRACE,   */
/* il faut lire la section TRACE du fichier INI de l'application.   */
/*------------------------------------------------------------------*/
sRep 			= ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_FN", "" )
sFicTrace	= sRep + String ( Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )

sTrace[ 1 ]  = stGLB.sCodAppli
sTrace[ 2 ]  = sNomMachine
sTrace[ 3 ]  = stGLB.sCodServ
sTrace[ 4 ]  = String ( dw_3.GetItemNumber ( alLigne, "ID_SIN" ) )
If	abRet Then
	sTrace[ 5 ]  = "1"
Else
	sTrace[ 5 ]  = "-1"
End If

sLigne	= ""
/*------------------------------------------------------------------*/
/* On vérifie qu'il n'y ait plus de chaîne nulle.                   */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot
		If	IsNull ( sTrace[ lCpt ] ) Or sTrace[ lCpt ] = "''" Then
			sTrace[ lCpt ] = ""
		End If
Next

/*------------------------------------------------------------------*/
/* On traite les N-1 valeurs, puis la dernière. Pour terminer, on   */
/* ecrit la ligne                                                   */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lTot - 1
		sLigne = sLigne + sTrace[ lCpt ] + sTab
Next

sLigne = sLigne + sTrace[ lTot ]

f_EcrireFichierText ( sFicTrace, sLigne )

end subroutine

protected subroutine wf_consultercourrier (string asrepcourrier, string asmodele, string asentete, string ascleedition);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_ConsulterCourrier
//* Auteur			: PLJ
//* Date				: 09/06/1998 
//* Libellé			: Permet de consulter le courrier sélectionné dans dw_3 (datawindow des sinistres).
//* Commentaires	: 
//*
//* Arguments		: String			asRepCourrier		Répertoire à utiliser pour les courriers
//*					  String			asModele				Modèle à utiliser pour les courriers
//*					  String			asEntete				Entete à utiliser pour les courriers
//*					  String			asCleEdition		Valeur de la CLE pour l'édition
//*
//* Retourne		: Integer			 1	= Tout est OK
//*											-1	= Il y a un probléme
//*
//*-----------------------------------------------------------------
//* N° Modif          Reçue Le          Effectuée Le          PAR
//* [PI087] FS le 08/04/2020 Ecriture de la trace de consultation
//*	
//*-----------------------------------------------------------------
 
String	sIdCour			// Identifiant du courrier composé.
String	sAltPart			// Indique s'il s'agit d'un courrier divers ou particulier.
String	sAltPce			// Indique s'il y a une autre piece.
String	sAltPs			// Indique s'il y a un post scriptum.
Long		lIdSin			// Identifiant du sinistre
Long		lIdInter			// Identifiant interlocuteur
Long		lIdDoc			// Identifiant du document archivé.
String	sTxtCompo		// Composition.
String	sTxtCompo1		// Première partie de la composition.
String	sTxtCompo2		// Deuxième partie de la composition.
String	sDteEdit			// Date d'édition du courrier.
Blob		bTxtblob			// Blob contenant le texte des variables.
Long		lDocPrincipal, lCpt
String	sFic
Blob		blFicConsult

Boolean bRet

//Migration PB8-WYNIWYG-03/2006 FM
boolean	lb_ac
//Fin Migration PB8-WYNIWYG-03/2006 FM

Long		lNumlig			// N° de ligne sélectionnée.

N_Cst_Edition_Courrier	nvEditionCourrier

nvEditionCourrier = CREATE N_Cst_Edition_Courrier

lNumLig = Dw_3.GetRow ( )

/*------------------------------------------------------------------*/
/* On vérifie s'il existe des documents ouverts dans WORD.          */
/*------------------------------------------------------------------*/
If	nvEditionCourrier.uf_Verifier_Word_AvantGeneration ( FALSE ) < 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//	DESTROY nvEditionCourrier
	If IsValid(nvEditionCourrier) Then DESTROY nvEditionCourrier
//Fin Migration PB8-WYNIWYG-03/2006 FM
	Return
End If

/*------------------------------------------------------------------*/
/* On initialise le NVUO pour la gestion des courriers.             */
/*------------------------------------------------------------------*/
nvEditionCourrier.uf_Initialiser ( "C" )
/*------------------------------------------------------------------*/
/* On se connecte à WORD.                                           */
/*------------------------------------------------------------------*/
nvEditionCourrier.uf_InitialiserWord ( FALSE )
/*------------------------------------------------------------------*/
/* On supprime le dernier fichier consulté.                         */
/*------------------------------------------------------------------*/
FileDelete ( isFicConsult )
/*------------------------------------------------------------------*/
/* Si le dernier fichier consulté existe toujours, on arrête tout.  */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//If	FileExists ( isFicConsult ) Then 
If	f_FileExists ( isFicConsult ) Then 
//Fin Migration PB8-WYNIWYG-03/2006 CP

//Migration PB8-WYNIWYG-03/2006 FM
//	DESTROY nvEditionCourrier
	If IsValid(nvEditionCourrier) Then DESTROY nvEditionCourrier
//Fin Migration PB8-WYNIWYG-03/2006 FM
	Return
End If
/*------------------------------------------------------------------*/
/* On s'occupe des valeurs particulières du courrier. Faut-il       */
/* sauvegarder le courrier ?. Faut-il éditer le courrier ?.         */
/* Faut-il positionner la mise souspli ?.                           */
/*------------------------------------------------------------------*/
nvEditionCourrier.uf_InscrireParamCourrier ( isFicConsult, "O", "N", "N" )
/*------------------------------------------------------------------*/
/* On initialise les valeurs particulières pour RepCourrier,        */
/* Modele et Entete.                                                */
/*------------------------------------------------------------------*/
nvEditionCourrier.uf_Inscrire_Valeur_Differentes ( asRepCourrier, asModele, asEntete )
/*------------------------------------------------------------------*/
/* On arme la valeur pour la cle d'édition.                         */
/*------------------------------------------------------------------*/
If IsNull ( asCleEdition ) Or Len ( Trim ( asCleEdition ) ) = 0	Then asCleEdition = "EDITION"
nvEditionCourrier.uf_Cle_Edition_FichierIni ( asCleEdition )


If lNumLig >  0 And Dw_3.RowCount ( ) > 0 Then

	lIdSin 	= Dw_3.GetitemNumber  ( lNumLig, "ID_SIN"   )
	lIdInter	= Dw_3.GetitemNumber  ( lNumLig, "ID_INTER" )
	lIdDoc	= Dw_3.GetitemNumber  ( lNumLig, "ID_DOC"   )
	sIdCour	= Dw_3.GetitemString  ( lNumLig, "ID_COUR"  )
	
	If IsNull ( sIdCour ) Then
		sIdCour = ""
	End If

	//sDteEdit	= f_Txt_Date ( Dw_3.GetItemDate ( lNumLig, "DTE_EDIT" ) )
	sDteEdit	= f_Txt_Date ( Date(Dw_3.GetItemDateTime ( lNumLig, "DTE_EDIT" )) ) // [PI056]
	
	sAltPart		= Dw_3.GetITemString ( lNumLig, "ALT_PART" )
	sAltPce		= Dw_3.GetITemString ( lNumLig, "ALT_PCE"  )
	sAltPs		= Dw_3.GetITemString ( lNumLig, "ALT_PS"   )
	
	sTxtCompo1	=	Dw_3.GetitemString ( lNumLig, "TXT_COMPO1" )
	sTxtCompo2	=	Dw_3.GetitemString ( lNumLig, "TXT_COMPO2" )

/*------------------------------------------------------------------*/
/* On ouvre le document principal. Ce document utilise l'entête     */
/* standard pour les datas.                                         */
/*------------------------------------------------------------------*/
	lDocPrincipal = nvEditionCourrier.uf_OuvrirDocument ( sIdCour, isFicEntete )

	If sAltPart = "O" Then
		/*------------------------------------------------------------------*/
		/* dans le cas d'un courrier particulier il n'y a que "PART.SPB"    */
		/* dans txt_compo1.                                                 */
		/*------------------------------------------------------------------*/
		sTxtCompo = sTxtCompo1
	Else
		If IsNull ( sTxtCompo2 ) Then	sTxtCompo2 = ""
		sTxtCompo = sTxtCompo1 + sTxtCompo2
	End If

	/*------------------------------------------------------------------*/
	/* On compose le courrier                                           */
	/*------------------------------------------------------------------*/
	nvEditionCourrier.uf_InscrireComposition ( lDocPrincipal, sTxtCompo )

	If sAltPart = "O" Then
		If	IsNull ( isFic[2]	) Then	
//Migration PB8-WYNIWYG-03/2006 FM
			lb_ac = itrtrans.AutoCommit
			itrtrans.AutoCommit = True
//Fin Migration PB8-WYNIWYG-03/2006 FM
			SELECTBLOB 	txt_blob
					INTO	:bTxtBlob
					FROM	sysadm.archive_blob
				  WHERE  sysadm.archive_blob.id_sin      = :lidsin 
					 AND	sysadm.archive_blob.id_inter    = :lidinter 
					 AND	sysadm.archive_blob.id_doc      = :liddoc
					 AND	sysadm.archive_blob.id_typ_blob = 'CP'
				  USING	itrtrans	;	
			
//Migration PB8-WYNIWYG-03/2006 FM
			itrtrans.AutoCommit = lb_ac
//Fin Migration PB8-WYNIWYG-03/2006 FM
					bRet = True
		Else
			sFic = isFic[2]
			bRet = Wf_Lire_Fichier_FOB ( sFic, bTxtBlob )
		End If

		If itrtrans.SQLCode <> 0 Or bRet = False Then

			stMessage.sTitre	=	"Consultation des courriers"
			stMessage.Icon		=	Information!
			stMessage.sCode	=	"COUR002"

			f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//			DESTROY nvEditionCourrier
			If IsValid(nvEditionCourrier) Then DESTROY nvEditionCourrier
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Return
		End If

/*------------------------------------------------------------------*/
/* Gestion du courrier particulier.                                 */
/*------------------------------------------------------------------*/
		nvEditionCourrier.uf_GenererBlob ( lDocPrincipal, "PART", bTxtBlob )

	ElseIf sAltPce = "O" Or sAltPs = "O" Then

		If sAltPce = "O"	Then
			If	IsNull ( isFic[3]	) Then	
//Migration PB8-WYNIWYG-03/2006 FM
			lb_ac = itrtrans.AutoCommit
			itrtrans.AutoCommit = True
//Fin Migration PB8-WYNIWYG-03/2006 FM
				SELECTBLOB	txt_blob
						INTO	:bTxtBlob
						FROM	sysadm.archive_blob
					  WHERE  sysadm.archive_blob.id_sin      = :lidsin 
				 		 AND	sysadm.archive_blob.id_inter    = :lidinter 
					 	 AND	sysadm.archive_blob.id_doc      = :liddoc
						 AND	sysadm.archive_blob.id_typ_blob = 'PC'
					  USING	itrtrans	;	
//Migration PB8-WYNIWYG-03/2006 FM
			itrtrans.AutoCommit = lb_ac
//Fin Migration PB8-WYNIWYG-03/2006 FM

						bRet = True
			Else
				sFic = isFic[3]
				bRet = Wf_Lire_Fichier_FOB ( sFic, bTxtBlob )
			End If

			If itrtrans.SQLCode <> 0 Or bRet = False Then

				stMessage.sTitre	=	"Consultation des courriers"
				stMessage.Icon		=	Information!
				stMessage.sCode	=	"COUR003"

				f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//				DESTROY nvEditionCourrier
				If IsValid(nvEditionCourrier) Then DESTROY nvEditionCourrier
//Fin Migration PB8-WYNIWYG-03/2006 FM
				Return

			End If
/*------------------------------------------------------------------*/
/* Gestion du paragraphe AUTRE PIECE.                               */
/*------------------------------------------------------------------*/
			nvEditionCourrier.uf_GenererBlob ( lDocPrincipal, "PIEC", bTxtBlob )
		End If

		If sAltPs = "O" Then
			If	IsNull ( isFic[4]	) Then	
//Migration PB8-WYNIWYG-03/2006 FM
			lb_ac = itrtrans.AutoCommit
			itrtrans.AutoCommit = True
//Fin Migration PB8-WYNIWYG-03/2006 FM
				SELECTBLOB	txt_blob
						INTO	:bTxtBlob
						FROM	sysadm.archive_blob
					  WHERE  sysadm.archive_blob.id_sin      = :lidsin 
					    AND	sysadm.archive_blob.id_inter    = :lidinter 
				   	 AND	sysadm.archive_blob.id_doc      = :liddoc
						 AND	sysadm.archive_blob.id_typ_blob = 'PS'
					  USING	itrtrans	;	
//Migration PB8-WYNIWYG-03/2006 FM
			itrtrans.AutoCommit = lb_ac
//Fin Migration PB8-WYNIWYG-03/2006 FM

						bRet = True
			Else
				sFic = isFic[4]
				bRet = Wf_Lire_Fichier_FOB ( sFic, bTxtBlob )
			End If

			If itrtrans.SQLCode <> 0 Or bRet = False Then

				stMessage.sTitre	=	"Consultation des courriers"
				stMessage.Icon		=	Information!
				stMessage.sCode	=	"COUR004"

				f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//				DESTROY nvEditionCourrier
				If IsValid(nvEditionCourrier) Then DESTROY nvEditionCourrier
//Fin Migration PB8-WYNIWYG-03/2006 FM
				Return

			End If
/*------------------------------------------------------------------*/
/* Gestion du paragraphe POST-SCRITUM.                              */
/*------------------------------------------------------------------*/
			nvEditionCourrier.uf_GenererBlob ( lDocPrincipal, "POST", bTxtBlob )
		End If

	End If

	/*------------------------------------------------------------------*/
	/* On prépare les variables.                                        */
	/*------------------------------------------------------------------*/
	If	IsNull ( isFic[1]	) Then

//Migration PB8-WYNIWYG-03/2006 FM
			lb_ac = itrtrans.AutoCommit
			itrtrans.AutoCommit = True
//Fin Migration PB8-WYNIWYG-03/2006 FM
		SELECTBLOB	txt_blob
			INTO	:bTxtBlob
			FROM	sysadm.archive_blob
			WHERE sysadm.archive_blob.id_sin      = :lidsin 
			  AND	sysadm.archive_blob.id_inter    = :lidinter 
			  AND	sysadm.archive_blob.id_doc      = :liddoc
			  AND	sysadm.archive_blob.id_typ_blob = 'DT'
		USING	itrtrans	;	
//Migration PB8-WYNIWYG-03/2006 FM
			itrtrans.AutoCommit = lb_ac
//Fin Migration PB8-WYNIWYG-03/2006 FM

		bRet = True

	Else
		sFic = isFic[1]
		bRet = Wf_Lire_Fichier_FOB ( sFic, bTxtBlob )
	End If

	If itrtrans.SQLCode <> 0 Or bRet = False Then

		stMessage.sTitre	=	"Consultation des courriers"
		stMessage.Icon		=	Information!
		stMessage.sCode	=	"COUR005"

		f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//		DESTROY nvEditionCourrier
		If IsValid(nvEditionCourrier) Then DESTROY nvEditionCourrier
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Return

	Else
/*------------------------------------------------------------------*/
/* On prépare les varaiables.                                       */
/*------------------------------------------------------------------*/
		nvEditionCourrier.uf_GenererData ( lDocPrincipal, bTxtBlob )

/*------------------------------------------------------------------*/
/* On positionne la date d'édition du courrier dans le fichier      */
/* INI. Section=[COURRIER], Cle=DTE_EDIT.                           */
/*------------------------------------------------------------------*/
		nvEditionCourrier.Uf_Inscrire_DteEdition_Courrier ( sDteEdit )
/*------------------------------------------------------------------*/
/* On lance la MACRO qui va recomposer le document.                 */
/*------------------------------------------------------------------*/
		nvEditionCourrier.uf_Imprimer ( "" )
/*------------------------------------------------------------------*/
/* On attend la création du fichier isFicConsult (CONSUULT.DOC)     */
/* dans le répertoire temporaire de WINDOWS.                        */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP		
//		Do While Not FileExists ( isFicConsult ) Or lCpt = 5000
		Do While Not f_FileExists ( isFicConsult ) Or lCpt = 5000
//Fin Migration PB8-WYNIWYG-03/2006 CP			
			
			Yield ()
			lCpt ++
		Loop
/*------------------------------------------------------------------*/
/* On va renommer le fichier isFicConsult afin de pouvoir ouvrir    */
/* le nouveau fichier et supprimer isFicConsult.                    */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP		
//		If	FileExists ( isFicConsult )	Then
		If	f_FileExists ( isFicConsult )	Then
//Fin Migration PB8-WYNIWYG-03/2006 CP			
			
			SetNull ( blFicConsult )
			FileDelete ( isFicConsultFinal )
			F_LireFichierBlob ( blFicConsult, isFicConsult )
			F_EcrireFichierBlob ( blFicConsult, isFicConsultFinal )
/*------------------------------------------------------------------*/
/* On ouvre le fichier et on agrandit la fenêtre WORD.              */
/*------------------------------------------------------------------*/
			nvEditionCourrier.uf_Envoyer_Commande ( 9, isFicConsultFinal )
		End If
	End If
End If

nvEditionCourrier.uf_FermerDocument ( lDocPrincipal )
//Migration PB8-WYNIWYG-03/2006 FM
//DESTROY nvEditionCourrier
If IsValid(nvEditionCourrier) Then DESTROY nvEditionCourrier
//Fin Migration PB8-WYNIWYG-03/2006 FM


//Migration PB8-WYNIWYG-03/2006 FM
return
//Fin Migration PB8-WYNIWYG-03/2006 FM

end subroutine

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_archiver
//* Evenement 		: ue_modifier
//* Auteur			: PLJ
//* Date				: 09/06/1998
//* Libellé			: Appel des fenêtres de consultation
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		  Modification
//      JFF    03/11/2015 [PM260]
//*-----------------------------------------------------------------

s_Pass stPass

stPass = istpass
Boolean bRet
Long lCpt, lRefDocDt, ValclePm260, lIdSin 
Date dDteArchiv
String sIdSin, sIdInter, sIdDoc, sMajPar, sSql, sDteAnonymisation
DateTime dtMajLe



Choose Case iuAccueilCourrant

	Case dw_3		// .... Consultation des courriers

			// [PM260]
			If Left ( SQLCA.DataBase, 6 ) = "SIMPA2" Then
				sIdSin = String ( dw_3.GetItemNumber ( dw_3.ilLigneClick, "ID_SIN" ) )
				sDteAnonymisation = Space ( 35 )
				lIdSin = Long ( sIdSin )


				Select IsNull ( CONVERT ( VarChar (35), val_dte , 103 ), '' ) 
				Into   :sDteAnonymisation 
				From	 sysadm.div_sin 
				Where   id_sin = :lIdSin
				And     nom_zone = "dte_anonymisation"				
				Using SQLCA ;
		
				
				sDteAnonymisation = Trim ( sDteAnonymisation )
				If Not IsNull ( sDteAnonymisation ) And Len ( sDteAnonymisation ) > 0 Then
					
					stMessage.sTitre	=	"PM260 : Dossier anonymisé"
					stMessage.icon		=	Information!
					stMessage.sCode	=	"COUR009"
					stMessage.sVar[1] = sDteAnonymisation

					f_Message ( stMessage )
					bRet = False
					SetPointer ( Arrow! )
					Return
				End If 
			End If 
			// :[PM260]

		SetPointer( HourGlass! )

		
		If Dw_3.ilLigneClick > 0 Then

			//If ( isNull ( Dw_3.GetItemDate ( Dw_3.ilLigneClick, "DTE_ARCHIV" ) ) ) Then
			If ( isNull ( Dw_3.GetItemDateTime ( Dw_3.ilLigneClick, "DTE_ARCHIV" ) ) ) Then // [PI056]

				// [PM260]
				If Left ( SQLCA.DataBase, 6 ) = "SIMPA2" Then
					sIdSin = String ( dw_3.GetItemNumber ( dw_3.ilLigneClick, "ID_SIN" ) )
					sDteAnonymisation = Space ( 35 )
					lIdSin = Long ( sIdSin )


					Select IsNull ( CONVERT ( VarChar (35), val_dte , 103 ), '' ) 
					Into   :sDteAnonymisation 
					From	 sysadm.div_sin 
					Where   id_sin = :lIdSin
					And     nom_zone = "dte_anonymisation"				
					Using SQLCA ;
			
					
					sDteAnonymisation = Trim ( sDteAnonymisation )
					If Not IsNull ( sDteAnonymisation ) And Len ( sDteAnonymisation ) > 0 Then
						
						stMessage.sTitre	=	"PM260 : Dossier anonymisé"
						stMessage.icon		=	Information!
						stMessage.sCode	=	"COUR009"
						stMessage.sVar[1] = sDteAnonymisation
	
						f_Message ( stMessage )
						bRet = False
						SetPointer ( Arrow! )
						Return
					End If 
				End If 
				// :[PM260]

/*------------------------------------------------------------------*/
/* Il faut mettre à NULL le tableau pour les fichiers. Il faudra    */
/* enlever ces commentaires dans le futur.                          */
/*------------------------------------------------------------------*/
				For	lCpt = 1 To 4
						SetNull ( isFic[lCpt] )
				Next

				TriggerEvent ( "Ue_Word" )

			Else
/*------------------------------------------------------------------*/
/* Le 16/03/2003.                                                   */
/* Pour la base SIMPA2, les courriers 2001 et 2002 sont             */
/* positionnés dans une base SIMPA2BLOB_PRO. La zone DTE_ARCHIV de  */
/* la table ARCHIVE est positionnée avec la valeur 01/06/2003. La   */
/* zone REF_DOC_DT est positionnée à 1 dans la table ARCHIVE.       */
/* On va appeler la procédure stockée qui va insérer les lignes     */
/* (DT,PS,PC,CP) correspondantes de la base SIMPA2BLOB_PRO(Table    */
/* archive_blob) dans la base SIMPA2_PRO(Table archive_blob). De    */
/* plus, un trace sera positionnée dans la table                    */
/* W_TRC_ARCHIVE_RECUP. (Base SIMPA2_PRO)                           */
/*------------------------------------------------------------------*/
				//dDteArchiv	= dw_3.GetItemDate ( dw_3.ilLigneClick, "DTE_ARCHIV" ) // [PI056] Mis en commentaire - var inutile
				
				lRefDocDt	= dw_3.GetItemNumber ( dw_3.ilLigneClick, "REF_DOC_DT" )
/*------------------------------------------------------------------*/
/* Pour le moment, je teste uniquement la date du 01/06/2003.       */
/*------------------------------------------------------------------*/
/* Suite traitement de fin 08/2004, je ne teste plus la DTE_ARCHIV  */
/* mais uniquement REF_DOC_DT.                                      */
/*------------------------------------------------------------------*/
//				If	dDteArchiv = Date ( "01/06/2003" ) And lRefDocDt = 1	Then

				If	lRefDocDt = 1	Then
					sIdSin	= String ( dw_3.GetItemNumber ( dw_3.ilLigneClick, "ID_SIN" ) )
					sIdInter = String ( dw_3.GetItemNumber ( dw_3.ilLigneClick, "ID_INTER" ) )
					sIdDoc	= String ( dw_3.GetItemNumber ( dw_3.ilLigneClick, "ID_DOC" ) )
					sMajPar	= stGLB.sCodOper

					sSql = "EXECUTE sysadm.PS_I01_RECUPERER_ARCHIVE " + sIdSin + " ," + sIdInter + " ," + sIdDoc + " ,'" + sMajPar + "'"
					bRet = F_Execute ( sSql, itrTrans )

					F_Commit ( itrTrans, bRet )
				End If
				
/*------------------------------------------------------------------*/
/* Le 10/10/2007.                                                   */
/* Ajout d'une nouvelle procédure PS_I01_RECUPERER_ARCHIVE_V01 pour */
/* traiter les nouveaux courriers archivés.                         */
/*------------------------------------------------------------------*/
				If	lRefDocDt > 1	Then
					sIdSin	= String ( dw_3.GetItemNumber ( dw_3.ilLigneClick, "ID_SIN" ) )
					sIdInter = String ( dw_3.GetItemNumber ( dw_3.ilLigneClick, "ID_INTER" ) )
					sIdDoc	= String ( dw_3.GetItemNumber ( dw_3.ilLigneClick, "ID_DOC" ) )
					sMajPar	= stGLB.sCodOper

					sSql = "EXECUTE sysadm.PS_I01_RECUPERER_ARCHIVE_V01 " + sIdSin + " ," + sIdInter + " ," + sIdDoc + " ,'" + sMajPar + "'"
					bRet = F_Execute ( sSql, itrTrans )

					F_Commit ( itrTrans, bRet )
				End If				

//				bRet = Wf_Gestion_FileNet ( dw_3.ilLigneClick )
///*------------------------------------------------------------------*/
///* On génére une TRACE du passage sous FileNet.                     */
///*------------------------------------------------------------------*/
//				Wf_Ecrire_Trace_FN ( bRet, dw_3.ilLigneClick )
//
//				If	bRet	Then
//					TriggerEvent ( "Ue_Word" )
//				End If


/*------------------------------------------------------------------*/
/* On n'affiche pas le message si la récupération du courrier       */
/* vient de réussir. Et on appelle la génération 'normale' du       */
/* courrier.                                                        */
/*------------------------------------------------------------------*/
				If	Not bRet	Then			
					stMessage.sTitre	=	"Consultation des courriers"
					stMessage.icon		=	Information!
					stMessage.sCode	=	"COUR007"

					f_Message ( stMessage )
				Else
/*------------------------------------------------------------------*/
/* Il ne faut pas oublier de positionner la valeur actuelle de la   */
/* zone DTE_ARCHIV à NULL, au cas ou le gestionnaire clique à       */
/* nouveau sur le courrier.                                         */
/*------------------------------------------------------------------*/
					dw_3.SetItem ( dw_3.ilLigneClick, "DTE_ARCHIV", stNul.dat )
					dw_3.SetItem ( dw_3.ilLigneClick, "REF_DOC_DT", stNul.lng )

					For	lCpt = 1 To 4
							SetNull ( isFic[lCpt] )
					Next

					TriggerEvent ( "Ue_Word" )
				End If
			End If
		End If
	
		SetPointer ( Arrow! )
End Choose

end event

on close;call w_8_accueil_consultation::close;//*-----------------------------------------------------------------
//*
//* Objet 			:	W_ac_spb_archive
//* Evenement 		:	Close
//* Auteur			:	PLJ
//* Date				:	12/06/1998
//* Libellé			:	Opérations à effectuer à la fermeture de la 
//*					 	fenêtre 
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  PLJ 17/12/2001  Si un document word est ouvert avec des modifications
//*                     Mettre un message d'avertissement pas de abFermer_sans_verifier de TRUE --> FALSE				  
//*-----------------------------------------------------------------

N_Cst_Edition_Courrier	nvEditionCourrier

/*------------------------------------------------------------------*/
/* On supprime la référence au NVUO FileNet si elle existe.         */
/*------------------------------------------------------------------*/
If	IsValid ( iuoFn )						Then Destroy 	iuoFn


/*------------------------------------------------------------------*/
/* On ferme tous les documents qui restent ouverts dans WORD.       */
/*------------------------------------------------------------------*/
nvEditionCourrier = CREATE N_Cst_Edition_Courrier

/*------------------------------------------------------------------*/
/* On vérifie s'il existe des documents ouverts dans WORD.          */
/*------------------------------------------------------------------*/
nvEditionCourrier.uf_Verifier_Word_AvantGeneration ( FALSE )  //#1

DESTROY nvEditionCourrier
end on

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_archive
//* Evenement 		: ue_initialiser - Extend
//* Auteur			: PLJ
//* Date				: 09/06/1998
//* Libellé			: Ouverture de la fenêtre d'accueil
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF		06/07/99 Modification du tri suite à la demande de Denis.
//* #2 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//* #3  PHG		14/11/2006 [DNTMAIL1-2] Point 8 spécification Focntionelle				  
//*-----------------------------------------------------------------


String sRepCourrier, sEntete

String sTables [ ]			// Tables du SELECT
String sBmpMail = ''			// #3 [DNTMAIL1-2] Point 8 spécification Focntionelle
String sbmpWord = ''			// #3 [DNTMAIL1-2] Point 8 spécification Focntionelle
/*------------------------------------------------------------------*/
/*   Positionnement des objets sur la fenêtre d'accueil             */
/*------------------------------------------------------------------*/

wf_PositionnerObjets()


/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil des dossiers en archive         */
/*------------------------------------------------------------------*/

iTrTrans = SQLCA


/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil des dossiers en constitution    */
/*------------------------------------------------------------------*/


dw_3.istCol[1].sDbName			=	"sysadm.produit.lib_court"
dw_3.istCol[1].sResultSet		=	"lib_court"
dw_3.istCol[1].sType				=	"Char(20)"
dw_3.istCol[1].sHeaderName		=	"Produit"
dw_3.istCol[1].ilargeur			=	19
dw_3.istCol[1].sAlignement		=	"0"
dw_3.istCol[1].sInvisible		= 	"N"

dw_3.istCol[2].sDbName			=	"sysadm.archive.id_sin"
dw_3.istCol[2].sResultSet		=	"id_sin"
dw_3.istCol[2].sType				=	"number"
dw_3.istCol[2].sHeaderName		=	"Sinistre"
dw_3.istCol[2].ilargeur			=	10  // [PI062]
dw_3.istCol[2].sAlignement		=	"2"
dw_3.istCol[2].sInvisible		= 	"N"

dw_3.istCol[3].sDbName			=	"sysadm.archive.id_inter"
dw_3.istCol[3].sResultSet		=	"id_inter"
dw_3.istCol[3].sType				=	"number"
dw_3.istCol[3].sHeaderName		=	"Interlocuteur"
dw_3.istCol[3].ilargeur			=	7
dw_3.istCol[3].sAlignement		=	"2"
dw_3.istCol[3].sInvisible		= 	"O"

dw_3.istCol[4].sDbName		=	"RTrim ( sysadm.personne.nom ) + ' ' + sysadm.personne.prenom"
dw_3.istCol[4].sResultSet	=	"Assure"
dw_3.istCol[4].sType			=	"char(70)"
dw_3.istCol[4].sHeaderName	=	"Assuré"
dw_3.istCol[4].ilargeur		=	20
dw_3.istCol[4].sAlignement	=	"0"
dw_3.istCol[4].sInvisible	= 	"N"

dw_3.istCol[5].sDbName			=	"sysadm.archive.id_doc"
dw_3.istCol[5].sResultSet		=	"id_doc"
dw_3.istCol[5].sType				=	"number"
dw_3.istCol[5].sHeaderName		=	"document"
dw_3.istCol[5].ilargeur			=	7
dw_3.istCol[5].sAlignement		=	"2"
dw_3.istCol[5].sInvisible		= 	"O"

dw_3.istCol[6].sDbName			=	"sysadm.archive.cod_inter"
dw_3.istCol[6].sResultSet		=	"cod_inter"
dw_3.istCol[6].sType				=	"char(1)"
dw_3.istCol[6].sHeaderName		=	"Inter"
dw_3.istCol[6].ilargeur			=	5
dw_3.istCol[6].sAlignement		=	"0"
dw_3.istCol[6].sInvisible		= 	"O"

dw_3.istCol[7].sDbName			=	"sysadm.archive.nom"
dw_3.istCol[7].sResultSet		=	"nom"
dw_3.istCol[7].sType				=	"char(71)"
dw_3.istCol[7].sHeaderName		=	"Courrier adressé à"
dw_3.istCol[7].ilargeur			=	21
dw_3.istCol[7].sAlignement		=	"0"
dw_3.istCol[7].sInvisible		= 	"N"

dw_3.istCol[8].sDbName			=	"sysadm.archive.dte_edit"
dw_3.istCol[8].sResultSet		=	"dte_edit"
dw_3.istCol[8].sType				=	"datetime" // [PI056] date=> datetime
dw_3.istCol[8].sHeaderName		=	"Edité le"
dw_3.istCol[8].sFormat			=	"dd/mm/yyyy"
dw_3.istCol[8].ilargeur			=	12
dw_3.istCol[8].sAlignement		=	"2"
dw_3.istCol[8].sInvisible		= 	"N"

dw_3.istCol[9].sDbName			=	"sysadm.archive.id_cour"
dw_3.istCol[9].sResultSet		=	"id_cour"
dw_3.istCol[9].sType				=	"char(6)"
dw_3.istCol[9].sHeaderName		=	"Courr"
dw_3.istCol[9].ilargeur			=	6
dw_3.istCol[9].sAlignement		=	"0"
dw_3.istCol[9].sInvisible		= 	"N"

dw_3.istCol[10].sDbName			=	"sysadm.archive.alt_part"
dw_3.istCol[10].sResultSet		=	"alt_part"
dw_3.istCol[10].sType			=	"char(1)"
dw_3.istCol[10].sHeaderName	=	"Part."
dw_3.istCol[10].ilargeur		=	3
dw_3.istCol[10].sAlignement	=	"2"
dw_3.istCol[10].sValues 		=	"ü	O/	N"
dw_3.istCol[10].sInvisible		= 	"O"

dw_3.istCol[11].sDbName			=	"sysadm.archive.alt_pce"
dw_3.istCol[11].sResultSet		=	"alt_pce"
dw_3.istCol[11].sType			=	"char(1)"
dw_3.istCol[11].sHeaderName	=	"Pce"
dw_3.istCol[11].ilargeur		=	3
dw_3.istCol[11].sAlignement	=	"2"
dw_3.istCol[11].sValues 		=	"ü	O/	N"
dw_3.istCol[11].sInvisible		= 	"O"

dw_3.istCol[12].sDbName			=	"sysadm.archive.alt_ps"
dw_3.istCol[12].sResultSet		=	"alt_ps"
dw_3.istCol[12].sType			=	"char(1)"
dw_3.istCol[12].sHeaderName	=	"PS."
dw_3.istCol[12].ilargeur		=	3
dw_3.istCol[12].sAlignement	=	"2"
dw_3.istCol[12].sValues 		=	"ü	O/	N"													
dw_3.istCol[12].sInvisible		= 	"O"

dw_3.istCol[13].sDbName			=	"sysadm.archive.alt_rep"
dw_3.istCol[13].sResultSet		=	"alt_rep"
dw_3.istCol[13].sType			=	"char(1)"
dw_3.istCol[13].sHeaderName	=	"Rep."
dw_3.istCol[13].ilargeur		=	3
dw_3.istCol[13].sAlignement	=	"2"
dw_3.istCol[13].sValues 		=	"ü	O/	N"													
dw_3.istCol[13].sInvisible		= 	"O"

dw_3.istCol[14].sDbName			=	"sysadm.archive.txt_compo1"
dw_3.istCol[14].sResultSet		=	"txt_compo1"
dw_3.istCol[14].sType			=	"char(248)"
dw_3.istCol[14].sHeaderName	=	"txt_compo1"
dw_3.istCol[14].ilargeur		=	9
dw_3.istCol[14].sAlignement	=	"0"
dw_3.istCol[14].sInvisible		= 	"O"

dw_3.istCol[15].sDbName			=	"sysadm.archive.txt_compo2"
dw_3.istCol[15].sResultSet		=	"txt_compo2"
dw_3.istCol[15].sType			=	"char(248)"
dw_3.istCol[15].sHeaderName	=	"txt_compo2"
dw_3.istCol[15].ilargeur		=	9
dw_3.istCol[15].sAlignement	=	"0"
dw_3.istCol[15].sInvisible		= 	"O"

dw_3.istCol[16].sDbName			=	"sysadm.archive.dte_archiv"
dw_3.istCol[16].sResultSet		=	"dte_archiv"
dw_3.istCol[16].sType			=	"datetime" // [PI056] date=> datetime
dw_3.istCol[16].sHeaderName	=	"Archive"
dw_3.istCol[16].sFormat			=	"dd/mm/yyyy"
dw_3.istCol[16].ilargeur		=	12
dw_3.istCol[16].sAlignement	=	"2"
dw_3.istCol[16].sInvisible		= 	"O"

dw_3.istCol[17].sDbName			=	"sysadm.archive.cod_version"
dw_3.istCol[17].sResultSet		=	"cod_version"
dw_3.istCol[17].sType			=	"number"
dw_3.istCol[17].sHeaderName	=	"Version"
dw_3.istCol[17].ilargeur		=	2
dw_3.istCol[17].sAlignement	=	"2"
dw_3.istCol[17].sInvisible		= 	"O"

dw_3.istCol[18].sDbName			=	"sysadm.archive.ref_doc_dt"
dw_3.istCol[18].sResultSet		=	"ref_doc_dt"
dw_3.istCol[18].sType			=	"number"
dw_3.istCol[18].sHeaderName	=	""
dw_3.istCol[18].ilargeur		=	7
dw_3.istCol[18].sAlignement	=	"2"
dw_3.istCol[18].sInvisible		= 	"O"

dw_3.istCol[19].sDbName			=	"sysadm.archive.ref_doc_cp"
dw_3.istCol[19].sResultSet		=	"ref_doc_cp"
dw_3.istCol[19].sType			=	"number"
dw_3.istCol[19].sHeaderName	=	""
dw_3.istCol[19].ilargeur		=	7
dw_3.istCol[19].sAlignement	=	"2"
dw_3.istCol[19].sInvisible		= 	"O"

dw_3.istCol[20].sDbName			=	"sysadm.archive.ref_doc_pc"
dw_3.istCol[20].sResultSet		=	"ref_doc_pc"
dw_3.istCol[20].sType			=	"number"
dw_3.istCol[20].sHeaderName	=	""
dw_3.istCol[20].ilargeur		=	7
dw_3.istCol[20].sAlignement	=	"2"
dw_3.istCol[20].sInvisible		= 	"O"

dw_3.istCol[21].sDbName			=	"sysadm.archive.ref_doc_ps"
dw_3.istCol[21].sResultSet		=	"ref_doc_ps"
dw_3.istCol[21].sType			=	"number"
dw_3.istCol[21].sHeaderName	=	""
dw_3.istCol[21].ilargeur		=	7
dw_3.istCol[21].sAlignement	=	"2"
dw_3.istCol[21].sInvisible		= 	"O"

sTables [ 1 ] = "archive"
sTables [ 2 ] = "personne"
sTables [ 3 ] = "produit"



/*------------------------------------------------------------------*/
/* Jointure de la Data Window d'accueil.                            */
/*------------------------------------------------------------------*/
Dw_3.isJointure = " And sysadm.archive.id_ordre   = sysadm.personne.id_ordre" +&
						" And sysadm.archive.id_prod    = sysadm.produit.id_prod " 




/*------------------------------------------------------------------*/
/* Tri par défaut de la Data Window d'accueil.                      */
/*------------------------------------------------------------------*/
// #1
dw_3.isTri = "#2 A, #8 D, #7 A"


/*------------------------------------------------------------------*/
/* Création de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_3.Uf_Creer_Tout( dw_3.istCol, sTables, iTrTrans )


///*------------------------------------------------------------------*/
///* Affectation de la police Wingdings aux colonnes DW_3.Alt_xxxxx   */
///*------------------------------------------------------------------*/
//
//dw_3.Modify ("#10.font.face='Wingdings'")			// DW_3.ALT_PART
//dw_3.Modify ("#10.font.family='0'")
//dw_3.Modify ("#10.font.charset='2'")
//dw_3.Modify ("#10.font.height='-10'")
//
//dw_3.Modify ("#11.font.face='Wingdings'")			// DW3.ALT_PIECE
//dw_3.Modify ("#11.font.family='0'")
//dw_3.Modify ("#11.font.charset='2'")
//dw_3.Modify ("#11.font.height='-10'")
//
//dw_3.Modify ("#12.font.face='Wingdings'")			// DW3.ALT_PS
//dw_3.Modify ("#12.font.family='0'")
//dw_3.Modify ("#12.font.charset='2'")
//dw_3.Modify ("#12.font.height='-10'")
//
//dw_3.Modify ("#13.font.face='Wingdings'")			// DW3.ALT_REP
//dw_3.Modify ("#13.font.family='0'")
//dw_3.Modify ("#13.font.charset='2'")
//dw_3.Modify ("#13.font.height='-10'")
	

/*------------------------------------------------------------------*/
/* Selection de l'Onglet courant                                    */
/*------------------------------------------------------------------*/

iuAccueilCourrant = dw_1

/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des paramètres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= iTrTrans
istPass.bControl	= TRUE		// Utilisation du bouton CONTROLER


/*------------------------------------------------------------------*/
/* On initialise une instance  qui indique le répertoire et le nom  */
/* du fichier d'entête à utiliser par défaut.                       */
/*------------------------------------------------------------------*/
sRepCourrier	= ProfileString ( stGLB.sFichierIni, "EDITION", "REP_COURRIER", "" )
sEntete			= ProfileString ( stGLB.sFichierIni, "EDITION", "ENTETE", "" )

isFicEntete		= sRepCourrier + sEntete

/*------------------------------------------------------------------*/
/* On initialise une variable d'instance pour indiquer le nom du    */
/* fichier que l'on va construire pour la consultation.             */
/*------------------------------------------------------------------*/
//#2 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//isFicConsult		= stGLB.sWinDir + "\TEMP\CONSCOUR.DOC"
//isFicConsultFinal = stGLB.sWinDir + "\TEMP\CONSULT.DOC"
isFicConsult		= stGLB.sRepTempo + "CONSCOUR.DOC"
isFicConsultFinal = stGLB.sRepTempo + "CONSULT.DOC"


end event

on open;call w_8_accueil_consultation::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_sa_dossier
//* Evenement 		: open - Extend
//* Auteur			: FS
//* Date				: 29/04/1998
//* Libellé			: Ouverture de la fenêtre d'accueil
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Initialisation des onglets.                                      */
/*------------------------------------------------------------------*/

wf_Creer_Onglet( 3, 1, { "Instruction", "Sinistre", "Archive" } )			/* Sera exécuté après l'appel de tous les ue_initialiser */
																								/* que ce soit les ue_initialiser de cette fenêtre ou    */
																								/* ceux des fenêtres descendantes                        */	
																								/* donc la création des 3 onglets se fera après la       */
																								/* construction dynamique des 3 datawindows composant    */ 
																								/* ces trois onglets.											   */



end on

on w_ac_spb_archive_2000.create
int iCurrent
call super::create
end on

on w_ac_spb_archive_2000.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_8_accueil_consultation`cb_debug within w_ac_spb_archive_2000
end type

type pb_retour from w_8_accueil_consultation`pb_retour within w_ac_spb_archive_2000
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil_consultation`pb_interro within w_ac_spb_archive_2000
integer width = 242
integer height = 144
end type

type pb_tri from w_8_accueil_consultation`pb_tri within w_ac_spb_archive_2000
integer width = 242
integer height = 144
end type

type uo_onglet from w_8_accueil_consultation`uo_onglet within w_ac_spb_archive_2000
integer width = 1467
end type

type dw_1 from w_8_accueil_consultation`dw_1 within w_ac_spb_archive_2000
integer x = 46
integer y = 492
integer width = 443
integer height = 424
end type

type dw_2 from w_8_accueil_consultation`dw_2 within w_ac_spb_archive_2000
integer x = 535
integer y = 492
integer width = 443
integer height = 424
end type

type dw_3 from w_8_accueil_consultation`dw_3 within w_ac_spb_archive_2000
integer x = 1024
integer y = 492
integer width = 443
integer height = 424
end type

type dw_4 from w_8_accueil_consultation`dw_4 within w_ac_spb_archive_2000
integer x = 1513
integer y = 492
integer width = 443
integer height = 424
end type

type dw_5 from w_8_accueil_consultation`dw_5 within w_ac_spb_archive_2000
integer x = 2002
integer y = 492
integer width = 443
integer height = 424
end type

type dw_6 from w_8_accueil_consultation`dw_6 within w_ac_spb_archive_2000
integer x = 2491
integer y = 492
integer width = 443
integer height = 424
end type

type uo_1 from w_8_accueil_consultation`uo_1 within w_ac_spb_archive_2000
integer x = 1531
integer y = 28
integer width = 347
integer height = 96
end type

on uo_1::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_1::Constructor (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: PLJ
//* Date				: 29/04/1998 
//* Libellé			: Positionnement de de l'objet uo_1
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne le Bord en 3D, puis on appelle la construction     */
/* normale.                                                         */
/*------------------------------------------------------------------*/

This.X			=   28
This.Y			=  293
This.Width		= 3537
This.Height		= 1453

Call U_Bord3D::Constructor
end on

type pb_imprimer from w_8_accueil_consultation`pb_imprimer within w_ac_spb_archive_2000
integer width = 242
integer height = 144
end type

