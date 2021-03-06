% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/imdbSeries.R
\name{imdbSeries}
\alias{imdbSeries}
\title{IMDB information downloader for series.}
\usage{
imdbSeries(seriesname, seasons = 1, key = NULL)
}
\arguments{
\item{seriesname}{Give the name of the series for example "House MD"}

\item{seasons}{Information about hat seasons do you want to download? Defaults to 1.}

\item{key}{Enter your API key. If you don't have one yet, you can obtain one here: http://www.omdbapi.com/apikey.aspx}
}
\description{
This function downloads series information into a dataframe.
}
\examples{
\dontrun{
imdbSeries("House MD", 1:2)
}
}
\keyword{imdb,}
\keyword{series}
