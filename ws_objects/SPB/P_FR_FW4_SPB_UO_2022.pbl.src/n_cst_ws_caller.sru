HA$PBExportHeader$n_cst_ws_caller.sru
$PBExportComments$Ancetre des objets d'appels aux m$$HEX1$$e900$$ENDHEX$$thodes des WebServices
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

// A d$$HEX1$$e900$$ENDHEX$$clarer
// <mon_proxy> iProxy
end variables
forward prototypes
public function integer createproxy (soapconnection asoapcnx)
public function long uf_gestionexception (soapexception asoapex)
public function string uf_getlastsoaperror ()
end prototypes

public function integer createproxy (soapconnection asoapcnx);// Methode Virtuelle
// Retourne -1 : Caller non d$$HEX1$$e900$$ENDHEX$$fini
//
// Pour exemple, ci dessous Prototype de script
// a coder dans le descendant :
//
// Note : iProxy doit etre d$$HEX1$$e900$$ENDHEX$$clar$$HEX2$$e9002000$$ENDHEX$$dans le descendant
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

sSerializedError+= "Exception Soap N$$HEX2$$b0002000$$ENDHEX$$" + String(aSoapEx.number) + K_TAB
sSerializedError+= "Objet : " + aSoapEx.ObjectName + K_TAB
sSerializedError+= "Fonction/Evenement : " + aSoapEx.RoutineName + K_TAB
sSerializedError+= "Ligne N$$HEX2$$b0002000$$ENDHEX$$: " + string(aSoapEx.Line) + K_TAB
sSerializedError+= "Message PB : " + aSoapEx.Text + K_TAB
sSerializedError+= "Detail Erreur Soap => FaultCode :" + aSoapEx.GetFaultCode()+ K_TAB
sSerializedError+= "FaultString :" + aSoapEx.GetFaultString() + K_TAB
sSerializedError+= "FaultDetails :" + aSoapEx.GetDetailMessage()

isSoapError = sSerializedError

return lRet
end function

public function string uf_getlastsoaperror ();return issoaperror
end function

on n_cst_ws_caller.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ws_caller.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

