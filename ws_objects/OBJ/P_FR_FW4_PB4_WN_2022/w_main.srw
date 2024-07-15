HA$PBExportHeader$w_main.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre Main pour la gestion de chacun des modules de l'application
forward
global type w_main from Window
end type
end forward

global type w_main from Window
int X=1075
int Y=481
int Width=2533
int Height=1593
boolean TitleBar=true
string Title="Untitled"
string MenuName="m_main"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_main w_main

forward prototypes
private function boolean wf_popmenu (ref s_glb astglb)
private function boolean wf_menuvisible (ref s_glb astglb, integer aicptmodule, integer aicptmenu)
end prototypes

private function boolean wf_popmenu (ref s_glb astglb);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_PopMenu (Private)
//* Auteur			: Erick John Stark
//* Date				: 04/09/1997 16:47:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Personnalisation du menu en fonction des droits de l'utilisateur
//*
//* Arguments		: s_GLB			astGLB				(R$$HEX1$$e900$$ENDHEX$$f)	Structure globale
//*
//* Retourne		: Boolean		True	= Tous est OK
//*										False = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

Integer	iCpt, iCpt1, iNbElement, iNbElement1

Boolean	bRet

bRet = True

/*------------------------------------------------------------------*/
/* On a initialis$$HEX2$$e9002000$$ENDHEX$$stGLB.sCodModule avec le nom du module sur       */
/* lequel on se positionne.(Fonction F_OuvreMain )                  */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On recherche ce module dans la liste des modules r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$s. On   */
/* doit forc$$HEX1$$e900$$ENDHEX$$ment le trouver.                                       */
/*------------------------------------------------------------------*/

iNbElement 	=	Upperbound ( astGLB.stModule [] )

For iCpt = 1 To iNbElement 

	If astGLB.stModule[ iCpt ].sCodModule = astGLB.sCodModule Then

/*------------------------------------------------------------------*/
/* On vient de le trouver, on va faire disparaitre les menus non    */
/* autoris$$HEX1$$e900$$ENDHEX$$s.                                                       */
/*------------------------------------------------------------------*/

		iNbElement1 = UpperBound ( astGLB.stModule[ iCpt ].sCodMenu[] )

		For iCpt1 = 1 To iNbElement1 
			If Not Wf_MenuVisible ( astGLB, iCpt, iCpt1 ) Then
				bRet = False
/*------------------------------------------------------------------*/
/* Un menu est mal d$$HEX1$$e900$$ENDHEX$$fini, il ne sert $$HEX2$$e0002000$$ENDHEX$$rien de continuer.          */
/*------------------------------------------------------------------*/
				Exit
			End If
		Next			

		This.Title = astGLB.stModule[ iCpt ].sLibModule
		
/*------------------------------------------------------------------*/
/* Pas besoin d'aller plus loin dans la boucle.                     */
/*------------------------------------------------------------------*/
		Exit
	End If
Next

/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut, si aucun module n'est trouv$$HEX2$$e9002000$$ENDHEX$$(Cas impossible $$HEX8$$e0002000200020002000200020002000$$ENDHEX$$*/
/* priori), tous les menus de ce module seront visibles.            */
/* (Car bRet est initilis$$HEX4$$e9002000e0002000$$ENDHEX$$vrai)                                  */
/*------------------------------------------------------------------*/

//If iCpt > iNbElement Then bRet = True

Return ( bRet )
end function

private function boolean wf_menuvisible (ref s_glb astglb, integer aicptmodule, integer aicptmenu);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_MenuVisible (Private)
//* Auteur			: Erick John Stark
//* Date				: 04/09/1997 17:01:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On masque les menus d'une fen$$HEX1$$ea00$$ENDHEX$$tre de type W_MAIN
//*
//* Arguments		: s_GLB			astGLB				(R$$HEX1$$e900$$ENDHEX$$f)	Structure globale
//*					  Integer		aiCptModule			(Val)	Position du module dans stGLB
//*					  Integer		aiCptMenu			(Val)	Position du menu dans stGLB.stModule
//*
//* Retourne		: Boolean		True	= Tout est OK
//*										False = Probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

Boolean	 	bRet

Integer		iNbElement, iNbElement1, iPos, iPos1

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nombre de menu "Primaires" d$$HEX1$$e900$$ENDHEX$$finis pour cette     */
/* fen$$HEX1$$ea00$$ENDHEX$$tre.                                                         */
/*------------------------------------------------------------------*/

iNbElement	=	UpperBound ( This.MenuId.Item[] )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le N$$HEX2$$b0002000$$ENDHEX$$du menu $$HEX2$$e0002000$$ENDHEX$$rendre invisible. (1er caract$$HEX1$$e800$$ENDHEX$$re)    */
/*------------------------------------------------------------------*/

