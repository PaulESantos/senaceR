# Retrieve public information access requests

Downloads public information access requests or retrieves their bundled
local snapshot.

## Usage

``` r
senace_solicitudes_acceso(api_key = NULL, offline = FALSE)
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
senace_solicitudes_acceso(offline = TRUE)
#> # A tibble: 9,247 × 9
#>    NRO_EXPEDIENTE NRO_DOC_IDENTIDAD NOMBRE_COMPLETO_CIUDADANO    FECHA_SOLICITUD
#>    <chr>          <chr>             <chr>                        <chr>          
#>  1 ""             44031571          RIVERA RIOS LEYDI DIANA SUS… "31/03/2026   …
#>  2 "2026-0000894" 70503356          NEYRA QUIJANDRIA HERNAN FAB… "02/03/2026   …
#>  3 "2026-0000889" 75924703          VASQUEZ LIMO MILAGROS GERAL… "28/02/2026   …
#>  4 ""             73320307          LÓPEZ JULCARIMA ELSA ELIZAB… "27/02/2026   …
#>  5 "2026-0000872" 70509526          ALVAREZ VICAÑO JOCSAN        "27/02/2026   …
#>  6 "2026-0000883" 74822818          MUÑOZ GALINDO TERESA DIANA   "27/02/2026   …
#>  7 "2026-0000884" 46709777          TORRES PEREZ KATTIA SUSAN    "27/02/2026   …
#>  8 "2026-0000887" 73107665          DE LA CRUZ SALAZAR LUIS IVAN "27/02/2026   …
#>  9 "2026-0000888" 70974939          PERALES CACERES PAUL RENZO   "27/02/2026   …
#> 10 ""             76612365          SANCHEZ CHAVEZ NAOMI ANTUAN… "26/02/2026   …
#> # ℹ 9,237 more rows
#> # ℹ 5 more variables: SOLICTUD <chr>, OBSERVACION <chr>, FECHA_ATENCION <chr>,
#> #   ESTADO_SOLICITUD <chr>, ESTADO_ATENCION <chr>
```
