HA$PBExportHeader$w_dc_spb_paragraphe.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d$$HEX1$$e900$$ENDHEX$$tail de consultation des paragraphes.
forward
global type w_dc_spb_paragraphe from w_8_ancetre_consultation
end type
type uo_paragraphe from u_saisieparagraphe within w_dc_spb_paragraphe
end type
type pb_word from picturebutton within w_dc_spb_paragraphe
end type
type mle_visualisation from multilineedit within w_dc_spb_paragraphe
end type
type dw_paragraphe from u_datawindow within w_dc_spb_paragraphe
end type
end forward

global type w_dc_spb_paragraphe from w_8_ancetre_consultation
integer x = 0
integer y = 0
integer width = 2057
integer height = 1780
string title = "Consultation d~'un paragraphe"
boolean controlmenu = false
uo_paragraphe uo_paragraphe
pb_word pb_word
mle_visualisation mle_visualisation
dw_paragraphe dw_paragraphe
end type
global w_dc_spb_paragraphe w_dc_spb_paragraphe

type variables
Boolean		ibDocumentOuvert
end variables

forward prototypes
public function boolean wf_saisirparagraphe ()
public function boolean wf_preparerconsulter ()
end prototypes

public function boolean wf_saisirparagraphe ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_saisirparagraphe
//* Auteur			:	YP
//* Date				:	23/09/97 16:02:10
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

		ibDocumentOuvert = uo_paragraphe.uf_OuvrirParagraphe ( 1, stGlb, dw_Paragraphe.GetItemString( 1, "ID_PARA" ) + "." + dw_Paragraphe.GetItemString( 1, "CPT_VER" ) )

	End If

End If

If ( Not ibDocumentOuvert ) Then

		stMessage.sTitre		= "Consultation des paragraphes"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "PARA005"

		f_Message ( stMessage )

		Return ( False )

End If

Return ( ibDocumentOuvert )
end function

public function boolean wf_preparerconsulter ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparerconsulter
//* Auteur			:	YP
//* Date				:	23/09/97 16:06:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant consultation
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La consultation peut continuer
//*
//*-----------------------------------------------------------------

String   sCol [ 2 ]	// Champ $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger contre la saisie.
String	sTxtPara		// Texte du paragraphe.

/*------------------------------------------------------------------*/
/* Rend inaccessible tous les champs.                               */
/*------------------------------------------------------------------*/
sCol [ 1 ] 		= "ID_PARA"
sCol [ 2 ] 		= "LIB_PARA"

Dw_Paragraphe.Uf_Proteger ( sCol, "1" )


/*------------------------------------------------------------------------------------*/
/* MADM 28/06/2006 Projet DNTMAIL1 AJout de la colonne ID_CANAL                       */
/* Dans les ancetres le multicanal n'est pas g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$, on passe la valeur 'MU' par d$$HEX1$$e900$$ENDHEX$$faut */
/*------------------------------------------------------------------------------------*/
If Dw_Paragraphe.Retrieve ( istPass.sTab[1], "MU" ) <= 0 Then Return ( False )

/*------------------------------------------------------------------*/
/* Le contenu du champ TXT_PARA est affect$$HEX4$$e9002000e0002000$$ENDHEX$$une Multi line Edit.  */
/*------------------------------------------------------------------*/
sTxtPara = Dw_Paragraphe.GetItemString ( 1, "TXT_PARA" )

If IsNull ( sTxtPara ) Then sTxtPara = ""

Mle_Visualisation.Text = sTxtPara

/*------------------------------------------------------------------*/
/* Initialisation de l'objet de communication avec Word             */
/*------------------------------------------------------------------*/
ibDocumentOuvert = False

If Not ( Uo_Paragraphe.uf_initialiser ( stGlb, Mle_Visualisation ) ) Then

	stMessage.sTitre		= "Consultation des paragraphes"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "PARA004"

	f_Message ( stMessage )

	Return ( False )

End If

Return ( True ) 
end function

on ue_initialiser;call w_8_ancetre_consultation::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_dc_spb_paragraphe
//* Evenement 		:	ue_initialiser
//* Auteur			:	YP
//* Date				:	23/09/1997 16:04:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des 
//*					 	paragraphes.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
String		sCol [ 2 ]		// Tableau contenant les champs dont 
									// l'attribut 'protect' peut $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$.

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/
sCol[ 1 ] 			= "ID_PARA"
sCol[ 2 ] 			= "LIB_PARA"

Dw_Paragraphe.Uf_InitialiserCouleur ( sCol )

Dw_Paragraphe.Uf_SetTransObject ( itrTrans )


end on

on w_dc_spb_paragraphe.create
int iCurrent
call super::create
this.uo_paragraphe=create uo_paragraphe
this.pb_word=create pb_word
this.mle_visualisation=create mle_visualisation
this.dw_paragraphe=create dw_paragraphe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_paragraphe
this.Control[iCurrent+2]=this.pb_word
this.Control[iCurrent+3]=this.mle_visualisation
this.Control[iCurrent+4]=this.dw_paragraphe
end on

on w_dc_spb_paragraphe.destroy
call super::destroy
destroy(this.uo_paragraphe)
destroy(this.pb_word)
destroy(this.mle_visualisation)
destroy(this.dw_paragraphe)
end on

type st_titre from w_8_ancetre_consultation`st_titre within w_dc_spb_paragraphe
boolean visible = false
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_dc_spb_paragraphe
integer x = 27
integer y = 32
end type

type uo_paragraphe from u_saisieparagraphe within w_dc_spb_paragraphe
boolean visible = false
integer x = 1861
integer y = 8
integer taborder = 50
boolean bringtotop = true
end type

on uo_paragraphe.destroy
call u_saisieparagraphe::destroy
end on

type pb_word from picturebutton within w_dc_spb_paragraphe
integer x = 1765
integer y = 32
integer width = 233
integer height = 136
integer taborder = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Voir $$HEX1$$a700$$ENDHEX$$"
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

stMessage.sTitre		=	parent.title
stMessage.Icon			=	Information!
stMessage.sCode		=	"PARA012"
stMessage.bErreurG	=	TRUE

f_Message ( stMessage )

wf_SaisirParagraphe ()
end on

type mle_visualisation from multilineedit within w_dc_spb_paragraphe
integer x = 46
integer y = 752
integer width = 1952
integer height = 880
integer taborder = 30
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

type dw_paragraphe from u_datawindow within w_dc_spb_paragraphe
integer x = 32
integer y = 196
integer width = 1984
integer height = 536
integer taborder = 10
string dataobject = "d_spb_paragraphe"
boolean border = false
end type

