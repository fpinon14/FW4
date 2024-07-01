HA$PBExportHeader$w_trt_corb_oper.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour la gestion des Corbeilles/Op$$HEX1$$e900$$ENDHEX$$rateurs (W_TRT_CORB_OPER)
forward
global type w_trt_corb_oper from w_traitement
end type
type dw_acc from u_datawindow_accueil within w_trt_corb_oper
end type
type dw_operateur from datawindow within w_trt_corb_oper
end type
type dw_produit from datawindow within w_trt_corb_oper
end type
type dw_2 from datawindow within w_trt_corb_oper
end type
end forward

global type w_trt_corb_oper from w_traitement
int X=1
int Y=1
int Width=3589
int Height=1745
boolean TitleBar=true
string Title="Assignation des Op$$HEX1$$e900$$ENDHEX$$rateurs/Corbeilles"
dw_acc dw_acc
dw_operateur dw_operateur
dw_produit dw_produit
dw_2 dw_2
end type
global w_trt_corb_oper w_trt_corb_oper

type variables
Private :
    u_Gs_Corb_Oper          iuoCorb
end variables

on we_childactivate;call w_traitement::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Trt_Corb_Oper::We_ChildActivate
//* Evenement 		: We_ChildActivate
//* Auteur			: Erick John Stark
//* Date				: 04/12/1997 09:06:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Si on d$$HEX1$$e900$$ENDHEX$$place la fen$$HEX1$$ea00$$ENDHEX$$tre, elle revient au m$$HEX1$$ea00$$ENDHEX$$me endroit. 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//

This.X			=    1
This.Y			=    1
This.Height		= 1745
This.Width		= 3590
end on

on ue_initialiser;call w_traitement::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Trt_Corb_Oper::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 10/09/1997 15:00:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des NVUO
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lWidth

iuoCorb = Create u_Gs_Corb_Oper

dw_1.Uf_SetTransObject ( itrTrans )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la taille de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil en pixels. Si      */
/* cette valeur est inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$800, on peut imaginer que l'on     */
/* travaille en 800x600. On va donc retailler les boutons et        */
/* positionner une police ad$$HEX1$$e900$$ENDHEX$$quate.                                 */
/*------------------------------------------------------------------*/

lWidth = istPass.lTab[1]

If	lWidth <= 800 Then
	pb_Retour.PictureName	= "K:\PB4OBJ\BMP\8_QUIT.BMP"
	pb_Retour.TextSize		= -7
	pb_Retour.FaceName		= "Arial"

	pb_Valider.PictureName	= "K:\PB4OBJ\BMP\8_VALID.BMP"
	pb_Valider.TextSize		= -7
	pb_Valider.FaceName		= "Arial"
End If

/*------------------------------------------------------------------*/
/* Dans le futur, il ne restera plus qu'a dimensionner              */
/* correctement les deux DataWindows. Pour le moment, il faut les   */
/* laisser avec une taille de 800x600.                              */
/*------------------------------------------------------------------*/

iuoCorb.Uf_Initialisation ( itrTrans, dw_Acc, dw_Operateur, dw_Produit, dw_1, dw_2 )




end on

on close;call w_traitement::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Trt_Corb_Oper::Close
//* Evenement 		: Close
//* Auteur			: Erick John Stark
//* Date				: 10/09/1997 15:04:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Destruction des NVUO instanci$$HEX1$$e900$$ENDHEX$$s dans Ue_Initialiser
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Destroy iuoCorb


end on

on w_trt_corb_oper.create
int iCurrent
call w_traitement::create
this.dw_acc=create dw_acc
this.dw_operateur=create dw_operateur
this.dw_produit=create dw_produit
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_acc
this.Control[iCurrent+2]=dw_operateur
this.Control[iCurrent+3]=dw_produit
this.Control[iCurrent+4]=dw_2
end on

on w_trt_corb_oper.destroy
call w_traitement::destroy
destroy(this.dw_acc)
destroy(this.dw_operateur)
destroy(this.dw_produit)
destroy(this.dw_2)
end on

type dw_1 from w_traitement`dw_1 within w_trt_corb_oper
int X=2378
int Y=13
int Width=348
int Height=149
int TabOrder=0
boolean Visible=false
boolean Enabled=false
string DataObject="d_operateur_corbeille_gup"
end type

type st_titre from w_traitement`st_titre within w_trt_corb_oper
int X=2762
int Y=13
int Width=535
boolean Visible=false
end type

type pb_retour from w_traitement`pb_retour within w_trt_corb_oper
int X=14
int Y=13
int TabOrder=30
end type

on pb_retour::clicked;call w_traitement`pb_retour::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Trt_Corb_Oper::Pb_Retour::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 26/09/1997 17:36:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iwParent.TriggerEvent ( "Ue_MajAccueil" )
end on

type pb_valider from w_traitement`pb_valider within w_trt_corb_oper
int X=293
int Y=13
end type

on pb_valider::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_traitement::pb_valider::Clicked (OverRide)
//* Evenement 		: Clicked (Override)
//* Auteur			: Erick John Stark
//* Date				: 25/09/1997 16:47:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Lancement de la validation des op$$HEX1$$e900$$ENDHEX$$rateurs
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	iuocorb.Uf_Valider_Operateur () Then

	pb_Retour.TriggerEvent ( Clicked! )

End If


end on

type pb_imprimer from w_traitement`pb_imprimer within w_trt_corb_oper
int X=2058
int Y=17
int TabOrder=0
boolean Visible=false
boolean Enabled=false
string DisabledName=""
end type

