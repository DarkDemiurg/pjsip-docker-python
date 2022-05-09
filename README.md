# pjsip-docker-python

Dockerfile for building pjsip python binding

This Dockerfile currently builds Ubuntu 18.04 release with pjsip pre-compiled.

## usage

To build this image, just clone this repo and build using docker:

    git clone https://github.com/DarkDemiurg/pjsip-docker-python.git
    cd pjsip-docker-python
    docker build -t pjsip .

To get build artifacts:

    docker run --it pjsip
    docker ps
    docker cp <CONTAINER ID>:/pjsip ./build/1804

## license

[MIT](https://github.com/DarkDemiurg/pjsip-docker-python/blob/master/LICENSE)

