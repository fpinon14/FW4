HA$PBExportHeader$u_barredefil.sru
$PBExportComments$------} UserObjet pour la barre de d$$HEX1$$e900$$ENDHEX$$filement uniquement
forward
global type u_barredefil from datawindow
end type
end forward

global type u_barredefil from datawindow
int Width=1623
int Height=77
int TabOrder=1
string DataObject="d_barredefil"
boolean Border=false
boolean LiveScroll=true
end type
global u_barredefil u_barredefil

type variables
UnsignedLong      iulTotal

String                  isX      // Position $$HEX2$$e0002000$$ENDHEX$$Gauche 14 PBU par d$$HEX1$$e900$$ENDHEX$$faut

Long                   ilLargeur
end variables

forward prototypes
public function long uf_init (long alnbr)
public subroutine uf_progression (unsignedlong aulnbr)
end prototypes

public function long uf_init (long alnbr);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Init
//* Auteur			: Erick John Stark
//* Date				: 24/05/1996 11:42:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de la Barre de d$$HEX1$$e900$$ENDHEX$$filement
//*
//* Arguments		: alNbr		Long		(Val)	Valeur du pourcentage $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$100 %
//*
//* Retourne		: Long
//*
//*-----------------------------------------------------------------

String sText, sRet

iulTotal		= alNbr

sText = "st_Pct.Text = '  0 %' rc_Barre.Width = 0 rc_Barre.X = " + isX
sRet = This.Modify ( sText )

Return ( 1 )




end function

public subroutine uf_progression (unsignedlong aulnbr);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Progression
//* Auteur			: Erick John Stark
//* Date				: 28/05/1996 15:46:21
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Progression de la barre de d$$HEX1$$e900$$ENDHEX$$filement et du pourcentage
//* Commentaires	: 
//*
//* Arguments		: aulNbr		UnsignedLong		(Val)	Valeur du compteur en cours
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lLargeur
String sText, sRet

lLargeur = ( aulNbr * ilLargeur ) / iulTotal

sText = "rc_barre.Width = " + String ( lLargeur )

sText		= sText + " " + "st_Pct.Text = '" + String ( Int ( aulNbr * 100 / iulTotal ) ) + " %'" 

sRet = This.modify ( sText )


end subroutine

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: U_BarreDefil
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 28/05/1996 11:35:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des attributs
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lPctX, lPctW
String sText, sRet

isX = "14"

/*------------------------------------------------------------------*/
/* Longueur du User Objet                                           */
/*------------------------------------------------------------------*/

ilLargeur = This.Width - 20

/*------------------------------------------------------------------*/
/* Longeur du pourcentage                                           */
/*------------------------------------------------------------------*/

lPctW = Long ( This.Describe ( "st_Pct.Width" ) )

/*------------------------------------------------------------------*/
/* Calcul pour le centrage du texte                                 */
/*------------------------------------------------------------------*/

lPctX = ( ( ilLargeur + 20 ) - lPctW ) / 2

sText = "Barre.X = " + isX + " Barre.Width = " + String ( ilLargeur ) + " " + "st_Pct.X = " + String ( lPctX )

sRet = This.modify ( sText )




end on

