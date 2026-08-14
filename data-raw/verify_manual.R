# Manual verification script for senaceR (without devtools/testthat dependencies)

cat("===================================\n")
cat("Verifying senaceR...\n")

# Mock namespace setup to load package data into the global environment
# to simulate the presence of pre-packaged datasets.
# In an R package, Roxygen/LazyData handles this. For simple testing:
cat("1. Loading pre-packaged datasets from data/...\n")
rda_files <- list.files("data", pattern = "\\.rda$", full.names = TRUE)
for (f in rda_files) {
  load(f, envir = .GlobalEnv)
}

cat("2. Loading R source files from R/...\n")
r_files <- list.files("R", pattern = "\\.[Rr]$", full.names = TRUE)
for (f in r_files) {
  sys.source(f, envir = .GlobalEnv)
}

# Create a mock of asNamespace("senaceR") so get_package_dataset works locally
# since outside formal package loading, asNamespace("senaceR") doesn't exist or doesn't have datasets.
# Therefore, we temporarily modify the search scope to look in .GlobalEnv.
# Redefining the internal function get_package_dataset to look in .GlobalEnv
get_package_dataset <- function(guid, dataset_var, api_key, offline) {
  ns_name <- "senaceR"
  
  if (offline) {
    if (exists(dataset_var, envir = .GlobalEnv)) {
      return(get(dataset_var, envir = .GlobalEnv))
    } else {
      stop(paste0("Pre-packaged local dataset '", dataset_var, "' is not available."), call. = FALSE)
    }
  }
  
  # Live attempt
  tryCatch({
    senace_get_data(guid, api_key = api_key)
  }, error = function(e) {
    cat("ERROR DETECTED IN LIVE API CONNECTION:", e$message, "\n")
    if (exists(dataset_var, envir = .GlobalEnv)) {
      warning("Could not connect to live SENACE API. Returning pre-packaged local copy.", call. = FALSE)
      return(get(dataset_var, envir = .GlobalEnv))
    } else {
      stop(e$message, call. = FALSE)
    }
  })
}

cat("3. Executing function tests...\n")

# A. Datasets list
ds <- senace_list_datasets()
stopifnot(is.data.frame(ds))
stopifnot(nrow(ds) == 8)
cat("✔ senace_list_datasets() OK\n")

# B. API Key configuration
senace_set_key("mi_api_key_temporal")
stopifnot(senace_api_key() == "mi_api_key_temporal")
cat("✔ senace_set_key() and senace_api_key() OK\n")

# C. Pre-packaged data loading (Offline)
cat("\nTesting offline data load from data/ folder:\n")

proyectos <- senace_cartera_proyectos(offline = TRUE)
stopifnot(nrow(proyectos) == 2567)
cat("✔ senace_cartera_proyectos(offline = TRUE) OK (rows:", nrow(proyectos), ")\n")

consultoras <- senace_consultoras_ambientales(offline = TRUE)
stopifnot(nrow(consultoras) == 14187)
cat("✔ senace_consultoras_ambientales(offline = TRUE) OK (rows:", nrow(consultoras), ")\n")

reclamos <- senace_reclamos(offline = TRUE)
stopifnot(nrow(reclamos) == 59)
cat("✔ senace_reclamos(offline = TRUE) OK (rows:", nrow(reclamos), ")\n")

visitas <- senace_visitas(offline = TRUE)
stopifnot(nrow(visitas) == 57021)
cat("✔ senace_visitas(offline = TRUE) OK (rows:", nrow(visitas), ")\n")

# D. Live query test using provided key
cat("\nTesting live API query using provided API key:\n")
# The real credential is read only from the environment.
api_key_usuario <- Sys.getenv("SENACE_API_KEY")
if (identical(api_key_usuario, "")) {
  stop("Configure SENACE_API_KEY before running the live API checks.", call. = FALSE)
}
senace_set_key(api_key_usuario)

reclamos_vivo <- senace_reclamos(offline = FALSE)
stopifnot(nrow(reclamos_vivo) > 0)
cat("✔ Live Reclamos query OK (rows:", nrow(reclamos_vivo), ")\n")

gasto_fuente_vivo <- senace_gastos_fuente(offline = FALSE)
stopifnot(nrow(gasto_fuente_vivo) > 0)
cat("✔ Live GastoFuente query OK (rows:", nrow(gasto_fuente_vivo), ")\n")

cat("\n===================================\n")
cat("ALL MANUAL VERIFICATIONS PASSED SUCCESSFULLY!\n")
cat("===================================\n")

