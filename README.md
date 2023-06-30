# suggestion by ChatGPT how to build a python conda package for convert-pheno

https://stackoverflow.com/questions/65724310/unable-to-install-perl-modules-via-cpanm-in-conda-environments
Thanks you very match @Håkon! This is the clearest and most comprehensive answer I got from the web. Finally, I was able to install most of the perl modules via cpanm, into a conda environment. I also found that if your module requires one or more headers from any C library (ie: PerlIO::gzip), you can install that library with conda (conda install -c anaconda zlib) and add $CONDA_PREFIX/include to the ccflags var from Config_heavy.pl -I/igatech/rd/dev/miniconda3/envs/test-perl/include – 
vid1998
 Jan 15, 2021 at 17:28

Link to chat:
https://chat.openai.com/share/9f2266d6-78df-4fb5-a1b6-82d9564bd356

If you need to use a CPAN (Comprehensive Perl Archive Network) module in your conda environment,
you can include it in your build and run requirements by following similar steps to those outlined previously.
However, you must create a conda package for your CPAN module first if it doesn't exist already.

Create a conda recipe for your CPAN module
A conda recipe for a CPAN module will include a meta.yaml file and potentially a build.sh script.
The meta.yaml file provides metadata about the package and its dependencies,
and the build.sh script contains the commands to build the module.

conda build perl-convert-pheno
conda activate biocondaPy37
bioconda-utils build --docker --mulled-test --git-range master --packages perl-convert-pheno

after the build is done you can install the package with:
mamba install --use-local perl-convert-pheno

unfortunately errors out with:
Can't locate Sort/Naturally.pm in @INC (you may need to install the Sort::Naturally module) (@INC contains: /home/ivo/mambaforge/envs/biocondaPy37/bin/../lib /home/ivo/mambaforge/envs/biocondaPy37/lib/perl5/5.32/site_perl /home/ivo/mambaforge/envs/biocondaPy37/lib/perl5/site_perl /home/ivo/mambaforge/envs/biocondaPy37/lib/perl5/5.32/vendor_perl /home/ivo/mambaforge/envs/biocondaPy37/lib/perl5/vendor_perl /home/ivo/mambaforge/envs/biocondaPy37/lib/perl5/5.32/core_perl /home/ivo/mambaforge/envs/biocondaPy37/lib/perl5/core_perl .) at /home/ivo/mambaforge/envs/biocondaPy37/lib/perl5/site_perl/Convert/Pheno/CSV.pm line 9.

Looks like the package dependecies are not installed.
Even though the extracted .tar.bz2 looks correct.
It`s info/index.json looks as follows:

"depends": [
    "perl >=5.32.1,<6.0a0 *_perl5",
    "perl-dbd-sqlite",
    "perl-dbi",
    "perl-json-xs",
    "perl-perlio-gzip",
    "perl-sort-naturally"
],

Include the CPAN module as a dependency in your Python conda package
Now you can include perl-convert-pheno as a dependency in your meta.yaml file for your Python conda package.

```
requirements:
	build:
		- python
		- setuptools
		- perl
		- perl-convert-pheno

	run:
		- python
		- perl
		- perl-convert-pheno
```

![](https://raw.githubusercontent.com/bioconda/bioconda-recipes/master/logo/bioconda_monochrome_small.png "Bioconda")

# The bioconda channel

[![Gitter](https://badges.gitter.im/bioconda/bioconda-recipes.svg)](https://gitter.im/bioconda/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

[Conda](http://anaconda.org) is a platform- and language-independent package
manager that sports easy distribution, installation and version management of
software. The [bioconda channel](https://anaconda.org/bioconda) is a Conda
channel providing bioinformatics related packages for **Linux** and **Mac OS**.
This repository hosts the corresponding recipes.

## User guide

Please visit https://bioconda.github.io for details.

## Developer guide

Please visit the new docs at https://bioconda.github.io/contributor/index.html for details.
