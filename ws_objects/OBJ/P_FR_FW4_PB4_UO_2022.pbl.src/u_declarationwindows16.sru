HA$PBExportHeader$u_declarationwindows16.sru
$PBExportComments$----} UserObjet pour les d$$HEX1$$e900$$ENDHEX$$clarations externes Windows
forward
global type u_declarationwindows16 from u_declarationwindows
end type
end forward

global type u_declarationwindows16 from u_declarationwindows
end type
global u_declarationwindows16 u_declarationwindows16

type prototypes
// Fonctions Windows

Function Boolean	              BringWindowToTop( Uint uiHwnd ) Library "USER.EXE"
Function Boolean 	              EnableWindow (Uint uiHwnd,Boolean bEnable) Library "USER.EXE"
Function UInt 		GetDc (UInt uiHwnd) Library "USER.EXE"
Function Int 		GetModuleHandle(String sModuleName) Library "KERNEL.EXE" alias for "GetModuleHandle;Ansi"
Function Int		GetModuleFileName(UInt uiHwnd, Ref String szFilename, Int NbMax)  Library "KERNEL.EXE" alias for "GetModuleFileName;Ansi"
Function Uint 		GetStockObject (int iObj) library "GDI.EXE"
Function Int 		GetTextFace (Uint uiHdc,Int iSizeof, Ref String sFace) library "GDI.EXE" alias for "GetTextFace;Ansi"
Function Boolean 	              GetTextMetrics (Uint uiHdc,Ref s_txtmetrics stTextMet) library "GDI.EXE" alias for "GetTextMetrics;Ansi"
Function Uint 		GetWindow (Uint uiHwnd,Uint uiFlag) library "USER.EXE"
Function Boolean 	              IsWindowEnabled (Uint uiHwnd ) library "USER.EXE"
Subroutine  		LZClose (Uint uiHfile) library "LZexpand.dll"
Function Uint 		LZCopy  (Uint uiSrc,Uint uiDest) library "LZexpand.dll"
Function Uint 		LZOpenfile (String sFileName,s_Ofstruct stStruct,Uint uiMode) library "LZexpand.dll" alias for "LZOpenfile;Ansi"
Function Int 		ReleaseDc (UInt uiHwnd, Uint uiHdc) Library "USER.EXE"
Function Uint 		SelectObject (Uint uiHdc,Uint uiHobj) library "GDI.EXE"
Function Uint 		SetFocus (Uint uiHwnd) library "USER.EXE"
Function Uint 		GetFocus () library "USER.EXE"
Function UInt		GetActiveWindow () Library "USER.EXE"
Function Boolean 	              ShowWindow (Uint uiHwnd,Int iFlag) Library "USER.EXE"
Function Int		GetSystemMetrics( Int iSysMetr ) Library "USER.EXE"
Function Uint		SpoolFile ( String sImp, String sPort, String sJob, String sFic ) Library "GDI.EXE" alias for "SpoolFile;Ansi"
Function Uint		Winexec	( String sPrg, Uint	uiEtat ) Library "KERNEL.EXE" alias for "Winexec;Ansi"
Function UInt		SetActiveWindow ( UInt uiHwnd ) Library "USER.EXE"
Function UInt		FindWindow ( String sClassName, String sWindowName ) Library "USER.EXE" alias for "FindWindow;Ansi"
Function Int		GetScrollPos( UInt uiHwnd,Int iScroll) Library "USER.EXE"
Function Long		GetFreeSpace( UInt uiNotUsed ) Library "KERNEL.EXE"
Function UInt		GetFreeSystemResources( UInt uiTypeRessource ) Library "USER.EXE"
Subroutine 		ReleaseCapture( ) library "USER.EXE"
Function Uint 		SetCapture(uint win_hand) library "USER.EXE"
Function Int		GetPrivateProfileString( ref string sSection, ref string sEntry, ref string sDefaut, ref blob blRetour, uint uiBuffer, ref string sNomFic ) Library "KERNEL.EXE" alias for "GetPrivateProfileString;Ansi"
Function Uint 		LoadModule (String sModule, s_LoadParams stLoadParams) Library "KERNEL.EXE" alias for "LoadModule;Ansi"
Function Int 		WNetGetUser ( ref String sUserId, ref uint uiLng ) Library "USER.EXE" alias for "WNetGetUser;Ansi"
Function Int		GetTempFileName( Uint uiDrive, String sPrefixe, uint uiUnique, Ref String sTempFileName )  LIBRARY "KERNEL.EXE" alias for "GetTempFileName;Ansi"
Function Int		WritePrivateProfileString( ref string sSection, ref string sEntry, ref string sString, ref string sNomFic ) Library "KERNEL.EXE" alias for "WritePrivateProfileString;Ansi"

