HA$PBExportHeader$w_ac_spb_parametres.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil de consultation des param$$HEX1$$e800$$ENDHEX$$tres g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$raux du param$$HEX1$$e800$$ENDHEX$$trage.
forward
global type w_ac_spb_parametres from w_8_accueil_consultation
end type
end forward

global type w_ac_spb_parametres from w_8_accueil_consultation
integer x = 0
integer y = 200
integer width = 3639
integer height = 2000
string title = "Accueil - Consultation des param$$HEX1$$e800$$ENDHEX$$tres g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$raux"
end type
global w_ac_spb_parametres w_ac_spb_parametres

type variables
s_datainterro	stDataInterroNull[]
end variables

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_parametres
//* Evenement 		: Open
//* Auteur			: YP
//* Date				: 23/09/1997 12:15:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation des Dw d'accueil.
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//* #1 JCA 18/05/2006 DCMP 60291 passage d'id_cie de 2 $$HEX2$$e0002000$$ENDHEX$$3 caract$$HEX1$$e800$$ENDHEX$$res
//* #2 MADM 07/06/2006 Projet DNTMAIL1 : Ajout de la colonne ID_CANAL comme 2$$HEX1$$e900$$ENDHEX$$me identifiant $$HEX2$$e0002000$$ENDHEX$$la table PARAGRAHE
//* #3	JCA		15/11/2006		DCMP 060825 - plus de limitation du nbr de ligne de retour
//*-----------------------------------------------------------------

Long				lPosX					//Position X en Unit PB.
Long				lPosY					//Position Y en Unit PB.

//Migration PB8-WYNIWYG-03/2006 CP
//String 			sTables2[ 2 ]		// Table du SELECT
//String 			sTables[ 1 ]		// Table du SELECT
String sTables2 []
String sTables []
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Desactive le Reset sur les DW qui ne portent pas sur la          */
/* consultation, ainsi elles gardent leur contenu.                  */
/*------------------------------------------------------------------*/
Wf_Activer_ResetDw ( False )

/*------------------------------------------------------------------*/
/* Affecte l'object de transaction $$HEX2$$e0002000$$ENDHEX$$la variable d'instance.        */
/*------------------------------------------------------------------*/
iTrTrans = SQLCA


/*------------------------------------------------------------------*/
/* porte la limitation du nombre de lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$2000 au  */
/* lieu des 150 par d$$HEX1$$e900$$ENDHEX$$faut.                                         */
/*------------------------------------------------------------------*/
dw_1.ilMaxLig = 0 // #3


/*------------------------------------------------------------------*/
/* Description de la DW d'accueil                                   */
/*------------------------------------------------------------------*/
dw_1.istCol [ 1 ].sDbName		=	"sysadm.compagnie.id_cie"
dw_1.istCol [ 1 ].sType			=	"number"
dw_1.istCol [ 1 ].sHeaderName	=	"Cie"

// #1
//dw_1.istCol [ 1 ].ilargeur		=	2
dw_1.istCol [ 1 ].ilargeur		=	3
// #1 FIN

dw_1.istCol [ 1 ].sAlignement	=	"2"
dw_1.istCol [ 1 ].sInvisible	= 	"N"

dw_1.istCol [ 2 ].sDbName		=	"sysadm.compagnie.lib_cie"
dw_1.istCol [ 2 ].sType			=	"char(35)"
dw_1.istCol [ 2 ].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_1.istCol [ 2 ].ilargeur		=	35
dw_1.istCol [ 2 ].sAlignement	=	"0"
dw_1.istCol [ 2 ].sInvisible	= 	"N"

dw_1.istCol [ 3 ].sDbName		=	"sysadm.compagnie.cree_le"
dw_1.istCol [ 3 ].sType			=	"datetime"
dw_1.istCol [ 3 ].sHeaderName	=	"Cr$$HEX3$$e900e9002000$$ENDHEX$$le"
dw_1.istCol [ 3 ].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol [ 3 ].ilargeur		=	19
dw_1.istCol [ 3 ].sAlignement	=	"2"
dw_1.istCol [ 3 ].sInvisible	= 	"N"

dw_1.istCol [ 4 ].sDbName		=	"sysadm.compagnie.maj_le"
dw_1.istCol [ 4 ].sType			=	"datetime"
dw_1.istCol [ 4 ].sHeaderName	=	"Maj le"
dw_1.istCol [ 4 ].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_1.istCol [ 4 ].ilargeur		=	19
dw_1.istCol [ 4 ].sAlignement	=	"2"
dw_1.istCol [ 4 ].sInvisible	= 	"N"


dw_1.istCol [ 5 ].sDbName		=	"sysadm.compagnie.maj_par"
dw_1.istCol [ 5 ].sType			=	"char(4)"
dw_1.istCol [ 5 ].sHeaderName	=	"Par"
dw_1.istCol [ 5 ].ilargeur		=	4
dw_1.istCol [ 5 ].sAlignement	=	"2"
dw_1.istCol [ 5 ].sInvisible	= 	"N"

