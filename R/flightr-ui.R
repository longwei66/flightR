#' flightR shinydashboard UI
#'
#' using shinydashboard layout do define the main smartexplorer interface
#'
#' @include dashboard-header-ui.R
#' @include dashboard-sidebar-ui.R
#' @include dashboard-body-ui.R
flightRui <- div(
        div(
                id = "main_content",
                dashboardPage(
                        skin = "purple",
                        # Header, sidebard and body
                        dashboard_header,
                        dashboard_sidebar,
                        dashboard_body
                )
        )
)