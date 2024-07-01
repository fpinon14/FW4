HA$PBExportHeader$w_t_spb_police.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des polices
forward
global type w_t_spb_police from w_8_traitement
end type
end forward

global type w_t_spb_police from w_8_traitement
integer x = 754
integer y = 556
integer width = 2139
integer height = 712
string title = "Gestion des polices"
event ue_droitecriture pbm_custom39
end type
global w_t_spb_police w_t_spb_police

type variables
u_spb_gs_police		iuoGsPolice
end variables

forward prototypes
public function string wf_controlersaisie ()
public function boolean wf_preparervalider ()
public function boolean wf_preparersupprimer ()
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
public function boolean wf_terminervalider ()
public function boolean wf_terminersupprimer ()
end prototypes

on ue_droitecriture;call w_8_traitement::ue_droitecriture;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_spb_police
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
//* Date				:	10/06/97 14:32:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de saisie des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					 	POLICE.
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*					
//*
//*-----------------------------------------------------------------

String 		sCol [ 2 ]			// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sErr [ 2 ]			// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String 		sNouvelleLigne		// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText					// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos					// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.
String		sVal					// Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification.
Long 			lCpt					//Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrCol				//Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.

sNouvelleLigne	= "~r~n"
lNbrCol			= UpperBound ( sCol )
sPos				= ""
sText				= sNouvelleLigne

sCol [ 1 ]		= "ID_CIE"
sCol [ 2 ]		= "LIB_POLICE"

sErr [ 1 ]		= " - Le code de la compagnie"
sErr [ 2 ]		= " - Le libell$$HEX2$$e9002000$$ENDHEX$$de la police"

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lNbrCol

	If lCpt = 1 Then

		sVal = String ( Dw_1.GetITemNumber ( 1 , sCol[ lCpt ] ) )

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

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Polices"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If

Return ( sPos )
end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		: wf_PreparerValider
//* Auteur			: Moi
//* Date				: 12/02/1997 12:18:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Met $$HEX2$$e0002000$$ENDHEX$$jour les infos de cr$$HEX1$$e900$$ENDHEX$$ation et de modification.
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en 	-->	Vraie : La validation peut 
//*													  continuer
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Initialisation des informations de cr$$HEX1$$e900$$ENDHEX$$ation dans le cas de       */
/* l'insertion d'une nouvelle police.                               */
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
//* Date				:	10/06/97 14:37:36
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Demande de confirmation avant suppression.
//* Commentaires	: 
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai -->	La suppression peut continuer 
//*
//*-----------------------------------------------------------------

Boolean 	bRet 			// Variable de retour de la fonction.

Long 		dcIdPolice	// Identifiant de la police $$HEX2$$e0002000$$ENDHEX$$supprimer.

Integer	iRet			// Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur.

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/
stMessage.sTitre 		= "Suppression d'une Police"
stMessage.sVar[ 1 ] 	= "cette police"
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
	dcIdPolice 	= Dw_1.GetItemNumber ( 1, "ID_POLICE" )
	bRet 		   = iuoGsPolice.uf_Gs_Sup_Police ( dcIdPolice )

	If ( bRet = False ) Then

		stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression d'une Police"
		stMessage.sVar[ 1 ] 	= "des garanties"  
		stMessage.sVar[ 2 ] 	= "cette police"
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
//* Date				:	10/06/97 14:34:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations avant insertion.
//* Commentaires	: 
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer
//*					
//*
//*-----------------------------------------------------------------

Dw_1.ilPremCol = 2
Dw_1.ilDernCol = 3

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


Dw_1.SetColumn ( Dw_1.ilPremCol ) 

Return ( True )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparermodifier
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	10/06/97 14:36:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant modification.
//* Commentaires	: 
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La Modification peut continuer
//*					
//*
//*-----------------------------------------------------------------

Boolean 	bRet		// Valeur de Retour.

bRet = True

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


Dw_1.ilPremCol = 2
Dw_1.ilDernCol = 3

If Dw_1.Retrieve ( Dec ( istPass.sTab [ 1 ] ) ) <= 0 Then bRet = False

Return ( bRet ) 
end function

public function boolean wf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_terminervalider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	10/06/97 14:42:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Termine la validation.
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
UoGsTrace.Uf_CommitTrace ( TRUE )

