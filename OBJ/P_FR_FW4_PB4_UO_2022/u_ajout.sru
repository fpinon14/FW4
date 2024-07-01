HA$PBExportHeader$u_ajout.sru
$PBExportComments$----} UserObjet de Type Contenu/Contenant
forward
global type u_ajout from userobject
end type
type p_indicateur from picture within u_ajout
end type
type pb_enlever_tout from picturebutton within u_ajout
end type
type pb_enlever_1 from picturebutton within u_ajout
end type
type pb_ajouter_tout from picturebutton within u_ajout
end type
type pb_ajouter_1 from picturebutton within u_ajout
end type
type dw_cible from datawindow within u_ajout
end type
type st_titre from statictext within u_ajout
end type
type dw_recherche from datawindow within u_ajout
end type
type dw_source from datawindow within u_ajout
end type
type r_bord from rectangle within u_ajout
end type
type ln_gauche from line within u_ajout
end type
type ln_bas from line within u_ajout
end type
end forward

global type u_ajout from userobject
integer width = 1518
integer height = 1236
boolean border = true
long backcolor = 12632256
event ue_dimensionner pbm_custom75
event ue_dwsource_retrieve pbm_custom74
event ue_dwsource_updatestart pbm_custom73
event type long ue_dwsource_sqlpreview ( sqlpreviewfunction requete,  sqlpreviewtype sql_type,  string sql_syntax,  dwbuffer buffer_dw,  long ligne )
event ue_dwrecherche_retrieve pbm_custom71
event ue_dwsource_itemchanged pbm_custom70
event ue_dwsource_supprime pbm_custom69
event ue_dwsource_itemerror pbm_custom68
event ue_dwsource_dclick pbm_custom67
event ue_dwsource_rbuttondown pbm_custom66
event ue_dwcible_rbuttondown pbm_custom65
event ue_dwcible_supprime pbm_custom64
event type long ue_dwsource_buttonclicked ( long row,  long actionreturncode,  dwobject dwo )
p_indicateur p_indicateur
pb_enlever_tout pb_enlever_tout
pb_enlever_1 pb_enlever_1
pb_ajouter_tout pb_ajouter_tout
pb_ajouter_1 pb_ajouter_1
dw_cible dw_cible
st_titre st_titre
dw_recherche dw_recherche
dw_source dw_source
r_bord r_bord
ln_gauche ln_gauche
ln_bas ln_bas
end type
global u_ajout u_ajout

type variables
Private :
    String            isArg
    Long             ilShiftLigCible
    Long             ilShiftLigSource

    Boolean         ibCopier
    Boolean         ibSourceClick
    Boolean         ibCibleClick
    Boolean         ibConsult

Protected :
    String            isTaille
    String            isSqlPrev
    String            isIndicateur
    String            isRech

    Boolean         ibTitre
    Boolean         ibEffet3D
    Boolean         ibHorizontal
    Boolean         ibIndicateur
    Boolean         ibSupprime
    Boolean         ibSourceSelMul

    Long              ilLigSourceClick
    Long              ilLigSourceSupp

    Integer           iiDifference

Public :
    Long             ilLigRecherche
    Long             ilLigSource
    Boolean         ibClick

end variables

forward prototypes
private subroutine uf_dimensionner ()
public subroutine uf_titre (string astitre)
private subroutine uf_selectionner (datawindow adwtrt, ref long alshiftlig)
public function long uf_initialiser (string asdwtrt, string asdwsource, string asdwcible, u_transaction atrtrans)
public subroutine uf_dwsourcestatus ()
public function long uf_dwrechercheretrieve (string astext, u_ajout auoajout)
public function long uf_dwsourceretrieve (string astext, u_ajout auoajout)
public subroutine uf_consulter (boolean abConsult)
private subroutine uf_copier (datawindow adwsource, datawindow adwcible, integer aitype)
public function string uf_modify (datawindow adwtrt, ref string astext)
private subroutine uf_ddcalendrier ()
end prototypes

event ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Ajout
//* Evenement 		: Ue_Dimensionner
//* Auteur			: Erick John Stark
//* Date				: 26/12/1996 15:03:16
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Dimensionnement de l'objet
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On appele la fonction uf_Dimensionner. Il suffit de mettre ce    */
/* script en overwrite si l'on ne veut pas d'un dimensionnement     */
/* automatique                                                      */
/*------------------------------------------------------------------*/

This.Uf_Dimensionner ()

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_dwsource_retrieve;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Ajout
//* Evenement 		: Ue_dwSource_Retrieve
//* Auteur			: Erick John Stark
//* Date				: 26/12/1996 21:35:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut, on g$$HEX1$$e900$$ENDHEX$$re un seul argument dans le retrieve.           */
/* Si cela ne convient pas, il suffit de mettre cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement en    */
/* overwrite                                                        */
/*------------------------------------------------------------------*/

ilLigSource = dw_Source.Retrieve ( isArg )

//Migration PB8-WYNIWYG-03/2006 FM
return ilLigSource
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_dwsource_updatestart;//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event type long ue_dwsource_sqlpreview(sqlpreviewfunction requete, sqlpreviewtype sql_type, string sql_syntax, dwbuffer buffer_dw, long ligne);//Migration PB8-WYNIWYG-03/2006 FM
//Modification de l'EventID de pbm_custom_72 $$HEX2$$e0002000$$ENDHEX$$None
//Ajout de 3 param$$HEX1$$e800$$ENDHEX$$tres pass$$HEX1$$e900$$ENDHEX$$s par valeur
//String		sql_syntax
//dwbuffer	buffer_dw
//long		ligne
//modification des types et des nom des 2 premi$$HEX1$$e800$$ENDHEX$$res variables
Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM
end event

event ue_dwrecherche_retrieve;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Ajout
//* Evenement 		: Ue_dwRecherche_Retrieve
//* Auteur			: Erick John Stark
//* Date				: 26/12/1996 21:35:38
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut, on g$$HEX1$$e900$$ENDHEX$$re un seul argument dans le retrieve.           */
/* Si cela ne convient pas, il suffit de mettre cet $$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement en    */
/* overwrite                                                        */
/*------------------------------------------------------------------*/

