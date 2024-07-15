HA$PBExportHeader$w_t_spb_compagnie.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des compagnies
forward
global type w_t_spb_compagnie from w_8_traitement
end type
end forward

global type w_t_spb_compagnie from w_8_traitement
integer x = 571
integer width = 2505
integer height = 576
string title = "Gestion des compagnies"
event ue_droitecriture pbm_custom39
end type
global w_t_spb_compagnie w_t_spb_compagnie

type prototypes
Function ULONG GetVersion ( ) LIBRARY "KERNEL.EXE"
end prototypes

type variables
u_spb_gs_compagnie		iuoGsCompagnie
end variables

forward prototypes
public function string wf_controlersaisie ()
public function boolean wf_preparervalider ()
public function boolean wf_preparersupprimer ()
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
public function boolean wf_terminervalider ()
public function boolean wf_terminersupprimer ()
public function string wf_controlergestion ()
end prototypes

on ue_droitecriture;call w_8_traitement::ue_droitecriture;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_spb_compagnie
//* Evenement     : ue_DroitEcriture
//* Auteur        : Fabry JF
//* Date          : 16/09/2003 14:17:32
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: DCMP 030399 OMG/SO
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

PictureButton TbPict []

TbPict[1] = pb_valider
TbPict[2] = pb_supprimer

F_Droit_Ecriture_Param ( tbPict, "" )


end on

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_controlersaisie
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 16:42:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	Contr$$HEX1$$f400$$ENDHEX$$le de saisie des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					 	COMPAGNIE.
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String	"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

String 		sCol [ 2 ]			// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sErr [ 2 ]			// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier .
String 		sNouvelleLigne		// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText					// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos					// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.
String		sVal					// Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification.
Long 			lCpt					// Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrCol				// Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.

sNouvelleLigne	= "~r~n"
lNbrCol			= UpperBound ( sCol )
sPos				= ""
sText				= sNouvelleLigne

sCol [ 1 ]		= "ID_CIE"
sCol [ 2 ]		= "LIB_CIE"

sErr [ 1 ]		= " - Le code de la compagnie"
sErr [ 2 ]		= " - Le libell$$HEX2$$e9002000$$ENDHEX$$de la compagnie"

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lNbrCol

	If lCpt = 1 Then
		sVal = String ( Dw_1.GetItemNumber ( 1, sCol[ lCpt ] ) )
	
	Else
		sVal = Dw_1.GetItemString ( 1, sCol[ lCpt ] )

	End If

	If ( IsNull ( sVal ) or Trim ( sVal ) = "" )	Then

		If ( sPos = "" ) 	Then 	sPos = sCol[ lCpt ]
		sText = sText + sErr[ lCpt ] + sNouvelleLigne

	End If

Next

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/

If	( sPos <> "" ) Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Compagnies"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.bErreurG	=	TRUE
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If

Return ( sPos )
end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparervalider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 17:19:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
//*
//* Arguments		:	Aucun.
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	-->	Vraie : La validation peut 
//*													  continuer
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Initialisation des informations de cr$$HEX1$$e900$$ENDHEX$$ation dans le cas de       */
/* l'insertion d'une nouvelle compagnie.                            */
/*------------------------------------------------------------------*/
If ( istPass.bInsert = True ) Then

	f_Creele ( Dw_1, 1 )

End If

f_MajPar ( Dw_1, 1 )

Return ( True )
end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparersupprimer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 17:17:53
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Demande de confirmation avant suppression.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai -->	La suppression peut continuer
//*
//*-----------------------------------------------------------------

Boolean 	bRet 			// Variable de retour de la fonction.

Long	 	dcIdCie		// Identifiant de la compagnie $$HEX2$$e0002000$$ENDHEX$$supprimer.

Integer	iRet			// Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur.

bRet = True
/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/

