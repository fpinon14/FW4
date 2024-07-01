HA$PBExportHeader$u_rapport.sru
$PBExportComments$------} UserObjet servant $$HEX2$$e0002000$$ENDHEX$$afficher du texte
forward
global type u_rapport from multilineedit
end type
end forward

global type u_rapport from multilineedit
integer y = 532
integer width = 1989
integer height = 516
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = styleraised!
end type
global u_rapport u_rapport

type variables
Private:

	Boolean		ibTraceContenu
	String		isFichierTrace
	String		isOperateur

	String		isAncienText
	String		isTextCourrant

	Long		ilAnciennePosition
	Long		ilPosition
end variables

forward prototypes
public function boolean uf_activertrace (s_glb astglb, boolean abactivation, string asfichier)
private function boolean uf_tracer (string asligne)
public subroutine uf_effacertext ()
public subroutine uf_ecriretext (string astext)
public subroutine uf_ajoutertext (string astext)
public subroutine uf_remplacertext (string astext)
end prototypes

public function boolean uf_activertrace (s_glb astglb, boolean abactivation, string asfichier);//*******************************************************************************************
// Fonction            	: Uf_ActiverTrace
//	Auteur              	: La Recrue
//	Date 					 	: 13/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Permet d'activer ou de d$$HEX1$$e900$$ENDHEX$$sactiver Le Logue du contenu dela multiline
//
// Arguments				: Boolean		abActivation	(Val)	Choix d'activation ou non
//								  String			sFichier			(Val) Nom du fichier de trace
//
// Retourne					: (None)
//								  
//*******************************************************************************************

ibTraceContenu = abActivation

If ( ibTraceContenu ) Then

	isFichierTrace = asFichier
	isOperateur		= astGlb.sCodOper

	If ( Not Uf_Tracer( "Activation de la trace" ) ) Then

		isFichierTrace = ""
		isOperateur		= ""
		ibTraceContenu = False

		Return ( False )

	End If

Else

		isFichierTrace = ""
		isOperateur		= ""

End If

Return ( True )
end function

private function boolean uf_tracer (string asligne);//*******************************************************************************************
// Fonction            	: Uf_Tracer
//	Auteur              	: La Recrue
//	Date 					 	: 13/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Ecrit une ligne dans le fichier trace
//
// Arguments				: String			asLigne			(Val) Ligne $$HEX2$$e0002000$$ENDHEX$$Ecrire dans le fichier
//
// Retourne					: Boolean	Vrai la ligne peut $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$crite
//								  
//*******************************************************************************************

Integer	iHandle
String	sLigne

//Migration PB8-WYNIWYG-03/2006 CP
//If ( FileExists ( isFichierTrace ) ) Then
If ( f_FileExists ( isFichierTrace ) ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP	
	
	iHandle = FileOpen( isFichierTrace, LineMode!, Write!, Shared!, Append! )

Else

	iHandle = FileOpen( isFichierTrace, LineMode!, Write!, Shared! )

End If

If ( iHandle = -1 ) Then Return ( False )

sLigne = String ( DateTime( Today(), Now() ) ) + "~t" + isOperateur + "~t" + asLigne

If ( FileWrite( iHandle, sLigne ) = -1 ) Then Return ( False )

FileClose( iHandle )

Return ( True )
end function

public subroutine uf_effacertext ();//*******************************************************************************************
// Fonction            	: Uf_EffacerText
//	Auteur              	: La Recrue
//	Date 					 	: 13/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Permet de r$$HEX1$$e900$$ENDHEX$$initialiser le text de la Multiline
//
// Arguments				: Aucun
//
// Retourne					: (None)
//								  
//*******************************************************************************************

This.Text= ""

ilAnciennePosition	= Position()
ilPosition 				= Position()

If ( ibTraceContenu ) Then

	uf_Tracer ( "Effacement du contenu" )

End If


end subroutine

public subroutine uf_ecriretext (string astext);//*******************************************************************************************
// Fonction            	: Uf_EcrireText
//	Auteur              	: La Recrue
//	Date 					 	: 13/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Ecrit le texte $$HEX2$$e0002000$$ENDHEX$$la place du texte existant
//
// Arguments				: String		asText	( Val )	Texte $$HEX2$$e0002000$$ENDHEX$$Ecrire
//
// Retourne					: (None)
//								  
//*******************************************************************************************

This.Text		= ""

ilAnciennePosition = This.Position()
This.ReplaceText ( asText )
ilPosition = This.Position()

isAncienText	= asText
isTextCourrant	= asText

If ( ibTraceContenu ) Then
	uf_Tracer ( asText )
End If

end subroutine

public subroutine uf_ajoutertext (string astext);//*******************************************************************************************
// Fonction            	: Uf_AjouterText
//	Auteur              	: La Recrue
//	Date 					 	: 13/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Ecrit le texts $$HEX2$$e0002000$$ENDHEX$$la fin du text existant
//
// Arguments				: String		asText	( Val )	Texte $$HEX2$$e0002000$$ENDHEX$$Ecrire
//
// Retourne					: (None)
//								  
//*******************************************************************************************

isAncienText	= This.Text
//This.Text		= isAncienText + asText

This.ilAnciennePosition = This.Position()
This.ReplaceText ( asText )
This.ilPosition = This.Position()

isTextCourrant	= This.Text

If ( ibTraceContenu ) Then
	uf_Tracer ( asText )
End If

end subroutine

public subroutine uf_remplacertext (string astext);//*******************************************************************************************
// Fonction            	: Uf_RemplacerText
//	Auteur              	: La Recrue
//	Date 					 	: 13/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Ecrite le texte $$HEX2$$e0002000$$ENDHEX$$la place du dernier texte pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$demment $$HEX1$$e900$$ENDHEX$$crit.
//
// Arguments				: String		asText	( Val )	Texte $$HEX2$$e0002000$$ENDHEX$$Ecrire
//
// Retourne					: (None)
//								  
//*******************************************************************************************

This.Text		= isAncienText + asText

This.SelectText( ilAnciennePosition, ilPosition - ilAnciennePosition )
This.ReplaceText( asText )

ilPosition = This.Position()


//isTextCourrant	= This.Text

If ( ibTraceContenu ) Then
	uf_Tracer ( asText )
End If

end subroutine

on constructor;//*****************************************************************************
//
// Objet 		: U_Rapport
// Evenement 	: Constructor
//	Auteur		: La Recrue
//	Date			: 13/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Initialisation des varaibles d'instance.
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

ibTraceContenu			= False

isAncienText			= ""
isTextCourrant			= ""
end on

on u_rapport.create
end on

on u_rapport.destroy
end on

