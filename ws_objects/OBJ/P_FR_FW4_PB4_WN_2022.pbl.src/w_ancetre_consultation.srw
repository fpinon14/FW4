HA$PBExportHeader$w_ancetre_consultation.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre pour toutes les fen$$HEX1$$ea00$$ENDHEX$$tres de consultation
forward
global type w_ancetre_consultation from w_ancetre
end type
type st_titre from u_titre within w_ancetre_consultation
end type
type pb_retour from u_pbretour within w_ancetre_consultation
end type
end forward

global type w_ancetre_consultation from w_ancetre
int Width=2661
int Height=1637
boolean TitleBar=true
string Title="Fen$$HEX1$$ea00$$ENDHEX$$tre de consultation"
boolean ControlMenu=true
boolean MinBox=true
st_titre st_titre
pb_retour pb_retour
end type
global w_ancetre_consultation w_ancetre_consultation

type variables
Protected:
	Boolean		ibOpen

Public:
	Boolean		ibAInitialiser
	Long		ilNoFenetre





end variables

forward prototypes
public function boolean wf_preparerconsulter ()
public function boolean wf_terminerconsulter ()
end prototypes

public function boolean wf_preparerconsulter ();//*******************************************************************************************
// Fonction            	: w_Anc$$HEX1$$ea00$$ENDHEX$$tre_consultation::wf_PreparerConsulter
//	Auteur              	: La recrue
//	Date 					 	: 15/01/1997
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Pr$$HEX1$$e900$$ENDHEX$$paration pour la consultation
// Commentaires			: 
//								  
// Arguments				: 
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai
//								  
//*******************************************************************************************

Return ( True )
end function

public function boolean wf_terminerconsulter ();//*******************************************************************************************
// Fonction            	: w_Anc$$HEX1$$ea00$$ENDHEX$$tre_consultation::wf_TerminerConsulter
//	Auteur              	: La recrue
//	Date 					 	: 15/01/1997
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Retour de la consultation
// Commentaires			: 
//								  
// Arguments				: 
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai
//								  
//*******************************************************************************************

Return ( True )
end function

on hide;call w_ancetre::hide;//*****************************************************************************
//
// Objet 		: w_Ancetre_Consultation
// Evenement 	: Hide
//	Auteur		: La Recrue
//	Date			: 17/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Disable la fen$$HEX1$$ea00$$ENDHEX$$tre
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date			Modification
//
//*****************************************************************************

This.Enabled = False

end on

on ue_retour;call w_ancetre::ue_retour;//*****************************************************************************
//
// Objet 		: W_Traitement
// Evenement 	: Ue_Retour
//	Auteur		: D.Bizien
//	Date			: 22/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Fermeture de la fenetre de traitement
// Commentaires: Le fenetre n'est pas r$$HEX1$$e900$$ENDHEX$$ellement ferm$$HEX1$$e900$$ENDHEX$$e mais seulement cach$$HEX1$$e900$$ENDHEX$$e
//					  c'est la fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil qui la fermera 
//					  d$$HEX1$$e900$$ENDHEX$$finitivement
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	Par		17/12/1996	Ajout de la gestion des de la fermeture r$$HEX2$$e900e900$$ENDHEX$$lle de la fen$$HEX1$$ea00$$ENDHEX$$tre
//								Si besoin est.
//*****************************************************************************

If ( wf_TerminerConsulter() ) Then

	If ( Not istPass.bEnableParent ) Then
		iwParent.TriggerEvent ( "ue_EnableFenetre" )
	End If

	If ( istPass.bCloseRetour ) Then
		Close ( This )
	Else
		This.Hide ()
	End If

End If



end on

on show;call w_ancetre::show;//*****************************************************************************
//
// Objet 		: w_ancetre_consultation
// Evenement 	: Show
//	Auteur		: La Recrue
//	Date			: 17/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Enable la fen$$HEX1$$ea00$$ENDHEX$$tre
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date			Modification
//
//*****************************************************************************

This.Enabled = True

end on

on open;call w_ancetre::open;//*****************************************************************************
//
// Objet 		: w_Traitement_consultation
// Evenement 	: Open
//	Auteur		: La Recrue
//	Date			: 22/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de tconsultation
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date			Modification
//	
//*****************************************************************************


ibAInitialiser = True
ibOpen			= True
end on

on close;call w_ancetre::close;//*****************************************************************************
//
// Objet 		: w_Ancetre_Consultation
// Evenement 	: Close
//	Auteur		: La Recrue
//	Date			: 16/01/1997
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Examine si la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil consultation est en mode MDI
//					  Auquel cas, il faut supprimer cette fen$$HEX1$$ea00$$ENDHEX$$tre du compteur
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date			Modification
//
//*****************************************************************************

w_accueil_consultation	wAccueil

If ( iwParent.WindowType = Child! ) Or ( iwParent.windowType = Popup! ) Then
	wAccueil = iwParent.ParentWindow()
Else
	wAccueil = iwParent
End If

