HA$PBExportHeader$u_calendrier.sru
$PBExportComments$----} UserObjet Calendrier utilis$$HEX2$$e9002000$$ENDHEX$$dans les DW
forward
global type u_calendrier from userobject
end type
type pb_mois_suiv from picturebutton within u_calendrier
end type
type pb_an_suiv from picturebutton within u_calendrier
end type
type pb_mois_prec from picturebutton within u_calendrier
end type
type pb_an_prec from picturebutton within u_calendrier
end type
type dw_cal from datawindow within u_calendrier
end type
end forward

global type u_calendrier from userobject
integer width = 741
integer height = 708
boolean border = true
long backcolor = 12632256
event ue_fermer pbm_custom75
pb_mois_suiv pb_mois_suiv
pb_an_suiv pb_an_suiv
pb_mois_prec pb_mois_prec
pb_an_prec pb_an_prec
dw_cal dw_cal
end type
global u_calendrier u_calendrier

type variables
Private :
	
	Integer		iiJour,	& 
			iiMois,	&
			iiAn,	&
			iiCol

	Date		idFerie[11]
		
	N_Cst_DateTime	invDateTime
		
Protected :
	Date		idEnCours
end variables

forward prototypes
public function long uf_initcalendrier (date addte)
private subroutine uf_afficherchiffre (integer aijour1, integer aifinmois)
protected function string uf_afficherdate (integer aitypeaffichage, date addte)
private subroutine uf_affichermois (integer aian, integer aimois)
private subroutine uf_debutaffichage ()
private function integer uf_nbrjourmois (integer aian, integer aimois)
private subroutine uf_setferie (integer aiannee)
end prototypes

public function long uf_initcalendrier (date addte);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_InitCalendrier ( Public )
//* Auteur			: Erick John Stark
//* Date				: 20/11/1996 09:47:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation du calendrier
//*
//* Arguments		: Date			adDte			(Val)	Date Initialisation
//*
//* Retourne		: Long			 1 = Ok
//*										-1 = Probl$$HEX1$$e900$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

Long lRet

/*------------------------------------------------------------------*/
/* Insertion d'une ligne                                            */
/*------------------------------------------------------------------*/
dw_Cal.InsertRow ( 0 )

/*------------------------------------------------------------------*/
/* Le 05/07/2002.                                                   */
/* Positionnement des jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s.                                 */
/*------------------------------------------------------------------*/
This.uf_SetFerie ( Year ( adDte ) )

iiAn		= Year ( adDte )
iiMois	= Month ( adDte )
iiJour	= Day ( adDte )

Uf_DebutAffichage ()

dw_Cal.SetFocus ()

Return ( lRet )


end function

private subroutine uf_afficherchiffre (integer aijour1, integer aifinmois);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_AfficherChiffre ( Private )
//* Auteur			: Erick John Stark
//* Date				: 20/11/1996 14:38:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Integer		aiJour1			(Val)	Premier jour du mois
//*					  Integer		aiFinMois		(Val)
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer iCpt, iNumJour, iTotJourFerie, iJourFerie
String sText

/*------------------------------------------------------------------*/
/* Mettre les colonnes avant le 1er jour du mois $$HEX2$$e0002000$$ENDHEX$$blanc            */
/*------------------------------------------------------------------*/

For	iCpt = 1 To aiJour1
		dw_Cal.SetItem ( 1, iCpt, "" )
Next

/*------------------------------------------------------------------*/
/* Initialiser les colonnes avec les chiffres du mois               */
/*------------------------------------------------------------------*/

For 	iCpt = 1 To aiFinMois
		iNumJour = aiJour1 + iCpt - 1
		dw_Cal.SetItem ( 1, iNumJour, String ( iCpt ) )
Next

iNumJour ++

/*------------------------------------------------------------------*/
/* Mettre les colonnes apr$$HEX1$$e900$$ENDHEX$$s le dernier jour du mois $$HEX2$$e0002000$$ENDHEX$$blanc        */
/*------------------------------------------------------------------*/

For	iCpt = iNumJour To 42
		dw_Cal.SetItem ( 1, iCpt, "" )
Next

