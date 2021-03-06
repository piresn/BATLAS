### install CellMix first time
# source('http://www.bioconductor.org/biocLite.R')
# biocLite('CellMix', siteRepos = 'http://web.cbio.uct.ac.za/~renaud/CRAN', type='both')

library(CellMix)
library(ggplot2)
library(shiny)
library(shinythemes)
library(shinycssloaders)
library(reshape2)
library(scales)
library(DT)


# Limit user files to 100MB
options(shiny.maxRequestSize = 100*1024^2)


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


#################################################
### functions
#################################################

source('validation.R')


calc_proportions <- function(x, markers, method = 'DSA') {
  
  # methods
  ## DSA Digital Sorting Algorithm
  ## ssKL = semi-supervised NMF for KL divergence
  ## ssFrobenius = semi-supervised NMF for euclid distance
  ## meanProfile = proportion proxies
  
  x <- ged(as.matrix(x) + 0.01, markers, method, verbose = FALSE) # add small pseudocount to avoid zero-errors
  x <- scoef(x)
  
  x <- data.frame(t(x))
  
  return(x)
}


bat_plot <- function(x){

  x$sample <- factor(rownames(x), levels = rev(rownames(x)))
  x <- melt(x, variable.name = 'fat', value.name = 'Proportion')
  x$fat <- factor(x$fat, levels = c('brown', 'white'), ordered = TRUE)
  
  ggplot(x, aes(sample, Proportion, fill = fat)) +
    geom_hline(yintercept = 0.5, color = 'grey60') +
    geom_col(position = position_stack(reverse = TRUE),
             color = 'grey85', width = 0.8, alpha = 0.95, lwd = 0.4) +
    scale_fill_manual(values = c('sienna4', 'snow'), guide = FALSE) +
    scale_y_continuous(breaks = seq(0, 1, 0.25), minor_breaks = seq(0, 1, 0.05),
                       expand = c(0.01,0.01),
                       labels = percent) +
    coord_flip() +
    labs(x = NULL, y = 'Brown percentage estimate') +
    theme_minimal() + 
    theme(panel.grid.major.y = element_blank())
}

