#' getOSNallStateVectors
#' 
#' A function to get all available details of flights by plane icao transponder adress
#' at a specific time - call to Opensky Network API.
#' 
#' Limitations for anonymous (unauthenticated) users can only get the most recent
#' state vectors, i.e. the time parameter will be ignored.
#' Anonymous users can only retrieve data with a time resultion of 10 seconds.
#' That means, the API will return state vectors for time now−(now mod 10).
#' This annonymous mode is not implemented in this function
#' 
#' Limitations for OpenSky users
#' OpenSky users can retrieve data of up to 1 hour in the past.
#' If the time parameter has a value t<now−3600 the API will return 400 Bad Request.
#' OpenSky users can retrieve data with a time resultion of 5 seconds.
#' That means, if the time parameter was set to t, the API will return state vectors
#' for time t−(t mod 5).
#'  
#' 
#' @param icao24 character vector, one or more ICAO24 transponder addresses (e.g. "abc9f3")
#' @param time character, to retrieve flights vector as "YYYY-MM-DD HH:MM:SS"
#' @param latitude.min numeric, lower bound for the latitude in decimal degrees (optional)
#' @param longitude.min numeric, lower bound for the longitude in decimal degrees
#' @param latitude.max numeric, upper bound for the latitude in decimal degrees
#' @param longitude.max numeric, upper bound for the longitude in decimal degrees
#' @param login OSN login information
#' @param password OSN password information associated to the login provided
#'
#' @seealso https://opensky-network.org/apidoc/rest.html#all-state-vectors
#' @seealso https://en.wikipedia.org/wiki/Aviation_transponder_interrogation_modes#ICAO_24-bit_address
#' 
#' @import httr
#' @return The response is a JSON array of flights where each flight is an object with properties
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' getOSNallStateVectors(icao24 = NULL,
#'                       time = "2018-01-29 00:00:00",
#'                       login = "login",
#'                       password = "my pasword")
#' }
getOSNallStateVectors <- function(icao24 = NULL,
                                  time = NULL,
                                  latitude.min = NULL,
                                  longitude.min = NULL,
                                  latitude.max = NULL,
                                  longitude.max = NULL,
                                  login = NULL,
                                  password = NULL){
        
        ## Test if login & password are provided
        if(is.null(login) | is.null(password)){
                stop('Valid "login" and/or "password" are required')
        }
        
        ## Test that if bounding box is provided all coordinnates are not NULL
        bboxallnull <- is.null(latitude.min) & is.null(longitude.min) & is.null(latitude.max) & is.null(longitude.max)
        oneoffbboxnull <- is.null(latitude.min) | is.null(longitude.min) | is.null(latitude.max) | is.null(longitude.max)
        
        if(!(bboxallnull) & (oneoffbboxnull)){
                stop('All 4 coordinnates must be provided for a valid bounding box')
        }
        
        ## Define OpenSky API URL
        url.base <- paste0("https://",login,":",password,"@opensky-network.org/api/states/all?")
        
        ## get icao24 flight defined
        if(!is.null(icao24)){
                url.icao24 <- paste0("icao24=", icao24, collapse = "&")
        } else {
                url.icao24 <- ""
        }
        ## -- if time parameter is missing, use current system time
        if(!is.null(time)){
                url.time <- paste0("&time=",as.integer(as.POSIXct(time)))
        } else {
                url.time <- paste0("&time=",as.integer(as.POSIXct(Sys.time())))
        }
        
        ## -- design url.bounding depending on if all null or not
        if(bboxallnull){
                url.bounding <- ""
        } else {
                url.bounding <- paste0(
                        "&lamin=",latitude.min,
                        "&lomin=",longitude.min,
                        "&lamax=",latitude.max,
                        "&lomax=",longitude.max
                )        
        }
        
        url <- paste0(url.base, url.icao24, url.time, url.bounding)
        message(url)
        
        ## GET request
        request <- GET(url)
        stop_for_status(request)
        if(status_code(request) == 200){
                answer <- content(request, "parsed", "application/json", encoding="UTF-8")
        } else {
                answer <- NULL
        }
        ## -- answer is a list containing two elements, time and states (all flights)
        
        
        ## -- answer of the API does not give labels on data
        ## -- usine documentation online to set right names.
        names.vector <- c(
                "icao24", # string Unique ICAO 24-bit address of the transponder in hex string representation.
                "callsign" , # string Callsign of the vehicle (8 chars). Can be null if no callsign has been received.
                "origin_country", # string Country name inferred from the ICAO 24-bit address.
                "time_position", # int Unix timestamp (seconds) for the last position update. Can be null if no position report was received by OpenSky within the past 15s.
                "last_contact", # int Unix timestamp (seconds) for the last update in general. This field is updated for any new, valid message received from the transponder.
                "longitude", # float WGS-84 longitude in decimal degrees. Can be null.
                "latitude", # float WGS-84 latitude in decimal degrees. Can be null.
                "baro_altitude", # float Barometric altitude in meters. Can be null.
                "on_ground", #boolean Boolean value which indicates if the position was retrieved from a surface position report.
                "velocity", # float Velocity over ground in m/s. Can be null.
                "true_track", # float True track in decimal degrees clockwise from north (north=0°). Can be null.
                "vertical_rate", # float Vertical rate in m/s. A positive value indicates that the airplane is climbing, a negative value indicates that it descends. Can be null.
                "sensors", #int[] IDs of the receivers which contributed to this state vector. Is null if no filtering for sensor was used in the request.
                "geo_altitude", #float Geometric altitude in meters. Can be null.
                "squawk", # string The transponder code aka Squawk. Can be null.
                "spi", # boolean Whether flight status indicates special purpose indicator.
                "position_source" # int Origin of this state’s position: 0 = ADS-B, 1 = ASTERIX, 2 = MLAT
        )
        ## -- function to set names, run it on all items
        answer$states <- lapply(answer$states, setVectorName, names = names.vector)        

        ## -- replace NULL values by NA Values
        answer$states <- lapply(answer$states, replaceNullByNA)        
        
        
        return(answer)
}
