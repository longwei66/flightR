#' getFlightSchedulesTimetables
#' 
#' A function to get timetables of all flights departing or arrivingin a
#' specific airport.
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
#' @examples getFlightSchedulesTimetables(iata.code = "LIS", type = "arrival", api.key = "key.here)
getFlightSchedulesTimetables <- function(iata.code="JFK",
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
