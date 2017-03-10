
#' Download information about a movie from imdb
#'
#' @param moviename Type the name of the movie
#' @export
imdbMovies <- function(moviename){
        link<-gsub(pattern = " ",
                   replacement = "%20", x=(paste("http://www.omdbapi.com/?t=",moviename,"&type=movie&r=json&plot=full", sep = "")))
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
