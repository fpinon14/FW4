$PBExportHeader$w_message_reponse.srw
$PBExportComments$Saisie d'une réponse
forward
global type w_message_reponse from window
end type
type dw_1 from u_datawindow within w_message_reponse
end type
type cb_cancel from commandbutton within w_message_reponse
end type
type cb_ok from commandbutton within w_message_reponse
end type
end forward

global type w_message_reponse from window
integer width = 2258
integer height = 1364
boolean titlebar = true
string title = "Untitled"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_message_reponse w_message_reponse

type variables
Protected:
boolean ibMethodeOld	// TRUE : avec s_se_params, FALSE avec n_cst_spb_params
n_cst_spb_params iuParams

end variables

forward prototypes
private function string wf_serialiser ()
private function boolean wf_initialiser_defaut (string asparam, long alnbrows)
public subroutine uf_initialiser (n_cst_spb_params auparams)
private subroutine wf_serialiser2 ()
private function boolean wf_serialiser3 ()
protected subroutine wf_initialiser_defaut (n_cst_spb_params auparams, long alnbrows)
end prototypes

private function string wf_serialiser ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_message_reponse::wf_serialiser
//* Auteur			: 
//* Date				: 25/06/2008 16:41:36
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 FPI	 17/08/2009	  [DCMP090404] On gère plusieurs lignes 
//			FPI 	07/12/2012		[ITSM138130] Retour de l'accepttext
//*-----------------------------------------------------------------


Long lTot, l, lRow
String sRet
String sNomCol
String sValCol



String sRetour
String sVal
N_Cst_String    nvString

lTot = 0
sRetour = ""

If dw_1.AcceptText()	<> 1 Then return ""

sRet = dw_1.Object.DataWindow.Column.Count

If isNumber ( sRet ) Then lTot = Long ( sRet )

For lRow = 1 To dw_1.RowCount() // #1
	For l = 1 To lTot
		
		
		sRet = "#" + String ( l ) + ".Name"
		
		sNomCol = dw_1.Describe( sRet )
		sValCol = String( dw_1.Object.Data[lRow,l] ) // #1
		
		If isNull ( sNomCol ) Then sNomCol = ""
		If isNull ( sValCol ) Then sValCol = ""
		
		sRetour += Upper ( sNomCol ) + "=" + sValCol + ";"
		
		
	Next
Next // #1

Return sRetour
end function

private function boolean wf_initialiser_defaut (string asparam, long alnbrows);//*-----------------------------------------------------------------
//*
//* Fonction		: w_message_reponse::wf_initialiser_defaut
//* Auteur			: FS
//* Date				: 31/07/2008 08:40:57
//* Libellé			: Initialisation des valeurs par défaut
//* Commentaires	: 
//*
//* Arguments		: value string asparam	Chaine du type "ID_COLX=valeur;..."
//*						Si +ieurs lignes, il faut renseigner toutes les colonnes
//*
//* Retourne		: boolean	True  au moins une colonne initialisée 
//*                           False
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	FPI	07/01/2009	[RoutageMasse] Prise en compte du type de colonnes
//* #2	FPI	17/08/2009	[DCMP090404] Plusieurs lignes
//*-----------------------------------------------------------------

Boolean bOk 
Long lTot, l, lVal
int  iRet
String sRet,sNomCol, sValCol, sTypeCol

Date	dtVal
DateTime dttVal
Real rVal
Time	tVal
Decimal dcVal
Long lRow, lNbRows, lLongueur // #2


N_Cst_String    nvString

lTot = 0
bOk = false

sRet = dw_1.Object.DataWindow.Column.Count

/*------------------------------------------------------------------*/
/* Principe :                                                       */
/*   Pour chaque colonne de dw_1, recherche de la valeur dans la    */
/*   chaine "asParam"                                               */
/*------------------------------------------------------------------*/


If isNumber ( sRet ) Then lTot = Long ( sRet )

lLongueur = 0

For lRow = 1 To alNbRows
// #2 fin
	For l = 1 To lTot

		sRet = "#" + String ( l ) + ".Name"
		
		sNomCol = Upper(dw_1.Describe( sRet ) )
		
		sValCol = nvString.of_getkeyvalue( asParam, sNomCol, ";" )
		
		If sValCol <> "" Then
		
			// #1 - Prise en compte du type de colonnes
			sTypeCol = dw_1.Describe(sNomCol + ".ColType")
			
			Choose Case Upper(sTypeCol)
				Case "INT", "LONG", "NUMBER", "ULONG"
					lVal = Long(sValCol)
				//	dw_1.setitem( 1, l, lVal )
					dw_1.setitem( lRow, l, lVal )		// #2
				Case "DATE"
					dtVal = date(sValCol)
