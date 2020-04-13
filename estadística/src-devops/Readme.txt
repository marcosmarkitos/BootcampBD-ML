Imagen Docker:

Para construir la imagen:
 docker build -t estadistica .
Para ejecutar el docker:
 docker run -it -p 8888:8888 -v "$PWD":/mnt estadistica 



La máquina vitual se crea ejecutando:
> vagrant up

La cual, la primera vez que se llama se descarga una imagen ubuntu y después ejecuta el script bootstrap.sh el cual instala todos los paquetes necesarios.

Si se desea generar de nuevo ese fichero basta con ejecutar de nuevo:
> vagrant provision

Para poder subir la imagen a https://app.vagrantup.com/
Es necesario primero crear el fichero .box a partir de la imagen recién generada:
> vagrant package --output estadisticaR.box

Luego desde la web o mediante linea de comandos con 'vagrant cloud publish' se publica la imagen


Adicionalmente se puede comprobar desde Jupyter que todos los paquetes se han instalado correctamente al ejecutar:
library('repr')
library('IRdisplay')
library('evaluate')
library('crayon')
library('pbdZMQ')
library('devtools')
library('uuid')
library('digest')
library('ggplot2')
library('reshape2')
library('entropy')
library('quantmod')
library('zoo')
library('MASS')


