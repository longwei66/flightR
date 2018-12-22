#' makeTimetableItemOverview
#' 
#' A function which takes an airport timetable item (see getFlightSchedulesTimetables)
#' and returnd a list containing the flight main metadata
#'
#' @param flight a list containing the airport timetable item (one flight) 
#'
#' @seealso \code{\link{getFlightSchedulesTimetables}}
#' @return a list with main details of that file
#' @export
#'
#' @examples makeTimetableOverview(timetable)
makeTimetableItemOverview <- function(timetable){
    ## a simple function to replace a value by NA if NULL
    quickCheck <- function(x){ if(is.null(x)){ return(NA) } else { return(x) } }
    
    ## Return data 
    return(
        list(
            "airliner" = flight$airline$name,
            "airliner" = flight$airline$iataCode,
            "flight.iata.number" = flight$flight$iataNumber,
            "from.iata.code" = flight$departure$iataCode,
            "from.scheduled.time" = quickCheck(flight$departure$scheduledTime),
            "from.estimated.time" = quickCheck(flight$departure$estimatedTime),
            "from.actual.time" = quickCheck(flight$departure$actualTime),
            "to.iata.code" = flight$arrival$iataCode,
            "to.scheduled.time" = quickCheck(flight$arrival$scheduledTime),
            "to.estimated.time" = quickCheck(flight$arrival$estimatedTime),
            "to.actual.time" = quickCheck(flight$arrival$actualTime),
            "departure.delay" = quickCheck(flight$departure$delay),
            "type" = flight$type,
            "status" = flight$status,
            "arrival.delay" = quickCheck(flight$arrival$delay)
        )
    )
}