//					dw_1.setitem( 1, l, dtVal )
					dw_1.setitem( lRow, l, dtVal )		// #2
				Case "DATETIME","TIMESTAMP"
					dttVal = datetime(sValCol)
//					dw_1.setitem( 1, l, dttVal )
					dw_1.setitem( lRow, l, dttVal )		// #2
				Case "REAL"
					rVal = real(sValCol)
//					dw_1.setitem( 1, l, rVal )
					dw_1.setitem( lRow, l, rVal )		// #2
				Case "TIME"
					tVal = time(sValCol)
//					dw_1.setitem( 1, l, tVal )
					dw_1.setitem( lRow, l, tVal )		// #2
				Case Else
					If Left(Upper(sTypeCol),3) = "DEC" Then
						// Decimal(n)
						dcVal = dec(sValCol)
//						dw_1.setitem( 1, l, dcVal )
						dw_1.setitem( lRow, l, dcVal )		// #2
					Else
						// Char(n) ou String
//						dw_1.setitem( 1, l, sValCol )
						dw_1.setitem( lRow, l, sValCol )		// #2
					End if
			End Choose
			
			bOk = True
		
		End If
		
		// #2
		If alNbRows > 1 Then lLongueur+=Len(sValCol) + Len(sNomCol) + 2
		
	Next		
	
	asParam =Mid(asParam,lLongueur)
Next // #2

		
Return bOk
end function

public subroutine uf_initialiser (n_cst_spb_params auparams);//*-----------------------------------------------------------------
//*
//* Fonction		: w_message_reponse::uf_initialiser
//* Auteur			: F. Pinon
//* Date				: 18/08/2009 10:50:33
//* Libellé			: 
//* Commentaires	: 
//*
//* Arguments		: value n_cst_spb_params auparams	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
Long lNbRows

/*------------------------------------------------------------------*/
/* isvaleurstr[1] = Le titre                                               */
/* isvaleurstr[2] = Le data object à mettre                                */
/* isvaleurstr[3] = La chaine d'initialisation des colonnes                */
/*           Format : "ID_COLX=val;ID_COLY=val;"                    */
/*------------------------------------------------------------------*/
	
If Upperbound( auParams.isvaleurstr ) > 1 Then
	If UpperBound( auParams.isvaleurstr) > 0 Then This.Title = auParams.isvaleurstr[1]				// ... Gestion du titre
	If UpperBound(auParams.isvaleurstr) > 1 Then This.dw_1.dataobject = auParams.isvaleurstr[2]	// ... Affectation du dataobject
	
	If UpperBound(auParams.iivaleurint) > 0 Then
		lNbRows = auParams.iivaleurint[1]
	Else
		lNbRows = 1
	End If
	
	This.wf_initialiser_defaut( auParams,lNbRows )
	
	cb_ok.Enabled = True
Else
	cb_ok.Enabled = False
End if
end subroutine

private subroutine wf_serialiser2 ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_message_reponse::wf_serialiser2
//* Auteur			: 
//* Date				: 18/08/2009
//* Libellé			: 
//* Commentaires	:  [DCMP090404] On gère plusieurs lignes 
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------


Long lTot, l, lRow
String sRet
String sNomCol
String sValCol
String sRetour

lTot = 0
sRetour = ""

dw_1.AcceptText()

sRet = dw_1.Object.DataWindow.Column.Count

If isNumber ( sRet ) Then lTot = Long ( sRet )

For lRow = 1 To dw_1.RowCount() 
	For l = 1 To lTot
		
		sRet = "#" + String ( l ) + ".Name"
		
		sNomCol = dw_1.Describe( sRet )
		sValCol = String( dw_1.Object.Data[lRow,l] )
		
		If isNull ( sNomCol ) Then sNomCol = ""
		If isNull ( sValCol ) Then sValCol = ""
		
		iuParams.istparams[lRow].isValeurStr[l]= Upper ( sNomCol ) + "=" + sValCol 
		
		
	Next
Next 
end subroutine

private function boolean wf_serialiser3 ();//*-----------------------------------------------------------------
//*
//* Fonction		: w_message_reponse::wf_serialiser2
//* Auteur			: 
//* Date				: 18/08/2009
//* Libellé			: 
//* Commentaires	:  [ITSM138130] On gère plusieurs lignes + retour si accepttext=-1
//*
//* Arguments		: 
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//*-----------------------------------------------------------------


