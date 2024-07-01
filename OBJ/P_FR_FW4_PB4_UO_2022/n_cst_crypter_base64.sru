HA$PBExportHeader$n_cst_crypter_base64.sru
forward
global type n_cst_crypter_base64 from n_cst_crypter
end type
end forward

global type n_cst_crypter_base64 from n_cst_crypter
end type
global n_cst_crypter_base64 n_cst_crypter_base64

type variables
private:

byte map1[0 to 63]
byte map2[0 to 127]
string is_lasterror
end variables

forward prototypes
public function integer uf_crypter (ref string aschaine, boolean abswitch)
public function string uf_encode (blob abl_data)
public function long of_bitwiseand (long al_value1, long al_value2)
public function boolean of_getbit (long al_decimal, unsignedinteger ai_bit)
public function long of_bitwiseor (long al_value1, long al_value2)
public function blob uf_decode (string as_input)
public function string uf_decode_to_utf8 (string as_data)
public function string uf_encode_in_utf8 (string as_data)
public function integer uf_crypter_utf8 (ref string aschaine, boolean abswitch)
public subroutine uf_init ()
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
//* #1 SBA		23/10/2009	[SESAME_PWD].1.1.5 Nouvelle classe				  
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Plage de caract$$HEX1$$e800$$ENDHEX$$res pouvant $$HEX1$$ea00$$ENDHEX$$tre cod$$HEX1$$e900$$ENDHEX$$e.								  */
/*------------------------------------------------------------------*/
Constant Int K_BORNMIN	  = 32   // Borne ASCII Minimum
Constant Int K_BORNMAX	  = 124  // Borne ASCII Maximum

Int		iRet = 1 	  				// Retour
Int		iCle			  				// Valeur de cl$$HEX1$$e900$$ENDHEX$$
Int		iMilChaine    				// Milieu de la cha$$HEX1$$ee00$$ENDHEX$$ne
Int		iVal, iVal2, iVal3 	  	// Valeurs enti$$HEX1$$e800$$ENDHEX$$res
Int		iCpt			  				// Compteur entier
Int		iSeconde						// Seconde en cours
Long		lCpt			  				// Compteur Long
String	sCopChaine[]  				// Copie de la Chaine pass$$HEX1$$e900$$ENDHEX$$e en argument en 2 tableau
String	sCarCle		  				// Symbole repr$$HEX1$$e900$$ENDHEX$$sentant la cl$$HEX1$$e900$$ENDHEX$$

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
	
		iVal2 = AscA ( MidA ( asChaine, lCpt, 1) )
		If iVal2 < K_BORNMIN or iVal2 > K_BORNMAX Then
			iRet = -2
			Exit
		End If
	
	Next

	
	If iRet = 1 Then
	
		// D$$HEX1$$e900$$ENDHEX$$termination de la cl$$HEX1$$e900$$ENDHEX$$
		iSeconde = Integer ( RightA ( String ( Now () ), 1 ) )
		If iSeconde < 4 Then	
			iCle = ( K_BORNMAX - K_BORNMIN ) / 4
		ElseIf iSeconde > 3 and iSeconde < 7 Then	
			iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 2
		ElseIf iSeconde > 6 and iSeconde < 10 Then
			iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 3
		End If
	
		
		// D$$HEX1$$e900$$ENDHEX$$termination du Symbole qui repr$$HEX1$$e900$$ENDHEX$$sentra la cl$$HEX2$$e9002000$$ENDHEX$$dans la future chaine crypt$$HEX1$$e900$$ENDHEX$$e
		Randomize ( 0 )
		sCarcle = ""
		Do While sCarCle = "" 
			iVal = Rand ( K_BORNMAX - K_BORNMIN ) + K_BORNMIN
	
			If ( iCle = ( K_BORNMAX - K_BORNMIN ) / 4 )         and ( iVal >= K_BORNMIN and iVal <= K_BORNMIN + 30  ) Or & 
				( iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 2 ) and ( iVal > K_BORNMIN + 30 and iVal <= K_BORNMIN + 60  ) Or & 
				( iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 3 ) and ( iVal > K_BORNMIN + 60  ) Then  
				
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
	If iVal >= K_BORNMIN and iVal <= K_BORNMIN + 30  Then	
		iCle = ( K_BORNMAX - K_BORNMIN ) / 4
	ElseIf iVal > K_BORNMIN + 30 and iVal <= K_BORNMIN + 60 Then	
		iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 2
	ElseIf iVal > K_BORNMIN + 60   Then
		iCle = ( ( K_BORNMAX - K_BORNMIN ) / 4 ) * 3
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

