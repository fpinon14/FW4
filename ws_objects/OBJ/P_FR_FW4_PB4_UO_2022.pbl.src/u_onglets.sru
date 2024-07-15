HA$PBExportHeader$u_onglets.sru
$PBExportComments$------} UserObjet Onglets
forward
global type u_onglets from datawindow
end type
end forward

global type u_onglets from datawindow
int Width=2922
int Height=117
int TabOrder=1
string DataObject="d_onglets"
boolean LiveScroll=true
end type
global u_onglets u_onglets

type variables
Private :
    Integer              iiNbrOnglet = 6
 
    String                isOngletCourant = "01"
    String                isNomObjet
    String                isCouleurDesactive

    DragObject        idoOnglet[ 1 to 6 ]

Public : 
   Boolean             ibStop = False
end variables

forward prototypes
public subroutine uf_initialiser (integer ainbronglet, integer aiobjet)
public subroutine uf_changertitre (string asnumonglet, string astitre)
public subroutine uf_changeronglet (string asonglet)
public subroutine uf_activeronglet (string asonglet, boolean abactivation)
public subroutine uf_changerbitmap (string asnumonglet, string asBitMap)
public subroutine uf_enregistreronglet (string asnumonglet, string astitre, string asbitmap, dragobject adoonglet, boolean abdefaut)
public function string uf_recupererongletcourant ()
end prototypes

public subroutine uf_initialiser (integer ainbronglet, integer aiobjet);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser ( Public )
//* Auteur			: Erick John Stark 
//* Date				: 20/12/1996 15:04:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des Onglets
//*
//* Arguments		: Integer		aiNbrOnglet			(Val)	Nombre d'onglet $$HEX2$$e0002000$$ENDHEX$$Initialiser
//						  Integer      aiObjet				(Val) N$$HEX2$$b0002000$$ENDHEX$$du User objet Onglet
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer iCpt
String sText = ""
Long lLong

/*------------------------------------------------------------------*/
/* On rend les onglets invisibles, s'ils ne sont pas utilis$$HEX1$$e900$$ENDHEX$$s       */
/*------------------------------------------------------------------*/

For	iCpt	= aiNbrOnglet + 1 To This.iiNbrOnglet
		sText = sText + "ong" + String ( iCpt, "00" ) + "_p.Visible = 0" + &
				  			" ong" + String ( iCpt, "00" ) + "_st.Visible = 0" + &
				  			" ong" + String ( iCpt, "00" ) + "_bmp.Visible = 0 "

Next

This.Modify ( sText )

/*------------------------------------------------------------------*/
/* Le nombre d'onglet pr$$HEX1$$e900$$ENDHEX$$sents est initialis$$HEX4$$e9002000e0002000$$ENDHEX$$la fin              */
/*------------------------------------------------------------------*/

This.iiNbrOnglet = aiNbrOnglet

/*------------------------------------------------------------------*/
/* On positionne le user objet $$HEX2$$e0002000$$ENDHEX$$la bonne taille                    */
/*------------------------------------------------------------------*/

lLong = Long ( Describe ( "ong" + String ( aiNbrOnglet, "00" ) + "_p.X" ) ) + &
		  Long ( Describe ( "ong" + String ( aiNbrOnglet, "00" ) + "_p.Width" ) ) 

This.width = lLong //+ 4

/*------------------------------------------------------------------*/
/* On initialise le N$$HEX2$$b0002000$$ENDHEX$$du User Objet, au cas ou il y en ait deux    */
/* sur une fen$$HEX1$$ea00$$ENDHEX$$tre, et cela afin de d$$HEX1$$e900$$ENDHEX$$clencher les $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nements.      */
/*------------------------------------------------------------------*/

This.isNomObjet = String ( aiObjet, "0" )


end subroutine

public subroutine uf_changertitre (string asnumonglet, string astitre);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ChangerTitre ( Public )
//* Auteur			: Erick John Stark
//* Date				: 16/01/1997 09:24:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String			asNumOnglet			(Val)	Num$$HEX1$$e900$$ENDHEX$$ro de l'onglet
//*					  String			asTitre				(Val) Titre de l'onglet
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Changement du titre de l'onglet                                  */
/*------------------------------------------------------------------*/

This.Modify ( "ong" + asNumOnglet + "_st.Text='" + asTitre + "'" )

end subroutine

