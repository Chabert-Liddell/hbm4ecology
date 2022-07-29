#' Biomass Production for Namibian Hake over 25 years
#'
#' A dataset containing the biomass and abundance indices from 1964 to 1988
#'
#' @format A named list:
#' \describe{
#'   \item{N}{The number of years in the data set}
#'   \item{Year}{The years of the data}
#'   \item{C}{Number of catches in thousand tons}
#'   \item{I}{Abundance indices based on CPUE in tons per standadized trawler hours}
#' }
#' @source McAllister, M. K., & Kirkwood, G. P. (1998). Bayesian stock assessment: a review and example application using the logistic model. ICES Journal of Marine Science, 55(6), 1031-1060.

"BioprodNamibianHake"


#' Catch-mark-recapture data of adult salmon on the Oir river
#'
#' A dataset containing CMR data from 1984 to 2000
#'
#' @format A named list:
#' \describe{
#'   \item{N}{The number of years in the data set}
#'   \item{y1}{The number of trapped fish}
#'   \item{y2}{Number of one sea-winter (1SW) fish removed from the population}
#'   \item{y3}{NUmber of two sea-winter (2SW) fish removed from the population}
#'   \item{y4}{Number of tagged and released fish}
#'   \item{y5}{Number of marked-recapture fish}
#'   \item{y6}{Number of unmarked-recapture fish}
#' }
#' @source Rivot, E., & Prévost, E. (2002). Hierarchical Bayesian analysis of capture mark recapture data. Canadian Journal of Fisheries and Aquatic Sciences, 59(11), 1768-1784.

"CmrOir"

#' Stock recruitment data of A. salmon over 13 rivers
#'
#' A dataset containing the stock and recruitment of A. salmon over 13 european
#' rivers. As well as the latitude and name of the different site and new
#' latitude to perform predictions.
#'
#' @format A named list:
#' \describe{
#'   \item{n_riv}{The number of rivers}
#'   \item{name_riv}{The name of the rivers}
#'   \item{country_riv}{The country of the rivers}
#'   \item{area}{The riverine wetted area accessible to salmon in
#'   squared meters}
#'   \item{n_obs}{The number of observations for each river}
#'   \item{n}{The total number of observations}
#'   \item{riv}{The river membership of each observation}
#'   \item{S}{Stock data of length n}
#'   \item{R}{Recruitment data of length n}
#'   \item{lat}{Latitude of each river site}
#'   \item{n_pred}{Number of predictions}
#'   \item{lat_pred}{Latitude used for predictions}
#' }
#' @source Prévost, E., Parent, E., Crozier, W., Davidson, I., Dumas, J.,
#' Gudbergsson, G., ... & Sættem, L. M. (2003). Setting biological reference
#' points for Atlantic salmon stocks: transfer of information from data-rich to
#' sparse-data situations by Bayesian hierarchical modelling.
#' ICES Journal of Marine Science, 60(6), 1177-1193.

"SRSalmon"


#' Successive removal data of A. salmon in the Nivelle river
#'
#' A dataset containing the stock and recruitment of A. salmon over 13 european
#' rivers. As well as the latitude and name of the different site and new
#' latitude to perform predictions.
#'
#' @format A named list:
#' \describe{
#'   \item{n_riv}{The number of rivers}
#'   \item{name_riv}{The name of the rivers}
#'   \item{country_riv}{The country of the rivers}
#'   \item{area}{The riverine wetted area accessible to salmon in
#'   squared meters}
#'   \item{n_obs}{The number of observations for each river}
#'   \item{n}{The total number of observations}
#'   \item{riv}{The river membership of each observation}
#'   \item{S}{Stock data of length n}
#'   \item{R}{Recruitment data of length n}
#'   \item{lat}{Latitude of each river site}
#'   \item{n_pred}{Number of predictions}
#'   \item{lat_pred}{Latitude used for predictions}
#' }
#' @source McAllister, M. K., & Kirkwood, G. P. (1998). Bayesian stock assessment: a review and example application using the logistic model. ICES Journal of Marine Science, 55(6), 1031-1060.

"SucRemNivelle"