iPos			=	Integer ( Left ( astGLB.stModule[ aiCptModule ].sCodMenu[ aiCptMenu ], 1 ) )

/*------------------------------------------------------------------*/
/* S'agit-il d'un menu "Primaire" ?                                 */
/*------------------------------------------------------------------*/

If	astGLB.stModule[ aiCptModule ].sTypMenu[ aiCptMenu ] = "P" Then

	If iPos > iNbElement Then 

/*------------------------------------------------------------------*/
/* Si Oui et que le N$$HEX2$$b0002000$$ENDHEX$$du menu (1er caract$$HEX1$$e800$$ENDHEX$$re) est sup$$HEX1$$e900$$ENDHEX$$rieur au     */
/* nombre maximum de menu "Primaire", il y a un probl$$HEX1$$e800$$ENDHEX$$me.           */
/*------------------------------------------------------------------*/

		stMessage.sCode	= "APPLI08"
		stMessage.sVar[1]	= This.MenuId.ClassName()
		stMessage.sVar[2]	= astGLB.stModule[ aiCptModule ].sCodMenu[ aiCptMenu ]
		stMessage.sVar[3]	= astGLB.stModule[ aiCptModule ].sTypMenu[ aiCptMenu ]

	Else

/*------------------------------------------------------------------*/
/* On vient de trouver le menu, (Primaire), on le rend invisible.   */
/*------------------------------------------------------------------*/

		This.MenuId.Item[ Integer ( Left ( astGLB.stModule[ aiCptModule ].sCodMenu[ aiCptMenu ], 1 ) ) ].Visible = False
		bRet = True
	End If

Else
/*------------------------------------------------------------------*/
/* Il s'agit dans ce cas d'un menu secondaire.                      */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le nombre de menu "secondaires" d$$HEX1$$e900$$ENDHEX$$finis pour ce menu.*/
/*------------------------------------------------------------------*/
	iNbElement1	=	UpperBound ( This.MenuId.Item[ iPos ].Item[] )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le N$$HEX2$$b0002000$$ENDHEX$$du menu $$HEX2$$e0002000$$ENDHEX$$rendre invisible.                    */
/* (Deux derniers caract$$HEX1$$e800$$ENDHEX$$re)                                        */
/*------------------------------------------------------------------*/
	iPos1	=	Integer ( Right ( astGLB.stModule[ aiCptModule ].sCodMenu[ aiCptMenu ], 2 ) )

	If ( iPos > iNbElement ) Or ( iPos1 > iNbElement1 ) Then

		stMessage.sCode	= "APPLI08"
		stMessage.sVar[1]	= This.MenuId.ClassName()
		stMessage.sVar[2]	= astGLB.stModule[ aiCptModule ].sCodMenu[ aiCptMenu ]
		stMessage.sVar[3]	= astGLB.stModule[ aiCptModule ].sTypMenu[ aiCptMenu ]

	Else
/*------------------------------------------------------------------*/
/* On vient de trouver le menu, (Secondaire), on le rend invisible. */
/*------------------------------------------------------------------*/
		This.MenuId.&
		Item[ Integer ( Left  ( astGLB.stModule[ aiCptModule ].sCodMenu[ aiCptMenu ], 1 ) ) ].&
		Item[ Integer ( Right ( astGLB.stModule[ aiCptModule ].sCodMenu[ aiCptMenu ], 2 ) ) ].Visible = False
		bRet	=	True
	End If

End If

Return ( bRet )

end function

on open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Main::Open
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
/* On va rendre les menus de la fen$$HEX1$$ea00$$ENDHEX$$tre invisibles, en fonction     */
/* des valeurs populis$$HEX1$$e900$$ENDHEX$$s pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$demment.                              */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* On teste $$HEX2$$e0002000$$ENDHEX$$tout hasard, si la structure globale est              */
/* correctement initialis$$HEX1$$e900$$ENDHEX$$e.                                        */
/*------------------------------------------------------------------*/

If	IsValid ( lstGLB ) Then
	If	Not Wf_PopMenu ( lstGLB ) Then
/*------------------------------------------------------------------*/
/* On affiche un message d'erreur si besoin. Ce message est arm$$HEX5$$e9002000200020002000$$ENDHEX$$*/
/* dans la fonction Wf_MenuInvisible.                               */
/*------------------------------------------------------------------*/
		stMessage.sTitre		= "Erreur dans W_Main - Wf_MenuInvisible"
		stMessage.Icon			= StopSign!
		stMessage.bErreurG	= True
		stMessage.bTrace		= True

		f_Message ( stMessage )
	End If
End If

end on

on w_main.create
if this.MenuName = "m_main" then this.MenuID = create m_main
end on

on w_main.destroy
if IsValid(MenuID) then destroy(MenuID)
end on

