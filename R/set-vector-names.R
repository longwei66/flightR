#' setVectorName
#'
#' @param x a list
#' @param names names of the list
#'
#' @return a named list
#'
#' @examples
setVectorName <- function(x = NULL,
                          names = NULL) {
        names(x) <- names
        return(x)
}