HA$PBExportHeader$w_ancetre_traitement.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre pour toutes les fen$$HEX1$$ea00$$ENDHEX$$tres de traitement
forward
global type w_ancetre_traitement from w_ancetre
end type
type dw_1 from u_datawindow within w_ancetre_traitement
end type
type st_titre from u_titre within w_ancetre_traitement
end type
type pb_retour from u_pbretour within w_ancetre_traitement
end type
type pb_valider from u_pbvalider within w_ancetre_traitement
end type
type pb_imprimer from u_pbimprimer within w_ancetre_traitement
end type
type pb_controler from u_pbcontroler within w_ancetre_traitement
end type
type pb_supprimer from u_pbsupprimer within w_ancetre_traitement
end type
end forward

global type w_ancetre_traitement from w_ancetre
integer width = 2661
integer height = 1636
boolean titlebar = true
string title = "Fenetre de traitement"
dw_1 dw_1
st_titre st_titre
pb_retour pb_retour
pb_valider pb_valider
pb_imprimer pb_imprimer
pb_controler pb_controler
pb_supprimer pb_supprimer
end type
global w_ancetre_traitement w_ancetre_traitement

type variables
Protected :

Boolean		IbOpen
Boolean		ibScriptClientFocus=FALSE

// JFF le 20/11/2006 Bool pour stocker le r$$HEX1$$e900$$ENDHEX$$sultat du contr$$HEX1$$f400$$ENDHEX$$le [JFF-RESCTRL-201106]
Boolean		ibResultCtrl=FALSE


DataWindow	idwControle

Public:

Boolean		ibAInitialiser

String		isMajAccueil

Boolean		ibModeDetail	// Pr$$HEX1$$e900$$ENDHEX$$cise si l'on fonctiontionne en mode d$$HEX1$$e900$$ENDHEX$$tail

Boolean		ibMajAccueil	// Pr$$HEX1$$e900$$ENDHEX$$cise si le syst$$HEX1$$e800$$ENDHEX$$me de mise $$HEX2$$e0002000$$ENDHEX$$jour de l'accueil est actif ou non

end variables

forward prototypes
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
public subroutine wf_pb_ctl_vld (integer aibouton)
public function boolean wf_controler ()
public function boolean wf_valider ()
public function boolean wf_preparervalider ()
public function boolean wf_terminervalider ()
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_supprimer ()
public function boolean wf_terminersupprimer ()
public function boolean wf_preparersupprimer ()
public function boolean wf_executervalider ()
public function boolean wf_executersupprimer ()
public subroutine wf_activermodedetail (boolean abmode)
public subroutine wf_activermajaccueil (boolean abmajaccueil)
public subroutine wf_changer_controle (datawindow adwControle)
public function boolean wf_accepttext ()
public function boolean wf_preparerabandonner ()
public function boolean wf_suite_valider ()
public subroutine wf_script_client_focus ()
end prototypes

public function boolean wf_preparerinserer ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_PreparerInserer
//	Auteur              	: D.Bizien
//	Date 					 	: 08/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Pr$$HEX1$$e900$$ENDHEX$$paration lors de l'insertion d'un nouvel enregistrement
// Commentaires			: Cette fonction doit $$HEX1$$ea00$$ENDHEX$$tre surcodifi$$HEX1$$e900$$ENDHEX$$e par le script client
//								  lors de la personnalisation d'une insertion
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai
//								  
//*******************************************************************************************

Return ( True )
end function

public function boolean wf_preparermodifier ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_PreparerModifier
//	Auteur              	: D.Bizien
//	Date 					 	: 08/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Pr$$HEX1$$e900$$ENDHEX$$paration lors de la modification d'un enregistrement
// Commentaires			: Cette fonction doit $$HEX1$$ea00$$ENDHEX$$tre surcodifi$$HEX1$$e900$$ENDHEX$$e par le script client
//								  lors de la personnalisation d'une Modification
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai
//								  
//*******************************************************************************************

Return ( True )
end function

