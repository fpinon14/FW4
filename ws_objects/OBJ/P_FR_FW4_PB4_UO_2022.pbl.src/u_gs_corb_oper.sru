HA$PBExportHeader$u_gs_corb_oper.sru
$PBExportComments$----} UserObjet servant $$HEX2$$e0002000$$ENDHEX$$toutes les fonctionnalit$$HEX1$$e900$$ENDHEX$$s de la gestion des Corbeilles/Op$$HEX1$$e900$$ENDHEX$$rateurs
forward
global type u_gs_corb_oper from nonvisualobject
end type
end forward

global type u_gs_corb_oper from nonvisualobject
end type
global u_gs_corb_oper u_gs_corb_oper

type variables
Private :
	u_Transaction		itrTrans

	u_DataWindow_Accueil	iDw_Acc

	DataWindow		iDw_Operateur
	DataWindow		iDw_Produit
	DataWindow		iDw_Texte

	U_DataWindow		iDw1

	String			isMoteur




    
end variables

forward prototypes
private subroutine uf_creer_accueil ()
private subroutine uf_selectionner_produit ()
private subroutine uf_selectionner_corbeille_oper ()
public subroutine uf_filtrer_corbeille (long allig)
private function string uf_getitem (ref datawindow adw, string asColonne, long alLigne)
private function boolean uf_gestion_operateur ()
public function boolean uf_valider_operateur ()
private function boolean uf_supprimer_operateur (string asidoper, string asidcorb)
private function boolean uf_preparer_supprimer ()
private function boolean uf_preparer_inserer ()
private function boolean uf_inserer_operateur (long alligne)
public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow_accueil adwacc, ref datawindow adwoperateur, ref datawindow adwproduit, ref u_datawindow adw1, ref datawindow adwtexte)
end prototypes

private subroutine uf_creer_accueil ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Creer_Accueil (Private)
//* Auteur			: Erick John Stark
//* Date				: 09/09/1997 16:14:07
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Cr$$HEX1$$e900$$ENDHEX$$ation de la DataWindow Accueil
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sTables[]

// .... Description de la DW d'accueil

idw_Acc.istCol[1].sDbName		=	"corb.id_oper"
idw_Acc.istCol[1].sType			=	"char(4)"
idw_Acc.istCol[1].sHeaderName	=	"Code"
idw_Acc.istCol[1].sAlignement	= 	"0"
idw_Acc.istCol[1].ilargeur		=	4
idw_Acc.istCol[1].sInvisible	= 	"N"

idw_Acc.istCol[2].sDbName		=	"corb.nom"
idw_Acc.istCol[2].sType			=	"char(30)"
idw_Acc.istCol[2].sHeaderName	=	"Nom"
idw_Acc.istCol[2].ilargeur		=	18
idw_Acc.istCol[2].sAlignement	=	"0"
idw_Acc.istCol[2].sInvisible	= 	"N"

idw_Acc.istCol[3].sDbName		=	"corb.prenom"
idw_Acc.istCol[3].sType			=	"char(30)"
idw_Acc.istCol[3].sHeaderName	=	"Pr$$HEX1$$e900$$ENDHEX$$nom"
idw_Acc.istCol[3].ilargeur		=	13
idw_Acc.istCol[3].sAlignement	=	"0"
idw_Acc.istCol[3].sInvisible	= 	"N"

idw_Acc.istCol[4].sDbName		=	"corb.cree_le"
idw_Acc.istCol[4].sType			=	"datetime"
idw_Acc.istCol[4].sHeaderName	=	"Cree Le"
idw_Acc.istCol[4].sFormat		=  "dd/mm/yy hh:mm"
idw_Acc.istCol[4].ilargeur		=	15
idw_Acc.istCol[4].sAlignement	=	"2"
idw_Acc.istCol[4].sInvisible	= 	"O"

idw_Acc.istCol[5].sDbName		=	"corb.maj_le"
idw_Acc.istCol[5].sType			=	"datetime"
idw_Acc.istCol[5].sHeaderName	=	"Maj le"
idw_Acc.istCol[5].sFormat		=  "dd/mm/yy hh:mm"
idw_Acc.istCol[5].ilargeur		=	15
idw_Acc.istCol[5].sAlignement	=	"2"
idw_Acc.istCol[5].sInvisible	= 	"N"

idw_Acc.istCol[6].sDbName		=	"corb.maj_par"
idw_Acc.istCol[6].sType			=	"char(4)"
idw_Acc.istCol[6].sHeaderName	=	"Par"
idw_Acc.istCol[6].ilargeur		=	4
idw_Acc.istCol[6].sAlignement	=	"0"
idw_Acc.istCol[6].sInvisible	= 	"N"

sTables[ 1 ]		= "corb"

idw_Acc.isPointer = ""

idw_Acc.Uf_Creer_Tout ( idw_Acc.istCol, sTables, itrTrans )


end subroutine

private subroutine uf_selectionner_produit ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Selectionner_Produit (Private)
//* Auteur			: Erick John Stark
//* Date				: 10/09/1997 11:48:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la liste des produits
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sDataObjet

sDataObjet = "d_produit_lst_" + isMoteur

/*------------------------------------------------------------------*/
/* S$$HEX1$$e900$$ENDHEX$$lection des produits et des corbeilles.                        */
/*------------------------------------------------------------------*/

