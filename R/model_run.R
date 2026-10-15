.mayo_vars <- c("age", "smoker", "prior_cancer", "diameter", "spiculation", "upper_lobe")
.mayo_alias <- c(smoking = "smoker", ever_smoker = "smoker",
                 cancer = "prior_cancer", extrathoracic_cancer = "prior_cancer",
                 nodule_size = "diameter", size = "diameter", diameter_mm = "diameter",
                 spiculated = "spiculation", upper = "upper_lobe")

#' Mayo nodule model (ModelsCloud entry point)
#' @param model_input Named list of all six inputs; see [mayo()].
#' @param ... The same fields as named arguments.
#' @return See [mayo()].
#' @export
model_run <- function(model_input = NULL, ...) {
  args <- .mayo_normalize(model_input, list(...), .mayo_vars, .mayo_alias)
  if (is.null(args) || length(args) == 0) args <- get_default_input()
  missing <- setdiff(.mayo_vars, names(args))
  if (length(missing) > 0) {
    stop("Missing required variable(s): ", paste(missing, collapse = ", "), ".",
         call. = FALSE)
  }
  do.call(mayo, args)
}

#' Example Mayo inputs
#' @param n Optional number of rows.
#' @param ... Ignored.
#' @export
get_sample_input <- function(n = NULL, ...) {
  df <- data.frame(age = c(54, 68, 70), smoker = c("yes", "yes", "yes"),
                   prior_cancer = c("no", "no", "no"), diameter = c(16, 22, 4),
                   spiculation = c("no", "yes", "no"), upper_lobe = c("yes", "yes", "yes"),
                   stringsAsFactors = FALSE)
  if (!is.null(n)) df <- utils::head(df, n)
  df
}

#' Default Mayo input
#' @param ... Ignored.
#' @export
get_default_input <- function(...) {
  list(age = 54, smoker = "yes", prior_cancer = "no", diameter = 16,
       spiculation = "no", upper_lobe = "yes")
}
