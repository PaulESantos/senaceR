# Retrieve data from a SENACE datastream

Sends a GET request to the SENACE Open Data Portal API and returns the
requested datastream.

## Usage

``` r
senace_get_data(guid, api_key = NULL)
```

## Arguments

- guid:

  A single character string identifying the dataset, for example
  `"CarteraProyectos"`.

- api_key:

  A personal SENACE API key. If `NULL`, the key is obtained with
  [`senace_api_key()`](https://paulesantos.github.io/senaceR/reference/senace_api_key.md).

## Value

A tibble containing the datastream data.

## Examples

``` r
if (FALSE) { # \dontrun{
complaints <- senace_get_data("Reclamos")
print(complaints)
} # }
```