idw_Produit.DataObject = sDataObjet
idw_Produit.SetTransObject ( itrTrans )
idw_Produit.Retrieve ()






end subroutine

private subroutine uf_selectionner_corbeille_oper ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Selectionner_Corbeille_Oper (Private)
//* Auteur			: Erick John Stark
//* Date				: 10/09/1997 11:48:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration de la liste des Op$$HEX1$$e900$$ENDHEX$$rateurs/Produits
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sDataObjet

sDataObjet = "d_Operateur_Corbeille_" + isMoteur

/*------------------------------------------------------------------*/
/* S$$HEX1$$e900$$ENDHEX$$lection des op$$HEX1$$e900$$ENDHEX$$rateurs/corbeilles qui ont d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$assign$$HEX1$$e900$$ENDHEX$$.    */
/*------------------------------------------------------------------*/

idw1.Uf_DataObject ( sDataObjet )
idw1.Uf_SetTransObject ( itrTrans )
idw1.Retrieve ()






end subroutine

public subroutine uf_filtrer_corbeille (long allig);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Filtrer_Corbeille (Public)
//* Auteur			: Erick John Stark
//* Date				: 11/09/1997 15:06:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Filtrer les corbeilles en fonction de l'op$$HEX1$$e900$$ENDHEX$$rateur
//*
//* Arguments		: Long			alLig				(Val)	Ligne du code op$$HEX1$$e900$$ENDHEX$$rateur $$HEX2$$e0002000$$ENDHEX$$filtrer
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

String sCodOper, sFiltre, sMod

sCodOper = idw_Acc.GetItemString ( alLig, "ID_OPER" )
sFiltre	= "ID_OPER = '" + sCodOper + "'"

idw_Texte.Visible = False

idw_Texte.SetFilter ( sFiltre )
idw_Texte.Filter ()
idw_Texte.Sort ()
idw_Texte.GroupCalc ()

/*------------------------------------------------------------------*/
/* Le 02/10/1997, suite demande de M. Sal$$HEX27$$e90020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
/* On modifie le titre de la DataWindow au format                   */
/* 'Acc$$HEX1$$e900$$ENDHEX$$s aux produits pour : XXX'                                  */
/*------------------------------------------------------------------*/

sMod	= "st_Titre.Text = ' Acc$$HEX1$$e800$$ENDHEX$$s aux produits pour " + sCodOper + "'"

idw_Texte.Modify ( sMod )

idw_Texte.Visible = True


end subroutine

private function string uf_getitem (ref datawindow adw, string asColonne, long alLigne);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_GetItem (Private)
//* Auteur			: Erick John Stark
//* Date				: 23/09/1997 15:47:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: R$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$ration des zones en fonction du type de moteur
//* Commentaires	: 
//*
//* Arguments		: DataWindow	adw					(R$$HEX1$$e900$$ENDHEX$$f)	DataWindow
//*					  String			asColonne			(Val)	Nom de la colonne
//*					  Long			alLigne				(Val) N$$HEX2$$b0002000$$ENDHEX$$de la ligne
//*
//* Retourne		: String			Valeur de la zone en caract$$HEX1$$e800$$ENDHEX$$re
//*
//*-----------------------------------------------------------------

String sRet

Choose Case isMoteur
Case "GUP"

	sRet 	= adw.GetItemString ( alLigne, asColonne )

Case "MSS"

	sRet	= String ( adw.GetItemNumber ( alLigne, asColonne ) )

End Choose

Return ( sRet )

end function

private function boolean uf_gestion_operateur ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Gestion_Operateur (Private)
//* Auteur			: Erick John Stark
//* Date				: 10/09/1997 17:26:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des op$$HEX1$$e900$$ENDHEX$$rateurs et des corbeilles
//*
//* Arguments		: Aucun
//*
//* Retourne		: Bolean			True	= Tout est OK
//*										False = Il faut s'arr$$HEX1$$e900$$ENDHEX$$ter
//*
//*-----------------------------------------------------------------

Boolean bRet, bImportOper

String sIdOper, sRech, sImport, sTab, sNew, sMaintenant, sMod, sBlanc, sJaune
String sNom, sPrenom, sMajPar, sIdCorb, sIdCorbLu

DateTime dtCreeLe, dtMajLe

Long lTotOper, lTotProduit, lTotOperCorb, lCpt, lLig, lCpt2, lCptProd, lLig1

Integer iCpt

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie que au moins un op$$HEX1$$e900$$ENDHEX$$rateur poss$$HEX1$$e900$$ENDHEX$$de l'acc$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$cette     */
/* application. Sinon, cela ne sert $$HEX2$$e0002000$$ENDHEX$$rien de continuer.            */
/*------------------------------------------------------------------*/

lTotOper = idw_Operateur.RowCount ()

If	lTotOper < 1 Then
	stMessage.sCode		= "CORBE01"
	stMessage.sTitre		= "Erreur dans U_Gs_Corb_Oper"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= True
	stMessage.bTrace		= True

	bRet = False
	f_Message ( stMessage )
	Return ( bRet )

End If

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie qu'il existe au moins un produit dans la base.        */
/* Sinon, cela ne sert $$HEX2$$e0002000$$ENDHEX$$rien de continuer.                         */
/*------------------------------------------------------------------*/

