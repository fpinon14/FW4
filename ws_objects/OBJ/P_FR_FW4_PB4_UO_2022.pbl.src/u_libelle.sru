HA$PBExportHeader$u_libelle.sru
$PBExportComments$----} UserObjet pour la gestion des courriers
forward
global type u_libelle from userobject
end type
type dw_1 from datawindow within u_libelle
end type
end forward

global type u_libelle from userobject
integer width = 567
integer height = 416
dw_1 dw_1
end type
global u_libelle u_libelle

type variables
String		isVarValue[]
Long		ilNbVar
end variables

forward prototypes
public function integer u_charge_code (string astyplib, ref string ascode[])
public function integer u_charge_libelle (string astyplib, ref string ascode[])
public function boolean u_setvalue (string asvar, string asvalue)
public function string u_getitemstring (datawindow adwdatawindow, long alrow, string ascol)
public function string u_getitemdate (datawindow adwdatawindow, long alrow, string ascol)
public function string u_getitemdatetime (datawindow adwdatawindow, long alrow, string ascol)
public function string u_getitemtime (datawindow adwdatawindow, long alrow, string ascol)
public function string u_getitemnumber (datawindow adwdatawindow, long alrow, string ascol)
public function string u_getitemdecimal (datawindow adwdatawindow, long alrow, string ascol)
public function boolean u_addvalue (string asvar, string asvalue)
public function boolean u_addvaluesep (string asvar, string asvalue, string asseparator)
public function boolean u_creevariable (string asfic, boolean abretour)
public function boolean u_variablechaine (ref string ascahine, s_spb astspb)
public subroutine u_initialisation (u_transaction atrtrans)
public subroutine u_retrieve (string astyplib)
public function boolean u_initvar ()
end prototypes

public function integer u_charge_code (string astyplib, ref string ascode[]);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_Charge_Code
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de remplir un tableau avec les codes 
//*						retrouv$$HEX2$$e9002000$$ENDHEX$$dans la table des codes
//* Commentaires	:	
//*
//* Arguments		:	String	asTypeLib	(Val)	Code concern$$HEX1$$e900$$ENDHEX$$.
//*						String	asCode[]		(Ref) Tableau $$HEX2$$e0002000$$ENDHEX$$charger
//*
//* Retourne		:	Integer	Le nombre de codes lus
//*-----------------------------------------------------------------

Integer	iCpt = 1

Long		lNbLig
Long		lCpt

String	sType

lNbLig	=	Dw_1.RowCount()

For lCpt = 1 To lNbLig

	sType	=	Dw_1.GetItemString ( lCpt, "cod_type" )
	If sType = asTypLib Then

		asCode[iCpt] = Dw_1.GetItemString ( lCpt, "cod_lib" )
		iCpt++
	End If
Next

Return ( iCpt - 1 )
end function

public function integer u_charge_libelle (string astyplib, ref string ascode[]);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_Charge_libelle
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de remplir un tableau avec les libelle 
//*						retrouv$$HEX2$$e9002000$$ENDHEX$$dans la table des codes
//* Commentaires	:	
//*
//* Arguments		:	String	asTypeLib	(Val)	Code concern$$HEX1$$e900$$ENDHEX$$.
//*						String	asCode[]		(Ref) Tableau $$HEX2$$e0002000$$ENDHEX$$charger
//*
//* Retourne		:	Integer	Le nombre de codes lus
//*-----------------------------------------------------------------
Integer	iCpt

Long		lNbLig
Long		lCpt

String	sType

lNbLig	=	Dw_1.RowCount()

For lCpt = 1 To lNbLig

	sType	=	Dw_1.GetItemString ( lCpt, "cod_type" )
	If sType = asTypLib Then

		asCode[iCpt] = Dw_1.GetItemString ( lCpt, "lib" )
		iCpt++
	End If
Next

Return ( iCpt )
end function

