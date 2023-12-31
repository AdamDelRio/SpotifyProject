% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_artist_album_valence_energy_visual.r
\name{create_artist_album_valence_energy_visual}
\alias{create_artist_album_valence_energy_visual}
\title{Create a valenece and energy plot based on an artist's albums}
\usage{
create_artist_album_valence_energy_visual(
  query = NULL,
  artist_id = NULL,
  limit = 5,
  authorization = get_spotify_access_token()
)
}
\arguments{
\item{query}{\itemize{
\item A single artist name.  Defaults to NULL.  Only put this or id
}}

\item{artist_id}{\itemize{
\item A single Spotify artist id.  Defaults to NULL.  Only put this or query
}}

\item{limit}{\itemize{
\item Number of albums wanted to return.  Valid if between 1 and 50.  Defaults to 20
}}

\item{authorization}{\itemize{
\item An access_token generated from the get_spotify_access_token() function
}}
}
\value{
A valence and energy plot taking in a set number of artist's albums
}
\description{
Create a valenece and energy plot based on an artist's albums
}
\examples{
\dontrun{
 create_artist_album_valence_energy_visual(artist_id = "0du5cEVh5yTK9QJze8zA0C")
 create_artist_album_valence_energy_visual(artist_id = "0du5cEVh5yTK9QJze8zA0C", limit = 5)
 create_artist_album_valence_energy_visual(query = "Bruno Mars")
}
}
