HA$PBExportHeader$n_cst_word2003.sru
$PBExportComments$------} UserObjet pour WORD 2003.
forward
global type n_cst_word2003 from n_cst_word
end type
end forward

global type n_cst_word2003 from n_cst_word
end type
global n_cst_word2003 n_cst_word2003

type variables
Private :
// [MIGPB11] [EMD] : Debut : 'remont$$HEX1$$e900$$ENDHEX$$' de ces variables sous forme de constantes, dans la classe ancetre
	//String K_CLASSNAME	= "OpusApp"
	//String K_WINDOWNAME	= "Microsoft Word"
	constant String K_WORD2003		= "Word.Application.11"
// [MIGPB11] [EMD] : Fin

// [Office2010] [FMU] : Debut : 
//$$HEX2$$e0002000$$ENDHEX$$priori d'apr$$HEX1$$e800$$ENDHEX$$s http://support.microsoft.com/kb/821549
//le SP2 correspond $$HEX2$$e0002000$$ENDHEX$$une version <= 11.0.7969.0
//(la version de Office 2003 SP2 trouv$$HEX1$$e900$$ENDHEX$$e sur la VM de test est 11.0.6568)
//(la version de Office 2003 SP3 trouv$$HEX1$$e900$$ENDHEX$$e sur la VM de test est 11.0.8326)
Constant Long K_SP3min = 7970
// [Office2010] [FMU] : Fin

end variables

forward prototypes
public function integer uf_agrandirword (boolean abagrandir)
public subroutine uf_commandeword (integer aitype, string asparam1, ref oleobject aoleobject)
public function integer uf_fichierouvertdansword (ref oleobject aoleobject, boolean abfermer, boolean abfermer_sansverifier)
public function integer uf_creeroleobject_word (ref oleobject aoleobject)
public function integer uf_fermerword ()
public subroutine uf_trace (s_glb astglb, string asdescription)
public function integer uf_setversionword (string as_majeur, string as_moyen, string as_mineur)
end prototypes

public function integer uf_agrandirword (boolean abagrandir);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word2003::uf_AgrandirWord			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/05/2006 10:03:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut maximizer ou minimizer la fen$$HEX1$$ea00$$ENDHEX$$tre WORD.
//*
//* Arguments		: Boolean	(Val)		abAgrandir
//*
//* Retourne		: Integer		 1 = Tout se passe bien
//*										 0 = Word ne fonctionne pas
//*										-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

ULong ulHandleWord
Boolean bRet
Integer iRet
Long lMessage

iRet = -1
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le Handle de la fen$$HEX1$$ea00$$ENDHEX$$tre WORD.                        */
/*------------------------------------------------------------------*/
ulHandleWord = uf_WordOuvert ()

If	ulHandleWord > 0	Then
	If	abAgrandir		Then lMessage = 61728		// SC_MINIMIZE
	If	Not abAgrandir	Then lMessage = 61472		// SC_RESTORE
	
	bRet = Post ( ulHandleWord, 274, lMessage, 0 )
	If	bRet Then iRet = 1
Else
	iRet = 0
End If

Return ( iRet )


end function

public subroutine uf_commandeword (integer aitype, string asparam1, ref oleobject aoleobject);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word2003::uf_CommandeWord		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/05/2006 10:03:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On lance une commande WORD
//*
//* Arguments		: (Val)	Integer		aiType
//*					  (Val)	String		asParam1
//*					  (R$$HEX1$$e900$$ENDHEX$$f)	OleObject	aOleObject
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* [MIGPB8COR]	PHG	14/04/2006	correction Migration PB8 - Ajout de yield()
//*-----------------------------------------------------------------

Long lCpt, lTotFenetre, lPosG, lHauteur, lLargeur
String sFicIniApp, sCommande
boolean bContinue
string szError
integer i, li_res
n_cst_DateTime	nDelay

nDelay = Create n_cst_DateTime

bContinue = false // Par d$$HEX1$$e900$$ENDHEX$$faut, en cas de probl$$HEX1$$e800$$ENDHEX$$me on ne continue pas
			             // -> On garde l'ancien fonctionnement $$HEX2$$e0002000$$ENDHEX$$savoir un PB General Faillure

