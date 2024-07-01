HA$PBExportHeader$w_accueil_edition_2000.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre d'$$HEX1$$e900$$ENDHEX$$dition
forward
global type w_accueil_edition_2000 from w_accueil
end type
type cb_tout from commandbutton within w_accueil_edition_2000
end type
type cb_aucun from commandbutton within w_accueil_edition_2000
end type
type st_1 from statictext within w_accueil_edition_2000
end type
type st_2 from statictext within w_accueil_edition_2000
end type
type st_nombre from statictext within w_accueil_edition_2000
end type
type st_edit from statictext within w_accueil_edition_2000
end type
type mle_msg from u_rapport within w_accueil_edition_2000
end type
type pb_editer from picturebutton within w_accueil_edition_2000
end type
end forward

global type w_accueil_edition_2000 from w_accueil
integer x = 0
integer y = 0
integer width = 3621
integer height = 1904
event spb_preparerimpression pbm_custom01
event spb_imprimerdossier pbm_custom02
event spb_terminerimpression pbm_custom03
cb_tout cb_tout
cb_aucun cb_aucun
st_1 st_1
st_2 st_2
st_nombre st_nombre
st_edit st_edit
mle_msg mle_msg
pb_editer pb_editer
end type
global w_accueil_edition_2000 w_accueil_edition_2000

type variables
Private :
	Boolean		ibStopTraitement
	Boolean		ibSupprimerLigne

Protected :
	N_Cst_Edition_Courrier	invEditionCourrier
	Long		ilNbrDossierSelection

	Boolean		ibPositionnerObjet=TRUE
	Long		ilIdProd, ilIdLigne
end variables

forward prototypes
private subroutine wf_positionnerobjets ()
protected subroutine wf_actualiser (long alnbr)
protected subroutine wf_setsupprimerligne (boolean absupprimerligne)
protected subroutine wf_setstoptraitement (boolean abStopTraitement)
private function long wf_editer ()
protected function boolean wf_getsupprimerligne ()
protected function boolean wf_getstoptraitement ()
protected subroutine wf_setnbrdossierselection (long alnbrdossierselection)
protected function long wf_getnbrdossierselection ()
protected subroutine wf_selectionner (boolean abactiver)
protected subroutine wf_verifiermodeleword ()
protected subroutine wf_changermodele (string asmodele)
protected subroutine wf_armementproduit ()
end prototypes

private subroutine wf_positionnerobjets ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Edition_2000::wf_PositionnerObjets		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 29/03/2000 15:43:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On s'occupe de positionner tous les objets de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On taille la MLE et la DW au format de la fen$$HEX1$$ea00$$ENDHEX$$tre 'parent'.      */
/*------------------------------------------------------------------*/
Mle_Msg.X		=   19
Mle_Msg.Height	=  421
Mle_Msg.Width	= 3548

Cb_Tout.X		=   33
Cb_Tout.Y		=  621

Cb_Aucun.X		=  316
Cb_Aucun.Y		=  621

St_1.X			=  878
St_1.Y			=  633

St_Nombre.X		= 1509
St_Nombre.Y		=  621

St_2.X			= 2295
St_2.Y			=  633

St_Edit.X		= 2949
St_Edit.Y		=  621

dw_1.X			=   19
dw_1.Y			=  761
dw_1.Width		= 3548
dw_1.Height		=  941

dw_1.Visible	= TRUE
end subroutine

