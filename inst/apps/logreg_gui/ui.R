# Define UI for logistics regression app ----
ui <- pageWithSidebar(
  
  # App title ----
  headerPanel("Logistics Regression"),
  
  # Sidebar panel for inputs ----
  sidebarPanel(
    
    # Action Button: Process the variables
    actionButton("gobutton","Start"),
    
    # Input: Selector for variable to plot against mpg ----
    checkboxGroupInput("variable", "Variables:", dataHeaders),
  ), # end sidebarPanel
  
  # Main panel for displaying outputs ----
  mainPanel(
    
    # Output: Formatted text for caption ----
    h3(textOutput("caption")),
    
    # Output: Data Frame (headers) ----
    dataTableOutput("headerData"),
    
    # Output: Data Frame (data) ----
    dataTableOutput("newData")
  ) # end mainPanel
  
) # end pagewithSidebar