public function boolean u_setvalue (string asvar, string asvalue);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_SetValue
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet une variable de fusion avec une valeur
//* Commentaires	:	Fait pour les variable liste
//*
//* Arguments		:	String	asVar		(Val)	Nom de la variable de fusion.
//*						String	asValue	(Val) Valeur devant initialiser la variable.
//*
//* Retourne		:	Boolean	True : Ok la variable $$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trouv$$HEX1$$e900$$ENDHEX$$e
//*						et bien initialis$$HEX1$$e900$$ENDHEX$$e.
//*-----------------------------------------------------------------
String	sDwFind
Long		lRow

sDwFind = "cod_lib='" + asVar + "'"

lRow = dw_1.Find ( sDwFind, 1 , ilNbVar )

If ( lRow > 0 ) Then
	isvarvalue[ lRow ] = asValue
	Return True
Else
	Return ( False )
End If


end function

public function string u_getitemstring (datawindow adwdatawindow, long alrow, string ascol);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_GetItemString
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Effectue un GetItemString sur une datawindow donn$$HEX1$$e900$$ENDHEX$$e 
//*						et retourne "" si la chaine est nulle
//* Commentaires	:	Utile pour remplir les variables de fusion des courriers
//*
//* Arguments		:	DataWindow	aDwDataWindow	(Val)	Datawindow concern$$HEX1$$e900$$ENDHEX$$e.
//*						Long			alRow				(Val) Ligne de la datawindow
//*						String		asCol				(Val) Nom de la colonne
//*
//* Retourne		:	String	La chaine trouv$$HEX1$$e900$$ENDHEX$$e
//*									"" si la chaine est nulle
//*-----------------------------------------------------------------

String sGetItemString

	sGetItemString	= adwDataWindow.GetItemString ( alRow, asCol ) 
	If ( IsNull ( sGetItemString ) ) Then sGetItemString	=	""

Return sGetItemString



end function

public function string u_getitemdate (datawindow adwdatawindow, long alrow, string ascol);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_GetItemDate
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Effectue un GetItemDate sur une datawindow donn$$HEX1$$e900$$ENDHEX$$e 
//*						et la retourne sous forme de chaine
//* Commentaires	:	Utile pour remplir les variables de fusion des courriers
//*
//* Arguments		:	DataWindow	aDwDataWindow	(Val)	Datawindow concern$$HEX1$$e900$$ENDHEX$$e.
//*						Long			alRow				(Val) Ligne de la datawindow
//*						String		asCol				(Val) Nom de la colonne
//*
//* Retourne		:	String	La date sous forme de chaine
//*									"" si la date est nulle
//*-----------------------------------------------------------------

String	sGetItemDate
Date		dtDate

	dtDate = adwDataWindow.GetItemDate ( alRow, asCol ) 
	If ( IsNull ( dtDate ) ) Then 
		sGetItemDate	=	""
	Else
		sGetItemDate	=	String ( dtDate, "DD/MM/YYYY" )
	End If

Return sGetItemDate


end function

public function string u_getitemdatetime (datawindow adwdatawindow, long alrow, string ascol);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_GetItemDateTime
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Effectue un GetItemDateTime sur une datawindow donn$$HEX1$$e900$$ENDHEX$$e 
//*						et retourne la date sous forme de chaine
//* Commentaires	:	Utile pour remplir les variables de fusion des courriers
//*
//* Arguments		:	DataWindow	aDwDataWindow	(Val)	Datawindow concern$$HEX1$$e900$$ENDHEX$$e.
//*						Long			alRow				(Val) Ligne de la datawindow
//*						String		asCol				(Val) Nom de la colonne
//*
//* Retourne		:	String	La date sous forme de chaine
//*									"" si la date est nulle
//*-----------------------------------------------------------------
String	sGetItemDateTime
DateTime	dtDate

	dtDate = adwDataWindow.GetItemDateTime ( alRow, asCol ) 
	If ( IsNull ( dtDate ) ) Then 
		sGetItemDateTime	=	""
	Else
		sGetItemDateTime	=	String ( dtDate, "DD/MM/YYYY" )
	End If

