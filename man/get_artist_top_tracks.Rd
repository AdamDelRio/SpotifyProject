% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tracks_functions.r
\name{get_artist_top_tracks}
\alias{get_artist_top_tracks}
\title{Search for Spotify artist's top tracks}
\usage{
get_artist_top_tracks(
  query = NULL,
  id = NULL,
  authorization = get_spotify_access_token()
)
}
\arguments{
\item{query}{\itemize{
\item A single artist name.  Deafualts to NULL.  Only use this or id
}}

\item{id}{\itemize{
\item A single Spotify artist id.  Deafualts to NULL.  Only use this or query
}}

\item{authorization}{\itemize{
\item An access_token generated from the get_spotify_access_token() function
}}
}
\value{
A dataframe of track data, including the duration, track id and name, explicitness, popularity, track number in its album, album name and id, and artist name and id
}
\description{
Search for Spotify artist's top tracks
}
\examples{
\dontrun{
get_artist_top_tracks(id = "0du5cEVh5yTK9QJze8zA0C")
get_artist_top_tracks(query = "Bruno Mars")
}
}