sTables [ 1 ]	= "compagnie"


/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_1.Uf_Creer_Tout( dw_1.istCol, sTables, itrTrans )

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut sur l'identifiant des compagnies.                 */
/*------------------------------------------------------------------*/
dw_1.isTri = "#1 A"



/*------------------------------------------------------------------*/
/* porte la limitation du nombre de lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$2000 au  */
/* lieu des 150 par d$$HEX1$$e900$$ENDHEX$$faut.                                         */
/*------------------------------------------------------------------*/
dw_2.ilMaxLig = 0 // #3

/*------------------------------------------------------------------*/
/* Description de la DW d'accueil                                   */
/*------------------------------------------------------------------*/
dw_2.istCol[1].sDbName		=	"sysadm.departement.id_dept"
dw_2.istCol[1].sType			=	"number"
dw_2.istCol[1].sHeaderName	=	"D$$HEX1$$e900$$ENDHEX$$pt."
dw_2.istCol[1].ilargeur		=	3
dw_2.istCol[1].sAlignement	=	"2"
dw_2.istCol[1].sInvisible	= 	"N"

dw_2.istCol[2].sDbName		=	"sysadm.departement.lib_dept"
dw_2.istCol[2].sType			=	"char(35)"
dw_2.istCol[2].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_2.istCol[2].ilargeur		=	35
dw_2.istCol[2].sAlignement	=	"0"
dw_2.istCol[2].sInvisible	= 	"N"

dw_2.istCol[3].sDbName		=	"sysadm.departement.cree_le"
dw_2.istCol[3].sType			=	"datetime"
dw_2.istCol[3].sHeaderName	=	"Cr$$HEX3$$e900e9002000$$ENDHEX$$le"
dw_2.istCol[3].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_2.istCol[3].ilargeur		=	19
dw_2.istCol[3].sAlignement	=	"2"
dw_2.istCol[3].sInvisible	= 	"N"

dw_2.istCol[4].sDbName		=	"sysadm.departement.maj_le"
dw_2.istCol[4].sType			=	"datetime"
dw_2.istCol[4].sHeaderName	=	"Maj le"
dw_2.istCol[4].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_2.istCol[4].ilargeur		=	19
dw_2.istCol[4].sAlignement	=	"2"
dw_2.istCol[4].sInvisible	= 	"N"

dw_2.istCol[5].sDbName		=	"sysadm.departement.maj_par"
dw_2.istCol[5].sType			=	"char(4)"
dw_2.istCol[5].sHeaderName	=	"Par"
dw_2.istCol[5].ilargeur		=	4
dw_2.istCol[5].sAlignement	=	"2"
dw_2.istCol[5].sInvisible	= 	"N"

sTables[ 1 ]	= "departement"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_2.Uf_Creer_Tout( dw_2.istCol, sTables, itrTrans )

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut sur l'identifiant des d$$HEX1$$e900$$ENDHEX$$partements.               */
/*------------------------------------------------------------------*/
dw_2.isTri = "#1 A"



/*------------------------------------------------------------------*/
/* porte la limitation du nombre de lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$2000 au  */
/* lieu des 150 par d$$HEX1$$e900$$ENDHEX$$faut.                                         */
/*------------------------------------------------------------------*/
dw_3.ilMaxLig = 0 // #3

/*------------------------------------------------------------------*/
/* Description de la DW d'accueil                                   */
/*------------------------------------------------------------------*/
dw_3.istCol [ 1 ].sDbName		=	"sysadm.groupe.id_grp"
dw_3.istCol [ 1 ].sType			=	"number"
dw_3.istCol [ 1 ].sHeaderName	=	"Contract."
dw_3.istCol [ 1 ].ilargeur		=	8
dw_3.istCol [ 1 ].sAlignement	=	"2"
dw_3.istCol [ 1 ].sInvisible	= 	"N"

dw_3.istCol [ 2 ].sDbName		=	"sysadm.groupe.id_grp_base"
dw_3.istCol [ 2 ].sType			=	"number"
dw_3.istCol [ 2 ].sHeaderName	=  "Ets p$$HEX1$$e800$$ENDHEX$$re"
dw_3.istCol [ 2 ].ilargeur		=	8
dw_3.istCol [ 2 ].sAlignement	=	"2"
dw_3.istCol [ 2 ].sInvisible	= 	"N"

dw_3.istCol [ 3 ].sDbName		=	"sysadm.groupe.lib_grp"
dw_3.istCol [ 3 ].sType			=	"char(35)"
dw_3.istCol [ 3 ].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_3.istCol [ 3 ].ilargeur		=	35
dw_3.istCol [ 3 ].sAlignement	=	"0"
dw_3.istCol [ 3 ].sInvisible	= 	"N"

