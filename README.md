ST 558 Project 2
================
Melanie Kahn & Bennett McAuley

-   <a href="#overview" id="toc-overview">Overview</a>
-   <a href="#requirements" id="toc-requirements">Requirements</a>
-   <a href="#the-data" id="toc-the-data">The Data</a>
-   <a href="#function-definitions" id="toc-function-definitions">Function
    Definitions</a>
    -   <a href="#get_ob_dataframe"
        id="toc-get_ob_dataframe">Get_OB_DataFrame</a>
    -   <a href="#get_ob_random" id="toc-get_ob_random">Get_OB_Random</a>
-   <a href="#exploratory-data-analysis"
    id="toc-exploratory-data-analysis">Exploratory Data Analysis</a>

## Overview

The purpose and overall goal of this vignette is provide instruction on
how to contact an API using functions we created to query, parse, and
return data in a well-structured format. These functions drive a basic
exploratory analysis.

This vignette makes use of the beer data API by the [Open Brewery
DB](https://www.openbrewerydb.org/faq) project.

## Requirements

The following packages should be installed and loaded to run the code
successfully:

-   `httr` - Tools for working with URLs and HTTP
-   `jsonlite` - JSON parser and generator for R
-   `tidyverse` - Collection of packages for data science using “tidy
    data”

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
    ##  $ date       : POSIXct[1:1], format: "2022-10-10 18:24:58"
    ##  $ times      : Named num [1:6] 0 0.000046 0.000047 0.000125 0.04003 ...
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
-   `name`
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
-   `address_2`
-   `address_3`
-   `city`
-   `state`
-   `county_province`
-   `postal_code`
-   `country`
-   `longitude` - The vertical distance from an origin point
-   `latitude` - The horizontal distance from an origin point
-   `phone`
-   `website_url`
-   `updated_at`
-   `created_at`

Notice that some of the variables provide useful information that can be
applied to data analysis; some cannot (`website_url`, for instance).
This will be addressed by the functions (*see below*) that will query
the data and return tibbles that are analysis-ready.

[Back to Top](#top)

## Function Definitions

This section is dedicated to showcasing all of the functions go into
contacting the API, querying data, and performing our basic exploratory
analysis.

### Get_OB_DataFrame

The `Get_OB_DataFrame` function contacts the API, runs a query based on
values provided by the user, parses the data from the query, and returns
a tibble with relevant and well-formatted variables. It takes the
following arguments:

-   `size` - The number of breweries to return as observations (default
    is `10`)
-   `search_by` - The category of filtering to be applied to the search.
    Valid options are:
    -   `"city"`
    -   `"state"`
    -   `"country"`
    -   `"type"` (*`brewery_type`, see above for values*)
    -   `"name"`
    -   `"dist"` (\_must be denoted by
        `"<latitude>,<longitude>"`–e.g. `"45,37"`)
-   `input` - The value or term to be searched for

*Note: In testing, it was discovered that the querying functionality is
not case sensitive (i.e. `"raleigh"`, `"Raleigh"`, and `"RALEIGH"` will
all return the same thing), so inputting the values in sentence case is
not necessary. Inputting them in quotations on function call, however,
is.*

``` r
Get_OB_DataFrame <- function(size = 10, search_by, input) {
  if (search_by %in% c("city", "state", "country", "type", "name", "dist")) {
    query <- GET(paste0("https://api.openbrewerydb.org/breweries?by_", search_by, "=", input, "&per_page=", size))
  } else {
    stop("Invalid search category. Please use one of these options: 'city', 'state', 'country', 'type' 'name', or 'dist'.")
  }

  query_parse <- fromJSON(rawToChar(query$content))
  
  dt <- as_tibble(query_parse) %>%
    select(id, name, brewery_type, city, state, county_province, country, latitude, longitude) %>%
    mutate(brewery_type = as.factor(brewery_type), longitude = as.numeric(longitude), latitude = as.numeric(latitude)) %>%
    arrange(name)
  
  return(dt)
}
```

#### Usage Examples:

``` r
Get_OB_DataFrame(size = 50, search_by = "city", input = "Dublin") #returns 50 breweries in cities called 'Dublin'--not just the one in Ireland!
Get_OB_DataFrame(7, "state", "North Carolina") #returns 7 breweries in North Carolina
Get_OB_DataFrame(search_by = "country", input = "South Korea") #returns default number of breweries in South Korea
Get_OB_DataFrame(size = 20, "type", "nano") #return 20 nano breweries
Get_OB_DataFrame(search_by = "name", input = "wine") #returns default number of breweries with the term 'wine' contained within their names
Get_OB_DataFrame(size = 5, "dist", "41.9,12.4") #returns 5 closest breweries (that have non-NA values) to specified coordinates -- Lat 41.9, Long 12.4 (Rome, Italy)
```

[Back to Top](#top)

### Get_OB_Random

`Get_OB_Random` is functionally identical to `Get_OB_DataFrame`, but
instead of the user specifying characteristics they want in the data,
the observations are queried at random based on the following argument:

-   `n` - The number of breweries to return as observations (default is
    `5`). According to the API documentation, the maximum is `50`.

*Note: In testing, it was verified that the randomness in the API is not
really random; there is a seed associated with it as the queries yielded
the same results per value of `n`, regardless of whether a seed was
speicifed in the R environment.*

``` r
Get_OB_Random <- function(n = 5) {
  
  query <- GET(paste0("https://api.openbrewerydb.org/breweries/random?size=", n))

  query_parse <- fromJSON(rawToChar(query$content))
  
  dt <- as_tibble(query_parse) %>%
    select(id, name, brewery_type, city, state, county_province, country, latitude, longitude) %>%
    mutate(brewery_type = as.factor(brewery_type), longitude = as.numeric(longitude), latitude = as.numeric(latitude)) %>%
    arrange(name)
    
  
  return(dt)
}
```

#### Usage Examples

``` r
Get_OB_Random() #returns default number of randomly selected breweries
Get_OB_Random(20) #returns 20 randomly selected breweries
Get_OB_Random(75) #returns 50 randomly selected breweries; API will still execute the query, but caps the number of observations returned at 50
```

[Back to Top](#top)

## Exploratory Data Analysis
