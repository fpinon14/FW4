HA$PBExportHeader$n_cst_shell_fileoperations.sru
$PBExportComments$Objet d'encapsulation des fonctions "shell" sur fichiers/r$$HEX1$$e900$$ENDHEX$$pertoires ( Copy/Move/Suppression/Vidage) :Deltree fait, Vidage Fait.
forward
global type n_cst_shell_fileoperations from nonvisualobject
end type
type st_hnamemappings from structure within n_cst_shell_fileoperations
end type
type st_shfileopstructa from structure within n_cst_shell_fileoperations
end type
type st_filedatetime from structure within n_cst_shell_fileoperations
end type
type st_filedata from structure within n_cst_shell_fileoperations
end type
end forward

type st_hnamemappings from structure
	unsignedinteger		unumberofmappings
	string		lpshnamemapping
end type

type st_shfileopstructa from structure
	long		hwnd
	long		wfunc
	string		pfrom
	string		pto
	long		fflags
	long		fanyoperationsaborted
	long		lpshnamemapping
	string		lpszprogresstitle
end type

type st_filedatetime from structure
	unsignedlong		ul_lowdatetime
	unsignedlong		ul_highdatetime
end type

type st_filedata from structure
	unsignedlong		ul_fileattribute
	st_filedatetime		str_creationtime
	st_filedatetime		str_lastaccesstime
	st_filedatetime		str_lastwritetime
	unsignedlong		ul_filesizehigh
	unsignedlong		ul_filesizelow
	unsignedlong		ul_reserved0
	unsignedlong		ul_reserved1
	character		s_filename[260]
	character		s_alternatefilename[14]
end type

global type n_cst_shell_fileoperations from nonvisualobject autoinstantiate
end type

type prototypes
// Sh File Operations
// [OM2_DIAG_NOMADE].lot2 PHG, le 22/01/2010 Mise en compatibilit$$HEX2$$e9002000$$ENDHEX$$avec les chemin UNC
//private Function long SHFileOperation (ref st_SHFILEOPSTRUCTA st_FileOp) LIBRARY "shell32.dll" ALIAS FOR "SHFileOperationA;Ansi"
private Function long SHFileOperation (ref st_SHFILEOPSTRUCTA st_FileOp) LIBRARY "shell32.dll" ALIAS FOR "SHFileOperationW"

// Fonction de Recherche de fichier
// [OM2_DIAG_NOMADE].lot2 PHG, le 22/01/2010 Mise en compatibilit$$HEX2$$e9002000$$ENDHEX$$avec les chemin UNC
//FUNCTION long FindFirstFileA (string filename, ref st_filedata findfiledata) LIBRARY "KERNEL32.DLL" alias for "FindFirstFileA;Ansi"
//FUNCTION long FindNextFileA (long handle, ref st_filedata findfiledata) LIBRARY "KERNEL32.DLL" alias for "FindNextFileA;Ansi"
FUNCTION long FindFirstFile (string filename, ref st_filedata findfiledata) LIBRARY "KERNEL32.DLL" alias for "FindFirstFileW"
FUNCTION long FindNextFile (long handle, ref st_filedata findfiledata) LIBRARY "KERNEL32.DLL" alias for "FindNextFileW"
FUNCTION boolean FindClose (long handle) LIBRARY "KERNEL32.DLL"

// [MIGPB11] [EMD] : Debut : [DETECTEAPPLI].REPTEMPO ajout de SetFileAttributes utile dans of_viderdir(...)
// Manipulation d'attribut
// [OM2_DIAG_NOMADE].lot2 PHG, le 22/01/2010 Mise en compatibilit$$HEX2$$e9002000$$ENDHEX$$avec les chemin UNC
//FUNCTION long SetFileAttributes(string filename, unsignedlong ulFileAttributes) LIBRARY "KERNEL32.DLL" ALIAS FOR "SetFileAttributesA;Ansi"
FUNCTION long SetFileAttributes(string filename, unsignedlong ulFileAttributes) LIBRARY "KERNEL32.DLL" ALIAS FOR "SetFileAttributesW"
// [MIGPB11] [EMD] : Fin

