#' getFlightTracker
#' 
#' A function to get information about all flights in the world with 
#' 
#' \strong{Flight Tracker API}
#' Clients can connect to the flight tracking through the API key which gives 
#' direct access to all the live flight data. The flight tracker API allows 
#' clients to display within their applications or on their websites and other 
#' platforms, the actual tracking of flights including all their relevant 
#' information. This service is central to our aviation data and maintained
#' constantly within our database. Since the data is live, the updates happen 
#' within short intervals of just a few minutes. Aviation Edge’s function is 
#' to gather and maintain the complete aviation data for our clients so that 
#' they can create the functional tools for their customers.
#'  
#' \strong{Sources and process}
#' The data of the flight tracking API is collected through ADS-B systems as
#' well as the use of flight schedules to anticipate the location and fill in
#' the gaps where needed. We also receive data from our aviation partners and 
#' combine all this to the central system for our clients.
#' 
#' \strong{Data included in the Flight Tracker API}
#' Geography: Location information such as latitude, longitude, altitude and direction.
#' Speed: Vertical and horizontal speed of aircraft.
#' Departure and arrival: IATA codes and ICAO codes of the departure and arrival location.
#' Aircraft and flight: IATA and ICAO number of flight and registration number, ICAO code and ICAO24 code of aircraft.
#' Airline: IATA code and ICAO code of airline.
#' System information: Squawk, status and last updated.
#'
#' @param api.key you authentication api key
#' @param depIata Departure airport IATAcode
#' @param depIcao Departure airport ICAO code
#' @param arrIata Arrival airport IATA code
#' @param arrIcao Arrival airport ICAO code
#' @param aircraftIcao Aircraft ICAO code
#' @param regNum Aircraft registration number
#' @param aircraftIcao24 Aircraft ICAO24 code
#' @param airlineIata Airline IATA code
#' @param airlineIcao Airline ICAO code
#' @param flightIata Flight IATA code
#' @param flightIcao Flight ICAO code
#' @param flightNum Flight number
#' @param status Status of the flight (en-route, landed)
#' @param limit Limit value for output
#'
#' @seealso https://www.iata.org/publications/Pages/code-search.aspx
#' 
#' @import httr
#' @return answer a json object containing flights list with status and details
#' @export
#'
#' @examples getFlightSchedulesTimetables(iata.code = "LIS", type = "arrival", api.key = "key.here)
getFlightTracker <- function(
    depIata= NULL,# Departure airport IATAcode
    depIcao= NULL,# Departure airport ICAO code
    arrIata= NULL,# Arrival airport IATA code
    arrIcao= NULL,# Arrival airport ICAO code
    aircraftIcao= NULL,# Aircraft ICAO code
    regNum= NULL,# Aircraft registration number
    aircraftIcao24= NULL,# Aircraft ICAO24 code
    airlineIata= NULL,# Airline IATA code
    airlineIcao= NULL,# Airline ICAO code
    flightIata= NULL,# Flight IATA code
    flightIcao= NULL,# Flight ICAO code
    flightNum= NULL,# Flight number
    status= NULL,# Status of the flight (en-route, landed)
    limit= NULL,# Limit value for output
    api.key){
    
    checkAndPaste <- function(x,y){
        if( is.null(x)){
            return(NULL) 
        } else { 
            paste0("&",y,"=",x)}
    }
    
    ## Define aviation-edge API URL
    url.base <- "http://aviation-edge.com/v2/public/flights?"
    url.param <- paste0(
        "key=",api.key,
        checkAndPaste(depIata,"depIata"),
        checkAndPaste(depIcao,"depIcao"),
        checkAndPaste(arrIata,"arrIata"),
        checkAndPaste(arrIcao,"arrIcao"),
        checkAndPaste(aircraftIcao,"aircraftIcao"),
        checkAndPaste(regNum,"regNum"),
        checkAndPaste(aircraftIcao24,"aircraftIcao24"),
        checkAndPaste(airlineIata,"airlineIata"),
        checkAndPaste(airlineIcao,"airlineIcao"),
        checkAndPaste(flightIata,"flightIata"),
        checkAndPaste(flightIcao,"flightIcao"),
        checkAndPaste(flightNum,"flightNum"),
        checkAndPaste(status,"status"),
        checkAndPaste(limit,"limit")
    )
    url <- paste0(url.base, url.param)
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
