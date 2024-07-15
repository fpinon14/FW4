HA$PBExportHeader$w_trt_corb_oper_new.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour la gestion des Corbeilles/Op$$HEX1$$e900$$ENDHEX$$rateurs (W_TRT_CORB_OPER)
forward
global type w_trt_corb_oper_new from w_traitement
end type
type u_ajout_corbeille from u_ajout within w_trt_corb_oper_new
end type
type dw_corbtmp from datawindow within w_trt_corb_oper_new
end type
type dw_operappli from datawindow within w_trt_corb_oper_new
end type
type dw_prodcorb from datawindow within w_trt_corb_oper_new
end type
type dw_acc from u_datawindow_accueil within w_trt_corb_oper_new
end type
type cbx_sortie from checkbox within w_trt_corb_oper_new
end type
end forward

global type w_trt_corb_oper_new from w_traitement
integer x = 0
integer y = 0
integer width = 3589
integer height = 1744
string title = "Assignation des Op$$HEX1$$e900$$ENDHEX$$rateurs/Corbeilles (Nouvelle M$$HEX1$$e900$$ENDHEX$$thode)"
u_ajout_corbeille u_ajout_corbeille
dw_corbtmp dw_corbtmp
dw_operappli dw_operappli
dw_prodcorb dw_prodcorb
dw_acc dw_acc
cbx_sortie cbx_sortie
end type
global w_trt_corb_oper_new w_trt_corb_oper_new

type variables
Private :

    N_Cst_Corb_Oper	invCorbOper
end variables

forward prototypes
private subroutine wf_positionnerobjet ()
end prototypes

private subroutine wf_positionnerobjet ();//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Corb_Oper
//* Evenement 		: SPB_PositionnerObjet
//* Auteur			: Erick John Stark
//* Date				: 30/11/1999 11:46:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va positionner les objets
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Liste des op$$HEX1$$e900$$ENDHEX$$rateurs.                                            */
/*------------------------------------------------------------------*/
Dw_Acc.X					=   14
Dw_Acc.Y					=  177
Dw_Acc.Width			= 2154
Dw_Acc.Height			= 1461
/*------------------------------------------------------------------*/
/* U_Ajout sur les corbeilles.                                      */
/*------------------------------------------------------------------*/
U_Ajout_Corbeille.X			= 2177
U_Ajout_Corbeille.Y			=  177
U_Ajout_Corbeille.Width		= 1390
U_Ajout_Corbeille.Height	= 1461

end subroutine

on ue_initialiser;call w_traitement::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Corb_Oper::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 30/11/2002 11:46:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des NVUO
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

invCorbOper	= Create N_Cst_Corb_Oper

dw_1.Uf_SetTransObject ( itrTrans )

Wf_PositionnerObjet ()

/*------------------------------------------------------------------*/
/* On va retailler les boutons et positionner une police ad$$HEX1$$e900$$ENDHEX$$quate.  */
/*------------------------------------------------------------------*/
pb_Retour.PictureName	= "K:\PB4OBJ\BMP\8_QUIT.BMP"
pb_Retour.TextSize		= -7
pb_Retour.FaceName		= "Arial"

pb_Valider.PictureName	= "K:\PB4OBJ\BMP\8_VALID.BMP"
pb_Valider.TextSize		= -7
pb_Valider.FaceName		= "Arial"

invCorbOper.Uf_Initialiser ( dw_1, dw_Acc, U_Ajout_Corbeille, dw_CorbTmp, dw_OperAppli, dw_ProdCorb )




end on

on show;call w_traitement::show;//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Corb_Oper::Show (EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 22/10/1999 10:39:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

invCorbOper.Uf_Preparer ()

/*------------------------------------------------------------------*/
/* On positionne le premier op$$HEX1$$e900$$ENDHEX$$rateur. Le positionnement            */
/* s'effectuera ensuite sur l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement RowFocusChanged de          */
/* dw_Acc_Oper.                                                     */
/*------------------------------------------------------------------*/
invCorbOper.Uf_Traiter_Operateur ( 1 )
invCorbOper.Uf_Traiter_Ajout_Corbeille ()

dw_Acc.SetFocus ()


end on

