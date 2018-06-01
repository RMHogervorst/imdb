
<!-- README.md is generated from README.Rmd. Please edit that file -->
Wat can I do with the imdb package?
===================================

The package imdb helps you in downloading series and movie information from imdb (it uses the omdbi api). It has three functions one for basic information about series and a second one that also downloads synopsis, actors etc. A third function downloads information about movies.

A walkthrough in the [vignette](articles/walktrough.html) provides more information.

Version information
-------------------

[![codecov](https://codecov.io/gh/RMHogervorst/imdb/branch/master/graph/badge.svg)](https://codecov.io/gh/RMHogervorst/imdb)[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/imdb)](https://cran.r-project.org/package=imdb)[![Last-changedate](https://img.shields.io/badge/last%20change-2017--03--03-yellowgreen.svg)](/commits/master)[![Licence](https://img.shields.io/badge/licence-MIT-lightgrey.svg)](http://choosealicense.com/)[![minimal R version](https://img.shields.io/badge/R-3.2.2-6666ff.svg)](https://cran.r-project.org/)[![Project Status: active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)[![Build Status](https://travis-ci.org/RMHogervorst/imdb.svg?branch=master)](https://travis-ci.org/RMHogervorst/imdb)

Installation instructions
=========================

For now you will have to install using `devtools::install_github("rmhogervorst/imdb")`

To make calls to the API you need an API-key. go to <https://www.omdbapi.com/apikey.aspx> and register for a free key. You can make a 1000 calls per day with the free account.

Add the key to your .Renviron (~/.Renviron) file: add a line like 'OMDB\_KEY = xxxkeyxxx' to the file.

Or use the function add\_key\_to\_renviron from the package.

Example usage
=============

imdb has 4 functions:

-   imdbSeries()
-   enrichIMDB() and
-   imdbMovies() and
-   imdbTitleId()

With the function 'imdbSeries(seriesname = "name of series", seasons = number(s))' you can call up general information about series. Note that the api is does not really care about case. "Game of Thrones" or "game of thrones" or "gAmE oF tHrONes " is all fine.

``` r
library(imdb)
imdbSeries("game of thrones ")
#>                                    Title   Released Episode imdbRating
#> 1                       Winter Is Coming 2011-04-17       1        9.0
#> 2                          The Kingsroad 2011-04-24       2        8.8
#> 3                              Lord Snow 2011-05-01       3        8.7
#> 4  Cripples, Bastards, and Broken Things 2011-05-08       4        8.8
#> 5                  The Wolf and the Lion 2011-05-15       5        9.1
#> 6                         A Golden Crown 2011-05-22       6        9.2
#> 7                     You Win or You Die 2011-05-29       7        9.3
#> 8                         The Pointy End 2011-06-05       8        9.1
#> 9                                 Baelor 2011-06-12       9        9.6
#> 10                        Fire and Blood 2011-06-19      10        9.5
#>       imdbID Season
#> 1  tt1480055      1
#> 2  tt1668746      1
#> 3  tt1829962      1
#> 4  tt1829963      1
#> 5  tt1829964      1
#> 6  tt1837862      1
#> 7  tt1837863      1
#> 8  tt1837864      1
#> 9  tt1851398      1
#> 10 tt1851397      1
```

The command will return a data frame with Title, releasedate, episodenumber imdb-rating, imdb ID and season.

Would you like to know more about your series? Use the `enrichIMDB` command:

``` r
season2GOT <-imdbSeries("game of thrones", seasons = 2)
season2GOT_enriched <- enrichIMDB(season2GOT)
```

The enrichIMDB command returns a seperate dataframe with imdbID, runtime, director, writer, actors, plot (complete synopsis), and votes per episode. It uses the imdbid of the episode to scour for more information. So if you'd like to know how many times Jon Snow appears in the synopsis, or how many times Peter Dinklage plays in season 2, you can now search for it.

``` r
grep("Jon",  season2GOT_enriched$plot)
#> [1]  2  6  7  8 10
grep("Peter Dinklage", season2GOT_enriched$actors)
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

Combining the information from the two dataframes can also be very useful.

``` r
library(ggplot2)
suppressPackageStartupMessages(library(dplyr))
GOTall<-imdbSeries("game of Thrones", 1:6)
GOT <-left_join(GOTall, enrichIMDB(GOTall), by = "imdbID")
ggplot(GOT, aes(Episode, imdbRating)) + 
        geom_smooth(aes(color = as.factor(Season)),se = FALSE , alpha = 1/10)+
        geom_point(aes(color = as.factor(Season), size = votes))+
        ggtitle("Rating per episode of GoT, \ncolored by season\nwith smoothlines")
```

Contact
=======

I'm always looking for people to help me improve my work. Contact me directly, use an [issue](https://github.com/RMHogervorst/imdb/issues), fork me or submit a pull request.

[![star this repo](http://githubbadges.com/star.svg?user=RMHogervorst&repo=imdb&style=flat)](https://github.com/RMHogervorst/imdb) [![fork this repo](http://githubbadges.com/fork.svg?user=RMHogervorst&repo=imdb&style=flat)](https://github.com/RMHogervorst/imdb/fork)
