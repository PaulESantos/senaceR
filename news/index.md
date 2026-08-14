# Changelog

## senaceR 0.1.0

- Initial release of `senaceR`.
- Provides programmatic access to the SENACE Open Data Portal REST API
  in Peru (<https://datosabiertos.senace.gob.pe>).
- Includes helper functions for 8 core datastreams:
  - [`senace_cartera_proyectos()`](https://paulesantos.github.io/senaceR/reference/senace_cartera_proyectos.md)
  - [`senace_consultoras_ambientales()`](https://paulesantos.github.io/senaceR/reference/senace_consultoras_ambientales.md)
  - [`senace_gastos_especifica()`](https://paulesantos.github.io/senaceR/reference/senace_gastos_especifica.md)
  - [`senace_gastos_fuente()`](https://paulesantos.github.io/senaceR/reference/senace_gastos_fuente.md)
  - [`senace_gastos_generica()`](https://paulesantos.github.io/senaceR/reference/senace_gastos_generica.md)
  - [`senace_solicitudes_acceso()`](https://paulesantos.github.io/senaceR/reference/senace_solicitudes_acceso.md)
  - [`senace_visitas()`](https://paulesantos.github.io/senaceR/reference/senace_visitas.md)
  - [`senace_reclamos()`](https://paulesantos.github.io/senaceR/reference/senace_reclamos.md)
- Features `offline = TRUE` parameter for querying pre-packaged datasets
  offline without network dependencies.
- Includes automatic fallback functionality when live API requests fail.
