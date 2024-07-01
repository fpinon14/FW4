HA$PBExportHeader$w_t_spb_paragraphe.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des paragraphes
forward
global type w_t_spb_paragraphe from w_8_traitement
end type
type pb_word from picturebutton within w_t_spb_paragraphe
end type
type mle_visualisation from multilineedit within w_t_spb_paragraphe
end type
type uo_paragraphe from u_saisieparagraphe within w_t_spb_paragraphe
end type
end forward

global type w_t_spb_paragraphe from w_8_traitement
integer x = 791
integer y = 40
integer width = 2034
integer height = 1692
string title = "Gestion des paragraphes"
event ue_droitecriture pbm_custom39
pb_word pb_word
mle_visualisation mle_visualisation
uo_paragraphe uo_paragraphe
end type
global w_t_spb_paragraphe w_t_spb_paragraphe

type variables
Boolean	ibDocumentOuvert

u_spb_gs_paragraphe iuoGsParagraphe
u_spb_zn_paragraphe iuoznParagraphe
end variables

forward prototypes
public function boolean wf_preparervalider ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparerinserer ()
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_saisirparagraphe ()
public function boolean wf_terminervalider ()
public function boolean wf_terminersupprimer ()
public function boolean wf_preparerabandonner ()
end prototypes

on ue_droitecriture;call w_8_traitement::ue_droitecriture;//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_carte
//* Evenement     : ue_DroitEcriture
//* Auteur        : Fabry JF
//* Date          : 16/09/2003 14:17:32
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: DCMP 030399 OMG/SO
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

PictureButton TbPict []

TbPict[1] = pb_valider
TbPict[2] = pb_supprimer

F_Droit_Ecriture_Param ( tbPict, "" )
end on

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparervalider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 11:04:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise les infos $$HEX2$$e0002000$$ENDHEX$$la cr$$HEX1$$e900$$ENDHEX$$ation d'un enregistrement
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	-->	Vraie : La validation peut 
//*													  continuer
//*
//*-----------------------------------------------------------------

String	sTxtPara		// Texte du paragraphe.
Long 		lVer
String	sVer

/*------------------------------------------------------------------*/
/* Test de la sauvegarde et de la fermeture du document si word     */
/* est ouvert                                                       */
/*------------------------------------------------------------------*/
If ( ibDocumentOuvert ) Then

	If ( Not Uo_Paragraphe.Uf_DocumentEnregistrer ( 1 ) ) Then

		stMessage.sTitre		= "Gestion des paragraphes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "PARA001"

		f_Message ( stMessage )

		Return ( False )

	End If

	If ( Not Uo_Paragraphe.Uf_DocumentFermer ( 1 ) ) Then

		stMessage.sTitre		= "Gestion des paragraphes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "PARA003"

		f_Message ( stMessage )

		Return ( False )

	End If


	lVer = Long( dw_1.GetItemString( 1, "CPT_VER" ) )
	lVer ++
	sVer = String( lVer, "000" )

	sVer = Uo_Paragraphe.uf_FichierExiste( stMessage, dw_1.GetItemString( 1, "ID_PARA" ) + "." + sVer )

	If ( sVer = "" ) Then

		Return ( False )

	End If

	If ( Not Uo_Paragraphe.uf_CopierTemporaire( 1 , stGlb, dw_1.GetItemString( 1, "ID_PARA" ) + "." + sVer ) ) Then

		stMessage.sTitre		= "Gestion des paragraphes"
		stMessage.Icon			= StopSign!
		sTmessage.sVar[1]		= dw_1.GetItemString( 1, "ID_PARA" ) + "." + sVer 
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "PARA002"

		f_Message ( stMessage )

		Return ( False )

	End If

	dw_1.SetItem( 1, "CPT_VER",  sVer)

Else

