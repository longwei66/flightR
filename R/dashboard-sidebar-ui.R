#' left sidebar object with all menus
#'
#' This inlcudes dataset selection
dashboard_sidebar <-  dashboardSidebar(
        width = 200,
        sidebarMenu(
                id = "mainMenu",
                menuItem(
                        "Explore Dataset",
                        tabName = "",
                        icon = icon("search"),
                        menuSubItem(
                                "Select dataset",
                                tabName = "mydataset",
                                icon = icon("folder-open")
                        ),
                        ## -- list all datasets
                        selectizeInput(
                                inputId = 'myDatasets',
                                label = NULL,
                                choices = NULL,
                                multiple = TRUE,
                                options = list(
                                        maxItems = 1)
                        )
                ),
                menuItem(
                        "version 0.0.0.9903",
                        icon = icon("info"),
                        tabName = "info")
        )
)