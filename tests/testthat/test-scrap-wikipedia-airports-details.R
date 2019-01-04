context("scrap wikipedia airport details")
library(flightR)

test_that("scrapWikipediaAirportsDetails return NA values for redlink input", {
    expect_identical(scrapWikipediaAirportsDetails(url = "https://en.wikipedia.org/w/index.php?title=Bialla_Airport&action=edit&redlink=1"),
                     list(longitude = NA,
                          latitude = NA,
                          longitude.degree = NA,
                          latitude.degree = NA))
})
test_that("scrapWikipediaAirportsDetails return NA values for NA", {
        expect_identical(scrapWikipediaAirportsDetails(url = NA),
                         list(longitude = NA,
                              latitude = NA,
                              longitude.degree = NA,
                              latitude.degree = NA))
})
test_that("scrapWikipediaAirportsDetails return correct values for https://en.wikipedia.org/wiki/Bahrain_International_Airport", {
        expect_equal(scrapWikipediaAirportsDetails(url = "https://en.wikipedia.org/wiki/Bahrain_International_Airport"),
                         list(longitude = dms2dd("50°38′01″E"),
                              latitude = dms2dd("26°16′15″N"),
                              longitude.degree = "50°38′01″E",
                              latitude.degree = "26°16′15″N"))
})