/*------------------------------------------------------------------*/
/* En cr$$HEX1$$e900$$ENDHEX$$ation, on ne contr$$HEX1$$f400$$ENDHEX$$le pas que le paragraphes est $$HEX1$$e900$$ENDHEX$$t$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$*/
/* saisie s'il sagit d'un paragraphe de substitution. ( $$HEX2$$a7002000$$ENDHEX$$Macro     */
/* ).                                                               */
/* Par contre, si Word $$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$ouvert une fois, les contr$$HEX1$$f400$$ENDHEX$$les         */
/* d'enregistrement et de fermeture subsistent.                     */
/*------------------------------------------------------------------*/

	If ( istPass.bInsert ) And ( Left ( dw_1.GetItemString ( 1, "ID_PARA" ) , 1 ) <> "M" ) Then

		stMessage.sTitre		= "Gestion des paragraphes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "PARA006"

		f_Message ( stMessage )

		Return ( False )

	End If

End If


/*------------------------------------------------------------------*/
/* Initialisation des informations de cr$$HEX1$$e900$$ENDHEX$$ation dans le cas de       */
/* l'insertion d'un nouveau paragraphe.                             */
/*------------------------------------------------------------------*/
If ( istPass.bInsert = True ) Then

		f_Creele ( Dw_1, 1 )		
	
End If

f_MajPar ( Dw_1, 1 )

/*------------------------------------------------------------------*/
/* Le contenu de la Mle est affect$$HEX2$$e9002000$$ENDHEX$$au champ TXT_PARA.              */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Modif DBI le 17/12/1998                                          */
/* Substitution des caract$$HEX1$$e800$$ENDHEX$$res qui posent probl$$HEX1$$e800$$ENDHEX$$mes                 */
/*------------------------------------------------------------------*/

sTxtPara = f_Remplace ( Mle_Visualisation.Text, "'", " " )
sTxtPara = f_Remplace ( sTxtPara, "$$HEX1$$1920$$ENDHEX$$", " " )

dw_1.SetItem ( 1, "TXT_PARA", sTxtPara )

Return ( True )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparermodifier
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 11:01:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La Modification peut continuer
//*
//*-----------------------------------------------------------------

String   sCol [ 1 ]	// Champ $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger contre la saisie.
String	sTxtPara		// Texte du paragraphe.

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")

/*------------------------------------------------------------------*/
/* Rend inaccessible en saisie le Code Paragraphe                   */
/*------------------------------------------------------------------*/
sCol [ 1 ] 		= "ID_PARA"
Dw_1.Uf_Proteger ( sCol, "1" )


Dw_1.ilPremCol = 2
Dw_1.ilDernCol = 2

/*------------------------------------------------------------------------------------*/
/* MADM 28/06/2006 Projet DNTMAIL1 AJout de la colonne ID_CANAL                       */
/* Dans les ancetres le multicanal n'est pas g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on passe la valeur 'MU' par d$$HEX1$$e900$$ENDHEX$$faut */
/*------------------------------------------------------------------------------------*/

If Dw_1.Retrieve ( istPass.sTab[1], "MU" ) <= 0 Then Return ( False )

Dw_1.SetColumn ( Dw_1.ilpremCol )


/*------------------------------------------------------------------*/
/* Le contenu du champ TXT_PARA est affect$$HEX4$$e9002000e0002000$$ENDHEX$$une Multi line Edit.  */
/*------------------------------------------------------------------*/
sTxtPara = Dw_1.GetItemString ( 1, "TXT_PARA" )

If IsNull ( sTxtPara ) then sTxtPara = ""

Mle_Visualisation.Text = sTxtPara

/*------------------------------------------------------------------*/
/* Initialisation de l'objet de communication avec Word             */
/*------------------------------------------------------------------*/
ibDocumentOuvert = False

If Not ( Uo_Paragraphe.uf_initialiser ( stGlb, Mle_Visualisation ) ) Then

	stMessage.sTitre		= "Gestion des paragraphes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "PARA004"

	f_Message ( stMessage )

	Return ( False )

