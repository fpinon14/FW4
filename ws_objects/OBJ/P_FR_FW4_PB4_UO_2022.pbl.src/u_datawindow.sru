$PBExportHeader$u_datawindow.sru
$PBExportComments$----} UserObjet Ancêtre DataWindow
forward
global type u_datawindow from datawindow
end type
end forward

global type u_datawindow from datawindow
integer width = 978
integer height = 492
integer taborder = 1
boolean livescroll = true
event ue_trier pbm_custom75
event we_touche pbm_dwnkey
event ue_boucleenr pbm_custom74
event ue_majaccueil pbm_custom73
event ue_dropdown pbm_dwndropdown
event ue_modifiermenu pbm_custom72
end type
global u_datawindow u_datawindow

type variables
Private :
	Long		ilChoixMonnaie

Protected:
	Boolean		ibMenuActif
	Boolean		ibGestionTouche
	m_Context	imContext	
	Integer            	iiCarNul


Public:

u_transaction     itrTrans

String              isTri,        &
                      isErrCol,    &
                      isNomCol,  &
                      isJointure

s_Creer_Dw     istCol[]

Integer            iiErreur,     &
                      iiReset

Integer	        iiStopTab

Boolean          ibErreur 
Boolean          ibPasDeMessage // [KSV649_ORREUCARA]

Long              ilMaxLig , &
                     ilNbrLig

Long	       ilPremCol
Long	       ilDernCol


u_datawindow_detail	iudwDetailSource
//datawindow	iudwDetailSource

Long			ilLigneDetailSource

// [SUISSE].ID_LANG
n_cst_dwsrv_itemmanager invIm // SErvice de gestion améliorée des tiem d'un dw

end variables

forward prototypes
public subroutine uf_dataobject (string asDataobject)
public function boolean uf_update ()
public subroutine uf_initialisercouleur (string ascolonne[])
public subroutine uf_proteger (string ascolonne[], string asprotection)
public subroutine uf_filtrer (string asfiltre)
public subroutine uf_desactiver (long alLigneDebut, long alLigneFin)
public function long uf_modify (ref string asmod)
public subroutine uf_indicator (ref picture apIndicator)
public function boolean uf_copierligne ()
public function boolean uf_validerligne (boolean abinsert)
public function boolean uf_detailparent (u_datawindow_detail audwdetail)
public function boolean uf_supprimerligne ()
public function boolean uf_mnu_interdiritem (integer ainumitem)
public function boolean uf_mnu_autoriseritem (integer ainumitem)
public function boolean uf_mnu_montreritem (integer ainumitem)
public function boolean uf_mnu_cacheritem (integer ainumitem)
public function boolean uf_mnu_checkitem (integer ainumitem)
public function boolean uf_mnu_uncheckitem (integer ainumitem)
public function boolean uf_mnu_ischecked (integer ainumitem)
public function boolean uf_mnu_supprimeritem (integer ainumitem)
public function boolean uf_mnu_changertext (integer ainumitem, string astext)
public function string uf_mnu_liretext (integer ainumitem)
public function boolean uf_mnu_ajouteritem (integer ainumitem, string astext)
public subroutine uf_activer_menu (boolean abActivation)
private subroutine uf_ddcalendrier ()
public function boolean uf_settransobject (ref u_transaction atrtrans)
private subroutine uf_ddsaisieeuro ()
public subroutine uf_modifier_choix_monnaie (long alChoixMonnaie)
public function long uf_reinitialiser ()
public function integer of_setitemmanager (boolean ab_switch)
end prototypes

event ue_trier;//*****************************************************************************
//
// Objet 		: U_DataWindow
// Evenement 	: Ue_Trier
//	Auteur		: Erick John Stark
//	Date			: 24/02/1996
// Libellé		: 
// Commentaires: Tri de la DW 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

This.SetSort ( isTri )
This.Sort ()

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event we_touche;//*****************************************************************************
//
// Objet 		: u_DataWindow
// Evenement 	: we_Touche
//	Auteur		: D.Bizien
//	Date			: 13/03/1996
// Libellé		: Controle de la touche pressée
// Commentaires: iiStopTab = 1 on fait tab et on est sur la dernière colonne 
//					  iiStopTab = 2 on fait shift-tab et on est sur la première colonne 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

//Migration PB8-WYNIWYG-03/2006 FM
//if	Not ibGestionTouche Then Return
If	Not ibGestionTouche Then Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

If KeyDown ( keyShift! ) Then

	If KeyDown ( keyTab! ) And This.GetColumn ( ) = ilPremCol Then

		iiStopTab = 2		
	End If
Else

	If KeyDown ( keyTab! ) And This.GetColumn ( ) = ilDernCol Then

		iiStopTab = 1
	End If
End If

If iiStopTab > 0 Then
	This.SetRedraw ( False )
	This.PostEvent ( "ue_BoucleEnr" )
End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_boucleenr;//*****************************************************************************
//
// Objet 		: u_DataWindow
// Evenement 	: ue_BoucleEnr
//	Auteur		: D.Bizien
//	Date			: 13/03/1996
// Libellé		: Repositionnement pour bouclage sur la datawindow
// Commentaires: iiStopTab = 1 on fait tab et on est sur la dernière colonne 
//					  iiStopTab = 2 on fait shift-tab et on est sur la première colonne 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

This.SetFocus ()

Choose Case iiStopTab
Case 1
	This.SetColumn ( ilPremCol )
Case 2
	This.SetColumn ( ilDernCol )
End Choose

iiStopTab = 0		// Reinit pour la fois suivante
This.SetRedraw ( True )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_dropdown;//*-----------------------------------------------------------------
//*
//* Objet 			: u_datawindow
//* Evenement 		: ue_DropDown
//* Auteur			: Erick John Stark
//* Date				: 02/12/1996 15:29:32
//* Libellé			: 
//* Commentaires	: Appel de la construction d'un calendrier,
//*					  ou d'une fenêtre de saisie en Euro
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*		FPI		18/09/2015	[PI056] colonne datetime au format dd/mm/yyyy => calendrier
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Si la colonne est de type DATE, on affiche un calendrier         */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM
If	This.Describe ( This.GetColumnName () + ".ColType" ) = "date" Then
	This.Uf_ddCalendrier ()
//Migration PB8-WYNIWYG-03/2006 FM
	//This.SetActionCode ( 1 )		// Empêche la DDLB d'apparaître
	ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

// [PI056]
If	This.Describe ( This.GetColumnName () + ".ColType" ) = "datetime" and This.Describe ( This.GetColumnName () + ".Format") = "dd/mm/yyyy" Then
	This.Uf_ddCalendrier ()
//Migration PB8-WYNIWYG-03/2006 FM
	//This.SetActionCode ( 1 )		// Empêche la DDLB d'apparaître
	ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If
// :[PI056]

/*------------------------------------------------------------------*/
/* Si la colonne est de type DECIMAL {2}, on affiche une aide à la  */
/* saisie en EUROS.                                                 */
/*------------------------------------------------------------------*/
If	This.Describe ( This.GetColumnName () + ".ColType" ) = "decimal(2)" Then
	This.Uf_ddSaisieEuro ()
