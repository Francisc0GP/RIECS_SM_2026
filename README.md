# RIECS-SM CIJ – Pipeline de Extracción y Procesamiento

Este repositorio implementa un **pipeline integral de extracción, transformación, recodificación y consolidación** de la información de *Entrevista Inicial*, con el objetivo de generar datasets listos para análisis y consumo por sistemas downstream.

El flujo está diseñado para **minimizar la carga sobre el servidor SQL**, asegurar **reproducibilidad**, y mantener una **arquitectura basada en archivos intermedios gestionados vía FTP**.

---

## Visión general del proceso

El pipeline se compone de **n etapas principales**, ejecutadas de forma secuencial:

1. **Extract_data** – Extracción y preprocesamiento inicial  
2. **Merge_data** – Consolidación histórica  
3. **Recod_data** – Recodificación de consumo y clasificación de usuarios  
4. **EdadInicio_Recod** – Cálculo de edades de inicio por sustancia y grupo  

Cada etapa produce salidas intermedias que se almacenan en un **servidor FTP**, permitiendo trazabilidad y re‐ejecución controlada.

---

## 1. Extract_data

En esta etapa se realiza la **extracción directa desde SQL Server**:

- Ejecución de consultas SQL parametrizadas **por año**.
- Extracción de los registros de *Entrevista Inicial* correspondientes al año consultado.
- Preprocesamiento inicial:
  - Limpieza básica.
  - Transformaciones de estructura.
  - Pivot de variables cuando aplica.
- Exportación de los resultados a archivos CSV.
- Carga de los archivos generados a un **servidor FTP**.

**Ventajas del enfoque anual:**

- Reduce la carga sobre el servidor SQL.
- Permite reprocesar años específicos sin rehacer todo el histórico.
- Facilita el control de versiones de la información.

---

## 2. Merge_data

Esta etapa consolida la información histórica:

- Consulta del **histórico del sistema 3.0**.
- Identificación automática de los archivos anuales disponibles en el FTP.
- Concatenación (merge) de los resultados anuales en un **único dataset consolidado**.
- Aplicación de filtros administrativos:
  - Centro de costo.
  - Tipo de servicio.
- Exclusión de registros que no corresponden a pacientes válidos.

El resultado es un archivo histórico único de *Entrevista Inicial* listo para procesos analíticos posteriores.

---

## 3. Recod_data

En esta etapa se realiza la **recodificación analítica del consumo de sustancias**:

- Recodificación de variables de consumo.
- Identificación inicial de **consumidores legales puros**, definidos como aquellos cuyo consumo se limita exclusivamente a:
  - Alcohol
  - Tabaco
- Se permite la coexistencia de categorías auxiliares como:
  - Problemas de salud mental
  - Ninguna

  Estas categorías **no se consideran sustancias de mayor impacto**.

- El subconjunto de consumidores legales puros se **excluye del dataset principal**.
- El resto de los registros se clasifican como **consumidores ilegales**, es decir, aquellos que:
  - Presentan consumo de al menos una sustancia ilegal, o
  - No cumplen con los criterios establecidos para consumo legal puro.

Este proceso permite construir denominadores analíticos consistentes para análisis posteriores.

---

## 4. EdadInicio_Recod

En esta etapa se generan las **edades de inicio de consumo**:

- Cálculo de la edad de inicio:
  - A nivel de **sustancia**.
  - A nivel de **grupo de sustancias**.
- Consulta al servidor FTP para descargar los archivos necesarios.
- Procesamiento específico para cada sustancia/grupo.
- Generación de nuevos archivos con las variables de edad de inicio recodificadas.
- Carga de los resultados finales nuevamente al servidor FTP.

---

## Datasets derivados

A partir del pipeline completo se generan datasets especializados para su uso en sistemas y análisis:

- Lectura directa desde el FTP.
- Transformaciones adicionales según el objetivo analítico.
- Separación por tipo de información:
  - **Último mes**
  - **Alguna vez en la vida**
  - **Droga de impacto**

Estos datasets están diseñados para asegurar coherencia en los denominadores y facilitar la visualización de tendencias.

---

## Flujo resumido

1. Extracción anual desde SQL Server.
2. Almacenamiento intermedio en FTP.
3. Consolidación histórica.
4. Recodificación de consumo y clasificación de usuarios.
5. Cálculo de edades de inicio.
6. Generación de datasets finales para análisis y visualización.

---

## Notas finales

- El pipeline está pensado para ejecución modular.
- Cada etapa puede ejecutarse de forma independiente si los
