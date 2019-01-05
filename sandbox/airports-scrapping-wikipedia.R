## =============================================================================
##
##              Web Scrapping of Airport Data
##              -------------------------------------------
##
##              to support flightR package
##
##
## =============================================================================


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
url <- test[8, url]
scrapWikipediaAirportsDetails(url = url)

## -- test on one airport table page
all.airports.geo <- lapply(all.airports[, url], scrapWikipediaAirportsDetails)
all.airports.geo <- data.table::rbindlist(all.airports.geo)

## -- add geo location to all.aiports
all.airports <- cbind(all.airports, all.airports.geo)
all.airports[  , Country := gsub(pattern = "^(.*),[1-9]{0,1} (.*)$", replacement = "\\2", x = `Location served`) ]
