#' Find or define API key for omdb
#'
#' This function is not for direct use.
#'
#' @param key "quoted" key or by default searches in .Renviron en Sys.setenv
#'
#' @return key
api_key <- function(key = NULL){
        if(is.null(key)){
                key <- find_omdb_token()
        }#else{
        #  message("Setting key for this session")
        #  Sys.setenv(CORTICALIO_KEY = key)
        #}
        key
}


# This function tries to find the
# api key necessary for this api to work.
#
#
find_omdb_token <- function(){
        # if the key is already loaded, there is no need for other actions.
        if(Sys.getenv("OMDB_KEY")==""){
                location <- normalizePath("~/.Renviron")
                # if the file exists read the key.
                if(file.exists(location)){
                        token <- Sys.getenv("OMDB_KEY")
                        if(token == ""){
                                key <- set_omdb_key()
                        }
                }else{ # if there is no file, offer to create file.
                        message("you have no .Renviron file")
                        choice <- readline("Do you  want to create that file? (y/n) ")
                        if(choice== "y"){
                                writeLines("OMDB_KEY = ",file.path(normalizePath("~/"), ".Rtest") )
                                utils::file.edit(file.path(normalizePath("~/"), ".Renviron"))
                        }else if(choice == "n"){
                                message("You will have this message every time")
                                key <- set_omdb_key()
                        }
                }
        }else{
                key <- Sys.getenv("OMDB_KEY")
        }
        key
}

check_api_key <- function(){
        Sys.getenv("OMDB_KEY")
}


# key writing function
# don't export, internal function.
# returns error or key (also sets it in local env)
#
set_omdb_key <- function(){
        message("No omdb key found")
        key <- readline("Please enter your omdb api key: ")
        key <- ifelse(grepl("\\D",key),-1,key)
        if(is.na(key)|key== ""){stop("no key given")
        }else{
                message("writing key, \nif you don't want to repeat this process every time \n use the function add_key_to_renviron()")
                Sys.setenv(OMDB_KEY = key)
        }
        key
}

#' Add your api key to .Renviron
#'
#' This is a convenient function that writes
#' your key to the .Renviron file that is read in
#' at start. You dont have to give the key in, if
#' you use keep the key NULL it will ask for it in
#' the commandline (keeping it out of the logs and .history).
#'
#' Of course you can also go to the file and add it yourself.
#' the file should have a line that reads:
#' OMDB_KEY=key
#'
#' where you replace your key with your key.
#'
#' @param key keep NULL to search or add manualy
#' @param location what file do you want to write to?  defaults to ~/.Renviron
#' @export
add_key_to_renviron <- function(key = NULL, location = "~/.Renviron" ){
        if(!Sys.getenv('OMDB_KEY')==""){warning("The R session already as a OMDB key")}
        location <- path.expand(location)
        message("searching for file ",location)
        if(!file.exists(location)){stop("The file does does not exist")}
        file <- readLines(location)
        if(!any(grepl("OMDB_KEY", file))){
                if(is.null(key)){key <- set_omdb_key()}
                file <- append(file, paste0("OMDB_KEY=",key))
                writeLines(file, location)
                message("key added to ",location," restart session to read it in")
        }else{
                stop("The file ",location, " already contains an OMDB_KEY")
        }
}

# This function is now not used.
# Want to replace all the custom calls with this function.
call_api <- function(series = NULL, season = NULL, api_key = NULL){
        link <- "http://www.omdbapi.com/"

        #gsub(pattern = " ", replacement = "%20", x=(paste("http://www.omdbapi.com/?t=",series,"&Season=",season, sep = "")))
        config = list(
                t= series,
                Season= season,
                #,
                type=movie,
                r="json",
                plot="full",
                api_key = api_key(api_key)
        )
        httr::GET(url = link, config = config)
}
