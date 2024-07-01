HA$PBExportHeader$u_euro.sru
$PBExportComments$----} UserObjet Euro utilis$$HEX2$$e9002000$$ENDHEX$$dans les DW
forward
global type u_euro from userobject
end type
type dw_euro from datawindow within u_euro
end type
end forward

global type u_euro from userobject
integer width = 855
integer height = 164
boolean border = true
long backcolor = 12632256
event ue_fermer pbm_custom75
event ue_demande_quit ( )
event ue_demande_valide ( )
dw_euro dw_euro
end type
global u_euro u_euro

type variables
Private :
	Decimal{5}	idcTxEuro = 6.55957

	Decimal{2}	idcMtInitial
	Decimal{2}	idcMtConversion

	Boolean		ibModif

	String		isFormatDesire

end variables

forward prototypes
public function decimal uf_euro2franc ()
public subroutine uf_initsaisirmontant (decimal adcmontant)
end prototypes

public function decimal uf_euro2franc ();//*-----------------------------------------------------------------
//*
//* Fonction		: U_Euro::Uf_Euro2Franc ( Protected )
//* Auteur			: Erick John Stark
//* Date				: 20/11/1996 09:47:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On va calculer le montant en Francs de la zone en EURO
//*
//* Arguments		: Aucun
//*
//* Retourne		: Decimal	Montant en FRANCS
//*
//*-----------------------------------------------------------------

Decimal {2} dcMtInitial, dcMtRetour

/*------------------------------------------------------------------*/
/* Si le gestionnaire vient r$$HEX1$$e900$$ENDHEX$$ellement de saisir quelque chose, on  */
/* proc$$HEX1$$e900$$ENDHEX$$de $$HEX2$$e0002000$$ENDHEX$$la conversion.                                         */
/*------------------------------------------------------------------*/
If	ibModif Then
	If	isFormatDesire = "F"	Then
		dcMtInitial	= dw_Euro.GetItemNumber ( 1, "MT_EURO" )
		dcMtRetour 	= dcMtInitial * idcTxEuro
	Else
		dcMtInitial	= dw_Euro.GetItemNumber ( 1, "MT_FRANC" )
		dcMtRetour 	= dcMtInitial / idcTxEuro
	End If
Else
	dcMtRetour = idcMtInitial
End If

Return ( dcMtRetour )



end function

public subroutine uf_initsaisirmontant (decimal adcmontant);//*-----------------------------------------------------------------
//*
//* Fonction		: U_Euro::Uf_InitSaisirMontant ( Public )
//* Auteur			: Erick John Stark
//* Date				: 20/11/1996 09:47:47
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Initialisation du UserObjet pour la saisie du Montant
//*
//* Arguments		: Decimal		adcMontant	(Val)	Montant Initial provenant de la DW
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------

Decimal {2} dcMtConversion
String	sColonne, sModif

/*------------------------------------------------------------------*/
/* Insertion d'une ligne                                            */
/*------------------------------------------------------------------*/
dw_Euro.InsertRow ( 0 )

idcMtInitial		= adcMontant

/*------------------------------------------------------------------*/
/* On calcule le montant de la zone $$HEX2$$e0002000$$ENDHEX$$convertir en fonction du      */
/* format d$$HEX1$$e900$$ENDHEX$$sir$$HEX1$$e900$$ENDHEX$$. Si le montant est NULL, on initialise ce montant  */
/* $$HEX2$$e0002000$$ENDHEX$$0.00                                                           */
/*------------------------------------------------------------------*/
If	IsNull ( idcMtInitial ) Then idcMtInitial = 0.00

If	isFormatDesire = "F"	Then
/*------------------------------------------------------------------*/
/* La base de donn$$HEX1$$e900$$ENDHEX$$e est en FRANCS. On convertit le montant en      */
/* EUROS.                                                           */
/*------------------------------------------------------------------*/
	dcMtConversion = idcMtInitial / idcTxEuro

	dw_Euro.SetItem ( 1, "MT_FRANC", idcMtInitial )
	dw_Euro.SetItem ( 1, "MT_EURO", dcMtConversion )
	sColonne			= "MT_EURO"

	sModif = "MT_FRANC.Protect = 1 MT_EURO.Border= '5' MT_EURO.BackGround.Color='16777215'"
	dw_Euro.Modify ( sModif )
