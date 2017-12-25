#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "usage: build.sh <qemu arch> <image tag> <dockerhub user>" >&2
    exit 1
fi

QEMU_ARCH=$1
PULL_TAG=$2
DOCKERHUB_USER=$3

PUSH_TAG=${DOCKERHUB_USER}/${PULL_TAG##*/}
if [ "${PULL_TAG%%/*}" != "${PULL_TAG}" ]; then
    PUSH_TAG=${PUSH_TAG}-${PULL_TAG%%/*}
fi

ARCHIVE=x86_64_qemu-${QEMU_ARCH}-static.tar.gz
if [ ! -f download/qemu-${QEMU_ARCH}-static ]; then
    wget -P download https://github.com/multiarch/qemu-user-static/releases/download/v2.9.1-1/${ARCHIVE}
    tar xf download/$ARCHIVE -C download
fi

docker build -t $PUSH_TAG --build-arg PULL_TAG=$PULL_TAG --build-arg QEMU_ARCH=$QEMU_ARCH .
