HA$PBExportHeader$u_spb_gs_groupe.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de gestion relatifs aux groupes ( contractant ).
forward
global type u_spb_gs_groupe from u_spb_gs_anc
end type
end forward

global type u_spb_gs_groupe from u_spb_gs_anc
end type
global u_spb_gs_groupe u_spb_gs_groupe

forward prototypes
public function string uf_gs_sup_grp (long adcidgrp)
end prototypes

public function string uf_gs_sup_grp (long adcidgrp);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_sup_grp
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	21/06/97 17:11:33
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	V$$HEX1$$e900$$ENDHEX$$rification de l'absence de contrainte 
//*					 	d'int$$HEX1$$e900$$ENDHEX$$grit$$HEX2$$e9002000$$ENDHEX$$pour le groupe
//*
//* Commentaires	:	
//*
//* Arguments		:	String		adcIdGrp	//Type de code $$HEX2$$e0002000$$ENDHEX$$supprimer  
//*
//*														
//* Retourne		: String		"" --> la suppression est possible
//*									Type d'information en relation avec le
//*									groupe $$HEX2$$e0002000$$ENDHEX$$supprimer.
//*
//*-----------------------------------------------------------------

String	 sRet 		// Valeur de retour de la fonction correspondant au 
							// type d'informations en relation avec le groupe

String	sLiaison		// Mot de liaison entre les composants du message d'erreur.
String	sProduit		// Message des produits.
String	sEts			// Message des etablissements.
String	sGrp			// Message des groupes.

Long 		lNbProduit	// Nombre de produit en relation avec le groupe.
Long 		lNbEts		// Nombre d'$$HEX1$$e900$$ENDHEX$$tablissement en relation avec le groupe.
Long 		lNbGrp		// Nombre de groupe en relation avec le groupe (en tant que groupe de base ).


sRet       = ""
sProduit   = ""
sEts       = ""
sGrp       = ""

lNbProduit = 0
lNbEts     = 0
lNbGrp     = 0

/*------------------------------------------------------------------*/
/* Recherche si ce groupe est li$$HEX4$$e9002000e0002000$$ENDHEX$$un produit Et/Ou $$HEX2$$e0002000$$ENDHEX$$un           */
/* $$HEX1$$e900$$ENDHEX$$tablissement.                                                   */
/*------------------------------------------------------------------*/
itrTrans.PS_V01_GROUPE ( adcIdGrp, lNbProduit, lNbEts, lNbGrp )

/*------------------------------------------------------------------*/
/* Construction de la chaine de retour.                             */
/*------------------------------------------------------------------*/
If f_procedure ( stMessage , iTrTrans , "PS_V01_GROUPE" ) Then

	sLiaison = " et "

	If lNbProduit <> 0 then

		sProduit = "des produits"
   
		If lNbEts <> 0	Or lNbGrp <> 0 then

			sProduit = sLiaison + sProduit

			sLiaison = ", "

		End If

	End If

	If lNbEts <> 0	Then	

      sEts = "des $$HEX1$$e900$$ENDHEX$$tablissements"

		If lNbGrp <> 0 Then

			sEts = sLiaison + sEts
			sLiaison = ", "

		End if

	End If

	If lNbGrp <> 0 Then &
		sGrp = "des groupes"

	sRet = sGrp + sEts + sProduit

Else

	/*----------------------------------------------------------------------------*/
	/* On se trouve dans le cas o$$HEX2$$f9002000$$ENDHEX$$une erreur a $$HEX1$$e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$d$$HEX1$$e900$$ENDHEX$$tect$$HEX1$$e900$$ENDHEX$$e et g$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e (affichage  */
	/* d'un message d'erreur) par f_procedure, donc avec sText="PROC" on          */
	/* l'indique au code appelant.                                                */
	/*----------------------------------------------------------------------------*/
	sRet = "PROC"

End If

Return ( sRet )
end function

on u_spb_gs_groupe.create
TriggerEvent( this, "constructor" )
end on

on u_spb_gs_groupe.destroy
TriggerEvent( this, "destructor" )
end on

