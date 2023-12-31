% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_genre_radar_chart.r
\name{create_genre_radar_chart}
\alias{create_genre_radar_chart}
\title{Create a radar chart of genre features}
\usage{
create_genre_radar_chart(
  genres,
  vars = c(),
  authorization = get_spotify_access_token()
)
}
\arguments{
\item{genres}{\itemize{
\item A vector of Spotify genres
}}

\item{vars}{\itemize{
\item A vector of variables returned from get_genre_summary()
}}

\item{authorization}{\itemize{
\item An access_token generated from the get_spotify_access_token() function
}}
}
\value{
A radar chart displaying valence, energy, and speechiness, along with any other inputed variables
}
\description{
Create a radar chart of genre features
}
\examples{
\dontrun{
 create_genre_radar_chart(genres = c("hip-hop", "classical", "rock"), vars = c("instrumentalness", "acousticness"))
}
}
