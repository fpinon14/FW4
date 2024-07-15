HA$PBExportHeader$w_dc_spb_revisions.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre de consultation d'une r$$HEX1$$e900$$ENDHEX$$vision d'un produit.
forward
global type w_dc_spb_revisions from w_8_ancetre_consultation
end type
type dw_1 from u_datawindow within w_dc_spb_revisions
end type
end forward

global type w_dc_spb_revisions from w_8_ancetre_consultation
int X=1
int Y=1
int Width=2149
int Height=981
boolean TitleBar=true
string Title="Fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des r$$HEX1$$e900$$ENDHEX$$visions"
boolean ControlMenu=false
event ue_debut_initialiser pbm_custom01
dw_1 dw_1
end type
global w_dc_spb_revisions w_dc_spb_revisions

type variables
String		isDw1 = ""
end variables

forward prototypes
public function boolean wf_preparerconsulter ()
end prototypes

public function boolean wf_preparerconsulter ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerConsulter
//* Auteur			: YP
//* Date				: 16/09/1997 11:22:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise la r$$HEX1$$e900$$ENDHEX$$vision consult$$HEX1$$e900$$ENDHEX$$e.
//* Commentaires	: 
//*
//* Arguments		: Aucun.
//*
//* Retourne		: boolean 	TRUE  : OK
//*
//*-----------------------------------------------------------------
Long									lNumLig		//No de ligne $$HEX2$$e0002000$$ENDHEX$$visualiser
w_dc_spb_produits					wTemp			//Fen$$HEX1$$ea00$$ENDHEX$$tre appelante.


lNumLig = Long ( istPass.sTab[ 1 ] )

wTemp = iwParent

wTemp.dw_Revision.ShareData ( Dw_1 )

Dw_1.ScrollToRow ( lNumLig )

Return ( TRUE )
end function

on ue_retour;call w_8_ancetre_consultation::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet			:	w_dc_spb_revisions
//* Evenement 		:	Ue_Retour
//* Auteur			:	YP
//* Date				:	19/09/1997 15:25:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ferme la fen$$HEX1$$ea00$$ENDHEX$$tre de consultation des paragraphes.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------

If IsValid ( W_Consulter_Paragraphe ) Then Close ( W_Consulter_Paragraphe )
end on

on ue_initialiser;call w_8_ancetre_consultation::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_dc_spb_revisions
//* Evenement 		: ue_initialiser
//* Auteur			: YP
//* Date				: 16/09/97 11:23:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialise la datawindow dw_1.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
Long				lNbCol			// Nombre de colonnes de la DW.
Long				lCptCol			// Compteur de colonnes accessibles.
Long				lCpt				// Indice de boucle.

String			sColRev[]		// liste des colonnes accessibles.
String			sMod				// Chaine de modification de DW.
String			sEditStyle		// Style du champ.

/*----------------------------------------------------------------------------*/
/* Permet dans les descendants d'initialiser la vairable isDw1 contenant la   */
/* DataObject.                                                                */
/*----------------------------------------------------------------------------*/
TriggerEvent ( "Ue_Debut_Initialiser" )


DW_1.DataObject	= isDw1

Dw_1.Uf_SetTransObject ( iTrTrans )


/*----------------------------------------------------------------------------*/
/* PROTECTION DES ZONES DE PRODUITS                                           */
/*----------------------------------------------------------------------------*/
lNbCol 	= Long ( Dw_1.Describe ( "datawindow.column.count" ) )

sMod		= ""
lCptCol	= 0

If lNbCol > 0 Then

	For lCpt = lnbCol to 1 step -1

		sEditStyle	= Dw_1.Describe ( "#" + String ( lCpt ) + ".edit.style" )

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
			sColRev	[ lCptCol ] = "#" + String ( lCpt )

		End If

	Next

	Dw_1.Uf_Modify ( sMod )

	Dw_1.Uf_InitialiserCouleur ( sColRev )

	Dw_1.Uf_proteger ( sColRev , "1" )

End If
end on

on w_dc_spb_revisions.create
int iCurrent
call w_8_ancetre_consultation::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
end on

on w_dc_spb_revisions.destroy
call w_8_ancetre_consultation::destroy
destroy(this.dw_1)
end on

type st_titre from w_8_ancetre_consultation`st_titre within w_dc_spb_revisions
boolean Visible=false
end type

type pb_retour from w_8_ancetre_consultation`pb_retour within w_dc_spb_revisions
int Y=41
end type

type dw_1 from u_datawindow within w_dc_spb_revisions
int X=19
int Y=193
int Width=2103
int Height=697
int TabOrder=10
boolean Border=false
end type

