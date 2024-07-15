HA$PBExportHeader$n_se_connect.sru
$PBExportComments$PFC Transaction class
forward
global type n_se_connect from transaction
end type
end forward

global type n_se_connect from transaction
end type
global n_se_connect n_se_connect

type prototypes
function int PS_S01_NIVEAU_REQUIS_V01(int iIdUo, decimal dMontant, REF int iIdNiveau) RPCFUNC ALIAS FOR "sysadm.PS_S01_NIVEAU_REQUIS_V01"
function int PS_S01_NIVEAU_REQUIS_V02(int iIdUo, decimal dMontant, ref int iIdNiveau) RPCFUNC ALIAS FOR "sysadm.PS_S01_NIVEAU_REQUIS_V02"
function int PS_S01_NIVEAU_OPERATEUR_V01(int iIdUo, string sTrigramme, REF int iIdNiveauAcces, REF int iIdNiveauOper, REF string sOperSubstit) RPCFUNC ALIAS FOR "sysadm.PS_S01_NIVEAU_OPERATEUR_V01"


end prototypes

forward prototypes
public function boolean uf_isconnected ()
public function integer uf_init (string as_inifile, string as_inisection)
public function integer of_connect ()
end prototypes

public function boolean uf_isconnected ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_se_connect::uf_isconnected
//* Auteur			: F. Pinon
//* Date				: 18/07/2008 10:55:17
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: D$$HEX1$$e900$$ENDHEX$$finit si une connection $$HEX2$$e0002000$$ENDHEX$$la base est $$HEX1$$e900$$ENDHEX$$tablie
//*
//* Arguments		: 
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

if this.DBHandle() = 0 then
	return false
else
	return true
end if

end function

public function integer uf_init (string as_inifile, string as_inisection);//*-----------------------------------------------------------------
//*
//* Fonction		: n_se_connect::uf_init
//* Auteur			: F. Pinon
//* Date				: 18/07/2008 11:01:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string as_inifile	 */
/* 	value string as_inisection	 */
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
string sAutocommit

// Check arguments
if IsNull (as_inifile) or IsNull (as_inisection) or &
	Len (Trim (as_inifile))=0 or Len (Trim (as_inisection))=0 or &
	(not FileExists (as_inifile)) then return -1

this.DBMS= ProfileString (as_inifile, as_inisection, 'DBMS', '')

if this.DBMS = '' then return -2

this.Database = ProfileString (as_inifile, as_inisection, 'Database', '')
this.LogID = ProfileString (as_inifile, as_inisection, 'LogID', '')
this.LogPass = ProfileString (as_inifile, as_inisection, 'LogPassword', '')
this.ServerName = ProfileString (as_inifile, as_inisection, 'ServerName', '')
this.UserID = ProfileString (as_inifile, as_inisection, 'UserID', '')
this.DBPass =ProfileString (as_inifile, as_inisection, 'DatabasePassword', '')
this.Lock =ProfileString (as_inifile, as_inisection, 'Lock', '')
this.DBParm =ProfileString (as_inifile, as_inisection, 'DBParm', '')

sAutocommit = ProfileString (as_inifile, as_inisection, 'AutoCommit', 'false') 

if sAutocommit= 'false' then
	this.AutoCommit = false
else
	this.AutoCommit = True
end if

return 1

end function

public function integer of_connect ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_se_connect::of_connect
//* Auteur			: F. Pinon
//* Date				: 09/09/2009 10:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 	[ACTIVEDIRECTORY] 
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//			FPI/FS 25/08/2010	[SECURE_CNX] 
//*-----------------------------------------------------------------
long	ll_rc
string ls_name
boolean bAuthentWindows	// #1
string 	sOldLog[]			// [SECURE_CNX] 

// [SECURE_CNX] 
sOldLog[1] = logid
sOldLog[2] = logPass
//: [SECURE_CNX] 

// [MIGPB11] [EMD] : Debut : Integration code INTEGRATEDSECURITY
//bAuthentWindows= ( Pos(dbparm, "SECURE=1") > 0)
bAuthentWindows= ( Pos ( dbparm, "INTEGRATEDSECURITY='SSPI'" ) > 0 )
// [MIGPB11] [EMD] : Fin

If Not bAuthentWindows Then
	if Trim(logid) = "" or Trim(LogPass) = "" Then 
		SQLDbcode = -1
		SqlErrText = "Erreur de param$$HEX1$$e900$$ENDHEX$$trage dans le fichier INI - " + database
		Return -1
	// [SECURE_CNX]
	Else
		f_crypter( LogId, FALSE)
		f_crypter( LogPass, FALSE)
	// :[SECURE_CNX]
	End if
Else
	LogId=""
	LogPass=""
	Userid = ""
	DbPass = ""
End if

connect using this;
ll_rc = this.SQLCode

// [SECURE_CNX] 
logid = sOldLog[1]
logPass = sOldLog[2] 
//: [SECURE_CNX] 

return ll_rc
end function

on n_se_connect.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_se_connect.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//*-----------------------------------------------------------------
//*
//* Objet			: n_cse_connect
//* Evenement 		: destructor
//* Auteur			: F. Pinon
//* Date				: 18/07/2008 11:06:09
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

if uf_IsConnected() then
		Disconnect using this;
end if
end event

