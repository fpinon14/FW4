HA$PBExportHeader$u_declarationfilenet.sru
$PBExportComments$----} UserObjet pour les d$$HEX1$$e900$$ENDHEX$$clarations externes FileNet
forward
global type u_declarationfilenet from nonvisualobject
end type
end forward

global type u_declarationfilenet from nonvisualobject
end type
global u_declarationfilenet u_declarationfilenet

type prototypes
// .... D$$HEX1$$e900$$ENDHEX$$clarations pour FileNet

FUNCTION LONG LW_SetEnviron ( String envpth ) LIBRARY "fildll.dll" alias for "LW_SetEnviron;Ansi"
FUNCTION LONG LW_Disp ( String sMessage ) LIBRARY "fildll.dll" alias for "LW_Disp;Ansi"
FUNCTION LONG LW_Try ( ref Long liste[] ) LIBRARY "fildll.dll"

FUNCTION LONG cF_Logon ( String username, String password ) LIBRARY "fildll.dll" alias for "cF_Logon;Ansi"
FUNCTION LONG cF_Logoff () LIBRARY "fildll.dll"

FUNCTION LONG cF_Lire_Index ( String idxnom, Long docid, ref String idxval ) LIBRARY "fildll.dll" alias for "cF_Lire_Index;Ansi"
FUNCTION LONG cF_Maj_Index ( String idxnom, Long docid, String idxval, String idxtype ) LIBRARY "fildll.dll" alias for "cF_Maj_Index;Ansi"

FUNCTION LONG cF_Lire_Dq ( String dqnom, String fichier ) LIBRARY "fildll.dll" alias for "cF_Lire_Dq;Ansi"
FUNCTION LONG cF_Supprimer_Dq ( String dqnom ) LIBRARY "fildll.dll" alias for "cF_Supprimer_Dq;Ansi"
FUNCTION LONG cF_Vider_Dq ( String dqnom ) LIBRARY "fildll.dll" alias for "cF_Vider_Dq;Ansi"

FUNCTION LONG cF_Trouver_Id_Dossier ( String dossnom) LIBRARY "fildll.dll" alias for "cF_Trouver_Id_Dossier;Ansi"
FUNCTION LONG cF_Trouver_Nom_Dossier ( Long dossid, ref String dossnom ) LIBRARY "fildll.dll" alias for "cF_Trouver_Nom_Dossier;Ansi"
FUNCTION LONG cF_Creer_Dossier ( String dossnom ) LIBRARY "fildll.dll" alias for "cF_Creer_Dossier;Ansi"
FUNCTION LONG cF_Supprimer_Dossier ( Long dossid, Long verif ) LIBRARY "fildll.dll"
FUNCTION LONG cF_Inserer_Doc_Dossier ( Long dossid, Long docid ) LIBRARY "fildll.dll"
FUNCTION LONG cF_Supprimer_Doc_Dossier ( Long dossid, Long docid ) LIBRARY "fildll.dll"
FUNCTION LONG cF_Trouver_Dossiers ( Long dossid, ref Long listids[], Long maxids ) LIBRARY "fildll.dll"
FUNCTION LONG cF_Trouver_Docs_Dossier ( Long dossid, ref Long listids[], Long maxids ) LIBRARY "fildll.dll"
FUNCTION LONG cF_Maj_Dossier ( Long dossid, String dossnom ) LIBRARY "fildll.dll" alias for "cF_Maj_Dossier;Ansi"

FUNCTION LONG cF_Lire_Nb_Pages ( Long docid ) LIBRARY "fildll.dll"

FUNCTION Long cF_Archive_Fichier ( String pthnom ) LIBRARY "fildll.dll" alias for "cF_Archive_Fichier;Ansi"
FUNCTION Long cF_Recupere_Fichier ( Long docid, ref String pthnom ) LIBRARY "fildll.dll" alias for "cF_Recupere_Fichier;Ansi"

