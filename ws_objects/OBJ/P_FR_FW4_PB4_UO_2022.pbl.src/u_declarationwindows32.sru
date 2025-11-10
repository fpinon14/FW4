HA$PBExportHeader$u_declarationwindows32.sru
$PBExportComments$----} UserObjet pour les d$$HEX1$$e900$$ENDHEX$$clarations externes Windows en 32 Bits
forward
global type u_declarationwindows32 from u_declarationwindows
end type
end forward

global type u_declarationwindows32 from u_declarationwindows
end type
global u_declarationwindows32 u_declarationwindows32

type prototypes
// Fonctions Windows

Function Boolean	              BringWindowToTop( Uint uiHwnd ) Library "USER32.DLL"
Function Boolean 	              EnableWindow (Uint uiHwnd,Boolean bEnable) Library "USER32.DLL"
//Migration PB8-WYNIWYG-03/2006 FM
//Function UInt 		GetDc (UInt uiHwnd) Library "USER32.DLL"
Function UInt 		GetDC (UInt uiHwnd) Library "USER32.DLL"
//Fin Migration PB8-WYNIWYG-03/2006 FM
Function Int 		GetModuleHandle(String sModuleName) Library "KERNEL32.DLL" alias for "GetModuleHandle;Ansi"
Function Int		GetModuleFileName(UInt uiHwnd, Ref String szFilename, Int NbMax)  Library "KERNEL32.DLL" alias for "GetModuleFileName;Ansi"
Function Uint 		GetStockObject (int iObj) library "GDI32.DLL"
Function Int 		GetTextFace (Uint uiHdc,Int iSizeof, Ref String sFace) library "GDI32.DLL" alias for "GetTextFace;Ansi"
Function Boolean 	              GetTextMetrics (Uint uiHdc,Ref s_txtmetrics stTextMet) library "GDI32.DLL" alias for "GetTextMetrics;Ansi"
Function Uint 		GetWindow (Uint uiHwnd,Uint uiFlag) library "USER32.DLL"
Function Boolean 	              IsWindowEnabled (Uint uiHwnd ) library "USER32.DLL"
//Migration PB8-WYNIWYG-03/2006 FM
//Subroutine  		LZClose (Uint uiHfile) library "LZexpand.dll"
//Function Uint 		LZCopy  (Uint uiSrc,Uint uiDest) library "LZexpand.dll"
//Function Uint 		LZOpenfile (String sFileName,s_Ofstruct stStruct,Uint uiMode) library "LZexpand.dll"
//Function Int 		ReleaseDc (UInt uiHwnd, Uint uiHdc) Library "USER32.DLL"
Function Int 		ReleaseDC (UInt uiHwnd, Uint uiHdc) Library "USER32.DLL"
//Fin Migration PB8-WYNIWYG-03/2006 FM
Function Uint 		SelectObject (Uint uiHdc,Uint uiHobj) library "GDI32.DLL"
Function Uint 		SetFocus (Uint uiHwnd) library "USER32.DLL"
Function Boolean 	              ShowWindow (Uint uiHwnd,Int iFlag) Library "USER32.DLL"
Function Int		GetSystemMetrics( Int iSysMetr ) Library "USER32.DLL"
Function Uint		SpoolFile ( String sImp, String sPort, String sJob, String sFic ) Library "GDI32.DLL" alias for "SpoolFile;Ansi"
Function Uint		Winexec	( String sPrg, Uint	uiEtat ) Library "KERNEL32.DLL" alias for "Winexec;Ansi"
Function UInt		SetActiveWindow ( UInt uiHwnd ) Library "USER32.DLL"
Function UInt		FindWindow ( String sClassName, String sWindowName ) Library "USER32.DLL" alias for "FindWindow;Ansi"
Function Int		GetScrollPos( UInt uiHwnd,Int iScroll) Library "USER32.DLL"
Function Long		GetFreeSpace( UInt uiNotUsed ) Library "KERNEL32.DLL"
Function UInt		GetFreeSystemResources( UInt uiTypeRessource ) Library "USER32.DLL"
Subroutine 		ReleaseCapture( ) library "USER32.DLL"
Function Uint 		SetCapture(uint win_hand) library "USER32.DLL"
Function Int		GetPrivateProfileString( ref string sSection, ref string sEntry, ref string sDefaut, ref blob blRetour, uint uiBuffer, ref string sNomFic ) Library "KERNEL32.DLL" alias for "GetPrivateProfileString;Ansi"
Function Uint 		LoadModule (String sModule, s_LoadParams stLoadParams) Library "KERNEL32.DLL" alias for "LoadModule;Ansi"
//Migration PB8-WYNIWYG-03/2006 FM
//Function Int		GetTempFileName( Uint uiDrive, String sPrefixe, uint uiUnique, Ref String sTempFileName )  LIBRARY "KERNEL32.DLL"
//Function Int		WritePrivateProfileString( ref string sSection, ref string sEntry, ref string sString, ref string sNomFic ) Library "KERNEL32.DLL"
//Fin Migration PB8-WYNIWYG-03/2006 FM
// Fonction diff$$HEX1$$e900$$ENDHEX$$rent pour GetUser entre 16 et 32
Function Boolean 		GetUserNameA ( ref String sUserId, ref uLong Lng )  Library "ADVAPI32.DLL" alias for "GetUserNameA;Ansi"

Function ULong		GetWindowsDirectoryA ( ref string sDir, ulong ulSize) library "KERNEL32.DLL" alias for "GetWindowsDirectoryA;Ansi"
Function Long		ExpandEnvironmentStringsA ( REF string sSrc, REF string sDest, long lDest ) library "KERNEL32.DLL" alias for "ExpandEnvironmentStringsA;Ansi" 
Function boolean 		SetFileAttributesA (ref string filename, ulong attrib) library "KERNEL32.DLL" alias for "SetFileAttributesA;Ansi" 

