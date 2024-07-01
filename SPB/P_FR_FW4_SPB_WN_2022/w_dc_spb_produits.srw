HA$PBExportHeader$w_dc_spb_produits.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d$$HEX1$$e900$$ENDHEX$$tail de consultation des produits.
forward
global type w_dc_spb_produits from w_8_ancetre_consultation
end type
type uo_onglets from u_onglets within w_dc_spb_produits
end type
type p_1 from picture within w_dc_spb_produits
end type
type uo_onglets2 from u_onglets within w_dc_spb_produits
end type
type uo_bord3d2 from u_bord3d within w_dc_spb_produits
end type
type uo_bord3d3 from u_bord3d within w_dc_spb_produits
end type
type uo_bord3d from u_bord3d within w_dc_spb_produits
end type
type dw_ets from u_datawindow within w_dc_spb_produits
end type
type dw_courriers from u_datawindow within w_dc_spb_produits
end type
type dw_ets_rev from u_datawindow within w_dc_spb_produits
end type
type dw_pieces from u_datawindow within w_dc_spb_produits
end type
type dw_refus from u_datawindow within w_dc_spb_produits
end type
type dw_garanties from u_datawindow within w_dc_spb_produits
end type
type dw_produit from u_datawindow within w_dc_spb_produits
end type
type dw_compo_para from u_datawindow within w_dc_spb_produits
end type
type dw_cond from u_datawindow within w_dc_spb_produits
end type
type dw_code from u_datawindow within w_dc_spb_produits
end type
type dw_revision from u_datawindow within w_dc_spb_produits
end type
type dw_garanties_rev from u_datawindow within w_dc_spb_produits
end type
end forward

global type w_dc_spb_produits from w_8_ancetre_consultation
integer x = 0
integer y = 0
integer width = 3090
integer height = 1784
string title = "Consultation d~'un produit"
boolean controlmenu = false
event ue_entreronglet011 pbm_custom01
event ue_entreronglet021 pbm_custom02
event ue_entreronglet031 pbm_custom03
event ue_entreronglet041 pbm_custom04
event ue_entreronglet051 pbm_custom05
event ue_entreronglet061 pbm_custom06
event ue_quitteronglet011 pbm_custom07
event ue_quitteronglet021 pbm_custom08
event ue_quitteronglet031 pbm_custom09
event ue_quitteronglet041 pbm_custom10
event ue_quitteronglet051 pbm_custom11
event ue_entreronglet012 pbm_custom12
event ue_entreronglet022 pbm_custom13
event ue_entreronglet032 pbm_custom14
event ue_entreronglet042 pbm_custom15
event ue_entreronglet052 pbm_custom16
event ue_entreronglet062 pbm_custom17
event ue_debut_initialiser pbm_custom18
uo_onglets uo_onglets
p_1 p_1
uo_onglets2 uo_onglets2
uo_bord3d2 uo_bord3d2
uo_bord3d3 uo_bord3d3
uo_bord3d uo_bord3d
dw_ets dw_ets
dw_courriers dw_courriers
dw_ets_rev dw_ets_rev
dw_pieces dw_pieces
dw_refus dw_refus
dw_garanties dw_garanties
dw_produit dw_produit
dw_compo_para dw_compo_para
dw_cond dw_cond
dw_code dw_code
dw_revision dw_revision
dw_garanties_rev dw_garanties_rev
end type
global w_dc_spb_produits w_dc_spb_produits

type variables
u_datawindow	iuDwCourante


String		isNumOngletCourant = "00"

Integer		iiNbOnglets1Supplementaires = 0
Integer		iiNbOnglets2Supplementaires = 0

string		isDwProduit
string		isDwGarantie
string		isDwGarantieRevision
string		isDwRevision
string		isDwCondition
string		isDwCode
string		isDwPiece
string		isDwRefus
string		isDwCourrier
string		isDwEts
end variables

forward prototypes
public function boolean wf_preparerconsulter ()
public subroutine wf_init_conditions (string asidgti, string asidtypcode)
private subroutine wf_positionnerobjets ()
end prototypes

on ue_entreronglet021;call w_8_ancetre_consultation::ue_entreronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			: w_dc_spb_produits
//* Evenement 		: ue_entreronglet021
//* Auteur			: YP
//* Date				: 16/09/97 10:15:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Positionne la deuxi$$HEX1$$e800$$ENDHEX$$me barre d'onglets.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.SetRedraw ( FALSE )

Uo_Onglets2.Visible = True

Uo_Bord3d.Visible		= False
Uo_Bord3d2.Visible	= True
Uo_Bord3d3.Visible	= True

Uo_Bord3d2.BringToTop = False
Uo_Bord3d3.BringToTop = False

Uo_Onglets2.Uf_ChangerOnglet ( "01" )

This.SetRedraw ( TRUE )
end on

on ue_entreronglet031;call w_8_ancetre_consultation::ue_entreronglet031;//*-----------------------------------------------------------------
//*
//* Objet 			: w_dc_spb_produits
//* Evenement 		: ue_entreronglet031
//* Auteur			: YP
//* Date				: 16/09/97 10:14:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Visualise les DW d$$HEX1$$e900$$ENDHEX$$pendantes.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
String			sIdRev		// R$$HEX1$$e900$$ENDHEX$$vision courante.
Long				lNumLig		// N$$HEX2$$b0002000$$ENDHEX$$de ligne courante.

Dw_Garanties_Rev.Visible	= TRUE
Dw_Ets_Rev.Visible			= TRUE

lNumLig = Dw_Revision.GetRow ( )

If lNumLig > 0 Then

	sIdRev	=	String ( Dw_Revision.GetItemNumber  ( Dw_Revision.GetRow ( ) , "ID_REV" ) )

	Dw_Ets_Rev.SetFilter				(	"ID_REV=" + sIdRev				)
	Dw_Ets_Rev.Filter					(											)

	Dw_Ets_Rev.SetSort				( "ID_GRP A" )
	Dw_Ets_Rev.Sort					( )

End If
end on

on ue_entreronglet041;call w_8_ancetre_consultation::ue_entreronglet041;//*-----------------------------------------------------------------
//*
//* Objet			:	w_dc_spb_produits
//* Evenement 		:	Ue_EntrerOnglet041
//* Auteur			:	YP
//* Date				:	16/09/1997 10:24:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	On filtre les $$HEX1$$e900$$ENDHEX$$tablissements li$$HEX1$$e900$$ENDHEX$$s au produit.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

Dw_Ets.SetFilter				(	"ID_REV=-1"	)
Dw_Ets.Filter					(					)

Dw_Ets.SetSort					( "ID_GRP A"	)
Dw_Ets.Sort						( 					)
end on

on ue_quitteronglet021;call w_8_ancetre_consultation::ue_quitteronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			: w_dc_spb_produits
//* Evenement 		: ue_quitteronglet021
//* Auteur			: YP
//* Date				: 16/09/97 10:17:12
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Ferme toutes les fen$$HEX1$$ea00$$ENDHEX$$tres d$$HEX1$$e900$$ENDHEX$$pendantes et d$$HEX1$$e900$$ENDHEX$$positionne la 2$$HEX1$$e800$$ENDHEX$$me barre d'onglets.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uo_Onglets2.Visible = False

