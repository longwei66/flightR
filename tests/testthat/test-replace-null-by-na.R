context("replace NULL values by NA values in a list")
library(flightR)

test_that("replaceNullByNA returns erro if null input", {
        expect_error(replaceNullByNA(x = NULL),
                     'list input is required',
                     fixed = TRUE)
})
test_that("getAEairports raise error if both airport code and country code are provided", {
        expect_identical(replaceNullByNA(list("ab", "bc", NULL, "de")), list("ab", "bc", NA, "de"))
})