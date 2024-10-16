$PBExportHeader$n_cst_edition_courrier.sru
$PBExportComments$------} NVUO servant à l'édition et la génération automatique des courriers.
forward
global type n_cst_edition_courrier from nonvisualobject
end type
end forward

global type n_cst_edition_courrier from nonvisualobject
end type
global n_cst_edition_courrier n_cst_edition_courrier

type prototypes


end prototypes

type variables


PRIVATE :
	// [DNTMAIL1-2] 31/10/2006 PHG
	constant		string K_CANAL_MAIL 		= 'MA' 
	constant		string K_CANAL_COURRIER = 'CO'
	constant		string K_REP_COURRIER   = 'REP_COURRIER'
//	constant		string K_REP_COURMAIL   = 'REP_COURMAIL' // [PM159]
	constant		string K_REP_COURMAIL   = 'REP_COURRIER' // [PM159]
	
	String		isFicCourrierIni
	String		isRepCourrier
	String		isModele
	String		isEntete
	String		isFicSpool
	String      isIdCour // [PM425-1]
	String      isCasTrtPM425 // [PM425-1]
	String      isCodeRegroupement  // [PM425-1]
	
//       JFF  26/04/2023 [RS5045_REF_MATP]
	String 		isT_ModeleInter [] // Les modèles liés à l'inter  // [RS5045_REF_MATP]
	Int			iiT_InterModele [] // Les inters  // [RS5045_REF_MATP]
	String 		isModeleDefaut  // [RS5045_REF_MATP]
	
	Long		ilNbCourrierEdite
	Long		ilNbDocumentEdite
	Long		ilNbDocument

	Long     idcIdSin // [PM425-1]
	Long     iiIdArch // [PM425-1]
	Long     idcIdInter // [PM425-1]
	Long     ilIdLot // [PM425-1]
   Long     ilIdTypDoc // [PM425-1]
	Long     ilIndexPosition // [PM425-1]
	Long 	   ilIdDoc // [PM425-1]

	String		isIdDocument[]
	String		isVarErr [] // TRACE_TS_COURRIER
	
	Boolean		ibImpressionReussie
	Boolean		ibWordOuvertAvantTraitement
	Boolean     ibAMUEditionDecentralisee // [PM425-1]
	Boolean     ibAMUEditionChezSPB // [PM425-1]	
	Boolean		ibModeImpression // [PM425-1]	
	Boolean		ibCouperMsgEDI025 // TRACE_TS_COURRIER
		
	UnsignedLong	iulHandleWord

	U_DeclarationWindows	invWin
	
	OleObject	iOleWord
	Integer		iiDroitInter[]    // DCMP 040020 SVE
	
	n_cst_printer_descriptor	invPrinter // [SUPPORT_MFP]
	
	u_rapport iMleMsg // [PM425-1]
	

end variables

forward prototypes
public function integer uf_terminersession ()
public function integer uf_initialiser (string astypetrt)
public function integer uf_initialiserword (boolean abfermer_sansverifier)
private function boolean uf_verifieriddocument (long alIdDocument)
public function integer uf_verifier_word_avantgeneration (boolean abfermer_sansverifier)
public function integer uf_fermerdocument (long aliddocument)
public function integer uf_genererdata (long aliddocument, ref blob abldata)
public function integer uf_genererblob (long aliddocument, string astypeblob, ref blob ablword)
public function integer uf_inscrire_gestionparticuliere (long alIdDocument, string asComposition)
public function integer uf_inscrirebac (long aliddocument, string asbac, integer aitypeimprimante)
public function integer uf_inscrirecomposition (long aliddocument, string ascomposition)
public function integer uf_inscrireparamcourrier (string ascourriersauve, string astypesauve, string asedition, string asmisesouspli)
public function integer uf_ouvrirdocument (string ascodecourrier, string asentetedata)
public function integer uf_initialiserfichierspool ()
public function integer uf_imprimer (string asnommacro)
public function integer uf_envoyerimpressionauspool ()
public subroutine uf_inscrire_valeur_differentes (string asrepcourrier, string asmodele, string asentete)
public subroutine uf_envoyer_commande (integer aitype, string asparam)
public function long uf_cle_edition_fichierini (string ascle)
public function string uf_getnomfichierspool ()
public function integer uf_inscrire_dteedition_courrier (string asdteedit)
public function integer uf_inscrire_dteedition_document (long aliddocument, string asdteedit)
public function long uf_ouvrirdocument_2 (string asnomfichier)
public subroutine uf_changermodele (string asmodele)
public subroutine uf_inscrire_droitsmodifcourrier (integer aidroitinter[])
private function integer uf_appliquer_droitmodifcour (integer aiinter, string asnomfic)
public function integer uf_inscrire_dteedition_document_2 (string asdteedit)
public function integer uf_fermerdocument_2 ()
public function integer uf_inscrireparammisesouspli (string asmsp_chrono, string asmsp_compteur)
public function integer uf_recupererparammisesouspli ()
public function integer uf_inscrireparamcourrier2 (string ascourriersauve, string astypesauve, string asedition, string asmisesouspli, string asid_canal)
public function integer uf_inscrirebac (long aliddocument, string asbac, n_cst_printer_descriptor anv_printer)
public function integer uf_inscrirebac (long aliddocument, string asbac)
public function integer uf_inscrireparamcourrier (string ascourriersauve, string astypesauve, string asedition, string asmisesouspli, string asid_canal, string asid_lang)
public function integer uf_setidsin (string asidsin)
public subroutine uf_trace (s_glb astglb, string asdescription)
public function integer uf_generer_courrier (ref datawindow adwgencourrier, boolean abvisualisercourrier, boolean abcountpages)
public function integer uf_generer_courrier (datawindow adwgencourrier, boolean abvisualisercourrier)
public function integer uf_generer_courrier (datawindow adwgencourrier, boolean abvisualisercourrier, long alidprod)
private function string uf_editiondecentralisee (ref n_cst_word anvword)
public function integer uf_getpm425_etatedtetdecent ()
public subroutine uf_setpm425_etatedtetdecent (boolean abamueditiondecent, boolean abamueditionchezspb)
public subroutine uf_setpm425 (string ascas, long aiidsin, long aiidinter, string asidcour, long aiidarch, long alidlot, long alidtypdoc, long aliddoc, u_rapport amlemsg, string ascastrtpm425, boolean abmodeimpression)
public subroutine uf_set_coupermsgedi025 (boolean abcoupermsgedi025)
public subroutine uf_get_erreurimprimeredi025 (ref string asvarerr1, ref string asvarerr2)
public subroutine uf_setmodeleparmediaetinter (ref integer ait_intermodele[], ref string ast_modeleinter[])
end prototypes

public function integer uf_terminersession ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_TerminerSession		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 05/04/2000 16:10:01
//* Libellé			: 
//* Commentaires	: On ferme la session d'impression.
//*
//* Arguments		: 
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1	FPI	02/04/2010	[EDT_NBPAGES] On ne supprime plus le .INI de communication avec Word (courriers part)
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On supprime le fichier INI servant à la communication avec WORD. */
/*------------------------------------------------------------------*/
//FileDelete ( isFicCourrierIni )
/*------------------------------------------------------------------*/
/* On supprime le fichier de SPOOL s'il existe.                     */
/*------------------------------------------------------------------*/
FileDelete ( isFicSpool )
/*------------------------------------------------------------------*/
/* On supprime l'objet OLE Word s'il existe.                        */
/*------------------------------------------------------------------*/
If	IsValid ( iOleWord )	Then
	iOleWord.DisconnectObject ()
//Migration PB8-WYNIWYG-03/2006 FM
//	DESTROY iOleWord
	If IsValid(iOleWord) Then DESTROY iOleWord
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

Return ( 1 )

end function

public function integer uf_initialiser (string astypetrt);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_Initialiser	(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 15:06:20
//* Libellé			: 
//* Commentaires	: On initialise l'objet pour l'edition des courriers
//*
//* Arguments		: (Val)		String		asTypeTrt	(E)dition
//*																	(C)onsultation
//*
//* Retourne		: Integer				 1 = Tout est OK
//*												-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//  #1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

String sFicIniApp, sRepCourrierIni, sType
String sVarErr[]


/*------------------------------------------------------------------*/
/* On va créer un fichier d'initialisation pour permettre la        */
/* communication avec WORD. Ce fichier INI est composé des 6        */
/* premiers caractères du Code de l'application + "_" + Type de     */
/* traitement (E)dition, (C)onsultation.                            */
/*------------------------------------------------------------------*/
sFicIniApp 			= stGLB.sFichierIni

//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//sRepCourrierIni	= ProfileString ( sFicIniApp, "EDITION", "COURRIER_INI", &
//						  ProfileString ( stGlb.sWinDir + "\MAJPOST.INI", "PARAM", "DESTINATION", "C:" ) + "\" )
sRepCourrierIni	= stGlb.sRepTempo
isFicCourrierIni	= sRepCourrierIni + Left ( stGLB.sCodAppli, 6 ) + "_" + asTypeTrt + ".INI"

/*------------------------------------------------------------------*/
/* Si le fichier existe déjà, cela signifie que la dernière         */
/* utilisation de l'objet s'est mal terminée.                       */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//If ( FileExists ( isFicCourrierIni ) ) Then
If ( f_FileExists ( isFicCourrierIni ) ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP

	If asTypeTrt = "C" Then
		sVarErr[1]	= "consultation"
	Else
		sVarErr[1]	= "édition"
	End If
/*------------------------------------------------------------------*/	
/* On affiche un message d'erreur. On récupére éventuellement les   */
/* erreurs écrites par WORD ou par l'application.                   */
/*------------------------------------------------------------------*/
	sVarErr[2] = ProfileString ( isFicCourrierIni, "IMPRESSION", "ERREUR_WORD", "Aucun message Word" )
	sVarErr[3] = ProfileString ( isFicCourrierIni, "IMPRESSION", "ERREUR_APP", "Aucun message applicatif" )
	
//	Gnv_App.inv_Error.of_Message ( "EDIT005", sVarErr )
	FileDelete ( isFicCourrierIni )
End If

invWin = stGLB.uoWin

Return ( 1 )

end function

public function integer uf_initialiserword (boolean abfermer_sansverifier);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_InitialiserWord		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 15:45:02
//* Libellé			: 
//* Commentaires	: On initialise certains instances, on va lancer WORD
//*
//* Arguments		: (Val)		Boolean		abFermer_SansVerifier
//*
//* Retourne		: Integer			 1 = Tout est OK
//*											-1 = Il manque des informations dans le fichier INI
//*											-2 = Impossible de créer le fichier INI servant à la communication avec WORD
//*											-3 = La création de l'objet OLE Word est impossible
//*											-4 = Il existe des documents ouverts dans WORD et non sauvegardés
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  	   Modification
//       JFF  26/04/2023 [RS5045_REF_MATP]
//*-----------------------------------------------------------------

String sFicIniApp, sWord
Integer iRet
String sVarErr[]
N_Cst_Word	nvWord
n_cst_string lnvPFCString
Long lDeb, lFin

sFicIniApp = stGLB.sFichierIni
/*------------------------------------------------------------------*/
/* On positionne une variable pour savoir si WORD est ouvert avant  */
/* le TRAITEMENT. Une fenêtre en chair et en 'os'.                  */
/*------------------------------------------------------------------*/
F_SetVersionWord ( nvWord, TRUE )
iulHandleWord = nvWord.uf_WordOuvert ()
If	iulHandleWord > 0	Then
	ibWordOuvertAvantTraitement = TRUE
Else
	ibWordOuvertAvantTraitement = FALSE
End If

/*------------------------------------------------------------------*/
/* On positionne le nombre de courrier édités à 0.                  */
/*------------------------------------------------------------------*/
ilNbCourrierEdite = 0
ilNbDocumentEdite = 0
/*------------------------------------------------------------------*/
/* On positionne le nombre de documents d'un courrier à 0.          */
/*------------------------------------------------------------------*/
ilNbDocument		= 0
/*------------------------------------------------------------------*/
/* On arme les valeurs pour le répertoire des courriers, le nom du  */
/* fichier d'entête et le nom du modèle à utiliser.                 */
/*------------------------------------------------------------------*/
isRepCourrier	= ProfileString ( sFicIniApp, "EDITION", "REP_COURRIER",  "" )
isEntete			= ProfileString ( sFicIniApp, "EDITION", "ENTETE",  "" )
isModele		   = ProfileString ( sFicIniApp, "EDITION", "MODELE",  "" )
isModeleDefaut = isModele // [RS5045_REF_MATP]

/*------------------------------------------------------------------*/
/* S'il manque des informations, on affiche un message d'erreur et  */
/* on arrête tout.                                                  */
/*------------------------------------------------------------------*/
If	isRepCourrier = "" Or isModele = "" Or isEntete = ""	Then
	sVarErr[1] = sFicIniApp

	stMessage.sTitre		= "N_Cst_Edition_Courrier - uf_InialiserWord()"
	stMessage.sVar			= sVarErr
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "EDI010"
	stMessage.bTrace  	= False

	F_Message ( stMessage )

	Return ( -1 )
End If
/*------------------------------------------------------------------*/
/* Le fichier INI servant pour la communication avec WORD doit      */
/* exister. Si ce n'est pas le cas, on procéde à la création A      */
/* VIDE de ce fichier.                                              */
/*------------------------------------------------------------------*/
If	FileClose ( FileOpen ( isFicCourrierIni, LineMode!, Write!, LockReadWrite!, Replace! ) ) < 0	Then		
	sVarErr[1] = isFicCourrierIni

	stMessage.sTitre		= "N_Cst_Edition_Courrier - uf_InialiserWord()"
	stMessage.sVar			= sVarErr
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "EDI015"
	stMessage.bTrace  	= False

	F_Message ( stMessage )

	Return ( -2 )
End IF
/*------------------------------------------------------------------*/
/* On initialise maintenant l'objet OLE servant à la communication  */
/* avec WORD.                                                       */
/*------------------------------------------------------------------*/
If	Not IsValid ( iOleWord )	Then 
	iOleWord = CREATE OleObject
End If	

iRet = nvWord.uf_CreerOleObject_Word ( iOleWord )
If	iRet < 0	Then
	F_SetVersionWord ( nvWord, FALSE )

	stMessage.sTitre		= "N_Cst_Edition_Courrier - uf_InialiserWord()"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "EDI020"
	stMessage.bTrace  	= False

	F_Message ( stMessage )

	Return ( -3 )
End If
/*------------------------------------------------------------------*/
/* On vérifie s'il existe des documensts WORD ouverts et non        */
/* sauvegardés.                                                     */
/*------------------------------------------------------------------*/
iRet = nvWord.uf_FichierOuvertDansWord ( iOleWord, TRUE, abFermer_SansVerifier )
If	iRet < 0	Then
	F_SetVersionWord ( nvWord, FALSE )
	Return ( -4 )
End If

F_SetVersionWord ( nvWord, FALSE )
Return ( 1 )


end function

private function boolean uf_verifieriddocument (long alIdDocument);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_VerifierIdDocument		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 17:37:48
//* Libellé			: 
//* Commentaires	: On vérifie si l'Id du document est valide.
//*
//* Arguments		: (Val)		Long		alIdDocument		ID du document à vérifier
//*
//* Retourne		: Boolean					TRUE	= ID est correct
//*													FALSE	= ID non trouvé
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------
/*------------------------------------------------------------------*/
/* L'ID du document doit être supérieur à 0.                        */
/*------------------------------------------------------------------*/
If	alIdDocument <= 0	Then	Return ( FALSE )
/*------------------------------------------------------------------*/
/* Si l'ID du document est supérieur au nombre d'éléments du        */
/* tableau des références, il y a une erreur.                       */
/*------------------------------------------------------------------*/
If	alIdDocument > UpperBound ( isIdDocument )	Then Return ( FALSE )
/*------------------------------------------------------------------*/
/* Si l'élément du tableau de référence est vide, on arrête tout.   */
/*------------------------------------------------------------------*/
If	IsNull ( isIdDocument[ alIdDocument ] ) Then Return ( FALSE )
If	Trim ( isIdDocument[ alIdDocument ] ) = "" Then Return ( FALSE )

Return ( TRUE )

end function

public function integer uf_verifier_word_avantgeneration (boolean abfermer_sansverifier);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_Verifier_Word_AvantGeneration		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 15:45:02
//* Libellé			: 
//* Commentaires	: On vérifie si WORD est ouvert, s'il existe des documents non sauvegardés
//*					  Si tout est OK, on ferme tous les documents
//*
//* Arguments		: (Val)		Boolean		abFermer_SansVerifier
//*
//* Retourne		: Integer			 1 = Tout est OK
//*											-1 = Il y a une erreur
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Integer iRet, iRetWord
N_Cst_Word	nvWord
OleObject		OleWord


iRet = 1
/*------------------------------------------------------------------*/
/* On vérifie si WORD est OUVERT ou NON.                            */
/*------------------------------------------------------------------*/
F_SetVersionWord ( nvWord, TRUE )
iulHandleWord = nvWord.uf_WordOuvert ()
If	iulHandleWord > 0	Then

	OleWord = CREATE OleObject
	iRetWord = nvWord.uf_CreerOleObject_Word ( OleWord )
	
	If	iRetWord < 0	Then
		stMessage.sTitre		= "N_Cst_Edition_Courrier - uf_Verifier_Word_AvantGeneration()"
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "EDI020"
		stMessage.bTrace  	= False

		F_Message ( stMessage )

		iRet = -1
	End If
/*------------------------------------------------------------------*/
/* On vérifie s'il existe des documensts WORD ouverts et non        */
/* sauvegardés.                                                     */
/*------------------------------------------------------------------*/
/* On peut forcer la fermeture de tous les documents sans se poser  */
/* de question.                                                     */
/*------------------------------------------------------------------*/
	If	iRet = 1	Then
		iRetWord = nvWord.uf_FichierOuvertDansWord ( OleWord, TRUE, abFermer_SansVerifier )
		If	iRetWord < 0	Then
			iRet = -1
		End If
	End If
	
	Destroy OleWord
End If

F_SetVersionWord ( nvWord, FALSE )

Return ( iRet )


end function

public function integer uf_fermerdocument (long aliddocument);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_FermerDocument		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 11:08:25
//* Libellé			: 
//* Commentaires	: On ferme le document en cours de traitement
//*
//* Arguments		: (Val)		Long			alIdDocument
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = L'Id du document n'existe pas
//*														-2 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sSection, sCle, sText, sFicDonnee, sFicPiec, sFicPost, sFicPart, sCourrierSauve, sTypeSauve
String sNull, sFicSupp, sExtension
Char sCharSauve[]
Long lTot, lCpt

SetNull ( sNull )


/*------------------------------------------------------------------*/
/* On vérifie d'abord si l'ID est correct.                          */
/*------------------------------------------------------------------*/
If	Not uf_VerifierIdDocument ( alIdDocument )	Then
	Return ( -1 )
End If
/*------------------------------------------------------------------*/
/* On ferme le document en cours de traitement.                     */
/*------------------------------------------------------------------*/
sSection = "COURRIER"
sCle		= "NBR_DOC"
sText		= String ( ilNbDocument - 1 )

If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -2 )
End If
/*------------------------------------------------------------------*/
/* On remet le pointeur sur le code courrier à NULL.                */
/*------------------------------------------------------------------*/
sSection = "COURRIER"
sCle		= "DOCUMENT_" + String ( alIdDocument )

If	invWin.uf_SetProfileString ( isFicCourrierIni, sSection, sCle, sNull ) < 1	Then
	Return ( -2 )
End If
/*------------------------------------------------------------------*/
/* On enleve toutes les cles (ENTETE,PIEC,POST,PART,BAC,DONNEE)     */
/* faisant référence au document en cours. On enléve aussi cette    */
/* section.                                                         */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On supprime tous les fichiers qui peuvent trainer pour le        */
/* document en cours.                                               */
/*------------------------------------------------------------------*/
sSection		= isIdDocument[ alIdDocument ]
sFicDonnee	= ProfileString ( isFicCourrierIni, sSection, "DONNEE", "" )
sFicPiec		= ProfileString ( isFicCourrierIni, sSection, "AUTRE PIECE", "" )
sFicPost		= ProfileString ( isFicCourrierIni, sSection, "POST SCRIPTUM", "" )
sFicPart		= ProfileString ( isFicCourrierIni, sSection, "PARTICULIER", "" )

FileDelete ( sFicDonnee )
FileDelete ( sFicPiec )
FileDelete ( sFicPost )
FileDelete ( sFicPart )

If	invWin.uf_SetProfileString ( isFicCourrierIni, sSection, sNull, sNull ) < 1	Then
	Return ( -2 )
End If
/*------------------------------------------------------------------*/
/* On positionne les valeurs d'instances.                           */
/*------------------------------------------------------------------*/
ilNbDocument --
isIdDocument[ alIdDocument ] = sNull

/*------------------------------------------------------------------*/
/* S'il s'agit du dernier document du courrier, on enléve les       */
/* paramètres particuliers que l'on peut positionner dans le        */
/* fichier INI.                                                     */
/*------------------------------------------------------------------*/
If	ilNbDocument = 0	Then
	sCourrierSauve	= ProfileString ( isFicCourrierIni, "COURRIER", "FIC_SAUVE", "" )
	If	sCourrierSauve <> ""	Then
/*------------------------------------------------------------------*/
/* Il peut exister plusieurs fichiers (en fonction du paramètre     */
/* TYPE_SAUVE).                                                     */
/*------------------------------------------------------------------*/
		sTypeSauve = ProfileString ( isFicCourrierIni, "COURRIER", "TYPE_SAUVE", "" )
		sCharSauve[] = sTypeSauve
		lTot = UpperBound ( sCharSauve )
		For	lCpt = 1 To lTot
				Choose Case sCharSauve[ lCpt ]
					Case "0"
						sExtension = ".DOC"
					Case "1"
						sExtension = ".DOT"						
					Case "2", "3", "4"
						sExtension = ".TXT"
					Case "5"
						sExtension = ".RTF"
				End Choose
				sFicSupp = sCourrierSauve + sExtension
				FileDelete ( sFicSupp )
			Next
	End If
	sSection = "COURRIER"
	sCle		= "FIC_SAUVE"
	
	If	invWin.uf_SetProfileString ( isFicCourrierIni, sSection, sCle, sNull ) < 1	Then
		Return ( -2 )
	End If
	
	sCle		= "TYPE_SAUVE"
	If	invWin.uf_SetProfileString ( isFicCourrierIni, sSection, sCle, sNull ) < 1	Then
		Return ( -2 )
	End If
	
	sCle		= "EDITION"
	If	invWin.uf_SetProfileString ( isFicCourrierIni, sSection, sCle, sNull ) < 1	Then
		Return ( -2 )
	End If

	sCle		= "DTE_EDIT_COURRIER"
	If	invWin.uf_SetProfileString ( isFicCourrierIni, sSection, sCle, sNull ) < 1	Then
		Return ( -2 )
	End If
End If

Return ( 1 )

end function

public function integer uf_genererdata (long aliddocument, ref blob abldata);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_Genererata		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:12:30
//* Libellé			: 
//* Commentaires	: On s'occupe de générer le fichier des DATAS correspondants 
//*					  au document en cours de traitement
//*
//* Arguments		: (Val)		Long			alIdDocument		ID du document en cours de traitement
//*					  (Réf)		Blob			ablData				Blob à traiter
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = L'Id du document n'existe pas
//*														-2 = La cle ENTETE n'existe pas dans le fichier INI
//*														-3 = L'écriture du fichier contenant les DATAS et l'entete est impossible
//*														-4 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  			Modification
//* #1 		 DGA      19/09/2006    Gestion d'un répertoire temporaire DCMP-060643
//* 
//*-----------------------------------------------------------------

String sSection, sCle, sFicEntete, sFicData
Boolean bEcriture
Integer iFic
Blob blData

/*------------------------------------------------------------------*/
/* On vérifie d'abord si l'ID est correct.                          */
/*------------------------------------------------------------------*/
If	Not uf_VerifierIdDocument ( alIdDocument )	Then
	Return ( -1 )
End If

bEcriture	= TRUE
sSection		= isIdDocument[ alIdDocument ]
sCle			= "ENTETE"
/*------------------------------------------------------------------*/
/* On vérifie s'il existe bien une ENTETE de positionnée dans le    */
/* fichier INI. Cela est normalement fait dans la fonction          */
/* uf_OuvrirCourrier ().                                            */
/*------------------------------------------------------------------*/
sFicEntete = ProfileString ( isFicCourrierIni, sSection, sCle, "" )
If	sFicEntete = ""	Then
	Return ( -2 )
End If
/*------------------------------------------------------------------*/
/* On positionne le blob pour les DATAS.                            */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On essaye d'écrire ce blob dans un fichier sur disque.           */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sFicData = stGLB.sWinDir + "\TEMP" + "\VAR_" + String ( alIdDocument ) + ".TXT"
sFicData = stGLB.sRepTempo + "VAR_" + String ( alIdDocument ) + ".TXT"

iFic	= FileOpen ( sFicData, StreamMode!, Write!, LockReadWrite!, Replace! )
If FileWrite ( iFic, ablData ) < 0 Then	bEcriture = FALSE
FileClose( iFic )

If	Not bEcriture Then	Return ( -3 )

/*------------------------------------------------------------------*/
/* On va maintenant inscrire la présence du Blob dans le fichier    */
/* INI.                                                             */
/*------------------------------------------------------------------*/
sCle = "DONNEE"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, sFicData ) < 1	Then
	Return ( -4 )
