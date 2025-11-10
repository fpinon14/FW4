HA$PBExportHeader$w_t_spb_departement.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des d$$HEX1$$e900$$ENDHEX$$partements
forward
global type w_t_spb_departement from w_8_traitement
end type
end forward

global type w_t_spb_departement from w_8_traitement
integer x = 507
integer width = 2633
integer height = 680
string title = "Gestion des d$$HEX1$$e900$$ENDHEX$$partements"
event ue_droitecriture pbm_custom39
end type
global w_t_spb_departement w_t_spb_departement

type variables
u_spb_gs_departement	iuoGsDepartement
end variables

forward prototypes
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_preparervalider ()
public function boolean wf_preparersupprimer ()
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
public function boolean wf_terminersupprimer ()
public function boolean wf_terminervalider ()
end prototypes

on ue_droitecriture;call w_8_traitement::ue_droitecriture;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_spb_departement
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
//* Date				:	30/05/97 11:29:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Controle de saisie des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					 	DEPARTEMENT.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String	"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

String 		sCol[3]				// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sErr[3]				// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String 		sNouvelleLigne		// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText					// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos					// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.
String		sVal					// Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification.
Long 			lCpt					// Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrCol				// Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.


sNouvelleLigne		= "~r~n"
lNbrCol				= UpperBound ( sCol )
sPos					= ""
sText					= sNouvelleLigne

sCol[ 1 ]			= "ID_DEPT"
sCol[ 2 ]			= "LIB_DEPT"
sCol[ 3 ]			= "NOM_RSP"

sErr[ 1 ]			= " - Le code du d$$HEX1$$e900$$ENDHEX$$partement"
sErr[ 2 ]			= " - Le libell$$HEX2$$e9002000$$ENDHEX$$du d$$HEX1$$e900$$ENDHEX$$partement"
sErr[ 3 ]			= " - Le nom du responsable"

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lNbrCol

	If lCpt = 1	Then

		sVal = String ( Dw_1.GetItemNumber ( 1, sCol[ lCpt ] ) )

	Else

		sVal = Dw_1.GetItemString ( 1, sCol[ lCpt ] )

	End If

	If IsNull ( sVal ) or Trim ( sVal ) = ""	Then

		If sPos = "" Then sPos = sCol[ lCpt ]
		sText = sText + sErr[ lCpt ] + sNouvelleLigne

	End If

Next


/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur         */
/*------------------------------------------------------------------*/
If	sPos <> "" Then

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des DEPARTEMENTS"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If

Return ( sPos )
end function

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_controlergestion
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	30/05/97 11:43:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Controle de gestion de la saisie.
//* Commentaires	:	
//*
//* Arguments		:	Aucun.
//*
//* Retourne		:	String	"" -> Ok
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

String 	sCol 			// Nom de la colonne en Erreur.

Long		dcIdDept		// Identifiant du d$$HEX1$$e900$$ENDHEX$$partement.

Scol = ""

If ( istPass.bInsert = True )  Then

	dcIdDept = Dw_1.GetItemNumber ( 1, "ID_DEPT" )

	If ( iuoGsDepartement.uf_gs_Id_Dept ( dcIdDept ) = False ) Then

		sCol = "ID_DEPT"

	End If

End If

Return ( sCol )
end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparervalider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	30/05/97 11:42:46
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
/* l'insertion d'un nouveau d$$HEX1$$e900$$ENDHEX$$partement.                            */
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
//* Date				:	30/05/97 11:35:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Demande de confirmation avant suppression.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai -->	La suppression peut continuer
//*
//*-----------------------------------------------------------------

Boolean 	bRet 			// Variable de retour de la fonction.

Long		dcIdDept		// Identifiant du d$$HEX1$$e900$$ENDHEX$$partement $$HEX2$$e0002000$$ENDHEX$$supprimer.

Integer	iRet			// Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur.

bRet = True

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/
stMessage.sTitre 		= "Suppression d'un D$$HEX1$$e900$$ENDHEX$$partement"
stMessage.sVar[ 1 ] 	= "ce d$$HEX1$$e900$$ENDHEX$$partement"
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
	/* Produits                                                         */
	/*------------------------------------------------------------------*/
	dcIdDept = Dw_1.GetItemNumber ( 1, "ID_DEPT" )
	bRet 		= iuoGsDepartement.uf_gs_sup_dept ( dcIdDept )

	If ( bRet = False ) Then

		stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression du D$$HEX1$$e900$$ENDHEX$$partement"
		stMessage.sVar[ 1 ] 	= "des produits"  
		stMessage.sVar[ 2 ] 	= "ce d$$HEX1$$e900$$ENDHEX$$partement"
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "REFU002"
		f_Message ( stMessage )

	Else

		/*------------------------------------------------------------------*/
		/* Suppression si aucun probl$$HEX1$$e800$$ENDHEX$$me d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX25$$e900200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
		/*------------------------------------------------------------------*/

		dw_1.DeleteRow ( 0 )

	End If

