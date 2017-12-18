shinyServer(function(input, output, session) {
  
  
  values <- reactiveValues(dataset = NULL,
                           species = NULL,
                           status = '',
                           results = NULL,
                           debug = 'None')
  
  
  ### User data validation
  observeEvent(input$userdata,{
    
    values$dataset <- NULL
    
    val <- validation(input$userdata)
    
    values$status <- val$status
    if(val$status == 'OK'){
      values$dataset <- val$dataset
      values$species <- val$species
      values$results <- NULL
    }
  })
  
  
  output$status <- renderUI({
    
    if(is.null(values$dataset)) {
      
      HTML(paste0('<p style="color:red; padding-top:1px;">',
                  values$status,
                  '</p>'))
    }
  })
  
  
  ### Download example
  output$downloadExample <- downloadHandler(filename = 'mouse_example.txt',
                                            content = function(file){file.copy('data/RPKM_319.txt', file)})
  
  
  
  output$plot <- renderPlot({
    
    if(!is.null(values$dataset)){
      
      values$results <- calc_proportions(x = values$dataset,
                                         markers = markers.list[[values$species]],
                                         method = 'DSA')
      
      plot(bat_plot(values$results))
      
    }
  })
  
  
  output$table <- DT::renderDataTable({
    
    out <- NULL
    try(out <- round(values$results, 3))
    cbind(sample = rownames(out), out)
  },
  options = list(searching = FALSE), rownames = FALSE)#,
  #digits = 3, spacing = 'xs',
  #hover = TRUE, rownames = TRUE)
  
  
  output$debug <- renderPrint({
    head(values$results)
  })
  
  
})