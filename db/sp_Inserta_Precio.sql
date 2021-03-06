ALTER PROCEDURE [Ventas].[sp_Inserta_Precio] @Tipo2 INT, @Prec DECIMAL(10,2), @IdEstacion INT
AS

BEGIN 
--CONTEO
DECLARE
 @Cuantos int=0,
 @Maximo int=0

	SELECT @Cuantos = ISNULL (COUNT(*),0) from [Catalogos].[Precio] where [IdEstacion] = @IdEstacion and [Precio] = @Prec and [IdProducto] = @Tipo2;
	set @Maximo =(SELECT MAX(IdPrecio)from [Catalogos].[Precio]); 


 IF @Cuantos = 0
	BEGIN
		INSERT INTO [Catalogos].[Precio]
           ([IdEstacion]
           ,[IdPrecio]
           ,[IdProducto]
           ,[Precio]
           ,[Estatus]
           ,[FechaInicioVigencia]
           ,[FechaFinVigencia]
           ,[FechaAlta]
           ,[IdUsuarioAlta])
     VALUES
           (@IdEstacion
           ,isnull(@Maximo,0)+1
           ,@Tipo2
           ,@Prec
           ,1
           ,''
           ,''
           ,GETDATE()
           ,'THANOS');
	END -- IF
END





