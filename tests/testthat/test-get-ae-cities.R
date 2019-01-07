context("get All cities from Aviation Edge API")
library(flightR)

test_that("getAEcities raise error if no api key", {
    expect_error(getAEcities(api.key = NULL),
                 'API "key" is required',
                 fixed = TRUE)
})
test_that("getAEcities raise error if both city code and country code are provided", {
  expect_error(getAEcities(api.key = "a key", city.iata.code = "code", country.iso.code = "code"),
               'City code and Country code cannot be provided at the same time',
               fixed = TRUE)
})