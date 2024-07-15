HA$PBExportHeader$u_bord3d.sru
$PBExportComments$------} UserObjet qui simule un effet de bord en 3D
forward
global type u_bord3d from UserObject
end type
type r_bord from rectangle within u_bord3d
end type
type ln_droit from line within u_bord3d
end type
type ln_bas from line within u_bord3d
end type
end forward

global type u_bord3d from UserObject
int Width=942
int Height=629
long BackColor=12632256
r_bord r_bord
ln_droit ln_droit
ln_bas ln_bas
end type
global u_bord3d u_bord3d

type variables
Protected :
  Boolean ibEffet3D = True
end variables

on constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: u_bord3D
//* Evenement 		: Constuctor
//* Auteur			: Erick John Stark
//* Date				: 16/01/1997 18:13:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Construction d'un effet 3D
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibEffet3D	Then

	r_Bord.X				= 0
	r_Bord.Y				= 0

	r_Bord.Height		= This.Height
	r_Bord.Width		= This.Width
	r_Bord.Visible		= True

	ln_Droit.BeginY	= 0
	ln_Droit.EndY		= This.Height
	ln_Droit.BeginX	= This.Width - 3
	ln_Droit.EndX		= This.Width - 3
	
	ln_Droit.Visible	= True

	ln_Bas.BeginX		= 0
	ln_Bas.EndX			= This.Width
	ln_Bas.BeginY		= This.Height - 3
	ln_Bas.EndY			= This.Height - 3

	ln_Bas.Visible		= True

	This.Width	= This.Width	+ 9
	This.Height = This.Height	+ 9
	This.Border = True

End If


end on

on u_bord3d.create
this.r_bord=create r_bord
this.ln_droit=create ln_droit
this.ln_bas=create ln_bas
this.Control[]={ this.r_bord,&
this.ln_droit,&
this.ln_bas}
end on

on u_bord3d.destroy
destroy(this.r_bord)
destroy(this.ln_droit)
destroy(this.ln_bas)
end on

type r_bord from rectangle within u_bord3d
int Width=819
int Height=545
boolean Visible=false
boolean Enabled=false
int LineThickness=9
long LineColor=16777215
long FillColor=12632256
end type

type ln_droit from line within u_bord3d
boolean Visible=false
boolean Enabled=false
int BeginX=887
int BeginY=29
int EndX=887
int EndY=289
int LineThickness=9
long LineColor=8421504
end type

type ln_bas from line within u_bord3d
boolean Visible=false
boolean Enabled=false
int BeginX=23
int BeginY=597
int EndX=535
int EndY=597
int LineThickness=9
long LineColor=8421504
end type

