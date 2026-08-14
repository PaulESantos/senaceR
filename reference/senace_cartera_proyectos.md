# Retrieve the Sustainable Investment Project Portfolio

Downloads the SENACE project portfolio or retrieves its bundled local
snapshot.

## Usage

``` r
senace_cartera_proyectos(api_key = NULL, offline = FALSE)
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
senace_cartera_proyectos(offline = TRUE)
#> # A tibble: 2,567 × 13
#>       ID TITULAR           RUC   TITULO_PROYECTO UNIDAD_PROYECTO TIPO  ACTIVIDAD
#>    <int> <chr>             <chr> <chr>           <chr>           <chr> <chr>    
#>  1     7 AUTOPISTA DEL NO… 2052… "PROYECTO “REH… EVAP PROYECTO … Clas… Transpor…
#>  2     2 COMPAÑÍA MINERA … 2013… "MEIA PARA LA … U.M. SANTA MAR… MEIA… Minería  
#>  3     3 COMPAÑÍA MINERA … 2019… "SEGUNDA MODIF… PALLANCATA      MEIA… Minería  
#>  4     4 PROYECTO ESPECIA… 2027… "IGAPRO PARA L… PROYECTO CONTR… IGAP… Agricult…
#>  5     5 DOE RUN PERÚ S.R… 2037… "IMPLEMENTACIÓ… COBRIZA         ITS   Minería  
#>  6     6 COMPAÑIA MINERA … 2010… "MEIA DEL PROY… SAN VICENTE     MEIA… Minería  
#>  7    20 MINERA BARRICK M… 2020… "ITS PARA LA O… U.M. LAGUNAS N… ITS   Minería  
#>  8    21 ACQUA ENERGÍA S.… 2055… "\"LÍNEA DE TR… L.T. MIRAFLORE… Clas… Electric…
#>  9    22 EMPRESA MUNICIPA… 2010… "\"CREACIÓN DE… SIN UNIDAD      Clas… Transpor…
#> 10    23 GOBIERNO REGIONA… 2048… "EVAP DEL PROY… SIN UNIDAD      Clas… Agricult…
#> # ℹ 2,557 more rows
#> # ℹ 6 more variables: FECHA_INICIO <chr>, ESTADO <chr>, DESCRIPCION <chr>,
#> #   LONGITUD <dbl>, LATITUD <dbl>, RESOLUCION <chr>
```
