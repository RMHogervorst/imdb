#' IMDB information downloader for series.
#'
#' This function downloads series information into a dataframe.
#' @param seasons Information about hat seasons do you want to download? Defaults to 1.
#' @param seriesname Give the name of the series for example "House MD"
#' @param key Enter your API key. If you don't have one yet, you can obtain one here: http://www.omdbapi.com/apikey.aspx
#' @examples
#' \dontrun{
#' imdbSeries("House MD", 1:2)
#' }
#' @keywords imdb, series
#' @export
imdbSeries<-function(seriesname, seasons = 1, key = NULL) {
        key <- api_key(key)
        if(!seasons >=1){stop("season numbers need to be above 1, try 1:2, 3 etc.")}
        df<-data.frame(Title = character(0), Released = character(0),
                       Episode = character(0), imdbRating = character(0),
                       imdbID = character(0), Season =numeric(0))  #creates empty dataframe
        for( i in seasons) {
                link<-gsub(pattern = " ", replacement = "%20", x=(paste("http://www.omdbapi.com/?t=",seriesname,"&Season=",i,'&apikey=', key, sep = "")))
                hold<-jsonlite::fromJSON(link)  # link with spaces replaced
                dftemp<-hold$Episodes #using only the Episodes part
                dftemp$Season <-i     # adding variable season
                df<- rbind(df, dftemp)# combining
                #loops through seasons and combines the seasons into 1 dataframe.
        }
        #assigning right classes.
        df$Released<-as.Date(df$Released)
        df$Episode<- as.numeric(df$Episode)
        df$imdbRating<- as.numeric(df$imdbRating)
        ToS_message()
        df
}
