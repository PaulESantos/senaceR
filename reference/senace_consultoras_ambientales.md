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

## Examples

``` r
senace_consultoras_ambientales(offline = TRUE)
#> # A tibble: 14,187 × 8
#>    RAZON_SOCIAL           SUBSECTOR ACTIVIDAD TIPO_SOLICITUD RESOLUCION FECHA_RD
#>    <chr>                  <chr>     <chr>     <chr>          <chr>      <chr>   
#>  1 "\" URBANA CONSULTORE… PESCA Y … ACUICULT… MODIFICACIÓN   RD N° 001… 19/12/2…
#>  2 "\" URBANA CONSULTORE… SALUD     RESIDUOS… INSCRIPCIÓN    3534-2020… 04/09/2…
#>  3 "\" URBANA CONSULTORE… TRANSPOR… TRANSPOR… INSCRIPCIÓN    SENACE-20… 28/10/2…
#>  4 "\" URBANA CONSULTORE… MINERIA   MINERIA   INSCRIPCIÓN    SENACE-20… 03/12/2…
#>  5 "\" URBANA CONSULTORE… ENERGIA   ELECTRIC… INSCRIPCIÓN    SENACE-20… 28/10/2…
#>  6 "\" URBANA CONSULTORE… ENERGIA   HIDROCAR… INSCRIPCIÓN    SENACE-20… 03/12/2…
#>  7 "\" URBANA CONSULTORE… AGRICULT… AGRICULT… INSCRIPCIÓN    SENACE-20… 03/08/2…
#>  8 "\" URBANA CONSULTORE… PESCA Y … ACUICULT… INSCRIPCIÓN    RD N° 001… 17/12/2…
#>  9 "\" URBANA CONSULTORE… PESCA Y … PESCA     MODIFICACIÓN   RD N° 001… 19/12/2…
#> 10 "\" URBANA CONSULTORE… PESCA Y … PESCA     INSCRIPCIÓN    RD N° 001… 17/12/2…
#> # ℹ 14,177 more rows
#> # ℹ 2 more variables: INICIO_VIGENCIA_RD <chr>, FIN_VIGENCIA_RD <chr>
```
