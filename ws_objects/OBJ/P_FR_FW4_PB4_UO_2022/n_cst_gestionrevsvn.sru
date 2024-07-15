HA$PBExportHeader$n_cst_gestionrevsvn.sru
$PBExportComments$Composant de gestion des r$$HEX1$$e900$$ENDHEX$$visions SVN
forward
global type n_cst_gestionrevsvn from nonvisualobject
end type
end forward

global type n_cst_gestionrevsvn from nonvisualobject autoinstantiate
end type

forward prototypes
public function boolean uf_bverifrevisionsvn (string scodeappli, string snumrevision, boolean bmodecnx)
protected function integer uf_envoimail_erreur_es (integer icodeerr, ref u_transaction atrans, string sappliname)
public function integer uf_maj_auto_bornesappli (ref u_transaction atrans, string asappliname, long alnumrev)
end prototypes

public function boolean uf_bverifrevisionsvn (string scodeappli, string snumrevision, boolean bmodecnx);//*----------------------------------------------------------------- 
//*
//* Objet 			: n_cst_gestionRevSvn
//* Evenement 		: uf_bVerifRevisionSvn
//* Auteur			: LBP
//* Date				: 09/07/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: V$$HEX1$$e900$$ENDHEX$$rifie que la revision courante de l'application soit conforme aux bornes
//						   d$$HEX1$$e900$$ENDHEX$$finies dans la table application, alerte en cas de probl$$HEX1$$e800$$ENDHEX$$me.
//*					   Cf. Spec fournies par mail PHG le 09/07/2010
//						   Retourne si l'application peut continuer son fonctionnement normal ou non
//*
//* Param$$HEX1$$e800$$ENDHEX$$tres		:
//*						VAL	string 	sCodeAppli		:	Code de l'application
//*						VAL	string 	sNumRevision	:	Numero de rev de l'application courante
//*						VAL	boolean 	bmodecnx		:	Precise si l'utilisateur est conenct$$HEX2$$e9002000$$ENDHEX$$en mode CNX
//*
//*Retour			: 
//*						Retourne si l'application peut continuer son fonctionnement normal ou non
//*
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ 						PAR		Date				Modification	  
//* [Recup vers SVN]		LBP		09/07/2010		Controle de la r$$HEX1$$e900$$ENDHEX$$vision SVN
//*							FPI		21/09/2010		[ITSM45850] On supprime le message informatif
//* [DEMANDE JFF] 		LBP		21/10/2010		Au lieu de d'envoyer un mail a ES on met a jour la borne de l'appli automatiquement
//*-----------------------------------------------------------------
u_Transaction ltrTrans
boolean bContinue
long lRet
long lNumRevAppli
long lNumRevMin , lNumRevMax
DataStore	dsRevSvnAppli
boolean bErr
integer iMajBorneAuto

// Par def pas d'erreur
bErr = False

// Par d$$HEX1$$e900$$ENDHEX$$faut on continue
bContinue = True

// En mode Cnx on continue sans effectuer aucun test
If bModeCnx Then
	Return True
End If

// Teste si le numero de rev a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$lu correctement
If Not isnumber(snumrevision) Then
	// Pour l'instant une non lecture du num de r$$HEX1$$e900$$ENDHEX$$vision n'emp$$HEX1$$e800$$ENDHEX$$che pas le 
	// fonctionnement de l'appli
	Return True
End If

// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le num de r$$HEX1$$e900$$ENDHEX$$vision de l'appli au format int
lNumRevAppli = long(snumrevision)


// Connection a la base Sesame
ltrTrans = Create u_transaction
If Not f_ConnectSqlServer ( stGLB.sFichierIni, "SESAME BASE", ltrTrans, stGLB.sMessageErreur,stGlb.slibcourtappli, stGlb.sCodOper ) Then
	MessageBox ( "Erreur", stGLB.sMessageErreur )
	Disconnect Using ltrTrans ;
	Destroy ltrTrans
	bContinue = False
End If

