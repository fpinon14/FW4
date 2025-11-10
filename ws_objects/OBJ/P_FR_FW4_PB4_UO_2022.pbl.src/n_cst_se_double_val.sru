HA$PBExportHeader$n_cst_se_double_val.sru
forward
global type n_cst_se_double_val from nonvisualobject
end type
end forward

global type n_cst_se_double_val from nonvisualobject
end type
global n_cst_se_double_val n_cst_se_double_val

type variables
public:
	Constant integer K_OK=1
	Constant integer K_ANNULE=0
	
	Constant integer K_ERR_NIVEAU_REQUIS = -1
	Constant integer K_ERR_SAISIE = -2
	Constant integer K_ERR_DROIT_INSUFFISANT = -3
	Constant integer K_ERR_NIVEAU_INCONNU = -4
	Constant integer K_ERR_PROCURATION_INCONNU=-5
	Constant integer K_ERR_HISTO = -6
	Constant integer K_ERR_OPER_INCONNU = -7
	
	Constant integer K_ERR_INITALISATION=-8
	
	Constant integer K_ERR_LIRE_UO=-9
	Constant integer K_ERR_LIRE_MONTANT=-10
	Constant integer K_ERR_RESPONSABLE_IWD=-11
	
private:

n_se_connect invTransaction

// transaction	itrAppliDv
u_transaction	itrAppliDv // [PI056][TRANCOUNT][JFF][24/01/2020]

datastore idsNiveaux

decimal idcMtAVerser

boolean ibHistoConf=FALSE
integer iiversion=1 // .... [Pm114] Version de la matrice
end variables

forward prototypes
public function integer uf_crypter (ref string aschaine, boolean abswitch)
private function string uf_gettrigrammeprocuration (integer aipole, integer ainiveau)
public function integer uf_checkpassword (string astrigramme, string aspassword)
public function integer uf_init (string asinifile, string assection, ref transaction atrappli, ref string aserreurtxt)
public function integer uf_controler (string astrigramme, integer aipole, double admontant, long aldossier, ref string aserreurtxt)
public function integer uf_historiser (long aldossier, double admontant, string astrigramme, string asprocuration, string asmessage)
public function integer uf_lireuo (long alidprod)
public function integer uf_doublevalidationok (string astrigramme, any aaidsinistre, any aaidproduit, string asfichierini, ref transaction atrtrans, ref string asretour)
public function string uf_getlibniveau (integer ainiveau)
public subroutine uf_setmtaverser (decimal adcmontant)
public function string uf_histo_conf (long alidsin, integer aiidniveau)
public function integer uf_historiser (long aldossier, double admontant, integer ainiveau, s_se_params axparams)
public function decimal uf_liremontant (long alidsinistre, ref decimal admttotal, ref boolean aberror)
private function integer uf_controler_v2 (string astrigramme, integer aipole, decimal admontant, long aldossier, ref string aserreurtxt)
private function integer uf_maj_responsable_iwd (long aldossier, integer alniveaurequis)
private function integer uf_controler_v3 (string astrigramme, integer aipole, decimal admontant, long aldossier, ref string aserreurtxt)
end prototypes

public function integer uf_crypter (ref string aschaine, boolean abswitch);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Crypter
//* Acc$$HEX1$$e800$$ENDHEX$$s			: Public
//* Auteur			: Fabry JF
//* Date				: 13/09/1999 15:43:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cryptage d'une cha$$HEX1$$ee00$$ENDHEX$$ne de caract$$HEX1$$e800$$ENDHEX$$re 
//* Commentaires	: La cha$$HEX1$$ee00$$ENDHEX$$ne retourn$$HEX1$$e900$$ENDHEX$$e peut $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$crite sur une base SQLSERVER,
//*					  et contient un caract$$HEX1$$e800$$ENDHEX$$re de plus que la cha$$HEX1$$ee00$$ENDHEX$$ne pass$$HEX1$$e900$$ENDHEX$$e en argument.
//*                 
//*
//* Arguments		: String			asChaine					(R$$HEX1$$e900$$ENDHEX$$f)		   Chaine de caract$$HEX1$$e800$$ENDHEX$$res sans limite de taille
//*					  String			abSwitch					(Val)       True : Cryptage, False : D$$HEX1$$e900$$ENDHEX$$cryptage
//*																					
//*
//* Retourne		: Integer		1	->	 Cha$$HEX1$$ee00$$ENDHEX$$ne Crypt$$HEX1$$e900$$ENDHEX$$e/D$$HEX1$$e900$$ENDHEX$$crypt$$HEX1$$e900$$ENDHEX$$e avec Succ$$HEX1$$e800$$ENDHEX$$s
//*										-1 ->  La cha$$HEX1$$ee00$$ENDHEX$$ne pass$$HEX1$$e900$$ENDHEX$$e en argument est vide
//*										-2 ->  Erreur de cryptage, un des caract$$HEX1$$e800$$ENDHEX$$res de la cha$$HEX1$$ee00$$ENDHEX$$ne pass$$HEX1$$e900$$ENDHEX$$e
//*												 en argument n'est pas compris dans la plage d$$HEX1$$e900$$ENDHEX$$finie.
//*														
//*												 En cas d'erreur la cha$$HEX1$$ee00$$ENDHEX$$ne pass$$HEX1$$e900$$ENDHEX$$e en argument est retourn$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$l'identique. 
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* SBA			23/10/2009	[SESAME_PWD]1.1.5	  Appel au uf_crypter ad$$HEX1$$e900$$ENDHEX$$quate
//*-----------------------------------------------------------------

//[SESAME_PWD].1.1.5
String 			sObjClassName
Int				    iRet
n_cst_crypter 	lnvCrypter

iRet = -1

if IsValid(stGlb) then
	sObjClassName = ProfileString ( stGlb.sfichierini , "APPLICATION", "CRYPTER_CLASSNAME","n_cst_crypter_base64" )
	lnvCrypter = create using sObjClassName
end if	

iRet = lnvCrypter.uf_crypter(aschaine,abswitch)

destroy ( lnvCrypter )

return iRet


