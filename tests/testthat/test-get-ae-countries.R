context("get All countries from Aviation Edge API")
library(flightR)

test_that("getAEcountries raise error if no api key", {
    expect_error(getAEcountries(api.key = NULL),
                 'API "key" is required',
                 fixed = TRUE)
})
test_that("getAEcountries raise error if both country code and country name are provided", {
  expect_error(getAEcountries(api.key = "a key", country.iso.code = "code", country.name = "code"),
               'Country code and country name cannot be provided at the same time',
               fixed = TRUE)
})