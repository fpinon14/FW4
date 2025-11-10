HA$PBExportHeader$w_interro.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre pour toutes les fen$$HEX1$$ea00$$ENDHEX$$tres d'interrogation
forward
global type w_interro from w_ancetre
end type
type uo_1 from u_bd_interro within w_interro
end type
type dw_1 from u_datawindow within w_interro
end type
end forward

global type w_interro from w_ancetre
boolean visible = true
integer x = 361
integer y = 1200
integer width = 1947
integer height = 1684
boolean titlebar = true
windowtype windowtype = response!
event ue_envoi pbm_custom01
uo_1 uo_1
dw_1 dw_1
end type
global w_interro w_interro

type variables
Public : 
      String	isClause
      String              isClauseFrancais

Protected :
      Long		ilNbrCol

      s_Interro          istInterro

Private :
      String              isMoteur
      String	isFicConfig
end variables

forward prototypes
private subroutine wf_ficsauve ()
protected function long wf_construirechaine ()
protected subroutine wf_posfenetre ()
end prototypes

event ue_envoi;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Interro::Ue_Envoi
//* Evenement 		: Ue_Envoi
//* Auteur			: Erick John Stark
//* Date				: 20/02/1996 16:05:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sFicTrace, sRep, sMaintenant, sNomMachine, sLigne
String sTab
s_Pass stPass

U_DeclarationWindows	nvWin

sTab = "~t"

Choose Case uo_1.ilBouton
Case 1		
/*------------------------------------------------------------------*/
/* On vient d'appuyer sur le bouton Valider, on va construire la    */
/* cha$$HEX1$$ee00$$ENDHEX$$ne correspondant aux valeurs renseign$$HEX1$$e900$$ENDHEX$$es.                    */
/*------------------------------------------------------------------*/

	If	dw_1.AcceptText () > 0 Then
		Wf_ConstruireChaine ()

/*------------------------------------------------------------------*/
/* On assigne les valeurs de la clause $$HEX2$$e0002000$$ENDHEX$$la structure               */
/*------------------------------------------------------------------*/

		iwParent.TriggerEvent ( "UE_FERMER_INTERRO" )

		stPass.sTab[1] = isClause
		stPass.sTab[2] = isClauseFrancais

		sRep			= ProfileString ( stGLB.sFichierIni, "TRACE", "REP_TRACE_I", "" )

/*------------------------------------------------------------------*/
/* Si la section n'existe pas, on n'$$HEX1$$e900$$ENDHEX$$crit rien dans la trace.       */
/*------------------------------------------------------------------*/

		If	sRep <> "" Then

/*------------------------------------------------------------------*/
/* On initialise maintenant le nom du fichier de TRACE au format    */
/* JJMMAAAA.App (App correspond au code de l'application).          */
/* Pour connaitre le r$$HEX1$$e900$$ENDHEX$$pertoire qui contient le fichier de TRACE,   */
/* il faut lire la section TRACE du fichier INI de l'application.   */
/*------------------------------------------------------------------*/

			sFicTrace	= sRep + String ( Today (), "ddmmyyyy" ) + "." + Left ( stGLB.sCodAppli, 3 )

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re maintenant le nom de la machine. On part du principe */
/* que ce nom est positionn$$HEX2$$e9002000$$ENDHEX$$dans la valeur Dos (SQL=XXX)           */
/*------------------------------------------------------------------*/
			nvWin				= stGLB.uoWin
			sNomMachine 	= nvWin.uf_GetEnvironment ( "SQL" )

			sMaintenant = String ( DateTime ( Today(), Now() ), "dd/mm/yyyy hh:mm:ss" )

			sLigne = sMaintenant 			+ sTab + &
						stGLB.sCodAppli		+ sTab + &
						sNomMachine 			+ sTab + &
						stGLB.sCodOper			+ sTab + &
						istInterro.sCodeDw	+ sTab + &
						isClause

			f_EcrireFichierText ( sFicTrace, sLigne )
		End If

/*------------------------------------------------------------------*/
/* On sauvegarde les coordonn$$HEX1$$e900$$ENDHEX$$es de la fen$$HEX1$$ea00$$ENDHEX$$tre                      */
/*------------------------------------------------------------------*/
		Wf_FicSauve ()

/*------------------------------------------------------------------*/
/* Fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre et envoi de la cha$$HEX1$$ee00$$ENDHEX$$ne g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e            */
/*------------------------------------------------------------------*/
		CloseWithReturn ( This, stPass )

	End If

