HA$PBExportHeader$w_t_spb_courtype.srw
$PBExportComments$-} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des courriers type
forward
global type w_t_spb_courtype from w_8_traitement
end type
type uo_onglets from u_onglets within w_t_spb_courtype
end type
type uo_compo from u_spb_ajout_courtyp within w_t_spb_courtype
end type
type uo_bord3d from u_bord3d within w_t_spb_courtype
end type
end forward

global type w_t_spb_courtype from w_8_traitement
integer x = 224
integer y = 240
integer width = 3168
integer height = 1332
string title = "Gestion de la biblioth$$HEX1$$e800$$ENDHEX$$que des courriers types"
event ue_entreronglet021 pbm_custom39
event ue_droitecriture pbm_custom38
uo_onglets uo_onglets
uo_compo uo_compo
uo_bord3d uo_bord3d
end type
global w_t_spb_courtype w_t_spb_courtype

type variables
u_spb_gs_courtype iuoGsCourType
u_spb_zn_courtype iuoZnCourType
end variables

forward prototypes
public function string wf_controlergestion ()
public function string wf_controlersaisie ()
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
public function boolean wf_preparersupprimer ()
public function boolean wf_preparervalider ()
public function boolean wf_terminervalider ()
public function boolean wf_terminersupprimer ()
end prototypes

on ue_entreronglet021;call w_8_traitement::ue_entreronglet021;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_t_si_courtype
//* Evenement 		:	ue_entreronglet021
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/06/1997 17:34:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Positionne le focus sur uo_Compo.dw_cible
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


/*------------------------------------------------------------------*/
/* On positionne le Focus sur la DW Cible de uo_Compo afin d'$$HEX1$$e900$$ENDHEX$$viter */
/* qu'il y ait la premi$$HEX1$$e800$$ENDHEX$$re ligne de dw_cible ET de dw_source qui    */
/* soient s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es simultan$$HEX1$$e900$$ENDHEX$$ment, mais seulement s'il y a au   */
/* moins 1 enregistrement ; sinon on le positionne sur dw_source    */
/*------------------------------------------------------------------*/
If Uo_Compo.dw_Cible.RowCount () > 0 then

	Uo_Compo.Dw_Cible.SetFocus  ()
	Uo_Compo.dw_Cible.SelectRow ( 1 , True )

Else

	Uo_Compo.Dw_Source.SetFocus ()
	Uo_Compo.Dw_Source.SelectRow( 1 , True )

End If
end on

on ue_droitecriture;call w_8_traitement::ue_droitecriture;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_spb_courtype
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

public function string wf_controlergestion ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_controlergestion
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	17/06/97 11:53:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de gestion de la saisie
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	""		->	Si contr$$HEX1$$f400$$ENDHEX$$le Ok
//*					  				Nom de la colonne en Erreur
//*
//*-----------------------------------------------------------------

String		sCol 				// Nom de la colonne en Erreur.
String		sIdCour			// Identifiant du courrier type.

sCol = ""

If ( istPass.bInsert = True )  Then

	sIdCour 		= Dw_1.GetItemString ( 1, "ID_COUR" )

	If  Not ( iuoGsCourType.uf_gs_Id_cour ( sIdCour ) )	Then

		sCol 		= "ID_COUR"

		/*------------------------------------------------------------------*/
		/* Repositionne le bon onglet : onglet des courriers types          */
		/* (Rappel : l'init. de l'onglet se fait dans l'ue_initialiser      */
		/*------------------------------------------------------------------*/
		Uo_Onglets.Uf_ChangerOnglet ( "01" )

	End If

End If

Return ( sCol )
end function

public function string wf_controlersaisie ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_controlersaisie
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	17/06/97 11:50:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de saisie des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					 	COUR_TYPE.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String		"" -> On passe au controle de gestion
//*											Nom de colonne en erreur
//*
//*
//*-----------------------------------------------------------------

String 		sCol [ 3 ]			// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sErr [ 3 ]			// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String 		sNouvelleLigne		// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText					// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos					// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.
String		sVal					// Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification.
Long 			lCpt					// Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrCol				// Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.


sNouvelleLigne = "~r~n"
lNbrCol			= UpperBound ( sCol )
sPos				= ""
sText				= sNouvelleLigne

sCol [ 1 ]		= "ID_COUR"
sCol [ 2 ]		= "LIB_COUR"
sCol [ 3 ]		= "LIB_MODELE"

sErr [ 1 ]		= " - Le code courrier type"
sErr [ 2 ]		= " - Le libell$$HEX1$$e900$$ENDHEX$$"
sErr [ 3 ]		= " - Le nom du mod$$HEX1$$e800$$ENDHEX$$le"

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/
For	lCpt = 1 To lNbrCol

	sVal = Dw_1.GetItemString ( 1, sCol [ lCpt ] )

	If ( IsNull ( sVal ) or Trim ( sVal ) = "" )	Then

		If ( sPos = "" ) 	Then 	sPos = sCol [ lCpt ]
		sText = sText + sErr [ lCpt ] + sNouvelleLigne

	End If

Next

