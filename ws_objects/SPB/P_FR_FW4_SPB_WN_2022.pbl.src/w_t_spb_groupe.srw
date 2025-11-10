HA$PBExportHeader$w_t_spb_groupe.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des groupes
forward
global type w_t_spb_groupe from w_8_traitement
end type
end forward

global type w_t_spb_groupe from w_8_traitement
integer x = 750
integer width = 2149
integer height = 808
string title = "Gestion des groupes"
event ue_droitecriture pbm_custom39
end type
global w_t_spb_groupe w_t_spb_groupe

type variables
u_spb_gs_groupe	iuoGsGroupe
u_spb_zn_groupe	iuoZnGroupe
end variables

forward prototypes
public function string wf_controlersaisie ()
public function boolean wf_preparervalider ()
public function boolean wf_preparersupprimer ()
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
public function boolean wf_terminersupprimer ()
public function boolean wf_terminervalider ()
end prototypes

on ue_droitecriture;call w_8_traitement::ue_droitecriture;//*-----------------------------------------------------------------
//*
//* Objet         : w_tm_sp_carte
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
//* Date				:	22/07/97 11:09:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Controle de saisie des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					 	GROUPE.
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

sCol[ 1 ]			= "ID_GRP"
sCol[ 2 ]			= "ID_GRP_BASE"
sCol[ 3 ]			= "LIB_GRP"

sErr[ 1 ]			= " - Le code du groupe"
sErr[ 2 ]			= " - Le code du groupe principal"
sErr[ 3 ]			= " - Le libell$$HEX2$$e9002000$$ENDHEX$$du d$$HEX1$$e900$$ENDHEX$$partement"

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

For	lCpt = 1 To lNbrCol

	If lCpt < 3	Then

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

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Groupes"
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
//* Fonction		:	wf_preparervalider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	22/07/97 12:00:46
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
/* l'insertion d'un nouveau groupe.                                 */
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
//* Date				:	22/05/97 11:13:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Demande de confirmation avant suppression.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai -->	La suppression peut continuer
//*
//*-----------------------------------------------------------------

Boolean	bRet			// Valeur de retour de la fonction
String 	sText 		// Variable de retour de la fonction de controle.

Long		dcIdGrp		// Identifiant du groupe $$HEX2$$e0002000$$ENDHEX$$supprimer.

Integer	iRet			// Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur.

bRet  = True
sText = ""

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/
stMessage.sTitre 		= "Suppression d'un Groupe"
stMessage.sVar[ 1 ] 	= "ce groupe"
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
	/* Produit et Etablissement.                                        */
	/*------------------------------------------------------------------*/
	dcIdGrp = Dw_1.GetItemNumber ( 1, "ID_GRP" )
	sText   = iuoGsGroupe.Uf_Gs_Sup_Grp ( dcIdGrp )

	If sText <> "" Then

		bRet = False

		/*----------------------------------------------------------------------------*/
		/* Si sText = "PROC", alors une erreur a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$e et g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e par la         */
		/* fonction f_procedure, un message d'erreur a donc d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$affich$$HEX1$$e900$$ENDHEX$$.         */
		/*----------------------------------------------------------------------------*/
		If sText <> "PROC" Then

			stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression du Groupe"
			stMessage.sVar[ 1 ] 	= sText  
			stMessage.sVar[ 2 ] 	= "ce groupe"
			stMessage.sCode		= "REFU002"
			stMessage.bErreurG	= TRUE
			f_Message ( stMessage )

		End If

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
//* Date				:	22/07/97 11:11:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations avant insertion
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer.
//*
//*-----------------------------------------------------------------

String	sCol [ 1 ]	// Liste des champs $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger.
DataWindowChild	dwcGrpBase

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")

sCol[ 1 ] 		= "ID_GRP"

Dw_1.Uf_Proteger ( sCol, "0" )

Dw_1.ilPremCol = 1			// ID_GRP
Dw_1.ilDernCol = 3			// LIB_GRP


// .... On repopulise les groupes $$HEX2$$e0002000$$ENDHEX$$chaque cr$$HEX1$$e900$$ENDHEX$$ation

Dw_1.GetChild ( "ID_GRP_BASE" , dwcGrpBase )
dwcGrpBase.SetTransObject( itrTrans )
dwcGrpBase.Retrieve()
dwcGrpBase.SetFilter ( "ID_GRP = ID_GRP_BASE" )
dwcGrpBase.Filter ( )

Dw_1.SetColumn ( Dw_1.ilPremCol ) 

Return ( True )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparermodifier
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	22/07/97 11:12:24
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

sCol [ 1 ] 		= "ID_GRP"

Dw_1.ilPremCol = 2	// ID_GRP_BASE
Dw_1.ilDernCol = 3	// LIB_GRP

Dw_1.Uf_Proteger ( sCol, "1" )

If Dw_1.Retrieve ( Dec ( istPass.sTab [ 1 ] ) ) <= 0 Then bRet = False

Return ( bRet )
end function

