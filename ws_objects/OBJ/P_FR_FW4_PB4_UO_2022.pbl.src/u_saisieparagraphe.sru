HA$PBExportHeader$u_saisieparagraphe.sru
$PBExportComments$----} User Object pour la saisie des paragraphes dans Word.
forward
global type u_saisieparagraphe from userobject
end type
type ole_fichier from olecontrol within u_saisieparagraphe
end type
type s_document from structure within u_saisieparagraphe
end type
end forward

type s_document from structure
    string sTempFileName
    boolean bSauvegarde
    boolean bFerme
end type

global type u_saisieparagraphe from userobject
integer width = 293
integer height = 276
boolean border = true
long backcolor = 12632256
event ue_save pbm_custom01
ole_fichier ole_fichier
end type
global u_saisieparagraphe u_saisieparagraphe

type variables
Protected:
//Migration PB8-WYNIWYG-03/2006 FM
//Cette variable est utilis$$HEX1$$e900$$ENDHEX$$e par les descendants de cet objet
//	s_document	istDocument[]
	s_document_pb8	istDocument[]
//Fin Migration PB8-WYNIWYG-03/2006 FM

	Integer		iiDocumentCourant

	String		isModele
	String		isEntete
	String		isRepCourrier
	String		isPrefix

	MultiLineEdit	imleCopie

	OleObject	iOleObject




end variables

forward prototypes
public subroutine uf_activer ()
public function boolean uf_copiertemporaire (integer aidocument, s_glb astglb, string asnomparagraphe)
public subroutine uf_init_bool (integer aidocument)
public function boolean uf_creerparagraphe (integer aidocument, s_glb astglb)
public function boolean uf_documentenregistrer (integer aidocument)
public function boolean uf_documentfermer (integer aidocument)
public function string uf_fichierexiste (s_message astmessage, string asparagraphe)
public function boolean uf_ouvrirparagraphe (integer aidocument, s_glb astglb, string asnomparagraphe)
public function boolean uf_initialiser (s_glb astglb, ref multilineedit amlecopie)
public subroutine uf_clear ()
end prototypes

public subroutine uf_activer ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Activer
//* Auteur			: La recrue
//* Date				: 06/02/1997 15:09:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Active Word s'il est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$ouvert
//* Commentaires	: Aucun
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Ole_Fichier.Activate ( OffSite! )


end subroutine

public function boolean uf_copiertemporaire (integer aidocument, s_glb astglb, string asnomparagraphe);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_CopierTemporaire
//* Auteur			: La recrue
//* Date				: 06/02/1997 15:35:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Copie le fichier temporaire dans le paragraphe.
//* Commentaires	: Lorsque que le paragraphe est copi$$HEX1$$e900$$ENDHEX$$, il est flagu$$HEX1$$e900$$ENDHEX$$.
//*
//* Arguments		: 	aiDocument			Int		(Val)
//*						astGlb				s_Glb		(Val)
//*						asNomParagraphe	String	(Val)
//*
//* Retourne		: True		->	La copie et le flaguage s'est bien pass$$HEX1$$e900$$ENDHEX$$e
//*					  False		-> La copie et le flaguage ne s'est pas bien pass$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------

//u_declarationnetware312	uNet //[I037] Migration FUNCKy : Suppression Composant NetWare

Boolean						bOk

String						sVolMap


bOk = True

//Migration PB8-WYNIWYG-03/2006 FM
//If ( Not f_Copy ( astGlb.uoWin, istDocument[ aiDocument ].sTempFileName , isRepCourrier + asNomParagraphe ) ) Then
If ( FileCopy(istDocument[ aiDocument ].sTempFileName , isRepCourrier + asNomParagraphe ) <> 1 ) Then
//Fin Migration PB8-WYNIWYG-03/2006 FM

	Return ( False )

/*Else //[I037] Migration FUNCKy : Suppression Composant NetWare

	sVolMap = ProfileString( astGlb.sFichierIni, "EDITION", "VOL_MAP", "" )

	If ( sVolMap = "" ) Then

		Return ( False )

	Else

		If ( ProfileString( astGlb.sFichierIni, "EDITION", "FLAG_FILE" , "ON" ) = "ON" ) Then

			uNet		= Create u_declarationnetware312
			sVolMap	= sVolMap + asNomParagraphe
			bOk		= ( uNet.uf_changer_attribut ( sVolMap , 129 ) = 0 )
			Destroy uNet

		End If
			
	End If */

