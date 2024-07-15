HA$PBExportHeader$u_spb_zn_code.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux codes
forward
global type u_spb_zn_code from u_spb_zn_anc
end type
end forward

global type u_spb_zn_code from u_spb_zn_anc
end type
global u_spb_zn_code u_spb_zn_code

forward prototypes
public function integer uf_zn_id_typcode (string astext, ref boolean abcompteur)
end prototypes

public function integer uf_zn_id_typcode (string astext, ref boolean abcompteur);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_zn_id_TypCode
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	11/06/97 15:18:08
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	D$$HEX1$$e900$$ENDHEX$$termine s'il faut saisir l'ID_CODE.
//* Commentaires	:	S'il n'existe pas de compteur pour ce type de code dans la 
//*						table parametre la saisie est obligatoire.
//*
//* Arguments		:	String	asText		( Val ) : Valeur de la zone.
//*						Boolean	abCompteur	( Ref ) : pr$$HEX1$$e900$$ENDHEX$$sence de compteur.
//*
//* Retourne		:	Entier :	Correspondant $$HEX2$$e0002000$$ENDHEX$$l'action code $$HEX2$$e0002000$$ENDHEX$$utiliser 
//*					  				dans l'ItemChanged
//*
//*-----------------------------------------------------------------

Integer		iAction			// Valeur de retour de la fonction.

String  		sCol [ 1 ]		// Liste des champs $$HEX2$$e0002000$$ENDHEX$$prot$$HEX1$$e900$$ENDHEX$$ger.
String		sNomCompteur	// Nom du compteur $$HEX2$$e0002000$$ENDHEX$$trouver dans parametre.

Long			lNbCompteur		// Nombre de compteur.

Boolean		bRet				// Variable pour test d'erreur.

sCol [ 1 ] 	 = "ID_CODE"
lNbCompteur  = 0
iAction      = 0
bRet         = True
sNomCompteur = 'ID_' + Right ( asText, 2 )

/*------------------------------------------------------------------*/
/* Recherche s'il existe un compteur.                               */
/*------------------------------------------------------------------*/
itrtrans.IM_S01_PARAMETRE ( sNomCompteur, lNbCompteur )

If Not f_Procedure ( stMessage, itrTrans, "IM_S01_PARAMETRE" ) Then
	
	iAction = 1

Else

	If lNbCompteur = 1	Then 

		idw_1.Uf_Proteger ( sCol, "1" )
		abCompteur = True

	Else

		idw_1.Uf_Proteger ( sCol, "0" )
		abCompteur = False

	End If

	/*------------------------------------------------------------------*/
	/* Je r$$HEX1$$e900$$ENDHEX$$initialise le champ ID_CODE $$HEX2$$e0002000$$ENDHEX$$nul.                          */
	/*------------------------------------------------------------------*/
	idw_1.SetItem ( 1, scol [ 1 ], stNul.dcm )

End If

Return ( iAction )
end function

on u_spb_zn_code.create
TriggerEvent( this, "constructor" )
end on

on u_spb_zn_code.destroy
TriggerEvent( this, "destructor" )
end on

