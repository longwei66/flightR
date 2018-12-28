context("get Track by aircraft from OpenSky Network API")
library(flightR)

test_that("getOSNtrackByAircraft raise error if icao.24 is null", {
    expect_error(getOSNtrackByAircraft(login = "a login", password = "a password", icao24 = NULL),
                 '"icao24" cannot be NULL, value restricted to ICAO 24-bit address of the transponder in hex string representation. All letters need to be lower case"',
                 fixed = TRUE)
})
test_that("getOSNtrackByAircraft handle null input for 'password' or 'login' parameter", {
  expect_error(getOSNtrackByAircraft(login = NULL, password = NULL),
               'Valid "login" and/or "password" are required',
               fixed = TRUE)
})



