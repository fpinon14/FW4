HA$PBExportHeader$w_consulter_paragraphe.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre qui appara$$HEX1$$ee00$$ENDHEX$$t pour afficher le libell$$HEX2$$e9002000$$ENDHEX$$d'un paragraphe en clair (Gestion d'un buffer)
forward
global type w_consulter_paragraphe from w_ancetre
end type
type dw_1 from datawindow within w_consulter_paragraphe
end type
end forward

global type w_consulter_paragraphe from w_ancetre
boolean visible = true
integer x = 859
integer y = 40
integer width = 2496
integer height = 588
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = popup!
dw_1 dw_1
end type
global w_consulter_paragraphe w_consulter_paragraphe

type variables
Private :
    Integer        iiMaxPara  = 8
end variables

forward prototypes
public function boolean wf_afficherparagraphe (ref s_pass astpass)
end prototypes

public function boolean wf_afficherparagraphe (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		: Wf_AfficherParagraphe ( Public )
//* Auteur			: Erick John Stark
//* Date				: 17/07/1997 15:31:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Affichage d'un Paragraphe
//*
//* Arguments		: s_Pass			astPass				(R$$HEX1$$e900$$ENDHEX$$f)	
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en		 True 	= Tout est OK 
//*										 False	= Probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Cette fonction a besoin de certaines valeurs pour pouvoir        */
/* marcher.                                                         */
/* En premier lieu, il faut lui passer un objet de transaction.     */
/* En second lieu, il faut lui passer le code paragraphe que l'on   */
/* veut afficher, ainsi que le titre.                               */
/* Cette fonction marche avec SqlServer et SqlBase                  */
/*------------------------------------------------------------------*/

String	sIdPara, sRech, sTxt
		
Long lLigTrv, lIdOrdre, lNbrLig

Blob		blTxt

Boolean bRet

dw_1.Visible = False

sIdPara		= astPass.sTab[1]

lNbrLig		= dw_1.RowCount ()
sRech			= "ID_PARA = '" + sIdPara + "'"
bRet			= True

/*------------------------------------------------------------------*/
/* Il faut tester si le code paragraphe a d$$HEX1$$e900$$ENDHEX$$j$$HEX3$$e0002000e900$$ENDHEX$$t$$HEX2$$e9002000$$ENDHEX$$charg$$HEX1$$e900$$ENDHEX$$.          */
/*------------------------------------------------------------------*/

lLigTrv = dw_1.Find ( sRech, 1, lNbrLig )

If	lLigTrv > 0 Then

/*------------------------------------------------------------------*/
/* On vient de trouver le code paragraphe, donc pas besoin de       */
/* faire un select.                                                 */
/*------------------------------------------------------------------*/

	dw_1.SetRow ( lLigTrv )
	dw_1.ScrollToRow ( lLigTrv )

	astPass.sTab[2] = astPass.sTab[2] + "*"

Else

/*------------------------------------------------------------------*/
/* On ne trouve pas le paragraphe, on teste si le buffer est        */
/* plein. Si Oui, on supprime la premi$$HEX1$$e800$$ENDHEX$$re ligne charg$$HEX1$$e900$$ENDHEX$$e, sinon, on  */
/* charge le paragraphe.                                            */
/*------------------------------------------------------------------*/

	If	lNbrLig > 0 Then
		lIdOrdre = dw_1.GetItemNumber ( lNbrLig, "ID_ORDRE" )
	End If		
	lIdOrdre ++

	If	lNbrLig >= iiMaxPara Then
		dw_1.Sort ()
		dw_1.DeleteRow ( 1 )
	End If

/*------------------------------------------------------------------*/
/* On charge le paragraphe en fonction du type de DBMS              */
/*------------------------------------------------------------------*/

	Choose Case Left ( Upper ( astPass.trTrans.Dbms ), 5 )
	Case "GUPTA"

		SELECTBLOB 	Txt_Para
		INTO			:blTxt
		FROM			sysadm.paragraphe
		WHERE			sysadm.paragraphe.id_para = :sIdPara
		USING			astPass.trTrans	;

		sTxt = String ( blTxt )

	Case "MSS M"							// "MSS Microsoft Sql Server 6.0"

		SELECT	 	txt_para
		INTO			:sTxt
		FROM			sysadm.paragraphe
		WHERE			sysadm.paragraphe.id_para = :sIdPara
		USING			astPass.trTrans	;

	// [MIGPB11] [EMD] : Debut Migration : support du DBMS SNC
	Case "SNC S"							// "SNC SQL Server"

		SELECT	 	txt_para
		INTO			:sTxt
		FROM			sysadm.paragraphe
		WHERE			sysadm.paragraphe.id_para = :sIdPara
		USING			astPass.trTrans	;
		
	// [MIGPB11] [EMD] : Fin Migration

	Case Else // [PI056]

		SELECT	 	txt_para
		INTO			:sTxt
		FROM			sysadm.paragraphe
		WHERE			sysadm.paragraphe.id_para = :sIdPara
		USING			astPass.trTrans	;
		
	End Choose

	If astPass.trTrans.SqlCode <> 0 Then

			stMessage.bErreurG	= True
			stMessage.sVar[1]		= sIdPara
			stMessage.sTitre		= " - Afficher Paragraphe - "
			stMessage.Icon			= Exclamation!
			stMessage.sCode 		= "ANCE050"

			f_Message ( stMessage )
			bRet = False

	Else

		lNbrLig = dw_1.InsertRow ( 0 )
		dw_1.SetItem ( lNbrLig, "ID_ORDRE", lIdOrdre )
		dw_1.SetItem ( lNbrLig, "ID_PARA", sIdPara )
		dw_1.SetItem ( lNbrLig, "TXT_PARA", sTxt )

		dw_1.Sort ()

		dw_1.SetRow ( lNbrLig )
		dw_1.ScrollToRow ( lNbrLig )

	End If

End If

This.Title 	= astPass.sTab[2]
dw_1.Visible = True

Return ( bRet )
end function

on w_consulter_paragraphe.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_consulter_paragraphe.destroy
call super::destroy
destroy(this.dw_1)
end on

type cb_debug from w_ancetre`cb_debug within w_consulter_paragraphe
end type

type dw_1 from datawindow within w_consulter_paragraphe
integer x = 9
integer y = 8
integer width = 2469
integer height = 488
integer taborder = 1
string dataobject = "d_consulter_paragraphe"
borderstyle borderstyle = styleraised!
end type

