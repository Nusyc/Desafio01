--SELECT * FROM JORNADA

TRUNCATE TABLE JORNADA
TRUNCATE TABLE JORNADA_ADICIONAL

DECLARE @TopE INT = 100000

INSERT INTO JORNADA WITH(TABLOCK)
   (ID_RESPONSAVEL,DH_INICIO_JORNADA,DH_INICIO_INTERVALO,DH_FIM_INTERVALO,DH_FIM_JORNADA,ID_USUARIO) 
SELECT TOP (@TopE)
       10 ID_RESPONSAVEL,
	   DH_INICIO_JORNADA,
       DH_INICIO_INTERVALO
	  , DH_FIM_INTERVALO,
	   DH_FIM_JORNADA,
	   1
	  -- ,DH_INICIO_INTERVALO - DH_INICIO_JORNADA
  FROM sysobjects a,
       sysobjects b,
       sysobjects c,
       sysobjects d
CROSS APPLY (VALUES(ABS(CHECKSUM(NEWID())) / 1, ABS(CHECKSUM(NEWID())) / 1)) AS Tab1(MenorValue, MaiorValue)
CROSS APPLY (SELECT DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % (Tab1.MaiorValue-Tab1.MenorValue), '20200101')) AS Tab2(DH_INICIO_JORNADA)
CROSS APPLY (SELECT DATEADD(MS, ABS(CHECKSUM(NEWID()))/1000.,DH_INICIO_JORNADA)) AS Tab3(DH_INICIO_INTERVALO)
CROSS APPLY (SELECT DATEADD(MS, ABS(CHECKSUM(NEWID()))/1000.,DH_INICIO_INTERVALO)) AS Tab4(DH_FIM_INTERVALO)
CROSS APPLY (SELECT DATEADD(MS, ABS(CHECKSUM(NEWID()))/1000.,DH_FIM_INTERVALO)) AS Tab5(DH_FIM_JORNADA)

INSERT INTO JORNADA_ADICIONAL
(ID_JORNADA, DH_INICIO_ADICIONAL, DH_FIM_ADICIONAL, ID_USUARIO, ID_STATUS)
SELECT 
	ID_JORNADA,
	DH_INICIO_ADICIONAL,
	DH_FIM_ADICIONAL,
	1 ID_USUARIO,
	1 ID_STATUS 

FROM
	JORNADA
CROSS APPLY (
				SELECT TOP (7)
				      
					  DH_INICIO_ADICIONAL,
					  DH_FIM_ADICIONAL
					  -- ,DH_INICIO_INTERVALO - DH_INICIO_JORNADA
				  FROM sysobjects a,
				       sysobjects b,
				       sysobjects c,
				       sysobjects d
				CROSS APPLY (VALUES(ABS(CHECKSUM(NEWID())) / 1, ABS(CHECKSUM(NEWID())) / 1)) AS Tab1(MenorValue, MaiorValue)
				CROSS APPLY (SELECT DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % (Tab1.MaiorValue-Tab1.MenorValue), '20200101')) AS Tab2(DH_INICIO_ADICIONAL)
				CROSS APPLY (SELECT DATEADD(MS, ABS(CHECKSUM(NEWID()))/500.,DH_INICIO_ADICIONAL)) AS Tab3(DH_FIM_ADICIONAL)		

			 ) c
--WHERE
--	ID_JORNADA = 1
UNION ALL
SELECT 
		ID_JORNADA,
	DH_INICIO_ADICIONAL,
	DH_FIM_ADICIONAL,
	1 ID_USUARIO,
	1 ID_STATUS 

FROM
	JORNADA
CROSS APPLY (
				SELECT TOP (2)
				      
					  DH_INICIO_ADICIONAL,
					  DH_FIM_ADICIONAL
					  -- ,DH_INICIO_INTERVALO - DH_INICIO_JORNADA
				  FROM sysobjects a,
				       sysobjects b,
				       sysobjects c,
				       sysobjects d
				CROSS APPLY (VALUES(ABS(CHECKSUM(NEWID())) / 1, ABS(CHECKSUM(NEWID())) / 1)) AS Tab1(MenorValue, MaiorValue)
				CROSS APPLY (SELECT DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % (Tab1.MaiorValue-Tab1.MenorValue), '20200102')) AS Tab2(DH_INICIO_ADICIONAL)
				CROSS APPLY (SELECT DATEADD(MS, ABS(CHECKSUM(NEWID()))/500.,DH_INICIO_ADICIONAL)) AS Tab3(DH_FIM_ADICIONAL)		

			 ) c
--WHERE
--	ID_JORNADA = 1

INSERT INTO JORNADA_ADICIONAL (ID_JORNADA, DH_INICIO_ADICIONAL, DH_FIM_ADICIONAL, ID_USUARIO, ID_STATUS)
SELECT TOP 1000
	ID_JORNADA,
	DATEADD(MS, ABS(CHECKSUM(NEWID()))/7000.,DH_INICIO_ADICIONAL),
	DATEADD(MS, ABS(CHECKSUM(NEWID()))/7000.,DH_FIM_ADICIONAL),
	1 ID_USUARIO,
	1 ID_STATUS 

FROM
	JORNADA_ADICIONAL
ORDER BY 1 ASC

INSERT INTO JORNADA_ADICIONAL (ID_JORNADA, DH_INICIO_ADICIONAL, DH_FIM_ADICIONAL, ID_USUARIO, ID_STATUS)
SELECT TOP 1000
	ID_JORNADA,
	DATEADD(MS, ABS(CHECKSUM(NEWID()))/7000.,DH_INICIO_ADICIONAL),
	DATEADD(MS, ABS(CHECKSUM(NEWID()))/7000.,DH_FIM_ADICIONAL),
	1 ID_USUARIO,
	1 ID_STATUS 

FROM
	JORNADA_ADICIONAL
ORDER BY 1 DESC