End If

Return ( 1 )

end function

public function integer uf_genererblob (long aliddocument, string astypeblob, ref blob ablword);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_GenererBlob			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:12:30
//* Libellé			: 
//* Commentaires	: On s'occupe de générer les Blobs correspondants à 
//*					  AUTRE PIECE, POST SCRIPTUM, COURRIER PARTICULIER
//*
//* Arguments		: (Val)		Long			alIdDocument		ID du document en cours de traitement
//*					  (Val)		String		asTypeBlob			Type du Blob à traiter
//*					  (Réf)		Blob			ablWord				Blob à traiter
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = L'Id du document n'existe pas
//*														-2 = L'écriture du blob vient d'échouer
//*														-3 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  			Modification
//* #1 		 DGA      19/09/2006    Gestion d'un répertoire temporaire DCMP-060643
//*-----------------------------------------------------------------

String sSection, sCle, sFic

/*------------------------------------------------------------------*/
/* On vérifie d'abord si l'ID est correct.                          */
/*------------------------------------------------------------------*/
If	Not uf_VerifierIdDocument ( alIdDocument )	Then
	Return ( -1 )
End If

sSection = isIdDocument[ alIdDocument ]
/*------------------------------------------------------------------*/
/* On procéde à l'écriture du blob sur le disque.                   */
/*------------------------------------------------------------------*/
Choose Case asTypeBlob
Case "PIEC"
	sCle = "AUTRE PIECE"
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//	sFic = stGLB.sWinDir + "\TEMP" + "\PIEC_" + String ( alIdDocument ) + ".SPB"
	sFic = stGLB.sRepTempo + "PIEC_" + String ( alIdDocument ) + ".SPB"	
	
Case "POST"
	sCle = "POST SCRIPTUM"
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//	sFic = stGLB.sWinDir + "\TEMP" + "\POST_" + String ( alIdDocument ) + ".SPB"
	sFic = stGLB.sRepTempo + "POST_" + String ( alIdDocument ) + ".SPB"
Case "PART"
	sCle = "PARTICULIER"
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//	sFic = stGLB.sWinDir + "\TEMP" + "\PART_" + String ( alIdDocument ) + ".SPB"
	sFic = stGLB.sRepTempo + "PART_" + String ( alIdDocument ) + ".SPB"
End Choose
/*------------------------------------------------------------------*/
/* On procéde à l'écriture du blob. Si cette opération échoue, on   */
/* arrête tout.                                                     */
/*------------------------------------------------------------------*/
If	Not F_EcrireFichierBlob ( ablWord, sFic )	Then Return ( -2 )

/*------------------------------------------------------------------*/
/* On va maintenant inscrire la présence du Blob dans le fichier    */
/* INI.                                                             */
/*------------------------------------------------------------------*/
If	SetProfileString ( isFicCourrierIni, sSection, sCle, sFic ) < 1	Then
	Return ( -3 )
End If

Return ( 1 )

end function

public function integer uf_inscrire_gestionparticuliere (long alIdDocument, string asComposition);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_Inscrire_GestionParticulier		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 17:33:52
//* Libellé			: 
//* Commentaires	: On va positionner une clé dans le fichier INI
//*					  On désire une gestion particuliére. (GESTION_PART='O')
//*					  La clé suivante correspond au nom du fichier à ouvrir sans composition et sans DATA.
//*
//*
//* Arguments		: (Val)		Long		alIdDocument		ID du document à traiter
//*					  (Val)		String	asComposition		Nom du fichier en dur à ouvrir par WORD
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = L'Id du document n'existe pas
//*														-2 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sSection, sCle, sText

/*------------------------------------------------------------------*/
/* On vérifie d'abord si l'ID est correct.                          */
/*------------------------------------------------------------------*/
If	Not uf_VerifierIdDocument ( alIdDocument )	Then
	Return ( -1 )
End If
/*------------------------------------------------------------------*/
/* On va maintenant inscrire la composition du document à ouvrir    */
/* dans le fichier INI.                                             */
/*------------------------------------------------------------------*/
sSection = isIdDocument[ alIdDocument ]
sCle		= "COMPOSITION"
sText		= asComposition

If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -2 )
End If
/*------------------------------------------------------------------*/
/* On va maintenant inscrire qu'il s'agit d'une gestion             */
/* particuliére.                                                    */
/*------------------------------------------------------------------*/
sCle		= "GESTION_PART"
sText		= "O"

If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -2 )
End If

Return ( 1 )



end function

public function integer uf_inscrirebac (long aliddocument, string asbac, integer aitypeimprimante);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_InscrireBac		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:35:14
//* Libellé			: 
//* Commentaires	: On va inscrire le bac dans le fichier INI
//*
//* Arguments		: (Val)		Long		alIdDocument		ID du document à traiter
//*					  (Val)		String	asBac					Bac à utiliser
//*					  (Val)		Integer	aiTypeImprimante	Type d'imprimante
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = L'Id du document n'existe pas
//*														-2 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1		PHG	13/05/2008	[SUPPORT_MFP] FONCTION OBSOLETE !!!
//										Gardée pour Compatibilité SAVANE/SINDI Uniquement.
//										Utiliser la version avec descripteur d'Imprimante :
//		uf_InscrireBac( /*long aliddocument*/, /*string asbac*/, /*n_cst_printer_descriptor anv_printer */)
//*-----------------------------------------------------------------

String sSection, sCle, sText

/*------------------------------------------------------------------*/
/* On vérifie d'abord si l'ID est correct.                          */
/*------------------------------------------------------------------*/
If	Not uf_VerifierIdDocument ( alIdDocument )	Then
	Return ( -1 )
End If

/*------------------------------------------------------------------*/
/* On va maintenant inscrire le bac à utiliser dans le fichier INI. */
/*------------------------------------------------------------------*/
sSection = isIdDocument[ alIdDocument ]
sCle		= "BAC"
/*------------------------------------------------------------------*/
/* Le type d'imprimante 1 fait référence aux imprimantes Xerox      */
/* 4520 et Compaq PageMarq.                                         */
/*------------------------------------------------------------------*/
Choose Case aiTypeImprimante
Case 1
	Choose Case asBac
	Case "HAUT"
		sText = "1"
	Case "MILIEU"
		sText = "3"
	Case "BAS"
		sText = "2"
	End Choose
End Choose

If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -2 )
End If

Return ( 1 )

end function

public function integer uf_inscrirecomposition (long aliddocument, string ascomposition);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_InscrireComposition		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 17:33:52
//* Libellé			: 
//* Commentaires	: On va positionne la composition du document en cours de traitement
//*						dans le fichier INI servant à la communication avec WORD
//*
//* Arguments		: (Val)		Long		alIdDocument		ID du document à traiter
//*					  (Val)		String	asComposition		Composition à inscrire
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = L'Id du document n'existe pas
//*														-2 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//    		 JFF   31/03/2021 [PRBLE_PATCH_MS_WORD]
//*-----------------------------------------------------------------

String sSection, sCle, sText, sText2, sCompoWork, sPara, sCheminRepCourrierLocal, sRepCourrier, sCheminRepCourrierLocalPara 	
unsignedlong ival

// [PRBLE_PATCH_MS_WORD]
sCompoWork = asComposition
sCheminRepCourrierLocal = stGlb.sRepTempo + "COURRIER\"
sRepCourrier 	= ProfileString ( stGLB.sFichierIni , "EDITION" , "REP_COURRIER" 	, "" 	)

/*------------------------------------------------------------------*/
/* On vérifie d'abord si l'ID est correct.                          */
/*------------------------------------------------------------------*/
If	Not uf_VerifierIdDocument ( alIdDocument )	Then
	Return ( -1 )
End If
/*------------------------------------------------------------------*/
/* On va maintenant inscrire la composition du document à éditer    */
/* dans le fichier INI.                                             */
/*------------------------------------------------------------------*/
sSection = isIdDocument[ alIdDocument ]
sCle		= "COMPOSITION"
sText		= asComposition
/*------------------------------------------------------------------*/
/* Pour les compositions un peu longues (+ de 31 paragraphes), on   */
/* découpe la chaîne en deux TOPICS.                                */
/*------------------------------------------------------------------*/
If	Len ( sText ) > 248	Then
	sText2	= Right ( sText, Len ( sText ) - 248 )
	sText		= Left ( sText, 248 )
/*------------------------------------------------------------------*/	
/* Seconde COMPOSITION.                                             */
/*------------------------------------------------------------------*/
	sCle = "COMPOSITION2"
	If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText2 ) < 1	Then
		Return ( -2 )
	End If
End If
/*------------------------------------------------------------------*/	
/* Première COMPOSITION.                                            */
/*------------------------------------------------------------------*/
If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -2 )
End If
	

// [PRBLE_PATCH_MS_WORD]
// Si l'inscription de la chaine compo a réussi, on rappatrie les paragraphes en local
Do While Len ( sCompoWork ) > 0 
	sPara = Left ( sCompoWork, 8 ) 
	sCheminRepCourrierLocalPara = sCheminRepCourrierLocal + sPara
	If Not FileExists ( sCheminRepCourrierLocalPara ) Then 
		If FileCopy ( sRepCourrier	+ sPara, sCheminRepCourrierLocalPara, TRUE )	< 0 Then
			Return (-2)
		End If 
		iVal = 128 // Normal, sinon 1 pour ReadOnly. avec 128 on enlève le ReadOnly
		invWin.uf_SetFileAttributes( sCheminRepCourrierLocalPara, iVal )
	End If 
	sCompoWork = Right ( sCompoWork, Len ( sCompoWork ) - 8 ) 
Loop 

// Et On inscrit le chemin du Répertoire Local
If	SetProfileString ( isFicCourrierIni, "COURRIER", "REP_PARA_LOCAL", sCheminRepCourrierLocal ) < 1	Then
	Return ( -2 )
End If

