HA$PBExportHeader$w_routage.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre qui appara$$HEX1$$ee00$$ENDHEX$$t lors du routage d'un travail ( DCMP 990391)
forward
global type w_routage from w_ancetre
end type
type pb_1 from u_8_pbretour within w_routage
end type
type pb_router from picturebutton within w_routage
end type
type dw_routage from datawindow within w_routage
end type
type dw_motif from datawindow within w_routage
end type
type gb_1 from groupbox within w_routage
end type
end forward

global type w_routage from w_ancetre
boolean visible = true
integer x = 983
integer y = 712
integer width = 1746
integer height = 1492
boolean titlebar = true
windowtype windowtype = response!
pb_1 pb_1
pb_router pb_router
dw_routage dw_routage
dw_motif dw_motif
gb_1 gb_1
end type
global w_routage w_routage

type variables
Private:

	Boolean  ibMotifRoutage	//#1
end variables

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_routage::Open
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 12/06/1997 11:01:21
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de routage
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*	#1 DBI 	31/08/99 DCMP 990391 : Gestion des motifs de routage		  
//    #2 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

U_DeclarationWindows	nvWin
String sWinDir, sFicCorb, sFicOper, sFiltre, sFicEssaiTrc, sFicEssaiTrcRout
String sIdOper, sIdCorb, sMotif
Long lNbElement, lCpt

s_Pass stPass

DataWindowChild 	dwCodOper       	// DDDW du Code Op$$HEX1$$e900$$ENDHEX$$rateur
DataWindowChild 	dwIdCorb       	// DDDW du Code Corbeille

stPass = Message.PowerObjectParm

nvWin		= stGLB.uoWin
sWinDir	= nvWin.Uf_GetWindowsDirectory ()
//#2 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//sWinDir	= sWinDir + "\TEMP\"
sWinDir	= stGlb.sRepTempo

If	stPass.sTab[1] = "1" Then

	This.Title = "Gestion du Routage - Saisie du dossier " + stPass.sTab[ 2 ]
	
	// #1 Gestion des motifs de routage uniquement en validation
	ibMotifRoutage	= False		// #1
Else

	This.Title = "Gestion du Routage - Validation du dossier " + stPass.sTab[ 2 ]

	ibMotifRoutage	= True		//#1 
End If


/*------------------------------------------------------------------*/
/* #1 Modification DBI le 30/08/1999                                */
/* Gestion des motifs de routage                                    */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$initialisation des motifs de routage et des coefficients       */
/*------------------------------------------------------------------*/

If ibMotifRoutage Then

	stPass.DwNorm[ 1 ].ShareData ( Dw_Motif )

	lNbElement	=	Dw_Motif.RowCount ( )

	For lCpt = 1 To lNbElement

		Dw_Motif.SetItem ( lCpt, "ALT_ERR", stNul.str )
		Dw_Motif.SetItem ( lCpt, "COEFF"  , stNul.inum )
	Next

Else

/*------------------------------------------------------------------*/
/* #1 Je masque la saisie des motifs de routage                     */
/*------------------------------------------------------------------*/

	Dw_Motif.Visible 	= False
	Gb_1.Visible 		= False
	This.Height			= 965
	Pb_Router.Y			= 681
	Pb_1.Y				= 681
End If	

/*------------------------------------------------------------------*/
/* Le 04/06/1999.                                                   */
/* Modif DGA: On v$$HEX1$$e900$$ENDHEX$$rifie si l'on peut ecrire dans le r$$HEX1$$e900$$ENDHEX$$pertoire de  */
/* TRACE. Si ce n'est pas le cas, on empeche le routage.            */
/*------------------------------------------------------------------*/
lNbElement = UpperBound ( stPass.sTab[] )

If	lNbElement > 2	Then
	sFicEssaiTrc 		= stPass.sTab[ 5 ]
	sFicEssaiTrcRout 	= stPass.sTab[ 6 ]		//#1

	If	F_Verifier_Ecriture_Trace ( sFicEssaiTrc     ) < 0	Or &
		F_Verifier_Ecriture_Trace ( sFicEssaiTrcRout ) < 0	Then
/*------------------------------------------------------------------*/
/* On affiche un message d'erreur que l'on ne peut tracer. On sort  */
/* ensuite imm$$HEX1$$e900$$ENDHEX$$diatement de la fonction.                            */
/*------------------------------------------------------------------*/
		stMessage.sTitre		= "Gestion des sinistres"
		stMessage.Icon			= StopSign!
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "APPLI09"
   	stMessage.bTrace  	= False

		F_Message ( stMessage )
		Pb_Router.Enabled = False
	End If
	
	sIdOper = stPass.sTab[ 3 ]
	sIdCorb = stPass.sTab[ 4 ]

End If

dw_Routage.InsertRow ( 0 )

