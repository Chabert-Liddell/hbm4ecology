#' Extract object from various MCMC sampler into a wide data frame
#'
#' The dataset as the form [iteration, chain, parameters]
#'
#' @param fit An object of type \code{stanfit} or \code{mcmc.list}
#'
#' @return A tibble object of wide format
#' @export
#'
#' @examples
extract_wider <- function(fit) {
  if (inherits(fit, "stanfit")) {
    ar <-  rstan::extract(fit, permuted=FALSE, inc_warmup=FALSE)
    df <- lapply(seq(dim(ar)[2]),
                 function(c) tibble::as_tibble(ar[,c,]) %>%
                   dplyr::mutate(iteration = seq.int(nrow(ar[,c,])),
                          chain = forcats::as_factor(eval(c)), .before = 1)) %>%
      dplyr::bind_rows()
  } else {
    if (inherits(fit, "mcmc.list")) {
      df <- lapply(seq_along(fit),
                   function(c) {
                     tibble::tibble(
                       iteration = seq_len(nrow(fit[[c]])),
                       chain = factor(c)) %>%
                       dplyr::bind_cols(tibble::as_tibble(fit[[c]]))
                   }) %>% dplyr::bind_rows()
      names(df) <- stringr::str_replace_all(names(df), "\\.", "_")
    } else {
      stop("Unknown class for fit! fit must be of class stanfit (rstan) or
           mcmc.list (rjags).")
    }
  }
  names(df) <- stringr::str_replace(names(df), "(.*)\\[(.*)]" ,"\\1.\\2")
  df
}


#' Extract object from various MCMC sampler into a long data frame
#'
#' The dataset as the form [iteration, chain, parameter, value]
#'
#' @param fit An object of type \code{stanfit} or \code{mcmc.list}
#'
#' @return A tibble object of long format
#' @export
#'
#' @examples
extract_longer <- function(fit) {
  fit_w <- extract_wider(fit)
  fit_w %>% tidyr::pivot_longer(cols = -c("iteration", "chain"),
                                names_to = "parameter")
}
