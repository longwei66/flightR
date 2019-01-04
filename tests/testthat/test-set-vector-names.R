context("Set Vector Names")
library(flightR)

test_that("setVectorName return correct data on test values ", {
    expect_equal(setVectorName(x = list(1,2,3,4), names = c("a","b","c","d")),
                 list( "a" = 1, "b" = 2, "c" = 3, "d" = 4))
})



test_that("setVectorName return error if input is not list of vector ", {
        expect_error(setVectorName(x = iris, names = iris),
                     'names & x must be vectors or lists',
                     fixed = TRUE)
})

test_that("setVectorName return error if names argument is missing", {
        expect_error(setVectorName(x = list(1,2,3), names = NULL),
                     'argument names must be provided',
                     fixed = TRUE)
})