#' launches the flightR shiny app
#' 
#' This function launches a shiny app which enables exploration of aviation
#' data collected by the flightR package. (to be continued with details of 
#' features)
#'
#' @param ae.api.key a valid Aviation Edge API Key
#' @param osn.login a valid OpenSky Network login
#' @param osn.login a valid OpenSky Network password
#' @param ...
#'
#' @return shiny application object
#' @export flightR
#'
#' @import shiny
#' @import shinydashboard
#' @import shinyjs
#' 
#' @include flightr-ui.R
#' @include flightr-server.R
#'
#' @examples flightR::flightR()
flightR <- function(ae.api.key = NULL, osn.login = NULL, osn.password = NULL, ...) {
        
        ## get from global context
        assign("ae.api.key",ae.api.key,.GlobalEnv)
        
        ## Create shiny app
        app <-  shinyApp(
                ui = flightRui,
                server = flightRserver
        )
        ## choose to return the app instead of launching it directly
        ## this at least can be covered in unit testing
        ##runApp(app, ...)
        return(app)
}