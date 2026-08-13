#' Retrieve the Sustainable Investment Project Portfolio
#'
#' Downloads the SENACE project portfolio or retrieves its bundled local snapshot.
#'
#' @param api_key A SENACE API key. If `NULL`, it is retrieved automatically.
#' @param offline If `TRUE`, use the dataset bundled with the package instead of
#'   querying the API.
#'
#' @return A tibble.
#' @export
senace_cartera_proyectos <- function(api_key = NULL, offline = FALSE) {
  get_package_dataset("CarteraProyectos", "cartera_proyectos_data", api_key, offline)
}

#' Retrieve the Environmental Consulting Firms Register
#'
#' Downloads the register of environmental consulting firms authorized by SENACE
#' or retrieves its bundled local snapshot.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
senace_consultoras_ambientales <- function(api_key = NULL, offline = FALSE) {
  get_package_dataset("ConsultorasAmbientales", "consultoras_ambientales_data", api_key, offline)
}

#' Retrieve expenditure by detailed classifier
#'
#' Downloads detailed budget expenditure data or retrieves its bundled local
#' snapshot.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
senace_gastos_especifica <- function(api_key = NULL, offline = FALSE) {
  get_package_dataset("GastoEspecifica", "gasto_especifica_data", api_key, offline)
}

#' Retrieve expenditure by funding source
#'
#' Downloads budget expenditure summarized by funding source or retrieves its
#' bundled local snapshot.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
senace_gastos_fuente <- function(api_key = NULL, offline = FALSE) {
  get_package_dataset("GastoFuente", "gasto_fuente_data", api_key, offline)
}

#' Retrieve expenditure by generic classifier
#'
#' Downloads budget expenditure by generic classifier or retrieves its bundled
#' local snapshot.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
senace_gastos_generica <- function(api_key = NULL, offline = FALSE) {
  get_package_dataset("GastoGenerica", "gasto_generica_data", api_key, offline)
}

#' Retrieve public information access requests
#'
#' Downloads public information access requests or retrieves their bundled local
#' snapshot.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
senace_solicitudes_acceso <- function(api_key = NULL, offline = FALSE) {
  get_package_dataset("SolicitudAcceso", "solicitud_acceso_data", api_key, offline)
}

#' Retrieve the Institutional Visits Register
#'
#' Downloads records of visits to SENACE offices or retrieves their bundled local
#' snapshot.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
senace_visitas <- function(api_key = NULL, offline = FALSE) {
  get_package_dataset("Visitas", "visitas_data", api_key, offline)
}

#' Retrieve the Complaints and Claims Register
#'
#' Downloads complaints and claims submitted by the public or retrieves their
#' bundled local snapshot.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
senace_reclamos <- function(api_key = NULL, offline = FALSE) {
  get_package_dataset("Reclamos", "reclamos_data", api_key, offline)
}

# Internal helper that retrieves an online dataset or its local snapshot.
get_package_dataset <- function(guid, dataset_var, api_key, offline) {
  ns_name <- "senaceR"
  
  if (offline) {
    if (exists(dataset_var, envir = asNamespace(ns_name))) {
      return(get(dataset_var, envir = asNamespace(ns_name)))
    } else {
      stop(
        paste0("The bundled dataset '", dataset_var, "' is not available. ",
               "Set `offline = FALSE` and provide an active API key to download it."),
        call. = FALSE
      )
    }
  }
  
  # Try the live endpoint first.
  tryCatch({
    senace_get_data(guid, api_key = api_key)
  }, error = function(e) {
    # Fall back to the bundled snapshot when available.
    if (exists(dataset_var, envir = asNamespace(ns_name))) {
      warning(
        paste0("Could not connect to the live SENACE API (", e$message, "). ",
               "Returning the bundled local snapshot."),
        call. = FALSE
      )
      return(get(dataset_var, envir = asNamespace(ns_name)))
    } else {
      stop(e$message, call. = FALSE)
    }
  })
}