// Et Une clé de bascule pour utilisation génération Local ou standard (comme avant )
If	SetProfileString ( isFicCourrierIni, "COURRIER", "GENERATION_LOCAL", "OUI") < 1	Then
	Return ( -2 )
End If	

Return ( 1 )


end function

public function integer uf_inscrireparamcourrier (string ascourriersauve, string astypesauve, string asedition, string asmisesouspli);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_InscrireParamCourrier			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:35:14
//* Libellé			: 
//* Commentaires	: On va inscrire certains paramètres pour le courrier
//*
//* Arguments		: (Val)		String	asCourrierSauve	Nom du fichier à sauvegarder
//*					  (Val)		String	asTypeSauve			Type de sauvegarde (DOC-HTM)
//*					  (Val)		String	asEdition			Doit-on editer le courrier ?
//*					  (Val)		String	asMiseSousPli		Doit-on positionner les marques de Mise Sous Pli ?
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1		 PHG	  31/10/06 [DNTMAIL1-2] Surcharge de la fonction en 
//*								  uf_InscrireParamCourrier2
//*-----------------------------------------------------------------

Return ( uf_InscrireParamCourrier2 ( ascourriersauve, astypesauve, asedition, asmisesouspli, k_canal_courrier ) )


end function

public function integer uf_ouvrirdocument (string ascodecourrier, string asentetedata);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_OuvrirDocument		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 16:34:52
//* Libellé			: 
//* Commentaires	: On ouvre un courrier
//*
//* Arguments		: (Val)		String		asCodeCourrier
//*					  (Val)		String		asEnteteData
//*
//* Retourne		: Long						Id du document ouvert
//*													-1 = Il y a une erreur
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  			Modification
//* #1 		 DGA      19/09/2006    Gestion d'un répertoire temporaire DCMP-060643
//* 
//*-----------------------------------------------------------------

Long lIdDocument, lTotId, lCpt
String sSection, sCle, sText, sRepWinTmp

lIdDocument = 0
lTotId		= UpperBound ( isIdDocument )
/*------------------------------------------------------------------*/
/* On ouvre un document. Il est possible d'avoir plusieurs          */
/* documents pour un même courrier. (Ex:Courrier Assuré + Double    */
/* Autre Courrier )                                                 */
/*------------------------------------------------------------------*/
If lTotId >= 1	Then
/*------------------------------------------------------------------*/	
/* On récupére le premier élément libre du tableau.                 */
/*------------------------------------------------------------------*/
	For	lCpt = 1 To lTotId
			If	IsNull ( isIdDocument[ lCpt ]	) Then
				lIdDocument = lCpt
				Exit
			End If				
	Next
/*------------------------------------------------------------------*/	
/* S'il n'existe aucun élément libre dans le tableau des ID, on en  */
/* ajoute 1.                                                        */
/*------------------------------------------------------------------*/
	If	lIdDocument = 0	Then
		lTotId ++
		lIdDocument = lTotId
	End If
Else
/*------------------------------------------------------------------*/	
/* Il s'agit du premier document pour le courrier en cours de       */
/* traitement.                                                      */
/*------------------------------------------------------------------*/
	lIdDocument = 1
End If
/*------------------------------------------------------------------*/
/* On positionne dans le fichier INI, le répertoire temporaire ou   */
/* l'on va stocker les DOCUMENTS générés avant regroupement du      */
/* courrier. Ces documents seront sont le format DOC___NN.DOC       */
/*------------------------------------------------------------------*/
sSection		= "COURRIER"
sCle			= "WINTEMP"
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepWinTmp	= stGLB.sWinDir + "\TEMP" + "\DOC__"
sRepWinTmp	= stGLB.sRepTempo + "DOC__"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, sRepWinTmp ) < 1	Then
	Return ( -1 )
End If

/*------------------------------------------------------------------*/
/* On positionne dans le fichier INI de communication, le nombre    */
/* de document à éditer pour le courrier.                           */
/*------------------------------------------------------------------*/
sSection = "COURRIER"
sCle		= "NBR_DOC"
sText		= String ( ilNbDocument + 1 )

If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -1 )
End If
/*------------------------------------------------------------------*/
/* On positionne dans la section "COURRIER", le N° du document en   */
/* cours de traitement, ainsi que le code courrier à éditer.        */
/*------------------------------------------------------------------*/
sSection = "COURRIER"
sCle		= "DOCUMENT_" + String ( lIdDocument )
sText		= asCodeCourrier + String ( lIdDocument )

If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -1 )
End If
/*------------------------------------------------------------------*/
/* On positionne dans une section portant le nom du code courrier   */
/* à éditer, l'entete des DATAS.                                    */
/*------------------------------------------------------------------*/
sSection	= asCodeCourrier + String ( lIdDocument )
sCle		= "ENTETE"
/*------------------------------------------------------------------*/
/* Il est possible d'utiliser l'entête STANDARD positionnée dans    */
/* le fichier de l'application. Néammoins le script client peut     */
/* décider d'utiliser un fichier différent, il doit dans ce cas,    */
/* passer la bonne valeur (Répertoire+Fichier) dans l'appel de la   */
/* fonction.                                                        */
/*------------------------------------------------------------------*/
If	asEnteteData = ""	Then
	sText		= isRepCourrier + isEntete
Else
	sText		= asEnteteData
End If

If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -1 )
End If
/*------------------------------------------------------------------*/
/* On incrémente maintenant le nombre de document en cours pour le  */
/* courrier.                                                        */
/*------------------------------------------------------------------*/
ilNbDocument ++
/*------------------------------------------------------------------*/
/* On positionne le code courrier en cours de traitement dans le    */
/* tableau d'instance.                                              */
/*------------------------------------------------------------------*/
isIdDocument[ lIdDocument ] = asCodeCourrier + String ( lIdDocument )

Return ( lIdDocument )


end function

public function integer uf_initialiserfichierspool ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_InitialiserFichierSpool 		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 16:33:21
//* Libellé			: 
//* Commentaires	: On initialise le nom du fichier qui sera généré par WORD
//*					  et envoyé au sur le SPOOL à la fin du traitement
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer			
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  			Modification
//* #1 		 DGA      19/09/2006    Gestion d'un répertoire temporaire DCMP-060643
//* 
//*-----------------------------------------------------------------

String sNow, sRepWin, sSection, sCle, sText

/*------------------------------------------------------------------*/
/* On supprime l'ancien fichier de SPOOL s'il existe.               */
/*------------------------------------------------------------------*/
If	Not IsNull ( isFicSpool ) Or Len ( Trim ( isFicSpool ) ) > 0	Then
	FileDelete ( isFicSpool )
End If

/*------------------------------------------------------------------*/
/* Le nom du fichier de SPOOL est composé de la manière suivante.   */
/* HH_MM_SS.XXX                                                     */
/* HH		= Heure courante                                           */
/* MM		= Minute courante                                          */
/* SS		= Seconde courante                                         */
/* XXX	= Code de l'application sur 3 positions                    */
/* Ex(15_02_58.PEG)                                                 */
/*------------------------------------------------------------------*/
sNow			= String ( Now (), "hh_mm_ss" )
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//sRepWin		= stGLB.sWinDir + "\TEMP" + "\"
sRepWin		= stGLB.sRepTempo
// DCMP-060643.SPOOL Modification temporaire désactivées, on laissait l'ancienne methode
// le temps que les ancetres 8 soient migrés
//sRepWin		= stGLB.sWinDir + "\TEMP" + "\"
isFicSpool	= sRepWin + sNow + "." + Left ( stGLB.sCodAppli, 3 )

/*------------------------------------------------------------------*/
/* On positionne dans le fichier INI de communication, le nom du    */
/* fichier que WORD va utiliser.                                    */
/*------------------------------------------------------------------*/
sSection = "COURRIER"
sCle		= "SPOOL"
sText		= isFicSpool

If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -1 )
End If

Return ( 1 )



end function

public function integer uf_imprimer (string asnommacro);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_Imprimer		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 11:38:57
//* Libellé			: 
//* Commentaires	: On lance la macro d'édition pour le courrier
//*
//* Arguments		: (Val)		String	asNomMacro			Nom de macro à utiliser
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il n'y a aucun courrier en cours
//*														-2 = Il y a un problème d'impression
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//           JFF   11/06/2019 [PM425-1]
//           JFF   04/07/2019 [PI082]
//           FS    19/08/2019 [PI082] Adaptation pour SINDI 
//       	 JFF  26/04/2023 [RS5045_REF_MATP]
//*-----------------------------------------------------------------

Long lRep
String sFicWinIni, sStatus, sRet
String sVarErr[]
N_Cst_Word	nvWord
Int iValCleSIMPA2

Boolean bSIMPA2
Boolean bSindi

String ls_keyword				// ... [PI082] 
String   sUserProfile			// ... [PI082] 
Integer li_count, li_return	// ... [PI082] 
ContextKeyword lcx_key		// ... [PI082] 
string ls_values[] // ... [PI082] 
Long  lRetProfile // ... [PI082]
Long  lRetFile	// ... [PI082]
Long  lFile // ... [PI082]

// A garder !!
// [PM425-1]
bSIMPA2 = Left ( Upper(SQLCA.Database), 5) = "SIMPA" 
bSindi = Left ( Upper(SQLCA.Database), 5) = "SINDI" 

If bSIMPA2 Then
	Select valeur
	Into :iValCleSIMPA2
	From sysadm.cle
	Where id_cle = "CS_USPR_ALD_WINDIR"
	Using SQLCA ; 
	
	If IsNull ( iValCleSIMPA2 ) Then iValCleSIMPA2 = 0
	
End IF 


/*------------------------------------------------------------------*/
/* On vérifie s'il existe au moins un document pour le courrier en  */
/* cours.                                                           */
/*------------------------------------------------------------------*/
If	ilNbDocument = 0	Then
	Return ( -1 )
End If
/*------------------------------------------------------------------*/
/* On écrit certaines indications à WORD. (Fichier                  */
/* d'initialisation de l'application) (Fichier des paramètres du    */
/* courrier à éditer). Ces informations sont écrites dans le        */
/* fichier WIN.INI.                                                 */
/*------------------------------------------------------------------*/
sFicWinIni = stGLB.sWinDir + "\WIN.INI"

/*---------------------------------------------------------------------------------------------*/
/* [Pi082] FS                                                                                                                      */
/* Constaté sur Sindi : L'écriture du win.in sur l'ancien emplacement c:\windows\win.ini renvoie 1   */
/* alors qu'il ne fonctionne pas ... donc l'écriture vers le nouvel emplacement ne se fait pas           */
/* Correctif:
      Détermination nouvel emplacement,
      Création d'un Win.Ini vide si non existant
	  Tentative d'écriture dedans : Ne fonctionnement pas su un poste W7
	  Si ne fonctionne pas alors reprise de l'ancien stGLB.sWinDir + "\WIN.INI" */
/*---------------------------------------------------------------------------------------------*/

// [PI082] 
If bSindi Then
	
		// ... 1) Lecture du USERPROFILE ex C:\Users\FS et écriture du WIN.INI 
	
		sFicWinIni =  stGlb.uoWin.uf_getenvironment("USERPROFILE") + "\Windows\WIN.INI" // TODO : revoir si le repertoire n'existe pas
		
		// ... 2) Le fichier C:\Users\FS\Windows\Win.INI existe t-il ? : Non création à vide ( sinon le SetProfileString ne fonctionne pas )
		//     En windows 7 le sous répertoire \Windows n'existe pas : Donc le code se déroulera au point 3)
		
		If not fileExists ( sFicWinIni ) Then
			
			lFile	= FileOpen ( sFicWinIni, LineMode!, Write!, LockWrite!, Append! )
			lRetFile = FileWrite ( lFile, "" )
			lRetFile = FileClose (lFile)
			
		End If
		
		lRetProfile = SetProfileString ( sFicWinIni, "IMPRESSION", "APPLICATION_INI", stGLB.sFichierIni )
		
		// ... 3)  Echec d'écriture : Ecriture sur l'ancien répertoire 
		
		If lRetProfile = -1 Then 
			sFicWinIni =  stGLB.sWinDir + "\WIN.INI"
			SetProfileString ( sFicWinIni, "IMPRESSION", "APPLICATION_INI",stGLB.sFichierIni )
		End If
		

Else

// [PI082] Code tel qu'il est pour Simpa2 laissé à l'existant 
// [DBG20241015131529340][CS_USPR_ALD_WINDIR] 
//If F_CLE_A_TRUE ( "CS_USPR_ALD_WINDIR" ) Then
	If iValCleSIMPA2 > 0 Then
		sFicWinIni = stGlb.uoWin.uf_getenvironment("USERPROFILE") + "\Windows\WIN.INI"
		SetProfileString ( sFicWinIni, "IMPRESSION", "APPLICATION_INI", stGLB.sFichierIni )
	Else 
		If SetProfileString ( sFicWinIni, "IMPRESSION", "APPLICATION_INI", stGLB.sFichierIni ) = -1 Then
			sFicWinIni = stGlb.uoWin.uf_getenvironment("USERPROFILE") + "\Windows\WIN.INI" // TODO : revoir si le repertoire n'existe pas
			SetProfileString ( sFicWinIni, "IMPRESSION", "APPLICATION_INI", stGLB.sFichierIni )
		End If
	End If 
End If


SetProfileString ( sFicWinIni, "IMPRESSION", "COURRIER_INI", isFicCourrierIni )
/*------------------------------------------------------------------*/
/* On arme la clé STATUS à vide dans le fichier INI servant à la    */
/* communication avec WORD.                                         */
/*------------------------------------------------------------------*/
SetProfileString ( isFicCourrierIni, "IMPRESSION", "STATUS", "" )
/*------------------------------------------------------------------*/
/* Le nom de la macro est vide, on utilise la macro par défaut.     */
/*------------------------------------------------------------------*/
If	asNomMacro = ""	Then
	asNomMacro = "EditerCourrier"
End If

/*------------------------------------------------------------------*/
/* On ouvre un nouveau modele dans le répertoire prévu à cet effet. */
/*------------------------------------------------------------------*/
F_SetVersionWord ( nvWord, TRUE )
Yield()

// [PM425-1]
// ibModeImpression : pourquoi ce boolean ? car en fait, cette même fonction sert à l'impression 
If bSIMPA2 And ibModeImpression Then
	sRet = This.Uf_EditionDecentralisee ( nvWord )
	
	Choose Case sRet 
		Case "SUCCES"
			// OK, on ne lance pas l'edition papier
			ibAMUEditionDecentralisee = TRUE
			
		Case "PROBLEME", "HORS_PARAM"
			// KO, on lance l'edition papier				
			nvWord.uf_CommandeWord ( 1, isRepCourrier + isModele, iOleWord )
			nvWord.uf_CommandeWord ( 2, asNomMacro, iOleWord )		
			ibAMUEditionChezSPB = TRUE
		
	End Choose 
Else
	nvWord.uf_CommandeWord ( 1, isRepCourrier + isModele, iOleWord )
	nvWord.uf_CommandeWord ( 2, asNomMacro, iOleWord )		
End If 

F_SetVersionWord ( nvWord, FALSE )

/*------------------------------------------------------------------*/
/* On vérifie si l'impression se déroule correctement. La macro     */
/* WORD positionne la valeur STATUS à OK dans le fichier INI.       */
/* Si ce n'est pas le cas, on arme une valeur d'instance à FALSE.   */
/*------------------------------------------------------------------*/
DO
	sStatus = ProfileString ( isFicCourrierIni, "IMPRESSION", "STATUS", "" )
	If	sStatus = "OK"	Then
		ibImpressionReussie = TRUE
	Else
		ibImpressionReussie = FALSE
	End If
	Yield ()
LOOP UNTIL sStatus = "OK" Or sStatus = "PAS OK"

//sStatus = ProfileString ( isFicCourrierIni, "IMPRESSION", "STATUS", "" )
//If	sStatus = "OK"	Then
//	ibImpressionReussie = TRUE
//Else
//	ibImpressionReussie = FALSE
//End If
/*------------------------------------------------------------------*/
/* Si l'impression échoue, on affiche un message d'erreur.          */
/*------------------------------------------------------------------*/
// ibCouperMsgEDI025 
If	Not ibImpressionReussie	Then
	If ibCouperMsgEDI025 Then 
		isVarErr[1] = ProfileString ( isFicCourrierIni, "IMPRESSION", "ERREUR_WORD", "Aucun message Word" )
		isVarErr[2] = ProfileString ( isFicCourrierIni, "IMPRESSION", "ERREUR_APP", "Aucun message applicatif" )
		Return ( -2 )
	Else 
		sVarErr[1] = ProfileString ( isFicCourrierIni, "IMPRESSION", "ERREUR_WORD", "Aucun message Word" )
		sVarErr[2] = ProfileString ( isFicCourrierIni, "IMPRESSION", "ERREUR_APP", "Aucun message applicatif" )
	
		stMessage.sTitre		= "N_Cst_Edition_Courrier - uf_Imprimer()"
		stMessage.sVar			= sVarErr
		stMessage.Icon			= Exclamation!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "EDI025"
		stMessage.bTrace  	= TRUE
	
		F_Message ( stMessage )
		
		Return ( -2 )
	End IF 
End If
/*------------------------------------------------------------------*/
/* On incrémente le nombre de courriers et le nombre de documents   */
/* édités.                                                          */
/*------------------------------------------------------------------*/
ilNbCourrierEdite ++
ilNbDocumentEdite += ilNbDocument

Return ( 1 )


end function

public function integer uf_envoyerimpressionauspool ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_EnvoyerImpressionAuSpool		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 16:50:55
//* Libellé			: 
//* Commentaires	: On envoie le fichier généré par WORD dans le SPOOL
//*
//* Arguments		: Aucun
//*					  
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = Il y a une erreur
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  		Modification
//* #1 		 DGA      19/09/2006 Gestion d'un répertoire temporaire DCMP-060643
//* #2		FPI		01/04/2010	[CORR_SPOOL] Augmentation du temps de timeout d'envoi au spool
//*-----------------------------------------------------------------

