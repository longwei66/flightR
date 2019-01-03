## =============================================================================
##
##              Web Scrapping of Airport Data
##              -------------------------------------------
##
##              to support flightR package
##
##
## =============================================================================


## =============================================================================
##      [0] load necessary libraries & configuration
## =============================================================================

## -- Needed libraries and system configuration
library(XML)
library(rvest)
library(dplyr)
library(lubridate)
library(unpivotr)
library(purrr)


## -- source uri configuration
airport.lists.base.url <- "https://en.wikipedia.org/wiki/List_of_airports_by_IATA_code:_"
airport.lists.url <- paste0(airport.lists.base.url,LETTERS)

## -- function to get airport list table
#' getAirportsTable
#' 
#' get airport table data from wikipedia
#'
#' @param url 
#'
#' @return a data.table with IATA, ICAO, Airport name, location served, time
#' DST and wikipedia url
#' @export
#' 
#' @seealso https://en.wikipedia.org/wiki/List_of_airports_by_IATA_code:_B
#'
#' @examples
getAirportsTable <- function(url){
        message(paste0('... scrapping : ',url))
        ## Get the information in the table as a data.table
        ## -- remove the lines of separation - XX -
        result <- url %>%
                read_html() %>%
                html_nodes(xpath = '/html/body/div[3]/div[3]/div[4]/div/table') %>%
                html_table() %>% rbindlist()
        result <- result[!grepl(pattern = "-", IATA)]
        
        ## Get the links to the airport pages
        ## -- we need a function to convert missing links to NA
        ## -- this should work off the shelves in rvest but it doesn't
        ## -- use purrr instead
        zero_to_na <- function(x) { ifelse( length(x) == 0, NA, x) }
        ## -- -- get all the cells of the thirs column
        myLinks <- url %>%
                read_html() %>%
                html_nodes( xpath="/html/body/div[3]/div[3]/div[4]/div/table/tbody/*/td[3]")
        ## -- -- map to chr using function to convert 0 lenght answer to NA
        links <- map_chr(myLinks, ~zero_to_na(html_attr(html_nodes(., xpath="./a[1]"), "href")))
        
        ## add both data
        result[ , url := paste0('https://en.wikipedia.org',links)]
        
        return(result)
}

## test on one page
test <- getAirportsTable(airport.lists.url[2])


## get all pages
all.airports <- rbindlist(lapply(airport.lists.url, getAirportsTable), fill = TRUE)



