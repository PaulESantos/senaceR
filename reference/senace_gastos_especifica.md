# Retrieve expenditure by detailed classifier

Downloads detailed budget expenditure data or retrieves its bundled
local snapshot.

## Usage

``` r
senace_gastos_especifica(api_key = NULL, offline = FALSE)
```

## Arguments

- api_key:

  A SENACE API key. If `NULL`, it is retrieved automatically.

- offline:

  If `TRUE`, use the dataset bundled with the package instead of
  querying the API.

## Value

A tibble.

## Examples

``` r
senace_gastos_especifica(offline = TRUE)
#> # A tibble: 3,495 × 11
#>    AÑO   FUENTE_FINANCIAMIENTO  META  GENERICA CLASIFICADOR DETALLE_CLASIFICADOR
#>    <chr> <chr>                  <chr> <chr>    <chr>        <chr>               
#>  1 2026  "RECURSOS ORDINARIOS … 0016  "PERSON… 2.1. 1. 9. … "OTROS BONOS EXTRAO…
#>  2 2026  "RECURSOS ORDINARIOS … 0015  "PERSON… 2.1. 1. 9. … "OTROS BONOS EXTRAO…
#>  3 2026  "RECURSOS ORDINARIOS … 0023  "PERSON… 2.1. 1. 9. … "OTROS BONOS EXTRAO…
#>  4 2026  "RECURSOS ORDINARIOS … 0003  "PERSON… 2.1. 1. 9. … "OTROS BONOS EXTRAO…
#>  5 2026  "RECURSOS ORDINARIOS … 0012  "PERSON… 2.1. 1. 9. … "OTROS BONOS EXTRAO…
#>  6 2026  "RECURSOS ORDINARIOS … 0001  "PERSON… 2.1. 1. 9. … "OTROS BONOS EXTRAO…
#>  7 2026  "RECURSOS ORDINARIOS … 0018  "PERSON… 2.1. 1. 9. … "OTROS BONOS EXTRAO…
#>  8 2026  "RECURSOS ORDINARIOS … 0004  "PERSON… 2.1. 1. 9. … "OTROS BONOS EXTRAO…
#>  9 2026  "RECURSOS ORDINARIOS … 0005  "PERSON… 2.1. 1. 9. … "OTROS BONOS EXTRAO…
#> 10 2026  "RECURSOS ORDINARIOS … 0010  "PERSON… 2.1. 1. 9. … "OTROS BONOS EXTRAO…
#> # ℹ 3,485 more rows
#> # ℹ 5 more variables: PIM <dbl>, CERTIFICADO <dbl>, COMPROMETIDO <dbl>,
#> #   DEVENGADO <dbl>, GIRADO <dbl>
```