//Migration PB8-WYNIWYG-03/2006 FM
Function Boolean 	GetTextMetricsA (Uint uiHdc,Ref s_txtmetrics_PB8 stTextMet) library "GDI32.DLL" alias for "GetTextMetricsA;Ansi"
Function Int		GetTempFileNameA( Uint uiDrive, String sPrefixe, uint uiUnique, Ref String sTempFileName )  LIBRARY "KERNEL32.DLL" alias for "GetTempFileNameA;Ansi"
Subroutine  		LZClose (Uint uiHfile) library "LZ32.dll"
Function Uint 		LZCopy  (Uint uiSrc,Uint uiDest) library "LZ32.dll"
Function Uint 		LZOpenFileA (String sFileName,s_Ofstruct32 stStruct,Uint uiMode) library "LZ32.dll" alias for "LZOpenFileA;Ansi"
Function Int		WritePrivateProfileStringA(ref string sSection, ref string sEntry, ref string sString, ref string sNomFic) Library "KERNEL32.DLL" alias for "WritePrivateProfileStringA;Ansi"
Function int		EmptyClipboard ( )  Library "USER32.DLL"
Function int		OpenClipboard  (Int hWnd) Library "USER32.DLL" 
Function int		CloseClipboard () Library "USER32.DLL" 
//Fin Migration PB8-WYNIWYG-03/2004
// PHG - 05/04/2006 - [DETECTEAPPLI] Detection lancement application
// [MIGPB11] [EMD] : Debut report modif [DETECTEAPPLI] : ajout de l'alias sur CreateMutexW au lieu de CreateMutexA;Ansi
//Function uLong		CreateMutex (uLong lMutexAttribut, Boolean bInitial, Ref String sNomApplication ) LIBRARY "kernel32.dll" ALIAS FOR "CreateMutexA;Ansi"
Function uLong		CreateMutex (uLong lMutexAttribut, Boolean bInitial, Ref String sNomApplication ) LIBRARY "kernel32.dll" ALIAS FOR "CreateMutexW"
// [MIGPB11] [EMD] : Fin
FUNCTION uLong		GetLastError () LIBRARY "kernel32.dll"
FUNCTION uLong		CloseHandle ( uLong lutex ) LIBRARY "kernel32.dll"
// FIN PHG - 05/04/2006 - [DETECTEAPPLI] Detection lancement application
Function long FindFirstFileA (ref string filename, ref s_filedata findfiledata) library "KERNEL32.DLL" alias for "FindFirstFileA;Ansi"
Function boolean FindNextFileA (long handle, ref s_filedata findfiledata) library "KERNEL32.DLL" alias for "FindNextFileA;Ansi" // [I037] Migration FUNCKy
Function boolean FindClose (long handle) library "KERNEL32.DLL"
Function long OpenFile (ref string filename, ref s_FileOpenInfo of_struct, ulong action) LIBRARY "KERNEL32.DLL" alias for "OpenFile;Ansi"
// [MERGE PHG] Function boolean CloseHandle (long file_hand) LIBRARY "KERNEL32.DLL"
Function boolean MoveFileA (ref string oldfile, ref string newfile) library "KERNEL32.DLL" alias for "MoveFileA;Ansi" // [I037] Migration FUNCKy
Function Boolean GetFileTime (long hFile, ref s_filedatetime lpCreationTime, ref s_filedatetime lpLastAccessTime, ref s_filedatetime lpLastWriteTime) LIBRARY "KERNEL32.DLL" alias for "GetFileTime;Ansi"
Function Boolean SetFileTime (long hFile, s_filedatetime lpCreationTime, s_filedatetime lpLastAccessTime, s_filedatetime lpLastWriteTime) LIBRARY "KERNEL32.DLL" alias for "SetFileTime;Ansi"
Function Boolean FileTimeToLocalFileTime (ref s_filedatetime lpFileTime, ref s_filedatetime lpLocalFileTime) LIBRARY "KERNEL32.DLL" alias for "FileTimeToLocalFileTime;Ansi"
Function Boolean FileTimeToSystemTime (ref s_filedatetime lpFileTime, ref s_SystemTime lpSystemTime) LIBRARY "KERNEL32.DLL" alias for "FileTimeToSystemTime;Ansi"
Function Boolean LocalFileTimeToFileTime (ref s_filedatetime lpLocalFileTime, ref s_filedatetime lpFileTime) LIBRARY "KERNEL32.DLL" alias for "LocalFileTimeToFileTime;Ansi"
Function Boolean SystemTimeToFileTime (s_SystemTime lpSystemTime, ref s_filedatetime lpFileTime) LIBRARY "KERNEL32.DLL" alias for "SystemTimeToFileTime;Ansi"
Function Long GetActiveWindow() Library "USER32.DLL"
end prototypes

