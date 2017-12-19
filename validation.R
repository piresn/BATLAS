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
  
  
  ### test if file could be imported using read.table
  if(is.null(userfile)){
    out$status <- 'Invalid file.'
    return(out)
  }
  
  ### test if gene names are in ensembl format
  if(length(grep('ENS.+\\d{11}', rownames(userfile), perl = TRUE)) < nrow(userfile)){
    out$status <- 'Gene names (first column) must be in ENSEMBL format (E.g. ENSG00000109424).'
    return(out)
  }
  
  ### test if all species gene annotations are ok
  spp <- val_gene_annotations(userfile)
  if(spp == 'unknown'){
    out$status <- 'Incomplete gene list: there are not enough genes available to determine brown content.'
    return(out)
  }
  
  ### test if all values are numeric
  if(!all(apply(userfile, 1, is.numeric))){
    out$status <- 'Invalid expression values: (they must be numeric and use dots as decimal separators).'
    return(out)
  }
  
  
  ### test if there are missing values
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


#####################################
test <- list(datapath = '~/Desktop/mouse_example2.txt')
test_res <- validation(test)
str(test_res)

test2 <- read.table(test$datapath, sep="\t", header=T, row.names=1)
