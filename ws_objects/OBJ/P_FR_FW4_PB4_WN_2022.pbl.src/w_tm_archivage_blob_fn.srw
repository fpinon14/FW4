HA$PBExportHeader$w_tm_archivage_blob_fn.srw
forward
global type w_tm_archivage_blob_fn from w_8_traitement_master
end type
type uo_ong from u_onglets within w_tm_archivage_blob_fn
end type
type p_focus from picture within w_tm_archivage_blob_fn
end type
type uo_3d from u_bord3d within w_tm_archivage_blob_fn
end type
type dw_lst_trt from u_datawindow_detail within w_tm_archivage_blob_fn
end type
type dw_lst_dossier from u_datawindow_detail within w_tm_archivage_blob_fn
end type
type pb_recup from picturebutton within w_tm_archivage_blob_fn
end type
type pb_arch from picturebutton within w_tm_archivage_blob_fn
end type
type cb_1 from commandbutton within w_tm_archivage_blob_fn
end type
type cb_2 from commandbutton within w_tm_archivage_blob_fn
end type
end forward

global type w_tm_archivage_blob_fn from w_8_traitement_master
integer x = 0
integer y = 0
integer width = 3598
integer height = 1768
string title = "Gestion de l~'archivage des courriers sur le syst$$HEX1$$e800$$ENDHEX$$me FileNet"
uo_ong uo_ong
p_focus p_focus
uo_3d uo_3d
dw_lst_trt dw_lst_trt
dw_lst_dossier dw_lst_dossier
pb_recup pb_recup
pb_arch pb_arch
cb_1 cb_1
cb_2 cb_2
end type
global w_tm_archivage_blob_fn w_tm_archivage_blob_fn

type variables
Private :
	u_Archivage_Fn		iuoArchivageFn


end variables

