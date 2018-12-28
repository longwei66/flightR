context("get Flights By Airport from OpenSky Network")
library(flightR)

test_that("getOSNflightsByAirport handle NULL input for 'type' parameter", {
    expect_error(getOSNflightsByAirport(type = NULL, login = "a login", password = "a password"),
                 '"type" cannot be NULL, value restricted to "arrival" or "departure"',
                 fixed = TRUE)
})
test_that("getOSNflightsByAirport handle non null incorrect input for 'type' parameter", {
  expect_error(getOSNflightsByAirport(type = "not a correct value", login = "a login", password = "a password"),
               'Invalid "type", value restricted to "arrival" or "departure"',
               fixed = TRUE)
})
test_that("getOSNflightsByAirport handle null input for 'password' or 'login' parameter", {
  expect_error(getOSNflightsByAirport(login = NULL, password = NULL),
               'Valid "login" and/or "password" are required',
               fixed = TRUE)
})



