## install script for R pkgs
source("https://bioconductor.org/biocLite.R")

library(BiocInstaller) # shouldn't be necessary
biocLite()


sc_pkgs <- c(
  "beachmat",
  "Canopy",
  "clusterExperiment",
  "destiny",
  "DiagrammeR",
  "edgeR",
  "GO.db",
  "goseq",
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

pkgs <- c(sc_pkgs)

ap.db <- available.packages(contrib.url(biocinstallRepos()))
ap <- rownames(ap.db)

pkgs_to_install <- pkgs[pkgs %in% ap]

biocLite(pkgs_to_install)

devtools::install_github("kieranrcampbell/ouija")

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

