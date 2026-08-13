# senaceR: Programmatic Access to SENACE Open Data

[![R-CMD-check](https://github.com/PaulESantos/senaceR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/PaulESantos/senaceR/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

`senaceR` provides an R interface to the official [SENACE Open Data Portal](https://datosabiertos.senace.gob.pe), operated by Peru's National Service for Environmental Certification of Sustainable Investments (*Servicio Nacional de Certificación Ambiental para las Inversiones Sostenibles*). 

It retrieves official REST API datastreams directly into tidy R data structures (`tibble`) and bundles compressed local snapshots for offline analysis and resilient fallback operation.

---

## Key Features

- **Direct REST API Integration:** Access SENACE's live endpoints using your personal API key (`auth_key`).
- **Tidy Tabular Data:** All responses are automatically formatted as modern `tibble` objects.
- **Offline & Fallback Mode:** Includes pre-packaged, compressed local datasets (`LazyData`). If the live API is unreachable, `senaceR` gracefully falls back to bundled snapshots with an informative warning.
- **Unified Datastreams:** Consolidates subdivided web portal views (e.g. 10 sector views for consulting firms) into clean, unified master datasets.

---

## Installation

You can install the development version of `senaceR` directly from GitHub or from a local source repository:

```R
# Install from GitHub
# install.packages("remotes")
remotes::install_github("PaulESantos/senaceR")

# Or install from local directory
devtools::install("d:/senaceR")
```

---

## API Key Setup / Configuración de la API Key

To download live, up-to-date data, you need a personal API key from the SENACE Open Data Portal.

### Español
1. Regístrate en el Portal de Datos Abiertos de SENACE: [https://datosabiertos.senace.gob.pe](https://datosabiertos.senace.gob.pe)
2. Dirígete a la sección de tu perfil o documentación de API y copia tu clave personal (`auth_key`).
3. Configúrala en tu sesión de R:

```R
library(senaceR)

# Configurar clave para la sesión actual
senace_set_key("tu_clave_api_aqui")
```

### English
Register at [https://datosabiertos.senace.gob.pe](https://datosabiertos.senace.gob.pe), retrieve your personal API key (`auth_key`), and configure it in your R session:

```R
library(senaceR)

# Set API key for current session
senace_set_key("your_api_key_here")
```

To make your API key persistent across R sessions, add `SENACE_API_KEY` to your `.Renviron` file:

```text
SENACE_API_KEY=your_api_key_here
```

---

## Usage

### 1. List Available Datasets

View all official datastreams provided by the SENACE REST API:

```R
library(senaceR)

datasets <- senace_list_datasets()
print(datasets)
```

### 2. Download Live Datasets

Once your API key is configured, use helper functions to fetch live data:

```R
# Retrieve the Sustainable Investment Project Portfolio
proyectos <- senace_cartera_proyectos()
head(proyectos)

# Retrieve the Environmental Consulting Firms Register
consultoras <- senace_consultoras_ambientales()
head(consultoras)

# Retrieve Public Information Access Requests
solicitudes <- senace_solicitudes_acceso()
head(solicitudes)
```

### 3. Use Bundled Offline Data

To work offline or perform fast exploratory analysis without network requests, set `offline = TRUE`:

```R
# Load packaged project portfolio snapshot
proyectos_offline <- senace_cartera_proyectos(offline = TRUE)

# Load packaged environmental consulting firms snapshot
consultoras_offline <- senace_consultoras_ambientales(offline = TRUE)
```

If `offline = FALSE` (default) and the live SENACE API cannot be reached, `senaceR` will automatically issue a warning and load the bundled offline snapshot as a resilient fallback.

---

## Architecture: API Datastreams vs. Web Catalog

While the SENACE Web Portal lists **22 items** in its online catalog, the official REST API consolidates these into **8 core Datastreams**:

- **Project Portfolio (3 web views → 1 API Datastream):** The portal breaks projects into separate pages (*Approved*, *Under Evaluation*, *Disapproved*). The API datastream `CarteraProyectos` returns all projects in a single table.
- **Consulting Firms (10 web views → 1 API Datastream):** The portal lists firms by individual subsector (*Agriculture, Mining, Energy, Transport, etc.*). The API datastream `ConsultorasAmbientales` consolidates all registered firms across all subsectors.
- **Web-Only Views:** Items such as *Especialistas*, *Participación Ciudadana*, and *Viáticos* are web-only portal displays without dedicated public REST API endpoints.

---

## Available Dataset Helpers

| Function | Datastream ID | Description |
| :--- | :--- | :--- |
| [`senace_cartera_proyectos()`](file:///d:/senaceR/R/datasets.R#L11) | `CarteraProyectos` | Sustainable Investment Project Portfolio & evaluation status |
| [`senace_consultoras_ambientales()`](file:///d:/senaceR/R/datasets.R#L24) | `ConsultorasAmbientales` | Authorized environmental consulting firms across all subsectors |
| [`senace_gastos_especifica()`](file:///d:/senaceR/R/datasets.R#L37) | `GastoEspecifica` | Daily and annual budget expenditure by detailed classifier |
| [`senace_gastos_fuente()`](file:///d:/senaceR/R/datasets.R#L50) | `GastoFuente` | Budget expenditure summarized by funding source |
| [`senace_gastos_generica()`](file:///d:/senaceR/R/datasets.R#L63) | `GastoGenerica` | Budget expenditure grouped by generic classifier |
| [`senace_solicitudes_acceso()`](file:///d:/senaceR/R/datasets.R#L76) | `SolicitudAcceso` | Public information access requests and status |
| [`senace_visitas()`](file:///d:/senaceR/R/datasets.R#L89) | `Visitas` | Institutional visitor and meeting records |
| [`senace_reclamos()`](file:///d:/senaceR/R/datasets.R#L102) | `Reclamos` | Complaints and claims submitted by the public |

---

## Updating Local Data Snapshots

For developers maintaining `senaceR`, local `.rda` files in `data/` can be refreshed by setting your `SENACE_API_KEY` and running the script:

```R
source("data-raw/update_packaged_data.R")
```

This script downloads the latest datastreams and regenerates `xz`-compressed local datasets.

---

## License

This project is licensed under the [MIT License](LICENSE).
