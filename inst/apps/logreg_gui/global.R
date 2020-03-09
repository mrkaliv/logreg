library(shiny)
library(shinythemes)
library(logreg)
#install.packages(c('shinythemes'))

data("Test_Data", package = "logreg")
#data("Test_Data_Small", package = "logreg")

# Data pre-processing ----

# Captures the column headers for use as an expression
dataHeaders <- colnames(Test_Data)