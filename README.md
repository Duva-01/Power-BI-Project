# Power-BI-Project

## Descripción del Proyecto

Este proyecto implementa una arquitectura de procesamiento de datos en tiempo real utilizando **PostgreSQL** como *data lake*, **Apache Kafka** como sistema de mensajería para la ingesta de datos, **Mage.ai** como herramienta ETL para la transformación de datos y **Google BigQuery** como *data warehouse*. Posteriormente, los datos se visualizan mediante **Power BI**, y los reportes se publican en **Power BI Service** para su consumo por parte de la compañía.

El objetivo es establecer un flujo de datos eficiente, escalable y en tiempo real que permita a la organización obtener información actualizada para la toma de decisiones.

---

## Arquitectura del Sistema

El sistema está compuesto por varias capas que se encargan de la ingesta, transformación, almacenamiento y visualización de los datos. A continuación, se detallan los componentes principales:

### 1. Ingesta de Datos en Tiempo Real (Apache Kafka)
Para la captura de datos en tiempo real, se utiliza **Apache Kafka**. Kafka es una plataforma de transmisión distribuida que permite la publicación y suscripción de flujos de datos de manera escalable y tolerante a fallos. En este proyecto:

- **Producer**: Un productor de datos genera eventos en tiempo real y los envía a un *topic* en Kafka.
- **Consumer**: Un consumidor de Kafka extrae los datos de los *topics* y los inserta en **PostgreSQL**, que actúa como *data lake*.

Kafka proporciona durabilidad, tolerancia a fallos y alta disponibilidad, lo que lo convierte en una solución ideal para manejar grandes volúmenes de datos en tiempo real.

### 2. Almacenamiento en PostgreSQL (Data Lake)
Una vez que los datos son consumidos desde Kafka, se almacenan en **PostgreSQL**, que en este caso actúa como un *data lake*. PostgreSQL permite gestionar datos estructurados y semiestructurados con soporte para JSON y proporciona herramientas avanzadas de indexación y optimización de consultas.

El uso de PostgreSQL como *data lake* permite:
- Almacenamiento eficiente de datos sin procesar.
- Integración con sistemas ETL para su procesamiento posterior.
- Capacidad de realizar consultas analíticas directamente sobre los datos almacenados.

### 3. Procesamiento ETL con Mage.ai
Para la transformación y carga de datos en el *data warehouse*, se utiliza **Mage.ai**, una plataforma de orquestación de flujos de datos diseñada para facilitar procesos ETL (Extract, Transform, Load). Mage.ai permite definir *pipelines* que:
- Extraen los datos de PostgreSQL.
- Transforman los datos según las reglas de negocio y normalización necesarias.
- Cargan los datos en **Google BigQuery**, que actúa como *data warehouse*.

Mage.ai se destaca por su interfaz intuitiva, su integración con múltiples fuentes de datos y su capacidad para ejecutar tareas de transformación utilizando Python, SQL y otras herramientas avanzadas.

### 4. Almacenamiento y Consulta en Google BigQuery (Data Warehouse)
Una vez que los datos son transformados, se almacenan en **Google BigQuery**, que actúa como *data warehouse* para facilitar el análisis y la generación de reportes. BigQuery es una solución de almacenamiento en la nube optimizada para consultas analíticas de grandes volúmenes de datos mediante SQL.

Beneficios de usar BigQuery:
- **Escalabilidad y rendimiento:** Permite consultas sobre grandes conjuntos de datos de manera eficiente.
- **Integración nativa con herramientas de visualización:** Conexión directa con Power BI.
- **Modelo *Serverless***: No requiere administración de infraestructura, lo que reduce costos operativos.

### 5. Visualización de Datos con Power BI
Para la interpretación y análisis de los datos, se utiliza **Power BI**, una herramienta de *business intelligence* que permite crear dashboards interactivos. Power BI se conecta directamente a BigQuery para consultar los datos y generar visualizaciones en tiempo real.

Los beneficios de esta integración incluyen:
- **Automatización del flujo de datos**: Los dashboards se actualizan automáticamente con los datos de BigQuery.
- **Análisis avanzado**: Capacidad de realizar análisis predictivo y de tendencias.
- **Compartición de reportes**: Posibilidad de publicar y compartir los reportes dentro de la organización.

### 6. Publicación en Power BI Service
Finalmente, los dashboards y reportes generados en Power BI se publican en **Power BI Service**, permitiendo que diferentes usuarios dentro de la organización accedan a la información de manera centralizada y con los permisos adecuados.

---

## Despliegue y Ejecución

El proyecto está diseñado para ejecutarse dentro de un entorno **Dockerizado**, facilitando su implementación y escalabilidad.

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/usuario/Power-BI-Project.git
   cd Power-BI-Project
   ```
2. Iniciar los contenedores:
   
  ```bash
  docker-compose up -d
  ```

3. Verificar el estado de los servicios:
   
  ```bash
  docker ps
  ```

4. Acceder a los logs de Kafka y PostgreSQL si es necesario:
  
  ```bash
  docker logs -f kafka
  docker logs -f postgresql
  ```

## Conclusión
Este proyecto representa una solución robusta y escalable para la ingesta, procesamiento y visualización de datos en tiempo real, integrando tecnologías modernas de data engineering. Con esta arquitectura, la compañía puede obtener información estratégica actualizada, mejorando la toma de decisiones y la eficiencia operativa.

Si tienes sugerencias o deseas contribuir al desarrollo del proyecto, siéntete libre de hacerlo mediante pull requests o reportando issues en este repositorio.
