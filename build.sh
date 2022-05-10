#!/bin/bash

UBUNTU_VERSIONS="1804 2004 2204"
 
for V in $UBUNTU_VERSIONS
do
  	echo "Building PJSIP library in $V, please wait..."
	docker build -t pjsip_$V -f Dockerfiles/Dockerfile_$V .
	docker create -ti --rm --name pjsip_$V pjsip_$V bash
	docker cp pjsip_$V:/pjsip ./build/$V
	docker cp pjsip_$V:/root/.local/lib ./build/$V
	docker rm -f pjsip_$V 
done
