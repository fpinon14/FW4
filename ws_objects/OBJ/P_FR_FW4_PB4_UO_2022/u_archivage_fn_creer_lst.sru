HA$PBExportHeader$u_archivage_fn_creer_lst.sru
$PBExportComments$----} UserObjet servant $$HEX2$$e0002000$$ENDHEX$$toutes les fonctionnalit$$HEX1$$e900$$ENDHEX$$s de la sauvegarde des courriers sous FileNet.
forward
global type u_archivage_fn_creer_lst from nonvisualobject
end type
end forward

global type u_archivage_fn_creer_lst from nonvisualobject
end type
global u_archivage_fn_creer_lst u_archivage_fn_creer_lst

type variables
Private :
	u_Transaction		itrTrans
	u_DataWindow_Detail	idwDet
	String			isSysadm = "sysadm."

	Long			ilNbrLigne = 40000
end variables

forward prototypes
private subroutine uf_maj_par (integer aicol, string astable)
public subroutine uf_creer_detail (integer aitype, ref u_datawindow_detail adw_1, ref u_transaction atrtrans)
private subroutine uf_maj_le (integer aicol, string astable)
private subroutine uf_cree_le (integer aicol, string astable)
private subroutine uf_archive_mss ()
end prototypes

private subroutine uf_maj_par (integer aicol, string astable);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Maj_Par ( Private )
//* Auteur			: Erick John Stark
//* Date				: 24/10/1997 15:12:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation d'une colonne MAJ_PAR standard sur dw d$$HEX1$$e900$$ENDHEX$$tail
//*
//* Arguments		: Integer		aiCol					(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la colonne de d$$HEX1$$e900$$ENDHEX$$tail
//*					  String			asTable				(Val)	Nom de la table
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idwDet.istCol[ aiCol ].sDbName		=	asTable + ".maj_par"
idwDet.istCol[ aiCol ].sResultSet	=	"maj_par"
idwDet.istCol[ aiCol ].sType			=	"char(4)"
idwDet.istCol[ aiCol ].sHeaderName	=	"Par"
idwDet.istCol[ aiCol ].ilargeur		=	4
idwDet.istCol[ aiCol ].sAlignement	=	"0"
idwDet.istCol[ aiCol ].sInvisible	= 	"N"
idwDet.istCol[ aiCol ].sUpdate		= 	"O"
idwDet.istCol[ aiCol ].sCle			= 	"N"


end subroutine