protected subroutine wf_actualiser (long alnbr);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Edition_2000::Wf_Actualiser			(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 09:48:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: (Val)		Long		alNbr
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sText
Long lTotLigne

sText = String ( alNbr ) + " / " + String ( dw_1.RowCount () )

If	alNbr > 0	Then
	If	Not Pb_Editer.Enabled	Then Pb_Editer.Enabled = TRUE
Else
	Pb_Editer.Enabled = FALSE
	ilNbrDossierSelection = 0
End If

st_Nombre.Text = sText


end subroutine

protected subroutine wf_setsupprimerligne (boolean absupprimerligne);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Edition_2000::wf_SetSupprimerLigne		(PROTECTED)
//* Auteur			: Erick John Stark
//* Date				: 03/04/2000 09:25:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne la suppression de la ligne trait$$HEX1$$e900$$ENDHEX$$e
//*
//* Arguments		: (Val)		Boolean		abSupprimerLigne
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

ibSupprimerLigne = abSupprimerLigne

end subroutine

protected subroutine wf_setstoptraitement (boolean abStopTraitement);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Edition_2000::wf_SetStopTraitement		(PROTECTED)
//* Auteur			: Erick John Stark
//* Date				: 03/04/2000 09:25:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne la variable ibStopTraitement
//*
//* Arguments		: (Val)		Boolean		abStopTraitement
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

ibStopTraitement = abStopTraitement

end subroutine

private function long wf_editer ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Edition_2000::wf_Editer			(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 29/03/2000 17:15:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On lance l'$$HEX1$$e900$$ENDHEX$$dition
//*
//* Arguments		: Aucun
//*
//* Retourne		: Long
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	   Modification
//* #1		 JFF		16/01/04 DCMP 030483, Gestion de modele de courrier diff$$HEX1$$e900$$ENDHEX$$rents.
//*-----------------------------------------------------------------

String sText
String sK_RETOUR	= "~r"
String sK_NEWLINE	= "~n"

Long lRet, lIdLigne

SetPointer( HourGlass! )
ilIdProd = -1

/*------------------------------------------------------------------*/
/* On efface le texte de la MLE.                                    */
/*------------------------------------------------------------------*/
Mle_Msg.Uf_ActiverTrace ( stGLB, FALSE, "" )
Mle_Msg.Uf_EffacerText ()

/*------------------------------------------------------------------*/
/* On initialise le NVUO, ainsi que le fichier INI pour la          */
/* communication avec WORD.                                         */
/*------------------------------------------------------------------*/
sText = "Initialisation du fichier INI ..." + sK_RETOUR + sK_NEWLINE
Mle_Msg.Uf_AjouterText ( sText )

lRet = invEditionCourrier.uf_Initialiser ( "E" )
If	lRet <> 1	Then
	sText = "L'initialisation du fichier INI vient d'$$HEX1$$e900$$ENDHEX$$chouer. "							+ & 
			  "(Erreur : " + String ( lRet ) + ")"												+ &
			  sK_RETOUR + sK_NEWLINE

	Mle_Msg.uf_RemplacerText ( sText )
	Return ( lRet )
Else
	sText = "Initialisation du fichier INI OK" + sK_RETOUR + sK_NEWLINE
	Mle_Msg.Uf_RemplacerText ( sText )
End If
/*------------------------------------------------------------------*/
/* On essaye de d$$HEX1$$e900$$ENDHEX$$marrer WORD.                                      */
/*------------------------------------------------------------------*/
sText = "Initialisation de la communication avec WORD ..." + sK_RETOUR + sK_NEWLINE
Mle_Msg.Uf_AjouterText ( sText )

lRet = invEditionCourrier.uf_InitialiserWord ( FALSE )
If	lRet <> 1	Then
	sText = "L'initialisation de la communication avec WORD vient d'$$HEX1$$e900$$ENDHEX$$chouer. "		+ & 
			  "(Erreur : " + String ( lRet ) + ")"												+ &
			  sK_RETOUR + sK_NEWLINE
			  
	Mle_Msg.uf_RemplacerText ( sText )
	Return ( lRet )
Else
	sText = "Initialisation de la communication avec WORD OK." + sK_RETOUR + sK_NEWLINE
	Mle_Msg.Uf_RemplacerText ( sText )
End If
/*------------------------------------------------------------------*/
/* On proc$$HEX1$$e900$$ENDHEX$$de $$HEX2$$e0002000$$ENDHEX$$l'initialisation du fichier SPOOL.                  */
/*------------------------------------------------------------------*/
sText = "Initialisation du fichier SPOOL ..." + sK_RETOUR + sK_NEWLINE
Mle_Msg.Uf_AjouterText ( sText )

lRet = invEditionCourrier.uf_InitialiserFichierSpool ()
If	lRet <> 1	Then
	sText = "L'initialisation du fichier SPOOL vient d'$$HEX1$$e900$$ENDHEX$$chouer. "						+ & 
			  "(Erreur : " + String ( lRet ) + ")"												+ &
			  sK_RETOUR + sK_NEWLINE
			  
	Mle_Msg.uf_RemplacerText ( sText )
	Return ( lRet )
Else
	sText = "Initialisation du fichier SPOOL OK." + sK_RETOUR + sK_NEWLINE
	Mle_Msg.Uf_RemplacerText ( sText )
End If
/*------------------------------------------------------------------*/
/* On s'occupe maintenant de la boucle pour le traitement des       */
/* dossiers.                                                        */
/*------------------------------------------------------------------*/
sText = "Traitement des dossiers en cours ..." + sK_RETOUR + sK_NEWLINE
Mle_Msg.Uf_AjouterText ( sText )
/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$sactive tous les objets de la fen$$HEX1$$ea00$$ENDHEX$$tre d'$$HEX1$$e900$$ENDHEX$$dition.            */
/*------------------------------------------------------------------*/
This.TriggerEvent ( "Ue_DisabledFenetre" )
/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$clenche un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement pour pr$$HEX1$$e900$$ENDHEX$$parer l'impression.            */
/*------------------------------------------------------------------*/
This.TriggerEvent ( "SPB_PreparerImpression" )
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le premier dossier s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$dans la DW_1.         */
/*------------------------------------------------------------------*/
lIdLigne = dw_1.GetSelectedRow ( 0 )
/*------------------------------------------------------------------*/
/* On commence la boucle de traitement tant qu'il n'y a pas         */
/* d'erreur.                                                        */
/*------------------------------------------------------------------*/
Do While ( lIdLigne > 0 ) And ( Not ibStopTraitement )
/*------------------------------------------------------------------*/
/* #1 :DCMP 030483, Gestion de mod$$HEX1$$e800$$ENDHEX$$les de courriers diff$$HEX1$$e900$$ENDHEX$$rents.     */
/*------------------------------------------------------------------*/
	ilIdLigne = lIdLigne
	This.wf_ArmementProduit ()
	This.wf_VerifierModeleWord ()
/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$clenche un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement pour le script client, en lui donnant  */
/* le N$$HEX2$$b0002000$$ENDHEX$$de la ligne $$HEX2$$e0002000$$ENDHEX$$traiter.                                     */
/*------------------------------------------------------------------*/
	This.TriggerEvent ( "SPB_ImprimerDossier", lIdLigne, lIdLigne )
	
	If	( Not ibStopTraitement )	Then
/*------------------------------------------------------------------*/
/* S'il le client positionne le param$$HEX1$$e800$$ENDHEX$$tre $$HEX2$$e0002000$$ENDHEX$$VRAI, on supprime la    */
/* ligne en cours de traitement pour lui.                           */
/*------------------------------------------------------------------*/
		If	wf_GetSupprimerLigne ()	Then
			dw_1.Visible = FALSE
			dw_1.DeleteRow ( lIdLigne )
			dw_1.Visible = TRUE
		End If
/*------------------------------------------------------------------*/
/* Il n'y a pas d'erreur pendant l'impression, on continue le       */
/* traitement avec le dossier suivant.                              */
/*------------------------------------------------------------------*/
		lIdLigne --
		lIdLigne = dw_1.GetSelectedRow ( lIdLigne )
	End If
Loop
/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$clenche un $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement pour permettre au script client de     */
/* terminer la session d'impression.                                */
/*------------------------------------------------------------------*/
This.TriggerEvent ( "SPB_TerminerImpression" )
dw_1.SelectRow ( 0, FALSE )
ilNbrDossierSelection = 0
wf_Actualiser ( 0 )
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$active le $$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments de la fen$$HEX1$$ea00$$ENDHEX$$tre.                           */
/*------------------------------------------------------------------*/
This.TriggerEvent ( "Ue_EnabledFenetre" )

stMessage.sTitre 		= "EDITION"
stMessage.Icon			= Information!
stMessage.sCode		= "ANCE020"
stMessage.bErreurG	= True

//f_Message( stMessage )

ibStopTraitement = False

Return ( 1 )

end function

protected function boolean wf_getsupprimerligne ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Edition_2000::wf_SetSupprimerLigne		(PROTECTED)
//* Auteur			: Erick John Stark
//* Date				: 03/04/2000 09:25:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la variable ibSupprimerLigne
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Return ( ibSupprimerLigne )

end function

protected function boolean wf_getstoptraitement ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Edition_2000::wf_GetStopTraitement		(PROTECTED)
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 16:01:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la valeur ibStopTraitement
//*
//* Arguments		: 
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Return ( ibStopTraitement )


end function

protected subroutine wf_setnbrdossierselection (long alnbrdossierselection);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Edition_2000::wf_SetSupprimerLigne		(PROTECTED)
//* Auteur			: Erick John Stark
//* Date				: 03/04/2000 09:25:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne la valeur de ilNbrDossierSelection
//*
//* Arguments		: (Val)		Long		ilNbrDossierSelection
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

ilNbrDossierSelection	= alNbrDossierSelection
wf_Actualiser ( ilNbrDossierSelection )

end subroutine

protected function long wf_getnbrdossierselection ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Edition_2000::wf_GetNbrDossierSelection		(PROTECTED)
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 16:01:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la valeur ilNbrDossierSelection
//*
//* Arguments		: 
//*
//* Retourne		: Boolean
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Return ( ilNbrDossierSelection )
end function

protected subroutine wf_selectionner (boolean abactiver);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Accueil_Edition_2000::wf_Selectionner			(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 09:25:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On active/d$$HEX1$$e900$$ENDHEX$$sactive la s$$HEX1$$e900$$ENDHEX$$lection des lignes dans dw_1
//*
//* Arguments		: (Val)		Boolean		abActiver	
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long lTot

dw_1.SetRedraw ( FALSE )

If	abActiver	Then
	dw_1.SelectRow ( 0, TRUE )
	
	lTot = dw_1.RowCount ()
Else	
	dw_1.SelectRow ( 0, FALSE )
	
	lTot  = 0
End If

dw_1.SetRedraw ( TRUE )

ilNbrDossierSelection = lTot
wf_Actualiser ( lTot )

end subroutine

protected subroutine wf_verifiermodeleword ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_Accueil_Edition_2000::wf_VerifierModeleWord (PROTECTED)
//* Auteur        : Fabry JF
//* Date          : 16/01/2004 11:21:33
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Verification du Modele de courrier
//* Commentaires  : Doit on utiliser COURRIER.DOT ou un autre modele '-MD'
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Cod$$HEX2$$e9002000$$ENDHEX$$sur les descendants                                         */
/*------------------------------------------------------------------*/

Return
end subroutine

protected subroutine wf_changermodele (string asmodele);//*-----------------------------------------------------------------
//*
//* Fonction      : wf_ChangerModele::wf_ChangerModele (PROTECTED)
//* Auteur        : Fabry JF
//* Date          : 15/01/2004 15:39:27
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Changer dynamiquement le mod$$HEX1$$e800$$ENDHEX$$le 
//* Commentaires  : 
//*
//* Arguments     : String		asModele			Val     // Nouveau mod$$HEX1$$e800$$ENDHEX$$le $$HEX2$$e0002000$$ENDHEX$$appliquer
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------


invEditionCourrier.uf_ChangerModele ( asModele )
end subroutine

protected subroutine wf_armementproduit ();//*-----------------------------------------------------------------
//*
//* Fonction      : w_accueil_Edition_2000::wf_ArmementProduit (PROTECTED)
//* Auteur        : Fabry JF
//* Date          : 19/01/2004 16:50:48
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Armement de la variable d'instance ilIdProd
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Cod$$HEX2$$e9002000$$ENDHEX$$sur les descendants.                                        */
/*------------------------------------------------------------------*/

Return 
end subroutine

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet			: W_Accueil_Edition_2000
//* Evenement 		: Open					(EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 29/03/2000 11:50:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: On s'occupe de positionner automatiquement les objets
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//  #1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

String sSpoolExe, sRepWin, sFicSpoolNon

/*------------------------------------------------------------------*/
/* On instancie le nvuo pour la gestion de l'$$HEX1$$e900$$ENDHEX$$dition.               */
/*------------------------------------------------------------------*/
invEditionCourrier = CREATE N_Cst_Edition_Courrier
/*------------------------------------------------------------------*/
/* On positionne tous les objets de la fen$$HEX1$$ea00$$ENDHEX$$tre.                     */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La variable ibPositionnerObjet est une variable d'instance de    */
/* type PROTECTED. S'il s'agit d'une fen$$HEX1$$ea00$$ENDHEX$$tre normale d'$$HEX1$$e900$$ENDHEX$$dition, on  */
/* laisse le boolean $$HEX2$$e0002000$$ENDHEX$$TRUE et les objets seront positionn$$HEX1$$e900$$ENDHEX$$s        */
/* automatiquement. Si on d$$HEX1$$e900$$ENDHEX$$sire une fen$$HEX1$$ea00$$ENDHEX$$tre particuli$$HEX1$$e800$$ENDHEX$$re (Cas des  */
/* relances, on positionne ce boolean $$HEX2$$e0002000$$ENDHEX$$FALSE dans l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement      */
/* ue_Initialiser) et on customise la fen$$HEX1$$ea00$$ENDHEX$$tre.                      */
/*------------------------------------------------------------------*/
If	ibPositionnerObjet	Then wf_PositionnerObjets ()
/*------------------------------------------------------------------*/
/* On initialise les variables d'instances.                         */
/*------------------------------------------------------------------*/
ibStopTraitement				= FALSE
ilNbrDossierSelection		= 0

wf_Actualiser ( ilNbrDossierSelection )

dw_1.Uf_Activer_Selection( False )
/*------------------------------------------------------------------*/
/* Affecte l'object de transaction $$HEX2$$e0002000$$ENDHEX$$la variable d'instance.        */
/*------------------------------------------------------------------*/
istPass.trTrans	= SQLCA
//Migration PB8-WYNIWYG-03/2006 FM
//l'objet de transaction de la fen$$HEX1$$ea00$$ENDHEX$$tre est la variable d'instance itrTrans
itrTrans = istPass.trTrans
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* !!ATTENTION!!. On lance une premi$$HEX1$$e800$$ENDHEX$$re fois l'impression afin de   */
/* permettre au programme et aux DLL PB7 d'$$HEX1$$ea00$$ENDHEX$$tre charg$$HEX1$$e900$$ENDHEX$$es en         */
/* m$$HEX1$$e900$$ENDHEX$$moire. En effet, le premier lancement de ce programme sur des  */
/* machines 'lentes' ne se termine pas bien.                        */
/*------------------------------------------------------------------*/
sSpoolExe	= ProfileString ( stGLB.sFichierIni, "APPLICATION", "EXE_SPOOL",  &
				  ProfileString ( stGlb.sWinDir + "\MAJPOST.INI", "PARAM", "DESTINATION", "C:" ) + "\SPOOLPB7.EXE" )

Run ( sSpoolExe, Minimized! )
/*------------------------------------------------------------------*/
/* A la fin du lancement, il existe un fichier SPOOL_OK.NON. Cela   */
/* est tout $$HEX2$$e0002000$$ENDHEX$$fait normal puisque l'on positionne aucun param$$HEX1$$ea00$$ENDHEX$$tre   */
/* pour SPOOLPB7.EXE.                                               */
/*------------------------------------------------------------------*/

//#1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//sRepWin			= stGLB.sWinDir + "\TEMP" + "\"
sRepWin			= stGLB.sRepTempo
//#1 [DCMP-060643.SPOOL] Modification Temporaire, desactiv$$HEX1$$e900$$ENDHEX$$e
//sRepWin			= stGLB.sWinDir + "\TEMP" + "\"
sFicSpoolNon	= sRepWin + "SPOOL_OK.NON"

//Migration PB8-WYNIWYG-03/2006 CP
//If	FileExists ( sFicSpoolNon ) Then FileDelete ( sFicSpoolNon )
If	f_FileExists ( sFicSpoolNon ) Then FileDelete ( sFicSpoolNon )
//Fin Migration PB8-WYNIWYG-03/2006 CP

end event

on ue_fin_interro;call w_accueil::ue_fin_interro;//*****************************************************************************
//
// Objet 		: w_Accueil_Edition
// Evenement 	: Ue_Fin_Interro
//	Auteur		: La Recrue
//	Date			: 14/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Enable les objets utiles $$HEX2$$e0002000$$ENDHEX$$l'impression si des lignes sont pr$$HEX1$$e900$$ENDHEX$$sentes
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

SetPointer( HourGlass! )

If ( dw_1.RowCount() > 0 ) Then

	cb_Tout.Enabled	= True
	cb_Aucun.Enabled	= True
	pb_Editer.Enabled	= True

	wf_Selectionner ( TRUE )
Else

	cb_Tout.Enabled	= False
	cb_Aucun.Enabled	= False
	pb_Editer.Enabled	= False

	wf_Selectionner ( FALSE )
End If
end on

on ue_taillerhauteur;//*-----------------------------------------------------------------
//*
//* Objet			: W_Accueil_Edition_2000
//* Evenement 		: Ue_TaillerHauteur						(OVERRIDE) !!
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 15:56:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne le script en OVERRIDE pour positionner
//*						la DW manuellement
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

end on

on ue_disablefenetre;call w_accueil::ue_disablefenetre;//*-----------------------------------------------------------------
//*
//* Objet			: W_Accueil_Edition_2000
//* Evenement 		: Ue_DisabledFenetre				(EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 15:56:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Pb_Editer.Enabled			= FALSE
Cb_Aucun.Enabled			= FALSE
Cb_Tout.Enabled			= FALSE


end on

on ue_enablefenetre;call w_accueil::ue_enablefenetre;//*-----------------------------------------------------------------
//*
//* Objet			: W_Accueil_Edition_2000
//* Evenement 		: Ue_EnabledFenetre				(EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 15:56:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Pb_Editer.Enabled			= TRUE
Cb_Aucun.Enabled			= TRUE
Cb_Tout.Enabled			= TRUE


end on

on close;call w_accueil::close;//*-----------------------------------------------------------------
//*
//* Objet			: W_Accueil_Edition_2000
//* Evenement 		: Close	(EXTEND)
//* Auteur			: Erick John Stark
//* Date				: 29/03/2000 11:19:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On supprime le NVUO.                                             */
/*------------------------------------------------------------------*/
If IsValid ( invEditionCourrier )	Then DESTROY	invEditionCourrier

end on

on w_accueil_edition_2000.create
int iCurrent
call super::create
this.cb_tout=create cb_tout
this.cb_aucun=create cb_aucun
this.st_1=create st_1
this.st_2=create st_2
this.st_nombre=create st_nombre
this.st_edit=create st_edit
this.mle_msg=create mle_msg
this.pb_editer=create pb_editer
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_tout
this.Control[iCurrent+2]=this.cb_aucun
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_nombre
this.Control[iCurrent+6]=this.st_edit
this.Control[iCurrent+7]=this.mle_msg
this.Control[iCurrent+8]=this.pb_editer
end on

on w_accueil_edition_2000.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_tout)
destroy(this.cb_aucun)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_nombre)
destroy(this.st_edit)
destroy(this.mle_msg)
destroy(this.pb_editer)
end on

on ue_centreracc;//*-----------------------------------------------------------------
//*
//* Objet			: W_Accueil_Edition_2000
//* Evenement 		: Ue_CentreAcc						(OVERRIDE) !!
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 15:56:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On positionne le script en OVERRIDE pour positionner
//*						la DW manuellement
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

end on

type pb_retour from w_accueil`pb_retour within w_accueil_edition_2000
integer width = 233
integer height = 136
integer taborder = 10
integer textsize = -7
string facename = "Arial"
string picturename = "k:\pb4obj\bmp\8_quit.bmp"
end type

type pb_interro from w_accueil`pb_interro within w_accueil_edition_2000
integer x = 288
integer width = 233
integer height = 136
integer taborder = 40
integer textsize = -7
string facename = "Arial"
string picturename = "k:\pb4obj\bmp\8_inter.bmp"
end type

type pb_creer from w_accueil`pb_creer within w_accueil_edition_2000
boolean visible = false
integer x = 2651
integer y = 12
integer width = 155
integer height = 100
integer taborder = 0
integer textsize = -7
string facename = "Arial"
boolean enabled = false
end type

type dw_1 from w_accueil`dw_1 within w_accueil_edition_2000
integer x = 18
integer y = 760
integer width = 3547
integer height = 940
integer taborder = 60
end type

event dw_1::clicked;call super::clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_Accueil_Edition_2000::dw_1
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 09:31:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* #1		PHG		06/12/2006 Correction Bug compteur
//*-----------------------------------------------------------------

Boolean	bSelected
Long		lRow, lNbrSelection

lNbrSelection = Parent.wf_GetNbrDossierSelection ()

//Migration PB8-WYNIWYG-03/2006 FM
//lRow = GetClickedRow()
lRow = row
//Fin Migration PB8-WYNIWYG-03/2006 FM

If ( lRow > 0 ) Then 

	bSelected = IsSelected( lRow )

	If ( bSelected ) Then
		lNbrSelection --
	Else
		lNbrSelection ++
	End If

	SelectRow( lRow, Not bSelected )

	Parent.wf_SetNbrDossierSelection ( lNbrSelection )
End If

end event

on dw_1::ue_modifiermenu;call w_accueil`dw_1::ue_modifiermenu;//*-----------------------------------------------------------------
//*
//* Objet			: W_Accueil_Edition_2000::dw_1
//* Evenement 		: Ue_ModifierMenu
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 09:31:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

This.Uf_mnu_CacherItem ( 1 )
This.Uf_mnu_CacherItem ( 2 )
This.Uf_mnu_CacherItem ( 3 )
This.Uf_mnu_CacherItem ( 4 )

This.Uf_mnu_AjouterItem ( 6, "Editer" )

If ( dw_1.GetSelectedRow ( 0 ) > 0 ) Then
	This.Uf_Mnu_AutoriserItem ( 6 )
Else
	This.Uf_Mnu_InterdirItem ( 6 )
End If


end on

event dw_1::retrievestart;call super::retrievestart;//*-----------------------------------------------------------------
//*
//* Objet			: w_accueil_edition_2000
//* Evenement 		: retrievestart
//* Auteur			: Pierre-Henri Gillot
//* Date				: 06/12/2006 14:15:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 PAR	 06/12/2006   Correction bug Compteur
//*-----------------------------------------------------------------

//#1 A cahque retrieve, le nombre de ligne selectionn$$HEX2$$e9002000$$ENDHEX$$est forcement $$HEX2$$e0002000$$ENDHEX$$0
wf_setnbrdossierselection (0)

end event

type pb_tri from w_accueil`pb_tri within w_accueil_edition_2000
integer x = 558
integer width = 233
integer height = 136
integer taborder = 70
integer textsize = -7
string facename = "Arial"
string picturename = "k:\pb4obj\bmp\8_tri.bmp"
end type

type pb_imprimer from w_accueil`pb_imprimer within w_accueil_edition_2000
integer x = 2885
integer y = 12
integer width = 146
integer height = 100
integer taborder = 0
end type

type cb_tout from commandbutton within w_accueil_edition_2000
integer x = 32
integer y = 620
integer width = 247
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Tous"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_Accueil_Edition_2000::Cb_Tout
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 09:31:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: On s$$HEX1$$e900$$ENDHEX$$lectionne toutes les lignes
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

wf_Selectionner ( TRUE )

end on

type cb_aucun from commandbutton within w_accueil_edition_2000
integer x = 315
integer y = 620
integer width = 247
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aucun"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_Accueil_Edition_2000::Cb_Aucun
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 30/03/2000 09:31:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: On d$$HEX1$$e900$$ENDHEX$$s$$HEX1$$e900$$ENDHEX$$lectionne toutes les lignes
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

wf_Selectionner ( FALSE )

end on

type st_1 from statictext within w_accueil_edition_2000
integer x = 878
integer y = 632
integer width = 608
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nombre de dossiers $$HEX2$$e0002000$$ENDHEX$$traiter"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_accueil_edition_2000
integer x = 2295
integer y = 632
integer width = 608
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nombre de dossiers $$HEX1$$e900$$ENDHEX$$dit$$HEX1$$e900$$ENDHEX$$s"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_nombre from statictext within w_accueil_edition_2000
integer x = 1509
integer y = 620
integer width = 375
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_edit from statictext within w_accueil_edition_2000
integer x = 2949
integer y = 620
integer width = 375
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type mle_msg from u_rapport within w_accueil_edition_2000
integer x = 18
integer y = 172
integer width = 3547
integer height = 420
integer taborder = 0
end type

type pb_editer from picturebutton within w_accueil_edition_2000
integer x = 827
integer y = 16
integer width = 233
integer height = 136
integer taborder = 20
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Editer"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\8_word.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet			: W_Accueil_Edition_2000::Pb_Editer
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 31/03/2000 16:37:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: Long
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On envoie l'$$HEX1$$e900$$ENDHEX$$dition.                                             */
/*------------------------------------------------------------------*/
wf_Editer ()
end on

