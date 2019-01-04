context("convert geo location in degree minutes seconds to decimal degree")
library(flightR)

test_that("dms2dd return correct value for standard input", {
        expect_true(compare(dms2dd("50°38′01″E"),50.63361, tolerance = 0.001)$equal)
})
test_that("dms2dd return correct value for standard input", {
        expect_true(compare(dms2dd("50°38′01″W"),-50.63361, tolerance = 0.001)$equal)
})