/*------------------------------------------------------------------*/
/* Mettre le jour s$$HEX1$$e900$$ENDHEX$$lectionn$$HEX2$$e9002000$$ENDHEX$$en inverse                            */
/*------------------------------------------------------------------*/

If	iiCol <> 0 Then
	sText = "#" + String ( iiCol ) + ".border=0"
	dw_Cal.Modify ( sText )
End If

/*------------------------------------------------------------------*/
/* Le 05/07/2002.                                                   */
/* Modification pour gestion des jours F$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s                       */
/*------------------------------------------------------------------*/
/*------------------------------------------------------------------*/
/* On positionne toutes les cellules avec la couleur par d$$HEX1$$e900$$ENDHEX$$faut.    */
/* Sauf les cellules pour Samedi et Dimanche.                       */
/*------------------------------------------------------------------*/
sText = ""
For	iCpt = 1 To 42
		Choose Case iCpt
		Case 6,7,13,14,20,21,27,28,34,35,41,42
				sText = sText + "J" + String ( iCpt, "00" ) + ".Color='255' "
		Case Else
				sText = sText + "J" + String ( iCpt, "00" ) + ".Color='0' "
		End Choose
Next
dw_Cal.Modify ( sText )

/*------------------------------------------------------------------*/
/* On positionne maintenant les jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s en rouge.              */
/*------------------------------------------------------------------*/
iTotJourFerie = UpperBound ( idFerie )
sText = ""
For	iCpt = 1 To iTotJourFerie
		If	Year ( idFerie[ iCpt ] ) = iiAn And Month ( idFerie[ iCpt ] ) = iiMois	Then
			iJourFerie	= Day ( idFerie[ iCpt ] )
			iJourFerie	= iJourFerie + aiJour1 - 1
			sText			= sText + "J" + String ( iJourFerie, "00" ) + ".Color = '255' "
		End If
Next
dw_Cal.Modify ( sText )

iiCol = 0


end subroutine

protected function string uf_afficherdate (integer aitypeaffichage, date addte);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_AfficherDate ( Protected )
//* Auteur			: Erick John Stark
//* Date				: 20/11/1996 14:38:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affiche la date selon le format specifi$$HEX1$$e900$$ENDHEX$$
//*
//* Arguments		: Integer		aiTypeAffichage		(Val) Type affichage
//						  Date			adDte						(Val)	Date $$HEX2$$e0002000$$ENDHEX$$formater
//*
//* Retourne		: String			La cha$$HEX1$$ee00$$ENDHEX$$ne format$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------

String sRet

Choose Case aiTypeAffichage
Case 1		// Format JJ/MM/YYYY
	sRet = String ( adDte, "DD/MM/YYYY" )

Case 2		// Affichage en toutes lettres
	sRet = F_Txt_Jour ( DayNumber ( adDte ) ) + " " + String ( Day ( adDte ), "00" ) + " " + &
			 F_Txt_Mois ( Month ( adDte ) ) + " " + String ( Year ( adDte ) )

End Choose

Return ( sRet )
	


end function

private subroutine uf_affichermois (integer aian, integer aimois);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_AfficherMois ( Private )
//* Auteur			: Erick John Stark
//* Date				: 20/11/1996 14:38:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: Integer		aiAN				(Val)	Ann$$HEX1$$e900$$ENDHEX$$e
//*					  Integer		aiMois			(Val) Mois
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

iiMois 	= aiMois
iiAn		= aiAn

/*------------------------------------------------------------------*/
/* On d$$HEX1$$e900$$ENDHEX$$cr$$HEX1$$e900$$ENDHEX$$mente tant que le dernier jour du mois n'est pas valide  */
/*------------------------------------------------------------------*/

Do While Date ( iiAn, iiMois, iiJour ) = Date ( 1900, 1, 1 )
	iiJour --
Loop

Uf_DebutAffichage ()


end subroutine

private subroutine uf_debutaffichage ();//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_DebutAffichage ( Private )
//* Auteur			: Erick John Stark
//* Date				: 20/11/1996 09:47:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation
//*
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Integer iNbrJourMois, iJour1, iCellule
Date dJour1
String sText

SetPointer ( HourGlass! )
dw_Cal.SetRedraw ( False )

sText = ""

/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$termination du nombre de jours dans le mois                    */
/*------------------------------------------------------------------*/

