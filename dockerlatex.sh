#!/bin/sh
#
# Usage example:
#
#   dockerlatex.sh pdflatex foo.tex
#

docker run --rm -i --user="$(id -u):$(id -g)" -v `pwd`:/data mingc/latex $@
