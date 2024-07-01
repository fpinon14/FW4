HA$PBExportHeader$w_dc_spb_courtype.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d$$HEX1$$e900$$ENDHEX$$tail de consultation des courriers type.
forward
global type w_dc_spb_courtype from w_8_ancetre_consultation
end type
type uo_onglets from u_onglets within w_dc_spb_courtype
end type
type uo_bord3d from u_bord3d within w_dc_spb_courtype
end type
type dw_courtype from u_datawindow within w_dc_spb_courtype
end type
type uo_compo from u_spb_ajout_courtyp within w_dc_spb_courtype
end type
end forward

global type w_dc_spb_courtype from w_8_ancetre_consultation
integer x = 0
integer y = 0
integer width = 3168
integer height = 1332
string title = "Consultation d~'un courrier type"
boolean controlmenu = false
uo_onglets uo_onglets
uo_bord3d uo_bord3d
dw_courtype dw_courtype
uo_compo uo_compo
end type
global w_dc_spb_courtype w_dc_spb_courtype

forward prototypes
public function boolean wf_preparerconsulter ()
end prototypes

public function boolean wf_preparerconsulter ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_PreparerConsulter
//* Auteur			:	YP
//* Date				:	23/09/1997 11:27:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant consultation
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La consultation peut continuer
//*									
//*-----------------------------------------------------------------
String   sCol [ 3 ]		// Champ $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger contre la saisie


/*------------------------------------------------------------------*/
/* Rend inaccessible en saisie le Code Courrier Type                */
/*------------------------------------------------------------------*/
sCol [ 1 ] = "ID_COUR"
sCol [ 2 ] = "LIB_COUR"
sCol [ 3 ] = "LIB_MODELE"

Dw_CourType.Uf_Proteger ( sCol, "1" )

/*------------------------------------------------------------------*/
/* Positionnement sur l'onglet des courriers types.                 */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_ChangerOnglet ( "01" )

/*------------------------------------------------------------------*/
/* Initialisation li$$HEX1$$e900$$ENDHEX$$e aux colonnes.                                */
/*------------------------------------------------------------------*/
If Dw_CourType.Retrieve  ( istPass.sTab[1] ) <= 0 Then Return ( False )


/*------------------------------------------------------------------*/
/* Permet de populiser les informations dans  Dw Recherche.         */
/*------------------------------------------------------------------*/
Uo_Compo.Uf_dwRechercheRetrieve ( Dw_CourType.GetItemString ( 1 , "ID_COUR" ) , uo_Compo )

/*------------------------------------------------------------------*/
/* Populise les informations dans DwSource.                         */
/*------------------------------------------------------------------*/
Uo_Compo.Uf_dwSourceRetrieve ( Dw_CourType.GetItemString ( 1 , "ID_COUR" ), uo_Compo )

/*------------------------------------------------------------------*/
/* Ajout du tri sur le No d'ordre des paragraphes dans une          */
/* composition                                                      */
/*------------------------------------------------------------------*/
Uo_Compo.Dw_Source.SetSort ( "ID_ORDRE A" )
Uo_Compo.Dw_Source.Sort    ( )

/*------------------------------------------------------------------*/
/* Renseigne DwCible avec les informations de DwRecherche.          */
/*------------------------------------------------------------------*/
Uo_Compo.Dw_Recherche.RowsCopy	( 1 , 	Uo_Compo.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    		Uo_Compo.Dw_Cible , 1 , PRIMARY!  )


/*------------------------------------------------------------------*/
/* Tri les paragraphes non affect$$HEX1$$e900$$ENDHEX$$s.                                */
/*------------------------------------------------------------------*/
Uo_Compo.Dw_Cible.SetSort ( "ID_PARA A" )
Uo_Compo.Dw_Cible.Sort    ( )

/*------------------------------------------------------------------*/
/* On refait la s$$HEX1$$e900$$ENDHEX$$lection par d$$HEX1$$e900$$ENDHEX$$faut de la premi$$HEX1$$e800$$ENDHEX$$re ligne car avec  */
/* le Sort la premi$$HEX1$$e800$$ENDHEX$$re ligne n'est plus obligatoirement la m$$HEX1$$ea00$$ENDHEX$$me et  */
/* l'anc$$HEX1$$ea00$$ENDHEX$$tre l'a s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e d'office.                             */
/*------------------------------------------------------------------*/
Uo_Compo.Dw_Cible.SelectRow ( 0 , False )
Uo_Compo.Dw_Cible.SelectRow ( 1 , True  )


