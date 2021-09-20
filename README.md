# docker-latex

[![docker icon](https://dockeri.co/image/mingc/latex)](https://hub.docker.com/r/mingc/latex/)

[![CI](https://github.com/mingchen/docker-latex/actions/workflows/CI.yml/badge.svg)](https://github.com/mingchen/docker-latex/actions/workflows/CI.yml)
[![Docker Image CD](https://github.com/mingchen/docker-latex/actions/workflows/docker-image.yml/badge.svg)](https://github.com/mingchen/docker-latex/actions/workflows/docker-image.yml)

## Introduction

A docker image for [latex](https://www.latex-project.org/) compile with the latest release of [TeX Live 2021 full installation](https://www.tug.org/texlive/).

Base image: `ubuntu 21.04`.

Install location: `/usr/local/texlive/2021`.

Work directory: `/data`

Scheduled build weekly to get the latest softwares and patches.
## Supported Platforms

Docker image cross platform build to support following platforms:

* amd64
* arm64
* arm/v7

## Usage

The best way is download wrapper `dockerlatex.sh` and save to your bin path, e.g.

```sh
wget https://raw.githubusercontent.com/mingchen/docker-latex/master/dockerlatex.sh
chmod +x dockerlatex.sh
mv dockerlatex.sh $HOME/bin/
```

`dockerlatex.sh` wrapper map the current userid and current directory to docker, The content as following:

```sh
docker run --rm -i --user="$(id -u):$(id -g)" -v `pwd`:/data mingc/latex $@
```

Then use `dockerlatex.sh` to run docker commands.

To build `pdf` from `.tex` file:

```sh
dockerlatex.sh pdflatex foo.tex

# or
docker run --rm -i -v `pwd`:/data mingc/latex pdflatex foo.tex
```

To preserve build files user id and group id, pass `--user="$(id -u):$(id -g)"` to docker:

```sh
docker run --rm -i --user="$(id -u):$(id -g)" -v `pwd`:/data mingc/latex pdflatex foo.tex
```

To run interactive docker shell:

```sh
docker run --rm -it --user="$(id -u):$(id -g)" -v `pwd`:/data mingc/latex bash
```

Use following command o get the `pdflatex` version in docker image:

```sh
$ dockerlatex.sh pdflatex -version
pdfTeX 3.141592653-2.6-1.40.23 (TeX Live 2021)
kpathsea version 6.3.3
Copyright 2021 Han The Thanh (pdfTeX) et al.
There is NO warranty.  Redistribution of this software is
covered by the terms of both the pdfTeX copyright and
the Lesser GNU General Public License.
For more information about these matters, see the file
named COPYING and the pdfTeX source.
Primary author of pdfTeX: Han The Thanh (pdfTeX) et al.
Compiled with libpng 1.6.37; using libpng 1.6.37
Compiled with zlib 1.2.11; using zlib 1.2.11
Compiled with xpdf version 4.03
```

## setting the default paper size

The default is to configure the programs for the A4 paper size. To make the default be 8.5x11 letter-size paper, you can run:

```sh
tlmgr paper letter
```

## Build Image

```sh
docker build -t mingc/latex .
```

## Latex Templates

Checkout [templates](https://github.com/mingchen/docker-latex/tree/master/templates) for some template examples.

## Alternatives

- [blang/latex-docker](https://github.com/blang/latex-docker): latex docker build on ubuntu 16.04

## References

- https://www.latex-project.org/
- https://www.tug.org/texlive/
- https://www.tug.org/texlive/quickinstall.html
- https://ctan.org/mirrors
