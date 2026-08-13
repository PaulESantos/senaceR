test_that("senace_api_key handles environment variables and options", {
  # Clean env before test
  old_key <- Sys.getenv("SENACE_API_KEY", unset = NA)
  Sys.unsetenv("SENACE_API_KEY")
  
  # Error when no key is set
  expect_error(senace_api_key(), "No SENACE API key was found")
  
  # Set key via helper
  senace_set_key("test_key")
  expect_equal(senace_api_key(), "test_key")
  
  # Set key via options
  Sys.unsetenv("SENACE_API_KEY")
  options(senace.api_key = "option_key")
  expect_equal(senace_api_key(), "option_key")
  
  # Restore env/options
  options(senace.api_key = NULL)
  if (!is.na(old_key)) {
    Sys.setenv(SENACE_API_KEY = old_key)
  } else {
    Sys.unsetenv("SENACE_API_KEY")
  }
})

test_that("senace_list_datasets returns a valid tibble structure", {
  df <- senace_list_datasets()
  expect_s3_class(df, "tbl_df")
  expect_true(all(c("datastream", "titulo", "descripcion") %in% colnames(df)))
  expect_equal(nrow(df), 8)
})

test_that("Client functions validate arguments", {
  expect_error(senace_get_data(character(0)), "Supply a valid")
  expect_error(senace_get_data(""), "Supply a valid")
  expect_error(senace_set_key(""), "API key must be")
})

test_that("Offline fallback fails gracefully if data is missing", {
  # We test the helper function directly
  expect_error(
    get_package_dataset("Reclamos", "non_existent_data_var", "key", offline = TRUE),
    "is not available"
  )
})
