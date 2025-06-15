$PBExportHeader$u_trans_anc.sru
$PBExportComments$---} Objet de transaction avec RPC de gestion communes
forward
global type u_trans_anc from transaction
end type
end forward

global type u_trans_anc from transaction
end type
global u_trans_anc u_trans_anc

type prototypes
// ... Table CODE

//Migration PB8-WYNIWYG-03/2006 FM
//subroutine DW_I01_CODE(string sidtypcode,ref long dcidcode,string slibcode,datetime dtcreele,datetime dtmajle,string smajpar,string snomcompteur) rpcfunc alias for "sysadm.DW_I01_CODE"
subroutine DW_I01_CODE(string sidtypcode,ref decimal dcidcode,string slibcode,datetime dtcreele,datetime dtmajle,string smajpar,string snomcompteur) rpcfunc alias for "sysadm.DW_I01_CODE"
//Fin Migration PB8-WYNIWYG-03/2006 FM
subroutine DW_D01_CODE(string sidtypcode,long dcidcode) rpcfunc alias for "sysadm.DW_D01_CODE"
subroutine IM_S01_CODE(string sidtypcode,long dcidcode,ref string slibcode) rpcfunc alias for "sysadm.IM_S01_CODE"

// .... Table COMPAGNIE

subroutine DW_I01_COMPAGNIE(long dcidcie,string slibcie,datetime dtcreele,datetime dtmajle,string smajpar) rpcfunc alias for "sysadm.DW_I01_COMPAGNIE"
subroutine DW_D01_COMPAGNIE(long dcidcie) rpcfunc alias for "sysadm.DW_D01_COMPAGNIE"
subroutine IM_S01_COMPAGNIE(long dcidcie,ref string slibcie) rpcfunc alias for "sysadm.IM_S01_COMPAGNIE"

// .... Table COMPOSITION

subroutine DW_I01_COMPOSITION(string sidcour,string sidpara,long dcidordre,datetime dtcreele,datetime dtmajle,string smajpar) rpcfunc alias for "sysadm.DW_I01_COMPOSITION"
subroutine IM_D01_COMPOSITION(string sidcour) rpcfunc alias for "sysadm.IM_D01_COMPOSITION"

// .... Table COUR_TYPE

subroutine DW_I01_COUR_TYPE(string sidcour,string slibcour,string slibmodele,datetime dtcreele,datetime dtmajle,string smajpar) rpcfunc alias for "sysadm.DW_I01_COUR_TYPE"
subroutine DW_D01_COUR_TYPE(string sidcour) rpcfunc alias for "sysadm.DW_D01_COUR_TYPE"
subroutine IM_S01_COUR_TYPE(string sidcour,ref string slibcour) rpcfunc alias for "sysadm.IM_S01_COUR_TYPE"

// .... table DEPARTEMENT

subroutine DW_I01_DEPARTEMENT(long dciddept,string slibdept,string snomrsp,datetime dtcreele,datetime dtmajle,string smajpar) rpcfunc alias for "sysadm.DW_I01_DEPARTEMENT"
subroutine DW_D01_DEPARTEMENT(long dciddept) rpcfunc alias for "sysadm.DW_D01_DEPARTEMENT"
subroutine IM_S01_DEPARTEMENT(long dciddept,ref string slibdept) rpcfunc alias for "sysadm.IM_S01_DEPARTEMENT"

// ... Table GROUPE

subroutine DW_I01_GROUPE(long dcidgrp,long dcidgrpbase,string slibgrp,datetime dtcreele,datetime dtmajle,string smajpar) rpcfunc alias for "sysadm.DW_I01_GROUPE"
subroutine DW_I01_GROUPE_V01(long dcidgrp,long dcidgrpbase,string slibgrp,datetime dtcreele,datetime dtmajle,string smajpar,long lIdGrpProd) rpcfunc alias for "sysadm.DW_I01_GROUPE_V01"
subroutine DW_D01_GROUPE(long dcidgrp) rpcfunc alias for "sysadm.DW_D01_GROUPE"
subroutine PS_V01_GROUPE(long dcidgrp,ref long inbprod,ref long inbets,ref long inbgrp) rpcfunc alias for "sysadm.PS_V01_GROUPE"
subroutine IM_S01_GROUPE(long dcidgrp,ref string slibgrp) rpcfunc alias for "sysadm.IM_S01_GROUPE"
subroutine IM_S02_GROUPE(long dcidgrpbase,ref string slibgrp) rpcfunc alias for "sysadm.IM_S02_GROUPE"

