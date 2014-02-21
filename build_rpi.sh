#!/bin/bash

export PROJECT=RPi
export ARCH=arm

make > log_${PROJECT}.txt 2>&1
