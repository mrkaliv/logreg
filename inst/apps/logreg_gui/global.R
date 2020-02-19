library(shiny)
library(shinythemes)

#install.packages(c('shinythemes'))

# Data pre-processing ----
# Tweak the "am" variable to have nicer factor labels -- since this doesn't rely on any user inputs, we can do this once at startup and then use the value throughout the lifetime of the app
mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))
# Captures the column headers for use as an expression
dataHeaders <- colnames(mtcars)