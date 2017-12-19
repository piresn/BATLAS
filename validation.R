val_gene_annotations <- function(x){
  
  all_human_ok <- all(unlist(markers.list[['human']]) %in% rownames(x))
  all_mouse_ok <- all(unlist(markers.list[['mouse']]) %in% rownames(x))
  
  if(all_mouse_ok){ out <- 'mouse'
  } else if(all_human_ok){ out <- 'human'
  } else{ out <- 'unknown'}
  
  return(out)
}

########################################

validation <- function(x){
  
  out <- list()
  
  userfile <- NULL; try(userfile <- read.table(x$datapath, sep="\t", header=T, row.names=1))
  
  
  ### check if file could be imported using read.table
  if(is.null(userfile)){
    out$status <- 'Invalid file. RPKM values must be given as a tab-delimited file, with sample names on the first row and gene IDs in the first column.'
    return(out)
  }
  
  ### check if gene names are in ensembl format
  if(length(grep('ENS.+\\d{11}', rownames(userfile), perl = TRUE)) < nrow(userfile)){
    out$status <- 'Gene names (first column) must be in ENSEMBL format (E.g. ENSG00000109424).'
    return(out)
  }
  

  ### check if all required gene annotations are ok (and determine species)
  spp <- val_gene_annotations(userfile)
  if(spp == 'unknown'){
    out$status <- 'Incomplete gene list: there are not enough genes available to determine brown content.'
    return(out)
  }
  
  ### check if all values are numeric
  if(!all(apply(userfile, 1, is.numeric))){
    out$status <- 'Invalid expression values: (they must be numeric and use dots as decimal separators).'
    return(out)
  }
  
  
  ### check if there are missing values
  if(sum(apply(userfile, 1, is.na)) > 0) {
    out$status <- 'Invalid input file: missing expression values.'
    return(out)
  }
  
  ##### userfile appears to be ok
  
  out$status <- 'OK'
  out$dataset <- userfile
  out$species <- spp
  
  return(out)
}
