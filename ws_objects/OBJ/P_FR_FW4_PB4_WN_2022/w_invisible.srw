HA$PBExportHeader$w_invisible.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre utilis$$HEX1$$e900$$ENDHEX$$e dans EnvSpb
forward
global type w_invisible from Window
end type
type dw_data4 from datawindow within w_invisible
end type
type dw_data3 from datawindow within w_invisible
end type
type dw_data2 from u_datawindow within w_invisible
end type
type dw_data from u_datawindow within w_invisible
end type
end forward

global type w_invisible from Window
int X=1075
int Y=481
int Width=1271
int Height=1213
boolean Visible=false
boolean TitleBar=true
string Title="Untitled"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_data4 dw_data4
dw_data3 dw_data3
dw_data2 dw_data2
dw_data dw_data
end type
global w_invisible w_invisible

on w_invisible.create
this.dw_data4=create dw_data4
this.dw_data3=create dw_data3
this.dw_data2=create dw_data2
this.dw_data=create dw_data
this.Control[]={ this.dw_data4,&
this.dw_data3,&
this.dw_data2,&
this.dw_data}
end on

on w_invisible.destroy
destroy(this.dw_data4)
destroy(this.dw_data3)
destroy(this.dw_data2)
destroy(this.dw_data)
end on

type dw_data4 from datawindow within w_invisible
int X=599
int Y=669
int Width=494
int Height=361
boolean LiveScroll=true
end type

type dw_data3 from datawindow within w_invisible
int X=69
int Y=665
int Width=494
int Height=361
boolean LiveScroll=true
end type

type dw_data2 from u_datawindow within w_invisible
int X=170
int Y=129
int TabOrder=0
end type

type dw_data from u_datawindow within w_invisible
int X=37
int Y=37
int TabOrder=0
end type

