ALTER PROCEDURE [Ventas].[sp_Ins_Tb_Ticket]
	
@IdTicket varchar(100),
@Tipo varchar(100),
@NCliente varchar(100),
@Precio varchar(100),
@Litros varchar(100),
@SubTotal varchar(100),
@Iva varchar(100),
@Total varchar(100),
@InicioDespacho varchar(100),
@FinalDespacho varchar(100),
@NVentaTurno varchar(100),
@InicioTurno varchar(100),
@NOperador varchar(100),
@FormaPago varchar(100),
@NoUsado varchar(100),
@Tipo2 varchar(100),
@Factor varchar(100),
@NoUsado2 varchar(100),
@NoUsado3 varchar(100),
@Cliente varchar(100),
@IdEstacion varchar(100)


AS
BEGIN

Declare 

@fecha1 datetime ,
@fecha2 datetime,
@IdTurnoMAX int,
@IdTurnoVERI int,
@IdBomba int,
@Prec VARCHAR(100),
@Lit varchar(100),
@subto varchar(100),
@iva2 varchar(100),
@tot varchar(100)


set @IdBomba = (select substring(@IdTicket, 1,4));
set @fecha1 = Ventas.fnfechas (@InicioDespacho);
set @fecha2 = Ventas.fnfechas (@FinalDespacho);

---PRECIO
SET @Prec = (SELECT SUBSTRING (@Precio,3,2));
SET @Prec = (SELECT CONCAT(@Prec,'.'));
SET @Prec =(SELECT CONCAT(@Prec,SUBSTRING (@Precio,5,6)));
SET @Prec=  (SELECT CAST(@Prec AS Decimal(10, 2)));

---LITROS
SET @Lit = (SELECT SUBSTRING (@Litros,3,2));
SET @Lit = (SELECT CONCAT(@Lit,'.'));
SET @Lit =(SELECT CONCAT(@Lit,SUBSTRING (@Litros,5,6)));
SET @Lit=  (SELECT CAST(@Lit AS Decimal(10, 2)));

---subtotal

set @subto = (SELECT SUBSTRING (@SubTotal,4,3));
SET @subto = (SELECT CONCAT(@subto,'.'));
SET @subto =(SELECT CONCAT(@subto,SUBSTRING (@SubTotal,7,8)));
SET @subto=  (SELECT CAST(@subto AS Decimal(10, 2)));

----iva

set @iva2 = (SELECT SUBSTRING (@Iva,4,3));
SET @iva2 = (SELECT CONCAT(@iva2,'.'));
SET @iva2 =(SELECT CONCAT(@iva2,SUBSTRING (@Iva,7,8)));
SET @iva2=  (SELECT CAST(@iva2 AS Decimal(10, 2)));

----Total

set @tot = (SELECT SUBSTRING (@Total,4,3));
SET @tot = (SELECT CONCAT(@tot,'.'));
SET @tot =(SELECT CONCAT(@tot,SUBSTRING (@Total,7,8)));
SET @tot=  (SELECT CAST(@tot AS Decimal(10, 2)));






select @IdTurnoVERI  = ISNULL (COUNT(*),0) from Ventas.Turno where IdBomba = @IdBomba and IdTurnoMedidor = '' and IdTurnoRelacionado = '' ;

 IF @IdTurnoVERI = 0

BEGIN

INSERT INTO [Ventas].[Turno]
           ([IdEstacion]
           ,[IdTurnoMedidor]
           ,[IdTurnoRelacionado]
           ,[IdBomba]
           ,[IdEmpresa]
           ,[IdEstatus]
           ,[FechaOperacion]
           ,[IdUsuario]
           ,[TotMedidorInicial]
           ,[TotInicialRegistro]
           ,[IdTipoTurno]
           ,[DifenciaTot]
           ,[IdPersonal]
           ,[TotMedidorFinal]
           ,[Fecharegistro]
           ,[TotFinalRegistro]
           ,[FechaInicioTurno]
           ,[FechaFinTurno]
           ,[IdTurnoInterno])
     VALUES
           (@IdEstacion
           ,''
           ,''
           ,@IdBomba
           ,1
           ,1
           ,GETDATE()
           ,''
           ,1
           ,1
           ,1
           ,1
           ,1
           ,1
           ,GETDATE()
           ,1
           ,GETDATE()
           ,GETDATE()
           ,1);

END -- if


set @IdTurnoMAX =(select max(IdTurno) from Ventas.Turno where IdBomba = @IdBomba);


INSERT INTO [Ventas].[Ticket]
           ([IdEstacion]
           ,[IdTurno]
           ,[IdFolio]
           ,[IdCliente]
           ,[Precio]
           ,[Litros]
           ,[Subtotal]
           ,[IVA]
           ,[Total]
           ,[FechaInicioDespacho]
           ,[FechaFinalDespacho]
           ,[IdVentaDelTurno]
           ,[IdFormaPago]
           ,[IdTipoVenta]
           ,[IdCondicionPago]
           ,[Factor]
           ,[NombreCliente])
     VALUES
           (@IdEstacion
           ,@IdTurnoMAX
           ,@IdTicket
           ,@NCliente
           ,@Prec
           ,@Lit
           ,@subto
           ,@iva2
           ,@tot
           ,@fecha1
           ,@fecha2
           ,@NVentaTurno
           ,@FormaPago
           ,@Tipo2
           ,0
           ,@Factor
           ,@Cliente)

EXECUTE [Ventas].[sp_Inserta_Precio] @Tipo2, @Prec, @IdEstacion

END 