End If

Return ( True ) 
end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparerinserer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 10:59:36
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations avant insertion
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer
//*
//*-----------------------------------------------------------------

String  sCol [ 1 ]		// Champ $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger.

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")

/*------------------------------------------------------------------*/
/* Rend accessible en saisie le Code Paragraphe                     */
/*------------------------------------------------------------------*/
sCol [ 1 ] 		= "ID_PARA"
Dw_1.Uf_Proteger ( sCol, "0" )

Dw_1.ilPremCol = 1
Dw_1.ilDernCol = 2

Dw_1.SetColumn ( Dw_1.ilPremCol )

/*------------------------------------------------------------------*/
/* Initialisation de l'objet de communication avec Word             */
/*------------------------------------------------------------------*/
ibDocumentOuvert = False

If Not ( Uo_Paragraphe.uf_initialiser ( stGlb, Mle_Visualisation ) ) Then

	stMessage.sTitre		= "Gestion des paragraphes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "PARA004"

	f_Message ( stMessage )

	Return ( False )

End If

dw_1.SetItem( 1, "CPT_VER", "000" )

Mle_Visualisation.Text = ""

Return ( TRUE )
end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_controlersaisie
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 11:18:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de saisie des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					 	PARAGRAPHE.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String		"" -> On passe au controle de gestion
//*
//*-----------------------------------------------------------------

String 		sCol [ 3 ]			// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sErr [ 3 ]			// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String 		sNouvelleLigne		// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText					// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos					// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.
String		sVal					// Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification.
Long 			lCpt					// Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrCol				// Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.

sNouvelleLigne	= "~r~n"
lNbrCol			= UpperBound ( sCol )
sPos				= ""
sText				= sNouvelleLigne

sCol[ 1 ]		= "ID_PARA"
sCol[ 2 ]		= "LIB_PARA"
sCol[ 3 ]		= "CPT_VER"

sErr[ 1 ]		= " - Le code paragraphe"
sErr[ 2 ]		= " - Le libell$$HEX1$$e900$$ENDHEX$$"
sErr[ 3 ]		= " - Le compteur de version"

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lNbrCol

	sVal = Dw_1.GetItemString ( 1, sCol [ lCpt ] )

	If ( IsNull ( sVal ) or Trim ( sVal ) = "" )	Then

		If ( sPos = "" ) 	Then 	sPos = sCol [ lCpt ]
		sText = sText + sErr [ lCpt ] + sNouvelleLigne

	End If

Next

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur s'il y  */
/* en a une :												                    */
/*------------------------------------------------------------------*/
If	( sPos <> "" ) Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Paragraphes"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If

Return ( sPos )
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_controlergestion
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 11:21:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de gestion de la saisie.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	""		->	Si contr$$HEX1$$f400$$ENDHEX$$le Ok
//*					  				Nom de la colonne en Erreur
//*
//*-----------------------------------------------------------------

String		sCol 		// Nom de la colonne en Erreur.
String		sIdPara, sIdCanal	// Identifiant du paragraphe.

scol = ""

If ( istPass.bInsert = True )  Then

//Ajout de la colonne ID_CANAL
	sidPara 	= Dw_1.GetItemString ( 1, "ID_PARA" )
	sidCanal 	= Dw_1.GetItemString ( 1, "ID_CANAL" )

	If ( iuoGsParagraphe.uf_gs_Id_Para ( sIdPara, sidCanal ) = False ) Then

		sCol 		= "ID_PARA"

	End If

End If

Return ( sCol )	
end function

public function boolean wf_saisirparagraphe ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_saisirparagraphe
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 11:35:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Saisie du $$HEX1$$a700$$ENDHEX$$
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	True	-> Si Ok
//*					 	False	-> Si Non
//*
//*-----------------------------------------------------------------

SetPointer( HourGlass! )

