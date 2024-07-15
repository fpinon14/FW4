HA$PBExportHeader$n_cst_gfp_standard.sru
$PBExportComments$Forunisseur de fonction Globale France Standard
forward
global type n_cst_gfp_standard from n_cst_global_function_provider
end type
end forward

global type n_cst_gfp_standard from n_cst_global_function_provider
end type
global n_cst_gfp_standard n_cst_gfp_standard

forward prototypes
public function boolean uf_f_code_postal (string ascodepostal, integer airegle)
public function boolean uf_f_libelle (string astexte, integer airegle)
public function boolean uf_f_iban (string asidiban, string asaction, ref long alcle)
end prototypes

public function boolean uf_f_code_postal (string ascodepostal, integer airegle);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_F_code_postal
//* Auteur			: V.Capelle
//* Date				: 28/02/1997 14:39:30
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fonction de v$$HEX1$$e900$$ENDHEX$$rification des codes postaux
//* Commentaires	: Transform$$HEX2$$e9002000$$ENDHEX$$en fg surchargeable par PHG
//*
//* Arguments		: 
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en
//*					
//*
//*-----------------------------------------------------------------
//* N$$HEX2$$b0002000$$ENDHEX$$Modif          Re$$HEX1$$e700$$ENDHEX$$ue Le          Effectu$$HEX1$$e900$$ENDHEX$$e Le          PAR
//*
//* MOD-BUG3          01/08/97            01/08/97				 YP
//*
//*-----------------------------------------------------------------

Boolean 	bRet	//Valeur de retour

/*----------------------------------------------------------------------------*/
/* MOD-BUG3 : On ne testait pas si le code postal est $$HEX2$$e0002000$$ENDHEX$$NULL et si c'$$HEX1$$e900$$ENDHEX$$tait    */
/* le cas, on avait droit un beau PBSTUB !!                                   */
/*----------------------------------------------------------------------------*/
If isNull ( ascodePostal ) Or asCodePostal = "" Then 

	bRet = True

Else

	Choose Case aiRegle
	
		Case 1

			bRet = ( Match	(  asCodePostal  , "^[0-9][0-9][0-9][0-9][0-9]$" )  &
					   And ( ( Real ( asCodePostal ) >= 1000 and Real ( asCodePostal ) <= 95999 ) &
					    Or ( Real ( asCodePostal ) >= 97000 and Real ( asCodePostal ) <= 99000 ))) &
					 Or & 
            	 (  asCodePostal  = "     " )

		Case 2

			bRet = ( Match	(  asCodePostal  , "^[0-9][0-9][0-9][0-9][0-9]$" )  &
					   And ( ( Real ( asCodePostal ) >= 1000 and Real ( asCodePostal ) <= 95999 ) &
					    Or ( Real ( asCodePostal ) >= 97000 and Real ( asCodePostal ) <= 99000 ))) &
					 Or & 
            	 (  asCodePostal  = "00000" )

	End Choose

End If

Return ( bRet )
end function

public function boolean uf_f_libelle (string astexte, integer airegle);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_F_Libelle
//* Auteur			: YP
//* Date				: 06/11/1997 11:19:02
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Fonction de regroupement des r$$HEX1$$e800$$ENDHEX$$gles de validation
//*					  des diff$$HEX1$$e900$$ENDHEX$$rents champs
//* Commentaires	: Transform$$HEX2$$e9002000$$ENDHEX$$en Focntion Globale Surchargeable par PHG
//*
//* Arguments		: String		asTexte	-->	Valeur saisie pour le champ
//*					  Integer	aiRegle  -->	Type de r$$HEX1$$e800$$ENDHEX$$gle de validation
//*														que valeur doit respecter   	
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en	Vrai 		-->	La valeur saisie pour le
//*														respecte la r$$HEX1$$e800$$ENDHEX$$gle de 
//*														validation correspondant 
//*														au champ
//*
//*									Faux		-->	La r$$HEX1$$e800$$ENDHEX$$gle de validation du 
//*														champ n'est pas respect$$HEX1$$e900$$ENDHEX$$e 	
//*										
//*
//*-----------------------------------------------------------------
//	FPI	27/05/2013	[EURO] Ajout du sigle Euro
//*-----------------------------------------------------------------

Long lCpt, lTrouveA, lTrouveB, lTot

lTrouveA = 0
lTrouveB = 0

Boolean	bRet = False		//Valeur de retour de la fonction


If isNull ( asTexte ) Or asTexte = "" Then 

	bRet = True