forward prototypes
public function boolean uf_bringwindowtotop (unsignedinteger auihwnd)
public function boolean uf_enablewindow (unsignedinteger auihwnd, boolean abenable)
public function unsignedinteger uf_getdc (unsignedinteger auihwnd)
public function integer uf_getmodulehandle (string asnommodule)
public function integer uf_getmodulefilename (unsignedinteger auihwnd, ref string asnomfic, integer ainbmax)
public function unsignedinteger uf_getstockobject (integer aiobj)
public function integer uf_gettextface (unsignedinteger auihdc, integer aitaille, ref string asface)
public function boolean uf_gettextmetrics (unsignedinteger auihdc, ref s_txtmetrics_pb8 astmetrics)
public function unsignedinteger uf_getwindow (unsignedinteger auihwnd, unsignedinteger auiflag)
public function boolean uf_iswindowenabled (unsignedinteger auihwnd)
public function unsignedinteger uf_lzcopy (unsignedinteger auisrc, unsignedinteger auidest)
public function unsignedinteger uf_lzopenfile (string asnomfic, s_ofstruct32 aststruct, unsignedinteger auimode)
public function integer uf_releasedc (unsignedinteger auihwnd, unsignedinteger auihdc)
public function unsignedinteger uf_selectobject (unsignedinteger auihdc, unsignedinteger auihobj)
public function unsignedinteger uf_setfocus (unsignedinteger auihwnd)
public function boolean uf_showwindow (unsignedinteger auihwnd, integer aiflag)
public function integer uf_getsystemmetrics (integer aisysmet)
public function unsignedinteger uf_spoolfile (string asimp, string asport, string asjob, string asfic)
public function unsignedinteger uf_winexec (string asprg, unsignedinteger auietat)
public function unsignedinteger uf_setactivewindow (unsignedinteger auihwnd)
public function unsignedinteger uf_findwindow (string asclasse, string aswindow)
public function integer uf_getscrollpos (unsignedinteger auihwnd, integer aiscroll)
public function long uf_getfreespace (unsignedinteger auitype)
public function unsignedinteger uf_getfreesystemresources (unsignedinteger auitype)
public subroutine uf_releasecapture ()
public function unsignedinteger uf_setcapture (unsignedinteger auihwnd)
public function unsignedinteger uf_loadmodule (string asmodule, s_loadparams astparam)
public function integer uf_getprivateprofilestring (ref string assection, ref string asentry, ref string asdefaut, ref blob ablretour, unsignedinteger auibuffer, ref string asnomfic)
public subroutine uf_lzclose (unsignedinteger auific)
public function string uf_getuser ()
public function integer uf_gettempfilename (string asprefix, ref string astmpfilename)
public function integer uf_setprofilestring (ref string asfichier, ref string assection, ref string ascle, ref string astext)
public function integer uf_spbgetdevice (ref string asdrivername, ref string asdevicename, ref string asportname)
public function unsignedinteger uf_wnetgetconnection (string asportname, ref string asnetqueuename, ref unsignedinteger auimaxnbcar)
public function string uf_getversion ()
public function string uf_getwindowsdirectory ()
public function string uf_getenvironment (string asvariable)
public function integer uf_setfileattributes (ref string asnomfic, unsignedlong aulattrib)
public function integer uf_emptyclipboard ()
public function long uf_createmutex (boolean abinitial, ref string asnomapplication)
public function integer uf_closehandle (unsignedlong aul_lutex)
public function integer uf_getlasterror ()
protected function integer f_convertfiledatetimetopb (s_filedatetime astr_filetime, ref date ad_date, ref time at_time)
public function integer uf_getlastwritedatetime (string asfichier, ref date addate, ref time attime)
public function integer uf_setlastwritedatetime (string asfichier, date addate, time attime)
protected function integer f_convertpbdatetimetofile (date ad_filedate, time at_filetime, ref s_filedatetime astr_filedatetime)
public function unsignedinteger uf_spbfwrite (unsignedinteger auihandlefile, ref blob ablbuf, unsignedinteger auinbbyte)
public function unsignedinteger uf_getactivewindow ()
public function long uf_filecount (string aspattern, long alattrib)
public function integer uf_frename (string as_sourcefile, string as_targetfile)
public function integer uf_feraseall (string asfic)
end prototypes

public function boolean uf_bringwindowtotop (unsignedinteger auihwnd);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_BringWindowToTop
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affiche la fen$$HEX1$$ea00$$ENDHEX$$tre au premier plan
//*
//* Arguments		: UnsignedInteger		auiHWnd		(Val)	Handle de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*								
//*
//*-----------------------------------------------------------------

Return BringWindowToTop ( auiHWnd )
end function

public function boolean uf_enablewindow (unsignedinteger auihwnd, boolean abenable);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_EnableWindow
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Rend une fen$$HEX1$$ea00$$ENDHEX$$tre active ou non active
//*
//* Arguments		: UnsignedInteger		auiHWnd		(Val)	Handle de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//*					  Bool$$HEX1$$e900$$ENDHEX$$en				abEnable		(Val) Actif ou Non
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*								
//*
//*-----------------------------------------------------------------

Return EnableWindow ( auiHWnd, abEnable )
end function

public function unsignedinteger uf_getdc (unsignedinteger auihwnd);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetDc
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiHWnd		(Val)	Handle de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//Return GetDc ( auiHWnd )
Return GetDC ( auiHWnd )
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

public function integer uf_getmodulehandle (string asnommodule);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetModuleHandle
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Retourne le handle du module sp$$HEX1$$e900$$ENDHEX$$cifi$$HEX1$$e900$$ENDHEX$$
//*
//* Arguments		: String					asNomModule	(Val)	Nom du Module
//*
//* Retourne		: Integer
//*								
//*
//*-----------------------------------------------------------------

Return GetModuleHandle ( asNomModule )
end function

public function integer uf_getmodulefilename (unsignedinteger auihwnd, ref string asnomfic, integer ainbmax);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetModuleFileName
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Retourne le nom du module correspondant au handle
//*
//* Arguments		: UnsignedInteger		auiHWnd		(Val)	Handle de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//*					  String					asNomFic		(R$$HEX1$$e900$$ENDHEX$$f) Nom du Fichier
//*					  Integer				aiNbMax		(Val) Nombre de caract$$HEX1$$e900$$ENDHEX$$res $$HEX3$$e0002000e900$$ENDHEX$$crire
//*
//* Retourne		: Integer
//*								
//*
//*-----------------------------------------------------------------

Return GetModuleFileName ( auiHWnd, asNomFic, aiNbMax )
end function

public function unsignedinteger uf_getstockobject (integer aiobj);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetStockObject
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Integer				aiObj			(Val)	
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

Return GetStockObject ( aiObj )
end function

public function integer uf_gettextface (unsignedinteger auihdc, integer aitaille, ref string asface);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetTextFace
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiHDc		(Val)	Handle du device context
//*					  Integer				aiTaille		(Val) 
//*					  String					asFace		(R$$HEX1$$e900$$ENDHEX$$f) 
//*
//* Retourne		: Integer
//*								
//*
//*-----------------------------------------------------------------

Return GetTextFace ( auiHDc, aiTaille, asFace )
end function