lTotProduit = idw_Produit.RowCount ()

If	lTotProduit < 1 Then
	stMessage.sCode		= "CORBE02"
	stMessage.sTitre		= "Erreur dans U_Gs_Corb_Oper"
	stMessage.Icon			= Information!
	stMessage.bErreurG	= True
	stMessage.bTrace		= True

	bRet = False
	f_Message ( stMessage )
	Return ( bRet )

End If

sTab 			= "~t"
sNew			= "~r~n"
sMaintenant = String ( DateTime ( Today (), Now () ) )

/*------------------------------------------------------------------*/
/* La DataWindow doit $$HEX1$$ea00$$ENDHEX$$tre tri$$HEX1$$e900$$ENDHEX$$e sur le Code Op$$HEX1$$e900$$ENDHEX$$rateur.             */
/*------------------------------------------------------------------*/
idw_Operateur.Sort ()

/*------------------------------------------------------------------*/
/* La DataWindow doit $$HEX1$$ea00$$ENDHEX$$tre tri$$HEX1$$e900$$ENDHEX$$e sur le Code Op$$HEX1$$e900$$ENDHEX$$rateur et la        */
/* corbeille                                                        */
/*------------------------------------------------------------------*/
idw1.Sort ()

/*------------------------------------------------------------------*/
/* La Data Window doit $$HEX1$$ea00$$ENDHEX$$tre tri$$HEX1$$e900$$ENDHEX$$e sur le Code Corbeille.            */
/*------------------------------------------------------------------*/
idw_Produit.Sort ()

iCpt = 1

For	lCpt = 1 To lTotOper
		sIdOper	= idw_Operateur.GetItemString ( lCpt, "ID_OPER" )
		sRech		= "ID_OPER = '" + sIdOper + "'"

/*------------------------------------------------------------------*/
/* On v$$HEX1$$e900$$ENDHEX$$rifie si l'op$$HEX1$$e900$$ENDHEX$$rateur existe dans idw1 (Liste des            */
/* op$$HEX1$$e900$$ENDHEX$$rateurs assign$$HEX1$$e900$$ENDHEX$$s pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e900$$ENDHEX$$demment.)                               */
/*------------------------------------------------------------------*/
		lTotOperCorb = idw1.RowCount ()

		lLig = idw1.Find ( sRech, 1, lTotOperCorb )
		If	lLig > 0 Then
/*------------------------------------------------------------------*/
/* On vient de trouver l'op$$HEX1$$e900$$ENDHEX$$rateur. On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re au passage les      */
/* informations utiles.                                             */
/*------------------------------------------------------------------*/

			sNom			= idw_Operateur.GetItemString ( lCpt, "NOM" )
			sPrenom		= idw_Operateur.GetItemString ( lCpt, "PRENOM" )
			bImportOper	= False

/*------------------------------------------------------------------*/
/* On va v$$HEX1$$e900$$ENDHEX$$rifier si les corbeilles actuelles sont d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$assign$$HEX1$$e900$$ENDHEX$$es   */
/* $$HEX2$$e0002000$$ENDHEX$$l'op$$HEX1$$e900$$ENDHEX$$rateur.                                                   */
/*------------------------------------------------------------------*/

			For	lCptProd = 1 To lTotProduit
					sIdCorb = Uf_GetItem ( idw_Produit, "ID_CORB", lCptProd )
					If	isMoteur = "GUP" Then
						sRech		= "ID_OPER = '" + sIdOper + "' AND ID_CORB = '" + sIdCorb + "'"
					Else
						sRech		= "ID_OPER = '" + sIdOper + "' AND ID_CORB = " + sIdCorb
					End If

					lTotOperCorb = idw1.RowCount ()

					lLig1 = idw1.Find ( sRech, 1, lTotOperCorb )
					If	lLig1 > 0 Then

						sMajPar	= idw1.GetItemString ( lLig1, "MAJ_PAR" )
						dtCreeLe	= idw1.GetItemDateTime ( lLig1, "CREE_LE" )
						dtMajLe	= idw1.GetItemDateTime ( lLig1, "MAJ_LE" )

/*------------------------------------------------------------------*/
/* On vient de trouver la corbeille. On supprime l'enregistrement   */
/* de Dw_1. On ins$$HEX1$$e900$$ENDHEX$$re une ligne pour l'op$$HEX1$$e900$$ENDHEX$$rateur en cours dans      */
/* dw_Acc.                                                          */
/*------------------------------------------------------------------*/

						idw1.DeleteRow ( lLig1 )

						If	Not bImportOper Then
							sImport =	sIdOper 									+ sTab + &
											sNom  									+ sTab + &
											sPrenom  								+ sTab + &
											String ( dtCreeLe )					+ sTab + &
											String ( dtMajLe )					+ sTab + &
											sMajPar
							bImportOper = True
							idw_Acc.ImportString ( sImport )		
						End If

