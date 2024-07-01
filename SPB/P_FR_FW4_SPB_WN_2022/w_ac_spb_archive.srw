HA$PBExportHeader$w_ac_spb_archive.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre d'accueil de consultation sinistre, comprenant la gestion archive.
forward
global type w_ac_spb_archive from w_8_accueil_consultation
end type
end forward

global type w_ac_spb_archive from w_8_accueil_consultation
event ue_word pbm_custom35
end type
global w_ac_spb_archive w_ac_spb_archive

type variables
//u_courrier		iuoCourrier	

Private :
	U_DeclarationFileNet	iUoFn

	String			isFic[4]

end variables

forward prototypes
private subroutine wf_positionnerobjets ()
protected subroutine wf_consultercourrier ()
private function boolean wf_gestion_filenet (long alligne)
private function boolean wf_gestion_blob_lire (long alligne)
private function boolean wf_lire_blob (long aldocid, string astypblob, long alligne)
private function boolean wf_lire_fichier_fob (string asnomfic, ref blob ablBlob)
private subroutine wf_gestion_erreur (integer aitype, long alligne, long aldocid)
private subroutine wf_ecrire_trace_fn (boolean abret, long alligne)
end prototypes

on ue_word;call w_8_accueil_consultation::ue_word;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_archive
//* Evenement 		: Ue_Word
//* Auteur			: PLJ
//* Date				: 09/06/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$clenche la consultation du courrier s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* JFF			29/10/98 On ne Teste plus la pr$$HEX1$$e900$$ENDHEX$$sence d'un Word ouvert.
//*-----------------------------------------------------------------

Long		lNumlig			// N$$HEX2$$b0002000$$ENDHEX$$de ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e.


lNumLig = Dw_3.GetRow ( )

If lNumLig >  0 And Dw_3.RowCount ( ) > 0 Then

	SetPointer ( HourGlass! )


	/*----------------------------------------------------------------------------*/
	/* On ne Teste plus la pr$$HEX1$$e900$$ENDHEX$$sence d'un WORD ouvert, car de toutes    				*/
	/* fa$$HEX1$$e700$$ENDHEX$$ons, la Cr$$HEX1$$e900$$ENDHEX$$ation de l'objet WordBasic (et sa connexion), ouvrira un WORD*/
	/* s'il n'y en a pas d'ouvert, ou on utilisera le WORD ouvert s'il y en a un. */
	/* De cette fa$$HEX1$$e700$$ENDHEX$$ons, nous n'executons plus la macro "Aper$$HEX1$$e700$$ENDHEX$$uOff", qui ne s'exe- */
	/* cutait que si le mod$$HEX1$$e800$$ENDHEX$$le COURRIER.DOT $$HEX1$$e900$$ENDHEX$$tait pr$$HEX1$$e900$$ENDHEX$$sent .								*/
	/* Ainsi l'utilisateur peut fermer le mod$$HEX1$$e800$$ENDHEX$$le sans fermer WORD, cela n'aura    */
	/* aucune incidence.																				*/
	/* ATTENTION : Si l'utilisateur laisse un document ouvert en mode APERCU, l$$HEX2$$e0000900$$ENDHEX$$*/
	/* il y aura plantage lors de l'ouverture d'un prochain courrier, mais on ne	*/
	/* peut pas tester cela sans faire appel $$HEX2$$e0002000$$ENDHEX$$une macro, dont le mod$$HEX1$$e800$$ENDHEX$$le o$$HEX2$$f9002000$$ENDHEX$$elle	*/
	/* se trouve, pourrait $$HEX1$$e900$$ENDHEX$$ventuellement ne pas $$HEX1$$ea00$$ENDHEX$$tre ouvert. 							*/
	/*																						JFF			*/
	/*----------------------------------------------------------------------------*/



////		If ( Not iuoCourrier.uf_initCourrier( stGlb, stMessage ) ) Then
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

Wf_ConsulterCourrier ( )

SetPointer ( Arrow! )
end on

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_ac_si_dossier::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: PLJ
//* Date				: 29/04/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne et on taille tous les objets
//*                 sauf uo_1 qui est positionn$$HEX2$$e9002000$$ENDHEX$$et taill$$HEX1$$e900$$ENDHEX$$
//*                 par son constructor
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne tous les objets n$$HEX1$$e900$$ENDHEX$$cessaires $$HEX2$$e0002000$$ENDHEX$$la gestion, pour     */
/* faciliter le d$$HEX1$$e900$$ENDHEX$$veloppement. (On peut bouger les objets).         */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Barre Onglet                                                     */
/*------------------------------------------------------------------*/
Uo_Onglet.X			=   19
Uo_Onglet.Y			=  197
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

