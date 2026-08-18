
<!-- README.md is generated from README.Rmd. Please edit that file -->

# senaceR: Programmatic Access to SENACE Open Data

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/PaulESantos/senaceR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/PaulESantos/senaceR/actions/workflows/R-CMD-check.yaml)
[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

`senaceR` provides an R interface to the official [SENACE Open Data
Portal](https://datosabiertos.senace.gob.pe), operated by Peru’s
National Service for Environmental Certification of Sustainable
Investments (*Servicio Nacional de Certificación Ambiental para las
Inversiones Sostenibles*).

It retrieves official REST API datastreams directly into tidy R data
structures (`tibble`).

------------------------------------------------------------------------

## Key Features

- **Direct REST API Integration:** Access SENACE’s active live endpoints
  using your personal API key (`auth_key`).
- **Tidy Tabular Data:** All responses are automatically formatted as
  modern `tibble` objects.
- **Unified Datastreams:** Consolidates subdivided web portal views
  (e.g. 10 sector views for consulting firms) into clean, unified master
  datasets.

------------------------------------------------------------------------

## Installation

You can install the released version of `senaceR` from CRAN with:

``` r
# install.packages("senaceR")
```

Or install the development version from GitHub:

``` r
# install.packages("pak")
pak::pak("PaulESantos/senaceR")
```

------------------------------------------------------------------------

## API Key Setup / Configuración de la API Key

To download live, up-to-date data, you need a personal API key from the
SENACE Open Data Portal.

### Español

1.  Regístrate en el Portal de Datos Abiertos de SENACE:
    <https://datosabiertos.senace.gob.pe>
2.  Dirígete a la sección de tu perfil o documentación de API y copia tu
    clave personal (`auth_key`).
3.  Configúrala en tu sesión de R:

``` r
library(senaceR)

# Configurar clave para la sesión actual
senace_set_key("tu_clave_api_aqui")
```

### English

Register at <https://datosabiertos.senace.gob.pe>, retrieve your
personal API key (`auth_key`), and configure it in your R session:

``` r
library(senaceR)

# Set API key for current session
senace_set_key("your_api_key_here")
```

To make your API key persistent across R sessions, add `SENACE_API_KEY`
to your `.Renviron` file:

``` text
SENACE_API_KEY=your_api_key_here
```

------------------------------------------------------------------------

## Usage

### 1. List Available Datasets

View all official datastreams provided by the SENACE REST API:

``` r
library(senaceR)

datasets <- senace_list_datasets()
print(datasets)
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

### 2. Download Active Datasets

Once your API key is configured, use helper functions to fetch active
data directly from the REST API:

``` r
# Retrieve the Sustainable Investment Project Portfolio
proyectos <- senace_cartera_proyectos()
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

# Retrieve the Environmental Consulting Firms Register
consultoras <- senace_consultoras_ambientales()
head(consultoras)
#> # A tibble: 6 × 8
#>   RAZON_SOCIAL            SUBSECTOR ACTIVIDAD TIPO_SOLICITUD RESOLUCION FECHA_RD
#>   <chr>                   <chr>     <chr>     <chr>          <chr>      <chr>   
#> 1 "\" URBANA CONSULTORES… PESCA Y … ACUICULT… MODIFICACIÓN   RD N° 001… 19/12/2…
#> 2 "\" URBANA CONSULTORES… SALUD     RESIDUOS… INSCRIPCIÓN    3534-2020… 04/09/2…
#> 3 "\" URBANA CONSULTORES… AGRICULT… AGRICULT… INSCRIPCIÓN    SENACE-20… 03/08/2…
#> 4 "\" URBANA CONSULTORES… TRANSPOR… TRANSPOR… INSCRIPCIÓN    SENACE-20… 28/10/2…
#> 5 "\" URBANA CONSULTORES… MINERIA   MINERIA   INSCRIPCIÓN    SENACE-20… 03/12/2…
#> 6 "\" URBANA CONSULTORES… ENERGIA   ELECTRIC… INSCRIPCIÓN    SENACE-20… 28/10/2…
#> # ℹ 2 more variables: INICIO_VIGENCIA_RD <chr>, FIN_VIGENCIA_RD <chr>

# Retrieve Public Information Access Requests
solicitudes <- senace_solicitudes_acceso()
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

## Architecture: API Datastreams vs. Web Catalog

While the SENACE Web Portal lists **22 items** in its online catalog,
the official REST API consolidates these into **8 core Datastreams**:

- **Project Portfolio (3 web views → 1 API Datastream):** The portal
  breaks projects into separate pages (*Approved*, *Under Evaluation*,
  *Disapproved*). The API datastream `CarteraProyectos` returns all
  projects in a single table.
- **Consulting Firms (10 web views → 1 API Datastream):** The portal
  lists firms by individual subsector (*Agriculture, Mining, Energy,
  Transport, etc.*). The API datastream `ConsultorasAmbientales`
  consolidates all registered firms across all subsectors.
- **Web-Only Views:** Items such as *Especialistas*, *Participación
  Ciudadana*, and *Viáticos* are web-only portal displays without
  dedicated public REST API endpoints.

------------------------------------------------------------------------

## Available Dataset Helpers

| Function | Datastream ID | Description |
|:---|:---|:---|
| `senace_cartera_proyectos()` | `CarteraProyectos` | Sustainable Investment Project Portfolio & evaluation status |
| `senace_consultoras_ambientales()` | `ConsultorasAmbientales` | Authorized environmental consulting firms across all subsectors |
| `senace_gastos_especifica()` | `GastoEspecifica` | Daily and annual budget expenditure by detailed classifier |
| `senace_gastos_fuente()` | `GastoFuente` | Budget expenditure summarized by funding source |
| `senace_gastos_generica()` | `GastoGenerica` | Budget expenditure grouped by generic classifier |
| `senace_solicitudes_acceso()` | `SolicitudAcceso` | Public information access requests and status |
| `senace_visitas()` | `Visitas` | Institutional visitor and meeting records |
| `senace_reclamos()` | `Reclamos` | Complaints and claims submitted by the public |

------------------------------------------------------------------------

## License & Data Attribution

### Software License

The `senaceR` package source code is licensed under the [MIT
License](LICENSE).

### Data Source & Terms of Use

The datasets accessed through this package are published by the
**Servicio Nacional de Certificación Ambiental para las Inversiones
Sostenibles (SENACE)** of Peru via its official Open Data Portal
(<https://datosabiertos.senace.gob.pe>).

In accordance with Peru’s National Open Data Strategy (*Decreto Supremo
N° 016-2017-PCM*), public sector open data is available for free public
use, redistribution, and analysis, requiring proper source attribution
to SENACE.

### Citing `senaceR` and SENACE Data

To cite `senaceR` or the underlying SENACE datasets in academic research
or reports, run:

``` r
citation("senaceR")
#> To cite senaceR or the SENACE open data in publications, please use:
#> 
#>   Santos Andrade, P. E. (2026). senaceR: Programmatic Access to SENACE
#>   Open Data. R package version 0.1.0. URL:
#>   https://paulesantos.github.io/senaceR/
#> 
#>   Servicio Nacional de Certificación Ambiental para las Inversiones
#>   Sostenibles - SENACE. (2026). Portal de Datos Abiertos del SENACE
#>   [Data set]. Ministerio del Ambiente, Perú. URL:
#>   https://datosabiertos.senace.gob.pe/
#> 
#> To see these entries in BibTeX format, use 'print(<citation>,
#> bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```
