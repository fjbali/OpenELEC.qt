#!/bin/bash

export PROJECT=Generic
export ARCH=x86_64

if [ -z "$1" ]; then
	make > log_${PROJECT}.txt 2>&1
else
	make $1 > log_${PROJECT}.txt 2>&1
fi