dw_3.istCol [ 4 ].sDbName		=	"sysadm.groupe.cree_le"
dw_3.istCol [ 4 ].sType			=	"datetime"
dw_3.istCol [ 4 ].sHeaderName	=	"Cr$$HEX3$$e900e9002000$$ENDHEX$$le"
dw_3.istCol [ 4 ].sFormat		=	"dd/mm/yyyy hh:mm"
dw_3.istCol [ 4 ].ilargeur		=	16
dw_3.istCol [ 4 ].sAlignement	=	"2"
dw_3.istCol [ 4 ].sInvisible	= 	"N"

dw_3.istCol [ 5 ].sDbName		=	"sysadm.groupe.maj_le"
dw_3.istCol [ 5 ].sType			=	"datetime"
dw_3.istCol [ 5 ].sHeaderName	=	"Maj le"
dw_3.istCol [ 5 ].sFormat		=	"dd/mm/yyyy hh:mm"
dw_3.istCol [ 5 ].ilargeur		=	16
dw_3.istCol [ 5 ].sAlignement	=	"2"
dw_3.istCol [ 5 ].sInvisible	= 	"N"

dw_3.istCol [ 6 ].sDbName		=	"sysadm.groupe.maj_par"
dw_3.istCol [ 6 ].sType			=	"char(4)"
dw_3.istCol [ 6 ].sHeaderName	=	"Par"
dw_3.istCol [ 6 ].ilargeur		=	4
dw_3.istCol [ 6 ].sAlignement	=	"2"
dw_3.istCol [ 6 ].sInvisible	= 	"N"

sTables [ 1 ] = "groupe"


/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_3.Uf_Creer_Tout( dw_3.istCol, sTables, itrTrans )

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut                                                   */
/*------------------------------------------------------------------*/
dw_3.isTri = "#2 A, #1 A"




/*------------------------------------------------------------------*/
/* porte la limitation du nombre de lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$2000 au  */
/* lieu des 150 par d$$HEX1$$e900$$ENDHEX$$faut.                                         */
/*------------------------------------------------------------------*/
dw_4.ilMaxLig = 0 // #3

/*------------------------------------------------------------------*/
/*   Description de la DW d'accueil                                 */
/*------------------------------------------------------------------*/
dw_4.istCol [ 1 ].sDbName		=	"sysadm.paragraphe.id_para"
dw_4.istCol [ 1 ].sType			=	"char(4)"
dw_4.istCol [ 1 ].sHeaderName	=	"Id Para"
dw_4.istCol [ 1 ].ilargeur		=	8
dw_4.istCol [ 1 ].sAlignement	=	"2"
dw_4.istCol [ 1 ].sInvisible	= 	"N"

/*--------------------------------------------------------------------*/
/* #2 MADM	 07/06/2006 Projet DNTMAIL1 : Ajout de la colonne ID_CANAL*/
/* Avec un d$$HEX1$$e900$$ENDHEX$$calage de l'ordre des colonnes									 */
/*--------------------------------------------------------------------*/
//dw_4.istCol [ 2 ].sDbName		=	"sysadm.paragraphe.id_canal"
//dw_4.istCol [ 2 ].sType			=	"char(2)"
//dw_4.istCol [ 2 ].sHeaderName	=	"Id Canal"
//dw_4.istCol [ 2 ].ilargeur		=	8
//dw_4.istCol [ 2 ].sAlignement	=	"2"
//dw_4.istCol [ 2 ].sInvisible	= 	"N"
//Fin MADM

dw_4.istCol [ 2 ].sDbName		=	"sysadm.paragraphe.cpt_ver"
dw_4.istCol [ 2 ].sType			=	"char(3)"
dw_4.istCol [ 2 ].sHeaderName	=	"Version"
dw_4.istCol [ 2 ].ilargeur		=	8
dw_4.istCol [ 2 ].sAlignement	=	"2"
dw_4.istCol [ 2 ].sInvisible	= 	"N"

dw_4.istCol [ 3 ].sDbName		=	"sysadm.paragraphe.lib_para"
dw_4.istCol [ 3 ].sType			=	"char(35)"
dw_4.istCol [ 3 ].sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_4.istCol [ 3 ].ilargeur		=	36
dw_4.istCol [ 3 ].sAlignement	=	"0"
dw_4.istCol [ 3 ].sInvisible	= 	"N"

dw_4.istCol [ 4 ].sDbName		=	"sysadm.paragraphe.maj_le"
dw_4.istCol [ 4 ].sType			=	"Datetime"
dw_4.istCol [ 4 ].sHeaderName	=	"Maj Le"
dw_4.istCol [ 4 ].sFormat		=	"dd/mm/yyyy hh:mm:ss"
dw_4.istCol [ 4 ].ilargeur		=	20
dw_4.istCol [ 4 ].sAlignement	=	"2"
dw_4.istCol [ 4 ].sInvisible	= 	"N"

dw_4.istCol [ 5 ].sDbName		=	"sysadm.paragraphe.maj_par"
dw_4.istCol [ 5 ].sType			=	"char(4)"
dw_4.istCol [ 5 ].sHeaderName	=	"Par"
dw_4.istCol [ 5 ].ilargeur		=	4
dw_4.istCol [ 5 ].sAlignement	=	"2"
dw_4.istCol [ 5 ].sInvisible	= 	"N"