//Migration PB8-WYNIWYG-03/2006 FM
//	This.SetActionCode ( 1 )		// Empêche la DDLB d'apparaître
	ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

public subroutine uf_dataobject (string asDataobject);//********************************************************************************
//
// Objet 		: u_Datawindow
// Fonction 	: uf_Dataobject
//	Auteur		: D.Bizien
//	Date			: 14/02/1996
// Objet			: Positionnement du dataobject de la datawindow
//					  
// Commentaires: 
//					  
// -------------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//********************************************************************************

This.Dataobject = asDataobject
end subroutine

public function boolean uf_update ();//*******************************************************************************************
// Fonction            	: u_DataWindow::uf_Update
//	Auteur              	: D.Bizien
//	Date 					 	: 11/03/1996
//	Libellé					: Update sur la datawindow
// Commentaires			: 
//
// Arguments				: Aucun
//
// Retourne					: Booléen - Vrai si l'update s'est bien passé
//								  
//*******************************************************************************************

Return ( This.Update ( True, False ) > 0 )
end function

public subroutine uf_initialisercouleur (string ascolonne[]);//*******************************************************************************************
// Fonction            	: u_DataWindow::uf_InitialiserCouleur
//	Auteur              	: D.Bizien
//	Date 					 	: 13/03/1996
//	Libellé					: Positionnement des attributs conditionnels de couleur des colonnes
// Commentaires			: si l'attribut protect de la colonne est à 1 on met la colonne en
//								  3dRaised - fond gris sinon 3dLowered - fond Blanc
//									sBlanc		= "16777215",	&
//									sVert			= "32768",		&
//									sBleu			= "16711680",	&
//									sGris			= "12632256",	&
//									s3DRaised	= "6",			&
//									s3DLowered	= "5",			&
// Arguments				: asColonne [] - String - tableau contenant la liste des colonnes à initialiser
//
// Retourne					: Rien
//								  
//*******************************************************************************************


String		swModif
String		sRet

Integer		iNbCol
Integer		iCpt

swModif		=	""

iNbCol			=	UpperBound ( asColonne )

For iCpt = 1 to iNbCol

	swModif	=	swModif 																						+ &
					asColonne[iCpt] + ".border='6~t if ( describe ( ~~~""							+ &
						asColonne[iCpt] + ".protect~~~" ) <> ~~'0~~', 6, 5 ) ' "					+ &
					asColonne[iCpt] + ".BackGround.Color='12632256~t if ( describe ( ~~~""	+ &
						asColonne[iCpt] + ".protect~~~" ) <> ~~'0~~', 12632256, 16777215 ) ' " + &
					asColonne[iCpt] + ".BackGround.Mode='0' "	


Next

sRet = This.Modify ( swModif ) 

If sRet <> "" Then MessageBox ( "Erreur", sRet + "~n~r" + swModif )


end subroutine

public subroutine uf_proteger (string ascolonne[], string asprotection);//*******************************************************************************************
// Fonction            	: u_DataWindow::uf_Proteger
//	Auteur              	: D.Bizien
//	Date 					 	: 13/03/1996
//	Libellé					: Protection, deprotection de colonnes
// Commentaires			: 
// Arguments				: asColonne [] - String - tableau contenant la liste des colonnes à initialiser
//								  asProtection - String - 0 pour deprotection, 1 pour protection
//
// Retourne					: Rien
//		
//*******************************************************************************************
// JFF   13/10/2022  J'envoie le modify à chaque fois car la chaine est trop longue et n'est pas totalement interprété
//*******************************************************************************************


String		swModif

Integer		iNbCol, iNbColDiv2
Integer		iCpt

swModif		=	""

iNbCol			=	UpperBound ( asColonne )
iNbColDiv2		=  iNbCol / 2

For iCpt = 1 to iNbCol

	// swModif	=	swModif + asColonne[iCpt] + ".protect = " + asProtection + " "
	swModif	=	asColonne[iCpt] + ".protect = " + asProtection + " "
	This.Modify ( swModif )
Next

// This.Modify ( swModif )

end subroutine

public subroutine uf_filtrer (string asfiltre);//*******************************************************************************************
// Fonction            	: u_DataWindow::uf_Filtrer
//	Auteur              	: D.Bizien
//	Date 					 	: 27/03/1996
//	Libellé					: Filtre de la datawindow en fonction d'un critère
// Commentaires			: Mettre le filtre à "" pour annuler tous les filtres ou à null pour 
//								  permettre à l'opérateur de choisir
// Arguments				: asFiltre - String - filtre à utiliser
//
// Retourne					: Rien
//								  
//*******************************************************************************************


This.SetFilter ( asFiltre )
This.Filter () 
end subroutine

public subroutine uf_desactiver (long alLigneDebut, long alLigneFin);//*******************************************************************************************
// Fonction            	: u_Datawindow::uf_Desactiver
//	Auteur              	: D.Bizien
//	Date 					 	: 27/03/1996
//	Libellé					: Détruit certaines lignes d'une datawindow sans conséquence pour la base
// Commentaires			:
//
// Arguments				: alLigneDebut - Long - Premier ligne à détruire
//								  alLigneFin   - Long - Dernière ligne à détruire
// Retourne					: 
//								  
//*******************************************************************************************

This.RowsMove    ( alLigneDebut, alLigneFin, Primary!, This, This.DeletedCount ( ) + 1, Delete! )
This.RowsDiscard ( This.DeletedCount ( ) - ( alLigneFin - alLigneDebut ) , This.DeletedCount ( ) , delete! ) 

end subroutine

public function long uf_modify (ref string asmod);//*******************************************************************************************
// Fonction            	: Uf_Modify
//	Auteur              	: Erick John Stark
//	Date 					 	: 22/02/1996
//	Libellé					: 
// Commentaires			: Modification de la DW
//
// Arguments				: asMod			String			(Réf)	Chaine de modification
//
// Retourne					: Long			 1 = Ok
//													-1 = Pas Ok
//								  
//*******************************************************************************************

Long lRet
String sRet

lRet	= 1
sRet	= This.Modify ( asMod )

If sRet <> "" Then
	lRet = -lRet
End If

Return ( lRet )
end function

public subroutine uf_indicator (ref picture apIndicator);//*******************************************************************************************
// Fonction            	: Uf_Indicator
//	Auteur              	: Erick John Stark
//	Date 					 	: 22/02/1996
//	Libellé					: 
// Commentaires			: Positionnement d'un Indicator sur la DW
//
// Arguments				: apIndicator	String			(Réf)	Picture Name à assigner
//
// Retourne					: Rien
//								  
//*******************************************************************************************


This.SetRowFocusIndicator ( apIndicator )


end subroutine

public function boolean uf_copierligne ();//*******************************************************************************************
// Fonction            	: u_DataWindow::uf_CopierLigne
//	Auteur              	: La Recrue
//	Date 					 	: 12/12/1996
//	Libellé					: Copie de ligne
// Commentaires			: copie la ligne courrante du Detail affecter sur elle meme.
//								  la ligne est ajoutée a la fin de la DW.
//
// Arguments				: Aucun
//
// Retourne					: Booléen - Vrai si la copie s'est bien passée								  
//*******************************************************************************************

