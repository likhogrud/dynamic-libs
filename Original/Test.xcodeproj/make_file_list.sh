#!/bin/bash

set +x

ARCHS="armv7 armv64"
ARCHS_LIST=($ARCHS)

echo $ARCHS

for ARCH in $ARCHS
do
	echo $ARCH
done

echo ${#ARCHS_LIST[@]} 

for ARCH in ${ARCHS[@]}
do
	echo $ARCH
done

