HA$PBExportHeader$w_accueil_edition.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'$$HEX1$$e900$$ENDHEX$$dition
forward
global type w_accueil_edition from w_accueil
end type
type pb_word from u_pbword within w_accueil_edition
end type
type mle_rapport from u_rapport within w_accueil_edition
end type
type cb_tous from commandbutton within w_accueil_edition
end type
type cb_aucun from commandbutton within w_accueil_edition
end type
type st_1 from statictext within w_accueil_edition
end type
type st_nombre from statictext within w_accueil_edition
end type
type cbx_banner from checkbox within w_accueil_edition
end type
type cbx_pageblanche from checkbox within w_accueil_edition
end type
end forward

global type w_accueil_edition from w_accueil
int Width=2538
int Height=1845
boolean TitleBar=true
string Title="Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil d'$$HEX1$$e900$$ENDHEX$$dition"
event ue_word pbm_custom01
event ue_preparerimpression pbm_custom02
event ue_imprimerdossier pbm_custom03
event ue_terminerimpression pbm_custom04
pb_word pb_word
mle_rapport mle_rapport
cb_tous cb_tous
cb_aucun cb_aucun
st_1 st_1
st_nombre st_nombre
cbx_banner cbx_banner
cbx_pageblanche cbx_pageblanche
end type
global w_accueil_edition w_accueil_edition

type variables
Protected:

//	u_courrier	iuoCourrier
	Long		ilDossier
	Long		ilNbSelection
	Boolean		ibStop
	Boolean		ibSupprimerLigne
	String		isTypeEdition
end variables

forward prototypes
protected subroutine wf_selectionnertout ()
protected subroutine wf_selectionneraucun ()
protected subroutine wf_actualisernombre ()
end prototypes

on ue_word;call w_accueil::ue_word;//*-----------------------------------------------------------------
//*
//* Objet			:	w_accueil_edition
//* Evenement 		:	ue_word
//* Auteur			:	La Recrue
//* Date				:	17/02/1997 18:06:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Impression des dossiers selectionn$$HEX1$$e900$$ENDHEX$$
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//* N$$HEX2$$b0002000$$ENDHEX$$Modif          Re$$HEX1$$e700$$ENDHEX$$ue Le          Effectu$$HEX1$$e900$$ENDHEX$$e Le          PAR
//*
//* MOD-0067          15/05/97            16/05/97					YP
//* MOD-0019			 27/08/97            04/09/97            PAR
//* MOD-0021										29/09/97				  PAR
//*-----------------------------------------------------------------

SetPointer( HourGlass! )

Mle_Rapport.Uf_EffacerText()

/*------------------------------------------------------------------*/
/* MOD-0067 : On doit tester si Word est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$lanc$$HEX2$$e9002000$$ENDHEX$$(IsValid).      */
/* Dans le cas contraire, on d$$HEX1$$e900$$ENDHEX$$clenche son ouverture.               */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* DBI le 15/04/1999                                                */
/* Le test si Word est d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$lanc$$HEX2$$e9002000$$ENDHEX$$ne sert $$HEX2$$e0002000$$ENDHEX$$rien et en plus il est  */
/* source de plantage lorsque l'on effectue Edition puis r$$HEX2$$e900e900$$ENDHEX$$dition  */
/* ou lorsque Word est charg$$HEX2$$e9002000$$ENDHEX$$en consult et que l'on tente          */
/* d'$$HEX1$$e900$$ENDHEX$$diter.                                                        */
/*------------------------------------------------------------------*/

//If ( Not iuoCourrier.uf_IsValid() ) Then
//End If

mle_Rapport.Uf_AjouterText( "Initialisation de la communication avec Word...~r~n" )
	
