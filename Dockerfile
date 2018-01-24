FROM rocker/verse:latest

MAINTAINER davis@ebi.ac.uk
LABEL authors="davis@ebi.ac.uk" \
description="Docker image R with tidyverse and general stats packages"

# Install container-wide requrements gcc, pip, zlib, libssl, make, libncurses, fortran77, g++, R
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y --no-install-recommends \
        bedtools \
        curl \
        emacs \
        g++ \
        gcc \
        gfortran \
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
        python-pip \
        python3-dev \
        python3-pip \
        python3-tk \
        wget \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Install tensorflow
pip install tensorflow

# Install snakemake
pip3 install snakemake

RUN mkdir -p /usr/local/lib/R/site-library

ADD install.R /tmp/

RUN R -f /tmp/install.R