Else
	dcMtConversion = idcMtInitial * idcTxEuro

	dw_Euro.SetItem ( 1, "MT_FRANC", dcMtConversion )
	dw_Euro.SetItem ( 1, "MT_EURO", idcMtInitial )
	sColonne			= "MT_FRANC"

	sModif = "MT_EURO.Protect = 1 MT_FRANC.Border= '5' MT_FRANC.BackGround.Color='16777215'"
	dw_Euro.Modify ( sModif )
End If

idcMtConversion = dcMtConversion

/*------------------------------------------------------------------*/
/* Il est important de faire un SetColumn, sinon la zone n'est pas  */
/* en AutoS$$HEX1$$e900$$ENDHEX$$lection.                                                */
/*------------------------------------------------------------------*/
dw_Euro.SetFocus ()
dw_Euro.SetColumn ( sColonne )

end subroutine

event constructor;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Euro
//* Evenement 		: Constructor
//* Auteur			: Erick John Stark
//* Date				: 23/04/2001 14:47:00
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: On initialise si l'on est dans un contexte (Franc->Euro ou Euro->Franc)
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//* #1	PHG	15/02/2008 [SUISSE].LOT3 : Harmonisatino de la lecture
//*                                       du.INI pour la monnaie
//*-----------------------------------------------------------------

// #1 [SUISSE].LOT3 
//isFormatDesire = ProfileString ( stGLB.sFichierIni, "EURO", "Format_Desire", "F" )
isFormatDesire = stGlb.smonnaieformatdesire
//
end event

on u_euro.create
this.dw_euro=create dw_euro
this.Control[]={this.dw_euro}
end on

on u_euro.destroy
destroy(this.dw_euro)
end on

type dw_euro from datawindow within u_euro
event ue_char pbm_dwnkey
integer width = 846
integer height = 156
integer taborder = 1
string dataobject = "d_euro"
boolean border = false
boolean livescroll = true
end type

event ue_char;//Migration PB8-WYNIWYG-03/2006 FM
//code cr$$HEX3$$e900e9002000$$ENDHEX$$lors de la migration pour g$$HEX1$$e900$$ENDHEX$$rer les touches tabulation et escape
//sur le convertisseur francs/euros

Choose Case Key
		
	Case KeyEscape!
		parent.event ue_demande_quit()

	Case KeyTab!
		this.AcceptText()
		parent.event ue_demande_valide()

End Choose

//Fin Migration PB8-WYNIWYG-03/2006 FM



end event

event editchanged;
//*-----------------------------------------------------------------
//*
//* Objet 			: U_Euro::Dw_euro::EditChanged
//* Evenement 		: EditChanged
//* Auteur			: Erick John Stark
//* Date				: 04/10/1998 18:46:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* On vient de saisir quelque chose. On part du principe que la     */
/* conversion sera faite. (Si la valeur saisie est de type          */
/* num$$HEX1$$e900$$ENDHEX$$rique).                                                      */
/*------------------------------------------------------------------*/

ibModif = True
end event

event itemerror;//*-----------------------------------------------------------------
//*
//* Objet 			: U_Euro::dw_Euro::ItemError
//* Evenement 		: ItemError
//* Auteur			: Erick John Stark
//* Date				: 06/01/1998 09:47:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Gestion des messages d'erreur
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* La personne vient de taper une valeur non num$$HEX1$$e900$$ENDHEX$$rique ou une valeur*/ 
/* nulle. On repositionne la valeur initiale                        */
/*------------------------------------------------------------------*/
ibModif = False
This.SetItem ( This.GetRow (), This.GetColumnName (), idcMtConversion )
//Migration PB8-WYNIWYG-03/2006 FM
//This.SetActionCode ( 3 )
Return 3
//Fin Migration PB8-WYNIWYG-03/2006 FM


end event