//If ( Not iuoCourrier.uf_initCourrier( stGlb, stMessage ) ) Then
//
//	mle_Rapport.Uf_RemplacerText( "Initialisation de la communication avec Word a echou$$HEX1$$e900$$ENDHEX$$e~r~n" )
//	Return
//
//Else
//	mle_Rapport.Uf_RemplacerText( "Initialisation Ok!~r~n" )
//End If
//	
//
/*------------------------------------------------------------------*/
/* fichier Spool                                                    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* MOD-0019                                                         */
/* On ajoute le nombre de dossiers selectionn$$HEX1$$e900$$ENDHEX$$s ainsi que les       */
/* choix de l'utilisateur pour savoir si un banni$$HEX1$$e800$$ENDHEX$$re doit           */
/* $$HEX1$$ea00$$ENDHEX$$tre edit$$HEX1$$e900$$ENDHEX$$e ou pas ou si une page blanche est $$HEX1$$e900$$ENDHEX$$dit$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$la fin ou */
/* non.                                                             */
/*------------------------------------------------------------------*/

//iuoCourrier.Uf_InitSpool( ilNbSelection, cbx_Banner.Checked, cbx_PageBlanche.Checked )

/*------------------------------------------------------------------*/
/* Traitement des dossiers                                          */
/*------------------------------------------------------------------*/

mle_Rapport.Uf_AjouterText( "Traitement des dossiers en cours~r~n" )

This.TriggerEvent( "Ue_DisableFenetre" )

This.TriggerEvent( "ue_PreparerImpression" )

ilDossier = 0

ilDossier = dw_1.GetSelectedRow( ilDossier )


Do While ( ilDossier > 0 ) And ( Not ibStop )

	This.TriggerEvent( "ue_ImprimerDossier" )

	If Not( ibStop ) Then

		If ( ibSupprimerLigne ) Then 

		/*------------------------------------------------------------------*/
		/* MOD-0021 : On supprimela ligne si ibSupprimeligne = True         */
		/*------------------------------------------------------------------*/
			Dw_1.Visible = False
			Dw_1.DeleteRow ( ilDossier )
			Dw_1.TriggerEvent ( "Ue_TaillerHauteur" )
			Dw_1.Visible = True
			ilDossier --			

		End If

		ilDossier = dw_1.GetSelectedRow( ilDossier )
		
	End If


Loop

This.TriggerEvent( "ue_TerminerImpression" )

/*------------------------------------------------------------------*/
/* Trace de l'$$HEX1$$e900$$ENDHEX$$dition                                               */
/*------------------------------------------------------------------*/

//iuocourrier.Uf_Trace ( stGlb, isTypeEdition )

This.TriggerEvent( "Ue_EnableFenetre" )

stMessage.sTitre 		= "EDITION"
stMessage.Icon			= Information!
stMessage.sCode		= "ANCE020"
stMessage.bErreurG	= True

f_Message( stMessage )

ibStop = False
ibSupprimerLigne = False

end on

protected subroutine wf_selectionnertout ();//*******************************************************************************************
// Fonction            	: wf_SelectionnerTout
//	Auteur              	: La Recrue
//	Date 					 	: 14/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Selectionne toutes les lignes de la datawindow
//
// Arguments				: Aucun
//
// Retourne					: Aucun
//								  
//*******************************************************************************************

SetPointer( HourGlass! )

dw_1.SetRedraw ( False )

Long	lI

ilNbSelection = dw_1.RowCount()

For lI = 1 to ilNbSelection
	dw_1.SelectRow( lI, True )
Next

wf_ActualiserNombre()

dw_1.SetRedraw ( True )

end subroutine

protected subroutine wf_selectionneraucun ();//*******************************************************************************************
// Fonction            	: wf_SelectionnerAucun
//	Auteur              	: La Recrue
//	Date 					 	: 14/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Enl$$HEX1$$e800$$ENDHEX$$ve la selection de toute les lignes
//
// Arguments				: Aucun
//
// Retourne					: Aucun
//								  
//*******************************************************************************************

dw_1.SelectRow( 0, False )
ilNbSelection = 0
wf_ActualiserNombre()