FUNCTION Long cF_Liste_Batches ( String pthnom ) LIBRARY "fildll.dll" alias for "cF_Liste_Batches;Ansi"
FUNCTION Long cF_Index_Batch ( String batchname ) LIBRARY "fildll.dll" alias for "cF_Index_Batch;Ansi"
FUNCTION Long cF_Commit_Batch ( String batchname, String docpth, String inxpth, String ixnom ) LIBRARY "fildll.dll" alias for "cF_Commit_Batch;Ansi"
FUNCTION Long cF_Info_Batch ( String batchname, String docpth, String inxpth, String ixnom ) LIBRARY "fildll.dll" alias for "cF_Info_Batch;Ansi"

FUNCTION Long cF_Cherche_Docs ( String idxnom, String idxval, Int doctype, Int maxelem, ref Long liste[], ref Long incomplet ) LIBRARY "fildll.dll" alias for "cF_Cherche_Docs;Ansi"
FUNCTION Long cF_Prefetch ( String filename, Long mode ) LIBRARY "fildll.dll" alias for "cF_Prefetch;Ansi"
end prototypes

forward prototypes
public function long fn_archive_fichier (string snomfic)
public function long fn_cherche_docs (string asnomindex, string asvaleur, integer idoctype, integer imaxelements, ref long lliste[], ref long lincomplet)
public function long fn_commit_batch (string asnomlot, string asnomfic, string asnomficidx, string asidx)
public function long fn_creerfolder (string asnomfolder)
public function long fn_index_batch (string asnomlot)
public function long fn_info_batch (string asnomlot, string asnomfic, string asnomficidx, string asidx)
public function long fn_inserer_doc_dossier (long alfolderid, long aldocid)
public function long fn_liredq (string asnomdq, string asnomfic)
public function long fn_lireindex (string asnomidx, long aldocid, ref string asvalidx)
public function long fn_lirenbpage (long aldocid)
public function boolean fn_halt_close ()
public function long fn_liste_batches (string asnomfic)
public function long fn_logoff ()
public function long fn_logon (string snomuser, string smotpasse)
public function long fn_lw_disp (string smess)
public function long fn_lw_setenviron (string snomfic)
public function long fn_majindex (string asnomidx, long aldocid, string asvalidx, string astypeidx)
public function long fn_prefetch (string asnomfic, long almode)
public function long fn_recupere_fichier (long ldocid, ref string asnomfic)
public function long fn_suppdq (string asnomdq)
public function long fn_supprimer_doc_dossier (long alfolderid, long aldocid)
public function long fn_trouver_docs_dossier (long alfolderid, ref long aldocid[], long almaxdocid)
public function long fn_trouver_id_dossier (string asnomfolder)
public function long fn_vider_dq (string asnomdq)
public function long fn_trouver_nom_dossier (long alfolderid, ref string asnomfolder)
public function long fn_supprimer_dossier (long alfolderid, long alverif)
public function long fn_maj_dossier (long alfolderid, string asnomfolder)
end prototypes

public function long fn_archive_fichier (string snomfic);//*******************************************************************************************
// Fonction            	: FN_Archive_Fichier
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Archive un fichier (Type OTHER) sue le syst$$HEX1$$e900$$ENDHEX$$me FILENET
//									et renvoi son DocId
// Arguments				: sNomFic 		String	Val
//
// Retourne					: Long
//								  
//*******************************************************************************************

Long lDocId

lDocId	= cF_Archive_Fichier ( sNomFic )

Return ( lDocId )




end function

public function long fn_cherche_docs (string asnomindex, string asvaleur, integer idoctype, integer imaxelements, ref long lliste[], ref long lincomplet);//*******************************************************************************************
// Fonction            	: FN_Cherche_Docs
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Lecture des DocIs/FolderIds en fonction d'un Index
//
// Arguments				: String		asNomIndex			(Val)	Nom de l'index 
// 							  String		asValeur				(Val)	Valeur recherch$$HEX1$$e900$$ENDHEX$$e
// 							  Int			iDocType				(Val)	Type du document recherch$$HEX1$$e900$$ENDHEX$$
// 							  Int			iMaxElements		(Val)	Nombre maximum d'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments revoy$$HEX1$$e900$$ENDHEX$$s
// 							  Long		lListe[]				(R$$HEX1$$e900$$ENDHEX$$f)	Tableau $$HEX2$$e0002000$$ENDHEX$$remplir
//								  Long		lIncomplet			(R$$HEX1$$e900$$ENDHEX$$f)	Le tableau est-il plein ?
//
// Retourne					: Long		? 	= Nbr d'$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$ments ramen$$HEX1$$e900$$ENDHEX$$s
//												-1	= Autre Erreur
//												-2	= Index inconnu
//								  
//*******************************************************************************************