protected subroutine wf_consultercourrier ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_ConsulterCourrier
//* Auteur			: PLJ
//* Date				: 09/06/1998 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Permet de consulter le courrier s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$dans dw_3 (datawindow des sinistres).
//* Commentaires	: 
//*
//* Arguments		: aucun
//*
//* Retourne		: rien
//*					
//*
//*-----------------------------------------------------------------
//* N$$HEX2$$b0002000$$ENDHEX$$Modif          Re$$HEX1$$e700$$ENDHEX$$ue Le          Effectu$$HEX1$$e900$$ENDHEX$$e Le          PAR
//* 
//*
//*-----------------------------------------------------------------
 
String	sIdCour			// Identifiant du courrier compos$$HEX1$$e900$$ENDHEX$$.
String	sAltPart			// Indique s'il s'agit d'un courrier divers ou particulier.
String	sAltPce			// Indique s'il y a une autre piece.
String	sAltPs			// Indique s'il y a un post scriptum.
Long		lIdSin			// Identifiant du sinistre
Long		lIdInter			// Identifiant interlocuteur
Long		lIdDoc			// Identifiant du document archiv$$HEX1$$e900$$ENDHEX$$.
String	sTxtCompo		// Composition.
String	sTxtCompo1		// Premi$$HEX1$$e800$$ENDHEX$$re partie de la composition.
String	sTxtCompo2		// Deuxi$$HEX1$$e800$$ENDHEX$$me partie de la composition.
String	sDteEdit			// Date d'$$HEX1$$e900$$ENDHEX$$dition du courrier.
Blob		bTxtblob			// Blob contenant le texte des variables.
Integer	iPoignee			// N$$HEX2$$b0002000$$ENDHEX$$de poign$$HEX1$$e900$$ENDHEX$$e (handle).
Long		lNumlig			// N$$HEX2$$b0002000$$ENDHEX$$de ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e.

String sFic
Boolean bRet
//Migration PB8-WYNIWYG-03/2006 FM
boolean	lb_ac
//Fin Migration PB8-WYNIWYG-03/2006 FM


lNumLig = Dw_3.GetRow ( )

If lNumLig >  0 And Dw_3.RowCount ( ) > 0 Then

	lIdSin 	= Dw_3.GetitemNumber  ( lNumLig, "ID_SIN"   )
	lIdInter	= Dw_3.GetitemNumber  ( lNumLig, "ID_INTER" )
	lIdDoc	= Dw_3.GetitemNumber  ( lNumLig, "ID_DOC"   )
	sIdCour	= Dw_3.GetitemString  ( lNumLig, "ID_COUR"  )
	
	If IsNull ( sIdCour ) Then

		sIdCour = ""

	End If

//	sDteEdit	= f_Txt_Date ( Dw_3.GetItemDate ( lNumLig, "DTE_EDIT" ) )
	sDteEdit	= f_Txt_Date ( Date(Dw_3.GetItemDateTime ( lNumLig, "DTE_EDIT" )) ) // [PI056]
	
	sAltPart		= Dw_3.GetITemString ( lNumLig, "ALT_PART" )
	sAltPce		= Dw_3.GetITemString ( lNumLig, "ALT_PCE"  )
	sAltPs		= Dw_3.GetITemString ( lNumLig, "ALT_PS"   )
	
	sTxtCompo1	=	Dw_3.GetitemString ( lNumLig, "TXT_COMPO1" )
	sTxtCompo2	=	Dw_3.GetitemString ( lNumLig, "TXT_COMPO2" )



//	iPoignee = iUoCourrier.Uf_ouvrirCourrier ( sIdCour )

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
//	iUoCourrier.Uf_Composition ( iPoignee, sTxtCompo )

	If sAltPart = "O" Then
		If	IsNull ( isFic[2]	) Then	
//Migration PB8-WYNIWYG-03/2006 FM
			lb_ac = itrTrans.AutoCommit
			itrTrans.AutoCommit = true
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
			itrTrans.AutoCommit = lb_ac
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

			Return

		End If

