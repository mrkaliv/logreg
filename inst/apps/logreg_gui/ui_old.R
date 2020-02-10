ui <- navbarPage('',
                 theme = shinythemes::shinytheme('cerulean'),
                 tabPanel(title = 'Variable Selection',
                          fluidPage(title = 'Logistic Regression Tool',
                                    theme = NULL,
                                    sidebarLayout(
                                      sidebarPanel(width = 4,
                                                   checkboxGroupInput("show_vars", "Variables:", c("Cylinders" = "cyl", "Transmission" = "am", "Gears" = "gear")),
                                                   tableOutput("myheaders")
                                                   ),
                                      mainPanel(width = 4,
                                                tableOutput("myheaders"))
                                                  )
                                    )
                          ),
                 
                 tabPanel('Nothing',
                          fluidPage(
                            mainPanel(width = 12,
                                      DT::dataTableOutput('myheaders'))))
               )