/*------------------------------------------------------------------*/
/* Affichage de la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant au message d'erreur s'il y  */
/* en a une :												                    */
/*------------------------------------------------------------------*/
If	( sPos <> "" ) Then

	/*------------------------------------------------------------------*/
	/* Repositionne le bon onglet : l'onglet des courriers types        */
	/* (Rappel : l'init. de l'onglet se fait dans l'ue_initialiser      */
	/*------------------------------------------------------------------*/
	Uo_Onglets.Uf_ChangerOnglet ( "01" )

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Courriers Types"
	stMessage.Icon			= Information!
	stMessage.sVar[1] 	= sText
	stMessage.bErreurG	= TRUE
	stMessage.sCode		= "GENE001"

	f_Message ( stMessage )

End If

Return ( sPos )
end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparerinserer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	17/06/97 11:55:53
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations avant insertion
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer
//*										
//*
//*-----------------------------------------------------------------

String  	sCol [ 1 ]	// Champ $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger.
String	sTab			// Variable pour la tabulation.
String	sNew			// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String	sText			// Variable relative $$HEX2$$e0002000$$ENDHEX$$la chaine $$HEX2$$e0002000$$ENDHEX$$importer. 

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")

/*------------------------------------------------------------------*/
/* Rend accessible en saisie le Code Courrier Type                  */
/*------------------------------------------------------------------*/
sCol [ 1 ] = "ID_COUR"
Dw_1.Uf_Proteger ( sCol, "0" )

/*------------------------------------------------------------------*/
/* Initialisation li$$HEX1$$e900$$ENDHEX$$e aux colonnes                                 */
/*------------------------------------------------------------------*/
Dw_1.ilPremCol = 1
Dw_1.ilDernCol = 4
Dw_1.SetColumn ( Dw_1.ilPremCol )

/*------------------------------------------------------------------*/
/* Positionnement sur l'onglet des courriers types                  */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_ChangerOnglet ( "01" )

/*------------------------------------------------------------------*/
/* Initialisations pour la gestion de la composition de courrier    */
/* type                                                             */
/*------------------------------------------------------------------*/
sTab	= "~t"
sNew	= "~r~n"
sText	= ""

/*------------------------------------------------------------------*/
/* Permet de populiser les informations dans la DwRecherche         */
/*------------------------------------------------------------------*/
Uo_Compo.Uf_dwRechercheRetrieve ( "", Uo_Compo )

/*------------------------------------------------------------------*/
/* Renseigne Dwcible avec les informations de DwRecherche.          */
/*------------------------------------------------------------------*/
Uo_Compo.Dw_Recherche.RowsCopy	( 1 , 	Uo_Compo.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    		Uo_Compo.Dw_Cible , 1 , PRIMARY!  )

/*------------------------------------------------------------------*/
/* Initialise la source $$HEX2$$e0002000$$ENDHEX$$vide puisqu'on est en cr$$HEX1$$e900$$ENDHEX$$ation            */
/*------------------------------------------------------------------*/
Uo_Compo.Dw_Source.Reset ( )


/*------------------------------------------------------------------*/
/* Tri les paragraphes non affect$$HEX1$$e900$$ENDHEX$$s                                 */
/*------------------------------------------------------------------*/
Uo_Compo.Dw_Cible.SetSort ( "ID_PARA A" )
Uo_Compo.Dw_Cible.Sort    ( )

/*------------------------------------------------------------------*/
/* On refait la s$$HEX1$$e900$$ENDHEX$$lection par d$$HEX1$$e900$$ENDHEX$$faut de la premi$$HEX1$$e800$$ENDHEX$$re ligne car avec  */
/* le Sort la premi$$HEX1$$e800$$ENDHEX$$re ligne n'est plus obligatoirement la m$$HEX1$$ea00$$ENDHEX$$me et  */
/* l'anc$$HEX1$$ea00$$ENDHEX$$tre l'a s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e d'office.                             */
/*------------------------------------------------------------------*/
Uo_Compo.Dw_Cible.SelectRow ( 0 , False )
Uo_Compo.Dw_Cible.SelectRow ( 1 , True  )

Uo_Compo.Dw_Source.SetSort ( "" )

Return ( TRUE )
end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_PreparerModifier
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/06/1997 17:23:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La Modification peut continuer
//*									
//*-----------------------------------------------------------------

String   sCol [ 1 ]		// Champ $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger contre la saisie
String	sTab				// Variable pour la tabulation.
String	sNew				// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String	sText				// Variable relative $$HEX2$$e0002000$$ENDHEX$$la chaine $$HEX2$$e0002000$$ENDHEX$$importer. 

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")

/*------------------------------------------------------------------*/
/* Rend inaccessible en saisie le Code Courrier Type                */
/*------------------------------------------------------------------*/
sCol [ 1 ] = "ID_COUR"
Dw_1.Uf_Proteger ( sCol, "1" )


/*------------------------------------------------------------------*/
/* Positionnement sur l'onglet des courriers types.                 */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_ChangerOnglet ( "01" )


/*------------------------------------------------------------------*/
/* Initialisation li$$HEX1$$e900$$ENDHEX$$e aux colonnes.                                */
/*------------------------------------------------------------------*/
Dw_1.ilPremCol = 2
Dw_1.ilDernCol = 4
Dw_1.SetColumn ( Dw_1.ilpremCol  )

