HA$PBExportHeader$n_cst_datetime.sru
forward
global type n_cst_datetime from nonvisualobject
end type
end forward

global type n_cst_datetime from nonvisualobject
end type
global n_cst_datetime n_cst_datetime

type variables
Private :
	String isJour[7] = { "Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi" }
end variables

forward prototypes
public function integer uf_finmois (integer aimois, integer aian)
public function date uf_plusmois (date addepart, integer aidur)
public function date uf_plusdate (date addepart, integer aidur, string asunt)
public function date uf_getascension (date adpaques)
public function date uf_getascension2annee (long alannee)
public function date uf_getpaques (long alannee)
public function date uf_getpentecote (date adpaques)
public function date uf_getpentecote2annee (long alAnnee)
public function boolean uf_isleap (integer aiyear)
public function boolean of_isvalid (datetime adtm_source)
public function boolean of_isvalid (time atm_source)
public function boolean of_isvalid (date ad_source)
public function integer of_wait (unsignedlong al_seconds)
public function integer of_wait (datetime adtm_target)
public function datetime of_relativedatetime (datetime adtm_start, long al_offset)
end prototypes

public function integer uf_finmois (integer aimois, integer aian);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_DateTime::Uf_FinMois		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 04/07/2002 17:33:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: D$$HEX1$$e900$$ENDHEX$$termination du jour de fin de mois
//*
//* Arguments		: (Val)		Integer		aiMois	N$$HEX2$$b0002000$$ENDHEX$$du mois
//*					  (Val)		Integer		aiAn		Ann$$HEX1$$e900$$ENDHEX$$e
//*
//* Retourne		: Le jour de fin de mois
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------	

Date Date1, Date2
Integer iMois, iAn

iMois = aiMois + 1
iAn   = aiAn

If iMois = 13 Then 
	iMois = 1
	iAn   = iAn + 1
End If

Date1 = Date ( String ( aiAn ) + "-" + String ( aiMois, "00" ) + "-" + "01" )
Date2 = Date ( String ( iAn  ) + "-" + String ( imois , "00" ) + "-" + "01" )

Return ( DaysAfter(  date1, date2 ) )


end function

public function date uf_plusmois (date addepart, integer aidur);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_DateTime::Uf_PlusMois			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 04/07/2002 17:33:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Ajout de N Mois $$HEX2$$e0002000$$ENDHEX$$une date
//*
//* Arguments		: (Val)		Date			adDepart	Date de d$$HEX1$$e900$$ENDHEX$$part
//*					  (Val)		Integer		aiDur		Nb Mois
//*
//* Retourne		: Date			La date calcul$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------	

Integer iAn, iMois, iJour, iCal, iFinMois

iCal  = Month ( adDepart ) + aiDur

If Mod ( iCal, 12 ) = 0 Then

	iAn = Year ( adDepart ) + ( iCal / 12 ) - 1 
	iMois = 12

Else

	iAn   = Int(  iCal / 12 ) + Year ( adDepart )

	If ( iCal < 0 ) Then

		iMois = 12 + Mod ( iCal, 12 ) 

	Else

		iMois = Mod ( iCal, 12 )

	End If

End If

iJour = Day ( adDepart )

iFinMois = uf_FinMois ( iMois, iAn ) 

if iJour > iFinMois Then iJour = iFinMois

Return ( Date ( iAn, iMois, iJour ) )


end function

public function date uf_plusdate (date addepart, integer aidur, string asunt);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_DateTime::Uf_PlusDate			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 04/07/2002 17:33:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: D$$HEX1$$e900$$ENDHEX$$termination du jour de fin de mois
//*
//* Arguments		: (Val)		Date			adDepart	Date de d$$HEX1$$e900$$ENDHEX$$part
//*					  (Val)		Integer		aiDur		Dur$$HEX1$$e900$$ENDHEX$$e
//*					  (Val)		String		asUnt		Unit$$HEX2$$e9002000$$ENDHEX$$de dur$$HEX1$$e900$$ENDHEX$$e 'J', 'M', 'A'
//*
//* Retourne		: Date			La date calcul$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------	

Date		dFin			// Date de fin
Integer	iIncrement

