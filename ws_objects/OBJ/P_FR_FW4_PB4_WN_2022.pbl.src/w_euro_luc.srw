HA$PBExportHeader$w_euro_luc.srw
forward
global type w_euro_luc from window
end type
type sle_1 from singlelineedit within w_euro_luc
end type
type dw_1 from datawindow within w_euro_luc
end type
end forward

global type w_euro_luc from window
integer x = 439
integer y = 456
integer width = 603
integer height = 84
boolean border = false
windowtype windowtype = popup!
long backcolor = 12632256
sle_1 sle_1
dw_1 dw_1
end type
global w_euro_luc w_euro_luc

type variables
Private :
	s_Euro_Luc	istEuroLuc

end variables

event open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Euro_Luc::Open
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 02/12/1996 16:11:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*				  
//*-----------------------------------------------------------------
//* #1   PLJ 28/04/1999 Je vide le CLipboard 
//* #2   FS  02/08/2001 Adaptation du format en fonction de l'unit$$HEX1$$e900$$ENDHEX$$
//*                     mon$$HEX1$$e900$$ENDHEX$$taire de la base
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//u_DeclarationWindows16 uo_gestion				//#1 D$$HEX1$$e900$$ENDHEX$$claration d'un nvuo u_Declaration16 pour acc$$HEX1$$e900$$ENDHEX$$der aux API
//uo_gestion = create u_DeclarationWindows16   //   de ClipBoard
u_DeclarationWindows32	uo_gestion				//#1 D$$HEX1$$e900$$ENDHEX$$claration d'un nvuo u_Declaration32 pour acc$$HEX1$$e900$$ENDHEX$$der 
uo_gestion = create u_DeclarationWindows32	//  aux API de ClipBoard
//Fin Migration PB8-WYNIWYG-03/2006 FM

Integer iRet
String sText, sModif

istEuroLuc = Message.PowerObjectParm
This.X		= istEuroLuc.iX
This.Y		= istEuroLuc.iY
This.Width	= istEuroLuc.iW

dw_1.Width	= istEuroLuc.iW + 6

dw_1.InsertRow ( 0 )

dw_1.SetItem ( 1, "MT_EURO", istEuroLuc.dcMontantEuro )

// ... #2 D$$HEX1$$e900$$ENDHEX$$but de modification

If stGLB.sMonnaieFormatDesire = "E" Then
	sModif = "mt_euro.Format='#,##0.00 \F'"
Else
	sModif = "mt_euro.Format='#,##0.00 \$$HEX1$$ac20$$ENDHEX$$'"
End If

dw_1.modify ( sModif )

// ... #2 Fin de modification

sText = "MT_EURO.Width=" + String ( istEuroLuc.iW + 4)

dw_1.Modify ( sText )

/*------------------------------------------------------------------*/
/* #1 Je vide le ClipBoard, avant d'y recopier le montant de la sle */
/*   pour ne plus avoir de probl$$HEX1$$e800$$ENDHEX$$me avec les copier fait sous word  */
/*------------------------------------------------------------------*/

iRet = uo_gestion.uf_EmptyClipBoard ()

sle_1.Text = istEuroLuc.sMontantClipBoard

//Migration PB8-WYNIWYG-03/2006 FM
//Destroy ( uo_Gestion )
If IsValid(uo_Gestion) Then Destroy uo_Gestion
//Fin Migration PB8-WYNIWYG-03/2006 FM

ClipBoard ( sle_1.Text )



end event

on deactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Euro_Luc::Deactivate
//* Evenement 		: Deactivate
//* Auteur			: Erick John Stark
//* Date				: 02/12/1996 16:14:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Si on perd le Focus, on ferme la fen$$HEX1$$ea00$$ENDHEX$$tre
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Close ( This )

end on

on key;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Euro_Luc::Key
//* Evenement 		: Key
//* Auteur			: Erick John Stark
//* Date				: 02/12/1996 16:14:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Si on appuie sur ESC, on ferme la fen$$HEX1$$ea00$$ENDHEX$$tre
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If 		KeyDown ( KeyEscape! ) Then
			Close ( This )
End If

end on

on w_euro_luc.create
this.sle_1=create sle_1
this.dw_1=create dw_1
this.Control[]={this.sle_1,&
this.dw_1}
end on

on w_euro_luc.destroy
destroy(this.sle_1)
destroy(this.dw_1)
end on

type sle_1 from singlelineedit within w_euro_luc
integer x = 41
integer y = 224
integer width = 247
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_euro_luc
integer width = 517
integer height = 72
integer taborder = 10
string dataobject = "d_euro_luc"
boolean border = false
boolean livescroll = true
end type

