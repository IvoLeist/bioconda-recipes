#!/bin/bash
HOME=/tmp cpanm Convert::Pheno
# HOME=/tmp cpanm --installdeps .
# export LD_LIBRARY_PATH="${PREFIX}/lib"
# export C_INCLUDE_PATH="${PREFIX}/include"

# below causes a lot of compilation errors
# export C_INCLUDE_PATH=${C_INCLUDE_PATH}:/usr/include/x86_64-linux-gnu