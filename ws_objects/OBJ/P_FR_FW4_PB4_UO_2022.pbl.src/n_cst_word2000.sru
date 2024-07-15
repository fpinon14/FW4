HA$PBExportHeader$n_cst_word2000.sru
$PBExportComments$------} UserObjet pour WORD 2000.
forward
global type n_cst_word2000 from n_cst_word
end type
end forward

global type n_cst_word2000 from n_cst_word
end type
global n_cst_word2000 n_cst_word2000

type variables
Private :
// [MIGPB11] [EMD] : Debut : 'remont$$HEX1$$e900$$ENDHEX$$' de ces variables sous forme de constantes, dans la classe ancetre
	//String K_CLASSNAME	= "OpusApp"
	//String K_WINDOWNAME	= "Microsoft Word"
	constant String K_WORD2000	= "Word.Application.9"
// [MIGPB11] [EMD] : Fin
end variables

forward prototypes
public function integer uf_fichierouvertdansword (ref oleobject aoleobject, boolean abfermer, boolean abfermer_sansverifier)
public function integer uf_fermerword ()
public function integer uf_creeroleobject_word (ref oleobject aoleobject)
public subroutine uf_commandeword (integer aitype, string asparam1, ref oleobject aoleobject)
public function integer uf_agrandirword (boolean abAgrandir)
end prototypes

public function integer uf_fichierouvertdansword (ref oleobject aoleobject, boolean abfermer, boolean abfermer_sansverifier);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word2000::uf_FichierOuvertDansWord		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 16:11:10
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

public function integer uf_fermerword ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word2000::uf_FermerWord		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 14:45:54
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

public function integer uf_creeroleobject_word (ref oleobject aoleobject);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word2000::uf_CreerOleObject_Word		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 14:41:35
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
	iRet = aOleObject.ConnectToNewObject ( K_WORD2000 )
Else
	iRet = aOleObject.ConnectToObject ( "", K_WORD2000 )
//	If iRet = 0 Then aOleObject.Application.WindowState = 2
End If	

Return  ( iRet )

end function

public subroutine uf_commandeword (integer aitype, string asparam1, ref oleobject aoleobject);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word2000::uf_CommandeWord		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 27/04/2000 16:03:18
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


Choose Case	aiType
Case 1
/*------------------------------------------------------------------*/	
/* Ouvrir un fichier mod$$HEX1$$e900$$ENDHEX$$le.                                        */
/*------------------------------------------------------------------*/
	aOleObject.Documents.Add ( asParam1 )
Case 2
/*------------------------------------------------------------------*/	
/* Ex$$HEX1$$e900$$ENDHEX$$cuter une MACRO.                                              */
/*------------------------------------------------------------------*/
//	This.uf_AgrandirWord ( TRUE )
// [Office2010] [FMU] : Debut : Si n$$HEX1$$e900$$ENDHEX$$cessaire modifier le chemin du mod$$HEX1$$e800$$ENDHEX$$le de document enregistr$$HEX2$$e9002000$$ENDHEX$$dans le fichier
		uf_CorrigeModele(aOleObject)
// [Office2010] [FMU] : Fin
	aOleObject.Application.Run ( asParam1 )
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
End Choose


end subroutine

public function integer uf_agrandirword (boolean abAgrandir);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word2000::uf_AgrandirWord			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 10:03:22
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

on n_cst_word2000.create
call super::create
end on

on n_cst_word2000.destroy
call super::destroy
end on