public subroutine wf_pb_ctl_vld (integer aibouton);//*******************************************************************************************
// Fonction            	: w_Traitement::wf_Pb_Ctl_Vld
//	Auteur              	: DBI
//	Date 					 	: 11/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Activation du bouton controle ou du bouton valider
// Commentaires			: si aiBouton = 0 Activation du bouton controle et 
//								  						d$$HEX1$$e900$$ENDHEX$$sactivation du bouton valider
//								  si aiBouton = 1 Activation du bouton valider et 
//								  						d$$HEX1$$e900$$ENDHEX$$sactivation du bouton controle
//
// Arguments				: aiBouton - Integer - Bouton $$HEX2$$e0002000$$ENDHEX$$activer
//
// Retourne					: Rien
//								  
//*******************************************************************************************

Choose Case aiBouton

	Case 0	// Activation controle 

		If ( istPass.bControl ) Then

			pb_Controler.Enabled		=	True
			pb_Valider.Enabled		=	False
		End If
			
	Case 1	// Activation Valider

		pb_Valider.Enabled		=	True
		pb_Controler.Enabled		=	False
		pb_Valider.SetFocus ()

End Choose
		
end subroutine

public function boolean wf_controler ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_Controler
//	Auteur              	: D.Bizien
//	Date 					 	: 11/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Proc$$HEX1$$e900$$ENDHEX$$dure centrale de controle 
// Commentaires			: Elle appelle les fonctions de controles de saisie et de controle de gestion
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si tout Ok
//								  
//*******************************************************************************************

Boolean		bRet = True		// Retour de la fonction
String		sCol				// Colonne sur laquelle on doit repositionner le focus si erreur

// ---------- Controle de remplissage des zones obligatoires

sCol = wf_ControlerSaisie( )

If ( sCol <> "" ) Then

	//	----------	Gestion du bouton de contr$$HEX1$$f400$$ENDHEX$$le.

	wf_Pb_Ctl_Vld ( 0 )
	
	//	----------	Aller sur la colonne en erreur

	iDwControle.SetRedraw ( False )
	iDwControle.SetFocus	( )
	iDwControle.SetColumn ( sCol )
	iDwControle.SetRedraw ( True )

	bRet = False

Else

	//	----------	Contr$$HEX1$$f400$$ENDHEX$$le de gestion et bouton de contr$$HEX1$$f400$$ENDHEX$$le.

	sCol	= wf_ControlerGestion ( )

	If ( sCol <> "" ) Then

		//	----------	Gestion du bouton de contr$$HEX1$$f400$$ENDHEX$$le.

		wf_Pb_Ctl_Vld ( 0 )

		//	----------	Aller sur la colonne en erreur

		iDwControle.SetRedraw ( False )
		iDwControle.SetFocus	( )
		iDwControle.SetColumn ( sCol )
		iDwControle.SetRedraw ( True )

		bRet = False

	Else

		wf_Pb_Ctl_Vld ( 1 )

		f_MajPar ( iDwControle, 1 )
		iDwControle.SetRedraw ( False )
		Pb_Valider.SetFocus ( )
		iDwControle.SetRedraw ( True )

	End If

End If

wf_Changer_Controle( Dw_1 )
Return ( bRet )

end function

public function boolean wf_valider ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_Valider
//	Auteur              	: D.Bizien
//	Date 					 	: 18/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Fonction centrale d'Enregistrement 
// Commentaires			: 
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si Ok
//								  
//*******************************************************************************************

Boolean bOk = False

If wf_PreparerValider ( ) Then

	If wf_ExecuterValider() Then

		If ( Not ibModeDetail ) Then
		
			If wf_TerminerValider ( ) Then

				Dw_1.ResetUpdate ()
				bOk = True

			End If
		Else
			wf_TerminerValider()
			bOk = True
		End If
	End If
End If

If ( Not ibModeDetail ) Then
	f_Commit ( itrTrans, bOk )
End If

Return ( bOk )
end function

public function boolean wf_preparervalider ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_PreparerValider
//	Auteur              	: D.Bizien
//	Date 					 	: 18/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Action a effectuer avant validation
// Commentaires			: 
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si on doit continuer la validation
//								  
//*******************************************************************************************

Return ( True )
end function

