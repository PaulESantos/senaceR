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

## Examples

``` r
senace_gastos_generica(offline = TRUE)
#> # A tibble: 48 × 8
#>    AÑO   GENERICA                  PIM CERTIFICADO COMPROMETIDO DEVENGADO GIRADO
#>    <chr> <chr>                   <dbl>       <dbl>        <dbl>     <dbl>  <dbl>
#>  1 2026  "2.1 PERSONAL Y OBLIG… 3.62e7      71126.           0         0  0     
#>  2 2026  "2.3 BIENES Y SERVICI… 1.70e7    6463434.        9000     15000  0     
#>  3 2026  "2.4 DONACIONES Y TRA… 7.17e4          0            0         0  0     
#>  4 2026  "2.5 OTROS GASTOS    … 8.96e4          0            0         0  0     
#>  5 2025  "2.1 PERSONAL Y OBLIG… 3.40e7   33168972.    32944112. 32923743. 3.26e7
#>  6 2025  "2.3 BIENES Y SERVICI… 1.93e7   18068079.    18013487. 18001066. 1.78e7
#>  7 2025  "2.4 DONACIONES Y TRA… 6.49e4      54375        54375     54375  5.44e4
#>  8 2025  "2.5 OTROS GASTOS    … 2.24e5     126462.      126462.   126462. 1.26e5
#>  9 2025  "2.6 ADQUISICION DE A… 2.82e6    2532815.     2532814.  2532814. 2.53e6
#> 10 2024  "2.1 PERSONAL Y OBLIG… 2.67e7   26661030.    26661023. 26661023. 2.67e7
#> # ℹ 38 more rows
#> # ℹ 1 more variable: PORC_EJECUCION <dbl>
```
