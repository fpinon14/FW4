HA$PBExportHeader$u_spb_cp_2000.sru
$PBExportComments$User Object Visuel : Gestion courriers particuliers office 2000 ( Attention dupliqu$$HEX2$$e9002000$$ENDHEX$$sur SAVANE )
forward
global type u_spb_cp_2000 from userobject
end type
type ole_fichier from olecontrol within u_spb_cp_2000
end type
type pb_eff_part from picturebutton within u_spb_cp_2000
end type
type pb_eff_ps from picturebutton within u_spb_cp_2000
end type
type pb_eff_pce from picturebutton within u_spb_cp_2000
end type
type pb_part from picturebutton within u_spb_cp_2000
end type
type pb_ps from picturebutton within u_spb_cp_2000
end type
type pb_pce from picturebutton within u_spb_cp_2000
end type
type gb_part from groupbox within u_spb_cp_2000
end type
end forward

global type u_spb_cp_2000 from userobject
integer width = 489
integer height = 580
long backcolor = 12632256
event ue_piece_saisir pbm_custom01
event ue_piece_effacer pbm_custom02
event ue_piece_sauver pbm_custom03
event ue_piece_select pbm_custom04
event ue_post_saisir pbm_custom05
event ue_post_effacer pbm_custom06
event ue_post_sauver pbm_custom07
event ue_post_select pbm_custom08
event ue_part_saisir pbm_custom09
event ue_part_effacer pbm_custom10
event ue_part_sauver pbm_custom11
event ue_part_select pbm_custom12
event ue_erreur pbm_custom13
ole_fichier ole_fichier
pb_eff_part pb_eff_part
pb_eff_ps pb_eff_ps
pb_eff_pce pb_eff_pce
pb_part pb_part
pb_ps pb_ps
pb_pce pb_pce
gb_part gb_part
end type
global u_spb_cp_2000 u_spb_cp_2000

type variables
Protected :
	Blob		iblDoc		// ... Blob de travail


Private :
	OleObject	iOleObject
	PictureButton	iPb[3]		// ... R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences aux 3 boutons
	u_DataWindow	idw_1		// ... R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence $$HEX2$$e0002000$$ENDHEX$$la dw
	U_DeclarationWindows	invWin    // ... R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence aux fonctions de windows
	String		isModele
	String		isRepCour


	Integer		iiElt = 0		// ... N$$HEX3$$b0002000e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment actif
	String		isRepTemp

	String		isDoc[3]		// ... Noms des documents
	String		isPara[3]		// ... Paragraphes $$HEX2$$e0002000$$ENDHEX$$ins$$HEX1$$e900$$ENDHEX$$rer si nouveau document
	String		isCol[3]		// ... Noms des colonnes ALT
	String		isBmpP[3]	// ... Noms des bitmaps docs pr$$HEX1$$e900$$ENDHEX$$sents
	String		isBmpV[3]	// ... Noms des bitmaps docs absents 

	Date		idK_DATECREATION = Date ( "01/01/2000" )
	Time		itK_TIMECREATION = Time ( "23:59:00" )
	Boolean		ibEncours = False	// ... Flag pour les nouveaux documents

end variables

forward prototypes
public function boolean uf_deconnecter ()
protected subroutine uf_init_bmp (string asbmpp[], string asbmpv[])
public subroutine uf_init_cp (string ascol[], ref datawindow adw_1)
public subroutine uf_init_inter (string asdoc[])
private function boolean uf_effacer_doc (integer aielt)
private function boolean uf_saisir_doc (integer aielt)
private function boolean uf_sauver_doc (integer aielt)
public subroutine uf_init_para (string asPara[])
public function boolean uf_tester_doc (integer aielt)
public subroutine uf_changermodele (string asmodele)
end prototypes

on ue_piece_saisir;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Spb_Cp::Ue_Piece_Saisir
//* Evenement 		: Ue_Piece_Saisir
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 17:25:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut saisir une AUTRE PIECE
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uf_Saisir_Doc ( 1 )
end on

on ue_piece_effacer;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Spb_Cp::Ue_Piece_Effacer
//* Evenement 		: Ue_Piece_Effacer
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 17:25:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut effacer une AUTRE PIECE
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uf_Effacer_Doc ( 1 )
end on

on ue_piece_sauver;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Spb_Cp::Ue_Piece_Sauver
//* Evenement 		: Ue_Piece_Sauver
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 17:25:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut sauver une AUTRE PIECE
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uf_Sauver_Doc ( 1 )
end on

