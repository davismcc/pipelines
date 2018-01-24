FROM quay.io/davismcc/pipelines:r-tidy

MAINTAINER davis@ebi.ac.uk
LABEL authors="davis@ebi.ac.uk" \
    description="Docker image containing R and packages for single-cell analyses"

# Install container-wide requrements gcc, pip, zlib, libssl, make, libncurses, fortran77, g++, R
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y --no-install-recommends \
        bedtools \
        curl \
        emacs \
        git \
        libbz2-dev \
        libcurl4-openssl-dev \
        libgsl-dev \
        libgsl2 \
        liblzma-dev \
        libncurses5-dev \
        libpcre3-dev \
        libreadline-dev \
        libssh2-1-dev \
        libssl-dev \
        libxml2-dev \
        libzmq3-dev \
        make \
        pandoc \
        pandoc-citeproc \
        python-dev \
        python3-pip \
        python3-tk \
        wget \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p  /usr/local/lib/R/site-library

ADD install.R /tmp/

RUN R -f /tmp/install.R