end prototypes

type variables
private:
// constante pour ShFilesOperations
constant uint K_FO_COPY	= 2	//Copies the files specified
constant uint K_FO_DELETE	= 3	//Deletes the files specified
constant uint K_FO_MOVE	= 1	//Moves the files specified
constant uint K_FO_RENAME	= 4	//Renames the files

constant uint K_FOF_ALLOWUNDO				= 64	//Preserve Undo information.
constant uint K_FOF_CONFIRMMOUSE			= 2	//Not currently implemented.
constant uint K_FOF_FILESONLY				= 128	//Perform the operation on files only if a wildcard file name (*.*) is specified.
constant uint K_FOF_MULTIDESTFILES			= 1	//The pTo member specifies multiple destination files (one for each source file) rather than one directory where all source files are to be deposited.
constant uint K_FOF_NOCONFIRMATION			= 16	//Respond with Yes to All for any dialog box that is displayed.
constant uint K_FOF_NOCONFIRMMKDIR			= 512	//Does not confirm the creation of a new directory if the operation requires one to be created.
constant uint K_FOF_RENAMEONCOLLISION		= 8	//Give the file being operated on a new name in a move, copy, or rename operation if a file with the target name already exists.
constant uint K_FOF_SILENT					= 4	//Does not display a progress dialog box.
constant uint K_FOF_SIMPLEPROGRESS			= 256	//Displays a progress dialog box but does not show the file names.
constant uint K_FOF_WANTMAPPINGHANDLE		= 32	//If K_FOF_RENAMEONCOLLISION is specified, the hNameMappings member will be filled in if any files were renamed.
constant uint K_FOF_NOCOPYSECURITYATTRIBS= 2048

//Constantes pour FindFirstfile, FindNextFile
// voir http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/fs/findfirstfile.asp
constant uint K_MAXPATH										 =  260 // Logeur maximale du cheminde recherche
constant uint K_FILE_ATTRIBUTE_READONLY             = 0001 // 0x0001 0b00000000 000000001
constant uint K_FILE_ATTRIBUTE_HIDDEN               = 0002 // 0x0002 0b00000000 000000010
constant uint K_FILE_ATTRIBUTE_SYSTEM               = 0004 // 0x0004 0b00000000 000000100
constant uint K_FILE_ATTRIBUTE_DIRECTORY            = 0016 // 0x0010 0b00000000 000010000
constant uint K_FILE_ATTRIBUTE_ARCHIVE              = 0032 // 0x0020 0b00000000 000100000
constant uint K_FILE_ATTRIBUTE_ENCRYPTED            = 0064 // 0x0040 0b00000000 001000000
constant uint K_FILE_ATTRIBUTE_NORMAL               = 0128 // 0x0080 0b00000000 010000000
constant uint K_FILE_ATTRIBUTE_TEMPORARY            = 0256 // 0x0100 0b00000000 100000000
constant uint K_FILE_ATTRIBUTE_SPARSE_FILE          = 0512 // 0x0200 0b00000001 000000000
constant uint K_FILE_ATTRIBUTE_REPARSE_POINT        = 1024 // 0x0400 0b00000010 000000000
constant uint K_FILE_ATTRIBUTE_COMPRESSED           = 2048 // 0x0800 0b00000100 000000000
constant uint K_FILE_ATTRIBUTE_OFFLINE              = 4096 // 0x1000 0b00001000 000000000
constant uint K_FILE_ATTRIBUTE_NOT_CONTENT_INDEXED  = 8192 // 0x2000 0b00010000 000000000

