# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

# Pick your favorite docker-stacks image
FROM jupyter/base-notebook

ADD work /home/jovyan/work
RUN pip install elasticsearch==5.5.1
RUN pip install redis

USER root

