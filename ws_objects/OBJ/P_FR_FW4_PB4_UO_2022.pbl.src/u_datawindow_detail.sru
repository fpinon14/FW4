HA$PBExportHeader$u_datawindow_detail.sru
$PBExportComments$----} UserObjet Anc$$HEX1$$ea00$$ENDHEX$$tre Datawindow D$$HEX1$$e900$$ENDHEX$$tail
forward
global type u_datawindow_detail from u_datawindow
end type
end forward

global type u_datawindow_detail from u_datawindow
integer taborder = 10
end type
global u_datawindow_detail u_datawindow_detail

type prototypes

end prototypes

type variables

Private:
	String		isNomDetail

Protected:
	Boolean		ibSelectionActive

Public:
	String  isSelect

	Int       iitmHeight	// hauteur de texte de la tabulaire en pixels

	Long    ilLargeur     // Largeur de la DW apr$$HEX1$$e900$$ENDHEX$$s construction

	Long    ilLigneClick // Ligne Click$$HEX1$$e900$$ENDHEX$$e

	String   isPointer = "K:\PB4OBJ\BMP\DBLCLICK.CUR"// Nom du pointeur .cur $$HEX2$$e0002000$$ENDHEX$$utiliser


end variables

forward prototypes
public subroutine uf_creer_select (ref s_creer_dw astcol[], ref string astable[])
public subroutine uf_cst_syntax (ref s_creer_dw astcol[], ref u_transaction atrtrans)
public function long uf_largeur (long allarfenetre, long almgauche)
public function long uf_hauteur (long alhaufenetre, long almhaut)
public function string uf_nom_detail ()
public function boolean uf_supprimerligne ()
public subroutine uf_activer_selection (boolean abactivation)
public function boolean uf_ajouter_clause (string ascondition[])
public function boolean uf_autoriserupdate (string astable)
public subroutine uf_filter (string asfilter)
public subroutine uf_creer_tout (ref s_creer_dw astcol[], ref string astable[], ref u_transaction atrtrans)
public function string uf_getdefaultheadersuffix ()
public function string uf_construire_syntax (ref s_creer_dw astaccueil[], ref long al_largeurtotale)
private function integer uf_cst_syntax_dga (ref s_creer_dw astCol[], ref u_Transaction atrTrans)
public function integer uf_setfromclause (ref string asselect, string asfromclause)
public function integer uf_setfromclause (string asfromclause)
end prototypes

public subroutine uf_creer_select (ref s_creer_dw astcol[], ref string astable[]);//*******************************************************************************************
// Fonction            	: Uf_Creer_Select
//	Auteur              	: Erick John Stark
//	Date 					 	: 22/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Cr$$HEX1$$e900$$ENDHEX$$ation du d$$HEX1$$e900$$ENDHEX$$but de la chaine composant un SELECT
//
// Arguments				: s_Creer_Dw	astCol[]			(R$$HEX1$$e900$$ENDHEX$$f)	Structure cliente correspondant aux colonnes
// 							  String			asTable[]		(R$$HEX1$$e900$$ENDHEX$$f)	Liste des tables
//
// Retourne					: String		? 	= D$$HEX1$$e900$$ENDHEX$$but du SELECT
//								  
//*******************************************************************************************


Integer iNbCol, iNbTable, iCpt

String sUser, sSelect

iNbCol		= UpperBound ( astCol )
iNbTable		= UpperBound ( asTable )

sSelect		=	"SELECT "
sUser			=	"sysadm."

// .... Construction du d$$HEX1$$e900$$ENDHEX$$but du SELECT ( N-1 Colonne )

For	iCpt = 1 To iNbCol - 1
		sSelect	=	sSelect + astCol[ iCpt ].sDbName + ", "
//		sSelect	=	sSelect + sUser + "." + astCol[ iCpt ].sDbName + ", "
Next

// .... Construction de la derni$$HEX1$$e800$$ENDHEX$$re colonne + FROM

sSelect	=	sSelect + astCol[ iNbCol ].sDbName + " FROM "
//sSelect	=	sSelect + sUser + "." + astCol[ iNbCol ].sDbName + " FROM "

// .... Construction de la liste des tables ( N-1 )

For	iCpt = 1 To ( iNbTable - 1 )
		sSelect	= sSelect + sUser + asTable[ iCpt ] + ", "
Next

// .... Construction de la derni$$HEX1$$e800$$ENDHEX$$re table

sSelect	= sSelect + sUser + asTable[ iNbTable ] 

// Initialisation de la variable d'instance du UO

This.isSelect = sSelect


end subroutine

public subroutine uf_cst_syntax (ref s_creer_dw astcol[], ref u_transaction atrtrans);//*******************************************************************************************
// Fonction            	: Uf_CstSyntax
//	Auteur              	: Erick John Stark
//	Date 					 	: 22/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Construction de la syntaxe de la DW
//
// Arguments				: s_Creer_Dw	astCol[]			(R$$HEX1$$e900$$ENDHEX$$f)	Structure cliente correspondant aux colonnes
//								  u_transaction	atrTrans		(R$$HEX1$$e900$$ENDHEX$$f)	Objet de transaction
//
// Retourne					: Rien
//								  
//*******************************************************************************************

Integer 			iRet

String 			sSyntax
		

//				--	Variables locales de type Integer --
//
//	iHeaderHeight			= Hauteur de la zone de Header
//	iDetailHeight			= Hauteur d'une ligne de d$$HEX1$$e900$$ENDHEX$$tail

Int				iHeaderHeight,			&
					iDetailHeight


//				--	Variables locales de type Unsigned Integer --
//
// uiHdc					= Handle de device context
// uiHwnd				= Handle de fenetre (datawindow)

UInt 				uiHdc,						&
					uiHwnd


//				--	Variables locales de type Structure --
//
// stTm					= Structure de reception des parametres li$$HEX1$$e900$$ENDHEX$$s
//								  a la police utilis$$HEX1$$e900$$ENDHEX$$e

//Migration PB8-WYNIWYG-03/2006 FM
//s_txtmetrics	stTm
s_txtmetrics_pb8	stTm
//Fin Migration PB8-WYNIWYG-03/2006 FM
Long lxPos


//				--	Variables locales de type Boolean --
//

Boolean 			bOk

//Migration PB8-WYNIWYG-03/2006 FM
//s_Parametre		stParametre
//Fin Migration PB8-WYNIWYG-03/2006 FM

//
//					-- Recuperation de la taille moyenne d'un car pour la police
//

//BlobEdit ( stTm.tmitalic, 1, 0 )
//BlobEdit ( stTm.tmUnderlined, 1, 0 )
//BlobEdit ( stTm.tmStruckout, 1, 0 )
//BlobEdit ( stTm.tmFirstChar, 1, 0 )
//BlobEdit ( stTm.tmLastChar, 1, 0 )
//BlobEdit ( stTm.tmDefaultChar, 1, 0 )
//BlobEdit ( stTm.tmBreakChar, 1, 0 )
//BlobEdit ( stTm.tmPitchAndFamily, 1, 0 )
//BlobEdit ( stTm.tmCharSet, 1, 0 )
stTm.tmitalic = "1"
stTm.tmUnderlined = "1"
stTm.tmStruckout = "1"
stTm.tmFirstChar = "1"
stTm.tmLastChar = "1"
stTm.tmDefaultChar = "1"
stTm.tmBreakChar = "1"
stTm.tmPitchAndFamily = "1"
stTm.tmCharSet = "1"
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//uiHwnd = Handle ( This )
//recherche de la fen$$HEX1$$ea00$$ENDHEX$$tre parente
window			L_wReturned
GraphicObject	L_goParent
ULong	Lul_Font

L_goParent = this.GetParent()
Do while IsValid(L_goParent) 
	if L_goParent.TypeOf() <> Window! then
		L_goParent = L_goParent.GetParent()
	else
		exit
	end if
Loop
if Not IsValid (L_goParent) then SetNull (L_goParent)
L_wReturned = L_goParent
uiHwnd = Handle(L_wReturned)
//Fin Migration PB8-WYNIWYG-03/2006 FM

uiHdc  = stGLB.uoWin.Uf_GetDc ( uiHwnd )

