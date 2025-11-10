$PBExportHeader$n_cst_ws_caller.sru
$PBExportComments$Ancetre des objets d'appels aux méthodes des WebServices
forward
global type n_cst_ws_caller from nonvisualobject
end type
end forward

global type n_cst_ws_caller from nonvisualobject
end type
global n_cst_ws_caller n_cst_ws_caller

type variables
protected:
constant string K_TESTWS = "INQUIRY REQUEST"
string isSoapError

// [MIG_PB2022]
HttpClient inv_httpclient
String isUrl
String isMethod
end variables

forward prototypes
public function integer createproxy (soapconnection asoapcnx)
public function long uf_gestionexception (soapexception asoapex)
public function string uf_getlastsoaperror ()
public function integer uf_init ()
end prototypes

public function integer createproxy (soapconnection asoapcnx);// Methode Virtuelle
// Retourne -1 : Caller non défini
//
// Pour exemple, ci dessous Prototype de script
// a coder dans le descendant :
//
// Note : iProxy doit etre déclaré dans le descendant
// et *DOIT* etre du type <Nom du Proxy>
// long lRet
// lret = aSoapcnx.CreateInstance(iProxy, &
//										"<Nom du Proxy>")
// return lRet

return -1
end function

public function long uf_gestionexception (soapexception asoapex);// Gestion des Exception Soap

long lRet
string sSerializedError=""
constant char K_TAB=char(9)
n_cst_string lnvString

lRet = aSoapEx.number*-1

sSerializedError+= "Exception Soap N° " + String(aSoapEx.number) + K_TAB
sSerializedError+= "Objet : " + aSoapEx.ObjectName + K_TAB
sSerializedError+= "Fonction/Evenement : " + aSoapEx.RoutineName + K_TAB
sSerializedError+= "Ligne N° : " + string(aSoapEx.Line) + K_TAB
sSerializedError+= "Message PB : " + aSoapEx.Text + K_TAB
sSerializedError+= "Detail Erreur Soap => FaultCode :" + aSoapEx.GetFaultCode()+ K_TAB
sSerializedError+= "FaultString :" + aSoapEx.GetFaultString() + K_TAB
sSerializedError+= "FaultDetails :" + aSoapEx.GetDetailMessage()

isSoapError = sSerializedError

return lRet
end function

public function string uf_getlastsoaperror ();return issoaperror
end function

public function integer uf_init ();// [MIG_PB2022]
// Methode Virtuelle à implémenter
// Retourne -1 : Caller non défini
//
// Pour exemple, ci dessous Prototype de script
// a coder dans le descendant :
/*
inv_httpclient.SetRequestHeader("Content-Type", "text/xml")
 isMethod="POST"
 isUrl=ProfileString(stglb.sfichierini,"SEPA","URL_WEBSERVICE_SEPA","")
	
	if sUrl="" Then Return -2
 return 1*/

inv_httpclient=CREATE HTTPClient

Return -1
end function

on n_cst_ws_caller.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ws_caller.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//[MIG_PB2022]
If isValid(inv_httpclient) Then 
	Destroy inv_httpclient
End if
end event

