#' Retrieve the Sustainable Investment Project Portfolio
#'
#' Downloads the SENACE project portfolio from the REST API.
#'
#' @param api_key A SENACE API key. If `NULL`, it is retrieved automatically.
#'
#' @return A tibble.
#' @export
#' @examples
#' \dontrun{
#' senace_cartera_proyectos()
#' }
senace_cartera_proyectos <- function(api_key = NULL) {
  senace_get_data("CarteraProyectos", api_key = api_key)
}

#' Retrieve the Environmental Consulting Firms Register
#'
#' Downloads the register of environmental consulting firms authorized by SENACE
#' from the REST API.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
#' @examples
#' \dontrun{
#' senace_consultoras_ambientales()
#' }
senace_consultoras_ambientales <- function(api_key = NULL) {
  senace_get_data("ConsultorasAmbientales", api_key = api_key)
}

#' Retrieve expenditure by detailed classifier
#'
#' Downloads detailed budget expenditure data from the REST API.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
#' @examples
#' \dontrun{
#' senace_gastos_especifica()
#' }
senace_gastos_especifica <- function(api_key = NULL) {
  senace_get_data("GastoEspecifica", api_key = api_key)
}

#' Retrieve expenditure by funding source
#'
#' Downloads budget expenditure summarized by funding source from the REST API.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
#' @examples
#' \dontrun{
#' senace_gastos_fuente()
#' }
senace_gastos_fuente <- function(api_key = NULL) {
  senace_get_data("GastoFuente", api_key = api_key)
}

#' Retrieve expenditure by generic classifier
#'
#' Downloads budget expenditure by generic classifier from the REST API.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
#' @examples
#' \dontrun{
#' senace_gastos_generica()
#' }
senace_gastos_generica <- function(api_key = NULL) {
  senace_get_data("GastoGenerica", api_key = api_key)
}

#' Retrieve public information access requests
#'
#' Downloads public information access requests from the REST API.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
#' @examples
#' \dontrun{
#' senace_solicitudes_acceso()
#' }
senace_solicitudes_acceso <- function(api_key = NULL) {
  senace_get_data("SolicitudAcceso", api_key = api_key)
}

#' Retrieve the Institutional Visits Register
#'
#' Downloads records of visits to SENACE offices from the REST API.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
#' @examples
#' \dontrun{
#' senace_visitas()
#' }
senace_visitas <- function(api_key = NULL) {
  senace_get_data("Visitas", api_key = api_key)
}

#' Retrieve the Complaints and Claims Register
#'
#' Downloads complaints and claims submitted by the public from the REST API.
#'
#' @inheritParams senace_cartera_proyectos
#'
#' @return A tibble.
#' @export
#' @examples
#' \dontrun{
#' senace_reclamos()
#' }
senace_reclamos <- function(api_key = NULL) {
  senace_get_data("Reclamos", api_key = api_key)
}
