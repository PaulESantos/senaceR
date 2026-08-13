# Script para actualizar los datasets locales empaquetados en el package
# Este script es para uso interno del desarrollador o del usuario que desee compilar sus propios datos offline.

# Cargar librerías necesarias
library(httr2)
library(jsonlite)
library(tibble)

# 1. Obtener la API key
# Puedes setearla como variable de entorno o directamente aquí:
# Sys.setenv(SENACE_API_KEY = "tu_api_key")
api_key <- Sys.getenv("SENACE_API_KEY")
if (api_key == "") {
  stop("Por favor configure la variable de entorno SENACE_API_KEY antes de correr este script.")
}

cat("Iniciando descarga de conjuntos de datos de SENACE...\n")

# Asegurarse de que exista el directorio 'data/'
if (!dir.exists("data")) {
  dir.create("data")
}

# Mapeo de Datastreams a nombres de variables internas
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
  cat("Descargando datastream:", item$guid, "... ")
  url <- paste0("https://datosabiertos.senace.gob.pe/Api/datastreams/", item$guid)
  
  tryCatch({
    req <- request(url)
    req <- req_url_query(req, auth_key = api_key)
    req <- req_perform(req)
    
    body <- resp_body_string(req)
    parsed <- fromJSON(body, simplifyVector = TRUE)
    
    # Asignar a variable con formato tibble
    assign(item$var, as_tibble(parsed))
    
    # Ruta de archivo
    file_path <- file.path("data", paste0(item$var, ".rda"))
    
    # Guardar en formato binario comprimido R (.rda)
    # xz es el formato de compresión más eficiente para datos de texto/tablas en R
    save(list = item$var, file = file_path, compress = "xz")
    cat("Listo! Guardado en:", file_path, "(", nrow(parsed), " filas)\n")
    
  }, error = function(e) {
    cat("ERROR al descargar/guardar:", e$message, "\n")
  })
}

cat("\nProceso de actualización completado con éxito.\n")
