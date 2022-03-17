describeBiocView <- function(x) {
    pkgs <- x@packageList
    maintainers <-
        unlist(sapply(pkgs, function(x) strsplit(x@Maintainer, ",")))
    contributors <- sapply(pkgs,
       function(x) {
           n <- unlist(strsplit(x@Author, "with contr"))
           n <- unlist(strsplit(n, ","))
           n <- unlist(strsplit(n, " and "))
           length(n)
       })
    cat("## biocView ", x@name, "\n")
    cat("- ", length(pkgs), " packages", "\n")
    cat("- ", length(maintainers), " maintainers", "\n")
    cat("- ", length(unique(maintainers)), " unique maintainers", "\n")
    cat("- ", sum(contributors), " contributors", "\n")
    invisible(pkgs)
}

v <- BiocManager::version()
url <- paste0("http://bioconductor.org/packages/", v, "/bioc")

## Bioconductor Task Views Vocabulary Data
data(biocViewsVocab, package = "biocViews")

## Specific BiocView of interest
bv <- biocViews:::getBiocViews(url, biocViewsVocab, "NoViewProvided")

msp <- describeBiocView(bv[["MassSpectrometry"]])
pp <- describeBiocView(bv[["Proteomics"]])
mp <- describeBiocView(bv[["Metabolomics"]])