Long lRet

lRet	= cF_Cherche_Docs ( asNomIndex, asValeur, iDocType, iMaxElements, lListe[], lIncomplet )

Return ( lRet )


// cF_Cherche_Docs (string idxnom, string idxval, int doctype, int maxelem, ref long liste[], ref long incomplet)
//
// Fabrique la liste des paires (doc_id,folder_id) pour tous les documents satisfaisant aux conditions, $$HEX2$$e0002000$$ENDHEX$$savoir:
// (a) pour l'index idxnom, ils ont la valeur idxval
// (b) et, si doctype est non nul, ils sont de l'un des types autoris$$HEX1$$e900$$ENDHEX$$s par doctype.
//
// Les types de docs possibles sont: image (1), text (2), form (4), mixed (8), other (16). Si on met doctype $$HEX2$$e0002000$$ENDHEX$$0,
// on n'impose aucune condition sur le type des documents. Si au contraire on souhaite restreindre la recherche $$HEX1$$e000$$ENDHEX$$
// tous les documents qui sont soit texte, soit image, on mettra doctype $$HEX2$$e0002000$$ENDHEX$$3 (= 2 + 1).



end function

public function long fn_commit_batch (string asnomlot, string asnomfic, string asnomficidx, string asidx);//*******************************************************************************************
// Fonction            	: FN_Commit_Batch
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Archivage Automatique du Batch, apr$$HEX1$$e900$$ENDHEX$$s avoir v$$HEX1$$e900$$ENDHEX$$rifi$$HEX2$$e9002000$$ENDHEX$$que c'est possible
//
// Arguments				: String		asNomLot			(Val)	Nom du lot $$HEX2$$e0002000$$ENDHEX$$traiter
//								  String		asNomFic			(Val)	Nom du fichier contenant les doc_id
//								  String		asNomFicIdx		(Val)	Nom du fihcier contenant les valeurs d'index
//								  String		asIdx				(Val)	Nom de l'index pour produire le fichier
//
// Retourne					: Long		 1 = Ok
//												-1 = Probl$$HEX1$$e900$$ENDHEX$$me sur l'archivage
//												-2 = Le lot ne peut $$HEX1$$ea00$$ENDHEX$$tre archiv$$HEX1$$e900$$ENDHEX$$u
//								  
//*******************************************************************************************

Long lRet

lRet = cF_Commit_Batch ( asNomLot, asNomFic, asNomFicIdx, asIdx )

Return ( lRet )

end function

public function long fn_creerfolder (string asnomfolder);//*******************************************************************************************
// Fonction            	: FN_CreerFolder
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Cr$$HEX1$$e900$$ENDHEX$$ation d'un folder FILENET
//
// Arguments				: String		asNomFolder		(Val)	Nom du folder a cr$$HEX1$$e900$$ENDHEX$$er
//
// Retourne					: Long		-1	= Erreur
//												-2	= Erreur, Le Folder existe d$$HEX1$$e900$$ENDHEX$$j$$HEX1$$e000$$ENDHEX$$
//												 1 	= OK
//								  
//*******************************************************************************************

Long lRet

lRet = cF_Creer_Dossier ( asNomFolder )

Return ( lRet )
end function

public function long fn_index_batch (string asnomlot);//*******************************************************************************************
// Fonction            	: FN_Index_Batch
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Indexation Automatique du Batch, apr$$HEX1$$e900$$ENDHEX$$s avoir v$$HEX1$$e900$$ENDHEX$$rifi$$HEX2$$e9002000$$ENDHEX$$que c'est possible
//
// Arguments				: String		asNomLot			(Val)	Nom du lot $$HEX2$$e0002000$$ENDHEX$$traiter
//
// Retourne					: Long		 1 = Ok
//												-1 = Probl$$HEX1$$e900$$ENDHEX$$me sur l'indexation
//												-2 = Le lot ne peut $$HEX1$$ea00$$ENDHEX$$tre index$$HEX1$$e900$$ENDHEX$$
//								  
//*******************************************************************************************

