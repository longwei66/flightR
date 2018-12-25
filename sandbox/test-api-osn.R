## Get the credentials
source('./conf/api-osn-credential.R')

## Test API for get Arrivals by Airports
## Example with Charles de Gaulle Airport
LFPG.1 <- getArrivalsByAirportOSN(icao.code = "LFPG",
                                from.time = "2018-01-29 00:00:00",
                                to.time = "2018-01-29 01:00:00",
                                login = my.osn.login,
                                password = my.osn.password)

LFPG.2 <- getArrivalsByAirportOSN(icao.code = "LFPG",
                                  from.time = "2018-12-24 00:00:00",
                                  to.time = "2018-12-24 01:00:00",
                                  login = my.osn.login,
                                  password = my.osn.password)