// LBP le 21/05/10 : Ajout du try ... catch(OLERuntimeError)
//       En cas d'erreur OLE on trace l'erreur dans un fichier d$$HEX1$$e900$$ENDHEX$$di$$HEX1$$e900$$ENDHEX$$
//       Pour conserver le fonctionnement actuel on r$$HEX1$$e900$$ENDHEX$$-emet l'exepction catch$$HEX1$$e900$$ENDHEX$$e
try
	Choose Case	aiType
	Case 1
	/*------------------------------------------------------------------*/	
	/* Ouvrir un fichier mod$$HEX1$$e900$$ENDHEX$$le.                                        */
	/*------------------------------------------------------------------*/
// [Office2010] [FMU] : Debut : 
		li_res = uf_CorrigeCheminModele(asParam1)
// [Office2010] [FMU] : Fin
		aOleObject.Documents.Add ( asParam1 )
	Case 2
	/*------------------------------------------------------------------*/	
	/* Ex$$HEX1$$e900$$ENDHEX$$cuter une MACRO.                                              */
	/*------------------------------------------------------------------*/
	//	This.uf_AgrandirWord ( TRUE )
// [Office2010] [FMU] : Debut : Si n$$HEX1$$e900$$ENDHEX$$cessaire modifier le chemin du mod$$HEX1$$e800$$ENDHEX$$le de document enregistr$$HEX2$$e9002000$$ENDHEX$$dans le fichier
		uf_CorrigeModele(aOleObject)
