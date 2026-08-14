# Set the SENACE API key

Stores a SENACE API key in the environment of the current R session.

## Usage

``` r
senace_set_key(key)
```

## Arguments

- key:

  A non-empty character string containing a personal API key.

## Value

Invisibly, `NULL`.

## Examples

``` r
senace_set_key("my_api_key")
#> SENACE API key stored in the session environment.
```
