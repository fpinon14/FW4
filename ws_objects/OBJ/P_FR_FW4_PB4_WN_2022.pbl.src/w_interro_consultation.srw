HA$PBExportHeader$w_interro_consultation.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre anc$$HEX1$$ea00$$ENDHEX$$tre pour toutes les fen$$HEX1$$ea00$$ENDHEX$$tres d'interrogation en consultation
forward
global type w_interro_consultation from w_interro
end type
end forward

global type w_interro_consultation from w_interro
end type
global w_interro_consultation w_interro_consultation

type variables

end variables

forward prototypes
public function long wf_construirechaine ()
end prototypes

public function long wf_construirechaine ();//*******************************************************************************************
// Fonction            	: wf_ConstruireChaine
//	Auteur              	: Le Recrue
//	Date 					 	: 15/01/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Construction de la chaine SQL pour la consultation
//
// Arguments				: 
//
// Retourne					: Long	
//								  
//*******************************************************************************************
// PLJ	03/10/2001		MODIFICATION pour prise en compte moteur SQL-SERVER
// JFF   06/02/2013     [PI038_CHIFFREMENT]
//*******************************************************************************************


Long lRet, lCpt, lCpt2, lPos
String sVal[]
String sText[], sOperande, sClause[], sTextFrancais[], sOperandeFrancais, sClauseFrancais[]
String sDbText
String sValDate, sMoteur, sValDateTime1, sValDateTime2, sValTime
Integer iCleValeur 
Integer iPos1, iPos2
String  sValIdAdh

lRet = 1

sMoteur = Left ( Upper ( istInterro.wAncetre.istPass.trTrans.DBMS ), 3 )



Choose Case  sMoteur
	Case "GUP"
		sValDate = "mm-dd-yyyy"
		sValDateTime1	= " 00:00:00:000000"
		sValDateTime2	= " 23:59:59:999999"
		sValTime			= "hh:mm:ssss"
		
	Case "MSS"
		sValDate = "dd/mm/yyyy"
		sValDateTime1	= " 00:00:00.00"
		sValDateTime2	= " 23:59:59.99"
		sValTime			= "hh:mm:ss.ff"

	// [MIGPB11] [EMD] : Debut Migration : support du DBMS SNC
	Case "SNC"
		sValDate = "dd/mm/yyyy"
		sValDateTime1	= " 00:00:00.000"
		sValDateTime2	= " 23:59:59.999"
		sValTime			= "hh:mm:ss.fff"
		// on se met dans les memes conditions que le moteur MSS
		sMoteur = "MSS"
	// [MIGPB11] [EMD] : Fin Migration

	// [PI056] MSS moteur par d$$HEX1$$e900$$ENDHEX$$faut
	Case Else
		sValDate = "dd/mm/yyyy"
		sValDateTime1	= " 00:00:00.000"
		sValDateTime2	= " 23:59:59.999"
		sValTime			= "hh:mm:ss.fff"
		// on se met dans les memes conditions que le moteur MSS
		sMoteur = "MSS"
		
End Choose

// .... Initialisation de isClause $$HEX2$$e0002000$$ENDHEX$$Vide

isClause = ""
isClauseFrancais = ""

For	lCpt = 1 To ilNbrCol

		Choose Case istInterro.sData[ lCpt ].sType

		Case "STRING"
			sVal[ lCpt ] = dw_1.GetItemString( 1, istInterro.sData[ lCpt ].sNom )
			If	IsNull( sVal[ lCpt ] ) Or sVal[ lCpt ] = "" Or sVal[ lCpt ] = "01/01/1900" Or sVal[ lCpt ] = "NULL" Or sVal[ lCpt ] = "NOT NULL" Then 
				Continue
			Else
				sVal[ lCpt ] = "'" + sVal[ lCpt ] + "'"
			End If

		Case "DATE"
			sVal[ lCpt ] = String( dw_1.GetItemDate( 1, istInterro.sData[ lCpt ].sNom ), sValDate )
			If sMoteur = 'MSS' Then sVal [lCpt] = "'" + sVal[lCpt] + "'"

		Case "DATETIME"

			sVal[ lCpt ] = String( dw_1.GetItemDateTime( 1, istInterro.sData[ lCpt ].sNom ), sValDate )
			If	IsNull( sVal[ lCpt ] ) Or sVal[ lCpt ] = "" Or sVal[ lCpt ] = "01/01/1900" Then
				Continue
			Else
				Choose Case istInterro.sData[ lCpt ].sOperande 
				Case ">=", ">"
					sVal[ lCpt ] = sVal[ lCpt ] + sValDateTime1

				Case "<=", "<"
					sVal[ lCpt ] = sVal[ lCpt ] + sValDateTime2
				End Choose
			End If
			If sMoteur = 'MSS' Then sVal [lCpt] = "'" + sVal[lCpt] + "'"


		Case "TIME"
			sVal[ lCpt ] = String( dw_1.GetItemTime( 1, istInterro.sData[ lCpt ].sNom ), sValTime )

		Case "NUMBER"
