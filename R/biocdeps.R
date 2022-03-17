library("Rgraphviz")
library("pkgDepTools")

## Current Bioc devel
biocUrl <- BiocManager::repositories()["BioCsoft"]
## Make dependency graph
biocDeps <- makeDepGraph(biocUrl, type = "source", dosize = FALSE)
## biocDeps0 <- layoutGraph(biocDeps)


## Proteomics packages dependency graph
pp <- unname(sapply(prot_packages, slot, "Package"))
## below, remove package that aren't in the dependency graph
pp <- pp[which(pp %in% nodes(biocDeps))]
## ## proteomics nodes and their dependencies
## nds <- unique(c(pp, unlist(sapply(acc(biocDeps, pp), names),
##                            use.names = FALSE)))
prot_deps <- subGraph(pp, biocDeps)

plot_deps <- function(gr, sz = 20, fs = "95") {
    makecls <- function(g) {
        blue <- c("MSnbase", "mzR", "ProtGenerics")
        red <- c("Spectra", "MsCoreUtils")
        orange <- c("QFeatures", "MsFeatures")
        yellow <- c("xcms", "MetaboCoreUtils")
        x <- nodes(g)
        ans <- rep("white", length(x))
        ans[x %in% blue] <- "steelblue"
        ans[x %in% red] <- "red"
        ans[x %in% orange] <- "orange"
        ans[x %in% yellow] <- "yellow"
        ans
    }
    nn <- makeNodeAttrs(gr,
                        height = sz, width = sz,
                        fontsize = fs,
                        fillcolor = makecls(gr))
    plot(gr, nodeAttrs = nn,
         attrs = list(edge = list(color = "#00000040")))

}

svg("./figs/prot_deps.svg")
plot_deps(prot_deps)
dev.off()

## Mass spectrometry packages dependency graph
msp <- unname(sapply(ms_packages, slot, "Package"))
## below, remove package that aren't in the dependency graph
msp <- msp[which(msp %in% nodes(biocDeps))]
ms_deps <- subGraph(msp, biocDeps)

svg("./figs/ms_deps.svg")
plot_deps(ms_deps)
dev.off()


## Metabolomics packages dependency graph
mp <- unname(sapply(metabo_packages, slot, "Package"))
## below, remove package that aren't in the dependency graph
mp <- mp[which(mp %in% nodes(biocDeps))]
mp_deps <- subGraph(mp, biocDeps)

svg("./figs/metabo_deps.svg")
plot_deps(mp_deps)
dev.off()
