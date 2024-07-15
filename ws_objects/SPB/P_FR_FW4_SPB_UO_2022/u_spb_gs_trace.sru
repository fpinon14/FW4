HA$PBExportHeader$u_spb_gs_trace.sru
$PBExportComments$---} User Object permettant de tracer le parametrage de la base.
forward
global type u_spb_gs_trace from nonvisualobject
end type
end forward

global type u_spb_gs_trace from nonvisualobject
end type
global u_spb_gs_trace u_spb_gs_trace

type variables
u_Transaction	itrTrans	// Objet de transaction
String		isMoteur	// Type du moteur GUP ou MSS

Protected :
Long		ilDernierNumero	//dernier numero utilise en mode incrementation autonome.
Boolean		ibModeIncAutonome	//Indique si on est en mode ncrementation autonome.




end variables

forward prototypes
public function boolean uf_trace (string astype, string astable, string ascle[], string ascol[], string asval[])
public function boolean uf_initialisation ()
public subroutine uf_preparertrace (string assql, ref string ascol[], ref string asval[])
public subroutine uf_committrace (boolean abcommit)
public function boolean uf_modeincautonome (boolean abmodeinc)
end prototypes

public function boolean uf_trace (string astype, string astable, string ascle[], string ascol[], string asval[]);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_Trace ()
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 14/02/1997 16:00:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Enregistrement d'une action sur une table qui doit
//*					  tracer.
//*
//* Arguments		: asType		String ( Val ) : type d'ordre SQL $$HEX2$$e0002000$$ENDHEX$$enregistrer.
//*					  asTable	String ( Val ) : nom de la table $$HEX2$$e0002000$$ENDHEX$$tracer.
//*					  asCle[]	String ( Val ) : tableau contenant les valeurs constituants
//*														  la cl$$HEX2$$e9002000$$ENDHEX$$d'acc$$HEX1$$e900$$ENDHEX$$s de l'enregistrement $$HEX2$$e0002000$$ENDHEX$$tracer.
//*					  asCol[]	String ( Val ) : tableau contenant les nom des colonnes concern$$HEX1$$e900$$ENDHEX$$es.
//*					  asVal[]	String ( Val ) : tableau contenant les valeurs des colonnes concern$$HEX1$$e900$$ENDHEX$$es.
//*
//* Retourne		: Bool$$HEX1$$e900$$ENDHEX$$en	Vrai, la validation peut se poursuivre.
//*
//*-----------------------------------------------------------------
//* #1	PLJ	06/12/2001	Traitement Sp$$HEX1$$e900$$ENDHEX$$cifique 'MSS' 'GUP'
//*-----------------------------------------------------------------
Boolean	bRet
Long		lCpt				// Compteur de colonne.
Long		lNbCol			// Nombre de colonne $$HEX2$$e0002000$$ENDHEX$$inserer dans la table VALEUR.
Long		lIdTrace			// Valeur du compteur de trace.
String 	sIdTrace			// Compteur de trace.
sTring	sMajLe			// Quand.
String	sIdCol [ 10 ]	// Identifiant de l'enregistrement concern$$HEX1$$e900$$ENDHEX$$.
String	sSql				// Ordre SQL.

bRet			= True
sIdCol		= asCle
lIdTrace	= 0


/*------------------------------------------------------------------*/
/* Incr$$HEX1$$e900$$ENDHEX$$mentation du compteur de trace :                            */
/* Si on n'est pas en mode incr$$HEX1$$e900$$ENDHEX$$mentation autonome, on utilise      */
/* f_incrementer pour initialiser IdTrace (cas o$$HEX2$$f9002000$$ENDHEX$$l'on n'a qu'un    */
/* seul appel $$HEX2$$e0002000$$ENDHEX$$la fonction de trace, dans les tables simples par   */
/* exemple).                                                        */
/* Si on est en mode incrementation autonome (cas o$$HEX2$$f9002000$$ENDHEX$$on a plusieurs */
/* trace dans une m$$HEX1$$ea00$$ENDHEX$$me fen$$HEX1$$ea00$$ENDHEX$$tre, on ne veut faire appel $$HEX13$$e000200020002000200020002000200020002000200020002000$$ENDHEX$$*/
/* f_incrementer qu'une seule fois puis incr$$HEX1$$e900$$ENDHEX$$menter directement     */
/* l'IdTrace) :                                                     */
/*     - si le dernier numero = 0 alors on utilise f_incrementer.   */
/*     - sinon on incr$$HEX1$$e900$$ENDHEX$$mente directment $$HEX2$$e0002000$$ENDHEX$$partir de ilderniernumero.*/
/*------------------------------------------------------------------*/
If ( not ibModeIncAutonome ) Or ( ibModeIncAutonome And ilDernierNumero = 0 )  Then

	lIdTrace = f_incrementer ( "CPT_TRACE", itrtrans )

	If ibModeIncAutonome Then ilDernierNumero = lIdTrace

