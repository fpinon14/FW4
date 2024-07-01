HA$PBExportHeader$u_treeview.sru
$PBExportComments$----} UserObjet visuel pour simuler un TreeView
forward
global type u_treeview from datawindow
end type
end forward

global type u_treeview from datawindow
int Width=494
int Height=361
int TabOrder=1
string DataObject="d_arbre"
boolean VScrollBar=true
event ue_keydown pbm_dwnkey
event ue_selection_ligne pbm_custom01
end type
global u_treeview u_treeview

type variables
Public :
	U_Gs_TreeView		iuoGsTreeView

end variables

on ue_keydown;//*-----------------------------------------------------------------
//*
//* Objet 			: U_TreeView::Ue_KeyDown
//* Evenement 		: Ue_KeyDown
//* Auteur			: Erick John Stark
//* Date				: 30/04/1998 18:02:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	IsValid ( iuoGsTreeView )	Then
	iuoGsTreeView.Uf_KeyDown ()
End If

end on

on rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet 			: U_TreeView::RButtonDown
//* Evenement 		: RButtonDown
//* Auteur			: Erick John Stark
//* Date				: 30/04/1998 18:02:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Window wParent

If	IsValid ( iuoGsTreeView )	Then
	wParent = Parent
	iuoGsTreeView.Uf_RButtonDown ( wParent )
End If

end on

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: U_TreeView::Constructor
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 30/04/1998 18:02:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation du NVUO qui contient les m$$HEX1$$e900$$ENDHEX$$thodes
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuoGsTreeView = Create U_Gs_TreeView


end on

on rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: U_TreeView::RowFocusChanged
//* Evenement 		: RowFocusChanged
//* Auteur			: Erick John Stark
//* Date				: 30/04/1998 18:02:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	IsValid ( iuoGsTreeView )	Then
	iuoGsTreeView.Uf_RowFocusChanged ()
End If

end on

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: U_TreeView::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 30/04/1998 18:02:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	IsValid ( iuoGsTreeView )	Then
	iuoGsTreeView.Uf_Clicked ()
End If




end on

on destructor;//*-----------------------------------------------------------------
//*
//* Objet 			: U_TreeView::Destructor
//* Evenement 		: Destructor
//* Auteur			: Erick John Stark
//* Date				: 30/04/1998 18:02:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Destruction du NVUO qui contient les m$$HEX1$$e900$$ENDHEX$$thodes
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Destroy iuoGsTreeView



end on

on doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet 			: U_TreeView::DoubleClicked
//* Evenement 		: DoubleClicked
//* Auteur			: Erick John Stark
//* Date				: 30/04/1998 18:02:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	IsValid ( iuoGsTreeView )	Then
//	iuoGsTreeView.Uf_DoubleClicked ()
End If

end on