Return sGetItemDateTime

end function

public function string u_getitemtime (datawindow adwdatawindow, long alrow, string ascol);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_GetItemTime
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Effectue un GetItemTime sur une datawindow donn$$HEX1$$e900$$ENDHEX$$e 
//*						et retourne l'haure sous forme de chaine
//* Commentaires	:	Utile pour remplir les variables de fusion des courriers
//*
//* Arguments		:	DataWindow	aDwDataWindow	(Val)	Datawindow concern$$HEX1$$e900$$ENDHEX$$e.
//*						Long			alRow				(Val) Ligne de la datawindow
//*						String		asCol				(Val) Nom de la colonne
//*
//* Retourne		:	String	L'heure sous forme de chaine
//*									"" si l'heure est nulle
//*-----------------------------------------------------------------
String	sGetItemTime
DateTime	dtTime

	dtTime = adwDataWindow.GetItemDateTime ( alRow, asCol ) 
	If ( IsNull ( dtTime ) ) Then 
		sGetItemTime	=	""
	Else
		sGetItemTime	=	String ( dtTime, "hh:mm:ss" )
	End If

Return sGetItemTime

end function

public function string u_getitemnumber (datawindow adwdatawindow, long alrow, string ascol);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_GetItemNumber
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Effectue un GetItemNumber sur une datawindow donn$$HEX1$$e900$$ENDHEX$$e 
//*						et retourne le nombre sous forme de chaine
//* Commentaires	:	Utile pour remplir les variables de fusion des courriers
//*
//* Arguments		:	DataWindow	aDwDataWindow	(Val)	Datawindow concern$$HEX1$$e900$$ENDHEX$$e.
//*						Long			alRow				(Val) Ligne de la datawindow
//*						String		asCol				(Val) Nom de la colonne
//*
//* Retourne		:	String	Le nombre sous forme de chaine
//*									"" si le nombre est nulle
//*-----------------------------------------------------------------

String	sGetItemNumber

	sGetItemNumber = String ( adwDataWindow.GetItemNumber ( alRow, asCol ) )
	If ( IsNull ( sGetItemNumber ) ) Then 	sGetItemNumber	=	""

Return sGetItemNumber


end function

public function string u_getitemdecimal (datawindow adwdatawindow, long alrow, string ascol);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_GetItemDecimal
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Effectue un GetItemDecimal sur une datawindow donn$$HEX1$$e900$$ENDHEX$$e 
//*						et retourne le nombre sous forme de chaine
//* Commentaires	:	Utile pour remplir les variables de fusion des courriers
//*
//* Arguments		:	DataWindow	aDwDataWindow	(Val)	Datawindow concern$$HEX1$$e900$$ENDHEX$$e.
//*						Long			alRow				(Val) Ligne de la datawindow
//*						String		asCol				(Val) Nom de la colonne
//*
//* Retourne		:	String	le nombre sous forme de chaine
//*									"" si le nombre est nulle
//*-----------------------------------------------------------------
String		sGetItemDecimal
Decimal {2}	dcDecimal

	dcDecimal =  adwDataWindow.GetItemDecimal ( alRow, asCol )
	If ( IsNull ( dcDecimal ) ) Then 	
		sGetItemDecimal	=	""
	Else
		sGetItemDecimal = String( dcDecimal )
	End If

Return sGetItemDecimal


end function

public function boolean u_addvalue (string asvar, string asvalue);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_addvalue
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet d'ajouter une valeur $$HEX2$$e0002000$$ENDHEX$$une varaible de fusion
//* Commentaires	:	Fait pour les variable liste
//*
//* Arguments		:	String	asVar		(Val)	Nom de la variable de fusion.
//*						String	asValue	(Val) Valeur $$HEX2$$e0002000$$ENDHEX$$ajouter
//*
//* Retourne		:	Boolean	True : Ok la variable $$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trouv$$HEX1$$e900$$ENDHEX$$e
//*						et la valeur est bien ajout$$HEX1$$e900$$ENDHEX$$e.
//*-----------------------------------------------------------------