Else

	ilDernierNumero ++
	lIdTrace = ilDernierNumero

End IF



If lIdTrace > 0	Then
		sIdTrace = "'" + String ( lIdTrace, "0000000" ) + "'"
Else
	bRet = False
End If


/*------------------------------------------------------------------*/
/* Insertion de l'action dans la table TRACE.                       */
/*------------------------------------------------------------------*/
If bRet	Then

	/*----*/
   /* #1 */
	/*------------------------------------------------------------------*/
	/* Traitement sp$$HEX1$$e900$$ENDHEX$$cificique Moteur 'MSS'                             */
	/*------------------------------------------------------------------*/
	If isMoteur = 'MSS' Then
		sMajLe = "'" + string ( DateTime ( Today (), Now () ), "dd/mm/yyyy hh:mm:ss.ff" ) + "'"

		For lcpt = 1 To 10
			If sIdCol [ lCpt ] = ""	Then sIdCol [ lCpt ] = "null"
			If isNumber ( sIdCol [ lCpt ] ) Then sIdCol [ lCpt ] = "'" + sIdCol [ lCpt ] + "'"	// #2
			
		Next

		sSql	=	'EXECUTE sysadm.d_trace_i1 '     		 + &
					sIdTrace									+ ","  + &
					"'" + stGLB.sCodAppli				+ "'," + &
					"'" + Upper( asTable	)				+ "'," + &
					sIdCol [ 1 ]							+ ","  + &
					sIdCol [ 2 ]							+ ","  + &
					sIdCol [ 3 ]							+ ","  + &
					sIdCol [ 4 ]							+ ","  + &
					sIdCol [ 5 ]							+ ","  + &
					sIdCol [ 6 ]							+ ","  + &
					sIdCol [ 7 ]							+ ","  + &
					sIdCol [ 8 ]							+ ","  + &
					sIdCol [ 9 ]							+ ","  + &
					sIdCol [ 10 ]							+ ","  + &
					asType									+ ","  + &
					sMajLe									+ ","  + &
					"'" + stGLB.sCodOper + "'"
	End If


	/*----*/
   /* #1 */
	/*------------------------------------------------------------------*/
	/* Traitement sp$$HEX1$$e900$$ENDHEX$$cificique Moteur 'GUP'                             */
	/*------------------------------------------------------------------*/
	If isMoteur = 'GUP' Then
		sMajLe = "'" + string ( DateTime ( Today (), Now () ), "yyyy-mm-dd hh:mm:ss.ff" ) + "'"

		For lcpt = 1 To 10
			If sIdCol [ lCpt ] = ""	Then
				sIdCol [ lCpt ] = "'" + sIdCol [ lCpt ] + "'"
			End If
		Next

		sSql	=	'EXECUTE sysadm.d_trace_i1 '     + &
					sIdTrace									+ "," + &
					stGLB.sCodAppli						+ "," + &
					asTable									+ "," + &
					sIdCol [ 1 ]							+ "," + &
					sIdCol [ 2 ]							+ "," + &
					sIdCol [ 3 ]							+ "," + &
					sIdCol [ 4 ]							+ "," + &
					sIdCol [ 5 ]							+ "," + &
					sIdCol [ 6 ]							+ "," + &
					sIdCol [ 7 ]							+ "," + &
					sIdCol [ 8 ]							+ "," + &
					sIdCol [ 9 ]							+ "," + &
					sIdCol [ 10 ]							+ "," + &
					asType									+ "," + &
					sMajLe									+ "," + &
					stGLB.sCodOper
	End If

	// [MIGPB11] [EMD] : Debut Migration : [SNC] contourne le fait que SNC ne mette pas $$HEX2$$e0002000$$ENDHEX$$jour SqlnRows
	//EXECUTE IMMEDIATE :sSql USING itrTrans ;
	f_execute( sSql, itrTrans )
	// [MIGPB11] [EMD] : Fin Migration
	If itrTrans.SQLCode < 0 Then	bRet = False

