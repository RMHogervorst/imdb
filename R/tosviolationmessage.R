
#' ToS violation message
#'
#' It has come to my attention that the use of the omdbapi might violate the terms of service
#' that imdb has set up. According to \url{http://www.imdb.com/conditions} scraping is forbidden.
#' I did not scrape IMDB but since we are using the omdb-api, we sort of violate the terms of service
#' indirectly. This is just a heads up.
#'
#' If you would like to stop this message, add a line to your .Renviron file: IMDBTOGGLE = "off". If you do I presume
#' you have read the message.
#'
#' @aliases tos_violation termsofservice tosviolation
#' @export
ToS_message <- function(){
 key <- Sys.getenv("IMDBTOGGLE")
if(key == ""){
message("You might violate the terms of service of imdb using this package and the omdbapi. \n for more info try ?tos_violation ")
}else if(key == "off"){
}else{
message("invalid entry for IMDBTOGGLE \nYou might violate the terms of service of imdb using this package and the omdbapi. \n for more info try ?tos_violation")
}
}