public function string uf_encode (blob abl_data);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_encode
//* Acc$$HEX1$$e800$$ENDHEX$$s			: Public
//* Auteur			: FPI
//* Date				: 08/03/2019
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cryptage d'une cha$$HEX1$$ee00$$ENDHEX$$ne de caract$$HEX1$$e800$$ENDHEX$$re UTF8
//* Commentaires	:  Encodes a byte array into Base64 format.
// 						   No blanks or line breaks are inserted.
//*                 
//*
//* Arguments		: abl_data: a blob containing the data bytes to be encoded.
//*																					
//*
//* Retourne		:  a string with the Base64 encoded data.
//*-----------------------------------------------------------------

long ll_InLen    //input length
long ll_ODataLen  //output length without padding
long ll_OLen    //output length including padding
long ip, op
byte lb_out[]
byte i0, i1, i2, o0, o1, o2, o3
string ls_buf

//is_lasterror = ""

ll_InLen = len(abl_data)
if ll_InLen = 0 then return ""

ll_ODataLen = (ll_InLen * 4 + 2) / 3
ll_OLen = int((ll_InLen + 2) / 3) * 4

ls_buf = space(ll_OLen)
//we need only half of the buffer, as the space() returns an utf-16 string
lb_out = GetByteArray(blobmid(blob(ls_buf), 1, ll_OLen)) 

ip = 1
op = 1
Do While ip <= ll_InLen
  getbyte(abl_data, ip, i0); ip++
  If ip <= ll_InLen Then 
    getbyte(abl_data, ip, i1); ip++ 
  Else 
    i1 = 0
  end if
  If ip <= ll_InLen Then 
    getbyte(abl_data, ip, i2); ip++ 
  Else 
    i2 = 0
  end if
  o0 = int(i0 / 4)
  o1 = of_bitwiseor(of_bitwiseand(i0, 3) * 16, int(i1 / 16))
  o2 = of_bitwiseor(of_bitwiseand(i1, 15) * 4, int(i2 / 64))
  o3 = of_bitwiseand(i2, 63)
  lb_out[op] = Map1[o0]; op++
  lb_out[op] = Map1[o1]; op++
  if op <= ll_ODataLen then lb_out[op] = Map1[o2] else lb_out[op] = asc('=')
  op++
  if op <= ll_ODataLen then lb_out[op] = Map1[o3] else lb_out[op] = asc('=')
  op++
Loop

return string(blob(lb_out), EncodingANSI!)

end function

public function long of_bitwiseand (long al_value1, long al_value2);//////////////////////////////////////////////////////////////////////////////
//
// Function:      of_BitwiseAnd
//
// Access:        public
//
// Arguments:
// al_Value1      The first value to be used in the operation. (e.g. 55)
// al_Value2      The second value to be used in the operation. (e.g. 44)
//
// Returns:       Long
//                The result of the AND operation (e.g. 36)
//                If either argument's value is NULL, function returns NULL.
//
// Description:   Performs a bitwise AND operation (al_Value1 && al_Value2),
//                which ANDs each bit of the values.
//                (55 && 44) = 36
//
//////////////////////////////////////////////////////////////////////////////
//
// Revision History
//
// Version
// 5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

Integer     li_Cnt
Long        ll_Result
Boolean     lb_Value1[32], lb_Value2[32]

// Check for nulls
If IsNull(al_Value1) Or IsNull(al_Value2) Then
   SetNull(ll_Result)
   Return ll_Result
End If

// Get all bits for both values
For li_Cnt = 1 To 32
	lb_Value1[li_Cnt] = of_getbit(al_Value1, li_Cnt)
   	lb_Value2[li_Cnt] = of_getbit(al_Value2, li_Cnt)
Next

