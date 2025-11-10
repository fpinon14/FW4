HA$PBExportHeader$u_tagger.sru
$PBExportComments$----} UserObjet servant au taggage
forward
global type u_tagger from userobject
end type
type st_titre from statictext within u_tagger
end type
type p_indicateur from picture within u_tagger
end type
type dw_source from datawindow within u_tagger
end type
type dw_trt from datawindow within u_tagger
end type
type r_bord from rectangle within u_tagger
end type
type ln_bas from line within u_tagger
end type
type ln_gauche from line within u_tagger
end type
end forward

global type u_tagger from userobject
integer width = 1669
integer height = 876
boolean border = true
long backcolor = 12632256
event ue_dimensionner pbm_custom75
event ue_dwtrt_itemchanged pbm_custom74
event ue_dwtrt_updatestart pbm_custom73
event type long ue_dwtrt_sqlpreview ( sqlpreviewfunction requete,  sqlpreviewtype sql_type,  string sql_syntax,  dwbuffer buffer_dw,  long ligne )
event ue_dwtrt_retrieve pbm_custom71
event ue_dwsource_retrieve pbm_custom70
event ue_dwtrt_rbuttondown pbm_custom69
st_titre st_titre
p_indicateur p_indicateur
dw_source dw_source
dw_trt dw_trt
r_bord r_bord
ln_bas ln_bas
ln_gauche ln_gauche
end type
global u_tagger u_tagger

type variables
Private :
    String            isArg
    Boolean         ibConsult

Protected :
    String            isIndicateur
    String            isSqlPrev

    Boolean         ibIndicateur
    Boolean         ibTitre
    Boolean         ibEffet3D

Public :
    Long             ilLigTrt
    Long             ilLigSource

end variables

forward prototypes
public subroutine uf_dwtrtfocus ()
private subroutine uf_dimensionner ()
public function string uf_dwtrtmodify (string astext)
public subroutine uf_dwtrtstatus ()
public subroutine uf_titre (string astitre)
public function long uf_dwsourceretrieve (string astext, u_tagger auoTagger)
public function long uf_dwtrtretrieve (string astext, u_tagger auoTagger)
public subroutine uf_consulter (boolean abConsult)
public function long uf_initialiser (string asdwtrt, string asdwsource, u_transaction atrtrans)
end prototypes

event ue_dimensionner;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Tagger
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

event ue_dwtrt_retrieve;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Tagger
//* Evenement 		: Ue_dwTrt_Retrieve
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

ilLigTrt = dw_Trt.Retrieve ( isArg )

//Migration PB8-WYNIWYG-03/2006 FM
return ilLigTrt
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event ue_dwsource_retrieve;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Tagger
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

public subroutine uf_dwtrtfocus ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_dwTrtFocus ( Public )
//* Auteur			: Erick John Stark 
//* Date				: 28/12/1996 18:24:28
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Postionnement sur la 1$$HEX1$$e900$$ENDHEX$$re ligne 
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

dw_Trt.SetFocus ()
dw_Trt.ScrollToRow ( 0 )
dw_Trt.SetRow ( 0 )

end subroutine

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

Long lEpais

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
/* Et enfin, on s'occupe de la Data Window de Traitement            */
/*------------------------------------------------------------------*/

If	ibTitre Then
	dw_Trt.Y = ( lEpais * 2 ) + st_Titre.Height
Else
	dw_Trt.Y = lEpais
End If

dw_Trt.X 			= lEpais
dw_Trt.Width		= This.Width - ( lEpais * 2 )
dw_Trt.Height		= This.Height - lEpais - dw_Trt.Y

dw_Trt.Visible		= True
dw_Trt.BringToTop = True

/*------------------------------------------------------------------*/
/* Pour donner un effet 3D, il faut obligatoirement un border au    */
/* User Objet                                                       */
/*------------------------------------------------------------------*/

If	ibEffet3D	Then
	This.Width	= This.Width + 9
	This.Height = This.Height + 9
	This.Border = True
End If

This.SetRedraw ( True )


end subroutine

