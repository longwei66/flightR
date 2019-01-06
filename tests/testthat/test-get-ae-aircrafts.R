context("get All aircrafts from Aviation Edge API")
library(flightR)

test_that("getAEaircrafts raise error if no api key", {
    expect_error(getAEaircrafts(api.key = NULL),
                 'API "key" is required',
                 fixed = TRUE)
})
test_that("getAEaircrafts raise error if both registration number and hex ICA code are provided AND/OR Airline IATA code 1/3", {
  expect_error(getAEaircrafts(api.key = "a key",
                             aircraft.registration.number = "number",
                             aircraft.hex.icao = "ICAO"),
               'Only one of the three filters should be applied : aircraft.registration.number, aircraft.hex.icao, airline.iata',
               fixed = TRUE)
})
test_that("getAEaircrafts raise error if both registration number and hex ICA code are provided AND/OR Airline IATA code 2/3", {
        expect_error(getAEaircrafts(api.key = "a key",
                                   aircraft.registration.number = "number",
                                   airline.iata = "IATA"),
                     'Only one of the three filters should be applied : aircraft.registration.number, aircraft.hex.icao, airline.iata',
                     fixed = TRUE)
})
test_that("getAEaircrafts raise error if both registration number and hex ICA code are provided AND/OR Airline IATA code 3/3", {
        expect_error(getAEaircrafts(api.key = "a key",
                                   aircraft.hex.icao = "ICAO",
                                   airline.iata = "IATA"),
                     'Only one of the three filters should be applied : aircraft.registration.number, aircraft.hex.icao, airline.iata',
                     fixed = TRUE)
})
