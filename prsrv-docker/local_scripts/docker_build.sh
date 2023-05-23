#!/bin/bash
source ../container-name.sh

if [ $# -lt 1 ];
then
    echo "+ $0: Too few arguments!"
    echo "+ use something like:"
    echo "+ $0 <CONTAINER_NAME>"
    echo "+ $0 ${CONTAINER_NAME}"
    exit
fi

pushd ../../
set -x
#docker build --no-cache --rm=true -t reslocal/${CONTAINER_NAME} .
#docker build --rm=true -t reslocal/${CONTAINER_NAME} .
docker build -f contrib/prserv/Dockerfile --rm=true -t reslocal/${CONTAINER_NAME} .
set +x
popd