public function boolean wf_terminervalider ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_TerminerValider
//	Auteur              	: D.Bizien
//	Date 					 	: 18/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Action $$HEX2$$e0002000$$ENDHEX$$effectuer apr$$HEX1$$e800$$ENDHEX$$s Validation
// Commentaires			: 
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si on doit continuer
//								  
//*******************************************************************************************

Return ( True )
end function

public function string wf_controlersaisie ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_ControlerSaisie
//	Auteur              	: D.Bizien
//	Date 					 	: 13/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Controle si toutes les zones obligatoires sont saisies
// Commentaires			: 
// Arguments				: Aucun
//
// Retourne					: String - Chaine vide si ok, nom de la colonne pour positionnement si err
//								  
//*******************************************************************************************

Return ""
end function

public function string wf_controlergestion ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_ControlerGestion
//	Auteur              	: D.Bizien
//	Date 					 	: 13/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Controle de coh$$HEX1$$e900$$ENDHEX$$rence des informations saisies
// Commentaires			: 
// Arguments				: Aucun
//
// Retourne					: String - Chaine vide si ok, nom de la colonne pour positionnement si err
//								  
//*******************************************************************************************


Return ""
end function

public function boolean wf_supprimer ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_Supprimer
//	Auteur              	: D.Bizien
//	Date 					 	: 18/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Suppression d'un enregistrement
// Commentaires			:
//
// Arguments				: Rien
//
// Retourne					: Rien
//								  
//*******************************************************************************************

Boolean bOk = False

If wf_PreparerSupprimer ( ) Then

	If wf_ExecuterSupprimer ( ) Then

		If wf_TerminerSupprimer ( ) Then

			Dw_1.ResetUpdate ( )
			bOk = True
		End If
	End If
End If

If ( Not ibModeDetail ) Then

	f_Commit ( itrTrans, bOk )
End If

Return ( bOk )


end function

public function boolean wf_terminersupprimer ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_TerminerSupprimer
//	Auteur              	: D.Bizien
//	Date 					 	: 18/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Action $$HEX2$$e0002000$$ENDHEX$$effectuer apr$$HEX1$$e800$$ENDHEX$$s validation
// Commentaires			: 
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si on doit continuer
//								  
//*******************************************************************************************

Return ( True )
end function

public function boolean wf_preparersupprimer ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_PreparerSupprimer
//	Auteur              	: D.Bizien
//	Date 					 	: 18/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Action a effectuer avant la suppression
// Commentaires			: 
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si on doit continuer la suppression
//								  
//*******************************************************************************************

Return ( True )
end function

public function boolean wf_executervalider ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_ExecuterValider
//	Auteur              	: La recrue
//	Date 					 	: 18/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Fonction d'Enregistrement 
// Commentaires			: Ueffectue un update de la datawindow ou un mise $$HEX2$$e0002000$$ENDHEX$$jour des d$$HEX1$$e900$$ENDHEX$$tail du 
//								  master selon le cas
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si Ok
//								  
//*******************************************************************************************


Return ( True )
end function

public function boolean wf_executersupprimer ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_ExecuterSupprimer
//	Auteur              	: La Recrue
//	Date 					 	: 22/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Fonction appel$$HEX1$$e900$$ENDHEX$$e dans le processus de suppresion d'une ligne
// Commentaires			:
//
// Arguments				: Rien
//
// Retourne					: Boolean Vraie si l'action s'est bien pass$$HEX1$$e900$$ENDHEX$$e
//								  
//*******************************************************************************************


Return ( True )
end function

public subroutine wf_activermodedetail (boolean abmode);//*******************************************************************************************
// Fonction            	: w__ancetre_Traitement::wf_ActiverModeDetail
//	Auteur              	: La Recrue
//	Date 					 	: 12/12/1996 
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Indique le mode de fonctionement de la fen$$HEX1$$ea00$$ENDHEX$$tre
// Commentaires			: Si le mode d$$HEX1$$e900$$ENDHEX$$tail est activ$$HEX1$$e900$$ENDHEX$$, alors les dw_1 des fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre
//								  n'effectueront pas d'update mais des copie de valeur
// Arguments				: abMode		Boolean	(Value) Bascule le mode
//
// Retourne					: Aucun
//								  
//*******************************************************************************************

ibModeDetail = abMode
end subroutine

