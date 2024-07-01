HA$PBExportHeader$n_cst_printer_descriptor_old_printer.sru
$PBExportComments$Descripteur G$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rique d'imprimante pour les imprimantes Xerox 4520, Compaq PageMarq, HP LaserJet 9040 PCL 6
forward
global type n_cst_printer_descriptor_old_printer from n_cst_printer_descriptor
end type
end forward

global type n_cst_printer_descriptor_old_printer from n_cst_printer_descriptor
end type
global n_cst_printer_descriptor_old_printer n_cst_printer_descriptor_old_printer

on n_cst_printer_descriptor_old_printer.create
call super::create
end on

on n_cst_printer_descriptor_old_printer.destroy
call super::destroy
end on

event constructor;call super::constructor;//*-----------------------------------------------------------------
//*
//* Objet			: n_cst_printer_descriptor_old_printer
//* Evenement 		: constructor
//* Auteur			: PHG
//* Date				: 13/05/2008 12:08:49
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: D$$HEX1$$e900$$ENDHEX$$finition des Propri$$HEX1$$e900$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$s propre $$HEX2$$e0002000$$ENDHEX$$l'Imprimante.
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
Ancien Code de uf_InscrireBac
/*------------------------------------------------------------------*/
/* Le type d'imprimante 1 fait r$$HEX1$$e900$$ENDHEX$$f$$HEX1$$e900$$ENDHEX$$rence aux imprimantes Xerox      */
/* 4520 et Compaq PageMarq.                                         */
/*------------------------------------------------------------------*/
Choose Case aiTypeImprimante
Case 1
	Choose Case asBac
	Case "HAUT"
		sText = "1"
	Case "MILIEU"
		sText = "3"
	Case "BAS"
		sText = "2"
	End Choose
End Choose

*/

sBacHaut		= "1" // Assur$$HEX2$$e9002000$$ENDHEX$$+ Autres : (SPB ou BNP)
sBacMilieu 	= "3" // Papier Blanc A4/A3
sBacBas 		= "2" // Papier SPB
end event

