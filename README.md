# docker-latex

[![docker icon](https://dockeri.co/image/mingc/latex)](https://hub.docker.com/r/mingc/latex/)
[![CI](https://github.com/mingchen/docker-latex/actions/workflows/CI.yml/badge.svg)](https://github.com/mingchen/docker-latex/actions/workflows/CI.yml)
[![Docker Image CD](https://github.com/mingchen/docker-latex/actions/workflows/docker-image.yml/badge.svg)](https://github.com/mingchen/docker-latex/actions/workflows/docker-image.yml)

A docker image for [latex](https://www.latex-project.org/) compile with [TeX Live](https://www.tug.org/texlive/).

Scheduled build weekly to get the latest softwares and patches.

## Supported Platforms

Docker image cross platform build to support following platforms:

* amd64
* arm64
* riscv64
* arm/v7
* s390x

## Usage

To build `pdf` from `.tex` file:

```sh
docker run --rm -i -v `pwd`:/data mingc/latex pdflatex foo.tex
```

To preserve build files user id and group id, pass `--user="$(id -u):$(id -g)"` to docker:

```sh
docker run --rm -i --user="$(id -u):$(id -g)" -v `pwd`:/data mingc/latex pdflatex foo.tex
```

To run interactive docker shell:

```sh
docker run --rm -it --user="$(id -u):$(id -g)" -v `pwd`:/data mingc/latex bash
root@5b9d4a3eefe4:/data#
```

Use following command o get the `pdflatex` version in docker image:

```sh
$ docker run --rm -i -v `pwd`:/data mingc/latex pdflatex -version
pdfTeX 3.14159265-2.6-1.40.20 (TeX Live 2019/Debian)
kpathsea version 6.3.1
Copyright 2019 Han The Thanh (pdfTeX) et al.
There is NO warranty.  Redistribution of this software is
covered by the terms of both the pdfTeX copyright and
the Lesser GNU General Public License.
For more information about these matters, see the file
named COPYING and the pdfTeX source.
Primary author of pdfTeX: Han The Thanh (pdfTeX) et al.
Compiled with libpng 1.6.37; using libpng 1.6.37
Compiled with zlib 1.2.11; using zlib 1.2.11
Compiled with xpdf version 4.01
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
