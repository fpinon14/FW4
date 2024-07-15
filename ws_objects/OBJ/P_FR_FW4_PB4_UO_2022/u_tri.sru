HA$PBExportHeader$u_tri.sru
$PBExportComments$----} UserObjet sp$$HEX1$$e900$$ENDHEX$$cifique pour le Tri
forward
global type u_tri from userobject
end type
type dw_2 from datawindow within u_tri
end type
type dw_1 from datawindow within u_tri
end type
end forward

global type u_tri from userobject
integer width = 1687
integer height = 1044
boolean border = true
long backcolor = 12632256
dw_2 dw_2
dw_1 dw_1
end type
global u_tri u_tri

type variables
Boolean     ibBoutonGdw1

Boolean     ibBoutonGdw2

Int             iiMouseXdw2, &
                 iiMouseYdw2

Int             iiMouseXdw1, &
                 iiMouseYdw1

Long          ilLigDragdw1, &
                 ilLigDragdw2


end variables

forward prototypes
public function long uf_getobjectatpointer (ref datawindow adw, ref string astext)
public function long uf_inserer (integer aitype, ref datawindow adwcible, ref datawindow adwsource, long alligcible, long alligsource, string asTypeTri)
end prototypes

public function long uf_getobjectatpointer (ref datawindow adw, ref string astext);//*******************************************************************************************
// Fonction            	: Uf_GetObjectAtPointer
//	Auteur              	: Erick John Stark
//	Date 					 	: 22/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: La souris se trouve-t-elle sur une colonne ?
//
// Arguments				: DataWindow	aDw		(R$$HEX1$$e900$$ENDHEX$$f)	La DataWindow sur lequel est positionn$$HEX2$$e9002000$$ENDHEX$$le pointeur
//								  String			asText	(R$$HEX1$$e900$$ENDHEX$$f) La colonne sur laquelle est positionn$$HEX1$$e900$$ENDHEX$$e le pointeur
//
// Retourne					: Long	0 -> Pas de Ligne sous le pointeur
//											? -> N$$HEX2$$b0002000$$ENDHEX$$de la Ligne 
//								  
//*******************************************************************************************


String sText
Long lLig, lPos

lLig = 0

sText = aDw.GetObjectAtPointer ()

If	sText <> "" Then
	lPos		= Pos ( sText, "~t" )

	asText	= Left ( sText, lPos - 1 )
	lLig 		= Long ( Mid( sText, lPos + 1 ) )
End If

Return ( lLig )
end function

public function long uf_inserer (integer aitype, ref datawindow adwcible, ref datawindow adwsource, long alligcible, long alligsource, string asTypeTri);//*******************************************************************************************
// Fonction            	: Uf_Inserer
//	Auteur              	: Erick John Stark
//	Date 					 	: 22/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Insertion d'un enregistrement et suppression d'un autre
//
// Arguments				: Integer		aiType				(Val)	Type d'insertion
// 							  DataWindow	adwCible				(R$$HEX1$$e900$$ENDHEX$$f)	Data Window Cible
// 							  DataWindow	adwSource			(R$$HEX1$$e900$$ENDHEX$$f)	Data Window Source
//								  Long			alLigCible			(Val) N$$HEX2$$b0002000$$ENDHEX$$de Ligne Cible
//								  Long			alLigSource			(Val) N$$HEX2$$b0002000$$ENDHEX$$de Ligne Source
//								  String			asTypeTri			(Val) Type de Tri ( A / D )
//
// Retourne					: Long		
//								  
//*******************************************************************************************

Long lRet

lRet = 1

// .... Insertion d'une ligne dans la DW Cible

adwCible.InsertRow ( alLigCible )

// .... Si Insertion en derni$$HEX1$$e900$$ENDHEX$$re position, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nombre de Lignes de la DW

If	alLigCible = 0 Then	
	alLigCible	= adwCible.RowCount ()
End If

// .... Insertion des valeurs courantes

adwCible.SetItem ( alLigCible, "sLib", 	adwSource.GetItemString ( alLigSource, "sLib" ) )
adwCible.SetItem ( alLigCible, "lCol", 	adwSource.GetItemNumber ( alLigSource, "lCol" ) )
adwCible.SetItem ( alLigCible, "sCode", 	adwSource.GetItemString ( alLigSource, "sCode" ) )

