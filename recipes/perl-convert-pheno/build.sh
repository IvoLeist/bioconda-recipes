#!/bin/bash
# HOME=/tmp cpanm --installdeps .
export LD_LIBRARY_PATH="${PREFIX}/lib"
HOME=/tmp cpanm PerlIO::gzip
# HOME=/tmp cpanm  Convert::Pheno