iNbrJourMois = Uf_NbrJourMois ( iiAn, iiMois )

/*------------------------------------------------------------------*/
/* D$$HEX1$$e900$$ENDHEX$$termination du premier jour du mois                            */
/*------------------------------------------------------------------*/

dJour1 = Date ( iiAn, iiMois, 1 )
iJour1 = DayNumber ( dJour1 )

/*------------------------------------------------------------------*/
/* Passage du Dimanche au Lundi                                     */
/*                                                                  */
/* Lu -> 2 ( 01-08-15-22-29-36 )                                    */
/* Ma -> 3 ( 02-09-16-23-30-37 )                                    */
/* Me -> 4 ( 03-10-17-24-31-38 )                                    */
/* Je -> 5 ( 04-11-18-25-32-39 )                                    */
/* Ve -> 6 ( 05-12-19-26-33-40 )                                    */
/* Sa -> 7 ( 06-13-20-27-34-41 )                                    */
/* Di -> 1 ( 07-14-21-28-35-42 )                                    */
/*------------------------------------------------------------------*/

If iJour1 = 1 Then
	iJour1 = 7
Else
	iJour1 --
End If

/*------------------------------------------------------------------*/
/* La premi$$HEX1$$e800$$ENDHEX$$re cellule du calendrier est donc                       */
/*------------------------------------------------------------------*/

iCellule = iJour1 + iiJour - 1

/*------------------------------------------------------------------*/
/* Positionnement du titre (Mois + Ann$$HEX1$$e900$$ENDHEX$$e)                           */
/*------------------------------------------------------------------*/

sText = F_Txt_Mois ( iiMois )
dw_Cal.Modify ( "st_mois.Text = ~"" + sText + "~"" )
dw_Cal.Modify ( "st_annee.Text = ~"" + String ( iiAn ) + "~"" )

/*------------------------------------------------------------------*/
/* Affichage des chiffres                                           */
/*------------------------------------------------------------------*/

Uf_AfficherChiffre ( iJour1, iNbrJourMois )

dw_Cal.SetItem ( 1, iCellule, String ( iiJour ) )

/*------------------------------------------------------------------*/
/* Positionnement de la bordure                                     */
/*------------------------------------------------------------------*/

sText = ""

If	iiCol <> 0 Then
	sText = "#" + String ( iiCol ) + ".border=0 "
End If

sText = sText + "#" + String ( iCellule ) + ".border=5"
dw_Cal.Modify ( sText )

iiCol = iCellule

SetPointer ( Arrow! )
dw_Cal.SetRedraw ( True )




end subroutine

private function integer uf_nbrjourmois (integer aian, integer aimois);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_NbrJourMois ( Private )
//* Auteur			: Erick John Stark
//* Date				: 20/11/1996 11:23:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Donne le nombre de jour dans un mois
//*
//* Arguments		: Integer		aiAn					(Val)	Ann$$HEX1$$e900$$ENDHEX$$e
//*                 Integer		aiMois				(Val) Mois
//*
//* Retourne		: Integer		 ? = Nbr de jours
//*
//*-----------------------------------------------------------------

n_cst_datetime lnvDatetime
Integer iNbrJour

lnvDatetime = Create n_cst_datetime

Choose Case aiMois
Case 1, 3, 5, 7, 8, 10, 12
	iNbrJour = 31
Case 4, 6, 9, 11
	iNbrJour = 30
Case 2
	If	lnvDatetime.Uf_IsLeap ( aiAn ) Then
		iNbrJour = 29
	Else
		iNbrJour = 28
	End If
End Choose

Destroy lnvDatetime

Return ( iNbrJour )
end function

private subroutine uf_setferie (integer aiannee);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Calendrier::Uf_SetFerie			(PRIVATE)
//* Auteur			: Erick John Stark
//* Date				: 04/07/2002 17:33:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation des jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s de l'ann$$HEX1$$e900$$ENDHEX$$e courante
//*
//* Arguments		: (Val)		Integer		aiAnnee		Ann$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$traiter
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------	