public subroutine uf_changeronglet (string asonglet);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ChangerOnglet ( Public )
//* Auteur			: Erick John Stark 
//* Date				: 20/12/1996 14:21:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String			asOnglet			(Val)	N$$HEX2$$b0002000$$ENDHEX$$de l'onglet 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Window wParent
String sText

wParent = Parent

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$clenche un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement sur la fen$$HEX1$$ea00$$ENDHEX$$tre qui contient le user    */
/* objet                                                            */
/* Cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement peut ne pas exister.                               */
/* Il s'appelle "Ue_QuitterOnglet" + N$$HEX2$$b0002000$$ENDHEX$$Onglet + Nom Objet          */
/* Ex ( "Ue_QuitterOnglet06" )                                      */
/*------------------------------------------------------------------*/


wParent.TriggerEvent ( "Ue_QuitterOnglet" + isOngletCourant + isNomObjet )

If	This.ibStop = False Then
	wParent.SetRedraw ( False )

/*------------------------------------------------------------------*/
/* On modifie la cosm$$HEX1$$e900$$ENDHEX$$tique des onglets. On modifie l'aspect        */
/* visible des dw, ainsi que les TabOrder                           */
/*------------------------------------------------------------------*/

	sText = "ong" + isOngletCourant + "_p.FileName = 'K:\PB4OBJ\BMP\ONG_FER.BMP'" + &
			  " ong" + isOngletCourant + "_st.Font.Weight = '400'" + &
			  " ong" + asOnglet + "_p.FileName = 'K:\PB4OBJ\BMP\ONG_OUV.BMP'" + &
			  " ong" + asOnglet + "_st.Font.Weight = '700'"

	This.Modify ( sText )

	This.idoOnglet[ Integer ( isOngletCourant ) ].Visible = False
	This.idoOnglet[ Integer ( isOngletCourant ) ].TabOrder = 0

	This.idoOnglet[ Integer ( asOnglet ) ].Visible = True
	This.idoOnglet[ Integer ( asOnglet ) ].BringToTop = True
	This.idoOnglet[ Integer ( asOnglet ) ].TabOrder = 1
	This.idoOnglet[ Integer ( asOnglet ) ].SetFocus ()

/*------------------------------------------------------------------*/
/* Permet de masquer la ligne de la DW en dessous                   */
/*------------------------------------------------------------------*/

	This.BringToTop = True

	wParent.SetRedraw ( True )
	isOngletCourant = asOnglet

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$clenche un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement sur la fen$$HEX1$$ea00$$ENDHEX$$tre qui contient le user    */
/* objet                                                            */
/* Cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement peut ne pas exister.                               */
/* Il s'appelle "Ue_EntrerOnglet" + N$$HEX2$$b0002000$$ENDHEX$$Onglet + Nom Objet           */
/* Ex ( "Ue_EntrerOnglet06" )                                       */
/*------------------------------------------------------------------*/

	wParent.TriggerEvent ( "Ue_EntrerOnglet" + isOngletCourant + isNomObjet )
End If

This.ibStop = False

end subroutine

public subroutine uf_activeronglet (string asonglet, boolean abactivation);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ActiverOnglet
//* Auteur			: Erick John Stark
//* Date				: 21/01/1997 09:28:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String			asOnglet			(Val)	N$$HEX2$$b0002000$$ENDHEX$$de l'onglet
//*					  Boolean		abActivation	(Val) Activation/d$$HEX1$$e900$$ENDHEX$$sactivation de l'onglet
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sText

/*------------------------------------------------------------------*/
/* Si on active un onglet, on passe le static text en Noir.         */
/* Si on le d$$HEX1$$e900$$ENDHEX$$asctive, on le passe en GRIS CLAIR                    */
/* Il est impossible de d$$HEX1$$e900$$ENDHEX$$sactiver l'onglet courant                 */
/*------------------------------------------------------------------*/

If			abActivation Then
			sText = "ong" + asOnglet + "_st.Color = '0'"
ElseIf	isOngletCourant <> asOnglet Then
			sText = "ong" + asOnglet + "_st.Color = '" + isCouleurDesactive + "'"
End If

This.Modify ( sText )








end subroutine

