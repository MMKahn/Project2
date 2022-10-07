ST 558 Project 2
================
Melanie Kahn & Bennett McAuley
2022-10-02

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

<details>

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
    ##  $ date       : POSIXct[1:1], format: "2022-10-07 16:29:53"
    ##  $ times      : Named num [1:6] 0 0.000044 0.000045 0.000118 0.042652 ...
    ##   ..- attr(*, "names")= chr [1:6] "redirect" "namelookup" "connect" "pretransfer" ...
    ##  $ request    :List of 7
    ##   ..- attr(*, "class")= chr "request"
    ##  $ handle     :Class 'curl_handle' <externalptr> 
    ##  - attr(*, "class")= chr "response"

</details>

## Function Definitions

This section is dedicated to showcasing all of the functions go into
contacting the API, querying data, and performing our basic exploratory
analysis.

<details>
<summary>
GET_OB_DataFrame
</summary>

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

</details>
