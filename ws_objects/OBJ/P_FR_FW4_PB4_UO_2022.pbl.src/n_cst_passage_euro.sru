HA$PBExportHeader$n_cst_passage_euro.sru
forward
global type n_cst_passage_euro from nonvisualobject
end type
end forward

global type n_cst_passage_euro from nonvisualobject
end type
global n_cst_passage_euro n_cst_passage_euro

type variables
Private :
	DataWindow	idwNorm[]

	String		isFormatActuel
	String		isFormatDesire
	String		isSymboleActuel // [SUISSE].LOT3 Gestion Avanc$$HEX1$$e900$$ENDHEX$$e des Symboles Monetaires
	String		isSymboleDesire // [SUISSE].LOT3 Gestion Avanc$$HEX1$$e900$$ENDHEX$$e des Symboles Monetaires
	String		isLitteralDesire // [SUISSE].LOT3 Gestion Avanc$$HEX1$$e900$$ENDHEX$$e des Symboles Monetaires
	String		isLitteralActuel // [SUISSE].LOT3 Gestion Avanc$$HEX1$$e900$$ENDHEX$$e des Symboles Monetaires

end variables

forward prototypes
public subroutine uf_initialiser (ref datawindow adwnorm[])
private subroutine uf_changer_cosmetique_colonne ()
end prototypes

