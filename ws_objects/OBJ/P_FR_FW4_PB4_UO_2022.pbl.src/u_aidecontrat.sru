HA$PBExportHeader$u_aidecontrat.sru
$PBExportComments$vuo CommandButton faisant appara$$HEX1$$ee00$$ENDHEX$$tre l'aide du contrat pour le gestionnaire
forward
global type u_aidecontrat from commandbutton
end type
end forward

global type u_aidecontrat from commandbutton
integer width = 375
integer height = 108
integer taborder = 1
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aide Contrat"
end type
global u_aidecontrat u_aidecontrat

type variables
Private :

Long	ilIdProd
String	isRepWin, isRepWord, isRepExcel, isCas, isFic

/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//String	K_AIDTEMP = "\TEMP\AIDE.DOC"
//String	K_NOTTEMP = "\TEMP\NOTICE.DOC"
//String	K_EXCTEMP = "\TEMP\CALCULS.XLS"

String	K_AIDTEMP = "AIDE.DOC"
String	K_NOTTEMP = "NOTICE.DOC"
String	K_EXCTEMP = "CALCULS.XLS"

//* ______________________________________________________ */
//* #2 	 JCA      11/06/2007 DCMP 070382 - Lecture de PDF */
//* $$HEX55$$af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af00af002000$$ENDHEX$$*/
string	K_NOTPDFTEMP = "NOTICE.PDF"
string	isRepPdf

end variables

forward prototypes
public subroutine uf_setidprod (long alidprod)
public subroutine uf_initialiser (string ascas, string aslabel)
public function string uf_get_repexcel ()
public function string uf_get_repword ()
end prototypes

public subroutine uf_setidprod (long alidprod);//*-----------------------------------------------------------------
//*
//* Fonction      : u_AideContrat::uf_SetIdprod (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 27/02/2002 09:46:54
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Armement du produit
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//*
//*-----------------------------------------------------------------

ilIdProd = alIdProd



end subroutine

public subroutine uf_initialiser (string ascas, string aslabel);//*-----------------------------------------------------------------
//*
//* Fonction      : u_AideContrat::uf_Initialiser (PUBLIC)
//* Auteur        : Fabry JF
//* Date          : 27/02/2002 10:18:01
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: 
//* Commentaires  : 
//*
//* Arguments     : Val		String		asCas		
//*					  Val		String		asLabel	
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     	Modification
//* #1 	 DGA      19/09/2006 Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire DCMP-060643
//* #2 	 JCA      11/06/2007 DCMP 070382 - Lecture de PDF
//*-----------------------------------------------------------------

u_DeclarationWindows	nvWin

isCas = Upper ( asCas )
isFic = ProFileString ( stGlb.sFichierIni, "DOCUMENTATION", isCas, "" )

// [Office2010] [FMU] : Debut : 
//isRepWord = ProFileString ( stGlb.sFichierIni, "DOCUMENTATION", "REP_WORD", "" )
isRepWord = f_GetWordExe()
// [Office2010] [FMU] : Fin
//isRepExcel = ProFileString ( stGlb.sFichierIni, "DOCUMENTATION", "REP_EXCEL", "" )
isRepExcel = F_GetExcelPath() //[PI037]

// #2
isRepPdf = ProFileString ( stGlb.sFichierIni, "DOCUMENTATION", "REP_PDF", "" )
// #2 - FIN

This.Text = asLabel

/*----------------------------------------------------------------------------*/
/* Armement du nom du rep win                                                 */
/*----------------------------------------------------------------------------*/
nvWin	= stGLB.uoWin
/*------------------------------------------------------------------*/  
/* #1. DCMP-060643                                                  */
/* Le 19/09/2006. Gestion d'un r$$HEX1$$e900$$ENDHEX$$pertoire temporaire parametrable.  */
/*------------------------------------------------------------------*/
//isRepWin	= nvWin.Uf_GetWindowsDirectory ()
isRepWin	= stGLB.sRepTempo

end subroutine

public function string uf_get_repexcel ();String sClasseExcel, sRetour