Long				lI, lColCount, lRet
DwItemStatus	lStatus

If ( isValid ( iudwDetailSource ) ) Then

	This.Reset()
	ilLigneDetailSource = iudwDetailSource.GetRow()

	If ( iudwDetailSource.RowsCopy( ilLignedetailSource, ilLignedetailSource, Primary!, This, This.RowCount() + 1, Primary! ) > 0 ) Then
		
		lRet = This.SetItemStatus( 1, 0, Primary!, DataModified! )

		lColCount = Long( This.Describe( "Datawindow.Column.Count" ) )

		For lI = 1 To lColCount
			lStatus = iudwDetailSource.GetItemStatus ( ilLigneDetailSource, lI, Primary! ) 
			lRet = This.SetItemStatus( 1, lI, Primary!, lStatus )
		Next

		lStatus = iudwDetailSource.GetItemStatus ( ilLigneDetailSource , 0, Primary! ) 
		lRet = This.SetItemStatus( 1, 0, Primary!, lStatus )

		Return( True )
	
	Else

		Return ( False )
	End If

Else

	Return ( False )
End If





end function

public function boolean uf_validerligne (boolean abinsert);//*******************************************************************************************
// Fonction            	: u_DataWindow::uf_ValiderLigne
//	Auteur              	: La Recrue
//	Date 					 	: 12/12/1996
//	Libellé					: Validation de ligne
// Commentaires			: Recopie la ligne modifiée sur le detail source
//	
// Arguments				: abInsert	Boolean	( val ) Indique s'il sagit d'une insertion ou pas
//
// Retourne					: Booléen - Vrai si la copie s'est bien passée								  
//*******************************************************************************************
//* N° Modif          Reçue Le          Effectuée Le          PAR
//*
//* MOD-0001          18/03/97            19/03/97				La Recrue
//*
//*-----------------------------------------------------------------



Long				lDeletedCount, lColCount, lI

//Migration PB8-WYNIWYG-03/2006 CP
Long				lg_cursor_sav, lg_selected_line
//Fin Migration PB8-WYNIWYG-03/2006 CP

dwItemStatus	lStatuColonne, lStatuLigne

If ( isValid ( iudwDetailSource ) ) Then
//Migration PB8-WYNIWYG-03/2006 CP
	lg_cursor_sav = iudwDetailSource.GetRow()
	lg_selected_line = iudwDetailSource.GetSelectedRow(0)
//Fin Migration PB8-WYNIWYG-03/2006 CP	

	iudwDetailSource.SetRedraw( False )

	If ( Not abInsert ) Then

		If ( This.RowsCopy( 1, 1, Primary!, iudwDetailSource, ilLigneDetailSource + 1 , Primary! ) > 0 ) Then

/*------------------------------------------------------------------*/
/* Récupération de l'état de la ligne avant la suppression. Si      */
/* elle est en NewModified! alors il est inutile d'effectuer un     */
/* RowDiscard sur le buffer Deleted! car le DeleteRow ne transfert  */
/* pas la ligne dans ce buffer.                                     */
/*------------------------------------------------------------------*/
			lStatuLigne = iudwDetailSource.GetItemStatus ( ilLigneDetailSource, 0, Primary! )

			iudwDetailSource.DeleteRow( ilLigneDetailSource )

			lDeletedCount = iudwDetailSource.DeletedCount()

			If ( lStatuLigne <> NewModified! ) Then

				iudwDetailSource.RowsDiscard( lDeletedCount , lDeletedCount, Delete! )

			End If

			lColCount = Long( iudwDetailSource.Describe( "Datawindow.Column.Count" ) )

			For lI = 1 To lColCount
				lStatuColonne = This.GetItemStatus( 1, lI, Primary! )
				iudwDetailSource.SetItemStatus( ilLigneDetailSource, lI, Primary!, lStatuColonne )
			Next

			lStatuLigne = This.GetItemStatus( 1, 0, Primary! )
			iudwDetailSource.SetItemStatus( ilLigneDetailSource, 0, Primary!, lStatuLigne )

//			iudwDetailSource.TriggerEvent( RowFocusChanged! )
/*------------------------------------------------------------------*/
/* Le 11/10/2006 - Modif DGA.                                       */
/* Problème sur le SetRow qui ne déclenche plus le RowFocusChanged  */
/* de U_DataWindow_Detail.                                          */
/*------------------------------------------------------------------*/
			iudwDetailSource.Event RowFocusChanged(lg_selected_line)
		Else

			iudwDetailSource.SetRedraw( True )
			Return ( False )

		End If

	Else

		If ( This.RowsCopy ( 1, 1, Primary!, iudwDetailSource, iudwDetailSource.Rowcount() + 1 , Primary! ) > 0 ) Then
			iudwDetailSource.SetRow ( iudwDetailSource.Rowcount() ) 
			iudwDetailSource.ScrollToRow ( iudwDetailSource.Rowcount() ) 
			ilLigneDetailSource = iudwDetailSource.GetRow()
/*------------------------------------------------------------------*/
/* Le 11/10/2006 - Modif DGA.                                       */
/* Problème sur le SetRow qui ne déclenche plus le RowFocusChanged  */
/* de U_DataWindow_Detail.                                          */
/*------------------------------------------------------------------*/
			iudwDetailSource.Event RowFocusChanged(iudwDetailSource.Rowcount())

		Else

			iudwDetailSource.SetRedraw( True )
			Return ( False )

		End If 

	End If

	iudwDetailSource.SetRedraw( True )
	
//Migration PB8-WYNIWYG-03/2006 CP
//	If	( Not abInsert )	Then
//		iudwDetailSource.SetRow (lg_cursor_sav)
//		if lg_selected_line > 0 Then iudwDetailSource.SelectRow(lg_selected_line, True)
//	End If
////Fin Migration PB8-WYNIWYG-03/2006 CP
	
	Return ( True )

Else

	Return ( False )

End If
end function

public function boolean uf_detailparent (u_datawindow_detail audwdetail);
//public function boolean uf_detailparent (datawindow audwdetail);
//*******************************************************************************************
// Fonction            	: u_DataWindow::uf_DetailParent
//	Auteur              	: La Recrue
//	Date 					 	: 12/12/1996
//	Libellé					: Affectaition du Detail source
// Commentaires			: Permet d'affecter un détail source a la datawindow pour la copie
//								  de ligne et la validation de ligne
//
// Arguments				: u_datawindow_detail	audwDetail	( DataWindow )
//
// Retourne					: Booléen -  Vrai si l'affectation s'est bien passée
//								  
//*******************************************************************************************

If ( isValid ( audwDetail ) ) Then

	iudwDetailSource = audwDetail
	Return ( True )
Else

	SetNull( iudwDetailSource )
	ilLigneDetailSource = 0
	Return ( False )
End If
end function

public function boolean uf_supprimerligne ();//*******************************************************************************************
// Fonction            	: u_DataWindow::uf_SupprimerLigne
//	Auteur              	: La Recrue
//	Date 					 	: 12/12/1996
//	Libellé					: Suppression d'une ligne sur un détail source
// Commentaires			: 
//	
// Arguments				: Aucun
//
// Retourne					: Booléen - Vrai si la copie s'est bien passée								  
//*******************************************************************************************

