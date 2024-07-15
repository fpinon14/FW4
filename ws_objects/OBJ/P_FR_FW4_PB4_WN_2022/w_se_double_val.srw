HA$PBExportHeader$w_se_double_val.srw
forward
global type w_se_double_val from window
end type
type dw_1 from datawindow within w_se_double_val
end type
type cb_annuler from commandbutton within w_se_double_val
end type
type cb_valider from commandbutton within w_se_double_val
end type
type st_titre from statictext within w_se_double_val
end type
end forward

global type w_se_double_val from window
integer width = 2149
integer height = 1344
boolean titlebar = true
string title = "Double validation"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_annuler cb_annuler
cb_valider cb_valider
st_titre st_titre
end type
global w_se_double_val w_se_double_val

type variables
private:

s_se_params ixParams
end variables

on w_se_double_val.create
this.dw_1=create dw_1
this.cb_annuler=create cb_annuler
this.cb_valider=create cb_valider
this.st_titre=create st_titre
this.Control[]={this.dw_1,&
this.cb_annuler,&
this.cb_valider,&
this.st_titre}
end on

on w_se_double_val.destroy
destroy(this.dw_1)
destroy(this.cb_annuler)
destroy(this.cb_valider)
destroy(this.st_titre)
end on

event open;//*-----------------------------------------------------------------
//*
//* Objet			: w_se_double_val
//* Evenement 		: open
//* Auteur			: F. Pinon
//* Date				: 18/07/2008 13:11:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
s_se_Params xParams

ixParams = Message.PowerObjectParm

dw_1.InsertRow(0)

if isValid(ixParams) then
	st_titre.text += ixParams.isvaleurstr[4]
	
	if UpperBound(ixParams.isvaleurstr) > 0 then 
		dw_1.SetItem(1,"trigramme",ixParams.isvaleurstr[1])
	end if
	if  isnull(ixParams.isvaleurstr[2]) then
		dw_1.SetItem(1,"procuration",1)
	else
		dw_1.SetItem(1,"trigramme_proc",ixParams.isvaleurstr[2])
		cb_valider.enabled=False
	end if
	
	if UpperBound(ixParams.isvaleurstr) = 5 then
		dw_1.setitem(1,"message",ixParams.isvaleurstr[5])
	else 
		cb_valider.enabled=false
	end if
	
	dw_1.setitem(1,"histo_conf","N")
	
	if UpperBound(ixParams.isvaleurstr) = 6 then
		if ixParams.isvaleurstr[6]="N" Then
			dw_1.object.histo_conf.visible=TRUE
		end if
	end if
	
	dw_1.setcolumn("password")
else
	ixParams=xParams
end if

ixParams.iivaleurint[2] = 0 // Valeur de retour (1 pour clic sur OK, 0 sinon)
end event

event close;//*-----------------------------------------------------------------
//*
//* Objet			: w_se_double_val
//* Evenement 		: close
//* Auteur			: F. Pinon
//* Date				: 22/07/2008 11:35:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Message.PowerObjectParm = ixParams
end event