//		iUoCourrier.Uf_CourrierParticulier ( iPoignee, bTxtBlob )

	ElseIf sAltPce = "O" Or sAltPs = "O" Then

		If sAltPce = "O"	Then
			If	IsNull ( isFic[3]	) Then	
//Migration PB8-WYNIWYG-03/2006 FM
				lb_ac = itrTrans.AutoCommit
				itrTrans.AutoCommit = true
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
				itrTrans.AutoCommit = lb_ac
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

				Return

			End If

//			iUoCourrier.Uf_AutrePiece ( iPoignee, bTxtBlob )

		End If

		If sAltPs = "O" Then
			If	IsNull ( isFic[4]	) Then	
//Migration PB8-WYNIWYG-03/2006 FM
				lb_ac = itrTrans.AutoCommit
				itrTrans.AutoCommit = true
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
				itrTrans.AutoCommit = lb_ac
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

				Return

			End If

//			iUoCourrier.Uf_PostScriptum ( iPoignee, bTxtBlob )

		End If

	End If

	/*------------------------------------------------------------------*/
	/* On pr$$HEX1$$e900$$ENDHEX$$pare les variables.                                        */
	/*------------------------------------------------------------------*/
	If	IsNull ( isFic[1]	) Then

//Migration PB8-WYNIWYG-03/2006 FM
			lb_ac = itrTrans.AutoCommit
			itrTrans.AutoCommit = true
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
			itrTrans.AutoCommit = lb_ac
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

		Return

	Else

//		iUoCourrier.Uf_Donnee ( iPoignee, bTxtBlob )

		/*------------------------------------------------------------------*/
		/* On positionne la date d'$$HEX1$$e900$$ENDHEX$$dition du courrier dans COURRIER.INI    */
		/*------------------------------------------------------------------*/
//		iUoCourrier.Uf_ProfileString ( iPoignee, "DTE_EDIT", sDteEdit )

		/*------------------------------------------------------------------*/
		/* On imprime le courrier.                                          */
		/*------------------------------------------------------------------*/
//		iUOCourrier.Uf_Imprimer ( stMessage, "CourrierConsultation" )

	End If

//	iuoCourrier.Uf_FermerCourrier ( iPoignee )

End If

end subroutine

