HA$PBExportHeader$n_cst_global_function_provider.sru
$PBExportComments$Fournisseur de Fonction Globale surchargeable. ( Voir event "Info" de l'objet pour utilisation )
forward
global type n_cst_global_function_provider from nonvisualobject
end type
end forward

global type n_cst_global_function_provider from nonvisualobject
event info ( )
end type
global n_cst_global_function_provider n_cst_global_function_provider

forward prototypes
public function boolean uf_f_libelle (string astexte, integer airegle)
public function boolean uf_f_code_postal (string ascodepostal, integer airegle)
public function boolean uf_f_iban (string asidiban, string asaction, ref long alcle)
end prototypes

event info();//*-----------------------------------------------------------------
//*
//* Objet			: n_cst_global_function_provider
//* Evenement 		: info
//* Auteur			: PHG
//* Date				: 14/03/2008 17:39:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Permet de fournir des fonctions globales surchargeable
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
// Cet objet sert d'interface pour stocker tous prototype de fonction 
// globale vou$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$pouvoir $$HEX1$$ea00$$ENDHEX$$tre surcharg$$HEX1$$e900$$ENDHEX$$e.
//
// Ainsi le mode op$$HEX1$$e900$$ENDHEX$$ratoire est le suivant :
// - D$$HEX1$$e900$$ENDHEX$$finir dans cet objet un prototype de fonction publique 
//	  correspondant $$HEX2$$e0002000$$ENDHEX$$la fonction globale que l'on aurait pu 
//	  cr$$HEX1$$e900$$ENDHEX$$er directement sous Pb.
// - Cr$$HEX1$$e900$$ENDHEX$$er un descendant de cet objet, on l'on va impl$$HEX1$$e900$$ENDHEX$$menter 
//   r$$HEX1$$e900$$ENDHEX$$ellement la focntion globale a utiliser.
//	  Ces descendant doivent etre nomm$$HEX2$$e9002000$$ENDHEX$$n_cst_gfp_... ( gfp = Global Fonction Provider )
// - Cr$$HEX1$$e900$$ENDHEX$$er une Vraie fonction Globale qui va instancier,
//   via un "create" ou un "create using" le descendant voulu.
// =>	Cela permet, dans le framework de faire appel $$HEX2$$e0002000$$ENDHEX$$des fonctions globales
//		qui seront surcharg$$HEX1$$e900$$ENDHEX$$e eventuellement dans le descendant.


end event

public function boolean uf_f_libelle (string astexte, integer airegle);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_global_function_provider::uf_f_libelle
//* Auteur			: PHG
//* Date				: 14/03/2008 17:52:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: PROTOTYPE : Voir descendant pour impl$$HEX1$$e900$$ENDHEX$$mentation
//* Commentaires	: 
//*
//* Arguments		: value string astexte	 */
/* 	value integer airegle	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

return TRUE



end function

public function boolean uf_f_code_postal (string ascodepostal, integer airegle);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_global_function_provider::uf_f_code_postal
//* Auteur			: PHG
//* Date				: 14/03/2008 17:54:32
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: PROTOTYPE : Voir descendant pour impl$$HEX1$$e900$$ENDHEX$$mentation
//*
//* Arguments		: value string ascodepostal	 */
/* 	value integer airegle	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------


return TRUE


end function

public function boolean uf_f_iban (string asidiban, string asaction, ref long alcle);return true
end function

on n_cst_global_function_provider.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_global_function_provider.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

