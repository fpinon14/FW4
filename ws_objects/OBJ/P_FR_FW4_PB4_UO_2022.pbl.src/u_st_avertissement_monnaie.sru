HA$PBExportHeader$u_st_avertissement_monnaie.sru
$PBExportComments$[SUISSE].LOT3 : static text affichant la monnaie d$$HEX1$$e900$$ENDHEX$$sir$$HEX1$$e900$$ENDHEX$$e au format litteral.
forward
global type u_st_avertissement_monnaie from statictext
end type
end forward

global type u_st_avertissement_monnaie from statictext
integer width = 1056
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Le montant est exprim$$HEX2$$e9002000$$ENDHEX$$en"
boolean focusrectangle = false
end type
global u_st_avertissement_monnaie u_st_avertissement_monnaie

event constructor;//*-----------------------------------------------------------------
//*
//* Objet			: u_st_avertissement_monnaie
//* Evenement 		: constructor
//* Auteur			: 
//* Date				: 27/02/2008 14:43:58
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*				  
//* Arguments		: 
//*
//* Retourne		: long
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

this.text += " " +stGlb.sMonnaieLitteralDesire
end event

on u_st_avertissement_monnaie.create
end on

on u_st_avertissement_monnaie.destroy
end on

