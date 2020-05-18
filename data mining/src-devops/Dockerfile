# Para construir la imagen:
# docker build -t estadistica .
# Para ejecutar el docker:
# docker run -it -p 8888:8888 -v "$PWD":/mnt estadistica 

#FROM resin/raspberrypi3-debian:latest
FROM r-base:3.6.0 

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

#RUN echo "deb http://mirrordirector.raspbian.org/raspbian/ buster main" > /etc/apt/sources.list


# runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        python \
        python-pip \
        curl \
#        r-base r-base-core r-base-dev \
        libssl-dev \
        libcurl4-openssl-dev \
        python-dev \       
        python-setuptools \ 
        && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install jupyter

RUN R -e "install.packages(c('repr','IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest','ggplot2','reshape2','entropy','quantmod'), repos='https://cran.rstudio.com/')"
RUN R -e "install.packages(c('caret','curl','dbsca','dplyr','dslabs','e1071','egg','euralet','GGally','ggdedro','ggpubr','glmet','jpeg','MASS','microbechmark','plotrix','plyr','pracma','reshape2','ROCR','tm','zoo','glmnetUtils'),repos='https://cran.rstudio.com/')"
RUN apt-get update && apt-get install -y --no-install-recommends libxml2-dev
RUN R -e "install.packages(c('tidyverse','dendextend','gplots','dbscan','neuralnet','ggdendro','microbenchmark'),repos='https://cran.rstudio.com/')"
RUN R -e "install.packages('IRkernel')"
RUN R -e "IRkernel::installspec(user = FALSE)"


CMD /usr/local/bin/jupyter notebook --allow-root --notebook-dir=/mnt --ip=0.0.0.0 --NotebookApp.token=