public function boolean uf_gettextmetrics (unsignedinteger auihdc, ref s_txtmetrics_pb8 astmetrics);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetTextMetrics
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiHDc		(Val)	Handle du device context
//Migration PB8-WYNIWYG-03/2006 FM
////*					  s_TxtMetrics			astMetrics	(R$$HEX1$$e900$$ENDHEX$$f) 
//*					  s_TxtMetrics_pb8	astMetrics	(R$$HEX1$$e900$$ENDHEX$$f) 
//Fin Migration PB8-WYNIWYG-03/2006 FM
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*								
//*
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//Return GetTextMetrics ( auiHDc, astMetrics )
Return GetTextMetricsA ( auiHDc, astMetrics )
//Return GetTextMetricsW ( auiHDc, astMetrics )
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

public function unsignedinteger uf_getwindow (unsignedinteger auihwnd, unsignedinteger auiflag);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetWindow
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiHWnd		(Val)	Handle de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//*					  UnsignedInteger		auiFlag		(Val)	Type de relation 
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

Return GetWindow ( auiHWnd, auiFlag )

end function

public function boolean uf_iswindowenabled (unsignedinteger auihwnd);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_IsWindowEnabled
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiHWnd		(Val)	Handle de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*								
//*
//*-----------------------------------------------------------------

Return IsWindowEnabled ( auiHWnd )
end function

public function unsignedinteger uf_lzcopy (unsignedinteger auisrc, unsignedinteger auidest);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_LzCopy
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiSrc		(Val)	Fichier source
//*					  UnsignedInteger		auiDest		(Val)	Fichier destination
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

Return LzCopy ( auiSrc, auiDest )
end function

public function unsignedinteger uf_lzopenfile (string asnomfic, s_ofstruct32 aststruct, unsignedinteger auimode);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_LzOpenFile
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String					asNomFic		(Val) Nom du Fichier
//*					  s_OfStruct			astStruct	(Val)
//*					  UnsignedInteger		auiMode		(Val) Mode d'ouverture
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//Return LzOpenFile ( asNomFic, astStruct, auiMode )
Return LzOpenFileA ( asNomFic, astStruct, auiMode )
//Fin Migration PB8-WYNIWYG-03/2006 FM
end function

public function integer uf_releasedc (unsignedinteger auihwnd, unsignedinteger auihdc);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ReleaseDc
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiHWnd		(Val)	Handle de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//*					  UnsignedInteger		auiHDc		(Val)	Handle du device context
//*
//* Retourne		: Integer
//*								
//*
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//Return ReleaseDc ( auiHWnd, auiHDc )
Return ReleaseDC ( auiHWnd, auiHDc )
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

public function unsignedinteger uf_selectobject (unsignedinteger auihdc, unsignedinteger auihobj);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_SelectObject
//* Auteur			: Erick John Stark
//* Date				: 14/11/1996 16:10:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiHDc		(Val)	Handle de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//*					  UnsignedInteger		auiHObj		(Val)	
//*
//* Retourne		: UnsignedInteger
//*
//*-----------------------------------------------------------------

Return SelectObject ( auiHDc, auiHObj )
end function

public function unsignedinteger uf_setfocus (unsignedinteger auihwnd);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_SetFocus
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiHWnd		(Val)	Handle de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

Return SetFocus ( auiHWnd )
end function

public function boolean uf_showwindow (unsignedinteger auihwnd, integer aiflag);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ShowWindow
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiHWnd		(Val)	Handle de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//*					  Integer				aiFlag		(Val) 
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*								
//*
//*-----------------------------------------------------------------

Return ShowWindow ( auiHWnd, aiFlag )
end function

public function integer uf_getsystemmetrics (integer aisysmet);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetSystemMetrics
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Integer				aiSysMet		(Val)	
//*
//* Retourne		: Integer
//*								
//*
//*-----------------------------------------------------------------

Return GetSystemMetrics ( aiSysMet )
end function

public function unsignedinteger uf_spoolfile (string asimp, string asport, string asjob, string asfic);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_SpoolFile
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Envoi d'un fichier $$HEX2$$e0002000$$ENDHEX$$l'impression
//*
//* Arguments		: String					asImp			(Val)	
//*					  String					asPort		(Val) 
//*					  String					asJob			(Val) 
//*					  String					asFic			(Val) 
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

Return SpoolFile ( asImp, asPort, asJob, asFic )
end function

public function unsignedinteger uf_winexec (string asprg, unsignedinteger auietat);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_WinExec
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ex$$HEX1$$e900$$ENDHEX$$cution d'un programme
//*
//* Arguments		: String					asPrg			(Val)	Nom du Programme
//*					  UnsignedInteger		auiEtat		(Val) Type de lancement
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

Return WinExec ( asPrg, auiEtat )
end function

public function unsignedinteger uf_setactivewindow (unsignedinteger auihwnd);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_SetActiveWindow
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiHWnd		(Val)	Handle de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

Return SetActiveWindow ( auiHWnd )

end function

public function unsignedinteger uf_findwindow (string asclasse, string aswindow);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_FindWindow
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String					asClasse		(Val)	
//*					  String					asWindow		(Val) 
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

String sClasse, sWindow

sClasse	= asClasse
sWindow	= asWindow

Return FindWindow ( sClasse, sWindow )


end function

public function integer uf_getscrollpos (unsignedinteger auihwnd, integer aiscroll);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetScrollPos
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiHWnd		(Val)	Handle de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//*					  Integer				aiScroll		(Val) 
//*
//* Retourne		: Integer
//*								
//*
//*-----------------------------------------------------------------

Return GetScrollPos ( auiHWnd, aiScroll )

end function

