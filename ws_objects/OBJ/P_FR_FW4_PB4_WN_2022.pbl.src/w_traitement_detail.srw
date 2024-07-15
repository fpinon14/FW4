HA$PBExportHeader$w_traitement_detail.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement d$$HEX1$$e900$$ENDHEX$$tail
forward
global type w_traitement_detail from w_ancetre_traitement
end type
end forward

global type w_traitement_detail from w_ancetre_traitement
end type
global w_traitement_detail w_traitement_detail

forward prototypes
public function boolean wf_executervalider ()
public function boolean wf_executersupprimer ()
end prototypes

public function boolean wf_executervalider ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_ExecuterValider
//	Auteur              	: La Recrue
//	Date 					 	: 12/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Fonction appeler dans le processus de validation.
// Commentaires			: Pour la fen$$HEX1$$ea00$$ENDHEX$$tre de detail on fait la copie sur le d$$HEX1$$e900$$ENDHEX$$tail source
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si Ok
//								  
//*******************************************************************************************

Return ( dw_1.uf_ValiderLigne ( istPass.bInsert ) )


end function

public function boolean wf_executersupprimer ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_ExecuterSupprimer
//	Auteur              	: La Recrue
//	Date 					 	: 12/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Fonction appeler dans le processus de suppression.
// Commentaires			: Pour la fen$$HEX1$$ea00$$ENDHEX$$tre de detail on fait suppression sur le d$$HEX1$$e900$$ENDHEX$$tail source
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si Ok
//								  
//*******************************************************************************************

Return ( Dw_1.uf_SupprimerLigne() )
end function

on ue_initialiser;call w_ancetre_traitement::ue_initialiser;//*****************************************************************************
//
// Objet 		: w_Traitement_Detail
// Evenement 	: ue_initialiser
//	Auteur		: La Recrue
//	Date			: 12/12/1966
// Libell$$HEX3$$e90009000900$$ENDHEX$$: initialisation d'un d$$HEX1$$e900$$ENDHEX$$tail
// Commentaires: Met en place le fonctionnement d'un d$$HEX1$$e900$$ENDHEX$$tail par d$$HEX1$$e900$$ENDHEX$$faut
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

wf_ActiverModeDetail( True )

Dw_1.uf_DetailParent( istPass.dwTab[1] )
end on

on w_traitement_detail.create
call w_ancetre_traitement::create
end on

on w_traitement_detail.destroy
call w_ancetre_traitement::destroy
end on

type dw_1 from w_ancetre_traitement`dw_1 within w_traitement_detail
int X=718
int Y=537
end type

