HA$PBExportHeader$u_spb_zn_paragraphe.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux paragraphes.
forward
global type u_spb_zn_paragraphe from u_spb_zn_anc
end type
end forward

global type u_spb_zn_paragraphe from u_spb_zn_anc
end type
global u_spb_zn_paragraphe u_spb_zn_paragraphe

forward prototypes
public function boolean uf_zn_longueurid (string asidpara)
end prototypes

public function boolean uf_zn_longueurid (string asidpara);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_LongueurId
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	13/06/97 17:40:22
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Contr$$HEX1$$f400$$ENDHEX$$le que l'Id du paragraphe est sur 4 caract$$HEX1$$e800$$ENDHEX$$res pour le code et 2 caract$$HEX1$$e900$$ENDHEX$$res pour le canal.
//*
//* Commentaires	:
//*
//* Arguments		:	String			asIdPara				( Val )	Identifiant du paragraphe.
//*						
//* Retourne		:	Boolean			TRUE  = tout est OK
//*										   FALSE = l'Id Para n'est pas sur 4 caract$$HEX1$$e800$$ENDHEX$$res.
//*-----------------------------------------------------------------


Return ( Not ( Len ( asIdPara ) <> 4 ) )



end function

on u_spb_zn_paragraphe.create
call super::create
end on

on u_spb_zn_paragraphe.destroy
call super::destroy
end on

