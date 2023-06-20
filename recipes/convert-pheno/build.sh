#!/bin/bash
HOME=/tmp cpanm --installdeps .
git clone https://github.com/tkluck/pyperler.git
cd pyperler
python setup.py build && python setup.py install