Long	iRet
Long lCpt
String sSpoolExe, sFicSpoolOui, sFicSpoolNon, sRepWin
Time tDeb
boolean bRet
n_cst_lanceretattendrecorrige nvLancerEtAttendreOK
/*------------------------------------------------------------------*/
/* On part du principe que le fichier généré par WORD est fermé.    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On envoie le fichier au SPOOL.                                   */
/*------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/* On va lancer un exécutable PB7 qui permet de gérer tous les cas d'OS       */
/* différents. ( WINNT/WINDOWS2000/WIN95-98).                                 */
/*----------------------------------------------------------------------------*/
sSpoolExe	= ProfileString ( stGLB.sFichierIni, "APPLICATION", "EXE_SPOOL",  &
				  ProfileString ( stGlb.sWinDir + "\MAJPOST.INI", "PARAM", "DESTINATION", "C:" ) + "\SPOOLPB7.EXE" )

//Migration PB8-WYNIWYG-03/2006 CP
//If	Not FileExists ( sSpoolExe )	Then
If	Not f_FileExists ( sSpoolExe )	Then
//Fin Migration PB8-WYNIWYG-03/2006 CP

	stMessage.sTitre		= "N_Cst_Edition_Courrier - uf_EnvoyerImpressionAuSpoo()"
	stMessage.sVar[1]		= sSpoolExe
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "EDI035"
	stMessage.bTrace  	= False

	F_Message ( stMessage )

	Return ( -1 )

Else
/*------------------------------------------------------------------*/
/* On supprime les fichiers SPOOL_OK.OUI et/ou SPOOL_OK.NON qui     */
/* peuvent exister. Ils seront créer pas l'application de SPOOL.    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//	sRepWin			= stGLB.sWinDir + "\TEMP" + "\"
	sRepWin			= stGLB.sRepTempo
// DCMP-060643.SPOOL Modif temporaire, desactivée
//	sRepWin			= stGLB.sWinDir + "\TEMP" + "\"
	sFicSpoolOui	= sRepWin + "SPOOL_OK.OUI"
	sFicSpoolNon	= sRepWin + "SPOOL_OK.NON"

//Migration PB8-WYNIWYG-03/2006 CP
//	If	FileExists ( sFicSpoolOui ) Then FileDelete ( sFicSpoolOui )
//	If	FileExists ( sFicSpoolNon ) Then FileDelete ( sFicSpoolNon )
	If	f_FileExists ( sFicSpoolOui ) Then FileDelete ( sFicSpoolOui )
	If	f_FileExists ( sFicSpoolNon ) Then FileDelete ( sFicSpoolNon )
//Fin Migration PB8-WYNIWYG-03/2006 CP	



// DBT COMMENTAIRES LBP
	//	sSpoolExe = sSpoolExe + " " + isFicSpool
	//
	//	Run ( sSpoolExe, Minimized! )
	//	Yield ()
	//
	//	tDeb = Now ()
	//
	////Migration PB8-WYNIWYG-03/2006 CP
	////	Do Until ( FileExists ( sFicSpoolOui ) ) Or ( FileExists ( sFicSpoolNon ) ) Or ( SecondsAfter ( tDeb, Now () ) > 25 )
	//	Do Until ( f_FileExists ( sFicSpoolOui ) ) Or ( f_FileExists ( sFicSpoolNon ) ) Or ( SecondsAfter ( tDeb, Now () ) > 250 ) // #2 [CORR_SPOOL] 250 ald 25
	////Fin Migration PB8-WYNIWYG-03/2006 CP
	//		
	//		Yield ()
	//		lCpt ++
	//	Loop
// FIN COMMENTAIRES LBP

	// LBP le 04/06/2010 : Lancement du spooleur via espionnage de fin de tache
	// Passage du timeout de 25s à 120s
	sSpoolExe = sSpoolExe + " " + isFicSpool
	bRet = nvLancerEtAttendreOK.uf_lanceretattendre(sSpoolExe, 120000)
	if not bRet then return -1
	

//	Do While ( Not FileExists ( sFicSpoolOui ) And Not FileExists ( sFicSpoolNon ) ) And ( lCpt <> 10000 )
//		Yield ()
//		lCpt ++
//	Loop

//Migration PB8-WYNIWYG-03/2006 CP
//	If	FileExists ( sFicSpoolOui ) Then iRet =  1
//	If	FileExists ( sFicSpoolNon ) Then iRet = -1
	If	f_FileExists ( sFicSpoolOui ) Then iRet =  1
	If	f_FileExists ( sFicSpoolNon ) Then iRet = -1
//Fin Migration PB8-WYNIWYG-03/2006 CP

End If

Return ( iRet )


end function

public subroutine uf_inscrire_valeur_differentes (string asrepcourrier, string asmodele, string asentete);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_Inscrire_Valeurs_Differentes		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 15:06:20
//* Libellé			: 
//* Commentaires	: On va positionner des valeurs différentes pour isRepCourrier, isModele,
//*					  isEntete
//*
//* Arguments		: (Val)		String		asRepCourrier		Répertoire qui contient les paragraphes
//*					  (Val)		String		asModele				Modéle à utiliser (Sans le répertoire)
//*					  (Val)		String		asEntete				Fichier d'entête servant à la fusion ( Sans le répertoire )
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

If Not IsNull ( asRepCourrier )	And Len ( Trim ( asRepCourrier ) )	> 0	Then isRepCourrier	= asRepCourrier
If Not IsNull ( asModele )			And Len ( Trim ( asModele ) ) 		> 0	Then isModele			= asModele
If Not IsNull ( asEntete )			And Len ( Trim ( asEntete ) ) 		> 0	Then isEntete			= asEntete
end subroutine

public subroutine uf_envoyer_commande (integer aitype, string asparam);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_Imprimer		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 11:38:57
//* Libellé			: 
//* Commentaires	: On lance la macro d'édition pour le courrier
//*
//* Arguments		: (Val)		Integer	aiType				Type de commande
//*					  (Val)		String	asParam				Paramètre
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

N_Cst_Word	nvWord

F_SetVersionWord ( nvWord, TRUE )
nvWord.uf_CommandeWord ( aiType, asParam, iOleWord )
F_SetVersionWord ( nvWord, FALSE )

end subroutine

public function long uf_cle_edition_fichierini (string ascle);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_Cle_Edition_FichierIni		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 15:06:20
//* Libellé			: 
//* Commentaires	: On va positionner une valeur particulere dans le fichier INI servant à l'édition
//*
//* Arguments		: (Val)		String		asCle					Valeur de la clé
//*
//* Retourne		: Long						 1 = Tout est OK
//*													-1 = Il y a une erreur
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sSection, sCle, sText

/*------------------------------------------------------------------*/
/* En SIMPA2, il existe plusieurs entrées pour les valeurs          */
/* d'édition ([EDITION], [EDITION_SIMPA1]). Or la macro utilise     */
/* par défaut la clé [EDITION] du fichier INI de l'application.     */
/* Cette fonction sert à armer une valeur différente dans la        */
/* section principale du fichier INI servant à l'édition (Ex        */
/* C:\SPB\SIM2_C.INI).                                              */
/*------------------------------------------------------------------*/
If Not IsNull ( asCle )	And Len ( Trim ( asCle ) )	> 0	Then

	sSection = "COURRIER"
	sCle		= "CLE_EDITION"
	sText		= asCle

	If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
		Return ( -1 )
	End If
End If

Return ( 1 )
end function

public function string uf_getnomfichierspool ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_GetNomFichierSpool		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 16:50:55
//* Libellé			: 
//* Commentaires	: On retourne le nom du fichier de SPOOL
//*
//* Arguments		: Aucun
//*					  
//*
//* Retourne		: String 
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Return ( isFicSpool )

end function

public function integer uf_inscrire_dteedition_courrier (string asdteedit);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_Inscrire_DteEdition_Duplicata		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:35:14
//* Libellé			: 
//* Commentaires	: On va inscrire la date d'édition (pour un duplicata) dans le fichier INI.
//*
//* Arguments		: (Val)		String	asDteEdit			Date d'édition pour le duplicata
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-2 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sSection, sCle, sText

/*------------------------------------------------------------------*/
/* On va maintenant inscrire la date d'édition dans le fichier INI. */
/*------------------------------------------------------------------*/
sSection = "COURRIER"
sCle		= "DTE_EDIT_COURRIER"
sText		= asDteEdit

If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -2 )
End If

Return ( 1 )

end function

public function integer uf_inscrire_dteedition_document (long aliddocument, string asdteedit);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_Inscrire_DteEdition_Document (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:35:14
//* Libellé			: 
//* Commentaires	: On va inscrire la date d'édition (pour un duplicata) dans le fichier INI.
//*
//* Arguments		: (Val)		Long		alIdDocument		ID du document à traiter
//*					  (Val)		String	asDteEdit			Date d'édition pour le duplicata
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = L'Id du document n'existe pas
//*														-2 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sSection, sCle, sText

/*------------------------------------------------------------------*/
/* On vérifie d'abord si l'ID est correct.                          */
/*------------------------------------------------------------------*/
If	Not uf_VerifierIdDocument ( alIdDocument )	Then
	Return ( -1 )
End If

/*------------------------------------------------------------------*/
/* On va maintenant inscrire la date d'édition dans le fichier INI. */
/*------------------------------------------------------------------*/
sSection = isIdDocument[ alIdDocument ]
sCle		= "DTE_EDIT_DOCUMENT"
sText		= asDteEdit

If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -2 )
End If

Return ( 1 )

end function

public function long uf_ouvrirdocument_2 (string asnomfichier);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_OuvrirDocument_2		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 16:34:52
//* Libellé			: 
//* Commentaires	: On ouvre un courrier directement à partir du disque
//*
//* Arguments		: (Val)		String		asCodeCourrier
//*
//* Retourne		: Long						Id du document ouvert
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sSection, sCle


ilNbDocument = 1
/*------------------------------------------------------------------*/
/* On ouvre le document positionné sur disque. On va ensuite        */
/* positionner les codes de mise sous pli et editer le courrier.    */
/*------------------------------------------------------------------*/
sSection		= "COURRIER"
sCle			= "NOMFICH"

If	SetProfileString ( isFicCourrierIni, sSection, sCle, asNomFichier ) < 1	Then
	Return ( -1 )
End If

Return ( 1 )

end function

public subroutine uf_changermodele (string asmodele);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_Edition_Courrier::uf_ChangerModele (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 15/01/2004 15:39:27
//* Libellé       : Changer dynamiquement le modèle après qu'il ait
//*					  été affecté dans uf_InitialiserWord
//* Commentaires  : 
//*
//* Arguments     : String		asModele			Val     // Nouveau modèle à appliquer
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Exemple : asModele = "ORANGE.DOT"                                */
/*------------------------------------------------------------------*/
isModele = asModele

end subroutine

public subroutine uf_inscrire_droitsmodifcourrier (integer aidroitinter[]);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_Inscrire_DroitsModifCourrier	(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 29/03/2004 10:35:14
//* Libellé			: Inscription du tableau définissant les droits de modification O/N des courriers
//*					  de chaque inter, par le gestionnaire.
//* Commentaires	: DCMP 040020 SVE
//*
//* Arguments		: Integer	aiDroitInter []			Réf
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

iiDroitInter = aiDroitInter 


end subroutine

private function integer uf_appliquer_droitmodifcour (integer aiinter, string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction      : n_cst_Edition_Courrier::uf_Appliquer_DroitModifCour (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 29/03/2004 11:48:20
//* Libellé       : Application des droits de modication au courrier génération.
//*					  Se traduit une protection/déprotection du fichier Word sur disque.
//* Commentaires  : DCMP 040020 SVE
//*
//* Arguments     : Integer		aiInter			Val
//*					  String			asNomFic			Val
//*
//* Retourne      : Integer		1 : Tout s'est passé
//*									  -1 : Problème
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Integer iTotDroitInter, iDroit, iRet

iTotDroitInter = UpperBound ( iiDroitInter )

/*------------------------------------------------------------------*/
/* DCMP 040020 SVE : Utilisation du tableau définissant les         */
/* droits de modification des courriers automatique.                */
/* On utilise le tableau que s'il a été inscrit.						  */
/*------------------------------------------------------------------*/
iRet = 1

/*------------------------------------------------------------------*/
/* Aucun tableau inscrit, on sort avec 1, tout est ok.              */
/*------------------------------------------------------------------*/
If iTotDroitInter <= 0 Then Return 1


iDroit = iiDroitInter [  aiinter + 1 ]
/*------------------------------------------------------------------*/
/* Le gestionnaire a le droit de modifier le courrier.              */
/*------------------------------------------------------------------*/
If iDroit = 1 Then
	iRet = invWin.uf_SetFileAttributes ( asNomFic, 0 )
/*------------------------------------------------------------------*/
/* Le gestionnaire n'a pas le droit de modifier le courrier.        */
/*------------------------------------------------------------------*/
ElseIf iDroit = -1 Then
	iRet = invWin.uf_SetFileAttributes ( asNomFic, 1 )
/*------------------------------------------------------------------*/
/* Par défaut le gestionnaire peut modifier le courrier.            */
/*------------------------------------------------------------------*/
Else 
	iRet = invWin.uf_SetFileAttributes ( asNomFic, 0 )
End If

Return iRet

end function

public function integer uf_inscrire_dteedition_document_2 (string asdteedit);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_Inscrire_DteEdition_Document_2 (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 28/04/2004 10:35:14
//* Libellé			: 
//* Commentaires	: On va inscrire la date d'édition (pour un courrier existant sur disque (pas de fusion)) dans le fichier INI.
//*
//*					  (Val)		String	asDteEdit			Date d'édition d'origine
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-2 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sSection, sCle, sText

/*------------------------------------------------------------------*/
/* On va maintenant inscrire la date d'édition dans le fichier INI. */
/*------------------------------------------------------------------*/
sSection = "COURRIER"
sCle		= "DTE_EDIT_DOCUMENT"
sText		= asDteEdit

If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -2 )
End If

Return ( 1 )

end function

public function integer uf_fermerdocument_2 ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_FermerDocument_2 (PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 28//2000 11:08:25
//* Libellé			: 
//* Commentaires	: On ferme le document en cours de traitement, pour un fichier présent sur Disque
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-2 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

// [MIGPB11] [EMD] : Debut Migration : mise en commentaire de la double declaration de sCharSauve[]
//String sSection, sCle, sText, sNull, sCourrierSauve, sTypeSauve, sCharSauve[], sExtension, sFicSupp
String sSection, sCle, sText, sNull, sCourrierSauve, sTypeSauve, sExtension, sFicSupp
// [MIGPB11] [EMD] : Fin Migration
Long lTot, lCpt
Char sCharSauve[]

/*------------------------------------------------------------------*/
/* On ferme le document en cours de traitement.                     */
/*------------------------------------------------------------------*/
sSection = "COURRIER"
sCle		= "NBR_DOC"
sText		= String ( ilNbDocument - 1 )

If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -2 )
End If

/*------------------------------------------------------------------*/
/* On remet le pointeur sur le nom du fichier à NULL.               */
/*------------------------------------------------------------------*/
sSection = "COURRIER"
sCle		= "NOMFICH"

If	invWin.uf_SetProfileString ( isFicCourrierIni, sSection, sCle, sNull ) < 1	Then
	Return ( -2 )
End If

/*------------------------------------------------------------------*/
/* On positionne les valeurs d'instances.                           */
/*------------------------------------------------------------------*/
ilNbDocument --

/*------------------------------------------------------------------*/
/* S'il s'agit du dernier document du courrier, on enléve les       */
/* paramètres particuliers que l'on peut positionner dans le        */
/* fichier INI.                                                     */
/*------------------------------------------------------------------*/
If	ilNbDocument = 0	Then
	sCourrierSauve	= ProfileString ( isFicCourrierIni, "COURRIER", "FIC_SAUVE", "" )
	If	sCourrierSauve <> ""	Then
/*------------------------------------------------------------------*/
/* Il peut exister plusieurs fichiers (en fonction du paramètre     */
/* TYPE_SAUVE).                                                     */
/*------------------------------------------------------------------*/
		sTypeSauve = ProfileString ( isFicCourrierIni, "COURRIER", "TYPE_SAUVE", "" )
		sCharSauve[] = sTypeSauve
		lTot = UpperBound ( sCharSauve )
		For	lCpt = 1 To lTot
				Choose Case sCharSauve[ lCpt ]
					Case "0"
						sExtension = ".DOC"
					Case "1"
						sExtension = ".DOT"						
					Case "2", "3", "4"
						sExtension = ".TXT"
					Case "5"
						sExtension = ".RTF"
				End Choose
				sFicSupp = sCourrierSauve + sExtension
				FileDelete ( sFicSupp )
			Next
	End If
	sSection = "COURRIER"
	sCle		= "FIC_SAUVE"
	
	If	invWin.uf_SetProfileString ( isFicCourrierIni, sSection, sCle, sNull ) < 1	Then
		Return ( -2 )
	End If
	
	sCle		= "TYPE_SAUVE"
	If	invWin.uf_SetProfileString ( isFicCourrierIni, sSection, sCle, sNull ) < 1	Then
		Return ( -2 )
	End If
	
	sCle		= "EDITION"
	If	invWin.uf_SetProfileString ( isFicCourrierIni, sSection, sCle, sNull ) < 1	Then
		Return ( -2 )
	End If

	sCle		= "DTE_EDIT_COURRIER"
	If	invWin.uf_SetProfileString ( isFicCourrierIni, sSection, sCle, sNull ) < 1	Then
		Return ( -2 )
	End If
End If

Return ( 1 )

end function

public function integer uf_inscrireparammisesouspli (string asmsp_chrono, string asmsp_compteur);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_InscrireParamMiseSousPli		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 04/09/2006 10:35:14
//* Libellé			: 
//* Commentaires	: On va inscrire certains paramètres pour le courrier
//*					  Ces paramètres sont en rapport avec la mise sous pli (Nouvelle méthode)
//*
//* Arguments		: (Val)		String	asMsp_Chrono		N° Chrono de mise sous pli (Applicatif,Programme,ID_DOC_EDT)
//*					  (Val)		String	asMsp_Compteur		Début du compteur de page. (Code de contrôle)
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//*
//*----------------------------------------------------------------

String sSection, sCle, sText
/*------------------------------------------------------------------*/
/* On positionne un paramètre pour le N° Chrono. Ce N° est composé  */
/* d'un code Applicatif, d'un code programme et d'un compteur de    */
/* document. (Zone ID_DOC_EDT de ARCHIVE en général).               */
/*------------------------------------------------------------------*/
sSection = "COURRIER"
sCle		= "MSP_CHRONO"

If	SetProfileString ( isFicCourrierIni, sSection, sCle, asMsp_Chrono ) < 1	Then
	Return ( -2 )
End If
/*------------------------------------------------------------------*/
/* Si le compteur de page pour le contrôle n'est pas armé, on       */
/* l'arme par défaut à 1.                                           */
/*------------------------------------------------------------------*/
If	IsNull ( asMsp_Compteur ) Or Len ( Trim ( asMsp_Compteur ) ) = 0	Then asMsp_Compteur = "0"

sCle		= "MSP_COMPTEUR"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, asMsp_Compteur ) < 1	Then
	Return ( -2 )
End If

Return ( 1 )
end function

public function integer uf_recupererparammisesouspli ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_RecupererParamMiseSousPli		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 04/09/2006 10:35:14
//* Libellé			: 
//* Commentaires	: On va récupérer le nombre de pages qui viennent d'être mises sous pli
//*					  Ces paramètres sont en rapport avec la mise sous pli (Nouvelle méthode)
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer						 ? = Nombre de pages [0 à N]
//*														-1 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//*
//*----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* La macro de MiseSousPli(NouvelleMethode) positionne une valeur   */
/* dans le fichier isFicCourrierIni, Section=PAGE,                  */
/* Clé=NbPageMiseSousPli. Cette valeur correspond au nombre de      */
/* pages du courrier qui vient d'être traité.                       */
/*------------------------------------------------------------------*/
String sSection, sCle, sNbPage, sNull
Integer iNbPage

SetNull ( sNull )
sSection = "PAGE"
sCle		= "NbPageMiseSousPli"
sNbPage	= ProfileString ( isFicCourrierIni, sSection, sCle, "NULL" )

If	sNbPage = "NULL"	Then
	iNbPage = 0
Else
	iNbPage = Integer ( sNbPage )
End If
/*------------------------------------------------------------------*/
/* On supprime la clé du fichier INI pour ne pas perturber la       */
/* suite des traitements.                                           */
/*------------------------------------------------------------------*/
If	invWin.uf_SetProfileString ( isFicCourrierIni, sSection, sCle, sNull ) < 1	Then
	Return -1
End If

Return ( iNbPage )
end function

public function integer uf_inscrireparamcourrier2 (string ascourriersauve, string astypesauve, string asedition, string asmisesouspli, string asid_canal);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_InscrireParamCourrier2			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:35:14
//* Libellé			: Reprise de uf_InscrireParamCourrier, pour [DNTMAIL1-2]
//* Commentaires	: On va inscrire certains paramètres pour le courrier
//*
//* Arguments		: (Val)		String	asCourrierSauve	Nom du fichier à sauvegarder
//*					  (Val)		String	asTypeSauve			Type de sauvegarde (DOC-HTM)
//*					  (Val)		String	asEdition			Doit-on editer le courrier ?
//*					  (Val)		String	asMiseSousPli		Doit-on positionner les marques de Mise Sous Pli ?
//*					  (Val)		String	asId_Canal			Indique le Canal ( CO=Courrier, MA=Mail )
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1		 JFF	  16/01/04 DCMP 030483 : Gestion des différent modèle
//* #2		 PHG	  31/10/06 [DNTMAIL1-2] Surcharge de la fonction en 
//*								  uf_InscrireParamCourrier2
//*-----------------------------------------------------------------

String sSection, sCle, sText
String sRepPara	// #2 [DNTMAIL1-2]
/*------------------------------------------------------------------*/
/* On positionne un paramètre pour expliquer si l'on veut           */
/* sauvegarder le courrier généré dans un répertoire.               */
/*------------------------------------------------------------------*/
sSection = "COURRIER"
sCle		= "FIC_SAUVE"

If	SetProfileString ( isFicCourrierIni, sSection, sCle, asCourrierSauve ) < 1	Then
	Return ( -2 )
End If
/*------------------------------------------------------------------*/
/* On positionne le paramètre qui indique le(s) type(s) de          */
/* sauvegarde(s). (Ex: DOC->Sauvegarde d'un fichier                 */
/* asCourrierSauve.DOC) (Ex:DOC-HTM->Sauvegarde d'un fichier        */
/* asCourrierSauve.DOC et d'un fichier asCourrierSauve.HTM)         */
/*------------------------------------------------------------------*/
/* Le paramètre est en correspondance avec les valeurs de           */
/* sauvegarde pour les documents WORD. (0=DOC, 1=TXT)               */
/*------------------------------------------------------------------*/
sCle		= "TYPE_SAUVE"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, asTypeSauve ) < 1	Then
	Return ( -2 )
End If

/*------------------------------------------------------------------*/
/* On positionne le paramètre expliquant si l'on veut éditer le     */
/* courrier.                                                        */
/*------------------------------------------------------------------*/
sCle = "EDITION"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, asEdition ) < 1	Then
	Return ( -2 )
End If

/*------------------------------------------------------------------*/
/* On positionne le paramètre expliquant si l'on veut mettre les    */
/* marques de mise sous pli.                                        */
/*------------------------------------------------------------------*/
sCle = "MISE SOUS PLI"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, asMiseSousPli ) < 1	Then
	Return ( -2 )
