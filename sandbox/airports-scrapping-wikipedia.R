## =============================================================================
##
##              Web Scrapping of Airport Data
##              -------------------------------------------
##
##              to support flightR package
##
##
## =============================================================================
devtools::load_all()


## =============================================================================
## [1] Get airports list
## =============================================================================

## -- source uri configuration
airport.lists.base.url <- "https://en.wikipedia.org/wiki/List_of_airports_by_IATA_code:_"
airport.lists.url <- paste0(airport.lists.base.url,LETTERS)

## test on one page
test <- scrapWikipediaAirportsTable(airport.lists.url[2])

## get all pages
all.airports <- rbindlist(lapply(airport.lists.url, scrapWikipediaAirportsTable), fill = TRUE)

## =============================================================================
## [1] Get airports details
## =============================================================================

## -- test on one airport
url <- test[8, airport.wikipedia.url]
scrapWikipediaAirportsDetails(url = url)

## -- test on one airport table page
all.airports.geo <- lapply(all.airports[, airport.wikipedia.url], scrapWikipediaAirportsDetails)
all.airports.geo <- data.table::rbindlist(all.airports.geo)

## -- add geo location to all.aiports
airports <- cbind(all.airports, all.airports.geo)
save(airports, file = "./data/airports.Rda")


