context("get Flights By Airport from OpenSky Network")
library(flightR)

test_that("getFlightsByAirportOSN handle NULL input for 'type' parameter", {
    expect_error(getFlightsByAirportOSN(type = NULL, login = "a login", password = "a password"),
                 '"type" cannot be NULL, value restricted to "arrival" or "departure"',
                 fixed = TRUE)
})
test_that("getFlightsByAirportOSN handle non null incorrect input for 'type' parameter", {
  expect_error(getFlightsByAirportOSN(type = "not a correct value", login = "a login", password = "a password"),
               'Invalid "type", value restricted to "arrival" or "departure"',
               fixed = TRUE)
})
test_that("getFlightsByAirportOSN handle null input for 'password' or 'login' parameter", {
  expect_error(getFlightsByAirportOSN(login = NULL, password = NULL),
               'Valid "login" and/or "password" are required',
               fixed = TRUE)
})



