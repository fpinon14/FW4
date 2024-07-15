HA$PBExportHeader$w_t_spb_code_anc.srw
$PBExportComments$--} Fen$$HEX1$$ea00$$ENDHEX$$tre de traitement pour le param$$HEX1$$e900$$ENDHEX$$trage des codes : fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre.
forward
global type w_t_spb_code_anc from w_8_traitement
end type
end forward

global type w_t_spb_code_anc from w_8_traitement
integer x = 754
integer y = 556
integer width = 2135
integer height = 680
string title = "Gestion des codes"
event ue_droitecriture pbm_custom39
end type
global w_t_spb_code_anc w_t_spb_code_anc

type variables
u_spb_gs_code	iuoGsCode
u_spb_zn_code	iuoZnCode

String 		isTypCode = ""

Boolean		ibCompteur

Integer		iiSetActionCode
end variables

forward prototypes
public function string wf_controlersaisie ()
public function string wf_controlergestion ()
public function boolean wf_preparervalider ()
public function boolean wf_preparerinserer ()
public function boolean wf_preparermodifier ()
public function boolean wf_terminervalider ()
public function boolean wf_terminersupprimer ()
end prototypes

on ue_droitecriture;call w_8_traitement::ue_droitecriture;//*-----------------------------------------------------------------
//*
//* Objet         : w_t_spb_code_anc
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
//* Date				:	11/06/97 14:59:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le de saisie des zones relatives $$HEX2$$e0002000$$ENDHEX$$la table 
//*					 	CODE.
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		"" -> On passe au contr$$HEX1$$f400$$ENDHEX$$le de gestion
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

String 		sCol [ 3 ]			// Nom des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sErr [ 3 ]			// Erreur relative a un champ $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String 		sNouvelleLigne		// Variable pour le retour $$HEX2$$e0002000$$ENDHEX$$la ligne.
String		sText					// Variable relative a l'ensemble des champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
String		sPos					// Nom du premier champ non renseign$$HEX1$$e900$$ENDHEX$$.
String		sVal					// Valeur du champ en v$$HEX1$$e900$$ENDHEX$$rification.

Long			lDebCpt				// Valeur de d$$HEX1$$e900$$ENDHEX$$but du compteur.
Long 			lCpt					// Compteur pour les champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.
Long			lNbrCol				// Nombre de champs $$HEX2$$e0002000$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$rifier.

sNouvelleLigne	= "~r~n"
lNbrCol			= UpperBound ( sCol )
sPos				= ""
sText				= sNouvelleLigne

sCol [ 1 ]		= "ID_CODE"
sCol [ 2 ]		= "ID_TYP_CODE"
sCol [ 3 ]		= "LIB_CODE"

sErr [ 1 ]		= " - Le code"
sErr [ 2 ]		= " - Le type code"
sErr [ 3 ]		= " - Le libell$$HEX2$$e9002000$$ENDHEX$$du code"

/*------------------------------------------------------------------*/
/* Si l'identifiant du code est renseign$$HEX2$$e9002000$$ENDHEX$$par un compteur il na     */
/* faut pas en verifier la saisie.                                  */
/*------------------------------------------------------------------*/
If ibCompteur	Then

	lDebCpt = 2

Else

	lDebCpt = 1

End If

/*------------------------------------------------------------------*/
/* Test des zones standards                                         */
/*------------------------------------------------------------------*/

For	lCpt = lDebCpt		To		lNbrCol

	If lCpt = 1	Then

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

	stMessage.sTitre		= "Contr$$HEX1$$f400$$ENDHEX$$le de Saisie des Codes"
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
//* Date				:	11/06/97 14:49:45
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Controle de gestion de la saisie.
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String	"" -> Ok
//*											Nom de colonne en erreur
//*
//*-----------------------------------------------------------------

String		sCol 			// Nom de la colonne en Erreur.
String		sIdTypCode	// Identifiant du type de code.

Long			dcIdCode		// Identifiant du code.

sCol = ""