stMessage.sTitre 		= "Suppression d'une Compagnie"
stMessage.sVar[ 1 ] 	= "cette compagnie"
stMessage.Bouton		= YesNo!
stMessage.Icon			= Exclamation!
stMessage.bErreurG	= TRUE
stMessage.sCode		= "CONF001"

iRet						= f_Message ( stMessage )


/*------------------------------------------------------------------*/
/* Traitement suivant confirmation ou non de l'op$$HEX1$$e900$$ENDHEX$$rateur            */
/*------------------------------------------------------------------*/

If iRet = 2 Then 	

	bRet = False

Else

	/*------------------------------------------------------------------*/
	/* V$$HEX1$$e900$$ENDHEX$$rification de l'int$$HEX1$$e900$$ENDHEX$$grit$$HEX2$$e9002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rencielle vis $$HEX2$$e0002000$$ENDHEX$$vis de la table  */
	/* Polices                                                          */
	/*------------------------------------------------------------------*/

	dcIdCie 	= Dw_1.GetItemNumber ( 1, "ID_CIE" )
	bRet 		= iuoGsCompagnie.uf_Gs_Sup_Cie ( dcIdCie )

	If ( Not bRet ) Then

		stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression d'une Compagnie"
		stMessage.sVar[ 1 ] 	= "des polices"  
		stMessage.sVar[ 2 ] 	= "cette compagnie"
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "REFU002"
		f_Message ( stMessage )

	Else

		/*------------------------------------------------------------------*/
		/* Suppression si aucun probl$$HEX1$$e800$$ENDHEX$$me d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX25$$e900200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
		/*------------------------------------------------------------------*/

		Dw_1.DeleteRow ( 0 )

	End If

End If

Return ( bRet )
end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparerinserer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 16:57:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations avant insertion.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer.
//*
//*-----------------------------------------------------------------

Dw_1.ilPremCol = 1
Dw_1.ilDernCol = 2

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")

Dw_1.Uf_Proteger ( { "ID_CIE" } , '0' )

Dw_1.SetColumn ( Dw_1.ilPremCol ) 

Return ( True )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparermodifier
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 16:59:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant modification.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer.
//*
//*
//*-----------------------------------------------------------------

Boolean 	bRet				// Valeur de Retour.

bRet			= True

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")

Dw_1.Uf_Proteger ( { "ID_CIE" } , '1' )

Dw_1.ilPremCol = 2
Dw_1.ilDernCol = 2

If Dw_1.Retrieve ( Dec ( istPass.sTab [ 1 ] ) ) <= 0 Then bRet = False

Return ( bRet ) 
end function

public function boolean wf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_terminervalider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 17:21:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Termine la validation.
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: boolean		TRUE 	si OK, la validation peut continuer.
//*										FALSE sinon.
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Tout est OK, on peut commiter la trace.                          */
/*------------------------------------------------------------------*/
UoGsTrace.Uf_CommitTrace ( TRUE )

Return ( TRUE )
end function

public function boolean wf_terminersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_terminerSupprimer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 17:21:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Termine la suppression.
//* Commentaires	: 
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	boolean		TRUE 	si OK, la validation peut continuer.
//*										FALSE sinon.
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Tout est OK, on peut commiter la trace.                          */
/*------------------------------------------------------------------*/
UoGsTrace.Uf_CommitTrace ( True )

Return ( True )
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_controlergestion
//* Auteur			:	YP
//* Date				:	01/10/97 10:37:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Controle de gestion de la saisie.
//* Commentaires	:	
//*
//* Arguments		:	Aucun.
//*
//* Retourne		:	String	"" -> Ok
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------
//* MAJ	PAR	Le				Description
//* #1	PHG	30/05/2008	[DCMP070914]Affichage d'info si cie 
//*								susceptible d'$$HEX1$$ea00$$ENDHEX$$tre au protocole AIG
//*-----------------------------------------------------------------
String 	sCol 			// Nom de la colonne en Erreur.

Long		dcIdCie		// Identifiant de la compagnie.
string	sLibCie		// #1 [DCMP070914] Libelle Compagnie