Function int		DBI ( Ref String sChaine, Ref s_Creer_Dw stCol [], ref s_Parametre sPar ) LIBRARY "DW.DLL" alias for "DBI;Ansi"
Function int		SPBGetDevice( Ref String lpszDriverName, Ref String lpszDeviceName, Ref String lpszPortName) LIBRARY "DW.DLL" alias for "SPBGetDevice;Ansi"
Function Uint		SPBFwrite( uint iHandleFile, Ref blob blBuf, uint uiNbByte ) LIBRARY "DW.DLL"

Function Ulong		GetVersion( ) LIBRARY "KERNEL.EXE"
Function Uint		WNetGetConnection( String sPortName, Ref String sNetQueueName, Ref uint nbMaxByte  ) LIBRARY "USER.EXE" alias for "WNetGetConnection;Ansi"

Function int 		EmptyClipboard ( )  Library "USER.EXE"
Function int		OpenClipboard  (Int hWnd) Library "USER.EXE" 
Function int		CloseClipboard () Library "USER.EXE" 

Function int		GetFileDateTime (string filename, ref string date, ref string time ) Library "PFCFLSRV.DLL" alias for "GetFileDateTime;Ansi"
Function int		SetFileDateTime (string filename, uint newdate, uint newtime ) Library "PFCFLSRV.DLL" alias for "SetFileDateTime;Ansi"

Function	Integer		GetWindowsDirectory (Ref String sBuffer, integer iSize) Library "KERNEL.EXE" alias for "GetWindowsDirectory;Ansi"
Function	Long		GetDosEnvironment () Library "KRNL386.EXE"
Function	String		AnsiUpper (Long lAddress) Library "USER.EXE" alias for "AnsiUpper;Ansi"
Function boolean 		SetFileAttributes (ref string filename, ulong attrib) library "KERNEL.EXE" alias for "SetFileAttributes;Ansi"

end prototypes

