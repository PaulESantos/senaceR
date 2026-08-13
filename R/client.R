#' Retrieve data from a SENACE datastream
#'
#' Sends a GET request to the SENACE Open Data Portal API and returns the
#' requested datastream.
#'
#' @param guid A single character string identifying the dataset, for example
#'   `"CarteraProyectos"`.
#' @param api_key A personal SENACE API key. If `NULL`, the key is obtained with
#'   [senace_api_key()].
#'
#' @return A tibble containing the datastream data.
#' @importFrom httr2 request req_url_query req_perform resp_body_string resp_status
#' @importFrom jsonlite fromJSON
#' @importFrom tibble as_tibble
#' @export
#' @examples
#' \dontrun{
#' complaints <- senace_get_data("Reclamos")
#' print(complaints)
#' }
senace_get_data <- function(guid, api_key = NULL) {
  if (missing(guid) || !is.character(guid) || length(guid) != 1 || nchar(guid) == 0) {
    stop("Supply a valid, non-empty datastream identifier, e.g. 'CarteraProyectos'.", call. = FALSE)
  }
  
  if (is.null(api_key)) {
    api_key <- senace_api_key()
  }
  
  url <- paste0("https://datosabiertos.senace.gob.pe/Api/datastreams/", guid)
  
  req <- httr2::request(url)
  req <- httr2::req_url_query(req, auth_key = api_key)
  
  # Perform the request.
  resp <- tryCatch({
    httr2::req_perform(req)
  }, error = function(e) {
    stop(paste("Could not connect to the SENACE API:", e$message), call. = FALSE)
  })
  
  # Validate the HTTP response.
  status <- httr2::resp_status(resp)
  if (status != 200) {
    stop(paste("The SENACE API returned HTTP status:", status), call. = FALSE)
  }
  
  # Parse the JSON response.
  body_text <- httr2::resp_body_string(resp)
  
  parsed_data <- tryCatch({
    jsonlite::fromJSON(body_text, simplifyVector = TRUE)
  }, error = function(e) {
    stop(paste("Could not parse the API JSON response:", e$message), call. = FALSE)
  })
  
  if (length(parsed_data) == 0) {
    message("The requested datastream is empty or returned no rows.")
    return(tibble::tibble())
  }
  
  # Return a modern tabular R object.
  return(tibble::as_tibble(parsed_data))
}

#' List datasets available from SENACE
#'
#' Returns the datastreams documented by the SENACE Open Data Portal.
#'
#' @return A tibble with datastream identifiers, titles, and descriptions. The
#'   column names `titulo` and `descripcion` are retained for backwards
#'   compatibility.
#' @importFrom tibble tibble
#' @export
#' @examples
#' senace_list_datasets()
senace_list_datasets <- function() {
  tibble::tibble(
    datastream = c(
      "CarteraProyectos",
      "ConsultorasAmbientales",
      "GastoEspecifica",
      "GastoFuente",
      "GastoGenerica",
      "SolicitudAcceso",
      "Visitas",
      "Reclamos"
    ),
    titulo = c(
      "Sustainable Investment Project Portfolio",
      "Environmental Consulting Firms Register",
      "Expenditure by Detailed Classifier",
      "Expenditure by Funding Source",
      "Expenditure by Generic Classifier",
      "Public Information Access Requests",
      "Institutional Visits Register",
      "Complaints and Claims Register"
    ),
    descripcion = c(
      "Projects within SENACE's remit, including their review status.",
      "Official register of organizations authorized to provide environmental consulting services, organized by subsector.",
      "Daily and annual budget expenditure broken down by detailed classifier.",
      "Budget expenditure summarized by funding source.",
      "Budget expenditure grouped by generic classifier.",
      "Public information access requests, including their status and response date.",
      "Records of visitors and meetings at SENACE offices.",
      "Complaints and claims formally submitted by members of the public."
    )
  )
}
