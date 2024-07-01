HA$PBExportHeader$u_pbdetail.sru
$PBExportComments$----} UserObjet Picture Bouton pour afficher les d$$HEX1$$e900$$ENDHEX$$tails d'une fen$$HEX1$$ea00$$ENDHEX$$tre de traitement master
forward
global type u_pbdetail from picturebutton
end type
end forward

global type u_pbdetail from picturebutton
int Width=266
int Height=153
int TabOrder=1
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_pbdetail u_pbdetail

type variables
Private:
	String			isNomDetail
	u_Datawindow_Detail	iuDetailAssocie
end variables

forward prototypes
public function boolean uf_associer_detail (u_datawindow_detail audetail)
end prototypes

public function boolean uf_associer_detail (u_datawindow_detail audetail);//*******************************************************************************************
// Fonction            	: Uf_Associer_Detail
//	Auteur              	: La Recrue
//	Date 					 	: 16/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Associe une datawindow de type detail au bouton
//
// Arguments				: Rien
//
// Retourne					: Le Nom du d$$HEX1$$e900$$ENDHEX$$tail
//								  
//*******************************************************************************************

If IsValid( auDetail ) Then

	iuDetailAssocie = auDetail
	Return True

Else

	Return False

End If
end function

on clicked;//*****************************************************************************
//
// Objet 		: U_Pb_Detail
// Evenement 	: Clicked
//	Auteur		: La Recrue
//	Date			: 16/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Affiche le d$$HEX1$$e900$$ENDHEX$$tail correspondant au bouton
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

If ( IsValid( iuDetailAssocie ) ) Then

	iuDetailAssocie.Show()
	iuDetailAssocie.SetFocus()
End If

end on

