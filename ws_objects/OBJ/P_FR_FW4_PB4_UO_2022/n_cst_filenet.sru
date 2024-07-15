HA$PBExportHeader$n_cst_filenet.sru
forward
global type n_cst_filenet from nonvisualobject
end type
end forward

global type n_cst_filenet from nonvisualobject
end type
global n_cst_filenet n_cst_filenet

type variables
Public :
	U_Transaction	itrFileNet
	OLEObject	iOleFNLibrary
	OLEObject	iOleFNViewer
	
Private :
	Boolean		ibInitNatif
	Boolean		ibInitSql
	Integer		iiAutoriserMiseaJour = 1
	
	String		isNomLibrairie
	String		isUser
	String		isMotDePasse
	String		isClassName
	
	Integer		iiClassNumber
	String		isNomQueue
	
	Long		K_FNSYSTEMTYPE = 1		// ImageService
	
	String		K_USERSQL = "f_sw."
end variables

forward prototypes
public function integer uf_connecternatif (boolean abactiver, string asfichierini)
private subroutine uf_initialisernatif (string asfichierini)
private subroutine uf_setautorisermiseajour ()
private function integer uf_getautorisermiseajour ()
public function integer uf_connectersql (boolean abactiver, string asfichierini)
private function long uf_initialisersql (string asfichierini)
private function string uf_getclassname (long alClassNumber)
end prototypes