sTables [ 1 ] = "paragraphe"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_4.Uf_Creer_Tout( dw_4.istCol, sTables, itrTrans )

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut                                                   */
/*------------------------------------------------------------------*/
dw_4.isTri = "#1 A, #2 A"



/*------------------------------------------------------------------*/
/* porte la limitation du nombre de lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$2000 au  */
/* lieu des 150 par d$$HEX1$$e900$$ENDHEX$$faut.                                         */
/*------------------------------------------------------------------*/
dw_5.ilMaxLig = 0 // #3

/*------------------------------------------------------------------*/
/* Description de la DW d'accueil                                   */
/*------------------------------------------------------------------*/

dw_5.istCol [ 1 ] .sDbName			=	"sysadm.police.id_police"
dw_5.istCol [ 1 ] .sType			=	"number"
dw_5.istCol [ 1 ] .sHeaderName	=	"N$$HEX1$$b000$$ENDHEX$$"
dw_5.istCol [ 1 ] .ilargeur		=	4
dw_5.istCol [ 1 ] .sAlignement	=	"2"
dw_5.istCol [ 1 ] .sInvisible		= 	"N"

dw_5.istCol [ 2 ] .sDbName			=	"sysadm.police.lib_police"
dw_5.istCol [ 2 ] .sType			=	"char(35)"
dw_5.istCol [ 2 ] .sHeaderName	=	"Libell$$HEX1$$e900$$ENDHEX$$"
dw_5.istCol [ 2 ] .ilargeur		=	25
dw_5.istCol [ 2 ] .sAlignement	=	"0"
dw_5.istCol [ 2 ] .sInvisible		= 	"N"

dw_5.istCol [ 3 ] .sDbName			=	"sysadm.compagnie.lib_cie"
dw_5.istCol [ 3 ] .sType			=	"char(35)"
dw_5.istCol [ 3 ] .sHeaderName	=	"Compagnie"
dw_5.istCol [ 3 ] .ilargeur		=	25
dw_5.istCol [ 3 ] .sAlignement	=	"0"
dw_5.istCol [ 3 ] .sInvisible		= 	"N"

dw_5.istCol [ 4 ] .sDbName			=	"sysadm.police.cree_le"
dw_5.istCol [ 4 ] .sType			=	"datetime"
dw_5.istCol [ 4 ] .sHeaderName	=	"Cr$$HEX3$$e900e9002000$$ENDHEX$$le"
dw_5.istCol [ 4 ] .sFormat			=	"dd/mm/yyyy hh:mm"
dw_5.istCol [ 4 ] .ilargeur		=	16
dw_5.istCol [ 4 ] .sAlignement	=	"2"
dw_5.istCol [ 4 ] .sInvisible		= 	"N"

dw_5.istCol [ 5 ] .sDbName			=	"sysadm.police.maj_le"
dw_5.istCol [ 5 ] .sType			=	"datetime"
dw_5.istCol [ 5 ] .sHeaderName	=	"Maj le"
dw_5.istCol [ 5 ] .sFormat			=	"dd/mm/yyyy hh:mm"
dw_5.istCol [ 5 ] .ilargeur		=	16
dw_5.istCol [ 5 ] .sAlignement	=	"2"
dw_5.istCol [ 5 ] .sInvisible		= 	"N"

dw_5.istCol [ 6 ] .sDbName			=	"sysadm.police.maj_par"
dw_5.istCol [ 6 ] .sType			=	"char(4)"
dw_5.istCol [ 6 ] .sHeaderName	=	"Par"
dw_5.istCol [ 6 ] .ilargeur		=	4
dw_5.istCol [ 6 ] .sAlignement	=	"2"
dw_5.istCol [ 6 ] .sInvisible		= 	"N"


sTables2 [ 1 ] 	= "police"
sTables2 [ 2 ] 	= "compagnie"

Dw_5.isJointure		= " AND sysadm.police.id_cie = sysadm.compagnie.id_cie"


/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window d'Accueil                             */
/*------------------------------------------------------------------*/
dw_5.Uf_Creer_Tout( dw_5.istCol, sTables2, itrTrans )

/*------------------------------------------------------------------*/
/* Tri par d$$HEX1$$e900$$ENDHEX$$faut sur l'identifiant des polices.                    */
/*------------------------------------------------------------------*/
dw_5.isTri = "#1 A"



/*------------------------------------------------------------------*/
/* Initialisation de la structure pour le passage des param$$HEX1$$e800$$ENDHEX$$tres    */
/*------------------------------------------------------------------*/
istPass.trTrans 	= itrTrans
istPass.bControl	= False		// Utilisation du bouton VALIDER

/*------------------------------------------------------------------*/
/* Initialisation des onglets.                                      */
/*------------------------------------------------------------------*/
wf_Creer_Onglet( 5, 1, { "Compagnies",   "D$$HEX1$$e900$$ENDHEX$$partements", "Groupes", "Paragraphes", &
								 "Polices" } )