If Dw_1.Retrieve  ( istPass.sTab[1] ) <= 0 Then Return ( False )

/*------------------------------------------------------------------*/
/*  Initialisations pour la gestion de la composition de courrier   */
/* type.                                                            */
/*------------------------------------------------------------------*/
sTab	= "~t"
sNew	= "~r~n"
sText	= ""


/*------------------------------------------------------------------*/
/* Permet de populiser les informations dans  Dw Recherche.         */
/*------------------------------------------------------------------*/
Uo_Compo.Uf_dwRechercheRetrieve ( Dw_1.GetItemString ( 1 , "ID_COUR" ) , uo_Compo )

/*------------------------------------------------------------------*/
/* Populise les informations dans DwSource.                         */
/*------------------------------------------------------------------*/
Uo_Compo.Uf_dwSourceRetrieve ( Dw_1.GetItemString ( 1 , "ID_COUR" ), uo_Compo )

/*------------------------------------------------------------------*/
/* Ajout du tri sur le No d'ordre des paragraphes dans une          */
/* composition                                                      */
/*------------------------------------------------------------------*/
Uo_Compo.Dw_Source.SetSort ( "ID_ORDRE A" )
Uo_Compo.Dw_Source.Sort    ( )

/*------------------------------------------------------------------*/
/* Renseigne DwCible avec les informations de DwRecherche.          */
/*------------------------------------------------------------------*/
Uo_Compo.Dw_Recherche.RowsCopy	( 1 , 	Uo_Compo.Dw_Recherche.RowCount ( ) , PRIMARY! , &
                                    		Uo_Compo.Dw_Cible , 1 , PRIMARY!  )


/*------------------------------------------------------------------*/
/* Tri les paragraphes non affect$$HEX1$$e900$$ENDHEX$$s.                                */
/*------------------------------------------------------------------*/
Uo_Compo.Dw_Cible.SetSort ( "ID_PARA A" )
Uo_Compo.Dw_Cible.Sort    ( )

/*------------------------------------------------------------------*/
/* On refait la s$$HEX1$$e900$$ENDHEX$$lection par d$$HEX1$$e900$$ENDHEX$$faut de la premi$$HEX1$$e800$$ENDHEX$$re ligne car avec  */
/* le Sort la premi$$HEX1$$e800$$ENDHEX$$re ligne n'est plus obligatoirement la m$$HEX1$$ea00$$ENDHEX$$me et  */
/* l'anc$$HEX1$$ea00$$ENDHEX$$tre l'a s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e d'office.                             */
/*------------------------------------------------------------------*/
Uo_Compo.Dw_Cible.SelectRow ( 0 , False )
Uo_Compo.Dw_Cible.SelectRow ( 1 , True  )

Uo_Compo.Dw_Source.SetSort ( "" )

Return ( True )
end function

public function boolean wf_preparersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_PreparerSupprimer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/06/1997 17:22:24
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Demande de confirmation avant suppression
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai -->	La suppression peut continuer
//*										
//*-----------------------------------------------------------------

Boolean 	bRet 				// Variable de retour de la fonction.

Integer	iRet				// Confirmation de l'op$$HEX1$$e900$$ENDHEX$$rateur.

String 	sIdCour			// Identifiant du courrier type $$HEX2$$e0002000$$ENDHEX$$supprimer.
String	sTable			// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sType				// Type d'action effectuer sur la table.
String	sCle [ 1 ]		// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
String	sCol [ 1 ]		// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal [ 1 ]		// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.

bRet = True

/*------------------------------------------------------------------*/
/* Demande de Confirmation avant suppression                        */
/*------------------------------------------------------------------*/
stMessage.sTitre 		= "Suppression d'un Courrier Type"
stMessage.sVar [ 1 ]	= "ce Courrier Type"
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
	/* COURRIER                                                         */
	/*------------------------------------------------------------------*/
	sIdCour 	= Dw_1.GetItemString ( 1, "ID_COUR" )
	bRet 		= iuoGsCourType.uf_Gs_Sup_CourType ( sIdCour )

	If Not ( bRet ) Then

		stMessage.sTitre 		= "Contr$$HEX1$$f400$$ENDHEX$$le avant Suppression d'un Courrier Type"
		stMessage.sVar[ 1 ] 	= "des courriers"
		stMessage.sVar[ 2 ] 	= "ce courrier type"
		stMessage.bErreurG	= TRUE
		stMessage.sCode		= "REFU002"

		f_Message ( stMessage )

	Else

		/*------------------------------------------------------------------*/
		/* Suppression si aucun probl$$HEX1$$e800$$ENDHEX$$me d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX25$$e900200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
		/*------------------------------------------------------------------*/
		If Dw_1.DeleteRow ( 0 ) < 0	Then

			bRet = False

		End If

	End If

	If bRet Then

		itrTrans.IM_D01_COMPOSITION ( sIdCour )

		If itrTrans.SQLCode <> 0 Then

			bRet = False

		Else

			/*------------------------------------------------------------------*/
			/* On trace les ligne que l'on vient de supprimer dans la table     */
			/* Composition.                                                     */
			/*------------------------------------------------------------------*/
			sTable = "COMPOSITION"

			sCle [ 1 ] = "'" + sIdCour + "'"
			sType = 'D'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

				bRet = False

			End If

		End If

	End If

