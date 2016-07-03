context("imdbSeries characters")


test_that("several caps and types return identical frames", {
        a<- imdbSeries("Game OF THRONES")
        b<- imdbSeries("Game-of-thrones")
        expect_equal(a,b)
})

test_that("usefull error messages are created", {
        skip_on_travis()
        expect_error(imdbSeries("Game OF THRONES", seasons = 1-5),
                     regexp = "season numbers")
})

sample<-  imdbSeries("Game OF THRONES", seasons = 3)
sample_2 <- enrichIMDB(sample)
test_that("enrichment works", {
        expect_match(sample$Title[5], "Kissed by Fire")
        expect_match(sample_2$plot[5], "Jon breaks his vows.")
})


rm(sample, sample_2)
