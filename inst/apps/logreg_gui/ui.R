# Define UI for logistics regression app ----
ui <- pageWithSidebar(
  
  # App title ----
  headerPanel("Step-Wise Logistic Regression"),
  
  # Sidebar panel for inputs ----
  sidebarPanel(
    
    # Action Button: Process the variables
    actionButton("gobutton","Start"),
    
    # Input: Selector for variable to plot against mpg ----
    checkboxGroupInput("variable", "Variables:", dataHeaders[-1]),
  ), # end sidebarPanel
  
  # Main panel for displaying outputs ----
  mainPanel(
    
    # Output: Formatted text for caption ----
    h3(textOutput("caption")),
    
    # Output: Data Frame (data) ----
    DT::dataTableOutput("newData"),
    
    # Ouput: Test Test_Data_Small -- will delete later (make sure to get rid of comma above)
    # DT::dataTableOutput("small_data")
    
    ) # end mainPanel
  
) # end pagewithSidebar
