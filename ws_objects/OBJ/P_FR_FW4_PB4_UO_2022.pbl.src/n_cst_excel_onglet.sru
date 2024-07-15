HA$PBExportHeader$n_cst_excel_onglet.sru
$PBExportComments$Permet d'$$HEX1$$e900$$ENDHEX$$crire/lire dans un fichier Excel $$HEX2$$e0002000$$ENDHEX$$onglet
forward
global type n_cst_excel_onglet from nonvisualobject
end type
end forward

global type n_cst_excel_onglet from nonvisualobject
end type
global n_cst_excel_onglet n_cst_excel_onglet

type variables
Private :

String isNomFichierExcel

OLEObject iiOleExcel, iiOleWorkbook
end variables

forward prototypes
public function integer uf_changernomonglet (integer ainumonglet, string asnomonglet, string asmajmin)
public function integer uf_creerfichierexcel ()
public function integer uf_ecriredonneessuronglet (integer ainumonglet, datawindow adwdata, string asentete, string asentetemajmin)
public function integer uf_sauverfichierexcel (string asnomfichier, string asextforcee)
public function integer uf_fermerexcel ()
public function integer uf_nombretotalonglet ()
public function integer uf_ajoutonglet (integer ainbreonglet)
end prototypes

public function integer uf_changernomonglet (integer ainumonglet, string asnomonglet, string asmajmin);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Excel_Onglet::uf_ChangerNomOnglet			(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 11/04/2019 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Integer		 1 = Tout se passe bien
//*										 0 = Excel ne fonctionne pas
//*										-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Int iRet 

iRet = 1

asNomOnglet = Trim ( asNomOnglet )

If Len ( asNomOnglet ) > 31 Then 
	iRet = -1
	Return iRet 
End If 

If aiNumOnglet < 0 Then 
	iRet = -1
	Return iRet 
End If 

If IsNull ( asMajMin ) Or Trim ( asMajMin ) = "" Then
	asMajMin = "MAJ"
End If 

Choose Case asMajMin
	Case "MAJ" 
		asNomOnglet = Upper ( asNomOnglet ) 
	Case "MIN" 		
		asNomOnglet = Lower ( asNomOnglet ) 
	Case "1EREMAJ" 				
		asNomOnglet = Upper ( Left ( asNomOnglet, 1) ) + Lower ( Mid ( asNomOnglet, 2, Len ( asNomOnglet ) ) ) 		
End CHoose 

iiOleWorkbook.worksheets ( aiNumOnglet ).name = asNomOnglet

Return iRet

end function

public function integer uf_creerfichierexcel ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Excel_Onglet::uf_CreerFichierExcel			(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 11/04/2019 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Integer		 1 = Tout se passe bien
//*										 0 = Excel ne fonctionne pas
//*										-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Int iRet

iiOleExcel = CREATE OLEObject
iRet = iiOleExcel.ConnectToNewObject("excel.application")

If iRet <> 0 Then
      destroy iiOleExcel
		Return iRet 
End If 

iiOleWorkbook = iiOleExcel.WorkBooks.add ()

Return iRet


end function

public function integer uf_ecriredonneessuronglet (integer ainumonglet, datawindow adwdata, string asentete, string asentetemajmin);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Excel_Onglet::uf_EcrireDonneesSurOnglet			(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 11/04/2019 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Integer		 1 = Tout se passe bien
//*										 0 = Excel ne fonctionne pas
//*										-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Int iRet 
string sTabNomCol[], sVal, sColType[]
long lCptCol, lTotCol, lCptRow, lTotRow, lCptRowEcr

If IsNull ( asEnteteMajMin ) Or Trim ( asEnteteMajMin ) = "" Then
	asEnteteMajMin = "MAJ"
End If 


iRet = 1
lCptRowEcr = 0

If aiNumOnglet < 0 Then 
	iRet = -1
	Return iRet 
End If 

lTotCol = Long ( adwdata.object.datawindow.column.count )
lTotRow = adwdata.RowCount ()

For lCptCol = 1 to lTotCol

	sVal = adwdata.describe( "#" + string ( lCptCol ) + ".name" )
	
	Choose Case asEnteteMajMin
		Case "MAJ"
			sTabNomCol[ lCptCol ] =  Upper ( sVal )

		Case "MIN"
			sTabNomCol[ lCptCol ] =  Lower ( sVal )
			
		Case "1EREMAJ"
			sTabNomCol[ lCptCol ] =  Upper ( Left ( sVal, 1 ) ) + Lower ( Mid ( sVal, 2, Len ( sVal ) ) )

	End Choose 
	
	sColType [ lCptCol ] = lower ( adwdata.Describe(sTabNomCol[ lCptCol ] + ".ColType" ) )
	
Next 

If asEntete = "AVEC_ENTETE" Then
	For lCptCol = 1 To lTotCol
		iiOleWorkbook.Worksheets [ aiNumOnglet ].cells [ 1, lCptCol] = sTabNomCol[ lCptCol ]
	Next
End If 

For lCptRow = 1 To lTotRow
	
	lCptRowEcr = lCptRow 
	
	If asEntete = "AVEC_ENTETE" Then	
		lCptRowEcr = lCptRow + 1
	End If 		
	
	For lCptCol = 1 To lTotCol

		Choose Case sColType [ lCptCol ] 
			Case "date"
				sVal = String ( adwdata.GetItemDate ( lCptRow, sTabNomCol[ lCptCol ] ), "dd/mm/yyyy" )
			Case "dateTime"
				sVal = String ( adwdata.GetItemDateTime ( lCptRow, sTabNomCol[ lCptCol ] ) , "dd/mm/yyyy hh:mm:ss" ) 				
			Case "int", "number", "long", "ulong"
				sVal = String ( adwdata.GetItemNumber ( lCptRow, sTabNomCol[ lCptCol ] ) )
			Case "time", "timestamp"
				sVal = String ( adwdata.GetItemTime ( lCptRow, sTabNomCol[ lCptCol ] ) )
		End Choose 

		Choose Case Left ( sColType [ lCptCol ], 4 ) 
			Case "char"
				sVal = adwdata.GetItemString ( lCptRow, sTabNomCol[ lCptCol ] ) 				
			Case "deci", "real"
				sVal = String ( adwdata.GetItemDecimal ( lCptRow, sTabNomCol[ lCptCol ] ) )				
		End Choose 
		
		If IsNull ( sVal ) Then sVal = ""

	   iiOleWorkbook.Worksheets [ aiNumOnglet ].cells [ lCptRowEcr, lCptCol] = "'" + sVal

	Next
Next


Return iRet
end function

public function integer uf_sauverfichierexcel (string asnomfichier, string asextforcee);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Excel_Onglet::uf_SauverFichierExcel			(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 11/04/2019 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Integer		 1 = Tout se passe bien
//*										 0 = Excel ne fonctionne pas
//*										-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Int iRet 

If IsNull ( asNomFichier ) Then 
	iRet = -1
	Return iRet 
End If 

asNomFichier = Trim ( asNomFichier ) 

If Len ( asNomFichier ) <= 0 Then 
	iRet = -1
	Return iRet 
End If 

If IsNull ( asExtForcee ) Then asExtForcee = ""
If asExtForcee = "" Then asExtForcee = ".xlsx"

iiOleWorkbook.saveas ( asnomfichier + asExtForcee  )

Return iRet 
end function

public function integer uf_fermerexcel ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Excel_Onglet::uf_FermerExcel			(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 11/04/2019 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Integer		 1 = Tout se passe bien
//*										 0 = Excel ne fonctionne pas
//*										-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Int iRet

iRet = 1

iiOleExcel.application.quit()
 
iiOleExcel.DisconnectObject()
 
destroy iiOleExcel

Return iRet
end function

public function integer uf_nombretotalonglet ();//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Excel_Onglet::uf_NombreTotalOnglet			(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 11/04/2019 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: 
//*
//* Arguments		: 
//*
//* Retourne		: Integer		 1 = Tout se passe bien
//*										 0 = Excel ne fonctionne pas
//*										-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------
Int lCountSheet

lCountSheet = iiOleWorkbook.WorkSheets.count

If lCountSheet < 0 Or IsNull ( lCountSheet ) Then lCountSheet = 0

Return lCountSheet 


end function

public function integer uf_ajoutonglet (integer ainbreonglet);//*-----------------------------------------------------------------
//*
//* Fonction		: N_Cst_Excel_Onglet::uf_AjoutOnglet			(PUBLIC)
//* Auteur			: Fabry JF
//* Date				: 11/04/2019 
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Les 3 premier onglet sont nativement pr$$HEX1$$e900$$ENDHEX$$sent, 
//* 					  ajouter si besoin de plus de 3 onglets
//*
//* Arguments		: 
//*
//* Retourne		: Integer		 1 = Tout se passe bien
//*										 0 = Excel ne fonctionne pas
//*										-1 = Il y a un probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------
//* MAJ      PAR      Date	  Modification
//* 
//*-----------------------------------------------------------------

Int iRet, iCpt, iTot

iTot = aiNbreOnglet

If iTot = 0 Or IsNull ( iTot ) Then iTot = 1 

For iCpt = 1 To iTot
	iiOleWorkbook.WorkSheets.Add ( )
Next 

iRet = This.uf_NombreTotalOnglet ()   

// iRet repr$$HEX1$$e900$$ENDHEX$$sente le num$$HEX1$$e900$$ENDHEX$$ro de l'onglet si tout se passe bien, n$$HEX1$$e900$$ENDHEX$$gatif sinon.

Return iRet 
end function

on n_cst_excel_onglet.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_excel_onglet.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