type pb_controler from w_traitement`pb_controler within w_trt_corb_oper
int X=1445
int Y=17
int TabOrder=0
boolean Visible=false
boolean Enabled=false
end type

type pb_supprimer from w_traitement`pb_supprimer within w_trt_corb_oper
int X=1751
int Y=17
int TabOrder=0
boolean Visible=false
boolean Enabled=false
end type

type dw_acc from u_datawindow_accueil within w_trt_corb_oper
int X=14
int Y=173
int Width=2190
int Height=1465
boolean VScrollBar=true
end type

on rowfocuschanged;call u_datawindow_accueil::rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_acc::RowFocusChanged
//* Evenement 		: RowFocusChanged
//* Auteur			: Erick John Stark
//* Date				: 11/09/1997 15:09:36
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On filtre les corbeilles en fonction du code op$$HEX1$$e900$$ENDHEX$$rateur courant
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


iuoCorb.Uf_Filtrer_Corbeille ( This.IlLigneClick )


end on

on ue_modifiermenu;call u_datawindow_accueil::ue_modifiermenu;




uf_Mnu_InterdirItem ( 1 )
uf_Mnu_InterdirItem ( 2 )
uf_Mnu_InterdirItem ( 3 )
uf_Mnu_InterdirItem ( 5 )
end on

type dw_operateur from datawindow within w_trt_corb_oper
int X=2771
int Y=13
int Width=348
int Height=149
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
boolean LiveScroll=true
end type

type dw_produit from datawindow within w_trt_corb_oper
int X=3182
int Y=13
int Width=348
int Height=149
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
boolean LiveScroll=true
end type

type dw_2 from datawindow within w_trt_corb_oper
int X=2259
int Y=173
int Width=1294
int Height=1465
int TabOrder=20
boolean BringToTop=true
string DataObject="d_operateur_corbeille_txt"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_2::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 11/09/1997 11:36:53
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Positionnement des lignes
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sText, sBand, sAltReclame, sIdCorb, sIdCorbLu
Long lPos, lLig, lTot, lCpt
DateTime dtMaintenant

/*------------------------------------------------------------------*/
/* On veut positionner la zone ALT_RECLAME $$HEX2$$e0002000$$ENDHEX$$Oui ou Non (Gestion    */
/* d'une bascule). Il y a un probl$$HEX1$$e800$$ENDHEX$$me avec PB car on ne peut pas    */
/* mettre un TabOrder sur une zone dans un Header. Je regarde si    */
/* la personne vient de clicker dans l'ent$$HEX1$$ea00$$ENDHEX$$te 1 (correspondant au   */
/* Groupe 1). (ID_CORB). Si oui, je r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le N$$HEX2$$b0002000$$ENDHEX$$de ligne et je   */
/* regarde la valeur actuelle de ALT_RECLAME.                       */
/* Ensuite je fais une boucle pour positionner tous les produits    */
/* qui correspondent $$HEX2$$e0002000$$ENDHEX$$cette corbeille. Si la corbeille lu est      */
/* diff$$HEX1$$e900$$ENDHEX$$rente de celle ou je viens de clicker je m'arr$$HEX1$$ea00$$ENDHEX$$te.          */
/*------------------------------------------------------------------*/

sText = This.GetBandAtPointer ()

If	sText <> "" Then
	lPos	= Pos ( sText, "~t" )
	sBand	= Upper ( Left ( sText, lPos - 1 ) )

	If	sBand = "HEADER.1" Then
		lLig 			= Long ( Mid ( sText, lPos + 1 ) )
		
		sAltReclame = This.GetItemString ( lLig, "ALT_RECLAME" )

/*------------------------------------------------------------------*/
/* Il faut positionner la valeur contraire de celle qui est lue.    */
/*------------------------------------------------------------------*/

		If	sAltReclame = "O" Then
			sAltReclame = "N"
		Else
			sAltReclame = "O"
		End If

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le code corbeille, on positionne la valeur de        */
/* ALT_RECLAME sur la 1$$HEX1$$e800$$ENDHEX$$re ligne.                                   */
/*------------------------------------------------------------------*/

		sIdCorb			= This.GetItemString ( lLig, "ID_CORB" )
		lTot				= This.RowCount ()
		dtMaintenant	= DateTime ( Today (), Now () )

/*------------------------------------------------------------------*/
/* On met $$HEX2$$e0002000$$ENDHEX$$jour la DataWindow d'accueil pour suivre l'$$HEX1$$e900$$ENDHEX$$volution    */
/* des mises $$HEX2$$e0002000$$ENDHEX$$jour.                                                */
/*------------------------------------------------------------------*/
		lPos = dw_Acc.SetItem ( dw_Acc.ilLigneClick, "MAJ_LE", dtMaintenant )
		dw_Acc.SetItem ( dw_Acc.ilLigneClick, "MAJ_PAR", stGLB.sCodOper )
		
		For	lCpt = lLig To lTot
				sIdCorbLu = This.GetItemString ( lCpt, "ID_CORB" )
				If	sIdCorb = sIdCorbLu Then

/*------------------------------------------------------------------*/
/* On met $$HEX2$$e0002000$$ENDHEX$$jour la bascule sur ALT_RECLAME, ainsi que les zones    */
/* MAJ_LE et MAJ_PAR de la DataWindow de stockage.                  */
/*------------------------------------------------------------------*/
					This.SetItem ( lCpt, "MAJ_LE", dtMaintenant )
					This.SetItem ( lCpt, "MAJ_PAR", stGLB.sCodOper )
					This.SetItem ( lCpt, "ALT_RECLAME", sAltReclame )
				Else
					Exit
				End If
		Next
	End If
End If


end on

