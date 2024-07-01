HA$PBExportHeader$u_spb_ajout_courtyp.sru
$PBExportComments$-} User Object de d$$HEX1$$e900$$ENDHEX$$finition des paragraphes d'un Courrier Type : permet de gerer le positionnement de Bmp.
forward
global type u_spb_ajout_courtyp from u_ajout
end type
end forward

global type u_spb_ajout_courtyp from u_ajout
integer width = 1513
integer height = 1244
event ue_click_plus pbm_custom63
end type
global u_spb_ajout_courtyp u_spb_ajout_courtyp

type variables
Boolean	ibScrollBarVisible 		        // Indique si la scrollbar verticale est visible.
Long       ilNbRecordMaxi    	       = 7	        // Nbre de record maxi affichable dans dw_source.

Integer	iiPosPlusOrigine
Integer	iiPosMoinsOrigine

end variables

forward prototypes
public subroutine uf_decaleragauche ()
public subroutine uf_decaleradroite ()
public subroutine uf_placerlesboutons ()
end prototypes

public subroutine uf_decaleragauche ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_DecalerAGauche
//* Auteur			: Y. Picard
//* Date				: 22/01/97 18:04:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$place les boutons + et - selon l'apparition de la
//*                 ScrollBar Verticale.
//* Commentaires	: Attention, ilNbRecordMaxi est initialis$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$sa d$$HEX1$$e900$$ENDHEX$$claration.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer 	iNewPosPlus				// Nouvelle position du bitmap PLUS
Integer 	iNewPosMoins			// Nouvelle position du bitmap MOINS
String   sMod	               // Chaine de modification de la datawindow source


/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re les coordoon$$HEX1$$e900$$ENDHEX$$es X des bitmap PLUS et MOINS.          */
/* Puis on d$$HEX1$$e900$$ENDHEX$$place les bitmaps vers la gauche de 15 unit$$HEX1$$e900$$ENDHEX$$s.         */
/*------------------------------------------------------------------*/

iNewPosPlus  			= Integer ( Dw_Source.Describe ( "b_plus.X"  ) )  - 15
iNewPosMoins 			= Integer ( Dw_Source.Describe ( "b_moins.X" ) )  - 15

sMod	 					= "b_plus.X='" 	+ String ( iNewPosPlus  ) + "' "
sMod						= sMod	      	+ &
							  "b_moins.X='" 	+ String ( iNewPosMoins ) + "'"

Uf_Modify ( Dw_Source , sMod )
end subroutine

public subroutine uf_decaleradroite ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_DecalerADroite
//* Auteur			: Y. Picard
//* Date				: 22/01/97 18:16:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$place les boutons + et - selon l'apparition de la
//*                 ScrollBar Verticale.
//* Commentaires	: Attention, ilNbRecordMaxi est initialis$$HEX4$$e9002000e0002000$$ENDHEX$$sa d$$HEX1$$e900$$ENDHEX$$claration.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer 	iNewPosPlus				// Nouvelle position du bitmap PLUS
Integer 	iNewPosMoins			// Nouvelle position du bitmap MOINS
String   sMod 		            // Chaine de modification de la datawindow source

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re les coordoon$$HEX1$$e900$$ENDHEX$$es X des bitmap PLUS et MOINS.          */
/* Puis on d$$HEX1$$e900$$ENDHEX$$place les bitmaps vers la droite.                      */
/*------------------------------------------------------------------*/

iNewPosPlus  			= Integer ( Dw_Source.Describe ( "b_plus.X"  ) )  + 15
iNewPosMoins 			= Integer ( Dw_Source.Describe ( "b_moins.X" ) )  + 15

sMod	 					= "b_plus.X='"  + String ( iNewPosPlus )  + "' "
sMod						= sMod	       + &
					  		  "b_moins.X='" + String ( iNewPosMoins ) + "'"

Uf_Modify ( Dw_Source , sMod )


end subroutine

public subroutine uf_placerlesboutons ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PlacerLesBoutons
//* Auteur			: Y. Picard
//* Date				: 05/05/97 14:06:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: G$$HEX1$$e800$$ENDHEX$$re la position des boutons PLUS et MOINS selon le nombre de records.
//* Commentaires	: 
//*
//* Arguments		: aucun
//*
//* Retourne		: rien
//*					
//*
//*-----------------------------------------------------------------

If ibScrollBarVisible And Dw_Source.RowCount ( ) <= ilNbRecordMaxi Then

	Uf_DecalerADroite ( )
	ibScrollBarVisible = FALSE

