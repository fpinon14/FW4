HA$PBExportHeader$u_spb_zn_groupe.sru
$PBExportComments$---} User Object pour les contr$$HEX1$$f400$$ENDHEX$$les de saisie relatifs aux groupes
forward
global type u_spb_zn_groupe from u_spb_zn_anc
end type
end forward

global type u_spb_zn_groupe from u_spb_zn_anc
end type
global u_spb_zn_groupe u_spb_zn_groupe

forward prototypes
public function integer uf_zn_id_grpbase (string astext)
public function integer uf_zn_id_grp (string astext)
end prototypes

public function integer uf_zn_id_grpbase (string astext);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_id_grpbase
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	21/07/97 16:42:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	V$$HEX1$$e900$$ENDHEX$$rification de l'existance du groupe principal.
//*
//* Arguments		:	String		asText		// Identifiant du groupe principal
//*
//*
//* Retourne		:	Integer
//*
//*-----------------------------------------------------------------

Integer	iRet				// Variable de retour de la fonction.

Long		dcIdGrpBase		// Code Grp Principal saisi.
Long		dcIdGrp			// Code Groupe saisi.

String 	sLibGrpBase		// Libell$$HEX2$$e9002000$$ENDHEX$$du Groupe correspondant aux identifiants
								// pass$$HEX1$$e900$$ENDHEX$$s en parametre.

iRet			= 0
sLibGrpBase	= space ( 35 )

If Not ( Trim ( asText ) = "" Or IsNull ( asText ) )		Then

	dcIdGrpBase  = Dec ( asText )
	dcIdGrp		 = iDw_1.GetItemNumBer ( 1, "ID_GRP" )

	If dcIdGrpBase <> dcIdGrp	Then

		/*------------------------------------------------------------------*/
		/* Recherche s'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un groupe avec l'identifiant pass$$HEX5$$e9002000200020002000$$ENDHEX$$*/
		/* en parametre                                                     */
		/*------------------------------------------------------------------*/
		itrtrans.IM_S02_GROUPE ( dcIdGrpBase, slibGrpBase )

		If Not f_procedure ( stMessage , iTrTrans , "IM_S02_GROUPE" ) Then

			iRet = 1
			iDW_1.iiErreur = 2

		Else

			sLibGrpBase = Trim ( sLibGrpBase )
	
			/*------------------------------------------------------------------*/
			/* Si on teste le groupe de base son identifiant doit exister       */
			/*------------------------------------------------------------------*/
			If sLibGrpBase = ""	Then

				iDw_1.iiErreur = 1
				iRet = 1

			Else

				iDw_1.SetItem ( 1, "LIB_GRP_BASE", sLibGrpBase )

			End If

		End If

	Else

		iDw_1.SetItem ( 1, "LIB_GRP_BASE", stNul.str )

	End If

Else

	iDw_1.SetItem ( 1, "LIB_GRP_BASE", stNul.str )

End If

Return ( iRet )
end function

public function integer uf_zn_id_grp (string astext);//*-----------------------------------------------------------------
//*
//* Fonction		:	uf_gs_id_grp
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	21/07/97 16:42:09
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	
//* Commentaires	:	V$$HEX1$$e900$$ENDHEX$$rification de l'unicit$$HEX2$$e9002000$$ENDHEX$$de l'identifiant des
//*					 	groupes.
//*
//* Arguments		: String		adcIdGrp		// Identifiant du groupe
//*
//*
//* Retourne		: Integer
//*
//*-----------------------------------------------------------------

Integer	iRet			// Variable de retour de la fonction.

Long		dcIdGrp		// Code Ets saisie.

String 	sLibGrp		// Libell$$HEX2$$e9002000$$ENDHEX$$du Groupe correspondant aux identifiants
							// pass$$HEX1$$e900$$ENDHEX$$s en parametre.

iRet		= 0
sLibGrp	= space ( 35 )

If Not ( Trim ( asText ) = "" Or IsNull ( asText ) )		Then

	dcIdGrp  = Dec ( asText )

	/*------------------------------------------------------------------*/
	/* Recherche s'il existe d$$HEX1$$e900$$ENDHEX$$j$$HEX2$$e0002000$$ENDHEX$$un groupe avec l'identifiant pass$$HEX5$$e9002000200020002000$$ENDHEX$$*/
	/* en parametre                                                     */
	/*------------------------------------------------------------------*/
	itrtrans.IM_S01_GROUPE ( dcIdGrp, slibGrp )

	If Not f_procedure ( stMessage , iTrTrans , "IM_S01_GROUPE" ) Then

		/*----------------------------------------------------------------------------*/
		/* On v$$HEX1$$e900$$ENDHEX$$rifie que l'appel de la proc. stock$$HEX1$$e900$$ENDHEX$$e se passe bien.                  */
		/*----------------------------------------------------------------------------*/
		iRet = 1
		iDw_1.iiErreur = 2

	Else

		sLibGrp = Trim ( sLibGrp )

		/*------------------------------------------------------------------*/
		/* Si on teste le groupe son identifiant doit $$HEX1$$ea00$$ENDHEX$$tre unique.          */
		/*------------------------------------------------------------------*/
		If	sLibGrp  <> "" Then

			iDw_1.iiErreur 	= 1
			iRet = 1

		Else

			iDw_1.SetItem ( 1, "ID_GRP_BASE", dcIdGrp )

		End If

	End If

Else

	iDw_1.SetItem ( 1, "ID_GRP_BASE" , stNul.dcm )
	iDw_1.SetItem ( 1, "LIB_GRP_BASE", stNul.str )

End If

Return ( iRet )
end function

on u_spb_zn_groupe.create
TriggerEvent( this, "constructor" )
end on

on u_spb_zn_groupe.destroy
TriggerEvent( this, "destructor" )
end on

