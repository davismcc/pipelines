FROM quay.io/davismcc/pipelines:base

LABEL authors="davis@ebi.ac.uk" \
    description="Docker image containing all requirements for HipSci fibro pipeline with R and necessary packages (originally developed at SciLifeLabs and adapted by Vlad Kiselev)"

# Install R
RUN curl -fsSL https://cran.r-project.org/src/base/R-3/R-3.4.3.tar.gz -o /opt/R-3.4.3.tar.gz && \
    tar xvzf /opt/R-3.4.3.tar.gz -C /opt/ && \
    cd /opt/R-3.4.3 && \
    ./configure && \
    make && \
    make install && \
    rm /opt/R-3.4.3.tar.gz

# install tidyverse and similar packages
RUN mkdir -p /usr/local/lib/R/site-library
RUN echo 'source("https://bioconductor.org/biocLite.R")' > /opt/packages.r && \
    echo 'biocLite(c("tidyverse", "apcluster", "batchtools", "bayesplot", "blogdown", "bookdown", "clustermq", "coda", "cowplot", "d3heatmap", "data.table", "devtools", "docopt", "DT", "dupRadar", "dynamicTreeCut", "e1071", "future", "future.batchtools", "flexmix", "formatR", "fpc", "GGally", "ggbeeswarm", "ggdendro", "ggmcmc", "ggpubr", "ggrepel", "ggridges", "ggsci", "ggthemes", "ggtree", "glmnet", "gdata", "gplots", "gtools", "keras", "knitr", "lattice", "latticeExtra", "lintr", "lme4", "markdown", "Matrix", "MatrixModels", "matrixStats", "microbenchmark", "mvoutlier", "NMF", "packrat", "pmclust", "pryr", "RColorBrewer", "roxygen2", "rprojroot", "scales", "superheat", "tensorflow", "testthat", "tufte", "UpSetR", "VGAM", "viridis", "wesanderson", "xtable"))' >> /opt/packages.r
RUN Rscript /opt/packages.r



