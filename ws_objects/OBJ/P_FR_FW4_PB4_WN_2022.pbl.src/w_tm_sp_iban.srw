HA$PBExportHeader$w_tm_sp_iban.srw
$PBExportComments$[PM64]
forward
global type w_tm_sp_iban from w_message_reponse
end type
type cb_eff from commandbutton within w_tm_sp_iban
end type
end forward

global type w_tm_sp_iban from w_message_reponse
integer width = 1641
integer height = 460
string title = "Saisie d~'IBAN"
long backcolor = 12632256
cb_eff cb_eff
end type
global w_tm_sp_iban w_tm_sp_iban

forward prototypes
public subroutine wf_set_rib ()
public function string wf_getcleiban (string asrib)
public function boolean wf_check_iban (string asiban)
end prototypes

public subroutine wf_set_rib ();//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_IBan::wf_set_rib (PRIVATE)
//* Auteur			: FPI
//* Date				: 22/02/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Renseigne les zones de RIB
//*
//* Arguments		:
//*
//* Retourne		: 
//*
//*-----------------------------------------------------------------
String sIban

sIban=dw_1.getitemstring(1,"IBAN")

dw_1.SetItem(1,"RIB_BQ", Mid(sIban,5,5))
dw_1.SetItem(1,"RIB_GUI", Mid(sIban,10,5))
dw_1.SetItem(1,"RIB_CPT", Mid(sIban,15,11))
dw_1.SetItem(1,"RIB_CLE", Mid(sIban,26,2))
end subroutine

public function string wf_getcleiban (string asrib);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_IBan::wf_getcleiban (PRIVATE)
//* Auteur			: FPI
//* Date				: 22/02/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Retourne la cl$$HEX2$$e9002000$$ENDHEX$$de contr$$HEX1$$f400$$ENDHEX$$le d'IBAN $$HEX2$$e0002000$$ENDHEX$$partir des derniers chiffres de l'IBAN ou $$HEX2$$e0002000$$ENDHEX$$partir du RIB
//*
//* Arguments		: asRib le RIB ou les derniers chiffres de l'IBAN
//*
//* Retourne		: La cl$$HEX2$$e9002000$$ENDHEX$$de contr$$HEX1$$f400$$ENDHEX$$le
//*
//*-----------------------------------------------------------------
String sCle
LongLong lCle
Integer iMod
Integer iCar, iPos

sCle=asRib + "152700"

// Conversion des lettres en chiffres
For iCar=65 to 90
	
	iPos=Pos(sCle,Char(iCar))
	
	Do While iPos > 0
		sCle=Replace(sCle,iPos,1,String(iCar - 55))
		iPos=Pos(sCle,Char(iCar))
	Loop
	
Next

// Modulo en 2 fois
lCle=LongLong(Left(sCle,14))
iMod=Mod(lCle,  97)
	
sCle=String(iMod) + Mid(sCle,15)
lCle=LongLong(sCle)
lCle=98 - Mod(lCle,97)
	
sCle=String(lCle,"00")

Return sCle
end function

public function boolean wf_check_iban (string asiban);//*-----------------------------------------------------------------
//*
//* Fonction		: W_Tm_Sp_IBan::wf_check_iban (PRIVATE)
//* Auteur			: FPI
//* Date				: 22/02/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Contr$$HEX1$$f400$$ENDHEX$$le la validit$$HEX2$$e9002000$$ENDHEX$$de l'IBAN
//*
//* Arguments		: asIBAN l'IBAN
//*
//* Retourne		: TRUE/FALSE
//*
//*-----------------------------------------------------------------
String sCle, sVal
LongLong lCle
Integer iMod
Boolean bOK

String  sBanque, sGuichet, sCompte

// Longueur
If isNull(asIban) or Len(asIban) <> 27 Then Return False

// 2 premier car sont des lettres
sVal=Left(asIban,2)
If not Match(sVal,"[A-Z][A-Z]") Then return False