// Init de la DW de recup des rev SVN
dsRevSvnAppli = CREATE DataStore
dsRevSvnAppli.DataObject = "d_stk_revsvn_application"
dsRevSvnAppli.SetTransObject ( ltrTrans )
lRet = dsRevSvnAppli.Retrieve ( stGLB.sCodAppli )

// Lecture des rev SVN
If lRet = 1 Then
	
	// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re les rev min & max de l'application en cours
	lNumRevMin = dsRevSvnAppli.getitemnumber( 1, "rev_svn_min")
	lNumRevMax = dsRevSvnAppli.getitemnumber( 1, "rev_svn_max")
	
	// Controle de la nullit$$HEX2$$e9002000$$ENDHEX$$des bornes
	If IsNull(lNumRevMax) or IsNull(lNumRevMin) Then
		
		// Les bornes sont incoherentes
		uf_EnvoiMail_Erreur_ES (2, ltrTrans, stGLB.sCodAppli)
		
		// Autorisation de continuer
		bContinue = True
		
		// Set du Flag d'erreur
		bErr = True
	End If		
	
	// Controle de la coherence des bornes
	If Not bErr Then
		// Controle de la coherence des bornes
		If lNumRevMax < lNumRevMin Then
			
			// Les bornes sont incoherentes
			uf_EnvoiMail_Erreur_ES (0, ltrTrans, stGLB.sCodAppli)
			
			// Autorisation de continuer
			bContinue = True
			
			// Set du Flag d'erreur
			bErr = True
		End If
	End If
		
	If Not bErr Then
		// Cas 1 : Rev courante sous la rev Mini, interdiction de continuer
		//			 et message demandant de red$$HEX1$$e900$$ENDHEX$$marrer application
		If lNumRevAppli <  lNumRevMin Then
			// Message d'avertissement utilisateur	
			stMessage.sCode		= "REV001"
			stMessage.sTitre		= "Controle de version"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= True
			stMessage.bTrace		= True
			
			// Affichage du message
			F_Message(stMessage)
	
			// Reset du code du message affich$$HEX2$$e9002000$$ENDHEX$$pour eviter les effets de bords
			stMessage.sCode = ""
	
			// Interdiction de continuer
			bContinue = False
			
		// Cas 2 : Rev courante sup$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la rev Mini mais inf$$HEX1$$e900$$ENDHEX$$rieure $$HEX2$$e0002000$$ENDHEX$$la r$$HEX1$$e900$$ENDHEX$$vision MAX
		//			 L'op$$HEX1$$e900$$ENDHEX$$rateur peut continuer mais on lui signale qu'il devrait red$$HEX1$$e900$$ENDHEX$$marrer son application
		ELseIf lNumRevAppli >=  lNumRevMin And lNumRevAppli < lNumRevMax Then
			/* [ITSM45850] 
			// Message d'avertissement utilisateur	
			stMessage.sCode		= "REV002"
			stMessage.sTitre		= "Controle de version"
			stMessage.Icon			= Information!
			stMessage.bErreurG	= True
			stMessage.bTrace		= True
			
			// Affichage du message
			F_Message(stMessage)
			*/
			
			// Autorisation de continuer
			bContinue = True
		
			// Reset du code du message affich$$HEX2$$e9002000$$ENDHEX$$pour eviter les effets de bords
			stMessage.sCode = ""
			
		// Cas 3 : Rev courante = $$HEX2$$e0002000$$ENDHEX$$la rev Max, rien $$HEX2$$e0002000$$ENDHEX$$faire, l'utilisateur peut continuer
		ELseIf lNumRevAppli =  lNumRevMax Then
			
			// Autorisation de continuer
			bContinue = True		
	
		// Cas 4 : Rev courante > $$HEX2$$e0002000$$ENDHEX$$la rev Max, erreur de mise $$HEX2$$e0002000$$ENDHEX$$jour des num$$HEX1$$e900$$ENDHEX$$ros de r$$HEX1$$e900$$ENDHEX$$visions
		//			 de l'application lors de la MEP, on continue mais on envoie un mail $$HEX2$$e0002000$$ENDHEX$$ES
		ELseIf lNumRevAppli >  lNumRevMax Then
			
			// Envoi de mail $$HEX2$$e0002000$$ENDHEX$$ES : La borne max de l'appli n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$mise $$HEX2$$e0002000$$ENDHEX$$jour
			
			// [DEMANDE JFF] Au lieu de d'envoyer un mailon met a jour la borne de l'appli automatiquement
			// et ce ssi la clef AUTO_MAJ_BORNES_SVN vaut 1 
			
			//uf_EnvoiMail_Erreur_ES (1, ltrTrans, stGLB.sCodAppli)
			iMajBorneAuto = ProfileInt ( stGLB.sFichierIni, "APPLICATION", "AUTO_MAJ_BORNES_SVN", 0)
			
			If iMajBorneAuto > 0 Then
				uf_MAJ_Auto_BornesAppli (ltrTrans, stGLB.sCodAppli, lNumRevAppli)
			End If
			
			// Autorisation de continuer
			bContinue = True		
		// Err (les bornes sont $$HEX2$$e0002000$$ENDHEX$$null)
		Else
			
			// La r$$HEX1$$e900$$ENDHEX$$vision courante est nulle
			uf_EnvoiMail_Erreur_ES (4, ltrTrans, stGLB.sCodAppli)
		
			// Autorisation de continuer
			bContinue = True
		End If
	End If
