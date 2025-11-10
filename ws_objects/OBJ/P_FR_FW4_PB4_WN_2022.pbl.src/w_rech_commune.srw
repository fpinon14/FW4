$PBExportHeader$w_rech_commune.srw
$PBExportComments$Recherche des communes et codes postaux
forward
global type w_rech_commune from window
end type
type st_mess from statictext within w_rech_commune
end type
type st_patienter from statictext within w_rech_commune
end type
type dw_rech_commune from datawindow within w_rech_commune
end type
type cb_valider from commandbutton within w_rech_commune
end type
type cb_retour from commandbutton within w_rech_commune
end type
type dw_commune from datawindow within w_rech_commune
end type
end forward

global type w_rech_commune from window
integer x = 1189
integer y = 552
integer width = 1157
integer height = 636
boolean titlebar = true
string title = "Untitled"
windowtype windowtype = response!
long backcolor = 12632256
event ue_charger pbm_custom01
st_mess st_mess
st_patienter st_patienter
dw_rech_commune dw_rech_commune
cb_valider cb_valider
cb_retour cb_retour
dw_commune dw_commune
end type
global w_rech_commune w_rech_commune

type variables
Private :

s_Commune	istCom

end variables

forward prototypes
public subroutine wf_gestion_fleches (string assens)
private subroutine wf_positionnerobjets ()
end prototypes

event ue_charger;//*-----------------------------------------------------------------
//*
//* Objet         : w_Rech_Commune
//* Evenement     : RowFocusChanged
//* Auteur        : Fabry JF
//* Date          : 20/08/2003 17:35:25
//* Libellé       : Chargement après l'ouvertue de la fenêtre (POSTEVENT)
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//* #1	 PHG	 10/10/2006	  [DCMP060445] VErsion Sherpa
//*-----------------------------------------------------------------

// #1 [DCMP060445] PHG Selon le cas (ds ou dw) on modifie le share data
if isvalid(istCom.dw_Commune) then
	istCom.dw_Commune.ShareData ( dw_Commune )
ElseIf isvalid(istCom.ds_Commune) then
	istCom.ds_Commune.ShareData ( dw_Commune )
End If

dw_Commune.SetSort ( "COMMUNE A" )
dw_Commune.Sort ( )

st_patienter.Hide ()
end event

public subroutine wf_gestion_fleches (string assens);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_Gestion_Fleches (Public)
//* Auteur			: Fabry JF
//* Date				: 21/08/2003 11:37:16
//* Libellé			: Gestion du déplacement par les flèches
//* Commentaires	: 
//*
//* Arguments		: String			asSens				(Val)	Indique le sens de la fléche (Haut, Bas)
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

Long 		lRow				// Row courant et sélectionné
Long 		lNbreRow			// Nbre de Row sélectionné dans le même tour
Boolean  bSel 				// True si, après contrôle, la ligne reste bien sélectionnée


lRow = Dw_Commune.GetSelectedRow ( 0 )

// ... Afin que l'on puisse toujours reprendre la main par les flèches
If lRow = 0 Then 
	lRow = 1
End IF

/*------------------------------------------------------------------*/
/* Gestion du sens de défilement des flèches                        */
/*------------------------------------------------------------------*/
CHOOSE CASE upper ( asSens )

	//... Fléche vers le bas
	CASE "BAS"

		Dw_Commune.SelectRow ( 0, False )

		If lRow = Dw_Commune.Rowcount () Then
			Dw_Commune.SelectRow ( 1, True )
			Dw_Commune.SetRow		( 1 )
		Else
			Dw_Commune.SelectRow ( lRow + 1, True )			
			Dw_Commune.SetRow		( lRow + 1 )
		End IF

		lNbreRow = 1

	//... Fléche vers le Haut
	CASE "HAUT"

		Dw_Commune.SelectRow ( 0, False 		  )
	
		If lRow = 1 Then
			Dw_Commune.SelectRow ( Dw_Commune.Rowcount () , True )			
			Dw_Commune.SetRow		( Dw_Commune.Rowcount ()  		  )
		Else
			Dw_Commune.SelectRow ( lRow - 1, True )			
			Dw_Commune.SetRow		( lRow - 1 		  )
		End IF
			
		lNbreRow = 1


END CHOOSE





end subroutine

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction      : wf_PositionnerObjets (PRIVATE)
//* Auteur        : Fabry JF
//* Date          : 21/08/2003 14:49:51
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

