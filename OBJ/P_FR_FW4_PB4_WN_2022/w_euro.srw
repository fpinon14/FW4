HA$PBExportHeader$w_euro.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre pour l'apparition d'une saisie en EURO dans les DW
forward
global type w_euro from window
end type
type uo_1 from u_euro within w_euro
end type
type r_1 from rectangle within w_euro
end type
type ln_1 from line within w_euro
end type
type ln_2 from line within w_euro
end type
end forward

global type w_euro from window
integer x = 439
integer y = 456
integer width = 891
integer height = 188
windowtype windowtype = popup!
long backcolor = 12632256
uo_1 uo_1
r_1 r_1
ln_1 ln_1
ln_2 ln_2
end type
global w_euro w_euro

type variables
Private :
	s_Euro	istEuro
	Integer	iiChoix
end variables

on close;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Euro::Close
//* Evenement 		: Close
//* Auteur			: Erick John Stark
//* Date				: 03/12/1996 10:31:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Decimal {2} dcMtConversion

If	iiChoix = 2 Then
	dcMtConversion = Uo_1.Uf_Euro2Franc ()

	istEuro.dwTrt.SetText ( String ( dcMtConversion ) )
End If

end on

on deactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Euro::Deactivate
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

iiChoix = 2
Close ( This )

end on

on open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Euro::Open
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 02/12/1996 16:11:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

istEuro = Message.PowerObjectParm
This.X = istEuro.iX
This.Y = istEuro.iY

/*------------------------------------------------------------------*/
/* La validit$$HEX2$$e9002000$$ENDHEX$$du montant est assur$$HEX2$$e9002000$$ENDHEX$$dans la fonction du UserObjet  */
/* U_DataWindow (Uf_ddSaisieEuro ).                                 */
/*------------------------------------------------------------------*/
uo_1.Uf_InitSaisirMontant ( istEuro.dcMtInitial )

end on

on key;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Euro::Key
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
			iiChoix = 1
			Close ( This )
ElseIf	KeyDown ( KeyTab! ) Then
			iiChoix = 2
			Close ( This )
End If

end on

on w_euro.create
this.uo_1=create uo_1
this.r_1=create r_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.Control[]={this.uo_1,&
this.r_1,&
this.ln_1,&
this.ln_2}
end on

on w_euro.destroy
destroy(this.uo_1)
destroy(this.r_1)
destroy(this.ln_1)
destroy(this.ln_2)
end on

type uo_1 from u_euro within w_euro
integer x = 14
integer y = 8
integer taborder = 10
boolean border = false
end type

on uo_1.destroy
call u_euro::destroy
end on

event ue_demande_quit;call super::ue_demande_quit;//Migration PB8-WYNIWYG-03/2004
iiChoix = 1
close(parent)
//Fin Migration PB8-WYNIWYG-03/2004

end event

event ue_demande_valide;call super::ue_demande_valide;//Migration PB8-WYNIWYG-03/2004
iiChoix = 2
close(parent)
//Fin Migration PB8-WYNIWYG-03/2004

end event

type r_1 from rectangle within w_euro
long linecolor = 16777215
integer linethickness = 9
long fillcolor = 12632256
integer x = 5
integer width = 882
integer height = 180
end type

type ln_1 from line within w_euro
long linecolor = 8421504
integer linethickness = 9
integer beginx = 882
integer endx = 882
integer endy = 172
end type

type ln_2 from line within w_euro
long linecolor = 8421504
integer linethickness = 9
integer beginx = 5
integer beginy = 176
integer endx = 882
integer endy = 176
end type