Uo_Bord3d.Visible		= True
Uo_Bord3d2.Visible	= False
Uo_Bord3d3.Visible	= False


end on

on ue_quitteronglet031;call w_8_ancetre_consultation::ue_quitteronglet031;//*-----------------------------------------------------------------
//*
//* Objet 			: w_dc_spb_produits
//* Evenement 		: ue_quitteronglet031
//* Auteur			: YP
//* Date				: 16/09/97 10:18:12
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: G$$HEX1$$e800$$ENDHEX$$re les DW d$$HEX1$$e900$$ENDHEX$$pendantes de l'onglet.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_Garanties_Rev.Visible = False
Dw_Ets_Rev.Visible = False

end on

on ue_entreronglet012;call w_8_ancetre_consultation::ue_entreronglet012;//*-----------------------------------------------------------------
//*
//* Objet 			: w_dc_spb_produits
//* Evenement 		: Ue_EntrerOnglet012
//* Auteur			: YP
//* Date				: 12/09/97 18:08:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Indique l'onglet courant.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

isNumOngletCourant = "01"

Dw_Code.Visible	=	False
end on

on ue_entreronglet022;call w_8_ancetre_consultation::ue_entreronglet022;//*
//* Objet 			: w_dc_spb_produits
//* Evenement 		: Ue_EntrerOnglet022
//* Auteur			: YP
//* Date				: 12/09/97 18:08:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Indique l'onglet courant.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

isNumOngletCourant = "02"

Dw_Code.Visible	=	False
end on

on ue_entreronglet032;call w_8_ancetre_consultation::ue_entreronglet032;//*-----------------------------------------------------------------
//*
//* Objet 			: w_dc_spb_produits
//* Evenement 		: Ue_EntrerOnglet032
//* Auteur			: YP
//* Date				: 14/05/97 15:54:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Filtre les conditions de garanties (Nature de sin.).
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
String 		sIdGti			//Identifiant du code garantie.
String		sIdTypCode		//Identifiant de l'indicateur.


isNumOngletCourant = "03"

/*------------------------------------------------------------------*/
/* Si on a au moins un code condition, on filtre en fonction du     */
/* code garantie courant et de l'indicateur courant                 */
/*------------------------------------------------------------------*/

If ( dw_garanties.RowCount ( ) > 0 ) Then

	sIdGti     = String ( dw_garanties.GetItemNumber ( dw_garanties.GetRow ( ) , "ID_GTI" ) )

Else

	/*------------------------------------------------------------------*/
	/* S'il n'y a pas de garantie, on met l'identifiant $$HEX2$$e0002000$$ENDHEX$$'', ainsi     */	
	/* lorsque l'on va filtrer, la DW des codes conditions affect$$HEX1$$e900$$ENDHEX$$s     */
	/* sera vide.                                                       */
	/*------------------------------------------------------------------*/
	sIdGti = ""

End If

sIdTypCode = "+NS"

wf_Init_Conditions ( sIdGti , sIdTypCode )

Dw_Code.Visible = TRUE
end on

on ue_entreronglet042;call w_8_ancetre_consultation::ue_entreronglet042;//*-----------------------------------------------------------------
//*
//* Objet 			: w_dc_spb_produits
//* Evenement 		: Ue_EntrerOnglet042
//* Auteur			: YP
//* Date				: 14/05/97 15:54:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Filtre les conditions de garanties (Territorialit$$HEX1$$e900$$ENDHEX$$s).
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
String 		sIdGti			//Identifiant du code garantie.
String		sIdTypCode		//Identifiant de l'indicateur.

isNumOngletCourant = "04"

/*------------------------------------------------------------------*/
/* Si on a au moins un code condition, on filtre en fonction du     */
/* code garantie courant et de l'indicateur courant                 */
/*------------------------------------------------------------------*/

If ( dw_garanties.RowCount ( ) > 0 ) Then

	sIdGti = String ( dw_garanties.GetItemNumber ( dw_garanties.GetRow ( ) , "ID_GTI" ) )

Else

	/*------------------------------------------------------------------*/
	/* S'il n'y a pas de garantie, on met l'identifiant $$HEX2$$e0002000$$ENDHEX$$'', ainsi     */	
	/* lorsque l'on va filtrer, la DW des codes conditions affect$$HEX1$$e900$$ENDHEX$$s     */
	/* sera vide.                                                       */
	/*------------------------------------------------------------------*/
	sIdGti = ""

End If

sIdTypCode = "+TR"

wf_Init_Conditions ( sIdGti , sIdTypCode )

Dw_Code.Visible = TRUE
end on

public function boolean wf_preparerconsulter ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerConsulter
//* Auteur			: YP
//* Date				: 12/09/1997 17:55:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise les Dw
//* Commentaires	: 
//*
//* Arguments		: Aucun.
//*
//* Retourne		: boolean 	TRUE  : si OK
//*									FALSE : sinon
//*
//*-----------------------------------------------------------------

Long					lPos				//Position du tiret dans le titre.

Boolean 				bRet				//Valeur de retour de la fonction.

String				sLibProd			//Libell$$HEX2$$e9002000$$ENDHEX$$long du produit.

SetPointer ( HourGlass! )

/*------------------------------------------------------------------*/
/* Initialise le contenu des DW.                                    */
/*------------------------------------------------------------------*/
bRet = ( dw_produit.Retrieve ( Dec ( istPass.sTab[ 1 ] ) )  > 0 )

