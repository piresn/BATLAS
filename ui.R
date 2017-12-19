shinyUI(
  navbarPage(
    'Brown fat cell deconvolution', theme = shinytheme("lumen"),
    
    tabPanel(
      "Analysis",
      
      fluidPage(
        
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
                   
                   downloadLink("downloadExample", "Download an example dataset", icon = icon('file'))
                   
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
      )
    ),
    
    ##############################################################
    ##############################################################
    
    tabPanel('Help',
             includeMarkdown("data/help.md")
    ),
    
    tags$footer(HTML('<a href="http://www.tnb.ethz.ch/" target="_blank" style = "color:grey;">Wolfrum lab - ETH Zürich</a>  | 2018'),
                align = "right",
                style = "position:absolute;
                bottom:0;
                font-size:12px;
                padding:10px;
                color:grey;
                width:50%;")
  )
)