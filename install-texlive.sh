#!/bin/sh -x
#
# Install TeX Live, see https://www.tug.org/texlive/quickinstall.html
#

wget -q https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz || exit 1

mkdir install-tl
tar --strip-components 1 -zvxf install-tl-unx.tar.gz -C "$PWD/install-tl" || exit 2
rm install-tl-unx.tar.gz

cd install-tl
./install-tl --profile=/texlive/texlive.profile

cd ..
rm -fr install-tl