If bRet Then

	/*------------------------------------------------------------------*/
	/* Mise $$HEX2$$e0002000$$ENDHEX$$jour du titre avec le libell$$HEX2$$e9002000$$ENDHEX$$du produit.                 */
	/*------------------------------------------------------------------*/
	sLibProd	=	Dw_Produit.GetItemString ( 1 , "LIB_LONG" )

	lPos = Pos ( This.Title , "-" )

	If lPos > 0 Then

		This.Title = Left ( This.Title , lPos - 2 ) + " - " + sLibProd

	Else

		This.Title = This.Title + " - " + sLibProd

	End If

	Dw_Garanties.Retrieve   	(	Dec ( istPass.sTab[ 1 ] )     )
	Dw_Garanties_rev.Retrieve	(	Dec ( istPass.sTab[ 1 ] )     )
	Dw_Revision.Retrieve 		(	Dec ( istPass.sTab[ 1 ] )     )
	Dw_Cond.Retrieve 				(	Dec ( istPass.sTab[ 1 ] )     )
	Dw_Code.Retrieve           (  										)
	Dw_Pieces.Retrieve 			(	Dec ( istPass.sTab[ 1 ] ), -1 )
	Dw_Refus.Retrieve 			(	Dec ( istPass.sTab[ 1 ] ), -1 )
	Dw_Courriers.Retrieve   	(  Dec ( istPass.sTab[ 1 ] )     )
   Dw_Ets.Retrieve 				(	Dec ( istPass.sTab[ 1 ] ) 		)

	Dw_Ets.SetFilter				(	"ID_REV=-1"							)
	Dw_Ets.Filter					(											)

	Dw_Ets.SetSort					( "ID_GRP A" )
	Dw_Ets.Sort						( )


	dw_garanties.SetSort   		( "id_gti A"   )
	dw_garanties.Sort      		( )

	dw_garanties_rev.SetSort 	( "id_gti A" )
	dw_garanties_rev.Sort 		( )

	dw_revision.SetSort 			( "id_rev A"   )
	dw_revision.Sort    			( )

	dw_courriers.SetSort   		( "id_cour A"  )
	dw_courriers.Sort      		( )


	/*------------------------------------------------------------------*/
	/* Positionne le 1er onglet, par d$$HEX1$$e900$$ENDHEX$$faut.                            */
	/*------------------------------------------------------------------*/
	Uo_Onglets.uf_ChangerOnglet( "01" )

	/*------------------------------------------------------------------*/
	/* Positionne 'pas d'onglet courant' pour le 2$$HEX1$$e800$$ENDHEX$$me onglet            */
	/*------------------------------------------------------------------*/	
	isNumOngletCourant = "00"

End If

Return ( bRet )
end function

public subroutine wf_init_conditions (string asidgti, string asidtypcode);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Init_Conditions
//* Auteur			: YP
//* Date				: 12/09/97 17:56:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise les conditions de la garantie.
//* Commentaires	: 
//*
//* Arguments		: 	asIdGti		String		: Identifiant de la garantie.
//*						asIdTypCode	String		: Identifiant du type de code.
//*
//* Retourne		: rien
//*					
//*
//*-----------------------------------------------------------------
String		sfiltre		// Chaine de filtre.
String		sIdCode		// Identifiant de Code.
Long			lNbrLig		// Nombre de ligne.
Long			lCpt			// Compteur de ligne.

SetPointer ( HourGlass! )

/*----------------------------------------------------------------------------*/
/* Si asIdGti est vide, cela signifie qu'il n'y a pas de garantie, donc pas   */
/* besoin de filtrer.                                                         */
/*----------------------------------------------------------------------------*/
If asIdGti <> "" Then
	sFiltre = "ID_GTI=" + asIdGti + " AND ID_TYP_CODE='" + asIdTypCode + "'"

	Dw_Cond.SetFilter ( sFiltre )
	Dw_Cond.Filter    ( )
	Dw_Cond.SetSort ( "ID_CODE A" )
	Dw_Cond.Sort    ( )

End If

/*------------------------------------------------------------------*/
/* On enl$$HEX1$$e800$$ENDHEX$$ve de la liste des codes les codes affect$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$la          */
/* garantie.                                                        */
/*------------------------------------------------------------------*/

sFiltre = "ID_TYP_CODE='" + asIdTypCode + "'"

lNbrLig = Dw_Cond.RowCount ( )

If  lNbrLig > 0 Then

	/*------------------------------------------------------------------*/
	/* On construit le filtre qiu va supprimer les codes affect$$HEX1$$e900$$ENDHEX$$s de    */
	/* la liste des codes non affect$$HEX1$$e900$$ENDHEX$$s.                                 */
	/*------------------------------------------------------------------*/
	For lCpt = 1 to lNbrLig

		sIdCode = String ( Dw_Cond.GetItemNumber ( lCpt , "ID_CODE" ) )
		sFiltre = sFiltre + " AND ID_CODE<>" + sIdCode
	Next

End If

Dw_Code.SetFilter ( sFiltre )
Dw_Code.Filter    ( )
Dw_Code.SetSort ( "ID_CODE A" )
Dw_Code.sort    ( )


end subroutine

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Dc_Spb_Produits::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: PLJ
//* Date				: 29/04/1999
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne et on taille tous les objets
//*                 sauf uo_bord_3d_1 et uo_bord_3d_2 qui sont positionn$$HEX1$$e900$$ENDHEX$$s et taill$$HEX1$$e900$$ENDHEX$$s
//*                 qui sont positionn$$HEX1$$e900$$ENDHEX$$s et taill$$HEX1$$e900$$ENDHEX$$s par leur constructor
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne tous les objets n$$HEX1$$e900$$ENDHEX$$cessaires $$HEX2$$e0002000$$ENDHEX$$la gestion, pour     */
/* faciliter le d$$HEX1$$e900$$ENDHEX$$veloppement. (On peut bouger les objets).         */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Barres Onglets                                                   */
/*------------------------------------------------------------------*/
Uo_Onglets.X			=   14
Uo_Onglets.Y			=  165
Uo_Onglets.Height	   =  109

Uo_Onglets2.X			=   14
Uo_Onglets2.Y			=  813
Uo_Onglets2.Height	=  109


/*----------------------------------------*/
/* Dw_Revision                            */
/*----------------------------------------*/
Dw_Revision.X			=  101
Dw_Revision.Y			=  313
Dw_Revision.Width		= 3027
Dw_Revision.Height	=  569

/*----------------------------------------*/
/* Dw_Produit                             */
/*----------------------------------------*/
Dw_Produit.X			=   55
Dw_Produit.Y			=  350
Dw_Produit.Width		= 2812
Dw_Produit.Height		= 1200

/*----------------------------------------*/
/* Dw_Ets	                              */
/*----------------------------------------*/
Dw_Ets.X					=  796
Dw_Ets.Y					=  305
Dw_Ets.Width			= 1441
Dw_Ets.Height			= 1285

/*----------------------------------------*/
/* Dw_Ets_Rev                             */
/*----------------------------------------*/
Dw_Ets_Rev.X			= 1687
Dw_Ets_Rev.Y			=  921
Dw_Ets_Rev.Width		= 1441
Dw_Ets_Rev.Height		=  645


/*----------------------------------------*/
/* Dw_Courriers                           */
/*----------------------------------------*/
Dw_Courriers.X			=  796
Dw_Courriers.Y			=  305
Dw_Courriers.Width	= 1441
Dw_Courriers.Height	= 1285

/*----------------------------------------*/
/* Dw_Garanties                           */
/*----------------------------------------*/
Dw_Garanties.X			=  531
Dw_Garanties.Y			=  305
Dw_Garanties.Width	= 2190
Dw_Garanties.Height	=  425

/*----------------------------------------*/
/* Dw_Garanties_Rev                       */
/*----------------------------------------*/
Dw_Garanties_Rev.X		=  101
Dw_Garanties_Rev.Y		=  921
Dw_Garanties_Rev.Width	= 1463
Dw_Garanties_Rev.Height	=  645

/*----------------------------------------*/
/* Dw_Code                                */
/*----------------------------------------*/
Dw_Code.X		=  124
Dw_Code.Y		=  957
Dw_Code.Width	= 1441
Dw_Code.Height	=  637