public:
//Constante pour l'objet
// reprise des constante pfc_n_base des PFC
// - Common return value constants:
constant integer 		SUCCESS = 1
constant integer 		FAILURE = -1
constant integer 		NO_ACTION = 0
// - Continue/Prevent return value constants:
constant integer 		CONTINUE_ACTION = 1
constant integer 		PREVENT_ACTION = 0
// On garde les anciennes constantes pour compatibilit$$HEX2$$e9002000$$ENDHEX$$ancetre pb4to8
constant integer K_SUCCESS                             = 1
constant integer K_FAILURE                             = -1
constant integer K_FILEDELETE_FAILURE                  = -10
constant integer K_DIRDELETE_FAILURE                   = -20

end variables

forward prototypes
public function integer of_deltree (long ahwnd, string asdirectory)
public function integer of_deltree (string asdirectory)
public function integer of_viderdir (string asdir, ref integer aierrorcode)
end prototypes

public function integer of_deltree (long ahwnd, string asdirectory);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_shell_fileoperations::of_deltree
//* Auteur			: Pierre-Henri Gillot
//* Date				: 22/08/2006 16:41:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 	value long ahwnd
//*								Handle de l'objet appelant la fonction
//* 						value string asdirectory
//*								R$$HEX1$$e900$$ENDHEX$$pertoire a Supprimer
//* Retourne		: integer	Ok =0, Autre valeur : Erreur
//*
//* Les constantes utilis$$HEX1$$e900$$ENDHEX$$es sont d$$HEX1$$e900$$ENDHEX$$crites dans les variables d'instances
//* Plus de d$$HEX1$$e900$$ENDHEX$$tails en :
//* http://msdn.microsoft.com/library/default.asp?url=/library/en-us/shellcc/platform/shell/reference/functions/shfileoperation.asp
//*
//* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//* ATTENTION : FONCTION A MANIPULER AVEC PRECAUTION
//* Peut potentiellement effacer n'importe quel r$$HEX1$$e900$$ENDHEX$$pertoire qui existe
//*   pass$$HEX2$$e9002000$$ENDHEX$$en parametre. Pas de s$$HEX1$$e900$$ENDHEX$$curit$$HEX1$$e900$$ENDHEX$$.
//* Appel de l'API ShellOperations, qui utilise les fonctions Kernel
//*	de manipulation de fichier. Acc$$HEX1$$e800$$ENDHEX$$s direct au systeme de fichier.
//* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

long lRet
st_shfileopstructa FileOp

FileOp.hWnd 					= ahWnd
FileOp.WFunc 					= k_fo_delete
FileOP.pFrom					= asdirectory
SetNull(FileOP.pTo)
FileOP.fFlags 					= k_fof_noconfirmation +k_fof_silent
FileOP.lpSZprogresstitle 	= "Suppression R$$HEX1$$e900$$ENDHEX$$pertoire '" + asdirectory + "' par Application PowerBuilder."

lRet = shfileoperation (FileOp) 

return lRet
end function

public function integer of_deltree (string asdirectory);//////////////////////////////////////////////////////////////////////////////
//
// Function:		of_deltree
//
// Access:			Public
//
// Arguments:
// asdirectory:	R$$HEX1$$e900$$ENDHEX$$pertoire $$HEX2$$e0002000$$ENDHEX$$Supprimer
//
// Returns:			integer
//						0, Ok
//						Autre Valeur :Erreur
//
// Description:	Fonction recursive de suppression de r$$HEX1$$e900$$ENDHEX$$pertoire
//						Encapsule la fonction eponyme de ce meme objet, en
//						$$HEX1$$e900$$ENDHEX$$vitant de passer un handle.
//						
//						ATTENTION : Fonction recursive de Suppression. Pas de
//						confirmation. Supression en acc$$HEX1$$e800$$ENDHEX$$s direct systeme. pas de
//						s$$HEX1$$e900$$ENDHEX$$curit$$HEX1$$e900$$ENDHEX$$.
//
// Usage:			of_deltree ( <chemin complet, sans le slash> )
//
//////////////////////////////////////////////////////////////////////////////
//
// Revision History
//
// Version
// 1.0	PHG	20/09/2006 Version Initiale
//
//////////////////////////////////////////////////////////////////////////////

