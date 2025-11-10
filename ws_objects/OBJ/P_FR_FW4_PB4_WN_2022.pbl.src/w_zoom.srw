HA$PBExportHeader$w_zoom.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre de saisie / consultation en zoom
forward
global type w_zoom from w_ancetre
end type
type dw_1 from u_datawindow within w_zoom
end type
type gb_1 from groupbox within w_zoom
end type
type pb_imprimer from u_pbimprimer within w_zoom
end type
type pb_valider from u_pbvalider within w_zoom
end type
end forward

global type w_zoom from w_ancetre
int Width=2396
int Height=1449
WindowType WindowType=response!
boolean TitleBar=true
string Title="Fen$$HEX1$$ea00$$ENDHEX$$tre de Zoom"
dw_1 dw_1
gb_1 gb_1
pb_imprimer pb_imprimer
pb_valider pb_valider
end type
global w_zoom w_zoom

type variables



end variables

forward prototypes
public function boolean wf_valider ()
public function string wf_controlergestion ()
public function string wf_controlersaisie ()
public function boolean wf_preparermodifier ()
end prototypes

public function boolean wf_valider ();//*******************************************************************************************
// Fonction				: W_Zoom::Wf_Valider
//	Auteur					: FS
//	Date 					 	: 20/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Proc$$HEX1$$e900$$ENDHEX$$dure centrale de controle 
// Commentaires			: Elle appelle les fonctions de controles de saisie et de controle de gestion
// Arguments				: Aucun
//
// Retourne				: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si tout Ok
//								  
//*******************************************************************************************

Boolean		bRet = True		// Retour de la fonction
String		sCol					// Colonne sur laquelle on doit repositionner le focus si erreur

// ---------- Controle de remplissage des zones obligatoires

sCol = wf_ControlerSaisie( )

If ( sCol <> "" ) Then

	//	----------	Aller sur la colonne en erreur

	Dw_1.SetRedraw ( False )
	Dw_1.SetFocus	( )
	Dw_1.SetColumn ( sCol )
	Dw_1.SetRedraw ( True )
	bRet = False

Else

	//	----------	Contr$$HEX1$$f400$$ENDHEX$$le de gestion et bouton de contr$$HEX1$$f400$$ENDHEX$$le.

	sCol	= wf_ControlerGestion ( )

	If ( sCol <> "" ) Then

		//	----------	Aller sur la colonne en erreur

		Dw_1.SetRedraw ( False )
		Dw_1.SetFocus	( )
		Dw_1.SetColumn ( sCol )
		Dw_1.SetRedraw ( True )
		bRet = False

	End If

End If

Return ( bRet )

end function

public function string wf_controlergestion ();//*******************************************************************************************
// Fonction				: w_Zoom::Wf_ControlerGestion
//	Auteur					: FS
//	Date 					 	: 20/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$les de Gestion ( ctl de fond )
// Commentaires			:
//
// Arguments				: 
//
// Retourne				: "" Si Ok, Nom de la colonne si Probl$$HEX1$$e800$$ENDHEX$$me
//								  
//*******************************************************************************************



Return ( "" )
end function

public function string wf_controlersaisie ();//*******************************************************************************************
// Fonction				: w_Zoom::Wf_ControlerSaisie
//	Auteur					: FS
//	Date 					 	: 20/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$les de Saisie ( ctl de forme )
// Commentaires			:
//
// Arguments				: 
//
// Retourne				: "" Si Ok, Nom de la colonne si Probl$$HEX1$$e800$$ENDHEX$$me
//								  
//*******************************************************************************************


Return ( "" )
end function

public function boolean wf_preparermodifier ();//*******************************************************************************************
// Fonction				: Wf_PreparerModifier
//	Auteur					: FS
//	Date 					 	: 19/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Initialisations
// Commentaires			:
//
// Arguments				: 
//
// Retourne					: True / ( Client : False en cas de pb )
//								  
//*******************************************************************************************



Return ( True )
end function

on ue_imprimer;call w_ancetre::ue_imprimer;//*****************************************************************************
//
// Objet 		: W_Zoom
// Evenement 	: ue_Imprimer
//	Auteur		: FS
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Impression de la Data Window
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

dw_1.Print( True )
end on

on open;call w_ancetre::open;//*****************************************************************************
//
// Objet 		: W_Zoom
// Evenement 	: Open	
//	Auteur		: FS
//	Date			: 19/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Initialisation fen$$HEX1$$ea00$$ENDHEX$$tre de zoom
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

String  sMsg
Boolean bOk = True

istPass = Message.PowerObjectParm

If isValid( istPass ) Then

	bOk  = Dw_1.Uf_SetTransObject( istPass.trTrans )
	
	If Not Bok Then

		sMsg = f_erreurbase ( istPass.trTrans )
		MessageBox( "Erreur SetTransObjet", sMsg )

	End If

End If

If bOk Then bOk = wf_PreparerModifier()

If Not bOk Then CloseWithReturn ( This, istPass )



end on

on ue_valider;call w_ancetre::ue_valider;//*****************************************************************************
//
// Objet 		: W_Zoom
// Evenement 	: ue_Valider
//	Auteur		: FS
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Fonctions de contr$$HEX1$$f400$$ENDHEX$$les et fermeture
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Boolean bOk = True

bOk = Wf_Valider()

If bOk Then CloseWithReturn( This, istPass )
end on

on w_zoom.create
int iCurrent
call w_ancetre::create
this.dw_1=create dw_1
this.gb_1=create gb_1
this.pb_imprimer=create pb_imprimer
this.pb_valider=create pb_valider
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
this.Control[iCurrent+2]=gb_1
this.Control[iCurrent+3]=pb_imprimer
this.Control[iCurrent+4]=pb_valider
end on

on w_zoom.destroy
call w_ancetre::destroy
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.pb_imprimer)
destroy(this.pb_valider)
end on

type dw_1 from u_datawindow within w_zoom
int X=106
int Y=113
int Width=2195
int Height=913
int TabOrder=30
end type

type gb_1 from groupbox within w_zoom
int X=65
int Y=49
int Width=2277
int Height=1057
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_imprimer from u_pbimprimer within w_zoom
int X=1230
int Y=1161
int TabOrder=20
end type

type pb_valider from u_pbvalider within w_zoom
int X=906
int Y=1161
int TabOrder=10
end type

