SELECT EI.FolioId, EISC.SustanciaId AS EISC_SustanciaId
FROM THSDSistemaCIJ.adm.ECEEntrevistaInicial EI
LEFT JOIN THSDSistemaCIJ.adm.ECEEntrevistaInicialSustanciasCombinadas EISC ON EI.FolioId = EISC.FolioId
WHERE YEAR(EI.FechaRegistro) = 2026