forward prototypes
public function boolean uf_bringwindowtotop (unsignedinteger auihwnd)
public function boolean uf_enablewindow (unsignedinteger auihwnd, boolean abenable)
public function unsignedinteger uf_getdc (unsignedinteger auihwnd)
public function integer uf_getmodulehandle (string asnommodule)
public function integer uf_getmodulefilename (unsignedinteger auihwnd, ref string asnomfic, integer ainbmax)
public function unsignedinteger uf_getstockobject (integer aiobj)
public function integer uf_gettextface (unsignedinteger auihdc, integer aitaille, ref string asface)
public function boolean uf_gettextmetrics (unsignedinteger auihdc, ref s_txtmetrics astmetrics)
public function unsignedinteger uf_getwindow (unsignedinteger auihwnd, unsignedinteger auiflag)
public function boolean uf_iswindowenabled (unsignedinteger auihwnd)
public function unsignedinteger uf_lzcopy (unsignedinteger auisrc, unsignedinteger auidest)
public function unsignedinteger uf_lzopenfile (string asnomfic, s_ofstruct aststruct, unsignedinteger auimode)
public function integer uf_releasedc (unsignedinteger auihwnd, unsignedinteger auihdc)
public function unsignedinteger uf_selectobject (unsignedinteger auihdc, unsignedinteger auihobj)
public function unsignedinteger uf_setfocus (unsignedinteger auihwnd)
public function boolean uf_showwindow (unsignedinteger auihwnd, integer aiflag)
public function integer uf_getsystemmetrics (integer aisysmet)
public function unsignedinteger uf_spoolfile (string asimp, string asport, string asjob, string asfic)
public function unsignedinteger uf_winexec (string asprg, unsignedinteger auietat)
public function unsignedinteger uf_setactivewindow (unsignedinteger auihwnd)
public function integer uf_getscrollpos (unsignedinteger auihwnd, integer aiscroll)
public function long uf_getfreespace (unsignedinteger auitype)
public function unsignedinteger uf_getfreesystemresources (unsignedinteger auitype)
public subroutine uf_releasecapture ()
public function unsignedinteger uf_setcapture (unsignedinteger auihwnd)
public function unsignedinteger uf_loadmodule (string asmodule, s_loadparams astparam)
public function integer uf_getprivateprofilestring (ref string assection, ref string asentry, ref string asdefaut, ref blob ablretour, unsignedinteger auibuffer, ref string asnomfic)
public subroutine uf_lzclose (unsignedinteger auific)
public function unsignedinteger uf_findwindow (string asclasse, string aswindow)
public function string uf_getuser ()
public function integer uf_gettempfilename (string asprefix, ref string astmpfilename)
public function integer uf_dbi (ref string aschaine, ref s_creer_dw astcol[], ref s_parametre astpar)
public function integer uf_setprofilestring (ref string asfichier, ref string assection, ref string ascle, ref string astext)
public function integer uf_spbgetdevice (ref string asDriverName, ref string asDeviceName, ref string asPortName)
public function unsignedinteger uf_wnetgetconnection (string asPortName, ref String asNetQueueName, ref unsignedinteger auiNbMaxCar)
public function unsignedinteger uf_spbfwrite (unsignedinteger auihandlefile, ref blob ablbuf, unsignedinteger auinbbyte)
public function string uf_getversion ()
public function integer uf_emptyclipboard ()
public function integer uf_setlastwritedatetime (string asFichier, date adDate, Time atTime)
public function integer uf_getlastwritedatetime (string asFichier, ref date adDate, ref time atTime)
public function unsignedinteger uf_getfocus ()
public function unsignedinteger uf_getactivewindow ()
public function string uf_getwindowsdirectory ()
public function string uf_getenvironment (string asvariable)
public function integer uf_setfileattributes (ref string asnomfic, ulong aulattrib)
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

Return GetDc ( auiHWnd )
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

public function boolean uf_gettextmetrics (unsignedinteger auihdc, ref s_txtmetrics astmetrics);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetTextMetrics
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: UnsignedInteger		auiHDc		(Val)	Handle du device context
//*					  s_TxtMetrics			astMetrics	(R$$HEX1$$e900$$ENDHEX$$f) 
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*								
//*
//*-----------------------------------------------------------------

Return GetTextMetrics ( auiHDc, astMetrics )
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

public function unsignedinteger uf_lzopenfile (string asnomfic, s_ofstruct aststruct, unsignedinteger auimode);//*-----------------------------------------------------------------
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

Return LzOpenFile ( asNomFic, astStruct, auiMode )
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

Return ReleaseDc ( auiHWnd, auiHDc )
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
UnsignedInteger uiLng
Integer iRet

uiLng = 255
sLogin = Space ( 255 )

iRet = This.WNetGetUser ( sLogin, uiLng )

sLogin = Trim ( sLogin )

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

Return ( GetTempFileName( 0, asPrefix, 0, asTmpFileName ) )
end function

public function integer uf_dbi (ref string aschaine, ref s_creer_dw astcol[], ref s_parametre astpar);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_dbi
//* Auteur			:	La Recrue
//* Date				:	05/03/1997 11:29:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Fonction appelent DBI dans DW.DLL
//* Commentaires	:	D$$HEX1$$e900$$ENDHEX$$port$$HEX2$$e9002000$$ENDHEX$$de u_datawindow_d$$HEX1$$e900$$ENDHEX$$tail
//*
//* Arguments		:	String		asChaine	Ref
//*						s_creer_dw	astCol	Ref
//*						s_parametre	astPar	Ref
//*						
//* Retourne		:	le rtour de DBI
//*						
//*
//*-----------------------------------------------------------------