Return ( TRUE )
end function

public function boolean wf_terminersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_terminersupprimer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	10/06/97 14:41:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Termine la suppression.
//* Commentaires	: 
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	boolean		TRUE 	si OK, la suppression peut continuer.
//*										FALSE sinon.
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Tout est OK, on peut commiter la trace.                          */
/*------------------------------------------------------------------*/
UoGsTrace.Uf_CommitTrace ( TRUE )

Return ( TRUE )
end function

on ue_majaccueil;call w_8_traitement::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_police
//* Evenement 		:	UE_MAJACCUEIL - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	10/06/97 14:28:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 				sTab			// Code tabulation.
String				sIdPolice	// Variable tampon pour ID_POLICE.
String				sMajLe		// Variable tampon pour MAJ_LE.
String				sLibCie		// Libell$$HEX2$$e9002000$$ENDHEX$$de la compagnie.
String				sIdCie		// Identifiant de la compagnie.

Long					lNumLigne	// Ligne correspondant $$HEX2$$e0002000$$ENDHEX$$la compagnie s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e.

DataWindowChild	dwcCie		// DDDW pour les compagnies.

sTab			= "~t"
sIdPolice	= String ( dw_1.GetItemNumber   ( 1, "ID_POLICE" ) )
sMajLe		= String ( dw_1.GetItemDateTime ( 1, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss" )

/*------------------------------------------------------------------*/
/* Recherche du libell$$HEX2$$e9002000$$ENDHEX$$de la compagnie dans la DDDW.                */
/*------------------------------------------------------------------*/
Dw_1.GetChild ( "ID_CIE", dwcCie )

sIdCie         = String ( dw_1.GetItemNumber   ( 1, "ID_CIE" ) )
lNumLigne	   = dwcCie.Find          ( "ID_CIE=" + sIdCie , 1, dwcCie.RowCount( ) )

sLibCie = ""
If lNumLigne > 0 Then &
	sLibCie        = dwcCie.GetItemString ( lNumLigne, "LIB_CIE" )

isMajAccueil 	=	sIdPolice											 			+ sTab	+ &
 						dw_1.GetItemString  ( 1, "LIB_POLICE" ) 			+ sTab	+ &
						sLibCie														+ sTab	+ &
						sMajLe								 						+ sTab	+ &
						dw_1.GetItemString  ( 1, "MAJ_PAR" )

end on

on ue_initialiser;call w_8_traitement::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_police
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	10/06/97 14:27:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					 	Polices.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

iuoGsPolice = Create u_spb_gs_Police

Dw_1.Uf_SetTransObject ( itrTrans )

iuoGsPolice.uf_initialisation ( itrTrans, Dw_1 )
end on

on close;call w_8_traitement::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_police
//* Evenement 		:	Close
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	10/06/97 14:27:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction du User Object de contr$$HEX1$$f400$$ENDHEX$$le de gestion pour le        */
/* param$$HEX1$$e900$$ENDHEX$$trage des polices                                          */
/*------------------------------------------------------------------*/

Destroy iuoGsPolice
end on

on w_t_spb_police.create
call super::create
end on

on w_t_spb_police.destroy
call super::destroy
end on

type dw_1 from w_8_traitement`dw_1 within w_t_spb_police
integer x = 9
integer y = 172
integer width = 2478
integer height = 464
string dataobject = "d_spb_police"
boolean border = false
end type

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	10/06/97 14:43:09
//* Date				:	12/02/1997 11:55:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages d'erreur suite aux erreurs 
//*					 	de saisies.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Polices"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "LIB_POLICE"

			stMessage.sVar[1] 	= "N$$HEX2$$b0002000$$ENDHEX$$de police"
			stMessage.bErreurG	= TRUE
			stMessage.sCode		= "GENE003"

	End Choose

	f_Message ( stMessage )

//Migration PB8-WYNIWYG-03/2006 FM
//	This.uf_Reinitialiser ()
	Return uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	10/06/97 14:44:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification du SqlPreview de la datawindow Dw_1
//*					 	dans le cas de l'insertion ou de la suppression 
//*					 	d'une police.	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sSqlPreview			// SqlPreview de la datawindow Dw_1.
String	sLibPolice			// Libell$$HEX2$$e9002000$$ENDHEX$$de la police.
String	sMajPar				// Auteur de la Mise $$HEX2$$e0002000$$ENDHEX$$jour.
String	sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sType					// Type d'action effectuer sur la table.
String	sCle [ 1 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.

//Migration PB8-WYNIWYG-03/2006 CP
//String	sCol [ 6 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String	sVal [ 6 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sCol [  ]			// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal [  ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 CP

Long		dcIdPolice			// Identifiant de la police.
Long		dcIdCie				// Identifiant de la compagnie.

Long 		ll_return

DateTime	dtCreeLe
DateTime	dtMajLe


//Migration PB8-WYNIWYG-03/2006 CP
// sSqlPreview 		= This.GetSQLPreview ()
	sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP


/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "POLICE"

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/

Choose Case Left ( sSqlPreview, 4 )

	Case	"INSE" 

		dcIdCie		= This.GetItemNumber   ( 1, "ID_CIE"     )
		sLibPolice  = This.GetItemString   ( 1, "LIB_POLICE" )
		dtCreele		= This.GetItemDateTime ( 1, "CREE_LE"    )
		dtMajLe		= This.GetItemDateTime ( 1, "MAJ_LE"     )
		sMajPar		= This.GetItemString   ( 1, "MAJ_PAR"    )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure d'insertion.                                           */
		/*------------------------------------------------------------------*/
		itrTrans.DW_I01_POLICE (  dcIdPolice , &
										  dcIdCie    , &
										  sLibPolice , &
									 	  dtCreeLe   , &
									 	  dtMajLe    , &
									 	  sMajPar )

		If itrTrans.SqlCode <> 0	Then


//Migration PB8-WYNIWYG-03/2006 CP
// 			This.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

		Else

			This.SetItem ( 1, "ID_POLICE", dcIdPolice )

		sCol = { "ID_POLICE" , "ID_CIE" , "LIB_POLICE" }

			sVal [ 1 ] = "'" + String ( dcIdPolice ) + "'"
			sVal [ 2 ] = "'" + String ( dcIdCie    ) + "'"
			sVal [ 3 ] = "'" + sLibPolice            + "'"

			sCle [ 1 ]	= sVal [ 1 ]

			sType = 'I'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then


//Migration PB8-WYNIWYG-03/2006 CP
// 				This.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

			Else


//Migration PB8-WYNIWYG-03/2006 CP
// 				This.SetActionCode ( 2 )
				ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP


			End If

		End If

	Case	"UPDA" 

 		uoGsTrace.uf_PreparerTrace ( sSqlPreview, sCol, sVal )

		sCle [ 1 ]	= "'" + String ( This.GetItemNumber ( 1, "ID_POLICE" ) ) + "'"

		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

//Migration PB8-WYNIWYG-03/2006 CP
//			Dw_1.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP


		End If

	Case	"DELE"

		dcIdPolice = This.GetItemNumber (  1, "ID_POLICE", DELETE!, False	)

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure de suppression.                                        */
		/*------------------------------------------------------------------*/
		itrTrans.DW_D01_POLICE ( dcIdPolice )

		If itrTrans.SqlCode <> 0	Then


//Migration PB8-WYNIWYG-03/2006 CP
// 			This.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

		Else

			sCle [ 1 ] = "'" + String ( dcIdPolice ) + "'"
			sType = 'D'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then


//Migration PB8-WYNIWYG-03/2006 CP
// 				This.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

			Else


//Migration PB8-WYNIWYG-03/2006 CP
// 				This.SetActionCode ( 2 )
				ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP

			End If

		End If

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
				Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

end event

on dw_1::dberror;call w_8_traitement`dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	dberror
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	10/06/97 14:43:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	En cas d'erreur base, on rollbacke la trace.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

UoGsTrace.Uf_CommitTrace ( False )
end on

type st_titre from w_8_traitement`st_titre within w_t_spb_police
boolean visible = false
end type

type pb_retour from w_8_traitement`pb_retour within w_t_spb_police
integer y = 16
end type

type pb_valider from w_8_traitement`pb_valider within w_t_spb_police
integer x = 283
integer y = 16
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_spb_police
boolean visible = false
end type

type pb_controler from w_8_traitement`pb_controler within w_t_spb_police
boolean visible = false
integer y = 16
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_spb_police
integer x = 530
integer y = 16
end type

