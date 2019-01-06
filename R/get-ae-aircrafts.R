#' @title getAEaircrafts
#' 
#' @description 
#' A function to get airport information from Aviation Edge API. As stated on 
#' aviation-edge.com, this api gives access to an aircraft registry in the form
#' of a database of all aircraft types
#' 
#' \strong{Available API Options}
#' 
#' \itemize{
#'    \item The entire database of aircrafts, i.e. get all aircrafts in one shot,
#'    this represents ~19k+ items (with free API)
#'    \item Information for a specific aircraft registration number.
#'    \item Information for aircrafts based on their hex ICAO code.
#'    \item All aircrafts of a specific airline, you can search based on airline IATA code.
#' }
#'
#' @param aircraft.registration.number aircraft registration number 
#' @param aircraft.hex.icao aircrafts hex ICAO code
#' @param airline.iata airline IATA code
#' @param api.key you authentication api key
#'
#' @seealso https://www.iata.org/publications/Pages/code-search.aspx
#' 
#' @import httr
#' @return answer a json object containing airports information details
#' \itemize{
#'         \item "airplaneId": "55",
#'         \item "numberRegistration": "HB-JVE", 
#'         \item "productionLine": "Fokker 28/70/100", 
#'         \item "airplaneIataType": "F28 MK0100", 
#'         \item "planeModel": "F-100", 
#'         \item "modelCode": "F100", 
#'         \item "hexIcaoAirplane": "4B19EA", 
#'         \item "codeIataPlaneShort": "100", 
#'         \item "codeIataPlaneLong": "F100", 
#'         \item "constructionNumber": "11459", 
#'         \item "numberTestRgistration": "PH-EZD", 
#'         \item "rolloutDate": "0000-00-00", 
#'         \item "firstFlight": "1993-05-31T22:00:00.000Z", 
#'         \item "deliveryDate": "1993-06-29T22:00:00.000Z", 
#'         \item "registrationDate": "2004-05-11T22:00:00.000Z", 
#'         \item "lineNumber": "", "planeSeries": "", 
#'         \item "codeIataAirline": "2L", 
#'         \item "codeIcaoAirline": "", 
#'         \item "planeOwner": "", 
#'         \item "enginesCount": "2", 
#'         \item "enginesType": "JET", 
#'         \item "planeAge": "24", 
#'         \item "planeStatus": "active", 
#'       } 
#' @export
#'
#' @examples 
#' 
#' Details about ...
#' \dontrun{ 
#' getAEaircrafts(
#'               api.key = 'key.here') 
#' }
#' 
#' 
getAEaircrafts <- function(aircraft.registration.number = NULL,
                           aircraft.hex.icao =  NULL,
                           airline.iata = NULL,
                           api.key){
    
    ## Test if API key is provided
    if(is.null(api.key)){
        stop('API "key" is required')
    } else {
        ## Define aviation-edge API URL
        url.base <- paste0("https://aviation-edge.com/v2/public/airplaneDatabase?key=",api.key)    
    }
    
    ## Test that two code are not provided at the same time
    if(sum(c(!is.null(aircraft.registration.number), 
       !is.null(aircraft.hex.icao) ,
       !is.null(airline.iata))) > 1 ){
        stop('Only one of the three filters should be applied : aircraft.registration.number, aircraft.hex.icao, airline.iata')
    }
    
    ## Test if no code is provided
    if(is.null(aircraft.registration.number) & is.null(aircraft.hex.icao) &
       is.null(airline.iata)){
        url <- url.base
    }
    
    ## If aircraft.registration.number is provided
    if(!is.null(aircraft.registration.number)){
        url.aircraft.registration.number <- paste0("&numberRegistration=",aircraft.registration.number)    
        url <- paste0(url.base, url.aircraft.registration.number)
    }
    ## If aircraft.hex.icao is provided
    if(!is.null(aircraft.hex.icao)){
        url.aircraft.hex.icao <- paste0("&hexIcaoAirplane=",aircraft.hex.icao)
        url <- paste0(url.base, url.aircraft.hex.icao)
    }
    ## If airline.iata is provided
    if(!is.null(airline.iata)){
        url.airline.iata <- paste0("&codeIataAirline=",airline.iata)
        url <- paste0(url.base, url.airline.iata)
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
