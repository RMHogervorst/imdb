context("testing imdbmovie")
if(!exists("key1")){
        key1 <- Sys.getenv('OMDB_KEY')
        Sys.setenv(IMDBTOGGLE = "off")
}

test_that("several caps and types return identical frames", {
        a<- imdbMovies("Meatballs", key = key1)
        b<- imdbMovies("MEATBALLS", key = key1)
        expect_equal(a,b)
})
test_that("correct response is returned", {
        test <- imdbMovies("Meatballs", key = key1)
        expect_equal(test$Country, "Canada")
})

