HA$PBExportHeader$u_datawindow_accueil.sru
$PBExportComments$------} UserObjet Anc$$HEX1$$ea00$$ENDHEX$$tre DataWindow Accueil
forward
global type u_datawindow_accueil from u_datawindow_detail
end type
end forward

global type u_datawindow_accueil from u_datawindow_detail
end type
global u_datawindow_accueil u_datawindow_accueil

type prototypes

end prototypes

type variables

end variables

event ue_modifiermenu;call super::ue_modifiermenu;//*****************************************************************************
//
// Objet 		: U_DataWindow_Accueil
// Evenement 	: ue_ModifierMenu
//	Auteur		: La Recrue
//	Date			: 16/12/1995
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Par defaut, on ne peut supprimer sur une fen$$HEX1$$ea00$$ENDHEX$$tre d'accueuil
//					  On ajoute le menu rechercher
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

uf_Mnu_InterdirItem ( 3 )
uf_Mnu_AjouterItem( 4, "" )
uf_Mnu_AjouterItem( 5, "Interroger" )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event retrievestart;call super::retrievestart;SetPointer( HourGlass! )
Window wTemp

wTemp = Parent

wTemp.TriggerEvent( "ue_Disablefenetre" )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event retrieveend;call super::retrieveend;SetPointer( HourGlass! )
Window wTemp

wTemp = Parent

wTemp.TriggerEvent( "ue_enablefenetre" )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event retrieverow;call super::retrieverow;//*****************************************************************************
//
// Objet 		: U_DataWindow_Accueil
// Evenement 	: RetrieveRow
//	Auteur		: Erick John Stark
//	Date			: 24/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Incr$$HEX1$$e900$$ENDHEX$$mentation du nombre de lignes retrouv$$HEX1$$e900$$ENDHEX$$es
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

SetPointer( HourGlass! )


ilNbrLig ++

// .... Le nombre de lignes retourn$$HEX1$$e900$$ENDHEX$$es d$$HEX1$$e900$$ENDHEX$$passe la valeur maximum

If	ilNbrLig = ilMaxLig Then
	DbCancel ()

	MessageBox ( "Arr$$HEX1$$ea00$$ENDHEX$$t", "Le nombre maximum de lignes est atteint~n~rLa s$$HEX1$$e900$$ENDHEX$$lection est incompl$$HEX1$$e800$$ENDHEX$$te" )
	
	//Migration PB8-WYNIWYG-03/2006 FM
	return 1
	//Fin Migration PB8-WYNIWYG-03/2006 FM
	
End IF

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_majaccueil;call super::ue_majaccueil;//*****************************************************************************
//
// Objet 		: u_DataWindow_Accueil
// Evenement 	: ue_MajAccueil
//	Auteur		: D.Bizien
//	Date			: 18/03/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Mise $$HEX2$$e0002000$$ENDHEX$$jour de la datawindow Accueil apr$$HEX1$$e800$$ENDHEX$$s Modification
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
// PAR		05/12/1996	Cr$$HEX1$$e900$$ENDHEX$$ation de l'an$$HEX1$$ea00$$ENDHEX$$tre d$$HEX1$$e900$$ENDHEX$$tail
//
//*****************************************************************************


Parent.TriggerEvent ( "ue_TaillerHauteur" )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event constructor;call super::constructor;//*****************************************************************************
//
// Objet 		: U_DataWindow_Accueil
// Evenement 	: Constructor
//	Auteur		: Erick John Stark
//	Date			: 24/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: Initialisation du nombre maximum de lignes 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

ilMaxLig = 150
uf_Activer_Selection ( True )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on u_datawindow_accueil.create
end on

on u_datawindow_accueil.destroy
end on

