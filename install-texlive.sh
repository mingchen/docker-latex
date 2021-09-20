#!/bin/sh -x
#
# Install TeX Live, see https://www.tug.org/texlive/quickinstall.html
#

# wget may failed due to TLS error. use curl instead.
#
# CTAN_MIRROR=https://ctan.math.ca/tex-archive
CTAN_MIRROR=https://mirror.ctan.org

curl -s -L --output install-tl-unx.tar.gz ${CTAN_MIRROR}/systems/texlive/tlnet/install-tl-unx.tar.gz || exit 2

mkdir install-tl
tar --strip-components 1 -zvxf install-tl-unx.tar.gz -C "$PWD/install-tl" || exit 3
rm install-tl-unx.tar.gz

cd install-tl
./install-tl --profile=/texlive/texlive.profile || exit 5

cd ..
rm -fr install-tl
