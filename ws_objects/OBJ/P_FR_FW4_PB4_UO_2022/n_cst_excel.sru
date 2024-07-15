HA$PBExportHeader$n_cst_excel.sru
$PBExportComments$------} UserObjet pour la gestion des documents sous EXCEL.
forward
global type n_cst_excel from nonvisualobject
end type
end forward

global type n_cst_excel from nonvisualobject
end type
global n_cst_Excel n_cst_excel

type prototypes
/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$claration de la fonction pour rechercher si EXCEL est ouvert.  */
/*------------------------------------------------------------------*/
Function Int FindWindow ( Ref string sClassName, Long sNull ) Library "USER.EXE" alias for "FindWindow;Ansi"
Function Int FindWindow ( Long lClassName, Ref String sWindowName ) Library "USER.EXE" alias for "FindWindow;Ansi"

Function Long SendMessage ( Ulong ulWinHandle, Uint uiWinMsg, Ulong ulwParam, Ulong ullParam ) Library "USER.EXE"

end prototypes

forward prototypes
public function unsignedlong uf_excelouvert ()
public function integer uf_fichierouvertdansexcel (ref oleobject aOleObject, boolean abFermer, boolean abfermer_SansVerifier)
public function integer uf_fermerexcel ()
public function integer uf_creeroleobject_excel (ref oleobject aOleObject)
public function integer uf_agrandirexcel (boolean abAgrandir)
public subroutine uf_commandeexcel (integer aitype, string asparam1, ref oleobject aoleobject)
end prototypes

public function unsignedlong uf_excelouvert ();
//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Excel::uf_ExcelOuvert		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 10:03:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Le programme EXCEL est-il en train de tourner ?
//*
//* Arguments		: Aucun
//*
//* Retourne		: ULong			 ? = Excel est en train de fonctionner, on retourne le HANDLE de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*										 0 = Excel ne fonctionne pas
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------


Return ( -1 )

end function

public function integer uf_fichierouvertdansExcel (ref oleobject aOleObject, boolean abFermer, boolean abfermer_SansVerifier);
//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Excel::uf_FichierOuvertDansExcel		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 16:11:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Existe-t-il des fichiers ouverts dans l'objet OLE EXCEL
//*
//* Arguments		: (R$$HEX1$$e900$$ENDHEX$$f)		OleObject		aOleObject
//*					  (Val)		Boolean			abFermer
//*					  (Val)		Boolean			abFermer_SansVerifier
//*
//* Retourne		: Integer				 1 = Il n'existe aucun document modifi$$HEX2$$e9002000$$ENDHEX$$dans EXCEL
//*												-1 = L'instance du NVUO est fausse
//*												-2 = Il existe des documents non sauvegard$$HEX1$$e900$$ENDHEX$$s
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------


Return ( -1 )

end function

public function integer uf_fermerExcel ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Excel::uf_FermerExcel		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 14:45:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On s'occupe de fermer la fen$$HEX1$$ea00$$ENDHEX$$tre EXCEL si elle est ouverte
//*
//* Arguments		: 
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Return ( -1 )



end function

public function integer uf_creeroleobject_Excel (ref oleobject aOleObject);
//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Excel::uf_CreerOleObject_Excel		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 14:41:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cette fonction se charge de cr$$HEX1$$e900$$ENDHEX$$er la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence $$HEX2$$e0002000$$ENDHEX$$EXCEL
//*
//* Arguments		: (R$$HEX1$$e900$$ENDHEX$$f)		OleObject		aOleObject
//*
//* Retourne		: Integer				 0 = Tout est OK
//*											  < 0 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Return  ( -1 )



end function

public function integer uf_agrandirExcel (boolean abAgrandir);
//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Excel::uf_AgrandirExcel			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 10:03:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut maximizer ou minimizer la fen$$HEX1$$ea00$$ENDHEX$$tre EXCEL.
//*
//* Arguments		: Boolean	(Val)		abAgrandir
//*
//* Retourne		: Integer		 1 = Tout se passe bien
//*										 0 = Excel ne fonctionne pas
//*										-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Return ( -1 )


end function

public subroutine uf_commandeExcel (integer aitype, string asparam1, ref oleobject aoleobject);
//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Excel::uf_CommandeExcel		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 27/04/2000 16:03:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On lance une commande EXCEL
//*
//* Arguments		: (Val)	Integer		aiType
//*					  (Val)	String		asParam1
//*					  (R$$HEX1$$e900$$ENDHEX$$f)	OleObject	aOleObject
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------



end subroutine

on n_cst_Excel.create
TriggerEvent( this, "constructor" )
end on

on n_cst_Excel.destroy
TriggerEvent( this, "destructor" )
end on

