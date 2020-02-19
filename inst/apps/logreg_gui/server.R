# Define server logic to plot various variables against mpg ----
server <- function(input, output) {
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by the output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste(c("mpg ~", input$variable), collapse = " + ")
  })
  
  # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot of the requested variable against mpg ----
  # and only exclude outliers if requested
  # output$mpgPlot <- renderPlot({
  #   boxplot(as.formula(formulaText()),
  #           data = mpgData,
  #           outline = input$outliers,
  #           col = "#75AADB", pch = 19)
    
    # Return a new dataset with just the columns checked ----
    # output$newData <- renderTable({data.frame(mtcars[c(input$variable)])})

  # Transpose headers to record variable data
  output$headerData <- renderDataTable({ data.frame( dataHeaders )
  })
  
  
  
  
  # Enables button action and output of datatable...data and newData
  # https://stackoverflow.com/questions/46521026/r-shiny-action-button-and-data-table-output
  buttonData <- eventReactive(input$gobutton,{
    if(is.null( mtcars[c(input$variable)] )){
      return()
    }
    
    df <- data.frame( mtcars[c(input$variable)] )
    df
  })
  
  output$newData <- renderDataTable({
    buttonData()
  })

  
  # })
  
}