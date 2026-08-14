# Retrieve the active SENACE API key

Looks for an API key in the `SENACE_API_KEY` environment variable and
then in the `senace.api_key` global option. An informative error is
raised if no key is available.

## Usage

``` r
senace_api_key()
```

## Value

A character string containing the SENACE API key.

## Examples

``` r
senace_set_key("my_api_key")
#> SENACE API key stored in the session environment.
senace_api_key()
#> [1] "my_api_key"
```
