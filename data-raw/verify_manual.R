# Manual verification script for senaceR (without devtools/testthat dependencies)

cat("===================================\n")
cat("Verifying senaceR (REST API focus)...\n")

cat("1. Loading R source files from R/...\n")
r_files <- list.files("R", pattern = "\\.[Rr]$", full.names = TRUE)
for (f in r_files) {
  sys.source(f, envir = .GlobalEnv)
}

cat("2. Executing client function tests...\n")

# A. Datasets list
ds <- senace_list_datasets()
stopifnot(is.data.frame(ds))
stopifnot(nrow(ds) == 8)
cat("✔ senace_list_datasets() OK\n")

# B. API Key configuration
senace_set_key("mi_api_key_temporal")
stopifnot(senace_api_key() == "mi_api_key_temporal")
cat("✔ senace_set_key() and senace_api_key() OK\n")

# C. Live query test using provided key
cat("\nTesting live API query using provided API key:\n")
api_key_usuario <- Sys.getenv("SENACE_API_KEY")
if (identical(api_key_usuario, "")) {
  cat("⚠ SENACE_API_KEY environment variable is not set. Skipping live HTTP request checks.\n")
} else {
  senace_set_key(api_key_usuario)

  reclamos_vivo <- senace_reclamos()
  stopifnot(nrow(reclamos_vivo) > 0)
  cat("✔ Live Reclamos query OK (rows:", nrow(reclamos_vivo), ")\n")

  gasto_fuente_vivo <- senace_gastos_fuente()
  stopifnot(nrow(gasto_fuente_vivo) > 0)
  cat("✔ Live GastoFuente query OK (rows:", nrow(gasto_fuente_vivo), ")\n")
}

cat("\n===================================\n")
cat("ALL MANUAL VERIFICATIONS PASSED SUCCESSFULLY!\n")
cat("===================================\n")