// .... Table PARAGRAPHE
// 28/06/2006 MADM Projet DNTMAIL1 Ajout de la colonne ID_CANAL
subroutine DW_D01_PARAGRAPHE(string sidpara) rpcfunc alias for "sysadm.DW_D01_PARAGRAPHE"    
subroutine IM_S01_PARAGRAPHE(string sidpara, string sidcanal, ref string slibpara) rpcfunc alias for "sysadm.IM_S01_PARAGRAPHE"
subroutine DW_I01_PARAGRAPHE_SPB(string sIdPara, string sIdCanal, string sLibPara,string sAltEnCours,string sCptVer,string sTxtPara,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_PARAGRAPHE_SPB"

// ... Table POLICE

subroutine DW_I01_POLICE(ref long dcidpolice,long dcidcie,string slibpolice,datetime dtcreele,datetime dtmajle,string smajpar) rpcfunc alias for "sysadm.DW_I01_POLICE"
subroutine DW_D01_POLICE(long dcidpolice) rpcfunc alias for "sysadm.DW_D01_POLICE"
subroutine IM_S01_POLICE(long dcidcie,ref long inbpolice) rpcfunc alias for "sysadm.IM_S01_POLICE"

// .... table COURRIER

subroutine IM_S02_COURRIER(string sidcour,ref long inbcourrier) rpcfunc alias for "sysadm.IM_S02_COURRIER"

// .... Table PRODUIT

subroutine IM_S02_PRODUIT(long dciddept,ref long inbprod) rpcfunc alias for "sysadm.IM_S02_PRODUIT"

// ... Table GARANTIE

subroutine IM_S02_GARANTIE(long dcidpolice,ref long inbpolice) rpcfunc alias for "sysadm.IM_S02_GARANTIE"

// ... Table PARAMETRE

subroutine IM_S01_PARAMETRE(string snomcompteur,ref long inbcompteur) rpcfunc alias for "sysadm.IM_S01_PARAMETRE"

// .... Gestion des ARCHIVES sur FileNet
subroutine PS_U01_ARCHIVE( long dcIdSin, long dcIdInter, long dcIdDoc, long dcRefDocDt, long dcRefDocCp, long dcRefDocPc, long dcRefDocPs, long dcNbrSupp, ref string sProc) RPCFUNC ALIAS FOR "sysadm.PS_U01_ARCHIVE"
subroutine DW_I01_FN_ARCHIVE( datetime dtRecupDeb, datetime dcRecupFin, long dcNbrDossier, datetime dtTrtDeb, datetime dtFnDeb, datetime dtFnFin, datetime dtTrtFin, long dcNbrDt, long dcNbrPs, long dcNbrPce, long dcNbrPart, datetime dtCreeLe, datetime dtMajLe, string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_FN_ARCHIVE"

// ... Table COUR_PROD
subroutine IM_S01_COUR_PROD( string sIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_COUR_PROD" // DCMP 070051

//[Recup vers SVN]
function long DW_S01_MAIL_SVN_SEND()  rpcfunc alias for "sysadm.DW_S01_MAIL_SVN_SEND"
function long PS_X_MAJ_BORNES_SVN(string sIdCodeApp, long iRevMax)  rpcfunc alias for "sysadm.PS_X_MAJ_BORNES_SVN"


// ... Table de Référence des IBAN, sur F4T.SESAME_PRO.sysadm.REF_IBAN
// [MIGPB11] [EMD] : Debut Migration : suppression de l'appel PS sur un serveur lié
//function long SPB_FN_IBAN (string sIban, string sAction)  RPCFUNC ALIAS FOR "[F4T].[SESAME_PRO].[sysadm].[SPB_FN_IBAN]" 
function long SPB_FN_IBAN (string sIban, string sAction)  RPCFUNC ALIAS FOR "sysadm.SPB_FN_IBAN"
// [MIGPB11] [EMD] : Fin Migration

// [MIGPB11] [EMD] : Debut Migration : ajout de la PS utilisée par f_execute()
function long PS_EXECUTE_SQL_CMDE (string asCmde)  RPCFUNC ALIAS FOR "sysadm.PS_EXECUTE_SQL_CMDE" 
// [MIGPB11] [EMD] : Fin Migration

//  JFF   11/06/2019 [PM425-1]
subroutine PS_S_PM425_RECUP_INFO ( Long adcIdSin, Long adcIdInter, Long aiIdArch, Long ilIdTypDoc, ref Long adcIdDoc, ref String asCodInter, ref long adcIdProd, ref String asLibCie, ref String asContractant, ref String asNomDest, ref string asAdr1, ref string asAdr2, ref String asAdrCP, ref String asAdrVille, Ref integer aiDecentralise, Ref String asFondPage, Ref integer aiFormatSortie, Ref String asChemin, Ref String sChaine ) RPCFUNC ALIAS FOR "sysadm.PS_S_PM425_RECUP_INFO" 

// [PI056][TRANCOUNT][JFF][24/01/2020]
function Int PS_S_RETURN_TRANCOUNT ( ) RPCFUNC ALIAS FOR "sysadm.PS_S_RETURN_TRANCOUNT"

//   JFF   24/04/2025 [LGY53_EQU_CNX] sur SESAME
subroutine PS_IU_EQUI_TS_CNX ( String asCas, String asIdOper, String asIdAppli, Long alNumRevCnx, String asTsVmCnx, Ref Long alIdCnx )  RPCFUNC ALIAS FOR "sysadm.PS_IU_EQUI_TS_CNX"

end prototypes
on u_trans_anc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_trans_anc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