//Migration PB8-WYNIWYG-03/2006 FM
//stGLB.uoWin.Uf_SelectObject ( uiHdc, stGLB.uoWin.Uf_GetStockObject ( 16 ) )				// System Fixed Font
Lul_Font = Send(uiHwnd, 49, 0, 0)
stGLB.uoWin.Uf_SelectObject ( uiHdc, Lul_Font)

//Fin Migration PB8-WYNIWYG-03/2006 FM
bOk	= stGLB.uoWin.Uf_GetTextMetrics ( uiHdc, stTm )

//Migration PB8-WYNIWYG-03/2006 FM
stTm.tmHeight = 16 	// [SUISSE].LOT3 => 13 chang$$HEX2$$e9002000$$ENDHEX$$en 16, pour tenir compte modif
							// uf_construire_syntaxe

//Fin Migration PB8-WYNIWYG-03/2006 FM

stGLB.uoWin.Uf_ReleaseDc ( uiHwnd, uiHdc )

iHeaderHeight	=	stTm.tmHeight + ( stTm.tmHeight / 2 )
iDetailHeight	=	stTm.tmHeight

// --- D$$HEX1$$e900$$ENDHEX$$but
//
//					-- Creation de la syntaxe
//

//Migration PB8-WYNIWYG-03/2006 FM
//stParametre.itmAveCharWidth	=	stTm.tmAveCharWidth
//stParametre.iHeaderHeight		=	iHeaderHeight
//stParametre.iDetailHeight		=	iDetailHeight
//stParametre.iNbElement			=	UpperBound ( astCol )
//stParametre.sPointer				=	isPointer
//
//sSyntax = Space ( 50000 )
//
//iRet = stGLB.uoWin.Uf_DBI ( sSyntax, astCol, stParametre )
Long	Ll_largeurTotale
sSyntax = uf_construire_syntax(astCol, Ll_largeurTotale)
int Li_Return
//Fin Migration PB8-WYNIWYG-03/2006 FM

// .... Cr$$HEX1$$e900$$ENDHEX$$ation de la DW et Initialisation de l'objet de u_transaction

Li_Return = This.Create ( sSyntax )
This.iiTmHeight	= stTm.tmHeight
This.Uf_SetTransObject ( atrTrans )

//Migration PB8-WYNIWYG-03/2006 FM
//lXPos = stParametre.iXPos
//Fin Migration PB8-WYNIWYG-03/2006 FM

// .... Retaillage en Largeur de la DW

//Migration PB8-WYNIWYG-03/2006 FM
//ilLargeur = PixelsToUnits ( lXpos, XPixelsToUnits! )
ilLargeur = PixelsToUnits ( Ll_largeurTotale, XPixelsToUnits! )
//Fin Migration PB8-WYNIWYG-03/2006 FM
Parent.TriggerEvent ( "UE_CentrerAcc" )

// .... Retaillage en Hauteur de la DW
// .... Il faut utiliser un PostEvent au lieu de TriggerEvent
// .... car la fen$$HEX1$$ea00$$ENDHEX$$tre n'est pas encore finie d'$$HEX1$$ea00$$ENDHEX$$tre construite
// .... et la valeur de la Hauteur peut bouger ( Menu )

Parent.PostEvent ( "UE_TaillerHauteur" )





end subroutine

public function long uf_largeur (long allarfenetre, long almgauche);//*******************************************************************************************
// Fonction            	: Uf_Largeur
//	Auteur              	: Erick John Stark
//	Date 					 	: 22/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Positionnement en largeur de la DW
//
// Arguments				: alLarFenetre	Long				(Val)	Largeur de la fen$$HEX1$$ea00$$ENDHEX$$tre
//								  alMGauche		Long				(Val) Position de la Marge Gauche	
//
// Retourne					: Long
//								  
//*******************************************************************************************


Long lMargeGauche
Long lLargeurAsc
Long lLargeurUtile
Long lLargeurDw
Long lRet, lX

// .... ilLargeur est une variable d'instance qui correspond $$HEX2$$e0002000$$ENDHEX$$la taille r$$HEX1$$e900$$ENDHEX$$elle
// .... de la DW apr$$HEX1$$e900$$ENDHEX$$s cr$$HEX1$$e900$$ENDHEX$$ation dynamique

lRet				= 1
lMargeGauche 	= 5														// On admet que la marge Gauche est $$HEX2$$e0002000$$ENDHEX$$5 Pixels du bord
lLargeurAsc		= 78														// Largeur de l'ascenceur de la DW
lLargeurUtile	= alLarFenetre - ( 2 * lMargeGauche + 42 )	// Largeur Utile Maximale de la Fen$$HEX1$$ea00$$ENDHEX$$tre
lLargeurDw		= ilLargeur + lLargeurAsc							// Largeur de la DW 

// .... Si la largeur de la DW est sup$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la taille de la fen$$HEX1$$ea00$$ENDHEX$$tre
// .... on la resize de la taille de la fen$$HEX1$$ea00$$ENDHEX$$tre

If	lLargeurDw > lLargeurUtile Then lLargeurDw = lLargeurUtile

// .... On retaille la DW et on la centre

This.Width		= lLargeurDw

// Si alMGauche = 0	-> Centrage dans la fen$$HEX1$$ea00$$ENDHEX$$tre
// Sinon 				-> Positionnement en X

If	almGauche = 0 Then
	lX = lMargeGauche + ( ( lLargeurUtile - lLargeurDw ) / 2 )
Else
	lX = alMGauche
End If
This.Move ( lX, This.Y )

Return ( lRet )


end function

public function long uf_hauteur (long alhaufenetre, long almhaut);//*******************************************************************************************
// Fonction            	: Uf_Hauteur
//	Auteur              	: Erick John Stark
//	Date 					 	: 22/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Positionnement en largeur de la DW
//
// Arguments				: alHauFenetre		Long				(Val)	Hauteur de la fen$$HEX1$$ea00$$ENDHEX$$tre
//								  alMHaut			Long				(Val) Position de la Marge Haute
//
// Retourne					: Long
//								  
//*******************************************************************************************


Long lNbMaxLig			// Nbre maximum de lignes sur la hauteur utile de l'$$HEX1$$e900$$ENDHEX$$cran
Long lNbrLig			// Nbre de ligne dans la DW actuellement
Long lMargeHaut		// Marge du Haut
Long lHauteurUtile	// Hauteur utile de la fen$$HEX1$$ea00$$ENDHEX$$tre
Long lHauteurDw		// Hauteur de la DW
Long lRet

lRet				= 1

// Si alMHaut	 = 0	-> Centrage dans la fen$$HEX1$$ea00$$ENDHEX$$tre
// Sinon 				-> Positionnement en Y

If	almHaut = 0 Then
	lMargeHaut = 240																	// On admet que la marge Haute est de 240
	lHauteurUtile	= Abs ( alHauFenetre - ( lMargeHaut + 100 ) )		// Hauteur Utile Maximale de la Fen$$HEX1$$ea00$$ENDHEX$$tre
Else
	lMargeHaut 		= almHaut
	lHauteurUtile	= alHauFenetre
End If

lNbrLig			= This.RowCount ()

lNbMaxLig = Int ( ( lHauteurUtile / PixelsToUnits( This.iiTmHeight, YPixelsToUnits! ) ) - 2 )

If	lNbrLig >= lNbMaxLig Then
	lNbrLig = lNbMaxLig
Else
	lNbrLig +=1
End If

lHauteurDw = PixelsToUnits ( ( This.iiTmHeight * 2 ) + ( This.iiTmHeight * lNbrLig ), YPixelsToUnits! )

If	lNbrLig = lNbMaxLig Or almHaut <> 0 Then
	This.Y = lMargeHaut
Else
	This.Y = lMargeHaut + ( ( lHauteurUtile - lHauteurDw ) / 3 )
End If

This.Height = lHauteurDw

Return ( lRet )


end function

public function string uf_nom_detail ();//*******************************************************************************************
// Fonction            	: Uf_Nom_Detail
//	Auteur              	: La Recrue
//	Date 					 	: 05/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Retourne le nom du d$$HEX1$$e900$$ENDHEX$$tail
//
// Arguments				: Rien
//
// Retourne					: Le Nom du d$$HEX1$$e900$$ENDHEX$$tail
//								  
//*******************************************************************************************

