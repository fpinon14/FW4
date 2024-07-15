HA$PBExportHeader$w_tm_sp_typo_courrier.srw
$PBExportComments$[PM497-1]
forward
global type w_tm_sp_typo_courrier from window
end type
type dw_resultat from datawindow within w_tm_sp_typo_courrier
end type
type dw_rech from datawindow within w_tm_sp_typo_courrier
end type
type cb_retour from commandbutton within w_tm_sp_typo_courrier
end type
end forward

global type w_tm_sp_typo_courrier from window
integer width = 4425
integer height = 1888
boolean titlebar = true
string title = "Typologie courrier (PM497-1)"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
dw_resultat dw_resultat
dw_rech dw_rech
cb_retour cb_retour
end type
global w_tm_sp_typo_courrier w_tm_sp_typo_courrier

type variables
Private : 

s_Pass istPass

String isTypFermeture
Int	 iiRow
end variables

forward prototypes
public subroutine wf_init_zone_saisie (string ascas)
public subroutine wf_dw_rech_itemchanged (string asnomzone)
end prototypes

public subroutine wf_init_zone_saisie (string ascas);DataWindowChild dwChild
dw_rech.GetChild ( "TYPO_LONG", dwchild)

Choose Case asCas
	Case "TOUT"
		
		dw_rech.SetItem ( 1, "SAISIE_LIBRE", stNul.str )
		dw_rech.SetItem ( 1, "TYPO_COURT", stNul.str )
		dw_rech.SetItem ( 1, "TYPO_LONG", stNul.str )
		
		dw_resultat.SetFilter ( "" ) 
		dw_resultat.Filter ()
		dw_resultat.Sort ()					
	
		dwchild.SetFilter ( "TYPO_COURT = ''" )
		dwchild.Filter ()
		dwchild.Sort ()					
	
	Case "SAISIE_LIBRE"
		dw_rech.SetItem ( 1, "SAISIE_LIBRE", stNul.str )
		
	Case "TYPO_COURT"
		dw_rech.SetItem ( 1, "TYPO_COURT", stNul.str )	
		dwchild.SetFilter ( "TYPO_COURT = ''" )
		dwchild.Filter ()
		dwchild.Sort ()
	
		
	Case "TYPO_LONG"
		dw_rech.SetItem ( 1, "TYPO_LONG", stNul.str )	
		dwchild.SetFilter ( "TYPO_COURT = ''" )
		dwchild.Filter ()
		dwchild.Sort ()		

End Choose


end subroutine

public subroutine wf_dw_rech_itemchanged (string asnomzone);String sVal, sVal1
DataWindowChild dwChild

dw_rech.AcceptText ()

Choose Case Upper ( asNomZone )
	Case "SAISIE_LIBRE"
		sVal = Trim ( dw_rech.GetItemString ( 1, "SAISIE_LIBRE" ))
		If IsNull ( sVal ) Then sVal = ""
		
		If sVal <> "" Then
			This.wf_init_zone_saisie ( "TYPO_COURT" )
			This.wf_init_zone_saisie ( "TYPO_LONG" )
			
			sVal = F_REMPLACE ( sVal, "'", "~~'" ) 
			
			dw_resultat.SetFilter ( "POS ( ID_COUR, '" + sVal + "' ) > 0 Or POS ( TYPO_COURT, '" + sVal + "' ) > 0 Or POS ( TYPO_LONG, '" + sVal + "' ) > 0" )
			dw_resultat.Filter ()
			dw_resultat.Sort ()			
			Return
		Else 
			dw_resultat.SetFilter ( "" )
			dw_resultat.Filter ()
			dw_resultat.Sort ()						
		End If 

	Case "TYPO_COURT"
		sVal = Trim ( dw_rech.GetItemString ( 1, "TYPO_COURT" ))
		If IsNull ( sVal ) Then sVal = ""

		This.wf_init_zone_saisie ( "SAISIE_LIBRE" )
		This.wf_init_zone_saisie ( "TYPO_LONG" )
		
		sVal = F_REMPLACE ( sVal, "'", "~~'" ) 
		dw_resultat.SetFilter ( "TYPO_COURT = '" + sVal + "'" )
		dw_resultat.Filter ()
		dw_resultat.Sort ()					
		
		dw_rech.GetChild ( "TYPO_LONG", dwchild)
		dwchild.SetFilter ( "TYPO_COURT = '" + sVal + "'" )
		dwchild.Filter ()
		dw_resultat.Sort ()
		
		Return

	Case "TYPO_LONG"

		sVal = Trim ( dw_rech.GetItemString ( 1, "TYPO_COURT" ))
		If IsNull ( sVal ) Then sVal = ""

		sVal1 = Trim ( dw_rech.GetItemString ( 1, "TYPO_LONG" ))
		If IsNull ( sVal1 ) Then sVal1 = ""

		sVal = F_REMPLACE ( sVal, "'", "~~'" ) 
		sVal1 = F_REMPLACE ( sVal1, "'", "~~'" ) 
	
		This.wf_init_zone_saisie ( "SAISIE_LIBRE" )
		dw_resultat.SetFilter ( "TYPO_COURT = '" + sVal + "' AND TYPO_LONG = '" + sVal1 + "'" )
		dw_resultat.Filter ()
		dw_resultat.Sort ()
		
		Return
		