End If



/*------------------------------------------------------------------*/
/* Si l'insert dans la table TRACE s'est bien r$$HEX1$$e900$$ENDHEX$$alis$$HEX2$$e9002000$$ENDHEX$$et si         */
/* l'action n'est pas de type D ( Delete ) il faut mettre $$HEX2$$e0002000$$ENDHEX$$jour    */
/* la table des VALEURS.                                            */
/*------------------------------------------------------------------*/
If bRet And asType <> 'D'	Then

	lNbCol = UpperBound ( asCol )

	For lCpt = 1 to lNbCol

		If asVal [ lCpt ] <> "''" And asVal [ lCpt ] <> ""	Then

			/*----*/
			/* #1 */
			/*----------------------------------------------------------*/
			/* Traitement Sp$$HEX1$$e900$$ENDHEX$$cifique 'MSS'                              */
			/*----------------------------------------------------------*/
			If isMoteur = 'MSS' Then
				If isNumber ( asVal [lCpt] ) Then asVal [lCpt]  = "'" + asVal [lCpt] + "'"
			End If


			sSql	=	'EXECUTE sysadm.d_valeur_i1 '		+ &
						sIdTrace									+ "," + &
						asCol [ lCpt ]							+ "," + &
						asVal [ lCpt ]

			// [MIGPB11] [EMD] : Debut Migration : [SNC] contourne le fait que SNC ne mette pas $$HEX2$$e0002000$$ENDHEX$$jour SqlnRows
			//EXECUTE IMMEDIATE :sSql USING itrTrans ;
			f_execute( sSql, itrTrans )
			// [MIGPB11] [EMD] : Fin Migration

			If itrTrans.SQLCode < 0 Then
				bRet = False
				Exit
			End If

		End If

	Next

End If


Return ( bRet )
end function

public function boolean uf_initialisation ();//*-----------------------------------------------------------------
//*
//* Fonction		: uf_Initialisation
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 14/02/1997 15:30:15
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Initialisation de l'objet de transaction du user Objet.
//*
//* Commentaires	: 
//*
//* Arguments		: aucun
//*	
//* Retourne		: Bret : Bool$$HEX1$$e900$$ENDHEX$$en
//*										
//*-----------------------------------------------------------------
//* #1   05/12/2001 PLJ  connection $$HEX2$$e0002000$$ENDHEX$$la nouvelle base TRACE
//*-----------------------------------------------------------------
Boolean	bRet



bRet = True
/*------------------------------------------------------------------*/
/* Initialise le dernier num$$HEX1$$e900$$ENDHEX$$ro utilis$$HEX4$$e9002000e0002000$$ENDHEX$$ZERO et le mode           */
/* incr$$HEX1$$e900$$ENDHEX$$mentation autonome $$HEX2$$e0002000$$ENDHEX$$FALSE. (Variable utilis$$HEX1$$e900$$ENDHEX$$es dans les    */
/* fonctions uf_trace (), uf_ModeIncAutonome().                     */
/*------------------------------------------------------------------*/

ilDernierNumero 	= 0
ibModeIncAutonome = False


itrTrans = Create u_transaction

/*----*/
/* #1 */
/*------------------------------------------------------------------*/
/* Devons-nous nous connecter sur une base Gupta ou SqlServer       */
/* On stocke $$HEX1$$e900$$ENDHEX$$galement le type de moteur qui sera utile pour les    */
/* fonctions d'$$HEX1$$e900$$ENDHEX$$criture                                             */
/*------------------------------------------------------------------*/
isMoteur = profileString ( stGLB.sFichierIni, "TRACE BASE", "DBMS", "ERREUR" )

If isMoteur = "ERREUR" Then
	MessageBox ( "Erreur", "Impossible de d$$HEX1$$e900$$ENDHEX$$terminer le type de moteur pour la Trace" )
	bRet = False
Else
	isMoteur = Upper ( Left ( isMoteur, 3 ) )
End If

// [MIGPB11] [EMD] : Debut Migration : modif de la variable isMoteur, si SNC on y met MSS
// If isMoteur = "SNC" Then
If isMoteur <> "GUP" Then // [PI056] MSS par d$$HEX1$$e900$$ENDHEX$$faut
	isMoteur = "MSS"	