End If

Return ( bOk )
end function

public subroutine uf_init_bool (integer aidocument);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Init_Bool
//* Auteur			: La recrue
//* Date				: 10/02/1997 18:49:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise les variables d'instances Bool$$HEX1$$e900$$ENDHEX$$enne
//* Commentaires	: Aucun
//*
//* Arguments		: aidocument		Int	(Val).
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------


istDocument[ aiDocument ].bSauvegarde	= False
istDocument[ aiDocument ].bFerme			= False
end subroutine

public function boolean uf_creerparagraphe (integer aidocument, s_glb astglb);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_CreerParagraphe
//* Auteur			: La recrue
//* Date				: 05/02/1997 09:12:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouvre un nouveau Paragraphe dans word.
//* Commentaires	:
//*
//* Arguments		: aidocument		Int	(Val)
//*
//* Retourne		: True		->	Si le $$HEX2$$a7002000$$ENDHEX$$est Ouvert
//*					  
//*
//*-----------------------------------------------------------------
Integer		iRet		// Valeur de retour de ConnectToNewObject.

SetPointer ( HourGlass! )

iidocumentCourant = aiDocument

astGlb.uoWin.uf_GetTempFileName ( isPrefix, istdocument[ aiDocument ].sTempFileName )

//*-----------------------------------------------------------------
//* Visualisation du fichier temporaire.
//*-----------------------------------------------------------------
uf_Init_Bool ( aiDocument )

iRet = iOleObject.ConnectToNewObject( "Word.Basic" )
//iRet = iOleObject.ConnectToNewObject( "Word.Application.11" )

/*------------------------------------------------------------------*/
/* Si l'ouverture de Word se passe mal, on invite l'utilisateur $$HEX4$$e000200020002000$$ENDHEX$$*/
/* rebooter son PC.                                                 */
/*------------------------------------------------------------------*/
If iRet = 0 Then

	iOleObject.FichierNouveau ( isRepCourrier + isModele, 0 )

	iOleObject.FichierEnregistrerSous ( istDocument[ aiDocument ].stempFileName )

	SetProfileString( "WIN.INI", "PARAGRAPHE" , "ENTETE", isRepCourrier + isEntete )

	Ole_Fichier.Clear()
	Ole_Fichier.LinkTo ( istDocument[ aiDocument ].sTempFileName )
	
	uf_Activer()

	iOleObject.OutilsMacro( "AffecterEntete", TRUE )
	iOleObject.OutilsMacro( "AfficherOutils", TRUE )

Else

	stMessage.sTitre = "Gestion des paragraphes"
	stMessage.Icon   = Information!
	stMessage.scode  = "PARA012"

	f_Message ( stMessage )

	Return ( False )

End If

Return ( True )
end function

public function boolean uf_documentenregistrer (integer aidocument);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_DocumentEnregistrer
//* Auteur			: La recrue
//* Date				: 06/02/1997 15:09:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Indique si le document est enregistr$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	: Aucun
//*
//* Arguments		: aidocument	Int	(Val)
//*
//* Retourne		: True		->	Si le $$HEX2$$a7002000$$ENDHEX$$est sauvegard$$HEX1$$e900$$ENDHEX$$
//*					  False		-> Si le $$HEX2$$a7002000$$ENDHEX$$n'est pas sauvegard$$HEX1$$e900$$ENDHEX$$
//*
//*-----------------------------------------------------------------

Return ( istdocument[ aiDocument ].bsauvegarde )
end function

public function boolean uf_documentfermer (integer aidocument);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_DocumentFermer
//* Auteur			: La recrue
//* Date				: 06/02/1997 16:09:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Indique si le document est enregistr$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	: Aucun
//*
//* Arguments		: aiDocument		Int		(Val)
//*
//* Retourne		: True		->	Si le $$HEX2$$a7002000$$ENDHEX$$est ferm$$HEX1$$e900$$ENDHEX$$
//*					  False		-> Si le $$HEX2$$a7002000$$ENDHEX$$n'est pas ferm$$HEX1$$e900$$ENDHEX$$
//*
//*-----------------------------------------------------------------