Boolean bOk

If ( isValid ( iudwDetailSource ) ) Then

	iudwDetailSource.SetRedraw( False )

	bOk = ( iudwDetailSource.DeleteRow( ilLigneDetailSource ) > 0 )

	If ( iudwDetailSource.Rowcount() > 0 ) Then

		iudwDetailSource.SetRow( Max ( ilLigneDetailSource - 1, 1 ) )
		iudwDetailSource.ScrollToRow( Max ( ilLigneDetailSource - 1, 1 ) )

		If ilLigneDetailSource = 1 Then
			iudwDetailSource.TriggerEvent( RowFocusChanged! )
		End If
			
	End If

	iudwDetailSource.SetRedraw( True )

	Return ( bOk )
Else

	Return ( False )
End If
end function

public function boolean uf_mnu_interdiritem (integer ainumitem);//*******************************************************************************************
// Fonction            	: Uf_Mnu_InterdirItem
//	Auteur              	: La Recrue
//	Date 					 	: 16/12/1996
//	Libellé					: 
// Commentaires			: Interdit l'acces a un item du menu contextuel
//
// Arguments				: Integer		aiNumItem	(Val)	N° de l'item dont l'accès doit être
//																			Interdit
// Retourne					: Boolean		True si l'indice ne déborde pas (15 item max).
//								  
//*******************************************************************************************

If ( aiNumItem > 15 ) Then

	Return False

End If

	imContext.m_MenuContext.Item[ aiNumItem ].Enabled = False

Return True
end function

public function boolean uf_mnu_autoriseritem (integer ainumitem);//*******************************************************************************************
// Fonction            	: Uf_Mnu_AutoriserItem
//	Auteur              	: La Recrue
//	Date 					 	: 16/12/1996
//	Libellé					: 
// Commentaires			: Autorise l'acces a un item du menu contextuel
//
// Arguments				: Integer		aiNumItem	(Val)	N° de l'item dont l'accès doit être
//																			Autorisé
// Retourne					: Boolean		True si l'indice ne déborde pas (15 item max).
//								  
//*******************************************************************************************

If ( aiNumItem > 15 ) Then

	Return False

End If

	imContext.m_MenuContext.Item[ aiNumItem ].Enabled = True

Return True
end function

public function boolean uf_mnu_montreritem (integer ainumitem);//*******************************************************************************************
// Fonction            	: Uf_Mnu_MontrerItem
//	Auteur              	: La Recrue
//	Date 					 	: 16/12/1996
//	Libellé					: 
// Commentaires			: Autorise l'acces a un item du menu contextuel
//
// Arguments				: Integer		aiNumItem	(Val)	N° de l'item dont l'accès doit être
//																			Autorisé
// Retourne					: Boolean		True si l'indice ne déborde pas (15 item max).
//								  
//*******************************************************************************************

If ( aiNumItem > 15 ) Then

	Return False

End If

	imContext.m_MenuContext.Item[ aiNumItem ].Visible = True

Return True
end function

public function boolean uf_mnu_cacheritem (integer ainumitem);//*******************************************************************************************
// Fonction            	: Uf_Mnu_CacherItem
//	Auteur              	: La Recrue
//	Date 					 	: 16/12/1996
//	Libellé					: 
// Commentaires			: permet de Chcher un item du menu contextuel
//
// Arguments				: Integer		aiNumItem	(Val)	N° de l'item qui doit être Cacher
//																			
// Retourne					: Boolean		True si l'indice ne déborde pas (15 item max).
//								  
//*******************************************************************************************

If ( aiNumItem > 15 ) Then

	Return False

End If

	imContext.m_MenuContext.Item[ aiNumItem ].Visible = False

Return True
end function

public function boolean uf_mnu_checkitem (integer ainumitem);//*******************************************************************************************
// Fonction            	: Uf_Mnu_CheckItem
//	Auteur              	: La Recrue
//	Date 					 	: 16/12/1996
//	Libellé					: 
// Commentaires			: Check un item du menu contextuel
//
// Arguments				: Integer		aiNumItem	(Val)	N° de l'item qui doit être "checké"
//
// Retourne					: Boolean		True si l'indice ne déborde pas (15 item max).
//								  
//*******************************************************************************************

If ( aiNumItem > 15 ) Then

	Return False

End If

	imContext.m_MenuContext.Item[ aiNumItem ].Checked = True

Return True
end function

public function boolean uf_mnu_uncheckitem (integer ainumitem);//*******************************************************************************************
// Fonction            	: Uf_Mnu_UncheckItem
//	Auteur              	: La Recrue
//	Date 					 	: 16/12/1996
//	Libellé					: 
// Commentaires			: Uncheck un item du menu contextuel
//
// Arguments				: Integer		aiNumItem	(Val)	N° de l'item qui doit être "déchecké"
//
// Retourne					: Boolean		True si l'indice ne déborde pas (15 item max).
//								  
//*******************************************************************************************

If ( aiNumItem > 15 ) Then

	Return False

End If

	imContext.m_MenuContext.Item[ aiNumItem ].Checked = False

Return True
end function

public function boolean uf_mnu_ischecked (integer ainumitem);//*******************************************************************************************
// Fonction            	: Uf_Mnu_IsChecked
//	Auteur              	: La Recrue
//	Date 					 	: 16/12/1996
//	Libellé					: 
// Commentaires			: Determine si un menu est "checké" ou pas
//
// Arguments				: Integer		aiNumItem	(Val)	N° de l'item qui doit être teste
//
// Retourne					: Boolean		True si l'indice ne déborde pas (15 item max) ou que l'item est "checké"
//								  					False si l'indice déborde, ou que l'item nest pas "checké"
//*******************************************************************************************

If ( aiNumItem > 15 ) Then

	Return False

End If

Return ( imContext.m_MenuContext.Item[ aiNumItem ].Checked ) 


end function

public function boolean uf_mnu_supprimeritem (integer ainumitem);//*******************************************************************************************
// Fonction            	: Uf_Mnu_SupprimerItem
//	Auteur              	: La Recrue
//	Date 					 	: 16/12/1996
//	Libellé					: 
// Commentaires			: Permet de supprimer un Item au menu contextuel
//
// Arguments				: Integer		aiNumItem	(Val)	N° de l'item Voulu
//													
// Retourne					: Boolean		True si l'indice ne déborde pas (15 item max).
//								  
//*******************************************************************************************

If ( aiNumItem > 15 ) Then

	Return False

End If

	uf_Mnu_CacherItem( aiNumItem )
	uf_Mnu_InterdirItem( aiNumItem )
	imContext.m_MenuContext.Item[ aiNumItem ].Text = "Item" + String( aiNumItem )

Return True
end function

public function boolean uf_mnu_changertext (integer ainumitem, string astext);//*******************************************************************************************
// Fonction            	: Uf_Mnu_AjouterItem
//	Auteur              	: La Recrue
//	Date 					 	: 16/12/1996
//	Libellé					: 
// Commentaires			: Permet d'ajouter un Item au menu contextuel
//
// Arguments				: Integer		aiNumItem	(Val)	N° de l'item Voulu
//													asText		(Val) Texte de l'item
// Retourne					: Boolean		True si l'indice ne déborde pas (15 item max).
//								  
//*******************************************************************************************

