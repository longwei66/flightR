## -- example
source('./conf/aviation-edge.R')

flights.to.lis <- getTimetablesAE(iata.code = "LIS", type = "arrival", api.key = aviation.edge.api.key)
report.to.lis <- data.table::rbindlist(lapply(flights.to.lis, makeTimetableItemOverviewAE))

flights.from.lis <- getTimetablesAE(iata.code = "LIS", type = "departure", api.key = aviation.edge.api.key)
report.from.lis <- data.table::rbindlist(lapply(flights.from.lis, makeTimetableItemOverviewAE))

flights.to.belo <- getFlightSchedulesTimetables(iata.code = "CNF", type = "arrival", api.key = aviation.edge.api.key)
report.to.belo <- data.table::rbindlist(lapply(flights.to.belo, makeTimetableItemOverviewAE))

flights.from.belo <- getFlightSchedulesTimetables(iata.code = "CNF", type = "departure", api.key = aviation.edge.api.key)
report.from.belo <- data.table::rbindlist(lapply(flights.from.belo, makeTimetableItemOverviewAE))


flights.from.cdg <- getFlightSchedulesTimetables(iata.code = "PVG", type = "departure", api.key = aviation.edge.api.key)
report.from.cdg <- data.table::rbindlist(lapply(flights.from.cdg, makeTimetableItemOverviewAE))

sample.flight <- report.to.lis[status == "active", flight.iata.number][2]
getFlightTracker(flightIata=sample.flight,api.key = aviation.edge.api.key)