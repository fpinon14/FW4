HA$PBExportHeader$n_cst_word.sru
$PBExportComments$------} UserObjet pour la gestion des documents sous WORD.
forward
global type n_cst_word from nonvisualobject
end type
end forward

global type n_cst_word from nonvisualobject
end type
global n_cst_word n_cst_word

type prototypes
/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$claration de la fonction pour rechercher si WORD est ouvert.   */
/*------------------------------------------------------------------*/
//Migration PB8-WYNIWYG-03/2006 FM
//Function Int FindWindow ( Ref string sClassName, Long sNull ) Library "USER.EXE"
//Function Int FindWindow ( Long lClassName, Ref String sWindowName ) Library "USER.EXE"
//
//Function Long SendMessage ( Ulong ulWinHandle, Uint uiWinMsg, Ulong ulwParam, Ulong ullParam ) Library "USER.EXE"

Function Int FindWindowA ( Ref string sClassName, Ref String sWindowName ) Library "USER32.DLL" alias for "FindWindowA;Ansi"
Function Long SendMessageA ( Ulong ulWinHandle, Uint uiWinMsg, Ulong ulwParam, Ulong ullParam ) Library "USER32.DLL"
//Fin Migration PB8-WYNIWYG-03/2006 FM


// [MIGPB11] [LBP] : Debut Migration
Function Ulong FindWindowExA( uLong hFatherWindow, uLong hNextChildWindow, Ref string sClassName, Ref string sWindowName) Library "USER32.DLL" alias for "FindWindowExA;Ansi"
Function integer GetWindowTextA(uLong hWindow, ref string sWindowTitle, integer nMaxCount) Library "USER32.DLL" alias for "GetWindowTextA;Ansi"
Function Ulong IsWindowVisible (uLong hWindow) Library "USER32.DLL" alias for "IsWindowVisible"
// [MIGPB11] [LBP] : Fin Migration
end prototypes

type variables
// [MIGPB11] [EMD] : Debut : 'remont$$HEX1$$e900$$ENDHEX$$' de ces variables sous forme de constantes, ici dans la classe ancetre
Protected:
	constant String K_CLASSNAME	= "OpusApp"
	constant String K_WINDOWNAME	= "Microsoft Word"
// [MIGPB11] [EMD] : Fin
// [Office2010] [FMU] : Debut : 
	//version d$$HEX1$$e900$$ENDHEX$$taill$$HEX1$$e900$$ENDHEX$$e de Word
	String is_VersionMajeur, is_VersionMoyen, is_VersionMineur
	//sous-r$$HEX1$$e900$$ENDHEX$$pertoire sp$$HEX1$$e900$$ENDHEX$$cifique au modele pour la version de Word
	String	is_SousRepModele
// [Office2010] [FMU] : Fin

end variables

forward prototypes
public function unsignedlong uf_wordouvert ()
public function integer uf_fichierouvertdansword (ref oleobject aOleObject, boolean abFermer, boolean abfermer_SansVerifier)
public function integer uf_fermerword ()
public function integer uf_creeroleobject_word (ref oleobject aOleObject)
public function integer uf_agrandirword (boolean abAgrandir)
public subroutine uf_commandeword (integer aitype, string asparam1, ref oleobject aoleobject)
public function integer uf_setversionword (string as_majeur, string as_moyen, string as_mineur)
public function string uf_getsousrepmodele ()
protected function integer uf_corrigecheminmodele (ref string as_chemin_complet)
protected function integer uf_corrigemodele (ref oleobject aole_word)
end prototypes

public function unsignedlong uf_wordouvert ();//*-----------------------------------------------------------------
//*
//* Fonction			: N_Cst_Word::uf_WordOuvert		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 17/05/2006 03:03:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Le programme WORD est-il en train de tourner ?
//*
//* Arguments		: Aucun
//*
//* Retourne		: ULong			 ? = Word est en train de fonctionner, on retourne le HANDLE de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*										 0 = Word ne fonctionne pas
//*
//*-----------------------------------------------------------------
//* MAJ      		PAR      	Date	  		Modification
//* [MIGPB11]	BL			07/10/09		Ajout s$$HEX1$$e900$$ENDHEX$$cu anti-d$$HEX1$$e900$$ENDHEX$$tection Outlook
//* [MIGPB11]	EMD		07/10/09		'remont$$HEX1$$e900$$ENDHEX$$' de cette fonction ici au niveau de la classe parent
//*											au lieu qu'elle soit dupliqu$$HEX1$$e900$$ENDHEX$$e dans les sous-classes
//*-----------------------------------------------------------------

