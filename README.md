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
    ##  $ date       : POSIXct[1:1], format: "2022-10-07 17:06:45"
    ##  $ times      : Named num [1:6] 0 0.000051 0.000053 0.000155 0.067129 ...
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
as.data.frame(brew_parsed)
```

    ##                                                  id                                          name brewery_type
    ## 1                        10-56-brewing-company-knox                         10-56 Brewing Company        micro
    ## 2                       10-barrel-brewing-co-bend-1                          10 Barrel Brewing Co        large
    ## 3                       10-barrel-brewing-co-bend-2                          10 Barrel Brewing Co        large
    ## 4                10-barrel-brewing-co-bend-pub-bend               10 Barrel Brewing Co - Bend Pub        large
    ## 5                  10-barrel-brewing-co-boise-boise                  10 Barrel Brewing Co - Boise        large
    ## 6                10-barrel-brewing-co-denver-denver                 10 Barrel Brewing Co - Denver        large
    ## 7                     10-barrel-brewing-co-portland                          10 Barrel Brewing Co        large
    ## 8                    10-barrel-brewing-co-san-diego                          10 Barrel Brewing Co        large
    ## 9               10-torr-distilling-and-brewing-reno                10 Torr Distilling and Brewing        micro
    ## 10                             101-brewery-quilcene                                   101 Brewery      brewpub
    ## 11               101-north-brewing-company-petaluma                     101 North Brewing Company       closed
    ## 12                  105-west-brewing-co-castle-rock                           105 West Brewing Co        micro
    ## 13                                10k-brewing-anoka                                   10K Brewing        micro
    ## 14           10th-district-brewing-company-abington                 10th District Brewing Company        micro
    ## 15                 11-below-brewing-company-houston                      11 Below Brewing Company        micro
    ## 16                         1188-brewing-co-john-day                               1188 Brewing Co      brewpub
    ## 17               12-acres-brewing-company-killeshin                      12 Acres Brewing Company        micro
    ## 18           12-gates-brewing-company-williamsville                      12 Gates Brewing Company      brewpub
    ## 19                  12-west-brewing-company-gilbert                       12 West Brewing Company        micro
    ## 20 12-west-brewing-company-production-facility-mesa 12 West Brewing Company - Production Facility        micro
    ##                         street address_2 address_3          city         state county_province postal_code
    ## 1                400 Brown Cir      <NA>        NA          Knox       Indiana            <NA>       46534
    ## 2                62970 18th St      <NA>        NA          Bend        Oregon            <NA>  97701-9847
    ## 3  1135 NW Galveston Ave Ste B      <NA>        NA          Bend        Oregon            <NA>  97703-2465
    ## 4             62950 NE 18th St      <NA>        NA          Bend        Oregon            <NA>       97701
    ## 5             826 W Bannock St      <NA>        NA         Boise         Idaho            <NA>  83702-5857
    ## 6               2620 Walnut St      <NA>        NA        Denver      Colorado            <NA>  80205-2231
    ## 7          1411 NW Flanders St      <NA>        NA      Portland        Oregon            <NA>  97209-2620
    ## 8                    1501 E St      <NA>        NA     San Diego    California            <NA>  92101-6618
    ## 9                  490 Mill St      <NA>        NA          Reno        Nevada            <NA>       89502
    ## 10       294793 US Highway 101      <NA>        NA      Quilcene    Washington            <NA>  98376-9000
    ## 11         1304 Scott St Ste D      <NA>        NA      Petaluma    California            <NA>  94954-7100
    ## 12                1043 Park St      <NA>        NA   Castle Rock      Colorado            <NA>  80109-1585
    ## 13                2005 2nd Ave      <NA>        NA         Anoka     Minnesota            <NA>  55303-2243
    ## 14           491 Washington St      <NA>        NA      Abington Massachusetts            <NA>  02351-2419
    ## 15           6820 Bourgeois Rd      <NA>        NA       Houston         Texas            <NA>  77066-3107
    ## 16               141 E Main St      <NA>        NA      John Day        Oregon            <NA>  97845-1210
    ## 17              Unnamed Street  Clonmore        NA     Killeshin          <NA>           Laois    R93 X3X8
    ## 18        80 Earhart Dr Ste 20      <NA>        NA Williamsville      New York            <NA>  14221-7804
    ## 19        3000 E Ray Rd Bldg 6      <NA>        NA       Gilbert       Arizona            <NA>  85296-7832
    ## 20                        <NA>      <NA>        NA          Mesa       Arizona            <NA>       85207
    ##          country           longitude           latitude         phone                        website_url
    ## 1  United States          -86.627954          41.289715    6308165790                               <NA>
    ## 2  United States -121.28170597038259  44.08683530625218    5415851007            http://www.10barrel.com
    ## 3  United States -121.32880209261799 44.057564901366796    5415851007                               <NA>
    ## 4  United States        -121.2809536         44.0912109    5415851007                               <NA>
    ## 5  United States         -116.202929          43.618516    2083445870            http://www.10barrel.com
    ## 6  United States        -104.9853655         39.7592508    7205738992                               <NA>
    ## 7  United States        -122.6855056         45.5259786    5032241700            http://www.10barrel.com
    ## 8  United States         -117.129593          32.714813    6195782311                http://10barrel.com
    ## 9  United States        -119.7732015         39.5171702    7755307014              http://www.10torr.com
    ## 10 United States -122.87558226136872 47.823475773720666    3607656485          http://www.101brewery.com
    ## 11 United States -122.66505504468803 38.270293813150886    7077534934        http://www.101northbeer.com
    ## 12 United States        -104.8667206        39.38269495    3033257321      http://www.105westbrewing.com
    ## 13 United States        -93.38952559        45.19812039    7633924753                 http://10KBrew.com
    ## 14 United States        -70.94594149        42.10591754    7813071554 http://www.10thdistrictbrewing.com
    ## 15 United States         -95.5186591         29.9515464    2814442337      http://www.11belowbrewing.com
    ## 16 United States        -118.9218754         44.4146563    5415751188         http://www.1188brewing.com
    ## 17       Ireland        -6.979343891        52.84930763 +353599107299         https://12acresbrewing.ie/
    ## 18 United States                <NA>               <NA>    7169066600      http://www.12gatesbrewing.com
    ## 19 United States                <NA>               <NA>    6023395014       http://www.12westbrewing.com
    ## 20 United States        -111.5860662          33.436188          <NA>                               <NA>
    ##                  updated_at               created_at
    ## 1  2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 2  2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 3  2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 4  2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 5  2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 6  2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 7  2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 8  2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 9  2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 10 2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 11 2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 12 2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 13 2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 14 2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 15 2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 16 2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 17 2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 18 2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 19 2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z
    ## 20 2022-08-20T02:56:08.975Z 2022-08-20T02:56:08.975Z

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