// .... Si Insertion de Dw_1 dans Dw_2, il y a une colonne suppl$$HEX1$$e900$$ENDHEX$$mentaire

If	aiType = 1 Then
	adwCible.SetItem ( alLigCible, "sTypeTri", asTypeTri )
End If

// .... Si Insertion de Dw_2 dans Dw_1, il faut retrier la DW avec le tri par defaut ( lCol )

If	aiType = 2 Then
	adwCible.Sort ()
End If

// .... Pour finir, on supprime la ligne de la DW source

adwSource.DeleteRow ( alLigSource )

Return ( lRet )
end function

on u_tri.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.dw_1}
end on

on u_tri.destroy
destroy(this.dw_2)
destroy(this.dw_1)
end on

type dw_2 from datawindow within u_tri
event bougersouris pbm_mousemove
event boutonbas pbm_lbuttondown
event boutonhaut pbm_lbuttonup
integer x = 658
integer y = 16
integer width = 987
integer height = 992
integer taborder = 20
string dragicon = "k:\pb4obj\bmp\dga.ico"
string dataobject = "d_tri2"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event bougersouris;//*****************************************************************************
//
// Objet 		: Dw_2
// Evenement 	: BougerSouris 
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: On bouge la souris
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Long lLig
String asText

asText = ""

// .... Le bouton gauche de la souris n'est pas enfonc$$HEX2$$e9002000$$ENDHEX$$donc rien

If	Not ibBoutonGdw2 Then Return

// .... Le bouton est enfonc$$HEX2$$e9002000$$ENDHEX$$et on a boug$$HEX2$$e9002000$$ENDHEX$$la souris d'une valeur suffisante

// .... De plus il faut tester le bouton de la souris, pour $$HEX1$$ea00$$ENDHEX$$tre certain
// .... de ne pas $$HEX1$$ea00$$ENDHEX$$tre perturb$$HEX2$$e9002000$$ENDHEX$$par le MouseMove de l'autre DW

If	Abs ( iiMouseXdw2 - This.PointerX() ) > 30  Or &
	Abs ( iiMouseYdw2 - This.PointerY() ) > 30  And &
	ibBoutonGdw2 Then

	lLig = Uf_GetObjectAtPointer ( dw_2, asText )

	If	lLig > 0 Then

// .... On se met en Drag And Drop

		ilLigDragDw2 = lLig

		ibBoutonGDw2 = False
		This.Drag ( Begin! )

	End If

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event boutonbas;//*****************************************************************************
//
// Objet 		: Dw_2
// Evenement 	: BoutonBas
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: On presse le bouton gauche de la souris
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************


If This.GetObjectAtPointer () <> "" Then

	ibBoutonGDw2	= True
	iiMouseXDw2 	= This.PointerX ()
	iiMouseYDw2 	= This.PointerY ()

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event boutonhaut;//*****************************************************************************
//
// Objet 		: Dw_2
// Evenement 	: BoutonHaut
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: On remonte le bouton gauche de la souris
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

ibBoutonGDw2 	= False
This.Drag ( Cancel! )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dragdrop;//*****************************************************************************
//
// Objet 		: Dw_2
// Evenement 	: DragDrop
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Long lNbrLig, lLig

DragObject ObjetDragger
String sNomObjet, asText

asText = ""

// .... On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nom de l'objet source

ObjetDragger	= DraggedObject ()
sNomObjet		= ObjetDragger.ClassName ()

If	sNomObjet = "dw_1" Then

	dw_1.Drag ( Cancel! )

// .... On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nombre total de ligne, ainsi que la ligne
// .... ou se trouve le pointeur

	lNbrLig	= This.RowCount ()
	lLig		= Uf_GetObjectAtPointer ( dw_2, asText )

// .... Si aucune ligne, on ins$$HEX1$$e900$$ENDHEX$$re $$HEX2$$e0002000$$ENDHEX$$la fin

	If	lNbrLig = 0 Or lLig = 0 Then

		Uf_Inserer ( 1, dw_2, dw_1, 0, ilLigDragDw1, "A" )

	Else

// .... Sinon on ins$$HEX1$$e900$$ENDHEX$$re au dessus de l'endroit ou se trouve le pointeur

		Uf_Inserer ( 1, dw_2, dw_1, lLig, ilLigDragDw1, "A" )

	End If

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event constructor;//*****************************************************************************
//
// Objet 		: Dw_2
// Evenement 	: Constructor
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

