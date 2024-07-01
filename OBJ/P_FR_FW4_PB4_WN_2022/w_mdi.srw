HA$PBExportHeader$w_mdi.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre MDI anc$$HEX1$$ea00$$ENDHEX$$tre de l'application
forward
global type w_mdi from Window
end type
type mdi_1 from mdiclient within w_mdi
end type
end forward

global type w_mdi from Window
int X=1
int Y=1
int Width=4682
int Height=3073
boolean TitleBar=true
string Title="Untitled"
string MenuName="m_mdi"
long BackColor=268435456
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowType WindowType=mdihelp!
event ue_initialisation pbm_custom75
mdi_1 mdi_1
end type
global w_mdi w_mdi

on open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Mdi::Open
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 03/09/1997 17:02:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre principale
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Je pr$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$re utiliser un nom diff$$HEX1$$e900$$ENDHEX$$rent pout stGLB pour $$HEX1$$ea00$$ENDHEX$$tre sur    */
/* que cela ne pose pas de probl$$HEX1$$e800$$ENDHEX$$me.                                */
/*------------------------------------------------------------------*/

s_GLB lstGLB

lstGLB	= Message.PowerObjectParm

/*------------------------------------------------------------------*/
/* Logiquement on a correctement initialis$$HEX2$$e9002000$$ENDHEX$$stGLB. Le UserObjet     */
/* est toujours actif, la fen$$HEX1$$ea00$$ENDHEX$$tre W_Invisible est toujours          */
/* ouverte.                                                         */
/* On va populiser les modules accessibles $$HEX2$$e0002000$$ENDHEX$$l'op$$HEX1$$e900$$ENDHEX$$rateur. En        */
/* retour, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re dans la structure globale la liste des       */
/* menus par module $$HEX2$$e0002000$$ENDHEX$$rendre invisibles.                            */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On teste $$HEX2$$e0002000$$ENDHEX$$tout hasard, si la structure globale est              */
/* correctement initialis$$HEX1$$e900$$ENDHEX$$e.                                        */
/*------------------------------------------------------------------*/

If	IsValid ( lstGLB ) Then
	This.Title = lstGLB.sLibAppli

	If	IsValid ( lstGLB.uoEnvSpb ) Then
		lstGLB.uoEnvSpb.Uf_PopMenu ( This, lstGLB )
	Else
		lstGLB.uoSesame.Uf_PopMenu ( This, lstGLB )
	End If

End If

Message.PowerObjectParm = lstGLB

/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$clenechement d'un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement pour le script client              */
/* $$HEX1$$e900$$ENDHEX$$ventuellement.                                                  */
/*------------------------------------------------------------------*/

This.PostEvent ( "Ue_Initialisation" )

end on

on closequery;//********************************************************************************
//
// Window 		: W_MDI
// Evenement 	: CloseQuery
//	Auteur		: D.Bizien
//	Date			: 12/02/1996
// Objet			: Demande de sortie de l'application par l'utilisateur
// Commentaires: Est appel$$HEX2$$e9002000$$ENDHEX$$lors d'une demande de sortie de l'applicatif soit par
//					  la fermeture de la fenetre principale soit par menu
// -------------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//********************************************************************************


Int iBoutonRet		// Bouton Click$$HEX2$$e9002000$$ENDHEX$$pour le messageBox


iBoutonRet = Messagebox ("APPLICATION","Voulez-vous r$$HEX1$$e900$$ENDHEX$$ellement quitter l'application",Exclamation!,OkCancel!,2)

If iBoutonRet = 2 Then

	Message.Processed 	= True
	Message.ReturnValue 	= 1
End If

end on

on w_mdi.create
if this.MenuName = "m_mdi" then this.MenuID = create m_mdi
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_mdi.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_mdi
long BackColor=268435456
end type