public function string uf_dwtrtmodify (string astext);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_dwTrtModify ( Public )
//* Auteur			: Erick John Stark 
//* Date				: 28/12/1996 18:39:31
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Modification de la DW
//*
//* Arguments		: String			asText				(Val)	Cha$$HEX1$$ee00$$ENDHEX$$ne de texte
//*
//* Retourne		: Long			"" = OK
//*										?	= Le modify ne marche pase
//*
//*-----------------------------------------------------------------

Return ( dw_Trt.Modify ( asText ) )

end function

public subroutine uf_dwtrtstatus ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_dwTrtStatus ( Public )
//* Auteur			: Erick John Stark 
//* Date				: 26/12/1996 21:16:42
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Modification du status des lignes pour dwTrt
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

ilLigTrt = dw_Trt.RowCount ()

For	lCpt = 1 To ilLigTrt
		dw_Trt.SetItemStatus ( lCpt, 0, Primary!, NewModified! )
Next



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

public function long uf_dwsourceretrieve (string astext, u_tagger auoTagger);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_dwSourceRetrieve ( Public )
//* Auteur			: Erick John Stark 
//* Date				: 26/12/1996 21:32:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String			asText				(Val)	Argument de Recherche
//*					  u_Tagger		auoTagger			(Val) User Objet u_Tagger
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

dw_Trt.Reset ()
dw_Source.Reset ()

TriggerEvent ( auoTagger, "ue_dwSource_Retrieve" )

Return ( ilLigSource )







end function

public function long uf_dwtrtretrieve (string astext, u_tagger auoTagger);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_dwTrtRetrieve ( Public )
//* Auteur			: Erick John Stark 
//* Date				: 26/12/1996 21:32:34
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: String			asText				(Val)	Argument de Recherche
//*					  u_Tagger		auoTagger			(Val) User Objet u_Tagger
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

isArg = asText

TriggerEvent ( auoTagger, "ue_dwTrt_Retrieve" )

Return ( ilLigTrt )
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

