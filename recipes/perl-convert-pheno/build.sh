#!/bin/bash
# HOME=/tmp cpanm Convert::Pheno
# HOME=/tmp cpanm --installdeps .
# export LD_LIBRARY_PATH="${PREFIX}/lib"
# export C_INCLUDE_PATH="${PREFIX}/include"

# below causes a lot of compilation errors
# export C_INCLUDE_PATH=${C_INCLUDE_PATH}:/usr/include/x86_64-linux-gnu
# HOME=/tmp cpanm PerlIO::gzip

perl Makefile.PL INSTALLDIRS=site

# perl Makefile.PL INSTALLDIRS=site \
#     INC="-I${PREFIX}/include" LIBS="-L${PREFIX}/lib -lz"
make
make test
make install