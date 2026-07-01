SELECT EI.FolioId,
EIM.MotivoConsultaId
FROM THSDSistemaCIJ.adm.ECEEntrevistaInicial EI
LEFT JOIN THSDSistemaCIJ.adm.ECEEntrevistaInicialIdentificacion EII ON EI.FolioId = EII.FolioId 
LEFT JOIN THSDSistemaCIJ.adm.ECEEntrevistaInicialMotivoConsulta EIM ON EI.FolioId = EIM.FolioId
WHERE YEAR(EI.FechaRegistro) = 2026