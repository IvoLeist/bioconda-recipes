#!/bin/bash
# HOME=/tmp cpanm PerlIO::gzip
HOME=/tmp cpanm --installdeps .
git clone https://github.com/tkluck/pyperler.git
cd pyperler
python setup.py build && sudo python setup.py install