ElseIf not ibScrollBarVisible And Dw_Source.RowCount ( ) > ilNbRecordMaxi Then

	Uf_DecalerAGauche ( )
	ibScrollBarVisible = TRUE

End If
end subroutine

on u_spb_ajout_courtyp.create
call super::create
end on

on u_spb_ajout_courtyp.destroy
call super::destroy
end on

type p_indicateur from u_ajout`p_indicateur within u_spb_ajout_courtyp
end type

type pb_enlever_tout from u_ajout`pb_enlever_tout within u_spb_ajout_courtyp
end type

type pb_enlever_1 from u_ajout`pb_enlever_1 within u_spb_ajout_courtyp
end type

event pb_enlever_1::clicked;call super::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: u_ajout::pb_enlever_1
//* Evenement 		: clicked
//* Auteur			: Y. Picard
//* Date				: 22/01/97 10:05:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$place les boutons + et - selon l'apparition de la
//*                 ScrollBar Verticale.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*-----------------------------------------------------------------

Uf_PlacerLesBoutons ( )



end event

type pb_ajouter_tout from u_ajout`pb_ajouter_tout within u_spb_ajout_courtyp
end type

type pb_ajouter_1 from u_ajout`pb_ajouter_1 within u_spb_ajout_courtyp
end type

event pb_ajouter_1::clicked;call super::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: u_ajout::pb_ajouter_1
//* Evenement 		: clicked
//* Auteur			: Y. Picard
//* Date				: 22/01/97 10:05:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$place les boutons + et - selon l'apparition de la
//*                 ScrollBar Verticale.
//* Commentaires	: 
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//*-----------------------------------------------------------------

Uf_PlacerLesBoutons ( )



end event

type dw_cible from u_ajout`dw_cible within u_spb_ajout_courtyp
end type

type st_titre from u_ajout`st_titre within u_spb_ajout_courtyp
end type

type dw_recherche from u_ajout`dw_recherche within u_spb_ajout_courtyp
end type

type dw_source from u_ajout`dw_source within u_spb_ajout_courtyp
event ue_postclicked pbm_custom01
integer x = 882
end type

on dw_source::ue_postclicked;call u_ajout`dw_source::ue_postclicked;//*-----------------------------------------------------------------
//*
//* Objet 			: u_ajout::dw_source
//* Evenement 		: ue_postClicked      
//* Auteur			: Y. Picard
//* Date				: 22/01/97 15:31:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: G$$HEX1$$e800$$ENDHEX$$re la modification de l'ordre des pararaphes dans la liste.
//*                 Cet EVENT est d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$par PostEvent() dans l'EVENT clicked.
//*
//* Commentaires	: ATTENTION : On ne g$$HEX1$$e800$$ENDHEX$$re pas ici le No d'ordre (ID_ORDRE) du
//*                 paragraphe dans la composition, ceci est fait dans wf_PreparerValider()
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* PLJ		02/02/1999  #1 Probl$$HEX1$$e800$$ENDHEX$$me de d$$HEX1$$e900$$ENDHEX$$filement dans le tri
//*							Il n'y a pas de repositionnement sur la ligne d$$HEX1$$e900$$ENDHEX$$plac$$HEX1$$e900$$ENDHEX$$e
//*				  
//*-----------------------------------------------------------------

String		sObjetclique				//Objet de la datawindow qui a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$cliqu$$HEX1$$e900$$ENDHEX$$
Long			lLigneClique				//No de la ligne cliqu$$HEX1$$e900$$ENDHEX$$e


/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'objet que l'on vient de cliquer                    */
/*------------------------------------------------------------------*/

This.SetRedraw ( False )			// PLJ #1

sObjetClique = GetObjectAtPointer ()

lLigneClique = This.GetRow ()

/*------------------------------------------------------------------*/
/* Declenchement Event pour perso sur click plus ou moins	        */
/*------------------------------------------------------------------*/

Parent.TriggerEvent ( "ue_click_plus" )

/*------------------------------------------------------------------*/
/* Si on clique le bouton + on remonte le record d'une ligne.       */
/*------------------------------------------------------------------*/

If Pos ( sObjetClique , "b_plus" ) > 0 then

	If lLigneClique > 1 then

		/*------------------------------------------------------------------*/
		/* On supprime la ligne, on la r$$HEX1$$e900$$ENDHEX$$ins$$HEX1$$e800$$ENDHEX$$re avant la ligne la pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dant */
		/* initialement, puis on la rend courante et s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e           */
		/*------------------------------------------------------------------*/


		This.RowsMove  ( lLigneClique, lLigneClique, PRIMARY!, This, 999999          ,&
							  DELETE!)

		This.RowsMove  ( This.DeletedCount( ), This.DeletedCount ( ), DELETE! , This, lLigneClique - 1,&
							  PRIMARY! )



		This.SetRow    ( lLigneClique - 1 )		

		This.SelectRow ( 0                , False )

		This.SelectRow ( lLigneClique - 1 , True )

		This.ScrollToRow	( lLigneClique - 1	)			// PLJ #1  

	End If