/*----------------------------------------*/
/* Dw_Pieces                              */
/*----------------------------------------*/
Dw_Pieces.X			=  878
Dw_Pieces.Y			=  957
Dw_Pieces.Width	= 1441
Dw_Pieces.Height	=  637

/*----------------------------------------*/
/* Dw_Refus	                              */
/*----------------------------------------*/
Dw_Refus.X			=  878
Dw_Refus.Y			=  957
Dw_Refus.Width	   = 1441
Dw_Refus.Height	=  637

/*----------------------------------------*/
/* Dw_Cond                                */
/*----------------------------------------*/
Dw_Cond.X			= 1678
Dw_Cond.Y			=  957
Dw_Cond.Width		= 1441
Dw_Cond.Height		=  637



end subroutine

on ue_initialiser;call w_8_ancetre_consultation::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_dc_spb_produits
//* Evenement 		: ue_initialiser
//* Auteur			: YP
//* Date				: 12/09/1997 17:41:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise les DW
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*----------------------------------------------------------------------------*/
/* On ne donne pas de limite aux tableaux de colonnes afin de pouvoir g$$HEX1$$e900$$ENDHEX$$rer   */
/* un nombre quelconque de colonne. On pourra ainsi ajouter ou d$$HEX1$$e900$$ENDHEX$$truire une   */
/* colonne dans une DW sans s'en soucier.                                     */
/*----------------------------------------------------------------------------*/
DataWindowChild	dwIdCorb			// DDDW des corbeilles.
DataWindowChild	dwCodNivOpe		// DDDW des niveaux op$$HEX1$$e900$$ENDHEX$$rateurs.
DataWindowChild	dwCodRgptStat	// DDDW des codes de regroupements statistiques.
DataWindowChild   dwChild			// pour chargement des DDDW

String		sEditStyle			// contient le style de la colonne.
String		sColProd	[]			// Liste des colonnes de la DW Produit.
String		sMod					// Chaine de modification de la DW.

Long			lNbCol				// Nombre de colonnes de la DW.
Long			lCpt					// Compteur de boucle.
Long			lCptCol				// Compteur de colonne dont on doit modifier les attributs.


SetPointer ( HourGlass! )

Wf_PositionnerObjets ()

/*----------------------------------------------------------------------------*/
/* Cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement permet d'initialiser les variables d'instances               */
/* iiNbOngletsXSupplementaires dans un descendant, par exemple.               */
/* De m$$HEX1$$ea00$$ENDHEX$$me pour initialiser les variables d'instances contenant les           */
/* DataObjects affect$$HEX1$$e900$$ENDHEX$$s dynamiquement ci-dessous.                             */
/*                                                                            */
/* Les Uf_EnregistrerOnglet() suppl$$HEX1$$e900$$ENDHEX$$mentaires seront cod$$HEX1$$e900$$ENDHEX$$s dans le descendant */
/* du pr$$HEX1$$e900$$ENDHEX$$sent $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement.                                                      */
/*----------------------------------------------------------------------------*/
TriggerEvent ( "Ue_Debut_Initialiser" )

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet                                       */
/*------------------------------------------------------------------*/
Uo_Onglets.uf_Initialiser( 5 + iiNbOnglets1Supplementaires , 1 )

Uo_Onglets.Uf_EnregistrerOnglet ( "01", "Produits",				"", Dw_Produit,	False )
Uo_Onglets.Uf_EnregistrerOnglet ( "02", "Garanties",				"", Dw_Garanties,	False )
Uo_Onglets.Uf_EnregistrerOnglet ( "03", "R$$HEX1$$e900$$ENDHEX$$visions",				"", Dw_Revision,  False )
Uo_Onglets.Uf_EnregistrerOnglet ( "04", "Etablissements",		"", Dw_Ets,		 	False )
Uo_Onglets.Uf_EnregistrerOnglet ( "05", "Courriers",				"", Dw_Courriers,	False )


Uo_Onglets2.uf_Initialiser( 4 + iiNbOnglets2Supplementaires , 2 )

Uo_Onglets2.Uf_EnregistrerOnglet ( "01", "Pi$$HEX1$$e800$$ENDHEX$$ces",					"", Dw_Pieces,	False )
Uo_Onglets2.Uf_EnregistrerOnglet ( "02", "Refus",					"", Dw_Refus,	False )
Uo_Onglets2.Uf_EnregistrerOnglet ( "03", "Natures Sin.",			"", Dw_Cond,	False )
Uo_Onglets2.Uf_EnregistrerOnglet ( "04", "Territorialit$$HEX1$$e900$$ENDHEX$$s",		"", Dw_Cond,	False )

Dw_Produit.DataObject			= isDwProduit
Dw_Garanties.DataObject			= isDwGarantie
Dw_Ets.DataObject					= isDwEts
Dw_Garanties_Rev.DataObject	= isDwGarantieRevision
Dw_Ets_Rev.DataObject			= isDwEts
Dw_Revision.DataObject			= isDwRevision
Dw_Cond.DataObject				= isDwCondition
Dw_Code.DataObject				= isDwCode
Dw_Pieces.DataObject				= isDwPiece
Dw_Refus.DataObject				= isDwRefus
Dw_Courriers.DataObject			= isDwCourrier

/*------------------------------------------------------------------*/
/* Affectation des Transactions                                     */
/*------------------------------------------------------------------*/
Dw_Produit.uf_SetTransObject			( istPass.trTrans )
Dw_Garanties.uf_SetTransObject		( istPass.trTrans )
Dw_Garanties_rev.Uf_SetTransObject	( istPass.trTrans )
Dw_Revision.uf_SetTransObject			( istPass.trTrans )
Dw_Cond.uf_SetTransObject				( istPass.trTrans )
Dw_Code.Uf_SetTransObject				( istPass.trTrans )
Dw_Pieces.uf_SetTransObject			( istPass.trTrans )
Dw_Refus.uf_SetTransObject				( istPass.trTrans )
Dw_Courriers.uf_SetTransObject		( istPass.trTrans )
Dw_Ets.uf_SetTransObject				( istPass.trTrans )

Dw_Compo_Para.Uf_SetTransObject		( istPass.trTrans	)

Dw_Ets.ShareData ( Dw_Ets_Rev )


/*----------------------------------------------------------------------------*/
/* On doit indiquer ici, les RowFocusIndicator positionn$$HEX1$$e900$$ENDHEX$$s car ces            */
/* Uf_indicator ex$$HEX1$$e900$$ENDHEX$$cut$$HEX1$$e900$$ENDHEX$$s dans les constructor des DW concern$$HEX1$$e900$$ENDHEX$$es sont          */
/* inefficaces $$HEX2$$e0002000$$ENDHEX$$cause de l'affectation dynamique des DataObjects dans le     */
/* pr$$HEX1$$e900$$ENDHEX$$sent $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement.                                                         */
/*----------------------------------------------------------------------------*/
Dw_Garanties.Uf_Indicator ( p_1 )
Dw_Garanties_Rev.Uf_Indicator ( p_1 )
Dw_Revision.Uf_Indicator ( p_1 )

