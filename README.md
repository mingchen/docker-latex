# docker-latex

[![docker icon](https://dockeri.co/image/mingc/latex)](https://hub.docker.com/r/mingc/latex/)

[![CI](https://github.com/mingchen/docker-latex/actions/workflows/CI.yml/badge.svg)](https://github.com/mingchen/docker-latex/actions/workflows/CI.yml)
[![Docker Image CD](https://github.com/mingchen/docker-latex/actions/workflows/docker-image.yml/badge.svg)](https://github.com/mingchen/docker-latex/actions/workflows/docker-image.yml)

[Dockerfile](https://github.com/mingchen/docker-latex/blob/master/Dockerfile)

## Introduction

A docker image for [latex](https://www.latex-project.org/) compile with the latest release of [TeX Live 2021 full installation](https://www.tug.org/texlive/).

- tex
- latex
- xelatex
- pdflatex
- pdfjam
- pdftex
- ps2eps
- ps4pdf
- pslatex
- qpdf
- gs (ghostscript)
- imagemagick

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

### Use pdfjam

`pdfjam` is a shell-script front end to the LaTeX 'pdfpages' package.
It can be used for merge, split pdf files etc.

Merge pdf files into a single pdf file:

```sh
docker run -it --rm -v `pwd`:/data mingc/latex pdfjam -o merged.pdf file1.pdf file2.pdf
```

Extract pages from exist pdf file:

```sh
# extract page 3 and 5-7 from book1.pdf to out.pdf
docker run -it --rm -v `pwd`:/data mingc/latex pdfjam -o out.pdf book1.pdf 3,5-7
```

Rotate file:
```sh
# rotate in.pdf in 90 degree
docker run -it --rm -v `pwd`:/data mingc/latex pdfjam --angle 90 in.pdf

# rotate in.pdf in -90 degree
docker run -it --rm -v `pwd`:/data mingc/latex pdfjam --angle -90 in.pdf
```

`pdfjam` usage:

```
Usage: pdfjam [OPTIONS] [--] [FILE1 [SEL1]] [FILE2 [SEL2]]...
where
* 'FILE1' etc. are PDF files (JPG and PNG files are also allowed).  For
   input from /dev/stdin, use the special name '/dev/stdin' in place of any
   of FILE1, FILE2, etc: this can be mixed with 'real' files as needed, to
   allow input through a pipe (note that if /dev/stdin is connected to tty,
   an error results).  If 'FILE1' is absent, pdfjam will use '/dev/stdin'
   (and will use '-' for the page selection -- see next item).
* 'SEL1' is a page selection for FILE1, etc.
   To select all pages (the default) use '-'.  See the pdfpages manual for
   more details.  An example:
          ... file1 '{},2,4-6,9-' ...
   makes an empty page, followed by pages 2,4,5,6 of file1, followed by pages
   9 onwards (up to the end of file1).
   A page selection can be applied to more than one file, e.g.,
          ... file1 file2 file3 1-7 ...
   applies page selection '1-7' to all three files; but for example
          ... file1 file2 2- file3 1-7 ...
   would apply the page selection '2-' to file1 and file2, and '1-7'
   to file3.  A page selection applies to all the files *immediately*
   preceding it in the argument list.  A missing page selection defaults to
   '-'; this includes the case where 'FILE1' is absent and so /dev/stdin gets
   used by default.
* 'options' are pdfpages specifications in the form '--KEY VALUE' (see
   below), or
     --help  (or -h, or -u)
                  Output this text only; no processing of PDF files.
     --configpath
                  Output the 'configpath' variable and exit immediately; no
                  processing of PDF files.
     --version (or -V)
                  Output the version number of pdfjam and exit immediately; no
                  processing of PDF files.
     --quiet  (or -q)
                  Suppress verbose commentary on progress.
     --batch
                  Run pdfjam sequentially on each input file in turn, and
                  produce a separate output file for each input, rather
                  than the default behaviour (which is a single run of
                  pdfjam on all of the input files, producing a single
                  output document).  For the location of output
                  files, see '--outfile'.  The --batch option cannot be
                  used in the case of input from stdin.
     --outfile PATH  (or -o PATH)
                  Specifies where the output file(s) will go.  If PATH is an
                  existing directory, pdfjam will attempt to write its
                  output PDF file(s) there, with name(s) derived from the
                  input file name(s) and the --suffix option (see below).
                  Otherwise the output file will be PATH.  If '/dev/stdin'
                  is the only or last input file, PATH cannot be a directory.
                  Your current default PATH for output is:

     --suffix STRING
                  Specifies a suffix for output file names, to be used when
                  --outfile is either (a) a directory, or
                                      (b) not specified in a --batch call.
                  A good STRING should be descriptive: for example,
                           --suffix 'rotated'
                  would append the text '-rotated' to the name of the input
                  file in order to make the output file name, as in
                  'myfile-rotated.pdf'.  The STRING must not have zero
                  length.
                  [Default for you at this site: suffix=]
     --checkfiles
     --no-checkfiles
                  If the Unix 'file' utility is available, with options
                  -L and -b, the output of 'file -Lb FILE1' should be
                  'PDF document...' where '...' gives version information.
                  If this is the case on your system you should use
                  '--checkfiles'; otherwise use '--no-checkfiles',
                  in which case all input PDF files must have .pdf or .PDF
                  as their name extension.
                  [Default for you at this site: checkfiles=]
     --preamble STRING
                  Append the supplied STRING to the preamble of the LaTeX
                  source file(s), immediately before the '\begin{document}'
                  line.  An example:
                      pdfjam --nup 2x2 myfile.pdf -o myfile-4up.pdf \
                          --preamble '\usepackage{fancyhdr} \pagestyle{fancy}'
                  The '--preamble' option can be used, for example, to load
                  LaTeX packages and/or to set global options.  If '--preamble'
                  is used more than once in the call, the supplied preamble
                  strings are simply concatenated.  For a note on avoiding
                  clashes, see the PDFjam-README file (also available at
                  http://www.pdfjam.net).
     --keepinfo
     --no-keepinfo
                  Preserve (or not) Title, Author, Subject and Keywords
                  (from the last input PDF file, if more than one) in the
                  output PDF file.  This requires the pdfinfo utility, from
                  the xpdf package, and the LaTeX 'hyperref' package; if
                  either of those is not available, '--keepinfo' is ignored.
                  [Default for you at this site: keepinfo=]
     --pdftitle STRING
     --pdfauthor STRING
     --pdfsubject STRING
     --pdfkeywords STRING
                  Provide text for the  Title, Author, Subject and Keywords
                  in the output PDF file.  Requires the  LaTeX 'hyperref'
                  package.  These options, individually, over-ride --keepinfo.
     --landscape
     --no-landscape
                  Specify landscape page orientation (or not) in the
                  output PDF file.
                  [Default for you at this site: landscape=]
     --twoside
     --no-twoside
                  Specify (or not) the 'twoside' document class option.
                  [Default for you at this site: twoside=]
     --paper PAPERSPEC  (or simply --PAPERSPEC)
                  Specify a LaTeX paper size, for example
                  '--paper a4paper' or simply '--a4paper' for ISO A4 paper.
                  If the LaTeX 'geometry' package is installed, a wider range
                  of paper sizes is available.  For details see documentation
                  for LaTeX and/or the 'geometry' package.
                  [Default for you at this site: paper=]
     --papersize '{WIDTH,HEIGHT}'
                  Specify a custom paper size, e.g.,
                      --papersize '{10in,18cm}'
                  (Note the braces, and the comma!)
                  If the 'geometry' package is not found, this has no effect.
     --pagecolor RGBSPEC
                  Specify a background colour for the output pages.  The
                  RGBSPEC must be a comma-separated trio of integers
                  between 0 and 255.  An example:
                         --pagecolor 150,200,150
                  [Default is no background colour]
     --tidy
     --no-tidy
                  Specify whether the temporary directory created by
                  pdfjam should be deleted.  Use '--no-tidy' to help debug
                  most errors.
                  [Default for you at this site: tidy=]
     --latex PATHTOLATEX
                  Specify the LaTeX engine to be used (one of pdflatex,
		  xelatex, lualatex).  The PATHTOLATEX string must be
		  the full path to a suitable LaTeX executable (for example
		  /usr/bin/xelatex on many unix systems).
		  [Default for you at this site: latex=]
     --runs N
                  Run latex N times, for each output document made.
                  [Default for you at this site: runs=]
     --vanilla
                  Suppress the reading of any site-wide or user-specific
                  configuration files.
     --KEY VALUE
                  Specify options to '\includepdfmerge', in the LaTeX
                  'pdfpages' package.  Here KEY is the name of any of the
                  many options for '\includepdfmerge', and VALUE is a
                  corresponding value.  Examples are
                      --nup 2x1     (for 2-up side-by-side imposition)
                      --scale 0.7   (to scale all input pages to 70% size)
                      --offset '1cm 0.5cm'
                                    (to offset all pages -- note the quotes!)
                      --frame true  (to put a frame round each input page)
                      --trim '1cm 2cm 1cm 2cm' --clip true
                                    (to trim those amounts from left, bottom,
                                     right and top, respectively, of input
                                     pages)
                  etc., etc.  For more information see the manual for
                  the 'pdfpages' package, at
                  http://www.ctan.org/tex-archive/macros/latex/contrib/pdfpages
* '--' can be used to signal that there are no more options to come.
```

### Use ImageMagick

Convert pdf to image:

```sh
docker run -it --rm -v `pwd`:/data mingc/latex convert -density 300 input.pdf -quality 90 output.jpg
```

By default it will generate jpg files for each page. The file name pattern is `output-<page number>.jpg`.

To specific output file name pattern:

```sh
docker run -it --rm -v `pwd`:/data mingc/latex convert -density 300 input.pdf -quality 90 output_%03d.jpg
```

It will generate `output_000.jpg`, `output_001.jpg`, `output_002.jpg` ...

Convert a single page to image:

```sh
docker run -it --rm -v `pwd`:/data mingc/latex convert -density 300 input.pdf[125] -quality 90 output.png
```

Image format can be `.jpg` or `.png`.

`-density xxx` will set the DPI to `xxx` (common are `150`, `200` and `300`).

`-quality xxx` will set the compression to `xxx` for PNG, JPG and MIFF file formates (100 means no compression).

`[125]` will convert only the 126th page to JPG (zero-based numbering so `[0]` is the 1st page).

ImageMagick `convert` usage:

```sh
$ docker run -it --rm -v `pwd`:/data mingc/latex convert -h
```

## FAQ

### Setting the default paper size

The default is to configure the programs for the A4 paper size. To make the default be 8.5x11 letter-size paper, you can run:

```sh
tlmgr paper letter
```

### Use Custom Fonts

Custom fonts can be map to `/root/.fonts`, use `xelatex` for CJK characters:

```sh
docker run --rm -i \
       -v `pwd`:/data \
       -v `pwd`/.fonts:/root/.fonts \
       mingc/latex \
              xelatex example.tex
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
- [pdfpages](http://www.ctan.org/tex-archive/macros/latex/contrib/pdfpages)
- [pdfjam](https://github.com/DavidFirth/pdfjam)
- [ImageMagick](https://imagemagick.org/)
