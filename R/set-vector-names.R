#' setVectorName
#'
#' @param x a list
#' @param names names of the list
#'
#' @return a named list
#'
#' @examples
#' setVectorName(x = list(1,2,3,4), names = c("a","b","c","d"))
setVectorName <- function(x = NULL,
                          names = NULL) {
        ## Test if login & password are provided
        if(is.null(names)){
                stop('argument names must be provided')
        }
        ## Test if x and names have same length
        if(length(x) != length(names)){
                stop('names must contains as many elements as x')
        }
        ## Test if x and names are list or vector
        if((!is.vector(x) | !is.list(x)) & (!is.vector(names) | !is.list(names))){
                stop('names & x must be vectors or lists')
        }
        
        
        names(x) <- names
        return(x)
}