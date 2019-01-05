#' All countries with their 2 digit codes (ISO 3166-1)
#'
#' All countries on the planet with names, iso names, iso code, continent
#' and wikipedia page. iso.name is ISO 3166-1-alpha-2 English country names with
#'  ISO 3166-1-alpha-2 code elements.
#' This list is built by datapleth.io using various sources.
#'
#'
#' @format A data frame with 10051 rows and 5 variables:
#' \describe{
#'   \item{country.code}{chr,country ISO 3166-1-alpha-2 code elements}
#'   \item{country.name}{chr, usual name of countries in english}
#'   \item{country.iso.name}{chr, official short names of countries in English as given in
#'    ISO 3166-1}
#'   \item{country.continent}{Factor, countinent the country belongs to :  
#'   "Europe", "Asia", "Africa", "Antartica", "South America", "Oceania", "North America"  }
#'   \item{comments}{chr, additionnal information}
#'   \item{wikipedia_link}{chr, country wikipedia page}
#' }
#' @source 
#' we combiend data from two sources
#' \url{https://datahub.io/core/country-list}
#' \url{http://ourairports.com/data/}
#' \url{http://en.wikipedia.org/}
"countries"