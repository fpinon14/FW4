HA$PBExportHeader$u_consultation_euro.sru
$PBExportComments$----} UserObjet Euro pour la consultation.
forward
global type u_consultation_euro from userobject
end type
type pb_monnaie from picturebutton within u_consultation_euro
end type
type dw_consult_euro from datawindow within u_consultation_euro
end type
end forward

global type u_consultation_euro from userobject
boolean visible = false
integer width = 233
integer height = 136
boolean enabled = false
long backcolor = 12632256
event ue_changer_monnaie pbm_custom01
pb_monnaie pb_monnaie
dw_consult_euro dw_consult_euro
end type
global u_consultation_euro u_consultation_euro

type variables
Private :
	DataWindow	idwNorm[]
	String		isMonnaieCourante
	String		isNomBitMap
	String		isFormatDesire
end variables

forward prototypes
public subroutine uf_initialiser (ref datawindow adwnorm[])
private subroutine uf_charger_colonne ()
public subroutine uf_changer_monnaie (string asmonnaie)
public function string uf_recuperer_monnaie_courante ()
end prototypes

event ue_changer_monnaie;//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

public subroutine uf_initialiser (ref datawindow adwnorm[]);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Consultation_Euro::Uf_Initialiser (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/1999 10:25:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisatoion des DW
//*
//* Arguments		: DataWindow	adwNorm[]			(R$$HEX1$$e900$$ENDHEX$$f)	Tableau de DW
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sBitMap

/*------------------------------------------------------------------*/
/* On va initialiser toutes les DW que l'on utilise pour la         */
/* fen$$HEX1$$ea00$$ENDHEX$$tre. On se sert d'un tableau de DW m$$HEX1$$ea00$$ENDHEX$$me pour les             */
/* U_DataWindow ou les U_DataWindow_Detail. Ce la ne pose aucun     */
/* probl$$HEX1$$e800$$ENDHEX$$me si on ne se sert pas des valeurs d'instances des        */
/* UserObjects.                                                     */
/*------------------------------------------------------------------*/
idwNorm = adwNorm

/*------------------------------------------------------------------*/
/* On recherche maintenant les colonnes de type decimal(2) des DW   */
/* que l'on vient d'instancier.                                     */
/*------------------------------------------------------------------*/
Uf_Charger_Colonne ()

/*------------------------------------------------------------------*/
/* On initialise le nom du fichier + r$$HEX1$$e900$$ENDHEX$$pertoire pour le bitmap.     */
/*------------------------------------------------------------------*/
isNomBitMap = "K:\PB4OBJ\BMP\MT_"

/*------------------------------------------------------------------*/
/* On initialise la monnaie courante par la valeur contenu dans le  */
/* fichier INI.                                                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* !! ATTENTION !!. L'initialisation de cette valeur est tr$$HEX1$$e900$$ENDHEX$$s       */
/* importante. Surtout pour le Nvuo N_Cst_Passage_Euro qui          */
/* correspond $$HEX2$$e0002000$$ENDHEX$$la p$$HEX1$$e900$$ENDHEX$$riode transitoire.                             */
/*------------------------------------------------------------------*/
isFormatDesire		= stGLB.sMonnaieFormatDesire
isMonnaieCourante = isFormatDesire

/*------------------------------------------------------------------*/
/* On initialise le bitmap pour le bouton.                          */
/*------------------------------------------------------------------*/
sBitMap = isNomBitMap + isMonnaieCourante + ".BMP"
Pb_Monnaie.PictureName = sBitMap



end subroutine

private subroutine uf_charger_colonne ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Consultation_Euro::U_Charger_Colonne (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 24/03/1999 10:34:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Recherche des colonnes dans les DW
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lTotDw, lCpt, lTotCol, lCptCol, lLig

String sVal, sNomCol, sColType, sNomDw, sVisible, sFont

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nombre total de DW en instance.                   */
/*------------------------------------------------------------------*/
lTotDw	= UpperBound ( idwNorm )

For	lCpt = 1 To lTotDw
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nombre total de colonne dans la DW.               */
/*------------------------------------------------------------------*/
		lTotCol	= Long ( idwNorm [ lCpt ].Describe ( "DataWindow.Column.Count" ) )
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nom de la DW.                                     */
/*------------------------------------------------------------------*/
		sNomDw	= idwNorm [ lCpt ].DataObject

		For	lCptCol = 1 To lTotCol
				sVal = "#" + String ( lCptCol ) + ".Name"
				sNomCol 	= idwNorm [ lCpt ].Describe ( sVal )
				sVal		= sNomCol + ".ColType"
				sColType	= idwNorm [ lCpt ].Describe ( sVal )

/*------------------------------------------------------------------*/
/* Si la colonne est de type DECIMAL(2), on ins$$HEX1$$e900$$ENDHEX$$re une ligne dans   */
/* la DW pr$$HEX1$$e900$$ENDHEX$$vue $$HEX2$$e0002000$$ENDHEX$$cet effet.                                        */
/*------------------------------------------------------------------*/
				If	sColType = "decimal(2)"	Then

					sVal		= sNomCol + ".Visible"
					sVisible	= idwNorm [ lCpt ].Describe ( sVal )
					sVal		= sNomCol + ".Font.Face"
					sFont		= idwNorm [ lCpt ].Describe ( sVal )

					lLig		= dw_Consult_Euro.InsertRow ( 0 )
					dw_Consult_Euro.SetItem ( lLig, "NUM_DW", lCpt )
					dw_Consult_Euro.SetItem ( lLig, "NOM_DW", sNomDw )
					dw_Consult_Euro.SetItem ( lLig, "COLONNE", sNomCol )
					dw_Consult_Euro.SetItem ( lLig, "VISIBLE", sVisible )
					dw_Consult_Euro.SetItem ( lLig, "FONT", sFont )
				End If
		Next
Next



end subroutine

public subroutine uf_changer_monnaie (string asmonnaie);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Consultation_Euro::U_Changer_Monnaie (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/1999 10:50:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va changer le type de la monnaie
//*
//* Arguments		: String			asMonnaie				(Val)	Type de monnaie
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------
//* #1   PLJ 02/04/1999 Prise en compte d'un attribut conditionnel sur la
//*                     propri$$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$visible d'une colonne 
//* #2	PLJ 14/05/2001 Changement des lignes se trouvant dans le buffer Filter!
//* #3	PHG 15/02/2008 [SUISSE].LOT3 : Gestion Dynamique de la monnaie
//*-----------------------------------------------------------------

Long 			lTotCol, lCptCol, lNumDw, lTotLig, lCptLig
String 		sFormat1, sFormat2, sFont, sVisible, sNomCol, sVal, sBitMap, sFiltreI
Decimal {2} dcMtFrancs, dcMtEuros
boolean		bEuroConvert // #1 [SUISSE].LOT3 : Gestion d'une Bi-monnaie Francs/euro

/*------------------------------------------------------------------*/
/* Si la monnaie est diff$$HEX1$$e900$$ENDHEX$$rente de (E)uros ou (F)rancs, on ne fait  */
/* rien.                                                            */
/*------------------------------------------------------------------*/
// #1 [SUISSE].LOT3 : Le test ci-dessous n'a plus lieu d'etre en internationnal
// etant donn$$HEX2$$e9002000$$ENDHEX$$que cette fonction g$$HEX1$$e800$$ENDHEX$$re AUSSI l'affichage du symbole mon$$HEX1$$e900$$ENDHEX$$taire pour
// les fenetre de consultation
// Par contre, la variable bEuroConvert determine si on est dans un cadre
// pertinent de Conversion Euro/francs
//If	asMonnaie <> "F" And asMonnaie <> "E"	Then
//	Return
//End If

bEuroConvert = ( stGlb.sMonnaieFormatActuel = "F") and ( stGlb.sMonnaieFormatDesire = "EURO")

if bEuroconvert then // #1 [SUISSE].LOT3 : Si contexte pertinent, on g$$HEX1$$e800$$ENDHEX$$re le bonton de conversion Euro/francs
	
	Pb_Monnaie.Visible = False
	/*------------------------------------------------------------------*/
	/* On modifie le bitmap du bouton.                                  */
	/*------------------------------------------------------------------*/
	If	asMonnaie = "F"	Then
		sBitMap = isNomBitMap + "F" + ".BMP"
	Else
		sBitMap = isNomBitMap + "E" + ".BMP"
	End If
	pb_Monnaie.PictureName = sBitMap
	
End If

/*------------------------------------------------------------------*/
/* On modifie le format des colonnes.                               */
/*------------------------------------------------------------------*/
lTotCol = dw_Consult_Euro.RowCount ()

// #1 [SUISSE].LOT3 : On Gere les symbole mon$$HEX1$$e900$$ENDHEX$$taire grace au point Ini
// Si pas de Symoble defini, Euro par Defaut
Choose Case asMonnaie
	Case stGlb.sMonnaieFormatActuel
		sFormat1 = ".Format='#,##0.00 \"+stGlb.sMonnaieSymboleActuel+"'"
		sFormat2 = ".Format='#,##0.00 \"+stGlb.sMonnaieSymboleActuel+"'"
	Case stGlb.sMonnaieFormatDesire
		sFormat1 = ".Format='#,##0.00 \"+stGlb.sMonnaieSymboleDesire+"'"
		sFormat2 = ".Format='#,##0.00 \"+stGlb.sMonnaieSymboleDesire+"'"
	Case Else
		sFormat1 = ".Format='#,##0.00 \$$HEX1$$ac20$$ENDHEX$$'"
		sFormat2 = ".Format='#,##0.00 \$$HEX1$$ac20$$ENDHEX$$'"//[SUISSE].LOT3 Chgment de /E vers /<euro>
End Choose


For	lCptCol = 1 To lTotCol
		lNumDw		= dw_Consult_Euro.GetItemNumber ( lCptCol, "NUM_DW" )
		sVisible		= dw_Consult_Euro.GetItemString ( lCptCol, "VISIBLE" )
		sNomCol		= dw_Consult_Euro.GetItemString ( lCptCol, "COLONNE" )
		sFont			= dw_Consult_Euro.GetItemString ( lCptCol, "FONT" )
/*------------------------------------------------------------------*/
/* Si la colonne n'est pas visible, on ne s'occupe pas du           */
/* changement de format.                                            */
/*------------------------------------------------------------------*/
/* #1 Plus exactement si elle n'est pas invisible on  s'occupe  du  */
/* changement de format.                                            */
/* En effet car lorsque que l'on pose un attribut sur la propri$$HEX1$$e900$$ENDHEX$$t$$HEX3$$e90020002000$$ENDHEX$$*/
/* visible, on n'a ni 1 ni 0. N$$HEX1$$e900$$ENDHEX$$anmoins on peut  consid$$HEX1$$e900$$ENDHEX$$rer  comme  */
/* visible, une colonne sur laquelle on aurait  pos$$HEX3$$e90020002000$$ENDHEX$$un  attribut  */
/* conditionnel.																	  */
/*------------------------------------------------------------------*/	  
		If	sVisible <> "0"	Then
			If	sFont = "Arial"	Then
				sVal = sNomCol + sFormat1
			Else
				sVal = sNomCol + sFormat2
			End If
			idwNorm [ lNumDw ].Modify ( sVal )
		End If
Next

/*------------------------------------------------------------------*/
/* On modifie ensuite le contenu des colonnes.                      */
/*------------------------------------------------------------------*/
For	lCptCol = 1 To lTotCol
		lNumDw		= dw_Consult_Euro.GetItemNumber ( lCptCol, "NUM_DW" )
		sVisible		= dw_Consult_Euro.GetItemString ( lCptCol, "VISIBLE" )
		sNomCol		= dw_Consult_Euro.GetItemString ( lCptCol, "COLONNE" )

/*------------------------------------------------------------------*/
/* Si la colonne n'est pas visible, on ne s'occupe pas du           */
/* changement de monnaie.                                           */
/*------------------------------------------------------------------*/
		If	sVisible = "0"	Then
			Continue
		End If

		/*----------------------------------------------------------------*/
		/* #2   Si la datawindow poss$$HEX1$$e800$$ENDHEX$$de un filtre on Suprime le filtre   */
		/*      pour pouvoir affecter toutes les lignes                   */
		/*----------------------------------------------------------------*/
		sFiltreI	=	idwNorm [ lNumDw ].Describe ( "datawindow.table.filter" )
		If sFiltreI <> "?" Then 
			idwNorm [ lNumDw ].SetRedraw ( False )
			idwNorm [ lNumDw ].SetFilter ( "" )
			idwNorm [ lNumDw ].Filter    ()
		End If	

		lTotLig = idwNorm [ lNumDw ].RowCount ()
		For	lCptLig	= 1 To lTotLig

//				If	asMonnaie = "F"	Then
//					dcMtFrancs = idwNorm [ lNumDw ].GetItemNumber ( lCptLig, sNomCol, Primary!, TRUE )
//					idwNorm [ lNumDw ].SetItem ( lCptLig, sNomCol, dcMtFrancs )
//				Else
//					dcMtEuros = idwNorm [ lNumDw ].GetItemNumber ( lCptLig, sNomCol ) / stGLB.Tx_Euro
//					idwNorm [ lNumDw ].SetItem ( lCptLig, sNomCol, dcMtEuros )
//				End If

/*------------------------------------------------------------------*/
/* Le format que l'on d$$HEX1$$e900$$ENDHEX$$sire afficher correspond au format d$$HEX1$$e900$$ENDHEX$$sir$$HEX4$$e900200020002000$$ENDHEX$$*/
/* (cad celui qui est stock$$HEX2$$e9002000$$ENDHEX$$dans la base). On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la valeur   */
/* initiale.                                                        */
/*------------------------------------------------------------------*/
				If	asMonnaie = isFormatDesire	Then
					dcMtFrancs = idwNorm [ lNumDw ].GetItemNumber ( lCptLig, sNomCol, Primary!, TRUE )
					idwNorm [ lNumDw ].SetItem ( lCptLig, sNomCol, dcMtFrancs )
				ElseIf bEuroConvert Then // #1 [SUISSE].LOT3 On ne fait de conversion 
												 // que dans le cadre Euro/Francs
/*------------------------------------------------------------------*/
/* Le format que l'on d$$HEX1$$e900$$ENDHEX$$sir$$HEX2$$e9002000$$ENDHEX$$afficher est diff$$HEX1$$e900$$ENDHEX$$rent de la valeur    */
/* courante de la base. On effectue un test pour trouver la valeur  */
/* de l'op$$HEX1$$e900$$ENDHEX$$rande. (Multiplication ou Soustraction)                  */
/*------------------------------------------------------------------*/
					If	isFormatDesire = "F"	Then
						dcMtEuros = idwNorm [ lNumDw ].GetItemNumber ( lCptLig, sNomCol ) / stGLB.Tx_Euro
						idwNorm [ lNumDw ].SetItem ( lCptLig, sNomCol, dcMtEuros )
					Else
						dcMtEuros = idwNorm [ lNumDw ].GetItemNumber ( lCptLig, sNomCol ) * stGLB.Tx_Euro
						idwNorm [ lNumDw ].SetItem ( lCptLig, sNomCol, dcMtEuros )
					End If
				End If

		Next
		/*-------------------------------------------------------------*/
		/* #2   Repositionnement si besoin du filtre Initial           */
		/*-------------------------------------------------------------*/
		If sFiltreI <> "?" Then 
			idwNorm [ lNumDw ].SetFilter ( sFiltreI )
			idwNorm [ lNumDw ].Filter    ()
			idwNorm [ lNumDw ].SetRedraw ( True )
		End If		

Next

/*------------------------------------------------------------------*/
/* On n'oublie pas de modifier la valeur d'instance pour la         */
/* monnaie courante.                                                */
/*------------------------------------------------------------------*/
isMonnaieCourante = asMonnaie

pb_Monnaie.Visible = True
end subroutine

public function string uf_recuperer_monnaie_courante ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Consultation_Euro::Uf_Recuperer_Monnaie_Courante (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 24/03/1999 10:47:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le type de la monnaire courane
//*
//* Arguments		: Rien
//*
//* Retourne		: String			E/F	= Type de la monnaie courante (E=Euro/F=Franc)
//*
//*-----------------------------------------------------------------

Return ( isMonnaieCourante )


end function

on u_consultation_euro.create
this.pb_monnaie=create pb_monnaie
this.dw_consult_euro=create dw_consult_euro
this.Control[]={this.pb_monnaie,&
this.dw_consult_euro}
end on

on u_consultation_euro.destroy
destroy(this.pb_monnaie)
destroy(this.dw_consult_euro)
end on

type pb_monnaie from picturebutton within u_consultation_euro
integer width = 233
integer height = 136
integer taborder = 10
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\mt_f.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: Pb_monnaie::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 24/03/1999 10:58:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On change le type de la monnaie courante.                        */
/*------------------------------------------------------------------*/
If	isMonnaieCourante = "F"	Then
	Uf_Changer_Monnaie ( "E" )
Else
	Uf_Changer_Monnaie ( "F" )
End If

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$clenche un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement sur le parent pour pouvoir coder du    */
/* script sp$$HEX1$$e900$$ENDHEX$$cifique.                                               */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Parent.TriggerEvent ( "Ue_Changer_Monnaie" )
long	ll_ret = 0

ll_ret = Parent.Event Ue_Changer_Monnaie(0,  0)
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_consult_euro from datawindow within u_consultation_euro
boolean visible = false
integer x = 448
integer y = 4
integer width = 242
integer height = 100
boolean enabled = false
string dataobject = "d_consultation_euro"
boolean livescroll = true
end type