Return DBI( asChaine, astCol, astPar )

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

If ( WritePrivateProfileString( asSection, asCle, asText, asFichier ) = 0 ) Then

	Return ( -1 )

Else

	Return ( 1 )

End If



end function

public function integer uf_spbgetdevice (ref string asDriverName, ref string asDeviceName, ref string asPortName);//*-----------------------------------------------------------------
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

Return ( SPBGetDevice( asDriverName, asDeviceName, asPortName) )
end function

public function unsignedinteger uf_wnetgetconnection (string asPortName, ref String asNetQueueName, ref unsignedinteger auiNbMaxCar);
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
//*						Uint		auiNbMaxCar		(Ref) Nombre Max de caract$$HEX1$$e800$$ENDHEX$$re pour le nom
//*
//* Retourne		:	Long				0 = Ok
//*											< 0  si non
//*
//*-----------------------------------------------------------------

Return ( WNetGetConnection( asPortName, asNetQueueName, auiNbMaxCar ) )
end function

public function unsignedinteger uf_spbfwrite (unsignedinteger auihandlefile, ref blob ablbuf, unsignedinteger auinbbyte);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_spbfwrite
//* Auteur			:	La Recrue
//* Date				:	13/03/1997 12:22:23
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	Permet d'$$HEX1$$e900$$ENDHEX$$cire dans un fichier grace un Handle
//*						ouvert par une fonction externe
//*
//* Arguments		:	uint	auiHandleFile	(Val)	Handle de fichier
//*						Blob	ablBuf			(Ref) Information $$HEX2$$e0002000$$ENDHEX$$ecrire
//*						uint	auiNbByte		(Val)	Nombre d'octet $$HEX2$$e0002000$$ENDHEX$$ecrire
//*
//* Retourne		:	uint		Nombre d'octet ecrit
//*									-1 = probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

Return ( SPBFwrite( auiHandleFile, ablBuf, auiNbByte ) )
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

ULong ulPlateforme
Uint  uiPlateforme

ulPlateforme = GetVersion ()

uiPlateforme = IntHigh ( ulPlateforme )

uiPlateforme = Int ( uiPlateforme /256 )

Choose Case uiPlateforme

	Case 5

		Return( "Windows NT4" )		

	Case 6

		Return( "Windows 3.1" )		

	Case 7

		Return( "Windows 95" )		

End Choose

Return ""

end function

public function integer uf_emptyclipboard ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_EmptyClipBoard
//* Auteur			:	PLJ
//* Date				:	28/04/1999
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Permet de vider le presse-papier
//*						
//* Commentaires	:	
//*
//* Arguments		:	Aucun
//*
//* Retourne		:	Boolean		Est-ce que le traitement c'est bien pass$$HEX1$$e900$$ENDHEX$$
//*
//*-----------------------------------------------------------------

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
end function

public function integer uf_setlastwritedatetime (string asFichier, date adDate, Time atTime);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetLastwriteDatetime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file whose date is to be set;
//									an absolute path may be specified or it will
//									be relative to the current working directory.
//	ad_Date						The date to be set.
//	at_Time						The time to be set.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Set the date and time on a file.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.03	Fixed problem with seconds doubling.  Dos only stores 0-29 seconds 
//				so seconds will also always be an even number.  Added calc comments
//	5.0.03	Fix Problem with Century not being on the year portion of a date
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_RC, li_Mon, li_DD, li_YY, li_HH, li_MM, li_SS
Uint		lui_Date, lui_Time
String	ls_Time, ls_Date

ls_Date = String(adDate, "mmddyyyy")
ls_Time = String(atTime, "hhmmss")

li_Mon = Integer(Left(ls_Date, 2))
li_DD = Integer(Mid(ls_Date, 3, 2))
li_YY = Integer(Right(ls_Date, 4))