/*----------------------------------------------------------------------------*/
/* Initialisation des DDDW.                                                   */
/*----------------------------------------------------------------------------*/
Dw_Produit.GetChild ( "COD_EURO", dwChild )
dwChild.SetTransObject	( istPass.trTrans )
dwChild.Retrieve ( "-EU" )


Dw_Produit.GetChild ( "ID_CORB", dwIDCorb )

dwIdCorb.SetTransObject ( iTrTrans )
If ( dwIdCorb.Retrieve ( "-CO" ) <=0 ) Then
	dwIdCorb.InsertRow ( 0 )
End If

Dw_Produit.GetChild ( "COD_NIV_OPE", dwCodNivOpe )

dwCodNivOpe.SetTransObject ( iTrTrans )
If ( dwCodNivOpe.Retrieve ( "-NO" ) <=0 ) Then
	dwCodNivOpe.InsertRow ( 0 )
End If

Dw_Garanties.GetChild ( "COD_RGPT_STAT", dwCodRgptStat )

dwCodRgptStat.SetTransObject ( itrTrans )
If ( dwCodRgptStat.Retrieve ( "-GS" ) <= 0 ) Then

	dwCodRgptStat.InsertRow ( 0 )

End If



/*----------------------------------------------------------------------------*/
/* Initialisation des champs.                                                 */
/*----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------*/
/* PROTECTION DES ZONES DE PRODUITS                                           */
/*----------------------------------------------------------------------------*/
lNbCol 	= Long ( Dw_Produit.Describe ( "datawindow.column.count" ) )

sMod		= ""
lCptCol	= 0

If lNbCol > 0 Then

	For lCpt = lNbCol to 1 step -1

		sEditStyle	= Dw_Produit.Describe ( "#" + String ( lCpt ) + ".edit.style" )

		/*----------------------------------------------------------------------------*/
		/* Si la colonne a un style (les colonnes qui ne sont pas "pos$$HEX1$$e900$$ENDHEX$$es" sur une    */
		/* des 'band' de la DW renvoient un style $$HEX2$$e0002000$$ENDHEX$$"?"), alors on traite la colonne  */
		/* (si la colonne est de type ddlb ou dddw on vire la fl$$HEX1$$e800$$ENDHEX$$che ; pour les       */
		/* autres, on les inclut dans la liste des colonnes qui vont passer dans      */
		/* Uf_InitialiserCouleur et Uf_Proteger.                                      */
		/*----------------------------------------------------------------------------*/

		If sEditStyle <> "?" Then

			If Lower ( sEditStyle ) = "ddlb" Or Lower ( sEditStyle ) = "dddw" Then

				sMod = sMod + " #" + String ( lCpt ) + "." + sEditStyle + ".UseAsBorder =No"	

			End If

			lCptCol++
			sColProd	[ lCptCol ] = "#" + String ( lCpt )

		End If

	Next

	Dw_Produit.Uf_Modify ( sMod )

	Dw_Produit.Uf_InitialiserCouleur ( sColProd )

	Dw_Produit.Uf_proteger ( sColProd , "1" )

End If


/*----------------------------------------------------------------------------*/
/* PROTECTION DES ZONES DE GARANTIES                                          */
/*----------------------------------------------------------------------------*/
sMod = "lib_gti.protect=1 mt_cmt.protect=1"
Dw_Garanties.Uf_Modify ( sMod )

/*----------------------------------------------------------------------------*/
/* PROTECTION DES ZONES DE PIECES                                             */
/*----------------------------------------------------------------------------*/
sMod = "lib_code.protect=1 id_para.edit.displayonly=yes"
Dw_Pieces.Uf_Modify ( sMod )

/*----------------------------------------------------------------------------*/
/* PROTECTION DES ZONES DE MOTIFS                                             */
/*----------------------------------------------------------------------------*/
Dw_Refus.Uf_Modify ( sMod )

/*----------------------------------------------------------------------------*/
/* PROTECTION DES ZONES DE COURRIER                                           */
/*----------------------------------------------------------------------------*/
sMod = " lib_code.protect=1"
Dw_Courriers.Uf_Modify ( sMod )

/*----------------------------------------------------------------------------*/
/* PROTECTION DES ZONES D'ETABLISSEMENT                                       */
/*----------------------------------------------------------------------------*/
sMod = " id_ets.protect=1"
Dw_Ets.Uf_Modify ( sMod )

/*----------------------------------------------------------------------------*/
/* Affecte un titre $$HEX2$$e0002000$$ENDHEX$$la DW des conditions couvertes.                         */
/*----------------------------------------------------------------------------*/
sMod = "titre.text='Conditions couvertes'"
Dw_Cond.Uf_Modify ( sMod )

/*----------------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$sactive le menu contextuel sur la liste des r$$HEX1$$e900$$ENDHEX$$visions.                */
/*----------------------------------------------------------------------------*/
Dw_Revision.Uf_Activer_Menu ( FALSE )

/*----------------------------------------------------------------------------*/
/* On positionne le curseur indiquant que l'on peut visualiser la compo du    */
/* courrier sur dw_courriers.                                                 */
/*----------------------------------------------------------------------------*/
sMod = "DataWindow.Pointer='K:\PB4OBJ\BMP\RBDCLICK.CUR'"
Dw_Courriers.Uf_Modify ( sMod )

sMod = "id_ets.protect=1"
Dw_Ets_Rev.Uf_modify ( sMod )
end on

on close;call w_8_ancetre_consultation::close;//*-----------------------------------------------------------------
//*
//* Objet 			: w_dc_spb_produits
//* Evenement 		: close
//* Auteur			: YP
//* Date				: 20/02/97 16:11:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If IsValid ( w_consulter_paragraphe ) Then Close ( w_consulter_paragraphe )

If IsValid ( w_consulter_courrier ) Then Close ( w_consulter_courrier )
end on

on ue_retour;call w_8_ancetre_consultation::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet			:	w_dc_spb_produits
//* Evenement 		:	Ue_Retour
//* Auteur			:	YP
//* Date				:	19/09/1997 15:25:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ferme la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des paragraphes.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

If IsValid ( w_consulter_paragraphe ) Then Close ( w_consulter_paragraphe )


end on

on hide;call w_8_ancetre_consultation::hide;//*-----------------------------------------------------------------
//*
//* Objet 			: w_dc_spb_produits
//* Evenement 		: hide
//* Auteur			: YP
//* Date				: 20/02/97 16:11:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If IsValid ( w_consulter_paragraphe ) Then Close ( w_consulter_paragraphe )
end on

