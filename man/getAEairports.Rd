% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get-ae-airports.R
\name{getAEairports}
\alias{getAEairports}
\title{getAEairports}
\usage{
getAEairports(airport.iata.code = NULL, country.iso.code = NULL,
  api.key)
}
\arguments{
\item{airport.iata.code}{IATA code of the airport}

\item{country.iso.code}{ISO code of the country (eg. DE)}

\item{api.key}{you authentication api key}
}
\value{
answer a json object containing airports information details
\itemize{
        \item "airportId": "7", 
        \item "nameAirport": "Aachen/Merzbruck", 
        \item "codeIataAirport": "AAH", 
        \item "codeIcaoAirport": "EDKA", 
        \item "latitudeAirport": "50.75", 
        \item "longitudeAirport": "6.133333", 
        \item "geonameId": "3247449", 
        \item "timezone": "Europe/Berlin", 
        \item "GMT": "1", 
        \item "phone": "", 
        \item "nameCountry": "Germany", 
        \item "codeIso2Country": "DE", 
        \item "codeIataCity": "AAH" 
      }
}
\description{
A function to get airport information from Aviation Edge API. As stated on 
aviation-edge.com, this world airport database contains detailed data on "every
airport, including private and public airports, airstrips, helipads, seaports
and much more".

\strong{Available API Options}

\itemize{
   \item The entire database of airports, i.e. get all airports in one shot,
   this represents ~10k+ items worldwide (with free API)
   \item Information for a specific airport using it's IATA Code.
   \item All airports for a specific country using country code (Iso).
}
}
\examples{

Details about Lisbon (LIS) airport
\dontrun{ 
getAEairports(airport.iata.code = 'LIS',
              country.iso.code = NULL,
              api.key = 'key.here') 
}

All airports in France
\dontrun{
getAEairports(airport.iata.code = NULL,
              country.iso.code = 'FR',
              api.key = 'key.here')
}

All airports
\dontrun{
getAEairports(airport.iata.code = NULL,
              country.iso.code = NULL,
              api.key = 'key.here')
}

}
\seealso{
https://www.iata.org/publications/Pages/code-search.aspx
}