application app
long ll_Hdw

app = GetApplication()
ll_Hdw = handle(app)
return of_deltree(ll_hdw, asDirectory )
end function

public function integer of_viderdir (string asdir, ref integer aierrorcode);//*-----------------------------------------------------------------
//*
//* Fonction		: U_DeclarationFuncky::of_EraseDir ( PUBLIC )
//* Auteur			: Erick John Stark/PHG
//*					  d'apres u_declarationfuncky.uf_fEraseAll (F.MUSSO (WYNIWIG))
//* Date				: 26/09/2006
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Suppression de tous les fichier  d'un r$$HEX1$$e900$$ENDHEX$$pertoire
//*					  ET des sous-repertoires sans supprimer le repertoire parent
//*
//* Arguments		: String			asFic				(Val)	Fichier $$HEX2$$e0002000$$ENDHEX$$supprimer
//*
//* Retourne		: Integer		 ? = Nombre de fichiers supprim$$HEX1$$e900$$ENDHEX$$s
//*										 0 = Aucun fichier ou Erreur
//*
//* !!!!!!!!! ATTENTION!!!!!!!!
//* Fonction R$$HEX1$$e900$$ENDHEX$$cursive, supprime TOUT les fichiers dans le repertoire pass$$HEX1$$e900$$ENDHEX$$
//* !!!!!!!!!!!!!!!!!!!!!!!!!!!
//* #1	PHG	22/01/2010	[OM2_DIAG_NOMADE].lot2 PHG, le 22/01/2010 Mise en compatibilit$$HEX2$$e9002000$$ENDHEX$$avec les chemin UNC
//*-----------------------------------------------------------------

long			ll_res, ll_deleted, ll_pos, ll_ret
boolean		lb_res
st_filedata	lstr_FileData
string		ls_path, ls_filename
boolean		lb_Root = FALSE

// Verification de la longueur du chemin
//if len (asdir) > K_MAXPATH then return -1 // chaine trop longue, fera planter les API en mode ASCII.

// Initialisation des flags de recherche
lstr_FileData.ul_fileattribute = &
	K_FILE_ATTRIBUTE_SYSTEM + &
	K_FILE_ATTRIBUTE_ARCHIVE + &
	K_FILE_ATTRIBUTE_ENCRYPTED + &
	K_FILE_ATTRIBUTE_NORMAL

// On complete le repertoire par "\*.*"
if right(asdir, 1) <> "\" then 
	ls_path = asdir+"\"
	asdir += "\*.*"
else
	ls_path = asdir
	asdir += "*.*"
End If

ll_deleted = 0

// #1 [OM2_DIAG_NOMADE].lot2 PHG, le 22/01/2010 Mise en compatibilit$$HEX2$$e9002000$$ENDHEX$$avec les chemin UNC
//ll_res = FindFirstFileA(asDir, lstr_FileData)
ll_res = FindFirstFile(asDir, lstr_FileData)
if ll_res = -1 then
	ll_deleted = k_failure
	aiErrorCode = k_failure
