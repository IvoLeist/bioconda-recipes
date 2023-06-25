#!/bin/bash
# HOME=/tmp cpanm --installdeps .
export LD_LIBRARY_PATH=${BUILD_PREFIX}/x86_64-conda-linux-gnu/sysroot/usr/lib64:${BUILD_PREFIX}/lib
HOME=/tmp cpanm  Convert::Pheno