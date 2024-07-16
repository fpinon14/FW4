HA$PBExportHeader$n_cst_word95.sru
$PBExportComments$------} UserObjet pour WORD 95.
forward
global type n_cst_word95 from n_cst_word
end type
end forward

global type n_cst_word95 from n_cst_word
end type
global n_cst_word95 n_cst_word95

type variables
Private :
// [MIGPB11] [EMD] : Debut : 'remont$$HEX1$$e900$$ENDHEX$$' de ces variables sous forme de constantes, dans la classe ancetre
	//String K_CLASSNAME	= "OpusApp"
	//String K_WINDOWNAME	= "Microsoft Word"
	constant String K_WORD95		= "Word.Basic"
// [MIGPB11] [EMD] : Fin
end variables
forward prototypes
public function integer uf_fichierouvertdansword (ref oleobject aoleobject, boolean abfermer, boolean abfermer_sansverifier)
public function integer uf_fermerword ()
public function integer uf_creeroleobject_word (ref oleobject aOleObject)
public subroutine uf_commandeword (integer aitype, string asparam1, ref oleobject aoleobject)
public function integer uf_agrandirword (boolean abAgrandir)
end prototypes

public function integer uf_fichierouvertdansword (ref oleobject aoleobject, boolean abfermer, boolean abfermer_sansverifier);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word95::uf_FichierOuvertDansWord		(PUBLIC)
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
Long lFenetre, lCpt, lModif, lApercu
String sCommande
String sVarErreur[]

If	Not IsValid ( aOleObject )	Then Return ( -1 )

/*------------------------------------------------------------------*/
/* On regarde combien il existe de fen$$HEX1$$ea00$$ENDHEX$$tres d'ouvertes dans WORD.   */
/*------------------------------------------------------------------*/
lFenetre = aOleObject.CompteFen$$HEX1$$ea00$$ENDHEX$$tres ()
/*------------------------------------------------------------------*/
/* Si l'objet WORD est en APERCU AVANT IMPRESSION, les commandes    */
/* OLE ne vont pas fonctionner correctement. Il faut d$$HEX1$$e900$$ENDHEX$$sactiver     */
/* APERCU.                                                          */
/*------------------------------------------------------------------*/
iRet		= 1
If lFenetre > 0	Then
	lApercu = aOleObject.FichierAper$$HEX1$$e700$$ENDHEX$$u ()
	If lApercu = -1 Then aOleObject.FermerAper$$HEX1$$e700$$ENDHEX$$u
End If

For	lCpt = 1 To lFenetre
/*------------------------------------------------------------------*/	
/* On se positionne sur la fen$$HEX1$$ea00$$ENDHEX$$tre, on la rend active et on         */
/* v$$HEX1$$e900$$ENDHEX$$rifie s'il existe des modifications non enregistr$$HEX1$$e900$$ENDHEX$$es.          */
/*------------------------------------------------------------------*/
//		aOleObject.ListeFen$$HEX1$$ea00$$ENDHEX$$tres ( lCpt )

		sCommande = "[ListeFen$$HEX1$$ea00$$ENDHEX$$tres " + String ( lCpt ) +"]"
    	ExecRemote( sCommande, "WinWord", "System"  )
		Yield ()

		lModif = aOleObject.EstDocModifi$$HEX2$$e9002000$$ENDHEX$$()
/*------------------------------------------------------------------*/		
/* Le document est modifi$$HEX2$$e9002000$$ENDHEX$$et non enregistr$$HEX1$$e900$$ENDHEX$$. On affiche un         */
/* message d'avertissement.                                         */
/*------------------------------------------------------------------*/
		If	lModif <> 0	Then
			iRet = -2
/*------------------------------------------------------------------*/
/* Le client ne doit pas voir pas de message s'il souhaite forcer   */
/* la fermeture.                                                    */
/*------------------------------------------------------------------*/
			If	Not abFermer_SansVerifier	Then
				sVarErreur[1] = aOleObject.NomFen$$HEX1$$ea00$$ENDHEX$$tre$ ( lCpt )

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
	sCommande = "[FichierFermerTout 2]"
	ExecRemote( sCommande, "WinWord", "System"  )
	Yield ()

//	aOleObject.FichierFermerTout (2)
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
//* Fonction		: N_Cst_Word95::uf_FermerWord		(PUBLIC)
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
ulWinHandle = FindWindowA (sWindowName, ls_null)

//If	ulWinHandle > 0	Then lRet = SendMessage ( ulWinHandle, 16, 0, 0 )
If	ulWinHandle > 0	Then lRet = SendMessageA ( ulWinHandle, 16, 0, 0 )
//Fin Migration PB8-WYNIWYG-03/2006 FM

Return ( 1 )

end function

public function integer uf_creeroleobject_word (ref oleobject aOleObject);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word95::uf_CreerOleObject_Word		(PUBLIC)
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
/* la connection avec WORD.                                          */
/*------------------------------------------------------------------*/
iRet = aOleObject.ConnectToNewObject ( K_WORD95 )

Return  ( iRet )

end function

public subroutine uf_commandeword (integer aitype, string asparam1, ref oleobject aoleobject);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word95::uf_CommandeWord		(PUBLIC)
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
//* 
//*-----------------------------------------------------------------

Long lPosG, lPosV, lHauteur, lLargeur
String sFicIniApp, sCommande

Choose Case	aiType
Case 1
/*------------------------------------------------------------------*/	
/* Ouvrir un fichier mod$$HEX1$$e900$$ENDHEX$$le.                                        */
/*------------------------------------------------------------------*/
	aOleObject.FichierNouveau ( asParam1, 0 )
