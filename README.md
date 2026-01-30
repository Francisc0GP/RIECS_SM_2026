# RIECS-SM CIJ – Pipeline de Extracción y Procesamiento 

Este repositorio implementa un **pipeline integral de extracción, transformación, recodificación, generación de datasets y optimización de archivos** a partir de la información de *Entrevista Inicial*. El objetivo es producir datasets analíticos y archivos optimizados listos para su consumo por sistemas downstream y procesos de visualización.

El flujo está diseñado para:

* **Minimizar la carga** sobre el servidor SQL.
* Garantizar **reproducibilidad y trazabilidad**.
* Mantener una arquitectura basada en **archivos intermedios gestionados vía FTP**.

---

## Visión general del proceso

El pipeline se compone de **diez etapas principales**, ejecutadas de forma secuencial:

1. **Extract_data** – Extracción y preprocesamiento inicial
2. **Merge_data** – Consolidación histórica
3. **Recod_data** – Recodificación de consumo y clasificación de usuarios
4. **EdadInicio_Recod** – Cálculo de edades de inicio
5. **DataSet** – Generación de datasets por denominador
6. **FinalSets** – Ajuste final y alineación al sistema 3.0
7. **Sankey** – Construcción de base de datos para diagramas Sankey
8. **Optimizacion_GPOS** – Optimización de archivos de Grupos
9. **Optimizacion_SUST** – Optimización de archivos de Sustancias
10. **Optimizacion_MOT** – Optimización de archivos de Motivos

Cada etapa genera salidas intermedias que se almacenan en un **servidor FTP**, permitiendo control de versiones y re‐ejecución modular del proceso.

---

## 1. Extract_data

En esta etapa se realiza la **extracción directa desde SQL Server**:

* Ejecución de consultas SQL parametrizadas **por año**.
* Extracción de los registros de *Entrevista Inicial* correspondientes al año consultado.
* Preprocesamiento inicial:

  * Limpieza básica.
  * Transformaciones de estructura.
  * Pivot de variables cuando aplica.
* Exportación de resultados a archivos CSV.
* Carga de los archivos generados a un **servidor FTP**.

**Ventajas del enfoque anual:**

* Reduce la carga sobre el servidor SQL.
* Permite reprocesar años específicos.
* Facilita el control histórico de la información.

---

## 2. Merge_data

Esta etapa consolida la información histórica:

* Consulta del **histórico del sistema 3.0**.
* Identificación automática de los archivos anuales disponibles en el FTP.
* Concatenación de los resultados en un **único dataset consolidado**.
* Aplicación de filtros administrativos:

  * Centro de costo.
  * Tipo de servicio.

El resultado es un archivo histórico único de *Entrevista Inicial*.

---

## 3. Recod_data

En esta etapa se realiza la **recodificación analítica del consumo de sustancias**:

* Recodificación de variables de consumo.

* Identificación de **consumidores legales puros**, definidos como aquellos cuyo consumo se limita exclusivamente a:

  * Alcohol
  * Tabaco

  Se permite la coexistencia de categorías auxiliares como *Problemas de salud mental* y *Ninguna*, las cuales no se consideran sustancias de mayor impacto.

* Exclusión del subconjunto de consumidores legales puros.

* Clasificación del resto de los registros como **consumidores ilegales**.

Este proceso permite construir denominadores analíticos consistentes.

---

## 4. EdadInicio_Recod

En esta etapa se generan las **edades de inicio de consumo**:

* Cálculo de la edad de inicio:

  * A nivel de **sustancia**.
  * A nivel de **grupo de sustancias**.
* Descarga de insumos desde el FTP.
* Procesamiento específico por sustancia/grupo.
* Exportación y carga de resultados al FTP.

---

## 5. DataSet

En este script se procesa la información para generar los **denominadores analíticos**:

* **Droga de impacto**
* **Alguna vez en la vida**
* **Consumo en el último mes**

Los datos se obtienen desde el FTP, se transforman según el denominador correspondiente y se cargan nuevamente al FTP para su uso posterior.

---

## 6. FinalSets

En esta etapa se realiza el **ajuste final de los datasets**:

* Renombrado de archivos.
* Aplicación de filtros temporales para alinear la información al **sistema 3.0**.
* Conservación únicamente de registros **generados a partir del año 2020 en adelante**.

Los archivos finales se exportan y se cargan nuevamente al FTP.

---

## 7. Sankey

En este script se construye la **base de datos necesaria para la generación de diagramas Sankey**:

* Lectura de archivos desde el FTP.
* Uso de la variable **edad de inicio** para determinar el **orden de consumo de sustancias por usuario**.
* Generación de la estructura requerida para visualización.
* Carga de los archivos resultantes al FTP.

---

## 8. Optimizacion_GPOS

Optimización de los **archivos de Grupos**:

* Reducción de los datos al **mínimo espacio de almacenamiento necesario**.
* Eliminación de folios **anteriores al año 2004**.
* Carga de los archivos optimizados al FTP.

---

## 9. Optimizacion_SUST

Optimización de los **archivos de Sustancias**:

* Reducción del tamaño de los datos.
* Eliminación de folios **anteriores al año 2004**.
* Exportación y carga de archivos optimizados al FTP.

---

## 10. Optimizacion_MOT

Optimización de los **archivos de Motivos**:

* Reducción del tamaño de los datos.
* Eliminación de folios **anteriores al año 2004**.
* Carga de los archivos optimizados al FTP.

---

## Ejecución del pipeline (main.py)

El archivo main.py funciona como orquestador del pipeline completo, permitiendo ejecutar de forma secuencial y automatizada todos los notebooks que conforman el proceso.
Este script:
Define el orden de ejecución de los notebooks.
Verifica que el entorno cuente con las dependencias necesarias (jupyter y nbconvert).
Ejecuta cada notebook de manera controlada utilizando nbconvert.
Detiene el proceso si algún notebook presenta errores, facilitando su diagnóstico.

## Flujo resumido

1. Extracción anual desde SQL Server.
2. Consolidación histórica.
3. Recodificación de consumo.
4. Cálculo de edades de inicio.
5. Generación de denominadores.
6. Ajuste final al sistema 3.0.
7. Construcción de datasets para Sankey.
8. Optimización de archivos de Grupos, Sustancias y Motivos.
9. Almacenamiento final en FTP.

---

## Notas finales

* El pipeline está diseñado para ejecución **modular**.
* Cada etapa puede ejecutarse de forma independiente si los insumos ya existen en el FTP.
* El diseño prioriza **reproducibilidad, trazabilidad y eficiencia en almacenamiento**.