End If
// [MIGPB11] [EMD] : Fin Migration

If bRet And isMoteur = 'GUP' Then

	If Not f_ConnectGupta ( stGLB.sFichierIni, "TRACE BASE", itrTrans, stGLB.sMessageErreur ) Then
		MessageBox ( "Erreur", stGLB.sMessageErreur )
		bRet = False
	End If

End If


If bRet And isMoteur = 'MSS' Then

	If Not f_ConnectSqlServer ( stGLB.sFichierIni, "TRACE BASE", itrTrans, stGLB.sMessageErreur,stGlb.slibcourtappli, stGlb.sCodOper ) Then
		MessageBox ( "Erreur", stGLB.sMessageErreur )
		bRet = False
	End If

End If



Return ( bRet )





end function

public subroutine uf_preparertrace (string assql, ref string ascol[], ref string asval[]);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_PreparerTrace ()
//* Auteur			: N$$HEX1$$b000$$ENDHEX$$6
//* Date				: 14/02/1997 16:00:19
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: 
//* Commentaires	: Renseigne les tableaux lors d'un update.
//*
//* Arguments		: asSql		String ( Val ) : Ordre SQL g$$HEX1$$e900$$ENDHEX$$n$$HEX1$$e900$$ENDHEX$$r$$HEX2$$e9002000$$ENDHEX$$par la datawindow.
//*					  asCol[]	String ( Ref ) : tableau contenant les nom des colonnes concern$$HEX1$$e900$$ENDHEX$$es.
//*					  asVal[]	String ( Ref ) : tableau contenant les valeurs des colonnes concern$$HEX1$$e900$$ENDHEX$$es.
//*
//* Retourne		: Rien
//*
//*-----------------------------------------------------------------
//* #1	PLJ	06/12/2001	Traitement Sp$$HEX1$$e900$$ENDHEX$$cifique 'MSS' 'GUP'
//*-----------------------------------------------------------------

Long		lCpt				// Compteur de colonne.
Long		lNbCol			// Nombre de colonne $$HEX2$$e0002000$$ENDHEX$$inserer dans la table VALEUR.
Long		lPos				// Position de la chaine.
Long		lPosV				// Position de la virgule
Long		lPosSuiv			// Position de la virgule suivante
String	sSqlTrim			// Trim de la chaine SQL.
String	sSqlSansQuote	// Chaine SQL sans les simples quotes de d$$HEX1$$e900$$ENDHEX$$but et de fin de chaine.

/*------------------------------------------------------------------*/
/* Elimination de la fin de l'Update.                               */
/*------------------------------------------------------------------*/
lPos = Pos ( asSql, "WHERE" )

If lPos > 0	Then

	asSql = Left ( asSql, lPos - 2 )

	/*------------------------------------------------------------------*/
	/* Elimination du d$$HEX1$$e900$$ENDHEX$$but de l'Update.                                */
	/*------------------------------------------------------------------*/
	lPos = Pos ( asSql, "SET" )

	If lPos > 0	Then

		asSql = Mid ( asSql, lPos + 3 )

	End If

End If



/*----*/
/* #1 */
/*------------------------------------------------------------------*/
/* Traitement sp$$HEX1$$e900$$ENDHEX$$cifique pour Moteur 'MSS'                          */
/*------------------------------------------------------------------*/

