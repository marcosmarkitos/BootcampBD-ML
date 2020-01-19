# Practica BDA Demo

## Idea general

Coger datos de sitios web como yelp y recomendar apartamentos de airbnb cerca.

## Nombre del Producto

Recomendador de Airbnb por Lifestyle (restaurantes guay, tiendas chulas)

### Estrategia del DAaaS

Voy a pasar un reporte mensual de los mejores 50 pisos para alquilar de airbnb en 
Madrid. Utilizar herramientas en la nube para facilitar el manejo de los datos.

### Arquitectura

Arquitectura Cloud basada en Scrapy + Google Cloud Storage + HIVE + Dataproc
  
Crawler con scrapy que lee de Yelp, me escribe los resultados en csv. Y lo ejecuto 
en un Cloud Function.
  
Insertar el dataset de airbnb en HIVE. 
  
Tanto el resultado del scrap como el dataset de airbnb los colocare en un segmento de 
Google Cloud.
  
Desde Google Storage cogere los datos para crear 2 tablas de HIVE, y realizare 
una query con un JOIN que reste las distancias entre cada airbnb y los locales 
con mejores reviews.
  
De la query obtendre el TOP de apartamentos de airbnb de menos de 100 euros la noche. 
  
El resultado de la query estara en Google Storage.
  
### Operating Model

Hay un operador que soy yo, voy a disparar el cloud function todas las mananas con 
mi Google Home (le dire: "Ok Google crawlea yelp"). Esto disparara el cloud function 
y guardara el resultado en un directorio del segmento llamado "input_yelp".

En el segmento siempre habra un directorio llamado "input_airbnb".

Seguire el standard de levantar el Cluster solamente cuando quiera regenerar el TOP.

Una vez al dia, levantare el CLUSTER a mano, enviare las tareas de:  
- crear tabla de airbnb
- crear tabla de yelp
- load data inpath de gs://XXXX:input_yelp/ into table yelp
- load data inpath de gs://XXXX:input_airbnb/ into table airbnb
- SELECT JOIN INTO DIRECTORY 'gs://output/results'

Apago el cluster y me voy a dormir.

Voy a montar una web con un link directo al Google Storage Segment Object.

### Desarrollo

- Tengo el cloud function aqui: 
- Query de HIVE
- Pantallazo final


### Diagrama

https://docs.google.com/drawings/d/1PmTkZWffrCy3KSQ_Lq8n-jrmFqr4SbsllP5WDW64QuY/edit?usp=sharing


### Crawler

https://colab.research.google.com/drive/1U5mSOVMUL1w8lxhqCteKQYy9JNwtCuoc