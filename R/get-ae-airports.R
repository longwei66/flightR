#' getAEairports
#' 
#' A function to get airport information from Aviation Edge API
#' 
#' \strong{The entire database of airports}
#' The entire data base of airports can be downloaded
#' 
#' \strong{Information for a specific airport}
#' For a designated airport, the data can be downloaded using it's IATA Code.
#' 
#' \strong{All airports for a specific country}
#' Using country code (Iso), all airports from this country can be retrieved
#'
#' @param airport.iata.code IATA code of the airport 
#' @param country.iso.code ISO code of the country (eg. DE)
#' @param api.key you authentication api key
#'
#' @seealso https://www.iata.org/publications/Pages/code-search.aspx
#' 
#' @import httr
#' @return answer a json object containing airports information details
#' @export
#'
#' @examples \dontrun{ getAEairports(airport.iata.code = "LIS", country.iso.code = NUL, api.key = "key.here) }
#' 
getAEairports <- function(airport.iata.code = NULL,
                          country.iso.code = NULL,
                          api.key){
    
    ## Test if API key is provided
    if(is.null(api.key)){
        stop('API "key" is required')
    } else {
        ## Define aviation-edge API URL
        url.base <- paste0("https://aviation-edge.com/v2/public/airportDatabase?key=",api.key)    
    }
    
    ## Test if both country code & airport code are provided
    if(!is.null(airport.iata.code) & !is.null(country.iso.code)){
        stop('Airport code and Country code cannot be provided at the same time')
    }
    
    ## Test if both country code & airport code are NOT provided
    if(is.null(airport.iata.code) & is.null(country.iso.code)){
        url <- url.base
    }
    
    ## If Airport Code is provided
    if(!is.null(airport.iata.code)){
        url.airport.iata.code <- paste0("&codeIataAirport=",airport.iata.code)    
        url <- paste0(url.base, url.airport.iata.code)
    }
    ## If Country Code is provided
    if(!is.null(country.iso.code)){
        url.country.iso.code <- paste0("&codeIso2Country=",country.iso.code)
        url <- paste0(url.base, url.country.iso.code)
    }
    message(url)
    
    ## GET request
    request <- GET(url)
    stop_for_status(request)
    if(status_code(request) == 200){
        answer <- content(request, "parsed", "application/json", encoding="UTF-8")
    } else {
        answer <- NULL
    }
    return(answer)
}