If isMoteur = 'MSS' Then

	/*------------------------------------------------------------------*/
	/* Remplace la chaine " = " par le caract$$HEX1$$e800$$ENDHEX$$re ','                    */
	/*------------------------------------------------------------------*/
	lPos = Pos ( asSql, " = " )

	Do While lPos > 0
		asSql = Replace ( asSql, lPos, 3, "," )
		lPos = Pos ( asSql, " = " )
	Loop

	/*------------------------------------------------------------------*/
	/* Renseigne les tableaux de colonnes et de valeurs.                */
	/*------------------------------------------------------------------*/
	lPos = Pos ( asSql, "," )

	lCpt = 1

	Do While lPos > 0

		asCol [ lCpt ] = UPPER ( Trim ( Left ( asSql, lPos - 1 ) ) )
		asSql = Mid ( asSql, lPos + 1 )
		lPos = Pos ( asSql, "," )

		If lPos = 0	Then
			/*------------------------------------------------------------------*/
			/* Derni$$HEX1$$e800$$ENDHEX$$re valeur de la chaine.                                    */
			/*------------------------------------------------------------------*/
			sSqlTrim			= 	Trim ( asSql )

			/*------------------------------------------------------------------*/
			/* Pour tester si la zone est de type Date, on doit supprimer les   */
			/* simples quotes qui l'entourent.                                  */
			/*------------------------------------------------------------------*/
			sSqlSansQuote  = Mid ( Mid ( sSqlTrim , 2 , Len ( sSqlTrim ) ) , 1 , &
   					        Len ( Mid ( sSqlTrim , 2 , Len ( sSqlTrim ) ) ) - 1 )

			If IsDate ( sSqlSansQuote ) Then

				//sSqlTrim = "'" + String ( Date ( sSqlSansQuote ) , "yyyy-mm-dd" ) + "'"
				sSqlTrim = "'" + String ( Date ( sSqlSansQuote ) , "dd/mm/yyyy" ) + "'"
			End If

			asVal [ lCpt ] = sSQLTrim

		Else

			sSqlTrim  = Trim ( Left ( asSql, lPos - 1 ) )

			/*------------------------------------------------------------------*/
			/* Pour tester si la zone est de type Date, on doit supprimer les   */
			/* simples quotes qui l'entourent.                                  */
			/*------------------------------------------------------------------*/
			sSqlSansQuote  = Mid ( Mid ( sSqlTrim , 2 , Len ( sSqlTrim ) ) , 1 , &
								  Len ( Mid ( sSqlTrim , 2 , Len ( sSqlTrim ) ) ) - 1 )

			If IsDate ( sSqlSansQuote ) Then

//				sSqlTrim = "'" + String ( Date ( sSqlSansQuote ) , "yyyy-mm-dd" ) + "'"
				sSqlTrim = "'" + String ( Date ( sSqlSansQuote ) , "dd/mm/yyyy" ) + "'"
			End If

			asVal [ lCpt ] = sSqlTrim
			asSql = Mid ( asSql, lPos + 1 )
			lPos = Pos ( asSql, "," )

		End If

		lCpt ++

	Loop

End If



/*----*/
/* #1 */
/*------------------------------------------------------------------*/
/* Traitement sp$$HEX1$$e900$$ENDHEX$$cifique pour Moteur 'GUP'                          */
/*------------------------------------------------------------------*/