/*------------------------------------------------------------------*/
/* Ensuite, on cr$$HEX3$$e900e9002000$$ENDHEX$$autant de lignes pour cet op$$HEX1$$e900$$ENDHEX$$rateur qu'il       */
/* existe de corbeilles.                                            */
/*------------------------------------------------------------------*/
						sIdCorbLu	= sIdCorb
						sImport		= ""
						Do While sIdCorbLu = sIdCorb
							sImport =	sImport																		+ &
											sIdOper															+ sTab	+ &
											Uf_GetItem ( idw_Produit, "ID_CORB", lCptProd )		+ sTab	+ &
											idw_Produit.GetItemString ( lCptProd, "LIB_CORB" )	+ sTab	+ &
											Uf_GetItem ( idw_Produit, "ID_PROD", lCptProd )		+ sTab	+ &
											idw_Produit.GetItemString ( lCptProd, "LIB_LONG" )	+ sTab	+ &
											String ( dtCreeLe )											+ sTab	+ &
											String ( dtMajLe )											+ sTab 	+ &
											sMajPar															+ sTab 	+ &
											"O"																+ sTab 	+ &
											"O"																+ sNew
							lCptProd ++
							If	lCptProd > lTotProduit Then
								Exit
							Else
								sIdCorb = Uf_GetItem ( idw_Produit, "ID_CORB", lCptProd )
							End If							
						Loop
						idw_Texte.ImportString ( sImport )
						sImport = ""
						lCptProd --
					Else
/*------------------------------------------------------------------*/
/* La corbeille n'existe pas pour l'op$$HEX1$$e900$$ENDHEX$$rateur. On ins$$HEX1$$e900$$ENDHEX$$re une ligne  */
/* dans dw_Acc.                                                     */
/*------------------------------------------------------------------*/

						If	Not bImportOper Then

							sImport =	sIdOper 									+ sTab + &
											sNom  									+ sTab + &
											sPrenom  								+ sTab + &
											sMaintenant								+ sTab + &
											sMaintenant								+ sTab + &
											stGLB.sCodOper
							bImportOper = True
							idw_Acc.ImportString ( sImport )

						End If

/*------------------------------------------------------------------*/
/* Ensuite, on cr$$HEX3$$e900e9002000$$ENDHEX$$autant de lignes pour cet op$$HEX1$$e900$$ENDHEX$$rateur qu'il       */
/* existe de corbeilles.                                            */
/*------------------------------------------------------------------*/
						sIdCorbLu	= sIdCorb
						sImport		= ""
						Do While sIdCorbLu = sIdCorb
							sImport =	sImport																		+ &
											sIdOper															+ sTab	+ &
											Uf_GetItem ( idw_Produit, "ID_CORB", lCptProd )		+ sTab	+ &
											idw_Produit.GetItemString ( lCptProd, "LIB_CORB" )	+ sTab	+ &
											Uf_GetItem ( idw_Produit, "ID_PROD", lCptProd )		+ sTab	+ &
											idw_Produit.GetItemString ( lCptProd, "LIB_LONG" )	+ sTab	+ &
											String ( dtCreeLe )											+ sTab	+ &
											String ( dtMajLe )											+ sTab 	+ &
											sMajPar															+ sTab 	+ &
											"N"																+ sTab 	+ &
											"N"																+ sNew
							lCptProd ++
							If	lCptProd > lTotProduit Then
								Exit
							Else
								sIdCorb = Uf_GetItem ( idw_Produit, "ID_CORB", lCptProd )
							End If
							
						Loop
						idw_Texte.ImportString ( sImport )
						sImport = ""
						lCptProd --
					End If
			Next
		Else

/*------------------------------------------------------------------*/
/* Si l'op$$HEX1$$e900$$ENDHEX$$rateur n'existe pas, on l'ins$$HEX1$$e900$$ENDHEX$$re dans la fen$$HEX1$$ea00$$ENDHEX$$tre         */
/* d'accueil.                                                       */
/*------------------------------------------------------------------*/
			sImport =	sIdOper 														+ sTab + &
							idw_Operateur.GetItemString ( lCpt, "NOM" )		+ sTab + &
							idw_Operateur.GetItemString ( lCpt, "PRENOM" )	+ sTab + &
							sMaintenant													+ sTab + &
							sMaintenant													+ sTab + &
							stGLB.sCodOper

			idw_Acc.ImportString ( sImport )

/*------------------------------------------------------------------*/
/* Ensuite, on cr$$HEX3$$e900e9002000$$ENDHEX$$autant de lignes pour cet op$$HEX1$$e900$$ENDHEX$$rateur qu'il       */
/* existe de corbeilles.                                            */
/*------------------------------------------------------------------*/
			
			sImport = ""
			For	lCpt2	= 1 To lTotProduit
					sImport =	sImport																		+ &
									sIdOper															+ sTab	+ &
									Uf_GetItem ( idw_Produit, "ID_CORB", lCpt2 )			+ sTab	+ &
									idw_Produit.GetItemString ( lCpt2, "LIB_CORB" )		+ sTab	+ &
									Uf_GetItem ( idw_Produit, "ID_PROD", lCpt2 )			+ sTab	+ &
									idw_Produit.GetItemString ( lCpt2, "LIB_LONG" )		+ sTab	+ &
									sMaintenant														+ sTab	+ &
									sMaintenant														+ sTab	+ &
									stGLB.sCodOper													+ sTab	+ &
									"N"																+ sTab 	+ &
									"N"																+ sNew
			Next
			idw_Texte.ImportString ( sImport )
		End If
Next