public subroutine wf_activermajaccueil (boolean abmajaccueil);//*******************************************************************************************
//	Fonction		: wf_ancetre_Traitement::wf_ActiverMajAccueil
//	Auteur			: La Recrue
//	Date				: 24/12/1996 
//	Libell$$HEX4$$e900090009000900$$ENDHEX$$: Indique si l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement ue_MajAccueil est appel$$HEX1$$e900$$ENDHEX$$
//	Commentaires	: Si le mode d$$HEX1$$e900$$ENDHEX$$tail est activ$$HEX1$$e900$$ENDHEX$$, alors les dw_1 des fen$$HEX1$$ea00$$ENDHEX$$tres anc$$HEX1$$ea00$$ENDHEX$$tres
//						  n'effectueront pas d'update mais des copies de valeurs.
//	Arguments		: abMode		Boolean	(Value) Bascule le mode
//
//	Retourne		: Aucun
//								  
//*******************************************************************************************

ibMajAccueil = abMajAccueil
end subroutine

public subroutine wf_changer_controle (datawindow adwControle);//*******************************************************************************************
//	Fonction			: wf_ancetre_Traitement::wf_Changer_Controle
//	Auteur			: La Recrue
//	Date				: 29/12/1996 
//	Libell$$HEX4$$e900090009000900$$ENDHEX$$: Arme la variable d'instance idwControle
//
//	Commentaires	: Cette fonction est appel$$HEX1$$e900$$ENDHEX$$e dans wf_controler getion ou saisie
//						  pour changer la datawindown sur laquelle doit $$HEX1$$ea00$$ENDHEX$$tre effectu$$HEX1$$e900$$ENDHEX$$e le setcolumn()
//						  au cas ou ce ne serait pas DW_1
//			
//	Arguments		: adwControle		Datawindow	(Value) Datawindow concern$$HEX1$$e900$$ENDHEX$$e
//
//	Retourne		: Aucun
//								  
//*******************************************************************************************


idwControle = adwControle
end subroutine

public function boolean wf_accepttext ();//*******************************************************************************************
//	Fonction			: wf_ancetre_Traitement::wf_AcceptText
//	Auteur			: La Recrue
//	Date				: 29/12/1996 
//	Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fonction destin$$HEX1$$e900$$ENDHEX$$e $$HEX3$$e0002000ea00$$ENDHEX$$tre surcodifi$$HEX1$$e900$$ENDHEX$$e pour faire les Accepttext des autres
//                  datawindow que dw si elle existe.
//	Commentaires	: Elle est Appel$$HEX1$$e900$$ENDHEX$$e, par ue_controler apr$$HEX1$$e800$$ENDHEX$$s l'acceptText de Dw_1.
//
//	Arguments		: Aucun
//
//	Retourne			: True ( le contr$$HEX1$$f400$$ENDHEX$$le s'est bien pass$$HEX2$$e9002000$$ENDHEX$$)
//								  
//*******************************************************************************************

Return True
end function

public function boolean wf_preparerabandonner ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparerabandonner
//* Auteur			:	La Recrue
//* Date				:	24/03/1997 09:48:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Fonction d$$HEX1$$e900$$ENDHEX$$clanch$$HEX1$$e900$$ENDHEX$$e avant le retour sur toutes
//*						les fen$$HEX1$$ea00$$ENDHEX$$tres de traitement
//* Commentaires	:	si elle retourne Faux, le retour ne s'effectue pas
//*
//* Arguments		:	aucun
//*
//* Retourne		:	Boolean	Vrai le retour peut $$HEX1$$ea00$$ENDHEX$$tre effectuer
//*
//*-----------------------------------------------------------------


Return ( True )
end function

