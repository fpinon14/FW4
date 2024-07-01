HA$PBExportHeader$u_zoom.sru
$PBExportComments$------} UserObjet servant $$HEX2$$e0002000$$ENDHEX$$l'appel des fen$$HEX1$$ea00$$ENDHEX$$tres de zooms
forward
global type u_zoom from datawindow
end type
end forward

type st_zoom from structure
    string slibelle
    boolean bacces
    boolean bSaisie
    window wfenetre
    string sarg[]
    string sretour[]
end type

global type u_zoom from datawindow
int Width=961
int Height=681
int TabOrder=1
string DataObject="d_zoom"
boolean Resizable=true
event ue_bouton_haut pbm_lbuttonup
event ue_touche_bas pbm_dwnkey
event ue_touche_haut pbm_keyup
end type
global u_zoom u_zoom

type variables
Long ilLigneClick             // Num$$HEX1$$e900$$ENDHEX$$ro du zoom s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$
Boolean ibEspace = False // Espace Enfonc$$HEX1$$e900$$ENDHEX$$e

end variables

forward prototypes
public function boolean uf_plein (long allig, boolean abplein)
public function boolean uf_enabled (long allig, boolean abenabled)
public function boolean uf_activer (long allig)
end prototypes

on ue_bouton_haut;//*****************************************************************************
//
// Objet 		: Uo_Zoom
// Evenement 	: Ue_Bouton_Haut
//	Auteur		: FS
//	Date			: 18/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Gestion de l'acc$$HEX1$$e800$$ENDHEX$$s aux zooms
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Long lLig

lLig = This.GetRow()

ilLigneClick = 0

If lLig > 0 Then

	If This.GetItemString( lLig, "ZOOM_ACCES" ) = "O" Then 

		This.setItem( lLig, 5, 6 )		// .... Raised
		ilLigneClick = lLig
		SetPointer( Hourglass! )
		This.TriggerEvent ( "DoubleClicked" )

	End If

End If

	


end on

on ue_touche_bas;//*****************************************************************************
//
// Objet 		: Uo_Zoom
// Evenement 	: Ue_Touche_Bas
//	Auteur		: FS
//	Date			: 19/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Gestion de l'acc$$HEX1$$e800$$ENDHEX$$s aux zooms par touche ESPACE
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Long lLig

If KeyDown( KeySpaceBar! ) Then

	lLig = This.GetRow()
 
	If This.GetItemString( lLig, "ZOOM_ACCES" ) = "O" Then 

		This.setItem( lLig, 5, 5 )		// .... Lowered
		ibEspace = True

	End If

End If



end on

on ue_touche_haut;//*****************************************************************************
//
// Objet 		: Uo_Zoom
// Evenement 	: Ue_Touche_Haut
//	Auteur		: FS
//	Date			: 18/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Gestion de l'acc$$HEX1$$e800$$ENDHEX$$s aux zooms par touche ESPACE
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Long lLig 

If ibEspace Then

	lLig = This.GetRow()

	ilLigneClick = 0

	If This.GetItemString( lLig, "ZOOM_ACCES" ) = "O" Then 

		This.setItem( lLig, 5, 6 )		// .... Raised

		ilLigneClick = lLig
		ibEspace = False
		SetPointer( Hourglass! )

		This.TriggerEvent ( "DoubleClicked" )


	

	End If

End If



end on

public function boolean uf_plein (long allig, boolean abplein);//*******************************************************************************************
// Fonction            	: Uf_Plein
//	Auteur              	: FS
//	Date 					 	: 22/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Gestion du bitmap Plein / Vide pour les zooms de saisie
// Commentaires			:
//
// Arguments				: alLig   : N$$HEX2$$b0002000$$ENDHEX$$ligne du zoom de saisie
//                     abPlein : True ( plein ), False ( Vide )
//
// Retourne				: True / False en cas de pb
//								  
//*******************************************************************************************

String sPlein = "O"

If alLig < 1 Or alLig > This.rowCount() Then Return False

If This.GetItemString( alLig, 2 ) <> "O" Then Return False		// Ce n'est pas un zoom de saisie !

