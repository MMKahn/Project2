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
    ##  $ date       : POSIXct[1:1], format: "2022-10-08 03:35:22"
    ##  $ times      : Named num [1:6] 0.0 6.3e-05 6.5e-05 2.1e-04 2.2e-02 ...
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
    ##    id     name  brewe…¹ street addre…² addre…³ city  state count…⁴ posta…⁵ country longi…⁶ latit…⁷ phone websi…⁸
    ##    <chr>  <chr> <chr>   <chr>  <chr>   <lgl>   <chr> <chr> <chr>   <chr>   <chr>   <chr>   <chr>   <chr> <chr>  
    ##  1 10-56… 10-5… micro   400 B… <NA>    NA      Knox  Indi… <NA>    46534   United… -86.62… 41.289… 6308… <NA>   
    ##  2 10-ba… 10 B… large   62970… <NA>    NA      Bend  Oreg… <NA>    97701-… United… -121.2… 44.086… 5415… http:/…
    ##  3 10-ba… 10 B… large   1135 … <NA>    NA      Bend  Oreg… <NA>    97703-… United… -121.3… 44.057… 5415… <NA>   
    ##  4 10-ba… 10 B… large   62950… <NA>    NA      Bend  Oreg… <NA>    97701   United… -121.2… 44.091… 5415… <NA>   
    ##  5 10-ba… 10 B… large   826 W… <NA>    NA      Boise Idaho <NA>    83702-… United… -116.2… 43.618… 2083… http:/…
    ##  6 10-ba… 10 B… large   2620 … <NA>    NA      Denv… Colo… <NA>    80205-… United… -104.9… 39.759… 7205… <NA>   
    ##  7 10-ba… 10 B… large   1411 … <NA>    NA      Port… Oreg… <NA>    97209-… United… -122.6… 45.525… 5032… http:/…
    ##  8 10-ba… 10 B… large   1501 … <NA>    NA      San … Cali… <NA>    92101-… United… -117.1… 32.714… 6195… http:/…
    ##  9 10-to… 10 T… micro   490 M… <NA>    NA      Reno  Neva… <NA>    89502   United… -119.7… 39.517… 7755… http:/…
    ## 10 101-b… 101 … brewpub 29479… <NA>    NA      Quil… Wash… <NA>    98376-… United… -122.8… 47.823… 3607… http:/…
    ## 11 101-n… 101 … closed  1304 … <NA>    NA      Peta… Cali… <NA>    94954-… United… -122.6… 38.270… 7077… http:/…
    ## 12 105-w… 105 … micro   1043 … <NA>    NA      Cast… Colo… <NA>    80109-… United… -104.8… 39.382… 3033… http:/…
    ## 13 10k-b… 10K … micro   2005 … <NA>    NA      Anoka Minn… <NA>    55303-… United… -93.38… 45.198… 7633… http:/…
    ## 14 10th-… 10th… micro   491 W… <NA>    NA      Abin… Mass… <NA>    02351-… United… -70.94… 42.105… 7813… http:/…
    ## 15 11-be… 11 B… micro   6820 … <NA>    NA      Hous… Texas <NA>    77066-… United… -95.51… 29.951… 2814… http:/…
    ## 16 1188-… 1188… brewpub 141 E… <NA>    NA      John… Oreg… <NA>    97845-… United… -118.9… 44.414… 5415… http:/…
    ## 17 12-ac… 12 A… micro   Unnam… Clonmo… NA      Kill… <NA>  Laois   R93 X3… Ireland -6.979… 52.849… +353… https:…
    ## 18 12-ga… 12 G… brewpub 80 Ea… <NA>    NA      Will… New … <NA>    14221-… United… <NA>    <NA>    7169… http:/…
    ## 19 12-we… 12 W… micro   3000 … <NA>    NA      Gilb… Ariz… <NA>    85296-… United… <NA>    <NA>    6023… http:/…
    ## 20 12-we… 12 W… micro   <NA>   <NA>    NA      Mesa  Ariz… <NA>    85207   United… -111.5… 33.436… <NA>  <NA>   
    ## # … with 2 more variables: updated_at <chr>, created_at <chr>, and abbreviated variable names ¹​brewery_type,
    ## #   ²​address_2, ³​address_3, ⁴​county_province, ⁵​postal_code, ⁶​longitude, ⁷​latitude, ⁸​website_url

The variables present for each entry in this database are as follows:

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

The `Get_OB_DataFrame` function contacts the API and returns a tibble (a
fancy data frame). It takes the following arguments:

-   `size` - The number of breweries to return as observations
-   `search_by` - The category of filtering to be applied to the search.
    Valid options are `"city"`, `"state"`, `"country"`, `"type"` (*for
    `brewery_type`, see above for values*), and `"name"`
-   `input` - The value or term to be searched for

*Note: In testing, it was discovered that the querying functionality is
not case sensitive (i.e. `"raleigh"`, `"Raleigh"`, and `"RALEIGH"` will
all return the same thing), so inputting the values in sentence case is
not necessary.*

``` r
Get_OB_DataFrame <- function(size, search_by, input) {
  if (search_by %in% c("city", "state", "country", "type", "name")) {
    query <- GET(paste0("https://api.openbrewerydb.org/breweries?by_", search_by, "=", input, "&per_page=", size))
  } else {
    stop("Invalid search category. Please use one of these options: 'city', 'state', 'country', 'type' or 'name'.")
  }

  query_parse <- fromJSON(rawToChar(query$content))
  
  dt <- as_tibble(query_parse) %>%
    select(id, name, brewery_type, street, city, state, county_province, country) %>%
    arrange(name)
  
  return(dt)
}
```