public function boolean wf_terminersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_terminerSupprimer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	22/07/97 12:01:29
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
//* Date				:	22/07/97 12:02:29
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

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_groupe
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	22/07/97 11:04:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					 	Groupes.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  PLJ  15/07/2004 Gestion de l'id_grp_prod				  
//*-----------------------------------------------------------------
long					ll_ret
boolean				lb_ret
String				sCol [ 1 ]	// Tableau contenant les champs dont l'attribut 'protect'
										// peut $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$.
DataWindowChild	dwcGrpBase	//DDDW des groupes principaux.
DatawindowChild	dwChild		//#1

iuoGsGroupe = Create u_spb_gs_Groupe
iuoZnGroupe = Create u_spb_zn_Groupe

lb_ret = Dw_1.Uf_SetTransObject ( itrTrans )


/*------------------------------------------------------------------*/
/* #1 Initialisation de la DDDW groupe Sherpa                       */
/*------------------------------------------------------------------*/
ll_ret = Dw_1.GetChild ( "ID_GRP_PROD" , dwChild )
ll_ret = dwChild.SetTransObject ( itrTrans )
ll_ret = dwChild.Retrieve ( '-GP' )
/*---------*/
/* FIN #1  */
/*---------*/

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/
sCol [ 1 ] = "ID_GRP"

Dw_1.GetChild ( "ID_GRP_BASE" , dwcGrpBase )
dwcGrpBase.SetFilter ( "ID_GRP = ID_GRP_BASE" )
dwcGrpBase.Filter ( )

Dw_1.Uf_InitialiserCouleur ( sCol )

iuoGsGroupe.uf_initialisation ( itrTrans, Dw_1 )
iuoZnGroupe.uf_initialisation ( itrTrans, Dw_1 )
end event

on ue_majaccueil;call w_8_traitement::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_groupe
//* Evenement 		:	UE_MAJACCUEIL - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	22/07/97 11:03:44
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
String	sIdGrp		// Variable tampon pour ID_GRP.
String	sIdGrpBase	// Variable tampon pour ID_GRP_BASE.

