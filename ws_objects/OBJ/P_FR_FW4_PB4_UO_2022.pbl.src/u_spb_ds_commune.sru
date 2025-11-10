HA$PBExportHeader$u_spb_ds_commune.sru
$PBExportComments$[DCMP060445] Datastore d'interogation des communes. Contient les fonctions de recherches de CP et de controle de coh$$HEX1$$e900$$ENDHEX$$rence.
forward
global type u_spb_ds_commune from datastore
end type
end forward

global type u_spb_ds_commune from datastore
end type
global u_spb_ds_commune u_spb_ds_commune

type variables
private:
constant	string	k_dataobject_commune = "d_stk_se_commune"

string  is_AppIni
boolean ib_VerifCPActive


end variables

forward prototypes
public function boolean uf_checkcp (string as_cp)
public function boolean uf_verif_cp_ville (string as_cp, string as_ville)
public function integer uf_chargecommune (transaction atr_sesa, string asficini)
public subroutine uf_epuration_zonecommune (ref string asville, ref integer aicode)
public function boolean of_isempty (string as_source)
end prototypes

public function boolean uf_checkcp (string as_cp);//*-----------------------------------------------------------------
//*
//* Fonction		: n_ds_commune::uf_checkcp
//* Auteur			: Pierre-Henri Gillot
//* Date				: 10/10/2006 13:28:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DCMP060445] Verification Existence Code CP
//*
//* Arguments		: value string as_cp	 */
//*
//* Retourne		: boolean	TRUE :
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

if this.RowCount()<= 0 then return FALSE

return ( this.Find("cp ='"+trim(as_CP)+"'",1, This.RowCount()+1)>0)





end function

public function boolean uf_verif_cp_ville (string as_cp, string as_ville);//*-----------------------------------------------------------------
//*
//* Fonction		: n_ds_commune::uf_verif_cp_ville
//* Auteur			: Pierre-Henri Gillot
//* Date				: 10/10/2006 13:28:41
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DCMP060445] Verification Existence Code CP-Ville
//*
//* Arguments		: value string as_cp	 */
//*					  value string as_ville */
//*
//* Retourne		: boolean	TRUE : si la ville existe et correspond au CP ou un des trois controle d'exception
//*									FALSE : Si pas de coh$$HEX1$$e900$$ENDHEX$$rence CP/Ville
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

long ll_pos
string ls_FindString
integer iCode
boolean bCPnull, bVilleNull

// Controle 1 : Sortie a TRUE si DCMP non mise en prod
if Not ib_VerifCPActive then RETURN True

as_cp = trim(as_cp)
as_ville = upper(trim(as_ville))

// Controle 2 : Sortie a TRUE si CP = '00000'
if as_cp = '00000' then return TRUE

// Controle 3 : Sortie a TRUE si CP et Ville Vide
bCPnull = of_isEmpty(as_cp)
bVilleNull = of_isEmpty(as_Ville)

if bCPnull AND bVilleNull then return TRUE
if bCPnull OR bVilleNull then return FALSE

// On effectue le controle
// Suivant les cas d'execption le controle ne portera que sur le departement ou sur le CP
// de plus, on enl$$HEX1$$e800$$ENDHEX$$ve tous les BP et Cedex de la ville, ainsi que tout chiffre.
uf_epuration_zonecommune (as_Ville, iCode)
// On ne prends en compte que les 25 premier caract$$HEX1$$e800$$ENDHEX$$res.
as_Ville = Left ( as_Ville, 25 )
// !!! sp$$HEX1$$e900$$ENDHEX$$cifique ancetre 4to8
as_Ville = F_Remplace ( as_Ville, "'", "~~'" ) 
// !!! sp$$HEX1$$e900$$ENDHEX$$cifique ancetre 8
// utiliser of_GlobalReplace de n_cst_string

if iCode = 1 then
	ls_FindString ="left(cp,2) = '"+left(as_cp,2)+"' AND left(upper(commune), 25) = upper('"+as_ville+"')"
else
	ls_FindString ="cp = '"+as_cp+"' AND left(upper(commune), 25)  = upper('"+as_ville+"')"
End If
ll_pos = Find(ls_FindString, 1, RowCount()+1)

return ( ll_pos > 0 )

end function

public function integer uf_chargecommune (transaction atr_sesa, string asficini);//*-----------------------------------------------------------------
//*
//* Fonction		: n_ds_commune::uf_chargecommune
//* Auteur			: Pierre-Henri Gillot
//* Date				: 10/10/2006 13:24:46
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DCMP060445] Chargement des communes en memoires
//*
//* Arguments		: value transaction atr_sesa	: Transaction connect$$HEX1$$e900$$ENDHEX$$e sur Sesame
//*
//* Retourne		: integer	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

integer li_Ret


if isvalid(atr_sesa) then
	ib_VerifCPActive = ( ProfileString(asFicIni, 'APPLICATION', 'MEP_CODE_POSTAUX','0') = '1')
	this.Dataobject = K_dataobject_commune
	this.settransobject(atr_sesa)
	li_ret = this.retrieve()
else
	li_ret = -1
End If

return li_Ret




end function

public subroutine uf_epuration_zonecommune (ref string asville, ref integer aicode);//*-----------------------------------------------------------------
//*
//* Fonction      : n_ds_commune::uf_Epuration_ZoneCommune ( PRIVATE )
//* Auteur        : Fabry JF
//* Date          : 12/09/2003 10:48:04
//* Libell$$HEX8$$e9002000200020002000200020002000$$ENDHEX$$: Supprime tout ce qui est g$$HEX1$$ea00$$ENDHEX$$nant dans la chaine de 
//*					  la ville afin de ne garder que la ville.
//* Commentaires  : [DCMP060445]
//*
//* Arguments     : String 	asVille 		aRef
//*					  Integer	aiCode		aRef	 1 : Pr$$HEX1$$e900$$ENDHEX$$sence d'un CEDEX, BP, etc 
//*
//* Retourne      : 
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....
//* #1	FPI	18/03/2010	[Bug.Incident.9415] Correction si ville ne contient que des caract$$HEX1$$e800$$ENDHEX$$res $$HEX2$$e0002000$$ENDHEX$$supprimer
//*-----------------------------------------------------------------