End If

/*------------------------------------------------------------------*/
/* On positionne le paramètre expliquant quelle est la clé à        */
/* utiliser pour la macro. Par défaut, cette clé est initialisée    */
/* avec CLE_EDITION=EDITION. On peut utiliser la fonction           */
/* uf_cle_edition_fichierini pour changer cette valeur.             */
/*------------------------------------------------------------------*/
sCle = "CLE_EDITION"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, "EDITION" ) < 1	Then
	Return ( -2 )
End If

/*------------------------------------------------------------------*/
/* #1 : On positionne le nom du modele à utiliser pour ce courrier. */
/*------------------------------------------------------------------*/
sCle = "MODELE"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, isModele ) < 1	Then
	Return ( -2 )
End If

/*------------------------------------------------------------------*/
/*  #2 [DNTMAIL1-2] PHG 31/10/2006                                  */
/*  Choix du répertoire ou l'on va lire le courrier suivant le      */
/* canal                                                            */
/*------------------------------------------------------------------*/
choose case asId_Canal
	case k_canal_mail
		sRepPara = k_rep_courmail
	case k_canal_courrier
		sRepPara = k_rep_courrier
end choose
sCle = "REP_PARA"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, sRepPara ) < 1	Then
	Return ( -2 )
End If
//

Return ( 1 )

end function

public function integer uf_inscrirebac (long aliddocument, string asbac, n_cst_printer_descriptor anv_printer);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_InscrireBac		(PUBLIC)
//* Auteur			: Erick John Stark/PHG
//* Date				: 24/03/2000 10:35:14
//* Libellé			: 
//* Commentaires	: On va inscrire le bac dans le fichier INI
//*
//* Arguments		: (Val)		Long		alIdDocument		ID du document à traiter
//*					  (Val)		String	asBac					Bac à utiliser
//*					  (Val)		n_cst_printer_descriptor	Descripteur de l'imprimante à utiliser
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = L'Id du document n'existe pas
//*														-2 = La mise à jour du fichier INI vient d'échouer
//*														-3 = Le descripteur d'imprimante n'a pas été instancié.
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  		Modification
//* #1		 PHG		13/05/2008	Surchage de la fonction pour utiliser 
//* 										un descripteur d'imprimante au lieu d'un type d'imprimante passé en parametre.
//*										Cette version permet d'utiliser le Descripteur d'imprimante de son choix
//*          JFF     11/10/2023  [RS5643_BAC0]
//*-----------------------------------------------------------------

String sSection, sCle, sText
Boolean bSIMPA2  //  [RS5643_BAC0]
Int iRS5643_BAC0 // [RS5643_BAC0]

bSIMPA2 = Left ( Upper(SQLCA.Database), 5) = "SIMPA"  // [RS5643_BAC0]
iRS5643_BAC0 = 0

/*------------------------------------------------------------------*/
/* On vérifie d'abord si l'ID est correct.                          */
/*------------------------------------------------------------------*/
If	Not uf_VerifierIdDocument ( alIdDocument )	Then
	Return ( -1 )
End If

/*------------------------------------------------------------------*/
/* On va maintenant inscrire le bac à utiliser dans le fichier INI. */
/*------------------------------------------------------------------*/
sSection = isIdDocument[ alIdDocument ]
sCle		= "BAC"
//#1 [SUPPORT_MFP]
/*------------------------------------------------------------------*/
/* On utilise le descritpeur d'imprimante instancié dans le         */
/* constructeur pour déterminer le code Bac a mettre dans le Word   */
/*------------------------------------------------------------------*/
if Not isvalid(anv_Printer) Then Return -3
sText = string(anv_Printer.uf_GetBac(asBac) )

// [RS5643_BAC0]
If bSIMPA2 Then
	SELECT valeur
	INTO :iRS5643_BAC0
	FROM sysadm.cle 
	Where id_cle = "RS5643_BAC0"
	Using SQLCA;
	
	If IsNull ( iRS5643_BAC0 ) Then iRS5643_BAC0 = 0
	
	If iRS5643_BAC0 > 0 Then sText = "0"  // On force le bac à 0 dans tous les cas
	
End If


If	SetProfileString ( isFicCourrierIni, sSection, sCle, sText ) < 1	Then
	Return ( -2 )
End If

Return ( 1 )

end function

public function integer uf_inscrirebac (long aliddocument, string asbac);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_InscrireBac		(PUBLIC)
//* Auteur			: Erick John Stark/PHG
//* Date				: 24/03/2000 10:35:14
//* Libellé			: 
//* Commentaires	: On va inscrire le bac dans le fichier INI
//*
//* Arguments		: (Val)		Long		alIdDocument		ID du document à traiter
//*					  (Val)		String	asBac					Bac à utiliser
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = L'Id du document n'existe pas
//*														-2 = La mise à jour du fichier INI vient d'échouer
//*														-3 = Le descripteur d'imprimante n'a pas été instancié.
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  		Modification
//* #1		 PHG		13/05/2008	Surchage de la fonction pour utiliser 
//* 										un descripteur d'imprimante au lieu d'un type d'imprimante passé en parametre.
//*										Prends le descripteur par defaut instancié dans n_cst_edition_courrier
//*-----------------------------------------------------------------

return uf_InscrireBac( aliddocument, asbac, invPrinter)
end function

public function integer uf_inscrireparamcourrier (string ascourriersauve, string astypesauve, string asedition, string asmisesouspli, string asid_canal, string asid_lang);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_InscrireParamCourrier2			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/2000 10:35:14
//* Libellé			: Reprise de uf_InscrireParamCourrier, pour [DNTMAIL1-2]
//* Commentaires	: On va inscrire certains paramètres pour le courrier
//*
//* Arguments		: (Val)		String	asCourrierSauve	Nom du fichier à sauvegarder
//*					  (Val)		String	asTypeSauve			Type de sauvegarde (DOC-HTM)
//*					  (Val)		String	asEdition			Doit-on editer le courrier ?
//*					  (Val)		String	asMiseSousPli		Doit-on positionner les marques de Mise Sous Pli ?
//*					  (Val)		String	asId_Canal			Indique le Canal ( CO=Courrier, MA=Mail )
//*					  (Val)		String	asId_Lang			Code Langue
//*
//* Retourne		: Integer						 1 = Tout est OK
//*														-1 = La mise à jour du fichier INI vient d'échouer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1		 JFF	  16/01/04 DCMP 030483 : Gestion des différent modèle
//* #2		 PHG	  31/10/06 [DNTMAIL1-2] Surcharge de la fonction en 
//*								  uf_InscrireParamCourrier2
//* #3		 PHG	  02/07/08 [SUISSE].ID_LANG Surcharge, au sens object,
//*								 pour le support du code langue.
//*-----------------------------------------------------------------

String sSection, sCle, sText
String sRepPara	// #2 [DNTMAIL1-2]

/*------------------------------------------------------------------*/
/* On positionne un paramètre pour expliquer si l'on veut           */
/* sauvegarder le courrier généré dans un répertoire.               */
/*------------------------------------------------------------------*/
sSection = "COURRIER"
sCle		= "FIC_SAUVE"

If	SetProfileString ( isFicCourrierIni, sSection, sCle, asCourrierSauve ) < 1	Then
	Return ( -2 )
End If

/*------------------------------------------------------------------*/
/* On positionne le paramètre qui indique le(s) type(s) de          */
/* sauvegarde(s). (Ex: DOC->Sauvegarde d'un fichier                 */
/* asCourrierSauve.DOC) (Ex:DOC-HTM->Sauvegarde d'un fichier        */
/* asCourrierSauve.DOC et d'un fichier asCourrierSauve.HTM)         */
/*------------------------------------------------------------------*/
/* Le paramètre est en correspondance avec les valeurs de           */
/* sauvegarde pour les documents WORD. (0=DOC, 1=TXT)               */
/*------------------------------------------------------------------*/
sCle		= "TYPE_SAUVE"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, asTypeSauve ) < 1	Then
	Return ( -2 )
End If

/*------------------------------------------------------------------*/
/* On positionne le paramètre expliquant si l'on veut éditer le     */
/* courrier.                                                        */
/*------------------------------------------------------------------*/
sCle = "EDITION"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, asEdition ) < 1	Then
	Return ( -2 )
End If

/*------------------------------------------------------------------*/
/* On positionne le paramètre expliquant si l'on veut mettre les    */
/* marques de mise sous pli.                                        */
/*------------------------------------------------------------------*/
sCle = "MISE SOUS PLI"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, asMiseSousPli ) < 1	Then
	Return ( -2 )
End If

/*------------------------------------------------------------------*/
/* On positionne le paramètre expliquant quelle est la clé à        */
/* utiliser pour la macro. Par défaut, cette clé est initialisée    */
/* avec CLE_EDITION=EDITION. On peut utiliser la fonction           */
/* uf_cle_edition_fichierini pour changer cette valeur.             */
/*------------------------------------------------------------------*/
sCle = "CLE_EDITION"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, "EDITION" ) < 1	Then
	Return ( -2 )
End If

/*------------------------------------------------------------------*/
/* #1 : On positionne le nom du modele à utiliser pour ce courrier. */
/*------------------------------------------------------------------*/
sCle = "MODELE"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, isModele ) < 1	Then
	Return ( -2 )
End If

/*------------------------------------------------------------------*/
/*  #2 [DNTMAIL1-2] PHG 31/10/2006                                  */
/*  Choix du répertoire ou l'on va lire le courrier suivant le      */
/* canal                                                            */
/*------------------------------------------------------------------*/
/*  #3 [SUISSE].ID_LANG On ajoute un cle INI pour spécifier l'Id_lang */
/*  afin que la macro word puisse choisir le répertoire correspondant à la langue. */

choose case asId_Canal
	case k_canal_mail
		sRepPara = k_rep_courmail
	case k_canal_courrier
		sRepPara = k_rep_courrier
end choose
sCle = "REP_PARA"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, sRepPara ) < 1	Then
	Return ( -2 )
End If
//

/*  #3 [SUISSE].ID_LANG On ajoute un cle INI pour spécifier l'Id_lang */
/*  afin que la macro word puisse choisir le répertoire correspondant à la langue. */
sCle = "ID_LANG"
If	SetProfileString ( isFicCourrierIni, sSection, sCle, asid_lang ) < 1	Then
	Return ( -2 )
End If
//


Return ( 1 )

end function

public function integer uf_setidsin (string asidsin);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_setIdSin	(PUBLIC)
//* Auteur			: FPI
//* Date				: 08/03/2010
//* Libellé			: [EDT_NBPAGES]
//* Commentaires	: On initialise la var d'instance ID_SIN
//*
//* Arguments		: (Val)		String		asidsin
//*
//* Retourne		: Integer				 1 = Tout est OK
//*												-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//           JFF   11/06/2019 [PM425-1]
//*-----------------------------------------------------------------
Integer iRet

If Not FileExists(isFiccourrierini) Then 
	iRet=FileOpen(isFiccourrierini, LineMode! , Write!)
	If iRet > 0 Then FileClose(iRet)
End If

// [PM425-1]
idcIdSin = Long ( asIdsin )

iRet= SetProfileString(isFiccourrierini,"IMPRESSION","ID_SIN",asIdsin)

Return iRet

end function

public subroutine uf_trace (s_glb astglb, string asdescription);
	//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_trace
//* Auteur			:	LBP
//* Date				:	21/05/10
//* Libellé			:	
//* Commentaires	:	Ecrit la trace d'une impression globale.
//*
//* Arguments		:	s_Glb		astGlb				( Val ) 	Desc globale de l'appli
//*						String		asDescription	( Val )	Description de l'erreur rencontrée
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------
//* N° Modif          Reçue Le          Effectuée Le          PAR
//*
//* 1                        					  21/05/10				LBP
//*
//* Ajout de la gestion de trace durant les editions.
//*-----------------------------------------------------------------


