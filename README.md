# senaceR: Programmatic Access to SENACE Open Data

`senaceR` provides an R interface to the [SENACE Open Data Portal](https://datosabiertos.senace.gob.pe), operated by Peru's National Service for Environmental Certification of Sustainable Investments. It retrieves the portal's official datastreams as tibbles and includes local snapshots for offline exploration.

## Features

- Live access to the eight SENACE datastreams using a personal API key.
- Tidy tabular output returned as `tibble` objects.
- Bundled local snapshots for offline work and an automatic fallback when the API cannot be reached.

## Installation

Install the package locally from R or RStudio:

```R
# Install from the local project directory
devtools::install("D:/senaceR")
```

---

## API key setup

To download current data, register for a personal API key at the [SENACE Open Data Portal](https://datosabiertos.senace.gob.pe). Set it for the current R session with:

1. Regístrate en el Portal de Datos Abiertos de SENACE: [https://datosabiertos.senace.gob.pe](https://datosabiertos.senace.gob.pe)
2. Dirígete a la sección de tu perfil o documentación de API y copia tu clave personal (`auth_key`).
3. En tu sesión de R, configúrala de la siguiente forma:

```R
library(senaceR)

# Store the key for the current session
senace_set_key("tu_clave_de_api_aquí")
```

To make the key available across sessions, add the following line to your `.Renviron` file (replacing the placeholder):

```text
SENACE_API_KEY=your_api_key
```

---

## Usage

### List available datasets

List the datastreams documented by the portal:

```R
library(senaceR)

datasets <- senace_list_datasets()
print(datasets)
```

This returns a tibble with each datastream identifier and its title and description. The last two columns retain their Spanish names (`titulo` and `descripcion`) for backwards compatibility.

### Download current data

After configuring an API key, use a dataset-specific helper:

```R
# Download the current project portfolio
proyectos <- senace_cartera_proyectos()
head(proyectos)

# Download the current consulting-firms register
consultoras <- senace_consultoras_ambientales()
head(consultoras)
```

### Use bundled offline data

Use `offline = TRUE` to explicitly use the snapshot packaged with `senaceR`:

```R
# Load the packaged project-portfolio snapshot
proyectos_offline <- senace_cartera_proyectos(offline = TRUE)
head(proyectos_offline)
```

---

## Available dataset helpers

The package provides these convenience functions:

| Function | API datastream | Description |
| :--- | :--- | :--- |
| `senace_cartera_proyectos()` | `CarteraProyectos` | SENACE project portfolio and review status |
| `senace_consultoras_ambientales()` | `ConsultorasAmbientales` | Authorized environmental consulting firms |
| `senace_gastos_especifica()` | `GastoEspecifica` | Expenditure by detailed classifier |
| `senace_gastos_fuente()` | `GastoFuente` | Expenditure by funding source |
| `senace_gastos_generica()` | `GastoGenerica` | Expenditure by generic classifier |
| `senace_solicitudes_acceso()` | `SolicitudAcceso` | Public information access requests and their status |
| `senace_visitas()` | `Visitas` | Institutional visitor records |
| `senace_reclamos()` | `Reclamos` | Complaints and claims records |

---

## Updating bundled snapshots

To update the local data distributed with the package, set `SENACE_API_KEY` and run `data-raw/update_packaged_data.R`. The script downloads the current data and creates optimized `.rda` files in `data/`.
