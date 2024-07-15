HA$PBExportHeader$p_pb4obj.sra
$PBExportComments$Contient la liste des Pbl ancetre
forward
global u_transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
s_GLB		stGlb

s_Message	stMessage

s_Nul		stNul

s_SPB		stSPB

u_spb_gs_trace	uoGsTrace
end variables

global type p_pb4obj from application
 string appruntimeversion = "22.2.0.3356"
end type
global p_pb4obj p_pb4obj

on p_pb4obj.create
appname = "p_pb4obj"
sqlca = create u_transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
message = create message
end on

on p_pb4obj.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