/*------------------------------------------------------------------*/
/* Si l'ann$$HEX1$$e900$$ENDHEX$$e que l'on d$$HEX1$$e900$$ENDHEX$$sire traiter correspond $$HEX2$$e0002000$$ENDHEX$$l'ann$$HEX1$$e900$$ENDHEX$$e          */
/* courante, on ne fait rien.                                       */
/*------------------------------------------------------------------*/
If	iiAn = 0 Or aiAnnee <> iiAn	Then

	idFerie[1]	= Date ( aiAnnee, 01, 01 )								// Jour de l'An
	idFerie[2]	= Date ( aiAnnee, 05, 01 )								// F$$HEX1$$ea00$$ENDHEX$$te du Travail
	idFerie[3]	= Date ( aiAnnee, 05, 08 )								// Victoire 1945
	idFerie[4]	= Date ( aiAnnee, 07, 14 )								// F$$HEX1$$ea00$$ENDHEX$$te Nationale
	idFerie[5]	= Date ( aiAnnee, 08, 15 )								// Assomption
	idFerie[6]	= Date ( aiAnnee, 11, 01 )								// Toussaint
	idFerie[7]	= Date ( aiAnnee, 11, 11 )								// Armistice 1918
	idFerie[8]	= Date ( aiAnnee, 12, 25 )								// No$$HEX1$$eb00$$ENDHEX$$l
	idFerie[9]	= invDateTime.uf_GetPaques ( aiAnnee )				// Lundi de P$$HEX1$$e200$$ENDHEX$$ques
	idFerie[10]	= invDateTime.uf_GetAscension ( idFerie[9] )		// Ascension
	idFerie[11]	= invDateTime.uf_GetPentecote ( idFerie[9] )		// Lundi de Pentec$$HEX1$$f400$$ENDHEX$$te

End If
end subroutine

on constructor;//*-----------------------------------------------------------------
//*
//* Objet			: U_Calendrier::Constructor			(EXTEND)
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 04/07/2002 17:33:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

invDateTime	= CREATE N_CSt_DateTime
end on

on destructor;//*-----------------------------------------------------------------
//*
//* Objet			: U_Calendrier::Destructor		(EXTEND)
//* Evenement 		: Destructor
//* Auteur			: Erick John Stark
//* Date				: 04/07/2002 17:33:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: Aucun
//*
//* Retourne		: Rien
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

If	IsValid ( invDateTime )	Then DESTROY invDateTime
end on

on u_calendrier.create
this.pb_mois_suiv=create pb_mois_suiv
this.pb_an_suiv=create pb_an_suiv
this.pb_mois_prec=create pb_mois_prec
this.pb_an_prec=create pb_an_prec
this.dw_cal=create dw_cal
this.Control[]={this.pb_mois_suiv,&
this.pb_an_suiv,&
this.pb_mois_prec,&
this.pb_an_prec,&
this.dw_cal}
end on

on u_calendrier.destroy
destroy(this.pb_mois_suiv)
destroy(this.pb_an_suiv)
destroy(this.pb_mois_prec)
destroy(this.pb_an_prec)
destroy(this.dw_cal)
end on

type pb_mois_suiv from picturebutton within u_calendrier
integer x = 622
integer y = 100
integer width = 101
integer height = 84
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\suiv.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_Mois_Suiv
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 20/11/1996 16:34:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affichage du mois suivant
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sDte
Integer iAnTemp

iiMois ++

If	iiMois = 13 Then
/*------------------------------------------------------------------*/
/* Le 05/07/2002.                                                   */
/*------------------------------------------------------------------*/
/* On recalcule les jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s avant d'incr$$HEX1$$e900$$ENDHEX$$menter la variable    */
/* iiAn.                                                            */
/*------------------------------------------------------------------*/
	iAnTemp = iiAn
	iAnTemp ++
	Uf_SetFerie ( iAnTemp )

	iiMois = 1
	iiAn ++
End If

sDte = String ( iiJour ) + "/" + String ( iiMois ) + "/" + String ( iiAn )

If	Not IsDate ( sDte ) Then iiJour = 1

Uf_AfficherMois ( iiAn , iiMois )

idEnCours = Date ( iiAn, iiMois, iiJour )


end on

type pb_an_suiv from picturebutton within u_calendrier
integer x = 622
integer y = 12
integer width = 101
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\suiv.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_An_Suiv
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 20/11/1996 16:34:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affichage de l'ann$$HEX1$$e900$$ENDHEX$$e suivante
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sDte
Integer iAnTemp

