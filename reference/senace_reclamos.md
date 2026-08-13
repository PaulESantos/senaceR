# Retrieve the Complaints and Claims Register

Downloads complaints and claims submitted by the public or retrieves
their bundled local snapshot.

## Usage

``` r
senace_reclamos(api_key = NULL, offline = FALSE)
```

## Arguments

- api_key:

  A SENACE API key. If `NULL`, it is retrieved automatically.

- offline:

  If `TRUE`, use the dataset bundled with the package instead of
  querying the API.

## Value

A tibble.
