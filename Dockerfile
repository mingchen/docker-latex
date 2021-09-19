FROM ubuntu:21.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && \
    apt-get install -y -qq --no-install-recommends \
        ca-certificates  \
        curl \
        git \
        gnuplot \
        make \
        jq \
        python3-pygments \
        wget \
        vim-tiny && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /texlive

COPY install-texlive.sh .
COPY texlive.profile .

RUN chmod +x install-texlive.sh && \
    ./install-texlive.sh

WORKDIR /data

VOLUME ["/data"]
