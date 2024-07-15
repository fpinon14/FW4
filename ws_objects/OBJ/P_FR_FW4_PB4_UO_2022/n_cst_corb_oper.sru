HA$PBExportHeader$n_cst_corb_oper.sru
$PBExportComments$------} NVUO pour la gestion des Corbeilles/Op$$HEX1$$e900$$ENDHEX$$rateurs. Utilis$$HEX2$$e9002000$$ENDHEX$$dans W_TRT_CORB_OPER.
forward
global type n_cst_corb_oper from nonvisualobject
end type
end forward

global type n_cst_corb_oper from nonvisualobject
end type
global n_cst_corb_oper n_cst_corb_oper

type variables
Private :
	U_DataWindow		idwTrt
	U_DataWindow_Accueil	idwAccOper
	
	DataWindow		idwCorbTmp
	DataWindow		idwOperAppli
	DataWindow		idwProdCorb
	
	U_Ajout			iuoAjoutCorbeille

	Long			ilIdAppli

	
end variables

forward prototypes
public subroutine uf_preparer ()
private function boolean uf_gestion_operateur ()
private subroutine uf_creer_accueil ()
public subroutine uf_initialiser (ref u_datawindow adwtrt, ref u_datawindow_accueil adwaccoper, ref u_ajout auajout, ref datawindow adwcorbtmp, ref datawindow adwoperappli, ref datawindow adwprodcorb)
private function boolean uf_armer_ajout ()
public function boolean uf_traiter_operateur (long alligne)
public subroutine uf_traiter_ajout_corbeille ()
public function boolean uf_inserer_operateur (string asfiltre)
private function boolean uf_modifier_operateur (string asfiltre)
private function boolean uf_supprimer_operateur (string asfiltre)
public function boolean uf_valider (boolean absortiechecked)
end prototypes