Case 2		

/*------------------------------------------------------------------*/
/* On vient d'appuyer sur le bouton Retour, la cha$$HEX1$$ee00$$ENDHEX$$ne est vide. On  */
/* sauvegarde les coordonn$$HEX1$$e900$$ENDHEX$$es de la fen$$HEX1$$ea00$$ENDHEX$$tre.                        */
/*------------------------------------------------------------------*/
	Wf_FicSauve ()

/*------------------------------------------------------------------*/
/* On assigne les valeurs de la clause $$HEX2$$e0002000$$ENDHEX$$la structure               */
/*------------------------------------------------------------------*/

	stPass.sTab[1] = ""
	stPass.sTab[2] = ""

	CloseWithReturn ( This, stPass )


Case 3
/*------------------------------------------------------------------*/
/* On vient d'appuyer sur le bouton Effacer.                        */
/*------------------------------------------------------------------*/

	dw_1.Reset ()
	dw_1.InsertRow ( 0 )
	dw_1.SetFocus ()

End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

private subroutine wf_ficsauve ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_FicSauve (Private)
//* Auteur			: Erick John Stark
//* Date				: 22/02/1996 15:29:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Sauvegarde des coordonn$$HEX1$$e900$$ENDHEX$$es de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sText, sRc, sSection

sRc			= "~n~r"

/*------------------------------------------------------------------*/
/* On va enregistrer les coordonn$$HEX1$$e900$$ENDHEX$$es de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interro, si    */
/* le code est bien initialis$$HEX1$$e900$$ENDHEX$$. Cela permettra de r$$HEX1$$e900$$ENDHEX$$ouvrir la       */
/* fen$$HEX1$$ea00$$ENDHEX$$tre au m$$HEX1$$ea00$$ENDHEX$$me endroit.                                         */
/*------------------------------------------------------------------*/

If	istInterro.sCodeDw = "" Or IsNull ( istInterro.sCodeDw ) Then Return 

/*------------------------------------------------------------------*/
/* Si le fichier n'existe pas, on le cr$$HEX3$$e900e9002000$$ENDHEX$$et on enregistre les      */
/* coordonn$$HEX1$$e900$$ENDHEX$$es.                                                     */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Chaque section se definit de la mani$$HEX1$$e800$$ENDHEX$$re suivante "Code           */
/* Application + Nom de la Dw Interro" (Ex [SA COMPAGNIE])          */
/*------------------------------------------------------------------*/

sSection = stGLB.sCodAppli + " " + istInterro.sCodeDw

//Migration PB8-WYNIWYG-03/2006 CP
//If	Not FileExists ( isFicConfig ) Then
If	Not f_FileExists ( isFicConfig ) Then
//Fin Migration PB8-WYNIWYG-03/2006 CP	
	
	sText = "[" + sSection + "]" + sRc + "X=" + String ( This.X ) + sRc + "Y=" + String ( This.Y ) + sRc
	f_EcrireFichierText ( isFicConfig, sText )

Else

	SetProfileString ( isFicConfig, sSection, "X", String ( This.X ) )
	SetProfileString ( isFicConfig, sSection, "Y", String ( This.Y ) )

End If

end subroutine

protected function long wf_construirechaine ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Interro::wf_ConstruireChaine (Protected)
//* Auteur			: Erick John Stark
//* Date				: 23/07/1997 16:47:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Construction de la chaine SQL
//*
//* Arguments		: Aucun
//*
//* Retourne		: Long			 1 = Tout est OK
//*										-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*
//* DGA  18/08/1997 		Prise en compte du moteur SQL Server pour les recherches sur les cl$$HEX1$$e900$$ENDHEX$$s en num$$HEX1$$e900$$ENDHEX$$rique,
//*							ainsi que les dates, datetime et time
//* # MADM 07/06/2006   Projet DNTMAIL1 : Ajout d'un test qui permet de Ne pas tenir compte du crit$$HEX1$$e900$$ENDHEX$$re
//*                     "AUCUN" de la liste des m$$HEX1$$e900$$ENDHEX$$dias 
//*-----------------------------------------------------------------

Long lRet, lCpt, lPos
String sVal[]
String sText, sOperande, sTextFrancais, sOperandeFrancais, sValFrancais
String sValDate, sValDateTime1, sValDateTime2, sValTime

lRet = 1

