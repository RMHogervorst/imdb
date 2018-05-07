#' Download information about a title from imdb by imdb ID
#'
#' @param titleid The id, f.i.: "tt0120382"
#' @inheritParams imdbSeries
#' @export
imdbTitleId <- function(titleid, key = NULL){
        key <- api_key(key)
        link<-gsub(pattern = " ",
                   replacement = "%20", x=(paste("http://www.omdbapi.com/?i=",titleid,"&type=movie&r=json&plot=full",'&apikey=', key, sep = "")))
        hold<-jsonlite::fromJSON(link)
        if(hold$Response != "True")stop("response is not valid")
        df <- data.frame(Title = hold$Title,
                         Year = hold$Year,
                         Rated = hold$Rated,
                         Released = hold$Released,
                         Runtime = hold$Runtime,
                         Genre = hold$Genre,
                         Director = hold$Director,
                         Writer = hold$Writer,
                         Actors = hold$Actors,
                         Plot = hold$Plot,
                         Language = hold$Language,
                         Country = hold$Country,
                         Awards = hold$Awards,
                         Posterlink = hold$Poster,
                         Metascore = hold$Metascore,
                         imdbRating = hold$imdbRating,
                         imdbVotes = hold$imdbVotes,
                         imdbID = hold$imdbID,
                         stringsAsFactors = FALSE)
        ToS_message()
        df

}