/*------------------------------------------------------------------*/
/* Si on clique le bouton - on descend le record d'une ligne.       */
/*------------------------------------------------------------------*/

ElseIf Pos ( sObjetClique , "b_moins" ) > 0 then

	If lLigneClique < This.RowCount () then

		/*------------------------------------------------------------------*/
		/* On supprime la ligne, on la r$$HEX1$$e900$$ENDHEX$$ins$$HEX1$$e800$$ENDHEX$$re apr$$HEX1$$e800$$ENDHEX$$s la ligne la suivant   */
		/* initialement, puis on la rend courante et s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e           */
		/*------------------------------------------------------------------*/


 		This.RowsMove  ( lLigneClique, lLigneClique, PRIMARY!, This, 999999          ,& 
							  DELETE!)

		This.RowsMove  ( This.DeletedCount( ), This.DeletedCount ( ), DELETE! , This, lLigneClique + 1,&
							  PRIMARY! )



		This.SetRow		( lLigneClique + 1 )

		This.SelectRow ( 0                , False )

		This.SelectRow ( lLigneClique + 1 , True )		

		This.ScrollToRow	( lLigneClique + 1	)			// PLJ #1  

	End If

End If


This.SetRedraw ( True )		// PLJ #1
end on

on dw_source::retrieveend;call u_ajout`dw_source::retrieveend;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_source
//* Evenement 		: retrievend
//* Auteur			: Y. Picard
//* Date				: 22/01/97 10:05:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$place les boutons + et - selon l'apparition de la
//*                 ScrollBar Verticale.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Uf_PlacerLesBoutons ( )

end on

event dw_source::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: u_ajout::dw_source
//* Evenement 		: clicked - OVERRIDE
//* Auteur			: Y. Picard
//* Date				: 23/01/97 11:59:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: d$$HEX1$$e900$$ENDHEX$$clenche le traitement de la modification de l'ordre des
//*                 paragraphes.
//*
//* Commentaires	: ce traitement est 'Post$$HEX1$$e900$$ENDHEX$$' car ex$$HEX1$$e900$$ENDHEX$$cut$$HEX2$$e9002000$$ENDHEX$$dans le pr$$HEX1$$e900$$ENDHEX$$sent $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement
//*                 des effets ind$$HEX1$$e900$$ENDHEX$$sirables se feraient sentir, d$$HEX1$$fb00$$ENDHEX$$s au fait que la ligne
//*                 cliqu$$HEX1$$e900$$ENDHEX$$e n'est pas encore courante et que l'on d$$HEX1$$e900$$ENDHEX$$clenche des RowsMove
//*                 qui modifient la num$$HEX1$$e900$$ENDHEX$$rotation des lignes dans le Set.
//*
//*                 De plus, si on d$$HEX1$$e900$$ENDHEX$$clenche le traitement de la modification de l'ordre
//*                 on ne d$$HEX1$$e900$$ENDHEX$$clenche pas le traitement du cliqu$$HEX1$$e900$$ENDHEX$$.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sObjetclique				//Objet de la datawindow qui a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$cliqu$$HEX1$$e900$$ENDHEX$$


/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'objet que l'on vient de cliquer                    */
/*------------------------------------------------------------------*/

sObjetClique = GetObjectAtPointer ()


/*------------------------------------------------------------------*/
/* Si on clique le bouton + ou - on d$$HEX1$$e900$$ENDHEX$$clenche le traitement de la   */
/* modification de l'ordre des paragraphes, sinon on laisse le      */
/* traitement par d$$HEX1$$e900$$ENDHEX$$faut s'ex$$HEX1$$e900$$ENDHEX$$cuter                                 */
/*------------------------------------------------------------------*/

If Pos ( sObjetClique , "b_plus"  ) > 0 or &
   Pos ( sObjetClique , "b_moins" ) > 0 then

	PostEvent ( "Ue_PostClicked" )

Else

	Call Super::Clicked
	
End If
end event

type r_bord from u_ajout`r_bord within u_spb_ajout_courtyp
end type

type ln_gauche from u_ajout`ln_gauche within u_spb_ajout_courtyp
end type

type ln_bas from u_ajout`ln_bas within u_spb_ajout_courtyp
end type