Return isNomDetail
end function

public function boolean uf_supprimerligne ();//*******************************************************************************************
// Fonction            	: u_DataWindow_detail::uf_SupprimerLigne
//	Auteur              	: La Recrue
//	Date 					 	: 12/12/1996

//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Suppression d'une ligne sur un d$$HEX1$$e900$$ENDHEX$$tail source
// Commentaires			: 
//	
// Arguments				: Aucun
//
// Retourne					: Bool$$HEX1$$e900$$ENDHEX$$en - Vrai si la copie s'est bien pass$$HEX1$$e900$$ENDHEX$$e								  
//*******************************************************************************************

Boolean bOk

This.SetRedraw( False )

bOk = ( This.DeleteRow( ilLigneClick ) > 0 )

If ( This.Rowcount() > 0 ) Then

	This.SetRow( Max ( ilLigneClick - 1, 1 ) )
	This.ScrollToRow( Max ( ilLigneClick - 1, 1 ) )

	If ilLigneClick = 1 Then
		This.TriggerEvent( RowFocusChanged! )
	End If
			
End If

This.SetRedraw( True )

Return ( bOk )

end function

public subroutine uf_activer_selection (boolean abactivation);//*******************************************************************************************
// Fonction            	: Uf_Activer_Selection
//	Auteur              	: La Recrue
//	Date 					 	: 05/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Permet d'activer ou de d$$HEX1$$e900$$ENDHEX$$sactiver la selection des lignes dans la DW
//
// Arguments				: Boolean		abActivation	(Val)	Choix d'activation ou non
//
// Retourne					: (None)
//								  
//*******************************************************************************************

ibSelectionActive = abActivation
end subroutine

public function boolean uf_ajouter_clause (string ascondition[]);//*******************************************************************************************
// Fonction            	: Uf_Ajouter_Clause
//	Auteur              	: La Recrue
//	Date 					 	: 19/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Permet d'ajouter une clause where au select de la dw
// Commentaires			: Sert dans le cas d'une construction dinamique de dw sur un detail 
//                        d'une fen$$HEX1$$ea00$$ENDHEX$$tre de traitement master. ( Pas de recherche par int$$HEX1$$e900$$ENDHEX$$rro ! )
//
// Arguments				: asClause		String	(Val) Clause where $$HEX2$$e0002000$$ENDHEX$$ajouter
//
// Retourne					: Rien
//								  
//*******************************************************************************************

String	sClause
Long		li

sClause = " Where"

For li = 1 To UpperBound( asCondition )

	sClause = sClause + " " + asCondition[li]

Next

// .... On concatene le SELECT de la DW + la Clause WHERE + la jointure CLIENTE de la DW

If	sClause <> "" Then

	sClause = This.isSelect + sClause + " " + This.isJointure
	Return ( This.Modify ( "DataWindow.Table.Select = ~"" + sClause + "~"" ) = "" )
Else

	Return ( False )
End If



end function

public function boolean uf_autoriserupdate (string astable);//*******************************************************************************************
// Fonction            	: Uf_AutoriserUpdate
//	Auteur              	: La Recrue
//	Date 					 	: 26/12/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Permet de modifier une datawindow dynamique pour autoriser l'update
//								  sur un d$$HEX1$$e900$$ENDHEX$$tail.
//
// Arguments				: String		as Table (Val)	Table $$HEX2$$e0002000$$ENDHEX$$mettre $$HEX2$$e0002000$$ENDHEX$$jour 
//
// Retourne					: Bool		Vrai si les modify se sont bien executer
//								  
//*******************************************************************************************


Long	lI
String	sErr, sMod


//<DW Control Name>.Modify(&
//"DataWindow.Table.UpdateTable='<string containing updateable table name>'")

sErr = This.Modify( "Datawindow.Table.UpdateTable='sysadm." + asTable + "'")
If ( sErr <> "" ) Then
	MessageBox(" Modigy Erreur ", sErr, StopSign! )
	Return False
End If

sErr = This.Modify( "Datawindow.Table.UpdateKeyInPlace=Yes" )
If ( sErr <> "" ) Then
	MessageBox(" Modigy Erreur ", sErr, StopSign! )
	Return False
End If

sErr = This.Modify( "Datawindow.Table.UpdateWhere=0" )
If ( sErr <> "" ) Then
	MessageBox(" Modigy Erreur ", sErr, StopSign! )
	Return False
End If

For li = 1 to upperBound ( This.istCol )

	If ( Pos( This.istCol[lI].sDbName, "." ) > 0 ) Then
		sMod = Right( This.istCol[lI].sDbName, Len ( This.istCol[lI].sDbName ) - Pos( This.istCol[lI].sDbName, "." ) )
	Else
		sMod = This.istCol[lI].sDbName
	End If

	If ( This.istCol[lI].sUpdate = 'O' ) Then

		sErr = This.Modify( sMod + ".update=Yes" )

		If ( sErr <> "" ) Then
			MessageBox(" Modigy Erreur ", sErr, StopSign! )
			Return False
		End If
	End If

	If ( This.istCol[lI].sCle = 'O' ) Then

		sErr = This.Modify( sMod + ".Key=Yes" )

		If ( sErr <> "" ) Then
			MessageBox(" Modigy Erreur ", sErr, StopSign! )
			Return False
		End If
	End If

Next

Return True
end function

public subroutine uf_filter (string asfilter);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_filter
//* Auteur			:	La Recrue
//* Date				:	19/03/1997 08:28:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX2$$e9002000$$ENDHEX$$un filtre sur la DW
//* Commentaires	:	Metre un "" pour annuler le filtre
//*
//* Arguments		:	String	asFilter		(Val)	Filtre
//*
//* Retourne		:	Rien 
//*
//*-----------------------------------------------------------------
//* N$$HEX2$$b0002000$$ENDHEX$$Modif          Re$$HEX1$$e700$$ENDHEX$$ue Le          Effectu$$HEX1$$e900$$ENDHEX$$e Le          PAR
//*
//* MOD-0001          18/03/97            18/03/97				La Recrue
//*
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* MOD-0001                                                         */
/* OverWrite de la m$$HEX1$$e900$$ENDHEX$$thode Uf_Filter pour que le selection des      */
/* lignes puissent fonctionner en cas de filtre sur le d$$HEX1$$e900$$ENDHEX$$tail.      */
/*------------------------------------------------------------------*/

If ( ibSelectionActive ) Then
	This.SelectRow ( 0, False )
End If

This.SetFilter( asFilter )
This.Filter()

This.SetSort( This.isTri )
This.Sort()

If This.RowCount() > 0 Then

	This.SetRow(1)
	This.ScrollToRow(1)

	If ibSelectionActive Then
		This.SelectRow ( 1, True )
	End If

	ilLigneClick = 1

End If
end subroutine

public subroutine uf_creer_tout (ref s_creer_dw astcol[], ref string astable[], ref u_transaction atrtrans);//*******************************************************************************************
// Fonction            	: Uf_Creer_Tout
//	Auteur              	: Erick John Stark
//	Date 					 	: 22/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Lancement de toutes les fonctions pour cr$$HEX1$$e900$$ENDHEX$$er la DW d'accueil
//
// Arguments				: s_Creer_Dw	astCol[]			(R$$HEX1$$e900$$ENDHEX$$f)	Structure cliente correspondant aux colonnes
// 							  String			asTable[]		(R$$HEX1$$e900$$ENDHEX$$f)	Liste des tables
//								  u_transaction	atrTrans		(R$$HEX1$$e900$$ENDHEX$$f) Objet de transaction
//
// Retourne					: Rien
//								  
//*******************************************************************************************


This.Uf_Creer_Select ( astCol, asTable )
This.Uf_Cst_Syntax ( astCol, atrTrans )



end subroutine