public subroutine uf_changerbitmap (string asnumonglet, string asBitMap);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ChangerTitre ( Public )
//* Auteur			: Erick John Stark
//* Date				: 16/01/1997 09:24:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String			asNumOnglet			(Val)	Num$$HEX1$$e900$$ENDHEX$$ro de l'onglet
//*					  String			asBitMap				(Val) Bitmap associ$$HEX4$$e9002000e0002000$$ENDHEX$$l'onglet
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sText

/*------------------------------------------------------------------*/
/* Changement du BitMap associ$$HEX4$$e9002000e0002000$$ENDHEX$$l'onglet                          */
/*------------------------------------------------------------------*/

If	asBitMap = "" Or IsNull ( asBitMap ) Then
	sText = "ong" + asNumOnglet + "_bmp.Visible = 0"
Else
	sText = 	"ong" + asNumOnglet + "_bmp.Visible = 1" + &
				" ong" + asNumOnglet + "_bmp.FileName='" + asBitMap + "'"
End If

This.Modify ( sText )

end subroutine

public subroutine uf_enregistreronglet (string asnumonglet, string astitre, string asbitmap, dragobject adoonglet, boolean abdefaut);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_EnregistrerOnglet ( Public )
//* Auteur			: Erick John Stark 
//* Date				: 20/12/1996 15:13:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation d'un Onglet
//*
//* Arguments		: String			asNumOnglet			(Val)	Num$$HEX1$$e900$$ENDHEX$$ro de l'onglet
//*					  String			asTitre				(Val) Titre de l'onglet
//*					  String			asBitMap				(Val) BitMap ssoci$$HEX4$$e9002000e0002000$$ENDHEX$$l'onglet
//*					  DragObject	adoOnglet			(Val) Objet associ$$HEX4$$e9002000e0002000$$ENDHEX$$l'onglet
//*					  Boolean		abDefaut				(Val)	Onglet par d$$HEX1$$e900$$ENDHEX$$faut
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Initialisation du titre et du BitMap associ$$HEX4$$e9002000e0002000$$ENDHEX$$l'onglet          */
/*------------------------------------------------------------------*/

Uf_ChangerTitre  ( asNumOnglet, asTitre )
Uf_ChangerBitMap ( asNumOnglet, asBitMap )

This.idoOnglet[ Integer ( asNumOnglet ) ] = adoOnglet

If	abDefaut Then

	Uf_ChangerOnglet ( asNumOnglet )

End If

end subroutine

public function string uf_recupererongletcourant ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ActiverOnglet (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 21/01/1997 09:28:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String				Valeur de l'onglet courant
//*
//*-----------------------------------------------------------------

Return ( isOngletCourant )
end function

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: u_onglets
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark 
//* Date				: 20/12/1996 14:12:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Activation de l'onglet sur lequel on vient de clicker
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sObjet, sOnglet, sCouleur, sText

sObjet = This.GetObjectAtPointer ()

/*------------------------------------------------------------------*/
/* Quel est l'onglet sur lequel on vient de clicker                 */
/* S'il s'agit de l'onglet courant, on ne fait rien                 */
/* De plus, si l'onglet est d$$HEX1$$e900$$ENDHEX$$sactiv$$HEX1$$e900$$ENDHEX$$e ( Couleur Rouge ), on ne     */
/* fait rien                                                        */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* La codification des onglets ( Texte + BitMap ) est la suivante   */
/*		TEXTE			BITMAP                                            */
/* 	ong01_st		ong01_p                                           */
/* 	ong02_st    ong02_p                                           */
/* 	ong03_st    ong03_p                                           */
/* 	ong04_st    ong04_p                                           */
/* 	ong05_st    ong05_p                                           */
/* 	ong06_st    ong06_p                                           */
/*------------------------------------------------------------------*/

If	Mid ( sObjet, 1, 3 ) = "ong" Then
	sOnglet = Mid ( sObjet, 4, 2 )
	sText = "ong" + sOnglet + "_st.Color"

	sCouleur = This.Describe ( sText )

	If	sOnglet	<> isOngletCourant And isCouleurDesactive <> sCouleur Then
		This.Uf_ChangerOnglet ( sOnglet )
	End If
End If

end on

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: u_onglets
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 21/01/1997 09:33:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut, on utilise la couleur GRIS CLAIR pour d$$HEX1$$e900$$ENDHEX$$sactiver un  */
/* onglet                                                           */
/*------------------------------------------------------------------*/


isCouleurDesactive = String ( RGB ( 128, 128, 128 ) )


end on

