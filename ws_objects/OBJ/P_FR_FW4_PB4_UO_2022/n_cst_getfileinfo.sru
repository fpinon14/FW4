HA$PBExportHeader$n_cst_getfileinfo.sru
$PBExportComments$[Recup vers SVN] : R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re les informations embarqu$$HEX1$$e900$$ENDHEX$$es dans un fichier
forward
global type n_cst_getfileinfo from nonvisualobject
end type
end forward

global type n_cst_getfileinfo from nonvisualobject autoinstantiate
end type

type prototypes
Private :


FUNCTION Long  GetCurrentProcessId() LIBRARY "kernel32.dll"
FUNCTION uLong	  OpenProcess ( Long lDesiredAccess, Boolean bInheritHandle, Long dwProcessId) LIBRARY "kernel32.dll"
FUNCTION uLong		CloseHandle ( uLong lHandle ) LIBRARY "kernel32.dll"
FUNCTION Long GetModuleBaseNameA ( uLong hProcess, uLong hModule, ref string szExeName, Long dwSize )  LIBRARY "Psapi.dll" ALIAS for "GetModuleBaseNameA;Ansi"
FUNCTION 		Long  GetFileVersionInfo			(String lptstrFilename ,  Long dwHandle , Long dwLen , ref byte pData) LIBRARY "Version.dll" ALIAS for "GetFileVersionInfoA;Ansi"

FUNCTION 		Long 	GetFileVersionInfoSize 	(String lptstrFilename, ref Long lpdwHandle) LIBRARY "Version.dll" ALIAS for "GetFileVersionInfoSizeA;Ansi"
FUNCTION 		Long  VerQueryValue 				(ref Byte pBlock  , string lpSubBlock, ref Long lplpBuffer , ref long puLen ) LIBRARY "Version.dll" ALIAS for "VerQueryValueA;Ansi"

SUBROUTINE 			MoveMemory 				(ref Byte dest, Long Source, Long length) LIBRARY "kernel32.dll" ALIAS for "RtlMoveMemory;Ansi"
SUBROUTINE 			MoveMemoryCodePage	(ref st_codepageinfo dest, Long Source, Long length) LIBRARY "kernel32.dll" ALIAS for "RtlMoveMemory;Ansi"

FUNCTION		Long 	lstrcpy 						(ref String lpString1 , Long lpString2) LIBRARY "kernel32.dll" ALIAS for "lstrcpyA;Ansi"

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
public function long of_hex2long (string as_hex)
public function string of_long2hex (long al_number, integer ai_digit)
public function boolean getstringvariableinfo (string asfilename, string askeytofind, ref string askeyvalue)
public function boolean uf_getcurrentapplicationname (ref string asprocessname)
end prototypes

public function long of_hex2long (string as_hex);//*----------------------------------------------------------------- 
//*
//* Objet 			: n_cst_getFileInfo
//* Fonction 		: of_hex2long
//* Auteur			: LBP
//* Date				: 16/06/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Convertit une chaine Hexa en d$$HEX1$$e900$$ENDHEX$$cimal
//* Param$$HEX1$$e800$$ENDHEX$$tres		:
//*						VAL	String 	as_hex		:	Chaine de caract $$HEX2$$e0002000$$ENDHEX$$convertir
//*						
//*Retour			: 
//*						long -> Nombre convertit
//*
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ 						PAR		Date			Modification	  
//* [Recup vers SVN]		LBP		15/06/10		R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la r$$HEX1$$e900$$ENDHEX$$vision SVN
//*
//*-----------------------------------------------------------------
string ls_hex
integer i,length
long result = 0

length = len(as_hex)
ls_hex = Upper(as_hex)
FOR i = 1 to length
   result += &
     (Pos ('123456789ABCDEF', mid(ls_hex, i, 1)) * &
     ( 16 ^  ( length - i )  ))
NEXT
RETURN result

end function

public function string of_long2hex (long al_number, integer ai_digit);//*----------------------------------------------------------------- 
//*
//* Objet 			: n_cst_getFileInfo
//* Fonction 		: of_long2hex
//* Auteur			: LBP
//* Date				: 16/06/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Convertit une chaine d$$HEX1$$e900$$ENDHEX$$cimale en Hexa
//* Param$$HEX1$$e800$$ENDHEX$$tres		:
//*						VAL	Long 	al_number		:	Chaine de caract $$HEX2$$e0002000$$ENDHEX$$convertir
//*						VAL	Integer 	ai_digit		:	Nombre de digit de la chaine finale convertie
//*Retour			: 
//*						String -> Nombre convertit en Hexa
//*
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ 						PAR		Date			Modification	  
//* [Recup vers SVN]		LBP		15/06/10		R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la r$$HEX1$$e900$$ENDHEX$$vision SVN
//*
//*-----------------------------------------------------------------

long ll_temp0, ll_temp1
char lc_ret

IF ai_digit > 0 THEN
   ll_temp0 = abs(al_number / (16 ^ (ai_digit - 1)))
   ll_temp1 = ll_temp0 * (16 ^ (ai_digit - 1))
   IF ll_temp0 > 9 THEN
      lc_ret = char(ll_temp0 + 55)
   ELSE
      lc_ret = char(ll_temp0 + 48)
   END IF
   RETURN lc_ret + &
          of_long2hex(al_number - ll_temp1 , ai_digit - 1)