If isMoteur = 'GUP' Then

	/*------------------------------------------------------------------*/
	/* Renseigne les tableaux de colonnes et de valeurs.                */
	/*------------------------------------------------------------------*/
	lPos = Pos ( asSql, " = " )

	lCpt = 1

	Do While lPos > 0

		// On s'occupe du nom de la colonne

		asCol [ lCpt ] = UPPER ( Trim ( Left ( asSql, lPos - 1 ) ) )
		asSql = Mid ( asSql, lPos + 3 )		// position + " = "

		//*****************************************************************************
		// On r$$HEX1$$e900$$ENDHEX$$cup$$HEX1$$e800$$ENDHEX$$re la valeur de la colonne
		// Je recherche la chaine " = " et ensuite la virgule qui pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e800$$ENDHEX$$de
		// si la chaine " = " n'est pas trouv$$HEX1$$e900$$ENDHEX$$e, c'est qu'il s'agit de la derni$$HEX1$$e800$$ENDHEX$$re 
		// zone de l'update
		// si la chaine " = " est trouv$$HEX1$$e900$$ENDHEX$$e, on recherche la virgule qui pr$$HEX1$$e900$$ENDHEX$$c$$HEX1$$e800$$ENDHEX$$de
		// si aucune virgule trouv$$HEX1$$e900$$ENDHEX$$e, c'est que la chaine " = " appartient $$HEX2$$e0002000$$ENDHEX$$une zone de texte
		// et on relance la recherche de la chaine " = "
		//*****************************************************************************

		lPos  = Pos ( asSql, " = " )

		If lPos = 0	Then
			/*------------------------------------------------------------------*/
			/* Derni$$HEX1$$e800$$ENDHEX$$re valeur de la chaine.                                    */
			/*------------------------------------------------------------------*/
			sSqlTrim			= 	f_Remplace ( Trim ( asSql ), ",", ";" )

			/*------------------------------------------------------------------*/
			/* Pour tester si la zone est de type Date, on doit supprimer les   */
			/* simples quotes qui l'entourent.                                  */
			/*------------------------------------------------------------------*/
			sSqlSansQuote  = Mid ( Mid ( sSqlTrim , 2 , Len ( sSqlTrim ) ) , 1 , &
   					        Len ( Mid ( sSqlTrim , 2 , Len ( sSqlTrim ) ) ) - 1 )

			If IsDate ( sSqlSansQuote ) Then

				sSqlTrim = "'" + String ( Date ( sSqlSansQuote ) , "yyyy-mm-dd" ) + "'"

			End If

			sSQLTrim = f_Remplace ( sSQLTrim, "'", " " )
			sSQLTrim = Trim ( f_Remplace ( sSQLTrim, "$$HEX1$$1920$$ENDHEX$$", " " ) )
			asVal [ lCpt ] = "'" + sSqlTrim + "'"

		Else

			// Recherche de la derni$$HEX1$$e800$$ENDHEX$$re virgule avant la chaine " = "
			lPosV 	= Pos ( asSql, "," )
			lPosSuiv = Pos ( asSql, ",", lPosV )

			Do While ( lPosSuiv > 0 ) And ( lPosSuiv < lPos )

				lPosV = lPosSuiv
				lPosSuiv = Pos ( asSql, ",", lPosV + 1 )
			
			Loop

			sSqlTrim  = f_Remplace ( Trim ( Left ( asSql, lPosV - 1 ) ), ",", ";" )
			sSQLTrim  = f_Remplace ( sSQLTrim, "'", " " )
			sSQLTrim  = Trim ( f_Remplace ( sSQLTrim, "$$HEX1$$1920$$ENDHEX$$", " " ) )

			/*------------------------------------------------------------------*/
			/* Pour tester si la zone est de type Date, on doit supprimer les   */
			/* simples quotes qui l'entourent.                                  */
			/*------------------------------------------------------------------*/
			sSqlSansQuote  = Mid ( Mid ( sSqlTrim , 2 , Len ( sSqlTrim ) ) , 1 , &
								  Len ( Mid ( sSqlTrim , 2 , Len ( sSqlTrim ) ) ) - 1 )

			If IsDate ( sSqlSansQuote ) Then

				sSqlTrim = String ( Date ( sSqlSansQuote ) , "yyyy-mm-dd" )

			End If

			asVal [ lCpt ] = "'" + sSqlTrim + "'"
			asSql = Mid ( asSql, lPosV + 1 )
			lPos 	= Pos ( asSql, " = " )

		End If

		lCpt ++

	Loop

End If



If lcpt > UpperBound ( asCol )	Then
	lNbCol = UpperBound ( asCol )
Else
	lNbCol = lCpt
End If


/*------------------------------------------------------------------*/
/* Elimination des champs CREE_LE, MAJ_LE, MAJ_PAR qui ne doivent   */
/* pas $$HEX1$$ea00$$ENDHEX$$tre trac$$HEX1$$e900$$ENDHEX$$s.                                                 */
/*------------------------------------------------------------------*/
For lCpt = 1 To lNbCol

	If asCol [ lCpt ] = "CREE_LE" Or &
		asCol [ lCpt ] = "MAJ_LE" 	Or &
		asCol [ lCpt ] = "MAJ_PAR"	Then

		asCol [ lCPt ] = ""
		asVal [ lCPt ] = "''"

	End If

Next

Return
end subroutine

public subroutine uf_committrace (boolean abcommit);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_CommitTrace ( )
//* Auteur			: Y. Picard
//* Date				: 27/02/97 11:20:13
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Commit ou rollback la trace selon abCommit.
//* Commentaires	: 
//*
//* Arguments		: Boolean		abCommit	: TRUE pour commiter ; FALSE pour rollbacker.
//*
//* Retourne		: Rien
//*					
//*
//*-----------------------------------------------------------------

f_Commit ( itrTrans, abCommit )
end subroutine

