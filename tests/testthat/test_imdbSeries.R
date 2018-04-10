context("imdbSeries characters")

key1 <- Sys.getenv('OMDB_KEY')
test_that("several caps and types return identical frames", {
        a<- imdbSeries("Game OF THRONES", key = key1)
        b<- imdbSeries("Game-of-thrones", key = key1)
        expect_equal(a,b)
})

test_that("usefull error messages are created", {
        skip_on_travis()
        expect_error(imdbSeries("Game OF THRONES", seasons = 1-5, key = key1),
                     regexp = "season numbers")
})

sample<-  imdbSeries("Game OF THRONES", seasons = 3, key = key1)
sample_2 <- enrichIMDB(sample, key = key1)
test_that("enrichment works", {
        expect_match(sample$Title[5], "Kissed by Fire")
        expect_match(sample_2$plot[5], "Jon breaks his vows.")
})


rm(sample, sample_2)