Else
	
	// Pas le bon nbre de ligne r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$
	uf_EnvoiMail_Erreur_ES (3, ltrTrans, stGLB.sCodAppli)
	
	// Autorisation de continuer
	bContinue = True
	
End if

// Suppression du DS cr$$HEX2$$e900e900$$ENDHEX$$
Destroy dsRevSvnAppli

// Deconnexion de la base Sesame
Disconnect Using ltrTrans ;
Destroy ltrTrans

return bContinue
end function

protected function integer uf_envoimail_erreur_es (integer icodeerr, ref u_transaction atrans, string sappliname);//*----------------------------------------------------------------- 
//*
//* Objet 			: n_cst_GestionRevSvn
//* Evenement 		: uf_envoimail_erreur_es
//* Auteur			: LBP
//* Date				: 09/07/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Envoi un mail $$HEX2$$e0002000$$ENDHEX$$Etude sinistre pour signaler que la gestion des revisions SVN d'une application 
//*					  est en echec
//						  
//*
//* Param$$HEX1$$e800$$ENDHEX$$tres		:
//*						VAL	integer 	icodeerr			:	Code de l'err surevenue
//*						REF	string 	u_transaction	:	Transaction de connexion $$HEX2$$e0002000$$ENDHEX$$la base SESAME
//*						VAL	string 	sappliname		:	Nom de l'application
//*						
//*
//*Retour			: 
//*						Retourne toujours 1
//*
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ 						PAR		Date				Modification	  
//* [Recup vers SVN]		LBP		09/07/2010		Controle de la r$$HEX1$$e900$$ENDHEX$$vision SVN
//*
//*-----------------------------------------------------------------


string sTo
string sTextBody
string sSql
string sSubject
string sCc
string sFrom
Long lRet

// Appel $$HEX2$$e0002000$$ENDHEX$$la PS pour v$$HEX1$$e900$$ENDHEX$$rifier si un mail a d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$envoy$$HEX2$$e9002000$$ENDHEX$$dans la journ$$HEX1$$e900$$ENDHEX$$e
lRet = atrans.DW_S01_MAIL_SVN_SEND ()
//atrans.commit

