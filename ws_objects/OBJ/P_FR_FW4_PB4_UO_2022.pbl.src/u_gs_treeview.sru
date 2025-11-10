HA$PBExportHeader$u_gs_treeview.sru
$PBExportComments$----} UserObjet Non Visuel contenant les m$$HEX1$$e900$$ENDHEX$$thodes pour U_TreeView
forward
global type u_gs_treeview from nonvisualobject
end type
end forward

global type u_gs_treeview from nonvisualobject
end type
global u_gs_treeview u_gs_treeview

type variables
Private :
	u_TreeView	iuoTreeView

	Long		ilHauteur
	Long		ilLigneCourante

	Boolean		ibAfficherRacine
	Boolean		ibGestionBmp
	Boolean		ibChargementTermine
	Boolean		ibClickedPlus
	Boolean		ibMenuActif

	m_TreeView	imTree

end variables

forward prototypes
public subroutine uf_debutchargement ()
public subroutine uf_chargerligne (string aslibelle, integer ainiveau, string asbmp1, string asbmp2)
public subroutine uf_clicked ()
private subroutine uf_fermer_une_ligne (long alligne)
private subroutine uf_ouvrir_une_ligne (long alligne)
public subroutine uf_rowfocuschanged ()
public subroutine uf_keydown ()
public subroutine uf_finchargement (long alliginitiale, ref long alligfermer[])
public subroutine uf_initialisation (ref u_treeview autreeview, boolean abafficherracine, boolean abGestionBmp)
public subroutine uf_rbuttondown (ref window awparent)
public subroutine uf_activer_menu (boolean abActiverMenu)
end prototypes

