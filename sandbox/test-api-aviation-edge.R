## -- example
source('./conf/aviation-edge.R')


## -- all current flights to Lisbone
flights.to.lis <- getAEtimetables(iata.code = "LIS", type = "arrival", api.key = aviation.edge.api.key)
report.to.lis <- data.table::rbindlist(lapply(flights.to.lis, AEmakeTimetableItemOverview))

## -- all current flights from Lisbone
flights.from.lis <- getAEtimetables(iata.code = "LIS", type = "departure", api.key = aviation.edge.api.key)
report.from.lis <- data.table::rbindlist(lapply(flights.from.lis, AEmakeTimetableItemOverview))

## -- get all flights to belo
flights.to.belo <- getAEtimetables(iata.code = "CNF", type = "arrival", api.key = aviation.edge.api.key)
report.to.belo <- data.table::rbindlist(lapply(flights.to.belo, AEmakeTimetableItemOverview))

## -- get all flights from belo
flights.from.belo <- getAEtimetables(iata.code = "CNF", type = "departure", api.key = aviation.edge.api.key)
report.from.belo <- data.table::rbindlist(lapply(flights.from.belo, AEmakeTimetableItemOverview))

## -- get all flights to belo
flights.to.cdg <- getAEtimetables(iata.code = "CDG", type = "arrival", api.key = aviation.edge.api.key)
report.to.cdg <- data.table::rbindlist(lapply(flights.to.cdg, AEmakeTimetableItemOverview))

## -- make a summary 
sample.flight <- report.to.lis[status == "active", flight.iata.number][2]
getAEflightTracker(flightIata=sample.flight,api.key = aviation.edge.api.key)

## -- 
test <- getAEflightTracker(flightIata="AF1583",api.key = aviation.edge.api.key)