end subroutine

protected subroutine wf_actualisernombre ();//*******************************************************************************************
// Fonction            	: wf_ActualiserNombre()
//	Auteur              	: La Recrue
//	Date 					 	: 14/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Met $$HEX2$$e0002000$$ENDHEX$$jour la zone indiquant le nombre de dossier selectionn$$HEX1$$e900$$ENDHEX$$
//
// Arguments				: Aucun
//
// Retourne					: Aucun
//								  
//*******************************************************************************************

If ( ilNbSelection > 0 ) Then

	St_Nombre.Text = String ( ilNbSelection ) +  " / " + String ( dw_1.RowCount() )

	If ( Not Pb_Word.Enabled ) Then 

		Pb_Word.Enabled = True

	End If

Else

	St_Nombre.Text = ""
	Pb_Word.Enabled = False

End If

end subroutine

on ue_fin_interro;call w_accueil::ue_fin_interro;//*****************************************************************************
//
// Objet 		: w_Accueil_Edition
// Evenement 	: Ue_Fin_Interro
//	Auteur		: La Recrue
//	Date			: 14/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Enable les objets utiles $$HEX2$$e0002000$$ENDHEX$$l'impression si des lignes sont pr$$HEX1$$e900$$ENDHEX$$sentes
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

SetPointer( HourGlass! )

If ( dw_1.RowCount() > 0 ) Then

	cb_Tous.Enabled	= True
	cb_Aucun.Enabled	= True
	pb_Word.Enabled	= True

	wf_SelectionnerTout()

Else

	cb_Tous.Enabled	= False
	cb_Aucun.Enabled	= False
	pb_Word.Enabled	= False

	ilNbSelection = 0
	wf_ActualiserNombre()

End If


end on

on open;call w_accueil::open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_accueil_edition
//* Evenement 		:	open
//* Auteur			:	La Recrue
//* Date				:	17/02/1997 17:56:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	Instanciation et initialisation des variables 
//*						d'instance
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//* N$$HEX2$$b0002000$$ENDHEX$$Modif          Re$$HEX1$$e700$$ENDHEX$$ue Le          Effectu$$HEX1$$e900$$ENDHEX$$e Le          PAR
//*
//* MOD-0021										29/09/97				  PAR
//*-----------------------------------------------------------------

//iUoCourrier			= Create u_courrier

/*----------------------------------------------------------------------------*/
/* On initialise le .INI de communication avec Word (ex COURRIER.INI). On y   */
/* g$$HEX1$$e800$$ENDHEX$$re $$HEX1$$e900$$ENDHEX$$galement l'existence de ce m$$HEX1$$ea00$$ENDHEX$$me fichier pour tracer les erreurs de   */
/* consultation. Le "C" indique que l'on se trouve dans un contexte de        */
/* Consultation de courrier.                                                  */
/*----------------------------------------------------------------------------*/
//iUoCourrier.Uf_InitIni ( stGLB, "E" , stMessage )

/*------------------------------------------------------------------*/
/* MOD-0067 : Initialisation des valeur pard$$HEX1$$e900$$ENDHEX$$faut des nouvelles     */
/* variable d'instance                                              */
/*------------------------------------------------------------------*/
ibSupprimerLigne	= False
isTypeEdition		= "1"

end on

on ue_initialiser;call w_accueil::ue_initialiser;//*****************************************************************************
//
// Objet 		: w_Accueil_Edition
// Evenement 	: UE_Initialiser
//	Auteur		: La Recrue
//	Date			: 14/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: La datawindow d'accueil ne fonctionne pas sur la selection
// Commentaires: //
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Dw_1.Uf_Activer_Selection( False )

ibStop = False
ilNbSelection	= 0
istPass.trTrans = SQLCA

wf_ActualiserNombre()



end on

