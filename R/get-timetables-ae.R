#' getTimetablesAE
#' 
#' A function to get timetables of all flights departing or arrivingin a
#' specific airport.
#' 
#' \strong{Flight schedules and Timetables API}
#' The API service provides the flight schedules and timetables of all airports 
#' and airlines around the world and maintains this for the clients in a central
#' database, always accessible with the personal API key. The airport and airline
#' timetables and schedules API is one of Aviation Edge’s core features. Making
#' it easy for developers to provide their customers with actual airport departure
#' and arrival times through API on their applications or websites. Our function
#' is to gather and maintain the aviation data and format this into workable 
#' flight schedules and airport timetables for the clients so that they can focus
#' on their core business of providing this information to their customers.
#' 
#' \strong{Sources and process}
#' The flight timetables and schedules come directly from the airports and airlines 
#' when available. Another source of data is through our partnerships with other
#' data providers and aviation. The data is aggregated through dedicated software 
#' which connects us with our individual partners.
#' 
#' \strong{Data included in aviation Timetables API}
#' Status of the flight: active, scheduled, landed, cancelled, incident, diverted,
#' redirected.
#' Location: departure/arrival: Airport IATA code, ICAO code, Terminal, Gate.
#' Take-off information: delay, the scheduled, estimated and actual time on runway and that of departure/arrival.
#' Airline: Name, IATA code and ICAO code.
#' Flight: Number of Flight, IATA prefix with flight number and ICAO prefix with flight number.
#'
#' @param iata.code IATA code of the airport 
#' @param type "arrival" or "departure" timetable
#' @param api.key you authentication api key
#'
#' @seealso https://www.iata.org/publications/Pages/code-search.aspx
#' 
#' @import httr
#' @return answer a json object containing flight list with status and details. Status can be: (landed, scheduled, cancelled, active, incident, diverted, redirected, unknown)
#' @export
#'
#' @examples 
#' \dontrun{
#' getFlightSchedulesTimetables(iata.code = "LIS",
#'                              type = "arrival",
#'                              api.key = "key.here)
#' }
getTimetablesAE <- function(iata.code="JFK",
                                         type="departure", #"arrival"
                                         api.key){
    ## Define aviation-edge API URL
    url.base <- "http://aviation-edge.com/v2/public/timetable?"
    url.param <- paste0("key=",api.key,"&iataCode=",iata.code,"&type=",type)
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
