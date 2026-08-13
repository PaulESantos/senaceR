# Getting Started with senaceR

## Introduction

The `senaceR` package provides programmatic access to open data
published by SENACE (*Servicio Nacional de Certificación Ambiental para
las Inversiones Sostenibles*), the national authority responsible for
evaluating detailed environmental impact assessments for major
investment projects in Peru.

Through its REST API, SENACE exposes datasets covering environmental
certification portfolios, registered consulting firms, institutional
visits, public information requests, and budget execution.

`senaceR` simplifies data access by:

1.  Handling API authentication (`auth_key`).
2.  Formatting JSON API responses into tidy R `tibble` objects.
3.  Bundling local data snapshots for offline work and automatic
    fallback operation.

------------------------------------------------------------------------

## Installation & Setup

Install `senaceR` from GitHub:

``` r

# install.packages("remotes")
remotes::install_github("PaulESantos/senaceR")
```

Load the package in your session:

``` r

library(senaceR)
```

### Configuring your API Key

To access live data from the SENACE API, register for a free account at
<https://datosabiertos.senace.gob.pe> and copy your personal API key
(`auth_key`).

You can set your API key for the current R session:

``` r

senace_set_key("YOUR_PERSONAL_API_KEY")
```

Or store it permanently in your `.Renviron` file:

``` text
SENACE_API_KEY=YOUR_PERSONAL_API_KEY
```

------------------------------------------------------------------------

## Discovering Datastreams

To view all official datastreams available through the API:

``` r

datasets <- senace_list_datasets()
datasets
#> # A tibble: 8 × 3
#>   datastream             titulo                                   descripcion   
#>   <chr>                  <chr>                                    <chr>         
#> 1 CarteraProyectos       Sustainable Investment Project Portfolio Projects with…
#> 2 ConsultorasAmbientales Environmental Consulting Firms Register  Official regi…
#> 3 GastoEspecifica        Expenditure by Detailed Classifier       Daily and ann…
#> 4 GastoFuente            Expenditure by Funding Source            Budget expend…
#> 5 GastoGenerica          Expenditure by Generic Classifier        Budget expend…
#> 6 SolicitudAcceso        Public Information Access Requests       Public inform…
#> 7 Visitas                Institutional Visits Register            Records of vi…
#> 8 Reclamos               Complaints and Claims Register           Complaints an…
```

------------------------------------------------------------------------

## Accessing Datastreams

`senaceR` provides dedicated functions for each datastream. For offline
exploration or when network access is unavailable, pass
`offline = TRUE`:

### 1. Sustainable Investment Project Portfolio

Retrieve the complete status of environmental impact studies evaluated
by SENACE:

``` r

proyectos <- senace_cartera_proyectos(offline = TRUE)
head(proyectos)
#> # A tibble: 6 × 13
#>      ID TITULAR            RUC   TITULO_PROYECTO UNIDAD_PROYECTO TIPO  ACTIVIDAD
#>   <int> <chr>              <chr> <chr>           <chr>           <chr> <chr>    
#> 1     7 AUTOPISTA DEL NOR… 2052… "PROYECTO “REH… EVAP PROYECTO … Clas… Transpor…
#> 2     2 COMPAÑÍA MINERA P… 2013… "MEIA PARA LA … U.M. SANTA MAR… MEIA… Minería  
#> 3     3 COMPAÑÍA MINERA A… 2019… "SEGUNDA MODIF… PALLANCATA      MEIA… Minería  
#> 4     4 PROYECTO ESPECIAL… 2027… "IGAPRO PARA L… PROYECTO CONTR… IGAP… Agricult…
#> 5     5 DOE RUN PERÚ S.R.… 2037… "IMPLEMENTACIÓ… COBRIZA         ITS   Minería  
#> 6     6 COMPAÑIA MINERA S… 2010… "MEIA DEL PROY… SAN VICENTE     MEIA… Minería  
#> # ℹ 6 more variables: FECHA_INICIO <chr>, ESTADO <chr>, DESCRIPCION <chr>,
#> #   LONGITUD <dbl>, LATITUD <dbl>, RESOLUCION <chr>
```

