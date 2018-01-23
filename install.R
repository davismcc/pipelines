## install script for R pkgs

library(BiocInstaller) # shouldn't be necessary


sc_pkgs <- c(
  "beachmat",
  "Canopy",
  "clusterExperiment",
  "destiny",
  "DiagrammeR",
  "edgeR",
  "GO.db",
  "goseq",
  "greta",
  "limma",
  "MAST",
  "monocle",
  "MultiAssayExperiment",
  "org.Hs.eg.db",
  "org.Mm.eg.db",
  "pcaMethods",
  "pheatmap",
  "preprocesCore",
  "rhdf5",
  "Rsamtools",
  "Rsubread",
  "Rtsne",
  "RUVseq",
  "SC3",
  "scater",
  "scfind",
  "scmap",
  "scone",
  "scran",
  "Seurat",
  "slalom",
  "snpStats",
  "tximport",
  "variancePartition",
  "vcfR",
  "zinbwave"
)

gen_pkgs <- c(
  "tidyverse",
  "apcluster",
  "batchtools",
  "bayesplot",
  "blogdown",
  "bookdown",
  "clustermq",
  "cowplot",
  "d3heatmap",
  "data.table",
  "devtools",
  "docopt",
  "DT",
  "dynamicTreeCut",
  "e1071",
  "future",
  "future.batchtools",
  "flexmix",
  "formatR",
  "fpc",
  "GGally",
  "ggbeeswarm",
  "ggdendro",
  "ggmcmc",
  "ggpubr",
  "ggrepel",
  "ggridges",
  "ggsci",
  "ggthemes",
  "ggtree",
  "glmnet",
  "gdata",
  "gplots",
  "gtools",
  "keras",
  "knitr",
  "lattice",
  "latticeExtra",
  "lintr",
  "lme4",
  "markdown",
  "Matrix",
  "MatrixModels",
  "matrixStats",
  "microbenchmark",
  "mvoutlier",
  "NMF",
  "packrat",
  "pryr",
  "RColorBrewer",
  "roxygen2",
  "rprojroot",
  "scales",
  "superheat",
  "tensorflow",
  "testthat",
  "tufte",
  "UpSetR",
  "viridis",
  "wesanderson",
  "xtable")

pkgs <- c(gen_pkgs, sc_pkgs)

ap.db <- available.packages(contrib.url(biocinstallRepos()))
ap <- rownames(ap.db)

pkgs_to_install <- pkgs[pkgs %in% ap]

biocLite(pkgs_to_install)

devtools::install_github("kieranrcampbell/ouija")
install.packages("rmote", repos = c(getOption("repos"), "http://cloudyr.github.io/drat"))
greta::install_tensorflow()

## just in case there were warnings, we want to see them
## without having to scroll up:
warnings()

if (!is.null(warnings()))
{
  w <- capture.output(warnings())
  if (length(grep("is not available|had non-zero exit status", w)))
    quit("no", 1L)
}

suppressWarnings(BiocInstaller::biocValid(fix=TRUE, ask=FALSE))

