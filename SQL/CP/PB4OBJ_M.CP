-------------------------------------------------------------------
--
-- Fichier      : PB4OBJ_M.CP
-- Auteur       : Nø6
-- Date         : 04/10/1997 09:37:27
--
-- Commentaires	: Liste des procedures utilisees par les objets.
--
-- Procedures   : DW_S01_CODE_CAR
--
-------------------------------------------------------------------

--------------------------------------------------------------------
--
-- Procedure    : DW_S00_CODE
-- Auteur       : NÝ6
-- Date         : 04/10/1997 09:49:17
-- Libelle      : Liste des codes pour un type de code, pour la table des codes
--                caracteres : CODE_CAR
-- Commentaires	: 
-- References   : U_LIBELLE, D_LIBELLE_MSS.
--
-- Arguments    : @sIdTypCode  Varchar ( 3 ) ( Val )
--
-- Retourne     : La selection.
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_CODE_CAR' AND type = 'P' )
 DROP procedure sysadm.DW_S01_CODE_CAR
GO

CREATE PROC DW_S01_CODE_CAR
 @sIdTypCode  Varchar ( 3 )
AS

 SELECT code_car.id_code,
        code_car.lib_code, 
        code_car.id_typ_code,
        code_car.cree_le,
        code_car.maj_le,
        code_car.maj_par
   FROM sysadm.code_car
  WHERE code_car.id_typ_code = @sIdTypCode

GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_U01_W_QUEUE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Passage de ALT_OCCUPE … OUI
-- Références           :        
--
-- Arguments            :       @dtTrvMajLe     DateTime                        (Val)
--                      :       @sTrvMajPar     Varchar (  4 )                  (Val)
--                      :       @sIdSin         Varchar (  6 )                  (Val)
--                      :       @sIdCorb        Varchar (  3 )                  (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_U01_W_QUEUE' AND type = 'P' )
        DROP procedure sysadm.IM_U01_W_QUEUE
GO

CREATE procedure sysadm.IM_U01_W_QUEUE
        @dtTrvMajLe     DateTime      ,
        @sTrvMajPar     VarChar (  4 ),
        @sIdSin         VarChar (  7 ),
        @sIdCorb        VarChar (  3 )
AS
 UPDATE sysadm.w_queue
    SET sysadm.w_queue.alt_occupe      = 'O',
        sysadm.w_queue.trv_maj_le      = @dtTrvMajLe,
        sysadm.w_queue.trv_maj_par     = @sTrvMajPar 
 WHERE  w_queue.id_sin          = @sIdSin               AND
        w_queue.id_corb         = @sIdCorb              AND
        w_queue.alt_occupe      = 'N'
GO


--------------------------------------------------------------------
--
-- Procédure            :       DW_S01_W_QUEUE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       V‚rification si le travail est toujours libre
-- Références           :        
--
-- Arguments            :       @sIdSin         Varchar (  6 )                  (Val)
--                      :       @sIdCorb        Varchar (  3 )                  (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'DW_S01_W_QUEUE' AND type = 'P' )
        DROP procedure sysadm.DW_S01_W_QUEUE
GO

CREATE procedure sysadm.DW_S01_W_QUEUE
        @sIdSin         VarChar (  7 ),
        @sIdCorb        VarChar (  3 )
AS
 SELECT w_queue.cod_etat,
        w_queue.alt_bloc,
        w_queue.trv_maj_par,
        w_queue.trv_maj_le
 FROM   sysadm.w_queue
 WHERE  w_queue.id_sin          = @sIdSin       AND
        w_queue.id_corb         = @sIdCorb
GO


--------------------------------------------------------------------
--
-- Procédure            :       IM_U02_W_QUEUE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Retour du traitement
-- Références           :        
--
-- Arguments            :       @sNom           Varchar ( 71 )                  (Val)
--                      :       @sIdCorb        Varchar (  3 )                  (Val)
--                      :       @sCodEtat       Varchar (  1 )                  (Val)
--                      :       @sCodAction     Varchar (  1 )                  (Val)
--                      :       @sAltBloc       Varchar (  1 )                  (Val)
--                      :       @sTxtMess1      Varchar (254 )                  (Val)
--                      :       @dtTrvMajLe     DateTime                        (Val)
--                      :       @sTrvMajPar     Varchar (  4 )                  (Val)
--                      :       @dtTrvRouteLe   DateTime                        (Val)
--                      :       @sTrvRoutePar   Varchar (  4 )                  (Val)
--                      :       @dtDosMajLe     DateTime                        (Val)
--                      :       @sDosMajPar     Varchar (  4 )                  (Val)
--                      :       @dtTrvEditeLe   DateTime                        (Val)
--                      :       @sTrvEditePar   Varchar (  4 )                  (Val)
--                      :       @sIdSin         Varchar (  6 )                  (Val)
--                      :       @sIdCorbAvt     Varchar (  3 )                  (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_U02_W_QUEUE' AND type = 'P' )
        DROP procedure sysadm.IM_U02_W_QUEUE
GO

CREATE procedure sysadm.IM_U02_W_QUEUE
        @sNom           Varchar ( 71 ),
        @sIdCorb        Varchar (  3 ),
        @sCodEtat       Varchar (  1 ),
        @sCodAction     Varchar (  1 ),
        @sAltBloc       Varchar (  1 ),
        @sTxtMess1      Varchar (254 ),
        @dtTrvMajLe     DateTime      ,
        @sTrvMajPar     Varchar (  4 ),
        @dtTrvRouteLe   DateTime      ,
        @sTrvRoutePar   Varchar (  4 ),
        @dtDosMajLe     DateTime      ,
        @sDosMajPar     Varchar (  4 ),
        @dtTrvEditeLe   DateTime      ,
        @sTrvEditePar   Varchar (  4 ),
        @sIdSin         Varchar (  7 ),
        @sIdCorbAvt     Varchar (  3 )
AS
 UPDATE sysadm.w_queue
    SET sysadm.w_queue.alt_occupe      = 'N'           ,
        sysadm.w_queue.nom             = @sNom         ,
        sysadm.w_queue.id_corb         = @sIdCorb      ,
        sysadm.w_queue.cod_etat        = @sCodEtat     ,
        sysadm.w_queue.cod_action      = @sCodAction   ,
        sysadm.w_queue.alt_bloc        = @sAltBloc     ,
        sysadm.w_queue.txt_mess1       = @sTxtMess1    ,
        sysadm.w_queue.trv_maj_le      = @dtTrvMajLe   ,
        sysadm.w_queue.trv_maj_par     = @sTrvMajPar   ,
        sysadm.w_queue.trv_route_le    = @dtTrvRouteLe ,
        sysadm.w_queue.trv_route_par   = @sTrvRoutePar ,
        sysadm.w_queue.dos_maj_le      = @dtDosMajLe   ,
        sysadm.w_queue.dos_maj_par     = @sDosMajPar   ,
        sysadm.w_queue.trv_edite_le    = @dtTrvEditeLe ,
        sysadm.w_queue.trv_edite_par   = @sTrvEditePar
 WHERE  w_queue.id_sin          = @sIdSin               AND
        w_queue.id_corb         = @sIdCorbAvt           AND
        w_queue.alt_occupe      = 'O'
GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_U03_W_QUEUE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       D‚blocage du dossier en ‚dition
-- Références           :        
--
-- Arguments            :       @sIdSin         Varchar (  6 )                  (Val)
--                      :       @sIdCorb        Varchar (  3 )                  (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_U03_W_QUEUE' AND type = 'P' )
        DROP procedure sysadm.IM_U03_W_QUEUE
GO

CREATE procedure sysadm.IM_U03_W_QUEUE
        @sIdSin         VarChar (  7 ),
        @sIdCorb        VarChar (  3 )
AS
 UPDATE sysadm.w_queue
    SET sysadm.w_queue.cod_etat        = '1',
        sysadm.w_queue.cod_action      = '1',
        sysadm.w_queue.trv_edite_le    = null,
        sysadm.w_queue.trv_edite_par   = null
 WHERE  w_queue.id_sin          = @sIdSin       AND
        w_queue.id_corb         = @sIdCorb      AND
        w_queue.alt_occupe      = 'N'
GO

--------------------------------------------------------------------
--
-- Procédure            :       IM_D01_W_QUEUE
-- Auteur               :       Erick John Stark
-- Date                 :       23/07/97 11:27:57
-- Libellé              :        
-- Commentaires         :       Suppression du travail
-- Références           :        
--
-- Arguments            :       @sIdSin         Varchar (  6 )                  (Val)
--                      :       @sIdCorb        Varchar (  3 )                  (Val)
--
-- Retourne             :       Rien
--
-------------------------------------------------------------------

IF EXISTS ( SELECT * FROM sysobjects WHERE name = 'IM_D01_W_QUEUE' AND type = 'P' )
        DROP procedure sysadm.IM_D01_W_QUEUE
GO

CREATE procedure sysadm.IM_D01_W_QUEUE
        @sIdSin         VarChar (  7 ),
        @sIdCorb        VarChar (  3 )
AS
 DELETE sysadm.w_queue
 WHERE  w_queue.id_sin          = @sIdSin       AND
        w_queue.id_corb         = @sIdCorb      AND
        w_queue.alt_occupe      = 'O'
GO
