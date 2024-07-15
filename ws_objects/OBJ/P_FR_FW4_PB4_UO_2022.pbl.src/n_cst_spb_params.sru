HA$PBExportHeader$n_cst_spb_params.sru
forward
global type n_cst_spb_params from nonvisualobject
end type
end forward

global type n_cst_spb_params from nonvisualobject
end type
global n_cst_spb_params n_cst_spb_params

type variables
Public:
Integer iiValeurInt[]
String isValeurStr[]

s_se_params istParams[]
end variables

forward prototypes
public subroutine uf_initialiser (long alnbrows, long alnbcols)
public function string uf_getvaluestr (long alrow, string ascol)
end prototypes

public subroutine uf_initialiser (long alnbrows, long alnbcols);
end subroutine

public function string uf_getvaluestr (long alrow, string ascol);//*-----------------------------------------------------------------
//*
//* Fonction		: n_cst_spb_params::uf_getvaluestr
//* Auteur			: F. Pinon
//* Date				: 18/08/2009 11:28:14
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: value long alrow	 */
/* 	value string ascol	 */
//*
//* Retourne		: string	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

String sRetour, sNomCol, sValCol
Long lCpt, lPos

// Contr$$HEX1$$f400$$ENDHEX$$le des param$$HEX1$$e800$$ENDHEX$$tres
If alRow < 1 or alRow > UpperBound(istparams) Then return ""
If isNull(asCol) Then return ""
if asCol="" Then return ""

sValCol = ""

// Parcours
For lCpt = 1 To UpperBound(istparams[alRow].isValeurStr)
	sRetour=istparams[alRow].isValeurStr[lCpt]
	
	lPos=Pos(sRetour,"=")
	if lPos <= 0 Then continue
		
	sNomCol = Upper(Left(sRetour,lPos -1))
	
	If Upper(sNomCol)= Upper(asCol) Then
		sValCol = Right(sRetour,Len(sRetour) - lPos)
		exit
	End If
Next

Return sValCol
end function

on n_cst_spb_params.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_spb_params.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

