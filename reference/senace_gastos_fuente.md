# Retrieve expenditure by funding source

Downloads budget expenditure summarized by funding source from the REST
API.

## Usage

``` r
senace_gastos_fuente(api_key = NULL)
```

## Arguments

- api_key:

  A SENACE API key. If `NULL`, it is retrieved automatically.

## Value

A tibble with budget expenditure records summarized by funding source.

## Examples

``` r
if (FALSE) { # \dontrun{
senace_gastos_fuente()
} # }
```