String	sDwFind
Long		lRow

sDwFind = "cod_lib='" + asVar + "'"

lRow = dw_1.Find ( sDwFind, 1 , ilNbVar )

If ( lRow > 0 ) Then
	If isVarValue[ lRow ] = "" Then
		isVarValue[ lRow ] = asValue
	Else
		isVarValue[ lRow ] = isVarvalue[ lRow ] + Char(11) + asValue
	End If
	Return ( True )
Else
	Return ( False )
End If


end function

public function boolean u_addvaluesep (string asvar, string asvalue, string asseparator);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_AddvalueSep
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:22:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet d'ajouter une valeur $$HEX2$$e0002000$$ENDHEX$$une varaible de fusion
//*						En pr$$HEX1$$e900$$ENDHEX$$sisant le s$$HEX1$$e900$$ENDHEX$$parateur
//* Commentaires	:	Fait pour les variable liste
//*
//* Arguments		:	String	asVar			(Val)	Nom de la variable de fusion.
//*						String	asValue		(Val) Valeur $$HEX2$$e0002000$$ENDHEX$$ajouter
//*						String	asSeparator	(Val) Caract$$HEX1$$e800$$ENDHEX$$re de s$$HEX1$$e900$$ENDHEX$$paration
//*
//* Retourne		:	Boolean	True : Ok la variable $$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$trouv$$HEX1$$e900$$ENDHEX$$e
//*						et la valeur est bien ajout$$HEX1$$e900$$ENDHEX$$e.
//*-----------------------------------------------------------------

String	sDwFind
Long		lRow

sDwFind = "cod_lib='" + asVar + "'"

lRow = dw_1.Find ( sDwFind, 1 , ilNbVar )

If ( lRow > 0 ) Then
	If isVarValue[ lRow ] = "" Then
		isVarValue[ lRow ] = asValue
	Else
		isVarValue[ lRow ] = isVarvalue[ lRow ] + asSeparator + asValue
	End If
	Return ( True )
Else
	Return ( False )
End If


end function

public function boolean u_creevariable (string asfic, boolean abretour);//======================================================================
// F_CreerVariable : Cr$$HEX1$$e900$$ENDHEX$$ation du fichier de variables ( DATA.DAT )
//
//
// Auteur PR le 19/04/95
//
// --> asFic : Nom du fichier $$HEX2$$e0002000$$ENDHEX$$cr$$HEX1$$e900$$ENDHEX$$er
//
// <-- True / False si probl$$HEX1$$e800$$ENDHEX$$me
//======================================================================

Boolean bOk = True
Integer i
String sVar
Blob blVar 
// .... Partie Adresse SPB

sVar = "ESPNOM~tESPAD1~tESPAD2~tESPCPO~tESPVIL~tESPLID~tESPLIV~tESPRSO"

For i = 1 To dw_1.RowCount()
	sVar = sVar + "~t" + dw_1.GetItemString( i,"cod_lib")
Next


If abRetour Then	sVar = sVar + "~r~n"
// [MIGPB11] [EMD] : Debut Migration : Forcer la cr$$HEX1$$e900$$ENDHEX$$ation de Blob en ANSI
//blVar = Blob ( sVar )
blVar = Blob ( sVar, EncodingANSI! )
// [MIGPB11] [EMD] : Fin Migration
bOk = F_EcrireFichierBlob( blVar , asFic )

Return bOk





end function

public function boolean u_variablechaine (ref string ascahine, s_spb astspb);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_variablechaine
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:47:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Retourne sous forme de chaine, les valeurs par 
//*						rapport aux variable de fusion
//* Commentaires	:	
//*
//* Arguments		:	String	asChaine	(Raf)	Zone de r$$HEX1$$e900$$ENDHEX$$ception des donn$$HEX1$$e900$$ENDHEX$$es.
//*
//* Retourne		:	Boolean Ok la variable est bien charg$$HEX1$$e900$$ENDHEX$$e.
//*
//*-----------------------------------------------------------------


