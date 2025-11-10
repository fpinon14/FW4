HA$PBExportHeader$n_cst_crypter_base256.sru
forward
global type n_cst_crypter_base256 from n_cst_crypter
end type
end forward

global type n_cst_crypter_base256 from n_cst_crypter
end type
global n_cst_crypter_base256 n_cst_crypter_base256

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
//* MAJ PAR		Date		Modification
//* #1  FS    21/02/2002 Recopie de cette fonction en PB4 pour hamonisation
//*                      De la m$$HEX1$$e900$$ENDHEX$$thode de codage des mots de passe				  
//* #2  PHG	  26/06/2009 [SESAME2009] Adaptation de la fonction pour une
//*							 prise en compte d'une plus grande plage de
//*							 caract$$HEX1$$e800$$ENDHEX$$re.
//* #3  SBA		23/10/2009	[SESAME_PWD].1.1.5 Nouvelle classe
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Plage de caract$$HEX1$$e800$$ENDHEX$$res pouvant $$HEX1$$ea00$$ENDHEX$$tre cod$$HEX1$$e900$$ENDHEX$$e.								  */
/*------------------------------------------------------------------*/
Int K_BORNMIN	  = 33   // Borne ASCII Minimum
Int K_BORNMAX	  = 254  // Borne ASCII Maximum //124 #2 [SESAME2009]

Int		iRet = 1 	  				// Retour
Int		iCle			  				// Valeur de cl$$HEX1$$e900$$ENDHEX$$
Int		iMilChaine    				// Milieu de la cha$$HEX1$$ee00$$ENDHEX$$ne
Int		iVal, iVal2, iVal3 	  	// Valeurs enti$$HEX1$$e800$$ENDHEX$$res
Int		iCpt			  				// Compteur entier
Int		iSeconde						// Seconde en cours
Long		lCpt			  				// Compteur Long
String	sCopChaine[]  				// Copie de la Chaine pass$$HEX1$$e900$$ENDHEX$$e en argument en 2 tableau
String	sCarCle		  				// Symbole repr$$HEX1$$e900$$ENDHEX$$sentant la cl$$HEX1$$e900$$ENDHEX$$
Int		iQuartPlage[3]				// Valeurs possible de cl$$HEX2$$e9002000$$ENDHEX$$( Plage de caractere / 4 )
Int		iTiersPlage[2]				// Plage de cryptage possible ( Plage de caractere / 3 )

// #2 [SESAME2009] Calcul Pr$$HEX1$$e900$$ENDHEX$$liminaire des Quart de plage et Tiers de Plage
For iCpt = 1 to 3
	iQuartPlage[iCpt] = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * iCpt
	if iCpt < 3 Then iTiersPlage[iCpt] = K_BORNMIN + ( ( K_BORNMAX - K_BORNMIN ) / 3 ) * iCpt
Next 
//

/*------------------------------------------------------------------*/
/* La cha$$HEX1$$ee00$$ENDHEX$$ne ne doit pas $$HEX1$$ea00$$ENDHEX$$tre vide.											  */
/*------------------------------------------------------------------*/
If asChaine = "" Then iRet = -1

/*------------------------------------------------------------------*/
/* CRYPTAGE de la Cha$$HEX1$$ee00$$ENDHEX$$ne														  */
/*------------------------------------------------------------------*/
If abSwitch then


	// Tous les caract$$HEX1$$e800$$ENDHEX$$res doivent $$HEX1$$ea00$$ENDHEX$$tre dans la plage d$$HEX1$$e900$$ENDHEX$$finie.
	iVal = LenA ( asChaine ) 
	For lCpt = 1 to iVal
	
		iVal2 = AscA (MidA ( asChaine, lCpt, 1) )
		If iVal2 < K_BORNMIN or iVal2 > K_BORNMAX Then
			iRet = -2
			Exit
		End If
	
	Next
	
	If iRet = 1 Then
	
		// D$$HEX1$$e900$$ENDHEX$$termination de la cl$$HEX1$$e900$$ENDHEX$$
		iSeconde = Integer ( Right ( String ( Now () ), 1 ) )
		If iSeconde < 4 Then	
			iCle = iQuartPlage[1]  //( K_BORNMAX - K_BORNMIN ) / 4 // #2 [SESAME2009]
		ElseIf iSeconde > 3 and iSeconde < 7 Then	
			iCle = iQuartPlage[2 ] //( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 2 // #2 [SESAME2009]
		ElseIf iSeconde > 6 and iSeconde < 10 Then
			iCle = iQuartPlage[3] //( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 3 // #2 [SESAME2009]
		End If
	
		
		// D$$HEX1$$e900$$ENDHEX$$termination du Symbole qui repr$$HEX1$$e900$$ENDHEX$$sentera la cl$$HEX2$$e9002000$$ENDHEX$$dans la future chaine crypt$$HEX1$$e900$$ENDHEX$$e
		Randomize ( 0 )
		sCarcle = ""
		Do While sCarCle = "" 
			iVal = Rand ( K_BORNMAX - K_BORNMIN ) + K_BORNMIN
