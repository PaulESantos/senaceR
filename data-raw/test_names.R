library(httr2)
library(jsonlite)

api_key <- Sys.getenv("SENACE_API_KEY")
if (identical(api_key, "")) {
  stop("Set SENACE_API_KEY before running this development script.", call. = FALSE)
}

names_to_test <- c(
  "CarteraProyectos",
  "ConsultorasAmbientales",
  "GastoEspecifica",
  "GastoFuente",
  "GastoGenerica",
  "SolicitudAcceso",
  "Visitas",
  "Reclamos"
)

for (name in names_to_test) {
  url <- paste0("https://datosabiertos.senace.gob.pe/Api/datastreams/", name)
  cat("\n===================================\nTesting datastream:", name, "\n")
  tryCatch({
    req <- request(url) %>%
      req_url_query(auth_key = api_key) %>%
      req_perform()
    
    cat("Status:", resp_status(req), "\n")
    body <- resp_body_string(req)
    df <- fromJSON(body)
    cat("Rows:", nrow(df), "| Columns:", ncol(df), "\n")
    cat("Columns:", paste(colnames(df), collapse = ", "), "\n")
    cat("First row excerpt:\n")
    print(head(df, 1))
  }, error = function(e) {
    cat("Failed. Error:", e$message, "\n")
  })
}