This.x = 1189
This.y = 553
This.width = 2204 + 30 // [20250425132807117][RETAILLE_FEN]
This.Height = 1165 + 30 // [20250425132807117][RETAILLE_FEN]

cb_Retour.x = 28
cb_Retour.y = 25
cb_Retour.width = 270
cb_Retour.Height = 93

cb_valider.x = 311
cb_valider.y = 25
cb_valider.width = 270
cb_valider.Height = 93

dw_commune.x = 33
dw_commune.y = 137
dw_commune.width = 2100
dw_commune.Height = 645

dw_rech_commune.x = 23
dw_rech_commune.y = 801
dw_rech_commune.width = 1203
dw_rech_commune.Height = 217

st_Mess.x = 1230
st_Mess.y = 793
st_Mess.width = 947
st_Mess.Height = 281



end subroutine

on open;//*-----------------------------------------------------------------
//*
//* Objet         : w_Rech_Commune
//* Evenement     : Open
//* Auteur        : Fabry JF
//* Date          : 20/08/2003 17:11:02
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

istCom = Message.PowerObjectParm

This.wf_PositionnerObjets ()

This.Title = "Recherche des communes"
istCom.bValider = FALSE

st_patienter.Show ()
st_patienter.BringToTop = TRUE

st_Mess.text = 		"Le nom de la commune doit être écrit sans" + char(13) + &
						"accentuation (é,è,ç,à,etc.) ni ponctuation" + Char(13) + "(, - ' etc.)." + &
						"Les noms ~"SAINT~" et ~"SAINTE~""  + Char(13) + "doivent être écrits" + &
						"~"ST~" et ~"STE~" à l'exception" + Char(13) + "de ~"SAINTES~" et ~"SAINTS~"." 


PostEvent ("UE_CHARGER") 

dw_Rech_Commune.InsertRow (0)
dw_Rech_Commune.SetColumn ("COMMUNE" ) 
dw_Rech_Commune.SetFocus ()


end on

on close;//*-----------------------------------------------------------------
//*
//* Objet         : w_Rech_Commune
//* Evenement     : Close
//* Auteur        : Fabry JF
//* Date          : 20/08/2003 17:14:47
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

CloseWithReturn ( This, istCom )


end on

on w_rech_commune.create
this.st_mess=create st_mess
this.st_patienter=create st_patienter
this.dw_rech_commune=create dw_rech_commune
this.cb_valider=create cb_valider
this.cb_retour=create cb_retour
this.dw_commune=create dw_commune
this.Control[]={this.st_mess,&
this.st_patienter,&
this.dw_rech_commune,&
this.cb_valider,&
this.cb_retour,&
this.dw_commune}
end on

on w_rech_commune.destroy
destroy(this.st_mess)
destroy(this.st_patienter)
destroy(this.dw_rech_commune)
destroy(this.cb_valider)
destroy(this.cb_retour)
destroy(this.dw_commune)
end on

type st_mess from statictext within w_rech_commune
integer x = 736
integer y = 136
integer width = 306
integer height = 276
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_patienter from statictext within w_rech_commune
boolean visible = false
integer x = 366
integer y = 432
integer width = 1362
integer height = 88
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Veuillez Patientez pendant le chargement...."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_rech_commune from datawindow within w_rech_commune
integer x = 389
integer y = 136
integer width = 297
integer height = 276
integer taborder = 40
string dataobject = "d_rech_commune"
boolean border = false
end type

on itemfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet         : dw_Rech_Commune
//* Evenement     : ItemFocusChanged
//* Auteur        : Fabry JF
//* Date          : 21/08/2003 09:58:55
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

String sNull

SetNull ( sNull )
Dw_Commune.SelectRow (0, FALSE)

Choose Case Upper (  This.GetColumnName() )
	Case "COMMUNE"
		Dw_Commune.SetSort ("COMMUNE A" )
		Dw_Rech_Commune.SetItem ( 1, "CP", sNull )

	Case "CP"
		Dw_Commune.SetSort ("CP A" )
		Dw_Rech_Commune.SetItem ( 1, "COMMUNE", sNull )

End Choose


Dw_Commune.Sort ()

end on

event editchanged;//*-----------------------------------------------------------------
//*
//* Objet         : dw_Rech_Commune
//* Evenement     : EditChanged
//* Auteur        : FABRY JF
//* Date          : 21/08/2003 11:45:32
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------
Long		lLigne, lLongueur
String 	sChaine, sNomCol, sGetText