on ue_enablefenetre;call w_accueil::ue_enablefenetre;//*-----------------------------------------------------------------
//*
//* Objet			:	w_accueil_edition
//* Evenement 		:	ue_Enablefenetre
//* Auteur			:	La Recrue
//* Date				:	17/03/1997 14:50:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	disable la fen$$HEX1$$ea00$$ENDHEX$$tre d'impression
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

cb_aucun.Enabled	= True
cb_tous.Enabled	= True
pb_word.Enabled	= True

end on

on close;call w_accueil::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_accueil_edition
//* Evenement 		:	Close
//* Auteur			:	La Recrue
//* Date				:	17/02/1997 17:58:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Destruction des variables instanci$$HEX1$$e900$$ENDHEX$$es
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


//Destroy iuoCourrier
end on

on ue_item6;call w_accueil::ue_item6;//*****************************************************************************
//
// Objet 		: w_Accueil_Edition
// Evenement 	: Ue_item6
//	Auteur		: La Recrue
//	Date			: 14/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Lance l'impression des dossiers selectionn$$HEX1$$e900$$ENDHEX$$s
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

TriggerEvent ( "ue_word" )
end on

on ue_centreracc;//*****************************************************************************
//
// Objet 		: w_Accueil_Edition
// Evenement 	: UE_Centre_Acc
//	Auteur		: La Recrue
//	Date			: 14/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: OverWrite du script anc$$HEX1$$ea00$$ENDHEX$$tre pour eviter le retaillage de la Dw
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************


end on

on ue_taillerhauteur;//*****************************************************************************
//
// Objet 		: w_Accueil_Edition
// Evenement 	: UE_Tailler_Hauteur
//	Auteur		: La Recrue
//	Date			: 14/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: OverWrite du script anc$$HEX1$$ea00$$ENDHEX$$tre pour eviter le retaillage de la Dw
// Commentaires: //
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************


end on

on w_accueil_edition.create
int iCurrent
call w_accueil::create
this.pb_word=create pb_word
this.mle_rapport=create mle_rapport
this.cb_tous=create cb_tous
this.cb_aucun=create cb_aucun
this.st_1=create st_1
this.st_nombre=create st_nombre
this.cbx_banner=create cbx_banner
this.cbx_pageblanche=create cbx_pageblanche
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=pb_word
this.Control[iCurrent+2]=mle_rapport
this.Control[iCurrent+3]=cb_tous
this.Control[iCurrent+4]=cb_aucun
this.Control[iCurrent+5]=st_1
this.Control[iCurrent+6]=st_nombre
this.Control[iCurrent+7]=cbx_banner
this.Control[iCurrent+8]=cbx_pageblanche
end on

on w_accueil_edition.destroy
call w_accueil::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_word)
destroy(this.mle_rapport)
destroy(this.cb_tous)
destroy(this.cb_aucun)
destroy(this.st_1)
destroy(this.st_nombre)
destroy(this.cbx_banner)
destroy(this.cbx_pageblanche)
end on

on ue_disablefenetre;call w_accueil::ue_disablefenetre;//*-----------------------------------------------------------------
//*
//* Objet			:	w_accueil_edition
//* Evenement 		:	ue_disablefenetre
//* Auteur			:	La Recrue
//* Date				:	17/03/1997 14:50:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	disable la fen$$HEX1$$ea00$$ENDHEX$$tre d'impression
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

cb_aucun.Enabled	= False
cb_tous.Enabled	= False
pb_word.Enabled	= False

end on

type pb_retour from w_accueil`pb_retour within w_accueil_edition
int TabOrder=70
end type

type pb_interro from w_accueil`pb_interro within w_accueil_edition
int X=298
int TabOrder=80
end type

type pb_creer from w_accueil`pb_creer within w_accueil_edition
int X=298
int TabOrder=90
boolean Visible=false
boolean Enabled=false
end type

type dw_1 from w_accueil`dw_1 within w_accueil_edition
int X=28
int Y=869
int Width=2451
int Height=773
boolean Visible=true
end type

