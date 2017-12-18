shinyServer(function(input, output, session) {
  
  
  values <- reactiveValues(dataset = NULL,
                           species = NULL,
                           debug = 'None')
  
  
  ### User data validation
  observeEvent(input$userdata,{
    
    file_upload <- input$userdata
    
    a1 <- NULL; try(a1 <- read.table(file_upload$datapath, sep="\t", header=T, row.names=1))
    
    values$debug <- colnames(a1)
    
    if(!is.null(a1)){
      all_human_ok <- all(unlist(markers.list[['human']]) %in% rownames(a1))
      all_mouse_ok <- all(unlist(markers.list[['mouse']]) %in% rownames(a1))
      
      if(all_human_ok | all_mouse_ok){
        values$dataset <- a1
        
        if(all_human_ok){ values$species <- 'human'} else{ values$species <- 'mouse' }
        
      }
    }
  })
  
  ### Download example
  output$downloadExample <- downloadHandler(filename = 'mouse_example.txt',
                                            content = function(file){file.copy('data/RPKM_319.txt', file)})

  
  ### Plot
  
  output$empty <- renderUI({
    
    if(is.null(values$dataset)) {
      
      HTML('<p style="text-align:center; padding-top:30px; color:silver;">Load a file with mouse or human RPKMs.</p>')
      
      }
    
  })
  
  output$plot <- renderPlot({
    
    if(!is.null(values$dataset)){
      
      results <- calc_proportions(values$dataset, markers.list[[values$species]])
      
      barplot(results, horiz = TRUE, las = 2)
      
    } else{}
    
  })
  
  output$debug <- renderPrint({
    values$debug
  })
  
  
})