public function boolean wf_suite_valider ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Ancetre_Traitement::Wf_Suite_Valider (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 25/06/1998 09:40:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cette fonction est appel$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$la suite de la validation
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		True 	= On continue
//*										False = On arrete
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Cette fonction est appel$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$la suite de la validation, donc     */
/* apr$$HEX1$$e900$$ENDHEX$$s le COMMIT. Dans le cas d'un ROLLBACK, on ne vient pas      */
/* ici. Elle permet d'envoyer des commandes pour les BLOBS en       */
/* SqlServer.                                                       */
/*------------------------------------------------------------------*/

Return ( True )
end function

public subroutine wf_script_client_focus ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Ancetre_Traitement::Wf_Script_Client_Focus		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 31/01/2002 14:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On utilise cette fonction $$HEX2$$e0002000$$ENDHEX$$la fin de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ment Ue_Controler
//*					  afin de positionner le focus sur une autre fen$$HEX1$$ea00$$ENDHEX$$tre
//*					  On utilise cette m$$HEX1$$e900$$ENDHEX$$thode dans le cas de Saisie/Validation/Edition
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*														
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------
end subroutine

event ue_controler;call super::ue_controler;//*****************************************************************************
//
// Objet 		: w_Traitement
// Evenement 	: ue_Controler
//	Auteur		: D.Bizien
//	Date			: 11/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Controle des informations de la fen$$HEX1$$ea00$$ENDHEX$$tre
// Commentaires: Le 07/04/1996 -> Erick John Stark 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	
// EJS			07/04/1996 Ajout d'un AcceptText pour envoyer un ItemChanged()
// JFF 	#1	   20/11/2006 Gestion du r$$HEX1$$e900$$ENDHEX$$sultat du contr$$HEX1$$f400$$ENDHEX$$le [JFF-RESCTRL-201106]
//*****************************************************************************

If	dw_1.AcceptText () > 0 Then
	If wf_AcceptText() Then

	ibResultCtrl = wf_Controler ()  //#1 [JFF-RESCTRL-201106]

/*------------------------------------------------------------------*/
/* Ajout d'une fonction pour permettre le basculement du focus sur  */
/* une autre fen$$HEX1$$ea00$$ENDHEX$$tre.                                               */
/* M$$HEX1$$e900$$ENDHEX$$thode utilis$$HEX1$$e900$$ENDHEX$$e pour la premi$$HEX1$$e800$$ENDHEX$$re ouverture du WORD dans la      */
/* m$$HEX1$$e900$$ENDHEX$$thode Saisie/Validation/Edition.                               */
/*------------------------------------------------------------------*/
		Wf_Script_Client_Focus ()
	End If
Else
	dw_1.SetFocus ()
End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event activate;call super::activate;//*****************************************************************************
//
// Objet 		: w_Ancetre_Traitement
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

//Migration PB8-WYNIWYG-03/2006 FM
//TriggerEvent( "we_childactivate" )
Return This.Event we_childactivate()
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_valider;call super::ue_valider;//*****************************************************************************
//
// Objet 		: w_Traitement
// Evenement 	: ue_Valider
//	Auteur		: D.Bizien
//	Date			: 13/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Enregistrement des informations
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	La Recrue	20/02/97	MOD-0017
// $$HEX2$$e0002000$$ENDHEX$$la fin du script execution d'un PostEvent pour la fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre
// apr$$HEX1$$e800$$ENDHEX$$s une validation.
//*****************************************************************************

Boolean bRet

s_Pass	stPass

SetPointer( HourGlass! )

If dw_1.AcceptText () > 0 Then

	If ( Not istPass.bControl ) Then

		If ( Not wf_Controler() ) Then

			dw_1.setFocus()
			Return
		End If
	End If

	bRet = Wf_Valider ()
/*------------------------------------------------------------------*/
/* Le COMMIT ou le ROLLBACK vient d'avoir lieu.                     */
/*------------------------------------------------------------------*/
	If	bRet	Then
		If ( ibMajAccueil ) Then
			If istPass.bInsert Then
				stPass.sTab[1] = "CRE"
			Else
				stPass.sTab[1] = "MOD"
			End If

			isMajAccueil 		= ""	
			This.TriggerEvent ( "ue_MajAccueil" )
			stPass.sTab[2]	= isMajAccueil

			Message.PowerObjectParm = stPass

			If ( IsValid( dw_1.iuDwdetailSource ) ) Then
				If ( Not ibModeDetail ) Then
					dw_1.iudwdetailsource.TriggerEvent ( "ue_MajAccueil" )
				End If
			Else
				iwParent.TriggerEvent ( "ue_MajAccueil" )
			End If

		End If
	End If
/*------------------------------------------------------------------*/
/* On peut envoyer d'autres UPDATES. Au script client d'effectuer   */
/* le COMMIT ou le ROLLBACK. (Cas des BLOBS)                        */
/*------------------------------------------------------------------*/
	If	bRet	Then
		bRet = Wf_Suite_Valider ()
	End If

/*------------------------------------------------------------------*/
/* Gestion du retour sur la grille d'accueil, si tout se passe      */
/* bien.                                                            */
/*------------------------------------------------------------------*/
	If	bRet	Then
//Migration PB8-WYNIWYG-03/2006 FM
//		This.PostEvent( "ue_retour" )
//si tout s'est bien pass$$HEX1$$e900$$ENDHEX$$, on appel le retour avec (0,0) en param$$HEX1$$e800$$ENDHEX$$tre
		This.PostEvent( "ue_retour", 0, 0 )
//Fin Migration PB8-WYNIWYG-03/2006 FM
	End If

Else

	dw_1.SetFocus ()

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_retour;call super::ue_retour;//*****************************************************************************
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
//	Par		24/03/1997	Ajout de la focntion wf_PreparerAbandonner
//*****************************************************************************

Long		lPrepare
Boolean	bOk

lPrepare = Message.WordParm

If lPrepare = 1 Then
	bOk = Wf_PreparerAbandonner() 
Else
	bOk = True
End If

If ( bOk ) Then

	If ( Not istPass.bEnableParent ) Then
		iwParent.TriggerEvent ( "ue_EnableFenetre" )
	End If

	If ( ibModeDetail ) Then
		If ( IsValid ( dw_1.iudwDetailSource ) ) Then
			dw_1.iudwDetailSource.SetFocus()
		End If
	End If

	If ( istPass.bCloseRetour ) Then
		Close ( This )
	Else
		dw_1.SetRedraw( True )
		This.Hide ()
	End If

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event we_childactivate;call super::we_childactivate;//*****************************************************************************
//
// Objet 		: w_Ancetre_Traitement
// Evenement 	: we_ChildActivate
//	Auteur		: La Recrue
//	Date			: 17/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Est d$$HEX1$$e900$$ENDHEX$$clanch$$HEX2$$e9002000$$ENDHEX$$lorsque la fen$$HEX1$$ea00$$ENDHEX$$tre est montr$$HEX1$$e900$$ENDHEX$$e qu'elle soit de type
//					  Chil! ou Popup! effectue ce qui $$HEX1$$e900$$ENDHEX$$tait coder sur l'Open
// ----------------------------------------------------------------------------
// MAJ PAR		Date			Modification
//
//*****************************************************************************

Boolean					bOk
w_traitement_master	wMasterParent

If ( ibAInitialiser ) Then

	ibAInitialiser  = False

	istPass = Message.PowerObjectParm

	itrTrans						=  istPass.trTrans	// Objet transaction de la fenetre appelante
	iwParent						=	istPass.wParent	// Fenetre Appelante ( utilis$$HEX1$$e900$$ENDHEX$$e pour enable )	

	istPass.wParent			=	This			// Fenetre appelante pour fenetre de traitment
	istPass.trTrans			=	itrTrans		// Objet de transaction par defaut
//	istPass.bEnableParent	= 	False			// Doit on rendre la fenetre appelante disable
														// lors de l'appel d'une fen$$HEX1$$ea00$$ENDHEX$$tre de traitement	This.TriggerEvent ( "ue_Initialiser" )
//	istPass.bCloseRetour		=	False			// Doit on fermer la fen$$HEX1$$ea00$$ENDHEX$$tre sur le bouton retour. D$$HEX1$$e900$$ENDHEX$$cision du script client


	wf_ActiverMajAccueil( True )	

	// Si il s'agit d'une fen$$HEX1$$ea00$$ENDHEX$$tre fille d'un master on la stock pour pouvoir la fermer

	If ( ibOpen ) Then

		If ( iwParent.WindowType = Child! ) Or ( iwParent.windowType = Popup! ) Then
			wMasterParent = iwParent
			wMasterParent.wf_AjouterDetail( This )
		End If

		This.TriggerEvent ( "ue_Initialiser" )
		IbOpen = False

	End If

	If ( Not istPass.bEnableParent ) Then
		iwParent.TriggerEvent ( "ue_DisableFenetre" )
	End If

	// Initialisation des variables d'instance

	Dw_1.ibErreur 	= False
	Dw_1.isNomCol	= ""
	Dw_1.isErrCol	= ""

	// Positionnement des boutons Controle et valider

	If Not istPass.bControl Then

		wf_Pb_Ctl_Vld ( 1 )	// Directement bouton valider

	Else

		wf_Pb_Ctl_Vld ( 0 )	// Controle + Valide

	End If

	// Preparation avant affichage

	If istPass.bInsert Then

		pb_Supprimer.Enabled = False
		Dw_1.Reset ()
		Dw_1.InsertRow ( 0 )
		f_CreeLe ( Dw_1, 1 )
		f_MajPar ( Dw_1, 1 )
		bOk = wf_PreparerInserer ()
	
	Else

		pb_Supprimer.Enabled = istPass.bSupprime
		bOk = wf_PreparerModifier ()

	End If

	// Arr$$HEX1$$ea00$$ENDHEX$$t d'ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre si probl$$HEX1$$e800$$ENDHEX$$me

	If Not bOk Then

		This.TriggerEvent ( "ue_retour" )
	Else
		wf_Changer_Controle( Dw_1 )

		If ( ibModeDetail ) Then

/*------------------------------------------------------------------*/
/* Uniquement pour que la datawindow puisse retrouver ses petits    */
/* lors d'un RowCopy. ( Bug Pb )                                    */
/*------------------------------------------------------------------*/

			dw_1.SetSort(dw_1.isTri)
			dw_1.Sort()

		End If

		This.Show()
		Dw_1.SetFocus ()

	End If

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_supprimer;call super::ue_supprimer;//*****************************************************************************
//
// Objet 		: w_Traitement
// Evenement 	: ue_Supprimer
//	Auteur		: D.Bizien
//	Date			: 18/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Suppression des informations
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	La Recrue	20/02/97	MOD-0017
// $$HEX2$$e0002000$$ENDHEX$$la fin du script execution d'un PostEvent pour la fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre
// apr$$HEX1$$e800$$ENDHEX$$s une suppression.
//*****************************************************************************

s_Pass	stPass

SetPointer( HourGlass! )

dw_1.SetRedraw ( False )

If wf_Supprimer () Then

	If ( ibMajAccueil ) Then

		stPass.sTab[1] = "SUP"

		isMajAccueil 		= ""	

		Message.PowerObjectParm = stPass

		If ( IsValid( dw_1.iuDwdetailSource ) ) Then
			If ( Not ibModeDetail ) Then
				dw_1.iudwdetailsource.TriggerEvent ( "ue_MajAccueil" )
			End If
		Else
			iwParent.TriggerEvent ( "ue_MajAccueil" )
		End If

	End If

	This.PostEvent( "ue_retour" )

Else

	dw_1.SetRedraw( True )

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event open;call super::open;//*****************************************************************************
//
// Objet 		: w_Traitement
// Evenement 	: Open
//	Auteur		: D.Bizien
//	Date			: 22/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date			Modification
//	PAR			17/12/1996	Ce qui $$HEX1$$e900$$ENDHEX$$tait fait sur l'Open avant est fait sur
//									l'activate d$$HEX1$$e900$$ENDHEX$$sormais.
//									le booleen ibDejaOuvert $$HEX2$$e0002000$$ENDHEX$$disparu, la fonction
//									f_ouvre_traitement $$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$modifi$$HEX1$$e900$$ENDHEX$$e.
//*****************************************************************************

ibAInitialiser = True
ibModeDetail 	= False // Par defaut une fenetre est en mode normal

ibOpen = True

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_imprimer;call super::ue_imprimer;//*****************************************************************************
//
// Objet 		: w_Traitement
// Evenement 	: ue_Imprimer
//	Auteur		: La Recrue
//	Date			: 17/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Impression de la dw_1
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

//Migration PB8-WYNIWYG-03/2006 FM
//dw_1.Print()
Return dw_1.Print()
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_disablefenetre;call super::ue_disablefenetre;//*****************************************************************************
//
// Objet 		: W_Traitement
// Evenement 	: ue_EnableFenetre
//	Auteur		: D.Bizien
//	Date			: 22/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Rend la fen$$HEX1$$ea00$$ENDHEX$$tre courante inaccessible
// Commentaires: Est appell$$HEX2$$e9002000$$ENDHEX$$lors de l'ouverture d'une fen$$HEX1$$ea00$$ENDHEX$$tre de d$$HEX1$$e900$$ENDHEX$$tail 
//					  par la fonction f_OuvreDetail
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

This.Enabled = False

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event resize;call super::resize;//*****************************************************************************
//
// Objet 		: w_Traitement
// Evenement 	: Resize
//	Auteur		: D.Bizien
//	Date			: 22/02/1996
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

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_enablefenetre;call super::ue_enablefenetre;//*****************************************************************************
//
// Objet 		: W_Traitement
// Evenement 	: ue_EnableFenetre
//	Auteur		: D.Bizien
//	Date			: 22/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Rend la fen$$HEX1$$ea00$$ENDHEX$$tre courante accessible
// Commentaires: Est appell$$HEX2$$e9002000$$ENDHEX$$par une fen$$HEX1$$ea00$$ENDHEX$$tre de d$$HEX1$$e900$$ENDHEX$$tail lors du retour de celui ci
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

This.Enabled = True

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_ancetre_traitement.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_titre=create st_titre
this.pb_retour=create pb_retour
this.pb_valider=create pb_valider
this.pb_imprimer=create pb_imprimer
this.pb_controler=create pb_controler
this.pb_supprimer=create pb_supprimer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_titre
this.Control[iCurrent+3]=this.pb_retour
this.Control[iCurrent+4]=this.pb_valider
this.Control[iCurrent+5]=this.pb_imprimer
this.Control[iCurrent+6]=this.pb_controler
this.Control[iCurrent+7]=this.pb_supprimer
end on

on w_ancetre_traitement.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_titre)
destroy(this.pb_retour)
destroy(this.pb_valider)
destroy(this.pb_imprimer)
destroy(this.pb_controler)
destroy(this.pb_supprimer)
end on