public subroutine uf_preparer ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_CorbOper::Uf_Preparer (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 30/11/1999 17:14:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

U_Transaction	trSesame
String 			sErrConnect, sFicIniAppli

/*------------------------------------------------------------------*/
/* On va se connecter $$HEX2$$e0002000$$ENDHEX$$la base qui g$$HEX1$$e900$$ENDHEX$$re la gestion des acc$$HEX1$$e900$$ENDHEX$$s.      */
/*------------------------------------------------------------------*/
trSesame = CREATE U_Transaction

sFicIniAppli 		= stGLB.sFichierIni
sErrConnect			= ""

If F_ConnectSqlServer ( sFicIniAppli, "SESAME BASE", trSesame, sErrConnect, "SESAME", stGlb.sCodOper ) Then
/*------------------------------------------------------------------*/
/* On va populiser une DataWindow pour r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$rer la liste des       */
/* op$$HEX1$$e900$$ENDHEX$$rateurs qui peuvent se connecter $$HEX2$$e0002000$$ENDHEX$$l'application.             */
/*------------------------------------------------------------------*/
	idwOperAppli.DataObject = "D_STK_OPERATEUR_APPLICATION"
	idwOperAppli.SetTransObject ( trSesame )
	idwOperAppli.Retrieve ( stGLB.sCodAppli )
	
	DISCONNECT USING trSesame ;
	
/*------------------------------------------------------------------*/
/* On s'occupe de la r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des produits et des corbeilles    */
/* assign$$HEX1$$e900$$ENDHEX$$es.                                                       */
/*------------------------------------------------------------------*/
	If	ilIdAppli = 1	Then
/*------------------------------------------------------------------*/
/* Gestion pour SAVANE. Dans la table PRODUIT, la colonne se nomme  */
/* ID_CORB.                                                         */
/*------------------------------------------------------------------*/
		idwProdCorb.DataObject = "D_STK_CORBEILLE_PRODUIT"
	Else
/*------------------------------------------------------------------*/
/* Pour SINDI et SAVANE, la DW existe d$$HEX1$$e900$$ENDHEX$$j$$HEX27$$e00020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
/* (D_PRODUIT_LST_MSS)(PS=DW_S01_PRODCORB). Dans la table PRODUIT,  */
/* la colonne se nomme ID_CORB.                                     */
/*------------------------------------------------------------------*/
		idwProdCorb.DataObject = "D_PRODUIT_LST_MSS"
	End If
	idwProdCorb.SetTransObject ( SQLCA )
	idwProdCorb.Retrieve ()

/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re une liste des corbeilles distinctes. Le DataObjet    */
/* est de type external.                                            */
/*------------------------------------------------------------------*/
	idwCorbTmp.DataObject = "D_STK_CORBEILLE_TEMP"
		
/*------------------------------------------------------------------*/
/* On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la table CORB_OPER. Cette table contient peut-$$HEX1$$ea00$$ENDHEX$$tre   */
/* des op$$HEX1$$e900$$ENDHEX$$rateurs qui n'ont plus acc$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$l'application. Elle peut   */
/* contenir des corbeilles qui ne sont plus valides.                */
/*------------------------------------------------------------------*/
	idwTrt.Retrieve()
	
	uf_Creer_Accueil ()
	Uf_Gestion_Operateur ()
	Uf_Armer_Ajout ()

End If

Destroy trSesame


end subroutine

private function boolean uf_gestion_operateur ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_CorbOper::Uf_Gestion_Operateur (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 01/12/1999 11:04:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des op$$HEX1$$e900$$ENDHEX$$rateurs
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean			True	= Tout est OK
//*											False	= Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Boolean bRet
String sIdOper, sRech, sImport, sK_TAB
Long lTotOper, lTotProduit, lCpt, lTotCorbOper, lLig

bRet		= TRUE
sK_TAB	= "~t"

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie que au moins un op$$HEX1$$e900$$ENDHEX$$rateur poss$$HEX1$$e900$$ENDHEX$$de l'acc$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$cette     */
/* application. Sinon, cela ne sert $$HEX2$$e0002000$$ENDHEX$$rien de continuer.            */
/*------------------------------------------------------------------*/
lTotOper = idwOperAppli.RowCount ()

If	lTotOper < 1 Then

	stMessage.sTitre		= "Gestion des Corbeilles/Op$$HEX1$$e900$$ENDHEX$$rateurs"
	stMessage.Icon			= Information!
	stMessage.sCode		= "CORB001"
	stMessage.Bouton		= OK!
	stMessage.bTrace		= FALSE
	stMessage.bErreurG	= TRUE
	f_Message ( stMessage )

	bRet = FALSE
	Return ( bRet )

End If

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie qu'il existe au moins un produit dans la base.        */
/* Sinon, cela ne sert $$HEX2$$e0002000$$ENDHEX$$rien de continuer.                         */
/*------------------------------------------------------------------*/
lTotProduit = idwProdCorb.RowCount ()

If	lTotProduit < 1 Then

	stMessage.sTitre		= "Gestion des Corbeilles/Op$$HEX1$$e900$$ENDHEX$$rateurs"
	stMessage.Icon			= Information!
	stMessage.sCode		= "CORB002"
	stMessage.Bouton		= OK!
	stMessage.bTrace		= FALSE
	stMessage.bErreurG	= TRUE
	f_Message ( stMessage )

	bRet = FALSE
	Return ( bRet )
End If

/*------------------------------------------------------------------*/
/* On effectue un tri sur les DW.                                   */
/* Liste des op$$HEX1$$e900$$ENDHEX$$rateurs 			: ID_OPER.                         */
/* Liste des Produits/Corbeilles	: ID_CORB + ID_PROD.               */
/* Table CORB_OPER 					: ID_OPER + MAJ_LE.                */
/*------------------------------------------------------------------*/
idwOperAppli.Sort ()
idwProdCorb.Sort ()
idwTrt.Sort ()

/*------------------------------------------------------------------*/
/* On ins$$HEX1$$e900$$ENDHEX$$re les op$$HEX1$$e900$$ENDHEX$$rateurs dans la DW ACCUEIL.                     */
/*------------------------------------------------------------------*/
lTotCorbOper = idwTrt.RowCount ()
For	lCpt = 1 To lTotOper
		sIdOper	= idwOperAppli.GetItemString ( lCpt, "ID_OPER" )
		sRech		= "id_oper = '" + sIdOper + "'"
		
/*------------------------------------------------------------------*/
/* On recherche l'op$$HEX1$$e900$$ENDHEX$$rateur dans CORB_OPER. S'il existe, on         */
/* r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re les informations CREE_LE, MAJ_LE, MAJ_PAR. S'il         */
/* n'existe pas, on positionne ces informations $$HEX2$$e0002000$$ENDHEX$$NULL.             */
/*------------------------------------------------------------------*/
/* Les informations affich$$HEX1$$e900$$ENDHEX$$es correspondent $$HEX2$$e0002000$$ENDHEX$$la derni$$HEX1$$e800$$ENDHEX$$re           */
/* modification. (MAJ_LE et MAJ_PAR)                                */
/*------------------------------------------------------------------*/
		lLig		= idwTrt.Find ( sRech, 1, lTotCorbOper )
		If	lLig > 0	Then
			sImport = 	sIdOper 																	+ sK_TAB + &
							Trim ( idwOperAppli.GetItemString ( lCpt, "NOM" ) )					+ &
							' '																					+ &
							Trim ( idwOperAppli.GetItemString ( lCpt, "PRENOM" ) )	+ sK_TAB + &
							String ( idwTrt.GetItemDateTime ( lLig, "CREE_LE" ) )		+ sK_TAB + &
							String ( idwTrt.GetItemDateTime ( lLig, "MAJ_LE" ) )		+ sK_TAB + &
							idwTrt.GetItemString ( lLig, "MAJ_PAR" )
		Else
			sImport = 	sIdOper 																	+ sK_TAB + &
							Trim ( idwOperAppli.GetItemString ( lCpt, "NOM" ) )					+ &
							' '																					+ &
							Trim ( idwOperAppli.GetItemString ( lCpt, "PRENOM" ) )	
		End If
		
		idwAccOper.ImportString ( sImport )
Next

Return ( TRUE )

end function

private subroutine uf_creer_accueil ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_CorbOper::Uf_Creer_Accueil (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 30/11/1999 17:14:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Integer iCpt
String sTables[]

// .... Description de la DW d'accueil

iCpt = 1
idwAccOper.istCol[iCpt].sDbName		=	"corb.id_oper"
idwAccOper.istCol[iCpt].sType			=	"char(4)"
idwAccOper.istCol[iCpt].sHeaderName	=	"Code"
idwAccOper.istCol[iCpt].sAlignement	= 	"0"
idwAccOper.istCol[iCpt].ilargeur		=	4
idwAccOper.istCol[iCpt].sInvisible	= 	"N"

iCpt ++

idwAccOper.istCol[iCpt].sDbName		=	"corb.nom"
idwAccOper.istCol[iCpt].sType			=	"char(71)"
idwAccOper.istCol[iCpt].sHeaderName	=	"Nom - Pr$$HEX1$$e900$$ENDHEX$$nom"
idwAccOper.istCol[iCpt].ilargeur		=	25
idwAccOper.istCol[iCpt].sAlignement	=	"0"
idwAccOper.istCol[iCpt].sInvisible	= 	"N"

iCpt ++

idwAccOper.istCol[iCpt].sDbName		=	"corb.cree_le"
idwAccOper.istCol[iCpt].sType			=	"datetime"
idwAccOper.istCol[iCpt].sHeaderName	=	"Cree Le"
idwAccOper.istCol[iCpt].sFormat		=  "dd/mm/yyyy hh:mm"
idwAccOper.istCol[iCpt].ilargeur		=	15
idwAccOper.istCol[iCpt].sAlignement	=	"2"
idwAccOper.istCol[iCpt].sInvisible	= 	"O"

iCpt ++

idwAccOper.istCol[iCpt].sDbName		=	"corb.maj_le"
idwAccOper.istCol[iCpt].sType			=	"datetime"
idwAccOper.istCol[iCpt].sHeaderName	=	"Derni$$HEX1$$e800$$ENDHEX$$re Modif."
idwAccOper.istCol[iCpt].sFormat		=  "dd/mm/yyyy hh:mm"
idwAccOper.istCol[iCpt].ilargeur		=	16
idwAccOper.istCol[iCpt].sAlignement	=	"2"
idwAccOper.istCol[iCpt].sInvisible	= 	"N"

iCpt ++

idwAccOper.istCol[iCpt].sDbName		=	"corb.maj_par"
idwAccOper.istCol[iCpt].sType			=	"char(4)"
idwAccOper.istCol[iCpt].sHeaderName	=	"Par"
idwAccOper.istCol[iCpt].ilargeur		=	4
idwAccOper.istCol[iCpt].sAlignement	=	"0"
idwAccOper.istCol[iCpt].sInvisible	= 	"N"

iCpt ++

idwAccOper.istCol[iCpt].sDbName		=	"corb.alt_trt"
idwAccOper.istCol[iCpt].sType			=	"char(1)"
idwAccOper.istCol[iCpt].sHeaderName	=	"Trt"
idwAccOper.istCol[iCpt].ilargeur		=	1
idwAccOper.istCol[iCpt].sAlignement	=	"2"
idwAccOper.istCol[iCpt].sInvisible	= 	"O"


sTables[ 1 ]		= "corb"

idwAccOper.isPointer = ""

idwAccOper.Uf_Creer_Tout ( idwAccOper.istCol, sTables, SQLCA )


end subroutine

public subroutine uf_initialiser (ref u_datawindow adwtrt, ref u_datawindow_accueil adwaccoper, ref u_ajout auajout, ref datawindow adwcorbtmp, ref datawindow adwoperappli, ref datawindow adwprodcorb);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_CorbOper::Uf_Initialiser (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 30/11/1999 15:16:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: U_Dw				aDwTrt			(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow de Traitement (dw_1)
//* 					: U_Dw_Accueil		aDwAccOper		(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow d'accueil des op$$HEX1$$e900$$ENDHEX$$rateurs
//* 					: U_Ajout			auAjout			(R$$HEX1$$e900$$ENDHEX$$f)	Objet U_Ajout
//* 					: U_Dw				aDwCorbTmp		(R$$HEX1$$e900$$ENDHEX$$f)	External D_STK_CORBEILLE_TEMP
//* 					: U_Dw				aDwOperAppli	(R$$HEX1$$e900$$ENDHEX$$f)	D_STK_OPERATEUR_APPLICATION (DW_S01_OPER_APPLI)
//* 					: U_Dw				aDwProdCorb		(R$$HEX1$$e900$$ENDHEX$$f)	D_PRODUIT_LST_GUP (d_produit_lst_gup)
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

iDwTrt				= aDwTrt
iDwAccOper			= aDwAccOper
iuoAjoutCorbeille	= auAjout

idwCorbTmp			= adwCorbTmp
idwOperAppli		= adwOperAppli
idwProdCorb			= adwProdCorb


/*------------------------------------------------------------------*/
/* On initialise les DW Source, Cible maintenant. On n'utilise pas  */
/* la fonction Uf_Initialiser () car elle affecte $$HEX2$$e0002000$$ENDHEX$$nouveau le      */
/* itrTrans. Ce qui est inutile.                                    */
/*------------------------------------------------------------------*/
iuoAjoutCorbeille.dw_Source.DataObject 	= "D_TRT_CORBEILLE_AFFECT"
iuoAjoutCorbeille.dw_Cible.DataObject 		= "D_TRT_CORBEILLE_NON_AFFECT"
iuoAjoutCorbeille.dw_Recherche.DataObject	= "D_TRT_CORBEILLE_AFFECT"


/*------------------------------------------------------------------*/
/* Dans ce NVUO, il faut g$$HEX1$$e900$$ENDHEX$$rer deux types diff$$HEX1$$e900$$ENDHEX$$rents                */
/* d'applications. Une applicationde type SAVANE, la colonne        */
/* faisant r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence $$HEX2$$e0002000$$ENDHEX$$la corbeille s'appelle COD_CORB pour la      */
/* table PRODUIT et la table CORB_OPER et elle est de type CHAR.    */
/* Les autres applications (SIMPA2, SINDI), la colonne se nomme     */
/* ID_CORB et elle est en integer.                                  */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On initialise une variable dans s_GLB (bCorbOperSavane). Cette   */
/* valeur est arm$$HEX1$$e900$$ENDHEX$$e dans le menu Corbeille/Op$$HEX1$$e900$$ENDHEX$$rateur $$HEX2$$e0002000$$ENDHEX$$vrai pour    */
/* l'application SAVANE. Dans le NVUO, on utilise une variable      */
/* d'instance ilIdAppli.                                            */
/*------------------------------------------------------------------*/
If	stGLB.bCorbOperSavane	Then
/*------------------------------------------------------------------*/
/* Application SAVANE.                                              */
/*------------------------------------------------------------------*/
	ilIdAppli = 1
Else
/*------------------------------------------------------------------*/
/* Application SIMPA2 ou SINDI.                                     */
/*------------------------------------------------------------------*/
	ilIdAppli = 2
End If


end subroutine

private function boolean uf_armer_ajout ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Corb_Oper::Uf_Armer_Ajout (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 02/12/1999 16:49:54
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va armer la dwRecherche de U_Ajout.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		TRUE	= Tout est OK
//*										FALSE	= Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long lCpt, lTotCorb, lLig, lIdCorb
String sFiltre, sLibLong, sNomCol

/*------------------------------------------------------------------*/
/* On va armer dans une DataWindow External la liste des corbeilles */
/* distinctes.                                                      */
/*------------------------------------------------------------------*/
sFiltre = "id_corb <> id_corb[-1] Or GetRow () = 1"
idwProdCorb.SetFilter ( sFiltre )
idwProdCorb.Filter ()

lTotCorb = idwProdCorb.RowCount ()

For	lCpt = 1 To lTotCorb
		lIdCorb	= idwProdCorb.GetItemNumber ( lCpt, "ID_CORB" )

		If	ilIdAppli = 1	Then
			sNomCol	= "LIB_CODE"
		Else
			sNomCol	= "LIB_CORB"
		End If

		sLibLong	= idwProdCorb.GetItemString ( lCpt, sNomCol )
		
		lLig = idwCorbTmp.InsertRow ( 0 )
		idwCorbTmp.SetItem ( lLig, "ID_CORB", lIdCorb )
		idwCorbTmp.SetItem ( lLig, "LIB_CORB", sLibLong )
		idwCorbTmp.SetItem ( lLig, "ALT_TRT", "N" )
Next

/*------------------------------------------------------------------*/
/* On enl$$HEX1$$e900$$ENDHEX$$ve le filtre sur Corbeilles/Produits.                     */
/*------------------------------------------------------------------*/
idwProdCorb.SetFilter ( "" )
idwProdCorb.Filter ()
idwProdCorb.Sort ()

Return ( TRUE )

end function

public function boolean uf_traiter_operateur (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_CorbOper::Uf_Traiter_Operateur (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 09/12/1999 10:21:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va traiter l'op$$HEX1$$e900$$ENDHEX$$rateur courant de la DW ACC
//*
//* Arguments		: Long			alLigne	(Val) 
//*
//* Retourne		: Boolean			TRUE	= Tout est OK
//*											FALSE	= Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long lCpt, lTotCorbTmp, lTotTrt, lLig, lIdCorb
String sStr, sIdOper, sFiltre, sImport, sImport1, sRech, sAltAvant, sLibCorb, sAltTrt, sAltValideAvt, sK_TAB, sK_RETOUR

sK_TAB		= "~t"
sK_RETOUR	= "~r"

/*------------------------------------------------------------------*/
/* La premi$$HEX1$$e800$$ENDHEX$$re chose $$HEX2$$e0002000$$ENDHEX$$faire est de repositionner la zone ALT_TRT   */
/* de idwCorbTmp.                                                   */
/*------------------------------------------------------------------*/
lTotCorbTmp = idwCorbTmp.RowCount ()

/*------------------------------------------------------------------*/
/* Si la DataWindow idwCorbTmp ne contient aucune ligne, on         */
/* s'arrete. Ce test est positionn$$HEX2$$e9002000$$ENDHEX$$ici pour le probl$$HEX1$$e800$$ENDHEX$$me du         */
/* RowFocusChanged sur idwAccOper.                                  */
/*------------------------------------------------------------------*/
If	lTotCorbTmp = 0	Then Return ( FALSE )

For	lCpt = 1 To lTotCorbTmp
		idwCorbTmp.SetItem ( lCpt, "ALT_TRT", "N" )
Next

/*------------------------------------------------------------------*/
/* On va filtrer idwTrt (Liste des Corbeilles/Op$$HEX1$$e900$$ENDHEX$$rateurs) sur le    */
/* ID_OPER en cours de traitement.                                  */
/*------------------------------------------------------------------*/
sIdOper = idwAccOper.GetItemString ( alLigne, "ID_OPER" )
sFiltre = "ID_OPER = '" + sIdOper + "'"
idwTrt.SetFilter ( sFiltre )
idwTrt.Filter ()
idwTrt.Sort ()

/*------------------------------------------------------------------*/
/* On recopie l'int$$HEX1$$e900$$ENDHEX$$gralit$$HEX2$$e9002000$$ENDHEX$$des lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es dans la        */
/* dwRecherche de U_Ajout.                                          */
/*------------------------------------------------------------------*/
lTotTrt = idwTrt.RowCount ()
sImport	= ""

For	lCpt = 1	To lTotTrt
		lIdCorb		= idwTrt.GetItemNumber ( lCpt, "ID_CORB" )
/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si cette corbeille est encore valide.                 */
/*------------------------------------------------------------------*/
		sRech		= "ID_CORB = " + String ( lIdCorb )
		lLig		= idwCorbTmp.Find ( sRech, 1, lTotCorbTmp )
		
		If	lLig <= 0	Then
/*------------------------------------------------------------------*/
/* Elle n'existe plus dans la liste des corbeilles actuelles. On    */
/* la supprimera $$HEX2$$e0002000$$ENDHEX$$la fin du traitement.                            */
/*------------------------------------------------------------------*/
			sAltAvant		= "-1"
			sLibCorb			= ""
			sAltValideAvt	= ""
		Else
/*------------------------------------------------------------------*/
/* Elle existe, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re le libell$$HEX2$$e9002000$$ENDHEX$$de la corbeille au passage.  */
/*------------------------------------------------------------------*/
			sAltAvant		= "1"
			sLibCorb			= idwCorbTmp.GetItemString ( lLig, "LIB_CORB" )
/*------------------------------------------------------------------*/
/* L'op$$HEX1$$e900$$ENDHEX$$rateur est-il autonome ?                                    */
/*------------------------------------------------------------------*/
			sAltValideAvt	= idwTrt.GetItemString ( lCpt, "ALT_VALIDE_AVANT" )
/*------------------------------------------------------------------*/
/* On marque la corbeille sur le DataStore.                         */
/*------------------------------------------------------------------*/
			idwCorbTmp.SetItem ( lLig, "ALT_TRT", "O" )		
		End If
		
		sImport = 	sImport 																					+ 		&
						sIdOper																+ sK_TAB 		+ 		&
						String ( lIdCorb )												+ sK_TAB 		+ 		&
						sLibCorb																+ sK_TAB 		+ 		&
						sAltValideAvt														+ sK_TAB 		+ 		&
						sAltValideAvt														+ sK_TAB 		+ 		&
						sAltAvant															+ sK_TAB 		+ 		&
						sAltAvant															+ sK_RETOUR
Next

/*------------------------------------------------------------------*/
/* On s'occupe maintenant d'ins$$HEX1$$e900$$ENDHEX$$rer les corbeilles non trait$$HEX1$$e900$$ENDHEX$$es de  */
/* idwCorbTmp.                                                      */
/*------------------------------------------------------------------*/
sImport1	= ""
For	lCpt = 1 To lTotCorbTmp
		lIdCorb 	= idwCorbTmp.GetItemNumber ( lCpt, "ID_CORB" )
		sAltTrt	= idwCorbTmp.GetItemString ( lCpt, "ALT_TRT" )
		
		If	sAltTrt = "O"	Then
			Continue
		Else
			sAltAvant		= "0"
			sLibCorb			= idwCorbTmp.GetItemString ( lCpt, "LIB_CORB" )
/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut le gestionnaire n'est pas autonome.                   */
/*------------------------------------------------------------------*/
			sAltValideAvt	= "N"
		End If
		
		sImport1 = 	sImport1 																				+ 		&
						sIdOper																+ sK_TAB 		+ 		&
						String ( lIdCorb )												+ sK_TAB 		+ 		&
						sLibCorb																+ sK_TAB 		+ 		&
						sAltValideAvt														+ sK_TAB 		+ 		&
						sAltValideAvt														+ sK_TAB 		+ 		&
						sAltAvant															+ sK_TAB 		+ 		&
						sAltAvant															+ sK_RETOUR

	
Next

/*------------------------------------------------------------------*/
/* On enl$$HEX1$$e900$$ENDHEX$$ve le filtre sur idwTrt.                                  */
/*------------------------------------------------------------------*/
idwTrt.SetFilter ( "" )
idwTrt.Filter ()
idwTrt.Sort ()

/*------------------------------------------------------------------*/
/* On positionne la ligne comme trait$$HEX1$$e900$$ENDHEX$$e dans la dwAcc.              */
/*------------------------------------------------------------------*/
idwAccOper.SetItem ( alLigne, "ALT_TRT", "O" )

/*------------------------------------------------------------------*/
/* On importe les lignes dans l'objet U_Ajout.                      */
/*------------------------------------------------------------------*/
iuoAjoutCorbeille.dw_Recherche.ImportString ( sImport )
iuoAjoutCorbeille.dw_Recherche.ImportString ( sImport1 )
iuoAjoutCorbeille.dw_Recherche.Sort ()

Return ( TRUE )


end function

public subroutine uf_traiter_ajout_corbeille ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_CorbOper::Uf_Traiter_Ajout_Corbeille (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 15/12/1999 15:29:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On vient de la fonction Uf_Traiter_Operateur, on s'occupe 
//*						maintenant de l'objet U_Ajout.
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

String sFiltre, sIdOper
Long lLig

/*------------------------------------------------------------------*/
/* La DataWindow de RECHERCHE de U_Ajout vient d'$$HEX1$$ea00$$ENDHEX$$tre populis$$HEX1$$e900$$ENDHEX$$e     */
/* dans la fonction Uf_Traiter_Operateur. On s'occupe maintenant    */
/* de r$$HEX1$$e900$$ENDHEX$$partir les corbeilles dans l'objet U_Ajout.                 */
/*------------------------------------------------------------------*/
iuoAjoutCorbeille.SetRedraw ( FALSE )

lLig = idwAccOper.GetSelectedRow ( 0 )
If	lLig > 0	Then
	sIdOper = idwAccOper.GetItemString ( lLig, "ID_OPER" )
/*------------------------------------------------------------------*/
/* On s'occupe des corbeilles NON POSITIONNEES. (CIBLE)             */
/*------------------------------------------------------------------*/
	sFiltre = "ID_OPER = '" + sIdOper + "' And ALT_APRES = 0"
	iUoAjoutCorbeille.dw_Recherche.SetFilter ( sFiltre )
	iUoAjoutCorbeille.dw_Recherche.Filter ()

	iUoAjoutCorbeille.dw_Cible.Reset ()
	iUoAjoutCorbeille.dw_Recherche.RowsCopy ( 1, 9999, PRIMARY!, iUoAjoutCorbeille.dw_Cible, 1, PRIMARY! )
	
/*------------------------------------------------------------------*/
/* On s'occupe des corbeilles POSITIONNEES. (SOURCE)                */
/*------------------------------------------------------------------*/
	sFiltre = "ID_OPER = '" + sIdOper + "' And ALT_APRES = 1"
	iUoAjoutCorbeille.dw_Recherche.SetFilter ( sFiltre )
	iUoAjoutCorbeille.dw_Recherche.Filter ()

	iUoAjoutCorbeille.dw_Source.Reset ()
	iUoAjoutCorbeille.dw_Recherche.RowsCopy ( 1, 9999, PRIMARY!, iUoAjoutCorbeille.dw_Source, 1, PRIMARY! )

/*------------------------------------------------------------------*/
/* On enl$$HEX1$$e900$$ENDHEX$$ve le filtre de la DataWindow de RECHERCHE.               */
/*------------------------------------------------------------------*/
	sFiltre = ""
	iUoAjoutCorbeille.dw_Recherche.SetFilter ( sFiltre )
	iUoAjoutCorbeille.dw_Recherche.Filter ()
	
	iUoAjoutCorbeille.dw_Source.Sort ()
	iUoAjoutCorbeille.dw_Cible.Sort ()
	
//	If	iuoAjout.dw_Source.RowCount () > 0	Then iuoAjout.dw_Source.SelectRow ( 1, TRUE )
	
	iUoAjoutCorbeille.dw_Source.SelectRow ( 0, FALSE )
	iUoAjoutCorbeille.dw_Cible.SelectRow ( 0, FALSE )
End If

iUoAjoutCorbeille.SetRedraw ( TRUE )


end subroutine

public function boolean uf_inserer_operateur (string asfiltre);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Corb_Oper::Uf_Inserer_Operateur (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 28/12/1999 16:04:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On ins$$HEX1$$e900$$ENDHEX$$re les nouveaux op$$HEX1$$e900$$ENDHEX$$rateurs dans la table CORB_OPER
//*
//* Arguments		: String		asFiltre			 (Val) Filtre $$HEX2$$e0002000$$ENDHEX$$appliquer
//*
//* Retourne		: Boolean		TRUE 	= Tout est OK, on continue
//*										FALSE	= Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long lTotTrt, lCpt, lIdCorb, lRet
String sIdOper, sIdCorb, sSql, sCreeLe, sMajLe, sMajPar, sAltVAlideApr, sIdAppli
String sVarErreur[6]
Boolean bRet

bRet = TRUE

/*------------------------------------------------------------------*/
/* On filtre la DW de recherche qui contient toutes les lignes.     */
/*------------------------------------------------------------------*/
iuoAjoutCorbeille.dw_Recherche.SetFilter ( asFiltre )
iuoAjoutCorbeille.dw_Recherche.Filter ()
iuoAjoutCorbeille.dw_Recherche.Sort ()

lTotTrt	= iuoAjoutCorbeille.dw_Recherche.RowCount ()

sCreeLe	= "'" + String ( DateTime ( Today (), Now () ), "dd/mm/yyyy hh:mm:ss.ff" ) + "'"
sMajLe	= sCreeLe
sMajPar	= "'" + stGLB.sCodOper + "'"


For	lCpt = 1 To lTotTrt
		sIdOper			= "'" + iuoAjoutCorbeille.dw_Recherche.GetItemString ( lCpt, "ID_OPER" ) + "'"
		sAltValideApr	= "'" + iuoAjoutCorbeille.dw_Recherche.GetItemString ( lCpt, "ALT_VALIDE_APRES" ) + "'"
		sIdAppli			= String ( ilIdAppli )

		sIdCorb		= "'" + String ( iuoAjoutCorbeille.dw_Recherche.GetItemNumber ( lCpt, "ID_CORB" ), "000" ) + "'"
		
		sSql		= "EXECUTE sysadm.IM_I01_CORB_OPER_NEW "					+ &
						sIdOper													+ "," + &
						sIdCorb													+ "," + &
						sAltValideApr											+ "," + &
						sCreeLe													+ "," + &
						sMajLe													+ "," + &
						sMajPar													+ "," + &
						sIdAppli

		// [MIGPB11] [EMD] : Debut Migration : [SNC] contourne le fait que SNC ne mette pas $$HEX2$$e0002000$$ENDHEX$$jour SqlnRows
		//EXECUTE IMMEDIATE :sSql USING SQLCA	;
		f_execute( sSql, SQLCA )
		// [MIGPB11] [EMD] : Fin Migration
		
		If	SQLCA.SqlnRows <> 1 Then
			sVarErreur[1]			= String ( SQLCA.SqlDbCode )
			sVarErreur[2]			= SQLCA.SqlErrText
			sVarErreur[3]			= SQLCA.Dbms
			sVarErreur[4]			= SQLCA.Database
			sVarErreur[5]			= SQLCA.UserId
			sVarErreur[6]			= SQLCA.Lock

			stMessage.bErreurG	= True
			stMessage.bTrace		= False
			stMessage.sTitre		= "Gestion des Corbeilles/Op$$HEX1$$e900$$ENDHEX$$rateurs"
			stMessage.Icon			= StopSign!
			stMessage.sCode 		= "CORB004"
			stMessage.sVar			= sVarErreur		
/*------------------------------------------------------------------*/
/* Il faut faire le ROLLBACK maintenant et afficher le message      */
/* d'erreur ensuite. Un second ROLLBACK partira sur l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement     */
/* VALIDER de la fen$$HEX1$$ea00$$ENDHEX$$tre.                                           */
/*------------------------------------------------------------------*/
//			ROLLBACK USING SQLCA	;
			F_COMMIT ( SQLCA, FALSE) // [PI056][TRANCOUNT][JFF][24/01/2020]

			bRet = FALSE
			F_Message ( stMessage )

			Exit
		End If

Next

Return ( bRet )

end function

private function boolean uf_modifier_operateur (string asfiltre);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Corb_Oper::Uf_Modifier_Operateur (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 28/12/1999 16:04:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On modifie les op$$HEX1$$e900$$ENDHEX$$rateurs qui changent avec ALT_VALIDE.
//*
//* Arguments		: String		asFiltre			 (Val) Filtre $$HEX2$$e0002000$$ENDHEX$$appliquer
//*
//* Retourne		: Boolean		TRUE 	= Tout est OK, on continue
//*										FALSE	= Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long lTotTrt, lCpt, lIdCorb, lRet
String sIdOper, sIdCorb, sSql, sCreeLe, sMajLe, sMajPar, sAltVAlideApr, sIdAppli
String sVarErreur[6]
Boolean bRet

bRet = TRUE

/*------------------------------------------------------------------*/
/* On filtre la DW de recherche qui contient toutes les lignes.     */
/*------------------------------------------------------------------*/
iuoAjoutCorbeille.dw_Recherche.SetFilter ( asFiltre )
iuoAjoutCorbeille.dw_Recherche.Filter ()
iuoAjoutCorbeille.dw_Recherche.Sort ()

lTotTrt	= iuoAjoutCorbeille.dw_Recherche.RowCount ()

sMajLe	= "'" + String ( DateTime ( Today (), Now () ), "dd/mm/yyyy hh:mm:ss.ff" ) + "'"
sMajPar	= "'" + stGLB.sCodOper + "'"

For	lCpt = 1 To lTotTrt
		sIdOper			= "'" + iuoAjoutCorbeille.dw_Recherche.GetItemString ( lCpt, "ID_OPER" ) + "'"
		sAltValideApr	= "'" + iuoAjoutCorbeille.dw_Recherche.GetItemString ( lCpt, "ALT_VALIDE_APRES" ) + "'"
		sIdAppli			= String ( ilIdAppli )

		sIdCorb		= "'" + String ( iuoAjoutCorbeille.dw_Recherche.GetItemNumber ( lCpt, "ID_CORB" ), "000" ) + "'"
		
		sSql		= "EXECUTE sysadm.IM_U01_CORB_OPER_NEW "					+ &
						sIdOper													+ "," + &
						sIdCorb													+ "," + &
						sAltValideApr											+ "," + &
						sMajLe													+ "," + &
						sMajPar													+ "," + &
						sIdAppli

		// [MIGPB11] [EMD] : Debut Migration : [SNC] contourne le fait que SNC ne mette pas $$HEX2$$e0002000$$ENDHEX$$jour SqlnRows
		//EXECUTE IMMEDIATE :sSql USING SQLCA		;
		f_execute( sSql, SQLCA )
		// [MIGPB11] [EMD] : Fin Migration

		If	SQLCA.SqlnRows <> 1 Then
			sVarErreur[1]			= String ( SQLCA.SqlDbCode )
			sVarErreur[2]			= SQLCA.SqlErrText
			sVarErreur[3]			= SQLCA.Dbms
			sVarErreur[4]			= SQLCA.Database
			sVarErreur[5]			= SQLCA.UserId
			sVarErreur[6]			= SQLCA.Lock

			stMessage.bErreurG	= True
			stMessage.bTrace		= False
			stMessage.sTitre		= "Gestion des Corbeilles/Op$$HEX1$$e900$$ENDHEX$$rateurs"
			stMessage.Icon			= StopSign!
			stMessage.sCode 		= "CORB005"
			stMessage.sVar			= sVarErreur
/*------------------------------------------------------------------*/
/* Il faut faire le ROLLBACK maintenant et afficher le message      */
/* d'erreur ensuite. Un second ROLLBACK partira sur l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement     */
/* VALIDER de la fen$$HEX1$$ea00$$ENDHEX$$tre.                                           */
/*------------------------------------------------------------------*/
//			ROLLBACK USING SQLCA		;
			F_COMMIT ( SQLCA, FALSE) // [PI056][TRANCOUNT][JFF][24/01/2020]

			bRet = FALSE

			F_Message ( stMessage )
			Exit
		End If
Next

Return ( bRet )


end function

private function boolean uf_supprimer_operateur (string asfiltre);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Corb_Oper::Uf_Supprimer_Operateur (PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 28/12/1999 16:04:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On vient de cliquer sur le bouton VALIDER
//*
//* Arguments		: String		asFiltre			 (Val) Filtre $$HEX2$$e0002000$$ENDHEX$$appliquer
//*
//* Retourne		: Boolean		TRUE 	= Tout est OK, on continue
//*										FALSE	= Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long lTotTrt, lCpt, lIdCorb, lRet
String sIdOper, sIdCorb, sSql, sIdAppli
String sVarErreur[6]
Boolean bRet

bRet = TRUE

/*------------------------------------------------------------------*/
/* On filtre la DW de recherche qui contient toutes les lignes.     */
/*------------------------------------------------------------------*/
iuoAjoutCorbeille.dw_Recherche.SetFilter ( asFiltre )
iuoAjoutCorbeille.dw_Recherche.Filter ()
iuoAjoutCorbeille.dw_Recherche.Sort ()

lTotTrt = iuoAjoutCorbeille.dw_Recherche.RowCount ()

For	lCpt = 1 To lTotTrt
		sIdOper		= "'" + iuoAjoutCorbeille.dw_Recherche.GetItemString ( lCpt, "ID_OPER" ) + "'"
		sIdAppli		= String ( ilIdAppli )
		
		sIdCorb		= "'" + String ( iuoAjoutCorbeille.dw_Recherche.GetItemNumber ( lCpt, "ID_CORB" ), "000" ) + "'"

		sSql		= "EXECUTE sysadm.IM_D01_CORB_OPER_NEW "					+ &
						sIdOper													+ "," + &
						sIdCorb													+ "," + &
						sIdAppli

		// [MIGPB11] [EMD] : Debut Migration : [SNC] contourne le fait que SNC ne mette pas $$HEX2$$e0002000$$ENDHEX$$jour SqlnRows
		//EXECUTE IMMEDIATE :sSql USING SQLCA		;
		f_execute( sSql, SQLCA )
		// [MIGPB11] [EMD] : Fin Migration
		
		If	SQLCA.SqlnRows <> 1 Then
			sVarErreur[1]			= String ( SQLCA.SqlDbCode )
			sVarErreur[2]			= SQLCA.SqlErrText
			sVarErreur[3]			= SQLCA.Dbms
			sVarErreur[4]			= SQLCA.Database
			sVarErreur[5]			= SQLCA.UserId
			sVarErreur[6]			= SQLCA.Lock

			stMessage.bErreurG	= True
			stMessage.bTrace		= False
			stMessage.sTitre		= "Gestion des Corbeilles/Op$$HEX1$$e900$$ENDHEX$$rateurs"
			stMessage.Icon			= StopSign!
			stMessage.sCode 		= "CORB003"
			stMessage.sVar			= sVarErreur
/*------------------------------------------------------------------*/
/* Il faut faire le ROLLBACK maintenant et afficher le message      */
/* d'erreur ensuite. Un second ROLLBACK partira sur l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement     */
/* VALIDER de la fen$$HEX1$$ea00$$ENDHEX$$tre.                                           */
/*------------------------------------------------------------------*/
//			ROLLBACk USING SQLCA		;
			F_COMMIT ( SQLCA, FALSE) // [PI056][TRANCOUNT][JFF][24/01/2020]

			bRet = FALSE
			F_Message ( stMessage )

			Exit
		End If
Next

Return ( bRet )






end function

public function boolean uf_valider (boolean absortiechecked);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Corb_Oper::Uf_Valider (PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 28/12/1999 16:04:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On vient de cliquer sur le bouton VALIDER
//*
//* Arguments		: Boolean	abSortieChecked (Val) Doit-on v$$HEX1$$e900$$ENDHEX$$rifier toutes les lignes de dwAccOper
//*
//* Retourne		: Boolean		TRUE 	= Tout est OK, on continue
//*										FALSE	= Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Long lCpt, lTotOper, lTotTrt, lIdCorb
String sFiltre, sIdOper
Boolean bRet

bRet = FALSE

/*------------------------------------------------------------------*/
/* Faut-il v$$HEX1$$e900$$ENDHEX$$rifier toutes les lignes de idwAccOper ?               */
/*------------------------------------------------------------------*/
If abSortieChecked = TRUE	Then
	lTotOper = idwAccOper.RowCount ()
	For	lCpt = 1 To lTotOper
			If	IsNull ( idwAccOper.GetItemString ( lCpt, "ALT_TRT" ) ) Then
				Uf_Traiter_Operateur ( lCpt )
			End If
	Next
End If

/*------------------------------------------------------------------*/
/* On s'occupe de la DW RECHERCHE de U_AJOUT. Cette DW contient     */
/* toutes les lignes $$HEX2$$e0002000$$ENDHEX$$mettre $$HEX2$$e0002000$$ENDHEX$$jour.                               */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* Les lignes avec -1 dans la zone ALT_AVANT doivent $$HEX1$$ea00$$ENDHEX$$tre           */
/* supprim$$HEX1$$e900$$ENDHEX$$es de la table CORB_OPER. (Op$$HEX1$$e900$$ENDHEX$$rateur ou corbeille n'est  */
/* plus valide).                                                    */
/*------------------------------------------------------------------*/
sFiltre = "ALT_AVANT = -1"
bRet = Uf_Supprimer_Operateur ( sFiltre )

/*------------------------------------------------------------------*/
/* Les lignes avec 1 (ALT_AVANT) et 0 (ALT_APRES) doivent $$HEX1$$ea00$$ENDHEX$$tre      */
/* supprim$$HEX1$$e900$$ENDHEX$$es aussi.                                                */
/*------------------------------------------------------------------*/
sFiltre = "ALT_AVANT = 1 And ALT_APRES = 0"
bRet = Uf_Supprimer_Operateur ( sFiltre )

/*------------------------------------------------------------------*/
/* Les lignes avec 0 (ALT_AVANT) et 1 (ALT_APRES) doivent $$HEX1$$ea00$$ENDHEX$$tre      */
/* ins$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$es.                                                        */
/*------------------------------------------------------------------*/
sFiltre = "ALT_AVANT = 0 AND ALT_APRES = 1"
bRet = Uf_Inserer_Operateur ( sFiltre )

/*------------------------------------------------------------------*/
/* Les lignes de dw_Cible avec 1 (ALT_AVANT) et 1 (ALT_APRES) et    */
/* ALT_VALIDE_AVANT <> ALT_VALIDE_APRES doivent $$HEX1$$ea00$$ENDHEX$$tre modifi$$HEX1$$e900$$ENDHEX$$es.     */
/*------------------------------------------------------------------*/
sFiltre = "( ALT_AVANT = 1 AND ALT_APRES = 1 ) And ( ALT_VALIDE_AVANT <> ALT_VALIDE_APRES )"
bRet = Uf_Modifier_Operateur ( sFiltre )

/*------------------------------------------------------------------*/
/* Tout se passe bien, on effectue le COMMIT g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$ral maintenant.    */
/*------------------------------------------------------------------*/
If	bRet Then 	
//	COMMIT USING SQLCA		;
	F_COMMIT ( SQLCA, TRUE ) // [PI056][TRANCOUNT][JFF][24/01/2020]
End If

Return ( bRet )


end function

on n_cst_corb_oper.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_corb_oper.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