on dw_1::ue_modifiermenu;call w_accueil`dw_1::ue_modifiermenu;//*****************************************************************************
//
// Objet 		: w_Accueil_Edition:dw_1
// Evenement 	: ue_Modifier_Menu
//	Auteur		: La Recrue
//	Date			: 14/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Ne permet que d'imprimer de dossier Selectionner
// Commentaires: //
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

This.Uf_mnu_CacherItem ( 1 )
This.Uf_mnu_CacherItem ( 2 )
This.Uf_mnu_CacherItem ( 3 )
This.Uf_mnu_CacherItem ( 4 )

This.Uf_mnu_AjouterItem ( 6, "Editer" )

If ( dw_1.GetSelectedRow( 0 ) > 0 ) Then
	This.Uf_Mnu_AutoriserItem( 6 )
Else
	This.Uf_Mnu_InterdirItem( 6 )
End If

end on

on dw_1::clicked;call w_accueil`dw_1::clicked;//*****************************************************************************
//
// Objet 		: w_Accueil_Edition:dw_1
// Evenement 	: Clicked
//	Auteur		: La Recrue
//	Date			: 14/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: G$$HEX1$$e800$$ENDHEX$$re la la selection Multiligne
// Commentaires: //
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Boolean	bSelected
Long		lRow

lRow = GetClickedRow()

If ( lRow > 0 ) Then 

	bSelected = IsSelected( lRow )

	If ( bSelected ) Then
		ilNbSelection --
	Else
		ilNbSelection ++
	End If

	SelectRow( lRow, Not bSelected )

	wf_ActualiserNombre()

End If
end on

type pb_tri from w_accueil`pb_tri within w_accueil_edition
int X=572
int TabOrder=100
end type

type pb_word from u_pbword within w_accueil_edition
int X=846
int Y=17
int TabOrder=110
boolean Enabled=false
string DisabledName="k:\pb4obj\bmp\winword.bmp"
end type

type mle_rapport from u_rapport within w_accueil_edition
int X=28
int Y=309
int Width=2451
int Height=413
int TabOrder=0
end type

type cb_tous from commandbutton within w_accueil_edition
int X=37
int Y=749
int Width=407
int Height=93
int TabOrder=30
boolean Enabled=false
boolean BringToTop=true
string Text="Tous"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//*****************************************************************************
//
// Objet 		: w_Accueil_Edition:cb_Tous
// Evenement 	: Clicked
//	Auteur		: La Recrue
//	Date			: 14/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Selection de toutes les ligne
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Wf_SelectionnerTout()
end on

type cb_aucun from commandbutton within w_accueil_edition
int X=467
int Y=749
int Width=407
int Height=93
int TabOrder=40
boolean Enabled=false
boolean BringToTop=true
string Text="Aucun"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//*****************************************************************************
//
// Objet 		: w_Accueil_Edition:cb_Aucun
// Evenement 	: Clicked
//	Auteur		: La Recrue
//	Date			: 14/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$selection de toutes les ligne
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Wf_SelectionnerAucun()
end on

type st_1 from statictext within w_accueil_edition
int X=1418
int Y=761
int Width=737
int Height=73
boolean Enabled=false
boolean BringToTop=true
string Text="Nombre de dossiers $$HEX3$$e0002000e900$$ENDHEX$$diter :"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_nombre from statictext within w_accueil_edition
int X=2181
int Y=757
int Width=293
int Height=77
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_banner from checkbox within w_accueil_edition
int X=1148
int Y=17
int Width=325
int Height=73
int TabOrder=50
boolean BringToTop=true
string Text="Banni$$HEX1$$e800$$ENDHEX$$re"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_pageblanche from checkbox within w_accueil_edition
int X=1148
int Y=97
int Width=426
int Height=73
int TabOrder=60
boolean BringToTop=true
string Text="Page blanche"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

