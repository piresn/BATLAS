validation <- function(x){
  
  out <- list()
  
  a1 <- NULL; try(a1 <- read.table(x$datapath, sep="\t", header=T, row.names=1))

  if(!is.null(a1)){
    all_human_ok <- all(unlist(markers.list[['human']]) %in% rownames(a1))
    all_mouse_ok <- all(unlist(markers.list[['mouse']]) %in% rownames(a1))
    
    if(all_human_ok | all_mouse_ok){
      
      out$status <- 'OK'
      out$dataset <- a1
      
      if(all_human_ok){ out$species <- 'human'} else{ out$species <- 'mouse' }
      
    } else{ out$status <- 'Invalid gene names.'}
  } else{ out$status <- 'Invalid file.'}
  
  return(out)
}