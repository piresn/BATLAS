shinyUI(
  navbarPage(
    'Deconvolution app', theme = shinytheme("lumen"),
    
    tabPanel(
      "Analysis",
      
      fluidRow(
        #shinythemes::themeSelector(),
        #verbatimTextOutput('debug'),
        
        column(3,
               
               fixedRow(
                 
                 conditionalPanel(
                   condition = "values.status != 'OK'",
                   htmlOutput('status')
                 ),
                 
                 fileInput("userdata", "Load expression data:"),

                 downloadLink("downloadExample", "Download an example", icon('file'))
                 
                 ### Optional: let user select different methods. Need to then call input$method on calc_proportions function
                 # tags$hr(),
                 # selectInput('method', 'Method', choices = c('DSA', 'ssKL', 'ssFrobenius', 'meanProfile'))
               )
        ),
        
        ##############################################################
        ##############################################################
        column(9,
               
               withSpinner(plotOutput('plot'), type = 5),
               
               div(DT::dataTableOutput('table', width = '50%'),
                   style = "font-size:80%; padding-top:80px;")
        )
      )
    ),
    
    ##############################################################
    ##############################################################
    
    tabPanel('Help',
             includeMarkdown("data/help.md")
    )
  )
)