#' IMDB information downloader for series.
#' 
#' This function downloads series information into a dataframe.
#' @param seasons Information about hat seasons do you want to download? Defaults to 1.
#' @param seriesname Give the name of the series for example "House MD"
#' @examples 
#' \dontrun{ 
#' imdbSeries("House MD", 1:2)
#' }
#' @keywords imdb, series

imdbSeries<-function(seriesname, seasons = 1) {
        library(jsonlite)
        df<-data.frame(Title = character(0), Released = character(0), 
                       Episode = character(0), imdbRating = character(0), 
                       imdbID = character(0), Season =numeric(0))  #creates empty dataframe
        for( i in seasons) {
                link<-gsub(pattern = " ", replacement = "%20", x=(paste("http://www.omdbapi.com/?t=",seriesname,"&Season=",i, sep = "")))
                hold<-fromJSON(link)  # link with spaces replaced
                dftemp<-hold$Episodes #using only the Episodes part
                dftemp$Season <-i     # adding variable season
                df<- rbind(df, dftemp)# combining
                #loops through seasons and combines the seasons into 1 dataframe.
        }
        #assigning right classes.
        df$Released<-as.Date(df$Released)
        df$Episode<- as.numeric(df$Episode)
        df$imdbRating<- as.numeric(df$imdbRating)
        return(df)
}