sNomCol = Upper ( This.GetColumnName () )
//Migration PB8-WYNIWYG-03/2006 FM
//sGetText = This.GetText ()
sGetText = data
//Fin Migration PB8-WYNIWYG-03/2006 FM

lLongueur = Len ( sGetText )
sChaine = "Upper ( Left ( " + sNomCol + ", " + String (lLongueur) + " )) = '" +  Upper ( sGetText ) + "'"

lLigne = dw_Commune.find ( sChaine, 1, 40000 )
If lLigne > 0 Then
	dw_Commune.ScrollToRow ( lLigne )
	dw_Commune.SetRow ( lLigne )
	dw_Commune.SelectRow ( 0, FALSE )
	dw_Commune.SelectRow ( lLigne, TRUE )
End If


end event

type cb_valider from commandbutton within w_rech_commune
integer x = 311
integer y = 24
integer width = 270
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Valider"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : dw_regle_coherence
//* Evenement     : RowFocusChanged
//* Auteur        : Fabry JF
//* Date          : 21/08/2003 09:33:09
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//* #1    PHG   10/10/2006   [DCMP060445] PHG Version Sherpa
//*-----------------------------------------------------------------

Long lRow

This.Enabled = FALSE

lRow = dw_Commune.GetSelectedRow ( 0 )

/*------------------------------------------------------------------*/
/* Une commune doit être sélectionnée                               */
/*------------------------------------------------------------------*/
If lRow <=0 Then
		// #1 On utilise un messagebox standard
//		stMessage.sTitre		= "Recherche des communes"
//		stMessage.Icon			= Information!
//		stMessage.bErreurG	= TRUE
//		stMessage.Bouton		= Ok!
//		stMessage.sCode		= "COMM01"
//		F_Message ( stMessage )
//		remplacé par
		messagebox("Recherche des communes", "Vous devez sélectionner une commune",&
					  Information!, Ok! )
		This.Enabled = True
		Return

/*------------------------------------------------------------------*/
/* Si une commune est sélectionné, on charge la structure, et on    */
/* ferme.                                                           */
/*------------------------------------------------------------------*/
Else	
	istCom.sCommune 		= dw_Commune.GetItemString ( lRow, "COMMUNE" )
	istCom.sCP		 		= dw_Commune.GetItemString ( lRow, "CP" )
	istCom.sDepartement 	= dw_Commune.GetItemString ( lRow, "DEPARTEMENT" )
	istCom.sCode_Dept 	= dw_Commune.GetItemString ( lRow, "CODE_DEPT" )
	istCom.sInsee		 	= dw_Commune.GetItemString ( lRow, "INSEE" )
	istCom.bValider 		= TRUE
End if

Close ( Parent )
end event

type cb_retour from commandbutton within w_rech_commune
integer x = 27
integer y = 24
integer width = 270
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Retour"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet         : dw_regle_coherence
//* Evenement     : RowFocusChanged
//* Auteur        : Fabry JF
//* Date          : 21/08/2003 09:33:09
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

istCom.bValider = FALSE
This.Enabled = FALSE

Close ( Parent )
end on

type dw_commune from datawindow within w_rech_commune
event we_touche pbm_dwnkey
integer x = 41
integer y = 136
integer width = 297
integer height = 276
integer taborder = 30
string dataobject = "d_commune"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on we_touche;//*-----------------------------------------------------------------
//*
//* Evenement		: we_Touche
//* Auteur			: JFF
//* Date				: 20/08/2003 16:16:55
//* Libellé			: Gestion de la touche pressée
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------


This.SetRedraw ( False )

If KeyDown ( KeyDownArrow! ) Then

	Parent.wf_Gestion_Fleches ("bas")

ElseIf KeyDown ( KeyUpArrow! ) Then

	Parent.wf_Gestion_Fleches ("haut")

End If

This.SetRedraw ( True )
end on

on doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet         : dw_Commune
//* Evenement     : DoubleCliked
//* Auteur        : Fabry JF
//* Date          : 21/08/2003 11:17:55
//* Libellé       : 
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

cb_valider.TriggerEvent ( "CLICKED" )

end on

on clicked;//*-----------------------------------------------------------------
//*
//* Evenement		: Clicked
//* Auteur			: JFF
//* Date				: 20/08/2003 16:16:55
//* Libellé			: Gestion du click 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------

Long 		lRow

lRow = This.GetClickedRow()

If lRow > 0 then 
	This.SelectRow ( 0, False 	 )
	This.ScrollToRow ( lRow )
	This.SelectRow ( lRow, True )
	This.SetRow		( lRow 	    )

End IF

end on

