# Define server logic to plot various variables against mpg ----
server <- function(input, output) {
  
  # Compute the formula text ----
  # This is in a reactive expression since it is shared by multiple outputs
  formulaText <- reactive({
    paste(c(colnames(Test_Data)[1], "~", paste(c(input$variable), collapse = " + ") ), sep="")
  })

  # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    formulaText()
  })

  rv <- reactiveValues(out_put = NULL)
  
  # Enables button action and output of datatable...data and newData
    observeEvent(input$gobutton, {   

      # Making datatable for the variables that I selected
      Test_Data_Small <- data.frame(Test_Data[, as.character(c(input$variable))])
      colnames(Test_Data_Small) <- as.character(c(input$variable))
      # This is the output for shiny, I don't necessarily need to show this.  Can comment out later.
      output$small_data <- DT::renderDataTable(DT::datatable(Test_Data_Small))
      
          
      # Loop through columns
      dfs <- cbind(Transition = Test_Data[["Transition"]], Test_Data_Small)
      mylogit <- glm(Transition ~ . , data = dfs, family = "binomial")
      modelLLR <- logLik(mylogit)[1]
      rv$out_put <- matrix(ncol=2, nrow=ncol(Test_Data))
      # initiate secondary (numerical) iteration for the for loop.
      j <- 1
      for(i in names(Test_Data)) {
        # provides a True/False of if the colname is in my dataframe.
        # __OLD CODE__ indx <- grepl(i, colnames(Test_Data_Small))
        indx <- grepl(i, colnames(dfs))
        # isTrue evaluates a statement and if it's not True, outputs False.  When a colname is not in the dataframe, I'm getting a logical zero, so this overcomes the if error.
        # combining indx with the dataframe colname pulls out the colname that is True.
        # __OLD CODE__ if (isTRUE(i == colnames(Test_Data_Small)[indx])) {
        if (isTRUE(i == colnames(dfs)[indx])) {
          # ___PLACEHOLDER___ setting the gStat to zero as a PLACEHOLDER until I can figure out a better response.
          gStat <- 0
          rv$out_put[j,1] <- i
          rv$out_put[j,2] <- gStat
          j <- j+1
        }
        else {
          # __OLD CODE__ var_formula = paste(my_formula, " + ", i)
          
          dfsi <- cbind(i = Test_Data[[i]], dfs)
          
          # var_formula = paste(c(formulaText, " + ", i))
          # __OLD CODE__ varlogit <- glm(var_formula, data = Test_Data, family = "binomial")
          
          varlogit <- glm(Transition ~ . , data = dfsi, family = "binomial")
          
          varLLR <- logLik(varlogit)[1]
          gStat <- -2 * (modelLLR - varLLR)
          rv$out_put[j,1] <- i
          rv$out_put[j,2] <- gStat
          j <- j+1
        }
      } # ends for loop for i in names(Test_Data)
    })  # ends observeEvent for gobutton
    
      output$newData <- DT::renderDataTable({ DT::datatable(rv$out_put) })

}