Long lRet

lRet = cF_Index_Batch ( asNomLot )

Return ( lRet )

end function

public function long fn_info_batch (string asnomlot, string asnomfic, string asnomficidx, string asidx);//*******************************************************************************************
// Fonction            	: FN_Info_Batch
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Cr$$HEX1$$e900$$ENDHEX$$ation des fichiers correspondant au contenu d'un lot
//
// Arguments				: String		asNomLot			(Val)	Nom du lot $$HEX2$$e0002000$$ENDHEX$$traiter
//								  String		asNomFic			(Val)	Nom du fichier contenant les doc_id
//								  String		asNomFicIdx		(Val)	Nom du fichier contenant les valeurs d'index
//								  String		asIdx				(Val)	Nom de l'index pour produire le fichier
//
// Retourne					: Long
//								  
//*******************************************************************************************

Long lRet

lRet	= cF_Info_Batch ( asNomLot, asNomFic, asNomFicIdx, asIdx )

Return ( lRet )


end function

public function long fn_inserer_doc_dossier (long alfolderid, long aldocid);//*******************************************************************************************
// Fonction            	: FN_Inserer_Doc_Dossier
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Insertion d'un DocId dans un FolderId
//
// Arguments				: Long		alFolderId			(Val)	N$$HEX2$$b0002000$$ENDHEX$$du folder
//								  Long		alDocId				(Val)	N$$HEX2$$b0002000$$ENDHEX$$du document
//
// Retourne					: Long		-1	= Erreur
//												-2	= Folder_Id Invalide
//												-3	= Doc_Id Invalide
//												-4	= Le document existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$dans le folder
//												 1	= OK
//								  
//*******************************************************************************************

Long lRet

lRet = cF_Inserer_Doc_Dossier ( alFolderId, alDocId )

Return ( lRet )
end function

public function long fn_liredq (string asnomdq, string asnomfic);//*******************************************************************************************
// Fonction            	: FN_LireDq
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Lecture de la queue de distribution
//
// Arguments				: String		asNomDq			(Val)	Nom de la queue de distribution
//								  String		asNomFic			(Val)	Nom du fichier
//
// Retourne					: Long		-1	= Erreur
//												 ?	= Nbr d'enregistrements dans la queue
//								  
//*******************************************************************************************

Long lRet

lRet = cF_Lire_Dq ( asNomDq, asNomFic )

Return ( lRet )
end function

public function long fn_lireindex (string asnomidx, long aldocid, ref string asvalidx);//*******************************************************************************************
// Fonction            	: FN_LireIndex
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Lecture d'un index sur le moteur FILENET
//
// Arguments				: String		asNomIdx			(Val)	Nom de l'index a mettre $$HEX2$$e0002000$$ENDHEX$$jour
//								  Long		alDocId			(Val)	N$$HEX2$$b0002000$$ENDHEX$$du document
//								  String		asValIdx			(R$$HEX1$$e900$$ENDHEX$$f)	Valeur de l'index
//
// Retourne					: Long		-1	= Erreur
//												 1 	= OK
//								  
//*******************************************************************************************

Long lRet, lLong

lRet = 1
lLong = Len ( asValIdx )

If	lLong < 256 Then
	asValIdx = asValIdx + Space ( 256 - lLong )
End If

lRet = cF_Lire_Index ( asNomIdx, alDocId, asValIdx )

Return ( lRet )

end function

public function long fn_lirenbpage (long aldocid);//*******************************************************************************************
// Fonction            	: FN_LireNbPage
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du Nbr de page d'un document
//
// Arguments				: Long		alDocId				(Val)	N$$HEX2$$b0002000$$ENDHEX$$du document
//
// Retourne					: Long		-1	= Erreur
//												 ?	= Nbr de page du document
//								  
//*******************************************************************************************

Long lRet

lRet = cF_Lire_Nb_Pages ( alDocId )

Return ( lRet )
end function

