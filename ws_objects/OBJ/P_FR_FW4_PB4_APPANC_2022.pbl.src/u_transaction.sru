$PBExportHeader$u_transaction.sru
$PBExportComments$Objet de transaction hérité de u_trans_anc ( Pb4Spb )
forward
global type u_transaction from u_trans_anc
end type
end forward

global type u_transaction from u_trans_anc
end type
global u_transaction u_transaction

type prototypes
// Procédures de gestion des courriers.
subroutine DW_D01_COURRIER(long dcIdProd,string sIdNatCour) RPCFUNC ALIAS FOR "sysadm.DW_D01_COURRIER"
subroutine DW_I01_COURRIER(long dcIdProd,string sIdNatCour,string sIdCour,string sIdConfDeb,string sIdConfN,string sIdConfFin,string sAltConf,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_COURRIER"


// Procédures de gestion des pièces et des motifs de refus.
subroutine DW_D01_MOTIF(long dcIdProd,long dcIdrev,long dcIdGti,long dcIdMotif) RPCFUNC ALIAS FOR "sysadm.DW_D01_MOTIF"
subroutine DW_D01_PIECE(long dcIdProd,long dcIdrev,long dcIdGti,long dcIdPce) RPCFUNC ALIAS FOR "sysadm.DW_D01_PIECE"
subroutine DW_I01_MOTIF(long dcIdProd,long dcIdrev,long dcIdGti,long dcIdMotif,string sIdPara,string sCodTypMotif,string sCodNatMotif,datetime dtCreeLe,datetime dtMajLe,string sMajPar, long dcCptTri ) RPCFUNC ALIAS FOR "sysadm.DW_I01_MOTIF"
subroutine DW_I01_PIECE(long dcIdProd,long dcIdrev,long dcIdGti,long dcIdPce,string sIdPara,string sCodTypPce,datetime dtCreeLe,datetime dtMajLe,string sMajPar, long dcCptTri ) RPCFUNC ALIAS FOR "sysadm.DW_I01_PIECE"

// Procédures pour la gestion des codes alphanumeriques.
subroutine DW_D01_CODECAR(string sIdTypCode,string sIdCode) RPCFUNC ALIAS FOR "sysadm.DW_D01_CODECAR"
subroutine DW_I01_CODECAR(string sIdTypCode,ref string sIdCode,string sLibCode,datetime dtCreeLe,datetime dtMajLe,string sMajPar,string sNomCompteur) RPCFUNC ALIAS FOR "sysadm.DW_I01_CODECAR"
subroutine IM_S01_CODECAR(string sIdTypCode,string sIdCode,ref string sLibCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_CODECAR"
subroutine IM_S01_COURRIER(string sIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_COURRIER"
subroutine IM_S01_DELAI(string sIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_DELAI"
subroutine IM_S01_FRANCHISE(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_FRANCHISE"
subroutine IM_S01_PLAFOND(string sIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_PLAFOND"

// Procédures pour la gestion des codes garanties.
subroutine IM_S02_CODE_GARANTIE(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S02_CODE_GARANTIE"
subroutine IM_S03_CODE_GARANTIE(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S03_CODE_GARANTIE"

// Procédures pour la gestion des motifs de refus.
subroutine IM_S01_MOTIF(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_MOTIF"

// Fonction pour la gestion des départements.
function long IM_S01_CARTE(long dcIdGrp) RPCFUNC ALIAS FOR "sysadm.IM_S01_CARTE"

// Procédures pour la gestion des départements.
subroutine DW_I01_DEPARTEMENT(long dcIdDept,string sLibDept,string sNomRsp,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_DEPARTEMENT"
subroutine DW_D01_DEPARTEMENT(long dcIdDept) RPCFUNC ALIAS FOR "sysadm.DW_D01_DEPARTEMENT"

subroutine IM_S01_DEPARTEMENT(long dcIdDept,ref string sLibDept) RPCFUNC ALIAS FOR "sysadm.IM_S01_DEPARTEMENT"
subroutine IM_S02_PRODUIT(long dcIdDept,ref long iNbProd) RPCFUNC ALIAS FOR "sysadm.IM_S02_PRODUIT"

// Procédures pour la gestion des Compagnies.
subroutine DW_I01_COMPAGNIE(long dcIdCie,string sLibCie,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_COMPAGNIE"
subroutine DW_D01_COMPAGNIE(long dcIdCie) RPCFUNC ALIAS FOR "sysadm.DW_D01_COMPAGNIE"
subroutine IM_S01_COMPAGNIE(long dcIdCie,ref string sLibCie) RPCFUNC ALIAS FOR "sysadm.IM_S01_COMPAGNIE"


subroutine IM_S01_POLICE(long dcIdCie,ref long iNbPolice) RPCFUNC ALIAS FOR "sysadm.IM_S01_POLICE"

// Procédures pour la gestion des Polices.
subroutine DW_I01_POLICE(ref long dcIdPolice,long dcIdCie,string sLibPolice,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_POLICE"
subroutine DW_D01_POLICE(long dcIdPolice) RPCFUNC ALIAS FOR "sysadm.DW_D01_POLICE"

subroutine IM_S02_GARANTIE(long dcIdPolice,ref long iNbPolice) RPCFUNC ALIAS FOR "sysadm.IM_S02_GARANTIE"


// Procédures pour la gestion des Groupes.
subroutine DW_I01_GROUPE(long dcIdGrp,long dcIdGrpBase,string sLibGrp,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_GROUPE"
subroutine DW_D01_GROUPE(long dcIdGrp) RPCFUNC ALIAS FOR "sysadm.DW_D01_GROUPE"

subroutine IM_S01_GROUPE(long dcIdGrp,ref string sLibGrp) RPCFUNC ALIAS FOR "sysadm.IM_S01_GROUPE"
subroutine IM_S02_GROUPE(long dcIdGrpBase,ref string sLibGrp) RPCFUNC ALIAS FOR "sysadm.IM_S02_GROUPE"

subroutine PS_V01_GROUPE(long dcIdGrp,ref long iNbProd,ref long iNbEts,ref long iNbGrp) RPCFUNC ALIAS FOR "sysadm.PS_V01_GROUPE"


// Procédures pour la gestion des etablissements.
subroutine DW_I01_ETABLISSEMENT(long dcIdProd,long dcIdGrp,long dcIdRev,long dcIdEts,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_ETABLISSEMENT"
subroutine DW_D01_ETABLISSEMENT(long dcIdProd,long dcIdGrp,long dcIdRev,long dcIdEts) RPCFUNC ALIAS FOR "sysadm.DW_D01_ETABLISSEMENT"
subroutine IM_S01_ETABLISSEMENT(long dcIdProd,long dcIdEts, Ref integer iSinistre ) RPCFUNC ALIAS FOR "sysadm.IM_S01_ETABLISSEMENT"

subroutine ETABLISSEMENT_C1(long dcIdEts,ref string sLibEts) RPCFUNC ALIAS FOR "sysadm.ETABLISSEMENT_C1"
subroutine ETABLISSEMENT_C2(ref string sLibAg,ref string sAdr1,ref string sAdr2,ref string sAdrCp,ref string sAdrVille,string sCodBq,string sCodAg) RPCFUNC ALIAS FOR "sysadm.ETABLISSEMENT_C2"
subroutine ETABLISSEMENT_C3(long dcIdEts,ref long iNbProd) RPCFUNC ALIAS FOR "sysadm.ETABLISSEMENT_C3"

// Procédures pour la gestion des codes.
subroutine DW_I01_CODE(string sIdTypCode,ref long dcIdCode,string sLibCode,datetime dtCreeLe,datetime dtMajLe,string sMajPar,string sNomCompteur) RPCFUNC ALIAS FOR "sysadm.DW_I01_CODE"
subroutine DW_D01_CODE(string sIdTypCode,long dcIdCode) RPCFUNC ALIAS FOR "sysadm.DW_D01_CODE"

subroutine IM_S01_CODE(string sIdTypCode,long dcIdCode,ref string sLibCode) RPCFUNC ALIAS FOR "sysadm.IM_S01_CODE"
subroutine IM_S01_PARAMETRE(string sNomCompteur,ref long iNbCompteur) RPCFUNC ALIAS FOR "sysadm.IM_S01_PARAMETRE"
subroutine IM_S02_PIECE(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S02_PIECE"
subroutine IM_S02_MOTIF(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S02_MOTIF"
subroutine IM_S02_CODE_CONDITION(string sIdTypCode,long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S02_CODE_CONDITION"

// Procédures pour la gestion des Paragraphes.
subroutine DW_D01_PARAGRAPHE(string sIdPara) RPCFUNC ALIAS FOR "sysadm.DW_D01_PARAGRAPHE"
subroutine DD_S01_PARAGRAPHE() RPCFUNC ALIAS FOR "sysadm.DD_S01_PARAGRAPHE"

subroutine IM_S01_PARAGRAPHE(string sIdPara,ref string sLibPara) RPCFUNC ALIAS FOR "sysadm.IM_S01_PARAGRAPHE"
subroutine IM_S02_COMPOSITION(string sIdPara,ref long iNbCompo) RPCFUNC ALIAS FOR "sysadm.IM_S02_COMPOSITION"
subroutine IM_S03_MOTIF(string sIdPara,ref long iNbNatEx) RPCFUNC ALIAS FOR "sysadm.IM_S03_MOTIF"
subroutine IM_S03_PIECE(string sIdPara,ref long iNbPiece) RPCFUNC ALIAS FOR "sysadm.IM_S03_PIECE"
subroutine IM_S01_PARAPROD(string sIdPara,ref long iNbProd) RPCFUNC ALIAS FOR "sysadm.IM_S01_PARAPROD"


// Procédures pour la gestion des Courriers Types.
subroutine DW_I01_COUR_TYPE(string sIdCour,string sLibCour,string sLibModele,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_COUR_TYPE"
subroutine DW_D01_COUR_TYPE(string sIdCour) RPCFUNC ALIAS FOR "sysadm.DW_D01_COUR_TYPE"

subroutine IM_S01_COUR_TYPE(string sIdCour,ref string sLibCour) RPCFUNC ALIAS FOR "sysadm.IM_S01_COUR_TYPE"
subroutine IM_S02_COURRIER(string sIdCour,ref long iNbCourrier) RPCFUNC ALIAS FOR "sysadm.IM_S02_COURRIER"

// Proc pour la Composition des courriers Types.
subroutine DW_I01_COMPOSITION(string sIdCour,string sIdPara,long dcIdOrdre,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_COMPOSITION"
subroutine IM_D01_COMPOSITION(string sIdCour) RPCFUNC ALIAS FOR "sysadm.IM_D01_COMPOSITION"

// Procédures pour la gestion des Produits.
subroutine DW_I01_PRODUIT(long dcIdProd,long dcIdDept,long dcIdGrp,string sLibCourt,string sLibLong,long dcCodRevSurv,long dcCodRevSous,long dcCodRevRnv,long dcCodNivOpe,long dcDurPerrnvAdh,string sUntPerrnvAdh,string sCodModeReg,string sLibBqDebit,string sRibBq,string sRibGui,string sRibCpt,string sRibCle,string sCodDestReg,string sCodAdh,long dcIdCorb,long dcIdPolice,string sNumTel,string sNumFax,long dcIdDepts,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_PRODUIT"
subroutine DW_D01_PRODUIT(long dcIdProd) RPCFUNC ALIAS FOR "sysadm.DW_D01_PRODUIT"
subroutine IM_S03_PRODUIT(long dcIdProd,ref string sLibCourt) RPCFUNC ALIAS FOR "sysadm.IM_S03_PRODUIT"
subroutine IM_S04_PRODUIT(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S04_PRODUIT"
subroutine IM_S05_PRODUIT(long dcIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S05_PRODUIT"

// Procédures pour la duplication dans la gestion des produits.
subroutine IM_I01_CONDITION(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_CONDITION"
subroutine IM_I01_GARANTIE(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_GARANTIE"
subroutine IM_I01_MOTIF(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_MOTIF"
subroutine IM_I01_PIECE(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_PIECE"

// Procédures de gestion d'une révision.
subroutine DW_D01_REVISION(long dcIdProd,long dcIdRev) RPCFUNC ALIAS FOR "sysadm.DW_D01_REVISION"
subroutine DW_I01_REVISION(long dcIdProd,long dcIdRev,string sLibRev,string sCodEffRev,datetime dtDteEff,datetime dtDteFin,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_REVISION"

// Procédures de suppression d'une révision.
subroutine PS_SUPREVISION(long dcIdProd,long dcIdRev) RPCFUNC ALIAS FOR "sysadm.PS_SUPREVISION"
subroutine IM_D01_CONDITION(long dcIdProd,long dcIdRev) RPCFUNC ALIAS FOR "sysadm.IM_D01_CONDITION"
subroutine IM_D01_ETABLISSEMENT(long dcIdProd,long dcIdRev) RPCFUNC ALIAS FOR "sysadm.IM_D01_ETABLISSEMENT"
subroutine IM_D01_GARANTIE(long dcIdProd,long dcIdRev) RPCFUNC ALIAS FOR "sysadm.IM_D01_GARANTIE"
subroutine IM_D01_MOTIF(long dcIdProd,long dcIdRev) RPCFUNC ALIAS FOR "sysadm.IM_D01_MOTIF"
subroutine IM_D01_PIECE(long dcIdProd,long dcIdRev) RPCFUNC ALIAS FOR "sysadm.IM_D01_PIECE"

// Procédures de suppression d'un produit.
subroutine PS_SUPPRODUIT(long dcIdProd) RPCFUNC ALIAS FOR "sysadm.PS_SUPPRODUIT"
subroutine IM_D01_COURRIER(long dcIdProd) RPCFUNC ALIAS FOR "sysadm.IM_D01_COURRIER"
subroutine IM_D01_PARA_PROD(long dcIdProd) RPCFUNC ALIAS FOR "sysadm.IM_D01_PARA_PROD"
subroutine IM_D01_REVISION(long dcIdProd) RPCFUNC ALIAS FOR "sysadm.IM_D01_REVISION"
subroutine IM_D02_CODE_CONDITION(long dcIdProd) RPCFUNC ALIAS FOR "sysadm.IM_D02_CODE_CONDITION"
subroutine IM_D02_CODE_GARANTIE(long dcIdProd) RPCFUNC ALIAS FOR "sysadm.IM_D02_CODE_GARANTIE"
subroutine IM_D02_CONDITION(long dcIdProd) RPCFUNC ALIAS FOR "sysadm.IM_D02_CONDITION"
subroutine IM_D02_ETABLISSEMENT(long dcIdProd) RPCFUNC ALIAS FOR "sysadm.IM_D02_ETABLISSEMENT"
subroutine IM_D02_GARANTIE(long dcIdProd) RPCFUNC ALIAS FOR "sysadm.IM_D02_GARANTIE"
subroutine IM_D03_MOTIF(long dcIdProd) RPCFUNC ALIAS FOR "sysadm.IM_D03_MOTIF"
subroutine IM_D03_PIECE(long dcIdProd) RPCFUNC ALIAS FOR "sysadm.IM_D03_PIECE"

// Procédures de suppression d'un code garantie.
subroutine PS_SUPCODEGARANTIE(long dcIdProd,long dcIdRev,long dcIdGti) RPCFUNC ALIAS FOR "sysadm.PS_SUPCODEGARANTIE"
subroutine IM_D01_CODE_CONDITION(long dcIdProd,long dcIdGti) RPCFUNC ALIAS FOR "sysadm.IM_D01_CODE_CONDITION"
subroutine IM_D01_CODE_GARANTIE(long dcIdProd,long dcIdGti) RPCFUNC ALIAS FOR "sysadm.IM_D01_CODE_GARANTIE"
subroutine IM_D02_MOTIF(long dcIdProd,long dcIdRev,long dcIdGti) RPCFUNC ALIAS FOR "sysadm.IM_D02_MOTIF"
subroutine IM_D02_PIECE(long dcIdProd,long dcIdRev,long dcIdGti) RPCFUNC ALIAS FOR "sysadm.IM_D02_PIECE"

// Procédures de gestion des codes garanties.
subroutine DW_I01_CODE_GARANTIE(long dcIdProd,long dcIdGti,string sLibGti,real dcMtCmt,long dcCodRgptStat,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_CODE_GARANTIE"
subroutine IM_S01_CODE_GARANTIE(long dcIdProd,long dcIdGti,ref long iNbGarantie) RPCFUNC ALIAS FOR "sysadm.IM_S01_CODE_GARANTIE"

// Procédures de gestion des codes condition.
subroutine DW_D01_CODE_CONDITION(long dcIdProd,long dcIdGti,string sIdTypCode,long dcIdCode) RPCFUNC ALIAS FOR "sysadm.DW_D01_CODE_CONDITION"
subroutine DW_I01_CODE_CONDITION(long dcIdProd,long dcIdGti,string sIdTypCode,long dcIdCode,string slibevt, datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_CODE_CONDITION"
//Procédures de contrôle pour la suppression des codes condition.
subroutine IM_S01_CONDITION(long dcIdProd,long dcIdGti,string sIdTypCode,long dcIdCode,ref long iNbCondition) RPCFUNC ALIAS FOR "sysadm.IM_S01_CONDITION"

// Procédures de controle du nimbre de garantie d'un produit.
subroutine IM_S03_GARANTIE(long dcIdProd,long dcIdGti,ref long iNbGarantie) RPCFUNC ALIAS FOR "sysadm.IM_S03_GARANTIE"

// Procédures de gestion des paragraphes d'information pour un produit.
subroutine DW_D01_PARA_PROD(long dcIdProd,string sIdPara) RPCFUNC ALIAS FOR "sysadm.DW_D01_PARA_PROD"
subroutine DW_I01_PARA_PROD(long dcIdProd,string sIdPara,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_PARA_PROD"

// Procédures de duplication des délais, plafonds et franchises pour une nvelle rév.
subroutine IM_I01_FRANCHISE(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_FRANCHISE"
subroutine IM_I01_PLAFOND(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_PLAFOND"
subroutine IM_I01_DELAI(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_DELAI"

// Procédures et fonctions de gestion des cartes et des types de cartes.
subroutine DW_D01_CARTE(long dcIdCarte) RPCFUNC ALIAS FOR "sysadm.DW_D01_CARTE"
subroutine DW_D01_TYPE_CARTE(string sIdTypeCarte) RPCFUNC ALIAS FOR "sysadm.DW_D01_TYPE_CARTE"
subroutine DW_I01_CARTE(ref long dcIdCarte,string sIdTypeCarte,long dcIdGrp,string sLibCarte,string sValRgMini,string sValRgMax,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_CARTE"
subroutine DW_I01_TYPE_CARTE(string sIdTypeCarte,string sLibTypeCarte,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_TYPE_CARTE"
subroutine IM_S01_TYPE_CARTE(string sIdTypeCarte,ref string sLibTypeCarte) RPCFUNC ALIAS FOR "sysadm.IM_S01_TYPE_CARTE"
FUNCTION long IM_S02_CARTE(long dcIdCarte,string sRangMini,string sRangMaxi) RPCFUNC ALIAS FOR "sysadm.IM_S02_CARTE"
FUNCTION long IM_S03_CARTE(long dcIdCarte,string sRangMini,string sRangMaxi) RPCFUNC ALIAS FOR "sysadm.IM_S03_CARTE"
FUNCTION long IM_S04_CARTE(string sIdTypeCarte) RPCFUNC ALIAS FOR "sysadm.IM_S04_CARTE"
FUNCTION long IM_S01_AFFILIER( long dcIdCarte ) RPCFUNC ALIAS FOR "sysadm.IM_S01_AFFILIER"
subroutine IM_I01_AFFILIER(long dcIdProd,long dcIdRev,long dcIdRevAnc,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.IM_I01_AFFILIER"

subroutine IM_S06_PRODUIT(string sIdCode,ref long iNbCode) RPCFUNC ALIAS FOR "sysadm.IM_S06_PRODUIT"

// Procédures et fonctions de gestion des garanties.
subroutine DW_I01_GARANTIE(long dcIdProd,long dcIdRev,long dcIdGti,long dcIdPolice,long dcCodTypFra,string sAltPlaf,string sAltDel,string sAltFran,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_GARANTIE"
subroutine DW_D01_GARANTIE(long dcIdProd,long dcIdRev,long dcIdGti) RPCFUNC ALIAS FOR "sysadm.DW_D01_GARANTIE"
subroutine IM_S01_GARANTIE(long dcIdProd,long dcIdRev,long dcIdGti,ref long dcIdGtiRech) RPCFUNC ALIAS FOR "sysadm.IM_S01_GARANTIE"
subroutine IM_U01_PRODUIT(long dcIdProduit,long dcIdPolice) RPCFUNC ALIAS FOR "sysadm.IM_U01_PRODUIT"


//Procédures et fonctions de gestion des cartes affiliées à une garantie
subroutine DW_I01_AFFILIER(long dcIdProd,long dcIdRev,long dcIdGti,long dcIdCarte,date dtDteAffil,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_AFFILIER"

//Procédures et fonctions de gestion des conditions de garantie
subroutine DW_I01_CONDITION(long dcIdProd,long dcIdRev,long dcIdGti,long dcIdCode,string dcIdTypCode,string AltReg,string AltPlaf,string AltDel,string AltFran,datetime dtCreeLe,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_I01_CONDITION"
subroutine DW_U01_CONDITION(long dcIdProd,long dcIdRev,long dcIdGti,long dcIdCode,string sIdTypCode,string sAltReg,string sAltPlaf,string sAltDel,string sAltFran,datetime dtMajLe,string sMajPar) RPCFUNC ALIAS FOR "sysadm.DW_U01_CONDITION"


//Procédure et fonction de gestion des pièce associées à une garantie pour une révision
subroutine DW_U01_PIECE(long dcIdProd,long dcIdRev,long dcIdGti,long dcIdPce,string sIdPara,string sCodTypPce,datetime dtMajLe,string sMajPar, long lCptTri) RPCFUNC ALIAS FOR "sysadm.DW_U01_PIECE"

//Procédure et fonction de gestion des refus associés à une garantie pour une révision
subroutine DW_U01_MOTIF(long dcIdProd,long dcIdRev,long dcIdGti,long dcIdMotif,string sIdPara,string sCodTypMotif,string sCodNatMotif,datetime dtMajLe,string sMajPar, long dcCptTri) RPCFUNC ALIAS FOR "sysadm.DW_U01_MOTIF"



end prototypes
on u_transaction.create
call super::create
end on

on u_transaction.destroy
call super::destroy
end on