event show;call super::show;//*****************************************************************************
//
// Objet 		: w_Ancetre_Traitement
// Evenement 	: Hide
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

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event hide;call super::hide;//*****************************************************************************
//
// Objet 		: w_Ancetre_Traitement
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

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_1 from u_datawindow within w_ancetre_traitement
integer x = 800
integer y = 516
integer taborder = 10
end type

type st_titre from u_titre within w_ancetre_traitement
integer x = 5
integer y = 4
integer width = 2642
integer height = 64
end type

on constructor;call u_titre::constructor;// This.Width = Parent.Width + 20
end on

type pb_retour from u_pbretour within w_ancetre_traitement
integer x = 37
integer y = 96
integer width = 265
integer height = 152
integer taborder = 20
end type

type pb_valider from u_pbvalider within w_ancetre_traitement
integer x = 594
integer y = 96
integer width = 265
integer height = 152
integer taborder = 40
end type

on losefocus;call u_pbvalider::losefocus;//*****************************************************************************
//
// Objet 		: w_Traitement::pb_Valider
// Evenement 	: LoseFocus
//	Auteur		: D.Bizien
//	Date			: 11/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Perte de focus du bouton valider
// Commentaires: Si le principe du controle/Valider est demand$$HEX1$$e900$$ENDHEX$$, on rend 
//					  inaccessible le bouton valider et accessible le bouton controle
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

If istPass.bControl Then

	wf_Pb_Ctl_Vld ( 0 )
End If
end on

type pb_imprimer from u_pbimprimer within w_ancetre_traitement
integer x = 1152
integer y = 96
integer width = 265
integer height = 152
integer taborder = 60
end type

type pb_controler from u_pbcontroler within w_ancetre_traitement
integer x = 315
integer y = 96
integer taborder = 30
end type

type pb_supprimer from u_pbsupprimer within w_ancetre_traitement
integer x = 873
integer y = 96
integer width = 265
integer height = 152
integer taborder = 50
end type

