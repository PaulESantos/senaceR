# Retrieve expenditure by detailed classifier

Downloads detailed budget expenditure data from the REST API.

## Usage

``` r
senace_gastos_especifica(api_key = NULL)
```

## Arguments

- api_key:

  A SENACE API key. If `NULL`, it is retrieved automatically.

## Value

A tibble with daily and annual budget expenditure records by detailed
classifier.

## Examples

``` r
if (FALSE) { # \dontrun{
senace_gastos_especifica()
} # }
```