String	sTrace, sTab, sFicTrace
string sTemp

// AJOUT LBP pour trace des erreurs Word
sTemp = ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_P", "" )
sFicTrace = sTemp + String (Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )

sTab		= "~t"

sTrace	= String( DateTime(Today(), Now() ), "DD/MM/YYYY hh:mm:ss" )	+	sTab
sTrace 	= + sTrace + astGlb.sCodAppli												+	sTab
sTrace 	= + sTrace + astGlb.sCodOper												+	sTab
sTrace 	= + sTrace + astGlb.sCodServ												+	sTab
sTrace 	= + sTrace + asDescription													+	sTab
	
f_EcrireFichierText ( sFicTrace, sTrace )




end subroutine

public function integer uf_generer_courrier (ref datawindow adwgencourrier, boolean abvisualisercourrier, boolean abcountpages);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Generation_Courrier::uf_Generer_Courrier		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 17:37:48
//* Libellé			: 
//* Commentaires	: On va générer tous les courriers contenu dans le N_DS.
//*
//* Arguments		: (Réf)		DataWindow	adwGenCourrier			DataWindow contenant les informations
//*					  (Val)		Boolean			abVisualiserCourrier		Faut-il visualiser les courriers à la fin de la génération ?
//*					  (Val)		Boolean			abcountpages				Faut-il compter les pages à la fin de la génération ?
//*
//* Retourne		: Integer					 1 = Tout est OK
//*												-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ     PAR      Date	  		Modification
//* #1		DGA		11/05/2001	Ajout du paramètre abVisualiserCourrier
//* #2		JFF		29/03/2004  DCMP 040020 SVE Gestion des droits de modifications des courriers.
//* #3 		DGA      19/09/2006  Gestion d'un répertoire temporaire DCMP-060643
//* #4		PHG		02/11/2006  [DNTMAIL1-2] Selection du répertoire de paragraphe en fonction du canal
//* #5		PHG		02/06/2008	[SUISSE].ID_LANG	Gestion, en edition uniquement, de la selection de la langue.
//* #6         LBP        21/05/2010 [COMPTAGE_PAGES] Ajout d'un paramètre pour spécifier si la fonction lance le comptage des page
//          JFF      26/04/2023  [RS5045_REF_MATP]
//*-----------------------------------------------------------------

Long lIdSin, lIdInter, lIdSeq, lCpt, lTotLigne, lTotInter, lTotDoc, lCptDoc, lLig, lCptTempo
Long lIdDoc[], lIdNull[], lInter[]
String sFicSauve, sIdCour, sTxtCompo, sData, sRepCourrier, sFicIniApp, sFicEntete
String sFicEnteteDefaut, sCodBac, sFiltre, sTri, sTitre, sFicTitre, sWord, sAltGen, sRech
String sAltGestionPart
String sDocOuvert[]
String sId_Canal //#4 [DNTMAIL1-2] PHG	02/11/2006
String sId_Lang //#5 [SUISSE].ID_LANG PHG 02/07/2008
n_cst_dwsrv_itemmanager lnvItm //#5 [SUISSE].ID_LANG PHG 02/07/2008
string sStatus
Integer iRet
Blob blData
string sDoc
Boolean bSIMPA2  //  [RS5045_REF_MATP]
Int iRS5045_REF_MATP // [RS5045_REF_MATP]
Int iTotInterModele, iCptInter  // [RS5045_REF_MATP]

bSIMPA2 = Left ( Upper(SQLCA.Database), 5) = "SIMPA"  //  [RS5045_REF_MATP]
iRS5045_REF_MATP = 0

// [RS5045_REF_MATP]
If bSIMPA2 Then
	// "RS5045_REF_MATP"
	SELECT valeur
	INTO :iRS5045_REF_MATP
	FROM sysadm.cle 
	Where id_cle = "RS5045_REF_MATP"
	Using SQLCA;
	
	If IsNull ( iRS5045_REF_MATP ) Then iRS5045_REF_MATP = 0
	
End If

//N_Cst_LancerEtAttendre	nvWaitAndSee // Objet auto instantiable
N_Cst_LancerEtAttendreCorrige	nvWaitAndSee // Objet auto instantiable
N_Cst_TuerProgramme nKillProcess

N_Cst_Word	nvWord

String 	K_TYPESAUVE = "0"
Date		K_DATECREATION		= Date ( "01/01/2000" )
Time		K_TIMECREATION		= Time ( "23:59:00" )
boolean bRet
long	ll_ret

lTotLigne	= adwGenCourrier.RowCount ()
iRet			= 1


/*------------------------------------------------------------------*/
/* Il n'y a aucun courrier à générer, on s'arrête.                  */
/*------------------------------------------------------------------*/
If	lTotLigne <= 0	Then Return ( -1 )
/*------------------------------------------------------------------*/
/* On va filtrer la DW pour savoir combient d'interlocuteur         */
/* différent doivent recevoir un courrier.                          */
/*------------------------------------------------------------------*/
sTri		= "ID_SIN A, ID_INTER A, ID_SEQ A"
sFiltre	= "GetRow () = 1 Or ( GetRow () > 1 And ( ID_INTER <> ID_INTER[-1] ) )"
ll_ret = adwGenCourrier.SetFilter ( sFiltre )
ll_ret = adwGenCourrier.Filter ()
ll_ret = adwGenCourrier.Sort ()

lTotInter = adwGenCourrier.RowCount ()
For	lCpt = 1 To lTotInter
		lInter [ lCpt ] = adwGenCourrier.GetItemNumber ( lCpt, "ID_INTER" )
Next
/*------------------------------------------------------------------*/
/* On enléve le filtre et on tri la DW par ID_SIN, ID_INTER et      */
/* ID_SEQ.                                                          */
/*------------------------------------------------------------------*/
sFiltre = ""
ll_ret = adwGenCourrier.SetFilter ( sFiltre )
ll_ret = adwGenCourrier.Filter ()
ll_ret = adwGenCourrier.Sort ()

/*------------------------------------------------------------------*/
/* On positionne en variable le nom du répertoire qui contient les  */
/* fichiers WORD et les modéles.                                    */
/*------------------------------------------------------------------*/
sFicIniApp			= stGLB.sFichierIni
sRepCourrier		= ProfileString ( sFicIniApp, "EDITION", "REP_COURRIER", "" )
sFicEnteteDefaut	= ProfileString ( sFicIniApp, "EDITION", "ENTETE", "" )
isModeleDefaut    = isModele // [RS5045_REF_MATP] 

For	lCpt = 1 To lTotInter
/*------------------------------------------------------------------*/
/* On positionne un filtre sur la DW. On s'occupe des documents     */
/* pour l'interlocuteur en cours de traitement.                     */
/*------------------------------------------------------------------*/
		sFiltre = "ID_INTER = " + String ( lInter [ lCpt ] )
		ll_ret = adwGenCourrier.SetFilter ( sFiltre )
		ll_ret = adwGenCourrier.Filter ()

		ll_ret = adwGenCourrier.Sort ()
		lTotDoc = adwGenCourrier.RowCount ()
/*------------------------------------------------------------------*/
/* La premièere ligne du N_Ds que l'on vient de filtre contient le  */
/* titre du courrier. (En correspondance avec ID_SEQ = 1).          */
/*------------------------------------------------------------------*/
		lIdSin	= adwGenCourrier.GetItemNumber ( 1, "ID_SIN" )
		lIdInter	= adwGenCourrier.GetItemNumber ( 1, "ID_INTER" )
		sTitre	= adwGenCourrier.GetItemString ( 1, "TITRE" )
		sAltGen	= adwGenCourrier.GetItemString ( 1, "ALT_GEN" )
		
/*------------------------------------------------------------------*/
/* #4 [DNTMAIL1-2] PHG 02/11/2006                                   */
/* On spécifie le canal, afin que uf_inscrireParamcourrier2 puisse  */
/* choisir                                                          */
/* le répertoire de paragraphe à utiliser.                          */
/*------------------------------------------------------------------*/
		sId_Canal = adwGenCourrier.object.id_canal[1]
		
		//#5 [SUISSE].ID_LANG Lecture de l'Id lang, utilisation de l'item manager
		lnvItm = create n_cst_dwsrv_itemmanager
		lnvItm.of_SetRequestor(adwGenCourrier)
		sId_Lang = string(lnvItm.uf_getitemunknow( 1, "ID_LANG", Primary!, FALSE, "FRA"))
		if isvalid(lnvItm) then destroy lnvItm
		//

/*------------------------------------------------------------------*/
/* Le titre du document final n'est pas armé, on arrête tout.       */
/*------------------------------------------------------------------*/
		If IsNull ( sTitre ) Or Len ( Trim ( sTitre ) ) = 0	Then Return ( -1 )
/*------------------------------------------------------------------*/		
/* Doit-on générer un nouveau courrier, ou simplement ouvrir un     */
/* fichier sur disque.                                              */
/*------------------------------------------------------------------*/
		If	sAltGen = "N"	Then
/*------------------------------------------------------------------*/  
/* #3. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//			sFicTitre = stGLB.sWinDir + "\TEMP\" + sTitre
			sFicTitre = stGLB.sRepTempo + sTitre

//Migration PB8-WYNIWYG-03/2006 CP
//			If	Not FileExists ( sFicTitre ) Then Return ( -1 )			
			If	Not f_FileExists ( sFicTitre ) Then Return ( -1 )			
//Fin Migration PB8-WYNIWYG-03/2006 CP
			
			sDocOuvert[ lCpt ] = '"' + sFicTitre + '"'
		Else			
/*------------------------------------------------------------------*/
/* On s'occupe des paramètres particuliers du courrier. Faut-il     */
/* éditer le courrier ?. Faut-il sauvegarder le courrier et sous    */
/* quel nom ?. Faut-il mettre les marques de mise sous pli ?.       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/  
/* #3. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//			sFicSauve 		= stGLB.sWinDir + "\TEMP\" + Left (String ( lIdSin ), 6 ) + String ( lIdInter, "00" )
			// Modification pour RIS
			sFicSauve 		= stGLB.sRepTempo + Left (String ( lIdSin ), 10 ) + String ( lIdInter, "00" ) // [PI062]

			// [RS5045_REF_MATP]
			If bSIMPA2 And iRS5045_REF_MATP >= 3 Then
				This.uf_ChangerModele ( isModeleDefaut ) 
				iTotInterModele = UpperBound ( iiT_InterModele )
				For iCptInter = 1 To iTotInterModele 
					If iiT_InterModele [ iCptInter ] = lIdInter Then
						This.uf_ChangerModele ( isT_ModeleInter [ iCptInter ] )
					End IF 
				Next 
			End IF 

/*------------------------------------------------------------------*/
/* #4 [DNTMAIL1-2] PHG 02/11/2006                                   */
/* On spécifie le canal, afin que uf_inscrireParamcourrier puisse  */
/* choisir                                                          */
/* le répertoire de paragraphe à utiliser.                          */
/*------------------------------------------------------------------*/
//			This.uf_InscrireParamCourrier ( sFicSauve, K_TYPESAUVE, "N", "N" )
// #5 [SUISSE].ID_LANG On utilise la dernière version de uf_InscrireParamCourrier, qui gère l'id_lang
//			This.uf_InscrireParamCourrier2 ( sFicSauve, K_TYPESAUVE, "N", "N", sId_Canal )
// est remplacé par :
			This.uf_InscrireParamCourrier ( sFicSauve, K_TYPESAUVE, "N", "N", sId_Canal, sId_Lang )

/*------------------------------------------------------------------*/
/* On réinitialise certaines variables.                             */
/*------------------------------------------------------------------*/
			lIdDoc = lIdNull
	
			For	lCptDoc = 1 To lTotDoc
/*------------------------------------------------------------------*/
/* On récupére les informations servant à générer les documents.    */
/*------------------------------------------------------------------*/
					lIdSeq				= adwGenCourrier.GetItemNumber ( lCptDoc, "ID_SEQ" )
					sIdCour				= adwGenCourrier.GetItemString ( lCptDoc, "ID_COUR" )
					sCodBac				= adwGenCourrier.GetItemString ( lCptDoc, "COD_BAC" )
					sFicEntete			= adwGenCourrier.GetItemString ( lCptDoc, "FIC_ENTETE" )
					sTxtCompo			= adwGenCourrier.GetItemString ( lCptDoc, "TXT_COMPO" )
					sAltGestionPart	= adwGenCourrier.GetItemString ( lCptDoc, "ALT_GESTION_PART" )
					sData					= adwGenCourrier.GetItemString ( lCptDoc, "TXT_DATA" )
// [MIGPB11] [EMD] : Debut Migration : Forcer la création de Blob en ANSI
					//blData				= Blob ( sData )
					blData				= Blob ( sData, EncodingANSI! )
// [MIGPB11] [EMD] : Fin Migration					

					If IsNull ( sAltGestionPart )	Then sAltGestionPart = "N"
/*------------------------------------------------------------------*/
/* La composition est vide, on arrête le processus.                 */
/*------------------------------------------------------------------*/
					If Len ( Trim ( sTxtCompo ) ) = 0 Then Return ( -1 )
/*------------------------------------------------------------------*/
/* Le blob est vide, on arrête le processus.                        */
/*------------------------------------------------------------------*/
					If	Len ( blData ) = 0 And sAltGestionPart = "N" Then Return ( -1 )
/*------------------------------------------------------------------*/
/* Normalement, le client doit armer le fichier d'entête que l'on   */
/* doit utiliser. Si ce n'est pas le cas, on utilise le fichier     */
/* d'entête par défaut dur fichier INI.                             */
/*------------------------------------------------------------------*/
					If IsNull ( sFicEntete ) Or Len ( Trim ( sFicEntete ) ) = 0	Then
						sFicEntete = sFicEnteteDefaut
					End If
/*------------------------------------------------------------------*/
/* On gére un bac par défaut si la valeur n'est pas renseignée.     */
/*------------------------------------------------------------------*/
					If	IsNull ( sCodBac ) Or Len ( Trim ( sCodBac ) ) = 0	Then
						sCodBac = "BAS"
					End If
/*------------------------------------------------------------------*/
/* On ouvre le document.                                            */
/*------------------------------------------------------------------*/
					lIdDoc[ lCptDoc ] = This.uf_OuvrirDocument ( sIdCour, sRepCourrier + sFicEntete )
/*------------------------------------------------------------------*/
/* On prépare la composition du document.                           */
/*------------------------------------------------------------------*/
					If	sAltGestionPart = "N"	Then
						This.uf_InscrireComposition ( lIdDoc[ lCptDoc ], sTxtCompo )
/*------------------------------------------------------------------*/
/* On prépare les variables pour le document.                       */
/*------------------------------------------------------------------*/
						This.uf_GenererData ( lIdDoc[ lCptDoc ], blData )
					Else
///*------------------------------------------------------------------*/
/* Il s'agit d'un document particulier. La composition correspond   */
/* au nom du courrier WORD à ouvrir. Il n'y a pas de DATA donc pas  */
/* de fusion à réaliser.                                            */
/*------------------------------------------------------------------*/
						This.uf_Inscrire_GestionParticuliere ( lIdDoc[ lCptDoc ], sTxtCompo )
					End If
/*------------------------------------------------------------------*/
/* Pour le moment, on gére les imprimantes COMPAQ et XEROX.         */
/*------------------------------------------------------------------*/
//					This.uf_InscrireBac ( lIdDoc[ lCptDoc ], sCodBac, 1 )
					This.uf_InscrireBac ( lIdDoc[ lCptDoc ], sCodBac ) // [SUPPORT_MFP]
			Next
/*------------------------------------------------------------------*/
/* On peut générer le courrier qui peut contenir plusieurs          */
/* documents.                                                       */
/*------------------------------------------------------------------*/
/* On utilise la macro STANDARD pour le moment.                     */
/*------------------------------------------------------------------*/
			
			iRet = This.uf_Imprimer ( "" )

         Yield()
/*------------------------------------------------------------------*/
/* On vide le ClipBoard puisque la macro WORD utilise un            */
/* Couper-Coller des documents.                                     */
/*------------------------------------------------------------------*/
			invWin.uf_EmptyClipBoard ()
/*------------------------------------------------------------------*/
/* L'impression se passe mal, on arrête tout.                       */
/*------------------------------------------------------------------*/
			If	iRet < 1 Then Return ( -1 )
/*------------------------------------------------------------------*/
/* On renomme le courrier génére avec le titre que le client        */
/* positionne.                                                      */
/*------------------------------------------------------------------*/
			sFicSauve = sFicSauve + ".DOC"
/*------------------------------------------------------------------*/  
/* #3. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un répertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//			sFicTitre = stGLB.sWinDir + "\TEMP\" + sTitre			
			sFicTitre = stGLB.sRepTempo + sTitre
/*------------------------------------------------------------------*/
/* On détruit le fichier précédent s'il existe. Le script client    */
/* doit logiquement s'en occuper mais je préfére le faire aussi à   */
/* cet endroit. Sinon, le rename ne pourra jamais fonctionner.      */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//			If	FileExists ( sFicTitre )	Then 
			If	f_FileExists ( sFicTitre )	Then 				
//Fin Migration PB8-WYNIWYG-03/2006 CP

				invWin.uf_SetFileAttributes ( sFicTitre, 0 ) // #2 non protection du fichier
				FileDelete ( sFicTitre )
			End If
//Migration PB8-WYNIWYG-03/2006 FM
//			F_Copy ( invWin, sFicSauve, sFicTitre )
			FileCopy(sFicSauve, sFicTitre)
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* On construit une chaîne pour les documents à ouvrir à la fin du  */
/* traitement.                                                      */
/*------------------------------------------------------------------*/
			sDocOuvert[ lCpt ] = '"' + sFicTitre + '"'