private function boolean wf_gestion_filenet (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Gestion_FileNet	(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 06/07/1999 11:33:12
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va lire les BLOBS sur FileNet
//*
//* Arguments		: Long			alLigne				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la ligne en cours de traitement
//*
//* Retourne		: Boolean		Vrai = Tout se passe bien
//*										Faux = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
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
/* On se connecte sur le syst$$HEX1$$e800$$ENDHEX$$me FileNet en tant que SysAdmin.      */
/*------------------------------------------------------------------*/
lRet = iuoFn.FN_Logon ( "SysAdmin", "SysAdmin" )

For	lCpt = 1 To 5
		Yield ()
Next

If	lRet >= 0	Then
/*------------------------------------------------------------------*/
/* On arme le tableau pour les fichiers que l'on va lire sur        */
/* FileNet $$HEX2$$e0002000$$ENDHEX$$NULL.                                                  */
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
Long lDocId

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration syst$$HEX1$$e900$$ENDHEX$$matique du blob des DATA.                      */
/*------------------------------------------------------------------*/
lDocId = dw_3.GetItemNumber ( alLigne, "REF_DOC_DT" )
bRet = wf_Lire_Blob ( lDocId, "DT", alLigne )

If	Not bRet	Then
	wf_Gestion_Erreur ( 1, alLigne, lDocId )
End If

/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration $$HEX1$$e900$$ENDHEX$$ventuelle d'un COURRIER PARTICULIER.               */
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
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration $$HEX1$$e900$$ENDHEX$$ventuelle d'une AUTRE PIECE.                       */
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
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration $$HEX1$$e900$$ENDHEX$$ventuelle du POST-SCRIPTUM.                        */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Lecture du Blob dans FileNet
//*
//* Arguments		: Long			alDocId				(Val)	N$$HEX2$$b0002000$$ENDHEX$$du DOC_ID
//* 					: String			asTypBlob			(Val)	Type du Blob (DT/PS/PC/CP)
//* 					: Long			alLigne				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la ligne en cours de traitement
//*
//* Retourne		: Boolean		Vrai	= L'$$HEX1$$e900$$ENDHEX$$criture est OK
//*										Faux	= L'$$HEX1$$e900$$ENDHEX$$criture pose probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

Long lRet, lCpt
String sFic

Boolean bRet

bRet	= False

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le BLOB de FileNet grace au DOC_ID.                  */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Lecture du fichier pour le transformer en BLOB
//*
//* Arguments		: String			asNomFic				(Val)	Nom du fichier
//* 					: Blob			ablBlob				(R$$HEX1$$e900$$ENDHEX$$f)	BLOB en retour
//*
//* Retourne		: Boolean		Vrai = La lecture se passe bien
//*										Faux = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
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
/* On d$$HEX1$$e900$$ENDHEX$$termine la longueur du FICHIER FOB.                         */
/*------------------------------------------------------------------*/
	lLngTot 		= FileLength ( asNomFic )
	If	lLngTot	> 32765	Then

/*------------------------------------------------------------------*/
/* Si cette longueur d$$HEX1$$e900$$ENDHEX$$passe 32765, on d$$HEX1$$e900$$ENDHEX$$termine le nombre          */
/* de lecture n$$HEX1$$e900$$ENDHEX$$cessaires dans le fichier.                          */
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On g$$HEX1$$e900$$ENDHEX$$re l'affichage des les diff$$HEX1$$e900$$ENDHEX$$rentes erreurs
//*
//* Arguments		: Integer		aiType				(Val)	Type d'erreur
//* 					: Long			alLigne				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la ligne en cours de traitement
//* 					: Long			alDocId				(Val)	N$$HEX2$$b0002000$$ENDHEX$$du DOCID
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

stMessage.sTitre		= "Consultation sur le syst$$HEX1$$e800$$ENDHEX$$me FileNet"
stMessage.Icon			= Information!
stMessage.Bouton		= OK!
stMessage.bErreurG	= TRUE

Choose	Case aiType
Case 1					// Erreur sur la lecture des BLOBS

	stMessage.sCode	= "FN0005"
	stMessage.sVar[1] = String ( alDocId )

Case 2					// Impossible de se connecter sur le syst$$HEX1$$e800$$ENDHEX$$me

	stMessage.sCode	= "FN0006"

End Choose

F_Message ( stMessage )


end subroutine

private subroutine wf_ecrire_trace_fn (boolean abret, long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Ecrire_Trace_FN ( Private )
//* Auteur			: Erick John Stark
//* Date				: 04/28/97 14:57:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Boolean		abRet				(Val) Les op$$HEX1$$e900$$ENDHEX$$rations FileNet se sont-elles bien pass$$HEX1$$e900$$ENDHEX$$es ?
//* 					: Long			alLigne			(Val) N$$HEX2$$b0002000$$ENDHEX$$de la ligne en cours de traitement
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
/* N$$HEX2$$b0002000$$ENDHEX$$Machine						02                                    */
/* COD_SERVICE						03                                    */
/* ID_SIN							04                                    */
/* ETAT FN							05                                    */
/*------------------------------------------------------------------*/

sTab = "~t"
lTot = UpperBound ( sTrace )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re maintenant le nom de la machine. On part du principe */
/* que ce nom est positionn$$HEX2$$e9002000$$ENDHEX$$dans la valeur Dos (SQL=XXX)           */
/*------------------------------------------------------------------*/
//uoDeclarationFuncky = Create u_DeclarationFuncky
//[I037] Migration FUNCKy
//sNomMachine = uoDeclarationFuncky.Uf_GetEnv ( "SQL" )
sNomMachine = stGlb.uoWin.uf_getenvironment("SQL")
//Destroy uoDeclarationFuncky

/*------------------------------------------------------------------*/
/* On initialise maintenant le nom du fichier de TRACE au format    */
/* JJMMAAAA.App (App correspond au code de l'application).          */
/* Pour connaitre le r$$HEX1$$e900$$ENDHEX$$pertoire qui contient le fichier de TRACE,   */
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

f_EcrireFichierText ( sFicTrace, sLigne )

end subroutine

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_archive
//* Evenement 		: ue_initialiser - Extend
//* Auteur			: PLJ
//* Date				: 09/06/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  JFF		06/07/99 Modification du tri suite $$HEX2$$e0002000$$ENDHEX$$la demande de Denis.
//*				  
//*-----------------------------------------------------------------


//iuoCourrier			= Create u_courrier

/*----------------------------------------------------------------------------*/
/* On initialise le .INI de communication avec Word (ex COURRIER.INI). On y   */
/* g$$HEX1$$e800$$ENDHEX$$re $$HEX1$$e900$$ENDHEX$$galement l'existence de ce m$$HEX1$$ea00$$ENDHEX$$me fichier pour tracer les erreurs de   */
/* consultation. Le "C" indique que l'on se trouve dans un contexte de        */
/* Consultation de courrier.                                                  */
/*----------------------------------------------------------------------------*/
//iUoCourrier.Uf_InitIni ( stGLB, "C" , stMessage )


String sTables [ ]			// Tables du SELECT


/*------------------------------------------------------------------*/
/*   Positionnement des objets sur la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil             */
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
dw_3.istCol[1].ilargeur			=	20
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
dw_3.istCol[4].sHeaderName	=	"Assur$$HEX1$$e900$$ENDHEX$$"
dw_3.istCol[4].ilargeur		=	21
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
dw_3.istCol[7].sHeaderName		=	"Courrier adress$$HEX3$$e9002000e000$$ENDHEX$$"
dw_3.istCol[7].ilargeur			=	22
dw_3.istCol[7].sAlignement		=	"0"
dw_3.istCol[7].sInvisible		= 	"N"

dw_3.istCol[8].sDbName			=	"sysadm.archive.dte_edit"
dw_3.istCol[8].sResultSet		=	"dte_edit"
dw_3.istCol[8].sType				=	"datetime" // [PI056] date=> datetime
dw_3.istCol[8].sHeaderName		=	"Edit$$HEX2$$e9002000$$ENDHEX$$le"
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
dw_3.istCol[10].sValues 		=	"$$HEX2$$fc000900$$ENDHEX$$O/	N"
dw_3.istCol[10].sInvisible		= 	"O"

dw_3.istCol[11].sDbName			=	"sysadm.archive.alt_pce"
dw_3.istCol[11].sResultSet		=	"alt_pce"
dw_3.istCol[11].sType			=	"char(1)"
dw_3.istCol[11].sHeaderName	=	"Pce"
dw_3.istCol[11].ilargeur		=	3
dw_3.istCol[11].sAlignement	=	"2"
dw_3.istCol[11].sValues 		=	"$$HEX2$$fc000900$$ENDHEX$$O/	N"
dw_3.istCol[11].sInvisible		= 	"O"

dw_3.istCol[12].sDbName			=	"sysadm.archive.alt_ps"
dw_3.istCol[12].sResultSet		=	"alt_ps"
dw_3.istCol[12].sType			=	"char(1)"
dw_3.istCol[12].sHeaderName	=	"PS."
dw_3.istCol[12].ilargeur		=	3
dw_3.istCol[12].sAlignement	=	"2"
dw_3.istCol[12].sValues 		=	"$$HEX2$$fc000900$$ENDHEX$$O/	N"													
dw_3.istCol[12].sInvisible		= 	"O"

dw_3.istCol[13].sDbName			=	"sysadm.archive.alt_rep"
dw_3.istCol[13].sResultSet		=	"alt_rep"
dw_3.istCol[13].sType			=	"char(1)"
dw_3.istCol[13].sHeaderName	=	"Rep."
dw_3.istCol[13].ilargeur		=	3
dw_3.istCol[13].sAlignement	=	"2"
dw_3.istCol[13].sValues 		=	"$$HEX2$$fc000900$$ENDHEX$$O/	N"													
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
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut de la Data Window d'accueil.                      */
/*------------------------------------------------------------------*/
// #1
dw_3.isTri = "#2 A, #8 D, #7 A"


/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
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
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= iTrTrans
istPass.bControl	= TRUE		// Utilisation du bouton CONTROLER




end event

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_archiver
//* Evenement 		: ue_modifier
//* Auteur			: PLJ
//* Date				: 09/06/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Appel des fen$$HEX1$$ea00$$ENDHEX$$tres de consultation
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPass

stPass = istpass
Boolean bRet
Long lCpt

Choose Case iuAccueilCourrant

	Case dw_3		// .... Consultation des courriers

		SetPointer( HourGlass! )

				
		If Dw_3.ilLigneClick > 0 Then

			//If ( isNull ( Dw_3.GetItemDate ( Dw_3.ilLigneClick, "DTE_ARCHIV" ) ) ) Then
			If ( isNull ( Dw_3.GetItemDateTime ( Dw_3.ilLigneClick, "DTE_ARCHIV" ) ) ) Then // [PI056]

/*------------------------------------------------------------------*/
/* Il faut mettre $$HEX2$$e0002000$$ENDHEX$$NULL le tableau pour les fichiers. Il faudra    */
/* enlever ces commentaires dans le futur.                          */
/*------------------------------------------------------------------*/
				For	lCpt = 1 To 4
						SetNull ( isFic[lCpt] )
				Next

				TriggerEvent ( "Ue_Word" )

			Else

//				bRet = Wf_Gestion_FileNet ( dw_3.ilLigneClick )
///*------------------------------------------------------------------*/
///* On g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$re une TRACE du passage sous FileNet.                     */
///*------------------------------------------------------------------*/
//				Wf_Ecrire_Trace_FN ( bRet, dw_3.ilLigneClick )
//
//				If	bRet	Then
//					TriggerEvent ( "Ue_Word" )
//				End If

				stMessage.sTitre	=	"Consultation des courriers"
				stMessage.icon		=	Information!
				stMessage.sCode	=	"COUR007"

				f_Message ( stMessage )

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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre 
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Destroy iuoCourrier

/*------------------------------------------------------------------*/
/* On supprime la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence au NVUO FileNet si elle existe.         */
/*------------------------------------------------------------------*/
If	IsValid ( iuoFn )	Then Destroy iuoFn
end on

on open;call w_8_accueil_consultation::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_sa_dossier
//* Evenement 		: open - Extend
//* Auteur			: FS
//* Date				: 29/04/1998
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* Initialisation des onglets.                                      */
/*------------------------------------------------------------------*/

wf_Creer_Onglet( 3, 1, { "Instruction", "Sinistre", "Archive" } )			/* Sera ex$$HEX1$$e900$$ENDHEX$$cut$$HEX2$$e9002000$$ENDHEX$$apr$$HEX1$$e800$$ENDHEX$$s l'appel de tous les ue_initialiser */
																								/* que ce soit les ue_initialiser de cette fen$$HEX1$$ea00$$ENDHEX$$tre ou    */
																								/* ceux des fen$$HEX1$$ea00$$ENDHEX$$tres descendantes                        */	
																								/* donc la cr$$HEX1$$e900$$ENDHEX$$ation des 3 onglets se fera apr$$HEX1$$e800$$ENDHEX$$s la       */
																								/* construction dynamique des 3 datawindows composant    */ 
																								/* ces trois onglets.											   */



end on

on w_ac_spb_archive.create
int iCurrent
call super::create
end on

on w_ac_spb_archive.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_debug from w_8_accueil_consultation`cb_debug within w_ac_spb_archive
end type

type pb_retour from w_8_accueil_consultation`pb_retour within w_ac_spb_archive
integer width = 242
integer height = 144
end type

type pb_interro from w_8_accueil_consultation`pb_interro within w_ac_spb_archive
integer width = 242
integer height = 144
end type

type pb_tri from w_8_accueil_consultation`pb_tri within w_ac_spb_archive
integer width = 242
integer height = 144
end type

type uo_onglet from w_8_accueil_consultation`uo_onglet within w_ac_spb_archive
integer width = 1467
end type

type dw_1 from w_8_accueil_consultation`dw_1 within w_ac_spb_archive
integer x = 46
integer y = 492
integer width = 443
integer height = 424
end type

type dw_2 from w_8_accueil_consultation`dw_2 within w_ac_spb_archive
integer x = 535
integer y = 492
integer width = 443
integer height = 424
end type

type dw_3 from w_8_accueil_consultation`dw_3 within w_ac_spb_archive
integer x = 1024
integer y = 492
integer width = 443
integer height = 424
end type

type dw_4 from w_8_accueil_consultation`dw_4 within w_ac_spb_archive
integer x = 1513
integer y = 492
integer width = 443
integer height = 424
end type

type dw_5 from w_8_accueil_consultation`dw_5 within w_ac_spb_archive
integer x = 2002
integer y = 492
integer width = 443
integer height = 424
end type

type dw_6 from w_8_accueil_consultation`dw_6 within w_ac_spb_archive
integer x = 2491
integer y = 492
integer width = 443
integer height = 424
end type

type uo_1 from w_8_accueil_consultation`uo_1 within w_ac_spb_archive
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
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Positionnement de de l'objet uo_1
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

type pb_imprimer from w_8_accueil_consultation`pb_imprimer within w_ac_spb_archive
integer width = 242
integer height = 144
end type