End Choose 


end subroutine

on w_tm_sp_typo_courrier.create
this.dw_resultat=create dw_resultat
this.dw_rech=create dw_rech
this.cb_retour=create cb_retour
this.Control[]={this.dw_resultat,&
this.dw_rech,&
this.cb_retour}
end on

on w_tm_sp_typo_courrier.destroy
destroy(this.dw_resultat)
destroy(this.dw_rech)
destroy(this.cb_retour)
end on

event open;//       JFF   18/08/2020 [PM497-1]


DataWindowChild dwChildTypoCourt, dwChildTypoLong

istPass = Message.PowerObjectParm

dw_rech.Insertrow (0)
dw_rech.GetChild ( "TYPO_COURT", dwChildTypoCourt )
dwChildTypoCourt.SetTransObject ( SQLCA )
dwChildTypoCourt.Retrieve ( istPass.lTab[1] )
dw_rech.GetChild ( "TYPO_LONG", dwChildTypoLong )
dwChildTypoLong.SetTransObject ( SQLCA )
dwChildTypoLong.Retrieve ( istPass.lTab[1] )

dw_resultat.SetRedraw (False)
dw_resultat.SetTransObject ( SQLCA )
dw_resultat.Retrieve ( istPass.lTab[1] )
//dw_resultat.SetFilter ( "ID_COUR =''" ) 
dw_resultat.SetFilter ( "" ) 
dw_resultat.Filter ()
dw_resultat.SetRedraw (True)

//This.X			=  50
//This.Y			=  20
//This.Width		= 3863
This.Height		= 3500

dw_resultat.Height = 2600	

This.wf_init_zone_saisie ( "TOUT" ) 


end event

event close;
s_Pass stPass


Choose Case isTypFermeture
		
	Case "[CHOIX]"

		stPass.sTab[1] = dw_resultat.GetItemString ( iiRow, "ID_NAT_COUR" )
		stPass.sTab[2] = dw_resultat.GetItemString ( iiRow, "ID_COUR" )

		Message.Powerobjectparm = stPass
		
		CloseWithReturn(this, Message.Powerobjectparm )			

	Case Else 
		
		Message.Powerobjectparm = stPass
		CloseWithReturn(this, Message.Powerobjectparm )


End Choose 

end event

type dw_resultat from datawindow within w_tm_sp_typo_courrier
integer x = 18
integer y = 740
integer width = 4375
integer height = 1040
integer taborder = 40
string title = "none"
string dataobject = "d_pm497_resultat"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;s_Pass stPass

Choose Case Upper ( dwo.name ) 
	Case "B_CHOISIR"
	
		stMessage.sTitre		= "Choix courrier (PM497-1)"
		stMessage.Icon		= Question!
		stMessage.bErreurG	= FALSE
		stMessage.Bouton		= YESNO!
		stMessage.sVar[1]    = This.GetItemString ( row, "ID_COUR" ) 
		stMessage.sVar[2]    = This.GetItemString ( row, "TYPO_COURT" )
		stMessage.sVar[3]    = This.GetItemString ( row, "TYPO_LONG" )		
		stMessage.sCode		= "WINT308"

		If F_Message ( stMessage ) = 1 Then

			isTypFermeture = "[CHOIX]"
			iiRow = row
			TriggerEvent ( Parent, "close" )
		Else 
			This.SelectRow ( row, FALSE)				
		End If 
		

		
End CHoose 

end event

event buttonclicking;Choose Case Upper ( dwo.name ) 
	Case "B_CHOISIR"
		This.SelectRow ( row, TRUE )
		
End Choose 
end event

type dw_rech from datawindow within w_tm_sp_typo_courrier
integer x = 18
integer y = 168
integer width = 4375
integer height = 572
integer taborder = 30
string title = "none"
string dataobject = "d_pm497_recherche"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;Parent.wf_init_zone_saisie ( "TOUT" ) 

end event

event itemerror;


Return 2
end event

event editchanged;Choose Case Upper ( dwo.name ) 
	Case "SAISIE_LIBRE" 
		Parent.wf_init_zone_saisie ( "TYPO_COURT" )
		Parent.wf_init_zone_saisie ( "TYPO_LONG" )
		Parent.wf_dw_rech_itemchanged ( Upper ( dwo.name )  )
End Choose 

end event

event itemchanged;

Parent.wf_dw_rech_itemchanged ( dwo.name )


end event

type cb_retour from commandbutton within w_tm_sp_typo_courrier
integer x = 27
integer y = 32
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Retour"
end type

event clicked;isTypFermeture = "[RETOUR]"
TriggerEvent ( Parent, "close" )
end event