/*------------------------------------------------------------------*/
/* On filtre maintenant les corbeilles en fonction du 1er           */
/* op$$HEX1$$e900$$ENDHEX$$rateur de la liste.                                           */
/*------------------------------------------------------------------*/

Uf_Filtrer_Corbeille ( 1 )

/*------------------------------------------------------------------*/
/* On positionne les corbeilles s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$s en jaune.              */
/*------------------------------------------------------------------*/

sBlanc	= String ( Rgb ( 255, 255, 255 ) ) 
sJaune	= String ( Rgb ( 255, 255, 0   ) ) 

sMod = "LIB_CORB.Background.Color='" + sBlanc  							   	+ &
		 "~t If( ALT_RECLAME = ~"O~"  ," + sJaune + "," + sBlanc + ")' "	+ &
		 "ID_CORB.Background.Color='" + sBlanc  							   	+ &
		 "~t If( ALT_RECLAME = ~"O~"  ," + sJaune + "," + sBlanc + ")'" 

idw_Texte.Modify ( sMod )

Return ( True )
end function

public function boolean uf_valider_operateur ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Valider_Operateur ( Public )
//* Auteur			: Erick John Stark
//* Date				: 25/09/1997 14:54:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Validation des Op$$HEX1$$e900$$ENDHEX$$rateurs/Corbeilles
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		True	= La validation se passe bien
//*										False = La validation ne se passe bien
//*
//*-----------------------------------------------------------------

Boolean bRet 

If	Uf_Preparer_Supprimer () Then
	If	Uf_Preparer_Inserer () Then
		bRet = True
//		COMMIT USING itrTrans		;
		F_COMMIT ( itrTrans, TRUE ) // [PI056][TRANCOUNT][JFF][24/01/2020]

	End If
End If

If	Not bRet Then
	f_Message ( stMessage )
/*------------------------------------------------------------------*/
/* Le ROLLBACK a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$fait dans la fonction Uf_Supprimer_Operateur.  */
/* On affiche simplement le message d'erreur.                       */
/*------------------------------------------------------------------*/
End If

Return ( bRet )


end function

private function boolean uf_supprimer_operateur (string asidoper, string asidcorb);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Supprimer_Operateur (Private)
//* Auteur			: Erick John Stark
//* Date				: 26/09/1997 10:01:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Suppression d'un op$$HEX1$$e900$$ENDHEX$$rateur dans la table CORB_OPER
//*
//* Arguments		: String			asIdOper			(Val)	Code de l'op$$HEX1$$e900$$ENDHEX$$rateur
//*					  String			asIdCorb			(Val) Code de la corbeille
//*
//* Retourne		: Boolean		True	= Tout est OK
//*										False	= La suppression pose un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

String sSql

Boolean bRet

bRet = True
Choose Case isMoteur
Case "GUP"
	sSql = 	"EXECUTE sysadm.d_corb_oper_d "			+ &
				"'" + asIdOper									+ "'," + &
				"'" + asIdCorb                         + "'"

Case "MSS"
/*------------------------------------------------------------------*/
/* Le 09/09/1998                                                    */
/* Il y a un probl$$HEX1$$e800$$ENDHEX$$me avec MSS. Si le code op$$HEX1$$e900$$ENDHEX$$rateur correspond     */
/* $$HEX2$$e0002000$$ENDHEX$$un mot r$$HEX1$$e900$$ENDHEX$$serv$$HEX2$$e9002000$$ENDHEX$$(OF, IS), le moteur ne parvient pas $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$coder   */
/* le SELECT ou l'UPDATE ou le DELETE. Je positionne donc toutes    */
/* les zones avec des quotes.                                       */
/*------------------------------------------------------------------*/
	asIdOper = "'" + asIdOper + "'"

	sSql = 	"EXECUTE sysadm.IM_D01_CORB_OPER "		+ &
				asIdOper											+ "," + &
				asIdCorb
	
End Choose

F_Execute ( sSql, itrTrans )

If itrTrans.SqlnRows <> 1 Then

	stMessage.bErreurG	= True
	stMessage.sVar[1]		= asIdOper
	stMessage.sVar[2]		= asIdCorb
	stMessage.sVar[3]		= itrTrans.SqlErrText
	stMessage.sTitre		= "- Assignation des Op$$HEX1$$e900$$ENDHEX$$rateurs - "
	stMessage.Icon			= Exclamation!
	stMessage.sCode 		= "CORBE01"

/*------------------------------------------------------------------*/
/* Il faut faire le ROOLBACK apr$$HEX1$$e900$$ENDHEX$$s. Sinon la zone SqlErrText est    */
/* remise $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro                                                    */
/*------------------------------------------------------------------*/

//	ROLLBACK USING	itrTrans		;
	F_COMMIT ( itrTrans, FALSE) // [PI056][TRANCOUNT][JFF][24/01/2020]
	
	bRet = False
End If

Return ( bRet )


end function

private function boolean uf_preparer_supprimer ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Preparer_Supprimer (Private)
//* Auteur			: Erick John Stark
//* Date				: 25/09/1997 15:00:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Suppression des op$$HEX1$$e900$$ENDHEX$$rateurs inutiles
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		True 	= La suppression est OK
//*										False	= La suppression ne marche pas
//*
//*-----------------------------------------------------------------

Long lTotSupp, lCptSupp