public function string uf_getdefaultheadersuffix ();//*-----------------------------------------------------------------
//*
//* Fonction		: u_datawindow_detail::Uf_GetDefaultHeaderSuffix
//* Auteur			: WYNIWYG
//* Date				: 31/03/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:
//* Commentaires	: retourne le suffixe $$HEX2$$e0002000$$ENDHEX$$ajouter $$HEX2$$e0002000$$ENDHEX$$un nom de colonne afin de
//*					  cr$$HEX1$$e900$$ENDHEX$$er le nom de l'ent$$HEX1$$ea00$$ENDHEX$$te de la colonne
//*					  le suffixe n'existait $$HEX2$$e0002000$$ENDHEX$$priori pas sous PB4
//*					  cr$$HEX3$$e900e9002000$$ENDHEX$$lors de la Migration PB8-WYNIWYG-03/2004
//*
//* Arguments		: st_Accueil	astAccueil[]		(R$$HEX1$$e900$$ENDHEX$$f) Tableau des colonnes
//						  String			asTable[]			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau des tables
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

return "_t"

end function

public function string uf_construire_syntax (ref s_creer_dw astaccueil[], ref long al_largeurtotale);//*-----------------------------------------------------------------
//*
//* Fonction		: u_datawindow_detail::Uf_Construire_Syntax
//* Auteur			: WYNIWYG
//* Date				: 31/03/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:
//* Commentaires	: Construction dynamique d'une DataWindow
//*					  cr$$HEX3$$e900e9002000$$ENDHEX$$lors de la Migration PB8-WYNIWYG-03/2004
//*
//* Arguments		: st_Accueil	astAccueil[]		(R$$HEX1$$e900$$ENDHEX$$f) Tableau des colonnes
//						  String			asTable[]			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau des tables
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

CONSTANT String	K_Retour	= "~r~n"

CONSTANT String	K_COLTMP1 =																														+ &
' font.face="Courier New" font.height="-10" font.weight="400" font.charset="0" font.pitch="2" '									+ &
' font.family="3" font.underline="0" font.italic="0" border="0" color="0" background.mode="1" background.color="0" '	+ &
' edit.autoselect=yes edit.autohscroll=yes ' // [SUISSE].LOT3

CONSTANT String	K_COLTMP2 =																														+ &
' font.face="MS Sans Serif" font.height="-8" font.weight="400" font.charset="0" font.pitch="2" '							+ &
' font.family="2" font.underline="0" font.italic="0" border="6" color="16711680" background.mode="0" '					+ &
' background.color="12632256" alignment="2" '

UnsignedInteger 	uiHdc								// Handle sur le Device CONTEXT
UnsignedInteger 	uiHwnd							// Handle sur la DataWindow

Long					lEspaceInterCol				// Espace en pixels entre chaque colonne
Long					lXpos								// Abscisse de la colonne $$HEX2$$e0002000$$ENDHEX$$afficher

Long					lLargeurCol						// Largeur de la colonne $$HEX2$$e0002000$$ENDHEX$$afficher
Long 					lPos

Integer				iLngHeader						// Longeur du Header d'une colonne

Integer				iNbCol, iCpt//, iNbTable
Integer				istHauteur						// Hauteur d'un caract$$HEX1$$e900$$ENDHEX$$re (PIXEL)
Integer				istLargeur						// Largeur moyenne d'un caract$$HEX1$$e800$$ENDHEX$$re (PIXEL)

String				sInvisible						// Gestion de l'attribut VISIBLE
String				sFormat							// Gestion de l'attribut FORMAT
String				sCodeTable						// Gestion de l'attribut EDIT VALUE
String				sValues							// Gestion de l'attribut EDIT VALUE
String				sName								// Gestion de l'attribut NAME
String				sBitmap							// Gestion de l'attribut BITMAP
String				sUpdate							// Gestion de l'attribut UPDATE
String				sKey								// Gestion de l'attribut KEY

String				sTable							// Gestion de l'attribut TABLE
String				sColumn							// Gestion de l'attribut COLUMN
String				sPointeur						// Gestion de l'attribut POINTEUR

String				sSyntaxe							// Syntaxe g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e

String				nvPfc_String					//N_Cst_String	 	nvPfc_String

iNbCol				= UpperBound ( astAccueil )
//iNbTable				= UpperBound ( asTable )

lXPos					= 3
lEspaceInterCol 	= 6

/*------------------------------------------------------------------*/
/* On va r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer la hauteur d'un PIXEL ainsi que la largeur       */
/* moyenne d'un caract$$HEX1$$e900$$ENDHEX$$re.                                          */
/*------------------------------------------------------------------*/
//If	IsValid ( Gnv_App.iGLB )	Then
//	Gnv_App.iGLB.Uf_GetHtLg ( istHauteur, istLargeur )
//PB4  u_datawindow_detail.uf_cst_syntax L77
//on conserve simplement les valeurs par d$$HEX1$$e900$$ENDHEX$$faut
//Else
	istHauteur = 16 // 13 [SUISSE].LOT3
	istLargeur =  8
//End If

/*------------------------------------------------------------------*/
/* Si le curseur n'est pas initialis$$HEX1$$e900$$ENDHEX$$, on positionne un curseur     */
/* par d$$HEX1$$e900$$ENDHEX$$faut.                                                      */
/*------------------------------------------------------------------*/
//If	IsNull ( isCurseur ) Or Len ( Trim ( isCurseur ) ) = 0	Then
//	isCurseur = Gnv_App.K_REPBMP + "DBLCLICK.CUR"
//c'$$HEX1$$e900$$ENDHEX$$tait la variable d'instance isPointer qui $$HEX1$$e900$$ENDHEX$$tait pass$$HEX4$$e9002000e0002000$$ENDHEX$$la fonction
//(valeur : "K:\PB4OBJ\BMP\DBLCLICK.CUR")
//End If

//sPointeur = ' pointer= "' + isCurseur + '" )'
sPointeur = ' pointer= "' + isPointer + '" )'
//Migration PB8-WYNIWYG-03/2004
//sSyntaxe	 = 'release 6;' + K_RETOUR + 'datawindow ( units=1 timer_interval=0 color=16777215 processing=0 print.margin.bottom=24 print.margin.left=24 print.margin.right=24 print.margin.top=24 ' + sPointeur + K_RETOUR
  sSyntaxe	 = 'release 8;' + K_RETOUR + 'datawindow ( units=1 timer_interval=0 color=16777215 processing=0 HTMLDW=no print.documentname="" print.orientation = 0 print.margin.bottom = 24 print.margin.left = 24 print.margin.right = 24 print.margin.top = 24 print.paper.source = 0 print.paper.size = 0 print.prompt=no print.buttons=no print.preview.buttons=no ' + sPointeur + K_RETOUR
//Fin Migration PB8-WYNIWYG-03/2004
sTable 	 = "table( " + K_RETOUR

For	iCpt = 1 To iNbCol
/*------------------------------------------------------------------*/
/* Si la colonne est invisible, on positionne l'attribut            */
/* correspondant $$HEX2$$e0002000$$ENDHEX$$0. La largeur de la colonne est positionn$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$0. */
/*------------------------------------------------------------------*/
		If	astAccueil[ iCpt ].sInvisible = "O"	Then
			sInvisible			= ' visible="0"'
			sCodeTable			= ""
			sValues				= ""
			sFormat				= ""
			sBitmap				= ""
			lLargeurCol			= 0
		Else
/*------------------------------------------------------------------*/
/* La colonne est visible, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la longeur de l'entete.      */
/*------------------------------------------------------------------*/
			sInvisible  =  ""
			iLngHeader = Len ( astAccueil[ iCpt ].sHeaderName )
/*------------------------------------------------------------------*/
/* On calcule la largeur d'une colonne, on comparant le nombre de   */
/* caract$$HEX1$$e800$$ENDHEX$$res $$HEX2$$e0002000$$ENDHEX$$afficher et la longeur de l'ENTETE.                 */
/*------------------------------------------------------------------*/
			If astAccueil[ iCpt ].iLargeur < iLngHeader Then
				lLargeurCol	=	iLngHeader * ( istLargeur  )
			Else
				lLargeurCol	= ( astAccueil[ iCpt ].iLargeur * ( istLargeur  ) )
			End if