else
	do 
		ls_filename = ls_path + lstr_FileData.s_filename
		
		if Right(lstr_FileData.s_filename,1 ) = "." then continue // on passe les directory "." et ".."
		// Test si c'est un repertoire :
		// On teste le FLAG K_FILE_ATTRIBUTE_DIRECTORY via une simulation de ET bit a bit :
		// 	On divise ul_fileattribute par K_FILE_ATTRIBUTE_DIRECTORY afin de decaler de 
		// 	K_FILE_ATTRIBUTE_DIRECTORY bits vers la droite puis on teste le bit le plus a droite
		// 	en faisant un modulo 2 pour savoir s'il est $$HEX2$$e0002000$$ENDHEX$$1 ou 0 ( modulo 2 => pair ou impair :) )
		if Mod(lstr_FileData.ul_fileattribute / K_FILE_ATTRIBUTE_DIRECTORY, 2) = 1 then
			ll_ret = of_ViderDir(ls_filename, aiErrorCode)
			if ll_ret >= 0 then 
				ll_deleted += ll_ret
				ll_ret = RemoveDirectory(ls_filename)
				if ll_ret = -1 then aiErrorCode = k_dirdelete_failure
			End If
		else
			// [MIGPB11] [EMD] : Debut Migration : [DETECTEAPPLI].REPTEMPO Si un ficher est ReadOnly, on enl$$HEX1$$e800$$ENDHEX$$ve l'attribut avant de l'effacer
			lb_res = TRUE
			if Mod(lstr_FileData.ul_fileattribute,2) = 1 Then // l'attribut READ_OLY est le bit le plus a droite
				lb_res = ( SetFileAttributes(ls_filename, lstr_FileData.ul_fileattribute - K_FILE_ATTRIBUTE_READONLY ) <> 0 )
			End If
			// [MIGPB11] [EMD] : Fin Migration
			lb_res = FileDelete(ls_filename)
			if lb_res then 
				ll_deleted++
			else
				aiErrorCode = k_filedelete_failure
			End If
		End If
	// #1 [OM2_DIAG_NOMADE].lot2 PHG, le 22/01/2010 Mise en compatibilit$$HEX2$$e9002000$$ENDHEX$$avec les chemin UNC
	//loop while FindNextFileA(ll_res, lstr_FileData) > 0
	loop while FindNextFile(ll_res, lstr_FileData) > 0
end if

lb_res = FindClose(ll_res)


return ll_deleted

// Ancien Code
//ll_res = FindFirstFileA(asDir, lstr_FileData)
//if ll_res = -1 then
//	ll_deleted = -1
//else
//	ls_filename = ls_path + lstr_FileData.s_filename
//	if Right(lstr_FileData.s_filename,1 ) <> "." then // on passe les directory "." et ".."
//		// On teste le FLAG K_FILE_ATTRIBUTE_DIRECTORY via une simulation de ET bit a bit :
//		// On divise ul_fileattribute par K_FILE_ATTRIBUTE_DIRECTORY afin de decaler de 
//		// K_FILE_ATTRIBUTE_DIRECTORY bits vers la droite puis on teste le bit le plus a droite
//		// en faisant un modulo 2 pour savoir s'il est $$HEX2$$e0002000$$ENDHEX$$1 ou 0 ( modulo 2 => pair ou impair :) )
//		if Mod(lstr_FileData.ul_fileattribute / K_FILE_ATTRIBUTE_DIRECTORY, 2) = 1 then 
//			ll_ret = of_ViderDir(ls_filename, aiErrorCode)
//			if ll_ret >= 0 then 
//				ll_deleted += ll_ret
//				ll_ret = RemoveDirectory(ls_filename)
//			End If
//		else
//			lb_res = FileDelete(ls_filename)
//			if lb_res then ll_deleted++
//		End If
//	End If
//	do while FindNextFileA(ll_res, lstr_FileData) > 0
//		ls_filename = ls_path + lstr_FileData.s_filename
//		
//		if Right(lstr_FileData.s_filename,1 ) = "." then continue // on passe les directory "." et ".."
//		// Test si c'est un repertoire, voir commentaire apres FindFirstFileA
//		if Mod(lstr_FileData.ul_fileattribute / K_FILE_ATTRIBUTE_DIRECTORY, 2) = 1 then
//			ll_ret = of_ViderDir(ls_filename, aiErrorCode)
//			if ll_ret >= 0 then 
//				ll_deleted += ll_ret
//				ll_ret = RemoveDirectory(ls_filename)
//				if ll_ret = -1 then aiErrorCode = -1
//			End If
//		else
//			lb_res = FileDelete(ls_filename)
//			if lb_res then ll_deleted++
//		End If
//	loop
//end if

end function

on n_cst_shell_fileoperations.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_shell_fileoperations.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

