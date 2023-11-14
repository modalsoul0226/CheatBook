#' Custom Knit function for specifying output directory
#'
#' @param input File input
#' @param output_dir Custom output directory
#' @param intermediates_dir Intermediate files directory
#' @export custom_knit
custom_knit <- function(input, output_dir, intermediates_dir, ...) {
  rmarkdown::render(
    input,
    output_dir = output_dir,
    intermediates_dir = intermediates_dir,
    envir = globalenv()
  )
}