public subroutine uf_creer_detail (integer aitype, ref u_datawindow_detail adw_1, ref u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Creer_Detail (Public)
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:47:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation d'une Data Window de D$$HEX1$$e900$$ENDHEX$$tail
//*
//* Arguments		: Integer					aiType	(Val)	Type de choix
//*					  U_DataWindow_Detail	adw_1		(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow de d$$HEX1$$e900$$ENDHEX$$tail
//*					  u_Transaction			atrTrans	(R$$HEX1$$e900$$ENDHEX$$f)	Objet de transaction
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sMoteur

idwDet	= adw_1
itrTrans	= atrTrans

/*------------------------------------------------------------------*/
/* Il faut construire une DW diff$$HEX1$$e900$$ENDHEX$$rente entre MSS et SqlBase.       */
/*------------------------------------------------------------------*/
sMoteur 	= Left ( Upper ( atrTrans.DBMS ), 3 )	

Choose Case aiType
Case 1
	Choose Case sMoteur
	Case "GUP"
//		Uf_Archive_Gup ()

	Case "MSS"
		Uf_Archive_Mss ()
		
	// [MIGPB11] [EMD] : Debut Migration : support du DBMS SNC
	Case "SNC"
		Uf_Archive_Mss ()
	// [MIGPB11] [EMD] : Fin Migration
	
	// [PI056] Moteur MSS par d$$HEX1$$e900$$ENDHEX$$faut
	Case Else
		Uf_Archive_Mss ()
	// :[PI056] 
	
	End Choose

End Choose

idwDet.Visible = True






end subroutine

private subroutine uf_maj_le (integer aicol, string astable);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Maj_Le ( Private )
//* Auteur			: Erick John Stark
//* Date				: 24/10/1997 15:12:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation d'une colonne MAJ_LE standard sur dw d$$HEX1$$e900$$ENDHEX$$tail
//*
//* Arguments		: Integer		aiCol					(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la colonne de d$$HEX1$$e900$$ENDHEX$$tail
//*					  String			asTable				(Val)	Nom de la table
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idwDet.istCol[ aiCol ].sDbName		=	asTable + ".maj_le"
idwDet.istCol[ aiCol ].sResultSet	=	"maj_le"
idwDet.istCol[ aiCol ].sType			=	"datetime"
idwDet.istCol[ aiCol ].sHeaderName	=	"Maj Le"
idwDet.istCol[ aiCol ].sFormat		=	"dd/mm/yyyy hh:mm"
idwDet.istCol[ aiCol ].ilargeur		=	16
idwDet.istCol[ aiCol ].sAlignement	=	"2"
idwDet.istCol[ aiCol ].sInvisible	= 	"N"
idwDet.istCol[ aiCol ].sUpdate		= 	"O"
idwDet.istCol[ aiCol ].sCle			= 	"N"

end subroutine

private subroutine uf_cree_le (integer aicol, string astable);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Cree_Le ( Private )
//* Auteur			: Erick John Stark
//* Date				: 24/10/1997 15:12:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation d'une colonne CREE_LE standard sur dw d$$HEX1$$e900$$ENDHEX$$tail
//*
//* Arguments		: Integer		aiCol					(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la colonne de d$$HEX1$$e900$$ENDHEX$$tail
//*					  String			asTable				(Val)	Nom de la table
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

idwDet.istCol[ aiCol ].sDbName		=	asTable + ".cree_le"
idwDet.istCol[ aiCol ].sResultSet	=	"cree_le"
idwDet.istCol[ aiCol ].sType			=	"datetime"
idwDet.istCol[ aiCol ].sHeaderName	=	"Cr$$HEX1$$e900$$ENDHEX$$ation"
idwDet.istCol[ aiCol ].sFormat		=	"dd/mm/yyyy"
idwDet.istCol[ aiCol ].ilargeur		=	10
idwDet.istCol[ aiCol ].sAlignement	=	"2"
idwDet.istCol[ aiCol ].sInvisible	= 	"O"
idwDet.istCol[ aiCol ].sUpdate		= 	"O"
idwDet.istCol[ aiCol ].sCle			= 	"N"

end subroutine

private subroutine uf_archive_mss ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Archive_Mss ( PRIVATE )
//* Auteur			: Erick John Stark
//* Date				: 19/10/1997 18:58:27
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation de la DW d'accueil sur la table ARCHIVE (Pour SQL Server)
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sTables[]
String sMod

sTables[ 1 ]	= "archive"

/*------------------------------------------------------------------*/
/* Il y a un BUG, en effet la fonction ne g$$HEX1$$e900$$ENDHEX$$re pas le principe du   */
/* sysadm (SQL Server) et/ou du result set. La cr$$HEX1$$e900$$ENDHEX$$ation marche,     */
/* mais l'autorisation pour l'update va poser des probl$$HEX1$$e800$$ENDHEX$$mes, donc   */
/* il vaut mieux enlever "sysadm.".                                 */
/*------------------------------------------------------------------*/
idwDet.istCol[1].sDbName		=	"archive.id_sin"
idwDet.istCol[1].sResultSet	=	"id_sin"
idwDet.istCol[1].sType			=	"decimal(0)"
idwDet.istCol[1].sHeaderName	=	"Id Sin"
idwDet.istCol[1].iLargeur		=	10  // [PI062]
idwDet.istCol[1].sAlignement	=	"2"
idwDet.istCol[1].sInvisible	= 	"N"
idwDet.istCol[1].sUpdate		= 	"N"
idwDet.istCol[1].sCle			= 	"N"

idwDet.istCol[2].sDbName		=	"archive.id_inter"
idwDet.istCol[2].sResultSet	=	"id_inter"
idwDet.istCol[2].sType			=	"decimal(0)"
idwDet.istCol[2].sHeaderName	=	"Inter"
idwDet.istCol[2].ilargeur		=	4
idwDet.istCol[2].sAlignement	=	"2"
idwDet.istCol[2].sInvisible	= 	"N"
idwDet.istCol[2].sUpdate		= 	"N"
idwDet.istCol[2].sCle			= 	"N"

idwDet.istCol[3].sDbName		=	"archive.id_doc"
idwDet.istCol[3].sResultSet	=	"id_doc"
idwDet.istCol[3].sType			=	"decimal(0)"
idwDet.istCol[3].sHeaderName	=	"Id Doc"
idwDet.istCol[3].ilargeur		=	6
idwDet.istCol[3].sAlignement	=	"2"
idwDet.istCol[3].sInvisible	= 	"O"
idwDet.istCol[3].sUpdate		= 	"N"
idwDet.istCol[3].sCle			= 	"N"

idwDet.istCol[4].sDbName		=	"archive.alt_part"
idwDet.istCol[4].sResultSet	=	"alt_part"
idwDet.istCol[4].sType			=	"char(1)"
idwDet.istCol[4].sHeaderName	=	"Prt."
idwDet.istCol[4].ilargeur		=	4
idwDet.istCol[4].sAlignement	=	"2"
idwDet.istCol[4].sInvisible	= 	"N"
idwDet.istCol[4].sUpdate		= 	"N"
idwDet.istCol[4].sCle			= 	"N"
idwDet.istCol[4].sValues		=  "$$HEX2$$fc000900$$ENDHEX$$O/ 	N/"

idwDet.istCol[5].sDbName		=	"archive.alt_ps"
idwDet.istCol[5].sResultSet	=	"alt_ps"
idwDet.istCol[5].sType			=	"char(1)"
idwDet.istCol[5].sHeaderName	=	"Post."
idwDet.istCol[5].ilargeur		=	5
idwDet.istCol[5].sAlignement	=	"2"
idwDet.istCol[5].sInvisible	= 	"N"
idwDet.istCol[5].sUpdate		= 	"N"
idwDet.istCol[5].sCle			= 	"N"
idwDet.istCol[5].sValues		=  "$$HEX2$$fc000900$$ENDHEX$$O/ 	N/"

idwDet.istCol[6].sDbName		=	"archive.alt_pce"
idwDet.istCol[6].sResultSet	=	"alt_pce"
idwDet.istCol[6].sType			=	"char(1)"
idwDet.istCol[6].sHeaderName	=	"A.Pce"
idwDet.istCol[6].ilargeur		=	5
idwDet.istCol[6].sAlignement	=	"2"
idwDet.istCol[6].sInvisible	= 	"N"
idwDet.istCol[6].sUpdate		= 	"N"
idwDet.istCol[6].sCle			= 	"N"
idwDet.istCol[6].sValues		=  "$$HEX2$$fc000900$$ENDHEX$$O/ 	N/"

idwDet.istCol[7].sDbName		=	"archive.valide_le"
idwDet.istCol[7].sResultSet	=	"valide_le"
idwDet.istCol[7].sType			=	"datetime"
idwDet.istCol[7].sHeaderName	=	"Valide Le"
idwDet.istCol[7].sFormat		=	"dd/mm/yyyy hh:mm"
idwDet.istCol[7].ilargeur		=	16
idwDet.istCol[7].sAlignement	=	"2"
idwDet.istCol[7].sInvisible	= 	"N"
idwDet.istCol[7].sUpdate		= 	"N"
idwDet.istCol[7].sCle			= 	"N"

idwDet.istCol[8].sDbName		=	"archive.ref_doc_dt"
idwDet.istCol[8].sResultSet	=	""
idwDet.istCol[8].sType			=	"decimal(0)"
idwDet.istCol[8].sHeaderName	=	""
idwDet.istCol[8].iLargeur		=	1
idwDet.istCol[8].sAlignement	=	"2"
idwDet.istCol[8].sInvisible	= 	"O"
idwDet.istCol[8].sUpdate		= 	"N"
idwDet.istCol[8].sCle			= 	"N"

idwDet.istCol[9].sDbName		=	"archive.ref_doc_cp"
idwDet.istCol[9].sResultSet	=	""
idwDet.istCol[9].sType			=	"decimal(0)"
idwDet.istCol[9].sHeaderName	=	""
idwDet.istCol[9].iLargeur		=	1
idwDet.istCol[9].sAlignement	=	"2"
idwDet.istCol[9].sInvisible	= 	"O"
idwDet.istCol[9].sUpdate		= 	"N"
idwDet.istCol[9].sCle			= 	"N"

idwDet.istCol[10].sDbName		=	"archive.ref_doc_pc"
idwDet.istCol[10].sResultSet	=	""
idwDet.istCol[10].sType			=	"decimal(0)"
idwDet.istCol[10].sHeaderName	=	""
idwDet.istCol[10].iLargeur		=	1
idwDet.istCol[10].sAlignement	=	"2"
idwDet.istCol[10].sInvisible	= 	"O"
idwDet.istCol[10].sUpdate		= 	"N"
idwDet.istCol[10].sCle			= 	"N"

idwDet.istCol[11].sDbName		=	"archive.ref_doc_ps"
idwDet.istCol[11].sResultSet	=	""
idwDet.istCol[11].sType			=	"decimal(0)"
idwDet.istCol[11].sHeaderName	=	""
idwDet.istCol[11].iLargeur		=	1
idwDet.istCol[11].sAlignement	=	"2"
idwDet.istCol[11].sInvisible	= 	"O"
idwDet.istCol[11].sUpdate		= 	"N"
idwDet.istCol[11].sCle			= 	"N"

/*------------------------------------------------------------------*/
/* Cr$$HEX1$$e900$$ENDHEX$$ation de la Data Window de d$$HEX1$$e900$$ENDHEX$$tail                             */
/*------------------------------------------------------------------*/
idwDet.Uf_Creer_Tout ( idwDet.istCol, sTables, iTrTrans )

/*------------------------------------------------------------------*/
/* La DataWindow de d$$HEX1$$e900$$ENDHEX$$tail sera tri$$HEX1$$e900$$ENDHEX$$e sur                           */
/*------------------------------------------------------------------*/
idwDet.isTri = "VALIDE_LE A"

/*------------------------------------------------------------------*/
/* La premi$$HEX1$$e800$$ENDHEX$$re ligne n'est pas s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e par d$$HEX1$$e900$$ENDHEX$$faut.             */
/*------------------------------------------------------------------*/
idwDet.Uf_Activer_Selection ( True )

/*------------------------------------------------------------------*/
/* On arrete la recherche $$HEX2$$e0002000$$ENDHEX$$X lignes dans idw_LstDossier.           */
/*------------------------------------------------------------------*/
idwDet.ilMaxLig = ilNbrLigne

/*------------------------------------------------------------------*/
/* On positionne la bonne commande pour le retrieve.                */
/*------------------------------------------------------------------*/
sMod = "datawindow.table.procedure = ~"1 EXECUTE sysadm.DW_S01_ARCHIVE_FN_LSTDET " + "~""
idwDet.Uf_Modify ( sMod )

/*------------------------------------------------------------------*/
/* On modifie la cosm$$HEX1$$e900$$ENDHEX$$tique pour les colonnes ALT_PART, ALT_PS,     */
/* ALT_PCE. On va faire appara$$HEX1$$ee00$$ENDHEX$$tre un coche pour la valeur (O)ui.   */
/*------------------------------------------------------------------*/
sMod = 	"alt_part.Font.Face='Wingdings' alt_part.font.family='0' alt_part.font.charset='2' alt_part.font.height='-12' alt_part.color = '255' " + &
			"alt_ps.Font.Face='Wingdings' alt_ps.font.family='0' alt_ps.font.charset='2' alt_ps.font.height='-12' alt_ps.color = '255' " 				+ &
			"alt_pce.Font.Face='Wingdings' alt_pce.font.family='0' alt_pce.font.charset='2' alt_pce.font.height='-12' alt_pce.color = '255' "
idwDet.Uf_Modify ( sMod )



end subroutine

on u_archivage_fn_creer_lst.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_archivage_fn_creer_lst.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

