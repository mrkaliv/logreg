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
    
    # Input: Checkbox for whether outliers should be included ----
    checkboxInput("outliers", "Show outliers", TRUE)
    
  ),
  
  
  # Main panel for displaying outputs ----
  mainPanel(
    
    # Output: Formatted text for caption ----
    h3(textOutput("caption")),
    
    # Output: Plot of the requested variable against mpg ----
    # plotOutput("mpgPlot"),
    
    # Output: Data Frame (headers) ----
    dataTableOutput("headerData"),
    
    # Output: Data Frame (data) ----
    dataTableOutput("newData")
  )
)
