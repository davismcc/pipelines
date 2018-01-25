source("https://bioconductor.org/biocLite.R")
library(BiocInstaller) # shouldn't be necessary


pkgs <- c(
  "apcluster",
  "batchtools",
  "bayesplot",
  "clustermq",
  "coda",
  "cowplot",
  "d3heatmap",
  "data.table",
  "devtools",
  "DiagrammeR",
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
  "greta",
  "keras",
  "lattice",
  "latticeExtra",
  "lintr",
  "lme4",
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
  "VGAM",
  "viridis",
  "wesanderson",
  "xtable"
)

ap.db <- available.packages(contrib.url(biocinstallRepos()))
ap <- rownames(ap.db)

pkgs_to_install <- pkgs[pkgs %in% ap]

biocLite(pkgs_to_install)
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