If ( ibDocumentOuvert ) Then

	uo_paragraphe.uf_Init_Bool ( 1 )
	uo_paragraphe.uf_Activer()
	
Else

	If ( istPass.bInsert ) Then

		ibDocumentOuvert = uo_paragraphe.uf_CreerParagraphe ( 1, stGlb )

	Else

		ibDocumentOuvert = uo_paragraphe.uf_OuvrirParagraphe ( 1, stGlb, dw_1.GetItemString( 1, "id_para" ) + "." + dw_1.GetItemString( 1, "cpt_ver" ) )

	End If

End If

If ( Not ibDocumentOuvert ) Then

		stMessage.sTitre		= "Gestion des paragraphes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "PARA005"

		f_Message ( stMessage )

		Return ( False )

End If

Return ( ibDocumentOuvert )
end function

public function boolean wf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_terminervalider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 11:24:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Termine la validation.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	-->	Vraie : La validation peut 
//*													  continuer
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Nettoies les liens avec Word                                     */
/*------------------------------------------------------------------*/
uo_paragraphe.Uf_Clear()

/*------------------------------------------------------------------*/
/* Tout est OK, on peut commiter la trace.                          */
/*------------------------------------------------------------------*/
UoGsTrace.Uf_CommitTrace ( TRUE )

Return ( True )
end function

public function boolean wf_terminersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_terminersupprimer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/1997 11:40:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	True
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Nettoie les liens avec Word                                      */
/*------------------------------------------------------------------*/
uo_paragraphe.Uf_Clear()

/*------------------------------------------------------------------*/
/* Tout est OK, on peut commiter la trace.                          */
/*------------------------------------------------------------------*/
UoGsTrace.Uf_CommitTrace ( True )

Return ( True )
end function

public function boolean wf_preparerabandonner ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparerabandonner
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 11:23:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Nettoie les liens avec Word
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	True
//*
//*-----------------------------------------------------------------

uo_paragraphe.uf_Clear()

Return True
end function

on ue_initialiser;call w_8_traitement::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_t_spb_paragraphe
//* Evenement 		:	ue_initialiser
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	13/06/1997 17:46:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					 	paragraphes.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
String		sCol [ 1 ]		// Tableau contenant les champs dont 
									// l'attribut 'protect' peut $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$.

iuoGsParagraphe = Create u_spb_gs_Paragraphe
iUoZnParagraphe = Create u_spb_zn_Paragraphe

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/

sCol[1] 			= "ID_PARA"

Dw_1.Uf_InitialiserCouleur ( sCol )

Dw_1.Uf_SetTransObject ( itrTrans )

/*------------------------------------------------------------------*/
/* Initialisation du User Object de contr$$HEX1$$f400$$ENDHEX$$le de gestion             */
/*------------------------------------------------------------------*/

iuoGsParagraphe.uf_initialisation ( itrTrans, Dw_1 )
iuoZnParagraphe.uf_initialisation ( itrTrans, Dw_1 )
end on

on ue_majaccueil;call w_8_traitement::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_t_spb_paragraphe
//* Evenement 		:	UE_MAJACCUEIL - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	13/06/1997 17:47:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 	sTab			// Code tabulation.
String	sMajLe		// Variable tampon pour MAJ_LE.

