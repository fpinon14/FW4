REMARK 
\
==================================
COMMANDES RELATIVES A LA FONCTION f_INCREMENTER
==================================
/

Store U_PARAMETRE_NUM
 UPDATE SYSADM.PARAMETRE
 SET    NUM_MAJ = - NUM_MAJ
 WHERE  REF_CPT = :1;

Store U_PARAMETRE_VAL
 UPDATE SYSADM.PARAMETRE
 SET    CPT_VAL = :2
 WHERE  REF_CPT = :1;

Store S_PARAMETRE
 SELECT CPT_VAL
 FROM   SYSADM.PARAMETRE
 WHERE  REF_CPT = :1 ;
   
REMARK 
\
==================================
. COMMANDES RELATIVES A LA DATAWINDOW D_LIBELLE DE l'OBJET U_LIBELLE
. SELECT SUR LA TABLE CODE.
==================================
/
STORE D_CODE_S4
 SELECT code.id_code,
        code.lib_code, 
        code.id_typ_code,
        code.cree_le,
        code.maj_le,
        code.maj_par
   FROM sysadm.code
  WHERE code.id_typ_code = :1 ;


REMARK
\
==================================
Commandes pour Acceuil sur W_QUEUE
==================================
/
REMARK
\
.... W_QUEUE : Passage de Alt_Occupe = O
/
STORE W_AS_QUEUE_U1
UPDATE  sysadm.w_queue
   SET  sysadm.w_queue.alt_occupe       = 'O',
        sysadm.w_queue.trv_maj_le       = :1,
        sysadm.w_queue.trv_maj_par      = :2
 WHERE  sysadm.w_queue.id_sin           = :3 
 AND    sysadm.w_queue.id_corb          = :4 
 AND    sysadm.w_queue.alt_occupe       = 'N'      ;


REMARK
\
.... W_QUEUE : S‚lection si le travail est toujours libre
/
STORE W_AS_QUEUE_S1
SELECT  sysadm.w_queue.cod_etat,
        sysadm.w_queue.alt_bloc,
        sysadm.w_queue.trv_maj_par,
        sysadm.w_queue.trv_maj_le
 FROM   sysadm.w_queue        
 WHERE  sysadm.w_queue.id_sin           = :1
 AND    sysadm.w_queue.id_corb          = :2      ;


REMARK
\
.... W_QUEUE : Retour du traitement
/
STORE W_AS_QUEUE_U2
UPDATE  sysadm.w_queue
   SET  sysadm.w_queue.alt_occupe       = 'N',
        sysadm.w_queue.nom              = :1,	
        sysadm.w_queue.id_corb          = :2,
        sysadm.w_queue.cod_etat         = :3,
        sysadm.w_queue.cod_action       = :4,
        sysadm.w_queue.alt_bloc         = :5,
        sysadm.w_queue.txt_mess1        = :6,
        sysadm.w_queue.trv_maj_le       = :7,
        sysadm.w_queue.trv_maj_par      = :8,
        sysadm.w_queue.trv_route_le     = :9,
        sysadm.w_queue.trv_route_par    = :10,
        sysadm.w_queue.dos_maj_le       = :11,
        sysadm.w_queue.dos_maj_par      = :12,
        sysadm.w_queue.trv_edite_le     = :13,
        sysadm.w_queue.trv_edite_par    = :14  
 WHERE  sysadm.w_queue.id_sin           = :15
 AND    sysadm.w_queue.id_corb          = :16
 AND    sysadm.w_queue.alt_occupe       = 'O'      ;


REMARK
\
.... W_QUEUE : D‚blocage du dossier en ‚dition
/
STORE W_AS_QUEUE_U3
UPDATE  sysadm.w_queue
   SET  sysadm.w_queue.cod_etat         = '1',
        sysadm.w_queue.cod_action       = '1',
        sysadm.w_queue.trv_edite_le     = NULL,
        sysadm.w_queue.trv_edite_par    = NULL  
 WHERE  sysadm.w_queue.id_sin           = :1
 AND    sysadm.w_queue.id_corb          = :2
 AND    sysadm.w_queue.alt_occupe       = 'N'      ;

REMARK
\
.... W_QUEUE : Suppression du traitement
/
STORE W_AS_QUEUE_D
DELETE  FROM    sysadm.w_queue
WHERE           sysadm.w_queue.id_sin           = :1
AND             sysadm.w_queue.id_corb          = :2
AND             sysadm.w_queue.alt_occupe       = 'O'           ;


REMARK
\
==================================
Commandes pour Op‚rateurs/Corbeilles
==================================
/
REMARK
\
.... R‚cup‚ration des op‚rateurs pour une application
/
STORE W_AS_CORB_OPER
SELECT  DISTINCT        sysadm.autorisation.cod_oper,
                        sysadm.operateur.nom,
                        sysadm.operateur.prenom
FROM    sysadm.autorisation,
        sysadm.operateur
WHERE   sysadm.operateur.cod_oper = sysadm.autorisation.cod_oper
AND     sysadm.autorisation.cod_appli = :1              ;


