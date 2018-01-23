FROM quay.io/davismcc/pipelines:withr

LABEL authors="davis@ebi.ac.uk" \
    description="Docker image containing all requirements for HipSci fibro pipeline with R and necessary packages (originally developed at SciLifeLabs and adapted by Vlad Kiselev)"

# Install R Packages for bioinformatics
RUN echo 'source("https://bioconductor.org/biocLite.R")' > /opt/packages.r && \
    echo 'r <- getOption("repos"); r["CRAN"] <- "https://cran.ma.imperial.ac.uk/"; options(repos = r)' >> /opt/packages.r && \
    echo 'biocLite(ask = FALSE)' >> /opt/packages.r && \
    echo 'biocLite(c("adegenet", "beachmat", "Canopy", "clusterExperiment", "DDRTree", "destiny", "DiagrammeR", "edgeR", "GenomicRanges", "GO.db", "goseq", "greta", "limma", "MAST", "monocle", "MultiAssayExperiment", "org.Hs.eg.db", "org.Mm.eg.db", "pcaMethods", "pheatmap", "preprocesCore", "rhdf5", "Rsamtools", "Rsubread", "Rtsne", "RUVseq", "SC3", "scater", "scfind", "scmap", "scone", "scran", "Seurat", "slalom", "snpStats", "tximport", "UpSetR", "variancePartition", "VariantAnnotation", "vcfR", "vegan", "zinbwave"), repos = "http://cran.us.r-project.org")' >> /opt/packages.r
RUN echo 'devtools::install_github("kieranrcampbell/ouija", repos = "http://cran.us.r-project.org")' >> /opt/packages.r && \
    echo 'install.packages("rmote", repos = c(getOption("repos"), "http://cloudyr.github.io/drat"))' >> /opt/packages.r && \
    echo 'greta::install_tensorflow()'  >> /opt/packages.r
RUN Rscript /opt/packages.r

