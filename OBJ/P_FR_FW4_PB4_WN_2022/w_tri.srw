HA$PBExportHeader$w_tri.srw
$PBExportComments$---} Fen$$HEX1$$ea00$$ENDHEX$$tre pour la gestion du Tri
forward
global type w_tri from w_ancetre
end type
type uo_2 from u_tri within w_tri
end type
type uo_1 from u_bd_interro within w_tri
end type
end forward

global type w_tri from w_ancetre
int X=353
int Y=573
int Width=1733
int Height=1373
WindowType WindowType=response!
boolean Visible=true
boolean TitleBar=true
string Title="Gestion du Tri"
event ue_envoi pbm_custom01
uo_2 uo_2
uo_1 uo_1
end type
global w_tri w_tri

type variables
String      isTriRetour

s_Tri       istTri             // Structure permettant la constuction de dw_1



end variables

forward prototypes
public function long wf_taillefenetre ()
public function string wf_construirechaine ()
public subroutine wf_construireimport ()
end prototypes

on ue_envoi;call w_ancetre::ue_envoi;//*****************************************************************************
//
// Objet 		: U_BD_INTERRO
// Evenement 	: ENVOI
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: 
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

String sTab

sTab = "~t"

Choose Case uo_1.ilBouton
Case 1		// Bouton Valider
				// Construire la cha$$HEX1$$ee00$$ENDHEX$$ne correspondant aux valeurs renseign$$HEX1$$e900$$ENDHEX$$es

// .... Fermeture de la fen$$HEX1$$ea00$$ENDHEX$$tre et envoi de la cha$$HEX1$$ee00$$ENDHEX$$ne g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e
	
	Wf_ConstruireChaine ()
	CloseWithReturn ( This, isTriRetour )

Case 2		// Bouton Retour
				// La cha$$HEX1$$ee00$$ENDHEX$$ne est $$HEX2$$e0002000$$ENDHEX$$NULL

	isTriRetour 	= stNul.Str
	CloseWithReturn ( This, isTriRetour )

Case 3		// Bouton Effacer

// .... On reinitialise dw_2 et dw_1

	Uo_2.dw_1.Reset ()
	Uo_2.dw_2.Reset ()
	Uo_2.dw_1.ImportString ( istTri.sImport )
	
End Choose

end on

public function long wf_taillefenetre ();//*******************************************************************************************
// Fonction            	: wf_TailleFenetre
//	Auteur              	: Erick John Stark
//	Date 					 	: 22/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Dimension de la fen$$HEX1$$ea00$$ENDHEX$$tre et des objets
//
// Arguments				: 
//
// Retourne					: Long	
//								  
//*******************************************************************************************

//* N$$HEX2$$b0002000$$ENDHEX$$Modif          Re$$HEX1$$e700$$ENDHEX$$ue Le          Effectu$$HEX1$$e900$$ENDHEX$$e Le          PAR
//*
//* MOD-0032          26/02/97            28/02/97					DGA
//*
//* On ajoute +1 au nombre de lignes de dw_1 et dw_2.
//* Sinon probl$$HEX1$$e800$$ENDHEX$$me de retaillage en 800x600
//*-----------------------------------------------------------------

Long lRet, ldw_H

String sdw_H

lRet = 1

sdw_H = uo_2.dw_1.Describe ( "DataWindow.Detail.Height" )

ldw_H = ( Long( sdw_H ) + 22 ) * ( Uo_2.dw_1.RowCount () + Uo_2.dw_2.RowCount () + 1 )

Uo_2.dw_1.Resize ( Uo_2.dw_1.Width, ldw_H + 10 )			// Retaillage de la DW 1
Uo_2.dw_2.Resize ( Uo_2.dw_2.Width, ldw_H + 10 )			// Retaillage de la DW 2

Uo_2.Resize ( Uo_2.width, ldw_H + 50 )						// Retaillage du UO_2

uo_1.Move ( uo_1.X, Uo_2.Height + 50 )						// Repostionnement du Bandeau
This.Resize ( This.Width, Uo_2.Height + 400 )				// Retaillage de la Fen$$HEX1$$ea00$$ENDHEX$$tre

Return ( lRet )

end function

public function string wf_construirechaine ();//*******************************************************************************************
// Fonction            	: wf_ConstruireChaine
//	Auteur              	: Erick John Stark
//	Date 					 	: 22/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne correpondant aux valeurs de Tri
//
// Arguments				: 
//
// Retourne					: String
//								  
//*******************************************************************************************

Long lLigTot, lCpt
String sCol, sTyp

// .... D$$HEX1$$e900$$ENDHEX$$termination du nombre de lignes

lLigTot 		= Uo_2.dw_2.RowCount ()
isTriRetour = ""