on w_dc_spb_produits.create
int iCurrent
call super::create
this.uo_onglets=create uo_onglets
this.p_1=create p_1
this.uo_onglets2=create uo_onglets2
this.uo_bord3d2=create uo_bord3d2
this.uo_bord3d3=create uo_bord3d3
this.uo_bord3d=create uo_bord3d
this.dw_ets=create dw_ets
this.dw_courriers=create dw_courriers
this.dw_ets_rev=create dw_ets_rev
this.dw_pieces=create dw_pieces
this.dw_refus=create dw_refus
this.dw_garanties=create dw_garanties
this.dw_produit=create dw_produit
this.dw_compo_para=create dw_compo_para
this.dw_cond=create dw_cond
this.dw_code=create dw_code
this.dw_revision=create dw_revision
this.dw_garanties_rev=create dw_garanties_rev
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_onglets
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.uo_onglets2
this.Control[iCurrent+4]=this.uo_bord3d2
this.Control[iCurrent+5]=this.uo_bord3d3
this.Control[iCurrent+6]=this.uo_bord3d
this.Control[iCurrent+7]=this.dw_ets
this.Control[iCurrent+8]=this.dw_courriers
this.Control[iCurrent+9]=this.dw_ets_rev
this.Control[iCurrent+10]=this.dw_pieces
this.Control[iCurrent+11]=this.dw_refus
this.Control[iCurrent+12]=this.dw_garanties
this.Control[iCurrent+13]=this.dw_produit
this.Control[iCurrent+14]=this.dw_compo_para
this.Control[iCurrent+15]=this.dw_cond
this.Control[iCurrent+16]=this.dw_code
this.Control[iCurrent+17]=this.dw_revision
this.Control[iCurrent+18]=this.dw_garanties_rev
end on

on w_dc_spb_produits.destroy
call super::destroy
destroy(this.uo_onglets)
destroy(this.p_1)
destroy(this.uo_onglets2)
destroy(this.uo_bord3d2)
destroy(this.uo_bord3d3)
destroy(this.uo_bord3d)
destroy(this.dw_ets)
destroy(this.dw_courriers)
destroy(this.dw_ets_rev)
destroy(this.dw_pieces)
destroy(this.dw_refus)
destroy(this.dw_garanties)
destroy(this.dw_produit)
destroy(this.dw_compo_para)
destroy(this.dw_cond)
destroy(this.dw_code)
destroy(this.dw_revision)
destroy(this.dw_garanties_rev)
end on

