HA$PBExportHeader$w_a_spb_travaux_crees.srw
forward
global type w_a_spb_travaux_crees from w_a_spb_ancetre_etat_wkf
end type
end forward

global type w_a_spb_travaux_crees from w_a_spb_ancetre_etat_wkf
boolean TitleBar=true
string Title="Etat des travaux cr$$HEX2$$e900e900$$ENDHEX$$s"
end type
global w_a_spb_travaux_crees w_a_spb_travaux_crees

forward prototypes
protected function long wf_retrieve (date addatedebut, date addatefin)
end prototypes

protected function long wf_retrieve (date addatedebut, date addatefin);//*-----------------------------------------------------------------
//*
//* Fonction		: wf_retrieve ( Protected ) Override
//* Auteur			: DBI
//* Date				: 20/11/1998 09:22:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Chargement de la datawindow
//* Commentaires	: 
//*
//* Arguments		: adDateDebut date	- date de d$$HEX1$$e900$$ENDHEX$$but de traitement
//*					  adDateFin   date	- date de fin de traitement
//* Retourne		: Long			Nb lignes charg$$HEX1$$e900$$ENDHEX$$es 
//*										
//*-----------------------------------------------------------------
//* #1   PLJ   08/10/2002  Ajout fonctionnalit$$HEX2$$e9002000$$ENDHEX$$pour correction fichier trace_c
//*                        g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$s par Sherpa
//*-----------------------------------------------------------------

Long		lRet, lCpt, lTot, lIdProdTrc, lIdProd, lNbProdDiff, lIdSin
String	sIdTypRecu
lRet		=	Dw_Etat.uf_Retrieve ( 1, adDateDebut, adDateFin )


/*------*/
/*  #1  */
/*------------------------------------------------------------------*/
/* Les fichiers Trace_c g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$s par SHERPA pour SIMPA2 sont faux    */
/* entre le 01/07/2002 et le 07/10/2002 inclus.                     */
/* Une zone n'a pas $$HEX1$$e900$$ENDHEX$$tait renseign$$HEX1$$e900$$ENDHEX$$e. Il s'agit de  l'id_typ_recu   */
/* (trace), qui prend la valeur 0 pour une  D$$HEX1$$e900$$ENDHEX$$claration,  et  les   */
/* valeurs 1,2,3,4 pour des compl$$HEX1$$e900$$ENDHEX$$ments.                            */
/* Cette zone n'a pas $$HEX1$$e900$$ENDHEX$$tait renseign$$HEX2$$e9002000$$ENDHEX$$dans le cas d'un compl$$HEX1$$e900$$ENDHEX$$ment   */
/* ( valeur ' ' ).  En  accord  avec  Corine Verrier, je  replace   */
/* toutes les valeurs $$HEX2$$e0002000$$ENDHEX$$1.                                          */
/* Ce correctif doit  s'apliquer  uniquement  pour  l'application   */
/* SIMPA2 et si l'une  des  deux  dates  se  trouvent  sur  cette   */
/* p$$HEX1$$e900$$ENDHEX$$riode.                                                         */
/*       01/07                      07/10                           */
/*  -------+--------------------------+-----------------            */
/*     1                                       2                    */
/*     1                      2                                     */
/*                1           2                                     */
/*                1                            2                    */
/*------------------------------------------------------------------*/

If ( adDateDebut >= 2002-07-01 AND adDateDebut <= 2002-10-07 	OR         &
	  adDateFin   >= 2002-07-01 AND adDateFin   <= 2002-10-07 	OR	        &
     adDateFin   <  2002-07-01 AND adDateFin   >  2002-10-07      )   AND &
   stGlb.sCodAppli = 'SIM2'																	 Then

	lNbProdDiff = 0

	lTot = Dw_Etat.RowCount()
	For lCpt = 1 To lTot
		sIdTypRecu = dw_Etat.GetItemString ( lCpt, "COD_TYP_RECU" )
		lIdProdTrc = dw_Etat.GetItemNumber ( lCpt, "ID_PROD"      )
		lIdSin     = Long ( dw_Etat.GetItemString ( lCpt, "ID_SIN" ) )
	
   	SELECT id_prod INTO :lIdProd FROM sysadm.sinistre WHERE id_sin = :lIdSin USING SQLCA; 

		IF SqlCa.SqlCode <> 0 Then
			SELECT id_prod INTO :lIdProd FROM sysadm.w_sin WHERE id_sin = :lIdSin USING SQLCA;
		End If

		If isNull ( lIdProdTrc ) Then lIdProdTrc = 0 

		IF lIdProdTrc <> lIdProd AND SqlCa.SqlCode = 0 Then 
			dw_Etat.SetItem ( lCpt, "ID_PROD", lIdProd )
			lNbProdDiff ++
		End If
			 
		If sIdTypRecu = ' ' Then
			dw_Etat.SetItem ( lCpt, "COD_TYP_RECU", '1' )
		End If
	Next

	Dw_Etat.Sort ()
	Dw_Etat.GroupCalc()
	
End If

/*---------*/
/* FIN #1  */                                                         
/*---------*/


Return ( lRet )
end function

on ue_initialiser;call w_a_spb_ancetre_etat_wkf::ue_initialiser;//*-----------------------------------------------------------------
//*
//* Objet 			: w_a_sp_travaux_traites
//* Evenement 		: ue_initialiser
//* Auteur			: DBI
//* Date				: 20/11/1998 09:15:40
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation Dw pour gestion travaux trait$$HEX1$$e900$$ENDHEX$$s
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Dw_Etat.uf_Initialisation ( stGlb.sFichierIni, stGlb.sCodOper, stGlb.sCodAppli, "C", itrTrans )

end on

on w_a_spb_travaux_crees.create
call w_a_spb_ancetre_etat_wkf::create
end on

on w_a_spb_travaux_crees.destroy
call w_a_spb_ancetre_etat_wkf::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_1 from w_a_spb_ancetre_etat_wkf`st_1 within w_a_spb_travaux_crees
boolean BringToTop=true
end type

type st_2 from w_a_spb_ancetre_etat_wkf`st_2 within w_a_spb_travaux_crees
boolean BringToTop=true
end type

type dw_2 from w_a_spb_ancetre_etat_wkf`dw_2 within w_a_spb_travaux_crees
boolean BringToTop=true
end type

type pb_excel from w_a_spb_ancetre_etat_wkf`pb_excel within w_a_spb_travaux_crees
boolean BringToTop=true
end type

type cb_1 from w_a_spb_ancetre_etat_wkf`cb_1 within w_a_spb_travaux_crees
boolean BringToTop=true
end type