ilLigRecherche = dw_Recherche.Retrieve ( isArg )

//Migration PB8-WYNIWYG-03/2006 FM
return ilLigRecherche
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_dwsource_itemchanged;//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_dwsource_supprime;//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_dwsource_itemerror;//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_dwsource_dclick;//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_dwsource_rbuttondown;//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_dwcible_rbuttondown;//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_dwcible_supprime;//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event type long ue_dwsource_buttonclicked(long row, long actionreturncode, dwobject dwo);// JCA 
// 16/11/2006
// DCMP 060825 
// Optimisation Param$$HEX1$$e900$$ENDHEX$$trage

return 0
end event

private subroutine uf_dimensionner ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Dimensionner ( Private )
//* Auteur			: Erick John Stark
//* Date				: 26/12/1996 14:58:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Dimensionnement de l'objet
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On positionne la bordure et on la dimensionne                    */
/*------------------------------------------------------------------*/

Long lEpais, lX, lY

This.SetRedraw ( False )

If	ibEffet3D	Then

	r_Bord.X				= 0
	r_Bord.Y				= 0

	r_Bord.Height		= This.Height
	r_Bord.Width		= This.Width
	r_Bord.Visible		= True

	lEpais				= r_Bord.LineThickness + 9

	ln_Gauche.BeginY	= 0
	ln_Gauche.EndY		= This.Height
	ln_Gauche.BeginX	= This.Width - 3
	ln_Gauche.EndX		= This.Width - 3
	
	ln_Gauche.Visible	= True

	ln_Bas.BeginX		= 0
	ln_Bas.EndX			= This.Width
	ln_Bas.BeginY		= This.Height - 3
	ln_Bas.EndY			= This.Height - 3

	ln_Bas.Visible		= True
	
Else
	r_Bord.Visible 	= False
	ln_Bas.Visible		= False
	ln_Gauche.Visible	= False
	lEpais 				= 9
End If

/*------------------------------------------------------------------*/
/* Ensuite on s'occupe du titre                                     */
/*------------------------------------------------------------------*/

If	ibTitre Then
	st_Titre.X		= lEpais * 2
	st_Titre.Y		= lEpais

	st_Titre.Height	= 73
	st_Titre.Width		= This.Width - ( lEpais * 4 )

	st_Titre.Visible 	= True
Else
	st_Titre.Visible	= False
End If

/*------------------------------------------------------------------*/
/* Il faut s'occuper des boutons en fonction de l'orientation       */
/*------------------------------------------------------------------*/

If	ibHorizontal Then
	pb_Ajouter_1.PictureName 		= "K:\PB4OBJ\BMP\" + isTaille + "AJ_1_V.BMP"
	pb_Ajouter_Tout.PictureName	= "K:\PB4OBJ\BMP\" + isTaille + "AJ_T_V.BMP"
	pb_Enlever_1.PictureName		= "K:\PB4OBJ\BMP\" + isTaille + "EN_1_V.BMP"
	pb_Enlever_Tout.PictureName	= "K:\PB4OBJ\BMP\" + isTaille + "EN_T_V.BMP"
Else
	pb_Ajouter_1.PictureName 		= "K:\PB4OBJ\BMP\" + isTaille + "AJ_1_H.BMP"
	pb_Ajouter_Tout.PictureName	= "K:\PB4OBJ\BMP\" + isTaille + "AJ_T_H.BMP"
	pb_Enlever_1.PictureName		= "K:\PB4OBJ\BMP\" + isTaille + "EN_1_H.BMP"
	pb_Enlever_Tout.PictureName	= "K:\PB4OBJ\BMP\" + isTaille + "EN_T_H.BMP"
End If

/*------------------------------------------------------------------*/
/* Maintenant le postionnement des boutons                          */
/*------------------------------------------------------------------*/

If	Not ibHorizontal Then

	lX = ( ( This.Width / 2 ) - ( Pb_Ajouter_1.Width / 2 ) )
	lY = ( This.Height - ( ( Pb_Ajouter_1.Height + 50 ) * 4 ) ) / 2

	pb_Ajouter_1.X		= lX + iiDifference
	pb_Ajouter_Tout.X = lX + iiDifference
	pb_Enlever_1.X		= lX + iiDifference
	pb_Enlever_Tout.X	= lX + iiDifference

	pb_Ajouter_Tout.Y	= lY
	pb_Ajouter_1.Y 	= pb_Ajouter_Tout.Y 	+ pb_Ajouter_Tout.Height	+ 50
	pb_Enlever_1.Y		= pb_Ajouter_1.Y 		+ pb_Ajouter_1.Height 		+ 50
	pb_Enlever_Tout.Y	= pb_Enlever_1.Y 		+ pb_Ajouter_1.Height 		+ 50

Else

	lX = ( This.Width - ( ( Pb_Ajouter_1.Width + 50 ) * 4 ) ) / 2
	lY = ( This.Height  / 2 ) - ( pb_Ajouter_1.Height / 2 )

	If	ibTitre Then
		lY = lY + st_Titre.Height - ( lEpais * 2 )
	Else
		lY = lY - lEpais
	End If

	pb_Ajouter_Tout.X	= lX
	pb_Ajouter_1.X 	= pb_Ajouter_Tout.X 	+ pb_Ajouter_1.Width + 50
	pb_Enlever_1.X		= pb_Ajouter_1.X 		+ pb_Ajouter_1.Width + 50
	pb_Enlever_Tout.X	= pb_Enlever_1.X 		+ pb_Ajouter_1.Width + 50

	pb_Ajouter_1.Y		= lY + iiDifference 
	pb_Ajouter_Tout.Y = lY + iiDifference
	pb_Enlever_1.Y		= lY + iiDifference
	pb_Enlever_Tout.Y	= lY + iiDifference

End If

pb_Ajouter_1.Visible		= True
pb_Ajouter_Tout.Visible	= True
pb_Enlever_1.Visible		= True
pb_Enlever_Tout.Visible	= True