// [Office2010] [FMU] : Fin
		try // FPI.17/07/2014
			aOleObject.Application.Run ( asParam1 )
		catch (OLERuntimeError OleE_2)
			aOleObject.Run ( asParam1 )
		End try
	Case 3
	/*------------------------------------------------------------------*/	
	/* Ouvrir un fichier WORD.                                          */
	/*------------------------------------------------------------------*/
		aOleObject.Documents.Open ( asParam1 )
	Case 4
	/*------------------------------------------------------------------*/
	/* Cette commande est utilis$$HEX1$$e900$$ENDHEX$$e dans N_Cst_Edition_Courrier.         */
	/* Fonction uf_Generation_Courrier. Elle permet de positionner      */
	/* WORD dans un endroit pr$$HEX1$$e900$$ENDHEX$$cis de l'$$HEX1$$e900$$ENDHEX$$cran.                          */
	/*------------------------------------------------------------------*/
	/* Avec WORD2000, si l'application est maximis$$HEX1$$e900$$ENDHEX$$e, il est            */
	/* impossible de d$$HEX1$$e900$$ENDHEX$$placer la fen$$HEX1$$ea00$$ENDHEX$$tre. Il faut donc la mettre dans   */
	/* un $$HEX1$$e900$$ENDHEX$$tat normal avant toute chose.                                */
	/*------------------------------------------------------------------*/
		sFicIniApp			= stGLB.sFichierIni
		If	IsNull ( asParam1 ) Or Len ( Trim ( asParam1 ) ) = 0 Then asParam1 = "POSITION WORD"
		
		lPosG					= ProfileInt ( sFicIniApp, asParam1, "G", 480 )
		lHauteur				= ProfileInt ( sFicIniApp, asParam1, "HT", 745 )
		lLargeur				= ProfileInt ( sFicIniApp, asParam1, "LG", 480 )
	
		aOleObject.Activate ()
		aOleObject.Application.WindowState = 2
		aOleObject.Application.WindowState = 0
		lTotFenetre = aOleObject.Windows.Count 
		
		For	lCpt = 1 To lTotFenetre
	// [MIGPB8COR] -- Ajout de Yield pour laisser Word faire son dimensionnement
	//
	//			aOleObject.Windows[ lCpt ].Left		=  lPosG
	//			aOleObject.Windows[ lCpt ].Height	=  Int ( lHauteur / lTotFenetre )
	//			aOleObject.Windows[ lCpt ].Width		=  lLargeur
	//			aOleObject.Windows[ lCpt ].Top		=  Int ( ( lCpt - 1 ) * ( lHauteur / lTotFenetre ) )
	// remplac$$HEX2$$e9002000$$ENDHEX$$par
	
				aOleObject.Windows[ lCpt ].Left		=  lPosG
				aOleObject.Windows[ lCpt ].Height	=  Int ( lHauteur / lTotFenetre )
				aOleObject.Windows[ lCpt ].Width		=  lLargeur
				aOleObject.Windows[ lCpt ].Top		=  Int ( ( lCpt - 1 ) * ( lHauteur / lTotFenetre ) )
	
				aOleObject.Windows[ lCpt ].ActivePane.View.Type = 1
		Next
	
	Case 5
	/*------------------------------------------------------------------*/	
	/* Ouvrir un fichier WORD et $$HEX1$$e900$$ENDHEX$$diter le fichier.                     */
	/*------------------------------------------------------------------*/
		aOleObject.Documents.Open ( asParam1 )
		aOleObject.ActiveDocument.PrintOut ( FALSE, FALSE, 0, "", "0", "0", 0, 1, "", 0, FALSE )
	/* BackGround, Append, Range, OutpuFileName, From, To, Item, Copies, Pages, PageType, PrintToFile */
		aOleObject.Documents.Close ( 0, 0, TRUE )
	Case 6
	/*------------------------------------------------------------------*/	
	/* Ouvrir un fichier WORD et $$HEX1$$e900$$ENDHEX$$diter le fichier.                     */
	/*------------------------------------------------------------------*/
	//	aOleObject.Activate ()
		aOleObject.Application.WindowState = 2
		aOleObject.Application.WindowState = 0
		lTotFenetre = aOleObject.Windows.Count 
		
		// [Office2010] [FMU] : Debut : Application de la modif de Baptiste sur n_cst_word2010 pour le SP3, 
		//pas plus d'explication ici que pour Office 2010...
		If long(is_VersionMineur) > K_SP3min Then
			nDelay.of_wait(1)
		End If
		// [Office2010] [FMU] : Fin
		
		For	lCpt = 1 To lTotFenetre
	// [MIGPB8COR] -- Ajout de Yield pour laisser Word faire son dimensionnement
	//
	//			aOleObject.Windows[ lCpt ].Left		=  480
	//			aOleObject.Windows[ lCpt ].Height	=  Int ( 745 / lTotFenetre )
	//			aOleObject.Windows[ lCpt ].Width		=  480
	//			aOleObject.Windows[ lCpt ].Top		=  Int ( ( lCpt - 1 ) * ( 745 / lTotFenetre ) )
	// remplace par
				aOleObject.Windows[ lCpt ].Left		=  480
				aOleObject.Windows[ lCpt ].Height	=  Int ( 745 / lTotFenetre )
				aOleObject.Windows[ lCpt ].Width		=  480
				aOleObject.Windows[ lCpt ].Top		=  Int ( ( lCpt - 1 ) * ( 745 / lTotFenetre ) )
	
				aOleObject.Windows[ lCpt ].ActivePane.View.Type = 1
		Next
	Case 7
	/*----------------------------------------------------------------------------*/
	/* Ins$$HEX1$$e900$$ENDHEX$$rer un fichier dans le document WORD ouvert.                           */
	/*----------------------------------------------------------------------------*/
		aOleObject.Selection.InsertFile ( asParam1 )
	Case 8
	/*----------------------------------------------------------------------------*/
	/* Enregistrement d'un fichier.                                               */
	/*----------------------------------------------------------------------------*/
		aOleObject.ActiveDocument.SaveAs ( asParam1 )
	Case 9
	/*------------------------------------------------------------------*/	
	/* Ouverture d'un fichier et agrandissement de la fen$$HEX1$$ea00$$ENDHEX$$tre WORD.     */
	/*------------------------------------------------------------------*/
		aOleObject.Documents.Open ( asParam1 )
		aOleObject.Application.WindowState = 2		// Minimize
		aOleObject.Application.WindowState = 1		// Maximize
	
	//	aOleObject.FenAppAgrandissement ()
	Case 10
	/*------------------------------------------------------------------*/
	/* Fermer tous les fichiers ouverts dans WORD.                      */
	/*------------------------------------------------------------------*/
		aOleObject.Documents.Close ( 0, 0, TRUE )
	
	Case 100
	/*------------------------------------------------------------------*/
	/* Fermer tous les fichiers ouverts dans WORD.                      */
	/* en demandant l'enregistement des doc non sauvegard$$HEX1$$e900$$ENDHEX$$s             */
	/*------------------------------------------------------------------*/
	
	
	Case 11
	/*------------------------------------------------------------------*/
	/* On enl$$HEX1$$e900$$ENDHEX$$ve la liaison de fusion du document en cours. On          */
	/* repositionne une nouvelle valeur pour le fichier mod$$HEX1$$e900$$ENDHEX$$le.         */
	/* (Utilisation dans la gestion des paragraphes.)                   */
	/*------------------------------------------------------------------*/
		aOleObject.ActiveDocument.MailMerge.MainDocumentType = -1
		aOleObject.ActiveDocument.AttachedTemplate = asParam1
	
	//	aOleObject.FusionR$$HEX1$$e900$$ENDHEX$$tablir ()
	//	aOleObject.FichierMod$$HEX1$$e800$$ENDHEX$$les ( 0, asParam1, 0 )
	Case 12
	/*------------------------------------------------------------------*/
	/* On s$$HEX1$$e900$$ENDHEX$$lectionne le contenu d'un document.                         */
	/* (Utilisation dans la gestion des paragraphes.)                   */
	/*------------------------------------------------------------------*/
		aOleObject.Documents.Open ( asParam1 )
		aOleObject.ActiveDocument.Content.Select
		aOleObject.Selection.Range.Copy
		aOleObject.Documents.Close ( 0, 0, TRUE )
	
	//	aOleObject.FichierOuvrir ( asParam1 )
	//	aOleObject.EditionS$$HEX1$$e900$$ENDHEX$$lectionnerTout ()
	//	aOleObject.EditionCopier ()	
	//	aOleObject.FichierFermerTout ( 2 )
	
	Case 13	// AJOUT LBP le 21/05/10
		/*------------------------------------------------------------------------------------------------------*/
		/*  Demande de g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration du fichier de nbre de page                                                     */
		/*  Utilisation dans Savane uniquement, la macro doit exister dans courrier.dot                   */
		/*------------------------------------------------------------------------------------------------------*/
				
		// Si le comptage des pages echoue on ne fait pas suivre l'erreur de mani$$HEX1$$e800$$ENDHEX$$re $$HEX2$$e0002000$$ENDHEX$$
		// ce que la g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ration des courriers continue
		bContinue = true
