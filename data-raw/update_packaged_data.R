# Script to update local packaged datasets inside the R package
# This script is for internal developer use or for users wishing to compile offline data.

# Load required libraries
library(httr2)
library(jsonlite)
library(tibble)

# 1. Retrieve API key
# You can set it as an environment variable or directly here:
# Sys.setenv(SENACE_API_KEY = "your_api_key")
api_key <- Sys.getenv("SENACE_API_KEY")
if (api_key == "") {
  stop("Please configure the SENACE_API_KEY environment variable before running this script.")
}

cat("Starting download of SENACE datasets...\n")

# Ensure 'data/' directory exists
if (!dir.exists("data")) {
  dir.create("data")
}

# Map Datastreams to internal variable names
datasets_info <- list(
  list(guid = "CarteraProyectos", var = "cartera_proyectos_data"),
  list(guid = "ConsultorasAmbientales", var = "consultoras_ambientales_data"),
  list(guid = "GastoEspecifica", var = "gasto_especifica_data"),
  list(guid = "GastoFuente", var = "gasto_fuente_data"),
  list(guid = "GastoGenerica", var = "gasto_generica_data"),
  list(guid = "SolicitudAcceso", var = "solicitud_acceso_data"),
  list(guid = "Visitas", var = "visitas_data"),
  list(guid = "Reclamos", var = "reclamos_data")
)

for (item in datasets_info) {
  cat("Downloading datastream:", item$guid, "... ")
  url <- paste0("https://datosabiertos.senace.gob.pe/Api/datastreams/", item$guid)
  
  tryCatch({
    req <- request(url)
    req <- req_url_query(req, auth_key = api_key)
    req <- req_perform(req)
    
    body <- resp_body_string(req)
    parsed <- fromJSON(body, simplifyVector = TRUE)
    
    # Assign variable as a tibble
    assign(item$var, as_tibble(parsed))
    
    # File path
    file_path <- file.path("data", paste0(item$var, ".rda"))
    
    # Save in binary compressed R format (.rda)
    # xz is the most efficient compression format for text/tabular data in R
    save(list = item$var, file = file_path, compress = "xz")
    cat("Done! Saved to:", file_path, "(", nrow(parsed), "rows)\n")
    
  }, error = function(e) {
    cat("ERROR downloading/saving:", e$message, "\n")
  })
}

cat("\nData update process completed successfully.\n")

