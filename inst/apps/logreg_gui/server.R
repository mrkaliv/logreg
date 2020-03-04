# Define server logic to plot various variables against mpg ----
server <- function(input, output) {
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by the output$caption and output$mpgPlot functions
  formulaText <- reactive({
    paste(c("Variables ~", input$variable), collapse = " + ")
  })
  
  # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })

  # formulaText_code <- reactive({
  #   paste(c(input$variable), collapse = " + ")
  # })
  # formulaText_code <- reactive({
  #      paste(c("GDP + FT5Y"))
  #    })
  
  rv <- reactiveValues(out_put = NULL)
  
  # Enables button action and output of datatable...data and newData
  # https://stackoverflow.com/questions/46521026/r-shiny-action-button-and-data-table-output
  # buttonData <- eventReactive(input$gobutton,{
  #   if(is.null( Test_Data[c(input$variable)] )){
  #     return()
#    }
    
    observeEvent(input$gobutton, {   
    
      
      # Making smaller datatable based on items checked
      # Formerly Test_Data_Small in R sample code
      # df <- data.frame(input$variable)
      # output$df <- DT::renderDataTable({df})
      
      small_dt <- DT::datatable(Test_Data[, as.character(c(input$variable))], rownames = F)
      # This is the output for shiny, I don't necessarily need to show this.  Can comment out later.
      output$small_data <- DT::renderDataTable(small_dt)
      
      # small_data <- eventReactive(input$gobutton,{
      #   if(is.null(input$variable)){
      #     return()
      #   }})
      
      # Loop through columns
      # ___TEST VALUES___ this forumla has some PLACEHOLDER values for testing still in it.
      my_formula <- paste(colnames(Test_Data_Small)[1], " ~ GDP + IMR")
      #my_formula <- paste(colnames(Test_Data_Small)[1], " ~ ", input$variable)
      mylogit <- glm(my_formula, data = Test_Data, family = "binomial")
      modelLLR <- logLik(mylogit)[1]
      rv$out_put <- matrix(ncol=2, nrow=ncol(Test_Data))
      # initiate secondary (numerical) iteration for the for loop.
      j <- 1
      for(i in names(Test_Data)) {
        # provides a True/False of if the colname is in my dataframe.
        indx <- grepl(i, colnames(Test_Data_Small))
        # isTrue evaluates a statement and if it's not True, outputs False.  When a colname is not in the dataframe, I'm getting a logical zero, so this overcomes the if error.
        # combining indx with the dataframe colname pulls out the colname that is True.
        if (isTRUE(i == colnames(Test_Data_Small)[indx])) {
          # ___PLACEHOLDER___ setting the gStat to zero as a PLACEHOLDER until I can figure out a better response.
          gStat <- 0
          rv$out_put[j,1] <- i
          rv$out_put[j,2] <- gStat
          j <- j+1
        }
        else {
          var_formula = paste(my_formula, " + ", i)
          varlogit <- glm(var_formula, data = Test_Data, family = "binomial")
          varLLR <- logLik(varlogit)[1]
          gStat <- -2 * (modelLLR - varLLR)
          rv$out_put[j,1] <- i
          rv$out_put[j,2] <- gStat
          j <- j+1
        }
      } # ends for loop for i in names(Test_Data)
    })    
      output$newData <- DT::renderDataTable({


      #buttonData()
      DT::datatable(rv$out_put)
      
      }) # ends buttonData function

    
#  })
  
  # This is where Test_Data_Small is generated...now called newData

  
}