public subroutine uf_debutchargement ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_TreeView::Uf_DebutChargement (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 27/05/1998 16:07:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On charge le TreeView
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On commence le chargement de la DataWindow. On positionne une    */
/* valeur d'instance pour expliquer que le chargement est en cours. */
/* Cela va $$HEX1$$e900$$ENDHEX$$viter de d$$HEX1$$e900$$ENDHEX$$clencher l'$$HEX1$$e900$$ENDHEX$$vement RowFocusChanged.          */
/*------------------------------------------------------------------*/

iuoTreeView.SetRedraw ( False )
iuoTreeView.Reset ()

ibChargementTermine = False


end subroutine

public subroutine uf_chargerligne (string aslibelle, integer ainiveau, string asbmp1, string asbmp2);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_TreeView::Uf_ChargerLigne (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 27/05/1998 16:34:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Chargement d'une ligne dans le TreeView
//*
//* Arguments		: String			asLibelle			(Val)	Libelle de la ligne
//*					  Integer		aiNiveau				(Val) Niveau de la ligne 
//*					  String			asBmp1				(Val) Nom du Bitmap qui doit apparaitre
//*					  String			asBmp2				(Val) Nom du Bitmap qui doit apparaitre
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lLig

lLig = iuoTreeView.InsertRow ( 0 )

iuoTreeView.SetItem ( lLig, "libelle",				asLibelle )
iuoTreeView.SetItem ( lLig, "niveau", 				aiNiveau )
iuoTreeView.SetItem ( lLig, "bmp_1", 				asBmp1 )
iuoTreeView.SetItem ( lLig, "bmp_2", 				asBmp2 )

end subroutine

public subroutine uf_clicked ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_TreeView::Uf_Clicked (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 04/06/1998 09:50:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On vient de cliquer sur une ligne. 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sNom

Long lLig

/*------------------------------------------------------------------*/
/* On recup$$HEX1$$e900$$ENDHEX$$re la ligne sur laquelle on vient de cliquer.           */
/*------------------------------------------------------------------*/
lLig = iuoTreeView.GetClickedRow ()

If	lLig < 1 Then Return

ibClickedPlus = False

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nom de l'objet sur lequel on vient de cliquer.    */
/*------------------------------------------------------------------*/
sNom = iuoTreeView.GetObjectAtPointer ()

If	sNom <> ""	Then
	sNom = Upper ( Mid ( sNom, 1, Pos ( sNom, '~t' ) - 1 ) )
End If

Choose Case sNom
Case ""
	ibClickedPlus = True

Case "LIBELLE", "IMAGE"
/*------------------------------------------------------------------*/
/* On change la ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e.                                 */
/*------------------------------------------------------------------*/
	If	This.ilLigneCourante <> lLig	Then
		If	This.ilLigneCourante > 0 Then	iuoTreeView.SetItem ( This.ilLigneCourante, "selectionne", "N" )

		iuoTreeView.SetItem ( lLig, "selectionne", "O" )
	End If
	This.ilLigneCourante = lLig

	iuoTreeView.TriggerEvent ( "Ue_Selection_Ligne" )

Case "PLUS_OU_MOINS"
/*------------------------------------------------------------------*/
/* On vient de cliquer sur le Bitmap (+/-), on v$$HEX1$$e900$$ENDHEX$$rifie que cet      */
/* objet est accessible.                                            */
/*------------------------------------------------------------------*/
	If	iuoTreeView.GetItemNumber ( lLig, "Voir_PlusouMoins" ) = 1	Then
		ibClickedPlus = True
/*------------------------------------------------------------------*/
/* On va empecher la gestion du RowFocusChanged grace a             */
/* ibClickedPlus.                                                   */
/*------------------------------------------------------------------*/
		iuoTreeView.SetRedraw ( False )
/*------------------------------------------------------------------*/
/* Si la ligne courante est 'ouverte', on la ferme. Si elle est     */
/* 'ferm$$HEX1$$e900$$ENDHEX$$e', on l'ouvre.                                            */
/*------------------------------------------------------------------*/
		If	iuoTreeView.GetItemString ( lLig, "ouvert" ) = "N"	Then
			Uf_Ouvrir_Une_Ligne ( lLig )
		Else
			Uf_Fermer_Une_Ligne ( lLig )
		End If
		iuoTreeView.SetRedraw ( True )
	End If

End Choose
end subroutine

private subroutine uf_fermer_une_ligne (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_TreeView::Uf_Fermer_Une_Ligne (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 04/06/1998 11:14:12
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Permet de fermer une ligne dans l'arbre
//*
//* Arguments		: Long			alLigne				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la ligne a fermer
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lCpt, lLigneFin, lNiveauDebut, lTotal


/*------------------------------------------------------------------*/
/* On positionne la ligne comme $$HEX1$$e900$$ENDHEX$$tant 'ferm$$HEX1$$e900$$ENDHEX$$e'.                     */
/*------------------------------------------------------------------*/
iuoTreeView.SetItem ( alLigne, "ouvert", "N" )

/*------------------------------------------------------------------*/
/* Quel est le niveau de la ligne que l'on vient de fermer ?.       */
/*------------------------------------------------------------------*/
lNiveauDebut	= iuoTreeView.GetItemNumber ( alLigne, "niveau" )
lTotal			= iuoTreeView.RowCount ()

If	lTotal = alLigne	Then Return

SetPointer ( HourGlass! )
lLigneFin		= lTotal

alLigne ++

/*------------------------------------------------------------------*/
/* On veut d$$HEX1$$e900$$ENDHEX$$terminer le N$$HEX2$$b0002000$$ENDHEX$$de la ligne avec un niveau inf$$HEX1$$e900$$ENDHEX$$rieur    */
/* ou $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$celui de la ligne ou l'on vient de cliquer.            */
/*------------------------------------------------------------------*/
For	lCpt = alLigne To lTotal
		If	iuoTreeView.GetItemNumber ( lCpt, "niveau" ) <= lNiveauDebut	Then
			lLigneFin = lCpt - 1
			Exit
		Else
			iuoTreeView.SetItem ( lCpt, "ouvert", "N" )
		End If
Next

/*------------------------------------------------------------------*/
/* Si la ligne courante s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e se trouve dans les lignes      */
/* touch$$HEX1$$e900$$ENDHEX$$es, on positionne la ligne courante sur la ligne ou l'on   */
/* vient de cliquer.                                                */
/*------------------------------------------------------------------*/
If	lLigneFin >= ilLigneCourante	And ilLigneCourante >= alLigne Then
	iuoTreeView.SetItem ( This.ilLigneCourante, "selectionne", "N" )

	This.ilLigneCourante = alLigne - 1

	iuoTreeView.SetItem ( This.ilLigneCourante, "selectionne", "O" )

	iuoTreeView.TriggerEvent ( "Ue_Selection_Ligne" )
End If

iuoTreeView.SetDetailHeight ( alLigne, lLigneFin, 0 )

end subroutine

private subroutine uf_ouvrir_une_ligne (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_TreeView::Uf_Ouvrir_Une_Ligne (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 04/06/1998 11:14:12
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Permet d'ouvrir une ligne dans l'arbre
//*
//* Arguments		: Long			alLigne				(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la ligne a ouvrir
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lNiveauDebut, lDerniereLigne, lTotal, lIndex

/*------------------------------------------------------------------*/
/* On positionne la ligne comme $$HEX1$$e900$$ENDHEX$$tant 'ouverte'.                    */
/*------------------------------------------------------------------*/
iuoTreeView.SetItem ( alLigne, "ouvert", "O" )

lNiveauDebut	= iuoTreeView.GetItemNumber ( alLigne, "niveau" )
lTotal			= iuoTreeView.RowCount ()

If	lTotal = alLigne Then Return

SetPointer ( HourGlass! )

lDerniereLigne = iuoTreeView.Find ( "niveau <= " + String ( lNiveauDebut ), alLigne + 1, lTotal )
If	lDerniereLigne <= 0 Then lDerniereLigne = lTotal

lNiveauDebut ++

lIndex = iuoTreeView.Find ( "niveau = " + String ( lNiveauDebut ), alLigne + 1, lDerniereLigne )

Do While	lIndex > 0
	iuoTreeView.SetDetailHeight ( lIndex, lIndex, ilHauteur )
	lIndex ++
	If	lIndex > lDerniereLigne	Then Exit
	lIndex = iuoTreeView.Find ( "niveau = " + String ( lNiveauDebut ), lIndex, lDerniereLigne )
Loop
end subroutine

public subroutine uf_rowfocuschanged ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_TreeView::Uf_RowFocusChanged (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 04/06/1998 17:10:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On bouge (haut/bas) dans le TreeView
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Boolean bBas

Long lLigne, lLigSuivante
bBas	= True

/*------------------------------------------------------------------*/
/* Si le chargement du TreeView est en cours, on ne fait rien.      */
/*------------------------------------------------------------------*/
If	Not ibChargementTermine	Then Return

/*------------------------------------------------------------------*/
/* Si on vient de cliquer sur le Bitmap (+/-), on se repositionne   */
/* sur la ligne courante. (Idem explorateur Windows.)               */
/*------------------------------------------------------------------*/
If	ibClickedPlus = True	Then
	ibClickedPlus = False

	iuoTreeView.SetRow ( ilLigneCourante )
	iuoTreeView.ScrollToRow ( ilLigneCourante )

	Return
End If

/*------------------------------------------------------------------*/
/* On recup$$HEX1$$e900$$ENDHEX$$re la ligne en cours de traitement. Si cette ligne      */
/* correpond $$HEX2$$e0002000$$ENDHEX$$la ligne courante, on ne fait rien. (Cas du Click)   */
/*------------------------------------------------------------------*/
lLigne = iuoTreeView.GetRow ()

If lLigne < 1	Then Return
If	lLigne = This.ilLigneCourante	Then Return

/*------------------------------------------------------------------*/
/* Quand on arrive ici, c'est que l'on utilise les fl$$HEX1$$e900$$ENDHEX$$ches de       */
/* d$$HEX1$$e900$$ENDHEX$$placement. On d$$HEX1$$e900$$ENDHEX$$termine si le d$$HEX1$$e900$$ENDHEX$$placement s'effectue sur le    */
/* haut ou le bas.                                                  */
/*------------------------------------------------------------------*/
If	This.ilLigneCourante > lLigne	Then
	bBas = False
End If

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$termine la ligne suivante sur laquelle on doit se           */
/* positionner.                                                     */
/*------------------------------------------------------------------*/
If	bBas	Then
	lLigSuivante = iuoTreeView.Find ( "RowHeight () <> 0" , lLigne, 9999 )
Else
	lLigSuivante = iuoTreeView.Find ( "RowHeight () <> 0" , lLigne, 1 )
End If

/*------------------------------------------------------------------*/
/* On s$$HEX1$$e900$$ENDHEX$$lectionne la ligne et on d$$HEX1$$e900$$ENDHEX$$selectionne la ligne courante.   */
/*------------------------------------------------------------------*/
If	lLigSuivante > 0 Then
	iuoTreeView.ScrollToRow ( lLigSuivante )
	iuoTreeView.SetItem ( This.ilLigneCourante, "selectionne", "N" )
	This.ilLigneCourante = lLigSuivante

	iuoTreeView.SetItem ( This.ilLigneCourante, "selectionne", "O" )

	iuoTreeView.TriggerEvent ( "Ue_Selection_Ligne" )
Else
	iuoTreeView.ScrollToRow ( ilLigneCourante )
End If

end subroutine

public subroutine uf_keydown ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_TreeView::Uf_KeyDown (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 09/06/1998 09:25:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: L'utilisateur vient d'appuyer sur une touche
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lLig

If	KeyDown ( KeyDownArrow! ) Or KeyDown ( KeyUpArrow! )		Or &
	KeyDown ( KeyLeftArrow! ) Or KeyDown ( KeyRightArrow! )	Or &
	KeyDown ( KeyPageUp! ) Or KeyDown ( KeyPageDown! ) Then
	ibClickedPlus = False
	Return
End If

If	KeyDown ( KeyAdd! ) Then
	lLig = iuoTreeView.GetRow ()
	If	iuoTreeView.GetItemNumber ( lLig, "VOIR_PLUSOUMOINS" ) = 1	Then
		If	iuoTreeView.GetItemString ( lLig, "ouvert" ) = "N"	Then
			iuoTreeView.SetRedraw ( False )
			Uf_Ouvrir_Une_Ligne ( lLig )
			iuoTreeView.SetRedraw ( True )
			SetPointer ( Arrow! )
			Return
		End If
	End If
End If

If	KeyDown ( KeySubtract! ) Then
	lLig = iuoTreeView.GetRow ()
	If	iuoTreeView.GetItemNumber ( lLig, "VOIR_PLUSOUMOINS" ) = 1	Then
		If	iuoTreeView.GetItemString ( lLig, "ouvert" ) = "O"	Then

			iuoTreeView.SetRedraw ( False )
			Uf_Fermer_Une_Ligne ( lLig )
			SetPointer ( Arrow! )
			iuoTreeView.SetRedraw ( True )
		End If
	End If
End If

end subroutine

public subroutine uf_finchargement (long alliginitiale, ref long alligfermer[]);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_TreeView::Uf_FinChargement (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 27/05/1998 17:24:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Long				alLigInitiale		(Val)	
//*					  Long				alLigFermer[]		(R$$HEX1$$e900$$ENDHEX$$f)
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer iNiveau

Long	lTotLig, lCpt, lLigNivInf, lLigNivEgal, lCptAutre, lTot

String sBmp

lTotLig = iuoTreeView.RowCount ()

For	lCpt = 1 To lTotLig

		iNiveau = iuoTreeView.GetItemNumber ( lCpt, "niveau" )

		lLigNivInf	= iuoTreeView.Find ( "niveau < " + String ( iNiveau ), lCpt + 1, 9999 )
		lLigNivEgal	= iuoTreeView.Find ( "niveau = " + String ( iNiveau ), lCpt + 1, 9999 )

		If	lLigNivInf 	= 0 Then	lLigNivInf = lTotLig
		If	lLigNivEgal > 0 And lLigNivInf > lLigNivEgal	Then
			iuoTreeView.SetItem ( lCpt, "autre", "O" )

			For	lCptAutre	= lCpt To lLigNivEgal
					iuoTreeView.SetItem ( lCptAutre, "ligne" + String ( iNiveau ), "O" )
			Next
		End If

Next

If	Not ibAfficherRacine	Then
	iuoTreeView.SetDetailHeight ( 1, 1, 0 )
End If

/*------------------------------------------------------------------*/
/* Si on g$$HEX1$$e900$$ENDHEX$$re la gestion du chemin des bitmaps, il faut les mettre  */
/* $$HEX2$$e0002000$$ENDHEX$$jour.                                                          */
/*------------------------------------------------------------------*/
If	ibGestionBmp	Then
	For	lCpt = 2 To lTotLig
			sBmp = iuoTreeView.GetItemString ( lCpt, "bmp_1" )
			sBmp = "K:\PB4OBJ\BMP\" + sBmp + ".BMP"
			iuoTreeView.SetItem ( lCpt, "bmp_1", sBmp )

			sBmp = iuoTreeView.GetItemString ( lCpt, "bmp_2" )
			sBmp = "K:\PB4OBJ\BMP\" + sBmp + ".BMP"
			iuoTreeView.SetItem ( lCpt, "bmp_2", sBmp )
	Next
End If


/*------------------------------------------------------------------*/
/* On initialise la valeur de la ligne courante.                    */
/*------------------------------------------------------------------*/
ilLigneCourante = ( alLigInitiale + 1 )
iuoTreeView.SetItem ( ilLigneCourante, "selectionne", "O" )
iuoTreeView.SetRow ( ilLigneCourante )
iuoTreeView.ScrollToRow ( ilLigneCourante )

/*------------------------------------------------------------------*/
/* On ferme les dossiers que l'on veut, sachant que par d$$HEX1$$e900$$ENDHEX$$faut ils  */
/* sont tous ouverts.                                               */
/*------------------------------------------------------------------*/
lTot = UpperBound ( alLigFermer )
For	lCpt = 1 To lTot
		Uf_Fermer_Une_Ligne ( alLigFermer [ lCpt ] + 1 )
Next

iuoTreeView.SetRedraw ( True )
ibChargementTermine = True


end subroutine

public subroutine uf_initialisation (ref u_treeview autreeview, boolean abafficherracine, boolean abGestionBmp);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_TreeView::Uf_Initialisation (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 30/04/1998 18:07:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: u_TreeView		auTreeView			(R$$HEX1$$e900$$ENDHEX$$f)	
//*					  Boolean			abAfficherRacine	(Val)
//*					  Boolean			abGestionBmp		(Val)
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sRet

/*------------------------------------------------------------------*/
/* On initialise le User Objet correspondant au TreeView.           */
/*------------------------------------------------------------------*/
iuoTreeView 		= auTreeView
ibAfficherRacine	= abAfficherRacine

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la hauteur d'une ligne de la DataWindow.             */
/*------------------------------------------------------------------*/
sRet 				= iuoTreeView.Describe ( 'DataWindow.Detail.Height' )
ilHauteur 		= Long ( sRet )

/*------------------------------------------------------------------*/
/* Doit-on g$$HEX1$$e900$$ENDHEX$$rer le chemin des bitmaps pour le TreeView ?           */
/*------------------------------------------------------------------*/
ibGestionBmp	= abGestionBmp
end subroutine

public subroutine uf_rbuttondown (ref window awparent);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_TreeView::Uf_RButtonDown (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 09/06/1998 09:25:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: L'utilisateur vient de faire un click droit
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

window	wParent
Long			lX,lY

ibMenuActif = True

If ( ibMenuActif ) Then

	wParent		= awParent

	iuoTreeView.TriggerEvent( "Ue_ModifierMenu" )

	If ( wParent.WindowType = Main! ) Then

		lX = wParent.X	+ 10	+	wParent.PointerX()
		lY = wParent.Y	+ 230	+	wParent.PointerY()
	Else

		If ( wParent.WindowType = Popup! ) Then

			lX = wParent.PointerX()
			lY = wParent.PointerY()

		Else

			lX = wParent.ParentWindow().X	+	10		+ wParent.X	+ 10	+ wParent.PointerX()
			lY = wParent.ParentWindow().Y	+	230	+ wParent.Y	+ 80	+ wParent.PointerY()

		End If
	End If

	imTree.m_MenuContext.PopMenu( lX, lY )

End If





end subroutine

public subroutine uf_activer_menu (boolean abActiverMenu);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Gs_TreeView::Uf_Activer_Menu
//* Auteur			: Erick John Stark
//* Date				: 10/06/1998 15:58:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Activation du menu flottant
//*
//* Arguments		: Boolean		abActiverMenu		(Val)	Activation du menu flottant
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

ibMenuActif = abActiverMenu


end subroutine

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Gs_TreeView::Constructor
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 10/06/1998 11:53:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

imTree = Create M_TreeView

end on

on destructor;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Gs_TreeView::Destructor
//* Evenement 		: Destructor
//* Auteur			: Erick John Stark
//* Date				: 10/06/1998 11:53:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Destroy imTree


end on

on u_gs_treeview.create
TriggerEvent( this, "constructor" )
end on

on u_gs_treeview.destroy
TriggerEvent( this, "destructor" )
end on