Case 2
/*------------------------------------------------------------------*/	
/* Ex$$HEX1$$e900$$ENDHEX$$cuter une MACRO.                                              */
/*------------------------------------------------------------------*/
	aOleObject.OutilsMacro ( asParam1, TRUE )
Case 3
/*------------------------------------------------------------------*/	
/* Ouvrir un fichier WORD.                                          */
/*------------------------------------------------------------------*/
	aOleObject.FichierOuvrir ( asParam1 )
Case 4
/*------------------------------------------------------------------*/
/* Cette commande est utilis$$HEX1$$e900$$ENDHEX$$e dans N_Cst_Edition_Courrier.         */
/* Fonction uf_Generation_Courrier. Elle permet de positionner      */
/* WORD dans un endroit pr$$HEX1$$e900$$ENDHEX$$cis de l'$$HEX1$$e900$$ENDHEX$$cran.                          */
/*------------------------------------------------------------------*/
	sFicIniApp			= stGLB.sFichierIni
	If	IsNull ( asParam1 ) Or Len ( Trim ( asParam1 ) ) = 0 Then asParam1 = "POSITION WORD"
	
	lPosG					= ProfileInt ( sFicIniApp, asParam1, "G", 480 )
	lPosV					= ProfileInt ( sFicIniApp, asParam1, "V", 0 )
	lHauteur				= ProfileInt ( sFicIniApp, asParam1, "HT", 745 )
	lLargeur				= ProfileInt ( sFicIniApp, asParam1, "LG", 480 )

	aOleObject.FenAppPosG ( lPosG )
	aOleObject.FenAppPosH ( lPosV )

	sCommande = "[FenAppDimension " + String ( lLargeur ) + " ," + String ( lHauteur ) + "]"
	ExecRemote( sCommande, "WinWord", "System"  )
	Yield ()

//	aOleObject.FenAppDimension ( lLargeur, lHauteur )
	aOleObject.Fen$$HEX1$$ea00$$ENDHEX$$treR$$HEX1$$e900$$ENDHEX$$organiser

//	aOleObject.AppActiver ( "Microsoft Word", 1 )
Case 5
/*------------------------------------------------------------------*/	
/* Ouvrir un fichier WORD et $$HEX1$$e900$$ENDHEX$$diter le fichier.                     */
/*------------------------------------------------------------------*/
	aOleObject.FichierOuvrir ( asParam1 )
	aOleObject.FichierImprimer ()

	sCommande = "[FichierFermerTout 2]"
	ExecRemote( sCommande, "WinWord", "System"  )
	Yield ()

//	aOleObject.FichierFermerTout ( 2 )
Case 6
/*------------------------------------------------------------------*/
/* Commande Non utilis$$HEX1$$e900$$ENDHEX$$e en Word95 mais utilis$$HEX1$$e900$$ENDHEX$$e en Word2000.       */
/*------------------------------------------------------------------*/
Case 7
/*------------------------------------------------------------------*/
/* Ins$$HEX1$$e900$$ENDHEX$$rer un Fichier dans le document WORD ouvert.                 */
/*------------------------------------------------------------------*/
	aOleObject.InsertionFichier ( asParam1 )
Case 8
/*------------------------------------------------------------------*/	
/* Enregistrement d'un fichier.                                     */
/*------------------------------------------------------------------*/
	aOleObject.FichierEnregistrerSous ( asParam1 )

Case 9
/*------------------------------------------------------------------*/	
/* Ouverture d'un fichier et agrandissement de la fen$$HEX1$$ea00$$ENDHEX$$tre WORD.     */
/*------------------------------------------------------------------*/
	aOleObject.FichierOuvrir ( asParam1 )

	sCommande = "[FenAppAgrandissement]"
	ExecRemote( sCommande, "WinWord", "System"  )
Case 10
/*------------------------------------------------------------------*/
/* Fermer tous les fichiers ouverts dans WORD.                      */
/*------------------------------------------------------------------*/
//	aOleObject.FichierFermerTout ( 2 )

	sCommande = "[FichierFermerTout 2]"
	ExecRemote( sCommande, "WinWord", "System"  )
	Yield ()

Case 11
/*------------------------------------------------------------------*/
/* On enl$$HEX1$$e900$$ENDHEX$$ve la liaison de fusion du document en cours. On          */
/* repositionne une nouvelle valeur pour le fichier mod$$HEX1$$e900$$ENDHEX$$le.         */
/* (Utilisation dans la gestion des paragraphes.)                   */
/*------------------------------------------------------------------*/
	aOleObject.FusionR$$HEX1$$e900$$ENDHEX$$tablir ()
	aOleObject.FichierMod$$HEX1$$e800$$ENDHEX$$les ( 0, asParam1, 0 )
Case 12
/*------------------------------------------------------------------*/
/* On s$$HEX1$$e900$$ENDHEX$$lectionne le contenu d'un document.                         */
/* (Utilisation dans la gestion des paragraphes.)                   */
/*------------------------------------------------------------------*/
	aOleObject.FichierOuvrir ( asParam1 )
	aOleObject.EditionS$$HEX1$$e900$$ENDHEX$$lectionnerTout ()
	aOleObject.EditionCopier ()

	sCommande = "[FichierFermerTout 2]"
	ExecRemote( sCommande, "WinWord", "System"  )
	Yield ()

//	aOleObject.FichierFermerTout ( 2 )

End Choose

end subroutine

public function integer uf_agrandirword (boolean abAgrandir);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word95::uf_AgrandirWord			(PUBLIC)
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

on n_cst_word95.create
call super::create
end on

on n_cst_word95.destroy
call super::destroy
end on