// fix problem with century not being passed in
if li_YY < 50 then
	li_YY = li_YY + 2000
elseif li_YY < 100 then
	li_YY = li_YY + 1900
end if


//The date consists of the year, month and day packed into 16 bits as follows:
//	bits 0-4	Day (1-31)	bits 5-8 Month (1-12)	bits 9-15 Year (0-119 representing 1980-2099)
lui_Date = ((li_YY - 1980) * 512) + (li_Mon * 32) + li_DD

li_HH = Integer(Left(ls_Time, 2))
li_MM = Integer(Mid(ls_Time, 3, 2))
li_SS = Integer(Right(ls_Time, 2))

//The time consists of the hour, minute and seconds/2 packed into 16 bits as follows:
//	bits 0-4 Seconds/2 (0-29)	bits 5-10 Minutes (0-59)	bits 11-15 Hours (0-23)
lui_Time = (li_HH * 2048) + (li_MM * 32) + Int(li_SS/2)

li_RC = SetFileDateTime(asFichier, lui_Date, lui_Time)

Return li_RC
end function

public function integer uf_getlastwritedatetime (string asFichier, ref date adDate, ref time atTime);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetLastwriteDatetime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file for which you want its date
//									and time; an absolute path may be specified or it
//									will be relative to the current working directory
//	ad_Date						The date the file was last modified, passed by reference.
//	at_Time						The time the file was last modified, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get the date and time a file was last modified.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.03	Fixed - function would fail under some international date formats
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_Date, ls_Time
string	ls_yy, ls_mm, ls_dd

ls_Date = Space(12)
ls_Time = Space(10)

If GetFileDateTime(asFichier, ls_Date, ls_Time) <> 0 Then Return -1

//date is returned as "2/1/1996"  Make it format neutral for internationalization
ls_yy = right(ls_date,4)
ls_mm = left(ls_date,2)
if right(ls_mm,1) = "/" then
	ls_dd = mid(ls_date,3,2)
	ls_mm = left(ls_mm,1)
else
	ls_dd = mid(ls_date,4,2)
end if
if right(ls_dd,1) = "/" then
	ls_dd = left(ls_dd,1)
end if

adDate = Date(integer(ls_yy), integer(ls_mm), integer(ls_dd))
atTime = Time(ls_Time)

Return 1

end function

public function unsignedinteger uf_getfocus ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetFocus
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

Return GetFocus ()

end function

public function unsignedinteger uf_getactivewindow ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetActiveWindow
//* Auteur			: Erick John Stark
//* Date				: 10/11/1996 19:46:39
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

Return GetActiveWindow ()

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

ULong		ulSize
ULong		ulRet
String	sDir

ulSize	= 144
sDir		= Space ( ulSize )

ulRet		= GetWindowsDirectory ( sDir, ULSize )

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

Long	lRet
Integer	iLen
String	sValeur


lRet	= GetDosEnvironment ()

asVariable	= Upper ( asVariable ) + "="
iLen			= Len ( asVariable )

sValeur		= AnsiUpper ( lRet )

Do	While sValeur <> ""
	
	If	Left ( sValeur + "=", iLen ) = asVariable	Then
		Return ( Mid ( sValeur, iLen + 1 ) )
		
	Else
		lRet	+= Len ( sValeur ) + 1
		sValeur	= AnsiUpper ( lRet )
	End If
Loop

Return ( "Inconnu" )


end function

public function integer uf_setfileattributes (ref string asnomfic, ulong aulattrib);//*-----------------------------------------------------------------
//*
//* Fonction      : u_DeclarationWindows16::uf_SetFileAttributes (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 26/03/2004 17:10:50
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Modifie les attributs d'un fichier (16 bits)
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
//*					  ulong		aulAttrib		Val
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

bRet = SetFileAttributes ( asNomFic, aulAttrib )

If bRet Then iRet = 1 

Return iRet 


end function

on u_declarationwindows16.create
TriggerEvent( this, "constructor" )
end on

on u_declarationwindows16.destroy
TriggerEvent( this, "destructor" )
end on