dw_Routage.GetChild ( "COD_OPER", dwCodOper )
dw_Routage.GetChild ( "ID_CORB", dwIdCorb )

sFicCorb = sWinDir + "CORB" + stGLB.sCodAppli + ".TXT" 
sFicOper = sWinDir + "OPER" + stGLB.sCodAppli + ".TXT" 

dwCodOper.ImportFile ( sFicOper )
dwIdCorb.ImportFile ( sFicCorb )

/*------------------------------------------------------------------*/
/* On arme les zones COD_OPER et ID_CORB avec les valeurs que l'on  */
/* passe en param$$HEX1$$ea00$$ENDHEX$$tres.                                             */
/*------------------------------------------------------------------*/
If	Not IsNull ( sIdOper )	Then dw_Routage.SetItem ( 1, "COD_OPER", sIdOper )
If	Not IsNull ( sIdCorb )	Then 
	dw_Routage.SetItem ( 1, "ID_CORB", sIdCorb )
Else
	sIdCorb = "9999"
End If

/*------------------------------------------------------------------*/
/* On va filtrer la DDDW sur les op$$HEX1$$e900$$ENDHEX$$rateurs.                        */
/*------------------------------------------------------------------*/
sFiltre = "ID_CORB = " + sIdCorb
dwCodOper.SetFilter ( sFiltre )
dwCodOper.Filter ()
dwCodOper.Sort ()


end event

on ue_retour;call w_ancetre::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			: w_routage::Ue_Retour
//* Evenement 		: Ue_Retour
//* Auteur			: Erick John Stark
//* Date				: 14/06/1997 17:38:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: La personne ne veut plus router le dossier
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass	stPass

stPass.sTab[ 1 ] = "RET"

CloseWithReturn ( This, stPass )


end on

on w_routage.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_router=create pb_router
this.dw_routage=create dw_routage
this.dw_motif=create dw_motif
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_router
this.Control[iCurrent+3]=this.dw_routage
this.Control[iCurrent+4]=this.dw_motif
this.Control[iCurrent+5]=this.gb_1
end on

on w_routage.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.pb_router)
destroy(this.dw_routage)
destroy(this.dw_motif)
destroy(this.gb_1)
end on

type pb_1 from u_8_pbretour within w_routage
integer x = 626
integer y = 1256
integer width = 233
integer height = 136
integer taborder = 50
end type

type pb_router from picturebutton within w_routage
integer x = 896
integer y = 1256
integer width = 233
integer height = 136
integer taborder = 30
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ro&uter"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_routag.bmp"
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: w_routage::Clicked::pb_Router
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 14/06/1997 17:38:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: La personne veut router le dossier
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*	#1 DBI 	31/08/99 DCMP 990391 : Gestion des motifs de routage		  
//*-----------------------------------------------------------------

s_Pass	stPass

Long lNbrCol, lCpt
Decimal {1}	dcCoeff

String sPos, sText, sAltErr

String 		sCol[3]				//Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier
String		sErr[3]				//Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier 

If	dw_Routage.AcceptText ()  > 0 Then

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie que toutes les zones sont saisies                     */
/*------------------------------------------------------------------*/

	sCol[ 1 ]				= "COD_OPER"
	sCol[ 2 ]				= "ID_CORB"
	sCol[ 3 ]				= "TXT_MESS1"

	sErr[ 1 ]				= " - Le code de l'op$$HEX1$$e900$$ENDHEX$$rateur"
	sErr[ 2 ]				= " - Le code de la corbeille"
	sErr[ 3 ]				= " - Le message du routage"

	sPos 	= ""
	sText = ""

	lNbrCol = UpperBound ( sCol )

	For	lCpt = 1 To lNbrCol

		stPass.sTab[ lCpt + 1 ]	= dw_Routage.GetItemString ( 1, sCol[ lCpt ] )

		If ( IsNull ( stPass.sTab[ lCpt + 1 ] ) or Trim ( stPass.sTab[ lCpt + 1 ] ) = "" )	Then

			If ( sPos = "" ) 	Then 	sPos = sCol[ lCpt ]
			sText = sText + sErr[ lCpt ] + "~r~n"
		End If
	Next

	// #1 gestion des motifs de routage

	If ibMotifRoutage Then

		Dw_Motif.AcceptText ()
		lNbrCol =Dw_Motif.RowCount ()

		lCpt	  =	Dw_Motif.Find ( "ALT_ERR = ~"O~"", 1, lNbrCol )

		If lCpt > 0 Then 

	/*------------------------------------------------------------------*/
	/* V$$HEX1$$e900$$ENDHEX$$rification qu'un coefficient est positionn$$HEX2$$e9002000$$ENDHEX$$sur chaque motif   */
	/* de routage coch$$HEX1$$e900$$ENDHEX$$.                                                */
	/*------------------------------------------------------------------*/
			For	lCpt = 1 To lNbrCol

				sAltErr	=	Dw_Motif.GetItemString ( lCpt, "ALT_ERR" )
				If sAltErr = 'O' Then

					dcCoeff	=	Dw_Motif.GetItemNumber ( lCpt, "COEFF" )
					If isNull ( dcCoeff ) Then
	/*------------------------------------------------------------------*/
	/* Je repositionne le curseur sur la Dw_Routage car elle ne         */
	/* poss$$HEX1$$e800$$ENDHEX$$de qu'une ligne                                             */
	/*------------------------------------------------------------------*/
						If ( sPos = "" ) 	Then 	sPos = sCol[ 1 ]
						sText = sText + " - Le coefficient pour l'erreur : " + Dw_Motif.GetItemString ( lCpt, "ERREUR" )  + "~r~n"
					End If

				End If
			Next
		Else

			If ( sPos = "" ) 	Then 	sPos = sCol[ 1 ]
			sText = sText + " - Au moins un motif de routage~r~n"
		
		End If

	End If //#1

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/

	If	( sPos <> "" ) Then

		stMessage.bErreurG	= True
		stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie du Routage"
		stMessage.Icon			= Information!
		stMessage.sVar[1] 	= sText
		stMessage.sCode		= "ANCE045"

		f_Message ( stMessage )

		dw_Routage.SetColumn ( sPos )
		dw_Routage.SetFocus ()

	Else

		stPass.sTab[ 1 ] = "ROU"
		CloseWithReturn ( Parent, stPass )

	End If