/*------------------------------------------------------------------*/
/* Initialisation de isClause $$HEX2$$e0002000$$ENDHEX$$Vide                                */
/*------------------------------------------------------------------*/

isClause = ""
isClauseFrancais = ""

/*------------------------------------------------------------------*/
/* Le 19/08/1997                                                    */
/* Initialisation des valeurs types de recherche en fonction du     */
/* moteur de base de donn$$HEX1$$e900$$ENDHEX$$es.                                       */
/*------------------------------------------------------------------*/

Choose Case isMoteur
Case	"GUP"
	sValDate			= "mm-dd-yyyy"
	sValDateTime1	= " 00:00:00:000000"
	sValDateTime2	= " 23:59:59:999999"
	sValTime			= "hh:mm:ssss"

Case	"MSS"
	sValDate			= "dd/mm/yyyy"
	sValDateTime1	= " 00:00:00.00"
	sValDateTime2	= " 23:59:59.99"
	sValTime			= "hh:mm:ss.ff"

End Choose



For	lCpt = 1 To ilNbrCol
		Choose Case istInterro.sData[ lCpt ].sType
		Case "STRING"
			sVal[ lCpt ] = dw_1.GetItemString ( 1, istInterro.sData[ lCpt ].sNom )
			
			/*---------------------------------------------------------------------------------*/
			/* Le 07/06/2006 MADM : Projet DNTMAIL1										              */
			/* Ne pas tenir compte du crit$$HEX1$$e900$$ENDHEX$$re AUCUN lors de l'ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interro*/ 
			/*---------------------------------------------------------------------------------*/
			if sVal[ lCpt ] = "AUCUN" THEN
				sVal[ lCpt ] = ""
			END IF
			//Fin MADM
			
			If	IsNull ( sVal[ lCpt ] ) Or sVal[ lCpt ] = "" Or sVal[ lCpt ] = "01/01/1900" Or sVal[ lCpt ] = "NULL" Or sVal[ lCpt ] = "NOT NULL" Then 
				Continue
			Else
				sVal[ lCpt ] = "'" + sVal[ lCpt ] + "'"
			End If

		Case "DATE"
			sVal[ lCpt ] = String ( dw_1.GetItemDate ( 1, istInterro.sData[ lCpt ].sNom ), sValDate )
/*------------------------------------------------------------------*/
/* Le 07/10/1998                                                    */
/* Modification sur les champs DATE. (Demande de PLJ) Utilisation   */
/* avec SQL Server. Pour un select sur un champ DATE, il faut       */
/* mettre des quotes. Pour le moment on ne fait rien avec SQLBase.  */
/*------------------------------------------------------------------*/
			If	isMoteur = "MSS" And sVal[lCpt ] <> "" Then
				sVal[ lCpt ] = "'" + sVal[ lCpt ] + "'"
			End If		

		Case "DATETIME"

/*------------------------------------------------------------------*/
/* Le 19/08/1997                                                    */
/* Ajout des c$$HEX1$$f400$$ENDHEX$$tes pour que la recherche puisse marcher avec SQL    */
/* Server, cela doit marcher avec SQLBase.                          */
/*------------------------------------------------------------------*/

			sVal[ lCpt ] = String ( dw_1.GetItemDateTime ( 1, istInterro.sData[ lCpt ].sNom ), sValDate )
			If	IsNull ( sVal[ lCpt ] ) Or sVal[ lCpt ] = "" Or sVal[ lCpt ] = "01/01/1900" Then
				Continue
			Else
				Choose Case istInterro.sData[ lCpt ].sOperande 
				Case ">=", ">"
					sVal[ lCpt ] = "'" + sVal[ lCpt ] + sValDateTime1 + "'"

				Case "<=", "<"
					sVal[ lCpt ] = "'" + sVal[ lCpt ] + sValDateTime2 + "'" 
				End Choose
			End If

		Case "TIME"
			sVal[ lCpt ] = String ( dw_1.GetItemTime ( 1, istInterro.sData[ lCpt ].sNom ), sValTime )

		Case "NUMBER"