End If

Return ( bRet )
end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparervalider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/06/97 17:14:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise les infos $$HEX2$$e0002000$$ENDHEX$$la cr$$HEX1$$e900$$ENDHEX$$ation d'un enregistrement
//* Commentaires	:	
//*
//* Arguments		: Aucun
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en 	-->	Vraie : La validation peut 
//*													  continuer
//*
//*-----------------------------------------------------------------

Boolean 		bRet 				// Valeur de retour de la fonction.
Long 			lCpt				// Compteur : nombre de lignes dans dw_Source.			
Long			lNbrLig			// Nombre de lignes dans dw_Source.
DateTime		dtValidation	// Variable relative aux dates : CREE_LE, MAJ_LE.
String		sIdCour			// Identifiant du courrier type trait$$HEX1$$e900$$ENDHEX$$.

bRet = True

/*------------------------------------------------------------------*/
/* Initialisation des informations de cr$$HEX1$$e900$$ENDHEX$$ation dans le cas de       */
/* l'insertion d'un nouveau courrier type.                          */
/*------------------------------------------------------------------*/
If ( istPass.bInsert = True ) Then

		f_Creele ( Dw_1, 1 )		
	
End If

f_MajPar ( Dw_1, 1 )


/*------------------------------------------------------------------*/
/* Initialisation de champ dans la datawindow source de la          */
/* composition                                                      */
/*------------------------------------------------------------------*/
lNbrLig	= uo_Compo.dw_Source.RowCount ()



/*------------------------------------------------------------------*/
/* S'il n'y pas au moins un paragraphe composant le courrier type,  */
/* la validation ne peut pas continuer                              */
/*------------------------------------------------------------------*/
If lNbrLig < 1 then

	/*------------------------------------------------------------------*/
	/* Repositionne le bon onglet : onglet de la composition            */
	/*------------------------------------------------------------------*/
	Uo_Onglets.Uf_ChangerOnglet ( "02" )

	/*------------------------------------------------------------------*/
	/* Erreur indiquant qu'il faut au moins un paragraphe               */
	/*------------------------------------------------------------------*/
	stMessage.sTitre		= "Param$$HEX1$$e800$$ENDHEX$$trage des Courriers Type"
	stMessage.Icon			= Exclamation!
	stMessage.bErreurG	= TRUE
	stMessage.sCode 		= "REFU003"

	f_Message ( stMessage ) 

	bRet = False

Else

	dtValidation 	= DateTime ( Today (), Now () )

	If lNbrLig > 0 Then

		For	lCpt = 1 To lNbrLig

		   /*------------------------------------------------------------------*/
		   /* Change le statut de la ligne de mani$$HEX1$$e800$$ENDHEX$$re $$HEX2$$e0002000$$ENDHEX$$toujours envoyer des   */
		   /* INSERT puis met $$HEX2$$e0002000$$ENDHEX$$jour les infos manquantes                      */
		   /*------------------------------------------------------------------*/
			uo_Compo.Dw_Source.SetItemStatus ( lCpt, 0, Primary!, New! )

			sIdCour = Dw_1.GetItemString ( 1 , "ID_COUR" )

			uo_Compo.Dw_Source.SetItem ( lCpt, "ID_COUR"	, sIdCour        ) 
			uo_Compo.Dw_Source.SetItem ( lCpt, "ID_ORDRE", lCpt           )
			uo_Compo.Dw_Source.SetItem ( lCpt, "CREE_LE" , dtValidation   ) 
			uo_Compo.Dw_Source.SetItem ( lCpt, "MAJ_LE"	, dtValidation   ) 
			uo_Compo.Dw_Source.SetItem ( lCpt, "MAJ_PAR"	, stGLB.sCodOper ) 

		Next

	End If

End If

Return ( bRet )
end function

public function boolean wf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_TerminerValider ()
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	17/06/1997 16:50:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Supprime les lignes de la table COMPOSITION et update
//*					 	la Datawindow : seulement des inserts seront envoy$$HEX1$$e900$$ENDHEX$$s.
//* Commentaires	:	
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean : True la validation peut se poursuivre.
//*
//*-----------------------------------------------------------------

Boolean	bRet				// Valeur de retour de la fonction.

String	sIdCour			// Identifiant du courrier.
String	sTable			// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sType				// Type d'action effectuer sur la table.
String	sCle [ 1 ]		// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
String	sCol [ 1 ]		// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal [ 1 ]		// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.

bRet = True

/*------------------------------------------------------------------*/
/* Si on est en cr$$HEX1$$e900$$ENDHEX$$ation inutile d'envoyer une commande d$$HEX1$$e900$$ENDHEX$$truire    */
/* des lignes qui n'existent pas.                                   */
/*------------------------------------------------------------------*/