String sMod

// .... Initialisation des colonnes ( Croissant ou D$$HEX1$$e900$$ENDHEX$$croissant )

sMod	= "ordre_t.Text='Croissant~t If( stypeTri = ~"D~", ~"D$$HEX1$$e900$$ENDHEX$$croissant~", ~"Croissant~"" + ")'"	
This.Modify( sMod )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event doubleclicked;//*****************************************************************************
//
// Objet 		: Dw_2
// Evenement 	: DoubleClicked
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

// .... On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la ligne 

ilLigDragDw2 = This.GetClickedRow ()

// .... Si pas de DoubleClick sur une ligne valide, on sort

If	ilLigDragDw2	<= 0 Then Return

If	This.GetClickedColumn () <> 1 Then Return

Uf_Inserer ( 2, dw_1, dw_2, 0, ilLigDragDw2, "" )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_1 from datawindow within u_tri
event bougersouris pbm_mousemove
event boutonbas pbm_lbuttondown
event boutonhaut pbm_lbuttonup
integer x = 37
integer y = 16
integer width = 603
integer height = 992
integer taborder = 10
string dragicon = "k:\pb4obj\bmp\dga.ico"
string dataobject = "d_tri1"
string icon = "None!"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event bougersouris;//*****************************************************************************
//
// Objet 		: Dw_1
// Evenement 	: BougerSouris 
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: On bouge la souris
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Long lLig
String asText

asText = ""

// .... Le bouton gauche de la souris n'est pas enfonc$$HEX2$$e9002000$$ENDHEX$$donc rien

If	Not ibBoutonGdw1 Then Return

// .... Le bouton est enfonc$$HEX2$$e9002000$$ENDHEX$$et on a boug$$HEX2$$e9002000$$ENDHEX$$la souris d'une valeur suffisante

// .... De plus il faut tester le bouton de la souris, pour $$HEX1$$ea00$$ENDHEX$$tre certain
// .... de ne pas $$HEX1$$ea00$$ENDHEX$$tre perturb$$HEX2$$e9002000$$ENDHEX$$par le MouseMove de l'autre DW

If	Abs ( iiMouseXdw1 - This.PointerX() ) > 30  Or &
	Abs ( iiMouseYdw1 - This.PointerY() ) > 30  And &
	ibBoutonGdw1 Then

	lLig = Uf_GetObjectAtPointer ( dw_1, asText )

	If	lLig > 0 Then

// .... On se met en Drag And Drop

		ilLigDragDw1 = lLig

		ibBoutonGDw1 = False
		This.Drag ( Begin! )

	End If

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event boutonbas;//*****************************************************************************
//
// Objet 		: Dw_1
// Evenement 	: BoutonBas
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: On presse le bouton gauche de la souris
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

If This.GetObjectAtPointer () <> "" Then

	ibBoutonGDw1	= True
	iiMouseXDw1 	= This.PointerX ()
	iiMouseYDw1 	= This.PointerY ()

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event boutonhaut;//*****************************************************************************
//
// Objet 		: Dw_1
// Evenement 	: BoutonHaut
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: On remonte le bouton gauche de la souris
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

ibBoutonGDw1 	= False
This.Drag ( Cancel! )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dragdrop;//*****************************************************************************
//
// Objet 		: Dw_1
// Evenement 	: DragDrop
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

DragObject ObjetDragger
String sNomObjet

// .... On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nom de l'objet source

ObjetDragger	= DraggedObject ()
sNomObjet		= ObjetDragger.ClassName ()

If	sNomObjet = "dw_2" Then

	dw_2.Drag ( Cancel! )

// .... On insere une ligne dans Dw_1

	Uf_Inserer ( 2, dw_1, dw_2, 0, ilLigDragDw2, "" )

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event doubleclicked;//*****************************************************************************
//
// Objet 		: Dw_1
// Evenement 	: DoubleClicked
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

// .... On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la ligne 

ilLigDragDw1 = This.GetClickedRow ()

// .... Si pas de DoubleClick sur une ligne valide, on sort

If	ilLigDragDw1	<= 0 Then Return

Uf_Inserer ( 1, dw_2, dw_1, 0, ilLigDragDw1, "A" )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

