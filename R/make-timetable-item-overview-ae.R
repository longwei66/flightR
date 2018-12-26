#' makeTimetableItemOverviewAE
#' 
#' A function which takes an airport timetable item (see getFlightSchedulesTimetables)
#' and returnd a list containing the flight main metadata
#'
#' @param timetable.item a list containing the airport timetable item (one flight) 
#'
#' @seealso \code{\link{getTimetablesAE}}
#' @return a list with main details of that file
#' @export
#'
#' @examples 
#' \dontrun{
#' makeTimetableOverview(timetable)
#' }
makeTimetableItemOverviewAE <- function(timetable.item = NULL){
    ## a simple function to replace a value by NA if NULL
    quickCheck <- function(x){ if(is.null(x)){ return(NA) } else { return(x) } }
    
    ## Return data 
    if(is.null(timetable.item)){
        item <- NULL
    } else {
        item <-
            list(
                "airliner" = timetable.item$airline$name,
                "airliner.iata.code" = timetable.item$airline$iataCode,
                "flight.iata.number" = timetable.item$flight$iataNumber,
                "from.iata.code" = timetable.item$departure$iataCode,
                "from.scheduled.time" = quickCheck(timetable.item$departure$scheduledTime),
                "from.estimated.time" = quickCheck(timetable.item$departure$estimatedTime),
                "from.actual.time" = quickCheck(timetable.item$departure$actualTime),
                "to.iata.code" = timetable.item$arrival$iataCode,
                "to.scheduled.time" = quickCheck(timetable.item$arrival$scheduledTime),
                "to.estimated.time" = quickCheck(timetable.item$arrival$estimatedTime),
                "to.actual.time" = quickCheck(timetable.item$arrival$actualTime),
                "departure.delay" = quickCheck(timetable.item$departure$delay),
                "type" = timetable.item$type,
                "status" = timetable.item$status,
                "arrival.delay" = quickCheck(timetable.item$arrival$delay)
            )
    }
    
    return(item)
}