boolean bWindowFound
string sClassName
string sWindowName
string sNull
string sWindowTitle
ulong lFatherHandle
ulong lNull
ulong lChildHandle
ulong lNbChild
ulong lWindowTitleSize
//ulong ulRet

/*------------------------------------------------------------------*/
/* On red$$HEX1$$e900$$ENDHEX$$clare la fonction FindWindowA. En effet, on recherche     */
/* simplement la Classe pour WORD. Le nom de la fen$$HEX1$$ea00$$ENDHEX$$tre est         */
/* toujours diff$$HEX1$$e900$$ENDHEX$$rent.                                              */
/*------------------------------------------------------------------*/
sClassName = K_CLASSNAME

//ulRet = FindWindowA ( sClassName, 0 )

// [MIGPB11] [LBP] : Debut Migration : Ajout code d$$HEX1$$e900$$ENDHEX$$tection pr$$HEX1$$e900$$ENDHEX$$sence Word en pr$$HEX1$$e900$$ENDHEX$$sence Outllook
  
// Init var de recherche
lWindowTitleSize = 128
SetNull( lFatherHandle )
SetNull( sNull )
SetNull( lNull )
sWindowTitle = fillA( ' ',lWindowTitleSize+1) //+1 pour caract NULL de la win32
bWindowFound = false

do
	// Parcours l'ensemble des fen$$HEX1$$ea00$$ENDHEX$$tres du bureau
	lFatherHandle = FindWindowExA ( lNull, lFatherHandle, sClassName, sNull )
	
	if lFatherHandle > 0 then
		// Si fen$$HEX1$$ea00$$ENDHEX$$tre p$$HEX1$$e800$$ENDHEX$$re de classe "ClassName" trouv$$HEX1$$e900$$ENDHEX$$e on lit son titre
		GetWindowTextA(lFatherHandle, sWindowTitle, lWindowTitleSize)
		if Match(sWindowTitle,'Word') And (iswindowvisible( lFatherHandle ) = 1) Then // On effectue une premi$$HEX1$$e800$$ENDHEX$$re v$$HEX1$$e900$$ENDHEX$$rif sur le titre de la Window, doit contenir Word
			
			/////////////////////////////////////////////////////////////////////////////////////////////////////////
			//
			// 	Compte nombre de sous windows de la window en cours
			// 		Le vrai word en a au moins 4, 
			//		Les Windows parasites en ont une seule  
			//
			/////////////////////////////////////////////////////////////////////////////////////////////////////////
			lNbChild = 0
			lChildHandle = FindWindowExA ( lFatherHandle, lNull, sNull, sNull )
			if lChildHandle>0 then
				// La fen$$HEX1$$ea00$$ENDHEX$$tre p$$HEX1$$e800$$ENDHEX$$re poss$$HEX1$$e800$$ENDHEX$$de au moins un enfant, on parcourt toute la liste pour les compter
				do
					lNbChild = lNbChild +1 
					lChildHandle = FindWindowExA ( lFatherHandle, lChildHandle, sNull, sNull )
				loop while ( lChildHandle > 0)
				
				// Si la fen$$HEX1$$ea00$$ENDHEX$$tre en cours contient plus d'un enfant, on consid$$HEX1$$e800$$ENDHEX$$re que c'est Word
				if lNbChild>1 then 
					// Word trouv$$HEX1$$e900$$ENDHEX$$, on sort de la boucle de recheche
					bWindowFound = true
				end if
			else // if lRetHandle>0 then
				// La fen$$HEX1$$ea00$$ENDHEX$$tre p$$HEX1$$e800$$ENDHEX$$re n'a pas de fen$$HEX1$$ea00$$ENDHEX$$tre enfant
				bWindowFound = false
			end if
		end if
	else // if lFatherHandle > 0 then
		bWindowFound = false		
	end if
loop while (lFatherHandle>0 and bWindowFound=false)

// [MIGPB11] [LBP] : Fin Migration