public function long uf_getfreespace (unsignedinteger auitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetFreeSpace
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiType		(Val)	
//*
//* Retourne		: Long
//*								
//*
//*-----------------------------------------------------------------

Return GetFreeSpace ( auiType )

end function

public function unsignedinteger uf_getfreesystemresources (unsignedinteger auitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetFreeSystemResources
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiType		(Val)	
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

Return GetFreeSystemResources ( auiType )

end function

public subroutine uf_releasecapture ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ReleaseCapture
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*								
//*
//*-----------------------------------------------------------------

ReleaseCapture ()
end subroutine

public function unsignedinteger uf_setcapture (unsignedinteger auihwnd);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_SetCapture
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiHWnd		(Val)	Handle de la Fen$$HEX1$$ea00$$ENDHEX$$tre
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

Return SetCapture ( auiHWnd )

end function

public function unsignedinteger uf_loadmodule (string asmodule, s_loadparams astparam);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_LoadModule
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String					asModule		(Val)	Nom du Module
//*					  s_LoadParams			astParam		(Val) 
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

Return LoadModule ( asModule, astParam )
end function

public function integer uf_getprivateprofilestring (ref string assection, ref string asentry, ref string asdefaut, ref blob ablretour, unsignedinteger auibuffer, ref string asnomfic);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetPrivateProfileString
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String					asSection	(R$$HEX1$$e900$$ENDHEX$$f)	Nom de la Section
//*					  String					asEntry		(R$$HEX1$$e900$$ENDHEX$$f) 
//*					  String					asDefaut		(R$$HEX1$$e900$$ENDHEX$$f) 
//*					  Blob					ablRetour	(R$$HEX1$$e900$$ENDHEX$$f) 
//*					  UnsignedInteger		auiBuffer	(Val) 
//*					  String					asNomFic		(R$$HEX1$$e900$$ENDHEX$$f) 
//*
//* Retourne		: Integer
//*								
//*
//*-----------------------------------------------------------------

Return GetPrivateProfileString ( asSection, asEntry, asDefaut, ablRetour, auiBuffer, asNomFic )
end function

public subroutine uf_lzclose (unsignedinteger auific);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_LzClose
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiFic		(Val)	Handle du fichier
//*
//* Retourne		: Rien
//*								
//*
//*-----------------------------------------------------------------

LzClose ( auiFic )
end subroutine

public function string uf_getuser ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetUser
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du Login ID
//*
//* Arguments		: Aucun
//*
//* Retourne		: String       Login Name
//*								
//*
//*-----------------------------------------------------------------

String sLogin
UnsignedLong ulLng
Boolean bRet

ulLng		= 255
sLogin	= Space ( 255 )

bRet 		= This.GetUserNameA ( sLogin, ulLng )

sLogin	= Trim ( sLogin )

Return sLogin
end function

public function integer uf_gettempfilename (string asprefix, ref string astmpfilename);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetTempFileName
//* Auteur			: Le revrue
//* Date				: 04/02/1997
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Retourne un nom de fichier temporaire dans le
//*                 repertoire temporaire de windows
//* Commentaires	: 
//*
//* Arguments		: String		sPrefix		(Val)	Pr$$HEX1$$e900$$ENDHEX$$fix du fichier
//*					  String    sArgument   (Ref) Non du fichier
//*
//* Retourne		: Integer
//*								
//*
//*-----------------------------------------------------------------

asTmpFileName= Space( 255 )

//Migration PB8-WYNIWYG-03/2006 FM
//Return ( GetTempFileName( 0, asPrefix, 0, asTmpFileName ) )
Return ( GetTempFileNameA( 0, asPrefix, 0, asTmpFileName ) )
//Fin Migration PB8-WYNIWYG-03/2006 FM

end function

public function integer uf_setprofilestring (ref string asfichier, ref string assection, ref string ascle, ref string astext);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_setprofilestring
//* Auteur			:	La Recrue
//* Date				:	17/02/1997 16:05:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Ecrit dans un fichier ini Priv$$HEX2$$e9002000$$ENDHEX$$en utilisant les API
//* Commentaires	:	Si les arguments de cl$$HEX2$$e9002000$$ENDHEX$$et de et de text sont $$HEX2$$e0002000$$ENDHEX$$Null, 
//*						la cl$$HEX2$$e9002000$$ENDHEX$$et ou la section disparait du .INI ce que ne 
//*						fait pas la focntion SetprofileString de PB.
//*
//* Arguments		:	String	asFichier	(Ref)	Fichier INI
//*						String	asSection	(Ref) Section
//*						String	asCle			(Ref) Cl$$HEX2$$e9002000$$ENDHEX$$dans la section
//*						String	asText		(Ref) Text de la cl$$HEX2$$e9002000$$ENDHEX$$dans la section
//*
//* Retourne		:	Integer	1	le setProfileString $$HEX2$$e0002000$$ENDHEX$$fonctionn$$HEX1$$e900$$ENDHEX$$
//*									-1	Sinon
//*
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//If ( WritePrivateProfileString( asSection, asCle, asText, asFichier ) = 0 ) Then
If ( WritePrivateProfileStringA( asSection, asCle, asText, asFichier ) = 0 ) Then
//Fin Migration PB8-WYNIWYG-03/2006 FM
	Return ( -1 )

Else

	Return ( 1 )

End If


end function

public function integer uf_spbgetdevice (ref string asdrivername, ref string asdevicename, ref string asportname);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_spbgetdevice
//* Auteur			:	La Recrue
//* Date				:	13/03/1997 08:44:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de retrouver les param$$HEX1$$e800$$ENDHEX$$tres d'impression
//*						dela station cliente
//* Commentaires	:	
//*
//* Arguments		:	String	asDriverName	(Ref)	Nom du driver d'impression
//*						String	asDeviceName	(Ref)	Nom du device d'impression
//*						String	asPortName		(Ref)	Nom du port
//*
//* Retourne		:	Integer			< 0  Probl$$HEX1$$e800$$ENDHEX$$me pour determier l'imprimante
//*											
//*
//*-----------------------------------------------------------------

asDriverName	= ""
asDeviceName	= ""
asPortName		= ""

/*------------------------------------------------------------------*/
/* ### Il faut la d$$HEX1$$e900$$ENDHEX$$velopper en 32 BIT                              */
/*------------------------------------------------------------------*/

//Return ( SPBGetDevice( asDriverName, asDeviceName, asPortName) )

Return 0 
end function

public function unsignedinteger uf_wnetgetconnection (string asportname, ref string asnetqueuename, ref unsignedinteger auimaxnbcar);
//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_wnetgetconnection
//* Auteur			:	La Recrue
//* Date				:	13/03/1997 11:38:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de conna$$HEX1$$ee00$$ENDHEX$$tre le nom d'une queue d'impression
//*						rattach$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$un port LPT.
//* Commentaires	:	
//*
//* Arguments		:	String	asPortName		(Val)	Nom du port
//*						String	asNetQueueName	(Ref) Nom de la queue en r$$HEX1$$e900$$ENDHEX$$ception
//*						Uint		auiMaxNbCar		(Ref) Nombre Max de caract$$HEX1$$e800$$ENDHEX$$re pour le nom
//*
//* Retourne		:	Long				0 = Ok
//*											< 0  si non
//*
//*-----------------------------------------------------------------

asPortName		= ""
asNetQueueName	= ""
auiMaxNbCar		= 0


/*------------------------------------------------------------------*/
/* ### $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$velopper en 32                                           */
/*------------------------------------------------------------------*/

Return 0
end function

public function string uf_getversion ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_getversion
//* Auteur			:	La Recrue
//* Date				:	13/03/1997 09:01:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de d$$HEX1$$e900$$ENDHEX$$terminer la plaforme sur laquelle on
//*							se trouve
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	String		Le nom de la plateforme
//*
//*-----------------------------------------------------------------

Return ""

end function

public function string uf_getwindowsdirectory ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetWindowsDirectory
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: String 
//*								
//*
//*-----------------------------------------------------------------

ULong		ulSize = 260 
ULong		ulRet
String	sDir

sDir	= Space ( ulSize )
ulRet	= GetWindowsDirectoryA ( sDir, ulSize )

If	ulRet > 0	Then
	Return ( sDir )
Else
	Return ( "" )
End If
end function

public function string uf_getenvironment (string asvariable);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetEnvironment
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String			asVariable		(Val)	Variable d'environnement recherch$$HEX1$$e900$$ENDHEX$$e
//*
//* Retourne		: String			?			= Valeur r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e
//*										Inconnu	= La valeur n'existe pas
//*
//*-----------------------------------------------------------------

String sDest
Long lRet


sDest			= Space ( 128 )
asVariable	= "%" + asVariable + "%"
lRet			= ExpandEnvironmentStringsA ( asVariable, sDest, 127 )

If	lRet <= 0	Then
	Return ( "Inconnu" )
Else
	Return ( sDest )
End If

end function

public function integer uf_setfileattributes (ref string asnomfic, unsignedlong aulattrib);//*-----------------------------------------------------------------
//*
//* Fonction      : u_DeclarationWindows32::uf_SetFileAttributes (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 29/03/2004 17:10:50
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Modifie les attributs d'un fichier (32 bits)
//* Commentaires  : Valeurs d'attributs possible en Hexa 
//*
//*					 	 READONLY    01x
//*						 HIDDEN      02x
//*						 SYSTEM      04x
//*						 DIRECTORY   10x
//*						 ARCHIVE     20x
//*						 NORMAL      80x
//*						 TEMPORARY  100x
//*						 COMPRESSED 800x
//*						 OFFLINE   1000x
//*
//* Arguments     : String		asNomFic			R$$HEX1$$e900$$ENDHEX$$f
//*					  uLong		aulAttrib		Val
//*
//* Retourne      : Integer
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

Int iRet
Boolean	bRet

iRet = -1

bRet = SetFileAttributesA ( asNomFic, aulAttrib )

If bRet Then iRet = 1 

Return iRet 


end function

public function integer uf_emptyclipboard ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_EmptyClipBoard
//* Auteur			:	FMO
//* Date				:	10/05/2004
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de vider le presse-papier
//*						
//* Commentaires	:	r$$HEX1$$e900$$ENDHEX$$alis$$HEX1$$e900$$ENDHEX$$e lors des corrections de la migration PB4-PB8
//*						en se basant sur la fonction existant dans l'objet 16 bits
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Integer		Est-ce que le traitement c'est bien pass$$HEX1$$e900$$ENDHEX$$
//*
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
Integer iRet, iHandleWindow

iHandleWindow = Handle ( w_euro_luc )

/*----------------------------------------------------------*/
/* Pour pouvoir vider le presse papier                      */
/* Il faut : Ouvrir le Presse Papier                        */
/*           Vider  le Presse Papier                        */
/*           Fermer le Presse Papier                        */
/*----------------------------------------------------------*/
iRet = OpenClipBoard ( iHandleWindow )

If iRet <> 0 Then	iRet = EmptyClipBoard ()

If iRet <> 0 Then iRet = CloseClipBoard ()

Return iRet
//Fin Migration PB8-WYNIWYG-03/2006 FM
end function

public function long uf_createmutex (boolean abinitial, ref string asnomapplication);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_CreateMutex
//* Auteur			:	PHG
//* Date				:	05/05/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX1$$e900$$ENDHEX$$e un mutex ( mutually exclusive )
//*						pour detecter le nombre de lancement d'application
//* Commentaires	:	[DETECTEAPPLI] VErsion 32 Bit
//*
//* Arguments		:	booelan		abInitial Etat Initial
//*						Ref String	asNomApplication Nom de l'application
//*
//* Retourne		:	Long				0 = Ok
//*											< 0  si non
//*
//*-----------------------------------------------------------------


return CreateMutex(0, abInitial, asnomApplication)
end function

public function integer uf_closehandle (unsignedlong aul_lutex);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_CloseHandle()
//* Auteur			:	PHG
//* Date				:	05/05/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Libere la ressource point$$HEX1$$e900$$ENDHEX$$e par le handle
//*						
//* Commentaires	:	[DETECTEAPPLI] Version 32 bit
//*
//* Arguments		:	ulong	aul_lutex handle de la ressource a tuer.
//*
//* Retourne		:	integer				0 = Ok
//*											< 0  si non
//*
//*-----------------------------------------------------------------

return CloseHandle(aul_lutex)

end function

public function integer uf_getlasterror ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_GetLastError()
//* Auteur			:	PHG
//* Date				:	05/05/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	retourne le dernier numero d'erreur systeme
//* Commentaires	:	[DETECTEAPPLI] Version 32 bit
//*
//* Arguments		:	
//*
//* Retourne		:	Long				0 = Ok
//*											< 0  si non
//*
//*-----------------------------------------------------------------

return GetLastError()
end function

protected function integer f_convertfiledatetimetopb (s_filedatetime astr_filetime, ref date ad_date, ref time at_time);//////////////////////////////////////////////////////////////////////////////
//	Protected Function:  f_ConvertFileDatetimeToPB
//	Arguments:		astr_FileTime		The s_filedatetime structure containing the system date/time for the file.
//						ad_Date				The file date in PowerBuilder Date format	passed by reference.
//						at_Time				The file time in PowerBuilder Time format	passed by reference.
//	Returns:			Integer
//						1 if successful, -1 if an error occurrs.
//	Description:	Convert a sytem file type to PowerBuilder Date and Time.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Version
//						5.0   Initial version
//						5.0.03	Fixed - function would fail under some international date formats
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
string				ls_Time
s_filedatetime		lstr_LocalTime
s_systemtime		lstr_SystemTime

If Not FileTimeToLocalFileTime(astr_FileTime, lstr_LocalTime) Then Return -1

If Not FileTimeToSystemTime(lstr_LocalTime, lstr_SystemTime) Then Return -1

// works with all date formats
ad_Date = Date(lstr_SystemTime.ul_yar, lstr_SystemTime.ul_Month, lstr_SystemTime.ul_Day)

ls_Time = String(lstr_SystemTime.ul_Hour) + ":" + &
			 String(lstr_SystemTime.ul_Minute) + ":" + &
			 String(lstr_SystemTime.ul_Second) + ":" + &
			 String(lstr_SystemTime.ul_Millisecond)
at_Time = Time(ls_Time)

Return 1
end function

public function integer uf_getlastwritedatetime (string asfichier, ref date addate, ref time attime);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  uf_GetLastWriteDatetime
//	Arguments:		as_FileName			The name of the file for which you want its date
//												and time; an absolute path may be specified or it
//												will be relative to the current working directory
//						ad_Date				The date the file was last modified, passed by reference.
//						at_Time				The time the file was last modified, passed by reference.
//	Returns:			Integer
//						1 if successful, -1 if an error occurrs.
//	Description:	Get the date and time a file was last modified.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Version
//						5.0 	Initial version
//						5.0.03	Changed long variables to Ulong for NT4.0 compatibility
//						8.0 	Changed datatype of lul_handle to long ll_handle
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
long			ll_handle
s_filedata	lstr_FindData

// Get the file information
ll_handle = FindFirstFileA(asFichier, lstr_FindData)
If ll_handle <= 0 Then Return -1
FindClose(ll_handle)

// Convert the date and time
Return f_ConvertFileDatetimeToPB(lstr_FindData.str_LastWriteTime, adDate, atTime)

end function

public function integer uf_setlastwritedatetime (string asfichier, date addate, time attime);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  uf_SetLastWriteDatetime
//	Arguments:		as_FileName				The name of the file to be updated.
//						ad_FileDate				The date to be set.
//						at_FileTime				The time to be set.
//	Returns:			Integer
//						1 if successful,
//						-1 if an error occurrs.
//	Description:	Set the Date/Time stamp on a file.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Version
//						5.0		Initial version
//						5.0.03	Changed long variables to Ulong for NT4.0 compatibility
//						8.0 	Changed datatype of lul_handle to long ll_handle
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
boolean lb_Ret
long ll_handle
s_FileDateTime lstr_FileTime, lstr_Empty
s_FileData lstr_FindData
s_FileOpenInfo lstr_FileInfo

// Get the file information.
// This is required to keep the Last Access date from changing.
// It will be changed by the OpenFile function.
ll_handle = FindFirstFileA(asFichier, lstr_FindData)
If ll_handle <= 0 Then Return -1
FindClose(ll_handle)

// Convert the date and time
If f_ConvertPBDatetimeToFile(adDate, atTime, lstr_FileTime) < 0 Then Return -1

// Set the file structure information
lstr_FileInfo.c_fixed_disk = "~000"
lstr_FileInfo.c_pathname = asFichier
lstr_FileInfo.c_length = "~142"

// Open the file
ll_handle = OpenFile ( asFichier, lstr_FileInfo, 2 ) 
If ll_handle < 1 Then Return -1
 
lb_Ret = SetFileTime(ll_handle, lstr_Empty, lstr_FindData.str_LastAccessTime, lstr_FileTime)
CloseHandle(ll_handle)
If lb_Ret Then
	Return 1
Else
	Return -1
End If
end function

protected function integer f_convertpbdatetimetofile (date ad_filedate, time at_filetime, ref s_filedatetime astr_filedatetime);//////////////////////////////////////////////////////////////////////////////
//	Protected Function:  f_ConvertPBDatetimeToFile
//	Arguments:		ad_FileDate			The file date in PowerBuilder Date format.
//						at_FileTime			The file time in PowerBuilder Time format.
//						astr_FileTime		The os_filedatetime structure to contain the
//												system date/time for the file, passed by reference.
//	Returns:			Integer
//						1 if successful, -1 if an error occurrs.
//	Description:	Convert PowerBuilder Date and Time to the sytem file type.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Version
//						5.0   Initial version
//						5.0.03	Fix problem with century not being on the year passed in
//						6.0.01	Fix millisecond overflow.  Change size of string to 3 digits from 6 
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
string				ls_Time
unsignedinteger	lui_year, lui_test
s_FileDateTime	lstr_LocalTime
s_SystemTime	lstr_SystemTime

// fix problem when year without century passed in
lui_year = Integer(String(ad_FileDate,'yyyy'))
lui_test = Year(ad_filedate)
if lui_year < 50 then
	lui_year = lui_year + 2000
elseif lui_year < 100 then
	lui_year = lui_year + 1900
end if 

// make sure year with century is passed in
lstr_SystemTime.ul_yar = lui_year
lstr_SystemTime.ul_Month = month(ad_FileDate)
lstr_SystemTime.ul_Day = day(ad_FileDate)

ls_Time = String(at_FileTime, "hh:mm:ss:fff")
lstr_SystemTime.ul_Hour = Long(Left(ls_Time, 2))
lstr_SystemTime.ul_Minute = Long(Mid(ls_Time, 4, 2))
lstr_SystemTime.ul_Second = Long(Mid(ls_Time, 7, 2))
lstr_SystemTime.ul_Millisecond = Long(Right(ls_Time, 3))

If Not SystemTimeToFileTime(lstr_SystemTime, lstr_LocalTime) Then Return -1

If Not LocalFileTimeToFileTime(lstr_LocalTime, astr_FileDateTime) Then Return -1

Return 1

end function

public function unsignedinteger uf_spbfwrite (unsignedinteger auihandlefile, ref blob ablbuf, unsignedinteger auinbbyte);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  uf_SPBfWrite
//	Arguments:		auiHandleFile			Handle du fichier dans lequel $$HEX1$$e900$$ENDHEX$$crire.
//						ablbuf					Blob conten,ant les donn$$HEX1$$e900$$ENDHEX$$es $$HEX3$$e0002000e900$$ENDHEX$$crire.
//						auinbbyte				Nombre d'octets $$HEX3$$e0002000e900$$ENDHEX$$crire
//													
//	Returns:			UnsignedInteger
//						1 if successful, -1 if an error occurrs.
//	Description:	Open, write from a blob, and close a file.  Handles blobs > 32,765 bytes.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Version
//						5.0   Initial version
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
integer li_FileNo, li_Writes, li_Cnt
long ll_BlobLen, ll_CurrentPos
blob lblb_Data
writemode lwm_Mode

//If ab_Append Then
//	lwm_Mode = Append!
//Else
//	lwm_Mode = Replace!
//End if
//
//li_FileNo = FileOpen(as_FileName, StreamMode!, Write!, LockReadWrite!, lwm_Mode)
//If li_FileNo < 0 Then Return -1
//
ll_BlobLen = Len(ablbuf)
//ll_BlobLen = auinbbyte

// Determine the number of writes required to write the entire blob
If ll_BlobLen > 32765 Then
	If Mod(ll_BlobLen, 32765) = 0 Then
		li_Writes = ll_BlobLen / 32765
	Else
		li_Writes = (ll_BlobLen / 32765) + 1
	End if
Else
	li_Writes = 1
End if

ll_CurrentPos = 1

For li_Cnt = 1 To li_Writes
	lblb_Data = BlobMid(ablbuf, ll_CurrentPos, 32765)
	ll_CurrentPos += 32765
	If FileWrite(li_FileNo, lblb_Data) = -1 Then
		Return -1
	End if
Next

FileClose(li_FileNo)

Return 1
end function

public function unsignedinteger uf_getactivewindow ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetActiveWindow
//* Auteur			: FM WYNIWYG
//* Date				: 07/06/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

Return GetActiveWindow()

end function

public function long uf_filecount (string aspattern, long alattrib);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_FileCount
//* Auteur			: PHG
//* Date				: 07/10/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [I037] Remplacement des fonctuion funcky Eponyme.
//*					  Version Win32
//*
//* Arguments		: String					asClasse		(Val)	
//*					  String					asWindow		(Val) 
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

boolean					lb_Found
long						ll_Entries
long						ll_handle
s_filedata				lstr_FileData

// List the entries in the directory
ll_handle = FindFirstFileA(asPattern, lstr_FileData)
If ll_handle <= 0 Then Return -1
Do
	ll_Entries ++
	lb_Found = FindNextFileA(ll_handle, lstr_FileData)
Loop Until Not lb_Found

FindClose(ll_handle)

Return ll_Entries
end function

public function integer uf_frename (string as_sourcefile, string as_targetfile);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_fRename
//* Auteur			: PHG
//* Date				: 07/10/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [I037] Remplacement des fonction funcky Eponyme.
//*					 Version Win32
//*
//* Arguments		: String					asClasse		(Val)	
//*					  String					asWindow		(Val) 
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

If MoveFileA(as_SourceFile, as_TargetFile) Then
	Return 1
Else
	Return -1
End If

end function

public function integer uf_feraseall (string asfic);//*-----------------------------------------------------------------
//*
//* Fonction		: U_DeclarationFuncky::Uf_fEraseAll ( PUBLIC )
//* Auteur			: PHG
//* Date				: 07/10/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [I037] Migration Funcky
//* Commentaires	: Suppression de tous les fichier sp$$HEX1$$e900$$ENDHEX$$cifi$$HEX1$$e900$$ENDHEX$$s d'un r$$HEX1$$e900$$ENDHEX$$pertoire
//*					  Version Ancetre
//* Arguments		: String			asFic				(Val)	Fichier $$HEX2$$e0002000$$ENDHEX$$supprimer
//*
//* Retourne		: Integer		 ? = Nombre de fichiers supprim$$HEX1$$e900$$ENDHEX$$s
//*										 0 = Aucun fichier ou Erreur
//*
//*-----------------------------------------------------------------

long			ll_res, ll_deleted, ll_pos
boolean		lb_res
s_filedata	lstr_FileData
string		ls_path, ls_filename

lstr_FileData.ul_fileattribute = 100
ll_deleted = 0
ll_pos =LastPos(asfic, "\")
ls_path = left(asfic, ll_pos)	//chemin du fichier ex : C:\WINNT\TEMP\

ll_res = FindFirstFileA(asfic, lstr_FileData)

if ll_res = -1 then
	ll_deleted = -1
else
	ls_filename = ls_path + lstr_FileData.s_filename
	lb_res = FileDelete(ls_filename)
	if lb_res then ll_deleted = ll_deleted + 1
	
	do while FindNextFileA(ll_res, lstr_FileData)
		ls_filename = ls_path + lstr_FileData.s_filename
		lb_res = FileDelete(ls_filename)
		if lb_res then ll_deleted = ll_deleted + 1
	loop
end if

lb_res = FindClose(ll_res)

return ll_deleted

end function

on u_declarationwindows32.create
call super::create
end on

on u_declarationwindows32.destroy
call super::destroy
end on