public function integer uf_connecternatif (boolean abactiver, string asfichierini);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_FileNet::Uf_ConnecterNatif (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 08/02/2000 16:40:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va se connecter de mani$$HEX1$$e800$$ENDHEX$$re NATIVE $$HEX2$$e0002000$$ENDHEX$$FileNet (SQL+MKF)
//*
//* Arguments		: (Val)	Boolean	abActiver		Connection/D$$HEX1$$e900$$ENDHEX$$connection
//*					  (Val)	String	asFichierIni	Fichier de param$$HEX1$$e800$$ENDHEX$$tres
//*
//* Retourne		: Integer				 1 = Tout est OK
//*												-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Integer iRet = 1
Long lRet
Boolean bRet

/*------------------------------------------------------------------*/
/* On veut activer une connection. On v$$HEX1$$e900$$ENDHEX$$rifie qu'une connection ne  */
/* soit pas d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$active. On instancie l'objet OLE pour FileNet, on  */
/* se connecte. Si la connection $$HEX1$$e900$$ENDHEX$$choue, on d$$HEX1$$e900$$ENDHEX$$truit l'instance.     */
/*------------------------------------------------------------------*/
If	abActiver	Then
	If	Not ibInitNatif	Then
		Uf_InitialiserNatif ( asFichierIni )

		bRet = iOleFNLibrary.Logon ( isUser, isMotDePasse, "", 0 )
		If	Not bRet	Then 
			DESTROY	iOleFnLibrary
			ibInitNatif = FALSE
			iRet = -1
		Else
			ibInitNatif = TRUE
		End If
	End If
Else
/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$sactive la connection NATIVE. On se d$$HEX1$$e900$$ENDHEX$$connecte des bases    */
/* (SQL+MKF).                                                       */
/*------------------------------------------------------------------*/
	If	ibInitNatif	Then
		iOleFnLibrary.Logoff ()
		ibInitNatif = FALSE
		DESTROY	iOleFnLibrary
	End If
End If

Return ( iRet )

end function

private subroutine uf_initialisernatif (string asfichierini);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_FileNet::uf_InitialiserNatif (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 08/02/2000 15:56:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On initialise les fonctionnalit$$HEX1$$e900$$ENDHEX$$es NATIVE de l'objet FileNet
//*
//* Arguments		: (Val)		String	asFichierIni
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sNomTransaction, sNomBase

/*------------------------------------------------------------------*/
/* Si le fichier de configuration existe, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les valeurs   */
/* dans la section FleNet NATIF. Ces valeurs vont permettre de se   */
/* connecter aux bases (SQL+MKF) de donn$$HEX1$$e900$$ENDHEX$$es.                        */
/*------------------------------------------------------------------*/
isNomLibrairie	= ProfileString ( asFichierIni, "FileNet NATIF", "NomLibrairie", "" )
isUser			= ProfileString ( asFichierIni, "FileNet NATIF", "User", "" )
isMotDePasse	= ProfileString ( asFichierIni, "FileNet NATIF", "MotDePasse", "" )
/*------------------------------------------------------------------*/
/* On va d$$HEX1$$e900$$ENDHEX$$coder le mot de passe qui est crypt$$HEX2$$e9002000$$ENDHEX$$dans le fichier     */
/* INI.                                                             */
/*------------------------------------------------------------------*/
isMotDePasse	= F_CoderMdp ( isMotDePasse )

iOleFnLibrary					= CREATE OleObject
Long lRet
lRet = iOleFnLibrary.ConnectToNewObject ( "IDMObjects.Library.3.1" )
MessageBox ( "", lRet )

lRet = iOleFnLibrary.ConnectToObject ( "", "IDMObjects.Library" )
MessageBox ( "", lRet )

//iOleFnLibrary.Name 			= isNomLibrairie
//iOleFnLibrary.SystemType	= K_FNSYSTEMTYPE

/*------------------------------------------------------------------*/
/* On s'occupe de cr$$HEX1$$e900$$ENDHEX$$er l'objet pour visualiser les documents.      */
/*------------------------------------------------------------------*/
iOleFnViewer					= CREATE OleObject
iOleFnViewer.ConnectToNewObject ( "IDMViewerApp.Application" )
/*------------------------------------------------------------------*/
/* On charge la variable d'instance iiAutoriserMiseaJour.           */
/*------------------------------------------------------------------*/
This.uf_SetAutoriserMiseaJour ()


end subroutine

private subroutine uf_setautorisermiseajour ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_FileNet::uf_SetAutoriserMiseaJour		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 01/12/2000 15:13:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: on va armer la variable d'instance iiAutoriserMiseaJour
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Le fichier INI dans la section [APPLICATION] doit contenir une   */
/* cl$$HEX2$$e9002000$$ENDHEX$$FileNet_AutoriserMiseaJour. Cette cl$$HEX2$$e9002000$$ENDHEX$$est arm$$HEX1$$e900$$ENDHEX$$e dans la      */
/* variable d'instance iiAutoriserMiseaJour. Cette fonction est     */
/* appel$$HEX1$$e900$$ENDHEX$$e dans uf_InitialiserNatif () et uf_Initialiser_Sql ().    */
/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut, on autorise la mise $$HEX2$$e0002000$$ENDHEX$$jour sur le syst$$HEX1$$e800$$ENDHEX$$me FileNet.   */
/*------------------------------------------------------------------*/
String sFicApp

sFicApp = stGLB.sFichierIni
iiAutoriserMiseaJour = ProfileInt ( sFicApp, "APPLICATION", "FileNet_AutoriserMiseaJour", 1 )



end subroutine

private function integer uf_getautorisermiseajour ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_FileNe::Uf_GetAutoriserMiseaJour		(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/02/2000 17:20:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Renvoie la valeur de iiAutoriserMiseaJour
//*
//* Arguments		: Aucun
//*
//* Retourne		: Integer	
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On renvoie la valeur d'instance iiAutoriserMiseaJour. Cette      */
/* valeur est positionn$$HEX1$$e900$$ENDHEX$$e automatiquement lors de la lecture du     */
/* fichier INI. Cette valeur est utilis$$HEX1$$e900$$ENDHEX$$e pour savoir si les mises  */
/* $$HEX2$$e0002000$$ENDHEX$$jour sont autoris$$HEX1$$e900$$ENDHEX$$es sur le serveur FileNet.                   */
/*------------------------------------------------------------------*/
Return ( iiAutoriserMiseaJour )

end function

public function integer uf_connectersql (boolean abactiver, string asfichierini);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_FileNet::Uf_ConnecterSql (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 08/02/2000 16:40:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va se connecter $$HEX2$$e0002000$$ENDHEX$$la base de donn$$HEX1$$e900$$ENDHEX$$es FileNet (en mode SQL)
//*
//* Arguments		: (Val)	Boolean	abActiver		Connection/D$$HEX1$$e900$$ENDHEX$$connection
//*					  (Val)	String	asFichierIni	Fichier de param$$HEX1$$e800$$ENDHEX$$tres
//*
//* Retourne		: Integer				 1 = Tout est OK
//*												-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Integer iRet = 1
Long lRet

/*------------------------------------------------------------------*/
/* On veut activer une connection. On v$$HEX1$$e900$$ENDHEX$$rifie qu'une connection ne  */
/* soit pas d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$active. On instancie l'objet de transaction, et    */
/* on effectue la connection. Si celle-ci n'aboutie pas, on         */
/* d$$HEX1$$e900$$ENDHEX$$truit l'instance.                                              */
/*------------------------------------------------------------------*/
If	abActiver	Then
	If	Not ibInitSql	Then
		lRet = Uf_InitialiserSql ( asFichierIni )
		If	lRet <> 0	Then 
			DESTROY	itrFileNet			
			ibInitSql = FALSE
			iRet = -1
		Else
			ibInitSql = TRUE
/*------------------------------------------------------------------*/
/* Dans la sauvegarde d'un document de type OTHER, il faut          */
/* obligatoirement sp$$HEX1$$e900$$ENDHEX$$cifier le nom de la classe en dur. On le      */
/* r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re maintenant par SELECT au lieu de le positionner dans    */
/* le fichier INI.                                                  */
/*------------------------------------------------------------------*/
			isClassName = Trim ( This.uf_GetClassName ( iiClassNumber ) )
		End If
	End If
Else
/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$sactive la connection $$HEX2$$e0002000$$ENDHEX$$la base de donn$$HEX1$$e900$$ENDHEX$$es. On teste la     */
/* validit$$HEX2$$e9002000$$ENDHEX$$de l'objet de transaction.                              */
/*------------------------------------------------------------------*/
	If	ibInitSql	Then
		DISCONNECT USING itrFilenet	;
		ibInitSql = FALSE
		DESTROY	itrFileNet
	End If
End If

Return ( iRet )






end function

private function long uf_initialisersql (string asfichierini);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_FileNet::uf_InitialiserSql (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 08/02/2000 15:56:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On initialise les fonctionnalit$$HEX1$$e900$$ENDHEX$$es SQL de l'objet FileNet
//*
//* Arguments		: (Val)		String	asFichierIni
//*
//* Retourne		: Long				 0 = Tout est OK
//*											-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sNomTransaction, sNomBase, sErreur, sLibCourtAppli
Long lRet

itrFileNet 	= CREATE U_Transaction
lRet			= -1

/*------------------------------------------------------------------*/
/* Si le fichier de configuration existe, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les valeurs   */
/* dans la section FileNet SQL. Ces valeurs vont permettre de se    */
/* connecter $$HEX2$$e0002000$$ENDHEX$$la base de donn$$HEX1$$e900$$ENDHEX$$es.                                  */
/*------------------------------------------------------------------*/
sNomTransaction 	= stGLB.sCodOper + "/" + "N$$HEX2$$b0002000$$ENDHEX$$IP"
sLibCourtAppli		= stGLB.sLibCourtAppli
sNomBase				= "FileNet SQL"

If	F_ConnectSqlServer ( asFichierIni, sNomBase, itrFileNet, sErreur, sLibCourtAppli, sNomTransaction )	Then lRet = 0
	
/*------------------------------------------------------------------*/
/* On va r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le ClassNumber qui est obligatoirement           */
/* positionn$$HEX2$$e9002000$$ENDHEX$$dans le fichier INI. Si ce n'est pas le cas la        */
/* valeur de ClassNumber est arm$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$-1 ce qui emp$$HEX1$$ea00$$ENDHEX$$che toute        */
/* r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de documents.                                       */
/*------------------------------------------------------------------*/
iiClassNumber = ProfileInt ( asFichierIni, sNomBase, "ClassNumber", -1 )
/*------------------------------------------------------------------*/
/* On va r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le nom de la table correspondant $$HEX2$$e0002000$$ENDHEX$$la            */
/* DistributorQueue, qui est obligatoirement positionn$$HEX2$$e9002000$$ENDHEX$$dans le     */
/* fichier INI.                                                     */
/*------------------------------------------------------------------*/
isNomQueue = ProfileString ( asFichierIni, sNomBase, "WorkSpace", "" )
/*------------------------------------------------------------------*/
/* On charge la variable d'instance iiAutoriserMiseaJour.           */
/*------------------------------------------------------------------*/
This.uf_SetAutoriserMiseaJour ()

Return ( lRet )
end function

private function string uf_getclassname (long alClassNumber);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_FileNe::Uf_GetClassName	(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 22/02/2000 17:20:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Renvoie le nom de la CLASSE de document
//*
//* Arguments		: (Val)		Long	alClassNumber	Identifiant de la CLASSE
//*
//* Retourne		: String			Nom de la CLASSE
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sNomClasse

/*------------------------------------------------------------------*/
/* On envoi un simple SELECT sur la table f_sw.document_class.      */
/*------------------------------------------------------------------*/
SELECT	f_sw.document_class.f_docclassname
INTO		:sNomClasse
FROM		f_sw.document_class
WHERE		f_sw.document_class.f_docclassnumber = :alClassNumber
USING		itrFileNet		;

If	itrFileNet.SqlCode <> 0	Or itrFileNet.SqlDbCode <> 0 Then
	sNomClasse = ""
End If

Return ( sNomClasse )





end function

on destructor;//*-----------------------------------------------------------------
//*
//* Objet			: N_Cst_FileNet
//* Evenement 		: Destructor
//* Auteur			: Erick John Stark
//* Date				: 08/02/2000 16:00:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long 
//*				  
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

If	IsValid ( itrFileNet )	Then 
	DISCONNECT USING itrFileNet ;
	DESTROY itrFileNet
End If

If	IsValid ( iOleFnLibrary )	Then
	iOleFnLibrary.Logoff ()
	DESTROY iOleFnLibrary
End If

If	IsValid ( iOleFnViewer )	Then
	iOleFnViewer.Quit ()
	DESTROY iOleFnViewer
End If


end on

on n_cst_filenet.create
TriggerEvent( this, "constructor" )
end on

on n_cst_filenet.destroy
TriggerEvent( this, "destructor" )
end on