/*----------------------------------------------------------------------------*/
/* Centre les DW dans la fen$$HEX1$$ea00$$ENDHEX$$tre, puis on place l'onglet et le bord 3d en     */
/* fonction de l'emplacement de dw_1. Ainsi l'onglet se retrouve centrer par  */
/* rapport aux DW horizontalement.                                            */
/*----------------------------------------------------------------------------*/
dw_1.Uf_Largeur ( This.Width , 0 )
dw_2.Uf_Largeur ( This.Width , 0 )
dw_3.Uf_Largeur ( This.Width , 0 )
dw_4.Uf_Largeur ( This.Width , 0 )
dw_5.Uf_Largeur ( This.Width , 0 )


lPosX = This.Width
Dw_1.X =  ( ( lPosX - Dw_1.Width ) / 2 ) - 20
Dw_2.X =  ( ( lPosX - Dw_2.Width ) / 2 ) - 20
Dw_3.X =  ( ( lPosX - Dw_3.Width ) / 2 ) - 20
Dw_4.X =  ( ( lPosX - Dw_4.Width ) / 2 ) - 20
Dw_5.X =  ( ( lPosX - Dw_5.Width ) / 2 ) - 20


lPosY = This.Height + 230
Dw_1.Y =  ( ( lPosY - This.Y ) - Dw_1.Height ) / 2
Dw_2.Y =  Dw_1.Y
Dw_3.Y =  Dw_1.Y
Dw_4.Y =  Dw_1.Y
Dw_5.Y =  Dw_1.Y


Dw_2.Height = Dw_1.Height
Dw_3.Height = Dw_1.Height
Dw_4.Height = Dw_1.Height
Dw_5.Height = Dw_1.Height


Uo_1.X = Dw_1.X - ( ( Uo_1.Width - Dw_1.Width ) / 2 )
Uo_1.Y = Dw_1.Y - 40

Uo_Onglet.X      	= Uo_1.X - 9
Uo_Onglet.Y			= Dw_1.Y - 136

Uo_1.Width = Uo_1.Width + 5


end event

on ue_entreronglet051;call w_8_accueil_consultation::ue_entreronglet051;//*-----------------------------------------------------------------
//*
//* Objet			:	w_ac_spb_parametres
//* Evenement 		:	Ue_EntrerOnglet051
//* Auteur			:	YP
//* Date				:	23/09/1997 17:33:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise la recherche pour les polices.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$initialise le tableau Data.                                           */
/*----------------------------------------------------------------------------*/
pb_Interro.istInterro.sData = stDataInterroNull

/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des Polices."

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des Polices"
pb_Interro.istInterro.sDataObject			= "d_spb_int_police"
pb_Interro.istInterro.sCodeDw					= "POLICE"

pb_Interro.istInterro.sData[1].sNom					= "id_police"
pb_Interro.istInterro.sData[1].sDbNameConsult	= { "", "", "", "", "sysadm.police.id_police", "" }
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="
pb_Interro.istInterro.sData[1].sMoteur		= "MSS"

pb_Interro.istInterro.sData[2].sNom					= "id_cie"
pb_Interro.istInterro.sData[2].sDbNameConsult	= { "", "", "", "", "sysadm.police.id_cie", "" }
pb_Interro.istInterro.sData[2].sType		= "NUMBER"
pb_Interro.istInterro.sData[2].sOperande	= "="
pb_Interro.istInterro.sData[2].sMoteur		= "MSS"

pb_Interro.istInterro.sData[3].sNom					= "lib_police"
pb_Interro.istInterro.sData[3].sDbNameConsult	= { "", "", "", "", "sysadm.police.lib_police", "" }
pb_Interro.istInterro.sData[3].sType				= "STRING"
pb_Interro.istInterro.sData[3].sOperande			= "="


end on

event ue_modifier;call super::ue_modifier;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_compagnie
//* Evenement 		: ue_modifier
//* Auteur			: YP
//* Date				: 23/09/1997 12:16:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des d$$HEX1$$e900$$ENDHEX$$tails.
//* Commentaires	: Aucun
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
w_ancetre_consultation	wTemp		//Instance de fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre de consultation.
s_Pass						stPass	//Structure de passage de param$$HEX1$$e800$$ENDHEX$$tre.

stPass 					= istPass
stPass.bEnableParent = False

If iuAccueilCourrant.IlLigneClick > 0 Then

	If iuAccueilCourrant = Dw_4 Then

//Migration PB8-WYNIWYG-03/2006 FM
//		stPass.sTab[ 1 ] = dw_4.GetItemString ( dw_4.ilLigneClick, "PARAGRAPHE.ID_PARA" )
		stPass.sTab[ 1 ] = dw_4.GetItemString ( dw_4.ilLigneClick, "ID_PARA" )