/*------------------------------------------------------------------*/
/* Il y a contr$$HEX1$$f400$$ENDHEX$$le d'unicit$$HEX2$$e9002000$$ENDHEX$$de l'identifiant du code que s'il est  */
/* saisissable : pas de compteur.                                   */
/*------------------------------------------------------------------*/
If ( istPass.bInsert = True ) AND ( ibCompteur = False )  Then

	sIdTypCode 	= Dw_1.GetItemString ( 1, "ID_TYP_CODE" )
	dcIdCode 	= Dw_1.GetItemNumber ( 1, "ID_CODE" )

	If ( iuoGsCode.uf_gs_id_Code ( sIdTypCode, dcIdCode ) = False ) Then

		sCol 		= "ID_CODE"

	End If

End If

Return ( sCol )
end function

public function boolean wf_preparervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparervalider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 14:43:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	-->	Vraie : La validation peut 
//*													  continuer
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Initialisation des informations de cr$$HEX1$$e900$$ENDHEX$$ation dans le cas de       */
/* l'insertion d'un nouveau code.                                   */
/*------------------------------------------------------------------*/
If ( istPass.bInsert = True ) Then

	f_Creele ( Dw_1, 1 )

End If

f_MajPar ( Dw_1, 1 )

Return ( True )
end function

public function boolean wf_preparerinserer ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparerinserer
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 14:39:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations avant insertion
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en	-->	True :  L'insertion peut continuer
//*
//*-----------------------------------------------------------------

Boolean	bRet 	// Variable de retour.
String	sMod	// Tampon pour modify.

bRet = True

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


/*------------------------------------------------------------------*/
/* Pas de compteur pour ID_CODE.                                    */
/*------------------------------------------------------------------*/
ibCompteur = True

If istPass.lTab [ 1 ] = 1 Then

	/*------------------------------------------------------------------*/
	/* le type du code n'est pas modifiable                             */
	/*------------------------------------------------------------------*/
	Dw_1.Uf_Proteger ( { "ID_TYP_CODE" }, "1" )
	/*------------------------------------------------------------------*/
	/* Pas de fl$$HEX1$$ea00$$ENDHEX$$che pour la DDDW                                       */
	/*------------------------------------------------------------------*/
	sMod = "Id_TYP_CODE.DDDW.UseAsBorder=No "
	Dw_1.uf_Modify ( sMod )

	/*------------------------------------------------------------------*/
	/* D$$HEX1$$e900$$ENDHEX$$termine si le code doit $$HEX1$$ea00$$ENDHEX$$tre saisie ou non.                    */
	/*------------------------------------------------------------------*/
	iuoZncode.uf_Zn_Id_TypCode ( isTypCode, ibCompteur )

	If ibCompteur	Then

		Dw_1.ilPremCol = 3

	Else

		Dw_1.ilPremcol = 2

	End If

Else

	/*------------------------------------------------------------------*/
	/* le type du code est modifiable                                   */
	/*------------------------------------------------------------------*/
	Dw_1.Uf_Proteger ( { "ID_TYP_CODE" }, "0" )	
	Dw_1.ilPremCol = 1

End If

Dw_1.ilDernCol = 3

Dw_1.SetColumn ( Dw_1.ilPremCol )
Dw_1.SetItem 	( 1, "ID_TYP_CODE", isTypCode )

Return ( bRet )

end function

public function boolean wf_preparermodifier ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_preparermodifier
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 14:41:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$ration avant modification
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en 	Vrai : La Modification peut continuer
//*
//*-----------------------------------------------------------------

Boolean 	bRet = True		// Valeur de Retour.

String	sMod				// Chaine tampon pour un modify.
String  	sCol [ 2 ]		// Liste des champs $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger.

/*------------------------------------------------------------------*/
/* DCMP 030399 OMG/SO                                               */
/*------------------------------------------------------------------*/
This.PostEvent ("ue_droitecriture")


sCol [ 1 ] 		= "ID_CODE"
sCol [ 2 ] 		= "ID_TYP_CODE"

Dw_1.ilPremCol = 3
Dw_1.ilDernCol = 3

Dw_1.Uf_Proteger ( sCol, "1" )

