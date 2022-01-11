#!/usr/bin/env bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
echo $ROOT_DIR
EXEC_PATH=$PWD

cd $ROOT_DIR

mkdir "$ROOT_DIR/ws"

if [[ $1 = "-n" ]]
  then
    docker build -t ur_itmo_framework --rm=true --force-rm=true -f $ROOT_DIR/docker/Dockerfile $ROOT_DIR \
                                  --network=host \
                                  --build-arg from=nvidia/opengl:1.2-glvnd-runtime-ubuntu20.04

else
    docker build -t ur_itmo_framework --rm=true --force-rm=true -f $ROOT_DIR/docker/Dockerfile $ROOT_DIR \
                                  --network=host \
                                  --build-arg from=ubuntu:20.04 
fi

cd $EXEC_PATH