If	lLigTot > 0 Then

// .... Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne de Tri
// .... au format N$$HEX2$$b0002000$$ENDHEX$$de Colonne + "A" Ou "D"
	
	For	lCpt = 1 To ( lLigTot - 1 )

			sCol	= "#" + String ( Uo_2.dw_2.GetItemNumber ( lCpt, "lCol" ) )
			sTyp	= Uo_2.dw_2.GetItemString ( lCpt, "sTypeTri" )

			isTriRetour = isTriRetour + sCol + " " + sTyp + ", "

	Next

	sCol	= "#" + String ( Uo_2.dw_2.GetItemNumber ( lLigTot, "lCol" ) )
	sTyp	= Uo_2.dw_2.GetItemString ( lLigTot, "sTypeTri" )

	isTriRetour = isTriRetour + sCol + " " + sTyp

End If

// .... Envoi de la cha$$HEX1$$ee00$$ENDHEX$$ne g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX1$$e900$$ENDHEX$$e
// .... si pas de tri de positionn$$HEX1$$e900$$ENDHEX$$, la cha$$HEX1$$ee00$$ENDHEX$$ne est $$HEX1$$e900$$ENDHEX$$gale $$HEX2$$e0002000$$ENDHEX$$""

Return ( isTriRetour )
end function

public subroutine wf_construireimport ();//*******************************************************************************************
// Fonction            	: wf_ConstruireImport
//	Auteur              	: Erick John Stark
//	Date 					 	: 22/02/1996
//	Libell$$HEX6$$e90009000900090009000900$$ENDHEX$$: 
// Commentaires			: Construction de la cha$$HEX1$$ee00$$ENDHEX$$ne d'import
//
// Arguments				: Aucun
//
// Retourne					: Rien
//								  
//*******************************************************************************************

String sTab[], sTypeTri, sCol, sText
Long lTaille, lCpt, lLig, lTotDw1

// .... Importation des lignes dans dw_1

uo_2.Dw_1.ImportString( istTri.sImport )

// .... D$$HEX1$$e900$$ENDHEX$$termination des colonnes pr$$HEX1$$e900$$ENDHEX$$sentes dans le tri actuel

f_DecomposerChaine ( istTri.sTriActuel, ",", sTab )

lTaille = UpperBound ( sTab )

// .... Recomposition de la chaine de tri

For	lCpt = 1 To lTaille
		lTotDw1	= Uo_2.dw_1.RowCount ()
		sTypeTri = Right ( sTab[ lCpt ], 1 )
		sCol		= Mid ( sTab[ lCpt ], 2, Len ( sTab[ lCpt ] ) - 2 )

// .... Il faut rechercher ou se trouve la ligne $$HEX2$$e0002000$$ENDHEX$$ins$$HEX1$$e900$$ENDHEX$$rer

		sText = "lCol = " + sCol
		lLig = Uo_2.dw_1.Find ( sText, 1, lTotDw1 )
		
		Uo_2.Uf_Inserer ( 1, Uo_2.dw_2, Uo_2.dw_1, 0, lLig, sTypeTri )
	
Next
		

end subroutine

on open;call w_ancetre::open;//*****************************************************************************
//
// Objet 		: 
// Evenement 	: OPEN de W_INTERRO
//	Auteur		: Erick John Stark
//	Date			: 20/02/1996
// Libell$$HEX3$$e90009000900$$ENDHEX$$: Ouverture de la Fen$$HEX1$$ea00$$ENDHEX$$tre d'interrogation
// Commentaires: 
//					  
// ----------------------------------------------------------------------------
// MAJ PAR		Date		Modification
//
//*****************************************************************************

istTri= Message.PowerObjectParm

If	IsNull( istTri.sImport ) Or istTri.sImport = "" Then

// Fermer la fen$$HEX1$$ea00$$ENDHEX$$tre si aucune colonne
	Uo_1.TriggerEvent( "UE_RETOUR" )

Else
// Cr$$HEX1$$e900$$ENDHEX$$ation des lignes dans la DW_1

	Wf_ConstruireImport ()
	Wf_TailleFenetre()

End If


end on

on w_tri.create
int iCurrent
call w_ancetre::create
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=uo_2
this.Control[iCurrent+2]=uo_1
end on

on w_tri.destroy
call w_ancetre::destroy
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_2 from u_tri within w_tri
int X=19
int Y=17
int Width=1665
int Height=1041
int TabOrder=10
boolean Border=false
end type

on uo_2.destroy
call u_tri::destroy
end on

type uo_1 from u_bd_interro within w_tri
int X=439
int Y=1073
int Width=897
int Height=193
int TabOrder=20
boolean Border=false
long BackColor=12632256
end type

on uo_1.destroy
call u_bd_interro::destroy
end on