/*------------------------------------------------------------------*/
/* Et enfin, on s'occupe des Data Window de Traitement              */
/*------------------------------------------------------------------*/

If	Not ibHorizontal Then
	If	ibTitre Then
		dw_Source.Y = ( lEpais * 2 ) + st_Titre.Height
		dw_Cible.Y	= ( lEpais * 2 ) + st_Titre.Height
	Else
		dw_Source.Y = lEpais
		dw_Cible.Y	= lEpais
	End If

	dw_Cible.X				= lEpais + 6
	dw_Cible.Width			= pb_Ajouter_1.X - ( lEpais * 2 )	
	dw_Cible.Height		= This.Height - dw_Cible.Y - lEpais

	dw_Source.X				= pb_Ajouter_1.X + pb_Ajouter_1.Width + lEpais
	dw_Source.Width		= dw_Cible.Width - ( iiDifference * 2 )
	dw_Source.Height		= dw_Cible.Height

Else
	dw_Cible.X			= lEpais + 6
	dw_Cible.Width		= This.Width - ( lEpais * 2 )

	dw_Source.X			= lEpais + 6
	dw_Source.Width	= This.Width - ( lEpais * 2 )

	If	ibTitre	Then
		dw_Cible.Y		= ( lEpais * 2 ) + st_Titre.Height
	Else
		dw_Cible.Y		= lEpais
	End If

	dw_Cible.Height	= pb_Ajouter_1.Y - dw_Cible.Y - lEpais

	dw_Source.Y			= pb_Ajouter_1.Y + pb_Ajouter_1.Height + ( lEpais * 2 )
	dw_Source.Height	= dw_Cible.Height - ( iiDifference * 2 )

End If

dw_Source.Visible		= True
dw_Source.BringToTop = True

dw_Cible.Visible		= True
dw_Cible.BringToTop 	= True

/*------------------------------------------------------------------*/
/* Pour donner un effet 3D, il faut obligatoirement un border au    */
/* User Objet                                                       */
/*------------------------------------------------------------------*/

If	ibEffet3D	Then
	This.Width	= This.Width	+ 9
	This.Height = This.Height	+ 9
	This.Border = True
End If

This.SetRedraw ( True )

end subroutine

public subroutine uf_titre (string astitre);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Titre ( Public )
//* Auteur			: Erick John Stark
//* Date				: 28/12/1996 18:04:51
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Positionnement du titre si besoin
//*
//* Arguments		: String			asTitre			(Val)	Titre
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

If	ibTitre Then
	st_Titre.Text = asTitre
End If


end subroutine

private subroutine uf_selectionner (datawindow adwtrt, ref long alshiftlig);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Selectionner ( Private )
//* Auteur			: Erick John Stark
//* Date				: 26/12/1996 14:58:04
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: S$$HEX1$$e900$$ENDHEX$$lection des lignes dans les DW
//*
//* Arguments		: DataWindow		adwTrt		(Val) DataWindow en cours
//*					  Long				alShiftLig	(R$$HEX1$$e900$$ENDHEX$$f) Derni$$HEX1$$e800$$ENDHEX$$re ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$e
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lLig, lCpt

lLig = adwTrt.GetClickedRow ()

If	lLig > 0 Then
	
	ibSourceClick	= True
	ibCibleClick 	= True
	
	If			KeyDown ( KeyControl! ) Then

				If	adwTrt.GetSelectedRow ( lLig - 1 ) = lLig Then
			
					adwTrt.SelectRow ( lLig, False )

				Else

					adwTrt.SelectRow ( lLig, True )
					alShiftLig = lLig
				End If

	ElseIf	KeyDown ( KeyShift! ) Then
				
				If	alShiftLig	> 0 Then
					adwTrt.SelectRow ( 0, False )

					If	lLig < alShiftLig Then
						For	lCpt = alShiftLig To lLig  Step -1
								adwTrt.SelectRow ( lCpt, True )
						Next
					Else
						For	lCpt = alShiftLig To lLig
								adwTrt.SelectRow ( lCpt, True )
						Next
					End If
				End If

	Else

		adwTrt.SelectRow ( 0, False )

		If	adwTrt.GetSelectedRow ( lLig - 1 ) = lLig Then
			adwTrt.SelectRow ( lLig, False )
		Else
			adwTrt.SelectRow ( lLig, True )
			alShiftLig = lLig
		End If
	End If
End If

end subroutine

