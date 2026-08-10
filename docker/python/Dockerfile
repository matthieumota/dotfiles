ARG PYTHON_VERSION=3.13
FROM python:${PYTHON_VERSION}-slim

ARG UNAME=matthieu
ARG UID=1000
ARG GID=1000
ARG EMAIL=matthieumota@gmail.com
ARG NAME=Matthieu Mota
ARG CODE_PATH=/home/${UNAME}/Code

ENV PATH "$PATH:/home/${UNAME}/.local/bin"

RUN apt-get update \
    && apt-get install -y curl git zip \
    && groupadd -g ${GID} ${UNAME} \
    && useradd -u ${UID} -g ${GID} -m ${UNAME} \
    && chown ${UNAME}:${UNAME} /home/${UNAME} \
    && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER ${UNAME}

RUN git config --global user.email "${EMAIL}" \
    && git config --global user.name "${NAME}" \
    && pip install --user --no-cache-dir django gunicorn uvicorn

WORKDIR ${CODE_PATH}
