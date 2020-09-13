
#' Export a multistar as a flat table
#'
#' We can obtain a flat table, implemented using a `tibble`, from a `multistar`
#' (which can be the result of a query). If it only has one fact table, it is
#' not necessary to provide its name.
#'
#' @param ms A `multistar` object.
#' @param name A string, name of the fact.
#'
#' @return A `tibble`.
#'
#' @family results export functions
#' @seealso
#'
#' @examples
#' library(tidyr)
#'
#' ft <- ms_mrs %>%
#'   multistar_as_flat_table(name = "mrs_age")
#'
#' ms <- dimensional_query(ms_mrs) %>%
#'   select_dimension(name = "where",
#'                   attributes = c("city", "state")) %>%
#'   select_dimension(name = "when",
#'                   attributes = c("year")) %>%
#'   select_fact(
#'     name = "mrs_age",
#'     measures = c("deaths")
#'   ) %>%
#'   select_fact(name = "mrs_cause",
#'              measures = c("pneumonia_and_influenza_deaths", "other_deaths")) %>%
#'   filter_dimension(name = "when", week <= "03") %>%
#'   filter_dimension(name = "where", city == "Boston") %>%
#'   run_query()
#'
#' ft <- ms %>%
#'   multistar_as_flat_table()
#'
#' @export
multistar_as_flat_table <- function(ms, name = NULL) {
  UseMethod("multistar_as_flat_table")
}


#' @rdname multistar_as_flat_table
#' @export
multistar_as_flat_table.multistar <- function(ms, name = NULL) {
  if (length(ms$fact) == 1) {
    ft <- ms$fact[[1]]
  } else {
    stopifnot(!is.null(name))
    stopifnot(name %in% names(ms$fact))
    ft <- ms$fact[[name]]
  }
  ft_fk <- attr(ft, "foreign_keys")
  for (d in names(ms$dimension)) {
    if (sprintf("%s_key", d) %in% ft_fk) {
      ft <- dereference_dimension(ft, ms$dimension[[d]], conversion = FALSE)
    }
  }
  tibble::as_tibble(ft)
}