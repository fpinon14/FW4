HA$PBExportHeader$n_cst_tuerprogramme.sru
$PBExportComments$NVUO destin$$HEX4$$e9002000e0002000$$ENDHEX$$tuer toutes les instances d'un programme lanc$$HEX2$$e9002000$$ENDHEX$$en m$$HEX1$$e900$$ENDHEX$$moire
forward
global type n_cst_tuerprogramme from nonvisualobject
end type
end forward

global type n_cst_tuerprogramme from nonvisualobject autoinstantiate
end type

type prototypes
Private :


FUNCTION uLong		GetLastError () LIBRARY "kernel32.dll"
FUNCTION uLong		CloseHandle ( uLong lHandle ) LIBRARY "kernel32.dll"

FUNCTION boolean  GetExitCodeProcess(  uLong ulProcessHandle, ref Long lExitCode) LIBRARY "kernel32.dll"
FUNCTION boolean  TerminateProcess(  uLong ulProcessHandle, Integer lExitCode) LIBRARY "kernel32.dll"
FUNCTION uLong	  OpenProcess ( Long lDesiredAccess, Boolean bInheritHandle, Long dwProcessId) LIBRARY "kernel32.dll"

FUNCTION uLong CreateToolhelp32Snapshot (Long lFlags, Long lProcessID) LIBRARY "kernel32.dll"
FUNCTION boolean Process32First ( uLong luSnapShot, ref st_processEntry32 uProcess ) LIBRARY "kernel32.dll" ALIAS for "Process32First;Ansi"
FUNCTION boolean Process32Next ( uLong luSnapShot , ref st_processEntry32 uProcess ) LIBRARY "kernel32.dll" ALIAS for "Process32Next;Ansi"
FUNCTION Long  GetCurrentProcessId() LIBRARY "kernel32.dll"


FUNCTION Long GetModuleBaseNameA ( uLong hProcess, uLong hModule, ref string szExeName, Long dwSize )  LIBRARY "Psapi.dll" ALIAS for "GetModuleBaseNameA;Ansi"






end prototypes
type variables
CONSTANT Long MAX_PATH		= 260

CONSTANT Long PROCESS_TERMINATE = 1
CONSTANT Long PROCESS_VM_READ = 16
CONSTANT Long PROCESS_QUERY_INFORMATION = 1024

//PROCESS_VM_READ or PROCESS_QUERY_INFORMATION
CONSTANT Long PROCESS_QUERY_ET_VM = 1040
end variables

forward prototypes
public function integer uf_tuerprogramme (string asprogname)
public function boolean uf_bgetprocessname (long alprocessid, ref string asprocessname)
end prototypes

public function integer uf_tuerprogramme (string asprogname);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_TuerProgramme::uf_TuerProgramme (PUBLIC)
//* Auteur			: LBP
//* Date				: 31/05/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Tue toutes les instances en m$$HEX1$$e900$$ENDHEX$$moires d'un programme donn$$HEX1$$e900$$ENDHEX$$.
//*
//* Arguments		: (Val)		String		asProgName : Nom du prog $$HEX2$$e0002000$$ENDHEX$$tuer
//*					 
//*
//* Retourne		: Integer	1-> OK sinon erreur
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
CONSTANT Long U_PROCESS_SIZE = 296 // 260 + 9 * 4 octets

CONSTANT Long TH32CS_SNAPHEAPLIST = 1
CONSTANT Long TH32CS_SNAPPROCESS = 2
CONSTANT Long TH32CS_SNAPTHREAD = 4
CONSTANT Long TH32CS_SNAPMODULE =8

// TH32CS_SNAPHEAPLIST Or TH32CS_SNAPPROCESS Or TH32CS_SNAPTHREAD Or TH32CS_SNAPMODULE
CONSTANT Long TH32CS_SNAPALL = 15 // TH32CS_SNAPHEAPLIST Or TH32CS_SNAPPROCESS Or TH32CS_SNAPTHREAD Or TH32CS_SNAPMODULE

Long lFlagSNAPAL
ULong hSnapShot
st_processentry32 uProcess
Integer iRet
Boolean bRet, bRetB
String sNomFichierExe
String szName 
Integer  iProcessCount 
ULong hProcess
Long lNameSize
Long lFlag
long lRet


uProcess.sNomFichierExe = space(MAX_PATH)
iProcessCount = 0

// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re une photo des processus instanci$$HEX1$$e900$$ENDHEX$$s sur la& machine
hSnapShot = CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0)
   
// Rempli la taille de la structure envoy$$HEX1$$e900$$ENDHEX$$e
uProcess.lSize = U_PROCESS_SIZE

// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re les infos du premier process trouv$$HEX1$$e900$$ENDHEX$$
bRet = Process32First(hSnapShot, uProcess)

// On ne tient volontairement pas compte du premier processus (0 -> IDLE Windows)
do while bRet
	
	uProcess.sNomFichierExe = Space(260)
	bRet = Process32Next(hSnapShot, uProcess)
	
	if bRet then
		// Incremente le compteur d'instance ouverte
		iProcessCount = iProcessCount + 1
		
		// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le nom du process
		szName = ""
		bRetB = uf_bgetprocessname(uProcess.lProcessID, szName)
	
		if bRetB  then
			if UPPER(szName) = UPPER(asprogname) then
				// Regarde si le process apaartient $$HEX2$$e0002000$$ENDHEX$$l'utilisateur courant & si celui-ci a le droit de tuer le process
				hProcess = OpenProcess(PROCESS_TERMINATE, False, uProcess.lProcessID)
				
				If hProcess > 0 Then
						// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le code de sortie du process
						GetExitCodeProcess ( hProcess, lRet)
						
						// Termine le process
						TerminateProcess(hProcess, integer(lRet) )
				end if
			
				// Ferme le Handle de fermeture du process
				CloseHandle (hProcess)
	
			end if //  UPPER(szName) = UPPER(asprogname)
		end if //bRet
	end if
loop 

CloseHandle(hSnapShot)

return 1
end function

public function boolean uf_bgetprocessname (long alprocessid, ref string asprocessname);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_TuerProgramme::uf_bgetprocessname (PUBLIC)
//* Auteur			: LBP
//* Date				: 31/05/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le nom d'un processus $$HEX2$$e0002000$$ENDHEX$$partir d'un PID
//*
//* Arguments		:   (Val)		Long			alprocessid : PID du process 
//								(Ref)		String		asprocessname : Nom du process trouv$$HEX1$$e900$$ENDHEX$$
//*					 
//*
//* Retourne		: Boolean 	-> Dit si la recup du nom c'est bien pass$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

Ulong hProcess
Long lSize
boolean bRet
long lREt
string sProcessName

// Init des var
bRet = false
lSize = MAX_PATH
sProcessName = space(MAX_PATH) // MAX_PATH

// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re un Handle de consultation process
hProcess = OpenProcess(PROCESS_QUERY_ET_VM, False, alProcessId)

 If hProcess > 0 Then
	// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le nom du process
	lRet = GetModuleBaseNameA(hProcess, 0, sProcessName, lSize)
	
	// Supprime les caract supplementaires du nom
	if lRet > 0 then
		asProcessName =left(sProcessName, lRet)		
		bRet = true
	end if
end if

// Ferme le Handle ouvert
CloseHandle (hProcess)

return bRet
end function

on n_cst_tuerprogramme.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_tuerprogramme.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

