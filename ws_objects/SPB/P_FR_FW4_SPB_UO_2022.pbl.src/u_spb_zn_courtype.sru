HA$PBExportHeader$u_spb_zn_courtype.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux courriers types
forward
global type u_spb_zn_courtype from u_spb_zn_anc
end type
end forward

global type u_spb_zn_courtype from u_spb_zn_anc
end type
global u_spb_zn_courtype u_spb_zn_courtype

forward prototypes
public function boolean uf_zn_longueur_id (string astext)
end prototypes

public function boolean uf_zn_longueur_id (string astext);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_Longueur_Id
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/06/97 16:53:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le que l'ID_COUR est bien compos$$HEX2$$e9002000$$ENDHEX$$de 6 caract$$HEX1$$e800$$ENDHEX$$res.
//* Commentaires	:
//*
//* Arguments		:	String			asText		( Val )	Id du Courrier Type $$HEX2$$e0002000$$ENDHEX$$tester
//*
//* Retourne		:	Boolean			TRUE  = tout est OK
//*										   FALSE = le code courrier type n'est pas compos$$HEX2$$e9002000$$ENDHEX$$de
//*                                         6 caract$$HEX1$$e800$$ENDHEX$$res.
//*-----------------------------------------------------------------

Return ( Not ( Len ( asText ) <> 6 ) )
end function

on u_spb_zn_courtype.create
TriggerEvent( this, "constructor" )
end on

on u_spb_zn_courtype.destroy
TriggerEvent( this, "destructor" )
end on

