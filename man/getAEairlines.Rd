% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get-ae-airlines.R
\name{getAEairlines}
\alias{getAEairlines}
\title{getAEailines}
\usage{
getAEairlines(airline.iata.code = NULL, country.iso.code = NULL,
  api.key)
}
\arguments{
\item{airline.iata.code}{IATA code of the airport}

\item{country.iso.code}{ISO code of the country (eg. DE)}

\item{api.key}{you authentication api key}
}
\value{
answer a json object containing airports information details
\itemize{
        \item "airlineId": "1",
        \item "nameAirline": "American Airlines", 
        \item "codeIataAirline": "AA", 
        \item "iataPrefixAccounting": "1", 
        \item "codeIcaoAirline": "AAL", 
        \item "callsign": "AMERICAN", 
        \item "type": "scheduled", 
        \item "statusAirline": "active", 
        \item "sizeAirline": "963", 
        \item "ageFleet": "10.9", 
        \item "founding": "1934", 
        \item "codeHub": "DFW", 
        \item "nameCountry": "United States", 
        \item "codeIso2Country": "US" 
      }
}
\description{
A function to get airlines information from Aviation Edge API. As stated on 
aviation-edge.com, this is a complete database of all the airlines in the
world, especially Interesting if used in combination with other AE API
solutions such as the flight tracker.

\strong{Available API Options}

\itemize{
   \item The entire database of airlines, i.e. get all airlines in one shot,
   this represents ~13k+ items worldwide (with free API)
   \item Information about a specific airline by IATA airline code.
   \item All airlines for a specific country using country code (Iso).
}
}
\examples{

The entire airlines database
\dontrun{ 
getAEairlines( api.key = 'key.here') 
}

Information about AA airlines
\dontrun{
getAEairlines(airline.iata.code = "AA", api.key = 'key.here')
}

All airlines in France
\dontrun{
getAEairlines(airline.iata.code = NULL,country.iso.code = "FR",api.key = 'key.here')
}

}
\seealso{
https://www.iata.org/publications/Pages/code-search.aspx
}
