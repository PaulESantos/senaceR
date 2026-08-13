# List datasets available from SENACE

Returns the datastreams documented by the SENACE Open Data Portal.

## Usage

``` r
senace_list_datasets()
```

## Value

A tibble with datastream identifiers, titles, and descriptions. The
column names `titulo` and `descripcion` are retained for backwards
compatibility.

## Examples

``` r
senace_list_datasets()
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