public function boolean uf_modeincautonome (boolean abmodeinc);//*-----------------------------------------------------------------
//*
//* Fonction		: Uf_ModeIncAutonome
//* Auteur			: Y. Picard
//* Date				: 27/02/97 16:06:35
//* Libell$$HEX4$$e900090009000900$$ENDHEX$$: Active ou Desactive le mode incr$$HEX1$$e900$$ENDHEX$$mentation autonome en fonction du
//*						param$$HEX1$$e800$$ENDHEX$$tre pass$$HEX2$$e9002000$$ENDHEX$$abModeInc.
//*
//* Commentaires	: Le mode incr$$HEX1$$e900$$ENDHEX$$mentation autonome permet dans le cas des fen$$HEX1$$ea00$$ENDHEX$$tres
//*  compos$$HEX1$$e900$$ENDHEX$$es o$$HEX2$$f9002000$$ENDHEX$$l'on fait appel plusieurs fois $$HEX2$$e0002000$$ENDHEX$$la fonction uf_trace de n'appeler
//*  qu'une seule fois la fonction f_incrementer puis d'incrementer directement l'IdTrace
//*  $$HEX2$$e0002000$$ENDHEX$$partir d'une variable d'instance ilDernierNumero. A la d$$HEX1$$e900$$ENDHEX$$sactivation du mode
//*  incr$$HEX1$$e900$$ENDHEX$$mentation autonome on met $$HEX2$$e0002000$$ENDHEX$$jour le compteur pour la trace (CPT_TRACE) avec le
//*  dernier numero utilis$$HEX2$$e9002000$$ENDHEX$$contenu dans ilDernierNumero et on remet ilDernierNumero $$HEX2$$e0002000$$ENDHEX$$
//*  ZERO pour la prochaine utilisation du mode.
//*  On doit activer ce mode $$HEX2$$e0002000$$ENDHEX$$la fin de la fonction wf_PreparerValider.
//*  On doit d$$HEX1$$e900$$ENDHEX$$sactiver ce mode $$HEX2$$e0002000$$ENDHEX$$fin du wf_TerminerValider ET dans l'$$HEX1$$e900$$ENDHEX$$v$$HEX1$$e800$$ENDHEX$$nement DbError
//*  de la Datawindow DW_1 car si l'Update() sur Dw_1 plante on doit d$$HEX1$$e900$$ENDHEX$$sactiver le mode
//*  pour $$HEX1$$e900$$ENDHEX$$viter de se trouver dans une situation instable.
//*
//*
//* Arguments		: Boolean	abModeInc 	= TRUE si on est en mode incrementation autonome.
//*													= FALSE sinon.
//*
//* Retourne		: Boolean		TRUE  si OK
//*										FALSE sinon
//*					
//*
//*-----------------------------------------------------------------
//*  #1	PLJ	06/12/2001  Gestion moteur MSS
//*-----------------------------------------------------------------
Boolean		bRet					// Valeur de retour de la fonction.
String 		sCommandeSQL		// Chaine contenant la commande SQL $$HEX2$$e0002000$$ENDHEX$$ex$$HEX1$$e900$$ENDHEX$$cuter.


bRet = TRUE

If ( abModeInc ) Then

	/*------------------------------------------------------------------*/
	/* On active le mode incrementation autonome.                       */
	/*------------------------------------------------------------------*/
	ibModeIncAutonome = TRUE

Else

	/*------------------------------------------------------------------*/
	/* On d$$HEX1$$e900$$ENDHEX$$sactive le mode incrementation autonome.                    */
	/*------------------------------------------------------------------*/
	ibModeIncAutonome = FALSE

	If ilDernierNumero > 0 Then

		/*----*/
      /* #1 */
		/*---------------------------------------------------------------*/
		/* Gestion MSS : on doit repositionner la PS en minuscule        */
		/*               reste compatible avec GUPTA                     */
		/*---------------------------------------------------------------*/
		sCommandeSql	=	"EXECUTE sysadm.u_parametre_val ~'CPT_TRACE~' ," + &
								String ( ilDernierNumero )

		// [MIGPB11] [EMD] : Debut Migration : [SNC] contourne le fait que SNC ne mette pas $$HEX2$$e0002000$$ENDHEX$$jour SqlnRows
		//EXECUTE IMMEDIATE :sCommandeSql USING itrTrans ;
		f_execute( sCommandeSql, itrTrans )
		// [MIGPB11] [EMD] : Fin Migration

		If itrTrans.SQLCode <> 0 Then

			bRet = False

		End If

		ilDernierNumero    = 0

	End If

End If

Return ( bRet )
end function

on u_spb_gs_trace.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_spb_gs_trace.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

