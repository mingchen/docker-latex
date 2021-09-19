FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && \
    apt-get install -y -qq --no-install-recommends \
        curl \
        git \
        gnuplot \
        make \
        jq \
        python-pygments \
        texlive-full  && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /data

VOLUME ["/data"]