/*------------------------------------------------------------------*/
/* le type du code n'est pas modifiable, pas de fl$$HEX1$$ea00$$ENDHEX$$che pour la DDDW */
/*------------------------------------------------------------------*/
sMod = "Id_TYP_CODE.DDDW.UseAsBorder=No "

Dw_1.uf_Modify ( sMod )

If Dw_1.Retrieve ( istPass.sTab [ 1 ], Dec ( istPass.sTab [ 2 ] ) ) <= 0 Then bRet = False

Return ( bRet )
end function

public function boolean wf_terminervalider ();//*-----------------------------------------------------------------
//*
//* Fonction		:	wf_terminervalider
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 14:48:08
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
//* Fonction		: wf_terminerSupprimer
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 11/06/97 14:49:06
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Termine la suppression
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: boolean		TRUE 	si OK, la suppression peut continuer.
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
//* Objet			:	w_t_spb_code_anc
//* Evenement 		:	UE_MAJACCUEIL - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 14:25:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne pour mettre $$HEX2$$e0002000$$ENDHEX$$jour la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 	sTab			// Code tabulation
String	sMajLe		// Variable tampon pour MAJ_LE
String	sIdCode		// Variable tampon pour ID_CODE

sTab    = "~t"
sIdCode = String ( dw_1.GetItemNumber ( 1, "ID_CODE" ) )
sMajLe  = String ( dw_1.GetItemDateTime ( 1, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss" )

isMajAccueil 	=	dw_1.GetItemString ( 1, "ID_TYP_CODE" ) 	+ sTab	+ &
 						sIdCode												+ sTab	+ &
 						dw_1.GetItemString ( 1, "LIB_CODE" ) 		+ sTab	+ &
						sMajLe								 				+ sTab	+ &
						dw_1.GetItemString ( 1, "MAJ_PAR" )

end on

on ue_initialiser;call w_8_traitement::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_code_anc
//* Evenement 		:	UE_INITIALISER - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 14:24:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialisation de la fen$$HEX1$$ea00$$ENDHEX$$tre de traitement des 
//*					 	Codes.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sCol [ 2 ]	// Tableau contenant les champs dont l'attribut 'protect' peut $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$

iuoGsCode 		= Create u_spb_gs_Code
iuoZnCode 		= Create u_spb_zn_Code

Dw_1.Uf_SetTransObject ( itrTrans )

/*------------------------------------------------------------------*/
/* Initialisation des champs dont la couleur changera en fonction   */
/* de la protection                                                 */
/*------------------------------------------------------------------*/
sCol[1] 			= "ID_CODE"
sCol[2] 			= "ID_TYP_CODE"

Dw_1.Uf_InitialiserCouleur ( sCol )

iuoGsCode.uf_initialisation ( itrTrans, Dw_1 )
iuoZnCode.uf_initialisation ( itrTrans, Dw_1 )
end on

event close;call super::close;//*-----------------------------------------------------------------
//*
//* Objet			:	w_t_spb_code_anc
//* Evenement 		:	Close
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 14:25:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Op$$HEX1$$e900$$ENDHEX$$rations $$HEX2$$e0002000$$ENDHEX$$effectuer $$HEX2$$e0002000$$ENDHEX$$la fermeture de la 
//*					 	fen$$HEX1$$ea00$$ENDHEX$$tre .
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Destruction des User Objects de contr$$HEX1$$f400$$ENDHEX$$le de gestion et de saisie */
/* pour le param$$HEX1$$e900$$ENDHEX$$trage des codes                                    */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Destroy iuoGsCode
//Destroy iuoZnCode
If IsValid(iuoGsCode) Then Destroy iuoGsCode
If IsValid(iuoZnCode) Then Destroy iuoZnCode
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on w_t_spb_code_anc.create
call super::create
end on

on w_t_spb_code_anc.destroy
call super::destroy
end on

type dw_1 from w_8_traitement`dw_1 within w_t_spb_code_anc
integer x = 23
integer y = 192
integer width = 2094
integer height = 388
string dataobject = "d_spb_code_num"
boolean border = false
end type

event dw_1::itemerror;call super::itemerror;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	ITEMERROR - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 15:45:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Gestion des messages d'erreur suite aux erreurs 
//*					   de saisies.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

stMessage.sCode = ""

If	ibErreur Then

	stMessage.sTitre	= "Param$$HEX1$$e900$$ENDHEX$$trage des Codes"
	stMessage.Icon		= Information!

	Choose Case isErrCol

		Case "ID_CODE"

			Choose Case iiErreur

				Case 0
					stMessage.sVar[1] 	= "code"
					stMessage.bErreurG	= TRUE
					stMessage.sCode		= "GENE003"
			
			End Choose

		Case "LIB_CODE"
			stMessage.sVar[1] 	= "libell$$HEX2$$e9002000$$ENDHEX$$du code"
			stMessage.bErreurG	= TRUE
			stMessage.sCode		= "GENE003"

	End Choose

	/*----------------------------------------------------------------------------*/
	/* L'affichage du message et le Uf_Reinitialiser() sont cod$$HEX1$$e900$$ENDHEX$$s dans le         */
	/* descendant.                                                                */
	/*----------------------------------------------------------------------------*/

End If

//Migration PB8-WYNIWYG-03/2006 FM
return AncestorReturnValue
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event dw_1::itemchanged;call super::itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			:	Dw_1
//* Evenement 		:	ITEMCHANGED - Extend
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 15:05:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le des champs en cas de modification.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String 	sVal			// Valeur du champ saisi.

iiSetActionCode	= 0
//Migration PB8-WYNIWYG-03/2006 FM
//sVal		= This.GetText( )
sVal		= data
//Fin Migration PB8-WYNIWYG-03/2006 FM

Choose Case isNomCol

		Case "ID_TYP_CODE"
			/*------------------------------------------------------------------*/
			/* Determine si pour ce type de code le champ ID_CODE doit $$HEX1$$ea00$$ENDHEX$$tre     */
			/* saisi.                                                           */
			/*------------------------------------------------------------------*/
			iiSetActionCode 	= iuoZnCode.uf_Zn_Id_TypCode ( sVal, ibCompteur )

End Choose

/*----------------------------------------------------------------------------*/
/* NB : Le SetACtionCode() sera d$$HEX1$$e900$$ENDHEX$$clench$$HEX2$$e9002000$$ENDHEX$$sur le descendant.                  */
/*----------------------------------------------------------------------------*/


end event

event dw_1::sqlpreview;call super::sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	SQLPREVIEW
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 17:27:26
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Modification du SqlPreview de la datawindow Dw_1
//*					 	dans le cas de l'insertion d'un nouveau code.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String	sSqlPreview		// SqlPreview de la datawindow Dw_1.
String	sIdTypcode		// Identifiant du type de code.
String	sLibCode			// Libell$$HEX2$$e9002000$$ENDHEX$$du code.
String	sNomCompteur
String	sMajPar
String	sTable			// Nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sType				// Type d'action effectuer sur la table.
String	sCle [ 2 ]		// Tableau de l'identifiant de l'enregistrement trac$$HEX1$$e900$$ENDHEX$$.

//Migration PB8-WYNIWYG-03/2006 CP
//String	sCol [ 6 ]		// Tableau des colonnes de la table : nom de ces colonnes.
//String	sVal [ 6 ]		// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.
String	sCol [  ]		// Tableau des colonnes de la table : nom de ces colonnes.
String	sVal [  ]		// Tableau des valeurs des colonnes $$HEX2$$e0002000$$ENDHEX$$tracer.//Fin Migration PB8-WYNIWYG-03/2006 CP
//Fin Migration PB8-WYNIWYG-03/2006 CP

//Migration PB8-WYNIWYG-03/2006 FM
//Long		dcIdCode			// Identifiant du code.
decimal		dcIdCode			// Identifiant du code.
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 CP
Long		ll_return
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
sTable		= "CODE"

Choose Case Left ( sSqlPreview, 4 )

	Case	"INSE"

		sIdTypCode   = This.GetItemString   ( 1, "ID_TYP_CODE" )

		If Not ( ibCompteur )	then

//Migration PB8-WYNIWYG-03/2006 FM
//			sNomCompteur = ""
//l'appel $$HEX2$$e0002000$$ENDHEX$$la fonction RPC ne fonctionne pas (d$$HEX1$$e900$$ENDHEX$$clenchement du raiseerror)
			sNomCompteur = " "
//Fin Migration PB8-WYNIWYG-03/2006 FM

			dcIdCode = This.GetItemNumber ( 1, "ID_CODE" )

		Else

			sNomCompteur = 'ID_' + Right ( sIdTypCode, 2 )

		End If

		sLibCode     = This.GetItemString   ( 1, "LIB_CODE"    )
		dtCreele     = This.GetItemDateTime ( 1, "CREE_LE"     )
		dtMajLe      = This.GetItemDateTime ( 1, "MAJ_LE"      )
		sMajPar      = This.GetItemString   ( 1, "MAJ_PAR"     )

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure d'insertion.                                           */
		/*------------------------------------------------------------------*/

		itrTrans.DW_I01_CODE (  sIdTypCode , &
									 dcIdCode   , &
									 sLibCode   , &
									 dtCreeLe   , &
									 dtMajLe    , &
									 sMajPar    , &
									 sNomCompteur )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 CP
// 			This.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP				

		Else

			If ibCompteur	Then	This.SetItem ( 1, "ID_CODE", dcIdCode )

			sCol = { "ID_TYP_CODE" , "ID_CODE" , "LIB_CODE" }

			sVal [ 1 ] = "'" + sIdTypCode  + "'"
			sVal [ 2 ] = "'" + String ( dcIdCode )  + "'"
			sVal [ 3 ] = "'" + sLibCode + "'"

			sCle [ 1 ]	= sVal [ 1 ]
			sCle [ 2 ]  = sVal [ 2 ]

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

		sCle [ 1 ] = "'" + This.GetItemString ( 1, "ID_TYP_CODE" ) + "'"
		sCle [ 2 ] = "'" + String ( This.GetItemNumber ( 1, "ID_CODE" ) ) + "'"

		sType = 'U'

		If Not ( uogstrace.uf_Trace ( sType, sTable, sCle, sCol, sVal ) )	Then
//Migration PB8-WYNIWYG-03/2006 CP
// 			Dw_1.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP				

		End If

	Case	"DELE"

		sIdTypCode = This.GetItemString (  1, "ID_TYP_CODE", DELETE!, False	)
		dcIdCode   = This.GetItemNumber (  1, "ID_CODE"    , DELETE!, False	)

		/*------------------------------------------------------------------*/
		/* Proc$$HEX1$$e900$$ENDHEX$$dure de suppression.                                        */
		/*------------------------------------------------------------------*/
		itrTrans.DW_D01_CODE ( sIdTypCode, dcIdCode )

		If itrTrans.SqlCode <> 0	Then
//Migration PB8-WYNIWYG-03/2006 CP
// 			This.SetActionCode ( 1 )
				ll_return = 1
//Fin Migration PB8-WYNIWYG-03/2006 CP				

		Else

			sCle [ 1 ] = "'" + sIdTypCode + "'"
			sCle [ 2 ] = "'" + String ( dcIdCode ) + "'"
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

Return ll_return



end event

on dw_1::dberror;call w_8_traitement`dw_1::dberror;//*-----------------------------------------------------------------
//*
//* Objet			:	Dw_1
//* Evenement 		:	dberror
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 15:45:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	En cas d'erreur base, on rollbacke la trace.
//* Commentaires	:	
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

UoGsTrace.Uf_CommitTrace ( False )
end on

type st_titre from w_8_traitement`st_titre within w_t_spb_code_anc
boolean visible = false
end type

type pb_retour from w_8_traitement`pb_retour within w_t_spb_code_anc
integer y = 16
end type

type pb_valider from w_8_traitement`pb_valider within w_t_spb_code_anc
integer x = 283
integer y = 16
end type

type pb_imprimer from w_8_traitement`pb_imprimer within w_t_spb_code_anc
boolean visible = false
end type

type pb_controler from w_8_traitement`pb_controler within w_t_spb_code_anc
boolean visible = false
integer y = 16
end type

type pb_supprimer from w_8_traitement`pb_supprimer within w_t_spb_code_anc
integer x = 530
integer y = 16
end type

