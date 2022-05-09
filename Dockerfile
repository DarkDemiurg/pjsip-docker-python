# -*- Dockerfile -*-

FROM ubuntu:18.04

LABEL org.opencontainers.image.authors="daefimov@gmail.com"
LABEL version="0.1"
LABEL description="Container for build python 3 support for PJSIP."

ENV PJSIP_VERSION=2.12

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
            build-essential \
            ca-certificates \
            curl \
            libgsm1-dev \
            libspeex-dev \
            libspeexdsp-dev \
            libsrtp0-dev \
            libssl-dev \
            portaudio19-dev \
            wget \
            python3.8 \
            python3.8-dev \
            python3.8-distutils \
            python3.8-venv \
            swig \
            default-jdk \
            && \
            update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 && \
            apt-get purge -y --auto-remove && rm -rf /var/lib/apt/lists/*

COPY config_site.h /tmp/

RUN mkdir /usr/src/pjsip && \
    cd /usr/src/pjsip && \    
    wget -c https://github.com/pjsip/pjproject/archive/refs/tags/${PJSIP_VERSION}.tar.gz  -O - | \
    tar --strip-components 1 -xz && \
    mv /tmp/config_site.h pjlib/include/pj/ && \
    CFLAGS="-O2 -DNDEBUG" \
    ./configure --enable-shared \
                --disable-video \
                --prefix=/pjsip \
                && \
    make dep -j$(nproc) && \
    make -j$(nproc) && \
    make install && \
    cd pjsip-apps/src/swig && \
    make && \
    make install && \
    /sbin/ldconfig && \
    rm -rf /usr/src/pjsip

ENTRYPOINT ["/bin/bash", ]
