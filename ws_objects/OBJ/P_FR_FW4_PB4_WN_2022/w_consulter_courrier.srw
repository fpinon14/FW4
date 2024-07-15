HA$PBExportHeader$w_consulter_courrier.srw
$PBExportComments$-----} Fen$$HEX1$$ea00$$ENDHEX$$tre qui appara$$HEX1$$ee00$$ENDHEX$$t pour afficher la composition d'un courrier.
forward
global type w_consulter_courrier from w_ancetre
end type
type dw_1 from datawindow within w_consulter_courrier
end type
end forward

global type w_consulter_courrier from w_ancetre
boolean visible = true
integer x = 859
integer y = 40
integer width = 2629
integer height = 1856
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
dw_1 dw_1
end type
global w_consulter_courrier w_consulter_courrier

type variables
Private :
    Integer        iiMaxPara  = 8
end variables

forward prototypes
public function boolean wf_affichercourrier (ref s_pass astpass)
end prototypes

public function boolean wf_affichercourrier (ref s_pass astpass);//*-----------------------------------------------------------------
//*
//* Fonction		:	Wf_AfficherCourrier ( Public )
//* Auteur			:	N$$HEX1$$b000$$ENDHEX$$6
//* Date				:	18/09/1997 15:07:48
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$:	Affiche la composition d'un courrier.
//*						Ordre des paragraphes en fonction de leur ordre
//*						sur la Dw permettant la composition.
//* Commentaires	: 
//*
//* Arguments		:	s_Pass			astPass				(R$$HEX1$$e900$$ENDHEX$$f)	
//*
//* Retourne		:	Bool$$HEX1$$e900$$ENDHEX$$en		 True 	= Tout est OK 
//*										 False	= Probl$$HEX1$$e800$$ENDHEX$$me
//*
//*-----------------------------------------------------------------

/*------------------------------------------------------------------*/
/* Le tableau composant le courrier doit $$HEX1$$ea00$$ENDHEX$$tre renseign$$HEX2$$e9002000$$ENDHEX$$de la       */
/* mani$$HEX1$$e800$$ENDHEX$$re suivante :                                               */
/*      sTab [ 1 ] : titre de la fen$$HEX1$$ea00$$ENDHEX$$tre de visualisation.          */
/*                                                                  */
/*      sTab [ 2 ] : identifiant du premier paragraphe.             */
/*      sTab [ 3 ] : libell$$HEX2$$e9002000$$ENDHEX$$du premier paragraphe.                 */
/*                                                                  */
/*      sTab [ n ]     : identifiant du N i$$HEX1$$e800$$ENDHEX$$me paragraphe.          */
/*      sTab [ n + 1 ] : libell$$HEX2$$e9002000$$ENDHEX$$du N i$$HEX1$$e800$$ENDHEX$$me paragraphe.              */
/*                                                                  */
/*------------------------------------------------------------------*/

Boolean	bRet			// valeur de retour de la fonction.

String	sTxt			// variable tampon pour le blob.

Long		lNbrLig		// N$$HEX2$$b0002000$$ENDHEX$$de ligne inser$$HEX1$$e900$$ENDHEX$$
Long		lCpt			// Compteur.
Long		lNbrPara		// Nombre de paragraphe composant le courrier

Blob		blTxt			// Text du paragraphe stock$$HEX2$$e9002000$$ENDHEX$$dans un blob pour SqlBase.

dw_1.Reset ()
dw_1.Visible = False
bRet			 = True

/*------------------------------------------------------------------*/
/* nombre de paragraphe composant ce courrier.                      */
/* Ne peut pas $$HEX1$$ea00$$ENDHEX$$tre nul.                                            */
/*------------------------------------------------------------------*/
lNbrPara = UpperBound ( astPass.sTab )

For lCpt = 2 To lNbrPara step 2

	/*------------------------------------------------------------------*/
	/* On charge le paragraphe en fonction du type de DBMS              */
	/*------------------------------------------------------------------*/
	Choose Case Left ( Upper ( astPass.trTrans.Dbms ), 5 )

		Case "GUPTA"

			SELECTBLOB 	Txt_Para
			INTO			:blTxt
			FROM			sysadm.paragraphe
			WHERE			sysadm.paragraphe.id_para = :astPass.sTab [ lCpt ]
			USING			astPass.trTrans	;

			sTxt = String ( blTxt )

		Case "MSS M"							// "MSS Microsoft Sql Server 6.0"

			SELECT	 	sysadm.paragraphe.txt_para
			INTO			:sTxt
			FROM			sysadm.paragraphe
			WHERE			sysadm.paragraphe.id_para = :astPass.sTab [ lCpt ]
			USING			astPass.trTrans	;

		// [MIGPB11] [EMD] : Debut Migration : support du DBMS SNC
		Case "SNC S"							// "SNC SQL Server"
			
			SELECT	 	sysadm.paragraphe.txt_para
			INTO			:sTxt
			FROM			sysadm.paragraphe
			WHERE			sysadm.paragraphe.id_para = :astPass.sTab [ lCpt ]
			USING			astPass.trTrans	;
			
		// [MIGPB11] [EMD] : Fin Migration		

		// [PI056]
		Case Else
			SELECT	 	sysadm.paragraphe.txt_para
			INTO			:sTxt
			FROM			sysadm.paragraphe
			WHERE			sysadm.paragraphe.id_para = :astPass.sTab [ lCpt ]
			USING			astPass.trTrans	;
			
	End Choose

	If astPass.trTrans.SqlCode <> 0 Then

		stMessage.bErreurG	= True
		stMessage.sVar[1]		= astPass.sTab [ lCpt ]
		stMessage.sTitre		= " - Afficher Composition du courrier - "
		stMessage.Icon			= Exclamation!
		stMessage.sCode 		= "ANCE050"

		f_Message ( stMessage )
		bRet = False

	Else

		lNbrLig = dw_1.InsertRow ( 0 )

		dw_1.SetItem ( lNbrLig, "ID_ORDRE", lCpt )
		dw_1.SetItem ( lNbrLig, "ID_PARA" , astPass.sTab [ lCpt ]     )
		dw_1.SetItem ( lNbrLig, "LIB_PARA", astPass.sTab [ lCpt + 1 ] )
		dw_1.SetItem ( lNbrLig, "TXT_PARA", sTxt )

	End If

Next

dw_1.Sort ()
dw_1.SetRow ( 1 )
dw_1.ScrollToRow ( 1 )

This.Title 	= astPass.sTab [ 1 ]

dw_1.Modify ( "DataWindow.Detail.Height.AutoSize=Yes" )


dw_1.Visible = True

Return ( bRet )
end function

on w_consulter_courrier.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_consulter_courrier.destroy
call super::destroy
destroy(this.dw_1)
end on

event resize;call super::resize;dw_1.height=newheight -16
dw_1.width=newwidth - 9
end event

type cb_debug from w_ancetre`cb_debug within w_consulter_courrier
end type

type dw_1 from datawindow within w_consulter_courrier
integer x = 5
integer y = 8
integer width = 2583
integer height = 1736
integer taborder = 1
string dataobject = "d_consulter_courrier"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

