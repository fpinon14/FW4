HA$PBExportHeader$n_cst_protocole_aig_param_gti.sru
$PBExportComments$Objet muti-applications permettant de mettre en oeuvre les controle de param$$HEX1$$e900$$ENDHEX$$trage de la garantie pour le protocole AIG.
forward
global type n_cst_protocole_aig_param_gti from nonvisualobject
end type
end forward

global type n_cst_protocole_aig_param_gti from nonvisualobject
event ue_info ( )
end type
global n_cst_protocole_aig_param_gti n_cst_protocole_aig_param_gti

type variables
public:
constant string K_MSG_PREFIXEOBLIG 	= "AIG0001"
constant string K_MSG_BOUTONAIDE 	= "AIG0002"//GENE161
constant string K_MSG_PARAM_CIE		= "AIG0003"
constant string K_MSG_PREFIXENOMODIF= "AIG0004"
constant string K_MSG_NOPARAMPREFIX = "AIG0005"
constant string K_OK = "OK"

protected:

constant string K_DWO_PREFIXE = "dddw_spb_prefixe_aig"

transaction itrTrans
datastore 	idsPrefixe
datawindow 	idwGarantie
string		isprefixecolname
string		ispolicecolname
end variables

forward prototypes
public function integer uf_initialiser (datawindow adwgarantie, string asprefixecolname, string aspolicecolname, ref transaction atrtrans)
protected function integer uf_share_prefixe ()
public function boolean uf_existsinistre (string asidprod, string asidgti)
public function integer uf_getidcie (integer aiidpolice)
public function integer uf_charge_prefixe (integer aiidpolice)
public function boolean uf_controler_prefixe (integer aiidpolice, ref string asidmsg)
public function integer uf_init_prefixe (ref datastore adsidprefixe, transaction atrtrans)
public function boolean uf_existsinistre (string asidprod, string asidgti, transaction atrtrans)
public function boolean uf_cieestaig (datastore adsidprefixe, long alidcie)
public function string uf_verif_param_aig (string asidprod, string asidrev, string asidgti, transaction atrtrans)
end prototypes

event ue_info();//*-----------------------------------------------------------------
//*
//* Objet			: n_cst_protocole_aig_param_gti
//* Evenement 		: ue_info
//* Auteur			: PHG
//* Date				: 28/05/2008 17:12:57
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [DCMP070914] Objet de gestion du param$$HEX1$$e900$$ENDHEX$$trage du 
//*										protocole AIG pour le param$$HEX1$$e900$$ENDHEX$$trage.
//* Commentaires	: 
//*				  
//* Arguments		: 	
//*
//* Retourne		: (none)
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

//*-----------------------------------------------------------------
/* M$$HEX1$$e900$$ENDHEX$$thodes Publique Impl$$HEX1$$e900$$ENDHEX$$ment$$HEX1$$e900$$ENDHEX$$es :                                 */
/* - uf_initialiser : Initialisation de cet objet                   */
/* 						 On pass les r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rences des objets applicatif  */
/*							 $$HEX2$$e0002000$$ENDHEX$$utiliser.											  */
/*                                                                  */
/* - uf_existsinistre : Permet de tester si un sinistre existe.     */
/* utilisation de ds_existsinistre.                                 */
/*                                                                  */
/* - uf_charge_pr$$HEX1$$e900$$ENDHEX$$fixe : Permet d'assurer le chargement des         */
/* pr$$HEX1$$e900$$ENDHEX$$fixes suivant la police.                                      */
/*                                                                  */
/* - uf_controler_pr$$HEX1$$e900$$ENDHEX$$fixe : Permet de savoir si un pr$$HEX1$$e900$$ENDHEX$$fixe doit     */
/* $$HEX1$$ea00$$ENDHEX$$tre saisi ou pas.                                               */
/*------------------------------------------------------------------*/

end event

