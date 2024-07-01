HA$PBExportHeader$w_attente.srw
forward
global type w_attente from Window
end type
type p_1 from picture within w_attente
end type
type st_message from statictext within w_attente
end type
type st_1 from statictext within w_attente
end type
end forward

global type w_attente from Window
int X=2058
int Y=1849
int Width=1724
int Height=389
long BackColor=12632256
WindowType WindowType=response!
event attendre pbm_custom01
p_1 p_1
st_message st_message
st_1 st_1
end type
global w_attente w_attente

type variables
st_Attente	istAttente
end variables

on attendre;Int	iImageNumber = 0, i
uint	uiHandle, uiHwnd
Int	iSc_Close = 61536, &
		iWm_SysCommand = 274
Long lResult

uiHandle = stGLB.uoWin.Uf_GetModuleHandle(istAttente.sProg)

Do While ( uiHandle <> 0 )

	For i = 1 to 1000
		Yield ()
	Next

	If ( iImageNumber = 64 ) Then iImageNumber = 0
	iImageNumber ++
	p_1.PictureName = "K:\PB4OBJ\BMP\REV" + String ( iImageNumber ) + ".bmp"

	If istAttente.iTours > 0 Then istAttente.iTours --

	If istAttente.iTours = 0 Then
		uiHwnd = stGLB.uoWin.Uf_FindWindow ( istAttente.sClass, istAttente.sNom )
		If ( uiHwnd > 0 ) Then
			lResult	= Send( uiHwnd, iWm_SysCommand, iSc_Close, 0 )
			If ( lResult < 0 ) Then
				MessageBox( This.Title, "Erreur fermeture gestionnaire d'impression" )
				Return
			Else
				istAttente.iTours  =  -1
			End If
		End If
	End If
	uiHandle = stGLB.uoWin.Uf_GetModuleHandle(istAttente.sProg)

Loop

Close ( This )
end on

on open;SetPointer(HourGlass!)
istAttente = Message.PowerObjectParm
st_Message.Text = istAttente.sText
This.PostEvent("Attendre")

end on

on w_attente.create
this.p_1=create p_1
this.st_message=create st_message
this.st_1=create st_1
this.Control[]={ this.p_1,&
this.st_message,&
this.st_1}
end on

on w_attente.destroy
destroy(this.p_1)
destroy(this.st_message)
destroy(this.st_1)
end on

type p_1 from picture within w_attente
int X=74
int Y=29
int Width=147
int Height=129
string PictureName="k:\pb4obj\bmp\rev1.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_message from statictext within w_attente
int X=5
int Y=201
int Width=1710
int Height=85
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_attente
int X=5
int Y=113
int Width=1710
int Height=73
boolean Enabled=false
string Text="Veuillez patienter."
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