if RegistryGet("HKEY_CLASSES_ROOT\.xls", "", sClasseExcel) = -1 Then return "Excel.exe"
if RegistryGet("HKEY_CLASSES_ROOT\"+sClasseExcel + "\shell\open\command", "", sRetour) = -1 Then return "Excel.exe"

return sRetour
end function

public function string uf_get_repword ();String sClasseWord, sRetour

if RegistryGet("HKEY_CLASSES_ROOT\.doc", "", sClasseWord) = -1 Then return "Winword.exe"
if RegistryGet("HKEY_CLASSES_ROOT\"+sClasseWord + "\shell\open\command", "", sRetour) = -1 Then return "Winword.exe"

return sRetour
end function

event clicked;//*-----------------------------------------------------------------
//*
//* Objet         : u_AideContrat
//* Evenement     : Clicked
//* Auteur        : Fabry JF
//* Date          : 27/02/2002 09:55:24
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Clique bouton
//* Commentaires  : 
//*
//* Arguments     : 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #1 	 JCA      11/06/2007 DCMP 070382 - Lecture de PDF
//* #2	FPI		13/08/2009	[DCMP090458]  Utilisation du lecteur PDF d$$HEX1$$e900$$ENDHEX$$fini par Windows
//			FPI		15/03/2012	[ITSM109855] Correction probl$$HEX1$$e800$$ENDHEX$$me XLS
//*-----------------------------------------------------------------

String	sFic, sFicTmp, sLib, sLib2, sRun
Blob		blBlob
Boolean  bOk
String 	sClassePdf // #2
n_cst_string	nvString // #2

sFic = isFic


// [ITSM109855]
If isRepWord="" Then isRepWord=uf_get_repword( )
If isRepExcel="" Then isRepExcel=uf_get_repexcel( )
// :[ITSM109855]

CHOOSE CASE isCas
	CASE "AIDE"
		sFicTmp = Upper ( isRepWin + K_AIDTEMP )
		sLib    = "d'aide"
		sLib2   = "l'aide"
		sRun    = isRepWord + " " + sFicTmp

	CASE "NOTICE"
		sFicTmp = Upper ( isRepWin + K_NOTTEMP )
		sLib    = "de notice"
		sLib2   = "la notice"
		sRun    = isRepWord + " " + sFicTmp

	CASE "EXCEL"
		sFicTmp = Upper ( isRepWin + K_EXCTEMP )
		sLib    = "de fichier de calculs EXCEL"
		sLib2   = "le fichier de calculs EXCEL"
		sRun    = isRepExcel + " " + sFicTmp

END CHOOSE

/*------------------------------------------------------------------*/
/* Le chemin o$$HEX2$$f9002000$$ENDHEX$$chercher l'aide est vide.                           */
/*------------------------------------------------------------------*/
If isFic = "" Then 
	stMessage.sTitre  	= "Aide/Notice Contrat"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE01"
	F_Message ( stMessage )
	Return
End If

/*------------------------------------------------------------------*/
/* Contruction de la chaine avec le produit                         */
/*------------------------------------------------------------------*/
sFic = Upper ( Replace ( sFic, Pos ( sFic, "*", 1 ), 1, String ( ilIdProd ) ) )

/*------------------------------------------------------------------*/
/* L'aide ou la notice existe-t-elle pour ce produit.					  */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//bOk = FileExists ( sFic )
bOk = f_FileExists ( sFic )
//Fin Migration PB8-WYNIWYG-03/2006 CP

// #1
if not bOk and isCas = 'NOTICE' then
	sFic = Upper ( Replace ( sFic, Pos ( sFic, ".DOC", 1 ), 4, ".PDF" ) )
	bOk = f_FileExists ( sFic )
	if bOk then
		sFicTmp = Upper ( isRepWin + K_NOTPDFTEMP )
		// #2 [DCMP090458]
//		sRun    = isRepPdf + " " + sFicTmp 

		if RegistryGet("HKEY_CLASSES_ROOT\.pdf", "", sClassePdf) = -1 Then return 
		if RegistryGet("HKEY_CLASSES_ROOT\"+sClassePdf + "\shell\open\command", "", sRun) = -1 Then return 

		sRun= nvstring.of_globalreplace(sRun, "%1", sFicTmp)
		// #2 [DCMP090458] - Fin
	end if
end if
// #1 - FIN

If Not bOk Then
	stMessage.sTitre  	= "Aide/Notice Contrat"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE06"
	stMessage.sVar[1]		= sLib
	stMessage.sVar[2]		= String ( ilIdProd )
	F_Message ( stMessage )
	Return
End If


/*------------------------------------------------------------------*/
/* Le chemin o$$HEX2$$f9002000$$ENDHEX$$trouver word est vide.                              */
/*------------------------------------------------------------------*/
If isRepWord = "" Then 
	stMessage.sTitre  	= "Aide/Notice Contrat"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE02"
	F_Message ( stMessage )
	Return
End If

/*------------------------------------------------------------------*/
/* La suppression du fichier temporaire $$HEX3$$e0002000e900$$ENDHEX$$chou$$HEX1$$e900$$ENDHEX$$.						  */
/*------------------------------------------------------------------*/

//Migration PB8-WYNIWYG-03/2006 CP
//If FileExists ( sFicTmp ) Then 
If f_FileExists ( sFicTmp ) Then 
//Fin Migration PB8-WYNIWYG-03/2006 CP	
	
	bOk = FileDelete ( sFicTmp )
	If Not bOk Then
		stMessage.sTitre  	= "Aide/Notice Contrat"
		stMessage.Icon			= Information!
		stMessage.bErreurG	= TRUE
		stMessage.Bouton		= Ok!
		stMessage.sCode		= "AIDE03"
		stMessage.sVar[1]		= sLib2
		stMessage.sVar[2]		= sFicTmp
		F_Message ( stMessage )
		Return
	End If
End If

/*------------------------------------------------------------------*/
/* Lecture du fichier source.                                       */
/*------------------------------------------------------------------*/
bOk = F_LireFichierBlob ( blBlob, sFic )
If Not bOk Then
	stMessage.sTitre  	= "Aide/Notice Contrat"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE04"
	stMessage.sVar[1]		= sFic
	F_Message ( stMessage )
	Return
End If

/*------------------------------------------------------------------*/
/* Ecriture en local vers fichier destination.							  */
/*------------------------------------------------------------------*/
bOk = F_EcrireFichierBlob ( blBlob, sFicTmp)
If Not bOk Then
	stMessage.sTitre  	= "Aide/Notice Contrat"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= TRUE
	stMessage.Bouton		= Ok!
	stMessage.sCode		= "AIDE05"
	stMessage.sVar[1]		= sFicTmp
	F_Message ( stMessage )
	Return
End If

RUN ( sRun )


end event

on u_aidecontrat.create
end on

on u_aidecontrat.destroy
end on