sTab				= "~t"
sMajLe			= String ( dw_1.GetItemDateTime ( 1, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss" )

isMajAccueil 	=	dw_1.GetItemString ( 1, "ID_PARA"  ) + sTab	+ &
						dw_1.GetItemString ( 1, "CPT_VER"  ) + sTab	+ &
 						dw_1.GetItemString ( 1, "LIB_PARA" ) + sTab	+ &
						sMajLe								 		 + sTab	+ &
						dw_1.GetItemString ( 1, "MAJ_PAR"  )
end on

on close;call w_8_traitement::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_t_spb_paragraphe
//* Evenement 		: Close
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 13/06/1997 17:45:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					  fen$$HEX1$$ea00$$ENDHEX$$tre 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction du User Object de contr$$HEX1$$f400$$ENDHEX$$le de gestion et de saisie   */
/* pour le param$$HEX1$$e900$$ENDHEX$$trage des Paragraphes                              */
/*------------------------------------------------------------------*/
Destroy iuoGsParagraphe
Destroy iuoZnParagraphe
end on

on w_t_spb_paragraphe.create
int iCurrent
call super::create
this.pb_word=create pb_word
this.mle_visualisation=create mle_visualisation
this.uo_paragraphe=create uo_paragraphe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_word
this.Control[iCurrent+2]=this.mle_visualisation
this.Control[iCurrent+3]=this.uo_paragraphe
end on

on w_t_spb_paragraphe.destroy
call super::destroy
destroy(this.pb_word)
destroy(this.mle_visualisation)
destroy(this.uo_paragraphe)
end on

type dw_1 from w_8_traitement`dw_1 within w_t_spb_paragraphe
integer x = 23
integer y = 168
integer width = 1970
integer height = 536
string dataobject = "d_spb_paragraphe"
boolean border = false
end type

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	16/06/97 11:37:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification du SqlPreview de la datawindow Dw_1
//*					 	dans le cas de l'insertion ou de la suppression  
//*					 	d'un paragraphe.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* 				  
//*-----------------------------------------------------------------

String	sSqlPreview			// SqlPreview de la datawindow Dw_1.
String	sIdPara 				// Identifiant du paragraphe.
String	sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sType					// Type d'action effectuer sur la table.
String	sCle [ 1 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.

//Migration PB8-WYNIWYG-03/2006 CP
//String	sCol [ 6 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String	sVal [ 6 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sCol [  ]			// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal [  ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 CP

Long 		ll_return

Long		lCpt

//Migration PB8-WYNIWYG-03/2006 CP
// sSqlPreview 		= Dw_1.GetSQLPreview ()
	sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP


/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "PARAGRAPHE"

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/
Choose Case Left ( sSqlPreview, 4 )

	Case	"INSE" 

		sCol = { "ID_PARA" , "LIB_PARA" , "CPT_VER" }

		sVal [ 1 ] = "'" + Dw_1.GetItemString   ( 1, "ID_PARA"  ) + "'"
		sVal [ 2 ] = "'" + Dw_1.GetItemString   ( 1, "LIB_PARA" ) + "'"
		sVal [ 3 ] = "'" + Dw_1.GetItemString   ( 1, "CPT_VER"  ) + "'"

		sCle [ 1 ]	= sVal [ 1 ]
		sType = 'I'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then


//Migration PB8-WYNIWYG-03/2006 CP
// 			This.SetActionCode ( 1 )
				ll_return =1
//Fin Migration PB8-WYNIWYG-03/2006 CP

		End If

	Case	"UPDA" 

 		uoGsTrace.uf_PreparerTrace ( sSqlPreview, sCol, sVal )

		/*------------------------------------------------------------------*/
		/* Pour l'update d'un paragraphe on ne trace que la modifiaction    */
		/* du libell$$HEX1$$e900$$ENDHEX$$. Il faut donc enlever de sCol et de sVal le contenu   */
		/* du champ TXT_PARA.                                               */
		/*------------------------------------------------------------------*/
		For lCpt = 2 To 6

			sCol [ lCPt ] = ""
			sVal [ lCPt ] = "''"

		Next


		sCle [ 1 ]	= Dw_1.GetItemString   ( 1, "ID_PARA"  )
		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then


//Migration PB8-WYNIWYG-03/2006 CP
// 			Dw_1.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

		End If

	Case	"DELE"
      
		sIdPara = Dw_1.GetItemString ( 1, "ID_PARA", DELETE!, FALSE )
		

		itrTrans.DW_D01_PARAGRAPHE ( sIdPara )

		If itrTrans.SqlCode <> 0	Then


//Migration PB8-WYNIWYG-03/2006 CP
// 			This.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

		Else

			sCle [ 1 ] = "'" + sIdPara + "'"
			sType = 'D'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then


//Migration PB8-WYNIWYG-03/2006 CP
// 				This.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

			Else


//Migration PB8-WYNIWYG-03/2006 CP
// 				This.SetActionCode ( 2 )
				ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP

			End If

		End If

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
				Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	ITEMERROR - Extend 
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	13/06/1997 17:44:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages d'erreur suite aux erreurs 
//*					 	de saisies.
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Paragraphes"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "ID_PARA"

			Choose Case iiErreur 

				Case 0
					stMessage.sVar[1] 	= "Code du Paragraphe"
					stMessage.bErreurG	= TRUE
					stMessage.sCode		= "GENE003"

				case 1
					stMessage.bErreurG	= TRUE
					stMessage.sCode   = "PARA011"

			End Choose

		Case "LIB_PARA"
			iiReset = 2
			stMessage.bErreurG	= TRUE
			stMessage.sVar[1] = "Libell$$HEX2$$e9002000$$ENDHEX$$du Paragraphe"
			stMessage.sCode	= "GENE003"

	End Choose

	f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.uf_Reinitialiser ()
	Return uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	ItemChanged - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	13/06/97 17:42:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de champs
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sVal			// Valeur du champ saisi.
Integer		iAction		// valeur du SetActionCode.

iAction	= 0
//Migration PB8-WYNIWYG-03/2006 FM
//sVal 		= This.GetText ( )
sVal = data
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case isNomCol
  
	Case "ID_PARA"

		If Not iUoZnParagraphe.Uf_Zn_LongueurId ( sVal ) Then 

			iAction	= 1
			iiErreur	= 1

		End If

End Choose


//Migration PB8-WYNIWYG-03/2006 CP
//SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 CP

end event

on dw_1::dberror;call w_8_traitement`dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	dberror
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	13/06/97 17:41:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	En cas d'erreur base, on rollbacke la trace.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

UoGsTrace.Uf_CommitTrace ( False )
end on

type st_titre from w_8_traitement`st_titre within w_t_spb_paragraphe
boolean visible = false
end type

type pb_retour from w_8_traitement`pb_retour within w_t_spb_paragraphe
integer x = 27
integer y = 20
end type

type pb_valider from w_8_traitement`pb_valider within w_t_spb_paragraphe
integer x = 274
integer y = 20
integer taborder = 30
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_spb_paragraphe
boolean visible = false
integer y = 32
integer taborder = 0
end type

type pb_controler from w_8_traitement`pb_controler within w_t_spb_paragraphe
boolean visible = false
integer y = 32
integer taborder = 40
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_spb_paragraphe
integer x = 521
integer y = 20
end type

type pb_word from picturebutton within w_t_spb_paragraphe
integer x = 1755
integer y = 20
integer width = 233
integer height = 136
integer taborder = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Saisir $$HEX1$$a700$$ENDHEX$$"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_word.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			:	pb_word
//* Evenement 		:	Click
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	13/06/97 17:48:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Appel $$HEX2$$e0002000$$ENDHEX$$Word pour editer le document en cour de saisie
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

wf_SaisirParagraphe ()
end on

type mle_visualisation from multilineedit within w_t_spb_paragraphe
integer x = 32
integer y = 696
integer width = 1952
integer height = 880
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

on rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	mle_visualisation
//* Evenement 		:	rbuttondown
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	13/06/97 17:47:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Emp$$HEX1$$ea00$$ENDHEX$$che l'apparition du menu contextuel standard 
//*					 	W95 et WNT.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Message.Processed = True


end on

type uo_paragraphe from u_saisieparagraphe within w_t_spb_paragraphe
boolean visible = false
integer x = 841
integer y = 248
boolean bringtotop = true
end type

on uo_paragraphe.destroy
call u_saisieparagraphe::destroy
end on

