# Retrieve the Environmental Consulting Firms Register

Downloads the register of environmental consulting firms authorized by
SENACE or retrieves its bundled local snapshot.

## Usage

``` r
senace_consultoras_ambientales(api_key = NULL, offline = FALSE)
```

## Arguments

- api_key:

  A SENACE API key. If `NULL`, it is retrieved automatically.

- offline:

  If `TRUE`, use the dataset bundled with the package instead of
  querying the API.

## Value

A tibble.