/*------------------------------------------------------------------*/
/* Le 05/07/2002.                                                   */
/*------------------------------------------------------------------*/
/* On recalcule les jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s avant d'incr$$HEX1$$e900$$ENDHEX$$menter la variable    */
/* iiAn.                                                            */
/*------------------------------------------------------------------*/
iAnTemp = iiAn
iAnTemp ++
Uf_SetFerie ( iAnTemp )

iiAn ++

sDte = String ( iiJour ) + "/" + String ( iiMois ) + "/" + String ( iiAn )

If	Not IsDate ( sDte ) Then iiJour = 1

Uf_AfficherMois ( iiAn , iiMois )

idEnCours = Date ( iiAn, iiMois, iiJour )



end on

type pb_mois_prec from picturebutton within u_calendrier
integer x = 9
integer y = 100
integer width = 101
integer height = 84
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\prec.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_Mois_Prec
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 20/11/1996 16:34:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affichage du mois precedent
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sDte
Integer iAnTemp

iiMois --

If	iiMois = 0 Then
/*------------------------------------------------------------------*/
/* Le 05/07/2002.                                                   */
/*------------------------------------------------------------------*/
/* On recalcule les jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s avant de d$$HEX1$$e900$$ENDHEX$$crementer la variable   */
/* iiAn.                                                            */
/*------------------------------------------------------------------*/
	iAnTemp = iiAn
	iAnTemp --
	Uf_SetFerie ( iAnTemp )

	iiMois = 12
	iiAn --
End If

sDte = String ( iiJour ) + "/" + String ( iiMois ) + "/" + String ( iiAn )

If	Not IsDate ( sDte ) Then iiJour = 1

Uf_AfficherMois ( iiAn , iiMois )

idEnCours = Date ( iiAn, iiMois, iiJour )



end on

type pb_an_prec from picturebutton within u_calendrier
integer x = 9
integer y = 12
integer width = 101
integer height = 84
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "k:\pb4obj\bmp\prec.bmp"
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: pb_An_Prec
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 20/11/1996 16:34:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affichage de l'ann$$HEX1$$e900$$ENDHEX$$e pr$$HEX1$$e900$$ENDHEX$$cedente
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

String sDte
Integer iAnTemp

/*------------------------------------------------------------------*/
/* Le 05/07/2002.                                                   */
/*------------------------------------------------------------------*/
/* On recalcule les jours f$$HEX1$$e900$$ENDHEX$$ri$$HEX1$$e900$$ENDHEX$$s avant de d$$HEX1$$e900$$ENDHEX$$crementer la variable   */
/* iiAn.                                                            */
/*------------------------------------------------------------------*/
iAnTemp = iiAn
iAnTemp --
Uf_SetFerie ( iAnTemp )

iiAn --

sDte = String ( iiJour ) + "/" + String ( iiMois ) + "/" + String ( iiAn )

If	Not IsDate ( sDte ) Then iiJour = 1

Uf_AfficherMois ( iiAn , iiMois )

idEnCours = Date ( iiAn, iiMois, iiJour )



end on

type dw_cal from datawindow within u_calendrier
integer width = 731
integer height = 696
string dataobject = "d_calendrier"
boolean border = false
boolean livescroll = true
end type

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: dw_cal
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 21/11/1996 10:11:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affichage du jour selectionn$$HEX1$$e900$$ENDHEX$$
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Long lCol
String sText, sJour

lCol = dw_Cal.GetClickedColumn ()
If	lCol = 0 Then Return

sJour = dw_Cal.GetItemString ( 1, lCol )
If	sJour = "" Then Return

iiJour = Integer ( sJour )

dw_Cal.SetItem ( 1, lCol, sJour )

sText = ""

If	iiCol <> 0 Then
	sText = "#" + String ( iiCol ) + ".border=0 "
End If

sText = sText + "#" + String ( lCol ) + ".border=5"
dw_Cal.Modify ( sText )

iiCol = lCol

idEnCours = Date ( iiAn, iiMois, iiJour )

/*------------------------------------------------------------------*/
/* On ferme la calculatrice                                         */
/*------------------------------------------------------------------*/

Parent.PostEvent ( "Ue_Fermer" )


end on