Return f_VariableChaine( astSPB, isVarValue, asCahine )

end function

public subroutine u_initialisation (u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_initialisation
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:42:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise le Uo avec un objet de transaction.
//* Commentaires	:	Utile pour le retrieve sur la table des codes.
//*
//* Arguments		:	u_transaction	aTrTrans	(Val)	Objet de transaction $$HEX2$$e0002000$$ENDHEX$$affecter
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

String	sDataObject		// Dataobject $$HEX2$$e0002000$$ENDHEX$$assigner en fonction du moteur.
String	sMoteur			// Moteur auquel on est connect$$HEX1$$e900$$ENDHEX$$.


sDataobject = "d_libelle_"
sMoteur		= Left ( Upper ( atrTrans.DBMS ), 3 )

// [MIGPB11] [EMD] : Debut Migration : support du DBMS SNC
// If sMoteur = "SNC" Then sMoteur = "MSS"
If sMoteur <> "GUP" Then sMoteur = "MSS" 	// [PI056] Moteur MSS par d$$HEX1$$e900$$ENDHEX$$faut
// [MIGPB11] [EMD] : Fin Migration

   /*-------------------------------------------------------------------*/
	/* Pour l'application SAVANE on continue d'utiliser les dataobjects  */
   /* de gupta : ces derniers ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$migr$$HEX1$$e900$$ENDHEX$$s pour fonctionner avec une  */
   /* base SqlServer                                                    */
   /*-------------------------------------------------------------------*/

	// [I027].BUG2 : Test fiable du code applif_IsApplication('savane')
	//If Left( stGlb.sCodAppli , 2 ) = 'SA' And sMoteur = "MSS" Then sMoteur = 'GUP'
	If f_IsApplication('savane') And sMoteur = "MSS" Then sMoteur = 'GUP'

/*------------------------------------------------------------------*/
/* On assigne le DataObject en fonction du moteur.                  */
/*------------------------------------------------------------------*/
Choose Case sMoteur

	Case "GUP"
		sDataObject = sDataObject + sMoteur
	
	Case "MSS"
		sDataObject = sDataObject + sMoteur

End Choose

Dw_1.DataObject = sDataObject

Dw_1.SetTransObject ( atrTrans )

end subroutine

public subroutine u_retrieve (string astyplib);//*-----------------------------------------------------------------
//*
//* Fonction		:	u_retrieve
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:44:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Effectue le retrieve sur la table des codes 
//*						pour un type de code donn$$HEX1$$e900$$ENDHEX$$.
//* Commentaires	:	
//*
//* Arguments		:	String	asTypLib	(Val)	Type de code
//*
//* Retourne		:	Rien
//*
//*-----------------------------------------------------------------

ilNbVar = Dw_1.Retrieve ( asTypLib )


end subroutine

public function boolean u_initvar ();//*-----------------------------------------------------------------
//*
//* Fonction		:	u_initvar
//* Auteur			:	La Recrue
//* Date				:	24/04/1997 11:43:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Initialise le tableau des variables $$HEX2$$e0002000$$ENDHEX$$vide
//* Commentaires	:	si aucune variable alors PB.
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean
//*-----------------------------------------------------------------

String	stEmpty[]

If ilNbVar > 0	Then

	isVarValue [] = stEmpty []
	isVarValue [ ilNbVar ] = ""

Else

	Return ( False )

End If

Return ( True )
end function

on u_libelle.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on u_libelle.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within u_libelle
boolean visible = false
integer x = 32
integer y = 24
integer width = 494
integer height = 360
integer taborder = 1
string dataobject = "d_libelle_gup"
boolean livescroll = true
end type

