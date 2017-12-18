shinyServer(function(input, output, session) {
  
  
  values <- reactiveValues(dataset = NULL,
                           species = NULL,
                           status = '',
                           debug = 'None')
  
  
  ### User data validation
  observeEvent(input$userdata,{
    
    values$dataset <- NULL
    val <- validation(input$userdata)
    
    values$status <- val$status
    
    if(val$status == 'OK'){
      values$dataset <- val$dataset
      values$species <- val$species
    }
  })
  
  ### Download example
  output$downloadExample <- downloadHandler(filename = 'mouse_example.txt',
                                            content = function(file){file.copy('data/RPKM_319.txt', file)})
  
  
  ### Plot
  
  output$status <- renderUI({

    if(is.null(values$dataset)) {

      HTML(paste0('<p style="color:red; padding-top:1px;">',
                    values$status,
                    '</p>'))
    }
  })
  
  # observeEvent(values$status, {
  #   if(values$status!='OK'){
  #     #shinyjs::info("Thank you!")
  #     #showModal(modalDialog('bla'))
  #     showNotification(values$status, duration = NULL, type = 'error')
  #   }
  # })

  output$plot <- renderPlot({
    
    if(!is.null(values$dataset)){
      
      results <- calc_proportions(values$dataset, markers.list[[values$species]])
      
      barplot(results, horiz = TRUE, las = 2)
      
    } else{}
    
  })
  
  output$debug <- renderPrint({
    values$status
  })
  
  
})