public function boolean fn_halt_close ();//*******************************************************************************************
// Fonction            	: FN_Halt_Close
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: D$$HEX1$$e900$$ENDHEX$$cr$$HEX1$$e900$$ENDHEX$$mentation du nb de connexion FileNet
//
// Arguments				: Aucun
//
// Retourne					: Boolean
//								  
//*******************************************************************************************

uInt	uiHandle	

uiHandle = stGLB.uoWin.Uf_FindWindow ( "FNWND040", "Connexion FileNet" )

If uiHandle <> 0 Then	Post ( uiHandle, 1098, 0, 0 )

Halt Close ;

Return True
end function

public function long fn_liste_batches (string asnomfic);//*******************************************************************************************
// Fonction            	: FN_Liste_Batches
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la liste des lots en attente
//
// Arguments				: Long		asNomFic			(Val)	Nom du fichier Texte de sortie
//
// Retourne					: Long		-1	= Erreur
//												-2	= Erreur Interface Filenet
//												 0	= Tout est OK
//								  
//*******************************************************************************************

Long lRet

lRet	= cF_Liste_Batches ( asNomFic )

Return ( lRet )




end function

public function long fn_logoff ();//*******************************************************************************************
// Fonction            	: FN_Logoff
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Provoque la d$$HEX1$$e900$$ENDHEX$$sinscription de l'utilisateur.
//
// Arguments				: Aucun
//
// Retourne					: Long
//								  
//*******************************************************************************************

Long lRet

lRet	=  cF_Logoff ()

Return ( lRet )


end function

public function long fn_logon (string snomuser, string smotpasse);//*******************************************************************************************
// Fonction            	: FN_Logon
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Provoque l'inscription de l'utilisateur $$HEX2$$e0002000$$ENDHEX$$l'IMS par d$$HEX1$$e900$$ENDHEX$$faut.
//
// Arguments				: String		sNomUser		(Val) Nom de l'utilisateur
//								  String		sMotPasse	(Val) Mot de Passe
//
// Retourne					: Long
//								  
//*******************************************************************************************

Long lRet

lRet	= cF_Logon ( sNomUser, sMotPasse )

Yield ()
Yield ()

Return ( lRet )


end function

public function long fn_lw_disp (string smess);//*******************************************************************************************
// Fonction            	: FN_Lw_Disp
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Affichage d'une cha$$HEX1$$ee00$$ENDHEX$$ne sur la fen$$HEX1$$ea00$$ENDHEX$$tre de trace LWLogWin
//
// Arguments				: String		sMess			(Val) Message
//
// Retourne					: Long
//								  
//*******************************************************************************************

Long lRet

lRet	= LW_Disp ( sMess )

Return ( lRet )


end function

public function long fn_lw_setenviron (string snomfic);//*******************************************************************************************
// Fonction            	: FN_Lw_SetEnviron
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: 	sNomFic	Full path name du fichier d'environnement de l'application.
//												Pour que la trace puisse $$HEX1$$e900$$ENDHEX$$ventuellement fonctionner, il faut
//												que ce fichier contienne une section [LWLogWin], comportant
//												les entr$$HEX1$$e900$$ENDHEX$$es LogDisp et LogFile. Exemple:
//
//												[LWLogWin]
//													LogDisp = d:\filenet\spb\win\exe
//													LogFile = d:\filenet\spb\pb3\logfile.txt
//
//													LogDisp est le fullpath du r$$HEX1$$e900$$ENDHEX$$pertoire contenant FILTST.EXE,
//													lequel assure la trace $$HEX1$$e900$$ENDHEX$$cran.
//													LogFile est le fullpath du fichier log
//  
//
// Arguments				: String		sNomFic			(Val) Nom du fichier environnement
//
// Retourne					: Long
//								  
//*******************************************************************************************

Long lRet

lRet	= LW_SetEnviron ( sNomFic )

Return ( lRet )
end function