String sIdOper, sIdCorb

Boolean bRet

/*------------------------------------------------------------------*/
/* On va supprimer les op$$HEX1$$e900$$ENDHEX$$rateurs restants dans dw_1. Il y a des    */
/* op$$HEX1$$e900$$ENDHEX$$rateurs qui n'ont plus acc$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$l'application. Il y a des      */
/* corbeilles qui ne pointent plus sur les produits.                */
/*------------------------------------------------------------------*/

lTotSupp = idw1.RowCount ()
bRet		= True

For	lCptSupp = 1 To lTotSupp
		sIdOper	= idw1.GetItemString ( lCptSupp, "ID_OPER" )
		If	isMoteur = "GUP" Then
			sIdCorb = idw1.GetItemString ( lCptSupp, "ID_CORB" )
		Else
			sIdCorb = String ( idw1.GetItemNumber ( lCptSupp, "ID_CORB" ) )
		End If

		If	Not Uf_Supprimer_Operateur ( sIdOper, sIdCorb ) Then
			bRet = False
			Exit
		End If
Next

Return ( bRet )
end function

private function boolean uf_preparer_inserer ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Preparer_Inserer (Private)
//* Auteur			: Erick John Stark
//* Date				: 25/09/1997 18:01:03
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Insertion des op$$HEX1$$e900$$ENDHEX$$rateurs dans la table CORB_OPER
//*
//* Arguments		: Aucun
//*
//* Retourne		: Boolean		True	= Tout est OK
//*										False	= Erreur lors de l'insertion d'un des op$$HEX1$$e900$$ENDHEX$$rateurs
//*
//*-----------------------------------------------------------------

Boolean bRet

String sAltReclameAvant, sAltReclameApres, sIdOper, sIdCorb, sOperCorb

bRet = True

Long lTotOper, lCpt

/*------------------------------------------------------------------*/
/* On enleve le filtre sur la DataWindow de stockage. Toutes les    */
/* lignes sont tri$$HEX1$$e900$$ENDHEX$$es sur ID_OPER, ID_CORB, ID_PROD.                */
/*------------------------------------------------------------------*/

idw_Texte.Visible = False
idw_Texte.SetFilter ( "" )
idw_Texte.Filter ()
idw_Texte.Sort ()
idw_Texte.GroupCalc ()

lTotOper = idw_Texte.RowCount ()

sOperCorb = ""


For	lCpt = 1 To lTotOper
		sIdOper	= idw_Texte.GetItemString ( lCpt, "ID_OPER" )
		sIdCorb	= idw_Texte.GetItemString ( lCpt, "ID_CORB" )

		If	sIdOper + sIdCorb = sOperCorb Then
			Continue
		Else
			sOperCorb = sIdOper + sIdCorb

			sAltReclameAvant = idw_Texte.GetItemString ( lCpt, "ALT_RECLAME_AVANT" )
			sAltReclameApres = idw_Texte.GetItemString ( lCpt, "ALT_RECLAME" )

			If			sAltReclameAvant = "O" And sAltReclameApres = "N" Then
/*------------------------------------------------------------------*/
/* Il faut supprimer la ligne sur la table.                         */
/*------------------------------------------------------------------*/
						If	Not Uf_Supprimer_Operateur ( sIdOper, sIdCorb ) Then
							bRet = False
							Exit
						End If

			ElseIf	sAltReclameAvant = "N" And sAltReclameApres = "O" Then
/*------------------------------------------------------------------*/
/* Il faut ins$$HEX1$$e900$$ENDHEX$$rer la ligne dans la table.                          */
/*------------------------------------------------------------------*/
						If	Not Uf_Inserer_Operateur ( lCpt ) Then
							bRet = False
							Exit
						End If

			End If
		End If

Next

If	Not bRet Then
	idw_Texte.Visible = True
	Uf_Filtrer_Corbeille ( 1 )
End If

Return ( bRet )


end function

private function boolean uf_inserer_operateur (long alligne);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Inserer_Operateur (Private)
//* Auteur			: Erick John Stark
//* Date				: 26/09/1997 10:01:11
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Insertion d'un op$$HEX1$$e900$$ENDHEX$$rateur dans la table
//*
//* Arguments		: Long			alLigne			(Val)	N$$HEX2$$b0002000$$ENDHEX$$de la ligne
//*
//* Retourne		: Boolean		True	= Tout est OK
//*										False	= L'insertion pose un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

String sSql, sIdOper, sIdCorb, sMajPar, sCreeLe, sMajLe

Boolean bRet

bRet = True

