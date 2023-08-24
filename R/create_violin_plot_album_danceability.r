#' @title Create a violin plot based on an artist's albums
#' @param query - A single artist name.  Defaults to NULL.  Only put this or id
#' @param artist_id - A single Spotify artist id.  Defaults to NULL.  Only put this or query
#' @param limit - Number of albums wanted to return.  Valid if between 1 and 50.  Defaults to 7
#' @param authorization - An access_token generated from the get_spotify_access_token() function
#' @return A violin plot displaying a specific number of an artist's albums' danceability
#' @examples 
#' \dontrun{
#'      create_violin_plot_album_danceability(query = "Bruno Mars")
#'      create_violin_plot_album_danceability(artist_id = "0du5cEVh5yTK9QJze8zA0C", limit = 5)
#' }
#' @export
create_violin_plot_album_danceability <- function(query = NULL, artist_id = NULL, limit = 7, authorization = get_spotify_access_token()) {
    df_artist <- get_artist_audio_features(query = query, id = artist_id, authorization = authorization)
    
    album_names <- unique(df_artist$album_name)[1:limit]
    
    # only keep rows of data frame where album name is one of the names in album_names;
    df_artist <- df_artist[df_artist$album_name %in% album_names, ]

    # not based on size of input, but rather number of rows of df;
    # if (nrow(df_artist) <= 5)
    if(length(album_names) <= 5) {
      # Can also try total characters divided by 10 to create ratio requirement; Maybe;
      if (any(nchar(unique(df_artist$album_name)) > 10)) {
        gg <- ggplot2::ggplot(df_artist, ggplot2::aes(x=album_name, y=danceability))  + 
                ggplot2::geom_violin(ggplot2::aes(fill = album_name)) + 
                # can use springf or paste; equivalent of {} for var in string;
                ggplot2::labs(title = sprintf("Danceability of %s's Albums", df_artist$artist_name[1]), x = "", y = "Danceability", fill = "Album") + 
                ggplot2::theme_bw() +
                ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5), 
                      axis.text.x = ggplot2::element_blank(), 
                      axis.ticks.x = ggplot2::element_blank()
                      ) + 
                ggplot2::stat_summary(fun.data = "mean_cl_normal", geom = "point", shape = 20, size = 4, color = "red")
      } else {
        gg <- ggplot2::ggplot(df_artist, ggplot2::aes(x=album_name, y=danceability))  + 
                ggplot2::geom_violin(ggplot2::aes(fill = album_name)) + 
                # can use sprintf or paste; equivalent of {} for var in string;
                ggplot2::labs(title = sprintf("Danceability of %s's Albums", df_artist$artist_name[1]), x = "Album", y = "Danceability", fill = "Album") +
                ggplot2::theme_bw() + 
                ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) + 
                ggplot2::stat_summary(fun.data = "mean_cl_normal", geom = "point", shape = 20, size = 4, color = "red")
        }
    } 
    else {
      gg <- ggplot2::ggplot(df_artist, ggplot2::aes(x=album_name, y=danceability))  + 
              ggplot2::geom_violin(ggplot2::aes(fill = album_name)) + 
              ggplot2::labs(title = sprintf("Danceability of %s's Albums", df_artist$artist_name[1]), x = "", y = "Danceability", fill = "Album") + 
              ggplot2::theme_bw() +
              ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5), 
                    axis.text.x = ggplot2::element_blank(), 
                    axis.ticks.x = ggplot2::element_blank()
                    ) + 
              ggplot2::stat_summary(fun.data = "mean_cl_normal", geom = "point", shape = 20, size = 4, color = "red")
    }
    plotly::ggplotly(gg)
}