type dw_1 from datawindow within w_se_double_val
integer y = 172
integer width = 2130
integer height = 836
integer taborder = 10
string title = "none"
string dataobject = "d_se_trt_double_val"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			: w_se_double_val
//* Evenement 		: itemchanged
//* Auteur			: F. Pinon
//* Date				: 07/08/2008 14:42:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value long row	 */
/* 	value dwobject dwo	 */
/* 	value string data	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    FPI   08/10/2008	  R$$HEX1$$e900$$ENDHEX$$fonte g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rale
//* #2	 FPI	13/03/2009		Correction activation de Valider 
//										si case "Ne plus poser..." coch$$HEX1$$e900$$ENDHEX$$e
//*-----------------------------------------------------------------
string sMsg, sPass
boolean bEnabled = TRUE

Choose case dwo.name
	case "message" 
		if isnull(data) or trim(data) = "" then bEnabled=FALSE

		if this.getitemnumber(1,"procuration") = 0 Then bEnabled=FALSE
		
		sPass=this.getitemstring(1,"password") 
		if isNull(sPass) or trim(sPass) = "" Then bEnabled=FALSE
		
	case "procuration"
		if data = "0" Then bEnabled=FALSE
		
		sMsg=this.getitemstring(1,"message") 
		if isNull(sMsg) or trim(sMsg) = "" then bEnabled=FALSE

		sPass=this.getitemstring(1,"password") 
		if isNull(sPass) or trim(sPass) = "" Then bEnabled=FALSE
		
	case "password"
		if isnull(data) or trim(data) = "" then bEnabled=FALSE

		if this.getitemnumber(1,"procuration") = 0 Then bEnabled=FALSE
		
		sMsg=this.getitemstring(1,"message") 
		if isNull(sMsg) or trim(sMsg) = "" then bEnabled=FALSE
	// #2
	Case Else
		bEnabled = cb_valider.enabled
end choose

cb_valider.enabled=bEnabled
/*Choose case dwo.name
	case "message" 
		if isnull(data) or trim(data) = "" then
			cb_valider.enabled = FALSE
		else
			cb_valider.enabled=(this.getitemnumber(1,"procuration") = 1)
		end if
	case "procuration"
		sMsg=this.getitemstring(1,"message") 
		if isNull(sMsg) or trim(sMsg) = "" then
			cb_valider.enabled=FALSE
		else
			cb_valider.enabled=(data="1")
		end if
end choose
*/		

end event

event editchanged;//*-----------------------------------------------------------------
//*
//* Objet			: w_se_double_val
//* Evenement 		: editchanged
//* Auteur			: F. Pinon
//* Date				: 07/08/2008 14:51:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: value long row	 */
/* 	value dwobject dwo	 */
/* 	value string data	 */
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    FPI   08/10/2008   Correction : password obligatoire
//*-----------------------------------------------------------------
string sTemp

If dwo.name = "message"  Then
	if trim(data) = "" then
		cb_valider.enabled = FALSE
	else
		sTemp = this.getitemstring(1,"password")
		cb_valider.enabled=(this.getitemnumber(1,"procuration") = 1 &
			and (not isNull(sTemp)) and sTemp <> "")
			
	end if
end if

If dwo.name = "password"  Then
	if trim(data) = "" then
		cb_valider.enabled = FALSE
	else
		sTemp = this.getitemstring(1,"message")
		cb_valider.enabled=(this.getitemnumber(1,"procuration") = 1 &
			and (not isNull(sTemp)) and sTemp <> "")
			
	end if
end if

end event

type cb_annuler from commandbutton within w_se_double_val
integer x = 1125
integer y = 1068
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Annuler"
boolean cancel = true
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_se_double_val::cb_annuler
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 22/07/2008 12:06:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Close(Parent)
end event

type cb_valider from commandbutton within w_se_double_val
integer x = 681
integer y = 1068
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&OK"
boolean default = true
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_se_double_val::cb_valider
//* Evenement 		: clicked
//* Auteur			: F. Pinon
//* Date				: 22/07/2008 11:35:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

ixParams.iivaleurint[2] = 1

dw_1.accepttext()

ixParams.isvaleurstr[1]=dw_1.getitemstring(1,"trigramme")
ixParams.isvaleurstr[3]=dw_1.getitemstring(1,"password")
ixParams.isvaleurstr[4]=dw_1.getitemstring(1,"message")
ixParams.isvaleurstr[6]=dw_1.getitemstring(1,"histo_conf")

Close(Parent)

end event

type st_titre from statictext within w_se_double_val
integer y = 56
integer width = 2130
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ce dossier n$$HEX1$$e900$$ENDHEX$$cessite une double validation de "
boolean border = true
boolean focusrectangle = false
end type

