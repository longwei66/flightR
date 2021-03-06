% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/airports.R
\docType{data}
\name{airports}
\alias{airports}
\title{a list airports worldwide}
\format{A data frame with 8983 rows and 12 variables:
\describe{
  \item{airport.iata}{chr - IATA code of the airport, such as CDG}
  \item{airport.icao}{chr - ICAO code of the airport, such as LFPG}
  \item{airport.name}{chr, official name of the airport}
  \item{location.served}{chr, }
  \item{country}{chr - Full text name of the country, such as France}
  \item{airport.time}{chr - Airport local time}
  \item{airport.dst}{chr - The DST column shows the months in which Daylight
   Saving Time}
  \item{airport.wikipedia.url}{chr - Url of the wikipedia page of the airport}
  \item{longitude}{num - longitude in decimal degrees}
  \item{latitude}{num - latitude in decimal degrees}
  \item{longitude.degree}{num - longitude in degrees minutes seconds}
  \item{latitude.degree}{num - latitude in degrees minutes seconds}
}}
\source{
\url{https://en.wikipedia.org/wiki/List_of_airports_by_IATA_code}
}
\usage{
airports
}
\description{
A dataset simple reference list of all airports worldwide scrapped from
wikipedia
}
\keyword{datasets}