If		Not ( istPass.bInsert )	Then

	sIdCour	= istPass.sTab [ 1 ]

	itrTrans.IM_D01_COMPOSITION ( sIdCour )

	If itrTrans.SQLCode <> 0 Then

		bRet = False

	Else

		/*------------------------------------------------------------------*/
		/* On trace les ligne que l'on vient de supprimer dans la table     */
		/* Composition.                                                     */
		/*------------------------------------------------------------------*/
		sTable = "COMPOSITION"

		sCle [ 1 ] = "'" + sIdCour + "'"

		sType = 'D'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

			bRet = False

		End If

	End If

End If


If bRet	Then

	If Uo_Compo.Dw_Source.Update () = -1	Then	bRet = False

End If

/*------------------------------------------------------------------*/
/* Si tout est OK, on peut commiter la trace, sinon rollback        */
/*------------------------------------------------------------------*/
UoGsTrace.Uf_CommitTrace ( bREt )

Return ( bRet )
end function

public function boolean wf_terminersupprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_terminerSupprimer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/06/1997 17:20:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	termine la suppression
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
UoGsTrace.Uf_CommitTrace ( True )

Return ( True )
end function

on ue_retour;call w_8_traitement::ue_retour;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_t_spb_courtype
//* Evenement 		:	Ue_retour
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	17/06/1997 17:45:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Ferme la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des courriers si elle est      */
/* ouverte et cach$$HEX1$$e900$$ENDHEX$$e.                                               */
/*------------------------------------------------------------------*/
If IsValid ( W_Consulter_Courrier )	Then

	Close ( W_Consulter_Courrier )

End If

end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_t_spb_courtype
//* Evenement 		:	Close
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	17/06/1997 17:45:55
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction du User Object de contr$$HEX1$$f400$$ENDHEX$$le de gestion et de saisie   */
/* pour le param$$HEX1$$e900$$ENDHEX$$trage des Courriers Type                           */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Destroy iuoGsCourType
//Destroy iuoZnCourType
If IsValid(iuoGsCourType) Then Destroy iuoGsCourType
If IsValid(iuoZnCourType) Then Destroy iuoZnCourType
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Ferme la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation des courriers si elle est      */
/* ouverte et cach$$HEX1$$e900$$ENDHEX$$e.                                               */
/*------------------------------------------------------------------*/
If IsValid ( W_Consulter_Courrier )	Then

	Close ( W_Consulter_Courrier )

End If



end event

event ue_initialiser;call super::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_courtype
//* Evenement 		:	ue_initialiser
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	17/06/97 17:39:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					 	Courriers type
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ	PAR		Date		Modification
//* #1	JCA	18/05/2007	DCMP 070051 - Modification du titre de l'onglet de courrier type
//*-----------------------------------------------------------------

String	sRepCourrier	// R$$HEX1$$e900$$ENDHEX$$pertoire des courriers.
String	sModele			// Mod$$HEX1$$e800$$ENDHEX$$le utilis$$HEX2$$e9002000$$ENDHEX$$par l'application.
String	sMod				// Chaine de Modify().
String	sCol [ 1 ]		// Tableau contenant les champs dont 
								// l'attribut 'protect' peut $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$.

iuoGsCourType = Create u_spb_gs_CourType
iuoZnCourType = Create u_spb_zn_CourType

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/
sCol[1] 			= "ID_COUR"

Dw_1.Uf_InitialiserCouleur ( sCol )

Dw_1.Uf_SetTransObject ( itrTrans )

/*------------------------------------------------------------------*/
/* Initialisation du User Object de contr$$HEX1$$f400$$ENDHEX$$le de gestion et de       */
/* saisie                                                           */
/*------------------------------------------------------------------*/
iuoGsCourType.uf_initialisation ( itrTrans, Dw_1 )
iuoZnCourType.uf_initialisation ( itrTrans, Dw_1 )


/*------------------------------------------------------------------*/
/* Initialisation de l'onglet                                       */
/*------------------------------------------------------------------*/
Uo_Onglets.Uf_Initialiser ( 2, 1 )

// #1
Uo_Onglets.Uf_EnregistrerOnglet ( "01", "Courrier Type", "" , dw_1    , False  )
//Uo_Onglets.Uf_EnregistrerOnglet ( "01", "Biblioth$$HEX1$$e800$$ENDHEX$$que de courriers type", "" , dw_1    , False  )
// Taille de l'onglet trop court :/
// #1 - FIN

Uo_Onglets.Uf_EnregistrerOnglet ( "02", "Composition"  , "" , Uo_Compo, False )

/*----------------------------------------------------------------------------*/
/* Affection des Dataobjet aux Dw de l'objet : recherche, source, cible.      */
/*----------------------------------------------------------------------------*/
Uo_Compo.Uf_Initialiser ( "d_spb_lst_para_rch", "d_spb_compo_para", "d_spb_lst_para", itrTrans )

/*----------------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le r$$HEX1$$e900$$ENDHEX$$pertoire des courriers et le mod$$HEX1$$e800$$ENDHEX$$le dans le .INI de       */
/* l'application pour initialiser le champ 'modele' avec.                     */
/*----------------------------------------------------------------------------*/
sRepCourrier 	= ProfileString ( stGLB.sFichierIni , "EDITION" , "REP_COURRIER" 	, "" 	)
sModele			= profileString ( stGLB.sFichierIni , "EDITION" , "MODELE" 			, ""	)

