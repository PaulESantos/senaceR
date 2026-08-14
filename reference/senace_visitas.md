# Retrieve the Institutional Visits Register

Downloads records of visits to SENACE offices or retrieves their bundled
local snapshot.

## Usage

``` r
senace_visitas(api_key = NULL, offline = FALSE)
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
senace_visitas(offline = TRUE)
#> # A tibble: 57,021 × 14
#>    NOMBRE_COMPLETO      NRO_DOCUMENTO TIPO_INSTITUCION ENTIDAD SEDE  TIPO_VISITA
#>    <chr>                <chr>         <chr>            <chr>   <chr> <chr>      
#>  1 RIMAC DAMIAN, JULIO… 44205427      PRIVADA          MUNICI… SEDE… INSTITUCIO…
#>  2 GUERRA SANDILLAN, J… 42019553      PRIVADA          MUNICI… SEDE… INSTITUCIO…
#>  3 SIGUEÑAS PAUCAR, YO… 73070164      PRIVADA          MUNICI… SEDE… INSTITUCIO…
#>  4 PALACIOS LAGUNA, CH… 40660222      PRIVADA          MUNICI… SEDE… INSTITUCIO…
#>  5 VALENCIA RINCON, JU… 08679607      PRIVADA          MUNICI… SEDE… INSTITUCIO…
#>  6 SALAZAR SOLIS, INOC… 32303862      PRIVADA          MUNICI… SEDE… INSTITUCIO…
#>  7 DOMINGUEZ ASENCIOS,… 80177071      PRIVADA          MUNICI… SEDE… INSTITUCIO…
#>  8 FIERRO NAVARRO, LIS… 43817137      PRIVADA          MUNICI… SEDE… INSTITUCIO…
#>  9 SOLIS COLANA, JAVIE… 10092835      PRIVADA          TRAPER… SEDE… PARTICULAR 
#> 10 MORENO PEÑA, CARLOS… 46968830      PRIVADA          C.D. C… SEDE… PARTICULAR 
#> # ℹ 57,011 more rows
#> # ℹ 8 more variables: NOMBRE_EMPLEADO <chr>, NOMBRE_OFICINA <chr>,
#> #   NOMBRE_CARGO <chr>, NOMBRE_LUGAR_ATENCION <chr>, MOTIVO <chr>,
#> #   FECHA_VISITA <chr>, HORA_INGRESO <chr>, HORA_SALIDA <chr>
```
