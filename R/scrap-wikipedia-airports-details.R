#' scrapWikipediaAirportsDetails
#'
#' @param url an airport wikipedia ura
#'
#' @return list of airport details
#' @import XML
#' @import rvest
#'
#' @examples
#' scrapWikipediaAirportsDetails(url = "https://en.wikipedia.org/wiki/Bahrain_International_Airport")
scrapWikipediaAirportsDetails <- function(url){
        
        ## skip if wikipedia url is redlink or NA
        if(grepl(pattern = "redlink=1", x = url) | is.na(url)){
                message("... skip scrapping as redlink or missing")
                return(list(longitude = NA,
                            latitude = NA,
                            longitude.degree = NA,
                            latitude.degree = NA))
        } else {
                
                message(paste0("scrapping ", url))
                webpage <- url %>%
                        read_html()
                
                latitude <- webpage %>%
                        html_nodes(xpath = '//*[ @class = "latitude" ]') %>%
                        html_text()
                latitude <- latitude[1]
                longitude <- webpage %>%
                        html_nodes(xpath = '//*[ @class = "longitude" ]') %>%
                        html_text()
                longitude <- longitude[1]
                

                
                
                return(
                        list(longitude = dms2dd(longitude),
                             latitude = dms2dd(latitude),
                             longitude.degree = longitude,
                             latitude.degree = latitude
                             )
                )
        }
}