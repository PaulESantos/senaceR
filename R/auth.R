#' Set the SENACE API key
#'
#' Stores a SENACE API key in the environment of the current R session.
#'
#' @param key A non-empty character string containing a personal API key.
#' @return Invisibly, `NULL`.
#' @export
#' @examples
#' \dontrun{
#' senace_set_key("your_api_key")
#' }
senace_set_key <- function(key) {
  if (missing(key) || !is.character(key) || length(key) != 1 || nchar(key) == 0) {
    stop("The API key must be a non-empty character string.", call. = FALSE)
  }
  Sys.setenv(SENACE_API_KEY = key)
  message("SENACE API key stored in the session environment.")
  invisible(NULL)
}

#' Retrieve the active SENACE API key
#'
#' Looks for an API key in the `SENACE_API_KEY` environment variable and then
#' in the `senace.api_key` global option. An informative error is raised if no
#' key is available.
#'
#' @return A character string containing the SENACE API key.
#' @export
senace_api_key <- function() {
  # 1. Look in the environment variable.
  key <- Sys.getenv("SENACE_API_KEY")
  if (key != "") {
    return(key)
  }
  
  # 2. Look in R options.
  key <- getOption("senace.api_key")
  if (!is.null(key) && is.character(key) && nchar(key) > 0) {
    return(key)
  }
  
  # 3. Provide setup instructions.
  stop(
    "No SENACE API key was found.\n",
    "Set one with:\n",
    "  senace_set_key('TU_API_KEY')\n\n",
    "Or save it in your .Renviron file as:\n",
    "  SENACE_API_KEY=TU_API_KEY\n\n",
    "Get an API key by registering at the SENACE Open Data Portal:\n",
    "https://datosabiertos.senace.gob.pe",
    call. = FALSE
  )
}
