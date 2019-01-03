#' @title getAEairports
#' 
#' @description 
#' A function to get airport information from Aviation Edge API. As stated on 
#' aviation-edge.com, this world airport database contains detailed data on "every
#' airport, including private and public airports, airstrips, helipads, seaports
#' and much more".
#' 
#' \strong{Available API Options}
#' 
#' \itemize{
#'    \item The entire database of airports, i.e. get all airports in one shot,
#'    this represents ~10k+ items worldwide (with free API)
#'    \item Information for a specific airport using it's IATA Code.
#'    \item All airports for a specific country using country code (Iso).
#' }
#'
#' @param airport.iata.code IATA code of the airport 
#' @param country.iso.code ISO code of the country (eg. DE)
#' @param api.key you authentication api key
#'
#' @seealso https://www.iata.org/publications/Pages/code-search.aspx
#' 
#' @import httr
#' @return answer a json object containing airports information details
#' \itemize{
#'         \item "airportId": "7", 
#'         \item "nameAirport": "Aachen/Merzbruck", 
#'         \item "codeIataAirport": "AAH", 
#'         \item "codeIcaoAirport": "EDKA", 
#'         \item "latitudeAirport": "50.75", 
#'         \item "longitudeAirport": "6.133333", 
#'         \item "geonameId": "3247449", 
#'         \item "timezone": "Europe/Berlin", 
#'         \item "GMT": "1", 
#'         \item "phone": "", 
#'         \item "nameCountry": "Germany", 
#'         \item "codeIso2Country": "DE", 
#'         \item "codeIataCity": "AAH" 
#'       } 
#' @export
#'
#' @examples 
#' 
#' Details about Lisbon (LIS) airport
#' \dontrun{ 
#' getAEairports(airport.iata.code = 'LIS',
#'               country.iso.code = NULL,
#'               api.key = 'key.here') 
#' }
#' 
#' All airports in France
#' \dontrun{
#' getAEairports(airport.iata.code = NULL,
#'               country.iso.code = 'FR',
#'               api.key = 'key.here')
#' }
#' 
#' All airports
#' \dontrun{
#' getAEairports(airport.iata.code = NULL,
#'               country.iso.code = NULL,
#'               api.key = 'key.here')
#' }
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
        
        ## -- replace NULL values by NA Values
        answer <- lapply(answer, replaceNullByNA) 
        
    } else {
        answer <- NULL
    }
    return(answer)
}
