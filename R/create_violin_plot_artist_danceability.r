#' @title Create a violin plot based on an artist's tracks
#' @param queries - A String vector of artist names, taken from the search_spotify() function.  Defaults to NULL.  Only use this or ids
#' @param artist_ids - A vector of Spotify artist ids.  Defaults to NULL.  Only use this or queries
#' @param authorization - An access_token generated from the get_spotify_access_token() function
#' @return A violin plot displaying a number of artist's tracks' danceability
#' @examples 
#' \dontrun{
#'  create_violin_plot_artist_danceability(artist_ids = "0du5cEVh5yTK9QJze8zA0C")
#'  create_violin_plot_artist_danceability(queries = c("Bruno Mars", "Anderson .Paak"))
#' }
#' @export
create_violin_plot_artist_danceability <- function(queries = NULL, artist_ids = NULL, authorization = get_spotify_access_token()) {
    # Get top 10 tracks of artist:
    if(!is.null(queries)){
        list_df_artist_top_tracks <- queries %>% 
                                    purrr::map(~ get_artist_top_tracks(query = .x))
    } else{
        list_df_artist_top_tracks <- artist_ids %>% 
                                    purrr::map(~ get_artist_top_tracks(id = .x))
    }

    # From list above, pull out the song ids and make into vector:
    vector_song_ids <- list_df_artist_top_tracks %>%
                            purrr::map(~ .x %>% pull(track_id)) %>% 
                            unlist()

    # Vector of artist names:
    # Get artist names and duplicate them
    if(!is.null(queries)){
        vector_artist_names <- queries %>% 
                                purrr::map(~ rep(get_artists(queries = .x)$artist_name, times = nrow(get_artist_top_tracks(query = .x)))) %>% 
                                unlist()
    } else{
        vector_artist_names <- artist_ids %>% 
                                purrr::map(~ rep(get_artists(ids = .x)$artist_name, times = nrow(get_artist_top_tracks(id = .x)))) %>% 
                                unlist()
    }

    # Get track audio features of artist 10 songs:
    df_tracks <- get_track_audio_features(ids = vector_song_ids, authorization = get_spotify_access_token()) %>% 
                    dplyr::mutate(artist = vector_artist_names)
    
    if (((length(artist_ids) <= 3 || length(queries) <= 3) & any(nchar(vector_artist_names) > 15) & any(nchar(vector_artist_names) < 30)) | (length(artist_ids) <= 5 & all(nchar(vector_artist_names) <= 15))) {
        gg <- ggplot2::ggplot(df_tracks, ggplot2::aes(x=artist, y=danceability))  + 
            ggplot2::geom_violin(ggplot2::aes(fill = artist)) + 
            ggplot2::labs(title = "Danceability of Artist Top Tracks", x = "Artist", y = "Danceability", fill = "Artist") + 
            ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) + 
                ggplot2::stat_summary(fun.data = "mean_cl_normal", geom = "point", shape = 20, size = 4, color = "red")
    } 
    else {
        gg <- ggplot2::ggplot(df_tracks, ggplot2::aes(x=artist, y=danceability))  + 
            ggplot2::geom_violin(aes(fill = artist)) + 
            ggplot2::labs(title = "Danceability of Artist Top Tracks", x = "") + 
            ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5), 
                    axis.text.x = ggplot2::element_blank(), 
                    axis.ticks.x = ggplot2::element_blank() 
                    ) + 
                ggplot2::stat_summary(fun.data = "mean_cl_normal", geom = "point", shape = 20, size = 4, color = "red")
    }
    plotly::ggplotly(gg)
}