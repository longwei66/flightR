## Get the credentials
source('./conf/api-osn-credential.R')

## Test API for get Arrivals by Airports
## Example with Charles de Gaulle Airport
LFPG.1 <- getFlightsByAirportOSN(icao.code = "LFPG",
                                 type = "arrival",
                                 from.time = "2018-01-29 00:00:00",
                                 to.time = "2018-01-29 01:00:00",
                                 login = my.osn.login,
                                 password = my.osn.password)

LFPG.2 <- getFlightsByAirportOSN(icao.code = "LFPG",
                                 type = "departure",
                                 from.time = "2018-12-24 20:00:00",
                                 to.time = "2018-12-24 21:00:00",
                                 login = my.osn.login,
                                 password = my.osn.password)

## Get all planes in a bounding box around Paris
bbox1 <- getAllStateVectorsOSN(latitude.min = 43, longitude.min = -3,
                               latitude.max = 50, longitude.max = 9,
                               login = my.osn.login, password = my.osn.password)

myFlight <- getTrackByAircraftOSN(icao24 = '4b1809', time = 0, login = my.osn.login, password = my.osn.password)

a <- data.table::rbindlist(myFlight$path)
g <- ggplot(data = a)
g <- g + geom_path(aes(x = latitude, y = longitude))
g