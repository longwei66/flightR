## -- example
source('./conf/aviation-edge.R')

flights.to.lis <- getFlightSchedulesTimetables(iata.code = "LIS", type = "arrival", api.key = aviation.edge.api.key)
report.to.lis <- data.table::rbindlist(lapply(flights.to.lis, makeTimetableItemOverview))

flights.from.lis <- getFlightSchedulesTimetables(iata.code = "LIS", type = "departure", api.key = aviation.edge.api.key)
report.from.lis <- data.table::rbindlist(lapply(flights.from.lis, makeTimetableItemOverview))

flights.to.belo <- getFlightSchedulesTimetables(iata.code = "CNF", type = "arrival", api.key = aviation.edge.api.key)
report.to.belo <- data.table::rbindlist(lapply(flights.to.belo, makeTimetableItemOverview))

flights.from.belo <- getFlightSchedulesTimetables(iata.code = "CNF", type = "departure", api.key = aviation.edge.api.key)
report.from.belo <- data.table::rbindlist(lapply(flights.from.belo, makeTimetableItemOverview))


flights.from.sh <- getFlightSchedulesTimetables(iata.code = "PVG", type = "departure", api.key = aviation.edge.api.key)
report.from.sh <- data.table::rbindlist(lapply(flights.from.sh, makeTimetableItemOverview))

sample.flight <- report.to.lis[status == "active", flight.iata.number][2]
getFlightTracker(flightIata=sample.flight,api.key = aviation.edge.api.key)