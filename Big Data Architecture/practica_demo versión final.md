# Mi recomendador de Pisos Guay

## Idea general

Es un recomendador de pisos de aibnb que toma datos de https://yelp.es y envia via 
telegram el top 10 de apartamentos en Madrid segun un dump de datos de airbnb.

### Estrategia del DAaaS

La estrategia general del DAaaS es proveer un listado de los mejores 10 apartamentos 
segun su ubicacion en Madrid. Para ello se utilizara una via facil de comunicacion 
como Telegram.

### Arquitectura

La arquitectura en términos generales está definida por componentes Cloud alojados en 
Google Cloud Platform utilizando Cloud Functions, Google Cloud Storage y HIVE bajo Dataproc.
  
La primera capa de Arquitectura es una serie de comandos definidos en Google Assistant que 
te permiten interactuar con el proyecto tanto como operador como cliente.

Los comandos del Google Assistant generan llamadas HTTPS a una cloud Function que analiza 
la petición y dependiendo de la necesidad, invoca a otros cloud functions.

Los datos de airbnb se extraen desde un proveedor de datasets. Los datos de Yelp se extraen 
via un Crawler con scrapy alojado en un cloud function. Tanto el dataset de airbnb como el 
de yelp se alojan en formato `csv` en un Segmento de Google Storage.

El cluster de Dataproc siempre tendrá la misma configuración (1 nodo maestro y 2 workers) y 
además se levantará con scripts de inicialización que crean las tablas de HIVE y precargan 
los datos, de esta manera quitamos pasos y acciones en el despliegue.
  
Se tendrán alojadas en google storage las queries necesarias para obtener las recomendaciones 
de esta manera se pueden definir `jobs` de HIVE que las ejecuten y dejen los resultados en 
un segmento de Google Storage.

El cluster de Dataproc se puede eliminar una vez calculados los resultados y la cloud function 
que envía los resultados enviará el último fichero alojado en la carpeta de resultados del segmento.
  
### Operating Model

El modelo de operaciones es bajo necesidad, esto quiere decir que los cloud functions se deben 
disparar según la necesidad del momento.

El modo de operar con el DAaaS es principalmente vía el Google Assistant, por lo que se puede 
usar desde Siri, un Google Home o cualquier dispositivo android. 

Existirá un cloud function que recibe todos los comandos de Google assistant y dependiendo 
del comando detectado, llamará a uno u otro cloud function.

El aplicativo de Google Assistant proveerá el listado de operaciones entre los que se puede 
actuar como operador (responsable de arquitectura) o cliente final:

#### Operaciones de Operador
  
- **Ejecutar extracción**: Dispara un cloud function que vía scrapy extrae datos de https://yelp.es y 
deje los resultados en un directorio llamado `input/yelp` del segmento de Google Storage utilizado 
para el cluster.
  
- **Levantar cluster**: Dispara un cloud function que vía SDK de python de google cloud levanta un 
cluster de Dataproc y le inyecta configuraciones base como crear tablas, cargar datos, etc. Dichos 
comandos se encuentran en un directorio llamado `scripts` del segmento de Google Storage utilizado 
para el cluster.
  
- **Ejecutar query de HIVE**: Dispara un cloud function que vía SDK de python de google cloud envía 
un job de HIVE con la query de cálculo de recomendación y guarda los resultados en un directorio 
llamado `/output/recommendation` del segmento de Google Storage utilizado para el cluster.
  
- **Eliminar cluster**: Dispara un cloud function que vía SDK de python de google cloud elimina el 
cluster de Dataproc activo.


#### Operaciones de cliente
  
- **Enviar Recomendación**: Dispara un cloud function que vía SDK de python de google Storage descarga 
el contenido del directorio llamado `/output/recommendation` del segmento de Google Storage utilizado 
para el cluster y envía las primeras 10 líneas del CSV formateadas para el usuario final

Como cliente también se puede enviar una solicitud a un bot de telegram para obtener la recomendación 
activa.

### Desarrollo

Vídeo en funcionamiento: (Coming soon)

- **Código de Trigger de comandos**: https://github.com/rvegas/flat_recommender/blob/master/cloud_functions/trigger.py

- **Código de Ejecutar extracción**: https://github.com/rvegas/flat_recommender/blob/master/cloud_functions/crawler.py
  
- **Código de Levantar cluster**: https://github.com/rvegas/flat_recommender/blob/master/cloud_functions/deploy_cluster.py
  
- **Código de Ejecutar query de HIVE**: https://github.com/rvegas/flat_recommender/blob/master/cloud_functions/run_query_job.py
  
- **Código de Eliminar cluster**: https://github.com/rvegas/flat_recommender/blob/master/cloud_functions/delete_cluster.py

- **Código de Enviar Recomendación**: https://github.com/rvegas/flat_recommender/blob/master/cloud_functions/send_recommendation.py

- **Código de scripts de inicialización y queries**: https://github.com/rvegas/flat_recommender/tree/master/scripts

### Diagrama

https://docs.google.com/drawings/d/1PmTkZWffrCy3KSQ_Lq8n-jrmFqr4SbsllP5WDW64QuY/edit?usp=sharing