type st_titre from w_8_ancetre_consultation`st_titre within w_dc_spb_produits
boolean visible = false
integer x = 3886
integer y = 132
integer width = 306
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_dc_spb_produits
integer x = 23
integer y = 16
integer taborder = 180
end type

type uo_onglets from u_onglets within w_dc_spb_produits
integer x = 91
integer y = 192
integer width = 2921
integer height = 108
integer taborder = 130
boolean border = false
end type

type p_1 from picture within w_dc_spb_produits
boolean visible = false
integer x = 2743
integer y = 32
integer width = 82
integer height = 52
boolean bringtotop = true
string picturename = "k:\pb4obj\bmp\focus_2.bmp"
boolean focusrectangle = false
end type

type uo_onglets2 from u_onglets within w_dc_spb_produits
integer x = 82
integer y = 352
integer width = 2921
integer height = 108
integer taborder = 140
boolean border = false
end type

type uo_bord3d2 from u_bord3d within w_dc_spb_produits
integer x = 887
integer y = 8
integer width = 265
integer height = 112
integer taborder = 170
boolean border = true
end type

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Dc_Spb_Produits::Uo_bord3Dd2 (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: PLJ
//* Date				: 29/04/1999
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne le Bord en 3D, puis on appelle la construction     */
/* normale.                                                         */
/*------------------------------------------------------------------*/

This.X			=   23
This.Y			=  261
This.Width		= 3191
This.Height		=  517

Call U_Bord3D::Constructor
end on

on uo_bord3d2.destroy
call u_bord3d::destroy
end on

type uo_bord3d3 from u_bord3d within w_dc_spb_produits
integer x = 1193
integer y = 12
integer width = 265
integer height = 112
integer taborder = 160
boolean border = true
end type

on constructor;call u_bord3d::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Dc_Spb_Produits::Uo_bord3Dd3 (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: PLJ
//* Date				: 29/04/1999
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne le Bord en 3D, puis on appelle la construction     */
/* normale.                                                         */
/*------------------------------------------------------------------*/

This.X			=   23
This.Y			=  909
This.Width		= 3191
This.Height		=  737

Call U_Bord3D::Constructor
end on

on uo_bord3d3.destroy
call u_bord3d::destroy
end on

type uo_bord3d from u_bord3d within w_dc_spb_produits
integer x = 549
integer y = 8
integer width = 265
integer height = 112
integer taborder = 150
boolean bringtotop = true
end type

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Dc_Spb_Produits::Uo_bord3D (OVERRIDE)
//* Evenement 		: Constructor
//* Auteur			: PLJ
//* Date				: 29/04/1999
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne le Bord en 3D, puis on appelle la construction     */
/* normale.                                                         */
/*------------------------------------------------------------------*/

This.X			=   23
This.Y			=  261
This.Width		= 3210
This.Height		= 1385

Call U_Bord3D::Constructor
end on

on uo_bord3d.destroy
call u_bord3d::destroy
end on

type dw_ets from u_datawindow within w_dc_spb_produits
boolean visible = false
integer x = 558
integer y = 1436
integer width = 201
integer height = 144
integer taborder = 20
boolean vscrollbar = true
end type

type dw_courriers from u_datawindow within w_dc_spb_produits
boolean visible = false
integer x = 786
integer y = 1436
integer width = 201
integer height = 144
integer taborder = 90
boolean vscrollbar = true
end type

event rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_Courriers
//* Evenement 		:	rbuttondown - OVERRIDE.
//* Auteur			:	YP
//* Date				:	19/09/97 15:44:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de d$$HEX1$$e900$$ENDHEX$$clencher la visualisation du courrier
//*						type d$$HEX1$$e900$$ENDHEX$$fini par cette composition.
//*						si ligne courante il y a et si $$HEX2$$a7002000$$ENDHEX$$il y a
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sIdCour		// Identifiant du courrier.
String		sBand			// Bande sur laquelle on clique.

s_Pass		stPass

Long			lnbrPara
Long			lCpt			// Compteur pour le nombre de paragraphe.
Long			lCpt1			// compteur pour le tableau.


// click pour changer de ligne si besoin est

//Migration PB8-WYNIWYG-03/2006 FM
//Send( Handle( This ) , 513, Message.WordParm, Message.LongParm ) 
This.TriggerEvent(Clicked!)
//Fin Migration PB8-WYNIWYG-03/2006 FM

sBand	= Left ( This.GetBandAtPointer (), 4 )

If	sBand = "deta" Then

//Migration PB8-WYNIWYG-03/2006 FM
//	If This.GetRow ( ) > 0 Then
	If Row > 0 Then
//Fin Migration PB8-WYNIWYG-03/2006 FM

		stPass.trTrans	=	Parent.itrTrans

//Migration PB8-WYNIWYG-03/2006 FM
//		sIdCour = This.GetItemString ( This.GetRow ( ) , "ID_COUR" )
		sIdCour = This.GetItemString ( Row , "ID_COUR" )
//Fin Migration PB8-WYNIWYG-03/2006 FM

		Dw_Compo_Para.Retrieve ( sIdCour )

		lNbrPara = Dw_Compo_Para.Rowcount ( )

		If lnbrPara > 0	Then

			stPass.sTab [ 1 ]	=	" Courrier " + sIdCour
			lCpt1 = 2
	
			For lCpt = 1	to lNbrPara

				stPass.sTab [ lCpt1 ] = Dw_Compo_Para.GetItemString ( lCpt, "ID_PARA"  )
				lCpt1 ++
				stPass.sTab [ lCpt1 ] = Dw_Compo_Para.GetItemString ( lCpt, "LIB_PARA" )
				lCpt1 ++

			Next

			If	IsValid ( W_Consulter_Courrier )	Then
	
				W_Consulter_Courrier.Show ( )

			Else

				Open ( W_Consulter_Courrier )
	
			End If

			W_Consulter_Courrier.Wf_AfficherCourrier ( stPass )

		End If

	End If

End If
end event

on doubleclicked;call u_datawindow::doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_courriers
//* Evenement 		: doubleclicked
//* Auteur			: YP
//* Date				: 18/02/97 14:27:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: d$$HEX1$$e900$$ENDHEX$$clenche ue_modifier qui g$$HEX1$$e800$$ENDHEX$$re l'ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de 
//*						consultation de la liste des paragraphes du courrier type courant.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iUdwCourante = This
Parent.TriggerEvent ( "ue_modifier" )
end on

type dw_ets_rev from u_datawindow within w_dc_spb_produits
boolean visible = false
integer x = 1015
integer y = 1436
integer width = 201
integer height = 144
integer taborder = 110
boolean vscrollbar = true
end type

type dw_pieces from u_datawindow within w_dc_spb_produits
boolean visible = false
integer x = 1243
integer y = 1436
integer width = 201
integer height = 144
integer taborder = 80
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_pieces
//* Evenement 		:	ItemChanged
//* Auteur			:	YP
//* Date				:	15/09/1997 16:51:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	On annule toute tentative de modification. Les DDDW sont accessibles
//*                  pour consulter le libell$$HEX2$$e9002000$$ENDHEX$$d'un code, mais ne doivent pas pouvoir $$HEX1$$ea00$$ENDHEX$$tre 
//*                  modifi$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

//SetActionCode ( 2 )
Return ( 2 )
end event

on rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_Pieces
//* Evenement 		:	rbuttondown ( OVERRIDE )
//* Auteur			:	YP
//* Date				:	15/09/97 10:12:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de d$$HEX1$$e900$$ENDHEX$$clencher la visualisation du paragraphe
//*						courant de la ligne courante.
//*						si ligne courante il y a et si $$HEX2$$a7002000$$ENDHEX$$il y a
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String			sCol		// Colonne sur laquelle se trouve le curseur
Long				lLig		// Ligne sur laquelle se trouve le curseur
u_DataWindow	CetteDw	// DW pr$$HEX1$$e900$$ENDHEX$$sente.

s_Pass		stPass

CetteDw	=	This
lLig	=	f_GetObjectAtPointer ( CetteDw , sCol )

If lLig > 0 Then

	This.ScrollToRow ( lLig )
	This.SetRow ( lLig )

	stPass.trTrans	=	Parent.itrTrans
	stPass.sTab[1]	=	This.GetItemString ( lLig, "ID_PARA" )
	stPass.sTab[2]	=	" Paragraphe " + This.GetItemString ( lLig, "ID_PARA" )

	If	Not ( IsNull ( stPass.sTab [ 1 ] ) )	Then

		If	IsValid ( W_Consulter_Paragraphe )	Then

			W_Consulter_Paragraphe.Show ()

		Else

			Open ( W_Consulter_Paragraphe )

		End If

		W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass )

	End If

End If
end on

on doubleclicked;call u_datawindow::doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_pieces
//* Evenement 		: doubleclicked
//* Auteur			: YP
//* Date				: 15/09/97 10:41:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: d$$HEX1$$e900$$ENDHEX$$clenche ue_modifier qui g$$HEX1$$e800$$ENDHEX$$re l'ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de 
//*						consultation du d$$HEX1$$e900$$ENDHEX$$tail du paragraphe s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iUdwCourante = This
Parent.TriggerEvent ( "ue_modifier" )
end on

type dw_refus from u_datawindow within w_dc_spb_produits
boolean visible = false
integer x = 1472
integer y = 1436
integer width = 201
integer height = 144
integer taborder = 60
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_refus
//* Evenement 		:	ItemChanged
//* Auteur			:	YP
//* Date				:	15/09/1997 16:51:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	On annule toute tentative de modification. Les DDDW sont accessibles
//*                  pour consulter le libell$$HEX2$$e9002000$$ENDHEX$$d'un code, mais ne doivent pas pouvoir $$HEX1$$ea00$$ENDHEX$$tre 
//*                  modifi$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

//SetActionCode ( 2 )
Return ( 2 )
end event

on doubleclicked;call u_datawindow::doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_garanties_4
//* Evenement 		: doubleclicked
//* Auteur			: YP
//* Date				: 15/09/97 10:42:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: d$$HEX1$$e900$$ENDHEX$$clenche ue_modifier qui g$$HEX1$$e800$$ENDHEX$$re l'ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de 
//*						consultation du d$$HEX1$$e900$$ENDHEX$$tail du paragraphe s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iUdwCourante = This
Parent.TriggerEvent ( "ue_modifier" )
end on

on rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_Refus
//* Evenement 		:	rbuttondown ( OVERRIDE )
//* Auteur			:	YP
//* Date				:	15/09/97 10:12:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de d$$HEX1$$e900$$ENDHEX$$clencher la visualisation du paragraphe
//*						courant de la ligne courante.
//*						si ligne courante il y a et si $$HEX2$$a7002000$$ENDHEX$$il y a
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String			sCol		// Colonne sur laquelle se trouve le curseur
Long				lLig		// Ligne sur laquelle se trouve le curseur
u_DataWindow	CetteDw	// DW pr$$HEX1$$e900$$ENDHEX$$sente.

s_Pass		stPass

CetteDw	=	This
lLig	=	f_GetObjectAtPointer ( CetteDw , sCol )

If lLig > 0 Then

	This.ScrollToRow ( lLig )
	This.SetRow ( lLig )

	stPass.trTrans	=	Parent.itrTrans
	stPass.sTab[1]	=	This.GetItemString ( lLig, "ID_PARA" )
	stPass.sTab[2]	=	" Paragraphe " + This.GetItemString ( lLig, "ID_PARA" )

	If	Not ( IsNull ( stPass.sTab [ 1 ] ) )	Then

		If	IsValid ( W_Consulter_Paragraphe )	Then

			W_Consulter_Paragraphe.Show ()

		Else

			Open ( W_Consulter_Paragraphe )

		End If

		W_Consulter_Paragraphe.Wf_AfficherParagraphe ( stPass )

	End If

End If
end on

type dw_garanties from u_datawindow within w_dc_spb_produits
integer x = 1701
integer y = 1436
integer width = 201
integer height = 144
integer taborder = 50
boolean vscrollbar = true
end type

on constructor;call u_datawindow::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_garanties
//* Evenement 		: constructor
//* Auteur			: YP
//* Date				: 20/02/97 10:43:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise le RowFocusIndicateur.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.Uf_Indicator ( p_1 )
end on

event rowfocuschanged;call super::rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Garanties
//* Evenement 		: RowFocusChanged
//* Auteur			: YP
//* Date				: 20/02/97 13:39:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Synchronise les datawindows avec le code garantie courant.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
String		sIdGti			//Identifiant du code garantie.
String		sIdTypCode		//Identifiant de l'indicateur.
Long			lNumLig			//No de ligne courante.


//Migration PB8-WYNIWYG-03/2006 FM
//lNumLig = dw_garanties.GetRow ( )
lNumLig = CurrentRow
//Fin Migration PB8-WYNIWYG-03/2006 FM

If lNumLig > 0 Then

	sIdGti     = String ( dw_garanties.GetItemNumber ( lNumLig	, "ID_GTI" ) )

	Choose Case	isNumOngletCourant

		Case "03"
			sIdTypCode = "+NS"

		Case "04"
			sIdTypCode = "+TR"

	End Choose

	If isNumOngletCourant = "03" Or isNumOngletCourant = "04" Then

		wf_init_conditions ( sIdGti , sIdTypCode )

	End If

	dw_Pieces.SetFilter ( "ID_GTI=" + sIdGti )
	dw_Pieces.Filter    ( )
	dw_Pieces.SetSort   ( "ID_PCE A" )
	dw_Pieces.Sort      ( )

	dw_Refus.SetFilter  ( "ID_GTI=" + sIdGti )
	dw_Refus.Filter     ( )

	Dw_Refus.SetSort    ( "#4 A" )
	Dw_Refus.Sort       ( )

End If
end event

event itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			:	dw_garanties
//* Evenement 		:	ItemChanged
//* Auteur			:	YP
//* Date				:	15/09/1997 16:51:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	On annule toute tentative de modification. Les DDDW sont accessibles
//*                  pour consulter le libell$$HEX2$$e9002000$$ENDHEX$$d'un code, mais ne doivent pas pouvoir $$HEX1$$ea00$$ENDHEX$$tre 
//*                  modifi$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

//SetActionCode ( 2 )
Return ( 2 )
end event

on doubleclicked;call u_datawindow::doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_garanties
//* Evenement 		: doubleclicked
//* Auteur			: YP
//* Date				: 18/02/97 14:27:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: d$$HEX1$$e900$$ENDHEX$$clenche ue_modifier qui g$$HEX1$$e800$$ENDHEX$$re l'ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de 
//*						consultation de la garantie s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$pour la r$$HEX1$$e900$$ENDHEX$$vision s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iUdwCourante = This
Parent.TriggerEvent ( "ue_modifier" )
end on

type dw_produit from u_datawindow within w_dc_spb_produits
boolean visible = false
integer x = 1929
integer y = 1436
integer width = 201
integer height = 144
integer taborder = 120
boolean border = false
end type

type dw_compo_para from u_datawindow within w_dc_spb_produits
boolean visible = false
integer x = 3195
integer y = 20
integer height = 100
integer taborder = 10
string dataobject = "d_spb_compo_para"
end type

type dw_cond from u_datawindow within w_dc_spb_produits
boolean visible = false
integer x = 2158
integer y = 1436
integer width = 201
integer height = 144
integer taborder = 40
boolean bringtotop = true
boolean vscrollbar = true
end type

type dw_code from u_datawindow within w_dc_spb_produits
boolean visible = false
integer x = 2386
integer y = 1436
integer width = 201
integer height = 144
integer taborder = 70
boolean bringtotop = true
boolean vscrollbar = true
end type

type dw_revision from u_datawindow within w_dc_spb_produits
boolean visible = false
integer x = 101
integer y = 1436
integer width = 201
integer height = 144
integer taborder = 30
boolean bringtotop = true
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_revision
//* Evenement 		: RowFocusChanged
//* Auteur			: YP
//* Date				: 15/09/97 10:43:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: synchronise la liste des garanties avec la r$$HEX1$$e900$$ENDHEX$$vision.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
Long		lNumLig				// N$$HEX2$$b0002000$$ENDHEX$$de ligne.
String	sFiltre				// Chaine de filtre des garanties.
String	sIdRev				// Identifiant de la r$$HEX1$$e900$$ENDHEX$$vision courante.

//Migration PB8-WYNIWYG-03/2006 FM
//lNumLig	=	This.GetRow ( )
lNumLig	=	CurrentRow
//Fin Migration PB8-WYNIWYG-03/2006 FM

If lNumLig > 0 Then

	sIdRev	=	String ( This.GetItemNumber ( lNumLig , "ID_REV" ) )

	sFiltre	=	"ID_REV=" + sIdRev

	Dw_Garanties_Rev.SetFilter ( sFiltre )
	Dw_Garanties_Rev.Filter    ( )

	Dw_Garanties_Rev.SetSort ( "id_gti A" )
	Dw_Garanties_Rev.Sort    ( )


	Dw_Ets_Rev.SetFilter				(	sFiltre				)
	Dw_Ets_Rev.Filter					(							)

	Dw_Ets_Rev.SetSort				( "ID_GRP A" )
	Dw_Ets_Rev.Sort					( )

End If

end event

on constructor;call u_datawindow::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_revision
//* Evenement 		: constructor
//* Auteur			: YP
//* Date				: 15/09/97 10:43:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise le RowFocusIndicateur.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.Uf_Indicator ( p_1 )
end on

type dw_garanties_rev from u_datawindow within w_dc_spb_produits
boolean visible = false
integer x = 329
integer y = 1436
integer width = 201
integer height = 144
integer taborder = 100
boolean bringtotop = true
boolean vscrollbar = true
end type

on doubleclicked;call u_datawindow::doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_garanties
//* Evenement 		: doubleclicked
//* Auteur			: YP
//* Date				: 18/02/97 14:27:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: d$$HEX1$$e900$$ENDHEX$$clenche ue_modifier qui g$$HEX1$$e800$$ENDHEX$$re l'ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de 
//*						consultation de la garantie s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$pour la r$$HEX1$$e900$$ENDHEX$$vision s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iUdwCourante = This
Parent.TriggerEvent ( "ue_modifier" )
end on

on constructor;call u_datawindow::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_garanties
//* Evenement 		: constructor
//* Auteur			: YP
//* Date				: 20/02/97 10:43:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise le RowFocusIndicateur.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.Uf_Indicator ( p_1 )
end on

