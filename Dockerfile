# This Dockerfile build the prerequisites of any xeus based kernel

# See: https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html

FROM debian:stable-slim

RUN apt-get update && \
    apt-get --yes install python-is-python3 python3-pip git

RUN python3 -m pip install --no-cache-dir notebook jupyterlab==3.6.4 jupyterlab-git
RUN pip install -U "jupyter-server<2.0.0"

ARG NB_USER=joylol
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default JoyLoL user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
WORKDIR ${HOME}

