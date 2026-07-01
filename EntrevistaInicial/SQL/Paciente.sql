SELECT EI.FolioId , EI.CentroCostoId, EI.TipoServicioId, EI.TipoPacienteId, EI.FechaRegistro,
DATEDIFF(YEAR, EII.FechaNacimiento, EI.FechaRegistro) - 
            CASE 
                WHEN MONTH(EII.FechaNacimiento) > MONTH(EI.FechaRegistro) 
                    OR (MONTH(EII.FechaNacimiento) = MONTH(EI.FechaRegistro) AND DAY(EII.FechaNacimiento) > DAY(EI.FechaRegistro))
                THEN 1 
                ELSE 0 
            END AS Edad,
            EIP.SexoId, EIP.PerteneceComunidadLGBTTTI, EIP.ComunComunidadLGBTTTIId,  EIP.PerteneceComunidadIndigena, EIP.ComunidadIndigena, EIP.HablaLenguaIndigena, EIP.PoblacionAfromexicanaAfroamericana, EIP.DiscapacidadPerceptual, EIP.DiscapacidadPerceptualDescripcion, EIP.LugarNacimientoId, EIP.ComunEstadoCivilId, EIP.ComunEscolaridadId, EIP.ComunOcupacionId, EIP.ComunEstratoSocialId,EIP.Migracion,EIP.VividoEstadosUnidos, EIP.ActividadLaboral, EIP.ComunDiscapacidadPerceptualId, EIP.PaisId, EIP.UltimosDoceMesesPaisId, EIP.EstadoEUAId,
            EISP.MayorImpactoSustanciaId, EISP.PreferidaSustanciaId, EISP.MultipleUsoMismoDia, EISP.ComunFrecuenciaAlcoholId, EISP.ComunFrecuenciaDrogasId, EISP.ComunTipoUsoDrogaIlicitaId,EISP.ProblemasSalud, EISP.ProblemasFamiliares, EISP.AccidentesAsociados, EISP.ProblemasEscolares, EISP.ProblemasLaborales, EISP.ProblemasPsicologicos, EISP.ProblemasLegales, EISP.ConductaAntisocial, EISP.ProblemasOtros
FROM THSDSistemaCIJ.adm.ECEEntrevistaInicial EI
LEFT JOIN THSDSistemaCIJ.adm.ECEEntrevistaInicialIdentificacion EII ON EI.FolioId = EII.FolioId 
LEFT JOIN THSDSistemaCIJ.adm.ECEEntrevistaInicialPaciente EIP ON EI.FolioId = EIP.FolioId 
LEFT JOIN THSDSistemaCIJ.adm.ECEEntrevistaInicialSustanciasPatron EISP ON EI.FolioId = EISP.FolioId 
WHERE YEAR(EI.FechaRegistro) = 2026