on ue_post_saisir;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Spb_Cp::Ue_Post_Saisir
//* Evenement 		: Ue_Post_Saisir
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 17:25:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut saisir un POST-SCRIPTUM
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uf_Saisir_Doc ( 2 )
end on

on ue_post_effacer;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Spb_Cp::Ue_Post_Effacer
//* Evenement 		: Ue_Post_Effacer
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 17:25:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut effacer un POST-SCRIPTUM
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uf_Effacer_Doc ( 2 )
end on

on ue_post_sauver;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Spb_Cp::Ue_Post_Sauver
//* Evenement 		: Ue_Post_Sauver
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 17:25:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut sauver un POST-SCRIPTUM
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uf_Sauver_Doc ( 2 )
end on

on ue_part_saisir;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Spb_Cp::Ue_Part_Saisir
//* Evenement 		: Ue_Part_Saisir
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 17:25:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut saisir un COURRIER PARTICULIER
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uf_Saisir_Doc ( 3 )
end on

on ue_part_effacer;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Spb_Cp::Ue_Part_Effacer
//* Evenement 		: Ue_Part_Effacer
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 17:25:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut effacer un COURRIER PARTICULIER
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uf_Effacer_Doc ( 3 )
end on

on ue_part_sauver;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Spb_Cp::Ue_Part_Sauver
//* Evenement 		: Ue_Part_Sauver
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 17:25:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut sauver un COURRIER PARTICULIER
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uf_Sauver_Doc ( 3 )
end on

on ue_erreur;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Spb_Cp::Ue_Erreur 
//* Evenement 		: Ue_Erreur
//* Auteur			: Erick John Stark
//* Date				: 23/06/1998 16:19:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Centralisation des messages d'erreurs
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lErr

lErr = Message.LongParm

stMessage.sTitre		= "Gestion des courriers particuliers"
stMessage.Icon			= Information!
stMessage.bErreurG	= TRUE
stMessage.bTrace		= TRUE
stMessage.sCode		= "CPART0" + String ( lErr )

/*------------------------------------------------------------------*/
/* Les variables sont arm$$HEX1$$e900$$ENDHEX$$es sur les fonctions Uf_Saisir_Doc et     */
/* Uf_Effacer_Doc du UserObjet.                                     */
/*------------------------------------------------------------------*/

f_Message ( stMessage )
end on