public function long uf_initialiser (string asdwtrt, string asdwsource, string asdwcible, u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser ( Public )
//* Auteur			: Erick John Stark
//* Date				: 26/12/1996 16:03:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des Datas Objets
//*
//* Arguments		: String			asDwTrt				(Val)	Data Object de la DW de traitement
//* 					  String			asdwSource			(Val)	Data Object de la DW source
//* 					  String			asdwCible			(Val)	Data Object de la DW cible
//* 					  Transaction	atrTrans				(Val)	Objet de transaction
//*
//* Retourne		: Long			 1 = Tout est OK
//*										-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

Long lRet

lRet = 1

/*------------------------------------------------------------------*/
/* On part du principe que les deux DW utilisent le m$$HEX1$$ea00$$ENDHEX$$me objet de   */
/* transaction                                                      */
/*------------------------------------------------------------------*/

/*------------------------------------------------------------------*/
/* Les dw source et cible doivent avoir les m$$HEX1$$ea00$$ENDHEX$$mes colonnes dans le  */
/* m$$HEX1$$ea00$$ENDHEX$$me ordre, neammoins elles peuvent avoir une cosm$$HEX1$$e900$$ENDHEX$$tique         */
/* diff$$HEX1$$e900$$ENDHEX$$rente                                                       */
/*------------------------------------------------------------------*/

dw_Recherche.DataObject	= asdwTrt
dw_Source.DataObject		= asdwSource
dw_Cible.DataObject		= asdwCible

If	dw_Recherche.SetTransObject ( atrTrans ) < 1 Then
	lRet = -1
End If

If dw_Source.SetTransObject ( atrTrans ) < 1 Then
	lRet = -1
End If

/*------------------------------------------------------------------*/
/* Si l'on d$$HEX1$$e900$$ENDHEX$$sire un RowFocusIndicator, il est positionn$$HEX2$$e9002000$$ENDHEX$$par       */
/* d$$HEX1$$e900$$ENDHEX$$faut.                                                          */
/* La personne qui n'en veut pas doit positionner "ibIndicateur" $$HEX3$$e00020002000$$ENDHEX$$*/
/* False sur le 'constructor' de l'objet.                           */
/* La personne qui d$$HEX1$$e900$$ENDHEX$$sire un bitmap particulier positionne          */
/* "isIndicateur"                                                   */
/*------------------------------------------------------------------*/

If	ibIndicateur Then
	p_Indicateur.PictureName = isIndicateur
	p_Indicateur.Height = Long ( dw_Source.Describe ( "DataWindow.Detail.Height" ) )
	dw_Source.SetRowFocusIndicator ( p_Indicateur )
End If

Return ( lRet )

end function

public subroutine uf_dwsourcestatus ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_dwSourceStatus ( Public )
//* Auteur			: Erick John Stark 
//* Date				: 26/12/1996 21:16:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Modification du status des lignes pour dwSource
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Long lCpt

/*------------------------------------------------------------------*/
/* Il existe une variable d'instance mais il vaut mieux la          */
/* r$$HEX1$$e900$$ENDHEX$$initialiser, on ne sait jamais                                 */
/*------------------------------------------------------------------*/

ilLigSource = dw_Source.RowCount ()

For	lCpt = 1 To ilLigSource
		dw_Source.SetItemStatus ( lCpt, 0, Primary!, NewModified! )
Next



end subroutine

public function long uf_dwrechercheretrieve (string astext, u_ajout auoajout);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_dwRechercheRetrieve ( Public )
//* Auteur			: Erick John Stark 
//* Date				: 26/12/1996 21:32:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String			asText				(Val)	Argument de Recherche
//*					  u_Ajout		auoAjout				(Val) User Objet u_Ajout
//*
//* Retourne		: Long			 ? = Nbr de lignes retrouv$$HEX1$$e900$$ENDHEX$$es
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut, un seul argument de recherche est g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e. Si          */
/* l'utilisateur en a besoin de plus, il doit mettre l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement    */
/* ue_dwTrt_Retrieve en overwrite et postionner lui-m$$HEX1$$ea00$$ENDHEX$$me les        */
/* arguments                                                        */
/*------------------------------------------------------------------*/

dw_Source.Reset ()
dw_Cible.Reset ()
dw_Recherche.Reset ()

isArg = asText

TriggerEvent ( auoAjout, "ue_dwRecherche_Retrieve" )

Return ( ilLigRecherche )
end function

public function long uf_dwsourceretrieve (string astext, u_ajout auoajout);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_dwSourceRetrieve ( Public )
//* Auteur			: Erick John Stark 
//* Date				: 26/12/1996 21:32:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String			asText				(Val)	Argument de Recherche
//*					  u_Ajout		auoAjout				(Val) User Objet u_Ajout
//*
//* Retourne		: Long			 ? = Nbr de lignes retrouv$$HEX1$$e900$$ENDHEX$$es
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Par d$$HEX1$$e900$$ENDHEX$$faut, un seul argument de recherche est g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e. Si          */
/* l'utilisateur en a besoin de plus, il doit mettre l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement    */
/* ue_dwSource_Retrieve en overwrite et postionner lui-m$$HEX1$$ea00$$ENDHEX$$me les     */
/* arguments                                                        */
/*------------------------------------------------------------------*/

isArg = asText

TriggerEvent ( auoAjout, "ue_dwSource_Retrieve" )

Return ( ilLigSource )







end function

public subroutine uf_consulter (boolean abConsult);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Consulter ( Public )
//* Auteur			: Erick John Stark
//* Date				: 15/01/1997 10:33:36
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Rend l'objet accessible ou non
//*
//* Arguments		: Boolean		abConsult		(Val)	Consultation ou Non
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

This.ibConsult = abConsult


end subroutine

private subroutine uf_copier (datawindow adwsource, datawindow adwcible, integer aitype);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Copier ( Private )
//* Auteur			: Erick John Stark
//* Date				: 08/01/97 22:23:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Copie les lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es d'une dw dans l'autre
//*
//* Arguments		: DataWindow	adwSource			(Val)	DataWindow Source
//*					  DataWindow	adwCible				(Val)	DataWindow Cible
//*					  Integer		aiType				(Val) Type Copie
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* Modification:
//*
//*   DATE      Programmeur						Description
//*
//* 23/01/1997      	ECA      Appel de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement ue_dwSource_supprime
//*                  	      de mani$$HEX1$$e800$$ENDHEX$$re $$HEX2$$e0002000$$ENDHEX$$preparer la suppression 
//*                           d'une ligne de Dw_Source.
//*
//* 24/01/1997		  	VCP	   Positionnement de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement ue_dwSource_supprime
//*                           dans le cas de la suppression d'une s$$HEX1$$e900$$ENDHEX$$lection
//*                           multiple au sein de Dw_Source et de la suppression
//*                           de toutes les lignes de Dw_Source
//*
//* 08/08/1997			DGA		Cr$$HEX1$$e900$$ENDHEX$$ation d'une variable d'instance ilLigSourceSupp
//*									Cette variable contient le N$$HEX2$$b0002000$$ENDHEX$$de la ligne que l'on va d$$HEX1$$e900$$ENDHEX$$placer
//*									Elle permet d'$$HEX1$$e900$$ENDHEX$$viter un conflit avec l'utilisation des fonctions 
//*									GetRow () et GetSelectedRow ()
//*									Cette fonctionnamit$$HEX2$$e9002000$$ENDHEX$$n'est pas g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e dans le cas d'un d$$HEX1$$e900$$ENDHEX$$placement de toutes les lignes
//*
//* 09/12/1997			VCP		Appel de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement ue_DwCible_Supprime de mani$$HEX1$$e800$$ENDHEX$$re $$HEX2$$e0002000$$ENDHEX$$
//*                  	      $$HEX2$$e0002000$$ENDHEX$$pouvoir intervenir sur l'obet avant la suppression 
//*                           d'une ou plusieurs lignes de Dw_Cible.
//*
//* 06/05/1998			DGA		Gestion d'une chaine de recherche pour se positionner sur la ligne d$$HEX1$$e900$$ENDHEX$$plac$$HEX1$$e900$$ENDHEX$$e
//*									
//*-----------------------------------------------------------------
Long lLigne = 0
Long lTot, lLigRech
ibCopier 	= True
isRech		= stNul.str

Choose Case aiType
Case 1					// Copie des lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es

/*------------------------------------------------------------------*/
/* Si on n'utilise pas la m$$HEX1$$e900$$ENDHEX$$thode de s$$HEX1$$e900$$ENDHEX$$lection multiple, on ajoute  */
/* uniquement la ligne courante                                     */
/*------------------------------------------------------------------*/

	If	Upper ( ClassName ( adwSource ) ) = "DW_SOURCE" And ibIndicateur	Then
		/*------------------------------------------------------------------*/
		/* D$$HEX1$$e900$$ENDHEX$$termine si la suppression d'une lignes de la datawindow        */
		/* source est autoris$$HEX1$$e900$$ENDHEX$$e: dans le cas d'une interdiction il faudra   */
		/* positionner $$HEX2$$e0002000$$ENDHEX$$False ibSupprime au niveau de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement          */
		/* ue_dwSource_supprime.                                            */
		/*------------------------------------------------------------------*/

		/*------------------------------------------------------------------*/
		/* Le 08/08/1997 : Assignation de la variable d'instance pour une   */
		/* utilisation $$HEX1$$e900$$ENDHEX$$ventuelle dans "ue_dwSourceSupprime"                */
		/*------------------------------------------------------------------*/

		lLigne 				= adwSource.GetRow ()		
		ilLigSourceSupp	= lLigne

		TriggerEvent ( "ue_dwSource_supprime" )

		If ibSupprime	Then

			adwSource.RowsMove ( lLigne, lLigne, Primary!, adwCible, 999999, Primary! )

		Else

			ibSupprime 	= True
		End If
	End If

/*------------------------------------------------------------------*/
/* Si on utilise la m$$HEX1$$e900$$ENDHEX$$thode de s$$HEX1$$e900$$ENDHEX$$lection multiple, on ajoute        */
/* toutes les lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es                                  */
/*------------------------------------------------------------------*/

	Do

/*------------------------------------------------------------------*/
/* Le 08/08/1997 : Assignation de la variable d'instance pour une   */
/* utilisation $$HEX1$$e900$$ENDHEX$$ventuelle dans "ue_dwSourceSupprime"                */
/*------------------------------------------------------------------*/

		lLigne 				= adwSource.GetSelectedRow ( lLigne )
		ilLigSourceSupp	= lLigne

		If	lLigne > 0 Then

			If	Upper ( ClassName ( adwSource ) ) = "DW_SOURCE"	Then			

				TriggerEvent ( "ue_dwSource_supprime" )

			Else

				/*----------------------------------------------------------------------------*/
				/* Appel de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement ue_dwCible_supprime de mani$$HEX1$$e800$$ENDHEX$$re $$HEX2$$e0002000$$ENDHEX$$garder une entr$$HEX1$$e900$$ENDHEX$$e    */
				/* avant le basculement d'un enregistrement de la cible vers la source.       */
				/******************************************************************************/
				/* ATTENTION!! : La r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence de la ligne bascul$$HEX1$$e900$$ENDHEX$$e est contenue dans          */
				/* ilLigSourceSupp et non pas ilLigCibleSupp ( Modification progressive de    */
				/* l'objet ).                                                                 */
				/*----------------------------------------------------------------------------*/
				TriggerEvent ( "ue_dwCible_supprime" )

			End If

			If ibSupprime	Then
				
				int i

				i = adwSource.RowsMove ( lLigne, lLigne, Primary!, adwCible, 999999, Primary! )

				/*------------------------------------------------------------------*/
				/* MODIF : lLigne-- $$HEX1$$e900$$ENDHEX$$tait juste avant le Loop Until, il a $$HEX1$$e900$$ENDHEX$$t$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$*/
				/* d$$HEX1$$e900$$ENDHEX$$plac$$HEX2$$e9002000$$ENDHEX$$ici afin de g$$HEX1$$e900$$ENDHEX$$rer correctement le cas o$$HEX2$$f9002000$$ENDHEX$$: on n'a pas    */
				/* de RowFocusIndicator (ibIndicateur=FALSE), la ligne N            */
				/* s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$ne peut pas $$HEX1$$ea00$$ENDHEX$$tre supprim$$HEX1$$e900$$ENDHEX$$e (ibSupprime=FALSE suite   */
				/* $$HEX2$$e0002000$$ENDHEX$$un contr$$HEX1$$f400$$ENDHEX$$le dans Ue_DwSource_Supprime). Dans ce cas, il ne     */
				/* faut pas faire le -- car sinon en d$$HEX1$$e900$$ENDHEX$$but de boucle le             */
				/* GetSelectedRow va renvoyer la ligne s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$suivante $$HEX8$$e0002000200020002000200020002000$$ENDHEX$$*/
				/* partir de la ligne N-1, c'est $$HEX2$$e0002000$$ENDHEX$$dire N : d'o$$HEX2$$f9002000$$ENDHEX$$BOUCLE INFINIE !!  */
				/* Ceci dit, si lLigne=0, il faut tout de m$$HEX1$$ea00$$ENDHEX$$me faire -- afin de     */
            /* pouvoir sortir de la boucle.                                     */
				/*------------------------------------------------------------------*/

				lLigne --

			Else

				ibSupprime = True

			End If

		Else

			lLigne --

		End If



	Loop Until lLigne < 0

Case 2					// Copie de toutes les lignes

	lTot = adwSource.RowCount ()

	If	Upper ( ClassName ( adwSource ) ) = "DW_SOURCE"	Then			

		TriggerEvent ( "ue_dwSource_supprime" )

	Else 

		/*----------------------------------------------------------------------------*/
		/* Appel de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement ue_dwCible_supprime de mani$$HEX1$$e800$$ENDHEX$$re $$HEX2$$e0002000$$ENDHEX$$garder une entr$$HEX1$$e900$$ENDHEX$$e    */
		/* avant le basculement de l'ensemble des enregistrements de la cible vers la */
		/* source.                                                                    */
		/*----------------------------------------------------------------------------*/
		TriggerEvent ( "ue_dwCible_supprime" )		

	End If

	If ibSupprime	Then

		adwSource.RowsMove ( 1, lTot, Primary!, adwCible, 999999, Primary! )

	Else 

		ibSupprime = True		

	End If

End Choose

ibCopier = False

adwCible.SetRedraw ( False )
adwCible.Sort ()

/*------------------------------------------------------------------*/
/* Si la chaine de recherche n'est pas vide, on essaye de trouver   */
/* la ligne qui vient d'$$HEX1$$ea00$$ENDHEX$$tre d$$HEX1$$e900$$ENDHEX$$plac$$HEX1$$e900$$ENDHEX$$e et on se positionne dessus.   */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* La chaine de recherche doit $$HEX1$$ea00$$ENDHEX$$tre logiquement arm$$HEX1$$e900$$ENDHEX$$e sur           */
/* Ue_DwSource_Supprime ou Ue_DwCible_Supprime.                     */
/*------------------------------------------------------------------*/
If Not IsNull ( isRech )	Then
	lTot		= adwCible.RowCount ()
	lLigRech = adwCible.Find ( isRech, 1, lTot )
	If	lLigRech > 0 Then
		adwCible.SetRow ( lLigRech )
		adwCible.ScrollToRow ( lLigRech )
		adwCible.SelectRow ( lLigRech, True )
		adwCible.SetFocus ()
	End If
End If

adwCible.SetRedraw ( True )
end subroutine

public function string uf_modify (datawindow adwtrt, ref string astext);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Modify ( Public )
//* Auteur			: Erick John Stark 
//* Date				: 28/12/1996 18:39:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Modification de la DW
//*
//* Arguments		: DataWindow	adwTrt				(Val)	DataWindow $$HEX2$$e0002000$$ENDHEX$$modifier
//*					  String			asText				(R$$HEX1$$e900$$ENDHEX$$f)	Cha$$HEX1$$ee00$$ENDHEX$$ne de texte
//*
//* Retourne		: Long			"" = OK
//*										?	= Le modify ne marche pase
//*
//*-----------------------------------------------------------------

Return ( adwTrt.Modify ( asText ) )

end function

private subroutine uf_ddcalendrier ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ddCalendrier ( Private )
//* Auteur			: Erick John Stark
//* Date				: 02/12/1996 15:32:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affichage d'un calendrier
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

s_Calendrier stCal
Environment stEnv
Integer iX, iY, iCalendrierHauteur
String sCol, sText
Long lLig
Window wParent

SetPointer ( HourGlass! )

/*------------------------------------------------------------------*/
/* Si la date n'est pas bonne on ressort tout de suite              */
/*------------------------------------------------------------------*/

sText = dw_Source.GetText ()

If	sText = "" Or sText = "01/01/1900" Then sText = String ( Today () )

If	Not IsDate ( sText ) Then	Return

stCal.dInit 	= Date ( sText )

sCol	= dw_Source.GetColumnName ()
lLig	= dw_Source.GetRow ()

iX		= dw_Source.X
iY		= dw_Source.Y

wParent = Parent

stCal.iX = wParent.WorkSpaceX () + iX + Integer ( dw_Source.Describe ( sCol + ".X" ) ) - 2
stCal.iY = wParent.WorkSpaceY () + iY + Integer ( dw_Source.Describe ( sCol + ".Y" ) ) &
				+ Integer ( dw_Source.Describe ( sCol + ".Height" ) ) + 12

iCalendrierHauteur = 695
GetEnvironment ( stEnv )

/*------------------------------------------------------------------*/
/* Je populise expr$$HEX1$$e900$$ENDHEX$$s une structure bas$$HEX1$$e900$$ENDHEX$$e sur l'environnement,      */
/* bien que celle-ci puisse exister dans stGLB                      */
/*------------------------------------------------------------------*/

If	stCal.iY + iCalendrierHauteur > PixelsToUnits ( stEnv.ScreenHeight, YPixelsToUnits! ) Then
	stCal.iY -= Integer ( dw_Source.Describe ( sCol + ".Height" ) ) + iCalendrierHauteur + 48
End If

stCal.wParent	= Parent
stCal.dwTrt		= dw_Source
stCal.sCol		= sCol
stCal.iChoix	= 1

OpenWithParm ( w_Calendrier, stCal )

dw_Source.SetColumn ( sCol )
end subroutine

event constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Ajout
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 26/12/1996 14:56:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Initialisation des variables d'instances                         */
/* 	Par d$$HEX1$$e900$$ENDHEX$$faut le titre est positionn$$HEX1$$e900$$ENDHEX$$e                           */
/*------------------------------------------------------------------*/

ibTitre			= True									// Y a t-il un titre ?
ibEffet3D		= True									// Y a t-il un effet 3D sur les bords ?
ibHorizontal	= False									// L'objet se pr$$HEX1$$e900$$ENDHEX$$sente t-il horizontalement ou verticalement ?
ibConsult		= False									// L'objet fonctionne t-il en mode consultation ?
ibSupprime		= True									// Autorisation de la suppression d'une ligne au sein de dw_Source
isTaille			= ""										// L'objet doit il $$HEX1$$ea00$$ENDHEX$$tre construit en 800*600 ou 1280*1024 ?
ibIndicateur	= False
ibSourceSelMul	= True									// S$$HEX1$$e900$$ENDHEX$$lection multiple autoris$$HEX2$$e9002000$$ENDHEX$$sur dw_source
isIndicateur	= "K:\PB4OBJ\BMP\FOCUS_1.BMP"	
iiDifference	= 0										// Difference de largeur entre les DW Source et Cible


This.PostEvent ( "ue_Dimensionner" )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on u_ajout.create
this.p_indicateur=create p_indicateur
this.pb_enlever_tout=create pb_enlever_tout
this.pb_enlever_1=create pb_enlever_1
this.pb_ajouter_tout=create pb_ajouter_tout
this.pb_ajouter_1=create pb_ajouter_1
this.dw_cible=create dw_cible
this.st_titre=create st_titre
this.dw_recherche=create dw_recherche
this.dw_source=create dw_source
this.r_bord=create r_bord
this.ln_gauche=create ln_gauche
this.ln_bas=create ln_bas
this.Control[]={this.p_indicateur,&
this.pb_enlever_tout,&
this.pb_enlever_1,&
this.pb_ajouter_tout,&
this.pb_ajouter_1,&
this.dw_cible,&
this.st_titre,&
this.dw_recherche,&
this.dw_source,&
this.r_bord,&
this.ln_gauche,&
this.ln_bas}
end on

on u_ajout.destroy
destroy(this.p_indicateur)
destroy(this.pb_enlever_tout)
destroy(this.pb_enlever_1)
destroy(this.pb_ajouter_tout)
destroy(this.pb_ajouter_1)
destroy(this.dw_cible)
destroy(this.st_titre)
destroy(this.dw_recherche)
destroy(this.dw_source)
destroy(this.r_bord)
destroy(this.ln_gauche)
destroy(this.ln_bas)
end on

type p_indicateur from picture within u_ajout
boolean visible = false
integer x = 635
integer y = 1032
integer width = 91
integer height = 76
boolean focusrectangle = false
end type

type pb_enlever_tout from picturebutton within u_ajout
boolean visible = false
integer x = 41
integer y = 908
integer width = 233
integer height = 136
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_Enlever_Tout
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 08/01/97 22:27:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Recopie de toutes les lignes
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//If	ibConsult Then Return
If	ibConsult Then Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

Uf_Copier ( dw_Source, dw_Cible, 2 )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type pb_enlever_1 from picturebutton within u_ajout
boolean visible = false
integer x = 41
integer y = 740
integer width = 233
integer height = 136
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_enlever_1
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 08/01/97 22:27:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Recopie des lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//If	ibConsult Then Return
If	ibConsult Then Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

Uf_Copier ( dw_Source, dw_Cible, 1 )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type pb_ajouter_tout from picturebutton within u_ajout
boolean visible = false
integer x = 41
integer y = 552
integer width = 233
integer height = 136
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_Ajouter_Tout
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 08/01/97 22:26:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Recopie de toutes les lignes
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//If	ibConsult Then Return
If	ibConsult Then Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

Uf_Copier ( dw_Cible, dw_Source, 2 )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type pb_ajouter_1 from picturebutton within u_ajout
boolean visible = false
integer x = 41
integer y = 392
integer width = 233
integer height = 136
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
end type

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_Ajouter_1
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 08/01/97 22:26:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Recopie des lignes s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX1$$e900$$ENDHEX$$es
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//If	ibConsult Then Return
If	ibConsult Then Return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

Uf_Copier ( dw_Cible, dw_Source, 1 )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type dw_cible from datawindow within u_ajout
boolean visible = false
integer x = 891
integer y = 396
integer width = 503
integer height = 360
integer taborder = 20
boolean vscrollbar = true
boolean livescroll = true
end type

event rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet 			: u_datawindow
//* Evenement 		: rButtonDown
//* Auteur			: DBI
//* Date				: 02/12/1996 15:29:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: D$$HEX1$$e900$$ENDHEX$$clenchement de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement sur l'objet parent
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.TriggerEvent ( "Ue_DwCible_rButtonDown" )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Cible
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 26/12/1996 21:14:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


Uf_Selectionner ( This, ilShiftLigCible )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Cible
//* Evenement 		: RowFocusChanged
//* Auteur			: Erick John Stark
//* Date				: 09/01/97 21:40:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lLigne

//Migration PB8-WYNIWYG-03/2006 FM
//lLigne = This.GetRow ()
lLigne = CurrentRow
//Fin Migration PB8-WYNIWYG-03/2006 FM

If	lLigne > 0 And Not ibCibleClick And Not ibCopier Then

	This.SelectRow ( 0, False )
	This.SelectRow ( lLigne, True )

End If

ibCibleClick = False

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event getfocus;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Cible
//* Evenement 		: GetFocus
//* Auteur			: Erick John Stark
//* Date				: 10/01/1997 10:39:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: on d$$HEX1$$e900$$ENDHEX$$selectionne les lignes de l'autre DW
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

dw_Source.SelectRow ( 0, False )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type st_titre from statictext within u_ajout
boolean visible = false
integer x = 18
integer y = 16
integer width = 293
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Titre"
alignment alignment = center!
boolean border = true
long bordercolor = 16777215
boolean focusrectangle = false
end type

type dw_recherche from datawindow within u_ajout
boolean visible = false
integer x = 878
integer y = 804
integer width = 503
integer height = 360
boolean enabled = false
boolean livescroll = true
end type

type dw_source from datawindow within u_ajout
event ue_dropdown pbm_dwndropdown
boolean visible = false
integer x = 887
integer y = 16
integer width = 503
integer height = 360
integer taborder = 10
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_dropdown;//*-----------------------------------------------------------------
//*
//* Objet 			: u_datawindow
//* Evenement 		: ue_DropDown
//* Auteur			: Erick John Stark
//* Date				: 02/12/1996 15:29:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Appel de la construction d'un calendrier
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

/*------------------------------------------------------------------*/
/* Si la colonne est de type DATE, on affiche un calendrier         */
/*------------------------------------------------------------------*/

If	This.Describe ( This.GetColumnName () + ".ColType" ) = "date" Then
//	Uf_ddCalendrier ()
//Migration PB8-WYNIWYG-03/2006 FM
//	This.SetActionCode ( 1 )		// Emp$$HEX1$$ea00$$ENDHEX$$che la DDLB d'appara$$HEX1$$ee00$$ENDHEX$$tre
	ll_ret = 1
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

//Migration PB8-WYNIWYG-03/2006 FM
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event doubleclicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Source
//* Evenement 		: DoubleClicked
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 15/01/1997 17:01:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------


illigsourceclick = This.GetClickedRow ()


If illigsourceclick  <> 0	Then

	Parent.TriggerEvent( "ue_dwSource_dClick" )

End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet 			: u_datawindow
//* Evenement 		: rButtonDown
//* Auteur			: DBI
//* Date				: 02/12/1996 15:29:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: D$$HEX1$$e900$$ENDHEX$$clenchement de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement sur l'objet parent
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//Parent.TriggerEvent ( "Ue_DwSource_rButtonDown" )
long	ll_ret

ll_ret = Parent.Event Ue_DwSource_rButtonDown(0, 0)
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Source
//* Evenement 		: ItemChanged
//* Auteur			: Erick John Stark
//* Date				: 26/12/1996 21:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret = 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

If	ibConsult Then 
//Migration PB8-WYNIWYG-03/2006 FM
//	This.SetActionCode ( 2 )
//	Return
	Return 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
End If

//Migration PB8-WYNIWYG-03/2006 FM
//Parent.TriggerEvent( "Ue_dwSource_ItemChanged" )
ll_ret = Parent.Event Ue_dwSource_ItemChanged(0, 0)
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM
end event

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Source
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 26/12/1996 21:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//Parent.TriggerEvent( "Ue_dwSource_ItemError" )
long	ll_ret

ll_ret = Parent.Event Ue_dwSource_ItemError(0, 0)
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Source
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 26/12/1996 21:14:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lLigne

lLigne = This.GetClickedRow ()

/*------------------------------------------------------------------*/
/* Si on utilise un RowFocusIndicateur, pas de s$$HEX1$$e900$$ENDHEX$$lection multiple   */
/* possible. On s'occupe de la ligne courante                       */
/*------------------------------------------------------------------*/

If	ibIndicateur Then Return

/*------------------------------------------------------------------*/
/* Si on ne veut pas de s$$HEX1$$e900$$ENDHEX$$lection multiple, on n'utilise pas la     */
/* fonction Uf_Selectionner ().                                     */
/* Dans ce cas, on d$$HEX1$$e900$$ENDHEX$$selectionne toutes les lignes et on            */
/* s$$HEX1$$e900$$ENDHEX$$lectionne la ligne click$$HEX1$$e900$$ENDHEX$$e                                     */
/*------------------------------------------------------------------*/

If	ibSourceSelMul = False And lLigne > 0 Then
	This.SelectRow ( 0, False )
	This.SelectRow ( lLigne, True )
	Return
End If

/*------------------------------------------------------------------*/
/* Dans tous les autres cas, ( c.a.d pas de RowFocusIndicateur et   */
/* s$$HEX1$$e900$$ENDHEX$$lection multiple autoris$$HEX2$$e9002000$$ENDHEX$$), on appelle la fonction de         */
/* s$$HEX1$$e900$$ENDHEX$$lection.                                                       */
/*------------------------------------------------------------------*/

Uf_Selectionner ( This, ilShiftLigSource )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event rowfocuschanged;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Source
//* Evenement 		: RowFocusChanged
//* Auteur			: Erick John Stark
//* Date				: 09/01/97 21:40:50
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lLigne

//Migration PB8-WYNIWYG-03/2006 FM
//lLigne = This.GetRow ()
lLigne = CurrentRow
//Fin Migration PB8-WYNIWYG-03/2006 FM
illigsourceclick = lLigne

If	ibIndicateur Then Return

If	lLigne > 0 And Not ibSourceClick And Not ibCopier Then

	This.SelectRow ( 0, False )
	This.SelectRow ( lLigne, True )

End If

ibSourceClick = False

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event getfocus;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Source
//* Evenement 		: GetFocus
//* Auteur			: Erick John Stark
//* Date				: 10/01/1997 10:39:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: on d$$HEX1$$e900$$ENDHEX$$selectionne les lignes de l'autre DW
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

dw_Cible.SelectRow ( 0, False )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event updatestart;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Source
//* Evenement 		: UpdateStart
//* Auteur			: Erick John Stark
//* Date				: 26/12/1996 21:14:25
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

//Migration PB8-WYNIWYG-03/2006 FM
//Parent.TriggerEvent ( "Ue_dwSource_UpdateStart" )
long	ll_ret

ll_ret = Parent.Event Ue_dwSource_UpdateStart(0, 0)
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_Source
//* Evenement 		: SqlPreview
//* Auteur			: Erick John Stark
//* Date				: 26/12/1996 21:10:01
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

dwbuffer dwBuf
//Migration PB8-WYNIWYG-03/2006 FM
//This.GetUpdateStatus ( ilLigSource, dwBuf )
ilLigSource = row
dwBuf = buffer
//isSqlPrev = This.GetSqlPreview()
isSqlPrev = sqlSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//Parent.TriggerEvent( "Ue_dwSource_SqlPreview" )
long	ll_ret
ll_ret = Parent.event Ue_dwSource_SqlPreview(request, sqltype, sqlsyntax, buffer, row)
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event buttonclicked;// JCA - DCMP 060825 Optimisation Produit
return parent.event ue_dwsource_buttonclicked ( row, actionreturncode, dwo )
end event

type r_bord from rectangle within u_ajout
boolean visible = false
long linecolor = 16777215
integer linethickness = 9
long fillcolor = 12632256
integer width = 855
integer height = 332
end type

type ln_gauche from line within u_ajout
boolean visible = false
long linecolor = 8421504
integer linethickness = 9
integer beginx = 526
integer beginy = 608
integer endx = 526
integer endy = 1048
end type

type ln_bas from line within u_ajout
boolean visible = false
long linecolor = 8421504
integer linethickness = 9
integer beginx = 466
integer beginy = 544
integer endx = 709
integer endy = 544
end type

