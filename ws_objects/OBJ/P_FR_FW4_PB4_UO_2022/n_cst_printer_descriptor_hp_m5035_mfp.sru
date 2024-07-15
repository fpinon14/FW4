HA$PBExportHeader$n_cst_printer_descriptor_hp_m5035_mfp.sru
$PBExportComments$Descripteur d'imprimante pour les HP LaserJet M5035 MFP PCL6.
forward
global type n_cst_printer_descriptor_hp_m5035_mfp from n_cst_printer_descriptor
end type
end forward

global type n_cst_printer_descriptor_hp_m5035_mfp from n_cst_printer_descriptor
end type
global n_cst_printer_descriptor_hp_m5035_mfp n_cst_printer_descriptor_hp_m5035_mfp

event constructor;call super::constructor;
//*-----------------------------------------------------------------
//*
//* Objet			: n_cst_printer_descriptor_hp_m5035_mfp
//* Evenement 		: constructor
//* Auteur			: PHG
//* Date				: 13/05/2008 12:17:42
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
Imprimante 3_B_IMP219 HP LaserJet M5035 MFP PCL6

Voici la description des bacs dans WORD

S$$HEX1$$e900$$ENDHEX$$lection automatique	= wdPrinterFormSource
S$$HEX1$$e900$$ENDHEX$$lection auto.impr		= 257
Alim. Manuelle (Bac 1)	= 258
Bac 1				= 259
Bac 2				= 260
Bac 3				= 261
Bac 4				= 262
Bac 5				= 263
Bac 6				= 264

Ordinaire			= 1273
Pr$$HEX1$$e900$$ENDHEX$$-imprim$$HEX4$$e900090009000900$$ENDHEX$$= 1272
Papier en-t$$HEX1$$ea00$$ENDHEX$$te		= 1271
*/

//sBacHaut		= "262" // Bac 4 :Assur$$HEX2$$e9002000$$ENDHEX$$+ Autres : (SPB ou BNP)
//sBacMilieu 	= "264" // Bac 6 :Papier Blanc A4/A3
////sBacMilieu 	= "261" // Bac 3 : Pour test sur 3_B_IMP_219
//sBacBas 		= "263" // Bac 5 : Bac Papier SPB
//

//[SUPPORT_MFP].SIMPA2 // Correction des commentaires, qui induisaient vraiment en erreur.

sBacHaut		= "262" // Bac 4 : Banque : ( Papier SPB uniquement )
sBacMilieu 	= "264" // Bac 6 : Papier Blanc A4/A3
//sBacMilieu 	= "261" // Bac 3 : Pour test sur 3_B_IMP_219
sBacBas 		= "263" // Bac 5 : Assur$$HEX2$$e9002000$$ENDHEX$$+ Autres : (Papier SPB ou autrs ( Bnp par exemple ) )

end event

on n_cst_printer_descriptor_hp_m5035_mfp.create
call super::create
end on

on n_cst_printer_descriptor_hp_m5035_mfp.destroy
call super::destroy
end on

