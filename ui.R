shinyUI(
  navbarPage(
    'BATLAS webtool', theme = shinytheme("sandstone"),
    
    tabPanel(
      "Analysis ", icon = icon('bar-chart'),
      
      fluidPage(
        
        fluidRow(
          #verbatimTextOutput('debug'),
          
          includeMarkdown("data/intro.md"),

          column(3,
                 
                 fixedRow(
                   
                   
                   conditionalPanel(
                     condition = "values.status != 'OK'",
                     htmlOutput('status')
                   ),
                   
                   fileInput("userdata", "Load expression data:"),
                   
                   hr(),
                   
                   div(HTML('<a href="https://raw.githubusercontent.com/piresn/BATLAS/master/data/mouseRPKM.txt" download>
                            Download example dataset</a>'))
                   
                   ### Optional: let user select different methods. Need to then call input$method on calc_proportions function
                   # tags$hr(),
                   # selectInput('method', 'Method', choices = c('DSA', 'ssKL', 'ssFrobenius', 'meanProfile'))
                 )
          ),
          
          ##############################################################
          ##############################################################
          
          column(9, align = 'center',

                 withSpinner(plotOutput('plot', width = '80%'), type = 5),
                 
                 hr(),
                 
                 div(DT::dataTableOutput('table', width = '70%'),
                     style = "font-size:90%; padding:40px;")
          )
        )
      )
    ),
    
    ##############################################################
    ##############################################################
    
    tabPanel('Help', #icon = icon('life-saver'),
             includeMarkdown("data/help.md")
    ),
    
    tags$footer(HTML('<a href="http://www.tnb.ethz.ch/" target="_blank" style = "color:darkgray;">Wolfrum lab - ETH Zürich</a>  | 2018'),
                align = "center",
                style = "position: relative;
                line-height: 20px;
                font-size:12px;
                margin-bottom:10px;
                margin-color: white;
                background-color: white;
                color:darkgray;
                width:100%;")
  )
)