public function long fn_majindex (string asnomidx, long aldocid, string asvalidx, string astypeidx);//*******************************************************************************************
// Fonction            	: FN_MajIndex
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Mise $$HEX2$$e0002000$$ENDHEX$$jour d'un index sur le moteur FILENET
//
// Arguments				: String		asNomIdx			(Val)	Nom de l'index a mettre $$HEX2$$e0002000$$ENDHEX$$jour
//								  Long		alDocId				(Val)	N$$HEX2$$b0002000$$ENDHEX$$du document
//								  String		asValIdx			(Val)	Valeur de l'index
//								  String		asTypeIdx			(Val)	Type de conversion
//											"1" --> String
//											"2" --> Date
//											"3" --> DateTime
//											"4" --> Number
//
// Retourne					: Long		-1	= Erreur
//												-2	= Erreur de Type
//												 1 = OK
//								  
//*******************************************************************************************

Long lRet

lRet = cF_Maj_Index ( asNomIdx, alDocId, asValIdx, asTypeIdx )

Return ( lRet )
end function

public function long fn_prefetch (string asnomfic, long almode);//*******************************************************************************************
// Fonction            	: FN_Prefetch
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Gestion du Prefetch
//								  Provoque le prefetch de tous les documents dont 
//								  le doc_id est indiqu$$HEX2$$e9002000$$ENDHEX$$dans le fichier asNomFic
//							  	  Si mode=0, prefetch sur cache serveur; si mode=1, prefetch local sur PC
//
//
// Arguments				: String		asNomFic			(Val)	Nom du Fichier contenant les DocIds
//								  Long		alMode			(Val)	Mode de Pr$$HEX1$$e900$$ENDHEX$$fetch
//
// Retourne					: Long		-1	= Erreur
//												 1 = OK
//								  
//*******************************************************************************************

Long lRet

lRet = cF_Prefetch ( asNomFic, alMode )

Return ( lRet )

end function

public function long fn_recupere_fichier (long ldocid, ref string asnomfic);//*******************************************************************************************
// Fonction            	: FN_Recupere_Fichier
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Charge le document docid dans un fichier dont le nom est retourn$$HEX2$$e9002000$$ENDHEX$$dans pthnom
//
// Arguments				: Long		lDocId			(Val)	N$$HEX2$$b0002000$$ENDHEX$$du Document
//								  String		asNomFic			(R$$HEX1$$e900$$ENDHEX$$f)	Nom du Fichier 
//
// Retourne					: Long		-1	= Erreur
//												 1 = OK
//								  
//*******************************************************************************************

Long lRet

If	Len ( asNomFic ) < 256 Then
	asNomFic = asNomFic + Space ( 256 - Len ( asNomFic ) )
End If

lRet	= cF_Recupere_Fichier ( lDocId, asNomFic )

Return ( lRet )

end function

public function long fn_suppdq (string asnomdq);//*******************************************************************************************
// Fonction            	: FN_SuppDq
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Suppression de la queue de distribution
//
// Arguments				: String		asNomDq				(Val)	Nom de la queue de distribution
//
// Retourne					: Long		-1	= Erreur
//								  
//*******************************************************************************************

Long lRet

lRet = cF_Supprimer_Dq ( asNomDq )

Return ( lRet )
end function

public function long fn_supprimer_doc_dossier (long alfolderid, long aldocid);//*******************************************************************************************
// Fonction            	: FN_Supprimer_Doc_Dossier
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Suppression d'un DocId dans un FolderId
//
// Arguments				: Long		alFolderId			(Val)	N$$HEX2$$b0002000$$ENDHEX$$du folder
//								  Long		alDocId				(Val)	N$$HEX2$$b0002000$$ENDHEX$$du document
//
// Retourne					: Long		-1	= Erreur
//												-2	= Folder_Id Invalide
//												-3	= Doc_Id Invalide
//												-4	= Le document n'existe pas dans le folder
//												 1 	= OK
//								  
//*******************************************************************************************

Long lRet

lRet = cF_Supprimer_Doc_Dossier ( alFolderId, alDocId )

Return ( lRet )

end function

public function long fn_trouver_docs_dossier (long alfolderid, ref long aldocid[], long almaxdocid);//*******************************************************************************************
// Fonction            	: FN_Trouver_Docs_Dossier
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des Doc_Id contenus dans un FolderId
//
// Arguments				: Long		alFolderId		(Val)	FolderId
//								  Long		alDocId[]		(R$$HEX1$$e900$$ENDHEX$$f)	Tableau des DocId
//								  Long		alMaxDocId		(Val)	Nombre Maximum de documents a r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer
//
// Retourne					: Long		-1	= Erreur
//												-2	= Le folder est invalide
//												-3	= lMaxDocId N$$HEX1$$e900$$ENDHEX$$gatif
//												 ?	= Nombre de Documents Lus
//								  
//*******************************************************************************************

