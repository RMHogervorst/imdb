#' IMDB information enricher.
#' 
#' This function downloads episode information into a dataframe. 
#' Use it to create a dataframe with extra information about every epidode.
#' it downloads runtime, director, writer, actors, plot and imdb votes.
#' @param df Name of dataframe you want to add info to. NEEDS an imdbID variable.
#' @examples 
#' \dontrun{ 
#' enrichIMDB("IMDB")
#' }
#' @keywords imdb, enrich
enrichIMDB<- function(df){
        library(jsonlite)
        #  read all unique  id's
        IDs<- unique(df$imdbID)
        #issue with rbind that breaks the column names, forces me to create a useless row
        imdbID <- "t103" 
        runtime<- "asdf"
        director<- "asdf"
        writer<- "asdf"
        actors<- "asdf"
        plot<-"adsf"
        votes<-"456"
        dataframe<-data.frame(imdbID, runtime,director, writer,actors, plot,votes, stringsAsFactors = F)
        #  loop through ids and add information into a row and adding it to dataframe. 
        for(i in IDs) {
                link <- paste("http://www.omdbapi.com/?i=", i ,"&plot=full&r=json", sep = "")
                hold<-fromJSON(link)
                newrow<- c( i, hold$Runtime, hold$Director, hold$Writer, hold$Actors, hold$Plot, hold$imdbVotes)
                dataframe<-rbind(dataframe, newrow)
        }
        dataframe = dataframe[-1,] #issue with rbind forces me to remove the useless row
        dataframe$votes<-as.numeric(dataframe$votes) # votes are numeric
        return(dataframe)
}