//Fin Migration PB8-WYNIWYG-03/2006 FM

		If ( wf_Is_Mode_Mdi () ) Then
			f_OuvreConsultation (  wtemp, "w_dc_spb_paragraphe", stPass )
	
		Else
			 f_OuvreConsultation (  w_dc_spb_paragraphe, "", stPass )

		End If		

	End If

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on ue_preparer_interro;call w_8_accueil_consultation::ue_preparer_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_parametres
//* Evenement 		: ue_preparer_interro
//* Auteur			: YP
//* Date				: 24/09/1997 11:03:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise l'object de transaction pour les DDDW.
//*
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
DataWindowChild		dwCie				//DDDW pour les compagnies.
DataWindowChild		dwPolice			//DDDW pour les Polices.
DataWindowChild		dwDept			//DDDW pour les d$$HEX1$$e900$$ENDHEX$$partements.
DataWindowChild		dwGrp				//DDDW pour les contractants.
DataWindowChild		dwGrpBase		//DDDW pour le groupe de base.

Choose Case iuAccueilCourrant

	/*------------------------------------------------------------------*/
	/* Cas des Compagnies.                                              */
	/*------------------------------------------------------------------*/
	Case dw_1

			w_Interro_Consultation.dw_1.Uf_SetTransObject ( iTrTrans )

			W_Interro_Consultation.Dw_1.GetChild ( "ID_CIE", dwCie )
			dwCie.SetTransObject ( itrTrans )
			dwCie.Retrieve ( )


	/*------------------------------------------------------------------*/
	/* Cas des D$$HEX1$$e900$$ENDHEX$$partements                                             */
	/*------------------------------------------------------------------*/
	Case dw_2

			w_Interro_Consultation.dw_1.Uf_SetTransObject ( itrTrans )

			W_Interro_Consultation.Dw_1.GetChild ( "ID_DEPT", dwDept )
			dwDept.SetTransObject ( itrTrans )
			dwDept.Retrieve ( )

	/*------------------------------------------------------------------*/
	/* Cas des Groupes                                                  */
	/*------------------------------------------------------------------*/
	Case dw_3

			w_Interro_Consultation.dw_1.Uf_SetTransObject ( itrTrans )

			W_Interro_Consultation.Dw_1.GetChild ( "ID_GRP", dwGrp )
			dwGrp.SetTransObject ( itrTrans )
			dwGrp.Retrieve ( )

			W_Interro_Consultation.Dw_1.GetChild ( "ID_GRP_BASE", dwGrpBase )
			dwGrpBase.SetTransObject ( itrTrans )
			dwGrpBase.Retrieve ( )
			dwGrpBase.SetFilter ( "ID_GRP = ID_GRP_BASE" )
			dwGrpBase.Filter   ( )

	/*------------------------------------------------------------------*/
	/* Cas des Polices                                                  */
	/*------------------------------------------------------------------*/
	Case dw_5

			w_Interro_Consultation.dw_1.Uf_SetTransObject ( itrTrans )

			W_Interro_Consultation.Dw_1.GetChild ( "ID_POLICE", dwPolice )
			W_Interro_Consultation.Dw_1.GetChild ( "ID_CIE", dwCie )

			dwPolice.SetTransObject ( itrTrans )
			dwCie.SetTransObject 	( itrTrans )

			dwPolice.Retrieve		 	( )
			dwCie.Retrieve 			( )


End Choose
end on

on ue_entreronglet011;call w_8_accueil_consultation::ue_entreronglet011;//*-----------------------------------------------------------------
//*
//* Objet			:	w_ac_spb_parametres
//* Evenement 		:	Ue_EntrerOnglet011
//* Auteur			:	YP
//* Date				:	23/09/1997 17:33:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise la recherche pour les compagnies.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$initialise le tableau Data.                                           */
/*----------------------------------------------------------------------------*/
pb_Interro.istInterro.sData = stDataInterroNull


/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des Compagnies."


/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des Compagnies"
pb_Interro.istInterro.sDataObject			= "d_spb_int_compagnie"
pb_Interro.istInterro.sCodeDw					= "COMPAGNIE"

pb_Interro.istInterro.sData[1].sNom					= "id_cie"
pb_Interro.istInterro.sData[1].sDbNameConsult	= { "sysadm.compagnie.id_cie", "", "", "", "", "" } 
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="
pb_Interro.istInterro.sData[1].sMoteur		= "MSS"

pb_Interro.istInterro.sData[2].sNom					= "lib_cie"
pb_Interro.istInterro.sData[2].sDbNameConsult	= { "sysadm.compagnie.lib_cie", "", "", "", "", "" } 
pb_Interro.istInterro.sData[2].sType				= "STRING"
pb_Interro.istInterro.sData[2].sOperande			= "="
end on

on ue_entreronglet041;call w_8_accueil_consultation::ue_entreronglet041;//*-----------------------------------------------------------------
//*
//* Objet			:	w_ac_spb_parametres
//* Evenement 		:	Ue_EntrerOnglet041
//* Auteur			:	YP
//* Date				:	23/09/1997 17:33:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise la recherche pour les paragraphes.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$initialise le tableau Data.                                           */
/*----------------------------------------------------------------------------*/
pb_Interro.istInterro.sData = stDataInterroNull

