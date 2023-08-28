
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
members %>%
  dplyr::select(artist_name, danceability_mean) %>% 
  dplyr::arrange(desc(danceability_mean)) %>%
  dplyr::rename("Artist Name" = artist_name,
                "Mean Danceability" = danceability_mean) %>%
  kable(format = "markdown")
```

| Artist Name     | Mean Danceability |
|:----------------|------------------:|
| Liam Payne      |         0.6461556 |
| Louis Tomlinson |         0.5836279 |
| ZAYN            |         0.5772874 |
| Harry Styles    |         0.5670263 |
| Niall Horan     |         0.5326024 |

### How Loud Does “Bohemian Rhapsody” Get Throughout The Song?

``` r
rhap <- get_track_sections(query = "Bohemian Rhapsody")
rhap %>%
  dplyr::select(track_name,
                start,
                loudness) %>% 
  ggplot2::ggplot(mapping = aes(x = start, y = loudness)) + 
  ggplot2::geom_line() + 
  ggplot2::theme_bw() + 
  ggplot2::labs(title = "Loudness of Bohemian Rhapsody Over Time",
                subtitle = "Loudness (dB)",
                x = "Start Time of Interval (s)",
                y = "")
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

### Of The Top Hip-Hop Artists, Which 5 Have The Most Followers?

``` r
hop <- get_genre_artists(genre = "hip-hop")
hop %>% 
  dplyr::select(artist_name, 
                followers_total) %>% 
  dplyr::arrange(desc(followers_total)) %>% 
  dplyr::slice_head(n = 5) %>% 
  dplyr::rename("Artist Name" = artist_name, 
                "Total Followers" = followers_total) %>% 
  knitr::kable(format = "markdown")
```

| Artist Name    | Total Followers |
|:---------------|----------------:|
| Drake          |        78959533 |
| Eminem         |        75746881 |
| XXXTENTACION   |        42814845 |
| Nicki Minaj    |        29308005 |
| Kendrick Lamar |        25159036 |

### How Does The Average Valence, Energy, Speechiness, Danceability, And Acousticness Of Kendrick Lamar Compare To Ed Sheeran

``` r
create_average_artists_radar_chart(queries = c("Kendrick Lamar", "Ed Sheeran"), vars = c("danceability", "acousticness"))
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />
