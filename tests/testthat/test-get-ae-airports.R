context("get All airports from Aviation Edge API")
library(flightR)

test_that("getAEairports raise error if no api key", {
    expect_error(getAEairports(api.key = NULL),
                 'API "key" is required',
                 fixed = TRUE)
})
test_that("getAEairports raise error if both airport code and country code are provided", {
  expect_error(getAEairports(api.key = "a key", airport.iata.code = "code", country.iso.code = "code"),
               'Airport code and Country code cannot be provided at the same time',
               fixed = TRUE)
})