END IF
RETURN ""

end function

public function boolean getstringvariableinfo (string asfilename, string askeytofind, ref string askeyvalue);//*----------------------------------------------------------------- 
//*
//* Objet 			: n_cst_getFileInfo
//* Evenement 		: getStringVariableInfo
//* Auteur			: LBP
//* Date				: 15/06/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Retourne les informations de type STRING li$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$la clef pass$$HEX1$$e900$$ENDHEX$$e
//*					  en param$$HEX1$$e800$$ENDHEX$$tre
//* Param$$HEX1$$e800$$ENDHEX$$tres		:
//*						VAL	String 	asFileName		:	Nom du fichier 
//*						VAL	String 	asKeyToFind	:	Nom de la clef $$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer
//*						REF	String 	asKeyToFind	:	Nom de la clef $$HEX2$$e0002000$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer
//*Retour			: Vrai si clef trouv$$HEX1$$e900$$ENDHEX$$e et que tout c'est bien pass$$HEX1$$e900$$ENDHEX$$. Faux sinon
//*
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ 						PAR		Date			Modification	  
//* [Recup vers SVN]		LBP		15/06/10		R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la r$$HEX1$$e900$$ENDHEX$$vision SVN
//*
//*-----------------------------------------------------------------

Long lLenData
Byte buffer[5000]
Long lRet 
Long pData
Byte cpl[4]
//Long cpl[4]
Long lSize
Long lCodePage
Long lLen
st_codepageinfo stCodePage
string szCodePageHexa
string szKeyToSearch
string szSvnRevision
integer iNbCar
boolean bRet

// Init par d$$HEX1$$e900$$ENDHEX$$faut de la chanie retourn$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$vide
askeyvalue =""

TRY
	// Si pas de nom de fichier pass$$HEX2$$e9002000$$ENDHEX$$en param on prend le nom du fichier courant
	
	if(asFileName = "") then
		bRet = uf_getCurrentApplicationName(asFileName)
		
		if bRet=false or asFileName = "" then
			return false
		end if
	end if
	
	// V$$HEX1$$e900$$ENDHEX$$rifie l'existence du fichier
	If Not FileExists(asFileName) Then
		return false
	End If
	
	// Recup de la taille des infos de version du fichier
	lLenData = GetFileVersionInfoSize(asFileName, pData)
	if lLenData = 0 then
		return false
	end if
	
	// Recup des info ds buffer
	lRet = GetFileVersionInfo(asFileName, 0, lLenData, buffer[1]) 
	
	if lRet <> 0 then
		// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du code page et du langage
		lRet = VerQueryValue(buffer[1], "\VarFileInfo\Translation", pData, lLenData) 
		
		if lRet <> 0 then
			// Lit les donn$$HEX1$$e900$$ENDHEX$$es fixes de la page dans la struct stFileInfo
			lLen = 4
			
			//MoveMemory ( cpl[1], pData, lLen)
			//MoveMemoryLong( cpl[1], pData, lLen)
			MoveMemoryCodePage(stCodePage, pData, lLen)
			
			// Reconstitue l'id contenant le code page et le langage (cf. microsoft.com aide fct VerQueryValue section StringFileInfo)
			lCodePage = Long(stCodePage.bbyte1) * 16^6 + Long(stCodePage.bbyte0) * 16^4 +  Long(stCodePage.bbyte3) * 16^2 +  Long(stCodePage.bbyte2)
			szCodePageHexa = of_long2hex(lCodePage, 8)
			
			// Creation de la clef de section
			szKeyToSearch = '\StringFileInfo\' + szCodePageHexa + "\" + askeytofind 
			
			// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la clef d$$HEX1$$e900$$ENDHEX$$finie ci-dessus
			lRet = VerQueryValue(buffer[1], szKeyToSearch, pData, lLenData) 
			if lRet <> 0 then
				If lLenData > 0 Then lLenData = lLenData - 1
					szSvnRevision = Space(lLenData)
					lstrcpy (szSvnRevision, pData)
					
					if IsNumber(szSvnRevision) then
						// On ne consereve que 5 digits au max
						iNbCar = Len(szSvnRevision)
						if iNbCar >0 then
							if iNbCar > 5 then iNbCar = 5
								askeyvalue =left(trim(szSvnRevision),iNbCar)
								return true
						end if
					end if
			end if
		end if
	end if
CATCH( RuntimeError re)
	// En cas d'erreur syst$$HEX1$$e800$$ENDHEX$$me on consid$$HEX1$$e800$$ENDHEX$$re que la revision n'a pu $$HEX1$$ea00$$ENDHEX$$tre lue
	// mais on ne bloque pas l'application.
	return false
END TRY

return false
end function

public function boolean uf_getcurrentapplicationname (ref string asprocessname);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_TuerProgramme::uf_getCurrentApplicationName (PUBLIC)
//* Auteur			: LBP
//* Date				: 24/06/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re le nom du courant
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
long lProcessId

// Init des var
bRet = false
lSize = MAX_PATH
sProcessName = space(MAX_PATH) // MAX_PATH

// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re l'ID du process courant
lProcessId = GetCurrentProcessId()

// R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re un Handle de consultation process
hProcess = OpenProcess(PROCESS_QUERY_ET_VM, False, lProcessId)

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

on n_cst_getfileinfo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_getfileinfo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

