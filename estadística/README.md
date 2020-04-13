# Estadistica 

Esta asignatura la veremos con R y notebooks jupyter. Todo el entorno está montado en un docker publicado en docker-hub:
https://hub.docker.com/r/calabozo/estadistica

Para arrancar en docker simplemente teneis que ejecutar desde el directorio de la práctica:

Si estais en Linux, Mac o Windows con Powershell: 

`$  docker run --rm -it -p 8888:8888 -v ${PWD}:/mnt calabozo/estadistica `

Si estais en Windows y no os funciona probad: 

  `$  docker run --rm -it -p 8888:8888 -v /c/miruta_del_curso:/mnt calabozo/estadistica `

   Suponiendo que teneis el curso en C:\miruta_del_curso. La ruta tiene que estar en minúsucla y no ha de tener espacios. Si en lugar de usar la unidad C: usais otra debeis reemplazar el /c por la unidad correpondiente.

   Los usuarios de Windows además tendrán que dar permisos de compartición a la unidad de disco desde la cual van a ejecutarlo, en el menú "Settings > Shared Drives" 
Si en windows teneis problemas con la virtualización os teneis que asegurar que Hiper-V está activado, con el comando "systeminfo" podeis averiguarlo.
Para activar Hipyer-V es posible que tengais que ejecutar: "bcdedit /set hypervisorlaunchtype auto"



Comprobad que todo funciona intentando entrar en vuestro navegador en http://localhost:8888/


Si carga juypter notebook significa que todo ha ido bien.

## Si el Docker falla:

Existen alternativas más dolorosas

### Instalar R y jupyter en tu máquina 

Se puede instalar el entorno de R y jupyter notebook con el entorno Conda. Instrucciones aquí:
 https://docs.anaconda.com/anaconda/navigator/tutorials/r-lang/

Una vez instalado R debeis instalar los siguientes paquetes de R:

install.packages(c('repr','IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest','ggplot2','reshape2','entropy','quantmod'), repos='https://cran.rstudio.com/')
install.packages(c('caret','curl','dbsca','dplyr','dslabs','e1071','egg','euralet','GGally','ggdedro','ggpubr','glmet','jpeg','MASS','microbechmark','plotrix','plyr','pracma','reshape2','ROCR','tm','zoo','glmnetUtils'),repos='https://cran.rstudio.com/')



### Vagrant

#### Software necesario:

Vagrant: https://www.vagrantup.com/downloads.html
Virtualbox: https://www.virtualbox.org/wiki/Downloads (Es necesaria una versión 6.0)
Si usais linux mejor utilizad el repositorio oficial

#### Configuración

Vagrant es una herramienta de configuración de entornos virtualizados. En el fichero Vagranfile tenéis la configuración de vuestra máquina virtual, que parte de una máquina virtual que he subido a Vagrant cloud.
Para levantar una máquina virtual, hay que ejecutar, por línea de comandos, y en el mismo directorio que se encuentra el Vagrantfile:
`vagrant up`
Esto levantará la máquina virtual de VirtualBox correspondiente, ni es la primera vez que lo ejecutais lo que hará es descargarla. \
Para cerrar la máquina virtual simplemente ejecutad:
`vagrant suspend`

Si alguna vez se os queda pillada la máquina ejecutad, para pararla del todo:
`vagrant halt`
y a continuación
`vagrant up`

AVISO: No arranqueis la máquina virtual desde la interfaz de VirtualBox, puede romper la configuración.

Al final del curso, cuando querais borrar la máquina virtual, ejecutad:
'vagrant destroy'
No borreis la máquina virtual desde VirtualBox, dejaría el sistema corrupto.

Una vez ejecutado este comando el jupyter ya no será accesible. Para volver a arrancarlo necesitaríais ejecutar de nuevo `vagrant up`.
No recomiendo que reiniciéis vuestra máquina sin antes haber parado la máquina virtual, podría corromperse.

Si utilizais windows 7 es posible que Vagrant os de un error. Según parece el fallo viene porque Windows 7 por defecto trae PowerShell2 y Vagrant necesita PowerShell v3 mínimo. Sigue las instrucciones de este enlace para actualizar PowerShell: http://mikefrobbins.com/2015/01/08/how-to-check-the-powershell-version-and-install-a-new-version


Comprobad que todo funciona intentando entrar en http://localhost:8888/ desde vuestra máquina host (no desde la máquina virtual, la máquina vitual solo tiene un ubuntu con jupyter)
Si carga juypter notebook significa que todo ha ido bien.

### Google cloud

Una vez que esté instalado R y jupyter siguiendo las instrucciones de:
https://medium.com/@sthanurk/using-jupyter-notebook-in-google-cloud-platform-gcp-6ef830cb9eba

Dentro de la máquina virtual con git clone, tal y como indican las instrucciones del enlace anterior, podeis clonar el repositorio del curso.

Una vez instalado jupyter y R, desde dentro de R, instalar los paquetes necesarios con:
install.packages(c('repr','IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest','ggplot2','reshape2','entropy','quantmod'), repos='https://cran.rstudio.com/')
install.packages(c('caret','curl','dbsca','dplyr','dslabs','e1071','egg','euralet','GGally','ggdedro','ggpubr','glmet','jpeg','MASS','microbechmark','plotrix','plyr','pracma','reshape2','ROCR','tm','zoo','glmnetUtils'),repos='https://cran.rstudio.com/')


### Google Colab

Los notebooks también se pueden ejecutar en R en google colab mediante el siguiente enlace:
https://colab.research.google.com/notebook#create=true&language=r

Luego tendrás que subir el notebook junto con los datasets, además de instalar los paquetes necesarios