Choose Case isMoteur
Case "GUP"
	sCreeLe	= String ( idw_Texte.GetItemDateTime ( alLigne, "CREE_LE" ), "yyyy-mm-dd hh:mm:ss.ff" )
	sMajLe	= String ( idw_Texte.GetItemDateTime ( alLigne, "MAJ_LE" ), "yyyy-mm-dd hh:mm:ss.ff" )

	// ... Cas SAVANE ou on est connect$$HEX2$$e9002000$$ENDHEX$$sur un SQLSERVER mais en utilisant les commandes
   //     initialement $$HEX1$$e900$$ENDHEX$$crites pour GUPTA

	// [MIGPB11] [EMD] : Debut Migration : support du DBMS SNC
	//If Left ( Upper ( itrTrans.DBMS ), 3 )	 = "MSS" Then
	//If Left ( Upper ( itrTrans.DBMS ), 3 ) = "MSS" or Left ( Upper ( itrTrans.DBMS ), 3 ) = "SNC" Then
	If Left ( Upper ( itrTrans.DBMS ), 3 ) <> "GUP" Then 		// [PI056] Moteur MSS par d$$HEX1$$e900$$ENDHEX$$faut
	// [MIGPB11] [EMD] : Fin Migration

		sCreeLe	= String ( idw_Texte.GetItemDateTime ( alLigne, "CREE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" ) 
		sMajLe	= String ( idw_Texte.GetItemDateTime ( alLigne, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss.ff" )

   End If

	sMajPar	= stGLB.sCodOper
	sIdCorb	= idw_Texte.GetItemString ( alLigne, "ID_CORB" )
	sIdOper	= idw_Texte.GetItemString ( alLigne, "ID_OPER" )

	sSql = 	"EXECUTE sysadm.d_corb_oper_i "			+ &
				"'" + sIdOper											+ "' ," + &
				"'" + sIdCorb											+ "' ," + &
				"'" + sCreeLe											+ "' ," + &
				"'" + sMajLe											+ "' ," + &
				"'" + sMajPar                                + "'"

Case "MSS"
	sCreeLe	= "'" + String ( idw_Texte.GetItemDateTime ( alLigne, "CREE_LE" ), "dd/mm/yyyy hh:mm:ss.ff" ) + "'"
	sMajLe	= "'" + String ( idw_Texte.GetItemDateTime ( alLigne, "MAJ_LE" ), "dd/mm/yyyy hh:mm:ss.ff" ) + "'"
	sMajPar	= stGLB.sCodOper
	sIdCorb	= idw_Texte.GetItemString ( alLigne, "ID_CORB" )
	sIdOper	= idw_Texte.GetItemString ( alLigne, "ID_OPER" )

/*------------------------------------------------------------------*/
/* Le 09/09/1998                                                    */
/* Il y a un probl$$HEX1$$e800$$ENDHEX$$me avec MSS. Si le code op$$HEX1$$e900$$ENDHEX$$rateur correspond     */
/* $$HEX2$$e0002000$$ENDHEX$$un mot r$$HEX1$$e900$$ENDHEX$$serv$$HEX2$$e9002000$$ENDHEX$$(OF, IS), le moteur ne parvient pas $$HEX2$$e0002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$coder   */
/* le SELECT ou l'UPDATE ou le DELETE. Je positionne donc toutes    */
/* les zones avec des quotes.                                       */
/*------------------------------------------------------------------*/
	sIdOper = "'" + sIdOper + "'"
	sMajPar = "'" + sMajPar + "'"

	sSql = 	"EXECUTE sysadm.IM_I01_CORB_OPER "				+ &
				sIdOper											+ "," + &
				sIdCorb											+ "," + &
				sCreeLe											+ "," + &
				sMajLe											+ "," + &
				sMajPar

End Choose

F_Execute ( sSql, itrTrans )

If itrTrans.SqlnRows <> 1 Then

	stMessage.bErreurG	= True
	stMessage.sVar[1]		= sIdOper
	stMessage.sVar[2]		= sIdCorb
	stMessage.sVar[3]		= itrTrans.SqlErrText
	stMessage.sTitre		= "- Assignation des Op$$HEX1$$e900$$ENDHEX$$rateurs - "
	stMessage.Icon			= Exclamation!
	stMessage.sCode 		= "CORBE02"

/*------------------------------------------------------------------*/
/* Il faut faire le ROLLBACK apr$$HEX1$$e900$$ENDHEX$$s. Sinon la zone SqlErrText est    */
/* remise $$HEX2$$e0002000$$ENDHEX$$z$$HEX1$$e900$$ENDHEX$$ro                                                    */
/*------------------------------------------------------------------*/

//	ROLLBACK USING	itrTrans		;
	F_COMMIT ( itrTrans, FALSE) // [PI056][TRANCOUNT][JFF][24/01/2020]
	
	bRet = False
End If

Return ( bRet )


end function

public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow_accueil adwacc, ref datawindow adwoperateur, ref datawindow adwproduit, ref u_datawindow adw1, ref datawindow adwtexte);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialisation (Public)
//* Auteur			: Erick John Stark
//* Date				: 09/09/1997 14:15:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des variables d'instances
//*
//* Arguments		: u_Transaction			atrTrans			(Val)	Objet de transaction
//*					  u_DataWindow_Accueil	adwAcc			(R$$HEX1$$e900$$ENDHEX$$f) DataWindow Accueil
//*					  DataWindow				adwOperateur	(R$$HEX1$$e900$$ENDHEX$$f) Liste des op$$HEX1$$e900$$ENDHEX$$rateurs concern$$HEX1$$e900$$ENDHEX$$s
//*					  DataWindow				adwProduit		(R$$HEX1$$e900$$ENDHEX$$f) Liste des produits
//*					  U_DataWindow				adw1				(R$$HEX1$$e900$$ENDHEX$$f) Liste des op$$HEX1$$e900$$ENDHEX$$rateurs/produits
//*					  DataWindow				adwTexte			(R$$HEX1$$e900$$ENDHEX$$f) 
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* idw_Acc correspond $$HEX2$$e0002000$$ENDHEX$$la DW accueil renseign$$HEX1$$e900$$ENDHEX$$e avec les           */
/* op$$HEX1$$e900$$ENDHEX$$rateurs qui peuvent se connecter $$HEX2$$e0002000$$ENDHEX$$l'application.             */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* idw_Operateur correspond $$HEX2$$e0002000$$ENDHEX$$la DW sur les op$$HEX1$$e900$$ENDHEX$$rateurs (Base        */
/* Acc$$HEX1$$e900$$ENDHEX$$s).                                                          */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* idw1 correspond $$HEX2$$e0002000$$ENDHEX$$la s$$HEX1$$e900$$ENDHEX$$lection sur CORB_OPER.                    */
/*------------------------------------------------------------------*/

u_Transaction trEnvSpb

Boolean bRet

String sMoteur, sDataObjet

Long lRet

trEnvspb = Create u_Transaction

/*------------------------------------------------------------------*/
/* On va se connecter $$HEX2$$e0002000$$ENDHEX$$la base qui g$$HEX1$$e900$$ENDHEX$$re la gestion des acc$$HEX1$$e900$$ENDHEX$$s.      */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On peut avoir deux moteurs diff$$HEX1$$e900$$ENDHEX$$rents. SqlBase ou SqlServer      */
/*------------------------------------------------------------------*/

sMoteur	= Upper ( ProfileString ( stGLB.sFichierIni, "SESAME BASE", "DBMS", "" ) )

If	sMoteur = "GUPTA" Then
	bRet = f_ConnectGupta ( stGLB.sFichierIni, "SESAME BASE", trEnvSpb, stGLB.sMessageErreur )
	sDataObjet = "d_Operateur_Application_GUP"
Else
	bRet = f_ConnectSqlServer ( stGLB.sFichierIni, "SESAME BASE", trEnvSpb, stGLB.sMessageErreur, stGLB.sLibCourtAppli, stGLB.sCodOper )
	sDataObjet = "d_Operateur_Application_MSS"
End If

If	bRet Then

/*------------------------------------------------------------------*/
/* Si la connexion se passe bien, on r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e900$$ENDHEX$$re la liste des          */
/* op$$HEX1$$e900$$ENDHEX$$rateurs qui ont acc$$HEX1$$e900$$ENDHEX$$s $$HEX2$$e0002000$$ENDHEX$$l'application.                        */
/*------------------------------------------------------------------*/

	adwOperateur.DataObject = sDataObjet
	adwOperateur.SetTransObject ( trEnvSpb )
	adwOperateur.Retrieve ( stGLB.sCodAppli )
	lRet = adwOperateur.RowCount ()

/*------------------------------------------------------------------*/
/* On se d$$HEX1$$e900$$ENDHEX$$connecte ensuite de la base ACCES. On initialise les     */
/* variables d'instances provenant de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil.         */
/*------------------------------------------------------------------*/
	DISCONNECT	USING	trEnvSpb		;

	itrtrans			= atrTrans
	idw_Acc			= adwAcc
	idw_Produit		= adwProduit
	idw1				= adw1
	idw_Operateur	= adwOperateur
	idw_Texte		= adwTexte

/*------------------------------------------------------------------*/
/* On initialise ici le type de moteur. Pour ce faire on prend en   */
/* compte la valeur itrTrans de la fen$$HEX1$$ea00$$ENDHEX$$tre d'accueil. La variable   */
/* isMoteur sera utilis$$HEX1$$e900$$ENDHEX$$e pour initialiser les DataObjects des DW.  */
/* (isMoteur peut-$$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$gal $$HEX2$$e0002000$$ENDHEX$$MSS ou GUP.)                          */
/*------------------------------------------------------------------*/

	isMoteur 				= Left ( Upper ( itrTrans.DBMS ), 3 )	
	// [MIGPB11] [EMD] : Debut Migration : modif de la variable isMoteur, si SNC on y met MSS
	//If isMoteur = "SNC" Then
	  If isMoteur <> "GUP" Then		// [PI056] Moteur MSS par d$$HEX1$$e900$$ENDHEX$$faut
		isMoteur = "MSS"
	End If
	// [MIGPB11] [EMD] : Fin Migration
	

   /*-------------------------------------------------------------------*/
	/* Pour l'application SAVANE on continue d'utiliser les dataobjects  */
   /* de gupta : ces derniers ont $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$migr$$HEX1$$e900$$ENDHEX$$s pour fonctionner avec une  */
   /* base SqlServer                                                    */
   /*-------------------------------------------------------------------*/

	// [I027].BUG2 : Test fiable du code applif_IsApplication('savane')
	//If Left( stGlb.sCodAppli , 2 ) = 'SA' And isMoteur = "MSS" Then isMoteur = 'GUP'
	If f_IsApplication('savane') And isMoteur = "MSS" Then isMoteur = 'GUP'

	Uf_Creer_Accueil ()
	Uf_Selectionner_Produit ()
	Uf_Selectionner_Corbeille_Oper ()
	Uf_Gestion_Operateur ()

End If	

Destroy trEnvSpb

end subroutine

on u_gs_corb_oper.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_gs_corb_oper.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

