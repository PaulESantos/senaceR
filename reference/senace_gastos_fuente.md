# Retrieve expenditure by funding source

Downloads budget expenditure summarized by funding source or retrieves
its bundled local snapshot.

## Usage

``` r
senace_gastos_fuente(api_key = NULL, offline = FALSE)
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
senace_gastos_fuente(offline = TRUE)
#> # A tibble: 26 × 8
#>    AÑO   FUENTE_FINANCIAMIENTO     PIM CERTIFICADO COMPROMETIDO DEVENGADO GIRADO
#>    <chr> <chr>                   <dbl>       <dbl>        <dbl>     <dbl>  <dbl>
#>  1 2026  "RECURSOS ORDINARIOS … 5.33e7    6534560.        9000     15000  0     
#>  2 2025  "RECURSOS ORDINARIOS … 5.64e7   53950702.    53671249. 53638459. 5.31e7
#>  3 2024  "RECURSOS ORDINARIOS … 4.97e7   49340245.    49329933. 49329933. 4.95e7
#>  4 2023  "RECURSOS ORDINARIOS … 4.37e7   42822075.    42741694. 42741694. 4.30e7
#>  5 2022  "RECURSOS ORDINARIOS … 3.73e7   36839168.    36837467. 36837467. 3.70e7
#>  6 2022  "RECURSOS DIRECTAMENT… 3.40e6    3109196.     3102613.  3102613. 3.10e6
#>  7 2022  "DONACIONES Y TRANSFE… 2.55e5     233816.      233816.   233816. 2.55e5
#>  8 2021  "RECURSOS ORDINARIOS … 3.59e7   35060387.    35051776. 35051776. 3.51e7
#>  9 2021  "RECURSOS DIRECTAMENT… 3.56e6    2337663.     2329290.  2329290. 2.33e6
#> 10 2021  "DONACIONES Y TRANSFE… 3.22e5      13440        13440     13440  1.34e4
#> # ℹ 16 more rows
#> # ℹ 1 more variable: PORC_EJECUCION <dbl>
```
