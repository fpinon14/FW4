HA$PBExportHeader$u_declarationwindows.sru
$PBExportComments$----} UserObjet pour les d$$HEX1$$e900$$ENDHEX$$clarations externes Windows
forward
global type u_declarationwindows from nonvisualobject
end type
end forward

global type u_declarationwindows from nonvisualobject
end type
global u_declarationwindows u_declarationwindows

type variables
// PHG [DETECTEAPPLI]
Private:
ulong ul_hMutex
end variables

forward prototypes
public function boolean uf_bringwindowtotop (unsignedinteger auihwnd)
public function boolean uf_enablewindow (unsignedinteger auihwnd, boolean abenable)
public function unsignedinteger uf_getdc (unsignedinteger auihwnd)
public function integer uf_getmodulehandle (string asnommodule)
public function integer uf_getmodulefilename (unsignedinteger auihwnd, ref string asnomfic, integer ainbmax)
public function unsignedinteger uf_getstockobject (integer aiobj)
public function integer uf_gettextface (unsignedinteger auihdc, integer aitaille, ref string asface)
public function unsignedinteger uf_getwindow (unsignedinteger auihwnd, unsignedinteger auiflag)
public function boolean uf_iswindowenabled (unsignedinteger auihwnd)
public function unsignedinteger uf_lzcopy (unsignedinteger auisrc, unsignedinteger auidest)
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
public function integer uf_setprofilestring (ref string asfichier, ref string assection, ref string ascle, ref string astext)
public function integer uf_dbi (ref string aschaine, ref s_creer_dw astcol[], ref s_parametre astpar)
public function integer uf_spbgetdevice (ref string asdrivername, ref string asdevicename, ref string asportname)
public function String uf_getversion ()
public function unsignedinteger uf_wnetgetconnection (string asportname, ref string asnetqueuename, ref unsignedinteger auinbmaxcar)
public function unsignedinteger uf_spbfwrite (unsignedinteger auihandlefile, ref blob ablbuf, unsignedinteger auinbbyte)
public function integer uf_setlastwritedatetime (string asfichier, date addate, time attime)
public function integer uf_getlastwritedatetime (string asFichier, ref date adDate, ref time atTime)
public function integer uf_emptyclipboard ()
public function unsignedinteger uf_getfocus ()
public function unsignedinteger uf_getactivewindow ()
public function string uf_getwindowsdirectory ()
public function string uf_getenvironment (string asvariable)
public function integer uf_setfileattributes (ref string asnomfic, unsignedlong aulattrib)
public function boolean uf_gettextmetrics (unsignedinteger auihdc, ref s_txtmetrics_pb8 astmetrics)
public function unsignedinteger uf_lzopenfile (string asnomfic, s_ofstruct32 aststruct, unsignedinteger auimode)
public function long uf_createmutex (boolean abinitial, ref string asnomapplication)
public function integer uf_getlasterror ()
public function integer uf_closehandle (unsignedlong aul_lutex)
public subroutine uf_setmutexref (unsignedlong aul_hmutex)
public function ulong uf_getmutexref ()
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

auiHWnd = 0

Return False
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

auiHWnd		= 0
abEnable 	= False

Return False
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

auiHWnd = 0

Return 0
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

asNomModule = ""

Return 0
end function

public function integer uf_getmodulefilename (unsignedinteger auihwnd, ref string asnomfic, integer ainbmax);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetModuleHandle
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

auiHWnd		= 0
asNomFic		= ""
aiNbMax		= 0

Return 0
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

aiObj	= 0

Return 0
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

auiHDc	= 0
aiTaille	= 0
asFace	= ""

Return 0
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

auiHWnd = 0
auiFlag = 0

Return 0

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

auiHWnd = 0

Return False
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

auiSrc	= 0
auiDest	= 0

Return 0
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

auiHWnd	= 0
auiHDc	= 0

Return 0
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

auiHDc 	= 0
auiHObj	= 0