If ( aiNumItem > 15 ) Then

	Return False

End If

	imContext.m_MenuContext.Item[ aiNumItem ].Text = asText
//	uf_Mnu_AutoriserItem( aiNumItem )
//	uf_Mnu_MontrerItem( aiNumItem )

Return True
end function

public function string uf_mnu_liretext (integer ainumitem);//*******************************************************************************************
// Fonction            	: Uf_Mnu_LireText
//	Auteur              	: La Recrue
//	Date 					 	: 16/12/1996
//	Libellé					: 
// Commentaires			: Permet de connaitre le text d'un item
//
// Arguments				: Integer		aiNumItem	(Val)	N° de l'item Voulu
//													
// Retourne					: String			"" si l'indice ne déborde pas (15 item max) 
//								  					le text de l'item voulu sinon
//*******************************************************************************************

If ( aiNumItem > 15 ) Then

	Return ""

End If

Return ( imContext.m_MenuContext.Item[ aiNumItem ].Text ) 


end function

public function boolean uf_mnu_ajouteritem (integer ainumitem, string astext);//*******************************************************************************************
// Fonction            	: Uf_Mnu_AjouterItem
//	Auteur              	: La Recrue
//	Date 					 	: 16/12/1996
//	Libellé					: 
// Commentaires			: Permet d'ajouter un Item au menu contextuel
//
// Arguments				: Integer		aiNumItem	(Val)	N° de l'item Voulu
//													asText		(Val) Texte de l'item
// Retourne					: Boolean		True si l'indice ne déborde pas (15 item max).
//								  
//*******************************************************************************************

If ( aiNumItem > 15 ) Then

	Return False

End If

	If ( asText <> "" ) Then
		imContext.m_MenuContext.Item[ aiNumItem ].Text = asText
	End If
	uf_Mnu_AutoriserItem( aiNumItem )
	uf_Mnu_MontrerItem( aiNumItem )

Return True
end function

public subroutine uf_activer_menu (boolean abActivation);//*******************************************************************************************
// Fonction            	: Uf_Activer_Menu
//	Auteur              	: La Recrue
//	Date 					 	: 05/12/1996
//	Libellé					: 
// Commentaires			: Permet d'activer ou de désactiver le menu contextuel
//
// Arguments				: Boolean		abActivation	(Val)	Choix d'activation ou non
//
// Retourne					: (None)
//								  
//*******************************************************************************************

ibMenuActif = abActivation


end subroutine

private subroutine uf_ddcalendrier ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ddCalendrier ( Private )
//* Auteur			: Erick John Stark
//* Date				: 02/12/1996 15:32:35
//* Libellé			: 
//* Commentaires	: Affichage d'un calendrier
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

s_Calendrier stCal
Environment stEnv
Integer iX, iY, iCalendrierHauteur
String sCol, sText
Long lLig
Window wParent

SetPointer ( HourGlass! )

/*------------------------------------------------------------------*/
/* Si la date n'est pas bonne on ressort tout de suite              */
/*------------------------------------------------------------------*/

sText = This.GetText ()

If	sText = "" Or sText = "01/01/1900" Then sText = String ( Today () )

If	Not IsDate ( sText ) Then	Return

stCal.dInit 	= Date ( sText )

sCol	= This.GetColumnName ()
lLig	= This.GetRow ()

iX		= This.X
iY		= This.Y

wParent = Parent

stCal.iX = wParent.WorkSpaceX () + iX + Integer ( This.Describe ( sCol + ".X" ) ) - 2
stCal.iY = wParent.WorkSpaceY () + iY + Integer ( This.Describe ( sCol + ".Y" ) ) &
				+ Integer ( This.Describe ( sCol + ".Height" ) ) + 12

iCalendrierHauteur = 695
GetEnvironment ( stEnv )

/*------------------------------------------------------------------*/
/* Je populise exprés une structure basée sur l'environnement,      */
/* bien que celle-ci puisse exister dans stGLB                      */
/*------------------------------------------------------------------*/

If	stCal.iY + iCalendrierHauteur > PixelsToUnits ( stEnv.ScreenHeight, YPixelsToUnits! ) Then
	stCal.iY -= Integer ( This.Describe ( sCol + ".Height" ) ) + iCalendrierHauteur + 48
End If

stCal.wParent	= Parent
stCal.dwTrt		= This
stCal.sCol		= sCol
stCal.iChoix	= 1

OpenWithParm ( w_Calendrier, stCal )

This.SetColumn ( sCol )
end subroutine