End If

Return ( bRet )
end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparerinserer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	30/05/97 11:32:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations avant insertion
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer.
//*
//*-----------------------------------------------------------------
String	sCol [ 1 ]	// Liste des champs $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger.

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


sCol[ 1 ] 		= "ID_DEPT"

Dw_1.Uf_Proteger ( sCol, "0" )

Dw_1.ilPremCol = 1
Dw_1.ilDernCol = 3
Dw_1.SetColumn ( Dw_1.ilPremCol ) 

Return ( True )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparermodifier
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	30/05/97 11:34:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant modification.
//* Commentaires	:	
//*
//* Arguments		:	Aucun.
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La Modification peut continuer.
//*
//*-----------------------------------------------------------------

Boolean 	bRet 				// Valeur de Retour.
String  	sCol [ 1 ]		// Liste des champs $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger.

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


bRet = True

sCol [ 1 ] 		= "ID_DEPT"

Dw_1.ilPremCol = 2
Dw_1.ilDernCol = 3

Dw_1.Uf_Proteger ( sCol, "1" )

If Dw_1.Retrieve ( Dec ( istPass.sTab [ 1 ] ) ) <= 0 Then bRet = False

Return ( bRet )
end function

public function boolean wf_terminersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_terminerSupprimer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	06/06/97 11:33:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	termine la suppression
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

public function boolean wf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_terminervalider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	06/06/97 11:28:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	termine la validation.
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

on ue_majaccueil;call w_8_traitement::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_departement
//* Evenement 		:	UE_MAJACCUEIL - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	30/05/97 11:21:44
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 	sTab			// Code tabulation.
String	sMajLe		// Variable tampon pour MAJ_LE.
String	sIdDept		// Variable tampon pour Id_DEPT.

sTab		= "~t"
sMajLe	= String ( dw_1.GetItemDateTime 	( 1, "MAJ_LE" 	), "dd/mm/yyyy hh:mm:ss" 	)
sIdDept	= String ( dw_1.GetItemNumber 	( 1, "ID_DEPT" ) 									)

isMajAccueil 	=	sIdDept										 		+ sTab	+ &
 						dw_1.GetItemString ( 1, "LIB_DEPT" ) 		+ sTab	+ &
						sMajLe								 				+ sTab	+ &
						dw_1.GetItemString ( 1, "MAJ_PAR" )
end on

on ue_initialiser;call w_8_traitement::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_departement
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	30/05/97 11:20:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					 	D$$HEX1$$e900$$ENDHEX$$partements.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sCol [ 1 ]	// Tableau contenant les champs dont l'attribut 'protect'
							// peut $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$.


iuoGsDepartement = Create u_spb_gs_Departement


Dw_1.Uf_SetTransObject ( itrTrans )

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/
sCol [ 1 ] = "ID_DEPT"

Dw_1.Uf_InitialiserCouleur ( sCol )

iuoGsDepartement.uf_initialisation ( itrTrans, Dw_1 )
end on

on close;call w_8_traitement::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_departement
//* Evenement 		:	Close
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	30/05/97 11:19:47
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
/* param$$HEX1$$e900$$ENDHEX$$trage des d$$HEX1$$e900$$ENDHEX$$partements                                     */
/*------------------------------------------------------------------*/
Destroy iuoGsDepartement
end on

on w_t_spb_departement.create
call super::create
end on

on w_t_spb_departement.destroy
call super::destroy
end on

type cb_debug from w_8_traitement`cb_debug within w_t_spb_departement
end type

type dw_1 from w_8_traitement`dw_1 within w_t_spb_departement
integer x = 18
integer y = 192
integer width = 2587
integer height = 396
string dataobject = "d_spb_departement"
boolean border = false
end type