public subroutine uf_initialiser (ref datawindow adwnorm[]);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Passage_Euro::Uf_Initialiser (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/1999 10:25:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisatoion des DW
//*
//* Arguments		: DataWindow	adwNorm[]			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau de DW
//*
//* Retourne		: Rien
//*
//* Historique		:
//* Ref			Par		Date
//* [MIGPB8COR] JFF&PHG	20/04/2006 : 
//*					  Contournement de Bug Runtime de PB 8.0.3 Build 9838 :
//*					  La passage par reference de pointeur de tableau
//*					  provoque une faute de protection generale
//*					  Le contournement est de parser le tableau et de faire
//*					  l'affectation element par element.
//* #1	PHG		  [SUISSE].LOT3 : Harmonisation lecture .INI pour la monnaie
//*-----------------------------------------------------------------

//String sFicIniApp //#1 [SUISSE].LOT3 Le fichier INI est lu dans u_sesame.
Long lTot, lCpt // [MIGPB8COR]-JFF&PHG

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re dans le fichier INI de l'application la valeur       */
/* actuelle du format des DW pour les colonnes de type D$$HEX1$$e900$$ENDHEX$$cimal.     */
/*------------------------------------------------------------------*/
// #1 [SUISSE].LOT3 Le fichier INI est lu dans u_sesame
//sFicIniApp = stGLB.sFichierIni
//
//isFormatActuel = ProfileString ( sFicIniApp, "EURO", "Format_Actuel", "" )
//isFormatDesire	= ProfileString ( sFicIniApp, "EURO", "Format_Desire", "" )

isFormatActuel		= stGlb.sMonnaieFormatActuel
isSymboleActuel	= stGlb.sMonnaieSymboleActuel
isLitteralActuel	= stGlb.sMonnaieLitteralActuel
isFormatDesire		= stGlb.sMonnaieFormatDesire
isSymboleDesire	= stGlb.sMonnaieSymboleDesire
isLitteralDesire	= stGlb.sMonnaieLitteralDesire
//

If	isFormatActuel <> isFormatDesire	Then
/*------------------------------------------------------------------*/
/* On va initialiser toutes les DW que l'on utilise pour la         */
/* fen$$HEX1$$ea00$$ENDHEX$$tre. On se sert d'un tableau de DW m$$HEX1$$ea00$$ENDHEX$$me pour les             */
/* U_DataWindow ou les U_DataWindow_Detail. Cela ne pose aucun      */
/* probl$$HEX1$$e800$$ENDHEX$$me si on ne se sert pas des valeurs d'instances des        */
/* UserObjects.                                                     */
/*------------------------------------------------------------------*/


// [MIGPB8COR]-JFF&PHG
//	idwNorm = adwNorm
// remplace par
lTot = UpperBound ( adwNorm )
For lCpt = 1 To lTot
	idwNorm [ lCpt ] = adwNorm [ lCpt ]
Next
	
/*------------------------------------------------------------------*/
/* On recherche maintenant les colonnes de type decimal(2) des DW   */
/* que l'on vient d'instancier.                                     */
/*------------------------------------------------------------------*/
	Uf_Changer_Cosmetique_Colonne ()
End If




end subroutine

private subroutine uf_changer_cosmetique_colonne ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Passage_Euro::U_Changer_Cosmetique_Colonne (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 24/03/1999 10:34:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Recherche des colonnes dans les DW et modification de la
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ	PAR		Le			Description
//* #1	PHG	15/02/2008	[SUISSE].LOT3 : Gestion Dynamique du symbole mon$$HEX1$$e900$$ENDHEX$$taire.
Long lTotDw, lCpt, lTotCol, lCptCol

String	sVal, sNomCol, sColType, sVisible, sFont, sFormat
String	sModif, sFormat1, sFormat2

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nombre total de DW en instance.                   */
/*------------------------------------------------------------------*/
lTotDw	= UpperBound ( idwNorm )

If	isFormatDesire = "F"	Then // [SUISSE].LOT3 : Changement syntaxe chaine en (') pour
									  // encapsuler les (")
	sFormat1 = '.Format="#,##0.00 \F"'
	sFormat2 = '.Format="#,##0.00 \F"'
Else
	//[SUISSE].LOT3 Gestion dynamique Symbole Mon$$HEX1$$e900$$ENDHEX$$taire 
	//sFormat1 = ".Format='#,##0.00 \$$HEX1$$ac20$$ENDHEX$$"
	//sFormat2 = ".Format='#,##0.00 \$$HEX1$$ac20$$ENDHEX$$"
	sFormat1 = '.Format="#,##0.00 \'+isSymboleDesire+'"'
	sFormat2 = '.Format="#,##0.00 \'+isSymboleDesire+'"'
End If

For	lCpt = 1 To lTotDw
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nombre total de colonne dans la DW.               */
/*------------------------------------------------------------------*/
		lTotCol	= Long ( idwNorm [ lCpt ].Describe ( "DataWindow.Column.Count" ) )
/*------------------------------------------------------------------*/
/* On initialise la chaine pour le modify.                          */
/*------------------------------------------------------------------*/
		sModif = ""

		For	lCptCol = 1 To lTotCol
				sVal = "#" + String ( lCptCol ) + ".Name"
				sNomCol 	= idwNorm [ lCpt ].Describe ( sVal )

				sVal		= sNomCol + ".ColType"
				sColType	= idwNorm [ lCpt ].Describe ( sVal )
/*------------------------------------------------------------------*/
/* Si la colonne est de type DECIMAL(2), on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le format      */
/* actuel de la colonne, ainsi que la FONT utilis$$HEX1$$e900$$ENDHEX$$e.                */
/*------------------------------------------------------------------*/
				If	sColType = "decimal(2)"	Then
					sVal		= sNomCol + ".Visible"
					sVisible	= idwNorm [ lCpt ].Describe ( sVal )

					sVal		= sNomCol + ".Font.Face"
					sFont		= idwNorm [ lCpt ].Describe ( sVal )

					sVal		= sNomCol + ".Format"
					sFormat	= idwNorm [ lCpt ].Describe ( sVal )
					// [SUISSE].LOT3 Gestion des champs decimal(2) destin$$HEX4$$e9002000e0002000$$ENDHEX$$etre des pourcentage
					If	sVisible <> "0" and Pos (sFormat, "%") = 0 Then
						If	sFont = "Arial"	Then
							sModif = sModif + sNomCol + sFormat1 + " "
						Else
							sModif = sModif + sNomCol + sFormat2 + " "
						End If
					End If
				End If
		Next
		idwNorm [ lCpt ].Modify ( sModif )
Next


end subroutine

on n_cst_passage_euro.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_passage_euro.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

