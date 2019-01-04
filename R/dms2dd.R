#' dms2dd
#' 
#' convert geo location from degree minute seconds to 
#'
#' @param x location as "120°37′10″E"
#'
#' @return location as "120.619444444444"
#' @export
#'
#' @examples dms2dd("120°37′10″E")
dms2dd <- function(x = NULL){
        ## E & N are positive values
        x <- gsub(pattern = "(.*)(E|N)", replacement = "\\1", x = x)
        ## W & S are negatives
        x <- gsub(pattern = "(.*)(W|S)", replacement = "-\\1", x = x)
        ## replace degre minute second by space
        x <- gsub(pattern = "°|′|″", replacement = " ", x = x)
        ## convert to 
        x_dec <- measurements::conv_unit(x, 
                                         from = 'deg_min_sec', 
                                         to = 'dec_deg')
        return(as.numeric(x_dec))
}