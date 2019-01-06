context("get All airlines from Aviation Edge API")
library(flightR)

test_that("getAEairlines raise error if no api key", {
    expect_error(getAEairlines(api.key = NULL),
                 'API "key" is required',
                 fixed = TRUE)
})
test_that("getAEairlines raise error if both airline IATA code and country code are provided", {
  expect_error(getAEairlines(api.key = "a key", airline.iata.code = "code", country.iso.code = "code"),
               'Airline code and Country code cannot be provided at the same time',
               fixed = TRUE)
})