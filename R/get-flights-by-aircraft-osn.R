#' getFlightsByAircraftOSN
#' 
#' Documentation from OpenSky Network API
#' This API call retrieves flights for a particular aircraft within a certain 
#' time interval. Resulting flights departed and arrived within (begin, end)
#' If no flights are found for the given period, HTTP stats 404 - Not found is
#' returned with an empty response body.
#'
#'
#' @param icao24 Unique ICAO 24-bit address of the transponder in hex string representation. All letters need to be lower case 
#' @param begin.time as "YYYY-MM-DD HH:MM:SS", Start of time interval to retrieve flights
#' @param end.time as "YYYY-MM-DD HH:MM:SS", End of time interval to retrieve flights
#' @param login osn valid login
#' @param password osn valid password
#'
#' @seealso https://opensky-network.org/apidoc/rest.html#flights-by-aircraft
#' 
#' @import httr
#' @import anytime
#' @return The response is a JSON array of flights where each flight is an object with properties:
#' 
#' @export
#'
#' @examples 
#' \dontrun{
#' getFlightsByAircraftOSN(icao24 = "3c666b",
#'                        from.time = "2018-01-29 00:00:00",
#'                        to.time = "2018-01-29 01:00:00",
#'                        login = "login",
#'                        password = "my pasword")
getFlightsByAircraftOSN <- function(icao24 = NULL,
                                    from.time = NULL,
                                    to.time = NULL,
                                    login = NULL,
                                    password = NULL){
        
        ## Test if login & password are provided
        if(is.null(login) | is.null(password)){
                stop('Valid "login" and/or "password" are required')
        }
        
        
        ## Test if icao24 is null
        if(is.null(icao24)){
                stop('"icao24" cannot be NULL, value restricted to ICAO 24-bit address of the transponder in hex string representation. All letters need to be lower case"')
        }
        
        ## Define OpenSky API URL
        url.base <- paste0("https://",login,":",password,"@opensky-network.org/api//flights/aircraft?")
                

        url.icao24 <- paste0("icao24=",icao24)
        url.time <- paste0("&begin=",as.integer(as.POSIXct(from.time)),"&end=",as.integer(as.POSIXct(to.time)))

        
        url <- paste0(url.base, url.icao24, url.time)
        message(url)
                
        ## GET request
        request <- GET(url)
        stop_for_status(request)
        if(status_code(request) == 200){
                answer <- content(request, "parsed", "application/json", encoding="UTF-8")
        } else {
                answer <- NULL
        }
        
        ## -- replace NULL values by NA Values
        answer <- lapply(answer, replaceNullByNA)         
        
        ## -- a function to fix dates
        fixTime <- function(x){
                x$firstSeen <- anytime(x$firstSeen)
                x$lastSeen <- anytime(x$lastSeen)
                return(x)
        }
        answer <- lapply(answer, fixTime)         
        

        return(answer)
}
