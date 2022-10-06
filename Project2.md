Project2
================
Melanie Kahn & Bennett McAuley
2022-10-02

## Overview

The purpose and overall goal of this project is to create a vignette
about contacting an API using functions we will create to query, parse,
and return data in a well-structured format. These functions will drive
the remainder of the the task, which will involve exploratory data
analysis.

### The Data

We chose to create a vignette to interact with the beer data API by the
[https://www.openbrewerydb.org/faq](Open%20Brewery%20DB) project.

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
    ##  $ date       : POSIXct[1:1], format: "2022-10-06 23:05:30"
    ##  $ times      : Named num [1:6] 0 0.00303 0.01347 0.0493 0.07042 ...
    ##   ..- attr(*, "names")= chr [1:6] "redirect" "namelookup" "connect" "pretransfer" ...
    ##  $ request    :List of 7
    ##   ..- attr(*, "class")= chr "request"
    ##  $ handle     :Class 'curl_handle' <externalptr> 
    ##  - attr(*, "class")= chr "response"
