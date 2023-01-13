REMARK
\
....Chargement du libellé du service.
/

Store S_SERVICE
 SELECT  SYSADM.SERVICE.LIB_SERV
 FROM    SYSADM.SERVICE 
 WHERE   SYSADM.SERVICE.COD_SERV = :1;

REMARK
\
....Chargement du type d'operateur.
/

Store S_OPER_SERVICE
 SELECT  '1',
         SYSADM.APPLICATION.LIB_APPLI
 FROM    SYSADM.APPLICATION 
 WHERE   SYSADM.APPLICATION.COD_APPLI = :3
UNION
 SELECT  '2',
         SYSADM.SERVICE.LIB_SERV
 FROM    SYSADM.SERVICE 
 WHERE   SYSADM.SERVICE.COD_SERV = :1
UNION
 SELECT  '3',
         SYSADM.CONNEXION.TYP_OPER
 FROM    SYSADM.CONNEXION 
 WHERE   SYSADM.CONNEXION.COD_OPER  = :2 AND
         SYSADM.CONNEXION.COD_APPLI = :3 
UNION
 SELECT  '4',
         SYSADM.APPLICATION.LIB_COURT_APPLI
 FROM    SYSADM.APPLICATION 
 WHERE   SYSADM.APPLICATION.COD_APPLI = :3
UNION
 SELECT  '5',
         SYSADM.APPLICATION.VERSION_APPLI
 FROM    SYSADM.APPLICATION 
 WHERE   SYSADM.APPLICATION.COD_APPLI = :3
UNION
 SELECT  '6',
         @DATETOCHAR ( SYSADM.CONNEXION.DATE_DER_CNX, 'dd/mm/yyyy hh:mi' )
 FROM    SYSADM.CONNEXION 
 WHERE   SYSADM.CONNEXION.COD_OPER  = :2 AND
         SYSADM.CONNEXION.COD_APPLI = :3
UNION
 SELECT  '7',
         @DATETOCHAR ( SYSADM.CONNEXION.DATE_DER_SOR, 'dd/mm/yyyy hh:mi' )
 FROM    SYSADM.CONNEXION 
 WHERE   SYSADM.CONNEXION.COD_OPER  = :2 AND
         SYSADM.CONNEXION.COD_APPLI = :3 ;

Store S_MOD_AUTOR
 SELECT  sysadm.autorisation.cod_mod, 
         sysadm.compoappli.lib_entree_menu, 
         sysadm.autorisation.cod_acces,
         sysadm.module.lib_mod
 FROM   sysadm.autorisation, sysadm.compoappli, module 
 WHERE ( sysadm.autorisation.cod_mod   = sysadm.compoappli.cod_mod   ) AND 
       ( sysadm.autorisation.cod_appli = sysadm.compoappli.cod_appli ) AND 
       ( sysadm.autorisation.cod_mod   = sysadm.module.cod_mod )       AND
       ( sysadm.autorisation.cod_oper  = :1 )                          AND 
       ( sysadm.autorisation.cod_appli = :2 )  ;


Store S_MENU
 SELECT SysAdm.opt_menu.cod_menu, 
        SysAdm.opt_menu.typ_menu
 FROM   SysAdm.opt_menu  
 WHERE  ( SysAdm.opt_menu.cod_mod = :1 ) and
        @mid( SysAdm.opt_menu.bin_acces, (:2-1), 1 ) = 0 ;


Store U_CONNEXION_CNX
 UPDATE SYSADM.CONNEXION 
 SET    SYSADM.CONNEXION.DATE_DER_CNX = SysDateTime
 WHERE  SYSADM.CONNEXION.COD_OPER  = :1 AND
        SYSADM.CONNEXION.COD_APPLI = :2 ;

Store U_CONNEXION_DCNX
 UPDATE SYSADM.CONNEXION 
 SET    SYSADM.CONNEXION.DATE_DER_SOR = SysDateTime
 WHERE  SYSADM.CONNEXION.COD_OPER  = :1 AND
        SYSADM.CONNEXION.COD_APPLI = :2 ;