/*------------------------------------------------------------------*/
/* Le 18/08/1997                                                    */
/* Modification pour la prise en compte des valeurs de cl$$HEX2$$e9002000$$ENDHEX$$en       */
/* num$$HEX1$$e900$$ENDHEX$$rique.                                                       */
/* Dans la structure d'interro, on laisse le type en number.        */
/* Dans la DW d'interro, on met le type en CHAR, pour pouvoir       */
/* saisir "*".                                                      */
/* Dans la structure d'interro, on renseigne la zone sMoteur avec   */
/* "MSS".                                                           */
/* Dans ce cas pr$$HEX1$$e900$$ENDHEX$$cis, on effectuera un convert.                    */
/*------------------------------------------------------------------*/

			If	istInterro.sData[ lCpt ].sMoteur = "MSS" Then
				sVal[ lCpt ] = dw_1.GetItemString ( 1, istInterro.sData[ lCpt ].sNom )
				If	Not IsNumber ( sVal[ lCpt ] ) Then
					sVal[ lCpt ] = "'" + sVal[ lCpt ] + "'"
				End If
			Else
				sVal[ lCpt ] = String ( dw_1.GetItemNumber ( 1, istInterro.sData[ lCpt ].sNom ) )
			End If

		End Choose

Next

For	lCpt = 1 To ilNbrCol

		If	IsNull ( sVal[ lCpt ] ) Or sVal[ lCpt ] = "" Or sVal[ lCpt ] = "01/01/1900" Then
			Continue
		Else
	
			sValFrancais		= ""
			sOperande			= istInterro.sData[ lCpt ].sOperande
			sOperandeFrancais	= istInterro.sData[ lCpt ].sOperande

/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$termination si la cha$$HEX1$$ee00$$ENDHEX$$ne contient "*"                          */
/*------------------------------------------------------------------*/

			lPos = Pos ( sVal[ lCpt ], "*" )
			sValFrancais = sVal[ lCpt ]

			If	lPos > 0 Then
				sVal[ lCpt ] = Left ( sVal[ lCpt ], ( lPos - 1 ) ) + "%'"

				If	sOperande = "<>" Then
					sOperande = "Not like"
					sOperandeFrancais = "ne commence pas par"
				Else
					sOperande = "like"
					sOperandeFrancais = "commence par"
				End If
			
			Else

/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$termination si la cha$$HEX1$$ee00$$ENDHEX$$ne contient "NULL" ou "NOT NULL"         */
/*------------------------------------------------------------------*/

				If	sVal[ lCpt ] = "NULL" Or sVal[ lCpt ] = "NOT NULL" Then
					sOperande = "is"
					sOperandeFrancais = "est"
				End If

			End If

			If	istInterro.sData[ lCpt ].sMoteur = "MSS" And Not IsNumber ( sVal[ lCpt ] ) Then
				sText = "CONVERT ( VARCHAR( 35 ), " + istInterro.sData[ lCpt ].sDbName + " )"
			Else
				sText = istInterro.sData[ lCpt ].sDbName
			End If

			sText =	sText 									+ " "			+ &
						sOperande 								+ " " 		+ &
						sVal[ lCpt ]
		
			sTextFrancais	= istInterro.sData[ lCpt ].sDbName	+ " " 	+ &
								  sOperandeFrancais						+ " " 	+ &
								  sValFrancais

			If	isClause = "" Then
				isClause 			=	sText
				isClauseFrancais	= sTextFrancais
			Else
				isClause 			= isClause + " AND " + sText
				isClauseFrancais	= isClauseFrancais + " et " + sTextFrancais
			End If
			
		End If
Next

/*------------------------------------------------------------------*/
/* Positionnement du WHERE                                          */
/*------------------------------------------------------------------*/

If	isClause <> "" Then
	isClause = " WHERE " + isClause
End If

Return ( lRet )

end function

protected subroutine wf_posfenetre ();//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_PosFenetre (Protected)
//* Auteur			: Erick John Stark
//* Date				: 22/02/1996 15:41:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Dimension de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long ldw_H, lX, lY

String sdw_H, sSection

sdw_H = dw_1.Describe ( "DataWindow.Detail.Height" )

ldw_H = Long ( sdw_H )

/*------------------------------------------------------------------*/
/* On retaille la Data Window, on positionne le bandeau et on       */
/* termine par le retaillage de la fen$$HEX1$$ea00$$ENDHEX$$tre d'interro.               */
/*------------------------------------------------------------------*/

dw_1.Resize ( dw_1.Width, ldw_H + 10 )
uo_1.Move ( uo_1.X, ldw_H + 50 )
This.Resize ( This.Width, ldw_H + 400 )

/*------------------------------------------------------------------*/
/* On repostionne la fen$$HEX1$$ea00$$ENDHEX$$tre aux derni$$HEX1$$e800$$ENDHEX$$res coordonn$$HEX1$$e900$$ENDHEX$$es connues.     */
/*------------------------------------------------------------------*/