// [Office2010] [FMU] : Debut : Si n$$HEX1$$e900$$ENDHEX$$cessaire modifier le chemin du mod$$HEX1$$e800$$ENDHEX$$le de document enregistr$$HEX2$$e9002000$$ENDHEX$$dans le fichier
		uf_CorrigeModele(aOleObject)
// [Office2010] [FMU] : Fin
		aOleObject.Application.Run ( "GetNbPages" )
	End Choose
	If IsValid(nDelay) Then Destroy nDelay

// Trappage des erreurs OLE
catch (OLERuntimeError OleE_1)
	// Construction de la chaine d'erreur
	szError = "Cmd=" + string(aiType) 
	if asParam1 <> "" then szError = szError + " Param=" + asParam1
	if OleE_1.description <> "" then szError = szError + " Desc=" + OleE_1.description
	
	If IsValid(nDelay) Then Destroy nDelay
	// Trace de l'err
	uf_trace ( stGlb , szError )
	
	// Si l'on ne veut pas continuer l'execution du prog suite $$HEX2$$e0002000$$ENDHEX$$l'erreur on r$$HEX1$$e900$$ENDHEX$$-emet l'exception
	if not bContinue then
		// Reemission de l'execption pour conserver le fonctionnement courant
		// lors des erreurs Word
		throw OleE_1
	end if	
end try
end subroutine

