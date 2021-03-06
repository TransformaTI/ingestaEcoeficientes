ALTER PROCEDURE [Ventas].[sp_Ins_Tb_Turno]
	
@IdTicket varchar(100),
@Tipo varchar(100),
@NDespachador varchar(100),
@LTSTotal varchar(100),
@ImporteTotal varchar(100),
@Inicio varchar(100),
@Fin varchar(100),
@NVentas varchar(100),
@NoUsado1 varchar(100),
@NoUsado2 varchar(100),
@NoUsado3 varchar(100),
@InicioTotalizador varchar(100),
@FinalTotalizador varchar(100),
@InicioTicket varchar(100),
@FinalTicket varchar(100),
@LTSP1Cilindro varchar(100),
@ImporteP1Cilindro varchar(100),
@LTSP2Cilindro varchar(100),
@ImporteP2Cilindro varchar(100),
@LTSCilindro varchar(100),
@ImporteCilindro varchar(100),
@LTSP1Carburacion varchar(100),
@ImporteP1Carburacion varchar(100),
@LTSP2Carburacion varchar(100),
@ImporteP2Carburacion varchar(100),
@LTSCarburacion varchar(100),
@ImporteCarburacion varchar(100),
@PrecioP1 varchar(100),
@PrecioP2 varchar(100),
@Nombre varchar(100),
@IdEstacion varchar(100)



AS
BEGIN

Declare 

@fecha1 datetime ,
@fecha2 datetime,
@fecha3 datetime,
@fecha4 datetime,
@datos int,
@maxid int,
@IdBomba varchar(50),
@IdT varchar(50),
@IDTURNOM varchar(50)



set @fecha1 = Ventas.fnfechas (@Inicio);
set @fecha2 = Ventas.fnfechas (@Fin);
set @fecha3 = Ventas.fnfechas (@Inicio);
set @fecha4 = Ventas.fnfechas (@Fin);

--Obtener Idbomba
set @IdBomba=SUBSTRING(@IdTicket, 1, 4)
--Obtener idTurno
set @IdT=SUBSTRING(@IdTicket, 5, 9)

set @maxid = (SELECT max(IdTurno) as turnomax
				FROM Ventas.Turno WHERE IdBomba=@IdBomba and 
				IdTurnoMedidor like '' and IdTurnoRelacionado like '')

--set @IDTURNOM=(@maxid) +'-'+(@IdT)


set @IDTURNOM=CONCAT (@maxid,+'-'+ @IdT) 

	UPDATE [Ventas].[Turno]
   SET [IdEstacion] = @IdEstacion
      ,[IdTurnoMedidor] = @IdT
      ,[IdTurnoRelacionado] = @IDTURNOM
      ,[IdBomba] = @IdBomba
      ,[IdEmpresa] = 1
      ,[IdEstatus] = 1
      ,[FechaOperacion] = @fecha1
      ,[IdUsuario] = 1
      ,[TotMedidorInicial] = 1
      ,[TotInicialRegistro] = 1
      ,[IdTipoTurno] = 1
      ,[DifenciaTot] = 1
      ,[IdPersonal] = 1
      ,[TotMedidorFinal] = 1
      ,[Fecharegistro] =   @fecha2
      ,[TotFinalRegistro] = 1
      ,[FechaInicioTurno] =  @fecha3
      ,[FechaFinTurno] =  @fecha4
      ,[IdTurnoInterno] = 1
 WHERE IdTurno = @maxid

--generar el idturnorelacionado
--EXECUTE [Ventas].[SPIdTurnoRelacionado] @IdT, @IdBomba 

 END -- sp
