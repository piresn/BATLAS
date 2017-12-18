shinyUI(
  navbarPage(
    'Deconvolution app', theme = shinytheme("lumen"),
    
    tabPanel(
      "Analysis",
      
      fluidRow(
        #shinythemes::themeSelector(),
        verbatimTextOutput('debug'),
        
        column(3,
               
               fixedRow(
                 
                 fileInput("userdata", "Load expression data"),
                 
                 downloadLink("downloadExample", "Download an example", icon('file'))
                 
               )
        ),
        column(9,
               
               htmlOutput('empty'),
               
               withSpinner(plotOutput('plot'), type = 5)
               
        )
      )
    ),
    tabPanel('Help',
             includeMarkdown("data/help.md")
    )
  )
)