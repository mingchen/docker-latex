# docker-latex

[![docker icon](https://dockeri.co/image/mingc/latex)](https://hub.docker.com/r/mingc/latex/)

[![CI](https://github.com/mingchen/docker-latex/actions/workflows/CI.yml/badge.svg)](https://github.com/mingchen/docker-latex/actions/workflows/CI.yml)
[![Docker Image CD](https://github.com/mingchen/docker-latex/actions/workflows/docker-image.yml/badge.svg)](https://github.com/mingchen/docker-latex/actions/workflows/docker-image.yml)

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
$ convert -h
Version: ImageMagick 6.9.10-23 Q16 arm 20190101 https://imagemagick.org
Copyright: © 1999-2019 ImageMagick Studio LLC
License: https://imagemagick.org/script/license.php
Features: Cipher DPC Modules OpenMP
Delegates (built-in): bzlib djvu fftw fontconfig freetype heic jbig jng jp2 jpeg lcms lqr ltdl lzma openexr pangocairo png tiff webp wmf x xml zlib
Usage: convert-im6.q16 [options ...] file [ [options ...] file ...] [options ...] file

Image Settings:
  -adjoin              join images into a single multi-image file
  -affine matrix       affine transform matrix
  -alpha option        activate, deactivate, reset, or set the alpha channel
  -antialias           remove pixel-aliasing
  -authenticate password
                       decipher image with this password
  -attenuate value     lessen (or intensify) when adding noise to an image
  -background color    background color
  -bias value          add bias when convolving an image
  -black-point-compensation
                       use black point compensation
  -blue-primary point  chromaticity blue primary point
  -bordercolor color   border color
  -caption string      assign a caption to an image
  -channel type        apply option to select image channels
  -clip-mask filename  associate a clip mask with the image
  -colors value        preferred number of colors in the image
  -colorspace type     alternate image colorspace
  -comment string      annotate image with comment
  -compose operator    set image composite operator
  -compress type       type of pixel compression when writing the image
  -define format:option
                       define one or more image format options
  -delay value         display the next image after pausing
  -density geometry    horizontal and vertical density of the image
  -depth value         image depth
  -direction type      render text right-to-left or left-to-right
  -display server      get image or font from this X server
  -dispose method      layer disposal method
  -dither method       apply error diffusion to image
  -encoding type       text encoding type
  -endian type         endianness (MSB or LSB) of the image
  -family name         render text with this font family
  -fill color          color to use when filling a graphic primitive
  -filter type         use this filter when resizing an image
  -font name           render text with this font
  -format "string"     output formatted image characteristics
  -fuzz distance       colors within this distance are considered equal
  -gravity type        horizontal and vertical text placement
  -green-primary point chromaticity green primary point
  -intensity method    method to generate intensity value from pixel
  -intent type         type of rendering intent when managing the image color
  -interlace type      type of image interlacing scheme
  -interline-spacing value
                       set the space between two text lines
  -interpolate method  pixel color interpolation method
  -interword-spacing value
                       set the space between two words
  -kerning value       set the space between two letters
  -label string        assign a label to an image
  -limit type value    pixel cache resource limit
  -loop iterations     add Netscape loop extension to your GIF animation
  -mask filename       associate a mask with the image
  -matte               store matte channel if the image has one
  -mattecolor color    frame color
  -moments             report image moments
  -monitor             monitor progress
  -orient type         image orientation
  -page geometry       size and location of an image canvas (setting)
  -ping                efficiently determine image attributes
  -pointsize value     font point size
  -precision value     maximum number of significant digits to print
  -preview type        image preview type
  -quality value       JPEG/MIFF/PNG compression level
  -quiet               suppress all warning messages
  -red-primary point   chromaticity red primary point
  -regard-warnings     pay attention to warning messages
  -remap filename      transform image colors to match this set of colors
  -repage geometry     size and location of an image canvas
  -respect-parentheses settings remain in effect until parenthesis boundary
  -sampling-factor geometry
                       horizontal and vertical sampling factor
  -scene value         image scene number
  -seed value          seed a new sequence of pseudo-random numbers
  -size geometry       width and height of image
  -stretch type        render text with this font stretch
  -stroke color        graphic primitive stroke color
  -strokewidth value   graphic primitive stroke width
  -style type          render text with this font style
  -support factor      resize support: > 1.0 is blurry, < 1.0 is sharp
  -synchronize         synchronize image to storage device
  -taint               declare the image as modified
  -texture filename    name of texture to tile onto the image background
  -tile-offset geometry
                       tile offset
  -treedepth value     color tree depth
  -transparent-color color
                       transparent color
  -undercolor color    annotation bounding box color
  -units type          the units of image resolution
  -verbose             print detailed information about the image
  -view                FlashPix viewing transforms
  -virtual-pixel method
                       virtual pixel access method
  -weight type         render text with this font weight
  -white-point point   chromaticity white point

Image Operators:
  -adaptive-blur geometry
                       adaptively blur pixels; decrease effect near edges
  -adaptive-resize geometry
                       adaptively resize image using 'mesh' interpolation
  -adaptive-sharpen geometry
                       adaptively sharpen pixels; increase effect near edges
  -alpha option        on, activate, off, deactivate, set, opaque, copy
                       transparent, extract, background, or shape
  -annotate geometry text
                       annotate the image with text
  -auto-gamma          automagically adjust gamma level of image
  -auto-level          automagically adjust color levels of image
  -auto-orient         automagically orient (rotate) image
  -bench iterations    measure performance
  -black-threshold value
                       force all pixels below the threshold into black
  -blue-shift factor   simulate a scene at nighttime in the moonlight
  -blur geometry       reduce image noise and reduce detail levels
  -border geometry     surround image with a border of color
  -bordercolor color   border color
  -brightness-contrast geometry
                       improve brightness / contrast of the image
  -canny geometry      detect edges in the image
  -cdl filename        color correct with a color decision list
  -charcoal radius     simulate a charcoal drawing
  -chop geometry       remove pixels from the image interior
  -clamp               keep pixel values in range (0-QuantumRange)
  -clip                clip along the first path from the 8BIM profile
  -clip-path id        clip along a named path from the 8BIM profile
  -colorize value      colorize the image with the fill color
  -color-matrix matrix apply color correction to the image
  -connected-components connectivity
                       connected-components uniquely labeled
  -contrast            enhance or reduce the image contrast
  -contrast-stretch geometry
                       improve contrast by `stretching' the intensity range
  -convolve coefficients
                       apply a convolution kernel to the image
  -cycle amount        cycle the image colormap
  -decipher filename   convert cipher pixels to plain pixels
  -deskew threshold    straighten an image
  -despeckle           reduce the speckles within an image
  -distort method args
                       distort images according to given method ad args
  -draw string         annotate the image with a graphic primitive
  -edge radius         apply a filter to detect edges in the image
  -encipher filename   convert plain pixels to cipher pixels
  -emboss radius       emboss an image
  -enhance             apply a digital filter to enhance a noisy image
  -equalize            perform histogram equalization to an image
  -evaluate operator value
                       evaluate an arithmetic, relational, or logical expression
  -extent geometry     set the image size
  -extract geometry    extract area from image
  -features distance   analyze image features (e.g. contrast, correlation)
  -fft                 implements the discrete Fourier transform (DFT)
  -flip                flip image vertically
  -floodfill geometry color
                       floodfill the image with color
  -flop                flop image horizontally
  -frame geometry      surround image with an ornamental border
  -function name parameters
                       apply function over image values
  -gamma value         level of gamma correction
  -gaussian-blur geometry
                       reduce image noise and reduce detail levels
  -geometry geometry   preferred size or location of the image
  -grayscale method    convert image to grayscale
  -hough-lines geometry
                       identify lines in the image
  -identify            identify the format and characteristics of the image
  -ift                 implements the inverse discrete Fourier transform (DFT)
  -implode amount      implode image pixels about the center
  -interpolative-resize geometry
                       resize image using 'point sampled' interpolation
  -kuwahara geometry   edge preserving noise reduction filter
  -lat geometry        local adaptive thresholding
  -level value         adjust the level of image contrast
  -level-colors color,color
                       level image with the given colors
  -linear-stretch geometry
                       improve contrast by `stretching with saturation'
  -liquid-rescale geometry
                       rescale image with seam-carving
  -local-contrast geometry
                       enhance local contrast
  -magnify             double the size of the image with pixel art scaling
  -mean-shift geometry delineate arbitrarily shaped clusters in the image
  -median geometry     apply a median filter to the image
  -mode geometry       make each pixel the 'predominant color' of the
                       neighborhood
  -modulate value      vary the brightness, saturation, and hue
  -monochrome          transform image to black and white
  -morphology method kernel
                       apply a morphology method to the image
  -motion-blur geometry
                       simulate motion blur
  -negate              replace every pixel with its complementary color
  -noise geometry      add or reduce noise in an image
  -normalize           transform image to span the full range of colors
  -opaque color        change this color to the fill color
  -ordered-dither NxN
                       add a noise pattern to the image with specific
                       amplitudes
  -paint radius        simulate an oil painting
  -perceptible epsilon
                       pixel value less than |epsilon| become epsilon or
                       -epsilon
  -polaroid angle      simulate a Polaroid picture
  -posterize levels    reduce the image to a limited number of color levels
  -profile filename    add, delete, or apply an image profile
  -quantize colorspace reduce colors in this colorspace
  -radial-blur angle   radial blur the image (deprecated use -rotational-blur
  -raise value         lighten/darken image edges to create a 3-D effect
  -random-threshold low,high
                       random threshold the image
  -region geometry     apply options to a portion of the image
  -render              render vector graphics
  -resample geometry   change the resolution of an image
  -resize geometry     resize the image
  -roll geometry       roll an image vertically or horizontally
  -rotate degrees      apply Paeth rotation to the image
  -rotational-blur angle
                       rotational blur the image
  -sample geometry     scale image with pixel sampling
  -scale geometry      scale the image
  -segment values      segment an image
  -selective-blur geometry
                       selectively blur pixels within a contrast threshold
  -sepia-tone threshold
                       simulate a sepia-toned photo
  -set property value  set an image property
  -shade degrees       shade the image using a distant light source
  -shadow geometry     simulate an image shadow
  -sharpen geometry    sharpen the image
  -shave geometry      shave pixels from the image edges
  -shear geometry      slide one edge of the image along the X or Y axis
  -sigmoidal-contrast geometry
                       increase the contrast without saturating highlights or
                       shadows
  -sketch geometry     simulate a pencil sketch
  -solarize threshold  negate all pixels above the threshold level
  -sparse-color method args
                       fill in a image based on a few color points
  -splice geometry     splice the background color into the image
  -spread radius       displace image pixels by a random amount
  -statistic type geometry
                       replace each pixel with corresponding statistic from the
                       neighborhood
  -strip               strip image of all profiles and comments
  -swirl degrees       swirl image pixels about the center
  -threshold value     threshold the image
  -thumbnail geometry  create a thumbnail of the image
  -tile filename       tile image when filling a graphic primitive
  -tint value          tint the image with the fill color
  -transform           affine transform image
  -transparent color   make this color transparent within the image
  -transpose           flip image vertically and rotate 90 degrees
  -transverse          flop image horizontally and rotate 270 degrees
  -trim                trim image edges
  -type type           image type
  -unique-colors       discard all but one of any pixel color
  -unsharp geometry    sharpen the image
  -vignette geometry   soften the edges of the image in vignette style
  -wave geometry       alter an image along a sine wave
  -wavelet-denoise threshold
                       removes noise from the image using a wavelet transform
  -white-threshold value
                       force all pixels above the threshold into white

Image Sequence Operators:
  -append              append an image sequence
  -clut                apply a color lookup table to the image
  -coalesce            merge a sequence of images
  -combine             combine a sequence of images
  -compare             mathematically and visually annotate the difference between an image and its reconstruction
  -complex operator    perform complex mathematics on an image sequence
  -composite           composite image
  -copy geometry offset
                       copy pixels from one area of an image to another
  -crop geometry       cut out a rectangular region of the image
  -deconstruct         break down an image sequence into constituent parts
  -evaluate-sequence operator
                       evaluate an arithmetic, relational, or logical expression
  -flatten             flatten a sequence of images
  -fx expression       apply mathematical expression to an image channel(s)
  -hald-clut           apply a Hald color lookup table to the image
  -layers method       optimize, merge, or compare image layers
  -morph value         morph an image sequence
  -mosaic              create a mosaic from an image sequence
  -poly terms          build a polynomial from the image sequence and the corresponding
                       terms (coefficients and degree pairs).
  -print string        interpret string and print to console
  -process arguments   process the image with a custom image filter
  -separate            separate an image channel into a grayscale image
  -smush geometry      smush an image sequence together
  -write filename      write images to this file

Image Stack Operators:
  -clone indexes       clone an image
  -delete indexes      delete the image from the image sequence
  -duplicate count,indexes
                       duplicate an image one or more times
  -insert index        insert last image into the image sequence
  -reverse             reverse image sequence
  -swap indexes        swap two images in the image sequence

Miscellaneous Options:
  -debug events        display copious debugging information
  -distribute-cache port
                       distributed pixel cache spanning one or more servers
  -help                print program options
  -list type           print a list of supported option arguments
  -log format          format of debugging information
  -version             print version information

By default, the image format of `file' is determined by its magic
number.  To specify a particular image format, precede the filename
with an image format name and a colon (i.e. ps:image) or specify the
image type as the filename suffix (i.e. image.ps).  Specify 'file' as
'-' for standard input or output.
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
