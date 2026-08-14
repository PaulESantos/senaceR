# senaceR 0.1.0

* Initial release of `senaceR`.
* Provides programmatic access to the SENACE Open Data Portal REST API in Peru (<https://datosabiertos.senace.gob.pe>).
* Includes helper functions for 8 core datastreams:
  * `senace_cartera_proyectos()`
  * `senace_consultoras_ambientales()`
  * `senace_gastos_especifica()`
  * `senace_gastos_fuente()`
  * `senace_gastos_generica()`
  * `senace_solicitudes_acceso()`
  * `senace_visitas()`
  * `senace_reclamos()`
* Features `offline = TRUE` parameter for querying pre-packaged datasets offline without network dependencies.
* Includes automatic fallback functionality when live API requests fail.