public function boolean uf_settransobject (ref u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_SetTransObject
//* Auteur			: Erick John Stark
//* Date				: 09/08/1996 14:41:42
//* Libellé			: 
//* Commentaires	: Positionnement de l'objet de transaction de la datawindow
//*
//* Arguments		: 
//*
//* Retourne		: Booléen
//*								
//*-----------------------------------------------------------------

Boolean	bOk
Long		lRet

bOk 	= True
lRet	= This.SetTransObject ( atrTrans )

If	lRet > 0 Then	
	itrTrans = atrTrans
Else
	bOk = False
End If

Return ( bOK )

end function

private subroutine uf_ddsaisieeuro ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ddSaisieEuro ( Private )
//* Auteur			: Erick John Stark
//* Date				: 02/12/1996 15:32:35
//* Libellé			: 
//* Commentaires	: Affichage d'une saisie en EURO
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

s_Euro stEuro
Environment stEnv
Integer iX, iY, iEuroHauteur
String sCol, sText
Long lLig
Window wParent

SetPointer ( HourGlass! )

/*------------------------------------------------------------------*/
/* Si le montant n'est pas positif, ou si la zone ne correspond pas */
/* à un nombre on ressort tout de suite.                            */
/*------------------------------------------------------------------*/
sText = This.GetText ()

If	Not IsNumber ( sText ) Then Return

If	Dec ( sText ) < 0 Then Return

stEuro.dcMtInitial 	= Dec ( sText )

sCol	= This.GetColumnName ()
lLig	= This.GetRow ()

iX		= This.X
iY		= This.Y

wParent = Parent

stEuro.iX = wParent.WorkSpaceX () + iX + Integer ( This.Describe ( sCol + ".X" ) ) - 2
stEuro.iY = wParent.WorkSpaceY () + iY + Integer ( This.Describe ( sCol + ".Y" ) ) &
				+ Integer ( This.Describe ( sCol + ".Height" ) ) + 12

iEuroHauteur = 160
GetEnvironment ( stEnv )

/*------------------------------------------------------------------*/
/* Je populise exprés une structure basée sur l'environnement,      */
/* bien que celle-ci puisse exister dans stGLB                      */
/*------------------------------------------------------------------*/

If	stEuro.iY + iEuroHauteur > PixelsToUnits ( stEnv.ScreenHeight, YPixelsToUnits! ) Then
	stEuro.iY -= Integer ( This.Describe ( sCol + ".Height" ) ) + iEuroHauteur + 48
End If

stEuro.wParent	= Parent
stEuro.dwTrt	= This
stEuro.sCol		= sCol

OpenWithParm ( w_Euro, stEuro )

This.SetColumn ( sCol )
end subroutine

public subroutine uf_modifier_choix_monnaie (long alChoixMonnaie);//*-----------------------------------------------------------------
//*
//* Fonction		: U_DataWindow::Uf_Modifier_Choix_Monnaie (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 31/03/1999 15:43:30
//* Libellé			: 
//* Commentaires	: Modification de la valeur d'instance PRIVATE ilChoixMonnaie
//*
//* Arguments		: Long			alChoixMonnaie			(Val)	Valeur de la zone
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Cette fonction sert à armer la valeur d'insance ilChoixMonnaie.  */
/* Par défaut, cette valeur est initialisée à 2 dans le             */
/* constructor de la DW. Cette valeur dépent du paramètrage du      */
/* produit.                                                         */
/*------------------------------------------------------------------*/

ilChoixMonnaie = alChoixMonnaie

end subroutine

public function long uf_reinitialiser ();//*******************************************************************************************
// Fonction            	: Uf_Reinitialiser ()
//	Auteur              	: D.Bizien
//	Date 					 	: 15/03/1996
//	Libellé					: Réinitialisation d'une zone après traitement d'erreur sur itemError 
// Commentaires			: iiReset = 0 : on remet la valeur initiale.
//								  iiReset = 1 : on repositionne la zone à nul.
//								  iiReset = 2 : on garde la valeur saisie.
//								  iiReset et iiErreur sont réinitialiser pour la fois suivante
// Arguments				: Aucun
//
// Retourne					: Rien
//								  
//*******************************************************************************************

String		sType					//	Type de colonne.
Decimal		dcValeur

sType = This.Describe ( This.GetColumnName ( ) + ".coltype" )

Choose Case Left ( sType, 4 )

	Case "char"					// String

		Choose Case iiReset

			Case 0
				This.SetItem ( This.GetRow ( ), This.GetColumnName ( ), &
							This.GetItemString ( This.GetRow ( ), This.GetColumnName ( ) ) )

			Case 1
				This.SetItem ( This.GetRow ( ), This.GetColumnName ( ), stNul.str )

			Case 2
			/*------------------------------------------------------------------*/
			/* On laisse la valeur saisie mais on ne la positionne pas dans la  */
			/* colonne.                                                         */
			/*------------------------------------------------------------------*/

		End Choose

	Case "numb"					// Variable numérique

		Choose Case iiReset

			Case 0
				This.SetItem ( This.GetRow ( ), This.GetColumnName ( ), &
							This.GetItemNumber ( This.GetRow ( ), This.GetColumnName ( ) ) )

			Case 1
				This.SetItem ( This.GetRow ( ), This.GetColumnName ( ), stNul.iNum )

			Case 2
			/*------------------------------------------------------------------*/
			/* On laisse la valeur saisie mais on ne la positionne pas dans la  */
			/* colonne.                                                         */
			/*------------------------------------------------------------------*/

		End Choose

	Case "deci"					// Type décimal

		Choose Case iiReset

			Case 0
				dcValeur = This.GetItemDecimal ( This.GetRow ( ), This.GetColumnName ( ) )
				This.SetItem ( This.GetRow ( ), This.GetColumnName ( ), dcValeur )


			Case 1
				This.SetItem ( This.GetRow ( ), This.GetColumnName ( ), stNul.dcm )

			Case 2
			/*------------------------------------------------------------------*/
			/* On laisse la valeur saisie mais on ne la positionne pas dans la  */
			/* colonne.                                                         */
			/*------------------------------------------------------------------*/

		End Choose

	Case "date"

		If( sType = "datetime" ) Then		// datetime

			Choose Case iiReset

				Case 0
					This.SetItem ( This.GetRow ( ), This.GetColumnName ( ), &
								This.GetItemDatetime ( This.GetRow ( ), This.GetColumnName ( ) ) )

				Case 1
					This.SetItem ( This.GetRow ( ), This.GetColumnName ( ), stNul.dtm )

				Case 2
					/*------------------------------------------------------------------*/
					/* On laisse la valeur saisie mais on ne la positionne pas dans la  */
					/* colonne.                                                         */
					/*------------------------------------------------------------------*/

			End Choose

		Else										// date

			Choose Case iiReset

				Case 0
					This.SetItem ( This.GetRow ( ), This.GetColumnName ( ), &
								This.GetItemDate ( This.GetRow ( ), This.GetColumnName ( ) ) )

				Case 1
					This.SetItem ( This.GetRow ( ), This.GetColumnName ( ), stNul.dat )

				Case 2
					/*------------------------------------------------------------------*/
					/* On laisse la valeur saisie mais on ne la positionne pas dans la  */
					/* colonne.                                                         */
					/*------------------------------------------------------------------*/

			End Choose

		End If

	Case "time"									// Time

		Choose Case iiReset

			Case 0
				This.SetItem ( This.GetRow ( ), This.GetColumnName ( ), &
							This.GetItemTime ( This.GetRow ( ), This.GetColumnName ( ) ) )

			Case 1
				This.SetItem ( This.GetRow ( ), This.GetColumnName ( ), stNul.tim )

			Case 2
				/*------------------------------------------------------------------*/
				/* On laisse la valeur saisie mais on ne la positionne pas dans la  */
				/* colonne.                                                         */
				/*------------------------------------------------------------------*/

		End Choose

End Choose

iiErreur		= 0					//	Réinit des variables d'instance
iiReset		= 0
iiStopTab	= 0
//Migration PB8-WYNIWYG-03/2006 FM
//This.SetActionCode( 1 )
return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

public function integer of_setitemmanager (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//	Public Function:	of_SetItemManager
//	Arguments:		boolean
//   					true  - Start (create) the service
//   					false - Stop (destroy ) the service
//	Returns:			Integer - 1 if Successful operation, 0 = No action taken and -1 if an error occured
//						1 - Successful operation.
//						0 - No action taken.
//						-1 - An error was encountered.
//	Description:  	Starts or stops the Item Manager SErvice.  This service
//					  	provides Get/setItem Extended capability
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
// [SUISSE].ID_LANG	VErsion Initiale du line avec l'item manager
//////////////////////////////////////////////////////////////////////////////

// Check arguments
if IsNull(ab_switch) then return -1

if ab_Switch then
	if IsNull(invIM) or not IsValid (invIM) then
		invIM = Create n_cst_dwsrv_itemmanager
		invIM.of_SetRequestor ( this )
		return 1
	end if
else 
	if IsValid ( invIM ) then
		Destroy invIM
		return 1
	end if	
end if

return 0
end function

event itemerror;//*****************************************************************************
//
// Objet 		: U_DataWindow
// Evenement 	: ItemError
//	Auteur		: Erick John Stark
//	Date			: 24/02/1996
// Libellé		: 
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

String sText, sType, sVal

ibErreur		= True
isErrCol		= Upper ( This.GetColumnName () )

//Migration PB8-WYNIWYG-03/2006 FM
//sText			= This.GetText ()
sText	= data
//Fin Migration PB8-WYNIWYG-03/2006 FM

If	sText = "" Then

	sVal	= This.GetColumnName () + ".ColType"
	sType	= This.Describe ( sVal )

// Interrogation sur l'utilité du code - JCA - 11/04/2006

//Migration PB8-WYNIWYG-03/2006 FM
//évite de vider le champ d'une DropDownListBox en cas d'utilisation des flèches haut et bas
//	Boolean Lb_ddlb
//	Lb_ddlb = (Len(This.Describe(This.GetColumnName ()+".ddlb.allowedit")) > 1)
//	if Lb_ddlb and sText = "" and ( Left ( sType, 4 ) = "deci" ) then 
//		This.Post SetItem(This.GetRow(), This.GetColumnName (), This.GetItemNumber(This.GetRow(), This.GetColumnName ()))
//	end if
//Fin Migration PB8-WYNIWYG-03/2006 FM

	Choose Case sType
	Case "date"
		This.SetItem ( This.GetRow (), This.GetColumn (), stNul.dat )

	Case "time"
		This.SetItem ( This.GetRow (), This.GetColumn (), stNul.tim )

	Case "number"
		This.SetItem ( This.GetRow (), This.GetColumn (), stNul.iNum )

	Case "datetime"
		This.SetItem ( This.GetRow (), This.GetColumn (), stNul.dtm )

	End Choose

	If 		( Left ( sType, 4 ) = "char" ) Then
				This.SetItem ( This.GetRow (), This.GetColumn (), stNul.str )

	ElseIf	( Left ( sType, 4 ) = "deci" ) Then
				This.SetItem ( This.GetRow (), This.GetColumn (), stNul.dcm )
	
	End If
//Migration PB8-WYNIWYG-03/2006 FM
//	This.SetActionCode ( 3 )
	ll_ret = 3
//Fin Migration PB8-WYNIWYG-03/2006 FM
	ibErreur		=	False

End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event constructor;//*****************************************************************************
//
// Objet 		: U_DataWindow
// Evenement 	: Constructor
//	Auteur		: Erick John Stark
//	Date			: 24/02/1996
// Libellé		: 
// Commentaires: Initialisation des variables d'instances
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

isTri 		= "#1 A"
isJointure	= ""
ilPremCol 	= 1
ilDernCol 	= Long ( This.Describe ( "datawindow.column.count" ) )
iiStopTab 	= 0
ibMenuActif = True
imContext	= CREATE m_Context

/*------------------------------------------------------------------*/
/* Le 02/06/1998.                                                   */
/* La gestion du scrolling sur les colonnes de la DW pose un        */
/* problème.                                                        */
/*------------------------------------------------------------------*/
/* On est positionné sur l'objet U_DataWindow, on prend en compte   */
/* la gestion de We_Touche.                                         */
/*------------------------------------------------------------------*/
ibGestionTouche = True

/*------------------------------------------------------------------*/
/* Le 31/03/1999.                                                   */
/* Modification DGA, pour la gestion de l'EURO.                     */
/* Ajout d'une variable d'instance. ( ilChoixMonnaie ).             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On initialise cette valeur à 4. E XXXX.XX ( FRF XXX.XX )         */
/* Depuis le passage à l'Euro                                       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Il existe une fonction pour modifier cette instance.             */
/* Uf_Modifier_Choix_Monnaie ()                                     */
/*------------------------------------------------------------------*/
ilChoixMonnaie = 4

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event rbuttondown;//*****************************************************************************
//
// Objet 		: U_DataWindow
// Evenement 	: RboutonDonw
//	Auteur		: La Recrue
//	Date			: 12/12/1996
// Libellé		: Gestion du menu contextuel
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
// #1 FS       02/08/2001 : Modif pour visualiser les mt euro en francs sur clic droit
// #2 WYNIWYG	21/06/2004 : F. Musso modifié pour résoudre le problème du menu 
//									contextuel sur les fenêtres avec une titlebar suite à la
//									Migration PB8-WYNIWYG-03/2004
// #3 PHG		22/02/2008 : [SUISSE].LOT3 : Desactivation PopupMenu Conversion Euro
//*****************************************************************************

w_Ancetre	wParent

Long			lX, lY, lPos, lLig
String sPointeur, sType, sNomCol, sText, sMontant
Decimal {2} dcMontant

s_Euro_Luc stEuroLuc
Environment stEnv
Integer iX, iY, iEuroHauteur

m_copie_colle	lm_cp	//rajout menu copie-colle suite Migration PB8-WYNIWYG-03/2004
//Migration PB8-WYNIWYG-03/2006 FM
powerObject lpo1
//Fin Migration PB8-WYNIWYG-03/2006 FM

If ( ibMenuActif ) Then

//Migration PB8-WYNIWYG-03/2006 FM
	lpo1 = Parent
	if lpo1.TypeOf() = Window! then 
//Fin Migration PB8-WYNIWYG-03/2006 FM
		wParent		= Parent
		This.TriggerEvent( "ue_ModifierMenu" )
	
		If ( wParent.WindowType = Main! ) Then
	
			lX = wParent.X	+ 10	+	wParent.PointerX()
			lY = wParent.Y	+ 230	+	wParent.PointerY()
		Else
	
			If ( wParent.WindowType = Popup! ) Then
	
				lX = wParent.PointerX()
				lY = wParent.PointerY()
	
			Else
	
				lX = wParent.ParentWindow().X	+	10		+ wParent.X	+ 10	+ wParent.PointerX()
				lY = wParent.ParentWindow().Y	+	230	+ wParent.Y	+ 80	+ wParent.PointerY()
	
			End If
		End If
	end if
//Migration PB8-WYNIWYG-03/2006 FM
	integer	li_ret
	li_ret = imContext.m_MenuContext.PopMenu( lX, lY )
//Fin Migration PB8-WYNIWYG-03/2006 FM
//rajout menu copie-colle suite Migration PB8-WYNIWYG-03/2004
	if imContext.mf_nb_visible() = 0 then
		lm_cp = create m_copie_colle
		lm_cp.mf_gest()
		li_ret = lm_cp.PopMenu( lX, lY )
	end if
//fin rajout menu copie-colle suite Migration PB8-WYNIWYG-03/2004
Else
/*------------------------------------------------------------------*/
/* Le 31/03/1999.                                                   */
/* Modification DGA, pour la gestion de l'EURO.                     */
/* Ajout d'une variable d'instance. ( ilChoixMonnaie ).             */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Si la colonne est de type DECIMAL{2}, et qu'elle posséde un      */
/* pointeur K:\PB4OBJ\BMP\EURO.CUR, on affiche une fenêtre avec le  */
/* montant en euros en consultation.                                */
/*------------------------------------------------------------------*/
	sText = This.GetObjectAtPointer ()

	If	sText <> "" Then
		lPos		= Pos ( sText, "~t" )
		sNomCol	= Left ( sText, lPos - 1 )
		lLig 		= Long ( Mid( sText, lPos + 1 ) )

		sType			= This.Describe ( sNomCol + ".ColType" )
		sPointeur	= Upper ( This.Describe ( sNomCol + ".Pointer" ) )
// [SUISSE].LOT3 Desactivation Conversion Automatique Euro/francs		
//		If	sType = "decimal(2)"	And sPointeur = "K:\PB4OBJ\BMP\EURO.CUR"	Then
//			dcMontant = This.GetItemNumber ( lLig, sNomCol )
///*------------------------------------------------------------------*/
///* Si le montant est NULL, on positionne la valeur à 0.             */
///*------------------------------------------------------------------*/
//			If	IsNull ( dcMontant )	Then dcMontant = 0.00
///*------------------------------------------------------------------*/
///* On récupére la chaine formatée pour la monnaie.                  */
///*------------------------------------------------------------------*/
//			sMontant = F_Monnaie ( dcMontant, ilChoixMonnaie, " " )
//
///*------------------------------------------------------------------*/
///* On arme tous les éléments de la structure de passage pour        */
///* pouvoir ouvrir le fenêtre.                                       */
///*------------------------------------------------------------------*/
//
//         // ... #1 Début de modification
//
//         If stGLB.sMonnaieFormatDesire = "EURO" Then
//				stEuroLuc.dcMontantEuro 		= dcMontant * stGLB.Tx_Euro
//         Else
//				stEuroLuc.dcMontantEuro 		= dcMontant / stGLB.Tx_Euro
//         End If
//
//         // ... #1 Fin de modification
//
//			stEuroLuc.sMontantClipBoard 	= sMontant
//
//			iX		= This.X
//			iY		= This.Y
//
//			wParent = Parent
//
//			stEuroLuc.iW = Integer ( This.Describe ( sNomCol + ".Width" ) )
//			stEuroLuc.iX = wParent.WorkSpaceX () + iX + Integer ( This.Describe ( sNomCol + ".X" ) ) - 2
//			stEuroLuc.iY = wParent.WorkSpaceY () + iY + Integer ( This.Describe ( sNomCol + ".Y" ) ) &
//					+ Integer ( This.Describe ( sNomCol + ".Height" ) ) + 12
//
//			iEuroHauteur = 160
//			GetEnvironment ( stEnv )
///*------------------------------------------------------------------*/
///* Je populise exprés une structure basée sur l'environnement,      */
///* bien que celle-ci puisse exister dans stGLB                      */
///*------------------------------------------------------------------*/
//			If	stEuroLuc.iY + iEuroHauteur > PixelsToUnits ( stEnv.ScreenHeight, YPixelsToUnits! ) Then
//				stEuroLuc.iY -= Integer ( This.Describe ( sNomCol + ".Height" ) ) + iEuroHauteur + 48
//			End If
//
//			stEuroLuc.wParent	= Parent
//
//			OpenWithParm ( w_Euro_Luc, stEuroLuc )
//
//		End If
	End If
//rajout menu copie-colle suite Migration PB8-WYNIWYG-03/2004
	lm_cp = create m_copie_colle
	
//Migration PB8-WYNIWYG-03/2006 FM
	lpo1 = Parent
	if lpo1.TypeOf() = Window! then 
//Fin Migration PB8-WYNIWYG-03/2006 FM
		wParent		= Parent
		If ( wParent.WindowType = Main! ) Then
			lX = wParent.X	+ 10	+	wParent.PointerX()
			lY = wParent.Y	+ 230	+	wParent.PointerY()
		Else
			If ( wParent.WindowType = Popup! ) Then
				lX = wParent.PointerX()
				lY = wParent.PointerY()
			Else
				lX = wParent.ParentWindow().X	+	10		+ wParent.X	+ 10	+ wParent.PointerX()
				lY = wParent.ParentWindow().Y	+	230	+ wParent.Y	+ 80	+ wParent.PointerY()
			End If
		End If
		lm_cp.mf_gest()
		li_ret = lm_cp.PopMenu( lX, lY )
	end if
//fin rajout menu copie-colle suite Migration PB8-WYNIWYG-03/2004
End If

//rajout menu copie-colle suite Migration PB8-WYNIWYG-03/2004
if IsValid(lm_cp) then destroy lm_cp
//fin rajout menu copie-colle suite Migration PB8-WYNIWYG-03/2004

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event itemchanged;//*****************************************************************************
//
// Objet 		: U_DataWindow
// Evenement 	: ItemChanged
//	Auteur		: Erick John Stark
//	Date			: 24/02/1996
// Libellé		: 
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//	DBI			03/03/98	Déclenchement itemerror si chaine vide permettant la gestion du null 
//*****************************************************************************
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

// Modif DBI : Déclenchement ItemError si text vide ( fonctionnement standard pb3 )

//Migration PB8-WYNIWYG-03/2006 FM
//If	This.GetText () = "" Then
If	data = "" Then
//Fin Migration PB8-WYNIWYG-03/2006 FM
	iiCarNul = 1
//Migration PB8-WYNIWYG-03/2006 FM
//	This.SetActionCode 	( 1 )
	ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
Else

	iiCarNul 	=  0
	iiErreur		=	0
	ibErreur		=	False
End If

isNomCol		=	Upper ( This.GetColumnName () )

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM
end event

event dberror;//*-----------------------------------------------------------------
//*
//* Objet 			: u_datawindow
//* Evenement 		: DbError
//* Auteur			: Erick John Stark
//* Date				: 09/08/1996 11:40:16
//* Libellé			: 
//* Commentaires	: Génération des messages d'erreurs 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
//F_DbErreur ( This.DbErrorCode (), This.DbErrorMessage (), This.itrTrans )
F_DbErreur ( sqldbcode, SQLErrText, This.itrTrans )
//Fin Migration PB8-WYNIWYG-03/2006 FM
This.SetFocus ()
//Migration PB8-WYNIWYG-03/2006 FM
//This.SetActionCode ( 1 )
return 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
end event

event destructor;//*****************************************************************************
//
// Objet 		: U_DataWindow
// Evenement 	: Destructor
//	Auteur		: La Recrue
//	Date			: 13/12/1996
// Libellé		: 
// Commentaires: Destruction des objets instanciés
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

//Migration PB8-WYNIWYG-03/2006 FM
//Destroy imContext	
If IsValid(imContext) Then Destroy imContext

Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event retrievestart;//*****************************************************************************
//
// Objet 		: U_DataWindow
// Evenement 	: RetrieveStart
//	Auteur		: Erick John Stark
//	Date			: 24/02/1996
// Libellé		: 
// Commentaires: Début du Retrieve
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

ilNbrLig = 0

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event itemfocuschanged;//*****************************************************************************
//
// Objet 		: U_DataWindow
// Evenement 	: ItemFocusChanged
//	Auteur		: Erick John Stark
//	Date			: 24/02/1996
// Libellé		: 
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************


ibErreur		=	False

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event retrieveend;//*****************************************************************************
//
// Objet 		: U_DataWindow
// Evenement 	: RetrieveEnd
//	Auteur		: Erick John Stark
//	Date			: 24/02/1996
// Libellé		: 
// Commentaires: Fin du Retrieve
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

This.TriggerEvent ( "Ue_Trier" )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on u_datawindow.create
end on

on u_datawindow.destroy
end on

