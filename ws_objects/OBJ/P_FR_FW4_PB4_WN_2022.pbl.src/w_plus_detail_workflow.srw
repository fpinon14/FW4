HA$PBExportHeader$w_plus_detail_workflow.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre qui appara$$HEX1$$ee00$$ENDHEX$$t pour donner un compl$$HEX1$$e900$$ENDHEX$$ment de d$$HEX1$$e900$$ENDHEX$$tail sur W_QUEUE
forward
global type w_plus_detail_workflow from Window
end type
type dw_1 from datawindow within w_plus_detail_workflow
end type
type uo_1 from u_bord3d within w_plus_detail_workflow
end type
end forward

global type w_plus_detail_workflow from Window
int X=691
int Y=645
int Width=2254
int Height=1389
long BackColor=12632256
boolean Border=false
WindowType WindowType=popup!
dw_1 dw_1
uo_1 uo_1
end type
global w_plus_detail_workflow w_plus_detail_workflow

type variables
Private :
    s_calendrier  istcal
end variables

on open;//*-----------------------------------------------------------------
//*
//* Objet 			: w_Plus_Detail_WorkFlow
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

s_Pass stPass

stPass = Message.PowerObjectParm

//This.X = stPass.lTab[ 1 ]
//This.Y = stPass.lTab[ 2 ]

dw_1.ImportString ( stPass.sTab[ 1 ] )

end on

on deactivate;//*-----------------------------------------------------------------
//*
//* Objet 			: w_Plus_Detail_WorkFlow
//* Evenement 		: Deasctivate
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
//* Objet 			: w_Plus_Detail_WorkFlow
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

If KeyDown ( KeyEscape! ) Then
	Close ( This )
End If

end on

on w_plus_detail_workflow.create
this.dw_1=create dw_1
this.uo_1=create uo_1
this.Control[]={ this.dw_1,&
this.uo_1}
end on

on w_plus_detail_workflow.destroy
destroy(this.dw_1)
destroy(this.uo_1)
end on

type dw_1 from datawindow within w_plus_detail_workflow
int X=10
int Y=13
int Width=2222
int Height=1361
int TabOrder=20
string DataObject="d_detail_workflow"
boolean Border=false
boolean LiveScroll=true
end type

type uo_1 from u_bord3d within w_plus_detail_workflow
int X=1
int Y=1
int Width=2236
int Height=1381
int TabOrder=10
end type

on uo_1.destroy
call u_bord3d::destroy
end on

