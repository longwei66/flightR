context("Set Vector Names")
library(flightR)

test_that("setVectorName raise error for bounding box if one coord is missing 1", {
    expect_equal(setVectorName(x = list(1,2,3,4), names = c("a","b","c","d")),
                 list( "a" = 1, "b" = 2, "c" = 3, "d" = 4))
})
