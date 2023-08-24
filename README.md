
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SpotifyProject

## Overview

The “SpotifyProject” package is an R package for utilizing Spotify’s Web
API for developers to pull information on a variety of topics, including
artists, albums, tracks, and genres. By just inputing an artist’s name,
you can gather a ton of fascinating data, including a summary of the
artists danceability, valence, and energy, among many other
measurements!

## Installation

``` r
devtools::install_github("AdamDelRio/SpotifyProject")
```

## Authentication

Firstly, create an account
[here](https://developer.spotify.com/my-applications/#!/applications)
for the Spotify for Developers Web API. After creating an account,
create a dashboard, then check the settings for your client and secret
id.

Then, set both ids in your environment, as the function
get_spotify_access_token() pulls these varaibles from the environment.
Alternatively, you can pass these varaibles into the function manually
and store the returned string, but remember to include this new varible
in all function calls.

``` r
Sys.setenv(SPOTIFY_CLIENT_ID = "xxxxxxxxxxxxxxxxxxxxx")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "xxxxxxxxxxxxxxxxxxxxx")
#OR
access_token <- get_spotify_access_token(SPOTIFY_CLIENT_ID = "xxxxxxxxxxxxxxxxxxxxx", 
                                         SPOTIFY_CLIENT_SECRET = "xxxxxxxxxxxxxxxxxxxxx")
```

## Usage

``` r
Sys.setenv(SPOTIFY_CLIENT_ID = "9b791d794b834a379a7fb31fee32431d")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "b582eccc019f4ab4aea3fdda49c0fb69")
```

### Which One Direction Member Is The Most Danceable?

``` r
library(SpotifyProject)
library(knitr)
library(tidyverse)
```

``` r
members <- get_artists_summary(queries = c("Harry Styles", "ZAYN", "Liam Payne", "Niall Horan", "Louis Tomlinson"))
order <- members %>%
         dplyr::select(artist_name, danceability_mean) %>% 
         dplyr::arrange(desc(danceability_mean)) %>%
         kable(format = "markdown")
```
