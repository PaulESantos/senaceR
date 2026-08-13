# Script de verificación manual para senaceR (sin dependencias de devtools/testthat)

cat("===================================\n")
cat("Verificando senaceR...\n")

# Mock de namespace para cargar los archivos del paquete en el entorno global
# para simular la existencia de los datasets precargados
# En un paquete R, Roxygen/LazyData se encarga de esto. Para probarlos de forma sencilla:
cat("1. Cargando datasets precargados de data/...\n")
rda_files <- list.files("data", pattern = "\\.rda$", full.names = TRUE)
for (f in rda_files) {
  load(f, envir = .GlobalEnv)
}

cat("2. Cargando código fuente de R/...\n")
r_files <- list.files("R", pattern = "\\.[Rr]$", full.names = TRUE)
for (f in r_files) {
  sys.source(f, envir = .GlobalEnv)
}

# Crear un mock de asNamespace("senaceR") para que la función get_package_dataset funcione en entorno local
# ya que fuera de la carga formal del paquete, asNamespace("senaceR") no existe o no tiene los datasets.
# Por lo tanto, modificamos el entorno de búsqueda para que busque en el entorno global.
# Vamos a redefinir temporalmente la función interna get_package_dataset para que busque en .GlobalEnv
get_package_dataset <- function(guid, dataset_var, api_key, offline) {
  ns_name <- "senaceR"
  
  if (offline) {
    if (exists(dataset_var, envir = .GlobalEnv)) {
      return(get(dataset_var, envir = .GlobalEnv))
    } else {
      stop(paste0("El dataset local pre-cargado '", dataset_var, "' no está disponible."), call. = FALSE)
    }
  }
  
  # Intento en vivo
  tryCatch({
    senace_get_data(guid, api_key = api_key)
  }, error = function(e) {
    cat("ERROR DETECTADO EN CONEXION API EN VIVO:", e$message, "\n")
    if (exists(dataset_var, envir = .GlobalEnv)) {
      warning("No se pudo conectar a la API en vivo de SENACE. Retornando copia local pre-cargada.", call. = FALSE)
      return(get(dataset_var, envir = .GlobalEnv))
    } else {
      stop(e$message, call. = FALSE)
    }
  })
}

cat("3. Ejecutando pruebas en funciones...\n")

# A. Lista de datasets
ds <- senace_list_datasets()
stopifnot(is.data.frame(ds))
stopifnot(nrow(ds) == 8)
cat("✔ senace_list_datasets() OK\n")

# B. Configuración de API Key
senace_set_key("mi_api_key_temporal")
stopifnot(senace_api_key() == "mi_api_key_temporal")
cat("✔ senace_set_key() y senace_api_key() OK\n")

# C. Carga de datos precargados (Offline)
cat("\nProbando carga de datos offline desde la carpeta data/:\n")

proyectos <- senace_cartera_proyectos(offline = TRUE)
stopifnot(nrow(proyectos) == 2567)
cat("✔ senace_cartera_proyectos(offline = TRUE) OK (filas:", nrow(proyectos), ")\n")

consultoras <- senace_consultoras_ambientales(offline = TRUE)
stopifnot(nrow(consultoras) == 14187)
cat("✔ senace_consultoras_ambientales(offline = TRUE) OK (filas:", nrow(consultoras), ")\n")

reclamos <- senace_reclamos(offline = TRUE)
stopifnot(nrow(reclamos) == 59)
cat("✔ senace_reclamos(offline = TRUE) OK (filas:", nrow(reclamos), ")\n")

visitas <- senace_visitas(offline = TRUE)
stopifnot(nrow(visitas) == 57021)
cat("✔ senace_visitas(offline = TRUE) OK (filas:", nrow(visitas), ")\n")

# D. Prueba de consulta en vivo usando la clave provista
cat("\nProbando consulta en vivo a la API usando la API Key provista:\n")
# The real credential is read only from the environment.
api_key_usuario <- Sys.getenv("SENACE_API_KEY")
if (identical(api_key_usuario, "")) {
  stop("Configure SENACE_API_KEY before running the live API checks.", call. = FALSE)
}
senace_set_key(api_key_usuario)

reclamos_vivo <- senace_reclamos(offline = FALSE)
stopifnot(nrow(reclamos_vivo) > 0)
cat("✔ Consulta en vivo de Reclamos OK (filas:", nrow(reclamos_vivo), ")\n")

gasto_fuente_vivo <- senace_gastos_fuente(offline = FALSE)
stopifnot(nrow(gasto_fuente_vivo) > 0)
cat("✔ Consulta en vivo de GastoFuente OK (filas:", nrow(gasto_fuente_vivo), ")\n")

cat("\n===================================\n")
cat("¡TODAS LAS VERIFICACIONES MANUALES PASARON CON ÉXITO!\n")
cat("===================================\n")
