# Entrevista Inicial (Extract)
Este repositorio implementa un flujo de trabajo para la extracción, tratamiento y consolidación de información almacenada en un servidor SQL, con el objetivo de facilitar su análisis posterior en Python.

## Extracción de información (por año)
- La información se obtiene directamente desde el servidor mediante consultas SQL parametrizadas por año.
- Cada ejecución del script extrae los datos correspondientes a un año específico.
- Se suben los datos a un servidor FTP.
- Los resultados se exportan y almacenan en archivos intermedios (por ejemplo, CSV), lo que permite:
  - Reducir la carga directa sobre el servidor.
  - Reproducir el análisis sin necesidad de ejecutar nuevamente la consulta.

## Tratamiento de datos
- Se realiza un pivot con las variables que se duplican.
- Se eliminan Folios que no cumplan con criterios de inclucion:
  - Centro de Costo
  - Año en consulta

## Consolidación de información histórica
Dado que el proceso se realiza por año, se utiliza un script adicional para:
Identificar automáticamente los archivos correspondientes a los distintos años disponibles.
Realizar un merge / concatenación de todos los años en un único conjunto de datos.
El resultado es un dataset consolidado.

## Flujo general del proceso
1. Conexión al servidor SQL.
2. Ejecución de consultas por año.
3. Exportación de resultados.
4. Limpieza y transformación de datos.
5. Unión de todos los años en un solo dataset final.

# Tendencias 
En esta parte del repositorio se realizó un trabajo enfocado en continuar con la transformación de la información para poder mostrarla correctamente en el sistema.
Uno de los principales retos fue la generación de datasets específicos según el denominador, es decir, consumidores de drogas lícitas o consumidores de drogas ilícitas.
Adicionalmente, se separaron los archivos de acuerdo con el tipo de información que representan: Datos del último mes, Alguna vez en la vida y Droga de impacto.

## Datasets
- Se realiza una lectura directa del FTP
- Se transforman los datos necesarios
- Se crean 3 diferentes tipos de datasets
  - Droga de impacto
  - Ultimo mes
  - Alguna vez en la vida
Estos tres datasets se crean para cada uno de los denominadores
  - Sustancias legales e ilegales
  - Sustancias Ilegales