/*------------------------------------------------------------------*/
/* Si la valeur d'alignement n'esp pas positionn$$HEX1$$e900$$ENDHEX$$, on positionne    */
/* la colonne $$HEX2$$e0002000$$ENDHEX$$GAUCHE.                                             */
/*------------------------------------------------------------------*/
			If astAccueil[ iCpt ].sAlignement = "" Then astAccueil[ iCpt ].sAlignement = "0"

/*------------------------------------------------------------------*/
/* On s'occupe d'un BITMAP $$HEX1$$e900$$ENDHEX$$ventuel.                                */
/*------------------------------------------------------------------*/
			If	astAccueil[ iCpt ].sBitmap = "O"	Then
				sBitmap = " bitmapname=yes "
			Else
				sBitmap = ""
			End If
/*------------------------------------------------------------------*/
/* On s'occupe d'un FORMAT $$HEX1$$e900$$ENDHEX$$ventuel.                                */
/*------------------------------------------------------------------*/
			If ( Not IsNull ( astAccueil[ iCpt ].sFormat ) ) And ( Len ( Trim ( astAccueil[ iCpt ].sFormat ) ) > 0 ) Then
				sFormat	= ' Format = "' + astAccueil[ iCpt ].sFormat + '" '
			Else
				sFormat	= ""
			End If
/*------------------------------------------------------------------*/
/* On s'occupe d'un EDIT VALUE $$HEX1$$e900$$ENDHEX$$ventuel.                            */
/*------------------------------------------------------------------*/
			If ( Len ( Trim ( astAccueil[ iCpt ].sValues ) ) = 0 ) Or ( IsNull ( astAccueil[ iCpt ].sValues ) ) Then
				sCodeTable	= ""
				sValues		= ""
			Else
				sCodeTable	= ' edit.codetable=yes '
				sValues		= ' values="' + astAccueil[ iCpt ].sValues + '"'
			End If
		End If
/*------------------------------------------------------------------*/
/* On s'occupe du RESULT SET.                                       */
/*------------------------------------------------------------------*/
//[I037] Migration Funcky
//u_declarationfuncky	ufuncky
//ufuncky = create u_declarationfuncky
		If	( Len ( Trim ( astAccueil[ iCpt ].sResultSet ) ) = 0 ) Or ( IsNull ( astAccueil[ iCpt ].sResultSet ) ) Then
//			lPos = nvPfc_String.of_LastPos ( astAccueil[ iCpt ].sDbName, ".", 0 )
//			lPos = ufuncky.uf_atlast(".", astAccueil[ iCpt ].sDbName)
			lPos = LastPos( astAccueil[ iCpt ].sDbName, ".") // Une fct native PB est maintenat dispo
			sName = Mid ( astAccueil[ iCpt ].sDbName, lPos+1 )
		Else
			sName = astAccueil[ iCpt ].sResultSet
		End If
//If IsValid(ufuncky) then Destroy(ufuncky)
/*------------------------------------------------------------------*/
/* On s'occupe de l'UPDATE de la colonne.                           */
/*------------------------------------------------------------------*/
		If ( Len ( Trim ( astAccueil[ iCpt ].sUpdate ) ) = 0 ) Or ( IsNull ( astAccueil[ iCpt ].sUpdate ) ) Or astAccueil[ iCpt ].sUpdate = "N"	Then
			sUpdate = 'Update=no'
		Else
			sUpdate = 'Update=yes'
		End If

/*------------------------------------------------------------------*/
/* On s'occupe de l'attribut KEY.                                   */
/*------------------------------------------------------------------*/
		If ( Len ( Trim ( astAccueil[ iCpt ].sCle ) ) = 0 ) Or ( IsNull ( astAccueil[ iCpt ].sCle ) ) Or astAccueil[ iCpt ].sCle = "N"	Then
			sKey = 'Key=no'
		Else
			sKey = 'Key=yes'
		End If

		sTable	=	sTable 																						+ &
				  	 	'column=( type=' + astAccueil[ iCpt ].sType 										+ &
					 	' ' + sUpdate + ' ' + sKey																+ &
					 	' name=' + sName																			+ &
					 	' dbname="' + astAccueil[ iCpt ].sDbName + '"' + sValues		 				+ &
						')' + K_RETOUR

		sColumn 	= sColumn 																						+ &
					 	' column( band=detail id=' + String ( iCpt )										+ &
					 	' x="' + String ( lXpos ) +  '"' 													+ &
					 	' y="0"' 																					+ &
					 	' width="' + String ( lLargeurCol ) + '"'											+ &
					 	' tabsequence=0 edit.limit=1'															+ &
						 sBitmap																						+ &
					 	' height="' + String ( istHauteur ) + '"'											+ &
					 	' alignment="' + astAccueil[ iCpt ].sAlignement + '"' 						+ &
						K_COLTMP1 																					+ &
						sCodeTable																					+ &
						sFormat																						+ &
						sInvisible																					+ &
					 	' edit.autovscroll=no edit.focusrectangle=yes ) ' + K_RETOUR 				+ &
					 	' text( band=header text="' + astAccueil[ iCpt ].sHeaderName + '"'	 	+ &
						' x="' + String (lXpos) + '"' +  ' y="4"'											+ &
					 	' height="' + String ( istHauteur ) + '"'											+ &
					 	' width="' + String ( lLargeurCol ) + '"' 										+ &
						K_COLTMP2 																					+ &
						sInvisible																					+ &
						' name='+ sName + This.uf_GetDefaultHeaderSuffix () + ')' + K_RETOUR
//						' name='+ sName + This.Of_GetDefaultHeaderSuffix () + ')' + K_RETOUR
//fct pfc pb8 retourne suffixe d'un header pfc ncst dwsrv   is_default header suffix   _t
//

		If astAccueil[ iCpt ].sInvisible = "N" Then	lXpos = lXpos + lLargeurCol + lEspaceInterCol

Next

sSyntaxe	=	sSyntaxe 																													+	&
				sTable		+ ')' + K_RETOUR 																							+	&
				'header( height=' + String ( Int ( istHauteur + 3 + ( istHauteur / 2 ) ) ) + ')' + K_RETOUR 		+ 	&
				'detail( height=' + String ( istHauteur ) + ')' + K_RETOUR 													+	&
				sColumn
al_largeurtotale = lXpos
return sSyntaxe
///*------------------------------------------------------------------*/
///* On va maintenant construire la DataWindow.                       */
///*------------------------------------------------------------------*/
//idw_Requestor.Create ( sSyntaxe )
//
///*------------------------------------------------------------------*/
///* Si l'utilisateur le d$$HEX1$$e900$$ENDHEX$$sire, on centre la DW dans l'espace de la  */
///* fen$$HEX1$$ea00$$ENDHEX$$tre FRAME.                                                   */
///*------------------------------------------------------------------*/
//If	ibCentrage Then
//	This.ilHauteurDw = istHauteur
//
//	lXpos = PixelsToUnits ( lXpos, XPixelsToUnits! )
//	This.Uf_Largeur ( lXpos )
//	This.Uf_Hauteur ()
//End If
end function