// And them together
For li_Cnt = 1 To 32
   If lb_Value1[li_Cnt] And lb_Value2[li_Cnt] Then
      ll_Result = ll_Result + (2^(li_Cnt - 1))
   End If
Next

Return ll_Result

end function

public function boolean of_getbit (long al_decimal, unsignedinteger ai_bit);//////////////////////////////////////////////////////////////////////////////
//
// Function:      of_GetBit
//
// Access:        public
//
// Arguments:
// al_decimal     Decimal value whose on/off value needs to be determined (e.g. 47).
// ai_bit         Position bit from right to left on the Decimal value.
//
// Returns:       boolean
//                True if the value is On.
//                False if the value is Off.
//                If any argument's value is NULL, function returns NULL.
//
// Description:   Determines if the nth binary bit of a decimal number is 
//                1 or 0.
//
//////////////////////////////////////////////////////////////////////////////
//
// Revision History
//
// Version
// 5.0   Initial version
// 5.0.03   Fixed problem when dealing with large numbers (>32k)
//          from "mod int" to "int mod"
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

Boolean lb_null

//Check parameters
If IsNull(al_decimal) or IsNull(ai_bit) then
   SetNull(lb_null)
   Return lb_null
End If

//Assumption ai_bit is the nth bit counting right to left with
//the leftmost bit being bit one.
//al_decimal is a binary number as a base 10 long.
If Int(Mod(al_decimal / (2 ^(ai_bit - 1)), 2)) > 0 Then
   Return True
End If

Return False

end function

public function long of_bitwiseor (long al_value1, long al_value2);//////////////////////////////////////////////////////////////////////////////
//
// Function:      of_BitwiseOr
//
// Access:        public
//
// Arguments:
// al_Value1      The first value to be used in the operation (e.g. 55).
// al_Value2      The second value to be used in the operation (e.g. 44).
//
// Returns:       Long
//                The result of the OR operation (e.g. 63).
//                If either argument's value is NULL, function returns NULL.
//
// Description:   Performs a bitwise OR operation (al_Value1 || al_Value2),
//                which ORs each bit of the values.
//                (55 || 44) = 63
//
//////////////////////////////////////////////////////////////////////////////
//
// Revision History
//
// Version
// 5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

Integer     li_Cnt
Long        ll_Result
Boolean     lb_Value1[32], lb_Value2[32]

// Check for nulls
If IsNull(al_Value1) Or IsNull(al_Value2) Then
   SetNull(ll_Result)
   Return ll_Result
End If

// Get all bits for both values
For li_Cnt = 1 To 32
   lb_Value1[li_Cnt] = of_getbit(al_Value1, li_Cnt)
   lb_Value2[li_Cnt] = of_getbit(al_Value2, li_Cnt)
Next

// Or them together
For li_Cnt = 1 To 32
   If lb_Value1[li_Cnt] Or lb_Value2[li_Cnt] Then
      ll_Result = ll_Result + (2^(li_Cnt - 1))
   End If
Next

Return ll_Result

end function

public function blob uf_decode (string as_input);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_decode
//* Acc$$HEX1$$e800$$ENDHEX$$s			: Public
//* Auteur			: FPI
//* Date				: 08/03/2019
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: D$$HEX1$$e900$$ENDHEX$$cryptage d'une cha$$HEX1$$ee00$$ENDHEX$$ne de caract$$HEX1$$e800$$ENDHEX$$re UTF8
//* Commentaires	:  Decodes a byte array into Base64 format.
// 						   No blanks or line breaks are inserted.
//*                 
//*
//* Arguments		: abl_data: a blob containing the data bytes to be encoded.
//*																					
//*
//* Retourne		:  a string with the Base64 encoded data.
//*-----------------------------------------------------------------

long ll_ILen, ll_OLen
long ip, op
blob lbl_ret
byte lb_ibuf[], lb_out[]
byte i0, i1, i2, i3, b0, b1, b2, b3, o0, o1, o2
string ls_tmp

is_lasterror = ""
as_input = righttrim(as_input, true)

ll_ILen = len(as_input)
if mod(ll_ILen, 4) <> 0 then
  is_lasterror = "Length of Base64 encoded input string is not a multiple of 4."
  return lbl_ret
end if