public function integer uf_fichierouvertdansword (ref oleobject aoleobject, boolean abfermer, boolean abfermer_sansverifier);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word2003::uf_FichierOuvertDansWord		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/05/2006 10:03:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Existe-t-il des fichiers ouverts dans l'objet OLE WORD
//*
//* Arguments		: (R$$HEX1$$e900$$ENDHEX$$f)		OleObject		aOleObject
//*					  (Val)		Boolean			abFermer
//*					  (Val)		Boolean			abFermer_SansV$$HEX1$$e900$$ENDHEX$$rifier
//*
//* Retourne		: Integer				 1 = Il n'existe aucun document modifi$$HEX2$$e9002000$$ENDHEX$$dans WORD
//*												-1 = L'instance du NVUO est fausse
//*												-2 = Il existe des documents non sauvegard$$HEX1$$e900$$ENDHEX$$s
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Integer iRet
Long lFenetre, lCpt
Boolean bModif, bApercu
String sVarErreur[]

If	Not IsValid ( aOleObject )	Then Return ( -1 )

/*------------------------------------------------------------------*/
/* On regarde combien il existe de fen$$HEX1$$ea00$$ENDHEX$$tres d'ouvertes dans WORD.   */
/*------------------------------------------------------------------*/
lFenetre = aOleObject.Windows.Count
/*------------------------------------------------------------------*/
/* Si l'objet WORD est en APERCU AVANT IMPRESSION, les commandes    */
/* OLE ne vont pas fonctionner correctement. Il faut d$$HEX1$$e900$$ENDHEX$$sactiver     */
/* APERCU.                                                          */
/*------------------------------------------------------------------*/
iRet		= 1
If lFenetre > 0	Then
	bApercu = aOleObject.Application.PrintPreview
	If bApercu = TRUE Then aOleObject.ActiveDocument.ClosePrintPreview
End If

For	lCpt = 1 To lFenetre
/*------------------------------------------------------------------*/	
/* On se positionne sur la fen$$HEX1$$ea00$$ENDHEX$$tre, on la rend active et on         */
/* v$$HEX1$$e900$$ENDHEX$$rifie s'il existe des modifications non enregistr$$HEX1$$e900$$ENDHEX$$es.          */
/*------------------------------------------------------------------*/
		aOleObject.Windows[ lCpt ].Activate
		bModif = aOleObject.ActiveDocument.Saved
/*------------------------------------------------------------------*/		
/* Le document est modifi$$HEX2$$e9002000$$ENDHEX$$et non enregistr$$HEX1$$e900$$ENDHEX$$. On affiche un         */
/* message d'avertissement.                                         */
/*------------------------------------------------------------------*/
		If	Not bModif Then
			iRet = -2
/*------------------------------------------------------------------*/
/* Le client ne doit pas voir pas de message s'il souhaite forcer   */
/* la fermeture.                                                    */
/*------------------------------------------------------------------*/
			If	Not abFermer_SansVerifier	Then
				sVarErreur[1] = aOleObject.ActiveWindow.Caption

				stMessage.sTitre		= "Fichier ouvert dans WORD"
				stMessage.sVar			= sVarErreur
				stMessage.Icon			= Exclamation!
				stMessage.bErreurG	= TRUE
				stMessage.sCode		= "EDI030"
			   stMessage.bTrace  	= False

				F_Message ( stMessage )
			End If
			Exit			
		End If			
Next
/*------------------------------------------------------------------*/
/* Si tous les documents pr$$HEX1$$e900$$ENDHEX$$sents dans WORD sont sauvegard$$HEX1$$e900$$ENDHEX$$s, on    */
/* peut tous les fermer si le client le d$$HEX1$$e900$$ENDHEX$$sire.                     */
/*------------------------------------------------------------------*/
/* On peut aussi fermer tous les fichiers NON SAUVEGARDE si         */
/* abFermer_SansVerifier = TRUE.                                    */
/*------------------------------------------------------------------*/
If	( abFermer	And iRet = 1 And lFenetre > 0 ) Or ( abFermer_SansVerifier And lFenetre > 0 ) Then
	aOleObject.Documents.Close ( 0, 0, TRUE )
End If

/*------------------------------------------------------------------*/
/* Suite discussion JFF, il faut toujours renvoyer 1 en cas de      */
/* demande de fermeture brutale.                                    */
/*------------------------------------------------------------------*/
If abFermer_SansVerifier	Then	iRet = 1

Return ( iRet )

end function