public function long uf_initialiser (string asdwtrt, string asdwsource, u_transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Initialiser ( Public )
//* Auteur			: Erick John Stark 
//* Date				: 26/12/1996 16:03:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des Datas Objets
//*
//* Arguments		: String				asDwTrt				(Val)	Data Object de la DW de traitement
//* 					  String				asdwSource			(Val)	Data Object de la DW source
//* 					  u_transaction	atrTrans				(Val)	Objet de transaction
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

dw_Trt.DataObject		= asdwTrt
dw_Source.DataObject	= asdwSource

If	dw_Trt.SetTransObject ( atrTrans ) < 1 Then
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
	p_Indicateur.Height = Long ( dw_Trt.Describe ( "DataWindow.Detail.Height" ) )
	dw_Trt.SetRowFocusIndicator ( p_Indicateur )
End If


Return ( lRet )

end function

event constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: u_Tagger
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
/* 	Par d$$HEX1$$e900$$ENDHEX$$faut on positionne le FocusIndicator                    */
/* 	Par d$$HEX1$$e900$$ENDHEX$$faut l'image est positionn$$HEX1$$e900$$ENDHEX$$e                            */
/* 	Par d$$HEX1$$e900$$ENDHEX$$faut le titre est positionn$$HEX1$$e900$$ENDHEX$$e                           */
/* 	Par d$$HEX1$$e900$$ENDHEX$$faut l'objet fonctionne en mode SAISIE                  */
/*------------------------------------------------------------------*/

ibIndicateur	= True
isIndicateur	= "K:\PB4OBJ\BMP\FOCUS_1.BMP"
ibTitre			= True
ibEffet3D		= True
ibConsult		= False

This.PostEvent ( "ue_Dimensionner" )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

on u_tagger.create
this.st_titre=create st_titre
this.p_indicateur=create p_indicateur
this.dw_source=create dw_source
this.dw_trt=create dw_trt
this.r_bord=create r_bord
this.ln_bas=create ln_bas
this.ln_gauche=create ln_gauche
this.Control[]={this.st_titre,&
this.p_indicateur,&
this.dw_source,&
this.dw_trt,&
this.r_bord,&
this.ln_bas,&
this.ln_gauche}
end on

on u_tagger.destroy
destroy(this.st_titre)
destroy(this.p_indicateur)
destroy(this.dw_source)
destroy(this.dw_trt)
destroy(this.r_bord)
destroy(this.ln_bas)
destroy(this.ln_gauche)
end on

type st_titre from statictext within u_tagger
boolean visible = false
integer x = 215
integer y = 104
integer width = 293
integer height = 68
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Titre"
alignment alignment = center!
boolean border = true
long bordercolor = 16777215
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type p_indicateur from picture within u_tagger
boolean visible = false
integer x = 896
integer y = 524
integer width = 91
integer height = 76
boolean focusrectangle = false
end type

type dw_source from datawindow within u_tagger
boolean visible = false
integer x = 55
integer y = 400
integer width = 494
integer height = 360
boolean enabled = false
boolean livescroll = true
end type

type dw_trt from datawindow within u_tagger
boolean visible = false
integer x = 914
integer y = 36
integer width = 654
integer height = 364
integer taborder = 10
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event itemchanged;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_trt
//* Evenement 		: ItemChanged
//* Auteur			: Erick John Stark 
//* Date				: 26/12/1996 21:13:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ 				PAR	Date			Modification
//* [MIGPB8COR] 	PHG 	02/02/2006 	Correction bug return code
//*-----------------------------------------------------------------

If	ibConsult Then 
//Migration PB8-WYNIWYG-03/2006 FM
//	This.SetActionCode ( 2 )
	Return 2
//Fin Migration PB8-WYNIWYG-03/2006 FM
Else
	// [MIGPB8COR]
	// Parent.TriggerEvent ( "Ue_dwTrt_ItemChanged" )
	// remplac$$HEX2$$e9002000$$ENDHEX$$par
	return Parent.event Ue_dwTrt_ItemChanged(0,0)
End If

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM
end event

event rbuttondown;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_trt
//* Evenement 		: rButtonDown
//* Auteur			: DBI
//* Date				: 27/06/1997
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: On trappe le click droit pour le r$$HEX1$$e900$$ENDHEX$$percuter sur le uo
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.TriggerEvent ( "Ue_dwTrt_rButtonDown" )

//Migration PB8-WYNIWYG-03/2006 FM
return 0
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event sqlpreview;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_trt
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
//Migration PB8-WYNIWYG-03/2006 FM
long	ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

dwbuffer dwBuf
//Migration PB8-WYNIWYG-03/2006 FM
//This.GetUpdateStatus ( ilLigTrt, dwBuf )
ilLigTrt = row
dwBuf = buffer
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//isSqlPrev = This.GetSqlPreview()
isSqlPrev = SQLSyntax
//Fin Migration PB8-WYNIWYG-03/2006 FM

//Migration PB8-WYNIWYG-03/2006 FM
//Parent.TriggerEvent( "Ue_dwTrt_SqlPreview" )
ll_ret = Parent.Event Ue_dwTrt_SqlPreview(request, sqltype, sqlsyntax, buffer, row)
return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

event updatestart;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_trt
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
//Parent.TriggerEvent ( "Ue_dwTrt_UpdateStart" )
long	ll_ret

ll_ret = Parent.Event Ue_dwTrt_UpdateStart(0, 0)
Return ll_ret
//Fin Migration PB8-WYNIWYG-03/2006 FM

end event

type r_bord from rectangle within u_tagger
boolean visible = false
long linecolor = 16777215
integer linethickness = 9
long fillcolor = 12632256
integer y = 4
integer width = 855
integer height = 332
end type

type ln_bas from line within u_tagger
boolean visible = false
long linecolor = 8421504
integer linethickness = 9
integer beginx = 1230
integer beginy = 540
integer endx = 1463
integer endy = 540
end type

type ln_gauche from line within u_tagger
boolean visible = false
long linecolor = 8421504
integer linethickness = 9
integer beginx = 1134
integer beginy = 496
integer endx = 1134
integer endy = 632
end type