/*------------------------------------------------------------------*/
/* On ferme tous les documents ouverts.                             */
/*------------------------------------------------------------------*/
			For	lCptDoc = 1 To lTotDoc
					This.uf_FermerDocument ( lIdDoc[ lCptDoc ] )
			Next
	End If
Next
/*------------------------------------------------------------------*/
/* On enléve le filtre sur la DW.                                   */
/*------------------------------------------------------------------*/
sFiltre = ""
ll_ret = adwGenCourrier.SetFilter ( sFiltre )
ll_ret = adwGenCourrier.Filter ()
ll_ret = adwGenCourrier.Sort ()


If	Not ibWordOuvertAvantTraitement	Then
// [Office2010] [FMU] : Debut : 
//	sWord = ProfileString ( sFicIniApp, "EDITION", "REP_WORD", "" )
	sWord = f_GetWordExe()
// [Office2010] [FMU] : Fin
	If	sWord <> ""	Then 
		For	lCpt = 1 To lTotInter
/*------------------------------------------------------------------*/
/* On recherche la ligne dans la DW pour vérifier s'il faut         */
/* générer le courrier. Si ALT_GEN = 'N', il ne faut pas            */
/* positionner le DateTime sur le fichier.                          */
/*------------------------------------------------------------------*/
/* La DW est triée sur ID_SIN, ID_INTER et ID_SEQ. La première      */
/* ligne trouvée pour la valeur de ID_INTER doit contenir la bonne  */
/* valeur pour ALT_GEN.                                             */
/*------------------------------------------------------------------*/
				sRech			= "ID_INTER = " + String ( lInter [ lCpt ] )
				lLig			= adwGenCourrier.Find ( sRech, 1, lTotLigne )
				sAltGen		= adwGenCourrier.GetItemString ( lLig, "ALT_GEN" )
				sFicTitre	= Mid ( sDocOuvert[ lCpt ], 2, Len ( sDocOuvert[ lCpt ] ) - 2 )

				If	sAltGen = "O"	Then invWin.uf_SetLastWriteDateTime ( sFicTitre, K_DATECREATION, K_TIMECREATION )
				sWord = sWord + " " + sDocOuvert[ lCpt ]

/*------------------------------------------------------------------*/
/* #2 : DCMP 040020 SVE : Utilisation du tableau définissant les    */
/* droits de modification des courriers automatique.                */
/* On utilise le tableau que s'il a été inscrit.						  */
/*------------------------------------------------------------------*/
				This.uf_Appliquer_DroitModifCour ( lInter [ lCpt ],  sFicTitre )

		Next
/*------------------------------------------------------------------*/
/* Le 11/05/2001. #1.                                               */
/* On ouvre WORD uniquement si le client le désire. Cas des         */
/* règlements automatiques pour PLJ.                                */
/*------------------------------------------------------------------*/
		If	abVisualiserCourrier Then	
				
//			// Ajout LBP le 25-05-10 : Verif de la bonne activation des macro
//			// pour se faire on positionne un flag a false dans le .INI, si les macros
//			// du poste client sont actives, cette valeur passera à TRUE
//			SetProfileString( isFicCourrierIni, "EDITION", "MACRO_ACTIVES", "FALSE") 
//			// Fin ajout LBP

			F_SetVersionWord ( nvWord, TRUE )	

			// MODIF LBP le 25-05-10 : Attente de la fin du lancement de Word avant de 
			// continuer sinon; risque que Word ne soit pas entièrment ouvert avant execution 
			// de commande OLE
			//run(sWord)

// [Office2010] [FMU] : Debut : 
			//sWord =  ProfileString ( sFicIniApp, "EDITION", "REP_WORD", "" )
			sWord =  f_GetWordExe()
// [Office2010] [FMU] : Fin
			
			bRet = nvWaitAndSee.uf_LancerEtAttendre (sWord , 5000 )
			
			if not bRet then
				// Trace du problème de lancement de Word
				uf_trace ( stGlb , "n_cst_edition_courrier - uf_generer_courrier() : Echec du 1er lancement de Word. ")
				
				// Erreur d'ouverture de Word : la probabilité la plus grande est qu'une autre instance de Word Soit Plantée et empèche 
				// l'ouverture : On tue tous les Words ouverts
				nKillProcess.uf_tuerprogramme(sWord )
				
				// Retente l'ouverure de Word
				bRet = nvWaitAndSee.uf_LancerEtAttendre (sWord , 5000 )
				
				// Second echec : On abandonne
				if not bRet then
					// Trace de l'impossibilité de lancement de Word
					uf_trace ( stGlb , "n_cst_edition_courrier - uf_generer_courrier() : Echec du 2nd lancement de Word. ")
					return -1
				end if				
			end  if
			
			// Fermeture de tous les docs
			nvWord.uf_CommandeWord ( 10, "", iOleWord )
			
			// Ouverture du ou des doc
			For	lCpt = 1 To lTotInter
				sDoc = sDocOuvert[ lCpt ]
				sFicTitre	= Mid ( sDoc, 2, Len ( sDoc ) - 2 )
				if FileExists( sFicTitre) then
					
					// Ouverture du fichier
					nvWord.uf_CommandeWord ( 3, sDoc, iOleWord )
					
					// Comptage du nombre de pages
					if abcountpages then nvWord.uf_CommandeWord ( 13, "", iOleWord )
					
				else
					return -1
				end if
			next 
			

			
			
			//			// Ajout LBP le 25-05-10 : Verif de la bonne activation des macro
			//			sStatus = ProfileString(isFicCourrierIni, "EDITION", "MACRO_ACTIVES", "") 
			//			if sStatus <> "TRUE" then
			//				uf_trace ( stGlb , "n_cst_edition_courrier - uf_imprimer() : Macro Word Inactives. ")
			//			end if
			
			
			nvWord.uf_CommandeWord ( 6, " ", iOleWord )
			F_SetVersionWord ( nvWord, FALSE )
		End If
	End If
Else
/*------------------------------------------------------------------*/
/* On charge les fichiers dans l'instance WORD en utilisant les     */
/* commandes OLE.                                                   */
/*------------------------------------------------------------------*/
	F_SetVersionWord ( nvWord, TRUE )
	For	lCpt = 1 To lTotInter
			sRech			= "ID_INTER = " + String ( lInter [ lCpt ] )
			lLig			= adwGenCourrier.Find ( sRech, 1, lTotLigne )
			sAltGen		= adwGenCourrier.GetItemString ( lLig, "ALT_GEN" )
			sFicTitre	= Mid ( sDocOuvert[ lCpt ], 2, Len ( sDocOuvert[ lCpt ] ) - 2 )

			If sAltGen = "O"	Then invWin.uf_SetLastWriteDateTime ( sFicTitre, K_DATECREATION, K_TIMECREATION )

/*------------------------------------------------------------------*/
/* #2 : DCMP 040020 SVE : Utilisation du tableau définissant les    */
/* droits de modification des courriers automatique.                */
/* On utilise le tableau que s'il a été inscrit.						  */
/*------------------------------------------------------------------*/
			This.uf_Appliquer_DroitModifCour ( lInter [ lCpt ],  sFicTitre )

/*------------------------------------------------------------------*/
/* Le 11/05/2001. #1.                                               */
/* On ouvre WORD uniquement si le client le désire. Cas des         */
/* règlements automatiques pour PLJ.                                */
/*------------------------------------------------------------------*/
			If	abVisualiserCourrier Then 
				
				
//				// Ajout LBP le 25-05-10 : Verif de la bonne activation des macro
//				// pour se faire on positionne un flag a false dans le .INI, si les macros
//				// du poste client sont actives, cette valeur passera à TRUE
//				SetProfileString( isFicCourrierIni, "EDITION", "MACRO_ACTIVES", "FALSE") 
//				// Fin ajout LBP

				// Ouverture du document
				nvWord.uf_CommandeWord ( 3, sDocOuvert[ lCpt ], iOleWord )
				
//				
//				// Ajout LBP le 25-05-10 : Verif de la bonne activation des macro
//				sStatus = ProfileString(isFicCourrierIni, "EDITION", "MACRO_ACTIVES", "") 
//				if sStatus <> "TRUE" then
//					uf_trace ( stGlb , "n_cst_edition_courrier - uf_imprimer() : Macro Word Inactives. ")
//				end if
//				// Fin ajout LBP
				
				
				
				// AJOUT LBP pour test : Comptage du nombre de pages
				if abcountpages then nvWord.uf_CommandeWord ( 13, "", iOleWord )
				// FIN AJOUT LBP pour test : Comptage du nombre de pages
			
			end if
	Next
/*------------------------------------------------------------------*/
/* On affiche la fenêtre WINWORD avec un ShowWindow. Aucune des     */
/* commandes OLE ne semble fonctionner.                             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le 11/05/2001. #1.                                               */
/* On ouvre WORD uniquement si le client le désire. Cas des         */
/* règlements automatiques pour PLJ.                                */
/*------------------------------------------------------------------*/
	If	abVisualiserCourrier Then 
//		invPFC_ServiceOs.uf_ShowWindow ( iulHandleWord, 1 )
		nvWord.uf_CommandeWord ( 4, "POSITION WORD", iOleWord )
	End If
	
	F_SetVersionWord ( nvWord, FALSE )
End If

/*------------------------------------------------------------------*/
/* On supprime l'instance WORD en cours d'utilisation, ainsi que    */
/* le fichier INI généré pour l'édition.                            */
/*------------------------------------------------------------------*/
uf_TerminerSession ()

Return ( iRet )

end function

public function integer uf_generer_courrier (datawindow adwgencourrier, boolean abvisualisercourrier);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Generation_Courrier::uf_generer_courrier		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 17:37:48
//* Libellé			: 
//* Commentaires	: Lance la génération des courriers SANS compatge des pages
//*
//* Arguments		: (Réf)		DataWindow	adwGenCourrier			DataWindow contenant les informations
//*					  (Val)		Boolean			abVisualiserCourrier		Faut-il visualiser les courriers à la fin de la génération ?
//*
//* Retourne		: Integer					 1 = Tout est OK
//*												-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ     PAR      Date	  			Modification
//* #1       LBP       21/05/2010 	[COMPTAGE_PAGES] Fonction de redirection pour garder la compatibilité
//*-----------------------------------------------------------------
return uf_generer_courrier( adwgencourrier, abvisualisercourrier, false)
end function

public function integer uf_generer_courrier (datawindow adwgencourrier, boolean abvisualisercourrier, long alidprod);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Generation_Courrier::uf_generer_courrier		(PUBLIC)
//* Auteur			: FPI
//* Date				: 28/09/2011
//* Libellé			: 
//* Commentaires	: Lance la génération des courriers - [PM73-2]
//*
//* Arguments		: (Réf)		DataWindow	adwGenCourrier	DataWindow contenant les informations
//*					  (Val)		Boolean			abVisualiserCourrier		Faut-il visualiser les courriers à la fin de la génération ?
//*					  (Val)		Long				alIdProd						Identifiant de produit			
//*
//* Retourne		: Integer					 1 = Tout est OK
//*												-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ     PAR      Date	  			Modification
//				FPI	27/10/2011		[PC363][LOGO_AUCHAN] Adaptation du modèle
//*-----------------------------------------------------------------
String sModele
String sListeProduits
n_cst_string nvString

sModele = isModele

//  [PM73-2] - Suppression du code
/*If Pos( isproduitscodebarre , "/" + String(alIdprod) + "/") > 0 Or isproduitscodebarre = "TOUS" Then
	//sModele = isModeleCodebarre
	sModele=nvString.of_globalreplace(isModele, ".DOT", "_CD.DOT")
End if*/

uf_changermodele( sModele )

return uf_generer_courrier( adwgencourrier, abvisualisercourrier, false)
end function

private function string uf_editiondecentralisee (ref n_cst_word anvword);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::Uf_EditionDecentralisee		(PRIVATE)
//* Auteur			: FABRY JF
//* Date				: 11/06/2019 
//* Libellé			: 
//* Commentaires	: [PM425-1] Edition décentralisée (écriture PDF sur disque)
//*
//* Arguments		: N_Cst_Word	anvWord   (Ref)
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//*          JFF   06/11/2020 [VDOC29832] ajout nombre page total
//           JFF   26/04/2023 [RS5045_REF_MATP]
//*-----------------------------------------------------------------

Long dcIdProd, lRow, dcIdDoc
String sLibCie, sContractant, sNomDest, sAdr1, sAdr2, sAdrCP, sAdrVille, sFondPage, sChemin, sChaine 
String sNomFichierSortie, sCodInter, sStatus , sExtFichierSortie, sApplication, sSql, sNbPageTotal, sText, sExtFichierIndex
Int iDecentralise, iFormatSortie
Boolean bStatut, bRet 
DataStore dsFichierIndex
Int iTot, iCpt, iRet 

Boolean bSIMPA2


// /A supprimer par la suite à la désact
// /[VDOC29832]

sApplication = "SIMPA2"

sLibCie = Space ( 35 )
sContractant = Space ( 35 )
sNomDest = Space ( 71 )
sAdr1 = Space ( 35 )
sAdr2 = Space ( 35 )
sAdrCP = Space ( 5 )
sAdrVille = Space ( 35 )
sFondPage = Space ( 35 )
sChemin = Space ( 255 )
sChaine = Space ( 255 )
sCodInter = Space ( 1 )

dcIdDoc = -1 // [RS5045_REF_MATP]
If ilIdDoc > 0 Then dcIdDoc = ilIdDoc // [RS5045_REF_MATP]

// Je récupère les données nécessaires 
//                            Val       Val         Val       Val         Ref => ...
SQLCA.PS_S_PM425_RECUP_INFO ( idcIdSin, idcIdInter, iiIdArch, ilIdTypDoc, dcIdDoc, sCodInter, dcIdProd, sLibCie, sContractant, sNomDest, sAdr1, sAdr2, sAdrCP, sAdrVille, iDecentralise, sFondPage, iFormatSortie, sChemin, sChaine ) 

// Si l'id_Doc avait été transmis à l'appel, c'est que l'on est dans un cas très particulier (les relances)
// On prends donc celui transmis à l'appel.
If ilIdDoc > 0 Then dcIdDoc = ilIdDoc
If ilIdLot < 0 Then ilIdLot = 0

If iDecentralise <= 0 Then 
	This.uf_setPM425 ( "RAZ", 0,0,"",0,0,0,0, iMleMsg, "", FALSE )
	Return "HORS_PARAM"
End If 

// Gestion du regroupement (pour les relance notamment, permets de regrouper 2 PDF dans la même enveloppe dans un ordre précis)
If isCasTrtPM425 = "REGROUPEMENT" Then
	If isCodeRegroupement = "" Then 
		isCodeRegroupement = String ( idcIdSin ) + String ( idcIdInter ) + String ( dcIdDoc )
	End If 
Else
	// Demandé par Corus, même si rien à regrouper, on met un code de regroupement.
	isCodeRegroupement = String ( idcIdSin ) + String ( idcIdInter ) + String ( dcIdDoc )
	ilIndexPosition = 0
End IF 

ilIndexPosition ++

// Extension
Choose Case iFormatSortie
	Case 17 
		sExtFichierSortie = "PDF"
	Case Else 
		sExtFichierSortie = "DOC"
End CHoose 

sExtFichierIndex = "IDX"

sText = "Dossier : " + String ( idcIdSin ) + ", inter " + String ( idcIdInter ) + " Impression décentralisée chez CORUS (" + sExtFichierSortie + ")"+ "~r~n"
iMleMsg.uf_AjouterText ( sText )


// SIMPA2_745471_7058748_0_A_ACP001_201904191410415
// Je ne mets pas l'extension, la sauvegarde en format 17 par Word la mettra automatiquement.
sNomFichierSortie = sApplication + "_"
sNomFichierSortie += String ( ilIdLot ) + "_"
sNomFichierSortie += String ( idcIdSin ) + "_"
sNomFichierSortie += String ( idcIdInter ) + "_"
sNomFichierSortie += String ( dcIdDoc ) + "_"
sNomFichierSortie += sCodInter + "_"
sNomFichierSortie += isIdCour + "_"
sNomFichierSortie += String ( Today (), "yyyymmdd" ) + "_"
sNomFichierSortie += String ( Now (), "hhmmss")

// J'arme les données nécéssaire à la macro pour écrire le PDF.
SetProfileString ( isFicCourrierIni, "EDT_DECENTRALISE", "FICHIER_SORTIE", sChemin + sNomFichierSortie )
SetProfileString ( isFicCourrierIni, "EDT_DECENTRALISE", "FORMAT_FICHIER_SORTIE", string ( iFormatSortie ) )

anvWord.uf_CommandeWord ( 1, isRepCourrier + isModele, iOleWord )
anvWord.uf_CommandeWord ( 2, "EditionDecentralisee", iOleWord )		

// On attend que l'écriture du fichier soit bien terminé
DO
	sStatus = ProfileString ( isFicCourrierIni, "EDT_DECENTRALISE", "STATUS", "" )
	sNbPageTotal = ProfileString ( isFicCourrierIni, "EDT_DECENTRALISE", "NB_PAGE_TOTAL", "" )
	bStatut = sStatus = "OK" And IsNumber ( sNbPageTotal )
	Yield ()
LOOP UNTIL sStatus = "OK" Or sStatus = "PAS OK"


