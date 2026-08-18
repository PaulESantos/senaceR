# Exploring SENACE Datastreams

## Overview

This article explains the dataset architecture of the SENACE Open Data
Portal and how web portal views map to official REST API datastreams.

``` r

library(senaceR)
```

------------------------------------------------------------------------

## Web Portal Catalog vs. REST API Datastreams

Visitors to the [SENACE Open Data
Portal](https://datosabiertos.senace.gob.pe) will notice **22 dataset
items** in the web catalog. However, the official REST API consolidates
these into **8 core Datastreams**:

| Web Portal Catalog Category | Web Items | API Datastream | `senaceR` Helper Function |
|:---|:--:|:---|:---|
| Certificación Ambiental | 3 | `CarteraProyectos` | [`senace_cartera_proyectos()`](https://paulesantos.github.io/senaceR/reference/senace_cartera_proyectos.md) |
| Registros Ambientales | 10 | `ConsultorasAmbientales` | [`senace_consultoras_ambientales()`](https://paulesantos.github.io/senaceR/reference/senace_consultoras_ambientales.md) |
| Transparencia y Atención | 3 | `SolicitudAcceso`, `Visitas`, `Reclamos` | [`senace_solicitudes_acceso()`](https://paulesantos.github.io/senaceR/reference/senace_solicitudes_acceso.md), [`senace_visitas()`](https://paulesantos.github.io/senaceR/reference/senace_visitas.md), [`senace_reclamos()`](https://paulesantos.github.io/senaceR/reference/senace_reclamos.md) |
| Planeamiento y Presupuesto | 3 | `GastoEspecifica`, `GastoFuente`, `GastoGenerica` | [`senace_gastos_especifica()`](https://paulesantos.github.io/senaceR/reference/senace_gastos_especifica.md), [`senace_gastos_fuente()`](https://paulesantos.github.io/senaceR/reference/senace_gastos_fuente.md), [`senace_gastos_generica()`](https://paulesantos.github.io/senaceR/reference/senace_gastos_generica.md) |

### Why the difference?

1.  **Subdivided Web Views:** On the portal interface, SENACE subdivides
    datasets for interactive web browsing. For example, *Consultoras
    Ambientales* is split into 10 separate pages (one per subsector like
    Mining, Electricity, Agriculture). In contrast, the REST API
    delivers the **complete master dataset** in a single query
    (`ConsultorasAmbientales`).
2.  **Filtered Project Views:** The portal displays separate cards for
    Approved, In Evaluation, and Disapproved projects. The API
    datastream `CarteraProyectos` returns all projects across all
    evaluation states.
3.  **Web-Only Displays:** A few web pages (*Especialistas*,
    *Participación Ciudadana*, *Viáticos*) are static portal displays
    without exposed public API endpoints.

------------------------------------------------------------------------

## Complete Datastream Reference

`senaceR` provides dedicated functions for each of the 8 REST API
datastreams:

| Datastream ID | Title | Description |
|:---|:---|:---|
| CarteraProyectos | Sustainable Investment Project Portfolio | Projects within SENACE’s remit, including their review status. |
| ConsultorasAmbientales | Environmental Consulting Firms Register | Official register of organizations authorized to provide environmental consulting services, organized by subsector. |
| GastoEspecifica | Expenditure by Detailed Classifier | Daily and annual budget expenditure broken down by detailed classifier. |
| GastoFuente | Expenditure by Funding Source | Budget expenditure summarized by funding source. |
| GastoGenerica | Expenditure by Generic Classifier | Budget expenditure grouped by generic classifier. |
| SolicitudAcceso | Public Information Access Requests | Public information access requests, including their status and response date. |
| Visitas | Institutional Visits Register | Records of visitors and meetings at SENACE offices. |
| Reclamos | Complaints and Claims Register | Complaints and claims formally submitted by members of the public. |

------------------------------------------------------------------------

## Accessing Datastreams via API

All helper functions query live endpoints directly using your SENACE API
key (`auth_key`). To ensure maximum data accuracy and consistency,
`senaceR` focuses strictly on active API datastreams rather than cached
or local static snapshots.
