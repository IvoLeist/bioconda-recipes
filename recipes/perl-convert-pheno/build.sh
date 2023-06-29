#!/bin/bash
# HOME=/tmp cpanm Convert::Pheno
# HOME=/tmp cpanm --installdeps .
# export LD_LIBRARY_PATH="${PREFIX}/lib"
# export C_INCLUDE_PATH="${PREFIX}/include"

# below causes a lot of compilation errors
# export C_INCLUDE_PATH=${C_INCLUDE_PATH}:/usr/include/x86_64-linux-gnu
# HOME=/tmp cpanm PerlIO::gzip

# Add the conda lib paths to PERL5LIB

# perl version
perl_version=$(perl -e 'print $^V');
perl_version=${perl_version:1}
echo "perl_version: $perl_version"

# try to undo the symlink
unlink "$CONDA_PREFIX/lib/perl5/5.32/site_perl"

echo "CONDA_PREFIX: $CONDA_PREFIX"
export PERL5LIB="$CONDA_PREFIX/lib:$CONDA_PREFIX/lib/perl5:$CONDA_PREFIX/lib/perl5/site_perl:$PERL5LIB"
echo "PERL5LIB: $PERL5LIB"

# according to ChatGPT-4 the following could help:
# export PERL_LOCAL_LIB_ROOT="$CONDA_PREFIX/lib/perl5/site_perl"
#  or a symlink
# ln -s "$PREFIX/lib/perl5/site_perl" "$CONDA_PREFIX/lib/perl5/5.32/site_perl"

echo "say for @INC"
perl -E 'say for @INC'
echo "say for @INC - END"

# the lines above have confirmed the via conda installed perl modules are in the INC path
# but still when trying to install the perl module Convert::Pheno it fails to find them
# because it is looking only in the follwing paths:
# $PREFIX/lib/perl5/5.32/site_perl
# $PREFIX/lib/perl5/5.32/vendor_perl
# $PREFIX/lib/perl5/5.32/core_perl

echo "get all perl modules in @INC"
INC_PATHS=$(perl -e 'print join(" ", @INC)')

for path in $INC_PATHS; do
    # Ensure path exists and is a directory
    if [[ -d "$path" ]]; then
        find "$path" -type f -name "*.pm"
    fi
done
echo "get all perl modules in @INC - END"

# the lines above have confirmed the via conda installed perl modules
# are there but unfortunately not in the paths including the perl version number
# but e.g. there:
# $PREFIX/lib/perl5/site_perl/Sort/Naturally.pm
# and the path above is not used when trying to install the perl module Convert::Pheno


# install dependencies not found in conda channels
install_deps() {
    deps=(
        "File::ShareDir::ProjectDistDir"
        "JSON::Validator"
        "Moo"
        "Path::Tiny"
        "Test::Deep"
        "Test::Warn"
        "Text::CSV_XS"
        "Text::Similarity"
        "Types::Standard"
        "XML::Fast"
        "YAML::XS"
    )
    for dep in "${deps[@]}"; do
        HOME=/tmp cpanm "$dep" || {
            echo "Failed to install perl module $dep"
            exit 1
        }
    done
}
install_deps

# HOME=/tmp cpanm File::ShareDir::ProjectDistDir
# HOME=/tmp cpanm JSON::Validator
# HOME=/tmp cpanm Moo
# HOME=/tmp cpanm Path::Tiny
# HOME=/tmp cpanm Sort::Naturally
# HOME=/tmp cpanm Test::Deep
# HOME=/tmp cpanm Test::Warn
# HOME=/tmp cpanm Text::CSV_XS
# HOME=/tmp cpanm Text::Similarity
# HOME=/tmp cpanm Types::Standard
# HOME=/tmp cpanm XML::Fast
# HOME=/tmp cpanm YAML::XS

perl Makefile.PL INSTALLDIRS=site
make
# make test

# suggestion by chatGPT to debug tests
# Run tests one by one and capture error logs
# TEST_LOGS_DIR="test_logs"
# mkdir -p "$TEST_LOGS_DIR"

# test_modules=("t/args.t" "t/cli.t")

# for test_module in "${test_modules[@]}"; do
#   test_name=$(basename "$test_module" ".t")
#   test_log_file="$TEST_LOGS_DIR/$test_name.log"
  
#   echo "Running test: $test_name"
#   make test TEST_FILES="$test_module" 2> "$test_log_file"
  
#   if [ $? -eq 0 ]; then
#     echo "Test '$test_name' passed."
#   else
#     echo "Test '$test_name' failed. Error log saved to: $test_log_file"
#   fi
# done

make install










# testing seem to fail (see below)
# make test
# make install


# perl Makefile.PL INSTALLDIRS=site \
#     INC="-I${PREFIX}/include" LIBS="-L${PREFIX}/lib -lz"

# failed testing logs:
# 19:09:12 BIOCONDA INFO (OUT) t/args.t .....
# 19:09:12 BIOCONDA INFO (OUT) Dubious, test returned 255 (wstat 65280, 0xff00)
# 19:09:12 BIOCONDA INFO (OUT) Failed 6/7 subtests
# 19:09:12 BIOCONDA INFO (OUT) t/cli.t ......
# 19:09:12 BIOCONDA INFO (ERR)   File "/home/ivo/mambaforge/envs/biocondaPy37/lib/python3.7/site-packages/conda_build/api.py", line 195, in build
# 19:09:12 BIOCONDA INFO (OUT) Dubious, test returned 255 (wstat 65280, 0xff00)
# 19:09:12 BIOCONDA INFO (ERR)     variants=variants
# 19:09:12 BIOCONDA INFO (OUT) Failed 2/9 subtests
# 19:09:12 BIOCONDA INFO (OUT) t/mapping.t .. ok
# 19:09:12 BIOCONDA INFO (OUT) t/module.t ... ok
# 19:09:12 BIOCONDA INFO (OUT) t/ohdsi.t .... ok
# 19:09:12 BIOCONDA INFO (OUT) t/stream.t ... ok
# 19:09:12 BIOCONDA INFO (OUT)
# 19:09:12 BIOCONDA INFO (OUT) Test Summary Report
# 19:09:12 BIOCONDA INFO (OUT) -------------------
# 19:09:12 BIOCONDA INFO (OUT) t/args.t   (Wstat: 65280 Tests: 1 Failed: 0)
# 19:09:12 BIOCONDA INFO (OUT)   Non-zero exit status: 255
# 19:09:12 BIOCONDA INFO (ERR)   File "/home/ivo/mambaforge/envs/biocondaPy37/lib/python3.7/site-packages/conda_build/build.py", line 3093, in build_tree
# 19:09:12 BIOCONDA INFO (OUT)   Parse errors: Bad plan.  You planned 7 tests but ran 1.
# 19:09:12 BIOCONDA INFO (ERR)     notest=notest,
# 19:09:12 BIOCONDA INFO (OUT) t/cli.t    (Wstat: 65280 Tests: 7 Failed: 0)
# 19:09:12 BIOCONDA INFO (OUT)   Non-zero exit status: 255
# 19:09:12 BIOCONDA INFO (OUT)   Parse errors: Bad plan.  You planned 9 tests but ran 7.
# 19:09:12 BIOCONDA INFO (OUT) Files=6, Tests=19,  9 wallclock secs ( 0.02 usr  0.01 sys +  8.76 cusr  0.37 csys =  9.16 CPU)
# 19:09:12 BIOCONDA INFO (OUT) Result: FAIL