public function boolean uf_deconnecter ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Spb_Cp::Uf_Deconnecter (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 23/06/1998 10:15:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On nettoie les liens avec Word. On d$$HEX1$$e900$$ENDHEX$$truit l'objet OLE
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------

N_Cst_Word	nvWord

If	IsValid ( iOleObject )	Then
	F_SetVersionWord ( nvWord, TRUE )

	iOleObject.DisconnectObject ()
	Ole_Fichier.Clear ()

	Destroy iOleObject

//	Mise en commentaire pose des pb lig 30 uf_fermer_word
//	nvWord.uf_FermerWord ()
	F_SetVersionWord ( nvWord, FALSE )
End If

Return ( True )




end function

protected subroutine uf_init_bmp (string asbmpp[], string asbmpv[]);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Spb_Cp::Uf_Init_Bmp (PROTECTED)
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 16:46:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String			asBmpV				(Val)	Tableau pour le nom des Bmp
//*					  String			asBmpP				(Val)	Tableau pour le nom des Bmp
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

isBmpV = asBmpV
isBmpP = asBmpP


end subroutine

public subroutine uf_init_cp (string ascol[], ref datawindow adw_1);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Spb_Cp::Uf_Init_Cp (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 17:33:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de l'objet pour la saisir
//*
//* Arguments		: String				asCol[]			(Val)	Tableau correspondant aux noms des colonnes
//*					  U_DataWindow		adw_1				(R$$HEX1$$e900$$ENDHEX$$f) DataWindow contenant logiquement 1 seule ligne
//*
//* Retourne		: Long			 1 = L'adh$$HEX1$$e900$$ENDHEX$$sion existe
//*										-1 = L'adh$$HEX1$$e900$$ENDHEX$$sion n'existe pas
//*
//*-----------------------------------------------------------------

isCol = asCol	// ... Colonnes ALT correspondant aux documents

idw_1 = adw_1	// ... Datawindow des colonnes ALT

invWin = stGLB.uoWin  // ... Objet avec les fonctions windows pour gestion des dates + heures de fichiers


end subroutine

public subroutine uf_init_inter (string asdoc[]);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Spb_Cp::Uf_Init_Inter (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 17:40:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des boutons pour un interlocuteur
//*
//* Arguments		: String			asDoc[]				(Val)	Tableau correspondant 
//*																au noms des documents
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String  sAlt
Integer i, iTot

// .... M$$HEX1$$e900$$ENDHEX$$morisation des variables d'instance

isDoc = asDoc

// .... Initialisation des bitmaps

iTot = UpperBound ( iPb )

For i = 1 To iTot

	sAlt = idw_1.GetItemString ( 1, isCol[ i ] )

	Choose Case sAlt

	Case "O", "C"		// .... Existant, Cr$$HEX1$$e900$$ENDHEX$$ation

		iPb[ i ].PictureName  = isBmpP [ i ]
		iPb[ i ].DisabledName = isBmpP [ i ]

	Case "N", "E"		// .... Non existant, Effac$$HEX1$$e900$$ENDHEX$$

		iPb[ i ].PictureName  = isBmpV [ i ]
		iPb[ i ].DisabledName = isBmpV [ i ]

	End Choose

Next
end subroutine

private function boolean uf_effacer_doc (integer aielt);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Spb_Cp::Uf_Effacer_Doc (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 23/06/1998 09:21:53
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On supprime le document demand$$HEX2$$e9002000$$ENDHEX$$sur le disque.
//*
//* Arguments		: Integer		aiElt				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment $$HEX2$$e0002000$$ENDHEX$$traiter
//*
//* Retourne		: Boolean		 True 	= La suppression se passe bien
//*										 False	= Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

Boolean  bOk = True
String	sNomDoc

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nom du document $$HEX2$$e0002000$$ENDHEX$$supprimer. Le nom du document   */
/* est arm$$HEX2$$e9002000$$ENDHEX$$sur Uf_Init_Inter.                                      */
/*------------------------------------------------------------------*/
sNomDoc = isRepTemp + isdoc[ aiElt ]

// ... #1 D$$HEX1$$e900$$ENDHEX$$but de modification

bOk = Uf_Tester_Doc ( aiElt ) // ... On v$$HEX1$$e900$$ENDHEX$$rifie si le fichier est en prise sous word

If Not bOk Then Return False

// ... #1 Fin de modification

/*------------------------------------------------------------------*/
/* On supprime le fichier.                                          */
/*------------------------------------------------------------------*/


//Migration PB8-WYNIWYG-03/2006 CP
//If	FileExists ( sNomDoc )	Then
If	f_FileExists ( sNomDoc )	Then
//Fin Migration PB8-WYNIWYG-03/2006 CP	
	
	bOk = FileDelete ( sNomDoc )
End If

If	bOk	Then
/*------------------------------------------------------------------*/
/* On affecte le Bitmap Vide.                                       */
/*------------------------------------------------------------------*/
	iPb[ aiElt ].PicTureName  = isBmpV[ aiElt ]
	iPb[ aiElt ].DisabledName = isBmpV[ aiElt ]

/*------------------------------------------------------------------*/
/* On affecte la colonne ALT.                                       */
/*------------------------------------------------------------------*/
	If	idw_1.GetItemString ( 1, isCol[ aiElt ] ) = "O"	Then
		idw_1.SetItem ( 1, isCol[ aiElt ], "E" )
	End If
Else
/*------------------------------------------------------------------*/
/* Il y a un probl$$HEX1$$e800$$ENDHEX$$me, on ne fait rien. (Pas de mise $$HEX2$$e0002000$$ENDHEX$$jour Bitmap  */
/* ou colonnes). On g$$HEX1$$e900$$ENDHEX$$re simplement l'erreur.                       */
/*------------------------------------------------------------------*/
	stMessage.sVar[1] 	= sNomDoc
	This.TriggerEvent ( "Ue_Erreur", 0, 4 )
End If

Return ( bOk )
end function

private function boolean uf_saisir_doc (integer aielt);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Spb_Cp::Uf_Ouvrir_Doc (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 23/06/1998 09:33:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Permet la saisie d'un document.
//*
//* Arguments		: Integer		aiElt				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment $$HEX2$$e0002000$$ENDHEX$$traiter
//*
//* Retourne		: Boolean		 True 	= La saisie se passe bien
//*										 False	= Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ 			PAR		Date		Modification
//* DCMP990453	JFF	29/09/99 Ajout insertion auto formule politesse
//*									et coupon r$$HEX1$$e900$$ENDHEX$$ponse sur CP.
//* #2 O.2000 FS     22/05/01 Apr$$HEX1$$e800$$ENDHEX$$s ecriture du fichier on le positionne
//*                           Avec une date de cr$$HEX1$$e900$$ENDHEX$$ation sp$$HEX1$$e900$$ENDHEX$$cifique
//* #3 O.2000 FS     14/06/01 Si alt = 'N' + fichier existe on consid$$HEX1$$e800$$ENDHEX$$re que 
//*                           alt devrait $$HEX1$$ea00$$ENDHEX$$tre ="O" ( cas ou on reclique sur
//*                           un bouton sans avoir fait contr$$HEX1$$f400$$ENDHEX$$le )
//*-----------------------------------------------------------------

Boolean  bOk = True
Long     lErr	
Int		iCpt, iNbrPara, iRet
String	sNomDoc, sAlt, sPara = ""
String 	sNomTmp
String	sEvt[] = { "ue_piece_select", "ue_post_select", "ue_part_select" }

N_Cst_Word	nvWord
//U_DeclarationFuncky	uFuncky //[I037] Migration Fucky

SetPointer ( HourGlass! )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nom du document $$HEX2$$e0002000$$ENDHEX$$saisir. Le nom du document      */
/* est arm$$HEX2$$e9002000$$ENDHEX$$sur Uf_Init_Inter.                                      */
/*------------------------------------------------------------------*/
sNomDoc = isRepTemp + isDoc[ aiElt ]
sNomTmp = isRepTemp + "X.TMP"

/*------------------------------------------------------------------*/
/* Le document existe, mais il n'a jamais $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$lu. (Donc $$HEX1$$e900$$ENDHEX$$crit sur   */
/* le disque).                                                      */
/*------------------------------------------------------------------*/
sAlt = idw_1.GetItemString ( 1, isCol[ aiElt ] )

/*------------------------------------------------------------------*/
/* Si la zone ALT est $$HEX2$$e0002000$$ENDHEX$$Non, on supprime le fichier dans tous les   */
/* cas. (Le gestionnaire, apr$$HEX1$$e900$$ENDHEX$$s avoir enregistr$$HEX2$$e9002000$$ENDHEX$$un document sous   */
/* WORD, clique sur ABANDON).                                       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Le fichier peut tr$$HEX1$$e900$$ENDHEX$$s bien ne pas exister.                        */
/*------------------------------------------------------------------*/

// ... #3 : D$$HEX1$$e900$$ENDHEX$$but de modification
//          Si le flag = 'N' et que le fichier existe on consid$$HEX1$$e800$$ENDHEX$$re que
//          le flag devrait $$HEX1$$ea00$$ENDHEX$$tre $$HEX2$$e0002000$$ENDHEX$$'O'


//Migration PB8-WYNIWYG-03/2006 CP
//If sAlt = "N" And FileExists ( sNomDoc ) Then
If sAlt = "N" And f_FileExists ( sNomDoc ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP


   sAlt = "O"
   uf_sauver_doc ( aiElt )

End If

// ... #3 fin de modification

If	sAlt = "N"	Then	FileDelete ( sNomDoc )


//Migration PB8-WYNIWYG-03/2006 CP
//If	sAlt = "O"	And Not FileExists ( sNomDoc )	Then
If	sAlt = "O"	And Not f_FileExists ( sNomDoc )	Then
//Fin Migration PB8-WYNIWYG-03/2006 CP	
	
	SetNull ( iblDoc )
/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$clenche un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement client pour r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le blob.         */
/*------------------------------------------------------------------*/
	This.TriggerEvent ( sEvt[ aiElt ] )
	
	If	Not IsNull ( iblDoc )	Then
		bOk = F_EcrireFichierBlob ( iblDoc, sNomDoc )
		If	Not bOk	Then 
			lErr 						= 1
			stMessage.sVar[1] 	= sNomDoc
		End If

		invWin.uf_SetLastWriteDateTime ( sNomDoc, idK_DATECREATION, itK_TIMECREATION )  // ... #2

	Else
		bOk			= False
		lErr			= 2
		Choose Case aiElt
		Case 1
			stMessage.sVar[1] 	= "paragraphe AUTRE PIECE"
		Case 2
			stMessage.sVar[1] 	= "paragraphe POST SCRIPTUM"
		Case 3
			stMessage.sVar[1] 	= "courrier particulier"
		End Choose

		stMessage.sVar[2] 	= sNomDoc
	End If
End If

/*------------------------------------------------------------------*/
/* Si tout se passe bien, on va cr$$HEX2$$e900e900$$ENDHEX$$r un objet OLE et initialiser   */
/* la communication.                                                */
/*------------------------------------------------------------------*/
F_SetVersionWord ( nvWord, TRUE )
If	bOk	Then
	If	Not IsValid ( iOleObject )	Then
		iOleObject = Create OleObject
	End If

//	bOk = ( iOleObject.ConnectToNewObject ( "Word.Basic" ) = 0 )
	bOk = ( nvWord.uf_CreerOleObject_Word ( iOleObject ) = 0 )
	If	Not bOk	Then lErr = 3
End If

If	Not bOk	Then
	This.TriggerEvent ( "Ue_Erreur", 0, lErr )
	Uf_Deconnecter ()
	F_SetVersionWord ( nvWord, FALSE )
	Return ( bOk )
Else
/*------------------------------------------------------------------*/
/* On ouvre le fichier existant.                                    */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP	
//	If	FileExists ( sNomDoc )	Then
	If	f_FileExists ( sNomDoc )	Then
//Fin Migration PB8-WYNIWYG-03/2006 CP		
		
		nvWord.uf_CommandeWord ( 3, sNomDoc, iOleObject )		
//		iOleObject.FichierOuvrir ( sNomDoc )
/*------------------------------------------------------------------*/
/* On cr$$HEX3$$e900e9002000$$ENDHEX$$un nouveau fichier.                                      */
/*------------------------------------------------------------------*/
	Else
		nvWord.uf_CommandeWord ( 1, isModele, iOleObject )
//		iOleObject.FichierNouveau ( isModele, 0 )

/*------------------------------------------------------------------*/
/* Modification DBI le 17/11/1998                                   */
/* Insertion Conditionnelle d'un paragraphe d'ent$$HEX1$$ea00$$ENDHEX$$te                */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DCMP990453 : Ajout insertion auto formule politesse et coupon    */
/*              r$$HEX1$$e900$$ENDHEX$$ponse sur CP.												  */
/*------------------------------------------------------------------*/

		If isPara [aiElt] <> "" Then
 
			iNbrPara = ( Len ( isPara [ aiElt ] ) / 8 ) - 1

			For iCpt = 0 to iNbrPara

				sPara = isRepCour + Mid ( isPara [ aiElt ], iCpt * 8 + 1, 8 )
				nvWord.uf_CommandeWord ( 7, sPara, iOleObject )
//				iOleObject.InsertionFichier ( sPara )

			Next

		End If

      //-----------------------------------------------------------------------------------------------------------
		// ... #2 : Explications 
      //          Pour d$$HEX1$$e900$$ENDHEX$$tecter la modification des fichiers on utilise le losefocus de chacun des 3 boutons
		//          au lieu de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement "save" de l'objet ole ( ne fonctionne pas sous word 2000 )
      //          voir fonction uf_tester_doc qui sur losefocus v$$HEX1$$e900$$ENDHEX$$rifie la date du fichier
      //          Lors de la cr$$HEX1$$e900$$ENDHEX$$ation d'un nouveau fichier on utilise d'abord un nom temporaire 
      //          car sinon entre la cr$$HEX1$$e900$$ENDHEX$$ation et l'enregistrer sous : le lose focus d$$HEX1$$e900$$ENDHEX$$tecterai un fichier modifi$$HEX1$$e900$$ENDHEX$$
		//          ( lose focus provoqu$$HEX2$$e9002000$$ENDHEX$$par l'envoi du focus sur word alors que le fichier n'est pas redat$$HEX2$$e9002000$$ENDHEX$$)
      //-----------------------------------------------------------------------------------------------------------

//		uFuncky = Create U_DeclarationFuncky

		FileDelete ( sNomTmp )																			// ... #2 Avant toute chose on s'assure que la place est propre !

		nvWord.uf_CommandeWord ( 8, sNomTmp , iOleObject )										// ... #2 Enregistrer Sous "nom temporaire"
//		iOleObject.FichierEnregistrerSous ( sNomTmp )
	
		nvWord.uf_CommandeWord ( 10, sNomTmp, iOleObject )										// ... #2 : On ferme "le fichier temporaire"
		invWin.uf_SetLastWriteDateTime ( sNomTmp, idK_DATECREATION, itK_TIMECREATION )// ... #2 : On redate "le fichier temporaire"
//      uFuncky.uf_fRename ( sNomTmp, sNomDoc )													// ... #2 : On renome "le fichier temporaire" 
     	invWin.uf_fRename ( sNomTmp, sNomDoc )													// ... #2 : On renome "le fichier temporaire" 
		nvWord.uf_CommandeWord ( 3 , sNomDoc, iOleObject )										// ... #2 : On ouvre le fichier d$$HEX1$$e900$$ENDHEX$$finitif

//Migration PB8-WYNIWYG-03/2006 FM
//		Destroy uFuncky
//		If IsValid(uFuncky) Then Destroy uFuncky
//Fin Migration PB8-WYNIWYG-03/2006 FM

	End If
End If


iRet = Ole_Fichier.Clear ()
iRet = Ole_Fichier.LinkTo   ( sNomDoc  )
iRet = Ole_Fichier.Activate ( OffSite! )

iiElt = aielt								// ... Voir Evt Save de OLE_FICHIER

F_SetVersionWord ( nvWord, FALSE )

Return ( True )
end function

private function boolean uf_sauver_doc (integer aielt);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Spb_Cp::Uf_Sauver_Doc
//* Auteur			: Erick John Stark
//* Date				: 23/06/1998 10:27:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Sauvegarde du document
//*
//* Arguments		: Integer		aiElt				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment $$HEX2$$e0002000$$ENDHEX$$traiter
//*
//* Retourne		: Boolean		 True 	= La sauvegarde se passe bien
//*										 False	= Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* On affecte le Bitmap Plein.                                      */
/*------------------------------------------------------------------*/

iPb[ aiElt ].PicTureName  = isBmpP[ aiElt ]
iPb[ aiElt ].DisabledName = isBmpP[ aiElt ]

/*------------------------------------------------------------------*/
/* On positionne la colonne ALT correspondante.                     */
/*------------------------------------------------------------------*/
idw_1.SetItem ( 1, isCol[ aiElt ], "O" )

Return True
end function

public subroutine uf_init_para (string asPara[]);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Spb_Cp::Uf_Init_Para (PUBLIC)
//* Auteur			: DBI
//* Date				: 17/11/1998 17:40:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des paragraphes par d$$HEX1$$e900$$ENDHEX$$faut si nouveau doc
//*
//* Arguments		: String			asPara[]				(Val)	Tableau correspondant 
//*																au noms des paragraphes
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

isPara [1]	= asPara[1]
isPara [2]	= asPara[2]
isPara [3]	= asPara[3]

end subroutine

public function boolean uf_tester_doc (integer aielt);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Spb_Cp_2000::Uf_Tester_Doc (PUBLIC)
//* Auteur			: FS
//* Date				: 22/05/2001
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Teste si les fichiers ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$modifi$$HEX1$$e900$$ENDHEX$$s
//*                 Si oui on provoque uf_sauver ( x ) qui n'est plus d$$HEX1$$e900$$ENDHEX$$clench$$HEX1$$e900$$ENDHEX$$
//*                 par l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement "SAVE" de l'objet OLE avec Word 2000
//*
//* Arguments		: aiElt integer N$$HEX2$$b0002000$$ENDHEX$$de l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment $$HEX2$$e0002000$$ENDHEX$$tester
//*                               0 : Tester tous les $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments
//*                               n : Tester l'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ment n
//*
//* Retourne		: Boolean False si un des document est encore ouvert
//*
//*-----------------------------------------------------------------

integer  i, iRet
Integer  iDeb, iFin
String	sNomDoc
String   sType[] = { "Autre pi$$HEX1$$e800$$ENDHEX$$ce"    ,"Post-scriptum"  , "Cr particulier" }
String	sEvt[]  = { "ue_piece_sauver", "ue_post_sauver", "ue_part_sauver" }
Date     dDate
Time     tHeure
Boolean  bPrise = False
N_Cst_Word	nvWord
unsignedlong    iulHandle

If aiElt = 0 Then
   iDeb = 1
   iFin = UpperBound ( isDoc )
Else
   iDeb = aiElt
   iFin = aiElt
End If

For i = iDeb To iFin

	sNomDoc = isRepTemp + isdoc[ i ]								// ... Nom du fichier $$HEX2$$e0002000$$ENDHEX$$tester


//Migration PB8-WYNIWYG-03/2006 CP	
//	If FileExists ( sNomDoc ) 	Then 
	If f_FileExists ( sNomDoc ) 	Then 
//Fin Migration PB8-WYNIWYG-03/2006 CP


		F_SetVersionWord ( nvWord, true )

		iulHandle = nvWord.uf_WordOuvert ()

      If iulHandle > 0 Then      

			iRet = nvWord.uf_fichierOuvertDansWord ( ioleobject, True, False )

		   If iRet = -2 Then bPrise = True

      End If

		F_SetVersionWord ( nvWord, true )


		// ... Le fichier est en prise : Erreur c'est $$HEX2$$e0002000$$ENDHEX$$l'utilisateur de le fermer

         IF bPrise Then	 Return False						
     
		// ... Le fichier n'est pas en prise : A t-il $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$modifi$$HEX2$$e9002000$$ENDHEX$$sur le disque ?

		If F_FichierModifie( sNomDoc )	Then 						// ... Le fichier est-il pr$$HEX1$$e900$$ENDHEX$$sent sur le disque ET modifi$$HEX2$$e9002000$$ENDHEX$$?

			This.TriggerEvent ( sEvt[ i ] )
	
		Else																	// ... Suppression du fichier marqu$$HEX4$$e9002000e0002000$$ENDHEX$$01/01/2000 23:59:00 car non modifi$$HEX1$$e900$$ENDHEX$$

			FileDelete( sNomDoc )

		End If

	End If


Next


Return ( True)
end function

public subroutine uf_changermodele (string asmodele);//*-----------------------------------------------------------------
//*
//* Fonction      : u_spb_cp_2000::uf_ChangerModele (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 15/01/2004 15:39:27
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Changer dynamiquement le mod$$HEX1$$e800$$ENDHEX$$le apr$$HEX1$$e800$$ENDHEX$$s qu'il ait
//*					  $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$affect$$HEX2$$e9002000$$ENDHEX$$dans l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement Constructor
//* Commentaires  : 
//*
//* Arguments     : String		asModele			Val     // Nouveau mod$$HEX1$$e800$$ENDHEX$$le $$HEX2$$e0002000$$ENDHEX$$appliquer
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
isModele = isRepCour + asModele

end subroutine

event constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Spb_Cp::Constructor
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 17:00:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des variables d'instance
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date					Modification
//* #1 DGA     19/09/2006        Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire DCMP-060643
//*-----------------------------------------------------------------

//u_DeclarationFuncky uoDeclarationFuncky

/*------------------------------------------------------------------*/
/* On recup$$HEX1$$e900$$ENDHEX$$re le nom du mod$$HEX1$$e900$$ENDHEX$$le.                                    */
/*------------------------------------------------------------------*/
isRepCour  = ProfileString ( stGlb.sFichierIni, "EDITION", "REP_COURRIER", "" )
isModele   = isRepCour + ProfileString ( stGlb.sFichierIni, "EDITION", "MODELE", "" )

/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On initialise le r$$HEX1$$e900$$ENDHEX$$pertoire de travail de Windows.               */
/*------------------------------------------------------------------*/
//uoDeclarationFuncky	= Create u_DeclarationFuncky
isRepTemp 				= stGLB.sRepTempo
//Destroy uoDeclarationFuncky

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence les Pictures Boutons.                               */
/*------------------------------------------------------------------*/
iPb[1]	= pb_Pce
iPb[2]	= pb_Ps
iPb[3]	= pb_Part

/*------------------------------------------------------------------*/
/* On initialise les Bitmaps par d$$HEX1$$e900$$ENDHEX$$faut.                            */
/*------------------------------------------------------------------*/
isBmpV[1] = "K:\PB4OBJ\BMP\8_AUPCE.BMP"
isBmpV[2] = "K:\PB4OBJ\BMP\8_CPOST.BMP"
isBmpV[3] = "K:\PB4OBJ\BMP\8_CPART.BMP"

isBmpP[1] = "K:\PB4OBJ\BMP\8_AUPCE2.BMP"
isBmpP[2] = "K:\PB4OBJ\BMP\8_CPOST2.BMP"
isBmpP[3] = "K:\PB4OBJ\BMP\8_CPART2.BMP"
end event

on u_spb_cp_2000.create
this.ole_fichier=create ole_fichier
this.pb_eff_part=create pb_eff_part
this.pb_eff_ps=create pb_eff_ps
this.pb_eff_pce=create pb_eff_pce
this.pb_part=create pb_part
this.pb_ps=create pb_ps
this.pb_pce=create pb_pce
this.gb_part=create gb_part
this.Control[]={this.ole_fichier,&
this.pb_eff_part,&
this.pb_eff_ps,&
this.pb_eff_pce,&
this.pb_part,&
this.pb_ps,&
this.pb_pce,&
this.gb_part}
end on

on u_spb_cp_2000.destroy
destroy(this.ole_fichier)
destroy(this.pb_eff_part)
destroy(this.pb_eff_ps)
destroy(this.pb_eff_pce)
destroy(this.pb_part)
destroy(this.pb_ps)
destroy(this.pb_pce)
destroy(this.gb_part)
end on

type ole_fichier from olecontrol within u_spb_cp_2000
boolean visible = false
integer x = 539
integer y = 40
integer width = 169
integer height = 220
integer taborder = 50
long backcolor = 12632256
boolean focusrectangle = false
string binarykey = "u_spb_cp_2000.udo"
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
omlinkupdateoptions linkupdateoptions = linkupdatemanual!
end type

type pb_eff_part from picturebutton within u_spb_cp_2000
integer x = 302
integer y = 416
integer width = 137
integer height = 120
integer taborder = 70
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\psclear.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Pb_Eff_Part::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 16:38:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut effacer le courrier particulier
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.TriggerEvent ( "Ue_Part_Effacer" )
end on

type pb_eff_ps from picturebutton within u_spb_cp_2000
integer x = 302
integer y = 252
integer width = 137
integer height = 120
integer taborder = 40
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\psclear.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Pb_Eff_Ps::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 16:38:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut effacer le Post-scriptum
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.TriggerEvent ( "Ue_Post_Effacer" )
end on

type pb_eff_pce from picturebutton within u_spb_cp_2000
integer x = 302
integer y = 88
integer width = 137
integer height = 120
integer taborder = 20
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\psclear.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Pb_Eff_Pce::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 16:38:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut effacer le paragraphe de PIECE
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.TriggerEvent ( "Ue_Piece_Effacer" )
end on

type pb_part from picturebutton within u_spb_cp_2000
integer x = 37
integer y = 400
integer width = 233
integer height = 136
integer taborder = 60
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cour.Part"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_cpart.bmp"
string disabledname = "k:\pb4obj\bmp\8_cpart2.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Pb_Part::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 16:38:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut saisir un courrier particulier
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sAltPce, sAltPs

Boolean bMess

bMess = True

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si la personne peut saisir le paragraphe COURRIER     */
/* PARTICULIER.                                                     */
/*------------------------------------------------------------------*/
sAltPce	= idw_1.GetItemString ( 1, isCol[1] )
sAltPs	= idw_1.GetItemString ( 1, isCol[2] )

If			sAltPce = "O"	And sAltPs = "O" Then
			stMessage.sVar[1] = "une AUTRE PIECE et un POST-SCRIPTUM"
ElseIf	sAltPce = "O"	Then
			stMessage.sVar[1] = "une AUTRE PIECE"
ElseIf	sAltPs = "O"	Then
			stMessage.sVar[1] = "un POST-SCRIPTUM"
Else
			bMess = False
			Parent.TriggerEvent ( "Ue_Part_Saisir" )
End If

If	bMess	Then
	stMessage.sTitre		= "Gestion des courriers particuliers"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE

	stMessage.sCode		= "CPART07"

	f_Message ( stMessage )
End If

end on

type pb_ps from picturebutton within u_spb_cp_2000
integer x = 37
integer y = 236
integer width = 233
integer height = 136
integer taborder = 30
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&P.Script"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_cpost.bmp"
string disabledname = "k:\pb4obj\bmp\8_cpost2.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Pb_Ps::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 16:38:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut saisir un PostScriptum
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si la personne peut saisir le paragraphe              */
/* POST-SCRIPTUM.                                                   */
/*------------------------------------------------------------------*/
If	idw_1.GetItemString ( 1, isCol[3] )	= "O"	Then
	stMessage.sTitre		= "Gestion des courriers particuliers"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE

	stMessage.sCode		= "CPART06"

	f_Message ( stMessage )

Else

	Parent.TriggerEvent ( "Ue_Post_Saisir" )
End If
end on

type pb_pce from picturebutton within u_spb_cp_2000
integer x = 37
integer y = 72
integer width = 233
integer height = 136
integer taborder = 10
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Autre Pce"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_aupce.bmp"
string disabledname = "k:\pb4obj\bmp\8_aupce2.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Pb_Pce::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 22/06/1998 16:38:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut saisir un paragraphe de PIECE
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si la personne peut saisir le paragraphe AUTRE PIECE. */
/*------------------------------------------------------------------*/
If	idw_1.GetItemString ( 1, isCol[3] )	= "O"	Then
	stMessage.sTitre		= "Gestion des courriers particuliers"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE

	stMessage.sCode		= "CPART05"

	f_Message ( stMessage )

Else
	Parent.TriggerEvent ( "Ue_Piece_Saisir" )
End If


end on

type gb_part from groupbox within u_spb_cp_2000
integer x = 9
integer y = 8
integer width = 466
integer height = 560
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cour. Particuliers"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
03u_spb_cp_2000.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
13u_spb_cp_2000.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
