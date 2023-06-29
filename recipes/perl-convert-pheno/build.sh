#!/bin/bash
# HOME=/tmp cpanm Convert::Pheno
# HOME=/tmp cpanm --installdeps .
# export LD_LIBRARY_PATH="${PREFIX}/lib"
# export C_INCLUDE_PATH="${PREFIX}/include"

# below causes a lot of compilation errors
# export C_INCLUDE_PATH=${C_INCLUDE_PATH}:/usr/include/x86_64-linux-gnu
# HOME=/tmp cpanm PerlIO::gzip

# install dependencies not found in conda channels
HOME /tmp cpanm File::ShareDir::ProjectDistDir
HOME /tmp cpanm JSON::Validator
HOME /tmp cpanm Moo
HOME /tmp cpanm Path::Tiny
HOME /tmp cpanm Test::Deep
HOME /tmp cpanm Test::Warn
HOME /tmp cpanm Text::CSV_XS
HOME /tmp cpanm Text::Similarity
HOME /tmp cpanm Types::Standard
HOME /tmp cpanm XML::Fast
HOME /tmp cpanm YAML::XS


perl Makefile.PL INSTALLDIRS=site
# perl Makefile.PL INSTALLDIRS=site \
#     INC="-I${PREFIX}/include" LIBS="-L${PREFIX}/lib -lz"
make
make test
make install