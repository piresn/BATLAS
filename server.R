shinyServer(function(input, output, session) {
  
  values <- reactiveValues(dataset = NULL,
                           species = NULL,
                           status = '',
                           results = NULL,
                           debug = 'None')
  
  
  ##############################################################
  # User data validation
  ##############################################################
  
  observeEvent(input$userdata,{
    
    # reset previous values
    values$dataset <- NULL
    values$species <- NULL
    values$results <- NULL
    
    # validate user input
    val <- validation(input$userdata)
    
    # update data
    values$status <- val$status
    if(val$status == 'OK'){
      values$dataset <- val$dataset
      values$species <- val$species
    }
  })
  
  
  ### Display informative error message upon invalidation user input
  
  output$status <- renderUI({
    if(is.null(values$dataset)){
      HTML(paste0('<p style="color:red; padding-top:1px;">',
                  values$status, '</p>'))
    }
  })
  
  ##############################################################
  # Plot
  ##############################################################
  output$plot <- renderPlot({
    
    if(!is.null(values$dataset)){
      
      values$results <- calc_proportions(x = values$dataset,
                                         markers = markers.list[[values$species]],
                                         method = input$method)
      
      bat_plot(values$results)
    }
  })
  
  ##############################################################
  # Table
  ##############################################################
  
  output$table <- DT::renderDataTable({
    out <- NULL
    try(out <- round(values$results, 3))
    cbind(sample = rownames(out), out)
  },
  options = list(searching = FALSE), rownames = FALSE)
  
  
  ##############################################################
  
  output$debug <- renderPrint({
    head(values$results)
  })
  
  
})