on we_childactivate;call w_traitement::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Trt_Corb_Oper::We_ChildActivate
//* Evenement 		: We_ChildActivate
//* Auteur			: Erick John Stark
//* Date				: 30/11/2002 11:13:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Si on d$$HEX1$$e900$$ENDHEX$$place la fen$$HEX1$$ea00$$ENDHEX$$tre, elle revient au m$$HEX1$$ea00$$ENDHEX$$me endroit. 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

This.X			=    1
This.Y			=    1
This.Height		= 1745
This.Width		= 3590
end on

on close;call w_traitement::close;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Corb_Oper
//* Evenement 		: Close
//* Auteur			: Erick John Stark
//* Date				: 30/11/2002 11:13:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Fermerture de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------
 
Destroy invCorbOper

end on

on w_trt_corb_oper_new.create
int iCurrent
call super::create
this.u_ajout_corbeille=create u_ajout_corbeille
this.dw_corbtmp=create dw_corbtmp
this.dw_operappli=create dw_operappli
this.dw_prodcorb=create dw_prodcorb
this.dw_acc=create dw_acc
this.cbx_sortie=create cbx_sortie
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.u_ajout_corbeille
this.Control[iCurrent+2]=this.dw_corbtmp
this.Control[iCurrent+3]=this.dw_operappli
this.Control[iCurrent+4]=this.dw_prodcorb
this.Control[iCurrent+5]=this.dw_acc
this.Control[iCurrent+6]=this.cbx_sortie
end on

on w_trt_corb_oper_new.destroy
call super::destroy
destroy(this.u_ajout_corbeille)
destroy(this.dw_corbtmp)
destroy(this.dw_operappli)
destroy(this.dw_prodcorb)
destroy(this.dw_acc)
destroy(this.cbx_sortie)
end on

type dw_1 from w_traitement`dw_1 within w_trt_corb_oper_new
boolean visible = false
integer x = 14
integer y = 372
integer width = 329
integer height = 192
integer taborder = 0
boolean enabled = false
string dataobject = "d_stk_operateur_corbeille"
end type

type st_titre from w_traitement`st_titre within w_trt_corb_oper_new
boolean visible = false
integer x = 2898
integer y = 24
integer width = 535
end type

type pb_retour from w_traitement`pb_retour within w_trt_corb_oper_new
integer x = 14
integer y = 12
integer taborder = 60
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

type pb_valider from w_traitement`pb_valider within w_trt_corb_oper_new
integer x = 293
integer y = 12
integer taborder = 70
alignment htextalign = left!
end type

on pb_valider::clicked;//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Corb_Oper::Cb_Valider::Clicked (OVERRIDE)
//* Auteur			: Erick John Stark
//* Date				: 28/12/1999 16:01:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On d$$HEX1$$e900$$ENDHEX$$clenche la validation
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

If	invCorbOper.Uf_Valider ( Cbx_Sortie.Checked ) Then
	pb_Retour.TriggerEvent ( Clicked! )
End If


end on

type pb_imprimer from w_traitement`pb_imprimer within w_trt_corb_oper_new
boolean visible = false
integer x = 2057
integer y = 16
integer taborder = 0
boolean enabled = false
string disabledname = ""
end type

type pb_controler from w_traitement`pb_controler within w_trt_corb_oper_new
boolean visible = false
integer x = 1445
integer y = 16
integer taborder = 0
boolean enabled = false
end type