Else

	Choose Case aiRegle

	/*------------------------------------------------------------------*/
	/* Tout sans quote                                                  */
	/* Utilis$$HEX2$$e9002000$$ENDHEX$$pour Adr_1, Adr_2, Adr_Ville avec colonne en UPPER       */
	/* Utilis$$HEX2$$e9002000$$ENDHEX$$pour v_ref1, v_ref2 avec colonne en ANY CASE		        */
	/*------------------------------------------------------------------*/
	Case 1
		bRet = Match ( asTexte , "^[A-Za-z0-9$$HEX9$$e900e800e000f900fb00e200f400ea00ee00$$ENDHEX$$|$$HEX1$$a700$$ENDHEX$$#()[\]{}$$HEX1$$e700$$ENDHEX$$=\_\+\-\*/%\$$$HEX2$$ac20a300$$ENDHEX$$&@\.:;!\?<>\\ ]+$" )

	/*------------------------------------------------------------------*/
	/* Tout avec quote                                                  */
	/*------------------------------------------------------------------*/
	Case 2
		bRet = Match ( asTexte , "^[A-Za-z0-9$$HEX9$$e900e800e000f900fb00e200f400ea00ee00$$ENDHEX$$|$$HEX1$$a700$$ENDHEX$$#()[\]{}$$HEX1$$e700$$ENDHEX$$=\_\'\+\-\*/%\$$$HEX2$$ac20a300$$ENDHEX$$&@\.:;!\?<>\\ ]+$" )

	/*------------------------------------------------------------------*/
	/* Alphanum$$HEX1$$e900$$ENDHEX$$rique avec espace et sans la Quote.                     */
	/* Utilis$$HEX2$$e9002000$$ENDHEX$$pour Nom, pr$$HEX1$$e900$$ENDHEX$$nom (Valable uniquement pour Gupta SQLBase).*/
	/*------------------------------------------------------------------*/
	Case 3
		bRet = Match ( asTexte , "^[a-zA-Z0-9\- ]+$" )

	/*------------------------------------------------------------------*/
	/* Alphanum$$HEX1$$e900$$ENDHEX$$rique sans espace                                       */
	/*------------------------------------------------------------------*/
	Case 4
		bRet = Match ( asTexte , "^[a-zA-Z0-9]+$" )

	/*------------------------------------------------------------------*/
	/* Alphab$$HEX1$$e900$$ENDHEX$$tique                                                     */
	/*------------------------------------------------------------------*/
	Case 5
		bRet = Match ( asTexte , "^[a-zA-Z]+$" )

	/*------------------------------------------------------------------*/
	/* num$$HEX1$$e900$$ENDHEX$$rique                                                        */
	/* Utilis$$HEX2$$e9002000$$ENDHEX$$pour T$$HEX1$$e900$$ENDHEX$$l$$HEX1$$e900$$ENDHEX$$phone avec format XX XX XX XX XX			        */
	/*------------------------------------------------------------------*/
	Case 6
		bRet = Match ( asTexte , "^[0-9]+$" )

	/*------------------------------------------------------------------*/
	/* Alphanum$$HEX1$$e900$$ENDHEX$$rique avec espace et Quote.                             */
	/* Utilis$$HEX2$$e9002000$$ENDHEX$$pour Nom, pr$$HEX1$$e900$$ENDHEX$$nom (Valable uniquement pour SQL Server).   */
	/*------------------------------------------------------------------*/
	Case 7
		bRet = Match ( asTexte , "^[a-zA-Z0-9\'\- ]+$" )
		
	/*------------------------------------------------------------------*/
	/* Alphanum$$HEX1$$e900$$ENDHEX$$rique.							                             */
	/* Utilis$$HEX2$$e9002000$$ENDHEX$$pour email															  */
	/*------------------------------------------------------------------*/
	Case 8
		bRet = Match ( asTexte , "^[A-Za-z0-9\_\-\.]+$" )

		lTot = Len ( asTexte ) 

		For lcpt = 1 To lTot
			If Mid ( asTexte, lcpt, 1 ) = '@' Then
				lTrouveA ++
			End IF
			If lTrouveA > 0 Then
				If Mid ( asTexte, lcpt, 1 ) = '.' Then
					lTrouveB ++
				End IF
			End If
		Next
		
		If lTrouveA <> 1 Or lTrouveB = 0 Then
			bret = False
		Else
			bret = true
		End If
	End Choose

End If

Return ( bRet )
end function

public function boolean uf_f_iban (string asidiban, string asaction, ref long alcle);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_gfp_standard::uf_f_iban
//* Auteur			: PHG
//* Date				: 30/04/2008
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Appel de la fonction standard de calcul/v$$HEX1$$e900$$ENDHEX$$rification de l'Iban
//* Commentaires	: 
//*
//* Arguments		: value string asidiban	 */
//* 	value string asaction	 */
//* 	ref long alcle	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

long lCle

lCle = SQLCA.SPB_FN_IBAN(asIdIban, asAction)
alCle = lCle

return  ( (asAction = 'V' and lcle = 1 ) or (lCle > 0 and asAction = 'C') ) and SQLCA.SQLCode = 0

end function

on n_cst_gfp_standard.create
call super::create
end on

on n_cst_gfp_standard.destroy
call super::destroy
end on

