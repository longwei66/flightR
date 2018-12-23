#' getArrivalsByAirportOSN
#' 
#' A function to get all arrival flights in a specific airport in a given time
#' interval - call to Opensky Network API
#' 
#' Retrieve flights for a certain airport which arrived within a given time 
#' interval (begin, end). If no flights are found for the given period, 
#' HTTP stats 404 - Not found is returned with an empty response body.

#'
#' @param icao.code ICAO code of the airport 
#' @param from.time Start of time interval to retrieve flights as "YYYY-MM-DD HH:MM:SS"
#' @param to.time End of time interval to retrieve flights as "YYYY-MM-DD HH:MM:SS"
#' @param login 
#' @param password 
#'
#' @seealso https://www.world-airport-codes.com/
#' @seealso https://opensky-network.org/apidoc/rest.html#arrivals-by-airport
#' 
#' @import httr
#' @return The response is a JSON array of flights where each flight is an object with properties
#' 
#' @export
#'
#' @examples getArrivalsByAirportOSN(iata.code = "LFPG", from.time = "2018-01-29 00:00:00", to.time = "2018-01-29 01:00:00", login = "login", password = "my pasword")
getArrivalsByAirportOSN <- function(icao.code="JFK",
									from.time,
									to.time,
									login,
									password){
    
	## Define aviation-edge API URL
    url.base <- paste0("https://",login,":",password,"@opensky-network.org/api/flights/arrival?")
    url.airport <- paste0("airport=",iata.code)
    url.from.time <- paste0("&begin=",as.integer(as.POSIXct(from.time)))
    url.to.time <- paste0("&end=",as.integer(as.POSIXct(to.time)))
    
    url <- paste0(url.base, url.airport, url.from.time, url.to.time)
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
