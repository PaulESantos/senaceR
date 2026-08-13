library(httr2)
library(jsonlite)

api_key <- Sys.getenv("SENACE_API_KEY")
if (identical(api_key, "")) {
  stop("Set SENACE_API_KEY before running this development script.", call. = FALSE)
}

# Try to query the catalog (datastreams.json)
tryCatch({
  cat("Querying datastreams.json list...\n")
  req1 <- request("https://datosabiertos.senace.gob.pe/api/v2/datastreams.json") %>%
    req_url_query(auth_key = api_key) %>%
    req_perform()
  
  resp1 <- resp_body_string(req1)
  data1 <- fromJSON(resp1)
  cat("Successfully queried datastreams.json! Structure:\n")
  print(names(data1))
  if (is.data.frame(data1)) {
    print(head(data1[, c("guid", "title", "description")]))
  } else if (is.list(data1)) {
    # If list, print first element
    print(head(data1))
  }
}, error = function(e) {
  cat("Failed to query datastreams.json. Error:", e$message, "\n")
})

# Try the alternate endpoint /Api/datastreams/
tryCatch({
  cat("\nQuerying /Api/datastreams/ with a common test...\n")
  # Let's see if we can find anything or test /api/v2/datasets.json
  req2 <- request("https://datosabiertos.senace.gob.pe/api/v2/datasets.json") %>%
    req_url_query(auth_key = api_key) %>%
    req_perform()
  
  resp2 <- resp_body_string(req2)
  data2 <- fromJSON(resp2)
  cat("Successfully queried datasets.json! Structure:\n")
  if (is.data.frame(data2)) {
    print(head(data2[, c("guid", "title")]))
  } else {
    print(summary(data2))
  }
}, error = function(e) {
  cat("Failed to query datasets.json. Error:", e$message, "\n")
})
