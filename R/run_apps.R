#' @title Shiny Apps Loader
#' @description This will run the shiny applications in this project. \cr
#'              As a reminder, the applications should be in quotes.  Example: run_apps("logreg_gui") \cr
#'              See details for descriptions of the various apps.
#' @export
#' @importFrom utils View
#' @importFrom shiny shinyAppDir
#' @details Application: "logreg_gui". \cr
#'          Logreg_gui is a step-wise logistic regression model.  A user may choose various variables to include in the model and the app will provide you with the G-Statistic for each response.  The variable with the highest G-Statistic will provide the most information for your model. \cr
#'          At this time, the structure of the data requires that the response be in column (1) with the column name "Transition".
#' 
run_apps <- 
  function(app_name = NULL, 
           theme = 'flatly',
           width = '100%',
           height = '800px',
           more_opts = list(NA),
           launch.browser = TRUE,...)
  {
    
    valid_apps <- list.files(system.file("apps", package = "logreg"))
    
    valid_apps_df <- data.frame(valid_apps)
    colnames(valid_apps_df) <- 'Valid Apps'
    
    if (missing(app_name) || !nzchar(app_name) || !app_name %in% valid_apps) {
      
      stop(paste0('Please run `logreg()` with a valid app as an argument.\n',
                  "See table for Valid Apps"),
           utils::View(valid_apps_df),
           call. = FALSE)
    }
    
    
    dir <- system.file('apps', app_name, package = 'logreg')
    
    shiny::shinyAppDir(appDir = dir, 
                       options = list(height = height, 
                                      width = width,
                                      launch.browser = launch.browser,...))
    
  }