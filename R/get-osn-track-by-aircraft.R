#' getOSNtrackByAircraft
#' 
#' Documentation from OpenSky Network API
#' Retrieve the trajectory for a certain aircraft at a given time. 
#' The trajectory is a list of waypoints containing position, 
#' barometric altitude, true track and an on-ground flag.
#' 
#' In contrast to state vectors, trajectories do not contain all information we
#' have about the flight, but rather show the aircraft’s general movement pattern.
#' For this reason, waypoints are selected among available state vectors given the
#' following set of rules:
#' \enumerate{
#' \item The first point is set immediately after the the aircraft’s expected 
#' departure, or after the network received the first poisition when the aircraft
#' entered its reception range.
#' \item The last point is set right before the aircraft’s expected arrival, or 
#' the aircraft left the networks reception range.
#' \item There is a waypoint at least every 15 minutes when the aircraft is in-flight.
#' \item A waypoint is added if the aircraft changes its track more than 2.5°.
#' \item A waypoint is added if the aircraft changes altitude by more than 100m (~330ft).
#' \item A waypoint is added if the on-ground state changes.
#' }
#' Tracks are strongly related to flights. Internally, we compute flights and
#' tracks within the same processing step. As such, it may be benificial to 
#' retrieve a list of flights with the API methods from above, and use these 
#' results with the given time stamps to retrieve detailed track information.
#'
#'
#' @param icao24 Unique ICAO 24-bit address of the transponder in hex string representation. All letters need to be lower case 
#' @param time as "YYYY-MM-DD HH:MM:SS", It can be any time betwee start and end of a known flight. If time = 0, get the live track if there is any flight ongoing for the given aircraft.
#' @param login osn valid login
#' @param password osn valid password
#'
#' @seealso https://opensky-network.org/apidoc/rest.html#track-by-aircraft
#' 
#' @import httr
#' @return The response is a JSON array of flights where each flight is an object with properties
#' 
#' @export
#'
#' @examples 
#' \dontrun{
#' getOSNtrackByAircraft(icao24 = "3c666b",
#'                        time = 0",
#'                        login = "login",
#'                        password = "my pasword")
getOSNtrackByAircraft <- function(icao24 = NULL,
                                  time = 0,
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
        url.base <- paste0("https://",login,":",password,"@opensky-network.org/api/tracks/all?")
        
        
        url.icao24 <- paste0("icao24=",icao24)
        if(time == 0) {
                url.time <- "&time=0"
        } else {
                url.time <- paste0("&time=",as.integer(as.POSIXct(time)))
        }
        
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
        
        
        
        ## -- answer of the API does not give labels on data
        ## -- using documentation online to set right names.
        names.vector <- c(
                "time", # integer Time which the given waypoint is associated with in seconds since epoch (Unix time).
                "latitude", # float WGS-84 latitude in decimal degrees. Can be null.
                "longitude", # float WGS-84 longitude in decimal degrees. Can be null.
                "baro_altitude", # float Barometric altitude in meters. Can be null.
                "true_track", # float True track in decimal degrees clockwise from north (north=0°). Can be null.
                "on_ground" # boolean Boolean value which indicates if the position was retrieved from a surface position report.
        )
        
        ## -- function to set names, run it on all items
        answer$path <- lapply(answer$path, setVectorName, names = names.vector)    
        
        
        
        
        return(answer)
}