If ( wAccueil.wf_Is_Mode_Mdi() ) Then
	wAccueil.wf_Supprimer_Fille()
End If
end on

on we_childactivate;call w_ancetre::we_childactivate;//*****************************************************************************
//
// Objet 		: w_Ancetre_consultation
// Evenement 	: we_ChildActivate
//	Auteur		: La Recrue
//	Date			: 16/01/1997
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Est d$$HEX1$$e900$$ENDHEX$$clanch$$HEX2$$e9002000$$ENDHEX$$lorsque la fen$$HEX1$$ea00$$ENDHEX$$tre est montr$$HEX1$$e900$$ENDHEX$$e qu'elle soit de type
//					  Chil! ou Popup! effectue ce qui $$HEX1$$e900$$ENDHEX$$tait coder sur l'Open
// ----------------------------------------------------------------------------
// MAJ PAR		Date			Modification
//
//*****************************************************************************

Boolean						bOk

If ( ibAInitialiser ) Then

	ibAInitialiser  = False

	istPass = Message.PowerObjectParm

	itrTrans						=  istPass.trTrans	// Objet transaction de la fenetre appelante
	iwParent						=	istPass.wParent	// Fenetre Appelante ( utilis$$HEX1$$e900$$ENDHEX$$e pour enable )	

	istPass.wParent			=	This					// Fenetre appelante pour fenetre de traitment
	istPass.trTrans			=	itrTrans				// Objet de transaction par defaut

	If ( ibOpen ) Then

		This.TriggerEvent ( "ue_Initialiser" )
		IbOpen = False

	End If

	If ( Not istPass.bEnableParent ) Then
		iwParent.TriggerEvent ( "ue_DisableFenetre" )
	End If

	// Preparation avant affichage

	bOk = wf_PreparerConsulter ()
	
	// Arr$$HEX1$$ea00$$ENDHEX$$t d'ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre si probl$$HEX1$$e800$$ENDHEX$$me

	If Not bOk Then
		This.TriggerEvent ( "ue_retour" )
	Else
		This.Show()
	End If

End If
end on

on ue_disablefenetre;call w_ancetre::ue_disablefenetre;//*****************************************************************************
//
// Objet 		: w_ancetre_consultation
// Evenement 	: ue_EnableFenetre
//	Auteur		: La Recrue
//	Date			: 17/01/1997
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Rend la fen$$HEX1$$ea00$$ENDHEX$$tre courante inaccessible
// Commentaires: Est appell$$HEX2$$e9002000$$ENDHEX$$lors de l'ouverture d'une fen$$HEX1$$ea00$$ENDHEX$$tre de d$$HEX1$$e900$$ENDHEX$$tail 
//					  par la fonction f_OuvreDetail
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

This.Enabled = False

end on

on activate;call w_ancetre::activate;//*****************************************************************************
//
// Objet 		: w_Ancetre_Consultation
// Evenement 	: Activate
//	Auteur		: La Recrue
//	Date			: 17/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Declanche we_childactivate
// Commentaires: Declanch$$HEX2$$e9002000$$ENDHEX$$si la fen$$HEX1$$ea00$$ENDHEX$$tre est de type Popup!
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date			Modification
//
//*****************************************************************************

TriggerEvent( "we_childactivate" )
end on

on resize;call w_ancetre::resize;//*****************************************************************************
//
// Objet 		: w_ancetre_consultation
// Evenement 	: Resize
//	Auteur		: La Recrue
//	Date			: 17/01/1997
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Mise $$HEX2$$e0002000$$ENDHEX$$jour longueur titre lors retaillage fenetre
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

If This.Resizable Then

	st_Titre.Width = This.Width  - 40
Else

	st_Titre.Width = This.Width  - 15
End If
end on

on ue_enablefenetre;call w_ancetre::ue_enablefenetre;//*****************************************************************************
//
// Objet 		: w_ancetre_consultation
// Evenement 	: ue_EnableFenetre
//	Auteur		: La Recrue
//	Date			: 17/01/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Rend la fen$$HEX1$$ea00$$ENDHEX$$tre courante accessible
// Commentaires: Est appell$$HEX2$$e9002000$$ENDHEX$$par une fen$$HEX1$$ea00$$ENDHEX$$tre de d$$HEX1$$e900$$ENDHEX$$tail lors du retour de celui ci
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

This.Enabled = True


end on

on w_ancetre_consultation.create
int iCurrent
call w_ancetre::create
this.st_titre=create st_titre
this.pb_retour=create pb_retour
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=st_titre
this.Control[iCurrent+2]=pb_retour
end on

on w_ancetre_consultation.destroy
call w_ancetre::destroy
destroy(this.st_titre)
destroy(this.pb_retour)
end on

type st_titre from u_titre within w_ancetre_consultation
int X=5
int Y=5
int Width=2643
end type

on constructor;call u_titre::constructor;// This.Width = Parent.Width + 20
end on

type pb_retour from u_pbretour within w_ancetre_consultation
int X=37
int Y=97
int TabOrder=20
end type

