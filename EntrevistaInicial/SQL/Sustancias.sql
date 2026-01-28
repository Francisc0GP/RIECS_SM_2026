SELECT EI.FolioId ,
EIS.SustanciaId, EIS.EdadInicio, EIS.OrdenConsumo, EIS.ComunPrevalenciaId,  EIS.ComunPrimeraFormaAdministracionId,EIS.ComunSegundaFormaAdministracionId,  EIS.ComunTerceraFormaAdministracionId,  EIS.ComunAbstinenciaId,  EIS.ComunUltimoConsumoId,  EIS.Dosis
FROM THSDSistemaCIJ.adm.ECEEntrevistaInicial EI
LEFT JOIN THSDSistemaCIJ.adm.ECEEntrevistaInicialSustancias EIS ON EI.FolioId = EIS.FolioId 
WHERE YEAR(EI.FechaRegistro) = 2025