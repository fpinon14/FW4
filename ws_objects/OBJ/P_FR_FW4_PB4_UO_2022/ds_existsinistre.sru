HA$PBExportHeader$ds_existsinistre.sru
$PBExportComments$Objet g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rique pour savoir s'il existe un sinistre pour un produit/r$$HEX1$$e900$$ENDHEX$$vision/garantie donn$$HEX1$$e900$$ENDHEX$$.
forward
global type ds_existsinistre from datastore
end type
end forward

global type ds_existsinistre from datastore
string dataobject = "d_existsinistre"
event ue_info ( )
end type
global ds_existsinistre ds_existsinistre

forward prototypes
public function boolean uf_existsinistre (string asidprod, string asidrev, string asidgti, transaction atrtrans)
end prototypes

event ue_info();//*-----------------------------------------------------------------
//*
//* Objet			: ds_existsinistre
//* Evenement 		: ue_info
//* Auteur			: PHG
//* Date				: 26/05/2008 14:59:20
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: [DCMP070914] DEscription de l'objet de test 
//*					  d'existence d'un sinistre
//* Commentaires	: 
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
//
// M$$HEX1$$e900$$ENDHEX$$thode impl$$HEX1$$e900$$ENDHEX$$ment$$HEX1$$e900$$ENDHEX$$e :
//
//- uf_existsinistre( 	/*string asidprod*/, 
//								/*string asidrev*/, 
//								/*string asidgti*/, 
//								/*transaction atrtrans */)
//
//  Methode publique de test d'existence d'un sinistre, bas$$HEX1$$e900$$ENDHEX$$e sur le
//  ds "ds_sinistre" qui interroge la proc$$HEX1$$e900$$ENDHEX$$dure stock$$HEX1$$e900$$ENDHEX$$e
//  DW_S01_EXIST_SINISTRE, compil$$HEX1$$e900$$ENDHEX$$e sur chaque base.
//  Les parametre asIdrev et asIdGti sont optionnels : pour les
//  ignorer, saisir -1 dans la valeur du param$$HEX1$$ea00$$ENDHEX$$tre.
//  De plus, l'un ne pr$$HEX1$$e900$$ENDHEX$$cede pas l'autre, on peux faire :
//  uf_existsinistre( "10910", "-1", "10")
//  Derni$$HEX1$$e800$$ENDHEX$$re chose : tous les parametre sont en string, le type des 
//  donn$$HEX1$$e900$$ENDHEX$$es id_prod/id_rev/id_gti n'$$HEX1$$e900$$ENDHEX$$tant pas n'$$HEX1$$e900$$ENDHEX$$tant pas homog$$HEX1$$e800$$ENDHEX$$ne
//  suivant les applications.
/////////////////////////////////////////////////////////////////

end event

public function boolean uf_existsinistre (string asidprod, string asidrev, string asidgti, transaction atrtrans);//*-----------------------------------------------------------------
//*
//* Fonction		: ds_existsinistre::uf_existsinistre
//* Auteur			: PHG
//* Date				: 15/05/2008 11:28:18
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value string asidprod	 */
/* 	value string asidrev	 */
/* 	value string asidgti	 */
//*
//* Retourne		: boolean : True, un sinistre existe, False, non.
//*									Si Erreur => NULL
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------
n_cst_string lnv_string
boolean bRet
long lRet

SetNull(bRet)

// Controle des parametre
IF Not &
	(lnv_string.of_IsEmpty(asIdProd) or &
	lnv_string.of_IsEmpty(asIdRev) or &
	lnv_string.of_IsEmpty(asIdGti) ) and &
	isValid(atrTrans) Then // Si Ok
	
	This.SetTransObject( atrTrans)
	lRet = This.retrieve(asIdProd, asIdRev, asIdGti )
	If lRet = 1 Then
		bRet = ( this.object.alt_exist_sinistre[1] = 'O' )
	End If

End If

return bRet



end function

on ds_existsinistre.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ds_existsinistre.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