### 2. Environmental Consulting Firms Register

Retrieve authorized environmental consulting firms across all subsectors
(Energy, Mining, Transport, Agriculture, etc.):

``` r

consultoras <- senace_consultoras_ambientales(offline = TRUE)
head(consultoras)
#> # A tibble: 6 × 8
#>   RAZON_SOCIAL            SUBSECTOR ACTIVIDAD TIPO_SOLICITUD RESOLUCION FECHA_RD
#>   <chr>                   <chr>     <chr>     <chr>          <chr>      <chr>   
#> 1 "\" URBANA CONSULTORES… PESCA Y … ACUICULT… MODIFICACIÓN   RD N° 001… 19/12/2…
#> 2 "\" URBANA CONSULTORES… SALUD     RESIDUOS… INSCRIPCIÓN    3534-2020… 04/09/2…
#> 3 "\" URBANA CONSULTORES… TRANSPOR… TRANSPOR… INSCRIPCIÓN    SENACE-20… 28/10/2…
#> 4 "\" URBANA CONSULTORES… MINERIA   MINERIA   INSCRIPCIÓN    SENACE-20… 03/12/2…
#> 5 "\" URBANA CONSULTORES… ENERGIA   ELECTRIC… INSCRIPCIÓN    SENACE-20… 28/10/2…
#> 6 "\" URBANA CONSULTORES… ENERGIA   HIDROCAR… INSCRIPCIÓN    SENACE-20… 03/12/2…
#> # ℹ 2 more variables: INICIO_VIGENCIA_RD <chr>, FIN_VIGENCIA_RD <chr>
```

### 3. Public Information Access Requests

Track transparency and public information requests submitted to SENACE:

``` r

solicitudes <- senace_solicitudes_acceso(offline = TRUE)
head(solicitudes)
#> # A tibble: 6 × 9
#>   NRO_EXPEDIENTE NRO_DOC_IDENTIDAD NOMBRE_COMPLETO_CIUDADANO     FECHA_SOLICITUD
#>   <chr>          <chr>             <chr>                         <chr>          
#> 1 ""             44031571          RIVERA RIOS LEYDI DIANA SUSE… "31/03/2026   …
#> 2 "2026-0000894" 70503356          NEYRA QUIJANDRIA HERNAN FABR… "02/03/2026   …
#> 3 "2026-0000889" 75924703          VASQUEZ LIMO MILAGROS GERALD… "28/02/2026   …
#> 4 ""             73320307          LÓPEZ JULCARIMA ELSA ELIZABE… "27/02/2026   …
#> 5 "2026-0000872" 70509526          ALVAREZ VICAÑO JOCSAN         "27/02/2026   …
#> 6 "2026-0000883" 74822818          MUÑOZ GALINDO TERESA DIANA    "27/02/2026   …
#> # ℹ 5 more variables: SOLICTUD <chr>, OBSERVACION <chr>, FECHA_ATENCION <chr>,
#> #   ESTADO_SOLICITUD <chr>, ESTADO_ATENCION <chr>
```

------------------------------------------------------------------------

## Resilient Offline Fallback

If you query a live dataset (`offline = FALSE`) but the SENACE API
server is down or unreachable, `senaceR` will automatically issue a
warning and load the pre-packaged offline snapshot:

``` r

# Automatic fallback if live API fails
proyectos_live <- senace_cartera_proyectos()
```

------------------------------------------------------------------------

## Conclusion

`senaceR` streamlines environmental data science workflows in Peru by
bridging SENACE’s open data portal directly to R data structures. For
more details on datastream architecture and offline snapshot management,
see
[`vignette("datasets")`](https://paulesantos.github.io/senaceR/articles/datasets.md).
