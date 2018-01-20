FROM davismcc/pipelines:master

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

# Install R Packages v2
RUN echo 'source("https://bioconductor.org/biocLite.R")' > /opt/packages.r && \
    echo 'biocLite()' >> /opt/packages.r && \
    echo 'biocLite(c("adegenet", "apcluster", "batchtools", "bayesplot", "beachmat", "blogdown", "bookdown", "Canopy", "clusterExperiment", "clustermq", "coda", "cowplot", "d3heatmap", "data.table", "DDRTree", "destiny", "devtools", "DiagrammeR", "docopt", "doParallel", "dplyr", "DT", "dtplyr", "dupRadar", "dynamicTreeCut", "e1071", "edgeR", "future", "future.batchtools", "flexmix", "formatR", "fpc", "GenomicRanges", "GGally", "ggbeeswarm", "ggdendro", "ggmcmc", "ggpubr", "ggrepel", "ggridges", "ggsci", "ggthemes", "ggtree", "glmnet", "gdata", "gplots", "GO.db", "goseq", "greta", "gtools", "keras", "knitr", "lattice", "latticeExtra", "limma", "lintr", "lme4", "markdown", "MAST", "Matrix", "MatrixModels", "matrixStats", "microbenchmark", "monocle", "MultiAssayExperiment", "mvoutlier", "NMF", "org.Hs.eg.db", "org.Mm.eg.db", "packrat", "pcaMethods", "pheatmap", "pmclust", "preprocesCore", "pryr", "RColorBrewer", "rhdf5", "roxygen2", "rprojroot", "Rsamtools", "Rsubread", "Rtsne", "RUVseq", "SC3", "scales", "scater", "scfind", "scmap", "scone", "scran", "Seurat", "slalom", "snpStats", "superheat", "tensorflow", "testthat", "tfestimators", "tidyverse", "tufte", "tximport", "UpSetR", "variancePartition", "VariantAnnotation", "vcfR", "vegan", "VGAM", "viridis", "wesanderson", "xtable", "zinbwave"))' >> /opt/packages.r && \
    echo 'devtools::install_github("kieranrcampbell/ouija")' >> /opt/packages.r && \
        echo 'install.packages("rmote", repos = c(getOption("repos"), "http://cloudyr.github.io/drat"))' >> /opt/packages.r && \
    echo 'greta::install_tensorflow()'  >> /opt/packages.r && \
    Rscript /opt/packages.r && \
    mkdir -p /usr/local/lib/R/site-library