Do While ll_ILen > 0
  If mid(as_input, ll_ILen, 1) <> "=" Then Exit //Do
  ll_ILen --
Loop

ll_OLen = (ll_ILen * 3) / 4
ls_tmp = space(ll_olen)
lb_ibuf = GetByteArray(blob(as_input, EncodingANSI!))
lb_out = getbytearray(blobmid(blob(ls_tmp),1,ll_olen))

ip = 1
op = 1
do while ip <= ll_ILen
  i0 = lb_ibuf[ip]; ip ++
  i1 = lb_ibuf[ip]; ip ++
  If ip <= ll_ILen Then 
    i2 = lb_ibuf[ip]; ip ++
  Else 
    i2 = asc("A")
  end if
  If ip <= ll_ILen Then 
    i3 = lb_ibuf[ip]; ip ++
  Else 
    i3 = asc("A")
  end if
  If i0 > 127 Or i1 > 127 Or i2 > 127 Or i3 > 127 Then 
    is_lasterror = "Illegal character in Base64 encoded data."
    return lbl_ret
  end if
  b0 = Map2[i0]
  b1 = Map2[i1]
  b2 = Map2[i2]
  b3 = Map2[i3]
  If b0 > 63 Or b1 > 63 Or b2 > 63 Or b3 > 63 Then 
    is_lasterror = "Illegal character in Base64 encoded data."
    return lbl_ret
  end if
  o0 = of_bitwiseor((b0 * 4), (b1 / 16))
  o1 = of_bitwiseor(of_bitwiseand(b1, 15) * 16, b2 / 4)
  o2 = of_bitwiseor(of_bitwiseand(b2, 3) * 64, b3)
  lb_out[op] = o0; op++
  if op <= ll_olen then lb_out[op] = o1; op++
  if op <= ll_olen then lb_out[op] = o2; op++
loop

return blob(lb_out)


end function

public function string uf_decode_to_utf8 (string as_data);
return string(uf_decode(as_data), EncodingUTF8!)

end function

public function string uf_encode_in_utf8 (string as_data);
// helper to encode a string converted into utf-8 into base64
//
// we save every null byte from the utf-16 encoding 
// so the resulting base64 is smaller

return uf_encode(blob(as_data, EncodingUTF8!))
end function

public function integer uf_crypter_utf8 (ref string aschaine, boolean abswitch);//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Crypter_UTF8
//* Acc$$HEX1$$e800$$ENDHEX$$s			: Public
//* Auteur			: FPI
//* Date				: 08/03/2019
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Cryptage d'une cha$$HEX1$$ee00$$ENDHEX$$ne de caract$$HEX1$$e800$$ENDHEX$$re 
//* Commentaires	: 
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
//*-----------------------------------------------------------------
Integer iRet

/*------------------------------------------------------------------*/
/* La cha$$HEX1$$ee00$$ENDHEX$$ne ne doit pas $$HEX1$$ea00$$ENDHEX$$tre vide.											  */
/*------------------------------------------------------------------*/
If asChaine = "" Then iRet = -1

/*------------------------------------------------------------------*/
/* CRYPTAGE de la Cha$$HEX1$$ee00$$ENDHEX$$ne														  */
/*------------------------------------------------------------------*/
If abSwitch then
	iRet=1
	asChaine=uf_encode_in_utf8( asChaine)
Else
	iRet=1
	asChaine=uf_decode_to_utf8( asChaine)		
End If

Return iRet
end function

public subroutine uf_init ();
uint i,c

// set Map1
i = 0
For c = Asc("A") To Asc("Z")
  Map1[i] = c; i ++
Next
For c = Asc("a") To Asc("z")
  Map1[i] = c; i++
Next
For c = Asc("0") To Asc("9")
  Map1[i] = c; i++
Next
Map1[i] = Asc("+"); i++
Map1[i] = Asc("/"); i++

// set Map2
For i = 0 To 127
  Map2[i] = 255
Next
For i = 0 To 63
  Map2[Map1[i]] = i
Next

is_lasterror = ""
end subroutine

on n_cst_crypter_base64.create
call super::create
end on

on n_cst_crypter_base64.destroy
call super::destroy
end on

event constructor;call super::constructor;uf_init()
end event

