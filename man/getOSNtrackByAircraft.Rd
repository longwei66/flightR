% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get-osn-track-by-aircraft.R
\name{getOSNtrackByAircraft}
\alias{getOSNtrackByAircraft}
\title{getOSNtrackByAircraft}
\usage{
getOSNtrackByAircraft(icao24 = NULL, time = 0, login = NULL,
  password = NULL)
}
\arguments{
\item{icao24}{Unique ICAO 24-bit address of the transponder in hex string representation. All letters need to be lower case}

\item{time}{as "YYYY-MM-DD HH:MM:SS", It can be any time betwee start and end of a known flight. If time = 0, get the live track if there is any flight ongoing for the given aircraft.}

\item{login}{osn valid login}

\item{password}{osn valid password}
}
\value{
The response is a JSON array of flights where each flight is an object with properties
}
\description{
Documentation from OpenSky Network API
Retrieve the trajectory for a certain aircraft at a given time. 
The trajectory is a list of waypoints containing position, 
barometric altitude, true track and an on-ground flag.
}
\details{
In contrast to state vectors, trajectories do not contain all information we
have about the flight, but rather show the aircraft’s general movement pattern.
For this reason, waypoints are selected among available state vectors given the
following set of rules:
\enumerate{
\item The first point is set immediately after the the aircraft’s expected 
departure, or after the network received the first poisition when the aircraft
entered its reception range.
\item The last point is set right before the aircraft’s expected arrival, or 
the aircraft left the networks reception range.
\item There is a waypoint at least every 15 minutes when the aircraft is in-flight.
\item A waypoint is added if the aircraft changes its track more than 2.5°.
\item A waypoint is added if the aircraft changes altitude by more than 100m (~330ft).
\item A waypoint is added if the on-ground state changes.
}
Tracks are strongly related to flights. Internally, we compute flights and
tracks within the same processing step. As such, it may be benificial to 
retrieve a list of flights with the API methods from above, and use these 
results with the given time stamps to retrieve detailed track information.
}
\examples{
\dontrun{
getOSNtrackByAircraft(icao24 = "3c666b",
                       time = "0",
                       login = "login",
                       password = "my pasword")
}
}
\seealso{
https://opensky-network.org/apidoc/rest.html#track-by-aircraft
}
