HA$PBExportHeader$u_spb_zn_anc.sru
$PBExportComments$---} User Object de contr$$HEX1$$f400$$ENDHEX$$le de saisie anc$$HEX1$$ea00$$ENDHEX$$tre
forward
global type u_spb_zn_anc from nonvisualobject
end type
end forward

global type u_spb_zn_anc from nonvisualobject
end type
global u_spb_zn_anc u_spb_zn_anc

type variables
u_Transaction	itrTrans	// Objet de transaction par d$$HEX1$$e900$$ENDHEX$$faut

u_DataWindow	iDw_1 // Datawindow sur laquelle faire les mise $$HEX2$$e0002000$$ENDHEX$$jour

end variables

forward prototypes
public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow)
end prototypes

public subroutine uf_initialisation (u_transaction atrtrans, ref u_datawindow adwdatawindow);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Initialisation
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 10/06/97 15:34:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation des variables d'instance pour le
//*					  User Object de contr$$HEX1$$f400$$ENDHEX$$le de saisie
//* Commentaires	: 
//*
//* Arguments		: u_Transaction	atrTrans
//*					  u_Datawindow		adwDatawindow
//*	
//* Retourne		: Rien
//*										
//*
//*-----------------------------------------------------------------

itrtrans		= atrTrans					//Objet de transaction $$HEX2$$e0002000$$ENDHEX$$utiliser
iDw_1			= adwDatawindow			//Datawindow $$HEX2$$e0002000$$ENDHEX$$contr$$HEX1$$f400$$ENDHEX$$ler
end subroutine

on u_spb_zn_anc.create
TriggerEvent( this, "constructor" )
end on

on u_spb_zn_anc.destroy
TriggerEvent( this, "destructor" )
end on