// Commence par FR
sVal=Left(asIban,2)
If sVal <> "FR" And sVal <> "MC" Then return False // ... [PM064] [MT7055] Prise en compte Monaco

// Apr$$HEX1$$e800$$ENDHEX$$s le pays, que des chiffres
//sVal=Mid(asIban, 3)
//If not isNumber(sVal) Then return false
//If not Match(sVal,"[A-Z1-9]+") Then return False

// Cl$$HEX2$$e9002000$$ENDHEX$$de controle
//sCle=wf_getcleiban( Mid(asIban, 5))

//If Mid(asIban, 3,2) <> sCle Then return false


// FS : Apr$$HEX1$$e800$$ENDHEX$$s le pays, 2 chiffres
sVal=mid( asIban, 3, 2 )
If not isNumber(sVal) Then return false

// FS contr$$HEX1$$f400$$ENDHEX$$le du reste de l'iban Fran$$HEX1$$e700$$ENDHEX$$ais : Constater le code ici

	sBanque  = mid( asIban, 5, 5 )
	sGuichet = mid( asIban,10,5 ) 
	sCompte  = mid( asIban, 15, 11 )
	sCle     = mid( asIban, 26, 2 )

	bOk = F_RIB ( sBanque, sGuichet, sCompte, scle )


Return bOK
end function

on w_tm_sp_iban.create
int iCurrent
call super::create
this.cb_eff=create cb_eff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_eff
end on

on w_tm_sp_iban.destroy
call super::destroy
destroy(this.cb_eff)
end on

event open;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_IBan::open
//* Evenement 		: Open
//* Auteur			: FPI
//* Date				: 21/02/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
String sIBAN
String sCle


//n_cst_spb_params iuparams // FS
//iuParams = CREATE n_cst_spb_params // FS

iuParams = Message.PowerObjectParm
wf_initialiser_defaut(iuParams,1)
cb_ok.Enabled=TRUE

If dw_1.GetItemString(1,"RIB_CPT") <> "" Then
	// Init de la zone IBAN
	sIBAN= dw_1.GetItemString(1,"RIB_BQ")
	sIBAN+=dw_1.GetItemString(1,"RIB_GUI")
	sIBan+=dw_1.GetItemString(1,"RIB_CPT")
	sIBAN+=dw_1.GetItemString(1,"RIB_CLE")
	
	sCle=wf_getcleiban( sIBAN)
	
	sIBAN="FR" + sCle + sIBAN
	
	dw_1.SetItem(1,"IBAN",sIBan)
End if

dw_1.SetFocus()
end event

type dw_1 from w_message_reponse`dw_1 within w_tm_sp_iban
integer x = 46
integer y = 32
integer width = 1422
integer height = 132
string dataobject = "d_sp_saisie_iban"
end type

type cb_cancel from w_message_reponse`cb_cancel within w_tm_sp_iban
integer x = 101
integer y = 216
string text = "&Retour"
end type

type cb_ok from w_message_reponse`cb_ok within w_tm_sp_iban
integer x = 965
integer y = 212
end type

event cb_ok::clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: W_Tm_Sp_IBan::cb_ok
//* Evenement 		: clicked
//* Auteur			: FPI
//* Date				: 21/02/2013
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------
If dw_1.AcceptText()=-1 Then return 0

If not Wf_check_iban( dw_1.getItemString(1,"IBAN")) Then
	MessageBox(Parent.Title,"L'IBAN saisi est incorrect")
	dw_1.SetFocus()
	Return 0	
End if

wf_set_rib( )

Super::EVENT Clicked()



end event

type cb_eff from commandbutton within w_tm_sp_iban
integer x = 1445
integer y = 32
integer width = 169
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Eff."
end type

event clicked;dw_1.SetItem(1,"IBAN","")
dw_1.SetColumn("IBAN")
dw_1.SetFocus()
end event