private function integer uf_cst_syntax_dga (ref s_creer_dw astCol[], ref u_Transaction atrTrans);////*-----------------------------------------------------------------
////*
////* Fonction		: N_Cst_DwSrv_Acc::Uf_Construire_Syntaxe
////* Auteur			: Erick John Stark
////* Date				: 06/09/1999 10:56:05
////* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
////* Commentaires	: Construction dynamique d'une ACCUEIL
////*
////* Arguments		: st_Accueil	astCol[]		(R$$HEX1$$e900$$ENDHEX$$f) Tableau des colonnes
////						  String			asTable[]			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau des tables
////*
////* Retourne		: Rien
////*
////*-----------------------------------------------------------------
//
//String	K_Retour	= "~r~n"
//
//String	K_COLTMP1 =																														+ &
//' font.face="Courier" font.height="-8" font.weight="400" font.charset="0" font.pitch="2" '									+ &
//' font.family="3" font.underline="0" font.italic="0" border="0" color="0" background.mode="1" background.color="0" '	+ &
//' edit.autoselect=yes edit.autohscroll=yes '
//
//String	K_COLTMP2 =																														+ &
//' font.face="MS Sans Serif" font.height="-8" font.weight="400" font.charset="0" font.pitch="2" '							+ &
//' font.family="2" font.underline="0" font.italic="0" border="6" color="16711680" background.mode="0" '					+ &
//' background.color="12632256" alignment="2" '
//
//UnsignedInteger 	uiHdc								// Handle sur le Device CONTEXT
//UnsignedInteger 	uiHwnd							// Handle sur la DataWindow
//
//Long					lEspaceInterCol				// Espace en pixels entre chaque colonne
//Long					lXpos								// Abscisse de la colonne $$HEX2$$e0002000$$ENDHEX$$afficher
//
//Long					lLargeurCol						// Largeur de la colonne $$HEX2$$e0002000$$ENDHEX$$afficher
//Long 					lPos
//
//Integer				iLngHeader						// Longeur du Header d'une colonne
//
//Integer				iNbCol, iNbTable, iCpt
//Integer				istHauteur						// Hauteur d'un caract$$HEX1$$e900$$ENDHEX$$re (PIXEL)
//Integer				istLargeur						// Largeur moyenne d'un caract$$HEX1$$e800$$ENDHEX$$re (PIXEL)
//
//String				sInvisible						// Gestion de l'attribut VISIBLE
//String				sFormat							// Gestion de l'attribut FORMAT
//String				sCodeTable						// Gestion de l'attribut EDIT VALUE
//String				sValues							// Gestion de l'attribut EDIT VALUE
//String				sName								// Gestion de l'attribut NAME
//String				sBitmap							// Gestion de l'attribut BITMAP
//String				sUpdate							// Gestion de l'attribut UPDATE
//String				sKey								// Gestion de l'attribut KEY
//
//String				sTable							// Gestion de l'attribut TABLE
//String				sColumn							// Gestion de l'attribut COLUMN
//String				sPointeur						// Gestion de l'attribut POINTEUR
//
//String				sSyntaxe							// Syntaxe g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e
//
////N_Cst_String	 	nvPfc_String
//
//iNbCol				= UpperBound ( astCol )
////iNbTable				= UpperBound ( asTable )
//
//lXPos					= 3
//lEspaceInterCol 	= 6
//
///*------------------------------------------------------------------*/
///* On va r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer la hauteur d'un PIXEL ainsi que la largeur       */
///* moyenne d'un caract$$HEX1$$e900$$ENDHEX$$re.                                          */
///*------------------------------------------------------------------*/
//If	IsValid ( Gnv_App.iGLB )	Then
//	Gnv_App.iGLB.Uf_GetHtLg ( istHauteur, istLargeur )
//Else
//	istHauteur = 13
//	istLargeur =  8
//End If
//
///*------------------------------------------------------------------*/
///* Si le curseur n'est pas initialis$$HEX1$$e900$$ENDHEX$$, on positionne un curseur     */
///* par d$$HEX1$$e900$$ENDHEX$$faut.                                                      */
///*------------------------------------------------------------------*/
//If	IsNull ( isCurseur ) Or Len ( Trim ( isCurseur ) ) = 0	Then
//	isCurseur = Gnv_App.K_REPBMP + "DBLCLICK.CUR"
//End If
//
//sPointeur = ' pointer= "' + isCurseur + '" )'
//sSyntaxe	 = 'release 6;' + K_RETOUR + 'datawindow ( units=1 timer_interval=0 color=16777215 processing=0 print.margin.bottom=24 print.margin.left=24 print.margin.right=24 print.margin.top=24 ' + sPointeur + K_RETOUR
//sTable 	 = "table( " + K_RETOUR
//
//For	iCpt = 1 To iNbCol
///*------------------------------------------------------------------*/
///* Si la colonne est invisible, on positionne l'attribut            */
///* correspondant $$HEX2$$e0002000$$ENDHEX$$0. La largeur de la colonne est positionn$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$0. */
///*------------------------------------------------------------------*/
//		If	astCol[ iCpt ].sInvisible = "O"	Then
//			sInvisible			= ' visible="0"'
//			sCodeTable			= ""
//			sValues				= ""
//			sFormat				= ""
//			sBitmap				= ""
//			lLargeurCol			= 0
//		Else
///*------------------------------------------------------------------*/
///* La colonne est visible, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la longeur de l'entete.      */
///*------------------------------------------------------------------*/
//			sInvisible  =  ""
//			iLngHeader = Len ( astCol[ iCpt ].sHeaderName )
///*------------------------------------------------------------------*/
///* On calcule la largeur d'une colonne, on comparant le nombre de   */
///* caract$$HEX1$$e800$$ENDHEX$$res $$HEX2$$e0002000$$ENDHEX$$afficher et la longeur de l'ENTETE.                 */
///*------------------------------------------------------------------*/
//			If astCol[ iCpt ].iLargeur < iLngHeader Then
//				lLargeurCol	=	iLngHeader * ( istLargeur  )
//			Else
//				lLargeurCol	= ( astCol[ iCpt ].iLargeur * ( istLargeur  ) )
//			End if	
///*------------------------------------------------------------------*/
///* Si la valeur d'alignement n'esp pas positionn$$HEX1$$e900$$ENDHEX$$, on positionne    */
///* la colonne $$HEX2$$e0002000$$ENDHEX$$GAUCHE.                                             */
///*------------------------------------------------------------------*/
//			If astCol[ iCpt ].sAlignement = "" Then astCol[ iCpt ].sAlignement = "0"
//			
///*------------------------------------------------------------------*/
///* On s'occupe d'un BITMAP $$HEX1$$e900$$ENDHEX$$ventuel.                                */
///*------------------------------------------------------------------*/
//			If	astCol[ iCpt ].sBitmap = "O"	Then
//				sBitmap = " bitmapname=yes "
//			Else
//				sBitmap = ""
//			End If
///*------------------------------------------------------------------*/
///* On s'occupe d'un FORMAT $$HEX1$$e900$$ENDHEX$$ventuel.                                */
///*------------------------------------------------------------------*/
//			If ( Not IsNull ( astCol[ iCpt ].sFormat ) ) And ( Len ( Trim ( astCol[ iCpt ].sFormat ) ) > 0 ) Then
//				sFormat	= ' Format = "' + astCol[ iCpt ].sFormat + '" '
//			Else
//				sFormat	= ""
//			End If
///*------------------------------------------------------------------*/
///* On s'occupe d'un EDIT VALUE $$HEX1$$e900$$ENDHEX$$ventuel.                            */
///*------------------------------------------------------------------*/
//			If ( Len ( Trim ( astCol[ iCpt ].sValues ) ) = 0 ) Or ( IsNull ( astCol[ iCpt ].sValues ) ) Then
//				sCodeTable	= ""
//				sValues		= ""
//			Else
//				sCodeTable	= ' edit.codetable=yes '
//				sValues		= ' values="' + astCol[ iCpt ].sValues + '"'
//			End If
//		End If
///*------------------------------------------------------------------*/
///* On s'occupe du RESULT SET.                                       */
///*------------------------------------------------------------------*/
//		If	( Len ( Trim ( astCol[ iCpt ].sResultSet ) ) = 0 ) Or ( IsNull ( astCol[ iCpt ].sResultSet ) ) Then
//			lPos = nvPfc_String.of_LastPos ( astCol[ iCpt ].sDbName, ".", 0 )
//			sName = Mid ( astCol[ iCpt ].sDbName, lPos+1 )
//		Else
//			sName = astCol[ iCpt ].sResultSet
//		End If
//		
///*------------------------------------------------------------------*/
///* On s'occupe de l'UPDATE de la colonne.                           */
///*------------------------------------------------------------------*/
//		If ( Len ( Trim ( astCol[ iCpt ].sUpdate ) ) = 0 ) Or ( IsNull ( astCol[ iCpt ].sUpdate ) ) Or astCol[ iCpt ].sUpdate = "N"	Then
//			sUpdate = 'Update=no'
//		Else
//			sUpdate = 'Update=yes'
//		End If
//		
///*------------------------------------------------------------------*/
///* On s'occupe de l'attribut KEY.                                   */
///*------------------------------------------------------------------*/
//		If ( Len ( Trim ( astCol[ iCpt ].sCle ) ) = 0 ) Or ( IsNull ( astCol[ iCpt ].sCle ) ) Or astCol[ iCpt ].sCle = "N"	Then
//			sKey = 'Key=no'
//		Else
//			sKey = 'Key=yes'
//		End If
//		
//		sTable	=	sTable 																						+ &
//				  	 	'column=( type=' + astCol[ iCpt ].sType 										+ &
//					 	' ' + sUpdate + ' ' + sKey																+ &
//					 	' name=' + sName																			+ &
//					 	' dbname="' + astCol[ iCpt ].sDbName + '"' + sValues		 				+ &
//						')' + K_RETOUR 
//
//		sColumn 	= sColumn 																						+ &
//					 	' column( band=detail id=' + String ( iCpt )										+ &
//					 	' x="' + String ( lXpos ) +  '"' 													+ &
//					 	' y="0"' 																					+ &
//					 	' width="' + String ( lLargeurCol ) + '"'											+ &
//					 	' tabsequence=0 edit.limit=1'															+ &
//						 sBitmap																						+ &
//					 	' height="' + String ( istHauteur ) + '"'											+ &
//					 	' alignment="' + astCol[ iCpt ].sAlignement + '"' 						+ &
//						K_COLTMP1 																					+ &
//						sCodeTable																					+ &
//						sFormat																						+ &
//						sInvisible																					+ &
//					 	' edit.autovscroll=no edit.focusrectangle=yes ) ' + K_RETOUR 				+ &
//					 	' text( band=header text="' + astCol[ iCpt ].sHeaderName + '"'	 	+ &
//						' x="' + String (lXpos) + '"' +  ' y="4"'											+ &
//					 	' height="' + String ( istHauteur ) + '"'											+ &
//					 	' width="' + String ( lLargeurCol ) + '"' 										+ &
//						K_COLTMP2 																					+ &						 
//						sInvisible																					+ &
//						' name='+ sName + This.Of_GetDefaultHeaderSuffix () + ')' + K_RETOUR
//												
//		If astCol[ iCpt ].sInvisible = "N" Then	lXpos = lXpos + lLargeurCol + lEspaceInterCol	
//	
//Next
//
//sSyntaxe	=	sSyntaxe 																													+	&
//				sTable		+ ')' + K_RETOUR 																							+	&
//				'header( height=' + String ( Int ( istHauteur + 3 + ( istHauteur / 2 ) ) ) + ')' + K_RETOUR 		+ 	&
//				'detail( height=' + String ( istHauteur ) + ')' + K_RETOUR 													+	&
//				sColumn
//
///*------------------------------------------------------------------*/
///* On va maintenant construire la DataWindow.                       */
///*------------------------------------------------------------------*/
//idw_Requestor.Create ( sSyntaxe )
//
///*------------------------------------------------------------------*/
///* Si l'utilisateur le d$$HEX1$$e900$$ENDHEX$$sire, on centre la DW dans l'espace de la  */
///* fen$$HEX1$$ea00$$ENDHEX$$tre FRAME.                                                   */
///*------------------------------------------------------------------*/
//If	ibCentrage Then
//	This.ilHauteurDw = istHauteur
//
//	lXpos = PixelsToUnits ( lXpos, XPixelsToUnits! )
//	This.Uf_Largeur ( lXpos )
//	This.Uf_Hauteur ()
//End If
//
Return ( 1 )
end function