If Not abPlein Then sPlein = "N"

If This.SetItem( alLig, 3, sPlein ) <> 1 Then Return False

Return True

end function

public function boolean uf_enabled (long allig, boolean abenabled);//*******************************************************************************************
// Fonction            	: Uf_Enabled
//	Auteur              	: FS
//	Date 					 	: 22/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Gestion autorisation d'acc$$HEX1$$e800$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$une ligne de zoom
// Commentaires			:
//
// Arguments				: alLig     : N$$HEX2$$b0002000$$ENDHEX$$ligne de zoom
//                     abEnabled : True ( O = autoris$$HEX2$$e9002000$$ENDHEX$$), False ( N = interdit )
//
// Retourne		  		: True / False en cas de pb
//								  
//*******************************************************************************************

String sAcces = "O"

If alLig < 1 Or alLig > This.rowCount() Then Return False

If Not abEnabled Then sAcces = "N"

If This.SetItem( alLig, 1, sAcces ) <> 1 Then Return False

Return True

end function

public function boolean uf_activer (long allig);//*******************************************************************************************
// Fonction          	: Uf_Activer
//	Auteur            	: FS
//	Date 					 	: le 12/03/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Ouverture automatique d'une fen$$HEX1$$ea00$$ENDHEX$$tre de zoom
// Commentaires			:
//
// Arguments				: alLig : N$$HEX2$$b0002000$$ENDHEX$$du zoom $$HEX2$$e0002000$$ENDHEX$$activer
//
// Retourne				: True / False
//								  
//*******************************************************************************************

ilLigneClick = 0

If This.GetItemString( alLig, "ZOOM_ACCES" ) = "O" Then 
	
	ilLigneClick = alLig

Else

	Return False

End If

This.BringToTop = True
This.SetFocus()

This.PostEvent( "doubleclicked" )

Return True

end function

on resize;//*****************************************************************************
// Objet 		: Uo_Zoom
// Evenement 	: Resize
//	Auteur		: FS
//	Date			: 22/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Ajustement de la largeur du titre
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

//String sLargeur
//
//If This.Resizable Then
//
//	sLargeur = String( This.Width - 58 )
//Else
//
//	sLargeur = String( This.Width - 15 )
//End If
//
//This.Modify( "titre.Width='" + sLargeur + "'" )

end on

on constructor;//*****************************************************************************
//
// Objet 		: Uo_Zoom
// Evenement 	: Constructor
//	Auteur		: FS
//	Date			: 23/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Initialisation Focus et taille du titre
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

String sLargeur

If This.Resizable Then

	sLargeur = String( This.Width - 58 )
Else

	sLargeur = String( This.Width - 15 )
End If

This.Modify( "titre.Width='" + sLargeur + "'" )

This.SetRowFocusIndicator( FocusRect! )

end on

on clicked;//*****************************************************************************
//
// Objet 		: Uo_Zoom
// Evenement 	: Clicked
//	Auteur		: FS
//	Date			: 18/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Gestion de l'acc$$HEX1$$e800$$ENDHEX$$s aux zooms
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Long lLig, lPos
String sText

//lLig = This.GetClickedRow()

sText = This.GetObjectAtPointer ()

If	sText <> "" Then
	lPos		= Pos ( sText, "~t" )
	lLig 		= Long ( Mid( sText, lPos + 1 ) )

	If This.GetItemString ( lLig, "ZOOM_ACCES" ) = "O" Then 

		This.SetItem ( lLig, 5, 5 )		// .... Lowered

	End If
End If

//If lLig > 0 Then
//
//	If This.GetItemString( lLig, "ZOOM_ACCES" ) = "O" Then 
//
//		This.setItem( lLig, 5, 5 )		// .... Lowered
//
//	End If
//
//End If


end on

on getfocus;//*****************************************************************************
//
// Objet 		: Uo_Zoom
// Evenement 	: GetFocus
//	Auteur		: FS
//	Date			: 16/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Passage au Premier plan
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

This.BringToTop = True











end on

