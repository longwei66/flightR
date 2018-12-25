context("get All State Vectors from OpenSky Network API")
library(flightR)

test_that("getAllStateVectorsOSN raise error for bounding box if one coord is missing 1", {
    expect_error(getAllStateVectorsOSN(login = "a login", password = "a password", latitude.min = 2.3),
                 'All 4 coordinnates must be provided for a valid bounding box',
                 fixed = TRUE)
})
test_that("getAllStateVectorsOSN raise error for bounding box if one coord is missing 2", {
  expect_error(getAllStateVectorsOSN(login = "a login", password = "a password", longitude.min = 2.3),
               'All 4 coordinnates must be provided for a valid bounding box',
               fixed = TRUE)
})
test_that("getAllStateVectorsOSN raise error for bounding box if one coord is missing 3", {
  expect_error(getAllStateVectorsOSN(login = "a login", password = "a password", longitude.max = 2.3),
               'All 4 coordinnates must be provided for a valid bounding box',
               fixed = TRUE)
})
test_that("getAllStateVectorsOSN raise error for bounding box if one coord is missing 4", {
  expect_error(getAllStateVectorsOSN(login = "a login", password = "a password", latitude.max = 2.3),
               'All 4 coordinnates must be provided for a valid bounding box',
               fixed = TRUE)
})
test_that("getFlightsByAirportOSN handle null input for 'password' or 'login' parameter", {
  expect_error(getFlightsByAirportOSN(login = NULL, password = NULL),
               'Valid "login" and/or "password" are required',
               fixed = TRUE)
})



