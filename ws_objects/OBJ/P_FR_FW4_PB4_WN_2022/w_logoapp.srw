HA$PBExportHeader$w_logoapp.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre de logo
forward
global type w_logoapp from w_ancetre
end type
type dw_logo from datawindow within w_logoapp
end type
end forward

global type w_logoapp from w_ancetre
boolean visible = true
integer x = 809
integer y = 344
integer width = 2309
integer height = 1016
boolean enabled = false
windowtype windowtype = popup!
long backcolor = 16777215
dw_logo dw_logo
end type
global w_logoapp w_logoapp

event open;//*****************************************************************************
//
// Objet 		: w_LogoApp
// Evenement 	: Open
//	Auteur		: D.Bizien
//	Date			: 22/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de logo
// Commentaires: Positionnement des $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments relatifs $$HEX2$$e0002000$$ENDHEX$$l'application si 
//					  structure SPB est renseign$$HEX1$$e900$$ENDHEX$$e
// ----------------------------------------------------------------------------
// 	MAJ 	PAR		Date				Modification
//	#1		LBP		24/06/2010		[Recup vers SVN] Affichage de la revision SVN
//*****************************************************************************

s_GLB		sttGLB		// Structure globale de l'application
String	sImport		// Chaine d'import pour la datawindow 

sttGLB	=	Message.PowerObjectParm

If isValid ( sttGLB ) Then
	//[Recup vers SVN] remplacement de la version par sttGLB.sRevisionSvn
	sImport	=	sttGLB.sCodOper			+	"~t" + &
					sttGLB.sLibCourtAppli	+	"~t" + &
					sttGLB.sRevisionSvn		+	"~t" + &
					sttGLB.sDteDerCnx			+	"~t" + &
					sttGLB.sDteDerDCnx

	Dw_Logo.ImportString ( sImport )
Else

	Dw_Logo.InsertRow ( 0 )
End If
end event

on w_logoapp.create
int iCurrent
call super::create
this.dw_logo=create dw_logo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_logo
end on

on w_logoapp.destroy
call super::destroy
destroy(this.dw_logo)
end on

type cb_debug from w_ancetre`cb_debug within w_logoapp
end type

type dw_logo from datawindow within w_logoapp
integer x = 91
integer y = 72
integer width = 2135
integer height = 860
integer taborder = 1
string dataobject = "d_logo"
boolean border = false
boolean livescroll = true
end type