String sVille, sCar, sMot, sMotSubst
String sTbMotCle []  // Mots Cl$$HEX4$$e9002000e0002000$$ENDHEX$$ne pas tenir Compte
Integer iTotMotCle, iCpt, iPos
Boolean bCarTrouve

sTbMotCle = { " BP", "CEDEX", "C$$HEX1$$c900$$ENDHEX$$DEX", "CED$$HEX1$$c900$$ENDHEX$$X", "C$$HEX1$$c900$$ENDHEX$$D$$HEX1$$c900$$ENDHEX$$X" }
sVille = Upper ( asVille )
aiCode = 0

// Controle de parametre
if isnull(asville) then
	aicode = -1
	return
End If

/*------------------------------------------------------------------*/
/* 1 : Suppression des mots cl$$HEX1$$e900$$ENDHEX$$s                                    */
/*------------------------------------------------------------------*/
iTotMotCle = UpperBound ( sTbMotCle )
For iCpt = 1 To iTotMotCle
	iPos = 1
	Do While iPos > 0 
		iPos = Pos ( sVille, sTbMotCle [iCpt], 1 )
		If iPos > 0 Then
			sVille = Replace ( sVille , iPos, Len ( sTbMotCle [iCpt]), "" ) 
			aiCode = 1
		End If
	Loop
Next

/*------------------------------------------------------------------*/
/* 2 : Par la gauche, suppression de tout caract$$HEX1$$e800$$ENDHEX$$re non compris     */
/* entre 65 et 90 (ASCII).                                          */
/*------------------------------------------------------------------*/
bCarTrouve = TRUE
//Do While bCarTrouve 
Do While bCarTrouve and Len(sVille) > 0	// #1 - [Bug.Incident.9415] 
	sCar = Left ( sVille, 1 )

	Choose Case asc ( sCar ) 
		Case 65 To 90
			bCarTrouve = False

		Case Else
			bCarTrouve = TRUE
				sVille = Right ( sVille, Len ( sVille ) - 1 )
	End Choose 
Loop

/*------------------------------------------------------------------*/
/* 3 : Par la Droite, suppression de tout caract$$HEX1$$e800$$ENDHEX$$re non compris     */
/* entre 65 et 90 (ASCII).                                          */
/*------------------------------------------------------------------*/
bCarTrouve = TRUE
//Do While bCarTrouve 
Do While bCarTrouve and Len(sVille) > 0	// #1 - [Bug.Incident.9415] 
	sCar = Right ( sVille, 1 )
	Choose Case asc ( sCar ) 
		Case 65 To 90
			bCarTrouve = False

		Case Else
			bCarTrouve = TRUE
				sVille = Left ( sVille, Len ( sVille ) - 1 )

	End Choose 
Loop


/*------------------------------------------------------------------*/
/* 4 : Si _SAINT_ Ou _SAINTE_ trouv$$HEX2$$e9002000$$ENDHEX$$en d$$HEX1$$e900$$ENDHEX$$but de chaine remplacer   */
/* par ST ou STE                                                    */

/*------------------------------------------------------------------*/
For iCpt = 1 To 4
	Choose Case iCpt
		Case 1
			sMot = " SAINT "
			sMotSubst = " ST "
		Case 2
			sMot = " SAINTE "
			sMotSubst = " STE "
		Case 3
			sMot = "SAINT "
			sMotSubst = "ST "
		Case 4
			sMot = "SAINTE "
			sMotSubst = "STE "
			
	End Choose

	iPos = Pos ( sVille, sMot, 1 )

	Choose Case iCpt
		Case 1, 2
			If iPos > 0 Then
				sVille = Replace ( sVille, iPos, Len ( sMot ), sMotSubst ) 
			End If

		Case 3, 4
			If iPos = 1 Then
				sVille = Replace ( sVille, iPos, Len ( sMot ), sMotSubst ) 
			End If
	End Choose 
Next

/*------------------------------------------------------------------*/
/* 5 : Si la ville est compos$$HEX1$$e900$$ENDHEX$$e, il ne doit y avoir qu'un espace 	  */
/* entre les mots.																  */
/*------------------------------------------------------------------*/
iPos = 1 
Do While iPos > 0 
	iPos = Pos ( sVille, "  ", 1 )
	If iPos > 0 Then
		sVille = Replace ( sVille , iPos, 2, " " ) 
	End If
Loop


asVille = sVille

end subroutine

public function boolean of_isempty (string as_source);
//*-----------------------------------------------------------------
//*
//* Fonction		: u_spb_ds_commune::of_isempty
//* Auteur			: Pierre-Henri Gillot
//* Date				: 17/10/2006 11:26:52
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: [DCMP060445] equivalent a of_isEmpty de n_cst_string
//*
//* Arguments		: value string as_source	 */
//*
//* Retourne		: boolean	
//*
//*-----------------------------------------------------------------
//* MAJ   PAR      Date	     Modification
//* #..   ...   ../../....   
//* 
//*-----------------------------------------------------------------

if IsNull(as_source) or Len(as_source)=0 then
	//String is empty
	Return True
end if
	
//String is Not empty
return False
end function

on u_spb_ds_commune.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_spb_ds_commune.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