/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des Paragraphes."

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des Paragraphes"
pb_Interro.istInterro.sDataObject			= "d_spb_int_paragraphe"
pb_Interro.istInterro.sCodeDw					= "PARAGRAPHE"

pb_Interro.istInterro.sData [ 1 ].sNom			= "id_para"
pb_Interro.istInterro.sData [ 1 ].sDbNameConsult	= { "", "", "", "sysadm.paragraphe.id_para", "", "" } 
pb_Interro.istInterro.sData [ 1 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 1 ].sOperande	= "="

pb_Interro.istInterro.sData [ 2 ].sNom			= "lib_para"
pb_Interro.istInterro.sData [ 2 ].sDbNameConsult	= { "", "", "", "sysadm.paragraphe.lib_para", "", "" } 
pb_Interro.istInterro.sData [ 2 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 2 ].sOperande	= "="

pb_Interro.istInterro.sData [ 3 ].sNom			= "maj_le1"
pb_Interro.istInterro.sData [ 3 ].sDbNameConsult	= { "", "", "", "sysadm.paragraphe.maj_le", "", "" } 
pb_Interro.istInterro.sData [ 3 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 3 ].sOperande	= ">="

pb_Interro.istInterro.sData [ 4 ].sNom			= "maj_le2"
pb_Interro.istInterro.sData [ 4 ].sDbNameConsult	= { "", "", "", "sysadm.paragraphe.maj_le", "", "" } 
pb_Interro.istInterro.sData [ 4 ].sType		= "DATETIME"
pb_Interro.istInterro.sData [ 4 ].sOperande	= "<="

pb_Interro.istInterro.sData [ 5 ].sNom			= "maj_par"
pb_Interro.istInterro.sData [ 5 ].sDbNameConsult	= { "", "", "", "sysadm.paragraphe.maj_par", "", "" } 
pb_Interro.istInterro.sData [ 5 ].sType		= "STRING"
pb_Interro.istInterro.sData [ 5  ].sOperande	= "="


end on

on ue_entreronglet021;call w_8_accueil_consultation::ue_entreronglet021;//*-----------------------------------------------------------------
//*
//* Objet			:	w_ac_spb_parametres
//* Evenement 		:	Ue_EntrerOnglet021
//* Auteur			:	YP
//* Date				:	23/09/1997 17:33:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise la recherche pour les d$$HEX1$$e900$$ENDHEX$$partements.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$initialise le tableau Data.                                           */
/*----------------------------------------------------------------------------*/
pb_Interro.istInterro.sData = stDataInterroNull

/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des D$$HEX1$$e900$$ENDHEX$$partements."

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des D$$HEX1$$e900$$ENDHEX$$partements"
pb_Interro.istInterro.sDataObject			= "d_spb_int_departement"
pb_Interro.istInterro.sCodeDw					= "DEPARTEMENT"

pb_Interro.istInterro.sData[1].sNom					= "id_dept"
pb_Interro.istInterro.sData[1].sDbNameConsult	= { "", "sysadm.departement.id_dept", "", "", "", "" } 
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="
pb_Interro.istInterro.sData[1].sMoteur		= "MSS"

pb_Interro.istInterro.sData[2].sNom					= "lib_dept"
pb_Interro.istInterro.sData[2].sDbNameConsult	= { "", "sysadm.departement.lib_dept", "", "", "", "" } 
pb_Interro.istInterro.sData[2].sType				= "STRING"
pb_Interro.istInterro.sData[2].sOperande			= "="


end on

on ue_fin_interro;call w_8_accueil_consultation::ue_fin_interro;//*-----------------------------------------------------------------
//*
//* Objet 			: w_ac_spb_compagnie
//* Evenement 		: ue_fin_interro
//* Auteur			: YP
//* Date				: 23/09/97 10:56:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Retaille la fen$$HEX1$$ea00$$ENDHEX$$tre en hauteur.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.TriggerEvent( "Ue_TaillerHauteur" )

iuAccueilCourrant.SetFocus ( )
end on

on w_ac_spb_parametres.create
int iCurrent
call super::create
end on

on w_ac_spb_parametres.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

on ue_entreronglet031;call w_8_accueil_consultation::ue_entreronglet031;//*-----------------------------------------------------------------
//*
//* Objet			:	w_ac_spb_parametres
//* Evenement 		:	Ue_EntrerOnglet031
//* Auteur			:	YP
//* Date				:	23/09/1997 17:33:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise la recherche pour les groupes.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$initialise le tableau Data.                                           */
/*----------------------------------------------------------------------------*/
pb_Interro.istInterro.sData = stDataInterroNull