Choose Case Upper ( asUnt )
	
	Case "M"
		dFin = uf_PlusMois ( adDepart, aiDur )
	
	Case "A"
		dFin = Date ( Year ( adDepart ) + aiDur, Month ( adDepart ), Day ( adDepart ) )
/*------------------------------------------------------------------*/
/* Le 19/01/1999.                                                   */
/* La fonction ne marche pas si la date de d$$HEX1$$e900$$ENDHEX$$part est un 29         */
/* F$$HEX1$$e900$$ENDHEX$$vrier, et que l'incr$$HEX1$$e900$$ENDHEX$$ment ne fait pas tomber sur une ann$$HEX1$$e900$$ENDHEX$$e     */
/* bissextile. Si la zone dFin est $$HEX2$$e0002000$$ENDHEX$$NULL, on renvoie la fonction   */
/* avec F_Plus_Mois ().                                             */
/*------------------------------------------------------------------*/
		If	String ( dFin ) = "01/01/1900"	Then
			iIncrement = aiDur * 12
			dFin = uf_PlusMois ( adDepart, iIncrement )
		End If
	
	Case "J"
		dFin = RelativeDate ( adDepart, aiDur )
	
 End Choose

Return ( dFin )



end function

public function date uf_getascension (date adpaques);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_DateTime::Uf_GetAscension			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 04/07/2002 17:33:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Obtention du jeudi de l'ascension $$HEX2$$e0002000$$ENDHEX$$partir du lundi de P$$HEX1$$e200$$ENDHEX$$ques
//*
//* Arguments		: (Val)		Date			adPaques		Date de d$$HEX1$$e900$$ENDHEX$$part
//*
//* Retourne		: Date			La date calcul$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------	

Date  dAscension

dAscension = Uf_PlusDate ( adPaques, 38, 'J' )

Return dAscension

end function

public function date uf_getascension2annee (long alannee);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_DateTime::Uf_GetAscension2Annee			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 04/07/2002 17:33:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Obtention du jeudi de l'ascension pour une ann$$HEX1$$e900$$ENDHEX$$e donn$$HEX1$$e900$$ENDHEX$$e
//*
//* Arguments		: (Val)		Long		alAnnee		Annee
//*
//* Retourne		: Date			La date calcul$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------	

Date  dAscension, dPaques

dPaques = Uf_GetPaques ( alAnnee )

dAscension = Uf_PlusDate ( dPaques, 38, 'J' )

Return dAscension


end function