type pb_supprimer from w_traitement`pb_supprimer within w_trt_corb_oper_new
boolean visible = false
integer x = 1751
integer y = 16
integer taborder = 0
boolean enabled = false
end type

type u_ajout_corbeille from u_ajout within w_trt_corb_oper_new
event ue_trt_part pbm_custom01
integer x = 402
integer y = 188
integer width = 494
integer height = 360
integer taborder = 50
end type

on ue_trt_part;call u_ajout::ue_trt_part;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Corb_Oper::U_Ajout_Corbeille
//* Evenement 		: Ue_Trt_Part
//* Auteur			: Erick John Stark
//* Date				: 25/10/2000 16:06:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On vient de modifier la zone ALT_VALIDE
//*				  
//* Arguments		: 
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Long lWordParm
String sAlt

lWordParm = Message.WordParm
sAlt      = String ( Message.LongParm, "address" )

If	sAlt = "O"	Then
	This.dw_Source.SetItem ( lWordParm, "ALT_VALIDE_APRES", "N" )
Else
	This.dw_Source.SetItem ( lWordParm, "ALT_VALIDE_APRES", "O" )
End If

This.dw_Source.SetRedraw ( TRUE )

end on

on ue_dwsource_supprime;call u_ajout::ue_dwsource_supprime;//*-----------------------------------------------------------------
//*
//* Objet			: U_Ajout_Corbeille
//* Evenement 		: Ue_DwSource_Supprime
//* Auteur			: Erick John Stark
//* Date				: 28/12/1999 11:22:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va proc$$HEX1$$e900$$ENDHEX$$der $$HEX2$$e0002000$$ENDHEX$$la gestion des corbeilles
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long lIdCorb, lApres, lTotRech, lLig, lLigSupp
String sIdOper, sRech, sAltValideApr

lLigSupp			= This.ilLigSourceSupp

lApres			= 0
sIdOper 			= This.dw_Source.GetItemString ( lLigSupp, "ID_OPER" )
lIdCorb 			= This.dw_Source.GetItemNumber ( lLigSupp, "ID_CORB" )
sAltValideApr	= "N"

/*------------------------------------------------------------------*/
/* On positionne la chaine de recherche.                            */
/*------------------------------------------------------------------*/
sRech = "ID_OPER = '" + sIdOper + "' And ID_CORB = " + String ( lIdCorb )

/*------------------------------------------------------------------*/
/* On doit forc$$HEX1$$e900$$ENDHEX$$ment trouver la ligne dans la DW de Recherche.      */
/*------------------------------------------------------------------*/
lTotRech = This.dw_Recherche.RowCount ()
lLig = dw_Recherche.Find ( sRech, 0, lTotRech )

This.dw_Recherche.SetItem ( lLig, "ALT_APRES", lApres )
This.dw_Recherche.SetItem ( lLig, "ALT_VALIDE_APRES", sAltValideApr )

end on

on ue_dwcible_supprime;call u_ajout::ue_dwcible_supprime;//*-----------------------------------------------------------------
//*
//* Objet			: U_Ajout_Corbeille
//* Evenement 		: Ue_DwCible_Supprime
//* Auteur			: Erick John Stark
//* Date				: 28/12/1999 11:22:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va proc$$HEX1$$e900$$ENDHEX$$der $$HEX2$$e0002000$$ENDHEX$$la gestion des corbeilles
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long lIdCorb, lApres, lTotRech, lLig, lLigSupp
String sIdOper, sRech, sAltValideApr

lLigSupp			= This.ilLigSourceSupp

lApres			= 1
sIdOper 			= This.dw_Cible.GetItemString ( lLigSupp, "ID_OPER" )
lIdCorb 			= This.dw_Cible.GetItemNumber ( lLigSupp, "ID_CORB" )
sAltValideApr	= "N"
This.dw_Cible.SetItem ( lLigSupp, "ALT_VALIDE_APRES", "N" )

/*------------------------------------------------------------------*/
/* On positionne la chaine de recherche.                            */
/*------------------------------------------------------------------*/
sRech = "ID_OPER = '" + sIdOper + "' And ID_CORB = " + String ( lIdCorb )

/*------------------------------------------------------------------*/
/* On doit forc$$HEX1$$e900$$ENDHEX$$ment trouver la ligne dans la DW de Recherche.      */
/*------------------------------------------------------------------*/
lTotRech = This.dw_Recherche.RowCount ()
lLig = dw_Recherche.Find ( sRech, 0, lTotRech )

This.dw_Recherche.SetItem ( lLig, "ALT_APRES", lApres )
This.dw_Recherche.SetItem ( lLig, "ALT_VALIDE_APRES", sAltValideApr )

end on

on ue_dwsource_itemchanged;call u_ajout::ue_dwsource_itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			: W_Trt_Corb_Oper::U_Ajout_Corbeille
//* Evenement 		: Ue_DwSource_ItemChanged
//* Auteur			: Erick John Stark
//* Date				: 25/10/2000 16:06:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On vient de modifier la zone ALT_VALIDE
//*				  
//* Arguments		: (Val)		Long			Row
//*					  (Val)		DwObject		Dwo
//* 					  (Val)		String		Data
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Long lIdCorb, lTotRech, lLig, lRow, lRow2
String sIdOper, sAltValideApr, sRech

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le N$$HEX2$$b0002000$$ENDHEX$$de la ligne en cours de traitement.            */
/*------------------------------------------------------------------*/
lRow	= This.dw_Source.GetRow ()
lRow2 = This.dw_Source.GetSelectedRow ( 0 )

/*------------------------------------------------------------------*/
/* Il peut exister un probl$$HEX1$$e800$$ENDHEX$$me de d$$HEX1$$e900$$ENDHEX$$calage entre la ligne courante  */
/* et la ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e. Dans ce cas, j'effectue un traitement  */
/* particulier sur un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement du UserObjet.                       */
/*------------------------------------------------------------------*/
If	lRow <> lRow2 Then
	This.dw_Source.SetRedraw ( FALSE )
	This.PostEvent ( "Ue_Trt_Part", lRow, This.dw_Source.GetText () )
	Return
End If

lIdCorb 			= This.dw_Source.GetItemNumber ( lRow, "ID_CORB" )
sIdOper 			= This.dw_Source.GetItemString ( lRow, "ID_OPER" )
sAltValideApr	= This.dw_Source.GetText ()

/*------------------------------------------------------------------*/
/* On positionne la chaine de recherche.                            */
/*------------------------------------------------------------------*/
sRech = "ID_OPER = '" + sIdOper + "' And ID_CORB = " + String ( lIdCorb )

/*------------------------------------------------------------------*/
/* On doit forc$$HEX1$$e900$$ENDHEX$$ment trouver la ligne dans la DW de Recherche.      */
/*------------------------------------------------------------------*/
lTotRech = This.dw_Recherche.RowCount ()
lLig = dw_Recherche.Find ( sRech, 0, lTotRech )

This.dw_Recherche.SetItem ( lLig, "ALT_VALIDE_APRES", sAltValideApr )

end on

on ue_dimensionner;call u_ajout::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Ajout_Corbeille::Ue_Dimensionner
//* Evenement 		: Ue_Dimensionner
//* Auteur			: Erick John Stark
//* Date				: 22/01/1998 11:51:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On rend invisible les boutons permettant de supprimer ou d'ajouter tout
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.pb_Enlever_Tout.Visible = False
This.pb_Ajouter_Tout.Visible = False

end on

on constructor;call u_ajout::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Ajout_Corbeille::Constructor (EXTEND)
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 14:57:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Les DataWindows sont plac$$HEX1$$e900$$ENDHEX$$es de mani$$HEX1$$e900$$ENDHEX$$re horizontale.             */
/*------------------------------------------------------------------*/
ibHorizontal	= True

/*------------------------------------------------------------------*/
/* L'objet ne poss$$HEX1$$e900$$ENDHEX$$de pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre			= False

/*------------------------------------------------------------------*/
/* On utilise les boutons en 800x600.                               */
/*------------------------------------------------------------------*/
isTaille			= "8_"

/*------------------------------------------------------------------*/
/* On ne veut pas de RowFocusIndicator.                             */
/*------------------------------------------------------------------*/
ibIndicateur	= False

/*------------------------------------------------------------------*/
/* On ne veut pas de s$$HEX1$$e900$$ENDHEX$$lection multiple dans la source.             */
/*------------------------------------------------------------------*/
ibSourceSelMul	= False

/*------------------------------------------------------------------*/
/* On ne veut pas d'effet 3D pour l'objet.                          */
/*------------------------------------------------------------------*/
ibEffet3D		= False

/*------------------------------------------------------------------*/
/* On enl$$HEX1$$e900$$ENDHEX$$ve la bordure, qui permet de mieux voir l'objet pendant   */
/* le d$$HEX1$$e900$$ENDHEX$$veloppement.                                                */
/*------------------------------------------------------------------*/
This.Border = False


end on

on u_ajout_corbeille.destroy
call u_ajout::destroy
end on

type dw_corbtmp from datawindow within w_trt_corb_oper_new
boolean visible = false
integer x = 1623
integer y = 308
integer width = 329
integer height = 192
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
end type

type dw_operappli from datawindow within w_trt_corb_oper_new
boolean visible = false
integer x = 1989
integer y = 308
integer width = 329
integer height = 192
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
end type

type dw_prodcorb from datawindow within w_trt_corb_oper_new
boolean visible = false
integer x = 2354
integer y = 308
integer width = 329
integer height = 192
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
end type

type dw_acc from u_datawindow_accueil within w_trt_corb_oper_new
integer x = 14
integer y = 172
integer width = 329
integer height = 192
boolean vscrollbar = true
end type

on ue_modifiermenu;call u_datawindow_accueil::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_Acc_Oper
//* Evenement 		: Ue_ModifierMenu
//* Auteur			: Erick John Stark
//* Date				: 16/12/1999 15:33:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------


uf_Mnu_InterdirItem ( 1 )
uf_Mnu_InterdirItem ( 2 )
uf_Mnu_InterdirItem ( 3 )
uf_Mnu_InterdirItem ( 5 )

end on

event rowfocuschanged;call super::rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet			: Dw_Acc_Oper
//* Evenement 		: RowFocusChanged
//* Auteur			: Erick John Stark
//* Date				: 16/12/1999 15:33:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On s'occupe de populiser la liste des corbeilles
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long lLigne
Boolean bRet
String sTitre, sMajPar, sMajLe

//Migration PB8-WYNIWYG-03/2006 FM
//lLigne	= This.GetRow ()
lLigne	= CurrentRow
//Fin Migration PB8-WYNIWYG-03/2006 FM
bRet		= TRUE

If	lLigne > 0	Then
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si le traitement de gestion a d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$effectu$$HEX1$$e900$$ENDHEX$$.      */
/*------------------------------------------------------------------*/
	If	IsNull ( This.GetItemString ( lLigne, "ALT_TRT" ) ) Then
		bRet = invCorbOper.Uf_Traiter_Operateur ( lLigne )
	End If
/*------------------------------------------------------------------*/
/* On positionne les corbeilles dans l'objet U_AJOUT.               */
/*------------------------------------------------------------------*/
	If	bRet Then invCorbOper.Uf_Traiter_Ajout_Corbeille ()
/*------------------------------------------------------------------*/
/* On modifie le titre de la fen$$HEX1$$ea00$$ENDHEX$$tre pour faire apparaitre MAJ_PAR  */
/* et MAJ_LE, pour les applis de type 1280*1024.                    */
/*------------------------------------------------------------------*/
//	If	Not Wf_Is800_600 ()	Then
//		sMajPar	= This.GetItemString ( lLigne, "MAJ_PAR" )
//		If IsNull ( sMajPar )	Then 
//			sTitre	= "Assignation des Op$$HEX1$$e900$$ENDHEX$$rateurs/Corbeilles "
//		Else
//			sMajLe	= String ( This.GetItemDateTime ( lLigne, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss;''" )
//			sTitre 	= "Assignation des Op$$HEX1$$e900$$ENDHEX$$rateurs/Corbeilles - Maj Par : " + sMajPar + " Le : " + sMajLe
//		End If
//		
//		Parent.Title = sTitre
//	End If
End If
end event

event rbuttondown;//Migration PB8-WYNIWYG-03/2006 FM

if row > 0 then
	This.SetRow(row)
	SelectRow( Row, true )
end if

call super::rbuttondown

return AncestorReturnValue

//Fin Migration PB8-WYNIWYG-03/2006 FM
end event

type cbx_sortie from checkbox within w_trt_corb_oper_new
integer x = 777
integer y = 64
integer width = 1330
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "V$$HEX1$$e900$$ENDHEX$$rification de toutes les lignes en sortie ?"
boolean lefttext = true
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Fonction		: W_Trt_Corb_Oper::Cbx_Sortie::Clicked (EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 28/12/1999 16:01:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cette option est r$$HEX1$$e900$$ENDHEX$$serv$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$DGA pour le moment.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

If	stGLB.sCodOper <> 'DGA'	Then
	This.Checked = FALSE
End If
end on