Return ( istdocument[ aiDocument ].bFerme )
end function

public function string uf_fichierexiste (s_message astmessage, string asparagraphe);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_fichierexiste
//* Auteur			:	Y. Picard
//* Date				:	19/02/97 12:25:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Teste si le fichier existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$, dans ce cas augmente le No de
//*					 	version et en avertit l'utilisateur. A la 20 i$$HEX1$$e800$$ENDHEX$$me it$$HEX1$$e900$$ENDHEX$$ration, on 
//*						consid$$HEX1$$e800$$ENDHEX$$re qu'il y a un probl$$HEX1$$e800$$ENDHEX$$me.
//* Commentaires	: 
//*
//* Arguments		: 	astMessage   : Structure de message utilis$$HEX1$$e900$$ENDHEX$$e.
//*						asParagraphe : fichier paragraphe $$HEX2$$e0002000$$ENDHEX$$tester.
//*
//* Retourne		:  Le No de version si OK ; "" sinon.
//*					
//*
//*-----------------------------------------------------------------

Boolean	bProbleme
Boolean	bProgression

String	sVer

Long		lCpt

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le No de version en cours.                           */
/*------------------------------------------------------------------*/
sVer = Right( asParagraphe, 3 )
astMessage.sVar[1]	= asParagraphe

/*------------------------------------------------------------------*/
/* Si le fichier n'existe pas, pas de probl$$HEX1$$e800$$ENDHEX$$me, on pourra cr$$HEX1$$e900$$ENDHEX$$er le  */
/* paragraphe avec le No de version initial.                        */
/* Si le fichier existe, on cherche un No de version "libre" en     */
/* v$$HEX1$$e900$$ENDHEX$$rifiant s'il existe un fichier pour le No suivant.             */
/* A la 20 i$$HEX1$$e800$$ENDHEX$$me tentative, on consid$$HEX1$$e800$$ENDHEX$$re qu'il y a un probl$$HEX1$$e800$$ENDHEX$$me.      */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//Do while FileExists( isRepCourrier + asParaGraphe )
Do while f_FileExists( isRepCourrier + asParaGraphe )
//Fin Migration PB8-WYNIWYG-03/2006 CP


	bProgression = True

	sVer = String( integer( sVer ) + 1 , "000" )
	asParagraphe = Left( asParagraphe , Len ( asParagraphe ) - 3 ) + sVer

	lCpt ++

	If ( lCpt = 20 ) Then

		bProbleme = True
		Exit

	End If

Loop

If ( bProbleme ) Then

	astMessage.sTitre		= "Gestion des paragraphes"
	astMessage.Icon			= StopSign!
	astMessage.sCode		= "PARA009"

	f_Message ( astMessage )
	
	Return ( "" )

End If

If ( bProgression ) Then

	astMessage.sTitre		= "Gestion des paragraphes"
	astMessage.Icon		= StopSign!
	asTmessage.sVar[2]	= isRepCourrier
	asTmessage.sVar[3]	= sVer
	astMessage.sCode		= "PARA010"

	f_Message ( astMessage )

End If

Return ( sVer )
end function

public function boolean uf_ouvrirparagraphe (integer aidocument, s_glb astglb, string asnomparagraphe);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_OuvrirParagraphe
//* Auteur			: La recrue
//* Date				: 05/02/1997 09:12:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouvre le paragraphe en question dans word
//* Commentaires	: Aucun
//*
//* Arguments		: 	aiDocument			Int		(val)
//*						astGlb				s_Glb		(Val)
//*						asNomParagraphe	String	(Val)
//*
//* Retourne		: True		->	L'ouverture s'est bien pass$$HEX1$$e900$$ENDHEX$$e
//*					  False		-> L'ouverture ne s'est pas bien pass$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------
// [MIGPB11] [EMD] : FileCopy avec ecrasement
integer	li_NbFichierCopie
constant boolean	LB_AVEC_ECRASEMENT = True
// [MIGPB11] [EMD] : Fin
Integer		iRet			// Valeur de retour de ConnectToNewobject.