////*-----------------------------------------------------------------
////*
////* Fonction		: uf_Crypter
////* Acc$$HEX1$$e800$$ENDHEX$$s			: Public
////* Auteur			: Fabry JF
////* Date				: 13/09/1999 15:43:46
////* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cryptage d'une cha$$HEX1$$ee00$$ENDHEX$$ne de caract$$HEX1$$e800$$ENDHEX$$re 
////* Commentaires	: La cha$$HEX1$$ee00$$ENDHEX$$ne retourn$$HEX1$$e900$$ENDHEX$$e peut $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$crite sur une base SQLSERVER,
////*					  et contient un caract$$HEX1$$e800$$ENDHEX$$re de plus que la cha$$HEX1$$ee00$$ENDHEX$$ne pass$$HEX1$$e900$$ENDHEX$$e en argument.
////*                 
////*
////* Arguments		: String			asChaine					(R$$HEX1$$e900$$ENDHEX$$f)		   Chaine de caract$$HEX1$$e800$$ENDHEX$$res sans limite de taille
////*					  String			abSwitch					(Val)       True : Cryptage, False : D$$HEX1$$e900$$ENDHEX$$cryptage
////*																					
////*
////* Retourne		: Integer		1	->	 Cha$$HEX1$$ee00$$ENDHEX$$ne Crypt$$HEX1$$e900$$ENDHEX$$e/D$$HEX1$$e900$$ENDHEX$$crypt$$HEX1$$e900$$ENDHEX$$e avec Succ$$HEX1$$e800$$ENDHEX$$s
////*										-1 ->  La cha$$HEX1$$ee00$$ENDHEX$$ne pass$$HEX1$$e900$$ENDHEX$$e en argument est vide
////*										-2 ->  Erreur de cryptage, un des caract$$HEX1$$e800$$ENDHEX$$res de la cha$$HEX1$$ee00$$ENDHEX$$ne pass$$HEX1$$e900$$ENDHEX$$e
////*												 en argument n'est pas compris dans la plage d$$HEX1$$e900$$ENDHEX$$finie.
////*														
////*												 En cas d'erreur la cha$$HEX1$$ee00$$ENDHEX$$ne pass$$HEX1$$e900$$ENDHEX$$e en argument est retourn$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$l'identique. 
////*-----------------------------------------------------------------
////* MAJ PAR		Date		Modification
////*				  
////*-----------------------------------------------------------------
//
///*------------------------------------------------------------------*/
///* Plage de caract$$HEX1$$e800$$ENDHEX$$res pouvant $$HEX1$$ea00$$ENDHEX$$tre cod$$HEX1$$e900$$ENDHEX$$e.								  */
///*------------------------------------------------------------------*/
//Constant Int K_BORNMIN	  = 32   // Borne ASCII Minimum
//Constant Int K_BORNMAX	  = 124  // Borne ASCII Maximum
//
//Int		iRet = 1 	  				// Retour
//Int		iCle			  				// Valeur de cl$$HEX1$$e900$$ENDHEX$$
//Int		iMilChaine    				// Milieu de la cha$$HEX1$$ee00$$ENDHEX$$ne
//Int		iVal, iVal2, iVal3 	  	// Valeurs enti$$HEX1$$e800$$ENDHEX$$res
//Int		iCpt			  				// Compteur entier
//Int		iSeconde						// Seconde en cours
//Long		lCpt			  				// Compteur Long
//String	sCopChaine[]  				// Copie de la Chaine pass$$HEX1$$e900$$ENDHEX$$e en argument en 2 tableau
//String	sCarCle		  				// Symbole repr$$HEX1$$e900$$ENDHEX$$sentant la cl$$HEX1$$e900$$ENDHEX$$
//
//
///*------------------------------------------------------------------*/
///* La cha$$HEX1$$ee00$$ENDHEX$$ne ne doit pas $$HEX1$$ea00$$ENDHEX$$tre vide.											  */
///*------------------------------------------------------------------*/
//If asChaine = "" Then iRet = -1
//
///*------------------------------------------------------------------*/
///* CRYPTAGE de la Cha$$HEX1$$ee00$$ENDHEX$$ne														  */
///*------------------------------------------------------------------*/
//If abSwitch then
//
//
//	// Tous les caract$$HEX1$$e800$$ENDHEX$$res doivent $$HEX1$$ea00$$ENDHEX$$tre dans la plage d$$HEX1$$e900$$ENDHEX$$finie.
//	iVal = Len ( asChaine ) 
//	For lCpt = 1 to iVal
//	
//		iVal2 = Asc ( Mid ( asChaine, lCpt, 1) )
//		If iVal2 < K_BORNMIN or iVal2 > K_BORNMAX Then
//			iRet = -2
//			Exit
//		End If
//	
//	Next
//
//	
//	If iRet = 1 Then
//	
//		// D$$HEX1$$e900$$ENDHEX$$termination de la cl$$HEX1$$e900$$ENDHEX$$
//		iSeconde = Integer ( Right ( String ( Now () ), 1 ) )
//		If iSeconde < 4 Then	
//			iCle = ( K_BORNMAX - K_BORNMIN ) / 4
//		ElseIf iSeconde > 3 and iSeconde < 7 Then	
//			iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 2
//		ElseIf iSeconde > 6 and iSeconde < 10 Then
//			iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 3
//		End If
//	
//		
//		// D$$HEX1$$e900$$ENDHEX$$termination du Symbole qui repr$$HEX1$$e900$$ENDHEX$$sentra la cl$$HEX2$$e9002000$$ENDHEX$$dans la future chaine crypt$$HEX1$$e900$$ENDHEX$$e
//		Randomize ( 0 )
//		sCarcle = ""
//		Do While sCarCle = "" 
//			iVal = Rand ( K_BORNMAX - K_BORNMIN ) + K_BORNMIN
//	
//			If ( iCle = ( K_BORNMAX - K_BORNMIN ) / 4 )         and ( iVal >= K_BORNMIN and iVal <= K_BORNMIN + 30  ) Or & 
//				( iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 2 ) and ( iVal > K_BORNMIN + 30 and iVal <= K_BORNMIN + 60  ) Or & 
//				( iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 3 ) and ( iVal > K_BORNMIN + 60  ) Then  
//				
//				sCarCle = Char ( iVal )
//				
//			End If
//		Loop
//		
//		
//		// D$$HEX1$$e900$$ENDHEX$$coupage de la cha$$HEX1$$ee00$$ENDHEX$$ne en deux
//		iMilChaine = Int ( Len ( asChaine ) / 2 )
//		sCopChaine [1] = Left ( asChaine, iMilChaine )
//		sCopChaine [2] = Right ( asChaine, Len ( asChaine) - iMilChaine )
//		
//		asChaine = ""
//
//		// Cryptage des caract$$HEX1$$e800$$ENDHEX$$res		
//		For iVal = 2 to 1 Step -1
//			
//			iVal2 = Len ( sCopChaine [ iVal ] )
//			For lCpt = 1 to iVal2
//	
//				If Mod ( lCpt, 2 ) = 0 then
//					iVal3 = Asc ( Mid ( sCopChaine [ iVal ], lcpt, 1 ) ) + iCle
//	
//					If iVal3 > K_BORNMAX Then
//						iVal3 = ( iVal3 - K_BORNMAX ) + K_BORNMIN - 1
//					End If
//	
//				Else
//					iVal3 = Asc ( Mid ( sCopChaine [ iVal ], lcpt, 1 ) ) - iCle
//	
//					If iVal3 < K_BORNMIN Then
//						iVal3 = K_BORNMAX - ( K_BORNMIN - iVal3 ) + 1
//					End If
//	
//				End If
//				
//				
//				asChaine = asChaine + Char ( iVal3 )
//				
//			Next
//			
//			// On ajoute la cl$$HEX4$$e9002000e0002000$$ENDHEX$$la fin de la premi$$HEX1$$e800$$ENDHEX$$re cha$$HEX1$$ee00$$ENDHEX$$ne
//			If iVal = 2 Then
//				asChaine = asChaine + sCarCle
//			End If
//			
//		Next
//	
//	End If
//
//End If
//
//
//
///*------------------------------------------------------------------*/
///* DECRYPTAGE de la Cha$$HEX1$$ee00$$ENDHEX$$ne														  */
///*------------------------------------------------------------------*/
//If Not abSwitch then
//	
//	// D$$HEX1$$e900$$ENDHEX$$coupage de la cha$$HEX1$$ee00$$ENDHEX$$ne en deux
//	iVal = Len ( asChaine ) 
//	If Mod ( iVal, 2 ) = 0 Then
//		iMilChaine = ( Len ( asChaine ) / 2 ) + 1
//	Else
//		iMilChaine = Int ( Len ( asChaine ) / 2 ) + 1
//	End If
//
//	// Recherche du caract$$HEX1$$e800$$ENDHEX$$re symbolisant la cl$$HEX2$$e9002000$$ENDHEX$$cach$$HEX1$$e900$$ENDHEX$$e
//	sCarCle = Mid ( asChaine, iMilChaine, 1 )
//	
//	sCopChaine [1] = Right ( asChaine, Len ( asChaine) - iMilChaine )
//	
//	// -1 car on enl$$HEX1$$e800$$ENDHEX$$ve la cl$$HEX1$$e900$$ENDHEX$$
//	sCopChaine [2] = Left ( asChaine, iMilChaine - 1 )
//	
//	asChaine = ""
//
//	// D$$HEX1$$e900$$ENDHEX$$chiffrage du symbole de cl$$HEX2$$e9002000$$ENDHEX$$afin d'en extraire la cl$$HEX2$$e9002000$$ENDHEX$$elle-m$$HEX1$$ea00$$ENDHEX$$me.
//	iVal = Asc ( sCarCle )
//	If iVal >= K_BORNMIN and iVal <= K_BORNMIN + 30  Then	
//		iCle = ( K_BORNMAX - K_BORNMIN ) / 4
//	ElseIf iVal > K_BORNMIN + 30 and iVal <= K_BORNMIN + 60 Then	
//		iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 2
//	ElseIf iVal > K_BORNMIN + 60   Then
//		iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 3
//	End If
//
//
//	// D$$HEX1$$e900$$ENDHEX$$cryptage des caract$$HEX1$$e800$$ENDHEX$$res
//	For iVal = 1 to 2 
//		
//		iVal2 = Len ( sCopChaine [ iVal ] )
//		For lCpt = 1 to iVal2
//
//			If Mod ( lCpt, 2 ) = 0 then
//				iVal3 = Asc ( Mid ( sCopChaine [ iVal ], lcpt, 1 ) ) - iCle
//
//				If iVal3 < K_BORNMIN Then
//					iVal3 = K_BORNMAX - ( K_BORNMIN - iVal3 ) + 1
//				End If
//
//			Else
//				iVal3 = Asc ( Mid ( sCopChaine [ iVal ], lcpt, 1 ) ) + iCle
//
//				If iVal3 > K_BORNMAX Then
//					iVal3 = ( iVal3 - K_BORNMAX ) + K_BORNMIN - 1
//				End If
//
//			End If
//			
//			asChaine = asChaine + Char ( iVal3 )
//			
//		Next
//		
//	Next
//
//		
//End If
//
//Return iRet
end function