// V$$HEX1$$e900$$ENDHEX$$rifie que le mail n'a pas d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$envoy$$HEX1$$e900$$ENDHEX$$
If lRet = 0 Then
	
	sTo = 'etudessinistres@spb.eu'
	sCc =''
	sFrom = sAppliName + '@spb.eu'
	sSubject = 'Echec de la v$$HEX1$$e900$$ENDHEX$$rification des bornes de r$$HEX1$$e900$$ENDHEX$$vision SVN'
	
	Choose Case icodeerr
		case 0	// Les bornes sont incoherentes
			sTextBody = 'Les bornes de v$$HEX1$$e900$$ENDHEX$$rification des r$$HEX1$$e900$$ENDHEX$$visions SVN sont incoh$$HEX1$$e900$$ENDHEX$$rentes.~r~n~r~n'
		case 1	// La borne max de l'appli n'a pas $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$mise $$HEX2$$e0002000$$ENDHEX$$jour
			sTextBody = 'Une connexion a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$e avec un numero de r$$HEX1$$e900$$ENDHEX$$vision SVN sup$$HEX1$$e900$$ENDHEX$$rieur $$HEX2$$e0002000$$ENDHEX$$celui d$$HEX1$$e900$$ENDHEX$$clar$$HEX2$$e9002000$$ENDHEX$$en base de donn$$HEX1$$e900$$ENDHEX$$es.~r~n~r~n'
		case 2	// Une des deux bornes (ou les deux) sont nulles
			sTextBody = 'La borne Min et/ou la borne Max de v$$HEX1$$e900$$ENDHEX$$rification des r$$HEX1$$e900$$ENDHEX$$visions SVN est nulle.~r~n~r~n'
		case 3	// Pas le bon nbre de ligne r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$
			sTextBody = 'Echec de lecture des bornes de r$$HEX1$$e900$$ENDHEX$$vision SVN.~r~n~r~n'
		case 4	// Pas le bon nbre de ligne r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$
			sTextBody = 'La r$$HEX1$$e900$$ENDHEX$$vision courante de l application est nulle.~r~n~r~n'
	End choose
	
	// Ajout d'une petite pr$$HEX1$$e900$$ENDHEX$$cision d'aide
	sTextBody = sTextBody + 'Cette erreur est probablement due $$HEX2$$e0002000$$ENDHEX$$une mauvaise mise $$HEX2$$e0002000$$ENDHEX$$jour des bornes de r$$HEX1$$e900$$ENDHEX$$vision SVN autoris$$HEX1$$e900$$ENDHEX$$es '
	sTextBody = sTextBody + 'pour l application courante (cf. table application de la base SESAME).~r~n~r~n'
	
	// Ajout du nom de l'appli concern$$HEX1$$e900$$ENDHEX$$e
	sTextBody = sTextBody + '  Code application concern$$HEX1$$e900$$ENDHEX$$e : ' + sAppliName
	
	sSql = "Exec sysadm.PS_S01_MAIL " + &
			  "'" + sTo + "'"				 + ", " + &
			  "'" + sTextBody + "'"		 + ", " + &
			  "'" + sSubject + "'"		 + ", " + &
			  "'" + sFrom + "'"		    + ", " + &
			  "'" + sCc + "'"		 		 + ", " + &
			  "null"   				 		 + ", " + &
			  "null"   				 		 + ", " + &
			  "null"   				 		 + ", " + &
			  "null"   				 		 + ", " + &
			  "null"
	
	F_Execute ( sSql, atrans )
End If

return 1
end function

public function integer uf_maj_auto_bornesappli (ref u_transaction atrans, string asappliname, long alnumrev);//*----------------------------------------------------------------- 
//*
//* Objet 			: n_cst_GestionRevSvn
//* Evenement 		: uf_maj_auto_bornesappli
//* Auteur			: LBP
//* Date				: 21/10/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:  [DEMANDE JFF]
//*						Met $$HEX2$$e0002000$$ENDHEX$$jour le numero de r$$HEX1$$e900$$ENDHEX$$vision SVN de l'application courante
//						  
//*
//* Param$$HEX1$$e800$$ENDHEX$$tres		:
//*						REF	string 	atrans			:	Transaction de connexion $$HEX2$$e0002000$$ENDHEX$$la base SESAME
//*						VAL	string 	asappliname	:	Nom de l'application
//*						VAL	long		alnumrev			:	Numero de l'application
//*						
//*
//*Retour			: 
//*						Retourne toujours 1
//*
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ 						PAR		Date				Modification	  
//*  
//*
//*-----------------------------------------------------------------
Long lRet = 0

// Appel $$HEX2$$e0002000$$ENDHEX$$la PS de MAJ des bornes de l'application
lRet = atrans.PS_X_MAJ_BORNES_SVN (asappliname, alnumrev)

return lRet
end function

on n_cst_gestionrevsvn.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_gestionrevsvn.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

