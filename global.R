library(CellMix)
library(ggplot2)
library(shiny)
library(shinythemes)
library(shinyBS)
library(shinycssloaders)

options(shiny.maxRequestSize = 50*1024^2)


#################################################
### load markers
#################################################

markers.file <- read.table(file = "data/MarkersList_V1.txt", sep="\t", header=T, row.names=1)

### create markers objects
brown.markers<-subset(markers.file, marker.type == "brown")
white.markers<-subset(markers.file, marker.type == "white")


markers.list <- list()
markers.list[['mouse']] <- MarkerList(list(brown = as.character(brown.markers$mouse),
                             white = as.character(white.markers$mouse)))

markers.list[['human']] <- MarkerList(list(brown = as.character(brown.markers$human),
                             white = as.character(white.markers$human)))


#ex_mouse <- read.table(file="data/RPKM_319.txt", sep="\t", header=T, row.names=1, check.names=F)


#################################################
### functions
#################################################

calc_proportions <- function(x, markers, method = 'DSA') {
  
  # methods
  ## DSA Digital Sorting Algorithm
  ## ssKL = semi-supervised NMF for KL divergence
  ## ssFrobenius = semi-supervised NMF for euclid distance
  ## meanProfile = proportion proxies
  
  res <- ged(as.matrix(x) + 0.01, markers, method, verbose = FALSE) # add small pseudocount to avoid zero-errors
  scaled.proportions <- scoef(res)
  return(scaled.proportions)
}