sCol = ""

dcIdCie = Dw_1.GetItemNumber ( 1, "ID_CIE" ) // #1 [DCMP070914] lecture des
sLibCie = Dw_1.GetItemString ( 1, "LIB_CIE" )// info Cie, valble qque soit
															// le mode.

If ( istPass.bInsert = True )  Then

	If ( iuoGsCompagnie.uf_gs_Id_Cie ( dcIdCie ) = False ) Then

		Dw_1.SetItem ( 1 , "ID_CIE" , stNul.dcm )
		sCol = "ID_CIE"

	End If

End If

// #1 [DCMP070914] Affichage du message d'info si besoin.
iuoGsCompagnie.uf_controler_aig( dcIdCie, sLibCie)

Return ( sCol )
end function

on ue_initialiser;call w_8_traitement::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_compagnie
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 16:45:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					 	Compagnies.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuoGsCompagnie = Create u_spb_gs_compagnie
iuoGsCompagnie.uf_initialisation ( itrTrans, Dw_1 )

Dw_1.Uf_InitialiserCouleur ( { "ID_CIE" } )

Dw_1.Uf_SetTransObject ( itrTrans )
end on

on ue_majaccueil;call w_8_traitement::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_compagnie
//* Evenement 		:	UE_MAJACCUEIL - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 16:53:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 	sTab			// Code tabulation.
String	sMajLe		// Variable tampon pour MAJ_lE.
String	sIdCie		// Variable tampon pour ID_CIE.

