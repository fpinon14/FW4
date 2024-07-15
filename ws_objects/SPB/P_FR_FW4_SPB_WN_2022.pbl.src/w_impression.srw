HA$PBExportHeader$w_impression.srw
$PBExportComments$----} Fen$$HEX1$$ea00$$ENDHEX$$tre d'attente des impressions d$$HEX1$$e900$$ENDHEX$$taill$$HEX1$$e900$$ENDHEX$$es
forward
global type w_impression from Window
end type
type p_imp from picture within w_impression
end type
type st_text from statictext within w_impression
end type
end forward

global type w_impression from Window
int X=951
int Y=1221
int Width=1559
int Height=265
boolean TitleBar=true
string Title="Impression en cours..."
long BackColor=12632256
WindowType WindowType=popup!
p_imp p_imp
st_text st_text
end type
global w_impression w_impression

forward prototypes
public subroutine wf_text (string astext)
end prototypes

public subroutine wf_text (string astext);//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_text
//* Auteur			:	La Recrue
//* Date				:	04/12/97 09:27:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Afiche le text d$$HEX1$$e900$$ENDHEX$$sir$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	:	
//*
//* Arguments		:	String	asText	(Val)	Text$$HEX3$$e0002000e900$$ENDHEX$$crire
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

st_Text.Text = asText


end subroutine

on open;//*-----------------------------------------------------------------
//*
//* Objet			:	w_impression
//* Evenement 		:	Open
//* Auteur			:	La Recrue
//* Date				:	04/12/97 09:17:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Potitionnement de la fen$$HEX1$$ea00$$ENDHEX$$tre au centre
//* Commentaires	:	de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

This.Move ( ParentWindow().x + Int( ParentWindow().Width / 2 )  - Int( This.Width  / 2) , &
				ParentWindow().y + Int( ParentWindow().Height / 2 ) - Int( This.Height / 2) )

This.Title = Message.StringParm


end on

on w_impression.create
this.p_imp=create p_imp
this.st_text=create st_text
this.Control[]={ this.p_imp,&
this.st_text}
end on

on w_impression.destroy
destroy(this.p_imp)
destroy(this.st_text)
end on

type p_imp from picture within w_impression
int X=19
int Y=53
int Width=206
int Height=113
string PictureName="k:\pb4obj\bmp\8_imp.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_text from statictext within w_impression
int X=229
int Y=65
int Width=1258
int Height=73
boolean Enabled=false
string Text="Impression en cours..."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