Return 0
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

auiHWnd = 0

Return 0
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

auiHWnd	= 0
aiFlag	= 0

Return False
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

aiSysMet	= 0

Return 0
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

asImp		= ""
asPort	= ""
asJob		= ""
asFic		= ""

Return 0
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

asPrg		= ""
auiEtat	= 0

Return 0
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

auiHWnd = 0

Return 0

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

auiHWnd	= 0
aiScroll	= 0

Return 0

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

auiType = 0

Return 0

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

auiType = 0

Return 0

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

auiHWnd = 0

Return 0

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
//*					  astParam				s_LoadParams(Val) 
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

asModule = ""
//SetNull ( astParam )


Return 0
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

asSection 	= ""
asEntry		= ""
asDefaut		= ""
// [MIGPB11] [EMD] : Debut Migration : Forcer la cr$$HEX1$$e900$$ENDHEX$$ation de Blob en ANSI
//ablRetour	= Blob ( "" )
ablRetour	= Blob ( "", EncodingANSI! )
// [MIGPB11] [EMD] : Fin Migration
auiBuffer	= 0
asNomFic		= ""

Return 0
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

auiFic = 0
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

asClasse = ""
asWindow = ""

Return 0

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
//* Retourne		: String    		Nom du Login
//*								
//*
//*-----------------------------------------------------------------

Return ""
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
//* Arguments		: String		asPrefix			(Val)	Pr$$HEX1$$e900$$ENDHEX$$fix du fichier
//*					  String    asTmpFileName 	(Ref) Non du fichier
//*
//* Retourne		: Integer
//*								
//*
//*-----------------------------------------------------------------

asPrefix			= ""
asTmpFileName	= ""

Return 0
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

asFichier	= ""
asSection	= ""
asCle			= ""
asText		= ""

Return ( 0 )

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

asChaine 	= ""

//SetNull ( astPar )

Return 0
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

Return 0
end function

public function String uf_getversion ();//*-----------------------------------------------------------------
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

public function unsignedinteger uf_wnetgetconnection (string asportname, ref string asnetqueuename, ref unsignedinteger auinbmaxcar);
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

asPortName		= ""
asNetQueueName	= ""
auiNbMaxCar		= 0

Return 0
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

AuiHandleFile	= 0
// [MIGPB11] [EMD] : Debut Migration : Forcer la cr$$HEX1$$e900$$ENDHEX$$ation de Blob en ANSI
//ablBuf			= Blob ( "" )
ablBuf			= Blob ( "", EncodingANSI! )
// [MIGPB11] [EMD] : Fin Migration
auiNbByte		= 0

Return 0
end function

public function integer uf_setlastwritedatetime (string asfichier, date addate, time attime);//////////////////////////////////////////////////////////////////////////////
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


Return ( -1 )
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

Return ( -1 )
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

Return  ( -1 )
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

Return 0
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

Return 0

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

Return ""

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
//* Retourne		: String 
//*								
//*
//*-----------------------------------------------------------------

Return ""

end function

public function integer uf_setfileattributes (ref string asnomfic, unsignedlong aulattrib);//*-----------------------------------------------------------------
//*
//* Fonction      : u_DeclarationWindows::uf_SetFileAttributes (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 26/03/2004 17:10:50
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Modifie les attributs d'un fichier 
//* Commentaires  : Valeurs d'attributs possible en Hexa.
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

Return ( -1 )


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

auiHDc = 0
//SetNull ( astMetrics )

Return False
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
//Migration PB8-WYNIWYG-03/2006 FM
////*					  s_OfStruct			astStruct	(Val)
//*					  s_OfStruct32			astStruct	(Val)
//Fin Migration PB8-WYNIWYG-03/2006 FM
//*					  UnsignedInteger		auiMode		(Val) Mode d'ouverture
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

//SetNull ( astStruct )
asNomFic = ""
auiMode 	= 0