sTab		= "~t"
sIdCie	= String ( dw_1.GetItemNumber   ( 1, "ID_CIE" ) )
sMajLe	= String ( dw_1.GetItemDateTime ( 1, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss" )

isMajAccueil 	=	sIdCie										+ sTab	+ &
 						dw_1.GetItemString ( 1, "LIB_CIE" ) + sTab	+ &
						sMajLe								 		+ sTab	+ &
						dw_1.GetItemString ( 1, "MAJ_PAR" )
end on

on close;call w_8_traitement::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_compagnie
//* Evenement 		:	Close
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 16:52:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre .
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction du User Object de contr$$HEX1$$f400$$ENDHEX$$le de gestion pour le        */
/* param$$HEX1$$e900$$ENDHEX$$trage des compagnies                                       */
/*------------------------------------------------------------------*/

Destroy iuoGsCompagnie
end on

on w_t_spb_compagnie.create
call super::create
end on

on w_t_spb_compagnie.destroy
call super::destroy
end on

type cb_debug from w_8_traitement`cb_debug within w_t_spb_compagnie
end type

type dw_1 from w_8_traitement`dw_1 within w_t_spb_compagnie
integer x = 9
integer y = 164
integer width = 2478
integer height = 328
string dataobject = "d_spb_compagnie"
boolean border = false
end type

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 17:30:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification du SqlPreview de la datawindow Dw_1
//*					   dans le cas de l'insertion d'une nouvelle compagnie.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String		sSqlPreview			// SqlPreview de la datawindow Dw_1.

String		sLibCie				// Libell$$HEX2$$e9002000$$ENDHEX$$de la compagnie.
String		sMajPar
String		sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sType					// Type d'action effectuer sur la table.
String		sCle [ 1 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.

//Migration PB8-WYNIWYG-03/2006 CP
//String		sCol [ 5 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String		sVal [ 5 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String		sCol [  ]			// Tableau des colonnes de la table : nom de ces colonnes.
String		sVal [  ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 CP

Long			dcIdCie				// Identifiant de la compagnie.

//Migration PB8-WYNIWYG-03/2006 CP
Long 			ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

DateTime		dtCreeLe				// Date de cr$$HEX1$$e900$$ENDHEX$$ation
DateTime		dtMajLe				// Date de mise $$HEX2$$e0002000$$ENDHEX$$jour

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview 		= Dw_1.GetSQLPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP


/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "COMPAGNIE"

Choose Case Left ( sSqlPreview, 4 )

	Case	"INSE" 

		dcIdCie	= Dw_1.GetItemNumber		( 1, "ID_CIE"	)
		sLibCie  = Dw_1.GetItemString		( 1, "LIB_CIE" )
		dtCreele = Dw_1.GetItemDateTime	( 1, "CREE_LE" )
		dtMajLe  = Dw_1.GetItemDateTime	( 1, "MAJ_LE"  )
		sMajPar  = Dw_1.GetItemString		( 1, "MAJ_PAR" )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure d'insertion.                                           */
		/*------------------------------------------------------------------*/
		itrTrans.DW_I01_COMPAGNIE ( dcIdCie  , &
										 	 sLibCie , &
											 dtCreeLe, &
										 	 dtMajLe , &
										 	 sMajPar )

		If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//			This.SetActionCode ( 1 )
			ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

		Else

			sCol = { "ID_CIE", "LIB_CIE" }

			sVal [ 1 ] = "'" + String ( dcIdCie )  + "'"
			sVal [ 2 ] = "'" + sLibCie + "'"

			sCle [ 1 ]	= sVal [ 1 ]

			sType = 'I'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 CP
//			This.SetActionCode ( 1 )
			ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

			Else
//Migration PB8-WYNIWYG-03/2006 CP
//			This.SetActionCode ( 2 )
			ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP

			End If

		End If
		
	Case	"UPDA" 

		uoGsTrace.uf_PreparerTrace ( sSqlPreview, sCol, sVal )

		sCle [ 1 ]	= "'" + String ( GetItemNumber ( 1, "ID_CIE" ) ) + "'"

		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 CP
//			This.SetActionCode ( 1 )
			ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

		End If

	Case	"DELE"

		dcIdCie = Dw_1.GetItemNumber ( 1, "ID_CIE", DELETE!, FALSE )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure de suppression.                                        */
		/*------------------------------------------------------------------*/
		itrTrans.DW_D01_COMPAGNIE ( dcIdCie )

		If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//			This.SetActionCode ( 1 )
			ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

		Else

			sCle [ 1 ] = "'" + String ( dcIdCie ) + "'"
			sType = 'D'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

//Migration PB8-WYNIWYG-03/2006 CP
//			This.SetActionCode ( 1 )
			ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP


			Else

//Migration PB8-WYNIWYG-03/2006 CP
//			This.SetActionCode ( 2 )
			ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP

			End If

		End If

End Choose

Return ll_return
end event

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	ItemError
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 17:29:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages d'erreur suite aux erreurs 
//*					 	de saisies.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Compagnies"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "LIB_CIE"

			stMessage.sVar[1] 	= "libell$$HEX2$$e9002000$$ENDHEX$$de la compagnie "
			stMessage.bErreurG 	= TRUE
			stMessage.sCode		= "GENE003"

		Case "ID_CIE"

			stMessage.sVar[1] 	= "code de la compagnie "
			stMessage.bErreurG 	= TRUE
			stMessage.sCode		= "GENE003"

	End Choose

	f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	Uf_Reinitialiser ()
	Return Uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on dw_1::dberror;call w_8_traitement`dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	dberror
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	09/06/97 17:23:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	En cas d'erreur base, on rollbacke la trace.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

UoGsTrace.Uf_CommitTrace ( False )

end on

type st_titre from w_8_traitement`st_titre within w_t_spb_compagnie
boolean visible = false
end type

type pb_retour from w_8_traitement`pb_retour within w_t_spb_compagnie
integer y = 16
end type

type pb_valider from w_8_traitement`pb_valider within w_t_spb_compagnie
integer x = 283
integer y = 16
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_spb_compagnie
boolean visible = false
integer x = 1637
integer y = 28
end type

type pb_controler from w_8_traitement`pb_controler within w_t_spb_compagnie
boolean visible = false
integer y = 16
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_spb_compagnie
integer x = 530
integer y = 16
end type

