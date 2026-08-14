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

## Examples

``` r
senace_reclamos(offline = TRUE)
#> # A tibble: 59 × 9
#>    NRO_EXPEDIENTE TIPO_DE_RECLAMO   FECHA_RECLAMO NRO_DOCUMENTO_CIUDADANO
#>    <chr>          <chr>             <chr>         <chr>                  
#>  1 ""             LIBRO ELECTRONICO 09/02/2026    41603622               
#>  2 "01990-2022"   LIBRO ELECTRONICO 26/05/2022    19413411               
#>  3 ""             LIBRO ELECTRONICO 13/05/2021    44765477               
#>  4 "01227-2021"   LIBRO ELECTRONICO 19/04/2021    47374258               
#>  5 ""             LIBRO ELECTRONICO 28/10/2020    10054036               
#>  6 ""             LIBRO ELECTRONICO 05/08/2020    29308022               
#>  7 ""             LIBRO ELECTRONICO 20/05/2020    72519008               
#>  8 ""             LIBRO FISICO      21/02/2020    43523442               
#>  9 "00495-2020"   LIBRO ELECTRONICO 14/02/2020    10299824               
#> 10 "00238-2020"   LIBRO ELECTRONICO 23/01/2020    07480548               
#> # ℹ 49 more rows
#> # ℹ 5 more variables: NOMBRE_COMPLETO_CIUDADANO <chr>,
#> #   DESCRIP_INFORMACION <chr>, FECHA_POSIBLE_ATENCION <chr>,
#> #   ESTADO_ATENCION <chr>, DESCRIP_OBSERVACION <chr>
```
