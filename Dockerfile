FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -q
RUN apt install -y -qq --no-install-recommends \
    ca-certificates  \
    curl \
    ghostscript \
    git \
    gnuplot \
    imagemagick \
    make \
    jq \
    qpdf \
    python3-pygments \
    wget \
    vim-tiny \ 
    perl \
    build-essential \
    libssl-dev \
    texlive-full \
    texlive-latex-extra
RUN curl -L https://cpanmin.us | perl - App::cpanminus
RUN cpanm YAML::Tiny
RUN cpan File::HomeDir

WORKDIR /data

VOLUME ["/data"]
