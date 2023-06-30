# How to build perl-convert-pheno:

1. create a new conda environment for the build
2. conda activate biocondaPy37
3. bioconda-utils build --docker --mulled-test --git-range master --packages perl-convert-pheno

after the build is done you can install the package to try it out:
but first you need to create a local channel and index it as follows:
(w/o the local channel conda will not install the dependencies of the package)
https://github.com/conda/conda/issues/1884#issuecomment-868488922

<!-- insert code below -->

```
# create a local channel and copy the package to it
mkdir -p /tmp/my-local-channel/noarch
mv ~/mambaforge/envs/biocondaPy37/conda-bld/perl-convert-pheno-0.09-pl5321h77fc8f9_0.tar.bz2 /tmp/my-local-channel/noarch

# index the local channel and install the package
conda index /tmp/my-local-channel
conda install -c file:///tmp/my-local-channel perl-convert-pheno
```


# suggestion by ChatGPT how to build a python conda package for convert-pheno

Link to chat:
https://chat.openai.com/share/9f2266d6-78df-4fb5-a1b6-82d9564bd356

If you need to use a CPAN (Comprehensive Perl Archive Network) module in your conda environment,
you can include it in your build and run requirements by following similar steps to those outlined previously.
However, you must create a conda package for your CPAN module first if it doesn't exist already.

Create a conda recipe for your CPAN module
A conda recipe for a CPAN module will include a meta.yaml file and potentially a build.sh script.
The meta.yaml file provides metadata about the package and its dependencies,
and the build.sh script contains the commands to build the module.

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
