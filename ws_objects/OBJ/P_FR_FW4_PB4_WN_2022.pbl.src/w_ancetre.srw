HA$PBExportHeader$w_ancetre.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre pour toutes les fen$$HEX1$$ea00$$ENDHEX$$tres de gestion
forward
global type w_ancetre from window
end type
type cb_debug from commandbutton within w_ancetre
end type
end forward

global type w_ancetre from window
boolean visible = false
integer x = 1074
integer y = 480
integer width = 1211
integer height = 600
windowtype windowtype = child!
long backcolor = 12632256
event we_childactivate pbm_childactivate
event ue_retour pbm_custom75
event ue_creer pbm_custom74
event ue_interro pbm_custom73
event ue_supprimer pbm_custom72
event ue_controler pbm_custom71
event ue_valider pbm_custom70
event ue_fin_interro pbm_custom69
event ue_fermer_interro pbm_custom68
event ue_imprimer pbm_custom67
event ue_preparer_interro pbm_custom66
event ue_initialiser pbm_custom65
event ue_enablefenetre pbm_custom64
event ue_disablefenetre pbm_custom63
event ue_trier pbm_custom62
event ue_centreracc pbm_custom61
event ue_taillerhauteur pbm_custom60
event ue_majaccueil pbm_custom59
event ue_modifier pbm_custom58
event ue_item5 pbm_custom57
event ue_item6 pbm_custom56
event ue_item7 pbm_custom55
event ue_item8 pbm_custom54
event ue_item9 pbm_custom53
event ue_item11 pbm_custom52
event ue_item12 pbm_custom51
event ue_item13 pbm_custom50
event ue_item14 pbm_custom49
event ue_item15 pbm_custom48
event ue_routage pbm_custom40
cb_debug cb_debug
end type
global w_ancetre w_ancetre

type variables
Private:
	Boolean	ibOccupe
Public:
s_Pass		istPass	// Structure de passage entre fenetres
u_transaction 	itrTrans 	// Objet de transaction de la fen$$HEX1$$ea00$$ENDHEX$$tre
Window		iwParent 	// Fenetre parent li$$HEX1$$e900$$ENDHEX$$e 
String		isSectionAppli // Section dans le .INI ou se trouve le code appli consult
String		isFichierIni // Fichier INI ou se trouve le code appli consult

end variables

forward prototypes
public subroutine wf_codappli ()
public function boolean wf_getiboccupe ()
end prototypes

on ue_enablefenetre;//*-----------------------------------------------------------------
//*
//* Objet			:	w_ancetre
//* Evenement 		:	ue_enableFenetre	
//* Auteur			:	La Recrue
//* Date				:	19/03/1997 10:58:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ibOccupe = False
end on

on ue_disablefenetre;//*-----------------------------------------------------------------
//*
//* Objet			:	w_ancetre
//* Evenement 		:	ue_disablefenetre
//* Auteur			:	La Recrue
//* Date				:	19/03/1997 10:59:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

ibOccupe = True
end on

public subroutine wf_codappli ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_CodAppli
//* Auteur			: DBI
//* Date				: 18/12/1997 18:16:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Positionnement de stGlb.sCodAppli pour appli de consult
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*						
//*
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* stGlb.sCodAppli est repositionn$$HEX2$$e9002000$$ENDHEX$$avec la m$$HEX1$$ea00$$ENDHEX$$me valeur que ce qui existait   */
/* pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$demment si l'entr$$HEX1$$e900$$ENDHEX$$e dans le fichier INI n'existe pas                  */
/*                                                                            */
/* Dans le cas contraire, il est arm$$HEX2$$e9002000$$ENDHEX$$avec la section COD_APPLI positionn$$HEX5$$e9002000200020002000$$ENDHEX$$*/
/* dans le .INI                                                               */
/*                                                                            */
/* Cette modif sert $$HEX2$$e0002000$$ENDHEX$$basculer le cod_appli pour la saisie effectu$$HEX1$$e900$$ENDHEX$$e $$HEX9$$e00020002000200020002000200020002000$$ENDHEX$$*/
/* partir de la consultation.                                                 */
/*----------------------------------------------------------------------------*/

stGlb.sCodAppli	=	ProfileString ( 				&
								isFichierIni, 				&
								isSectionAppli,			&
								"COD_APPLI",				&
								stGlb.sCodAppli )


end subroutine

public function boolean wf_getiboccupe ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_GetIbOccupe
//* Auteur			: FABRY JF
//* Date				: 18/05/2001 18:16:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Retourne ibOccupe
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*						
//*
//*-----------------------------------------------------------------


Return ibOccupe
end function

event activate;//*-----------------------------------------------------------------
//*
//* Objet			:	w_ancetre
//* Evenement 		:	Activate
//* Auteur			:	DBI
//* Date				:	19/12/1997 10:56:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Appel wf_CodAppli pour Consultation centralis$$HEX1$$e900$$ENDHEX$$e
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

wf_CodAppli ( )

end event

on w_ancetre.create
this.cb_debug=create cb_debug
this.Control[]={this.cb_debug}
end on

on w_ancetre.destroy
destroy(this.cb_debug)
end on

on closequery;//*-----------------------------------------------------------------
//*
//* Objet			:	w_ancetre
//* Evenement 		:	CloseQuery
//* Auteur			:	La Recrue
//* Date				:	19/03/1997 10:56:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ne fermer pas la fen$$HEX1$$ea00$$ENDHEX$$tre si elle est occup$$HEX1$$e900$$ENDHEX$$e.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If ( ibOccupe ) Then

	Message.Processed = True
	Message.ReturnValue 	= 1

End If
end on

type cb_debug from commandbutton within w_ancetre
boolean visible = false
integer x = 14
integer y = 12
integer width = 215
integer height = 44
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "debug"
end type

event clicked;messagebox("DEBUG", "Nom Fenetre : " + Parent.ClassName())
end event

