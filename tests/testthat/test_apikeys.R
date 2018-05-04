context("internals")
Sys.setenv(IMDBTOGGLE = "off")
key1 <- Sys.getenv('OMDB_KEY')

test_that("keys are located", {
        expect_equal(key1, imdb:::check_api_key())
        expect_equal(key1, imdb:::api_key())
})

test_that("handling of .renviron is correct", {
        writeLines("OMDB_KEY=blblblb", "tempfile")
        expect_error(add_key_to_renviron(NULL,location = ".data"),regexp = "The file does does not exist")
        expect_error(add_key_to_renviron("452",location = ".data"),regexp = "The file does does not exist")
        expect_error(add_key_to_renviron("452",location = "tempfile"),regexp = "The file tempfile already contains an OMDB_KEY")

        file.remove("tempfile")
})
