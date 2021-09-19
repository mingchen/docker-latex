# docker-latex

A docker image for `latex` using `texlive`.

Scheduled build weekly to get the latest software and patches.

## Supported Platforms

* amd64
* arm64,
* riscv64
* arm/v7
* s390x

## Usage

Build `pdf` from `.tex` file:

```sh
docker run --rm -i -v `pwd`:/data mingc/latex pdflatex foo.tex
```

To preserve build files user id and group id, pass `--user="$(id -u):$(id -g)"` to docker:

```sh
docker run --rm -i --user="$(id -u):$(id -g)" -v `pwd`:/data mingc/latex pdflatex foo.tex
```

## Build Image

```sh
docker build -t mingc/latex .
```

## Latex Templates

Checkout [templates](templates) for some template examples.