//*-----------------------------------------------------------------
//* V$$HEX1$$e900$$ENDHEX$$rification de l'existance du Paragraphe
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 CP
//If ( Not FileExists ( isRepCourrier + asNomParagraphe ) ) Then
If ( Not f_FileExists ( isRepCourrier + asNomParagraphe ) ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP


	Return ( False )

End If

// [MIGPB11] [EMD] : FileCopy avec ecrasement
// apres la correction du FileCopy avec ecrasement, on abandonne ici systematiquement
// l'ouverture du paragraphe car l'utilisation d'une tres ancienne version de Word, plus bas,
// ne fonctionne pas bien (FichierOuvrir, OutilsMacro)
Return ( False )
// [MIGPB11] [EMD] : Fin

//*-----------------------------------------------------------------
//* Copie du paragraphe dans un fichier temporaire.
//*-----------------------------------------------------------------
astGlb.uoWin.uf_GetTempFileName ( isPrefix, istDocument[ aiDocument ].sTempFileName )

//Migration PB8-WYNIWYG-03/2006 FM
//If ( Not f_Copy ( astGlb.uoWin, isRepCourrier + asNomParagraphe, &
//							istDocument[ aiDocument ].sTempFileName ) ) Then

// [MIGPB11] [EMD] : FileCopy avec ecrasement
/*
If ( FileCopy ( isRepCourrier + asNomParagraphe, &
							istDocument[ aiDocument ].sTempFileName ) <> 1 ) Then	
*/
li_NbFichierCopie = FileCopy (	isRepCourrier + asNomParagraphe, &
								istDocument[ aiDocument ].sTempFileName, &
								LB_AVEC_ECRASEMENT )
								
If ( li_NbFichierCopie <> 1 ) Then
// [MIGPB11] [EMD] : Fin
//Fin Migration PB8-WYNIWYG-03/2006 FM

	Return ( False )

End If

//*-----------------------------------------------------------------
//* Visualisation du fichier temporaire.
//*-----------------------------------------------------------------
iiDocumentCourant = aiDocument

uf_Init_Bool ( aiDocument )

iRet = iOleObject.ConnectToNewObject( "Word.Basic" )

/*------------------------------------------------------------------*/
/* Si l'ouverture de Word se passe mal, on invite l'utilisateur $$HEX4$$e000200020002000$$ENDHEX$$*/
/* rebooter son PC.                                                 */
/*------------------------------------------------------------------*/
If iRet = 0 then

	iOleObject.FichierOuvrir( istDocument[ aiDocument ].stempFileName )

	Ole_Fichier.Clear()
	Ole_Fichier.LinkTo ( istDocument[ aiDocument ].sTempFileName )

	uf_Activer()

	iOleObject.OutilsMacro( "AfficherOutils", TRUE )

Else

	stMessage.sTitre = "Gestion des paragraphes"
	stMessage.Icon   = Information!
	stMessage.scode  = "PARA012"

	f_Message ( stMessage )

	Return ( False )

End If

Return ( True )
end function

public function boolean uf_initialiser (s_glb astglb, ref multilineedit amlecopie);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Initialiser
//* Auteur			: La recrue
//* Date				: 05/02/1997 09:12:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise les variable d'instances.
//* Commentaires	: Aucun
//*
//* Arguments		: 	astGlb			s_Glb				(Val)
//*					  	aMleCopie		multilineedit	(Ref) Mle ou doit apparitre la 
//*					  	visu
//*
//* Retourne		: True		->	Si Les variable sont renseign$$HEX1$$e900$$ENDHEX$$es et
//*											si les fichiers existent
//*					  False		-> Si Non
//*
//*-----------------------------------------------------------------

String		sFichierVar
//Migration PB8-WYNIWYG-03/2006 FM
//s_document	stDocNul[]
s_document_pb8	stDocNul[]
//Fin Migration PB8-WYNIWYG-03/2006 FM
/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$initialise le tableau des documents $$HEX2$$e0002000$$ENDHEX$$NULL.                    */
/*------------------------------------------------------------------*/
istDocument		= stDocNul	

isRepCourrier	= 	ProfileString( astGlb.sFichierIni, "EDITION", "REP_COURRIER", "" )
isModele			= 	ProfileString( astGlb.sFichierIni, "EDITION", "MODELE", "" )
isEntete			= 	ProfileString( astGlb.sFichierIni, "EDITION", "ENTETE", "" )
isPrefix			= 	ProfileString( astGlb.sFichierIni, "EDITION", "PREFIX", "SA" )
sFichierVar		=	ProfileString( astGlb.sFichierIni, "EDITION", "FICHIER_VAR", "" )


//*-----------------------------------------------------------------
//* V$$HEX1$$e900$$ENDHEX$$rification du bon parametrage du .INI de l'application
//*-----------------------------------------------------------------

If ( ( isRepCourrier = "" ) Or ( isModele = "" ) Or ( isEntete = "" ) Or &
	  ( sfichierVar = "" ) ) Then

	Return ( False ) 

End If

//*-----------------------------------------------------------------
//* V$$HEX1$$e900$$ENDHEX$$rification de l'existance des Fichiers
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 CP
//If ( Not FileExists ( isRepCourrier + isModele ) ) Then
If ( Not f_FileExists ( isRepCourrier + isModele ) ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP
	
	Return ( False )

End If

//Migration PB8-WYNIWYG-03/2006 CP
//If ( Not FileExists ( isRepCourrier + isEntete ) ) Then
If ( Not f_FileExists ( isRepCourrier + isEntete ) ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP
	
	Return ( False )

End If

SetProfileString ( "WIN.INI" , "PARAGRAPHE" , "FICHIER_VAR" , sfichierVar )

iMleCopie = aMleCopie

Return ( True )
end function

public subroutine uf_clear ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_clear
//* Auteur			:	La Recrue
//* Date				:	11/04/1997 11:05:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Nettoye les liens avec Word
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

iOleObject.DisconnectObject()
Ole_Fichier.Clear()

end subroutine

on destructor;//*-----------------------------------------------------------------
//*
//* Objet 			: u_si_paragraphe
//* Evenement 		: Destructor - Extend
//* Auteur			: La recrue
//* Date				: 05/01/1997 14:48:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Destruction de l'objet Ole
//*					  
//* Commentaires	: Destruction des instances 
//*				     
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Destroy iOleObject
end on

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: u_si_paragraphe
//* Evenement 		: Open - Extend
//* Auteur			: La recrue
//* Date				: 05/01/1997 08:32:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation des variables d'instance
//*					  
//* Commentaires	: Aucun
//*				     
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iOleObject		= Create OleObject
end on

on u_saisieparagraphe.create
this.ole_fichier=create ole_fichier
this.Control[]={this.ole_fichier}
end on

on u_saisieparagraphe.destroy
destroy(this.ole_fichier)
end on

type ole_fichier from olecontrol within u_saisieparagraphe
boolean visible = false
integer x = 5
integer width = 224
integer height = 212
integer taborder = 1
boolean border = false
boolean focusrectangle = false
string binarykey = "u_saisieparagraphe.udo"
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
omlinkupdateoptions linkupdateoptions = linkupdatemanual!
end type

on close;//*-----------------------------------------------------------------
//*
//* Objet 			: ole_fichier
//* Evenement 		: Close - Extend
//* Auteur			: La recrue
//* Date				: 06/01/1997 16:04:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Est d$$HEX1$$e900$$ENDHEX$$clancher par word quand l'utilisateur
//*					  Ferme le fichier en question
//*
//* Commentaires	: Notification du faite que le $$HEX2$$a7002000$$ENDHEX$$soit ferm$$HEX1$$e900$$ENDHEX$$
//*				     
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istDocument[ iiDocumentCourant ].bFerme = True
end on

on save;//*-----------------------------------------------------------------
//*
//* Objet 			: ole_fichier
//* Evenement 		: Save - Extend
//* Auteur			: La recrue
//* Date				: 05/01/1997 14:48:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Est d$$HEX1$$e900$$ENDHEX$$clancher par word quand l'utilisateur
//*					  sauvegarde le fichier en question
//*
//* Commentaires	: Notification du faite que le $$HEX2$$a7002000$$ENDHEX$$soit sauvegard$$HEX1$$e900$$ENDHEX$$
//*				     
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istDocument[ iiDocumentCourant ].bSauvegarde = TRUE

If IsValid ( iMleCopie ) Then

	iMleCopie.Text = ""
	iMleCopie.Paste()

End If
end on


Start of PowerBuilder Binary Data Section : Do NOT Edit
04u_saisieparagraphe.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14u_saisieparagraphe.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