End If

end event

type dw_routage from datawindow within w_routage
integer x = 9
integer y = 8
integer width = 1733
integer height = 672
integer taborder = 10
string dataobject = "d_routage"
boolean border = false
boolean livescroll = true
end type

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Routage::ItemError
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 14/06/1997 18:17:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des Erreurs 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Le seul cas ou l'on vient ici, c'est parce que le message est    */
/* incorrect                                                        */
/*------------------------------------------------------------------*/

String sErrCol, sText

stMessage.sTitre	= "Gestion du Routage"
stMessage.Icon		= Information!

sErrCol		= Upper ( This.GetColumnName () )
sText			= This.GetText ()

Choose Case sErrCol
Case "TXT_MESS1"
	stMessage.bErreurG	= True
	stMessage.sVar[1] 	= "Message pour le routage"
	stMessage.sCode		= "ANCE046"

// JCA - developpement en cours...
Case "COD_OPER"
	stMessage.bErreurG	= True
	stMessage.sVar[1] 	= "op$$HEX1$$e900$$ENDHEX$$rateur"
	stMessage.sCode		= "GENE008"
	setnull(sText)
End Choose

f_Message ( stMessage )

This.SetItem ( This.GetRow (), This.GetColumn (), sText )

//Migration PB8-WYNIWYG-03/2006 CP
//This.SetActionCode ( 1 )
Return ( 1 )
//Fin Migration PB8-WYNIWYG-03/2006 CP


end event

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: Dw_Routage::ItemChanged!
//* Evenement 		: ItemChanged!
//* Auteur			: Erick John Stark
//* Date				: 10/11/1998 15:35:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JCA	06/12/2006	Modification de la gestion du routage				  
//*-----------------------------------------------------------------

String sNomCol, sFiltre, sIdCorb, sNull
Integer iActionCode
DataWindowChild 	dwCodOper

String sFind // #1
Long lFind, lTotDwOper // #1

iActionCode = 0
sNomCol = Upper ( dw_Routage.GetColumnName () )

If	sNomCol = "ID_CORB"	Then
//Migration PB8-WYNIWYG-03/2006 FM
//	sIdCorb	= dw_Routage.GetText ()
	sIdCorb	= data
//Fin Migration PB8-WYNIWYG-03/2006 FM
	sFiltre	= "ID_CORB = " + sIdCorb

	dw_Routage.GetChild ( "COD_OPER", dwCodOper )
	dwCodOper.SetFilter ( sFiltre )
	dwCodOper.Filter ()
	dwCodOper.Sort ()	
End If

// #1
If	sNomCol = "COD_OPER"	Then
	dw_Routage.GetChild ( "COD_OPER", dwCodOper )
	
	lTotDwOper = dwCodOper.Rowcount()
	sFind = "COD_OPER = '" + data + "'"
	
	lFind = dwCodOper.Find ( sFind, 1, long ( lTotDwOper ) )
	
	if lfind <= 0 then
		iActionCode = 1
	end if
End if
// #1 - FIN
	
return iActionCode
end event

type dw_motif from datawindow within w_routage
integer x = 50
integer y = 700
integer width = 1646
integer height = 516
integer taborder = 20
string dataobject = "d_routage_motif"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_routage
integer x = 27
integer y = 652
integer width = 1687
integer height = 592
integer taborder = 40
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

