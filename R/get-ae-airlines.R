#' @title getAEailines
#' 
#' @description 
#' A function to get airlines information from Aviation Edge API. As stated on 
#' aviation-edge.com, this is a complete database of all the airlines in the
#' world, especially Interesting if used in combination with other AE API
#' solutions such as the flight tracker.
#' 
#' \strong{Available API Options}
#' 
#' \itemize{
#'    \item The entire database of airlines, i.e. get all airlines in one shot,
#'    this represents ~13k+ items worldwide (with free API)
#'    \item Information about a specific airline by IATA airline code.
#'    \item All airlines for a specific country using country code (Iso).
#' }
#'
#' @param airline.iata.code IATA code of the airport 
#' @param country.iso.code ISO code of the country (eg. DE)
#' @param api.key you authentication api key
#'
#' @seealso https://www.iata.org/publications/Pages/code-search.aspx
#' 
#' @import httr
#' @return answer a json object containing airports information details
#' \itemize{
#'         \item "airlineId": "1",
#'         \item "nameAirline": "American Airlines", 
#'         \item "codeIataAirline": "AA", 
#'         \item "iataPrefixAccounting": "1", 
#'         \item "codeIcaoAirline": "AAL", 
#'         \item "callsign": "AMERICAN", 
#'         \item "type": "scheduled", 
#'         \item "statusAirline": "active", 
#'         \item "sizeAirline": "963", 
#'         \item "ageFleet": "10.9", 
#'         \item "founding": "1934", 
#'         \item "codeHub": "DFW", 
#'         \item "nameCountry": "United States", 
#'         \item "codeIso2Country": "US" 
#'       } 
#' @export
#'
#' @examples 
#' 
#' The entire airlines database
#' \dontrun{ 
#' getAEairlines( api.key = 'key.here') 
#' }
#' 
#' Information about AA airlines
#' \dontrun{
#' getAEairlines(airline.iata.code = "AA", api.key = 'key.here')
#' }
#' 
#' All airlines in France
#' \dontrun{
#' getAEairlines(airline.iata.code = NULL,country.iso.code = "FR",api.key = 'key.here')
#' }
#' 
getAEairlines <- function(airline.iata.code = NULL,
                          country.iso.code = NULL,
                          api.key){
    
    ## Test if API key is provided
    if(is.null(api.key)){
        stop('API "key" is required')
    } else {
        ## Define aviation-edge API URL
        url.base <- paste0("https://aviation-edge.com/v2/public/airlineDatabase?key=",api.key)    
    }
    
    ## Test if both country code & airline code are provided
    if(!is.null(airline.iata.code) & !is.null(country.iso.code)){
        stop('Airline code and Country code cannot be provided at the same time')
    }
    
    ## Test if both country code & airline code are NOT provided
    if(is.null(airline.iata.code) & is.null(country.iso.code)){
        url <- url.base
    }
    
    ## If Airline Code is provided
    if(!is.null(airline.iata.code)){
        url.airline.iata.code <- paste0("&codeIataAirline=",airline.iata.code)    
        url <- paste0(url.base, url.airline.iata.code)
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
        
        ## -- replace NULL values by NA Values
        answer <- lapply(answer, replaceNullByNA) 
        
    } else {
        answer <- NULL
    }
    return(answer)
}