If	bWindowFound and lFatherHandle > 0	Then 	Return ( lFatherHandle )

Return ( 0 )


// [EMD] ancien code :

//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word::uf_WordOuvert		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 10:03:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Le programme WORD est-il en train de tourner ?
//*
//* Arguments		: Aucun
//*
//* Retourne		: ULong			 ? = Word est en train de fonctionner, on retourne le HANDLE de la fen$$HEX1$$ea00$$ENDHEX$$tre
//*										 0 = Word ne fonctionne pas
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

//Return ( -1 )

end function

public function integer uf_fichierouvertdansword (ref oleobject aOleObject, boolean abFermer, boolean abfermer_SansVerifier);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word::uf_FichierOuvertDansWord		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 16:11:10
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Existe-t-il des fichiers ouverts dans l'objet OLE WORD
//*
//* Arguments		: (R$$HEX1$$e900$$ENDHEX$$f)		OleObject		aOleObject
//*					  (Val)		Boolean			abFermer
//*					  (Val)		Boolean			abFermer_SansVerifier
//*
//* Retourne		: Integer				 1 = Il n'existe aucun document modifi$$HEX2$$e9002000$$ENDHEX$$dans WORD
//*												-1 = L'instance du NVUO est fausse
//*												-2 = Il existe des documents non sauvegard$$HEX1$$e900$$ENDHEX$$s
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------


Return ( -1 )

end function

public function integer uf_fermerword ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word::uf_FermerWord		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 14:45:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On s'occupe de fermer la fen$$HEX1$$ea00$$ENDHEX$$tre WORD si elle est ouverte
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

public function integer uf_creeroleobject_word (ref oleobject aOleObject);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word::uf_CreerOleObject_Word		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 14:41:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cette fonction se charge de cr$$HEX1$$e900$$ENDHEX$$er la r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence $$HEX2$$e0002000$$ENDHEX$$WORD
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

public function integer uf_agrandirword (boolean abAgrandir);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word::uf_AgrandirWord			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 26/04/2000 10:03:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On veut maximizer ou minimizer la fen$$HEX1$$ea00$$ENDHEX$$tre WORD.
//*
//* Arguments		: Boolean	(Val)		abAgrandir
//*
//* Retourne		: Integer		 1 = Tout se passe bien
//*										 0 = Word ne fonctionne pas
//*										-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Return ( -1 )


end function

public subroutine uf_commandeword (integer aitype, string asparam1, ref oleobject aoleobject);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word::uf_CommandeWord		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 27/04/2000 16:03:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On lance une commande WORD
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

public function integer uf_setversionword (string as_majeur, string as_moyen, string as_mineur);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word::uf_SetVersionWord		(PUBLIC)
//* Auteur			: Franck Musso
//* Date				: 22/09/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la version compl$$HEX1$$e800$$ENDHEX$$te de Word
//*
//* Arguments		: (Val)		String		as_majeur
//*					  (Val)		String		as_moyen
//*					  (Val)		String		as_mineur
//*
//* Retourne		: Integer				 0
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

is_VersionMajeur = as_majeur
is_VersionMoyen = as_moyen
is_VersionMineur = as_mineur

Return 0

end function

public function string uf_getsousrepmodele ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word::uf_GetSousRepModele			(PUBLIC)
//* Auteur			: Franck Musso
//* Date				: 22/09/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: sous r$$HEX1$$e900$$ENDHEX$$pertoire sp$$HEX1$$e900$$ENDHEX$$cifique au mod$$HEX1$$e800$$ENDHEX$$le en fonction de la version de WORD.
//*
//* Arguments		: Aucun
//*
//* Retourne		: String		 Sous r$$HEX1$$e900$$ENDHEX$$pertoire sp$$HEX1$$e900$$ENDHEX$$cifique
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

If not IsNull(is_SousRepModele) and len(is_SousRepModele) > 0 Then
	If Right(is_SousRepModele, 1) <> '\' Then 
		Return is_SousRepModele + '\'
	Else
		Return is_SousRepModele
	End If
End If

Return ''

end function