Return 0
end function

public function long uf_createmutex (boolean abinitial, ref string asnomapplication);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_CreateMutex
//* Auteur			:	PHG
//* Date				:	05/05/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Cr$$HEX1$$e900$$ENDHEX$$e un mutex ( mutually exclusive )
//*						pour detecter le nombre de lancement d'application
//* Commentaires	:	[DETECTEAPPLI]
//*
//* Arguments		:	booelan		abInitial Etat Initial
//*						Ref String	asNomApplication Nom de l'application
//*
//* Retourne		:	Long				0 = Ok
//*											< 0  si non
//*
//*-----------------------------------------------------------------

abInitial = FALSE
asNomApplication = ""

return 0

end function

public function integer uf_getlasterror ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_GetLastError()
//* Auteur			:	PHG
//* Date				:	05/05/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	retourne le dernier numero d'erreur systeme
//* Commentaires	:	[DETECTEAPPLI]
//*
//* Arguments		:	booelan		abInitial Etat Initial
//*						Ref String	asNomApplication Nom de l'application
//*
//* Retourne		:	Long				0 = Ok
//*											< 0  si non
//*
//*-----------------------------------------------------------------

return 0
end function

public function integer uf_closehandle (unsignedlong aul_lutex);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_CloseHandle()
//* Auteur			:	PHG
//* Date				:	05/05/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Libere la ressource point$$HEX1$$e900$$ENDHEX$$e par le handle
//*						
//* Commentaires	:	[DETECTEAPPLI]
//*
//* Arguments		:	booelan		abInitial Etat Initial
//*						Ref String	asNomApplication Nom de l'application
//*
//* Retourne		:	Long				0 = Ok
//*											< 0  si non
//*
//*-----------------------------------------------------------------

return 0

end function

public subroutine uf_setmutexref (unsignedlong aul_hmutex);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_SetMutexRef
//* Auteur			:	PHG
//* Date				:	05/05/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Stocke le reference au Mutex cr$$HEX1$$e900$$ENDHEX$$e
//* Commentaires	:	[DETECTEAPPLI]
//*
//* Arguments		:	ulong hMutex Refrence sur le Mutex cr$$HEX1$$e900$$ENDHEX$$e
//*
//* Retourne		:	Long				0 = Ok
//*											< 0  si non
//*
//*-----------------------------------------------------------------

if aul_hMutex > 0 then ul_hmutex = aul_hMutex
end subroutine

public function ulong uf_getmutexref ();//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_GetMutexRef
//* Auteur			:	PHG
//* Date				:	05/05/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Stocke le reference au Mutex cr$$HEX1$$e900$$ENDHEX$$e
//* Commentaires	:	[DETECTEAPPLI]
//*
//* Arguments		:	ulong hMutex Refrence sur le Mutex cr$$HEX1$$e900$$ENDHEX$$e
//*
//* Retourne		:	Long				0 = Ok
//*											< 0  si non
//*
//*-----------------------------------------------------------------

return ul_hMutex
end function

public function long uf_filecount (string aspattern, long alattrib);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_FileCount
//* Auteur			: PHG
//* Date				: 07/10/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [I037] Remplacement des fonctuion funcky Eponyme.
//*					  Classe ancetre
//*
//* Arguments		: String					asClasse		(Val)	
//*					  String					asWindow		(Val) 
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------
long lFileCount

return lFileCount
end function

public function integer uf_frename (string as_sourcefile, string as_targetfile);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_fRename
//* Auteur			: PHG
//* Date				: 07/10/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [I037] Remplacement des fonction funcky Eponyme.
//*					  Classe ancetre
//*
//* Arguments		: String					asClasse		(Val)	
//*					  String					asWindow		(Val) 
//*
//* Retourne		: UnsignedInteger
//*								
//*
//*-----------------------------------------------------------------

return -1
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
return 0

end function

on u_declarationwindows.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_declarationwindows.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

