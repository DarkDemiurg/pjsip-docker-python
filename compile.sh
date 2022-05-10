#!/bin/bash
mkdir /usr/src/pjsip && \
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
make python && \
make install && \
/sbin/ldconfig && \
rm -rf /usr/src/pjsip
