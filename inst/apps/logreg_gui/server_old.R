server <- function(input, output, session)
{
  # data to react to
  mydata <- reactive({mtcars})
  
  
  # choose columns to display
  output$myheaders <- renderTable({mtcars[, c("mpg", input$show_vars) ,drop=FALSE]}, colnames = TRUE)

}