private function string uf_gettrigrammeprocuration (integer aipole, integer ainiveau);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_gettrigrammeprocuration
//* Auteur			: F. Pinon
//* Date				: 22/07/2008 11:48:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le trigramme utilis$$HEX2$$e9002000$$ENDHEX$$pour la procuration
//* Commentaires	: 
//*
//* Arguments		: value integer aipole	 */
/* 	value integer ainiveau	 */
//*
//* Retourne		: le trigramme, NULL s'il n'en existe aucun
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

datastore dsOperUo
string sTrigramme

SetNull(sTrigramme)

dsOperUo=CREATE datastore
dsOperUo.DataObject="d_se_operateur_uo"
dsOperUo.SetTransObject(invTransaction)
IF invTransaction.SQLCode <> 0 THEN goto fin

dsOperUo.Retrieve()
IF invTransaction.SQLCode <> 0 THEN goto fin

dsOperUo.SetFilter("membre=1 and id_niveau=" + string(aiNiveau) + &
	"and id_uo=" + string(aiPole))
	
if dsOperUo.Filter() = -1 then goto fin

if dsOperUo.RowCount() > 0 then
	sTrigramme=dsOperUo.getitemstring(1,"id_oper")
end if

fin:
DESTROY dsOperUo

Return sTrigramme

end function

public function integer uf_checkpassword (string astrigramme, string aspassword);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_checkpassword
//* Auteur			: F. Pinon
//* Date				: 22/07/2008 13:36:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string astrigramme	 */
/* 	value string aspassword	 */
//*
//* Retourne		: 0 NOK, 1 OK, -1 utilisateur introuvable	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

datastore dsOper
integer iResult=-1
string sPassOperateur

// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des infos du trigramme
dsOper=CREATE datastore
dsOper.DataObject="d_se_operateur"

dsOper.SetTransObject(invTransaction)
IF SQLCA.SQLCode <> 0 THEN goto fin

dsOper.Retrieve(astrigramme)
IF SQLCA.SQLCode < 0 THEN goto fin

if dsOper.RowCount() > 0 then
	// Comparaison des mots de passe
	sPassOperateur=dsOper.getitemstring(1,"passe")
	uf_crypter(sPassOperateur,FALSE)
	
	If date(dsOper.getitemdatetime(1,"date_fin_passe")) < Today() Then
		// Mot de passe expir$$HEX1$$e900$$ENDHEX$$
		iResult=0
		goto fin
	end if
	
	if IsValid(stGlb) then
		if ProfileString ( stGlb.sfichierini , "APPLICATION", "CRYPTER_CLASSNAME","n_cst_crypter_base64" ) = "n_cst_crypter_base64" then
			sPassOperateur = upper ( sPassOperateur )
		end if					
	end if	
	
	//messagebox("pass d$$HEX1$$e900$$ENDHEX$$crypt$$HEX1$$e900$$ENDHEX$$",sPassOperateur+ " "+aspassword)	// DEBUG

	if Trim(sPassOperateur) <>  Trim(aspassword) then
		iResult=0
	else
		iResult=1
	end if
end if

fin:
DESTROY dsOper

Return iResult



end function

