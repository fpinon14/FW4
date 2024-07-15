HA$PBExportHeader$n_cst_printer_descriptor_konica_c2060.sru
$PBExportComments$Descripteur d'imprimante pour les Konica AccurioPress C2060.
forward
global type n_cst_printer_descriptor_konica_c2060 from n_cst_printer_descriptor
end type
end forward

global type n_cst_printer_descriptor_konica_c2060 from n_cst_printer_descriptor
end type
global n_cst_printer_descriptor_konica_c2060 n_cst_printer_descriptor_konica_c2060

event constructor;call super::constructor;
//*-----------------------------------------------------------------
//*
//* Objet			: n_cst_printer_descriptor_konica_c2060
//* Evenement 		: constructor
//* Auteur			: FPI
//* Date				: 19/02/2018
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Definition des propri$$HEX1$$e900$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$s li$$HEX1$$e900$$ENDHEX$$es $$HEX2$$e0002000$$ENDHEX$$l'imprimante.
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

/*
Pour R$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence :
Imprimante Konica AccurioPress C2060

Voici la description des bacs dans WORD

S$$HEX1$$e900$$ENDHEX$$lection automatique	= wdPrinterFormSource
Bac 3				= 259
Bac 4				= 260
*/

/*sBacMilieu		= "259" // Bac 3 : Banque : ( Papier SPB uniquement )
sBacBas		 	= "261" // Bac 5 : Papier Blanc A4/A3 -> inutilis$$HEX1$$e900$$ENDHEX$$
sBacHaut 		= "260" // Bac 4 : Assur$$HEX2$$e9002000$$ENDHEX$$+ Autres : (Papier SPB ou autrs ( Bnp par exemple ) )*/

sBacMilieu		= "258" // Bac 3 : Banque : ( Papier SPB uniquement )
sBacBas		 	= "260" // Bac 5 : Papier Blanc A4/A3 -> inutilis$$HEX1$$e900$$ENDHEX$$
sBacHaut 		= "259" // Bac 4 : Assur$$HEX2$$e9002000$$ENDHEX$$+ Autres : (Papier SPB ou autrs ( Bnp par exemple ) )*/

end event

on n_cst_printer_descriptor_konica_c2060.create
call super::create
end on

on n_cst_printer_descriptor_konica_c2060.destroy
call super::destroy
end on

