HA$PBExportHeader$n_cst_printer_descriptor.sru
$PBExportComments$Interface Objet pour Description d'une Imprimante : D$$HEX1$$e900$$ENDHEX$$crit une s$$HEX1$$e900$$ENDHEX$$rie de m$$HEX1$$e900$$ENDHEX$$thode $$HEX2$$e0002000$$ENDHEX$$impl$$HEX1$$e900$$ENDHEX$$tenter dans les descendant pour d$$HEX1$$e900$$ENDHEX$$crire les bacs, et autres propri$$HEX1$$e900$$ENDHEX$$t$$HEX1$$e900$$ENDHEX$$s sp$$HEX1$$e900$$ENDHEX$$cifiques aux imprimantes.
forward
global type n_cst_printer_descriptor from nonvisualobject
end type
end forward

global type n_cst_printer_descriptor from nonvisualobject
event ue_info ( )
end type
global n_cst_printer_descriptor n_cst_printer_descriptor

type variables
protected:
string	sNomImprimante
string 	isListeBac[]
string 	sBacHaut
string 	sBacMilieu
string 	sBacBas



end variables

forward prototypes
public function string uf_getbac (string asbac)
end prototypes

event ue_info();//*-----------------------------------------------------------------
//*
//* Objet			: n_cst_printer_descriptor
//* Evenement 		: ue_info
//* Auteur			: PHG
//* Date				: 28/05/2008 17:23:05
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Description de la classe "n_cst_printer_descriptor"
//* Commentaires	: [SUPPORT_MFP]
//*				  
//* Arguments		: 
//*
//* Retourne		: (none)
//*				  
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

//*-----------------------------------------------------------------
//*
//* Ancetre Sp$$HEX1$$e900$$ENDHEX$$cifiant les m$$HEX1$$e900$$ENDHEX$$thodes virtuelle pour d$$HEX1$$e900$$ENDHEX$$crire une
//* Imprimante.
//* 
//* Utilisation : Cr$$HEX1$$e900$$ENDHEX$$er un descendant de cet anc$$HEX1$$ea00$$ENDHEX$$tre pour une 
//*					imprimante donn$$HEX1$$e900$$ENDHEX$$e, et impl$$HEX1$$e900$$ENDHEX$$menter les m$$HEX1$$e900$$ENDHEX$$thodes par
//*					surcharge, afin d'impl$$HEX1$$e900$$ENDHEX$$menter le comportement r$$HEX1$$e900$$ENDHEX$$el
//*					relatif $$HEX2$$e0002000$$ENDHEX$$l'imprimante.
//* 
//* ----------------------------------------------------------------
//* Propri$$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$:
//* iListeBac[] : Liste des Bac Disponible
//* iBacHaut 	: Identifiant du Bac du Haut
//* iBacMileu 	: Identifiant du Bac du Milieu
//* iBacBas 	: Identifiant du Bac de Bas
//* 
//* Liste des Methodes Actuellement Disponible pour surchages :
//* protected : uf_LireImprimante:	Initialise les propri$$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$de 
//*											l'objets
//* public : uf_GetBac (sBac)		: 	Retourne le Bac suivant le 
//*											parametre sp$$HEX1$$e900$$ENDHEX$$cifi$$HEX1$$e900$$ENDHEX$$.
//* 
//* M$$HEX1$$e900$$ENDHEX$$thodes pouvant etre Impl$$HEX1$$e900$$ENDHEX$$ment$$HEX1$$e900$$ENDHEX$$es :
//*
//* Toutes les m$$HEX1$$e900$$ENDHEX$$thodes faisant appel au API Windows pour 
//* lire/d$$HEX1$$e900$$ENDHEX$$finir tous les param$$HEX1$$ea00$$ENDHEX$$tre d'une imprimante, par exemple : 
//* Nom de L'imprimante, Chemin R$$HEX1$$e900$$ENDHEX$$seau, Papier Selectionn$$HEX1$$e900$$ENDHEX$$, Format..
//* ----------------------------------------------------------------

end event

public function string uf_getbac (string asbac);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_printer_descriptor::uf_getbac
//* Auteur			: PHG
//* Date				: 13/05/2008 11:52:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Retourne le Num$$HEX1$$e900$$ENDHEX$$ro de Bac Correspondant  
//* Commentaires	: 
//*
//* Arguments		: value string asbac	 */
//*
//* Retourne		: string : Le code Bac interpr$$HEX1$$e900$$ENDHEX$$table par l'imprimante	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

string sBac
Choose case upper(asBac)
	case "HAUT"
		sBac = sBacHaut
	case "MILIEU"
		sBac = sBacMilieu
	case "BAS"
		sBac = sBacBas
	case else
		sBac = ""
End Choose

return sBac

end function

on n_cst_printer_descriptor.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_printer_descriptor.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