on dw_1::itemerror;call w_8_traitement`dw_1::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	ItemError
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	30/05/97 11:27:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages d'erreur suite aux erreurs 
//*					 	de saisies.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre		= "Param$$HEX1$$e900$$ENDHEX$$trage des D$$HEX1$$e900$$ENDHEX$$partements"
	stMessage.Icon			= Information!

	stMessage.bErreurG	= TRUE

	Choose Case isErrCol

		Case "ID_DEPT"
			stMessage.sVar[1] = "code du d$$HEX1$$e900$$ENDHEX$$partement"
			stMessage.sCode	= "GENE003"

		Case "LIB_DEPT"
			stMessage.sVar[1] = "libell$$HEX2$$e9002000$$ENDHEX$$du d$$HEX1$$e900$$ENDHEX$$partement "
			stMessage.sCode	= "GENE003"

		Case "NOM_RSP"
			stMessage.sVar[1] = "nom du responsable"
			stMessage.sCode	= "GENE003"

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

end on

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	30/05/97 11:22:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification du SqlPreview de la datawindow Dw_1
//*					 	dans le cas de l'insertion d'un nouveau d$$HEX1$$e900$$ENDHEX$$partement.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sSqlPreview			// SqlPreview de la datawindow Dw_1.
String	sLibDept				// Libell$$HEX2$$e9002000$$ENDHEX$$du d$$HEX1$$e900$$ENDHEX$$partement.
String	sNomRsp				// Nom du responsable.
String	sMajPar				// Auteur de la derni$$HEX1$$e800$$ENDHEX$$re mise $$HEX2$$e0002000$$ENDHEX$$jour.
String	sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sType					// Type d'action effectuer sur la table.
String	sCle [ 1 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
//Migration PB8-WYNIWYG-03/2006 FM
//String	sCol [ 6 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String	sVal [ 6 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sCol []			// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal []			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 FM

Long		dcIdDept				// Identifiant du d$$HEX1$$e900$$ENDHEX$$partement.

DateTime	dtCreeLe				
DateTime	dtMajLe
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//sSqlPreview = Dw_1.GetSQLPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable = "DEPARTEMENT"

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/
Choose Case Left ( sSqlPreview, 4 )

	Case	"INSE"

		dcIdDept = Dw_1.GetItemNumber   ( 1, "ID_DEPT"  )
		sLibDept = Dw_1.GetItemString   ( 1, "LIB_DEPT" )
		sNomRsp  = Dw_1.GetItemString   ( 1, "NOM_RSP"  )
		dtCreele = Dw_1.GetItemDateTime ( 1, "CREE_LE"  )
		dtMajLe  = Dw_1.GetItemDateTime ( 1, "MAJ_LE"   )
		sMajPar  = Dw_1.GetItemString   ( 1, "MAJ_PAR"  )

		itrTrans.DW_I01_DEPARTEMENT ( dcIdDept, &
											 sLibDept, &
											 sNomRsp,  &
											 dtCreeLe, &
											 dtMajLe,  &
											 sMajPar )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCol = { "ID_DEPT" , "LIB_DEPT" , "NOM_RSP" }

			sVal [ 1 ] = "'" + String ( dcIdDept ) + "'"
			sVal [ 2 ] = "'" + sLibDept + "'"
			sVal [ 3 ] = "'" + sNomRsp + "'"

			sCle [ 1 ]	= sVal [ 1 ]

			sType = 'I'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

	Case	"UPDA" 

		uoGsTrace.uf_PreparerTrace ( sSqlPreview, sCol, sVal )

		sCle [ 1 ]	= "'" + String ( Dw_1.GetItemNumber ( 1, "ID_DEPT" ) ) + "'"
		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			Dw_1.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		End If



	Case	"DELE"

		dcIdDept = Dw_1.GetItemNumber ( 1, "ID_DEPT", DELETE!, FALSE )

		itrTrans.DW_D01_DEPARTEMENT ( dcIdDept )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 FM
//			This.SetActionCode ( 1 )
			ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
		Else

			sCle [ 1 ] = "'" + String ( dcIdDept ) + "'"
			sType = 'D'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 1 )
				ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
			Else
//Migration PB8-WYNIWYG-03/2006 FM
//				This.SetActionCode ( 2 )
				ll_ret = 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
			End If

		End If

End Choose

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on dw_1::dberror;call w_8_traitement`dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet			:	w_8_traitement::dw_1
//* Evenement 		:	dberror
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	05/06/97 18:30:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	En cas d'erreur base, on rollbacke la trace.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

UoGsTrace.Uf_CommitTrace ( False )
end on

type st_titre from w_8_traitement`st_titre within w_t_spb_departement
boolean visible = false
end type

type pb_retour from w_8_traitement`pb_retour within w_t_spb_departement
integer y = 20
end type

type pb_valider from w_8_traitement`pb_valider within w_t_spb_departement
integer x = 283
integer y = 20
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_spb_departement
boolean visible = false
end type

type pb_controler from w_8_traitement`pb_controler within w_t_spb_departement
boolean visible = false
integer y = 20
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_spb_departement
integer x = 530
integer y = 20
end type

