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


#' Three passes successive removal data of A. salmon in the Nivelle river
#'
#' A dataset containing the successive removal data electofishing of salmon
#' juveniles over 3 passes on 3 years (2003--2005) and 11 sites. Contains
#' missing data.
#'
#' @format A named list:
#' \describe{
#'   \item{I}{The number of sites (sites x years)}
#'   \item{C1}{The number of captures of the first pass for each site}
#'   \item{C2}{The number of captures of the second pass for each site}
#'   \item{C3}{The number of captures of the third pass for each site}
#'   \item{S}{The area in squared meter that was fished for each site}
#'   \item{AI}{The abundance index of each site}
#'   \item{I_pred}{The number of sites (for prediction)}
#'   \item{AI_pred}{Abundance indices (for prediction)}
#' }
#' @source Brun, M., Abraham, C., Jarry, M., Dumas, J., Lange, F., & Prévost, E.
#'  (2011). Estimating an homogeneous series of a population abundance indicator
#'   despite changes in data collection procedure: A hierarchical Bayesian
#'   modelling approach. Ecological Modelling, 222(5), 1069-1079.

"SucRemNivelle"

#' Successive removal data of A. salmon in the Oir river
#'
#' A dataset containing successive removal data with two passes of
#' Atlantic salmon over 20 years and between 7 and 10 sampling sites per year.
#' The data also contains the surface area of the sampling sites.
#'
#' @format A named list:
#' \describe{
#'   \item{ny}{The number of years}
#'   \item{smolts}{Number of smolts for cohort of 1986--2003.
#'   Cohorts match with juveniles. The fifth entry (smolts = 169) corresponds to
#'   year 1990 for which no 0+ juveniles data is available.}
#'   \item{n}{Number of observations}
#'   \item{Year}{The year of the data. 1990 is missing}
#'   \item{Y}{Index of the years}
#'   \item{nsy}{The cumulative number of sites per year}
#'   \item{H}{The habitat type. 1: Rapid/riffle; 2: Run}
#'   \item{C1}{Number of captures at the first pass}
#'   \item{C2}{Number of captures at the second pass}
#'   \item{S}{The surface of each site in squared meter}
#'   \item{Dat}{Number of predictions}
#'   \item{n_sites_ex}{The number of sites for extrapolation}
#'   \item{s_ex}{Mean surface per site per habitat type (for extrapolation)}
#' }
#' @source Rivot, E., Prévost, E., Cuzol, A., Baglinière, J. L., & Parent, E.
#' (2008). Hierarchical Bayesian modelling with habitat and time covariates for
#' estimating riverine fish population size by successive removal method.
#' Canadian Journal of Fisheries and Aquatic Sciences, 65(1), 117-133.

"SucRemOir"
