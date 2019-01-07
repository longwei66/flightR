#' @title getAEcountries
#' 
#' @description 
#' A function to get cities information from Aviation Edge API. As stated on 
#' aviation-edge.com, this countries database contains all countries and regions
#' in the world.
#' 
#' \strong{Available API Options}
#' 
#' \itemize{
#'    \item The entire database of countries, i.e. get all countries in one shot,
#'    this represents ~XXk+ items worldwide (with free API)
#'    \item Information for a specific country using it's ISO Code.
#'    \item Information for a specific country using it's name.
#' }
#'
#' @param country.iso.code ISO code of the country (eg. DE)
#' @param country.name name of the country (eg. France)
#' @param api.key you authentication api key
#'
#' @seealso https://www.iata.org/publications/Pages/code-search.aspx
#' @seealso https://aviation-edge.com/developers/
#' 
#' @import httr
#' @return answer a json object containing airports information details
#' \itemize{
#'         \item "countryId": "1", 
#'         \item "nameCountry": "Andorra", 
#'         \item "codeIso2Country": "AD", 
#'         \item "codeIso3Country": "AND", 
#'         \item "numericIso": "20", "population": "84000", 
#'         \item "capital": "Andorra la Vella", 
#'         \item "continent": "EU", 
#'         \item "nameCurrency": "Euro", 
#'         \item "codeCurrency": "EUR", 
#'         \item "codeFips": "AN", 
#'         \item "phonePrefix": "376" 
#'       } 
#'
#' @examples 
#' 
#' Details about Andorra
#' \dontrun{ 
#' getAEcountries(country.iso.code = "AD",
#'               api.key = 'key.here') 
#' }
#' \dontrun{ 
#' getAEcountries(country.name = "Andorra",
#'               api.key = 'key.here') 
#' }
#' 
#' All countries
#' \dontrun{
#' getAEcountries(country.iso.code = NULL,
#'               country.name = NULL,
#'               api.key = 'key.here')
#' }
#' 
getAEcountries <- function(country.iso.code = NULL,
                           country.name = NULL,
                           api.key){
    
    ## Test if API key is provided
    if(is.null(api.key)){
        stop('API "key" is required')
    } else {
        ## Define aviation-edge API URL
        url.base <- paste0("https://aviation-edge.com/v2/public/countryDatabase?key=",api.key)    
    }
    
    ## Test if both country code & country name are provided
    if(!is.null(country.iso.code) & !is.null(country.name)){
        stop('Country code and country name cannot be provided at the same time')
    }
    
    ## Test if both country code & city code are NOT provided
    if(is.null(country.iso.code) & is.null(country.name)){
        url <- url.base
    }
    
    ## If Country Code is provided
    if(!is.null(country.iso.code)){
        url.country.iso.code <- paste0("&codeIso2Country=",country.iso.code)
        url <- paste0(url.base, url.country.iso.code)
    }
    ## If Country Name is provided
    if(!is.null(country.name)){
        url.country.name <- paste0("&nameCountry=",country.name)
        url <- paste0(url.base, url.country.name)
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
