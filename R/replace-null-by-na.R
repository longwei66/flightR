#' replaceNullByNA
#' 
#' function to replace NULL Values in a list by NA values
#'
#' @param x a list
#'
#' @return x a list
#'
#' @examples
#' replaceNullByNA(list("ab", "bc", NULL, "de"))
replaceNullByNA <- function(x = NULL){
        
        ## Test if login & password are provided
        if(is.null(x)){
                stop('list input is required')
        }
        
        ## -- look for null values in the list and replace by NA
        x[sapply(x, is.null)] <- NA
        return(x)
}