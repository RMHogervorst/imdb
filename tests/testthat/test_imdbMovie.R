context("testing imdbmovie")

test_that("several caps and types return identical frames", {
        a<- imdbMovies("Meatballs")
        b<- imdbMovies("MEATBALLS")
        expect_equal(a,b)
})
test_that("correct response is returned", {
        test <- imdbMovies("Meatballs")
        expect_equal(test$Country, "Canada")
})