public function integer uf_creeroleobject_word (ref oleobject aoleobject);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word2003::uf_CreerOleObject_Word		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/05/2006 10:03:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cette fonction se charge de cr$$HEX1$$e900$$ENDHEX$$er la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence $$HEX2$$e0002000$$ENDHEX$$WORD
//*
//* Arguments		: (R$$HEX1$$e900$$ENDHEX$$f)		OleObject		aOleObject
//*
//* Retourne		: Integer				 0 = Tout est OK
//*											  < 0 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Integer iRet

/*------------------------------------------------------------------*/
/* On ne s'occupe pas de la cr$$HEX1$$e900$$ENDHEX$$ation de l'objet OLE. On s'occupe de */
/* la connection avec WORD.                                         */
/*------------------------------------------------------------------*/
If	uf_WordOuvert () = 0	Then
	iRet = aOleObject.ConnectToNewObject ( K_WORD2003 )
Else
	iRet = aOleObject.ConnectToObject ( "", K_WORD2003 )
//	If iRet = 0 Then aOleObject.Application.WindowState = 2
End If	

Return  ( iRet )

end function

public function integer uf_fermerword ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word2003::uf_FermerWord		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/05/2006 10:03:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On s'occupe de fermer la fen$$HEX1$$ea00$$ENDHEX$$tre WORD si elle est ouverte
//*
//* Arguments		: 
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On part du principe qu'il n'existe plus aucun document d'ouvert  */
/* dans WORD. Le nom de la fen$$HEX1$$ea00$$ENDHEX$$tre est donc (Microsoft Word).       */
/*------------------------------------------------------------------*/

String sWindowName
ULong ulWinHandle
Long lRet

sWindowName = K_WINDOWNAME

//Migration PB8-WYNIWYG-03/2006 FM
//ulWinHandle = FindWindow ( 0, sWindowName )
String	ls_null
SetNull(ls_null)
ulWinHandle = FindWindowA (sWindowName, ls_null )
//Fin Migration PB8-WYNIWYG-03/2006 FM
//If	ulWinHandle > 0	Then lRet = SendMessage ( ulWinHandle, 16, 0, 0 )
/*----------------------------------------------------------------------------*/
/* Le SendMessage provoque une erreur syst$$HEX1$$e900$$ENDHEX$$matique. On utilise donc un POST   */
/* pour envoyer un SC_CLOSE (&F060) $$HEX2$$e0002000$$ENDHEX$$WinWord.                                */
/*----------------------------------------------------------------------------*/
If	ulWinHandle > 0	Then Post ( ulWinHandle, 274, 61536, 0 )

Return ( 1 )

end function

public subroutine uf_trace (s_glb astglb, string asdescription);
	//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_trace
//* Auteur			:	LBP
//* Date				:	21/05/10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	Ecrit la trace d'une impression globale.
//*
//* Arguments		:	s_Glb		astGlb				( Val ) 	Desc globale de l'appli
//*						String		asDescription	( Val )	Description de l'erreur rencontr$$HEX1$$e900$$ENDHEX$$e
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------
//* N$$HEX2$$b0002000$$ENDHEX$$Modif          Re$$HEX1$$e700$$ENDHEX$$ue Le          Effectu$$HEX1$$e900$$ENDHEX$$e Le          PAR
//*
//* 1                        					  21/05/10				LBP
//*
//* Ajout de la gestion de trace durant les editions.
//*-----------------------------------------------------------------


String	sTrace,sTab
string sFicTrace, sTemp

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

public function integer uf_setversionword (string as_majeur, string as_moyen, string as_mineur);//la version est inconnue au moment de la construction...
super::uf_SetVersionWord(as_majeur, as_moyen, as_mineur)

If long(as_mineur) > K_SP3min Then	//Office 2003 SP3 ou sup$$HEX1$$e900$$ENDHEX$$rieur
	is_SousRepModele = 'W2K3SP3\'
	//sinon on laisse le r$$HEX1$$e900$$ENDHEX$$pertoire d$$HEX1$$e900$$ENDHEX$$fini par l'evt constructeur
End If

Return 0

end function

on n_cst_word2003.create
call super::create
end on

on n_cst_word2003.destroy
call super::destroy
end on

event constructor;call super::constructor;// [Office2010] [FMU] : Debut : 
is_SousRepModele = 'W2K3\'
// [Office2010] [FMU] : Fin

end event