sSection = stGLB.sCodAppli + " " + istInterro.sCodeDw

lX = ProfileInt ( isFicConfig, sSection, "X", 0 )
lY = ProfileInt ( isFicConfig, sSection, "Y", 0 )

If	lX <> 0 Then
	This.Move ( lX, lY )
End If


end subroutine

event open;call super::open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_interro::Open
//* Evenement 		: Open
//* Auteur			: Erick John Stark
//* Date				: 20/02/1996 11:06:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ouverture de la Fen$$HEX1$$ea00$$ENDHEX$$tre d'interrogation
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//* DGA        19/08/1997	Gestion du type de moteur concern$$HEX2$$e9002000$$ENDHEX$$par l'interrogation
//*
// #1 [DCMP-060643]-29/09/2006-PHG Gestion repertoire temporaire
//*-----------------------------------------------------------------

istInterro				= Message.PowerObjectParm

If	istInterro.sDataObject = "" Or IsNull ( istInterro.sDataObject ) Then
// Fermer la fen$$HEX1$$ea00$$ENDHEX$$tre si le DataObject est vide
	Uo_1.TriggerEvent ( "UE_RETOUR" )
	
Else
// D$$HEX1$$e900$$ENDHEX$$but Initialisation 
	iwParent					= istInterro.wAncetre
	This.Title				= istInterro.sTitre
	dw_1.uf_DataObject ( istInterro.sDataObject )
// #1 [DCMP-060643]-19/09/2006-PHG Gestion repertoire temporaire
//	isFicConfig				= ProfileString ( stGlb.sWinDir + "\MAJPOST.INI", "PARAM", "DESTINATION", "C:" ) + "\INTERRO.INI"
	isFicConfig				= stGlb.sRepTempo + "INTERRO.INI"

/*------------------------------------------------------------------*/
/* Le 19/08/1997                                                    */
/* On initialise ici le type de moteur. Pour ce faire on prend en   */
/* compte la valeur istPass.itrTrans de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil        */
/* appelante.                                                       */
/* Il est bon de pr$$HEX1$$e900$$ENDHEX$$ciser qu'il existe une instance sur l'accueil   */
/* (itTrans), mais celle-ci ne semble pas souvent initialis$$HEX1$$e900$$ENDHEX$$e.!!!   */
/* La variable isMoteur sera utilis$$HEX1$$e900$$ENDHEX$$e dans la fonction              */
/* Wf_ConstruireChaine pour les types de donn$$HEX1$$e900$$ENDHEX$$es DATE, DATETIME,    */
/* TIME. isMoteur peut-$$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$MSS ou GUP.                      */
/*------------------------------------------------------------------*/

	isMoteur 				= Left ( Upper ( istInterro.wAncetre.istPass.trTrans.DBMS ), 3 )	
	// [MIGPB11] [EMD] : Debut Migration : modif de la variable isMoteur, si SNC on y met MSS
	// If isMoteur = "SNC" Then
	If isMoteur <> "GUP" Then // [PI056] MSS moteur par d$$HEX1$$e900$$ENDHEX$$faut
		isMoteur = "MSS"	
	End If
	// [MIGPB11] [EMD] : Fin Migration

	ilNbrCol 				= UpperBound ( istInterro.sData )

// Positionnement de la Fen$$HEX1$$ea00$$ENDHEX$$tre ( En fonction des dimensions de la DW )
	Wf_PosFenetre ()

	dw_1.InsertRow ( 0 )
	dw_1.SetFocus ()

// D$$HEX1$$e900$$ENDHEX$$clenchement des Scripts Clients $$HEX1$$e900$$ENDHEX$$ventuels
	iwParent.TriggerEvent ( "UE_PREPARER_INTERRO" )
	
End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_interro.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.dw_1
end on

on w_interro.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.dw_1)
end on

type cb_debug from w_ancetre`cb_debug within w_interro
end type

type uo_1 from u_bd_interro within w_interro
integer x = 512
integer y = 1360
integer width = 896
integer height = 192
integer taborder = 20
boolean border = false
long backcolor = 12632256
end type

on uo_1.destroy
call u_bd_interro::destroy
end on

type dw_1 from u_datawindow within w_interro
integer x = 18
integer y = 16
integer width = 1883
integer height = 1296
integer taborder = 10
boolean border = false
end type