public function integer uf_initialiser (datawindow adwgarantie, string asprefixecolname, string aspolicecolname, ref transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Objet			: n_cst_protocole_aig_param_gti
//* Evenement 		: uf_initialiser
//* Auteur			: PHG
//* Date				: 28/05/2008 17:42:53
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialise l'objets
//*				  
//* Arguments		: ref transaction atrtrans	 */
//*
//* Retourne		: integer
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
n_cst_string	lnv_string
integer iret

// 0/ V$$HEX1$$e900$$ENDHEX$$rif des param
if Not isvalid(atrTrans) or &
	Not isvalid(adwGarantie) or &
	lnv_string.of_IsEmpty(asprefixecolname) or &
	lnv_string.of_IsEmpty(aspolicecolname) then return -1

// 1/ Memorisation des parametres
itrTrans 	= atrTrans
idwGarantie = adwgarantie
isprefixecolname = asprefixecolname
ispolicecolname = aspolicecolname

// 2/ Chargement de la liste des pr$$HEX1$$e900$$ENDHEX$$fixe
iRet = uf_init_prefixe(idsPrefixe, atrtrans)

// 3/ Partage des pr$$HEX1$$e900$$ENDHEX$$fixes
iREt = uf_share_prefixe()

// 4/ LE chargement en tant que tel par uf_charge_prefixe est laiss$$HEX4$$e9002000e0002000$$ENDHEX$$l'application

return iREt

end function

protected function integer uf_share_prefixe ();//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_protocole_aig_param_gti::uf_share_prefixe
//* Auteur			: PHG
//* Date				: 28/05/2008 19:19:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Partage les pr$$HEX1$$e900$$ENDHEX$$fixe avec le dwc de la dddw des prefixes
//*
//* Arguments		: 
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

datawindowchild dwc

if idwGarantie.GetChild( isprefixecolname , dwc) = -1 then return -1
return idsprefixe.ShareData(dwc)



end function

public function boolean uf_existsinistre (string asidprod, string asidgti);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_protocole_aig_param_gti::uf_existsinistre
//* Auteur			: PHG
//* Date				: 28/05/2008 17:34:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asidprod	 */
/* 	value string asidgti	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

return uf_existsinistre( asidprod, asidgti, itrtrans)
end function

public function integer uf_getidcie (integer aiidpolice);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_protocole_aig_param_gti::uf_getidcie
//* Auteur			: PHG
//* Date				: 28/05/2008 18:41:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Retourne l'Id Compagnie de la dw Garantie dans
//*					  dans le champ police.	
//*
//* Arguments		: value integer aiIdPolice : N$$HEX2$$b0002000$$ENDHEX$$de police
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
integer  lIdCie
long lRow
datawindowchild dwc
n_cst_string lnvString

SetNull(lIdCie)

if idwgarantie.getChild(isPoliceColname, dwc) < 0 then return -1
lRow = dwc.Find("LONG(STRING(ID_POLICE)) = LONG('"+string(aiIdPolice)+"')",1,dwc.RowCount()+1)

if not isnull(aiidpolice) and lRow > 0 Then lIdCie = integer(dwc.GetItemString( lRow, "ID_CIE"))

return lIdCie
end function

public function integer uf_charge_prefixe (integer aiidpolice);
//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_protocole_aig_param_gti::uf_charge_prefixe
//* Auteur			: PHG
//* Date				: 28/05/2008 18:14:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value integer aiIdPolice : N$$HEX2$$b0002000$$ENDHEX$$de police
//*
//* Retourne		: integer	: Retourne le nombre de pr$$HEX1$$e900$$ENDHEX$$fixe affich$$HEX1$$e900$$ENDHEX$$
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
integer lRet = -1
string  sIdCie, sFilter

sIdCie = trim(string(uf_GetIdCie(aiIdPolice)))
if isnull(sIdCie) then 
	sFilter = "ISNULL(ID_CIE)"
else
	sFilter = "TRIM(ID_CIE) = '" + sIdCie + "'"
End If

idsPrefixe.SetFilter(sFilter )
idsPrefixe.Filter()
lRet = idsPrefixe.RowCount( )

return lRet
end function

public function boolean uf_controler_prefixe (integer aiidpolice, ref string asidmsg);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_protocole_aig_param_gti::uf_controler_prefixe
//* Auteur			: PHG
//* Date				: 29/05/2008 11:51:56
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Indique si un pr$$HEX1$$e900$$ENDHEX$$fixe doit etre saisi ou pas.
//*
//* Arguments		: value integer aiIdPolice : N$$HEX2$$b0002000$$ENDHEX$$de police
//*					  ref string asIdMsg 
//*					  Code du message $$HEX2$$e0002000$$ENDHEX$$afficher si controle Non Ok
//*											
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

string sOldFilter, sIdPrefixe
boolean bRet
integer lIdCie
n_cst_string lnvString

// 1/ lecture Compagnie
lIdCie = uf_GetIdCie(aiIdPolice)

// 2/ On enl$$HEX1$$e800$$ENDHEX$$ve le filtre $$HEX1$$e900$$ENDHEX$$ventuel
sOldFilter = idsPrefixe.object.datawindow.table.filter
if lnvString.of_IsEmpty(sOldFilter) then sOldFilter= "" // on pr$$HEX1$$e900$$ENDHEX$$vient l'apparition de la filter 
idsPrefixe.setFilter("")										  // Dialog box si sOldFilter est null
idsPrefixe.Filter()

// 3/ On Recherche si la compagnie lue fait partie des compagnies AIG
bRet  = uf_cieestaig( idsPrefixe, lIdCie)

// 4/ Si oui, on regarde si le champs Pr$$HEX1$$e900$$ENDHEX$$fixe est bien saisi.
if bRet Then
	sIdPrefixe = idwgarantie.GetItemString( idwgarantie.GetRow(), isprefixecolname )
	bRet  = Not lnvString.of_IsEmpty(sIdPrefixe)
	asIdMsg = K_msg_prefixeoblig
Else
	bRet = TRUE
End If

// 4/ On restaure l'ancien Filtre
idsPrefixe.setFilter(sOldFilter)
idsPrefixe.Filter()

return bRet

end function

public function integer uf_init_prefixe (ref datastore adsidprefixe, transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_protocole_aig_param_gti::uf_init_prefixe
//* Auteur			: PHG
//* Date				: 28/05/2008 17:48:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialise le datastore contenant les pr$$HEX1$$e900$$ENDHEX$$fixes
//*
//* Arguments		: 
//*
//* Retourne		: integer, n$$HEX1$$e900$$ENDHEX$$gatif si erreur	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

adsIdPrefixe = create datastore

adsIdPrefixe.dataobject = K_DWO_PREFIXE
adsIdPrefixe.SetTransObject(atrTrans)
return adsIdPrefixe.retrieve()


end function

public function boolean uf_existsinistre (string asidprod, string asidgti, transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_protocole_aig_param_gti::uf_existsinistre
//* Auteur			: PHG
//* Date				: 28/05/2008 17:34:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asidprod	 */
/* 	value string asidrev	 */
/* 	value string asidgti	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
boolean bRet
ds_existsinistre lds_es

SetNull(bRet)
lds_es = create ds_existsinistre
if Not isvalid(lds_es) then return bRet

bRet = lds_es.uf_existsinistre( asidprod, '-1', asidgti, atrTrans)

if isvalid(lds_es) then destroy lds_es

return bRet
end function

public function boolean uf_cieestaig (datastore adsidprefixe, long alidcie);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_protocole_aig_param_gti::uf_controler_prefixe
//* Auteur			: PHG
//* Date				: 29/05/2008
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Indique si une compagnie fait partie du
//*					  Protocole AIG
//*
//* Arguments		: value integer alIdCie : N$$HEX2$$b0002000$$ENDHEX$$de Compagnie
//*											
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

boolean bRet

// On Recherche si la compagnie lue fait partie des compagnies AIG
bRet  = adsidprefixe.Find("ID_CIE = '" + string(alIdCie) +"'", 1 , adsidprefixe.RowCount() ) > 0

return bRet

end function

public function string uf_verif_param_aig (string asidprod, string asidrev, string asidgti, transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_protocole_aig_param_gti::uf_verif_param_aig
//* Auteur			: PHG
//* Date				: 18/06/2008 15:54:37
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DCMP070914].001 Controle du param $$HEX2$$e0002000$$ENDHEX$$la validation
//* 						des dossiers
//*
//* Arguments		: 
//*	value string asidprod
//* 	value string asidrev
//* 	value string asidgti
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

string			sSQL
string			sDwSyntax
string 			sErr
datastore		dsVerifParamAig
n_cst_string	lnvString
boolean			bOk
string 			sNul, sRet
integer 			lRow
SetNull(sNul)

if lnvString.of_IsEmpty( asIdProd) or &
	lnvString.of_IsEmpty( asIdRev) or &
	lnvString.of_IsEmpty( asIdGti) or &
	Not isvalid(atrTrans) Then
		return sNul
End If

sSQL = "execute sysadm.DW_S01_PARAM_AIG_OK " + &
		"'" + asIdProd + "', "+ &
		"'" + asIdRev  + "', "+ &
		"'" + asIdGti  + "'"
		
sDwSyntax = atrTrans.SyntaxFromSQL(sSQL, "Style(type=Grid)", sErr)

dsVerifParamAig = create datastore

if isvalid(dsVerifParamAig) and len(sErr) = 0 Then
	dsVerifParamAig.create( sDwSyntax )
	dsVerifParamAig.SetTransObject(atrTrans)
	lRow = dsVerifParamAig.retrieve()
	if lRow > 0 then
		bOk = ( dsVerifParamAig.object.alt_ok[lRow] = 'O' )
		if Not bOk Then 
			sRet = K_MSG_NOPARAMPREFIX
		Else
			sRet = K_OK
		End If
	Else
		SetNull(sRet)
	End If
Else
	SetNull(sRet)
End If

if isvalid(dsVerifParamAig) then destroy dsVerifParamAig

return sRet
end function

on n_cst_protocole_aig_param_gti.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_protocole_aig_param_gti.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

