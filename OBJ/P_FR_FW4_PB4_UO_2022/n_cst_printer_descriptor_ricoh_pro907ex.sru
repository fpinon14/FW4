HA$PBExportHeader$n_cst_printer_descriptor_ricoh_pro907ex.sru
$PBExportComments$Descripteur d'imprimante pour les "Ricoh Pro907Ex"
forward
global type n_cst_printer_descriptor_ricoh_pro907ex from n_cst_printer_descriptor
end type
end forward

global type n_cst_printer_descriptor_ricoh_pro907ex from n_cst_printer_descriptor
end type
global n_cst_printer_descriptor_ricoh_pro907ex n_cst_printer_descriptor_ricoh_pro907ex

event constructor;call super::constructor;
//*-----------------------------------------------------------------
//*
//* Objet			: n_cst_printer_descriptor_ricoh_pro907Ex
//* Evenement 		: constructor
//* Auteur			: PHG
//* Date				: 30/03/2011
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
Imprimante Ricoh Pro 907 Ex

Voici la description des bacs dans WORD

Bac 4				= 262
Bac 5				= 263
Bac 6				= 264

*/

// [PM118] 

sBacHaut		= "263" // Bac 5 : Banque : ( Papier SPB uniquement )
sBacMilieu 	= "262" // Bac 4 : Autres ( Papier Sp$$HEX1$$e900$$ENDHEX$$cial )
//sBacMilieu 	= "261" // Bac 3 : Pour test sur 3_B_IMP_219
sBacBas 		= "264" // Bac 6 : Assur$$HEX2$$e9002000$$ENDHEX$$: Papier SPB

end event

on n_cst_printer_descriptor_ricoh_pro907ex.create
call super::create
end on

on n_cst_printer_descriptor_ricoh_pro907ex.destroy
call super::destroy
end on