forward prototypes
private subroutine wf_positionnerobjets ()
public function boolean wf_preparerinserer ()
end prototypes

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Archivage_Blob_Fn::Wf_PositionnerObjets (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 09/01/1998 15:27:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne et on taille tous les objets
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne tous les objets n$$HEX1$$e900$$ENDHEX$$cessaires $$HEX2$$e0002000$$ENDHEX$$la gestion, pour     */
/* faciliter le d$$HEX1$$e900$$ENDHEX$$veloppement. (On peut bouger les objets).         */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Barre Onglet                                                     */
/*------------------------------------------------------------------*/
Uo_Ong.X			=   10
Uo_Ong.Y			=  157
Uo_Ong.Width	=  109

/*------------------------------------------------------------------*/
/* Dw_1 et les autres comprises dans l'onglet.                      */
/*------------------------------------------------------------------*/
Dw_1.X			=   60
Dw_1.Y			=  310
Dw_1.Width		= 1750
Dw_1.Height		= 1310

/*------------------------------------------------------------------*/
/* Liste des Dossiers                                               */
/*------------------------------------------------------------------*/
Dw_Lst_Dossier.X			= 1850
Dw_Lst_Dossier.Y			= 310
Dw_Lst_Dossier.Width		= 1750
Dw_Lst_Dossier.Height	= 1310

/*------------------------------------------------------------------*/
/* Liste des Traitements Pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dents                                 */
/*------------------------------------------------------------------*/
Dw_Lst_Trt.X		= Dw_1.X
Dw_Lst_Trt.Y		= Dw_1.Y
Dw_Lst_Trt.Width	= Dw_1.Width
Dw_Lst_Trt.Height	= Dw_1.Height

end subroutine

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Archivage_Blob_Fn::Wf_PreparerModifier
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:25:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//*
//* Arguments		: Rien
//*
//* Retourne		: Boolean		Vrai = On peut continuer
//*										Faux = Il y a une erreur
//*
//*-----------------------------------------------------------------

s_Pass	stPass_Dga
String sMonnaie

//stPass_Dga.sTab [ 1 ] = istPass.sTab [ 1 ]			// ID_SIN en cours de traitement

iuoArchivageFn.Uf_Traitement ( 2, stPass_Dga )

Return ( stPass_Dga.bRetour )

end function

on ue_initialiser;call w_8_traitement_master::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Archivage_Blob_Fn::Ue_Initialiser
//* Evenement 		: Ue_Initialiser
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPass_Dga

Wf_PositionnerObjets ()

/*------------------------------------------------------------------*/
/* On commence $$HEX2$$e0002000$$ENDHEX$$initialiser les NVUO.                              */
/*------------------------------------------------------------------*/
iuoArchivageFn = Create U_Archivage_Fn

/*------------------------------------------------------------------*/
/* On initialise les diff$$HEX1$$e900$$ENDHEX$$rents objets pour le NVUO.                */
/*------------------------------------------------------------------*/
iuoArchivageFn.Uf_Initialisation ( dw_1, itrTrans, Uo_Ong )
iuoArchivageFn.Uf_Initialiser_Dw ( dw_Lst_Dossier, dw_Lst_Trt )

/*------------------------------------------------------------------*/
/* On positionne un RowFocusIndicator.                              */
/*------------------------------------------------------------------*/
dw_Lst_Trt.SetRowFocusIndicator ( p_Focus, 50, 260 )

/*------------------------------------------------------------------*/
/* Initialisation de l'onglet.                                      */
/*------------------------------------------------------------------*/
Uo_Ong.Uf_Initialiser ( 2, 1 )
Uo_Ong.Uf_EnregistrerOnglet ( "01", "Archivage", 			"", dw_1,			True )
Uo_Ong.Uf_EnregistrerOnglet ( "02", "Trt. Pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dents",	"", dw_Lst_Trt,	False )

iuoArchivageFn.Uf_Traitement ( 1, stPass_Dga )


end on

on ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Archivage_Blob_Fn::Ue_Retour (OverRide!!)
//* Evenement 		: Ue_Retour
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:29:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Op$$HEX1$$e900$$ENDHEX$$rations  $$HEX2$$e0002000$$ENDHEX$$effectuer avant la fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iwParent.TriggerEvent ( "Ue_EnableFenetre" )

iwParent.TriggerEvent ( "Ue_MajAccueil" )


end on

on close;call w_8_traitement_master::close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Archivage_Blob_Fn::Close
//* Evenement 		: Close
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 18:46:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Fermeture d$$HEX1$$e900$$ENDHEX$$finitive de la fen$$HEX1$$ea00$$ENDHEX$$tre.
//*				     On supprime tous les NVUO.
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Destroy iUoArchivageFn

end on

on ue_modifier;call w_8_traitement_master::ue_modifier;////*-----------------------------------------------------------------
////*
////* Objet 			: W_Tm_Sp_Sinistre::Ue_Modifier
////* Evenement 		: Ue_Modifier
////* Auteur			: Erick John Stark
////* Date				: 09/01/1998 16:37:38
////* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
////* Commentaires	: Ouverture des Fen$$HEX1$$ea00$$ENDHEX$$tres de d$$HEX1$$e900$$ENDHEX$$tail.
////*				     (On est en modification d'un d$$HEX1$$e900$$ENDHEX$$tail)
////*
////*-----------------------------------------------------------------
////* MAJ PAR		Date		Modification
////*				  
////*-----------------------------------------------------------------
//
//s_Pass stPass_Dga
//
//stPass_Dga = istPass
//
//Choose Case isDetailActif
//Case "dw_lst_inter"
//
//	isDetailConsult = "dw_lst_inter"
//
//	SetPointer ( HourGlass! )
///*------------------------------------------------------------------*/
///* On arme la structure pour expliquer un certain nombre de         */
///* choses. On est en modification, on ne veut pas du bouton CTRL.   */
///* On passe la DW de d$$HEX1$$e900$$ENDHEX$$tail ainsi que la DW Master (Sinistre).      */
///* Cette derni$$HEX1$$e800$$ENDHEX$$re est tr$$HEX1$$e900$$ENDHEX$$s importante. Elle va $$HEX1$$e900$$ENDHEX$$viter d'utiliser    */
///* des instances de fen$$HEX1$$ea00$$ENDHEX$$tres.                                       */
///*------------------------------------------------------------------*/
//	stPass_Dga.bInsert		= False
//	stPass_Dga.bSupprime		= True
//	stPass_Dga.bControl		= False
//	
//	stPass_Dga.sTab [ 1 ]	= This.Title
//	stPass_Dga.sTab [ 2 ]	= isTypeTrt
//	stPass_Dga.sTab [ 3 ]	= Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()
//
//	stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Inter
//	stPass_Dga.dwMaster		= dw_1
//
//	stPass_Dga.dwNorm [ 1 ]	= dw_Produit			// DataWindow PRODUIT
//	stPass_Dga.dwNorm [ 2 ]	= dw_ParaProd			// DataWindow PARA_PROD
//	stPass_Dga.dwNorm [ 3 ]	= dw_wParaInfo			// DataWindow W_PARA_INFO
//	stPass_Dga.dwNorm [ 4 ]	= dw_wPiece				// DataWindow W_PIECE
//	stPass_Dga.dwNorm [ 5 ]	= dw_wRefus				// DataWindow W_REFUS
//	stPass_Dga.dwNorm [ 6 ]	= dw_wFrais				// DataWindow W_FRAIS
//	stPass_Dga.dwNorm [ 7 ]	= dw_wDetail			// DataWindow W_DETAIL
//
//	If	stPass_Dga.sTab [ 3 ]	<> "F"	Then	Uo_Consult_Euro.Uf_Changer_Monnaie ( "F" )
//
//	F_OuvreTraitement ( iW_Tm_Sp_Interlocuteur, stPass_Dga )
//
//Case "dw_lst_gti"
//
//	isDetailConsult = "dw_lst_gti"
//
//	SetPointer ( HourGlass! )	
//
//	stPass_Dga.bInsert		= False
//	stPass_Dga.bControl		= True
//
//	stPass_Dga.sTab [ 1 ]	= This.Title
//	stPass_Dga.sTab [ 2 ]	= isTypeTrt
//	stPass_Dga.sTab [ 3 ]	= Uo_Consult_Euro.Uf_Recuperer_Monnaie_Courante ()
//
//	stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Gti
//	stPass_Dga.dwTab [ 2 ]	= Dw_Lst_Inter
//
//	stPass_Dga.dwMaster		= dw_1
//
//	stPass_Dga.dwNorm [  1 ]	= dw_Produit			// DataWindow PRODUIT
//	stPass_Dga.dwNorm [  2 ]	= dw_CodeGarantie		// DataWindow CODE_GARANTIE
//	stPass_Dga.dwNorm [  3 ]	= dw_CodeCondition	// DataWindow CODE_CONDITION
//	stPass_Dga.dwNorm [  4 ]	= dw_Piece				// DataWindow PIECE
//	stPass_Dga.dwNorm [  5 ]	= dw_Motif				// DataWindow MOTIF
//	stPass_Dga.dwNorm [  6 ]	= dw_Franchise			// DataWindow FRANCHISE
//	stPass_Dga.dwNorm [  7 ]	= dw_Plafond			// DataWindow PLAFOND
//	stPass_Dga.dwNorm [  8 ]	= dw_Delai				// DataWindow DELAI
//	stPass_Dga.dwNorm [  9 ]	= dw_Garantie			// DataWindow GARANTIE
//	stPass_Dga.dwNorm [ 10 ]	= dw_Condition			// DataWindow CONDITION
//	stPass_Dga.dwNorm [ 11 ]	= dw_wDetail			// DataWindow W_DETAIL
//	stPass_Dga.dwNorm [ 12 ]	= dw_wPiece				// DataWindow W_PIECE
//	stPass_Dga.dwNorm [ 13 ]	= dw_wRefus				// DataWindow W_REFUS
//	stPass_Dga.dwNorm [ 14 ]	= dw_wParaPlafond		// DataWindow W_PARA_PLAFOND
//
//	If	stPass_Dga.sTab [ 3 ]	<> "F"	Then	Uo_Consult_Euro.Uf_Changer_Monnaie ( "F" )
//	
//	F_OuvreTraitement ( iW_Tm_Sp_W_Gar_Sin, stPass_Dga )
//
//End Choose
//
//
//
//
end on

on ue_creer;call w_8_traitement_master::ue_creer;////*-----------------------------------------------------------------
////*
////* Objet 			: W_Tm_Sp_Sinistre::Ue_Creer
////* Evenement 		: Ue_Creer
////* Auteur			: Erick John Stark
////* Date				: 09/01/1998 16:37:38
////* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
////* Commentaires	: Ouverture des Fen$$HEX1$$ea00$$ENDHEX$$tres de d$$HEX1$$e900$$ENDHEX$$tail.
////*				     (On est en cr$$HEX1$$e900$$ENDHEX$$ation d'un d$$HEX1$$e900$$ENDHEX$$tail)
////*				  
////*-----------------------------------------------------------------
////* MAJ PAR		Date		Modification
////*				  
////*-----------------------------------------------------------------
//
//s_Pass stPass_Dga
//
//stPass_Dga = istPass
//
//String sFiltre
//
//Long lTot, lCpt
//Boolean bRet
//
//If	isTypeTrt <> "S"	Then Return
//
//Choose Case isDetailActif
//Case "dw_lst_inter"
//
//	bRet	= True
//	SetPointer ( HourGlass! )
//
///*------------------------------------------------------------------*/
///* On ne doit pas cr$$HEX1$$e900$$ENDHEX$$er plus de 10 interlocuteurs. On ne g$$HEX1$$e900$$ENDHEX$$re pas   */
///* les trous, selon St Denis il n'y aura jamais plus de 2 ou 3      */
///* lignes dans la table. Donc on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re simplement le dernier Id  */
///* de la DW sachant qu'elle est tri$$HEX1$$e900$$ENDHEX$$e sur CODE_ID.                  */
///*------------------------------------------------------------------*/
//	lTot = dw_Lst_Inter.RowCount ()
//	If	lTot > 0 Then
//		If	dw_Lst_Inter.GetItemNumber ( lTot, "ID_I" ) >= 10 Then
//			bRet = False
//
//			stMessage.sTitre		= "Cr$$HEX1$$e900$$ENDHEX$$ation d'un interlocuteur - SIMPA 2"
//			stMessage.Icon			= StopSign!
//			stMessage.sVar [ 1 ]	= "d'interlocuteur"
//			stMessage.sCode		= "WSIN100"
//			F_Message ( stMessage )
//
//		End If
//	End If
//
//	If	bRet Then
///*------------------------------------------------------------------*/
///* On arme la structure pour expliquer un certain nombre de         */
///* choses. On est en insertion, on veut un bouton CTRL. On passe    */
///* la DW de d$$HEX1$$e900$$ENDHEX$$tail ainsi que la DW Master (Sinistre). Cette         */
///* derni$$HEX1$$e800$$ENDHEX$$re est tr$$HEX1$$e900$$ENDHEX$$s importante. Elle va $$HEX1$$e900$$ENDHEX$$viter d'utiliser des      */
///* instances de fen$$HEX1$$ea00$$ENDHEX$$tres.                                           */
///*------------------------------------------------------------------*/
//		stPass_Dga.bInsert		= True
//		stPass_Dga.bControl		= False
//	
//		stPass_Dga.sTab [ 1 ]	= This.Title
//		stPass_Dga.sTab [ 2 ]	= isTypeTrt
//
//		stPass_Dga.dwTab [ 1 ]	= Dw_Lst_Inter
//		stPass_Dga.dwMaster		= dw_1
//
//		stPass_Dga.dwNorm [ 1 ]	= dw_Produit			// DataWindow PRODUIT
//		stPass_Dga.dwNorm [ 2 ]	= dw_ParaProd			// DataWindow PARA_PROD
//		stPass_Dga.dwNorm [ 3 ]	= dw_wParaInfo			// DataWindow W_PARA_INFO
//		stPass_Dga.dwNorm [ 4 ]	= dw_wPiece				// DataWindow W_PIECE
//		stPass_Dga.dwNorm [ 5 ]	= dw_wRefus				// DataWindow W_REFUS
//		stPass_Dga.dwNorm [ 6 ]	= dw_wFrais				// DataWindow W_FRAIS
//		stPass_Dga.dwNorm [ 7 ]	= dw_wDetail			// DataWindow W_DETAIL
//
//		F_OuvreTraitement ( iW_Tm_Sp_Interlocuteur, stPass_Dga )
//
//	End If
//
//Case "dw_lst_gti"
//
///*------------------------------------------------------------------*/
///* On va ouvrir une fen$$HEX1$$ea00$$ENDHEX$$tre pour demander au gestionnaire de        */
///* choisir une garantie.                                            */
///*------------------------------------------------------------------*/
///*------------------------------------------------------------------*/
///* On filtre les garanties d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$positionn$$HEX1$$e900$$ENDHEX$$es.                       */
///*------------------------------------------------------------------*/
//	sFiltre = ""
//	lTot = dw_Lst_Gti.RowCount ()
//	If	lTot > 0 Then
//		For	lCpt = 1 To lTot
//			sFiltre = sFiltre + "ID_GTI <> " + String ( dw_Lst_Gti.GetItemNumber ( lCpt, "ID_GTI" ) ) + " AND "
//		Next
///*------------------------------------------------------------------*/
///* On enl$$HEX1$$e900$$ENDHEX$$ve le dernier AND g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$dans la boucle.                  */
///*------------------------------------------------------------------*/
//		sFiltre = Left ( sFiltre, Len ( sFiltre ) - 5 )
//	End If
//	dw_CodeGarantie.SetFilter ( sFiltre )
//	dw_CodeGarantie.Filter ()
//	dw_CodeGarantie.Sort ()
//	
//	If	dw_CodeGarantie.RowCount () > 0 Then
//
//		stPass_Dga.trTrans	= itrTrans
//		stPass_Dga.wParent	= This
//		stPass_Dga.dwNorm[1]	= dw_CodeGarantie
//
//		OpenWithParm ( W_T_Sp_Choix_Garantie, stPass_Dga, stPass_Dga.wParent.ParentWindow () )
//
///*------------------------------------------------------------------*/
///* On va ouvrir une fen$$HEX1$$ea00$$ENDHEX$$tre CHILD qui va permettre de choisir la    */
///* garantie que l'on d$$HEX1$$e900$$ENDHEX$$sire ouvrir. La 'suite' de l'ouverture de    */
///* la fen$$HEX1$$ea00$$ENDHEX$$tre de d$$HEX1$$e900$$ENDHEX$$tail se fera sur l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement Ue_Choix_Garantie.  */
///*------------------------------------------------------------------*/
///*------------------------------------------------------------------*/
///* On va enlever le filtre sur CODE_GARANTIE sur l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ment        */
///* UE_CHOIX_GARANTIE.                                               */
///*------------------------------------------------------------------*/
//	Else
///*------------------------------------------------------------------*/
///* On enl$$HEX1$$e900$$ENDHEX$$ve le filtre si il n'y a aucune ligne.                    */
///*------------------------------------------------------------------*/
//		sFiltre = ""
//		dw_CodeGarantie.SetFilter ( sFiltre )
//		dw_CodeGarantie.Filter ()
//		dw_CodeGarantie.Sort ()
//	End If
//End Choose
//
//
end on

on we_childactivate;call w_8_traitement_master::we_childactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Archivage_Blob_Fn::We_ChildActivate
//* Evenement 		: We_ChildActivate
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:53:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.X			=    1
This.Y			=    1
This.Height		= 1769
This.Width		= 3598
end on

on w_tm_archivage_blob_fn.create
int iCurrent
call super::create
this.uo_ong=create uo_ong
this.p_focus=create p_focus
this.uo_3d=create uo_3d
this.dw_lst_trt=create dw_lst_trt
this.dw_lst_dossier=create dw_lst_dossier
this.pb_recup=create pb_recup
this.pb_arch=create pb_arch
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_ong
this.Control[iCurrent+2]=this.p_focus
this.Control[iCurrent+3]=this.uo_3d
this.Control[iCurrent+4]=this.dw_lst_trt
this.Control[iCurrent+5]=this.dw_lst_dossier
this.Control[iCurrent+6]=this.pb_recup
this.Control[iCurrent+7]=this.pb_arch
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cb_2
end on

on w_tm_archivage_blob_fn.destroy
call super::destroy
destroy(this.uo_ong)
destroy(this.p_focus)
destroy(this.uo_3d)
destroy(this.dw_lst_trt)
destroy(this.dw_lst_dossier)
destroy(this.pb_recup)
destroy(this.pb_arch)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type dw_1 from w_8_traitement_master`dw_1 within w_tm_archivage_blob_fn
integer x = 41
integer y = 328
integer width = 530
integer height = 460
string dataobject = "d_mss_blob_fn"
boolean border = false
boolean livescroll = false
end type

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Archivage_Blob_Fn::dw_1::SqlPreview
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 28/11/1997 15:34:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sSqlPreview

Long dcNbrDossier, dcNbrDt, dcNbrPs, dcNbrPce, dcNbrPart

String sMajPar

DateTime dtCreeLe, dtMajLe, dtRecupDeb, dtRecupFin, dtTrtDeb, dtTrtFin, dtFnDeb, dtFnFin

//Migration PB8-WYNIWYG-03/2006 CP
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 CP

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview = This.GetSqlPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/
Choose Case Left ( sSqlPreview, 4 )
Case	"INSE"

	dtRecupDeb		= This.GetItemDateTime ( 1,	"RECUP_DEB"			)
	dtRecupFin		= This.GetItemDateTime ( 1,	"RECUP_FIN"			)
	dcNbrDossier	= This.GetItemNumber ( 1,	"NBR_DOSSIER"			)

	dtTrtDeb			= This.GetItemDateTime ( 1,	"TRT_DEB"			)
	dtFnDeb			= This.GetItemDateTime ( 1,	"FN_DEB"				)
	dtTrtFin			= This.GetItemDateTime ( 1,	"TRT_FIN"			)
	dtFnFin			= This.GetItemDateTime ( 1,	"FN_FIN"				)

	dcNbrDt			= This.GetItemNumber ( 1,	"NBR_DT"					)
	dcNbrPs			= This.GetItemNumber ( 1,	"NBR_PS"					)
	dcNbrPce			= This.GetItemNumber ( 1,	"NBR_PCE"				)
	dcNbrPart		= This.GetItemNumber ( 1,	"NBR_PART"				)

	sMajPar			= stGLB.sCodOper
	dtMajLe			= dw_1.GetItemDateTime ( 1, "MAJ_LE" 				)
	dtCreeLe			= This.GetItemDateTime ( 1, "CREE_LE"				)

	itrTrans.DW_I01_FN_ARCHIVE (	dtRecupDeb,			&
											dtRecupFin,			&
											dcNbrDossier,		&
											dtTrtDeb,			&
											dtFnDeb,				&
											dtTrtFin,			&
											dtFnFin,				&
											dcNbrDt,				&
											dcNbrPs,				&
											dcNbrPce,			&
											dcNbrPart,			&
											dtCreeLe,			&
											dtMajLe,				&
											sMajPar		)

	If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 CP
//		This.SetActionCode ( 1 )
		ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP				
	Else
//Migration PB8-WYNIWYG-03/2006 CP		
//		This.SetActionCode ( 2 )
		ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP		
	End If

	Pb_Arch.Visible 	= False
	Pb_Arch.Enabled 	= False

	Parent.Enabled 	= True

End Choose

//Migration PB8-WYNIWYG-03/2006 CP		
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 CP		
end event

type st_titre from w_8_traitement_master`st_titre within w_tm_archivage_blob_fn
boolean visible = false
integer x = 3442
integer y = 16
integer width = 133
integer height = 60
end type

type pb_retour from w_8_traitement_master`pb_retour within w_tm_archivage_blob_fn
integer x = 9
integer y = 8
integer taborder = 60
end type

type pb_valider from w_8_traitement_master`pb_valider within w_tm_archivage_blob_fn
boolean visible = false
integer x = 2533
integer y = 20
integer taborder = 80
boolean enabled = false
end type

on pb_valider::clicked;call w_8_traitement_master`pb_valider::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::pb_valider::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 05/12/1997 17:25:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Positionnement du code action sur CTRL_VALIDER
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


end on

type pb_imprimer from w_8_traitement_master`pb_imprimer within w_tm_archivage_blob_fn
boolean visible = false
integer x = 3017
integer y = 20
integer taborder = 0
boolean enabled = false
end type

type pb_controler from w_8_traitement_master`pb_controler within w_tm_archivage_blob_fn
boolean visible = false
integer x = 2290
integer y = 20
integer taborder = 70
boolean enabled = false
end type

on pb_controler::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_Sinistre::pb_controler (OVERRIDE)
//* Evenement 		: 
//* Auteur			: Erick John Stark
//* Date				: 05/02/1998 15:50:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$clenche un ItemFocusChanged avant toute chose. Cela         */
/* concerne les zones COD_CIV, ID_ETS.                              */
/*------------------------------------------------------------------*/

dw_1.TriggerEvent ( ItemFocusChanged! )

Call u_pbControler::Clicked

end on

type pb_supprimer from w_8_traitement_master`pb_supprimer within w_tm_archivage_blob_fn
boolean visible = false
integer x = 2775
integer y = 20
integer taborder = 120
boolean enabled = false
end type

type uo_ong from u_onglets within w_tm_archivage_blob_fn
integer x = 9
integer y = 156
integer width = 946
integer height = 108
integer taborder = 40
boolean border = false
end type

type p_focus from picture within w_tm_archivage_blob_fn
boolean visible = false
integer x = 3296
integer y = 16
integer width = 91
integer height = 76
boolean bringtotop = true
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\focus_1.bmp"
boolean focusrectangle = false
end type

type uo_3d from u_bord3d within w_tm_archivage_blob_fn
integer x = 1531
integer y = 60
integer width = 320
integer height = 120
end type

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: Uo_3d::Constructor (OVERRIDE)
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
/* On positionne le Bord en 3D, puis on appelle la construction     */
/* normale.                                                         */
/*------------------------------------------------------------------*/

This.X			=   19
This.Y			=  253
This.Width		= 1790
This.Height		= 1420

Call U_Bord3D::Constructor
end on

on uo_3d.destroy
call u_bord3d::destroy
end on

type dw_lst_trt from u_datawindow_detail within w_tm_archivage_blob_fn
integer x = 645
integer y = 328
integer width = 530
integer height = 460
integer taborder = 20
string dataobject = "d_mss_blob_fn_lst"
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
end type

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Lst_Trt::Ue_ModifierMenu
//* Evenement 		: Ue_ModifierMenu
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 14:25:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.Uf_Mnu_SupprimerItem ( 3 )

This.Uf_Mnu_CacherItem  ( 1 )
This.Uf_Mnu_ChangerText ( 2, "&Consulter" )



end on

type dw_lst_dossier from u_datawindow_detail within w_tm_archivage_blob_fn
integer x = 1248
integer y = 328
integer width = 530
integer height = 460
integer taborder = 30
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = styleshadowbox!
end type

on retrieverow;call u_datawindow_detail::retrieverow;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Lst_Dossier::RetrieveRow!
//* Evenement 		: RetrieveRow!
//* Auteur			: Erick John Stark
//* Date				: 21/01/1998 12:11:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Incr$$HEX1$$e900$$ENDHEX$$mentation du nombre de lignes retrouv$$HEX1$$e900$$ENDHEX$$es
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

DateTime dtRecupFin
Long lTotLig

This.ilNbrLig ++

If	This.ilNbrLig = This.ilMaxLig Then

	DbCancel ()

/*------------------------------------------------------------------*/
/* On positionne le DateTime de FIN de traitement.                  */
/*------------------------------------------------------------------*/
	dtRecupFin	= DateTime ( Today (), Now () )
	dw_1.SetItem ( 1, "RECUP_FIN", dtRecupFin )

	lTotLig = This.RowCount ()
	
	dw_1.SetItem ( 1, "NBR_DOSSIER", lTotLig )

	Pb_Recup.Visible	= False
	Pb_Recup.Enabled	= False

	Pb_Arch.Visible	= True
	Pb_Arch.Enabled	= True

	Parent.Enabled		= True

Else

	dw_1.SetItem ( 1, "NBR_DOSSIER", ilNbrLig )

End If


end on

on ue_modifiermenu;call u_datawindow_detail::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Lst_Dossier::Ue_ModifierMenu
//* Evenement 		: Ue_ModifierMenu
//* Auteur			: Erick John Stark
//* Date				: 15/01/1998 14:25:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.Uf_Mnu_SupprimerItem ( 3 )
This.Uf_Mnu_SupprimerItem ( 2 )
This.Uf_Mnu_SupprimerItem ( 1 )


end on

type pb_recup from picturebutton within w_tm_archivage_blob_fn
integer x = 265
integer y = 8
integer width = 233
integer height = 136
integer taborder = 110
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_ctl.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Archivage_Blob_Fn::Pb_Recup::Clicked!
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPass_Dga

SetPointer ( HourGlass! )
Parent.Enabled = False

iuoArchivageFn.Uf_Traitement ( 3, stPass_Dga )


end on

type pb_arch from picturebutton within w_tm_archivage_blob_fn
boolean visible = false
integer x = 265
integer y = 8
integer width = 233
integer height = 136
integer taborder = 50
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Archivage"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_valid.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Archivage_Blob_Fn::Pb_Arch::Clicked!
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 05/01/1998 17:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass stPass_Dga

SetPointer ( HourGlass! )
Parent.Enabled = False

iuoArchivageFn.Uf_Traitement ( 4, stPass_Dga )


end on

type cb_1 from commandbutton within w_tm_archivage_blob_fn
integer x = 1179
integer y = 20
integer width = 247
integer height = 68
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sauve"
end type

on clicked;

dw_Lst_Dossier.SaveAs ( "C:\TRT.TXT", Text!, False )


end on

type cb_2 from commandbutton within w_tm_archivage_blob_fn
integer x = 1179
integer y = 104
integer width = 247
integer height = 68
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Import"
end type

on clicked;

dw_Lst_Dossier.ImportFile ( "C:\TRT.TXT" )

pb_Recup.Visible = False
pb_Recup.Enabled = False

pb_Arch.Visible = True
pb_Arch.Enabled = True

MessageBox ( "", dw_Lst_Dossier.RowCount () )

end on