public function integer uf_init (string asinifile, string assection, ref transaction atrappli, ref string aserreurtxt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_init
//* Auteur			: F. Pinon
//* Date				: 18/07/2008 13:38:21
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asinifile	 */
/* 	value string assection	 */
/*		ref	transaction atrAppli */
/* 	ref   string asErreurTxt */
//*
//* Retourne		: 1 si OK,	-1 si mauvais param$$HEX1$$e800$$ENDHEX$$tres, 
//*					 -2 erreur de lecture du fichier INI
//*                -3 erreur de connexion $$HEX2$$e0002000$$ENDHEX$$la base SESAME
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 FPI	 19/09/2008	  Ajout de la cl$$HEX2$$e9002000$$ENDHEX$$"DOUBLE_VALIDATION_CONF" 
//*								  dans le fichier INI
//* #2	FPI	09/09/2009	[ACTIVEDIRECTORY] Utilisation de compte Windows pour la connexion aux bases
//			FPI/FS 25/08/2010	[SECURE_CNX] D$$HEX1$$e900$$ENDHEX$$cryptage dans of_connect
//* #3   FS     28/03/2011 [pm114] Double validation : lecture de la version
//* [MCO584]  FS 12/06/2024 Evolution des matrices de double validation
//*-----------------------------------------------------------------

integer iRet
String  sVal // ... [pm114]
Long lValeurCleMco584 // ... [MCO584]

iRet=invTransaction.uf_init(asIniFile,asSection)

if iRet=1 then

	// uf_crypter(invTransaction.LogPass,FALSE) // [SECURE_CNX]
	
	// #2 - [ACTIVEDIRECTORY]
	/*	connect using invTransaction;
	iRet=invTransaction.SQLCode*/
	
	iRet = invTransaction.of_connect( )
	// Fin #2 - [ACTIVEDIRECTORY]
	
	if iRet=-1 then 
		asErreurTxt = string(invTransaction.SQLDbCode) + " : " + &
			invTransaction.SQLErrText
		iRet=-3
	else
		idsNiveaux=CREATE datastore
		idsNiveaux.DataObject="d_se_code"
		idsNiveaux.setTransObject(invTransaction)
		idsNiveaux.Retrieve('-NV',-1)
	end if
	
end if

// #1
ibHistoConf=(ProfileString(asInifile,"APPLICATION","DOUBLE_VALIDATION_CONF","0") = "1")

itrAppliDv=atrAppli

/*---------------------------------------------------------------*/
/* #3 [pm114] lecture de la version / par d$$HEX1$$e900$$ENDHEX$$faut vesion = 1      */
/*---------------------------------------------------------------*/

	sVal = ProfileString (asInifile,"APPLICATION","DOUBLE_VALIDATION_VERSION","1" )
	
	If isNumber( sVal ) Then
		iiversion = integer( sVal)
	Else
		iiversion = 1
	End If
	
// ... [MCO584] Debut de modification : Lecture de la cl$$HEX2$$e9002000$$ENDHEX$$[MCO584] sur SESAME

		Select valeur 
		Into   :lValeurCleMco584  
		From   sysadm.cle
		Where  id_cle = "MCO584"
		Using invTransaction;

		If IsNull ( lValeurCleMco584 ) Then lValeurCleMco584 = 0 
		If lValeurCleMco584 > 0 Then iiversion = 3	

return iRet
end function

public function integer uf_controler (string astrigramme, integer aipole, double admontant, long aldossier, ref string aserreurtxt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_controler
//* Auteur			: F. Pinon
//* Date				: 18/07/2008 15:15:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string astrigramme	 */
/* 	value integer aiPole	 */
/* 	value double admontant	 */
/* 	value long alDossier */
/* 	ref string aserreurtxt	 */
//*
//* Retourne		: K_OK Validation autoris$$HEX1$$e900$$ENDHEX$$e
//*				     K_ANNULE  Clic sur Annuler
//*					  K_ERR_NIVEAU_REQUIS niveau insuffisant
//*					  K_ERR_SAISIE Erreur de saisie du trigramme/mot de passe
//*					  K_ERR_DROIT_INSUFFISANT "Vous n'avez pas les droits pour le niveau"
//*					  K_ERR_NIVEAU_INCONNU Impossible de d$$HEX1$$e900$$ENDHEX$$terminer le niveau requis
//*					  K_ERR_PROCURATION_INCONNU Impossible de trouver un trigramme de procuration
//*					  K_ERR_HISTO Erreur d'historisation
//*					  K_ERR_OPER_INCONNU Utilisateur inexistant
//*
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 FPI   19/09/2008   Ajout de la validation automatique
//*-----------------------------------------------------------------
integer iIdNiveauRequis, iIdNiveauOper, iIdNiveauAcces
s_se_params xParams
string sOperSubstit=space(4) // Allocation pour l'appel de la proc$$HEX1$$e900$$ENDHEX$$dure stock$$HEX1$$e900$$ENDHEX$$e
boolean bPopWindow //#1

// *** R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du niveau requis
if invTransaction.PS_S01_NIVEAU_REQUIS_V01(aipole, adMontant, iIdNiveauRequis) = 0 Then
	aserreurtxt="Impossible de d$$HEX1$$e900$$ENDHEX$$terminer le niveau requis"
	return K_ERR_NIVEAU_INCONNU
end if

// Pour le niveau 0, pas de double validation
if iIdNiveauRequis = 0 Then return 1 

// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du niveau du trigramme pour ce p$$HEX1$$f400$$ENDHEX$$le
if invTransaction.PS_S01_NIVEAU_OPERATEUR_V01(aipole, asTrigramme, &
	iIdNiveauAcces, iIdNiveauOper, sOperSubstit) = 0 Then Return K_ERR_OPER_INCONNU

// #1 - Test de validation pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente
bPopWindow = TRUE

if ibHistoConf then
	bPopWindow=(uf_histo_conf( aldossier, iIdNiveauRequis) = "N")
end if
// Fin #1

// *** Niveau suffisant ?
// Si on a coch$$HEX2$$e9002000$$ENDHEX$$"Ne plus poser la question" pour ce niveau, c'est OK.
if bPopWindow Then // #1
If (iIdNiveauRequis < 3 or iIdNiveauAcces < 2)  and iIdNiveauRequis > iIdNiveauAcces then 
	aserreurtxt = uf_getlibniveau(iIdNiveauRequis) 
	return K_ERR_NIVEAU_REQUIS
end if
end if// #1

// Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de saisie en fonction du niveau requis
xParams.isvaleurstr[1] = astrigramme
SetNull(xParams.isvaleurstr[2])
xParams.iivaleurint[1] = iIdNiveauRequis
xParams.iivaleurint[2] = iIdNiveauOper
xParams.isvaleurstr[3] = ""
xParams.isvaleurstr[4] = uf_getlibniveau(iIdNiveauRequis) 

// #1 - Test de validation pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente
if bPopWindow Then
	xParams.isvaleurstr[6] = ""
	if ibHistoConf Then xParams.isvaleurstr[6]="N"
// Fin #1

If iIdNiveauRequis > 2 and iIdNiveauRequis > iIdNiveauOper then
	// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du trigramme de procuration
	xParams.isvaleurstr[2] = uf_getTrigrammeProcuration(aiPole,iIdNiveauRequis)
	if isnull(xParams.isvaleurstr[2]) Then 
		aserreurtxt="Aucun trigramme n'est param$$HEX1$$e900$$ENDHEX$$tr$$HEX2$$e9002000$$ENDHEX$$pour le niveau " + string(iIdNiveauRequis) + &
			" de l'UO " + string(aipole)
		return K_ERR_PROCURATION_INCONNU
	end if
end if

if iIdNiveauAcces > iIdNiveauOper then
	xParams.isvaleurstr[5]=astrigramme + " Acting Manager de " + sOperSubstit + " : "
end if

// *** Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de double validation
OpenWithParm(w_se_double_val,xParams)
xParams=Message.PowerObjectParm

if xParams.iiValeurInt[2] = 0 then return 0 // Clic sur Annuler

// *** V$$HEX1$$e900$$ENDHEX$$rification du trigramme/Mot de passe
if uf_checkpassword(xParams.isvaleurstr[1],xParams.isvaleurstr[3]) <> 1 then
	return K_ERR_SAISIE
end if

// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du niveau du trigramme saisi dans la fen$$HEX1$$ea00$$ENDHEX$$tre pour ce p$$HEX1$$f400$$ENDHEX$$le
invTransaction.PS_S01_NIVEAU_OPERATEUR_V01(aipole, xParams.isvaleurstr[1],iIdNiveauAcces, iIdNiveauOper,sOperSubstit)

// *** V$$HEX1$$e900$$ENDHEX$$rification de l'autorisation
If (iIdNiveauRequis < 3 or iIdNiveauAcces < 2)  and iIdNiveauRequis > iIdNiveauAcces then 
	aserreurtxt = string(iIdNiveauRequis)
	return K_ERR_DROIT_INSUFFISANT
end if

// #1
Else
	xParams.isvaleurstr[4] = "Validation automatique"
	xParams.isvaleurstr[6] = "A"
end if
// Fin #1

//*** Historisation
/*if uf_historiser(alDossier, admontant, xParams.isvaleurstr[1], &
		xParams.isvaleurstr[2],xParams.isvaleurstr[4]) < 0 Then */
if uf_historiser(alDossier, admontant, iIdNiveauRequis, &
		xParams) < 0 Then //#1
	aserreurtxt="Erreur d'historisation de la double validation du dossier"
	return K_ERR_HISTO
end if
	

Return K_OK
end function

public function integer uf_historiser (long aldossier, double admontant, string astrigramme, string asprocuration, string asmessage);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_historiser
//* Auteur			: F. Pinon
//* Date				: 23/07/2008 10:04:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Effectue l'historisation de la validation
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 1 OK, K_ERR_HISTO sinon
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

DECLARE my_proc PROCEDURE FOR sysadm.PS_I01_HISTO_VALIDATION_V01
	@iIdSin=:alDossier, @dMontant=:admontant, @sValidePar=:asTrigramme, 
	@sCompte=:asProcuration, @sMessage=:asMessage USING itrAppliDv;

EXECUTE my_proc;

if itrAppliDv.SQLCode < 0 Then 
	return K_ERR_HISTO
end if
	
CLOSE my_proc ;

Return 1
end function

public function integer uf_lireuo (long alidprod);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_lireuo
//* Auteur			: F. Pinon
//* Date				: 01/08/2008 09:10:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value long alidprod	 */
//*
//* Retourne		: id_uo correspondant, 	K_ERR_LIRE_UO si pas trouv$$HEX1$$e900$$ENDHEX$$
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

integer iIdUo
datastore dsLireUo

iIdUo=-1

dsLireUo=CREATE datastore
dsLireUo.DataObject="d_se_lire_uo"
dsLireUo.SetTransObject(itrAppliDv)
IF itrAppliDv.SQLCode <> 0 THEN goto fin

dsLireUo.Retrieve(alidprod)
IF itrAppliDv.SQLCode <> 0 THEN goto fin

if dsLireUo.RowCount() > 0 then
	iIdUo=dsLireUo.getitemnumber(1,1)
end if

fin:
DESTROY dsLireUo


Return iIdUo
end function

public function integer uf_doublevalidationok (string astrigramme, any aaidsinistre, any aaidproduit, string asfichierini, ref transaction atrtrans, ref string asretour);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_doublevalidationok
//* Auteur			: F. Pinon
//* Date				: 25/07/2008 14:04:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string astrigramme	 */
/* 	value any aaidsinistre	 */
/* 	value string asfichierini	 */
/* 	ref transaction atrtrans	 */
/* 	ref string asretour	 */
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 FPI	08/10/2008    Correction : changement de signature de uf_liremontant
//* #2	 FPI	12/12/2008    Correction : Le montant $$HEX2$$e0002000$$ENDHEX$$verser est n$$HEX1$$e900$$ENDHEX$$gatif -> OK
//* #3     FS  28/03/2011    [pm114-double validation] Prise en compte de la version
//* [MCO584] FS le 12/06/2024 Nouvelle version de fonctionnement ( niveaux et montant )
//*-----------------------------------------------------------------

integer iRet
integer iIdPole
decimal dMontant, dMtTotal
long lIdSinistre
long lIdProduit
boolean bError

// Initialisation
iRet=uf_init(asFichierIni,"SESAME BASE",atrTrans,asRetour)
Choose case iRet
   Case -1 
      asRetour="Erreur de param$$HEX1$$e800$$ENDHEX$$tres (fichier ou section inexistant)"
      return K_ERR_INITALISATION
   Case -2 
      asRetour="Erreur de lecture du fichier INI"
      return K_ERR_INITALISATION
   Case -3
      asRetour="Erreur de connexion $$HEX2$$e0002000$$ENDHEX$$la base de donn$$HEX1$$e900$$ENDHEX$$es~n~n"+asRetour
      return K_ERR_INITALISATION
end choose

// Conversion
lIdSinistre=long(aaIdSinistre)
lIdProduit=long(String(aaIdProduit))

// Lecture du p$$HEX1$$f400$$ENDHEX$$le
iIdPole = uf_lireUo(lIdProduit)
if iIdPole < 0 then return K_ERR_LIRE_UO

// Lecture du montant
dMontant=uf_lireMontant(lIdSinistre, dMtTotal,bError)
//if dMontant < 0 then return K_ERR_LIRE_MONTANT
if bError Then return K_ERR_LIRE_MONTANT // FPI - 08/10/2008

//if dMontant = 0 then return K_OK // Montant = 0, OK. 
// #2 
if dMontant <= 0 then return K_OK // Montant = 0, OK. 

// Contr$$HEX1$$f400$$ENDHEX$$le
// [pm114] Prise en compte de la version

If iiversion = 2 Then
	
	iRet=uf_controler_v2(asTrigramme, iIdPole, dMtTotal, lIdSinistre,asRetour)
	
ElseIf iiVersion = 3 Then
	
	/* [MCO584] Appel $$HEX2$$e0002000$$ENDHEX$$la nouvelle version V3 : Escalade simple, pas de substitution des libell$$HEX1$$e900$$ENDHEX$$s*/	
	iRet=uf_controler_v3(asTrigramme, iIdPole, dMtTotal, lIdSinistre,asRetour)
		
Else

	iRet=uf_controler(asTrigramme, iIdPole, dMtTotal, lIdSinistre,asRetour)
End If


return iRet
end function

public function string uf_getlibniveau (integer ainiveau);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_getlibniveau
//* Auteur			: F. Pinon
//* Date				: 07/08/2008 13:25:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value integer ainiveau	 */
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
integer iRow
string sResult

iRow=idsNiveaux.Find("id_code=" + string(aiNiveau),1,idsNiveaux.RowCount())
if iRow < 1 then return ""

sResult=idsNiveaux.GetItemString(iRow,"lib_code")

sResult=Lower(left(sResult,1)) + Mid(sResult,2)

return sResult



end function

public subroutine uf_setmtaverser (decimal adcmontant);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_setmtaverser
//* Auteur			: F. Pinon
//* Date				: 03/09/2008 14:27:53
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value decimal adcmontant	 */
//*
//* Retourne		: (none)	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

idcmtaverser=adcmontant
end subroutine

public function string uf_histo_conf (long alidsin, integer aiidniveau);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_histo_conf
//* Auteur			: F. Pinon
//* Date				: 19/09/2008 13:51:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value long alidsin	 */
/* 	value integer aiidniveau	 */
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------


string sRet
datastore dsHistoConf

sRet="N"

dsHistoConf=CREATE datastore
dsHistoConf.DataObject="d_se_histo_conf"
dsHistoConf.SetTransObject(itrAppliDv)
IF itrAppliDv.SQLCode <> 0 THEN goto fin

dsHistoConf.Retrieve(alIdSin,aiIdNiveau)
IF itrAppliDv.SQLCode <> 0 THEN goto fin

if dsHistoConf.RowCount() > 0 then
	sRet=dsHistoConf.getitemstring(1,1)
end if

fin:
DESTROY dsHistoConf


Return sRet
end function

public function integer uf_historiser (long aldossier, double admontant, integer ainiveau, s_se_params axparams);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_historiser
//* Auteur			: F. Pinon
//* Date				: 23/07/2008 10:04:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Effectue l'historisation de la validation
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: 1 OK, K_ERR_HISTO sinon
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

DECLARE my_proc PROCEDURE FOR sysadm.PS_I01_HISTO_VALIDATION_V02
	@iIdSin=:alDossier, @dMontant=:admontant, 
	@sValidePar=:axParams.isvaleurstr[1], 
	@sCompte=:axParams.isvaleurstr[2], 
	@sMessage=:axParams.isvaleurstr[4],
	@iIdNiveau=:aiNiveau,
	@sAltConf=:axParams.isvaleurstr[6]
	USING itrAppliDv;

EXECUTE my_proc;

if itrAppliDv.SQLCode < 0 Then 
	return K_ERR_HISTO
end if
	
CLOSE my_proc ;

Return 1
end function

public function decimal uf_liremontant (long alidsinistre, ref decimal admttotal, ref boolean aberror);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_liremontant
//* Auteur			: F. Pinon
//* Date				: 01/08/2008 09:27:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value long alidsinistre	 
//							ref  double adMtTotal*/
//*
//* Retourne		: le montant du dossier, -1 sinon
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1    FPI    08/10/2008  Utilisation de abError car dcMontant peut $$HEX1$$ea00$$ENDHEX$$tre <0 
//*-----------------------------------------------------------------

decimal dcMontant
datastore dsLireMontant

abError=TRUE
//dcMontant=-1

dsLireMontant=CREATE datastore
dsLireMontant.DataObject="d_se_lire_montant"
dsLireMontant.SetTransObject(itrAppliDv)
IF itrAppliDv.SQLCode <> 0 THEN goto fin

dsLireMontant.Retrieve(alidsinistre)
IF itrAppliDv.SQLCode <> 0 THEN goto fin

if dsLireMontant.RowCount() > 0 then
	dcMontant=dsLireMontant.getitemdecimal(1,"mt_a_verser")
	adMtTotal=dsLireMontant.getitemdecimal(1,"mt_total")
	
	if not isnull(idcmtaverser) then
		adMtTotal=adMtTotal - dcMontant + idcmtaverser
		dcMontant=idcmtaverser
	end if
	abError=FALSE
end if

fin:
DESTROY dsLireMontant

Return dcMontant
end function

private function integer uf_controler_v2 (string astrigramme, integer aipole, decimal admontant, long aldossier, ref string aserreurtxt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_controler_v2
//* Auteur			: FS
//* Date				: 24/01/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le De la double validation version 2
//* Commentaires	: 
//*
//* Arguments		: value string astrigramme	 */
/* 	value integer aiPole	 */
/* 	value double admontant	 */
/* 	value long alDossier */
/* 	ref string aserreurtxt	 */
//*
//* Retourne		: K_OK Validation autoris$$HEX1$$e900$$ENDHEX$$e
//*				     K_ANNULE  Clic sur Annuler
//*					  K_ERR_NIVEAU_REQUIS niveau insuffisant
//*					  K_ERR_SAISIE Erreur de saisie du trigramme/mot de passe
//*					  K_ERR_DROIT_INSUFFISANT "Vous n'avez pas les droits pour le niveau"
//*					  K_ERR_NIVEAU_INCONNU Impossible de d$$HEX1$$e900$$ENDHEX$$terminer le niveau requis
//*					  K_ERR_PROCURATION_INCONNU Impossible de trouver un trigramme de procuration
//*					  K_ERR_HISTO Erreur d'historisation
//*					  K_ERR_OPER_INCONNU Utilisateur inexistant
//*
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 FPI   19/09/2008   Ajout de la validation automatique
//* #2    FS    20/11/2013   [PM217-2] Mise $$HEX2$$e0002000$$ENDHEX$$jour de la table update_iwd
//*-----------------------------------------------------------------

s_se_params xParams
string sOperSubstit=space(4) // Allocation pour l'appel de la proc$$HEX1$$e900$$ENDHEX$$dure stock$$HEX1$$e900$$ENDHEX$$e
boolean bPopWindow //#1

datastore dsLireNiv
long      lNb
long      lret
integer   iIdNiveauRequis  // ... Niveau minimal requis
integer   iIdNiveauOper    // ... Niveau r$$HEX1$$e900$$ENDHEX$$el de l'op$$HEX1$$e900$$ENDHEX$$rateur
integer   iIdNiveauAcces   // ... Niveau obtenu pour l'op$$HEX1$$e900$$ENDHEX$$rateur ( procuration )
String    sFind
Integer iCle


/*------------------------------------------------------------------------*/
/* Lecture des niveaux requis                                             */
/*------------------------------------------------------------------------*/

	// *** R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du niveau requis

	if invTransaction.PS_S01_NIVEAU_REQUIS_V02(aipole, adMontant, iIdNiveauRequis) = 0 Then
		aserreurtxt="Impossible de d$$HEX1$$e900$$ENDHEX$$terminer le niveau requis"
		return K_ERR_NIVEAU_INCONNU
	end if

/*------------------------------------------------------------------------*/
/* Pour le niveau 10, pas de double validation                            */
/*------------------------------------------------------------------------*/

	//	iIdNiveauRequis = dsLireNiv.GetItemNumber ( 1, "ID_NIVEAU" )
	
	if iIdNiveauRequis = 10 Then return 1 

/*------------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du niveau du trigramme pour ce p$$HEX1$$f400$$ENDHEX$$le                       */
/*------------------------------------------------------------------------*/

if invTransaction.PS_S01_NIVEAU_OPERATEUR_V01(aipole, asTrigramme, &
	iIdNiveauAcces, iIdNiveauOper, sOperSubstit) = 0 Then Return K_ERR_OPER_INCONNU
	
/*------------------------------------------------------------------------*/
/* Le niveau est-il suffisant ?                                           */
/*------------------------------------------------------------------------*/

	//    NiveauRequis   > Niveau Obtenu    Et  Niveau acces < Rdsc

	/* [Pm114] retour de recette
	
	   La fusion pour les nuls :garder le tronc !
		-----------------------
	
	  If ( iIdNiveauRequis > iIdNiveauAcces ) And iIdNiveauAcces  < 35 Then 
		*/
		
	If ( iIdNiveauRequis > iIdNiveauAcces ) And ( iIdNiveauAcces < 35 Or iIdNiveauAcces = 40) Then 
		
		
		/* Attention la lecture du niveau requis rend le plus petit niveau
		   donc si niveau 40 (rd) la lecture nous donne 35 (rdsc)
		*/
		
		If iIdNiveauRequis = 35 Then
			// ... Si le niveau requis = 35 Rdsc on pr$$HEX1$$e900$$ENDHEX$$cise que le niveau doit $$HEX1$$ea00$$ENDHEX$$tre le 40 RD ou le 35 Rdsc				
			aserreurtxt = uf_getlibniveau(40) 
			
		ElseIf iIdNiveauRequis = 50 Then
			// ... Si le niveau requis = 50 Rdta on pr$$HEX1$$e900$$ENDHEX$$cise que le niveau doit $$HEX1$$ea00$$ENDHEX$$tre le 50 Rdta ou le 35 Rdsc				
			aserreurtxt = char(10) + uf_getlibniveau(50) + char(10) + 'ou' + char(10) + uf_getlibniveau(35) 
		Else
			aserreurtxt = uf_getlibniveau(iIdNiveauRequis) 
		End If
		
		// [PM217-2]
		/* [PM217-2] Mise $$HEX2$$e0002000$$ENDHEX$$jour du niveau requis sur update_iwd */
		This.uf_maj_responsable_iwd( aldossier, iIdNiveauRequis )
		// :[PM217-2]
		
		return K_ERR_NIVEAU_REQUIS

	End If


/*------------------------------------------------------------------------*/
/* Niveau OK : Saisie trigramme + mot de passe                            */
/*------------------------------------------------------------------------*/

	// ... Y a t-il eu une validatin pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente enregistr$$HEX1$$e900$$ENDHEX$$e pour le niveau requis ?
	//     (Si on a coch$$HEX2$$e9002000$$ENDHEX$$"Ne plus poser la question" pour ce niveau, c'est OK.)

	bPopWindow = TRUE
	
	if ibHistoConf then bPopWindow=(uf_histo_conf( aldossier, iIdNiveauRequis) = "N")


// Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de saisie en fonction du niveau requis
xParams.isvaleurstr[1] = astrigramme
SetNull(xParams.isvaleurstr[2])
xParams.iivaleurint[1] = iIdNiveauRequis
xParams.iivaleurint[2] = iIdNiveauOper
xParams.isvaleurstr[3] = ""


If iIdNiveauRequis = 35 Then
	xParams.isvaleurstr[4] = uf_getlibniveau(40) 
Else
	xParams.isvaleurstr[4] = uf_getlibniveau(iIdNiveauRequis) 
End If

/*------------------------------------------------------------------------*/
/* Le niveau insuffisant ! mais DSC                                       */
/*------------------------------------------------------------------------*/

	If iIdNiveauRequis = 50 And iIdNiveauAcces = 35 Then 		// ... Rdsc pour le compte du Rdta
		
		xParams.isvaleurstr[2] = uf_getlibniveau(50)
	
	ElseIf iIdNiveauRequis = 40 And iIdNiveauAcces = 35 Then	// ... Rdsc pour le compte du Rdept
		
		xParams.isvaleurstr[2] = uf_getlibniveau(40)
		
	End If

/*------------------------------------------------------------------------*/
/* v$$HEX1$$e900$$ENDHEX$$rification si validation pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente                                  */
/*------------------------------------------------------------------------*/

if bPopWindow Then
	xParams.isvaleurstr[6] = ""
	if ibHistoConf Then xParams.isvaleurstr[6]="N"

	// ...Indication si le niveau obtenu est supp$$HEX1$$e900$$ENDHEX$$rieur au niveau r$$HEX1$$e900$$ENDHEX$$el de l'op$$HEX1$$e900$$ENDHEX$$rateur 
	
	if iIdNiveauAcces > iIdNiveauOper then
		xParams.isvaleurstr[5]=astrigramme + " Acting Manager de " + sOperSubstit + " : "
	end if

	// ... Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de double validation
	
	OpenWithParm(w_se_double_val,xParams)
	xParams=Message.PowerObjectParm

	if xParams.iiValeurInt[2] = 0 then return 0 // Clic sur Annuler

	// ... V$$HEX1$$e900$$ENDHEX$$rification du trigramme/Mot de passe
	
	if uf_checkpassword(xParams.isvaleurstr[1],xParams.isvaleurstr[3]) <> 1 then
		return K_ERR_SAISIE
	end if

	// ... R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du niveau du trigramme saisi dans la fen$$HEX1$$ea00$$ENDHEX$$tre pour ce p$$HEX1$$f400$$ENDHEX$$le

	invTransaction.PS_S01_NIVEAU_OPERATEUR_V01(aipole, xParams.isvaleurstr[1],iIdNiveauAcces, iIdNiveauOper,sOperSubstit)

	// ... V$$HEX1$$e900$$ENDHEX$$rification de l'autorisation

	If ( iIdNiveauRequis > iIdNiveauAcces ) And ( iIdNiveauRequis <> 50 And iIdNiveauAcces <> 35 ) Then 
		return K_ERR_DROIT_INSUFFISANT
	End If


Else
	xParams.isvaleurstr[4] = "Validation automatique"
	xParams.isvaleurstr[6] = "A"
end if


// ... Historisation

if uf_historiser(alDossier, admontant, iIdNiveauRequis, &
		xParams) < 0 Then //#1
	aserreurtxt="Erreur d'historisation de la double validation du dossier"
	return K_ERR_HISTO
end if
	

Return K_OK
end function

private function integer uf_maj_responsable_iwd (long aldossier, integer alniveaurequis);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_maj_responsable_iwd
//* Auteur			: FS
//* Date				: 20/11/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Maj du niveau requis pour la double validation
//* Commentaires	: [PM217-2] Ecriture sur w_queue.responsable_iwd
//*
//* Arguments		: 
//*
//* Retourne		: 1 OK, K_ERR_RESPONSABLE_IWD(-11) sinon
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

DECLARE my_proc PROCEDURE FOR sysadm.Iwd_Update_Iwd_Niveau_Dbval  
	@iIdSin=:alDossier, @iNiveau_dbval=:alNiveauRequis
	USING itrAppliDv;

EXECUTE my_proc;

if itrAppliDv.SQLCode < 0 Then 
//	Rollback USING itrAppliDv;
	F_COMMIT ( itrAppliDv, FALSE ) // [PI056][TRANCOUNT][JFF][24/01/2020]

	return K_ERR_RESPONSABLE_IWD
end if
	
// Commit using itrAppliDv;
	F_COMMIT ( itrAppliDv, TRUE ) // [PI056][TRANCOUNT][JFF][24/01/2020]

CLOSE my_proc ;

Return 1
end function

private function integer uf_controler_v3 (string astrigramme, integer aipole, decimal admontant, long aldossier, ref string aserreurtxt);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_se_double_val::uf_controler_v3
//* Auteur			: FS
//* Date			: 17/06/2024
//* Date			: [MOC-584] Cr$$HEX2$$e900e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$partir de uf_controler_v2
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Contr$$HEX1$$f400$$ENDHEX$$le De la double validation version 3
//* Commentaires	: 
//*
//* Arguments		: value string astrigramme	 */
/* 	value integer aiPole	 */
/* 	value double admontant	 */
/* 	value long alDossier */
/* 	ref string aserreurtxt	 */
//*
//* Retourne		: K_OK Validation autoris$$HEX1$$e900$$ENDHEX$$e
//*				     K_ANNULE  Clic sur Annuler
//*					  K_ERR_NIVEAU_REQUIS niveau insuffisant
//*					  K_ERR_SAISIE Erreur de saisie du trigramme/mot de passe
//*					  K_ERR_DROIT_INSUFFISANT "Vous n'avez pas les droits pour le niveau"
//*					  K_ERR_NIVEAU_INCONNU Impossible de d$$HEX1$$e900$$ENDHEX$$terminer le niveau requis
//*					  K_ERR_PROCURATION_INCONNU Impossible de trouver un trigramme de procuration
//*					  K_ERR_HISTO Erreur d'historisation
//*					  K_ERR_OPER_INCONNU Utilisateur inexistant
//*
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* #1	 FPI   19/09/2008   Ajout de la validation automatique
//* #2    FS    20/11/2013   [PM217-2] Mise $$HEX2$$e0002000$$ENDHEX$$jour de la table update_iwd
//* [MCO584]  FS 12/06/2024 Evolution des matrices de double validation : Version V3
//*-----------------------------------------------------------------

s_se_params xParams
string sOperSubstit=space(4) // Allocation pour l'appel de la proc$$HEX1$$e900$$ENDHEX$$dure stock$$HEX1$$e900$$ENDHEX$$e
boolean bPopWindow //#1

datastore dsLireNiv
long      lNb
long      lret
integer   iIdNiveauRequis  // ... Niveau minimal requis
integer   iIdNiveauOper    // ... Niveau r$$HEX1$$e900$$ENDHEX$$el de l'op$$HEX1$$e900$$ENDHEX$$rateur
integer   iIdNiveauAcces   // ... Niveau obtenu pour l'op$$HEX1$$e900$$ENDHEX$$rateur ( procuration )
String    sFind
Integer iCle


/*------------------------------------------------------------------------*/
/* Lecture des niveaux requis                                             */
/*------------------------------------------------------------------------*/

	// *** R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du niveau requis

	if invTransaction.PS_S01_NIVEAU_REQUIS_V02(aipole, adMontant, iIdNiveauRequis) = 0 Then
		aserreurtxt="Impossible de d$$HEX1$$e900$$ENDHEX$$terminer le niveau requis"
		return K_ERR_NIVEAU_INCONNU
	end if

/*------------------------------------------------------------------------*/
/* Pour le niveau 10, pas de double validation                            */
/*------------------------------------------------------------------------*/

	//	iIdNiveauRequis = dsLireNiv.GetItemNumber ( 1, "ID_NIVEAU" )
	
	if iIdNiveauRequis = 10 Then return 1 

/*------------------------------------------------------------------------*/
/* R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du niveau du trigramme pour ce p$$HEX1$$f400$$ENDHEX$$le                       */
/*------------------------------------------------------------------------*/

if invTransaction.PS_S01_NIVEAU_OPERATEUR_V01(aipole, asTrigramme, &
	iIdNiveauAcces, iIdNiveauOper, sOperSubstit) = 0 Then Return K_ERR_OPER_INCONNU
	
/*------------------------------------------------------------------------*/
/* Le niveau est-il suffisant ?                                           */
/*------------------------------------------------------------------------*/

	//    NiveauRequis   > Niveau Obtenu    Et  Niveau acces < Rdsc

	/* [Pm114] retour de recette
	
	   La fusion pour les nuls :garder le tronc !
		-----------------------
	
	  If ( iIdNiveauRequis > iIdNiveauAcces ) And iIdNiveauAcces  < 35 Then 
		*/

	/* [MCO584] prise en compte simplement du niveau requis  */
	/* [MCO584] avant :  If ( iIdNiveauRequis > iIdNiveauAcces ) And ( iIdNiveauAcces < 35 Or iIdNiveauAcces = 40) Then  */
	
	If ( iIdNiveauRequis > iIdNiveauAcces ) Then 
		
		/* [MCO584] prise en compte simplement du niveau requis  */
			aserreurtxt = uf_getlibniveau(iIdNiveauRequis) 
		
		/* [PM217-2] Mise $$HEX2$$e0002000$$ENDHEX$$jour du niveau requis sur update_iwd */
			This.uf_maj_responsable_iwd( aldossier, iIdNiveauRequis )
	
		return K_ERR_NIVEAU_REQUIS

	End If

/*------------------------------------------------------------------------*/
/* Niveau OK : Saisie trigramme + mot de passe                            */
/*------------------------------------------------------------------------*/

	// ... Y a t-il eu une validatin pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente enregistr$$HEX1$$e900$$ENDHEX$$e pour le niveau requis ?
	//     (Si on a coch$$HEX2$$e9002000$$ENDHEX$$"Ne plus poser la question" pour ce niveau, c'est OK.)

	bPopWindow = TRUE
	
	if ibHistoConf then bPopWindow=(uf_histo_conf( aldossier, iIdNiveauRequis) = "N")


// Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de saisie en fonction du niveau requis
xParams.isvaleurstr[1] = astrigramme
SetNull(xParams.isvaleurstr[2])
xParams.iivaleurint[1] = iIdNiveauRequis
xParams.iivaleurint[2] = iIdNiveauOper
xParams.isvaleurstr[3] = ""


If iIdNiveauRequis = 35 Then
	xParams.isvaleurstr[4] = uf_getlibniveau(40) 
Else
	xParams.isvaleurstr[4] = uf_getlibniveau(iIdNiveauRequis) 
End If

/*------------------------------------------------------------------------*/
/* Le niveau insuffisant ! mais DSC                                       */
/*------------------------------------------------------------------------*/
/* [MCO584] non c'est fini ce truc : xParams.isvaleurstr[2] sera null

	If iIdNiveauRequis = 50 And iIdNiveauAcces = 35 Then 		// ... Rdsc pour le compte du Rdta
		
		xParams.isvaleurstr[2] = uf_getlibniveau(50)
	
	ElseIf iIdNiveauRequis = 40 And iIdNiveauAcces = 35 Then	// ... Rdsc pour le compte du Rdept
		
		xParams.isvaleurstr[2] = uf_getlibniveau(40)
		
	End If
*/

/*------------------------------------------------------------------------*/
/* v$$HEX1$$e900$$ENDHEX$$rification si validation pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$dente                                  */
/*------------------------------------------------------------------------*/

if bPopWindow Then
	xParams.isvaleurstr[6] = ""
	if ibHistoConf Then xParams.isvaleurstr[6]="N"

	// ...Indication si le niveau obtenu est supp$$HEX1$$e900$$ENDHEX$$rieur au niveau r$$HEX1$$e900$$ENDHEX$$el de l'op$$HEX1$$e900$$ENDHEX$$rateur 
	
	if iIdNiveauAcces > iIdNiveauOper then
		xParams.isvaleurstr[5]=astrigramme + " Acting Manager de " + sOperSubstit + " : "
	end if

	// ... Ouverture de la fen$$HEX1$$ea00$$ENDHEX$$tre de double validation
	
	OpenWithParm(w_se_double_val,xParams)
	xParams=Message.PowerObjectParm

	if xParams.iiValeurInt[2] = 0 then return 0 // Clic sur Annuler

	// ... V$$HEX1$$e900$$ENDHEX$$rification du trigramme/Mot de passe
	
	if uf_checkpassword(xParams.isvaleurstr[1],xParams.isvaleurstr[3]) <> 1 then
		return K_ERR_SAISIE
	end if

	// ... R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du niveau du trigramme saisi dans la fen$$HEX1$$ea00$$ENDHEX$$tre pour ce p$$HEX1$$f400$$ENDHEX$$le

	invTransaction.PS_S01_NIVEAU_OPERATEUR_V01(aipole, xParams.isvaleurstr[1],iIdNiveauAcces, iIdNiveauOper,sOperSubstit)

	// ... V$$HEX1$$e900$$ENDHEX$$rification de l'autorisation

	If ( iIdNiveauRequis > iIdNiveauAcces ) And ( iIdNiveauRequis <> 50 And iIdNiveauAcces <> 35 ) Then 
		return K_ERR_DROIT_INSUFFISANT
	End If


Else
	xParams.isvaleurstr[4] = "Validation automatique"
	xParams.isvaleurstr[6] = "A"
end if


// ... Historisation

if uf_historiser(alDossier, admontant, iIdNiveauRequis, &
		xParams) < 0 Then //#1
	aserreurtxt="Erreur d'historisation de la double validation du dossier"
	return K_ERR_HISTO
end if
	

Return K_OK
end function

on n_cst_se_double_val.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_se_double_val.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//*-----------------------------------------------------------------
//*
//* Objet			: n_cst_se_double_val
//* Evenement 		: constructor
//* Auteur			: F. Pinon
//* Date				: 18/07/2008 13:36:05
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
//* 
//*-----------------------------------------------------------------

invTransaction=CREATE n_se_connect 
SetNull(idcMtAVerser)
end event

event destructor;//*-----------------------------------------------------------------
//*
//* Objet			: n_cst_se_double_val
//* Evenement 		: destructor
//* Auteur			: F. Pinon
//* Date				: 18/07/2008 13:35:55
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
//* 
//*-----------------------------------------------------------------

If isValid(idsNiveaux) then DESTROY idsNiveaux

If isValid(invTransaction) then 
	disconnect using invTransaction;
	DESTROY invTransaction
end if
end event