public function integer uf_setfromclause (ref string asselect, string asfromclause);//*******************************************************************************************
// Fonction            	: Uf_SetFromClause
//	Auteur              	: PHG
//	Date 					 	: 28/03/2011
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Remplace la clause From d$$HEX1$$e900$$ENDHEX$$finie dans un select Simple [I027] - France
// Commentaires			: Utile pour injecter des Jointures Externes $$HEX2$$e0002000$$ENDHEX$$la normes
//								  SQL ANSI-92 ( LEFT|RIGHT OUTER JOIN ... )
//
// Arguments				: asFromClause		String	(Val) Clause From $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$finir
//
// Retourne					: Integer, 0 => Ok, N$$HEX1$$e900$$ENDHEX$$gatif => Erreur
//								  
//*******************************************************************************************

integer iRet
integer iPosFrom
integer iPosWhere
string sStartSelect = ""
string sEndSelect = ""
string sFromClause = ""

iPosFrom = pos(asSelect, ' FROM', 1)+len(' FROM')
if iPosFrom > 0 then
	iPosWhere = pos(asSelect, ' WHERE', iPosFrom )
	sStartSelect = left(asSelect, iPosFrom )
	if iPosWhere > 0 Then sEndSelect = right(asSelect, len(asSelect) - iPosWhere)
	sFromClause = asfromclause
	asSelect = sStartSelect+sFromClause+sEndSelect
	iRet = 0
else
	iRet = -1
End If

return iRet

end function

public function integer uf_setfromclause (string asfromclause);//*******************************************************************************************
// Fonction            	: Uf_SetFromClause
//	Auteur              	: PHG
//	Date 					 	: 28/03/2011
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: Remplace la clause From d$$HEX1$$e900$$ENDHEX$$finie dans isSelect [I027] - France
// Commentaires			: Utile pour injecter des Jointures Externes $$HEX2$$e0002000$$ENDHEX$$la normes
//									SQL ANSI-92 ( LEFT|RIGHT OUTER JOIN ... )
//
// Arguments				: asFromClause		String	(Val) Clause From $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$finir
//
// Retourne					: Integer, 0 => Ok, N$$HEX1$$e900$$ENDHEX$$gatif => Erreur
//								  
//*******************************************************************************************

return uf_Setfromclause( isSelect, asfromclause )


end function

event ue_majaccueil;call super::ue_majaccueil;//*****************************************************************************
//
// Objet 		: u_DataWindow_Accueil
// Evenement 	: ue_MajAccueil
//	Auteur		: D.Bizien
//	Date			: 18/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Mise $$HEX2$$e0002000$$ENDHEX$$jour de la datawindow Accueil apr$$HEX1$$e800$$ENDHEX$$s Modification
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

s_Pass stPass

This.SetRedraw ( False )

stPass = Message.PowerObjectParm

Choose Case stPass.sTab[1]

	Case "CRE"

		This.ImportString ( stPass.sTab[2] )
		This.SelectRow ( 0, False )
		This.SelectRow ( This.RowCount (), True )
		This.TriggerEvent ( "ue_Trier" )
		This.ilLigneClick = This.GetSelectedRow ( 0 )
		This.ScrollToRow ( This.ilLigneClick )

	Case "MOD"

		This.DeleteRow ( This.ilLigneClick )
		This.ImportString ( stPass.sTab[2] )
		This.SelectRow ( 0, False )
		This.SelectRow ( This.RowCount (), True )
		This.TriggerEvent ( "ue_Trier" )
		This.ilLigneClick = This.GetSelectedRow ( 0 )
		This.ScrollToRow ( This.ilLigneClick )

	Case "SUP"

		This.DeleteRow ( This.ilLigneClick )
		This.SelectRow ( 0, False )
		This.TriggerEvent ( "ue_Trier" )
//		This.ilLigneClick = 0
		If ( This.RowCount() > 0 ) Then
			This.SetRow(1)
			This.ScrollToRow(1)
			This.SelectRow( 1, True )
			This.ilLigneClick = 1
		End If

	Case "RET"

End Choose

This.SetRedraw ( True )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event we_touche;call super::we_touche;//*****************************************************************************
//
// Objet 		: U_DataWindow_Detail
// Evenement 	: we_Touche
//	Auteur		: D.Bizien	
//	Date			: 11/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Conservation du CTRL+INS
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

If	( KeyDown( KeyControl! ) ) Then
	If	( KeyDown( KeyInsert! ) )	Then
		Parent.TriggerEvent ( "ue_Creer" )
	End If
End If


If ( GetSelectedRow(0) > 0  ) Then
	If ( KeyDown ( KeySpaceBar! ) ) Then
		Parent.TriggerEvent ( "ue_modifier" )
	End If

	If ( KeyDown ( KeyDelete! ) ) Then
		Parent.TriggerEvent ( "ue_SupprimerDetail" )
	End If
