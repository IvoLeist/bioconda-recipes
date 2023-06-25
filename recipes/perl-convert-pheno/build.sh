#!/bin/bash
# HOME=/tmp cpanm --installdeps .
export LD_LIBRARY_PATH="${PREFIX}/lib"
# export C_INCLUDE_PATH="${PREFIX}/include"
find "${PREFIX}/include" -name "timesize.h"
# export C_INCLUDE_PATH=${C_INCLUDE_PATH}:"${PREFIX}/include"
export C_INCLUDE_PATH=${C_INCLUDE_PATH}:/usr/include/x86_64-linux-gnu
# HOME=/tmp cpanm PerlIO::gzip
HOME=/tmp cpanm Convert::Pheno

# perl Makefile.PL INSTALLDIRS=site \
#     INC="-I${PREFIX}/include" LIBS="-L${PREFIX}/lib -lz"
# make
# make test
# make install