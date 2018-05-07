context("call by imdb id")
the_truman_show <- "tt0120382"
test_that("title ID calls are correct",{
        expect_equal(imdbTitleId(the_truman_show)$Title, "The Truman Show")
})

rm(the_truman_show)