// Si problème décriture, on ressort on laisse partir l'impression à défaut
If Not bStatut Then
	This.uf_setPM425 ( "RAZ", 0,0,"",0,0,0,0, iMleMsg, "", FALSE )
	sText = "Dossier : " + String ( idcIdSin ) + ", inter " + String ( idcIdInter ) + " Echec écriture fichier " + sExtFichierSortie + "(1)" + "~r~n"
	iMleMsg.uf_AjouterText ( sText )
	
	This.uf_setPM425 ( "RAZ", 0,0,"",0,0,0,0, iMleMsg, "", FALSE )
	
	// On supprime l'éventuel fichier PDF qui a pu tout de même s'écrire (cas déjà vu).
	FileDelete ( sChemin + sNomFichierSortie + "." + sExtFichierSortie )
	
	Return "PROBLEME"
End IF 	

// Si écriture Ok pour la macro, je vérifie encore.
If Not FileExists  ( sChemin + sNomFichierSortie + "." + sExtFichierSortie ) Then
	This.uf_setPM425 ( "RAZ", 0,0,"",0,0,0,0, iMleMsg, "", FALSE )
	sText = "Dossier : " + String ( idcIdSin ) + ", inter " + String ( idcIdInter ) + " Echec écriture fichier " + sExtFichierSortie + "(2)" + "~r~n"
	iMleMsg.uf_AjouterText ( sText )
	
	This.uf_setPM425 ( "RAZ", 0,0,"",0,0,0,0, iMleMsg, "", FALSE )
	
	// On supprime l'éventuel fichier PDF qui a pu tout de même s'écrire (cas déjà vu).
	FileDelete ( sChemin + sNomFichierSortie + "." + sExtFichierSortie )	
	
	Return "PROBLEME"
End IF 	

sText = "Dossier : " + String ( idcIdSin ) + ", inter " + String ( idcIdInter ) + " Succès écriture fichier " + sExtFichierSortie + "~r~n"
iMleMsg.uf_AjouterText ( sText )


// [VDOC29832]
// Si Ok on trace le fait que ce courrier fut, non pas édité, mais ecrité en PDF.
// Car dans la table ARCHIVE, le visu de l'enregistrement laissera croire qu'il s'est normalement édité.
sSql  = "Exec sysadm.PS_I_PM425_INSERT_TRACE_V01 "
sSql += String ( idcIdSin ) + "., "
sSql += String ( idcIdInter ) + "., "
sSql += String ( dcIdDoc ) + "., "
sSql += String ( iiIdArch ) + ", "
sSql += String ( ilIdLot ) + ", "
sSql += "'DATA'" + ", "
sSql += "'" + sExtFichierSortie + "(" + string ( iFormatSortie ) + ")"+ "'" + ", "   // PDF(17)
sSql += "'" + sChemin + "'" + ", "
sSql += "'" + sNomFichierSortie + "." + sExtFichierSortie + "'" + ", "
sSql += "'" + String ( ilIdTypDoc ) + "'" + ", "
sSql += "'" + sFondPage + "'" + ", "
sSql += "'" + sLibCie + "'" + ", "
sSql += "'" + sContractant + "'" + ", "
sSql += "'" + F_REMPLACE ( sNomDest, "'", "''" ) + "'" + ", "
sSql += "'" + F_REMPLACE ( sAdr1, "'", "''" ) + "'" + ", "
sSql += "'" + F_REMPLACE ( sAdr2, "'", "''" ) + "'" + ", "
sSql += "'" + sAdrCP + "'" + ", "
sSql += "'" + F_REMPLACE ( sAdrVille, "'", "''" ) + "'" + ", "
sSql += "'" + stGlb.sCodOper + "', "
sSql += sNbPageTotal 
	
F_Execute ( sSql, SQLCA )
bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0
F_Commit ( SQLCA, bRet ) 

If Not bRet Then 
	sText = "Dossier : " + String ( idcIdSin ) + ", inter " + String ( idcIdInter ) + " Echec écriture trace " + sExtFichierSortie + " en base" + "~r~n"
	iMleMsg.uf_AjouterText ( sText )
	
	This.uf_setPM425 ( "RAZ", 0,0,"",0,0,0,0, iMleMsg, "", FALSE )
	
	// On supprime l'éventuel fichier PDF qui a pu tout de même s'écrire (cas déjà vu).
	FileDelete ( sChemin + sNomFichierSortie + "." + sExtFichierSortie )	
	
	Return "PROBLEME"
End If 

// Construction du fichier index
dsFichierIndex = CREATE DataStore 
dsFichierIndex.dataObject = "d_trt_fichier_index_pm425"

// iTot = Integer ( sNbPageTotal ) 
iTot = 1 // Vu avec Hélène, on ne mets pas autant de ligne que de page. un courrier = une ligne.

For iCpt = 1 To iTot

   lRow = dsFichierIndex.InsertRow ( 0 )

	dsFichierIndex.SetItem ( lRow, "NOM_FICHIER", sNomFichierSortie + "." + sExtFichierSortie )
	dsFichierIndex.SetItem ( lRow, "APPLICATION", sApplication )
	dsFichierIndex.SetItem ( lRow, "TYPE_FACE", "R" )
	dsFichierIndex.SetItem ( lRow, "CODE_REGROUPEMENT", isCodeRegroupement )
	dsFichierIndex.SetItem ( lRow, "INDEX_POSITION", string ( ilIndexPosition ) )	
	dsFichierIndex.SetItem ( lRow, "FOND_DE_PAGE", sFondPage )
	dsFichierIndex.SetItem ( lRow, "ADRESSE1_DEST", sNomDest )
	dsFichierIndex.SetItem ( lRow, "ADRESSE2_DEST", sAdr1 )
	dsFichierIndex.SetItem ( lRow, "ADRESSE3_DEST", sAdr2 )
	dsFichierIndex.SetItem ( lRow, "ADRESSE4_DEST", "" )
	dsFichierIndex.SetItem ( lRow, "ADRESSE5_DEST", "" )
	dsFichierIndex.SetItem ( lRow, "CODE_POSTAL_DEST", sAdrCp )
	dsFichierIndex.SetItem ( lRow, "VILLE_DEST", sAdrVille )
	dsFichierIndex.SetItem ( lRow, "PAYS_DEST", "FRANCE" )
	dsFichierIndex.SetItem ( lRow, "CODE_ANNEXE_MSP_1", "" )
	dsFichierIndex.SetItem ( lRow, "CODE_ANNEXE_MSP_2", "" )
	dsFichierIndex.SetItem ( lRow, "CODE_ANNEXE_MSP_3", "" )
	dsFichierIndex.SetItem ( lRow, "CODE_ANNEXE_MSP_4", "" )
	dsFichierIndex.SetItem ( lRow, "CODE_ANNEXE_FLUX_1", "" )
	dsFichierIndex.SetItem ( lRow, "CODE_ANNEXE_FLUX_2", "" )
	dsFichierIndex.SetItem ( lRow, "CODE_ANNEXE_FLUX_3", "" )
	dsFichierIndex.SetItem ( lRow, "CODE_ANNEXE_FLUX_4", "" )
	dsFichierIndex.SetItem ( lRow, "REFERENCE_SINISTRE", String ( idcIdSin ) )
	dsFichierIndex.SetItem ( lRow, "PAGE", string ( lRow )  )
	dsFichierIndex.SetItem ( lRow, "NBRE_PAGE_TOTALE", sNbPageTotal )
	dsFichierIndex.SetItem ( lRow, "CODE_PRODUIT", String ( dcIdProd ) )
	dsFichierIndex.SetItem ( lRow, "ASSUREUR", sLibCie )
	dsFichierIndex.SetItem ( lRow, "CONTRACTANT", sContractant )
	dsFichierIndex.SetItem ( lRow, "CODE_ARCHIVE", String ( iiIdArch ) )
	dsFichierIndex.SetItem ( lRow, "CODE_APPLICATION", sApplication )

Next

// Ecriture du fichier index
iRet = dsFichierIndex.SaveAs ( sChemin + sNomFichierSortie + "." + sExtFichierIndex, Text!, TRUE )

If IsValid ( dsFichierIndex ) Then Destroy dsFichierIndex

// Si écriture Ok pour la macro, je vérifie encore.
If iRet < 0 Then
	This.uf_setPM425 ( "RAZ", 0,0,"",0,0,0, 0, iMleMsg, "", FALSE )
	sText = "Dossier : " + String ( idcIdSin ) + ", inter " + String ( idcIdInter ) + " Echec écriture fichier index (" + sExtFichierIndex + ")" + "~r~n"
	iMleMsg.uf_AjouterText ( sText )
	
	This.uf_setPM425 ( "RAZ", 0,0,"",0,0,0,0, iMleMsg, "", FALSE )
	
	// On supprime l'éventuel fichier PDF qui a pu tout de même s'écrire (cas déjà vu).
	FileDelete ( sChemin + sNomFichierSortie + "." + sExtFichierSortie )
	// On supprime l'éventuel fichier IDX qui a pu tout de même s'écrire (cas déjà vu).
	FileDelete ( sChemin + sNomFichierSortie + "." + sExtFichierIndex )	
	
	Return "PROBLEME"
End IF 	

sText = "Dossier : " + String ( idcIdSin ) + ", inter " + String ( idcIdInter ) + " Succès écriture fichier index (" + sExtFichierIndex + ")" + "~r~n"
iMleMsg.uf_AjouterText ( sText )

// [VDOC29832]

// Et on trace aussi l'écriture de l'index
sSql  = "Exec sysadm.PS_I_PM425_INSERT_TRACE_V01 "
sSql += String ( idcIdSin ) + "., "
sSql += String ( idcIdInter ) + "., "
sSql += String ( dcIdDoc ) + "., "
sSql += String ( iiIdArch ) + ", "
sSql += String ( ilIdLot ) + ", "
sSql += "'INDEX'" + ", "
sSql += "'" + sExtFichierIndex + "'" + ", "   // PDF(17)
sSql += "'" + sChemin + "'" + ", "
sSql += "'" + sNomFichierSortie + "." + sExtFichierIndex + "'" + ", "
sSql += "'" + String ( ilIdTypDoc ) + "'" + ", "
sSql += "'" + sFondPage + "'"+ ", "
sSql += "'" + sLibCie + "'" + ", "
sSql += "'" + sContractant + "'" + ", "
sSql += "'" + F_REMPLACE ( sNomDest, "'", "''" ) + "'" + ", "
sSql += "'" + F_REMPLACE ( sAdr1, "'", "''" ) + "'" + ", "
sSql += "'" + F_REMPLACE ( sAdr2, "'", "''" ) + "'" + ", "
sSql += "'" + sAdrCP + "'" + ", "
sSql += "'" + F_REMPLACE ( sAdrVille, "'", "''" ) + "'" + ", "
sSql += "'" + stGlb.sCodOper + "', "
sSql += "0"

F_Execute ( sSql, SQLCA )
bRet = SQLCA.SqlCode = 0 And SQLCA.SqlDBCode = 0
F_Commit ( SQLCA, bRet ) 

If Not bRet Then 
	sText = "Dossier : " + String ( idcIdSin ) + ", inter " + String ( idcIdInter ) + " Echec écriture trace " + sExtFichierIndex + " en base" + "~r~n"
	iMleMsg.uf_AjouterText ( sText )

	This.uf_setPM425 ( "RAZ", 0,0,"",0,0,0,0, iMleMsg, "", FALSE )
	
	// On supprime l'éventuel fichier PDF qui a pu tout de même s'écrire (cas déjà vu).
	FileDelete ( sChemin + sNomFichierSortie + "." + sExtFichierSortie )
	// On supprime l'éventuel fichier IDX qui a pu tout de même s'écrire (cas déjà vu).
	FileDelete ( sChemin + sNomFichierSortie + "." + sExtFichierIndex )		
	
	Return "PROBLEME"
End If

// Si Tout est Ok, on simule donc que "L'impression" est Ok, pour que la fin du traitement en amont se passe bien.
SetProfileString ( isFicCourrierIni, "IMPRESSION", "STATUS", "OK" )

This.uf_setPM425 ( "RAZ", 0,0,"",0,0,0,0, iMleMsg, "", FALSE )

Return "SUCCES"

end function

public function integer uf_getpm425_etatedtetdecent ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_getpm425_EtatEdtEtDecent	(PUBLIC)
//* Auteur			: JFF
//* Date				: 11/06/2019
//* Libellé			: 
//* Commentaires	: [PM425-1] Récuparéation variable ibAMUEditionDecentralise
//*
//* Arguments		: (Val)		String		asidsin
//*
//* Retourne		: Integer				 1 = Tout est OK
//*												-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//*-----------------------------------------------------------------

If ibAMUEditionDecentralisee And ibAMUEditionChezSPB Then Return 3
If ibAMUEditionDecentralisee Then Return 1
If ibAMUEditionChezSPB Then Return 2

Return 2

end function

public subroutine uf_setpm425_etatedtetdecent (boolean abamueditiondecent, boolean abamueditionchezspb);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_setpm425_etatedtetdecent	(PUBLIC)
//* Auteur			: JFF
//* Date				: 11/06/2019
//* Libellé			: 
//* Commentaires	: [PM425-1] On initialise les variables ibAMUEditionDecentralise et ibAMUEditionChezSPB
//*
//* Arguments		: (Val)		String		asidsin
//*
//* Retourne		: Integer				 1 = Tout est OK
//*												-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//*-----------------------------------------------------------------

ibAMUEditionDecentralisee = abAMUEditionDecent
ibAMUEditionChezSPB = abAMUEditionChezSPB

end subroutine

public subroutine uf_setpm425 (string ascas, long aiidsin, long aiidinter, string asidcour, long aiidarch, long alidlot, long alidtypdoc, long aliddoc, u_rapport amlemsg, string ascastrtpm425, boolean abmodeimpression);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_setPM425	(PUBLIC)
//* Auteur			: JFF
//* Date				: 11/06/2019
//* Libellé			: 
//* Commentaires	: [PM425-1] On initialise la var d'instance ID_SIN
//*
//* Arguments		: (Val)		String		asidsin
//*
//* Retourne		: Integer				 1 = Tout est OK
//*												-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//*-----------------------------------------------------------------
Integer iRet

Choose Case asCas
	Case "INIT"
		// [PM425-1]
		idcIdSin = aiIdSin
		idcIdInter = aiIdInter
		isIdCour = asIdCour
		iiIdArch = aiIdArch
		ilIdLot = alIdLot
		ilIdTypDoc = alIdTypDoc
		ilIdDoc = alIdDoc
		isCasTrtPM425 = asCasTrtPM425 
		ibModeImpression = abModeImpression
		
		iMleMsg = aMleMsg

	Case "FIN_REGROUPEMENT"
		isCodeRegroupement = ""
		ilIndexPosition = 0

	Case "RAZ"

		idcIdSin = -1
		idcIdInter = -1
		isIdCour = ""
		iiIdArch = -1
		ilIdLot = -1
		ilIdTypDoc = -1
		ilIdDoc = -1 
		isCasTrtPM425 = ""
		ibModeImpression = FALSE
		
End CHoose 
end subroutine

public subroutine uf_set_coupermsgedi025 (boolean abcoupermsgedi025);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_set_CouperMsgedi025	(PUBLIC)
//* Auteur			: JFF
//* Date				: 11/12/2019
//* Libellé			: 
//* Commentaires	: [TRACE_TS_COURRIER] 
//*
//* Arguments		: (Val)		String		asidsin
//*
//* Retourne		: Integer				 1 = Tout est OK
//*												-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//*-----------------------------------------------------------------

ibCouperMsgEDI025 = abCouperMsgEDI025







end subroutine

public subroutine uf_get_erreurimprimeredi025 (ref string asvarerr1, ref string asvarerr2);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_Get_ErreurImprimerEDI025	(PUBLIC)
//* Auteur			: JFF
//* Date				: 11/12/2019
//* Libellé			: 
//* Commentaires	: [TRACE_TS_COURRIER] 
//*
//* Arguments		: (Val)		String		asidsin
//*
//* Retourne		: Integer				 1 = Tout est OK
//*												-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//*-----------------------------------------------------------------

asVarErr1 = isVarErr [1]
asVarErr2 = isVarErr [2]


end subroutine

public subroutine uf_setmodeleparmediaetinter (ref integer ait_intermodele[], ref string ast_modeleinter[]);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Edition_Courrier::uf_setModeleParMediaEtInter	(PUBLIC)
//* Auteur			: JFF
//* Date				: 26/04/2023
//* Libellé			: 
//* Commentaires	: [RS5045_REF_MATP]
//*
//* Arguments		: (Val)		String		asidsin
//*
//* Retourne		: Integer				 1 = Tout est OK
//*												-1 = Il y a un problème
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//*-----------------------------------------------------------------

iiT_InterModele = aiT_InterModele
isT_ModeleInter = asT_ModeleInter	

end subroutine

on destructor;//*-----------------------------------------------------------------
//*
//* Objet			: N_Cst_Edition_Courrier
//* Evenement 		: Destructor
//* Auteur			: Erick John Stark
//* Date				: 23/03/2000 16:08:57
//* Libellé			: 
//* Commentaires	: On ferme le NVUo pour l'edition des courriers
//*				  
//* Arguments		: 
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On supprime les objets en instance.                              */
/*------------------------------------------------------------------*/
//uf_TerminerSession ()


end on

on n_cst_edition_courrier.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_edition_courrier.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//*-----------------------------------------------------------------
//*
//* Objet			: n_cst_edition_courrier
//* Evenement 		: constructor
//* Auteur			: PHG
//* Date				: 13/05/2008 14:07:51
//* Libellé			: 
//* Commentaires	: [SUPPORT_MFP] Instanciation du descripteur d'imprimante
//*						suivant l'imprimante spécifiée dans le .INI
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

string sPrinterKey

sPrinterKey = ProfileString(stglb.sfichierini, "EDITION", "IMPRIMANTE", "old_printer")

invPrinter = CREATE USING ("n_cst_printer_descriptor_"+sPrinterKey)

end event

