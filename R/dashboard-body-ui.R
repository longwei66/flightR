#' Generated the dashboard main body
#'
#' this shinydashboard object contains all the tabItems of the app
#' and uses a specific shiny module for the scatterplot interface and menus.
#'
#' @import shinydashboard
#' @import DT
#' @import plotly
#' @import ggplot2
dashboard_body <- dashboardBody(
        ## Load the different tabs
        tabItems(
                tabItem(
                        tabName = "mydataset",
                        fluidRow(
                                ## ----- Layout with tabbed boxes
                                tabBox(
                                        title = "Exploratory Analysis",
                                        width = 12,
                                        id = "tabset2",
                                        ## ----- Info & howto
                                        tabPanel(
                                                title = "How-to",
                                                icon = icon("info"),
                                                fluidRow(
                                                        column(
                                                                width = 12
                                                        )
                                                )
                                        ),
                                        ## ----- Airport TimeTable
                                        tabPanel(
                                                title = "Airport Timetable",
                                                icon = icon("th-list", lib = "glyphicon"),
                                                fluidRow(
                                                        column(
                                                                width = 12, 
                                                                DT::dataTableOutput('myTimeTableList')
                                                        )
                                                )
                                        )
                                )
                        )
                )
        )
)