#' replaceNullByNA
#' 
#' function to replace NULL Values in a list by NA values
#'
#' @param x a list
#'
#' @return x a list
#'
#' @examples
replaceNullByNA <- function(x){
        ## -- look for null values in the list and replace by NA
        x[sapply(x, is.null)] <- NA
        return(x)
}