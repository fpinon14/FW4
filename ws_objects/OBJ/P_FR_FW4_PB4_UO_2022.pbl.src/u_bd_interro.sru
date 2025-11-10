HA$PBExportHeader$u_bd_interro.sru
$PBExportComments$------} UserObjet pour la fen$$HEX1$$ea00$$ENDHEX$$tre d'interro
forward
global type u_bd_interro from UserObject
end type
type pb_3 from u_pbvalider within u_bd_interro
end type
type pb_2 from u_pbretour within u_bd_interro
end type
type pb_1 from u_pbeffacer within u_bd_interro
end type
end forward

global type u_bd_interro from UserObject
int Width=910
int Height=201
boolean Border=true
event ue_valider pbm_custom75
event ue_retour pbm_custom74
event ue_effacer pbm_custom73
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
end type
global u_bd_interro u_bd_interro

type variables
Long ilBouton
end variables

on ue_valider;// Appui sur le bouton valider

ilBouton = 1
Parent.TriggerEvent( "UE_ENVOI" )
end on

on ue_retour;// Appui sur le bouton retour

ilBouton = 2
Parent.TriggerEvent( "UE_ENVOI" )
end on

on ue_effacer;// Appui sur le bouton effacer

ilBouton = 3
Parent.TriggerEvent( "UE_ENVOI" )
end on

on u_bd_interro.create
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.Control[]={ this.pb_3,&
this.pb_2,&
this.pb_1}
end on

on u_bd_interro.destroy
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
end on

type pb_3 from u_pbvalider within u_bd_interro
int X=311
int Y=17
int TabOrder=20
boolean Default=true
end type

type pb_2 from u_pbretour within u_bd_interro
int X=19
int Y=17
int TabOrder=10
boolean Cancel=true
end type

type pb_1 from u_pbeffacer within u_bd_interro
int X=604
int Y=17
int TabOrder=30
end type