sMod = "lib_modele.initial='" + sRepCourrier + sModele + "'"
Dw_1.Uf_Modify ( sMod )


end event

on ue_majaccueil;call w_8_traitement::ue_majaccueil;//*-----------------------------------------------------------------
//*
//* Objet 			:	w_t_spb_courtype
//* Evenement 		:	UE_MAJACCUEIL - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	17/06/1997 17:43:11
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

sTab				= "~t"
sMajLe			= String ( dw_1.GetItemDateTime ( 1, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss" )

isMajAccueil 	= dw_1.GetItemString ( 1, "ID_COUR" ) 	+ sTab	+ &
 					  dw_1.GetItemString ( 1, "LIB_COUR" ) + sTab	+ &
					  sMajLe								 				+ sTab	+ &
					  dw_1.GetItemString ( 1, "MAJ_PAR" )

end on

on w_t_spb_courtype.create
int iCurrent
call super::create
this.uo_onglets=create uo_onglets
this.uo_compo=create uo_compo
this.uo_bord3d=create uo_bord3d
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_onglets
this.Control[iCurrent+2]=this.uo_compo
this.Control[iCurrent+3]=this.uo_bord3d
end on

on w_t_spb_courtype.destroy
call super::destroy
destroy(this.uo_onglets)
destroy(this.uo_compo)
destroy(this.uo_bord3d)
end on

type dw_1 from w_8_traitement`dw_1 within w_t_spb_courtype
integer x = 206
integer y = 452
integer width = 2738
integer height = 600
string dataobject = "d_spb_courtype"
boolean border = false
end type

on dw_1::dberror;call w_8_traitement`dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet 			: 	Dw_1
//* Evenement 		:	dberror
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/07/97 16:34:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	En cas d'erreur base, on rollbacke la trace.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

UoGsTrace.Uf_CommitTrace ( False )
end on

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	ITEMERROR - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/06/97 16:30:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages d'erreur suite aux erreurs 
//*					 	de saisies.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

If	ibErreur Then

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Courriers Types"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "ID_COUR"
			Choose Case iiErreur 
			
					Case 0
							stMessage.bErreurG	= TRUE
							stMessage.sVar[1] 	= "code du courrier type"
							stMessage.sCode		= "GENE003"

					Case 1
							stMessage.bErreurG	= TRUE
							stMessage.sCode   = "REFU004"
			End Choose


		Case "LIB_COUR"
			stMessage.bErreurG	= TRUE
			stMessage.sVar[1] = "libell$$HEX2$$e9002000$$ENDHEX$$du courrier type"
			stMessage.sCode	= "GENE003"


		Case "LIB_MODELE"
			stMessage.bErreurG	= TRUE
			stMessage.sVar[1] = "libell$$HEX2$$e9002000$$ENDHEX$$du mod$$HEX1$$e800$$ENDHEX$$le"
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

end event

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/06/1997 16:38:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification du SqlPreview de la datawindow Dw_1
//*					 	dans le cas de l'insertion ou de la suppression  
//*					 	d'un courrier type
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sSqlPreview		// SqlPreview de la datawindow Dw_1.
String	sIdCour			// Identifiant du courrier type.
String	sLibcour			// Libell$$HEX2$$e9002000$$ENDHEX$$du courrier type.
String	sLibModele		// Libell$$HEX2$$e9002000$$ENDHEX$$du mod$$HEX1$$e800$$ENDHEX$$le.
String	sMajPar
String	sTable			// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sType				// Type d'action effectuer sur la table.
String	sCle [ 1 ]		// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.

//Migration PB8-WYNIWYG-03/2006 CP
//String	sCol [ 6 ]		// Tableau des colonnes de la table : nom de ces colonnes.
//String	sVal [ 6 ]		// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sCol [  ]		// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal [  ]		// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
//Fin Migration PB8-WYNIWYG-03/2006 CP

//Migration PB8-WYNIWYG-03/2006 CP
Long ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

DateTime	dtCreeLe
DateTime	dtMajLe

//Migration PB8-WYNIWYG-03/2006 CP
//sSqlPreview 		= Dw_1.GetSQLPreview ()
sSqlPreview = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 CP


/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "COUR_TYPE"

Choose Case Left ( sSqlPreview, 4 )

	Case	"INSE"

		sIdCour		= This.GetItemString   ( 1, "ID_COUR"    )
		sLibCour		= This.GetItemString   ( 1, "LIB_COUR"   )
		sLibModele	= This.GetItemString   ( 1, "LIB_MODELE" )
		dtCreele		= This.GetItemDateTime ( 1, "CREE_LE"    )
		dtMajLe		= This.GetItemDateTime ( 1, "MAJ_LE"     )
		sMajPar		= This.GetItemString   ( 1, "MAJ_PAR"    )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure d'insertion.                                           */
		/*------------------------------------------------------------------*/
		itrTrans.DW_I01_COUR_TYPE ( sIdCour    , &
										 sLibCour   , &
										 sLibModele , &
									 	 dtCreeLe   , &
									 	 dtMajLe    , &
									 	 sMajPar )

		If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//			This.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP				

		Else

			sCol = { "ID_COUR", "LIB_COUR", "LIB_MODELE" }

			sVal [ 1 ] = "'" + sIdCour    + "'"
			sVal [ 2 ] = "'" + sLibCour   + "'"
			sVal [ 3 ] = "'" + sLibModele + "'"

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

		sCle [ 1 ]	= "'" + This.GetItemString ( 1, "ID_COUR" ) + "'"
		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

//Migration PB8-WYNIWYG-03/2006 CP
//			This.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP				

		End If

	Case	"DELE"

		sIdCour = This.GetItemString (  1, "ID_COUR", DELETE!, False )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure de suppression.                                        */
		/*------------------------------------------------------------------*/
		itrTrans.DW_D01_COUR_TYPE ( sIdCour )

		If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//			This.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP				


		Else

			sCle [ 1 ] = "'" + sIdCour + "'"
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

//Migration PB8-WYNIWYG-03/2006 CP
Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP
end event

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: 	Dw_1
//* Evenement 		:	ItemChanged - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/06/97 16:35:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de champs
//* Commentaires	:
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sVal			// Valeur du champ saisi.
Integer  iAction		// Valeur du SetActionCode.

iAction	= 0
//Migration PB8-WYNIWYG-03/2006 FM
//sVal		= This.GetText ( )
sVal		= data
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case isNomCol

	Case "ID_COUR"

		/*------------------------------------------------------------------*/
		/* V$$HEX1$$e900$$ENDHEX$$rifie que l'Id CourTyp doit faire exactement 6 caract$$HEX1$$e800$$ENDHEX$$res      */
		/*------------------------------------------------------------------*/
		If Not ( IuoZnCourType.Uf_Zn_Longueur_Id ( sVal ) ) then

			iiErreur = 1
			iAction  = 1

		End If

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
//This.SetACtionCode ( iAction )
Return iAction
//Fin Migration PB8-WYNIWYG-03/2006 CP




end event

type st_titre from w_8_traitement`st_titre within w_t_spb_courtype
boolean visible = false
end type

type pb_retour from w_8_traitement`pb_retour within w_t_spb_courtype
integer y = 32
integer taborder = 30
end type

type pb_valider from w_8_traitement`pb_valider within w_t_spb_courtype
integer x = 283
integer y = 32
integer taborder = 50
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_spb_courtype
boolean visible = false
integer x = 777
integer y = 36
integer taborder = 70
end type

type pb_controler from w_8_traitement`pb_controler within w_t_spb_courtype
boolean visible = false
integer y = 36
integer taborder = 40
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_spb_courtype
integer x = 530
integer y = 32
integer taborder = 60
end type

type uo_onglets from u_onglets within w_t_spb_courtype
integer x = 27
integer y = 196
integer width = 978
integer height = 108
integer taborder = 20
boolean border = false
end type

type uo_compo from u_spb_ajout_courtyp within w_t_spb_courtype
integer x = 37
integer y = 292
integer width = 3081
integer height = 924
integer taborder = 80
boolean border = false
end type

on ue_dwsource_rbuttondown;call u_spb_ajout_courtyp::ue_dwsource_rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet			:	Uo_Compo
//* Evenement 		:	ue_DwSource_rbuttondown
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/09/97 15:37:29
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de d$$HEX1$$e900$$ENDHEX$$clencher la visualisation du courrier
//*						type d$$HEX1$$e900$$ENDHEX$$fini par cette composition.
//*						si ligne courante il y a et si $$HEX2$$a7002000$$ENDHEX$$il y a
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

s_Pass		stPass

Long			lnbrPara
Long			lCpt			// Compteur pour le nombre de paragraphe.
Long			lCpt1			// compteur pour le tableau.

stPass.trTrans	=	Parent.itrTrans

lNbrPara = dw_source.Rowcount ()

If lnbrPara > 0	Then

	stPass.sTab [ 1 ]	=	" Courrier " + Dw_1.GetItemString ( 1, "ID_COUR" )	
	lCpt1 = 2

	For lCpt = 1	to lNbrPara

		stPass.sTab [ lCpt1 ] = dw_source.GetItemString ( lCpt, "ID_PARA"  )
		lCpt1 ++
		stPass.sTab [ lCpt1 ] = dw_source.GetItemString ( lCpt, "LIB_PARA" )
		lCpt1 ++

	Next

	If	IsValid ( W_Consulter_Courrier )	Then

		W_Consulter_Courrier.Show ()

	Else

		Open ( W_Consulter_Courrier )

	End If

	W_Consulter_Courrier.Wf_AfficherCourrier ( stPass )

End If
end on

on ue_dimensionner;call u_spb_ajout_courtyp::ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			:	uo_compo
//* Evenement 		:	ue_dimensionner
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/06/1997 17:09:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Rend invisible les boutons permettant de supprimer ou 
//*					 	d'ajouter tout.
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

uo_compo.Pb_enlever_tout.Visible = False
uo_compo.Pb_ajouter_tout.Visible = False
end on

event ue_dwsource_sqlpreview;call super::ue_dwsource_sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	uo_compo
//* Evenement 		:	UE_DWSOURCE_SQLPREVIEW
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/06/97 16:52:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Insertion des paragraphes dans la table COMPOSITION.
//*	
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sSql				// commande SQL qui doit $$HEX1$$ea00$$ENDHEX$$tre envoy$$HEX1$$e900$$ENDHEX$$e.
String	sIdCour			// Identifiant du courrier type.
String	sIdPara			// Identifiant du paragraphe
String	sMajPar			// Auteur de la mise $$HEX2$$e0002000$$ENDHEX$$jour.
String	sTable			// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sType				// Type d'action effectuer sur la table.
String	sCle [ 2 ]		// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.
String	sCol [ 6 ]		// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal [ 6 ]		// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.

decimal	dcIdOrdre		// Ordre du paragraphe dans la compo.

Long		lLig				// N$$HEX2$$b0002000$$ENDHEX$$de la ligne $$HEX2$$e0002000$$ENDHEX$$ins$$HEX1$$e800$$ENDHEX$$rer.

//Migration PB8-WYNIWYG-03/2006 CP
Long		ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP

dwBuffer	dwBuf				// buffer de donn$$HEX1$$e900$$ENDHEX$$e de la Dw.

DateTime	dtCreeLe
DateTime	dtMajLe

//Migration PB8-WYNIWYG-03/2006 FM
//sSql = uo_compo.dw_Source.GetSqlPreview ()
sSql = sql_syntax
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Initialisation pour la Trace.                                    */
/*------------------------------------------------------------------*/
sTable		= "COMPOSITION"

Choose Case Left ( sSql, 4 )

	Case "INSE"

		/*------------------------------------------------------------------*/
		/* Permet d'obtenir le N$$HEX2$$b0002000$$ENDHEX$$de l'enregistrement $$HEX2$$e0002000$$ENDHEX$$inserer.            */
		/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//		uo_compo.dw_Source.GetUpdateStatus ( lLig, dwBuf )
lLig = ligne
dwBuf = buffer_dw
//Fin Migration PB8-WYNIWYG-03/2006 FM

		sIdCour	 = uo_Compo.dw_Source.GetItemString   ( lLig, "ID_COUR"    )
		sIdPara	 = uo_Compo.dw_Source.GetItemString   ( lLig, "ID_PARA"   )
		dcIdOrdre = uo_Compo.dw_Source.GetItemNumber   ( lLig, "ID_ORDRE" )
		dtCreele	 = uo_Compo.dw_Source.GetItemDateTime ( lLig, "CREE_LE"    )
		dtMajLe	 = uo_Compo.dw_Source.GetItemDateTime ( lLig, "MAJ_LE"     )
		sMajPar	 = uo_Compo.dw_Source.GetItemString   ( lLig, "MAJ_PAR"    )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure d'insertion.                                           */
		/*------------------------------------------------------------------*/
		itrTrans.DW_I01_COMPOSITION ( sIdCour   , &
											   sIdPara   , &
											   dcIdOrdre , &
										 	   dtCreeLe  , &
										 	   dtMajLe   , &
										 	   sMajPar        )

		If itrTrans.SqlCode <> 0	Then

//Migration PB8-WYNIWYG-03/2006 CP
//			Uo_Compo.dw_Source.SetActionCode ( 1 )
			ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

		Else

			sCol = { "ID_COUR" , "ID_PARA" , "ID_ORDRE" }

			sVal [ 1 ] = "'" + sIdCour    + "'"
			sVal [ 2 ] = "'" + sIdPara   + "'"
			sVal [ 3 ] = "'" + String ( dcIdOrdre ) + "'"

			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]	= sVal [ 2 ]
			sType = 'I'

			If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then

//Migration PB8-WYNIWYG-03/2006 CP
//				Uo_Compo.dw_Source.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP

			Else

//Migration PB8-WYNIWYG-03/2006 CP
//				Uo_Compo.dw_Source.SetActionCode ( 2 )
				ll_return = 2
//Fin Migration PB8-WYNIWYG-03/2006 CP

			End If

		End If

End Choose

//Migration PB8-WYNIWYG-03/2006 CP
Return ll_return
//Fin Migration PB8-WYNIWYG-03/2006 CP
end event

on constructor;call u_spb_ajout_courtyp::constructor;//*-----------------------------------------------------------------
//*
//* Objet 			:	uo_compo
//* Evenement 		:	CONSTRUCTOR
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/06/1997 17:10:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de l'objet
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* L'objet ne poss$$HEX1$$e800$$ENDHEX$$de pas de titre.                                 */
/*------------------------------------------------------------------*/
ibTitre = False

/*------------------------------------------------------------------*/
/* Utilisation des boutons avec une taille pour des fen$$HEX1$$ea00$$ENDHEX$$tre 800x600 */
/*------------------------------------------------------------------*/
isTaille = '8_'

/*------------------------------------------------------------------*/
/* Pas de s$$HEX1$$e900$$ENDHEX$$lection multiple pour la datawindow source              */
/*------------------------------------------------------------------*/
ibSourceSelMul = False
end on

on uo_compo.destroy
call u_spb_ajout_courtyp::destroy
end on

type uo_bord3d from u_bord3d within w_t_spb_courtype
integer x = 37
integer y = 292
integer width = 3081
integer height = 924
boolean bringtotop = true
end type

on uo_bord3d.destroy
call u_bord3d::destroy
end on