public function date uf_getpaques (long alannee);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_DateTime::Uf_GetPaques			(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 04/07/2002 17:33:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Retourne la date du lundi de paques pour une ann$$HEX1$$e900$$ENDHEX$$e donn$$HEX1$$e900$$ENDHEX$$e.
//*
//* Arguments		: (Val)		Long		alAnnee		Annee
//*
//* Retourne		: Date			La date calcul$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------	

Date     dPaques
Integer	a, b, c, d, e

a = Mod ( alAnnee, 19 )
b = Mod ( alAnnee, 4  )
c = Mod ( alAnnee, 7  )

d = Mod ( ( 19 * a + 24 ), 30 )
e = Mod ( ( 2 * b + 4 * c + 6 * d + 5 ), 7 )

If ( d + e ) <= 9 Then

	dPaques = Date ( alAnnee, 3, 22 + d + e )
	
Else
	
	dPaques = Date ( alAnnee, 4, d + e - 9 )
	
End If

/*------------------------------------------------------------------*/
/* On ajoute 1 jour pour obtenir la date du lundi de paques         */
/*------------------------------------------------------------------*/
dPaques = Uf_PlusDate ( dPaques, 1, 'J' )

Return dPaques


end function

public function date uf_getpentecote (date adpaques);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_DateTime::Uf_GetPentecote		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 04/07/2002 17:33:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Obtention du lundi de pentec$$HEX1$$f400$$ENDHEX$$te $$HEX2$$e0002000$$ENDHEX$$partir du lundi de P$$HEX1$$e200$$ENDHEX$$ques
//*
//* Arguments		: (Val)		Date			adPaques		Date de d$$HEX1$$e900$$ENDHEX$$part
//*
//* Retourne		: Date			La date calcul$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------	

Date  dPenteCote

dPenteCote = Uf_PlusDate ( adPaques, 49, 'J' )

Return dPenteCote

end function

public function date uf_getpentecote2annee (long alAnnee);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_DateTime::Uf_GetPentecote		(PUBLIC)
//* Auteur			: Erick John Stark
//* Date				: 04/07/2002 17:33:43
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Obtention du lundi de pentec$$HEX1$$f400$$ENDHEX$$te $$HEX2$$e0002000$$ENDHEX$$partir du lundi de P$$HEX1$$e200$$ENDHEX$$ques
//*
//* Arguments		: (Val)		Long		alAnnee		Annee
//*
//* Retourne		: Date			La date calcul$$HEX1$$e900$$ENDHEX$$e
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------	

Date  dPenteCote, dPaques

dPaques = Uf_GetPaques ( alAnnee )

dPenteCote = Uf_PlusDate ( dPaques, 49, 'J' )

Return dPenteCote


end function

public function boolean uf_isleap (integer aiyear);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_DateTime::Uf_IsLeap		(PUBLIC)
//* Auteur			: PHG
//* Date				: 07/10/2011
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [I037] Migration FUNCKy
//*
//* Arguments		: 		  (Val)		Integer		aiYear	Ann$$HEX1$$e900$$ENDHEX$$e
//*
//* Retourne		: Le jour de fin de mois
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------	

int li_year
boolean lb_null
SetNull(lb_null)

if aiYear <=1 Then return False

li_year = aiYear

If ( (Mod(li_year,4) = 0 And Mod(li_year,100) <> 0) Or (Mod(li_year,400) = 0) ) Then
	Return True
End If

Return False
end function

public function boolean of_isvalid (datetime adtm_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsValid
//
//	Access:  		public
//
//	Arguments:
//	adtm_source		DateTime to test.
//
//	Returns:  		boolean
//						True if argument is a valid datetime.
//						If any argument's value is NULL, function returns False.
//						If any argument's value is Invalid, function returns False.
//
//	Description:  	Given a datetime, will determine if the Datetime is valid.
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

date 	ldt_value

//Check parameters
If IsNull(adtm_source) Then
	Return False
End If

//There is only need to test the Date portion of the DateTime.
//Can't tell if time is invalid because 12am is 00:00:00:000000
ldt_value = Date(adtm_source)

//Check for invalid date
If Not of_IsValid(ldt_value) Then
	Return False
End If

Return True

end function

public function boolean of_isvalid (time atm_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsValid
//
//	Access:  		public
//
//	Arguments:
//	adtm_source		DateTime to test.
//
//	Returns:  		boolean
//						True if argument is a valid time.
//						If any argument's value is NULL, function returns False.
//						If any argument's value is Invalid, function returns False.
//
//	Description:  	Given a time, will determine if the time is valid.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer 	li_hour
integer	li_minute
integer	li_second

// Initialize test values.
li_hour = Hour(atm_source)
li_minute = Minute(atm_source)
li_second = Second(atm_source)

// Check for nulls.
If IsNull(atm_source) Or IsNull(li_hour) or IsNull(li_minute) or IsNull(li_second) Then
	Return False
End If

// Check for invalid values.
If li_hour < 0 or li_minute < 0 or li_second < 0 Then
	Return False
End If

// Passed all testing.
Return True

end function

public function boolean of_isvalid (date ad_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsValid
//
//	Access:  		public
//
//	Arguments:
//	ad_source 			Date to test.
//
//	Returns:  		boolean
//						True if argument contains a valid date.
//						If any argument's value is NULL, function returns False.
//						If any argument's value is Invalid, function returns False.
//
//	Description:  	Given a date, will determine if the Date is valid.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.04 Enhanced for more complete checking.
//	6.0.01 Remove invalid date comparison
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer 	li_year
integer	li_month
integer	li_day

// Initialize test values.
li_year = Year(ad_source)
li_month = Month(ad_source)
li_day = Day(ad_source)

// Check for nulls.
If IsNull(ad_source) Or IsNull(li_year) or IsNull(li_month) or IsNull(li_day) Then
	Return False
End If

// Check for invalid values.
If	li_year <= 0 or li_month <= 0 or li_day <= 0 Then
	Return False
End If

// Passed all testing.
Return True

end function

public function integer of_wait (unsignedlong al_seconds);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Wait
//
//	Access:  		public
//
//	Arguments:
//	al_seconds 		Wait this many Seconds.
//
//	Returns:  		integer
//						1 if function waited the expected time.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns -1.
//
//	Description:  	Given a datetime, will wait until datetime is reached.
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

datetime ldtm_target
integer	li_ret

//Check parameters
If IsNull(al_seconds) Then
	Return al_seconds
End If

//Check invalid parameters
If al_seconds <= 0 Then
	Return -1
End If

//Get the Target DateTime
ldtm_target = of_RelativeDatetime(DateTime(Today(),Now()), al_seconds)

//Perform the actual wait.
li_ret = of_Wait(ldtm_target)

Return li_ret

end function

public function integer of_wait (datetime adtm_target);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Wait
//
//	Access:  		public
//
//	Arguments:
//	adtm_Target 	Target DateTime.
//
//	Returns:  		integer
//						1 if function waited the expected time.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns -1.
//
//	Description:  	Given a datetime, will wait until datetime is reached.
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

date 	ldt_value

//Check parameters
If IsNull(adtm_Target) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//There is only need to test the Date portion of the DateTime.
ldt_value = Date(adtm_Target)

//Check for invalid date
If Not of_IsValid(ldt_value) Then
	Return -1
End If

//Wait until Target datetime
DO UNTIL DateTime(Today(),Now()) >= adtm_Target
	Yield() //Yields control to other graphic objects, including objects that are not PB.
LOOP

Return 1

end function

public function datetime of_relativedatetime (datetime adtm_start, long al_offset);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RelativeDatetime
//
//	Access:  		public
//
//	Arguments:
//	adtm_start 		Starting datetime point of calculation.
//	al_offset     	Number of seconds before/after datetime to be returned.
//
//	Returns:		 	Datetime
//						Relative datetime.
//						If any argument's value is NULL, function returns NULL.
//						If any argument's value is Invalid, function returns 1900-01-01.
//
//	Description:  	Given a datetime, find the relative datetime +/- n seconds
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.03	Fix to return time as 00:00:00:000000 on invalid date check
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

datetime ldt_null
date ld_sdate
time lt_stime
long ll_date_adjust
long ll_time_adjust, ll_time_test

//Check parameters
If IsNull(adtm_start) or IsNull(al_offset) Then
	SetNull(ldt_null)
	Return ldt_null
End If

//Check for invalid date
If Not of_IsValid(adtm_start) Then
	Return ldt_null
End If

//Initialize date and time portion
ld_sdate = date(adtm_start)
lt_stime = time(adtm_start)

//Find out how many days are contained
//Note: 86400 is # of seconds in a day
ll_date_adjust = al_offset /  86400
ll_time_adjust = mod(al_offset, 86400)

//Adjust date portion
ld_sdate = RelativeDate(ld_sdate, ll_date_adjust)

//Adjust time portion
//	Allow for time adjustments periods crossing over days
//	Check for time rolling forwards a day
If ll_time_adjust > 0 then
	ll_time_test = SecondsAfter(lt_stime,time('23:59:59'))
	If ll_time_test < ll_time_adjust Then
		ld_sdate = RelativeDate(ld_sdate,1)
		ll_time_adjust = ll_time_adjust - ll_time_test -1
		lt_stime = time('00:00:00')
	End If
	lt_stime = RelativeTime(lt_stime, ll_time_adjust)
//Check for time rolling backwards a day
ElseIf  ll_time_adjust < 0 then
	ll_time_test = SecondsAfter(lt_stime,time('00:00:00'))
	If   ll_time_test > ll_time_adjust Then
		ld_sdate = RelativeDate(ld_sdate,-1)
		ll_time_adjust = ll_time_adjust - ll_time_test +1
		lt_stime = time('23:59:59')
	End If
	lt_stime = RelativeTime(lt_stime, ll_time_adjust)
End If

return(datetime(ld_sdate,lt_stime))
end function

on n_cst_datetime.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_datetime.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

