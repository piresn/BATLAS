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
  
  ### test if all species gene annotations are ok
  spp <- val_gene_annotations(userfile)
  if(spp == 'unknown'){
    out$status <- 'Invalid gene names.'
    return(out)
  }
  
  ### test if all values are numeric
  if(!all(apply(userfile, 1, is.numeric))){
    out$status <- 'Invalid expression values (must be numeric, use dots as decimal separators).'
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
# test <- list(datapath = '~/Desktop/mouse_example2.txt')
# test_res <- validation(test)
# str(test_res)
# 
# test2 <- read.table(test$datapath, sep="\t", header=T, row.names=1)