/*------------------------------------------------------------------*/
/* Positionne la variable pour le titre des listes $$HEX2$$e0002000$$ENDHEX$$imprimer.      */
/*------------------------------------------------------------------*/
This.isTitreLst = "Base : " + itrtrans.database + ". Liste des Groupes."

/*------------------------------------------------------------------*/
/* Fen$$HEX1$$ea00$$ENDHEX$$tre de recherche                                             */
/*------------------------------------------------------------------*/
pb_Interro.istInterro.wAncetre				= This
pb_Interro.istInterro.sTitre 					= "Recherche des Groupes"
pb_Interro.istInterro.sDataObject			= "d_spb_int_groupe"
pb_Interro.istInterro.sCodeDw					= "GROUPE"

pb_Interro.istInterro.sData[1].sNom					= "id_grp"
pb_Interro.istInterro.sData[1].sDbNameConsult	= { "", "", "sysadm.groupe.id_grp", "", "", "" } 
pb_Interro.istInterro.sData[1].sType		= "NUMBER"
pb_Interro.istInterro.sData[1].sOperande	= "="
pb_Interro.istInterro.sData[1].sMoteur		= "MSS"

pb_Interro.istInterro.sData[2].sNom					= "id_grp_base"
pb_Interro.istInterro.sData[2].sDbNameConsult	= { "", "", "sysadm.groupe.id_grp_base", "", "", "" } 
pb_Interro.istInterro.sData[2].sType		= "NUMBER"
pb_Interro.istInterro.sData[2].sOperande	= "="
pb_Interro.istInterro.sData[2].sMoteur		= "MSS"

pb_Interro.istInterro.sData[3].sNom					= "lib_grp"
pb_Interro.istInterro.sData[3].sDbNameConsult	= { "", "", "sysadm.groupe.lib_grp", "", "", "" } 
pb_Interro.istInterro.sData[3].sType				= "STRING"
pb_Interro.istInterro.sData[3].sOperande			= "="


end on

type pb_retour from w_8_accueil_consultation`pb_retour within w_ac_spb_parametres
end type

type pb_interro from w_8_accueil_consultation`pb_interro within w_ac_spb_parametres
end type

type pb_tri from w_8_accueil_consultation`pb_tri within w_ac_spb_parametres
end type

type uo_onglet from w_8_accueil_consultation`uo_onglet within w_ac_spb_parametres
boolean visible = true
end type

type dw_1 from w_8_accueil_consultation`dw_1 within w_ac_spb_parametres
boolean visible = true
integer x = 55
integer y = 348
integer width = 2880
integer height = 1340
boolean border = true
end type

on dw_1::ue_modifiermenu;call w_8_accueil_consultation`dw_1::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet			:	w_8_accueil_consultation::dw_1
//* Evenement 		:	Ue_modifierMenu
//* Auteur			:	YP
//* Date				:	25/09/1997 09:53:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	On ne garde que le choix 'Interroger'
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

uf_Mnu_InterdirItem ( 2 )
end on

type dw_2 from w_8_accueil_consultation`dw_2 within w_ac_spb_parametres
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
boolean border = true
end type

on dw_2::ue_modifiermenu;call w_8_accueil_consultation`dw_2::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet			:	w_8_accueil_consultation::dw_2
//* Evenement 		:	Ue_modifierMenu
//* Auteur			:	YP
//* Date				:	25/09/1997 09:53:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	On ne garde que le choix 'Interroger'
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

uf_Mnu_InterdirItem ( 2 )
end on

type dw_3 from w_8_accueil_consultation`dw_3 within w_ac_spb_parametres
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
boolean border = true
end type

on dw_3::ue_modifiermenu;call w_8_accueil_consultation`dw_3::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet			:	w_8_accueil_consultation::dw_3
//* Evenement 		:	Ue_modifierMenu
//* Auteur			:	YP
//* Date				:	25/09/1997 09:53:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	On ne garde que le choix 'Interroger'
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

uf_Mnu_InterdirItem ( 2 )
end on

type dw_4 from w_8_accueil_consultation`dw_4 within w_ac_spb_parametres
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
boolean border = true
end type

type dw_5 from w_8_accueil_consultation`dw_5 within w_ac_spb_parametres
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
boolean border = true
end type

on dw_5::ue_modifiermenu;call w_8_accueil_consultation`dw_5::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet			:	w_8_accueil_consultation::dw_1
//* Evenement 		:	Ue_modifierMenu
//* Auteur			:	YP
//* Date				:	25/09/1997 09:53:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	On ne garde que le choix 'Interroger'
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

uf_Mnu_InterdirItem ( 2 )

end on

type dw_6 from w_8_accueil_consultation`dw_6 within w_ac_spb_parametres
integer x = 78
integer y = 332
integer width = 2862
integer height = 1052
boolean border = true
end type

type uo_1 from w_8_accueil_consultation`uo_1 within w_ac_spb_parametres
integer width = 3552
integer height = 1412
boolean enabled = false
end type

type pb_imprimer from w_8_accueil_consultation`pb_imprimer within w_ac_spb_parametres
boolean visible = true
end type

