# Retrieve the Sustainable Investment Project Portfolio

Downloads the SENACE project portfolio from the REST API.

## Usage

``` r
senace_cartera_proyectos(api_key = NULL)
```

## Arguments

- api_key:

  A SENACE API key. If `NULL`, it is retrieved automatically.

## Value

A tibble with project portfolio records and evaluation status.

## Examples

``` r
if (FALSE) { # \dontrun{
senace_cartera_proyectos()
} # }
```
