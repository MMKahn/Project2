ST 558 Project 2
================
Melanie Kahn & Bennett McAuley
2022-10-02

# Table of Contents

1.  [The Data](#example)
2.  [Function Definitions](#example2)
3.  [Third Example](#third-example)
4.  [Fourth Example](#fourth-examplehttpwwwfourthexamplecom)

# Overview

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

### The Data

<details>

The brewery data from Open Brewery DB features information on breweries,
cideries, brewpubs, and bottleshops around the world. Using the `GET`
function from the `httr` package, a list of breweries is returned. Let’s
explore the contents to get a better understanding of the structure.

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
    ##  $ date       : POSIXct[1:1], format: "2022-10-07 16:18:48"
    ##  $ times      : Named num [1:6] 0 0.00005 0.000052 0.000129 0.033581 ...
    ##   ..- attr(*, "names")= chr [1:6] "redirect" "namelookup" "connect" "pretransfer" ...
    ##  $ request    :List of 7
    ##   ..- attr(*, "class")= chr "request"
    ##  $ handle     :Class 'curl_handle' <externalptr> 
    ##  - attr(*, "class")= chr "response"

</details>

### Function Definitions

<details>

This section is dedicated to showcasing all of the functions go into
contacting the API, querying data, and performing our basic exploratory
analysis.

#### Get_OB_DataFrame

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
