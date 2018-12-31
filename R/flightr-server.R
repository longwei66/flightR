#' Shiny app server function
#'
#' details to be written here after
#'
#' @import shiny
#' @import DT
#' @import ggplot2
#' @import plotly
#' @param input provided by shiny
#' @param output provided by shiny


flightRserver <- function(input, output, session) {
        
        ## ---------------------------------------------------------------------
        ##      Main functions
        ## ---------------------------------------------------------------------

        ## Module server part of scatterplot ui
        ## callModule()
        message(ae.api.key)
        
        getAEkey <- reactive({return(ae.api.key)})
        
        
        ## ---------------------------------------------------------------------
        ##      Generate output$
        ## ---------------------------------------------------------------------
        ## Generate Feature list
        output$myTimeTableList <- DT::renderDataTable({
                ## -- all current flights to Lisbone
                flights.to.lis <- getAEtimetables(iata.code = "LIS", type = "arrival", api.key = getAEkey())
                report.to.lis <- data.table::rbindlist(lapply(flights.to.lis, AEmakeTimetableItemOverview))
        }, options = list(scrollX = TRUE)
        )
        
}