Long lRet

If	alMaxDocId <= 0 Then
	lRet = -3
	Return ( lRet )
End If

lRet = cF_Trouver_Docs_Dossier ( alFolderId, alDocId[], alMaxDocId )

Return (  lRet )

end function

public function long fn_trouver_id_dossier (string asnomfolder);//*******************************************************************************************
// Fonction            	: FN_Trouver_Id_Dossier
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du folder Id en fonction du nom
//
// Arguments				: String		asNomFolder	(Val)	Nom du Folder
//
// Retourne					: Long		-1	= Erreur
//												-2	= Le folder n'existe pas
//												 ?	= Folder Id
//								  
//*******************************************************************************************

Long lRet

lRet = cF_Trouver_Id_Dossier ( asNomFolder )

Return ( lRet )
end function

public function long fn_vider_dq (string asnomdq);//*******************************************************************************************
// Fonction            	: FN_Vider_Dq
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Suppression du contenu de la queue de distribution
//
// Arguments				: String		asNomDq				(Val)	Nom de la queue de distribution
//
// Retourne					: Long		-1	= Erreur
//												 ?	= Nbr d'enregistrements supprim$$HEX1$$e900$$ENDHEX$$s dans la queue
//								  
//*******************************************************************************************

Long lRet

lRet = cF_Vider_Dq ( asNomDq )

Return ( lRet )
end function

public function long fn_trouver_nom_dossier (long alfolderid, ref string asnomfolder);//*******************************************************************************************
// Fonction            	: FN_Trouver_Nom_Dossier
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration du nom du folder en fonction du Folder Id
//
// Arguments				: Long		alFolderId	(Val)	Folder Id
//								  String		asNomFolder	(R$$HEX1$$e900$$ENDHEX$$f)	Nom du Folder
//
// Retourne					: Long		-1	= Erreur
//												 1	= Ok
//								  
//*******************************************************************************************

Long lRet

If	Len ( asNomFolder ) < 153 Then
	asNomFolder = asNomFolder + Space ( 153 - Len ( asNomFolder ) )
End If

lRet = cF_Trouver_Nom_Dossier ( alFolderId, asNomFolder )

Return( lRet )

end function

public function long fn_supprimer_dossier (long alfolderid, long alverif);//*******************************************************************************************
// Fonction            	: FN_Supprimer_Dossier
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Suppression d'un Folder Id et $$HEX1$$e900$$ENDHEX$$ventuellement de son contenu
//
// Arguments				: Long		alFolderId	(Val)	Folder Id
//								  Long		alVerif		(Val)	1 -> Suppression si Folder est Vide
//																		0 -> Suppression de tous les documents du folder au pr$$HEX1$$e900$$ENDHEX$$alable
//
// Retourne					: Long		-1	= Erreur
//												 1	= Ok
//								  
//*******************************************************************************************


Long lRet

lRet = cF_Supprimer_Dossier ( alFolderId, alVerif )

Return( lRet )

end function

public function long fn_maj_dossier (long alfolderid, string asnomfolder);//*******************************************************************************************
// Fonction            	: FN_Maj_Dossier
//	Auteur              	: Erick John Stark
//	Date 					 	: 23/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Mise $$HEX2$$e0002000$$ENDHEX$$jour d'un nom de Folder
//
// Arguments				: Long		alFolderId		(Val)	Folder Id
//								  String		asNomFolder		(Val)	Nouveau nom du Folder
//
// Retourne					: Long		-1	= Erreur
//												 1 = OK
//								  
//*******************************************************************************************

Long lRet

lRet	= cF_Maj_Dossier ( alFolderId, asNomFolder )

Return( lRet )
end function

on u_declarationfilenet.create
TriggerEvent( this, "constructor" )
end on

on u_declarationfilenet.destroy
TriggerEvent( this, "destructor" )
end on