End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event constructor;call super::constructor;//*****************************************************************************
//
// Objet 		: U_DataWindow_Detail
// Evenement 	: Constructor
//	Auteur		: La Recrue
//	Date			: 05/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Initialisation des variables d'instances
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

isNomDetail	= Lower( ClassName() )

uf_Mnu_MontrerItem( 1 )
uf_Mnu_MontrerItem( 2 )
uf_Mnu_MontrerItem( 3 )

/*------------------------------------------------------------------*/
/* Le 02/06/1998.                                                   */
/* On ne veut pas de la gestion de We_Touche, car on se trouve sur  */
/* un u_DataWindow_Detail                                           */
/*------------------------------------------------------------------*/
ibGestionTouche = False

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event retrievestart;call super::retrievestart;//*****************************************************************************
//
// Objet 		: U_DataWindow_detail
// Evenement 	: RetrieveStart
//	Auteur		: Y. Picard
//	Date			: 30/07/1997
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: On initialise ilLigneClick $$HEX2$$e0002000$$ENDHEX$$ZERO car dans le RetrieveEnd, on ne
//               positionne ilLigneClick $$HEX2$$e0002000$$ENDHEX$$1 QUE si RowCount()>0 ; Or lors d'une 2$$HEX1$$e800$$ENDHEX$$me 
//               recherche infructueuse faisant suite $$HEX2$$e0002000$$ENDHEX$$une 1$$HEX1$$e800$$ENDHEX$$re recherche ayant abouti 
//               avec succ$$HEX1$$e800$$ENDHEX$$s, ilLigneClick restait $$HEX2$$e0002000$$ENDHEX$$la pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente valeur positionn$$HEX1$$e900$$ENDHEX$$e
//               par le RowFocusChanged ou le RetrieveEnd. Ce n'est d$$HEX1$$e900$$ENDHEX$$sormais plus le cas,
//               en cas de seconde recherche infructueuse ilLigneClick est positionn$$HEX4$$e9002000e0002000$$ENDHEX$$0.
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************


This.IlLigneClick = 0

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_modifiermenu;call super::ue_modifiermenu;//*****************************************************************************
//
// Objet 		: U_DataWindow_detail
// Evenement 	: ue_ModifierMenu
//	Auteur		: La Recrue
//	Date			: 12/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Menu contextuel par d$$HEX1$$e900$$ENDHEX$$faut des d$$HEX1$$e900$$ENDHEX$$tails
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

String 		sBand
w_Ancetre	wParent

// click pour changer de ligne si besoin est

wParent = Parent

//Migration PB8-WYNIWYG-03/2006 FM
//Send( Handle( This ) , 513, Message.WordParm, Message.LongParm ) 
This.TriggerEvent (Clicked!)
//Fin Migration PB8-WYNIWYG-03/2006 FM

uf_Mnu_InterdirItem ( 2 )
uf_Mnu_InterdirItem ( 3 )

sBand	= Left ( This.GetBandAtPointer (), 4 )

If	sBand = "deta" Then
	uf_Mnu_AutoriserItem ( 2 )
	If ( wParent.istPass.bSupprime ) Then
		uf_Mnu_AutoriserItem ( 3 )
	End If
End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event rowfocuschanged;call super::rowfocuschanged;//*****************************************************************************
//
// Objet 		: U_DataWindow_Detail
// Evenement 	: Erick John Stark
//	Auteur		: D.Bizien	
//	Date			: 11/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: S$$HEX1$$e900$$ENDHEX$$lection de ligne
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
// PAR			05/12/1996	Ajout du boolean qui autorise la selection d'une 
//									ligne ou pas sur le row focus change
//*****************************************************************************
//* N$$HEX2$$b0002000$$ENDHEX$$Modif          Re$$HEX1$$e700$$ENDHEX$$ue Le          Effectu$$HEX1$$e900$$ENDHEX$$e Le          PAR
//*
//* MOD-0001          18/03/97            18/03/97				La Recrue
//* #2					 18/03/08				18/03/08				JFF
//*-----------------------------------------------------------------


Long lLigne
String sClassName

sClassName = ClassName()

//Migration PB8-WYNIWYG-03/2006 FM
//lLigne	=	This.GetRow ( )
lLigne	=	CurrentRow

//Fin Migration PB8-WYNIWYG-03/2006 FM

If	lLigne > 0 Then
	
		// On deselectionne tout
	If ( ibSelectionActive ) Then
		This.SelectRow ( ilLigneClick, False )
	End If

// #2, je commente cette ligne qui fait planter l'appli dans certain cas (?)
//	This.ScrollToRow ( lLigne )	
	This.SetRow ( lLigne )

	If ( ibSelectionActive ) Then
		This.SelectRow ( lLigne, True )
		
	End If

	ilLigneClick = lLigne
	

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event doubleclicked;call super::doubleclicked;//*****************************************************************************
//
// Objet 		: U_DataWindow_Detail
// Evenement 	: DoubleClicked
//	Auteur		: D.Bizien	
//	Date			: 08/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Modification d'un enregistrement
// Commentaires: D$$HEX1$$e900$$ENDHEX$$clenchement de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement ue_Modifier de la fen$$HEX1$$ea00$$ENDHEX$$tre parente
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	EJS			08/04/1996	Il faut tester que l'on clicke bien sur une ligne, colonne de la DW
// EJS			12/08/1996	En suppression, le n$$HEX2$$b0002000$$ENDHEX$$de ligne courante est $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro. 
//									Il faut donc tester ce cas
// PAR			05/12/1996	Cr$$HEX1$$e900$$ENDHEX$$ation de l'anc$$HEX1$$e800$$ENDHEX$$tre u_DataWindow_Detail
//
//*****************************************************************************

String sText, sBand

SetPointer( HourGlass! )

//Migration PB8-WYNIWYG-03/2006 FM
ilLigneClick = row
//Fin Migration PB8-WYNIWYG-03/2006 FM

If	This.ilLigneClick = 0 Then						// .... Cas ou l'on vient de supprimer l'enregistrement
	This.TriggerEvent ( "RowFocusChanged" )
End If

sText = This.GetObjectAtPointer ()
sBand	= Left ( This.GetBandAtPointer (), 4 )

If	sText <> "" And sBand = "deta" Then
	Parent.TriggerEvent ( "ue_Modifier" )
End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event losefocus;call super::losefocus;//*****************************************************************************
//
// Objet 		: U_DataWindow_Detail
// Evenement 	: LoseFocus
//	Auteur		: La Recrue
//	Date			: 05/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$clange l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement ue_chager d$$HEX1$$e900$$ENDHEX$$tail de la fen$$HEX1$$ea00$$ENDHEX$$tre parent.
// Commentaires: Plus acun d$$HEX1$$e900$$ENDHEX$$tail n'est actif
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Parent.TriggerEvent( "ue_ChangerDetail", 0, 1 )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event getfocus;call super::getfocus;//*****************************************************************************
//
// Objet 		: U_DataWindow_Detail
// Evenement 	: GetFocus
//	Auteur		: La Recrue
//	Date			: 05/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$clange l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement ue_chager d$$HEX1$$e900$$ENDHEX$$tail de la fen$$HEX1$$ea00$$ENDHEX$$tre parent.
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

Parent.TriggerEvent( "ue_ChangerDetail", 0, 0 )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event retrieveend;call super::retrieveend;//*****************************************************************************
//
// Objet 		: U_DataWindow_detail
// Evenement 	: RetrieveEnd
//	Auteur		: La Recrue
//	Date			: 12/12/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Selection de la premi$$HEX1$$e800$$ENDHEX$$re ligne de la datawindow $$HEX2$$e0002000$$ENDHEX$$la fin du 
//					  retieve si la selection est active
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************


If ( This.Rowcount() > 0 ) Then

	This.IlLigneClick = 1
	

	If ( This.ibSelectionActive ) Then

		This.SelectRow( 0, False )
		This.SelectRow( This.ilLigneClick, True )

	End If

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on u_datawindow_detail.create
call super::create
end on

on u_datawindow_detail.destroy
call super::destroy
end on

