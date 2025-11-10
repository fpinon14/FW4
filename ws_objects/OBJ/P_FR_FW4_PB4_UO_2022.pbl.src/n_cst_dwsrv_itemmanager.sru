HA$PBExportHeader$n_cst_dwsrv_itemmanager.sru
$PBExportComments$[SUISSE].ID_LANG => Cr$$HEX1$$e900$$ENDHEX$$ation d'un service de datawindows etendant les fonctionalit$$HEX2$$e9002000$$ENDHEX$$de base de GetItem et SetITem
forward
global type n_cst_dwsrv_itemmanager from nonvisualobject
end type
end forward

global type n_cst_dwsrv_itemmanager from nonvisualobject
event ue_info ( )
end type
global n_cst_dwsrv_itemmanager n_cst_dwsrv_itemmanager

type variables
datawindow idw_Requestor
end variables

forward prototypes
public function integer of_setrequestor (datawindow adw_requestor)
public function any uf_getitemunknow (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value, any aany_default)
public function any of_getitemany (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value)
public function integer of_setitemany (long al_row, string as_column, string as_value)
public function integer of_setitemany (long al_row, integer ai_column, string as_value)
end prototypes

event ue_info();//////////////////////////////////////////////////////////////////////////////
//
// Event: ue_info
//
// Description:	Evenement de documentation d'objet.
//						
//						Cet objet est un service de datawindows, $$HEX2$$e0002000$$ENDHEX$$l'instar des
//						service de datawindows existant dans les PFC.
//						
//						Il a pour vocation de contenir toutes les methodes
//						$$HEX1$$e900$$ENDHEX$$tendant les capacit$$HEX2$$e9002000$$ENDHEX$$natiives de datawindows $$HEX2$$e0002000$$ENDHEX$$acceder
//						au donn$$HEX1$$e900$$ENDHEX$$e ( GetItem.... et SetItem....  + la notation
//						dw.object.column... 
//						
//						M$$HEX1$$e900$$ENDHEX$$thode Impl$$HEX1$$e900$$ENDHEX$$ment$$HEX1$$e900$$ENDHEX$$e :
//						- SetRequestor  : Enregistrement de la dw utilisatrice du service.
//
// 					- GetItemAny	 : Retourne sous forme d'any un ITem quelconque ( Issu de pfc_n_cst_dwsrv )
//						
//						- SetItemUnknow : Permet de fait un setitem sur un
//						colonne par toujours pr$$HEX1$$e900$$ENDHEX$$sente ( cas de code g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rique
//						avec dataobject par forcement existant )
//						
//						- GetItemUnknow : Permet de fait un Getitem sur un
//						colonne par toujours pr$$HEX1$$e900$$ENDHEX$$sente ( cas de code g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rique
//						avec dataobject par forcement existant )
//
//////////////////////////////////////////////////////////////////////////////
//
// Revision History
//
// Version 1.0 : Initial Version. PHG, le 02/07/2008 [SUISSE].ID_LANG
//
//////////////////////////////////////////////////////////////////////////////

end event

