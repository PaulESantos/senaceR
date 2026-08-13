library(httr2)
library(jsonlite)

api_key <- Sys.getenv("SENACE_API_KEY")
if (identical(api_key, "")) {
  stop("Set SENACE_API_KEY before running this development script.", call. = FALSE)
}

endpoints <- c(
  "https://datosabiertos.senace.gob.pe/Api/datastreams/",
  "https://datosabiertos.senace.gob.pe/Api/datastreams/CarteraProyectos",
  "https://datosabiertos.senace.gob.pe/api/v2/datastreams/",
  "https://datosabiertos.senace.gob.pe/api/v2/datasets/",
  "https://datosabiertos.senace.gob.pe/api/v2/datastreams/CarteraProyectos"
)

for (url in endpoints) {
  cat("\n-----------------------------------\nTesting:", url, "\n")
  tryCatch({
    req <- request(url) %>%
      req_url_query(auth_key = api_key) %>%
      req_perform()
    
    cat("Status:", resp_status(req), "\n")
    body <- resp_body_string(req)
    cat("Body excerpt:", substr(body, 1, 200), "\n")
  }, error = function(e) {
    cat("Failed. Error:", e$message, "\n")
  })
}