sTab		  = "~t"
sMajLe	  = String ( dw_1.GetItemDateTime ( 1, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss" )
sIdGrp	  = String ( dw_1.GetItemNumber ( 1, "ID_GRP" ) )
sIdGrpBase = String ( dw_1.GetItemNumber ( 1, "ID_GRP_BASE" ) )

isMajAccueil 	=	sIdGrp										 		+ sTab	+ &
						sIdGrpBase									 		+ sTab	+ &
 						dw_1.GetItemString ( 1, "LIB_GRP" ) 		+ sTab	+ &
						sMajLe								 				+ sTab	+ &
						dw_1.GetItemString ( 1, "MAJ_PAR" )
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_groupe
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
//Migration PB8-WYNIWYG-03/2006 FM
//Destroy iuoGsGroupe
//Destroy iuoZnGroupe
If IsValid(iuoGsGroupe) Then Destroy iuoGsGroupe
If IsValid(iuoZnGroupe) Then Destroy iuoZnGroupe
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_t_spb_groupe.create
call super::create
end on

on w_t_spb_groupe.destroy
call super::destroy
end on

type dw_1 from w_8_traitement`dw_1 within w_t_spb_groupe
integer x = 18
integer y = 172
integer width = 2098
integer height = 516
string dataobject = "d_spb_groupe"
boolean border = false
end type

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	22/07/97 11:01:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification du SqlPreview de la datawindow Dw_1
//*					 	dans le cas de l'insertion d'un nouveau groupe.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1  PLJ  12/07/2004 Gestion du groupe de produit SHERPA					  
//*-----------------------------------------------------------------

String	sSqlPreview			// SqlPreview de la datawindow Dw_1.
String	sLibGrp				// Libell$$HEX2$$e9002000$$ENDHEX$$du groupe.
String	sMajPar
String	sTable				// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sType					// Type d'action effectuer sur la table.
String	sCle [ 1 ]			// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.

//Migration PB8-WYNIWYG-03/2006 CP
//String	sCol [ 6 ]			// Tableau des colonnes de la table : nom de ces colonnes.
//String	sVal [ 6 ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sCol [  ]			// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal [  ]			// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 CP



Long		dcIdGrp				// Identifiant du groupe.
Long		dcIdGrpBase			// Identifiant du groupe principal.

LOng		lIdGrpProd			// #1

Long 		ll_return

DateTime	dtCreeLe				
DateTime	dtMajLe

//Migration PB8-WYNIWYG-03/2006 CP
//CP sSqlPreview = Dw_1.GetSQLPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP

/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable = "GROUPE"

/*------------------------------------------------------------------*/
/* Modification du SqlPreview dans le cas d'une Insertion ou d'une  */
/* Suppression                                                      */
/*------------------------------------------------------------------*/
Choose Case Left ( sSqlPreview, 4 )

	Case	"INSE"

		dcIdGrp     = Dw_1.GetItemNumber   ( 1, "ID_GRP"      )
		dcIdGrpBase = Dw_1.GetItemNumber   ( 1, "ID_GRP_BASE" )
		sLibGrp     = Dw_1.GetItemString   ( 1, "LIB_GRP"     )
		dtCreele    = Dw_1.GetItemDateTime ( 1, "CREE_LE"     )
		dtMajLe     = Dw_1.GetItemDateTime ( 1, "MAJ_LE"      )
		sMajPar     = Dw_1.GetItemString   ( 1, "MAJ_PAR"     )
		lIdGrpProd  = Dw_1.GetItemNumber   ( 1, "ID_GRP_PROD" )

		itrTrans.DW_I01_GROUPE_V01 ( dcIdGrp    , &
										     dcIdGrpBase, &
										     sLibGrp    , &
										     dtCreeLe   , &
										     dtMajLe    , &
										     sMajPar    , &
										     lIdGrpProd )

		If itrTrans.SqlCode <> 0	Then


//Migration PB8-WYNIWYG-03/2006 CP
// 			This.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

		Else

			sCol = { "ID_GRP" , "ID_GRP_BASE" , "LIB_GRP" }

			sVal [ 1 ] = "'" + String ( dcIdGrp     ) + "'"
			sVal [ 2 ] = "'" + String ( dcIdGrpBase ) + "'"
			sVal [ 3 ] = "'" + sLibGrp                + "'"


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

		sCle [ 1 ]	= "'" + String ( Dw_1.GetItemNumber ( 1, "ID_GRP" ) ) + "'"
		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then


//Migration PB8-WYNIWYG-03/2006 CP
// 			Dw_1.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

		End If



	Case	"DELE"

		dcIdGrp = Dw_1.GetItemNumber ( 1, "ID_GRP", DELETE!, FALSE )

		itrTrans.DW_D01_GROUPE ( dcIdGrp )

		If itrTrans.SqlCode <> 0	Then


//Migration PB8-WYNIWYG-03/2006 CP
// 			This.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

		Else

			sCle [ 1 ] = "'" + String ( dcIdGrp ) + "'"
			sType = 'D'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

//CP 				This.SetActionCode ( 1 )
//Migration PB8-WYNIWYG-03/2006 CP
// 			This.SetActionCode ( 1 )
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

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	ItemError
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	22/07/97 10:59:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages d'erreur suite aux erreurs 
//*					 	de saisies.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Groupes"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "ID_GRP"

			Choose Case iiErreur

				Case 0
					stMessage.sVar[1] = "code du groupe"
					stMessage.sCode	= "GENE003"

				Case 1
					stMessage.sVar[1] = "Ce groupe"
					stMessage.sCode	= "GENE005"

			End Choose
	

		Case "ID_GRP_BASE"
			Choose Case iiErreur

				Case 0
					stMessage.sVar[1] = "code du groupe principal"
					stMessage.sCode	= "GENE003"

				Case 1
					stMessage.sVar[1] = "Ce groupe principal"
					stMessage.sCode	= "GENE004"

			End Choose

		Case "LIB_GRP"
			stMessage.sVar[1] = "libell$$HEX2$$e9002000$$ENDHEX$$du groupe"
			stMessage.sCode	= "GENE003"

	End Choose

	/*----------------------------------------------------------------------------*/
	/* On se trouve dans le cas d'une erreur g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e par f_procedure, un message a  */
	/* donc d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$affich$$HEX1$$e900$$ENDHEX$$.                                                     */
	/*----------------------------------------------------------------------------*/
	If iiErreur <> 2 Then

		stMessage.bErreurG	=	TRUE

		f_Message ( stMessage )

	End If

//Migration PB8-WYNIWYG-03/2006 FM
//	This.uf_Reinitialiser ()
	Return uf_Reinitialiser ()
//Fin Migration PB8-WYNIWYG-03/2006 FM

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	ItemChanged - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	22/07/97 13:37:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration lors du changement d'un champ.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 	sText				// Tampon pour la nouvelle valeur du champ.

Integer	iAction			// Argument pour le SetActionCode $$HEX2$$e0002000$$ENDHEX$$la fin de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement.

//Migration PB8-WYNIWYG-03/2006 FM
//sText = This.GetText ()
sText = data
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case isNomCol

	Case "ID_GRP"
		iAction = iuoZnGroupe.uf_zn_Id_Grp ( sText )

	Case "ID_GRP_BASE"
		iAction = iuoZnGroupe.uf_zn_Id_GrpBase ( sText )


End Choose


//Migration PB8-WYNIWYG-03/2006 CP
//This.SetActionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 CP

end event

on dw_1::dberror;call w_8_traitement`dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet			:	w_8_traitement::dw_1
//* Evenement 		:	dberror
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	22/07/97 10:59:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	En cas d'erreur base, on rollbacke la trace.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

UoGsTrace.Uf_CommitTrace ( False )
end on

type st_titre from w_8_traitement`st_titre within w_t_spb_groupe
boolean visible = false
end type

type pb_retour from w_8_traitement`pb_retour within w_t_spb_groupe
integer y = 20
end type

type pb_valider from w_8_traitement`pb_valider within w_t_spb_groupe
integer x = 283
integer y = 20
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_spb_groupe
boolean visible = false
end type

type pb_controler from w_8_traitement`pb_controler within w_t_spb_groupe
boolean visible = false
integer y = 20
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_spb_groupe
integer x = 530
integer y = 20
end type