public function integer of_setrequestor (datawindow adw_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetRequestor
//
//	Access:    Public
//
//	Arguments:
//   adw_Requestor   The datawindow requesting the service
//
//	Returns:  None
//
//	Description:  Associates a datawindow control with a datawindow service NVO
//			        by setting the idw_Requestor instance variable.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Added function return code.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

If IsNull(adw_requestor) or Not IsValid(adw_requestor) Then
	Return -1
End If

idw_Requestor = adw_Requestor
Return 1
end function

public function any uf_getitemunknow (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value, any aany_default);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_dwsrv_itemmanager::uf_getitemunknow
//* Auteur			: PHG
//* Date				: 02/07/2008 15:24:59
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Permet de lire une colonne de mani$$HEX1$$e800$$ENDHEX$$re s$$HEX1$$e900$$ENDHEX$$curis$$HEX1$$e900$$ENDHEX$$e
//*					  ( pas de plantage si la colonne n'existe pas )
//* Commentaires	: [SUISSE].ID_LANG => GetItem sur colonne g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$rique
//*
//* Arguments		: value long al_row	 */
/* 	value string as_column	 */
/* 	value dwbuffer adw_buffer	 */
/* 	value boolean ab_orig_value	 */
/*		value any aany_Default	*/	 // Valeur par defaut si champ non trouv$$HEX1$$e900$$ENDHEX$$.
//*
//* Retourne		: any	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

string	sObjectList
any 		AnyNull
any		AnyReturnValue
n_cst_string lnvString

Setnull(anyNull)
if not isvalid(idw_requestor) or isnull(idw_requestor) or &
	lnvString.of_IsEmpty(as_column) or isnull(adw_Buffer) or isnull(ab_orig_value) then
	return AnyNull
End If

sObjectList = lower(idw_Requestor.object.datawindow.objects)

if Pos(sObjectList, lower(as_column) ) > 0 then
	AnyReturnValue = of_GetItemAny(al_row, as_column, adw_buffer, ab_orig_value)
Else
	AnyReturnValue = aany_Default
End If

return AnyReturnValue
	




return 11
end function

public function any of_getitemany (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  of_GetItemAny (FORMAT 4) 
//	Arguments:   	al_row			   : The row reference
//   					as_column    		: The column name reference
//   					adw_buffer   		: The dw buffer from which to get the column's data value.
//   					ab_orig_value		: When True, returns the original values that were 
//							  					  retrieved from the database.
//	Returns:			Any - The column value cast to an any datatype
//	Description:	Returns a column's value cast to an any datatype
//////////////////////////////////////////////////////////////////////////////
//	Rev. History	Version
//						5.0   Initial version
//						7.0	Removed test on computed columns.  They can be treated
//								as normal columns.
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
any 		la_value

/*  Determine the datatype of the column and then call the appropriate 
	 GetItemxxx function and cast the returned value */
CHOOSE CASE Lower ( Left ( idw_Requestor.Describe ( as_column + ".ColType" ) , 5 ) )

		CASE "char(", "char"		//  CHARACTER DATATYPE
			la_value = idw_Requestor.GetItemString ( al_row, as_column, adw_buffer, ab_orig_value ) 
	
		CASE "date"					//  DATE DATATYPE
			la_value = idw_Requestor.GetItemDate ( al_row, as_column, adw_buffer, ab_orig_value ) 

		CASE "datet"				//  DATETIME DATATYPE
			la_value = idw_Requestor.GetItemDateTime ( al_row, as_column, adw_buffer, ab_orig_value ) 

		CASE "decim"				//  DECIMAL DATATYPE
			la_value = idw_Requestor.GetItemDecimal ( al_row, as_column, adw_buffer, ab_orig_value ) 
	
		CASE "numbe", "long", "ulong", "real", "int"				//  NUMBER DATATYPE	
			la_value = idw_Requestor.GetItemNumber ( al_row, as_column, adw_buffer, ab_orig_value ) 
	
		CASE "time", "times"		//  TIME DATATYPE
			la_value = idw_Requestor.GetItemTime ( al_row, as_column, adw_buffer, ab_orig_value ) 

		CASE ELSE 					
			SetNull ( la_value ) 

END CHOOSE

Return la_value
end function

public function integer of_setitemany (long al_row, string as_column, string as_value);//////////////////////////////////////////////////////////////////////////////
//	Public Function:		of_SetItem (FORMAT 2) 
//	Arguments:			al_row			:  The row reference for the value to be set
//							as_column		:  The column name reference
//							as_value			:  The value of the column in string format
//	Returns:				Integer: 			1 if successful,	-1 if an error occurrs.
//	Description:			Sets the specified row/column to the passed value.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:		Version
//							5.0		Initial version
//							5.0.02	Fixed problem with datetime columns being set to invalid datetime values
//										Added error checking for arguments.
//							6.0.01	Fixed where number and real datatype was being converted into a long.
//							8.0		Check datetime columns for absence of time value
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
integer	li_rc
date		ld_val
decimal	ldc_val
double	ldb_val
long		ll_val
real		lr_val
string		ls_string_value
time		ltm_val
n_cst_string	lnv_string
//n_cst_conversion	lnv_conversion

// Check arguments
if IsNull (al_row) or IsNull (as_column) then
	return -1
end if

if IsNull (idw_requestor) or not IsValid (idw_requestor) then
	return -1
end if

/*  Determine the datatype of the column and then call the SetItem
	 with proper datatype */

CHOOSE CASE Lower ( Left ( idw_Requestor.Describe ( as_column + ".ColType" ) , 5 ) )

		CASE "char(", "char"		//  CHARACTER DATATYPE
			li_rc = idw_Requestor.SetItem ( al_row, as_column, as_value ) 
	
		CASE "date"			//  DATE DATATYPE
			li_rc = idw_Requestor.SetItem ( al_row, as_column, Date (as_value) ) 

		CASE "datet"		//  DATETIME DATATYPE
			
//			ld_val = lnv_conversion.of_Date (as_value)
//			If Pos ( as_value, " " ) > 0 Then
//				/*  There was a time entered  */
//				ltm_val = lnv_conversion.of_Time (as_value)
//			Else
//				ltm_val = Time ( "00:00:00" )
//			End If
//			li_rc = idw_Requestor.SetItem (al_row, as_column, DateTime (ld_val, ltm_val))	
//
		CASE "decim"		//  DECIMAL DATATYPE
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ",", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				ldc_val = Dec (ls_string_value) / 100
			else
				ldc_val = Dec (ls_string_value)
			end if

			li_rc = idw_Requestor.SetItem ( al_row, as_column, ldc_val) 
	
		CASE "numbe", "doubl"			//  NUMBER DATATYPE	
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ",", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				ldb_val = Double (ls_string_value) / 100
			else
				ldb_val = Double (ls_string_value)
			end if
						
			li_rc = idw_Requestor.SetItem ( al_row, as_column, ldb_val) 
		
		CASE "real"				//  REAL DATATYPE	
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ",", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				lr_val = Real (ls_string_value) / 100
			else
				lr_val = Real (ls_string_value)
			end if
						
			li_rc = idw_Requestor.SetItem ( al_row, as_column, lr_val) 
		
		CASE "long", "ulong"		//  LONG/INTEGER DATATYPE	
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ",", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				ll_val = Long (ls_string_value) / 100
			else
				ll_val = Long (ls_string_value)
			end if
						
			li_rc = idw_Requestor.SetItem ( al_row, as_column, ll_val) 
		
		CASE "time", "times"		//  TIME DATATYPE
			li_rc = idw_Requestor.SetItem ( al_row, as_column, Time ( as_value ) ) 


END CHOOSE

Return li_rc
end function

public function integer of_setitemany (long al_row, integer ai_column, string as_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetItemAny (FORMAT 1)
//
//	Access:    		Public
//
//	Arguments:
//   al_row		:  The row reference for the value to be set
//   ai_column :  The column number reference
//   as_value  :  The value of the column in string format
//
//	Returns:  		Integer
//  					 1 = if it succeeds 
//  					-1 = if an error occurs
//
//	Description:  Sets the specified row/column to the passed value.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_columnname

/* Get the Column Name from the Column Number. */
ls_columnname = idw_Requestor.Describe ( "#" + String ( ai_column) + ".Name" ) 

Return of_SetItemAny ( al_row, ls_columnname, as_value )
end function

on n_cst_dwsrv_itemmanager.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dwsrv_itemmanager.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