Long lTot, l, lRow
String sRet
String sNomCol
String sValCol
String sRetour

lTot = 0
sRetour = ""

If dw_1.AcceptText() = -1 Then return false

sRet = dw_1.Object.DataWindow.Column.Count

If isNumber ( sRet ) Then lTot = Long ( sRet )

For lRow = 1 To dw_1.RowCount() 
	For l = 1 To lTot
		
		sRet = "#" + String ( l ) + ".Name"
		
		sNomCol = dw_1.Describe( sRet )
		sValCol = String( dw_1.Object.Data[lRow,l] )
		
		If isNull ( sNomCol ) Then sNomCol = ""
		If isNull ( sValCol ) Then sValCol = ""
		
		iuParams.istparams[lRow].isValeurStr[l]= Upper ( sNomCol ) + "=" + sValCol 
		
		
	Next
Next 

Return true
end function

protected subroutine wf_initialiser_defaut (n_cst_spb_params auparams, long alnbrows);//*-----------------------------------------------------------------
//*
//* Fonction		: w_message_reponse::wf_initialiser_defaut
//* Auteur			: FS
//* Date				: 31/07/2008 08:40:57
//* Libellé			: Initialisation des valeurs par défaut
//* Commentaires	: 
//*
//* Arguments		: value string asparam	Chaine du type "ID_COLX=valeur;..."
//*						Si +ieurs lignes, il faut renseigner toutes les colonnes
//*
//* Retourne		: boolean	True  au moins une colonne initialisée 
//*                           False
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	FPI	07/01/2009	[RoutageMasse] Prise en compte du type de colonnes
//* #2	FPI	17/08/2009	[DCMP090404] Plusieurs lignes
//*-----------------------------------------------------------------

Boolean bOk 
Long lTot, l, lVal
int  iRet
String sRet,sNomCol, sValCol, sTypeCol,sVal

Date	dtVal
DateTime dttVal
Real rVal
Time	tVal
Decimal dcVal
Long lRow, lNbRows, lLongueur // #2
Long lPos

N_Cst_String    nvString

lTot = 0
bOk = false

lLongueur = 0

For lRow = 1 To alNbRows

	dw_1.insertRow(0)
	
	For l = 1 To UpperBound(auParams.istParams[lRow].isvaleurstr)

		sVal =auParams.istParams[lRow].isvaleurstr[l]
		lPos = Pos(sVal,"=")
		
		if lPos <= 0 Then continue
		
		sNomCol = Upper(Left(sVal,lPos -1))
		sValCol = Right(sVal,Len(sVal) - lPos)
		
		If sValCol <> "" Then
		
			// #1 - Prise en compte du type de colonnes
			sTypeCol = dw_1.Describe(sNomCol + ".ColType")
			
			If sTypeCol = "?" or sTypeCol="!" Then Continue
			
			Choose Case Upper(sTypeCol)
				Case "INT", "LONG", "NUMBER", "ULONG"
					lVal = Long(sValCol)
					dw_1.setitem( lRow, sNomCol, lVal )		// #2
				Case "DATE"
					dtVal = date(sValCol)
					dw_1.setitem( lRow, sNomCol, dtVal )		// #2
				Case "DATETIME","TIMESTAMP"
					dttVal = datetime(sValCol)
					dw_1.setitem( lRow, sNomCol, dttVal )		// #2
				Case "REAL"
					rVal = real(sValCol)
					dw_1.setitem( lRow, sNomCol, rVal )		// #2
				Case "TIME"
					tVal = time(sValCol)
					dw_1.setitem( lRow, sNomCol, tVal )		// #2
				Case Else
					If Left(Upper(sTypeCol),3) = "DEC" Then
						// Decimal(n)
						dcVal = dec(sValCol)
						dw_1.setitem( lRow, sNomCol, dcVal )		// #2
					Else
						// Char(n) ou String
						dw_1.setitem( lRow, sNomCol, sValCol )		// #2
					End if
			End Choose
			
			bOk = True
		
		End If
		
	Next		
	
Next 

end subroutine

on w_message_reponse.create
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.dw_1,&
this.cb_cancel,&
this.cb_ok}
end on

on w_message_reponse.destroy
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;//*-----------------------------------------------------------------
//*
//* Objet			: w_message_reponse
//* Evenement 		: open
//* Auteur			: 
//* Date				: 24/06/2008 07:50:27
//* Libellé			: Initialisation des objets
//* Commentaires	: 
//*				   
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 FPI	 17/08/2009		[DCMP090404] Largeur de fen + ajout de l'entete
//*-----------------------------------------------------------------