// #2 [SESAME2009]	
//			If ( iCle = ( K_BORNMAX - K_BORNMIN ) / 4 )         and ( iVal >= K_BORNMIN and iVal <= K_BORNMIN + 30  ) Or & 
//				( iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 2 ) and ( iVal > K_BORNMIN + 30 and iVal <= K_BORNMIN + 60  ) Or & 
//				( iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 3 ) and ( iVal > K_BORNMIN + 60  ) Then  
			If ( iCle = iQuartPlage[1] and ( iVal >= K_BORNMIN and iVal <= iTiersPlage[1]  ) ) Or & 
				( iCle = iQuartPlage[2] and ( iVal > iTiersPlage[1] and iVal <= iTiersPlage[2] ) ) Or & 
				( iCle = iQuartPlage[3] and ( iVal > iTiersPlage[2] ) ) Then  
				
				sCarCle = CharA ( iVal )
				
			End If
		Loop
		
		
		// D$$HEX1$$e900$$ENDHEX$$coupage de la cha$$HEX1$$ee00$$ENDHEX$$ne en deux
		iMilChaine = Int ( LenA ( asChaine ) / 2 )
		sCopChaine [1] = LeftA ( asChaine, iMilChaine )
		sCopChaine [2] = RightA ( asChaine, LenA ( asChaine) - iMilChaine )
		
		asChaine = ""

		// Cryptage des caract$$HEX1$$e800$$ENDHEX$$res		
		For iVal = 2 to 1 Step -1
			
			iVal2 = LenA ( sCopChaine [ iVal ] )
			For lCpt = 1 to iVal2
	
				If Mod ( lCpt, 2 ) = 0 then
					iVal3 = AscA ( MidA ( sCopChaine [ iVal ], lcpt, 1 ) ) + iCle
	
					If iVal3 > K_BORNMAX Then
						iVal3 = ( iVal3 - K_BORNMAX ) + K_BORNMIN - 1
					End If
	
				Else
					iVal3 = AscA ( MidA ( sCopChaine [ iVal ], lcpt, 1 ) ) - iCle
	
					If iVal3 < K_BORNMIN Then
						iVal3 = K_BORNMAX - ( K_BORNMIN - iVal3 ) + 1
					End If
	
				End If
				
				
				asChaine = asChaine + CharA ( iVal3 )
				
			Next
			
			// On ajoute la cl$$HEX4$$e9002000e0002000$$ENDHEX$$la fin de la premi$$HEX1$$e800$$ENDHEX$$re cha$$HEX1$$ee00$$ENDHEX$$ne
			If iVal = 2 Then
				asChaine = asChaine + sCarCle
			End If
			
		Next
	
	End If

End If


/*------------------------------------------------------------------*/
/* DECRYPTAGE de la Cha$$HEX1$$ee00$$ENDHEX$$ne														  */
/*------------------------------------------------------------------*/
If Not abSwitch then
	
	// D$$HEX1$$e900$$ENDHEX$$coupage de la cha$$HEX1$$ee00$$ENDHEX$$ne en deux
	iVal = LenA ( asChaine ) 
	If Mod ( iVal, 2 ) = 0 Then
		iMilChaine = ( LenA ( asChaine ) / 2 ) + 1
	Else
		iMilChaine = Int ( LenA ( asChaine ) / 2 ) + 1
	End If

	// Recherche du caract$$HEX1$$e800$$ENDHEX$$re symbolisant la cl$$HEX2$$e9002000$$ENDHEX$$cach$$HEX1$$e900$$ENDHEX$$e
	sCarCle = MidA ( asChaine, iMilChaine, 1 )
	
	sCopChaine [1] = RightA ( asChaine, LenA ( asChaine) - iMilChaine )
	
	// -1 car on enl$$HEX1$$e800$$ENDHEX$$ve la cl$$HEX1$$e900$$ENDHEX$$
	sCopChaine [2] = LeftA ( asChaine, iMilChaine - 1 )
	
	asChaine = ""

	// D$$HEX1$$e900$$ENDHEX$$chiffrage du symbole de cl$$HEX2$$e9002000$$ENDHEX$$afin d'en extraire la cl$$HEX2$$e9002000$$ENDHEX$$elle-m$$HEX1$$ea00$$ENDHEX$$me.
	iVal = AscA ( sCarCle )
	// #2 [SESAME2009] Passage de Borne Absolue en bornes relatives $$HEX2$$e0002000$$ENDHEX$$la plage
//	If iVal >= K_BORNMIN and iVal <= K_BORNMIN + 30 Then	
//		iCle = ( K_BORNMAX - K_BORNMIN ) / 4 
//	ElseIf iVal > K_BORNMIN + 30 and iVal <= K_BORNMIN + 60 Then
//		iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 2
//	ElseIf iVal > K_BORNMIN + 60   Then 
//		iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 3
//	End If
	If iVal >= K_BORNMIN and iVal <= iTiersPlage[1] Then
		iCle = iQuartPlage[1]
	ElseIf iVal > iTiersPlage[1] and iVal <= iTiersPlage[2] Then
		iCle = iQuartPlage[2]
	ElseIf iVal > iTiersPlage[2] Then
		iCle = iQuartPlage[3]
	End If

	// D$$HEX1$$e900$$ENDHEX$$cryptage des caract$$HEX1$$e800$$ENDHEX$$res
	For iVal = 1 to 2 
		
		iVal2 = LenA ( sCopChaine [ iVal ] )
		For lCpt = 1 to iVal2

			If Mod ( lCpt, 2 ) = 0 then
				iVal3 = AscA ( MidA ( sCopChaine [ iVal ], lcpt, 1 ) ) - iCle

				If iVal3 < K_BORNMIN Then
					iVal3 = K_BORNMAX - ( K_BORNMIN - iVal3 ) + 1
				End If

			Else
				iVal3 = AscA ( MidA ( sCopChaine [ iVal ], lcpt, 1 ) ) + iCle

				If iVal3 > K_BORNMAX Then
					iVal3 = ( iVal3 - K_BORNMAX ) + K_BORNMIN - 1
				End If

			End If
			
			asChaine = asChaine + CharA ( iVal3 )
			
		Next
		
	Next
		
End If

Return iRet

end function

on n_cst_crypter_base256.create
call super::create
end on

on n_cst_crypter_base256.destroy
call super::destroy
end on