/*------------------------------------------------------------------*/
/* Le 18/08/1997                                                    */
/* Modification pour la prise en compte des valeurs de cl$$HEX2$$e9002000$$ENDHEX$$en       */
/* num$$HEX1$$e900$$ENDHEX$$rique.                                                       */
/* Dans la structure d'interro, on laisse le type en number.        */
/* Dans la DW d'interro, on met le type en CHAR, pour pouvoir       */
/* saisir "*".                                                      */
/* Dans la structure d'interro, on renseigne la zone sMoteur avec   */
/* "MSS".                                                           */
/* Dans ce cas pr$$HEX1$$e900$$ENDHEX$$cis, on effectuera un convert.                    */
/*------------------------------------------------------------------*/

			If	istInterro.sData[ lCpt ].sMoteur = "MSS" Then
				sVal[ lCpt ] = dw_1.GetItemString ( 1, istInterro.sData[ lCpt ].sNom )
				If	Not IsNumber ( sVal[ lCpt ] ) Then
					sVal[ lCpt ] = "'" + sVal[ lCpt ] + "'"
				End If
			Else
				sVal[ lCpt ] = String ( dw_1.GetItemNumber ( 1, istInterro.sData[ lCpt ].sNom ) )
			End If

		End Choose

Next

For	lCpt = 1 To ilNbrCol

		If	IsNull( sVal[ lCpt ] ) Or sVal[ lCpt ] = "" Or sVal[ lCpt ] = "01/01/1900" Then
			Continue
		Else

			sOperande = istInterro.sData[ lCpt ].sOperande

// .... D$$HEX1$$e900$$ENDHEX$$termination si la cha$$HEX1$$ee00$$ENDHEX$$ne contient "*"

			lPos = Pos( sVal[ lCpt ], "*" )

			If	lPos > 0 Then

				sVal[ lCpt ] = Left( sVal[ lCpt ], ( lPos - 1 ) ) + "%'"

				If	sOperande = "<>" Then
					sOperande = "Not like"
					sOperandeFrancais = "ne commence pas par"
				Else
					sOperande = "like"
					sOperandeFrancais = "commence par"
				End If
			
			Else

// .... D$$HEX1$$e900$$ENDHEX$$termination si la cha$$HEX1$$ee00$$ENDHEX$$ne contient "NULL" ou "NOT NULL"

				If	sVal[ lCpt ] = "NULL" Or sVal[ lCpt ] = "NOT NULL" Then
					sOperande = "is"
					sOperandeFrancais = "est"
				End If

			End If

			If ( UpperBound( sClause ) < UpperBound( istInterro.sData[ lCpt ].sDbNameConsult ) ) Then

				sClause[ UpperBound( istInterro.sData[ lCpt ].sDbNameConsult ) ] = ""

			End If

			For lCpt2 = 1 to UpperBound( istInterro.sData[ lCpt ].sDbNameConsult )

				If ( istInterro.sData[ lCpt ].sDbNameConsult[lCpt2] <> "" ) Then

					/*----------------------------------------------------------------------------*/
					/* Le 16/09/97 - YP : Modification pour prendre en compte le '*' avec SQL     */
					/* SERVER dans les cl$$HEX1$$e900$$ENDHEX$$s.                                                      */
					/*----------------------------------------------------------------------------*/
					If istInterro.sData[ lCpt ].sMoteur = "MSS" And Not IsNumber ( sVal[ lCpt ] ) Then
					   sDBText = "CONVERT ( VARCHAR( 35 ), " + istInterro.sData[ lCpt ].sDbNameConsult[lCpt2] + " )"
					Else
					   sDBText = istInterro.sData[ lCpt ].sDbNameConsult[lCpt2]
					End If

					sText[lCpt2] =	sDBText															+ " " + &
										sOperande 														+ " " + &
										sVal[ lCpt ]

					sTextFrancais[lCpt2]	= istInterro.sData[ lCpt ].sDbNameConsult[lCpt2]	+ " " 	+ &
												  sOperandeFrancais											+ " " 	+ &
												  sVal[ lCpt ]

					If	( sClause[lCpt2] = "" ) Then
						sClause[lCpt2]				=	sText[lCpt2]
						sClauseFrancais[lCpt2]	=	sTextFrancais[lCpt2]
					Else
						sClause[lCpt2] = sClause[lCpt2] + " AND " + sText[lCpt2]
						sClauseFrancais[lCpt2]	=	sClauseFrancais[lCpt2] + " et " + sTextFrancais[lCpt2]
					End If

				Else

					sText[lCpt2] = ""
					sTextFrancais[lCpt2] = ""

				End If

			Next

			
		End If
Next

// .... Positionnement du WHERE pour chaque clause
If UpperBound( sClause ) > 0 Then
	For lCpt = 1 To UpperBound( sClause )
		If sClause[lCpt] <> "" Then
			If	( isClause = "" ) Then
				isClause = " WHERE " + sClause[lCpt]
				isClauseFrancais = " " + sClauseFrancais[lCpt]
			Else
				isClause = isClause + " WHERE " + sClause[lCpt]
				isClauseFrancais = isClauseFrancais + " " + sClauseFrancais[lCpt]
			End If
		End If
		isClause = isClause + "~t"
		isClauseFrancais = isClauseFrancais + "~r~n"
	Next
End If



Return( lRet )

end function

on w_interro_consultation.create
int iCurrent
call super::create
end on

on w_interro_consultation.destroy
call super::destroy
end on

type cb_debug from w_interro`cb_debug within w_interro_consultation
end type

type uo_1 from w_interro`uo_1 within w_interro_consultation
end type

type dw_1 from w_interro`dw_1 within w_interro_consultation
end type

