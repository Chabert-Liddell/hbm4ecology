#' @title Biomass Production for Namibian Hake over 25 years
#'
#' @description A dataset containing the biomass and abundance indices from
#' 1964 to 1988.
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


#' @title Catch-mark-recapture data of adult salmon on the Oir river
#'
#' @description A dataset containing CMR data from 1984 to 2000
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

#' @title Stock recruitment data of A. salmon over 13 rivers
#'
#' @description A dataset containing the stock and recruitment of A. salmon over 13 european
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


#' @title Three passes successive removal data of A. salmon in the Nivelle river
#'
#' @description A dataset containing the successive removal data electofishing of
#' salmon
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

#' @title Successive removal data of A. salmon in the Oir river
#'
#' @description A dataset containing successive removal data with two passes of
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

#' @title Life cycle data of Atlantic salmon
#'
#' @description A dataset resulting from a comprehensive survey of the salmon
#' population of the Oir river between 1984 and 2001. The dataset corresponds
#' essentially to Catch Mark Recapture experiments.
#'
#' @format A named list:
#' \describe{
#'   \item{n}{The number of years}
#'   \item{surf}{The wetted surface of the system}
#'   \item{fec1}{Fecunity (number of eggs / female) of 1 Sea Winter (1SW) fish}
#'   \item{fec2}{Fecunity (number of eggs / female) of 2 Sea Winter (2SW) fish}
#'   \item{Year}{The years of the data}
#'   \item{c_Sp}{Number of of spawners trapped during upstream migration
#'   (\eqn{y_1^{Sp}})}
#'   \item{x_Sp1}{Number of 1SW Spawners retrieved fron the
#'   population (\eqn{y_2^{Sp}})}
#'   \item{x_Sp2}{Number of 2SW Spawners retrieved fron the
#'   population (\eqn{y_3^{Sp}})}
#'   \item{mad}{Marked and released Spawners (\eqn{y_4^{Sp}})}
#'   \item{rmad}{Marked and recaptured Spawners (\eqn{y_5^{Sp}})}
#'   \item{r_unm}{Unmarked and recaptured Spawners (\eqn{y_6^{Sp}})}
#'   \item{sample_Sp_age}{Adults examined for ageing (\eqn{y_7^{Sp}})}
#'   \item{sample_Sp11}{Number of 1SW issued from 1+ Smolts among sample_Sp_age
#'   (\eqn{y_8^{Sp}})}
#'   \item{sample_Sp21}{Number of 1SW issued from 2+ Smolts among sample_Sp_age
#'   (\eqn{y_9^{Sp}})}
#'   \item{sample_Sp12}{Number of 2SW issued from 1+ Smolts among sample_Sp_age
#'   (\eqn{y_{10}^{Sp}})}
#'   \item{sample_Sp22}{Number of 2SW issued from 2+ Smolts among sample_Sp_age
#'   (\eqn{y_{11}^{Sp}})}
#'   \item{sample_Sp1_sex}{Number of 1SW fish examined for sex identification
#'   (\eqn{y_{12}^{Sp}})}
#'   \item{sample_Sp2_sex}{Number of 2SW fish examined for sex identification
#'   (\eqn{y_{13}^{Sp}})}
#'   \item{sample_Sp1f}{Number of 1SW fish identified as female among
#'   sample_Sp1_sex (\eqn{y_{14}^{Sp}})}
#'   \item{sample_Sp2f}{Number of 1SW fish identified as female among
#'   sample_Sp2_sex (\eqn{y_{15}^{Sp}})}
#'   \item{c_Sm}{Number of smolts  caught in the downstream trapping facility
#'  during the migration time(\eqn{y_{1}^{Sm}})}
#'   \item{m_Sm}{Number of smolts  marked and released (\eqn{y_{2}^{Sm}})}
#'   \item{m_Sm}{Number of smolts  marked-released and recaptured (\eqn{y_{3}^{Sm}})}
#'   \item{sample_Sm_age}{Number of smolts  examined for river-age (\eqn{y_{4}^{Sm}})}
#'   \item{sample_Sm1}{Number of 1+ smolts  among sample_Sm_age (\eqn{y_{5}^{Sm}})}
#' }
#' @source Rivot, E., Prévost, E., Cuzol, A., Parent, E. & Baglinière, J. L.
#' (2004). A Bayesian state-space modeling framework for fitting a salmon
#' stage-structured population dynamic model to multiple time series of
#' field data. Ecological Modelling, 179, 463-485.

"SalmonLifeCycle"