s_se_params  sParams
Long    l, lTot, lLig
Long 	  lHeight
Long lNbRows, lLargeur // #1

// #1
lLargeur = 0

If ClassName(Message.PowerObjectParm) = "n_cst_spb_params" Then
	iuParams = Message.PowerObjectParm
	uf_initialiser(iuParams)
	If UpperBound( iuParams.iivaleurint) > 1 Then 
		lLargeur = iuParams.iivaleurint[2]
	End if
		
	ibmethodeold = FALSE
Else
	sParams = Message.PowerObjectParm
	if UpperBound(sParams.iivaleurint) > 1 Then lLargeur = sParams.iivaleurint[2]
	ibmethodeold = TRUE
	
	//sParams = Message.PowerObjectParm
// Fin #1
	
	/*------------------------------------------------------------------*/
	/* isvaleurstr[1] = Le titre                                               */
	/* isvaleurstr[2] = Le data object à mettre                                */
	/* isvaleurstr[3] = La chaine d'initialisation des colonnes                */
	/*           Format : "ID_COLX=val;ID_COLY=val;"                    */
	/*------------------------------------------------------------------*/
	
	If Upperbound( sParams.isvaleurstr ) > 1 Then
		This.Title = sParams.isvaleurstr[1]				// ... Gestion du titre
		This.dw_1.dataobject = sParams.isvaleurstr[2]	// ... Affectation du dataobject
		dw_1.insertrow(0)
		
		
		// #1
		If UpperBound(sParams.iivaleurint) > 0 Then
			lNbRows = sParams.iivaleurint[1]
		Else
			lNbRows = 1
		End If
		//
	
	//	If UpperBound( sParams.isvaleurstr ) > 2 Then This.wf_initialiser_defaut( sParams.isvaleurstr[3] )
		If UpperBound( sParams.isvaleurstr ) > 2 Then This.wf_initialiser_defaut( sParams.isvaleurstr[3],lNbRows )
		// Fin #1
		
		cb_ok.Enabled = True
		
		
	Else
		cb_ok.Enabled = False
	End If
	
End if // #1

/*------------------------------------------------------------------*/
/* Calcul de la hauteur de la fenêtre                               */
/*------------------------------------------------------------------*/
lHeight	= Long ( dw_1.Describe ( "Evaluate ( 'Sum ( RowHeight() for all )', 0  )" ) ) +5
		
// #1 - Ajout de l'entête
lHeight += Long (dw_1.Describe ( "DataWindow.Header.Height"))

dw_1.y = 115

dw_1.height = lHeight

cb_ok.y = 115 + lHeight + 115
cb_cancel.y = 115 + lHeight + 115

This.Height = 115 + lHeight + 115 + 115 + 115 + 80

// #1
if lLargeur > 0 Then
	// Calcul de la largeur de la fenêtre
	dw_1.width = lLargeur
	This.width = lLargeur + 128
	cb_ok.x = (this.Width - 1234 ) / 2
	cb_cancel.x = cb_ok.x + 741
End if
	

	
	


end event

type dw_1 from u_datawindow within w_message_reponse
integer x = 64
integer y = 116
integer width = 2144
integer height = 896
integer taborder = 10
boolean border = false
end type

event constructor;call super::constructor;
end event

event itemerror;stmessage.Bouton=OK!
stMessage.Icon=Exclamation!
stMessage.berreurG=TRUE
stMessage.sCode="GENE002"
stMessage.sVar[1]="saisie"
stMessage.sTitre=parent.title
f_message(stMessage)

Return 1
end event

event rbuttondown;// over script ancetre 
end event

type cb_cancel from commandbutton within w_message_reponse
integer x = 1189
integer y = 1104
integer width = 558
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annuler"
boolean cancel = true
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet			: w_message_reponse
//* Evenement 		: clicked
//* Auteur			: 
//* Date				: 24/06/2008 08:46:10
//* Libellé			: Annuler
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


CloseWithReturn ( Parent, "ANNULER" )
end event

type cb_ok from commandbutton within w_message_reponse
integer x = 512
integer y = 1104
integer width = 558
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ok"
boolean default = true
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Fonction		: w_message_reponse::clicked
//* Auteur			: 
//* Date				: 25/06/2008 16:44:11
//* Libellé			: 
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

String sRetour

if ibmethodeold Then
	sRetour = wf_serialiser()
	if sRetour <> "" Then CloseWithReturn ( Parent, sRetour )
Else 
	if wf_serialiser3()	 Then	CloseWithReturn ( Parent, iuparams )
End if 

end event

