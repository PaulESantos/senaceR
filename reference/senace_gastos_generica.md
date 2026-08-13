# Retrieve expenditure by generic classifier

Downloads budget expenditure by generic classifier or retrieves its
bundled local snapshot.

## Usage

``` r
senace_gastos_generica(api_key = NULL, offline = FALSE)
```

## Arguments

- api_key:

  A SENACE API key. If `NULL`, it is retrieved automatically.

- offline:

  If `TRUE`, use the dataset bundled with the package instead of
  querying the API.

## Value

A tibble.
