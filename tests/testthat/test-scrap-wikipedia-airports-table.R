context("scrap airport table from wikipedia")
library(flightR)

test_that("scrapWikipediaAirportsTable raise error if no url provided", {
    expect_error(scrapWikipediaAirportsTable(url = NULL),
                 'A wikipedia url is required',
                 fixed = TRUE)
})
test_that("scrapWikipediaAirportsTable return correct value for test url : https://en.wikipedia.org/wiki/List_of_airports_by_IATA_code:_A", {
  expect_identical(scrapWikipediaAirportsTable(url = 'https://en.wikipedia.org/wiki/List_of_airports_by_IATA_code:_A')[277, `Airport name`],"Ted Stevens Anchorage International Airport")
})