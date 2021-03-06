#' Title
#'
#' Description
#'
#' @param description
#' @return description
#' @export
similarity_coefficient <- function(similarity_mtx, x_axis = TRUE, threshold = NULL, echo = TRUE) {

  if (!is.null(threshold) & !is.numeric(threshold)) {
    stop('`threshold` needs to be NULL or numeric!')
  }

  margin <- if (x_axis) 1 else 2

  check_obj <- function(x) if (!is.null(dim(x)) & typeof(x) == 'double') TRUE else FALSE

  if (check_obj(similarity_mtx)) {

    # find maximum similarity from matrix
    if (echo) cat('Calculating similarity coefficients...\n')
    export <- apply(
      X = similarity_mtx,
      MARGIN = margin,
      FUN = function(similarities) {
        valid_similarities <- na.omit(similarities)
        max_similarity <- if (length(valid_similarities) < 1) NA else max(similarities, na.rm = TRUE)
      }
    )

    # coerce into dichotomous similarity score if threshold is defined
    if (!is.null(threshold)) {
      export <- dplyr::if_else(export >= threshold, 1, 0)
    }

  } else {
    stop('`similarity_mtx` must be matrix from `clis::similarity_matrix()`')
  }

  return(export)

}
