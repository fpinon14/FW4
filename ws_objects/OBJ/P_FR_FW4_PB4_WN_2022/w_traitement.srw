HA$PBExportHeader$w_traitement.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement simple
forward
global type w_traitement from w_ancetre_traitement
end type
end forward

global type w_traitement from w_ancetre_traitement
end type
global w_traitement w_traitement

forward prototypes
public function boolean wf_executervalider ()
public function boolean wf_executersupprimer ()
end prototypes

public function boolean wf_executervalider ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_ExecuterValider
//	Auteur              	: La Recrue
//	Date 					 	: 12/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Fonction appeler dans le processus de validation.
// Commentaires			: Pour la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement simple on fait l'update de la DW
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si Ok
//								  
//*******************************************************************************************

Return ( dw_1.uf_Update() )
end function

public function boolean wf_executersupprimer ();//*******************************************************************************************
// Fonction            	: w_Traitement::wf_ExecuterSupprimer
//	Auteur              	: La Recrue
//	Date 					 	: 12/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Fonction appel$$HEX1$$e900$$ENDHEX$$e dans le processus de suppression
// Commentaires			: pour de qui est de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement simple, on fait l'update
//								  de la datawindow	
// Arguments				: Rien
//
// Retourne					: Rien
//								  
//*******************************************************************************************


Return ( dw_1.uf_Update() )
end function

on ue_initialiser;call w_ancetre_traitement::ue_initialiser;//*****************************************************************************
//
// Objet 		: w_Traitement
// Evenement 	: ue_initialiser
//	Auteur		: La Recrue
//	Date			: 12/12/1966
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Affectation du d$$HEX1$$e900$$ENDHEX$$tail parent si l'on vient d'un master
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************


If ( UpperBound ( istPass.dwTab ) > 0 ) Then
	Dw_1.uf_DetailParent( istPass.dwTab[1] )
End If
end on

on w_traitement.create
call w_ancetre_traitement::create
end on

on w_traitement.destroy
call w_ancetre_traitement::destroy
end on

