HA$PBExportHeader$u_pbroutage.sru
$PBExportComments$----} UserObjet Picture Bouton Routage
forward
global type u_pbroutage from picturebutton
end type
end forward

global type u_pbroutage from picturebutton
int Width=266
int Height=153
int TabOrder=1
string Text="&Routage"
string PictureName="k:\pb4obj\bmp\routage.bmp"
boolean OriginalSize=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_pbroutage u_pbroutage

on clicked;//*-----------------------------------------------------------------
//*
//* Objet 			: u_pbroutage::Clicked
//* Evenement 		: Clicked
//* Auteur			: Erick John Stark
//* Date				: 12/06/1997 11:21:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: D$$HEX1$$e900$$ENDHEX$$clenchement de l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e900$$ENDHEX$$nement UE_ROUTAGE
//*				  
//*-----------------------------------------------------------------
//* MAJ PAR		Date		Modification
//*				  
//*-----------------------------------------------------------------

Parent.TriggerEvent ( "Ue_Routage" )


end on