protected function integer uf_corrigecheminmodele (ref string as_chemin_complet);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word::uf_CorrigeCheminModele			(PROTECTED)
//* Auteur			: Franck Musso
//* Date				: 22/09/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: si le chemin pass$$HEX2$$e9002000$$ENDHEX$$ne tient pas compte du sous-r$$HEX1$$e900$$ENDHEX$$pertoire 
//* 					du modele courrier.dot sp$$HEX1$$e900$$ENDHEX$$cifique $$HEX2$$e0002000$$ENDHEX$$la version de Word,
//* 					ins$$HEX1$$e800$$ENDHEX$$re ce sous-r$$HEX1$$e900$$ENDHEX$$pertoire dans le chemin
//*
//* 					On ins$$HEX1$$e800$$ENDHEX$$re (s'il existe) le sous-r$$HEX1$$e900$$ENDHEX$$pertoire sp$$HEX1$$e900$$ENDHEX$$cifique $$HEX2$$e0002000$$ENDHEX$$la version de Word
//* 					et on teste l'existance du fichier. Si le fichier existe on conserve la modification
//* 					sinon on reprend le chemin original
//*
//* Arguments		: String	(Ref)		as_chemin_complet, modifi$$HEX2$$e9002000$$ENDHEX$$si n$$HEX1$$e900$$ENDHEX$$cessaire
//*
//* Retourne		: Integer			 0 : chemin modifi$$HEX1$$e900$$ENDHEX$$
//*										 1 = chemin non modifi$$HEX2$$e9002000$$ENDHEX$$(modification inutile)
//*										-1 = Erreur
//*
//*-----------------------------------------------------------------
//* MAJ     	PAR	Date	  		Modification
//* 			FMU	05/10/2010	adaptation $$HEX2$$e0002000$$ENDHEX$$la correction du chemin enregistr$$HEX2$$e9002000$$ENDHEX$$dans le document
//* 
//*-----------------------------------------------------------------
string			ls_result, ls_fin_avec_ssrep
Integer		li_result
long			ll_pos, ll_pos2
n_cst_string	lo_string

li_result = -1
// [Office2010] [FMU] : Debut : 11/10/2010 / Parfois l'extension est omise dans le fichier .INI, tester et l'ajouter si n$$HEX1$$e900$$ENDHEX$$cessaire avant le traitement
If Upper(Right(as_chemin_complet, 4)) <> '.DOT' and Upper(Right(as_chemin_complet, 4)) <> '.DOC' and &
		Upper(Right(as_chemin_complet, 5)) <> '.DOTX' and Upper(Right(as_chemin_complet, 5)) <> '.DOCX' Then
	as_chemin_complet = as_chemin_complet + '.dot'
End If
// [Office2010] [FMU] : Fin

