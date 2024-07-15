HA$PBExportHeader$n_cst_crypter.sru
forward
global type n_cst_crypter from nonvisualobject
end type
end forward

global type n_cst_crypter from nonvisualobject
end type
global n_cst_crypter n_cst_crypter

forward prototypes
public function integer uf_crypter (ref string aschaine, boolean abswitch)
end prototypes

public function integer uf_crypter (ref string aschaine, boolean abswitch);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Crypter
//* Acc$$HEX1$$e800$$ENDHEX$$s			: Public
//* Auteur			: Fabry JF
//* Date				: 13/09/1999 15:43:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cryptage d'une cha$$HEX1$$ee00$$ENDHEX$$ne de caract$$HEX1$$e800$$ENDHEX$$re 
//* Commentaires	: La cha$$HEX1$$ee00$$ENDHEX$$ne retourn$$HEX1$$e900$$ENDHEX$$e peut $$HEX1$$ea00$$ENDHEX$$tre $$HEX1$$e900$$ENDHEX$$crite sur une base SQLSERVER,
//*					  et contient un caract$$HEX1$$e800$$ENDHEX$$re de plus que la cha$$HEX1$$ee00$$ENDHEX$$ne pass$$HEX1$$e900$$ENDHEX$$e en argument.
//*                 
//*
//* Arguments		: String			asChaine					(R$$HEX1$$e900$$ENDHEX$$f)		   Chaine de caract$$HEX1$$e800$$ENDHEX$$res sans limite de taille
//*					  String			abSwitch					(Val)       True : Cryptage, False : D$$HEX1$$e900$$ENDHEX$$cryptage
//*																					
//*
//* Retourne		: Integer		1	->	 Cha$$HEX1$$ee00$$ENDHEX$$ne Crypt$$HEX1$$e900$$ENDHEX$$e/D$$HEX1$$e900$$ENDHEX$$crypt$$HEX1$$e900$$ENDHEX$$e avec Succ$$HEX1$$e800$$ENDHEX$$s
//*										-1 ->  La cha$$HEX1$$ee00$$ENDHEX$$ne pass$$HEX1$$e900$$ENDHEX$$e en argument est vide
//*										-2 ->  Erreur de cryptage, un des caract$$HEX1$$e800$$ENDHEX$$res de la cha$$HEX1$$ee00$$ENDHEX$$ne pass$$HEX1$$e900$$ENDHEX$$e
//*												 en argument n'est pas compris dans la plage d$$HEX1$$e900$$ENDHEX$$finie.
//*														
//*												 En cas d'erreur la cha$$HEX1$$ee00$$ENDHEX$$ne pass$$HEX1$$e900$$ENDHEX$$e en argument est retourn$$HEX1$$e900$$ENDHEX$$e $$HEX2$$e0002000$$ENDHEX$$l'identique. 
//*-----------------------------------------------------------------
//* MAJ PAR		DATE		MODIFICATION
//*#1 SBA		23/10/09	[SESAME_PWD].1.1.5 Appel de la classe ad$$HEX1$$e900$$ENDHEX$$quate
//*-----------------------------------------------------------------

return -1
end function

on n_cst_crypter.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_crypter.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

