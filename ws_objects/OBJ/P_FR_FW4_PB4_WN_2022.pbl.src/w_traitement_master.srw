HA$PBExportHeader$w_traitement_master.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitment ma$$HEX1$$ee00$$ENDHEX$$tre
forward
global type w_traitement_master from w_ancetre_traitement
end type
end forward

global type w_traitement_master from w_ancetre_traitement
integer x = 1075
integer y = 481
event ue_changerdetail pbm_custom47
event ue_supprimerdetail pbm_custom46
end type
global w_traitement_master w_traitement_master

type variables
Private:
	Window		iwTraitement[]


Public:
	String		isDetailActif //D$$HEX1$$e900$$ENDHEX$$tail actif qui $$HEX2$$e0002000$$ENDHEX$$le focus ou qui est demander par bouton
end variables

forward prototypes
public subroutine wf_ajouterdetail (window awtraitement)
public function boolean wf_executervalider ()
public function boolean wf_executersupprimer ()
end prototypes

event ue_changerdetail;//*****************************************************************************
//
// Objet 		: w_Traitement_Master
// Evenement 	: ue_changerdetail
//	Auteur		: La recrue
//	Date			: 17/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Recup$$HEX1$$e800$$ENDHEX$$re le nom du d$$HEX1$$e900$$ENDHEX$$tail qui prend le focus et affecte la variable d'instance
// Commentaires: Est d$$HEX1$$e900$$ENDHEX$$clanch$$HEX2$$e9002000$$ENDHEX$$par le d$$HEX1$$e900$$ENDHEX$$tail qui prend le focus.
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

u_Datawindow_Detail uDetailCourrant

If Message.LongParm = 1 Then

	isDetailActif = ""
	
Else

	If ( TypeOf( GetFocus() ) = Datawindow! ) Then

		uDetailCourrant	= GetFocus()
		isDetailActif		= uDetailCourrant.uf_Nom_Detail()

	End If

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

public subroutine wf_ajouterdetail (window awtraitement);
iwTraitement[UpperBound(iwTraitement) + 1]=awTraitement
end subroutine

public function boolean wf_executervalider ();//*******************************************************************************************
// Fonction            	: w_Traitement_Master::wf_ExecuterValider
//	Auteur              	: La Recrue
//	Date 					 	: 12/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Fonction appeler dans le processus de validation.
// Commentaires			: Pour la fen$$HEX1$$ea00$$ENDHEX$$tre de detail on fait la copie sur le d$$HEX1$$e900$$ENDHEX$$tail source
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si Ok
//								  
//*******************************************************************************************


If ( ibModeDetail ) Then
	Return ( dw_1.uf_ValiderLigne ( istPass.bInsert ) )
Else
	Return ( dw_1.uf_Update() )
End If
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

If ( ibModeDetail ) Then
	Return ( Dw_1.uf_SupprimerLigne() )
Else
	Return ( dw_1.uf_Update() )
End If


end function

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_traitement_master
//* Evenement 		: Close
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6, PAR, DBI
//* Date				: 06/03/1997 16:24:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fermeture des fen$$HEX1$$ea00$$ENDHEX$$tres de traitements ouvertes 
//*						et filles en cascade
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long	lI

If ( UpperBound( iwTraitement ) > 0 ) Then

	For li = 1 To UpperBound( iwTraitement )

		If ( isValid ( iwTraitement[ lI ] ) ) Then

			Close ( iwTraitement[ lI ] )

		End If

	Next

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_majaccueil;call super::ue_majaccueil;//*****************************************************************************
//
// Objet 		: w_Traitement_Master
// Evenement 	: ue_MajAccueil
//	Auteur		: La recrue
//	Date			: 17/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Declange le MajAccueil d'un d$$HEX1$$e900$$ENDHEX$$tail si ilest actif
// Commentaires: Est d$$HEX1$$e900$$ENDHEX$$clanch$$HEX2$$e9002000$$ENDHEX$$par le d$$HEX1$$e900$$ENDHEX$$tail qui prend le focus.
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_initialiser;call super::ue_initialiser;//*****************************************************************************
//
// Objet 		: w_Traitement_Master
// Evenement 	: ue_initialise
//	Auteur		: La recrue
//	Date			: 17/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Plus aucun d$$HEX1$$e900$$ENDHEX$$tail n'est actif
// Commentaires: 
//
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

isDetailActif = ""

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_traitement_master.create
call super::create
end on

on w_traitement_master.destroy
call super::destroy
end on

type dw_1 from w_ancetre_traitement`dw_1 within w_traitement_master
end type

type st_titre from w_ancetre_traitement`st_titre within w_traitement_master
end type

type pb_retour from w_ancetre_traitement`pb_retour within w_traitement_master
end type

type pb_valider from w_ancetre_traitement`pb_valider within w_traitement_master
end type

type pb_imprimer from w_ancetre_traitement`pb_imprimer within w_traitement_master
end type

type pb_controler from w_ancetre_traitement`pb_controler within w_traitement_master
end type

type pb_supprimer from w_ancetre_traitement`pb_supprimer within w_traitement_master
end type