Return ( True )
end function

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_dc_spb_courtype
//* Evenement 		:	ue_initialiser
//* Auteur			:	YP
//* Date				:	23/09/97 11:23:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des 
//*					 	Courriers type
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JCA	18/05/2007	DCMP 070051 - Modification du titre de l'onglet de courrier type
//*-----------------------------------------------------------------
String	sMod				// Chaine de modification de DW.
String	sCol [ 3 ]		// Tableau contenant les champs dont 
								// l'attribut 'protect' peut $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$.

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/
sCol[1] 			= "ID_COUR"
sCol[2]			= "LIB_COUR"
sCol[3]			= "LIB_MODELE"

Dw_CourType.Uf_InitialiserCouleur ( sCol )

Dw_CourType.Uf_SetTransObject ( itrTrans )


/*------------------------------------------------------------------*/
/* Initialisation de l'onglet                                       */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_Initialiser ( 2, 1 )

// #1
Uo_Onglets.Uf_EnregistrerOnglet ( "01", "Courrier Type", "" , dw_CourType,	False  )
//Uo_Onglets.Uf_EnregistrerOnglet ( "01", "Biblioth$$HEX1$$e800$$ENDHEX$$que de courriers type", "" , dw_CourType,	False  )
// Taille de l'onglet trop court :/
// #1 - FIN

Uo_Onglets.Uf_EnregistrerOnglet ( "02", "Composition"  , "" , Uo_Compo,		False  )

/*----------------------------------------------------------------------------*/
/* Affection des Dataobjet aux Dw de l'objet : recherche, source, cible.      */
/*----------------------------------------------------------------------------*/
Uo_Compo.Uf_Initialiser ( "d_spb_lst_para_rch", "d_spb_compo_para", "d_spb_lst_para", itrTrans )

/*----------------------------------------------------------------------------*/
/* On fait disparaitre les bitmaps de r$$HEX1$$e900$$ENDHEX$$ordonnancement des paragraphes.       */
/*----------------------------------------------------------------------------*/
sMod = "b_plus.visible=0 b_moins.visible=0"
Uo_Compo.Uf_Modify ( Uo_Compo.Dw_Source , sMod )
end event

on w_dc_spb_courtype.create
int iCurrent
call super::create
this.uo_onglets=create uo_onglets
this.uo_bord3d=create uo_bord3d
this.dw_courtype=create dw_courtype
this.uo_compo=create uo_compo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_onglets
this.Control[iCurrent+2]=this.uo_bord3d
this.Control[iCurrent+3]=this.dw_courtype
this.Control[iCurrent+4]=this.uo_compo
end on

on w_dc_spb_courtype.destroy
call super::destroy
destroy(this.uo_onglets)
destroy(this.uo_bord3d)
destroy(this.dw_courtype)
destroy(this.uo_compo)
end on

on close;call w_8_ancetre_consultation::close;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_dc_spb_courtype
//* Evenement 		:	Close
//* Auteur			:	YP
//* Date				:	23/09/1997 11:20:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Ferme la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des courriers si elle est      */
/* ouverte et cach$$HEX1$$e900$$ENDHEX$$e.                                               */
/*------------------------------------------------------------------*/
If IsValid ( W_Consulter_Courrier )	Then

	Close ( W_Consulter_Courrier )

End If

end on

on ue_retour;call w_8_ancetre_consultation::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_dc_spb_courtype
//* Evenement 		:	Ue_retour
//* Auteur			:	YP
//* Date				:	23/09/1997 11:21:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Ferme la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des courriers si elle est      */
/* ouverte et cach$$HEX1$$e900$$ENDHEX$$e.                                               */
/*------------------------------------------------------------------*/
If IsValid ( W_Consulter_Courrier )	Then

	Close ( W_Consulter_Courrier )

End If



end on

