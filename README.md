ST 558 Project 2
================
Melanie Kahn & Bennett McAuley
2022-10-02

-   <a href="#overview" id="toc-overview">Overview</a>
-   <a href="#requirements" id="toc-requirements">Requirements</a>
-   <a href="#the-data" id="toc-the-data">The Data</a>
-   <a href="#function-definitions" id="toc-function-definitions">Function
    Definitions</a>
    -   <a href="#get_ob_dataframe"
        id="toc-get_ob_dataframe">Get_OB_DataFrame</a>

## Overview

The purpose and overall goal of this vignette is to instruct the user on
how to contact an API using functions we created to query, parse, and
return data in a well-structured format. These functions drive a basic
exploratory analysis.

This vignette makes use of the beer data API by the [Open Brewery
DB](https://www.openbrewerydb.org/faq) project.

## Requirements

The following packages are required to run the code properly:

-   `httr`
-   `jsonlite`
-   `tidyverse`

## The Data

This section provides the context and structure of the data to get a
better understanding of the contents of the API.

The brewery data from Open Brewery DB features information on breweries,
cideries, brewpubs, and bottleshops around the world. Using the `GET`
function from the `httr` package, a list of breweries is returned.

``` r
library(httr)
breweries <- GET("https://api.openbrewerydb.org/breweries")
str(breweries, max.level = 1)
```

    ## List of 10
    ##  $ url        : chr "https://api.openbrewerydb.org/breweries"
    ##  $ status_code: int 200
    ##  $ headers    :List of 25
    ##   ..- attr(*, "class")= chr [1:2] "insensitive" "list"
    ##  $ all_headers:List of 1
    ##  $ cookies    :'data.frame': 0 obs. of  7 variables:
    ##  $ content    : raw [1:9168] 5b 7b 22 69 ...
    ##  $ date       : POSIXct[1:1], format:  ...
    ##  $ times      : Named num [1:6] 0 0.000043 0.000044 0.000126 0.042681 ...
    ##   ..- attr(*, "names")= chr [1:6] "redirect" "namelookup" "connect" "pretransfer" ...
    ##  $ request    :List of 7
    ##   ..- attr(*, "class")= chr "request"
    ##  $ handle     :Class 'curl_handle' <externalptr> 
    ##  - attr(*, "class")= chr "response"

This information isn’t very readable, so we will parse it using the
`FromJSON` function from the `jsonlite` package, and represent the
information as a tibble.

``` r
brew_parsed <- fromJSON(rawToChar(breweries$content))
as_tibble(brew_parsed)
```

    ## # A tibble: 20 × 17
    ##    id      name  brewe…¹ street addre…² addre…³ city 
    ##    <chr>   <chr> <chr>   <chr>  <chr>   <lgl>   <chr>
    ##  1 10-56-… 10-5… micro   400 B… <NA>    NA      Knox 
    ##  2 10-bar… 10 B… large   62970… <NA>    NA      Bend 
    ##  3 10-bar… 10 B… large   1135 … <NA>    NA      Bend 
    ##  4 10-bar… 10 B… large   62950… <NA>    NA      Bend 
    ##  5 10-bar… 10 B… large   826 W… <NA>    NA      Boise
    ##  6 10-bar… 10 B… large   2620 … <NA>    NA      Denv…
    ##  7 10-bar… 10 B… large   1411 … <NA>    NA      Port…
    ##  8 10-bar… 10 B… large   1501 … <NA>    NA      San …
    ##  9 10-tor… 10 T… micro   490 M… <NA>    NA      Reno 
    ## 10 101-br… 101 … brewpub 29479… <NA>    NA      Quil…
    ## 11 101-no… 101 … closed  1304 … <NA>    NA      Peta…
    ## 12 105-we… 105 … micro   1043 … <NA>    NA      Cast…
    ## 13 10k-br… 10K … micro   2005 … <NA>    NA      Anoka
    ## 14 10th-d… 10th… micro   491 W… <NA>    NA      Abin…
    ## 15 11-bel… 11 B… micro   6820 … <NA>    NA      Hous…
    ## 16 1188-b… 1188… brewpub 141 E… <NA>    NA      John…
    ## 17 12-acr… 12 A… micro   Unnam… Clonmo… NA      Kill…
    ## 18 12-gat… 12 G… brewpub 80 Ea… <NA>    NA      Will…
    ## 19 12-wes… 12 W… micro   3000 … <NA>    NA      Gilb…
    ## 20 12-wes… 12 W… micro   <NA>   <NA>    NA      Mesa 
    ## # … with 10 more variables: state <chr>,
    ## #   county_province <chr>, postal_code <chr>,
    ## #   country <chr>, longitude <chr>, latitude <chr>,
    ## #   phone <chr>, website_url <chr>,
    ## #   updated_at <chr>, created_at <chr>, and
    ## #   abbreviated variable names ¹​brewery_type,
    ## #   ²​address_2, ³​address_3

The variables present in this database are as follows:

-   `id` - The unique ID of the brewery
-   `name` - The name of the brewery
-   `brewery_type` - The type of brewery; must be one of:
    -   `micro` - Most craft breweries
    -   `nano` - An extremely small brewery that typically only
        distributes locally
    -   `regional` - Regional location of an expanded brewery
    -   `brewpub` - A beer-focused restaurant or bar with a brewery
        on-premise
    -   `planning` - A brewery in planning or not yet opened to the
        public
    -   `contract` - A brewery that uses another brewery’s equipment
    -   `proprietor` - Similiar to contract brewing but refers more to a
        brewery incubator
    -   `closed` - A location that has closed
-   `street` - The street address of the brewery
-   `address_2` -
-   `address_3`
-   `city`
-   `state`
-   `county_province`
-   `postal_code`
-   `country`
-   `longitude` - The distance from an origin point
-   `latitude` - *see `longitude`*
-   `phone`
-   `website_url`
-   `updated_at`
-   `created_at`

## Function Definitions

This section is dedicated to showcasing all of the functions go into
contacting the API, querying data, and performing our basic exploratory
analysis.

### Get_OB_DataFrame

``` r
Get_OB_DataFrame <- function(search_by, input) {
  if (search_by %in% c("city", "state", "country", "type", "name")) {
    query <- GET(paste0("https://api.openbrewerydb.org/breweries?by_", search_by, "=", input))
  } else stop("Invalid search category. Please use one of these options: 'city', 'state', 'country', 'type' or 'name'.")
  
  query_parse <- fromJSON(rawToChar(query$content))
  
  dt <- as_tibble(query_parse) %>%
    select(id, name, brewery_type, street, city, state, county_province, country)
  
  return(dt)
} 
```