If not IsNull(is_SousRepModele) and len(is_SousRepModele) > 0 Then
	//un sous-rep sp$$HEX1$$e900$$ENDHEX$$cifique au mod$$HEX1$$e800$$ENDHEX$$le est d$$HEX1$$e900$$ENDHEX$$fini, on l'ajoute au chemin
	ll_pos = lo_string.of_LastPos(as_chemin_complet, '\')
	ls_result = left(as_chemin_complet, ll_pos) + uf_GetSousRepModele() + Right(as_chemin_complet, Len(as_chemin_complet) - ll_pos)
	If FileExists(ls_result) Then
		as_chemin_complet = ls_result
		li_result = 0
		//MessageBox('Test FMU office 2010', 'Utilisation du chemin modifi$$HEX1$$e900$$ENDHEX$$~r~n' + as_chemin_complet)
	Else
		//FMU 05/10/2010 : tester si le fichier existe en rempla$$HEX1$$e700$$ENDHEX$$ant le dernier sous-r$$HEX1$$e900$$ENDHEX$$pertoire 
		//par celui sp$$HEX1$$e900$$ENDHEX$$cifique $$HEX2$$e0002000$$ENDHEX$$cette version de Word (pour modification du mod$$HEX1$$e800$$ENDHEX$$le attach$$HEX2$$e9002000$$ENDHEX$$au fichier)
		ll_pos2 = lo_string.of_LastPos(left(as_chemin_complet, ll_pos - 1), '\')
		ls_result = left(as_chemin_complet, ll_pos2) + uf_GetSousRepModele() + Right(as_chemin_complet, Len(as_chemin_complet) - ll_pos)
		If FileExists(ls_result) Then
			//si le sous r$$HEX1$$e900$$ENDHEX$$pertoire sp$$HEX1$$e900$$ENDHEX$$cifique $$HEX1$$e900$$ENDHEX$$tait identique, ne pas indiquer de changement
			If ls_result = as_chemin_complet Then
				li_result = 1
			Else
				as_chemin_complet = ls_result
				li_result = 0
			End If
		Else
			//il faut v$$HEX1$$e900$$ENDHEX$$rifier l'existence du fichier dans le sous-r$$HEX1$$e900$$ENDHEX$$pertoire p$$HEX1$$e800$$ENDHEX$$re car on peut avoir un mod$$HEX1$$e900$$ENDHEX$$le 
			//provenant d'un sous-r$$HEX1$$e900$$ENDHEX$$pertoire sp$$HEX1$$e900$$ENDHEX$$cifique alors que la version courante de Word doit appeler
			//le modele par d$$HEX1$$e900$$ENDHEX$$faut hors sous-r$$HEX1$$e900$$ENDHEX$$pertoire sp$$HEX1$$e900$$ENDHEX$$cifique
			ls_result = left(as_chemin_complet, ll_pos2) + Right(as_chemin_complet, Len(as_chemin_complet) - ll_pos)
			If FileExists(ls_result) Then
				//ici on prend le fichier du r$$HEX1$$e900$$ENDHEX$$pertoire COURRIER au lieu du sous r$$HEX1$$e900$$ENDHEX$$pertoire sp$$HEX1$$e900$$ENDHEX$$cifique $$HEX2$$e0002000$$ENDHEX$$la version de Word de cr$$HEX1$$e900$$ENDHEX$$ation du .DOC
				as_chemin_complet = ls_result
				li_result = 0
			Else
				//on ne modifie pas le chemin
				li_result = 1
			End If
		End If
	End If
Else
	//sous-r$$HEX1$$e900$$ENDHEX$$pertoire sp$$HEX1$$e900$$ENDHEX$$cifique non d$$HEX1$$e900$$ENDHEX$$fini pour cette version
	//ou le fichier sp$$HEX1$$e900$$ENDHEX$$cifi$$HEX2$$e9002000$$ENDHEX$$n'est pas le mod$$HEX1$$e800$$ENDHEX$$le courrier.dot
	//ls_result = as_chemin_complet
	li_result = 1
End If

Return li_result

end function

protected function integer uf_corrigemodele (ref oleobject aole_word);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Word::uf_CorrigeModele			(PROTECTED)
//* Auteur			: Franck Musso
//* Date				: 05/10/2010
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: corrige le modele de document .dot stock$$HEX2$$e9002000$$ENDHEX$$dans le fichier .doc
//* 					pour appliquer les macros compatibles avec la version de Word
//* 					(ces macros sont prises dans le modele)
//*					remarque : cette fonction est a surcharger dans le descendant si 
//*					les fonctions OLE pour r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer le modele ont chang$$HEX1$$e900$$ENDHEX$$
//*
//* Arguments		: OLOObject	Objet OLE Word
//*
//* Retourne		: Integer			 0 : modele modifi$$HEX1$$e900$$ENDHEX$$
//*										 1 = modele non modifi$$HEX2$$e9002000$$ENDHEX$$(modification inutile)
//*										-1 = Erreur
//*
//*-----------------------------------------------------------------
//* MAJ     	PAR	Date	  		Modification
//* 
//*-----------------------------------------------------------------
string			ls_CheminModele, ls_FichierModele, ls_tmp
Integer		li_result

li_result = -1

//r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du chemin du modele
ls_FichierModele = aole_word.Application.Build
ls_FichierModele = aole_word.ActiveDocument.AttachedTemplate.Name
ls_CheminModele = aole_word.ActiveDocument.AttachedTemplate.Path
ls_tmp = ls_CheminModele + '\' + ls_FichierModele

li_result = uf_CorrigeCheminModele(ls_tmp)

//remettre si n$$HEX1$$e900$$ENDHEX$$cessaire le modele correcte dans le doc Word
If li_result = 0 Then
	//ls_tmp contient le nouveau chemin complet $$HEX2$$e0002000$$ENDHEX$$utiliser!
	aole_word.Application.ActiveDocument.AttachedTemplate = ls_tmp
End If

return li_result

end function

on n_cst_word.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_word.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

