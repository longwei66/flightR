#' @title getAEcities
#' 
#' @description 
#' A function to get cities information from Aviation Edge API. As stated on 
#' aviation-edge.com, this cities database contains all cities in the world 
#' with their aviation and travel related data. 
#' 
#' \strong{Available API Options}
#' 
#' \itemize{
#'    \item The entire database of cities, i.e. get all cities in one shot,
#'    this represents ~XXk+ items worldwide (with free API)
#'    \item Information for a specific cityt using it's IATA Code.
#'    \item All cities in a specific country using country code (Iso).
#' }
#'
#' @param city.iata.code IATA code of the airport 
#' @param country.iso.code ISO code of the country (eg. DE)
#' @param api.key you authentication api key
#'
#' @seealso https://www.iata.org/publications/Pages/code-search.aspx
#' @seealso https://aviation-edge.com/developers/
#' 
#' @import httr
#' @return answer a json object containing airports information details
#' \itemize{
#'         \item "cityId": "1",
#'         \item "nameCity": "Anaa",
#'         \item "codeIataCity": "AAA", 
#'         \item "codeIso2Country": "PF", 
#'         \item "latitudeCity": "-17.05", 
#'         \item "longitudeCity": "-145.41667", 
#'         \item "timezone": "Pacific/Tahiti", 
#'         \item "GMT": "-10", 
#'         \item "geonameId": "0" 
#'       } 
#'
#' @examples 
#' 
#' Details about Anaa city
#' \dontrun{ 
#' getAEcities(city.iata.code = 'AAA ',
#'               country.iso.code = NULL,
#'               api.key = 'key.here') 
#' }
#' 
#' All cities in France
#' \dontrun{
#' getAEcities(city.iata.code = NULL,
#'               country.iso.code = 'FR',
#'               api.key = 'key.here')
#' }
#' 
#' All cities
#' \dontrun{
#' getAEcities(city.iata.code = NULL,
#'               country.iso.code = NULL,
#'               api.key = 'key.here')
#' }
#' 
getAEcities <- function(city.iata.code = NULL,
                        country.iso.code = NULL,
                        api.key){
    
    ## Test if API key is provided
    if(is.null(api.key)){
        stop('API "key" is required')
    } else {
        ## Define aviation-edge API URL
        url.base <- paste0("https://aviation-edge.com/v2/public/cityDatabase?key=",api.key)    
    }
    
    ## Test if both country code & city code are provided
    if(!is.null(city.iata.code) & !is.null(country.iso.code)){
        stop('City code and Country code cannot be provided at the same time')
    }
    
    ## Test if both country code & city code are NOT provided
    if(is.null(city.iata.code) & is.null(country.iso.code)){
        url <- url.base
    }
    
    ## If city Code is provided
    if(!is.null(city.iata.code)){
        url.city.iata.code <- paste0("&codeIataCity=",airport.iata.code)    
        url <- paste0(url.base, url.city.iata.code)
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