type st_titre from w_8_ancetre_consultation`st_titre within w_dc_spb_courtype
boolean visible = false
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_dc_spb_courtype
integer x = 27
integer y = 20
integer taborder = 50
end type

type uo_onglets from u_onglets within w_dc_spb_courtype
integer x = 27
integer y = 196
integer width = 987
integer height = 108
integer taborder = 20
boolean border = false
end type

type uo_bord3d from u_bord3d within w_dc_spb_courtype
integer x = 37
integer y = 292
integer width = 3081
integer height = 924
integer taborder = 30
boolean bringtotop = true
end type

on uo_bord3d.destroy
call u_bord3d::destroy
end on

type dw_courtype from u_datawindow within w_dc_spb_courtype
integer x = 206
integer y = 452
integer width = 2738
integer height = 600
integer taborder = 10
string dataobject = "d_spb_courtype"
boolean border = false
end type

type uo_compo from u_spb_ajout_courtyp within w_dc_spb_courtype
boolean visible = false
integer x = 37
integer y = 292
integer width = 3081
integer height = 924
integer taborder = 40
boolean bringtotop = true
boolean border = false
end type

on ue_dwsource_rbuttondown;call u_spb_ajout_courtyp::ue_dwsource_rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	Uo_Compo
//* Evenement 		:	ue_DwSource_rbuttondown
//* Auteur			:	YP
//* Date				:	23/09/97 11:18:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de d$$HEX1$$e900$$ENDHEX$$clencher la visualisation du courrier
//*						type d$$HEX1$$e900$$ENDHEX$$fini par cette composition.
//*						si ligne courante il y a et si $$HEX2$$a7002000$$ENDHEX$$il y a
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass		stPass

Long			lnbrPara
Long			lCpt			// Compteur pour le nombre de paragraphe.
Long			lCpt1			// compteur pour le tableau.

stPass.trTrans	=	Parent.itrTrans

lNbrPara = dw_source.Rowcount ()

If lnbrPara > 0	Then

	stPass.sTab [ 1 ]	=	" Courrier " + Dw_CourType.GetItemString ( 1, "ID_COUR" )	
	lCpt1 = 2

	For lCpt = 1	to lNbrPara

		stPass.sTab [ lCpt1 ] = dw_source.GetItemString ( lCpt, "ID_PARA"  )
		lCpt1 ++
		stPass.sTab [ lCpt1 ] = dw_source.GetItemString ( lCpt, "LIB_PARA" )
		lCpt1 ++

	Next

	If	IsValid ( W_Consulter_Courrier )	Then

		W_Consulter_Courrier.Show ()

	Else

		Open ( W_Consulter_Courrier )

	End If

	W_Consulter_Courrier.Wf_AfficherCourrier ( stPass )

End If
end on

on constructor;call u_spb_ajout_courtyp::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			:	uo_compo
//* Evenement 		:	Constructor
//* Auteur			:	YP
//* Date				:	23/09/1997 11:13:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de l'objet
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* L'objet ne poss$$HEX1$$e800$$ENDHEX$$de pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre = False

/*------------------------------------------------------------------*/
/* Utilisation des boutons avec une taille pour des fen$$HEX1$$ea00$$ENDHEX$$tre 800x600 */
/*------------------------------------------------------------------*/
isTaille = '8_'

/*------------------------------------------------------------------*/
/* Pas de s$$HEX1$$e900$$ENDHEX$$lection multiple pour la datawindow source              */
/*------------------------------------------------------------------*/
ibSourceSelMul = False
end on

on ue_dimensionner;call u_spb_ajout_courtyp::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			:	uo_compo
//* Evenement 		:	ue_dimensionner
//* Auteur			:	YP
//* Date				:	23/09/1997 11:13:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Rend invisible les boutons permettant de supprimer ou 
//*					 	d'ajouter tout.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

uo_compo.Pb_enlever_tout.Visible = False
uo_compo.Pb_ajouter_tout.Visible = False

uo_compo.Pb_enlever_1.Visible = False
uo_compo.Pb_ajouter_1.Visible = False
end on

on uo_compo.destroy
call u_spb_ajout_courtyp::destroy
end on

