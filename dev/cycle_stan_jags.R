library(hbm4ecology)
library(rstan)
library(tidyverse)
library(GGally)
library(posterior)
library(bayesplot)
library(shinystan)
library(rjags)

data(SalmonLifeCycle)
data <- SalmonLifeCycle
data$n <-  16
data[c(5:25)] <- bind_cols(SalmonLifeCycle[c(5:25)]) %>% filter(Year >= 1986) %>% as.list()
data$sample_Sp <- bind_cols(data[13:16])

data$r_unm <- c(4+3, 22,  0+12,  0+12, 15,  1+4,  5,  3+2,  4+2,  7, 57,  3, 30,
                22, 33,  4+4)


model_str <- "
model {
# ---------------------------------------------------------------------------
#                               PRIORS
# ---------------------------------------------------------------------------

# Priors for Ricker stock-recruitmnt parameters
# R = alpha*exp(-beta*S)
# alpha constrained <1 becasue it is a survival rate eggs --> 0+

	log.alpha ~ dunif(-10,0)
	alpha <- exp(log.alpha)
	beta ~ dnorm(0,0.01)
	exp.beta <- exp(beta)

# Prior for recruitment process error variance
# (Corresponds to approximative 1/V between 1E-6 and 1E+6)

	log.sigma_2 ~ dunif(-13.8,13.8)
	sigma_2 <- exp(log.sigma_2)
	tau <- 1/sigma_2

# Survival rate Juveniles 0+ --> Pre-smolts1 (constant between years)

	s01 ~ dbeta(15,15)

# Life history choice - probability to migrate as Smolt 1
# (exchangeable hierarchical structure between years)

	mu_theta_Sm1 ~ dnorm(0,0.01)
	sd_theta_Sm1  ~ dunif(0,5)
	tau_theta_Sm1 <- 1/(sd_theta_Sm1*sd_theta_Sm1)
	# Indice [n+1] is the predictive
	for( i in 1:(n+1) ) 	{
	logit_theta_Sm1[i] ~ dnorm(mu_theta_Sm1,tau_theta_Sm1)
	logit(theta_Sm1[i]) <- logit_theta_Sm1[i]			}

# Survival rate Parr 1+ resident --> Smolts 2 (constant between years)

	s12 ~ dbeta(20,10)

# Transition Smolt1 --> post-smolts (survival during the first year at sea)
# (exchangeable hierarchical structure between years)

	mu_ss11 ~ dnorm(0,0.01)
	sd_ss11 ~ dunif(0,5)
	tau_ss11 <- 1/(sd_ss11*sd_ss11)
	# Indice [n+1] is the predictive
	for( i in 1 : (n+1) ) 	{
	logit_ss11[i] ~ dnorm(mu_ss11,tau_ss11)
	logit(ss11[i]) <- logit_ss11[i]
	logit(ss21[i]) <- logit_ss11[i] + delta_ss1	}

# Differential in survival rate between Sm1 and Sm2 (constant between years)
# logit(ss21) = logit(ss11) + delta_ss1

	delta_ss1 ~ dunif(0,10)

# Proportion of maturing adults as 1SW (constant between years)

	theta_m1 ~ dbeta(3,2)

# Marine survival rate for non maturing 1SW post-smolts
# Survival probability is the same for non maturing post.smolts1 and post.smolts2
# (ss12 = ss22) and constant accross year

	ss2 ~ dbeta(3,2)

# Proportion of females pf1 and pf2 (exchangeable hierarchical structure between years)

	mu_pf1 ~ dnorm(0,0.01)
	sd_pf1 ~ dunif(0,5)
	tau_pf1 <- 1/(sd_pf1*sd_pf1)

	mu_pf2 ~ dnorm(0,0.01)
	sd_pf2 ~ dunif(0,5)
	tau_pf2 <- 1/(sd_pf2*sd_pf2)

	# Indice [n+1] is the predictive
	for( i in 1 : (n+1) ) 	{
	logit_pf1[i] ~ dnorm(mu_pf1,tau_pf1)
	logit(pf1[i]) <- logit_pf1[i]
	logit_pf2[i] ~ dnorm(mu_pf2,tau_pf2)
	logit(pf2[i]) <- logit_pf2[i]		}

#  Trapping efficiencies (exchangeable hierarchical structure between years)

	# Smolts
	mu_pi_sm ~ dnorm(0,0.01)
	sd_pi_sm ~ dunif(0,5)
	tau_pi_sm <- 1/(sd_pi_sm*sd_pi_sm)

	# Adults
	mu_pi_sp1 ~ dnorm(0,0.01)
	sd_pi_sp1 ~ dunif(0,5)
	tau_pi_sp1 <- 1/(sd_pi_sp1*sd_pi_sp1)

	# Adults recapture efficiency
	mu_pi_sp2 ~ dnorm(0,0.01)
	sd_pi_sp2 ~ dunif(0,5)
	tau_pi_sp2 <- 1/(sd_pi_sp2*sd_pi_sp2)

	# Indice [n+1] is the predictive
	for( i in 1 : (n+1) ) 	{
	# Smolts
	logit_pi_sm[i] ~ dnorm(mu_pi_sm,tau_pi_sm)
	logit(pi_sm[i]) <- logit_pi_sm[i]

	# Adults
	logit_pi_sp1[i] ~ dnorm(mu_pi_sp1,tau_pi_sp1)
	logit(pi_sp1[i]) <- logit_pi_sp1[i]

	# Adults recapture efficiency
	logit_pi_sp2[i] ~ dnorm(mu_pi_sp2,tau_pi_sp2)
	logit(pi_sp2[i]) <- logit_pi_sp2[i]		}


# ---------------------------------------------------------------------------
#           PROCESS EQUATIOnS (hidden population dynamics)
# ---------------------------------------------------------------------------

# Prior on states for the first year
	dSp12 <- rep(1, 100)
	dSp22 <- rep(1, 50)

	Sp12[1] ~ dcat(dSp12)
	Sp22[1] ~ dcat(dSp22)

	dSm2 <- rep(1, 300)

 	Sm2[1] ~ dcat(dSm2)

	Jint[1] ~ dunif(0,1)

  dPSm <- rep(1, 10000)
	PSm[1] ~ dcat(dPSm)

	dPostSm1 <- rep(1, 1000)
	dPostSm2 <- rep(1, 1000)
	post.smolt1[1] ~ dcat(dPostSm1)
	post.smolt2[1] ~ dcat(dPostSm2)

#  Loop on time series (n = 18, i = 1 is year 1984, i = n is year 2001)

for( i in 1 : n ){

	Sp1[i] <- Sp11[i] + Sp21[i]
	Sp2[i] <- Sp12[i] + Sp22[i]
	Sp[i] <- Sp1[i] + Sp2[i]

# Stock (eggs) : number of female = marked and released + escape from the trap
# Standardized per m² of wetted production area

	Eggs[i] <- max( ( (Sp1[i]-x_Sp1[i]) * pf1[i] * fec1  + (Sp2[i]-x_Sp2[i]) * pf2[i] * fec2 )  /  surf, 1)

	p_Eggs1[i] <- max(  (Sp1[i]-x_Sp1[i]) * pf1[i] * fec1 / surf ,1) / Eggs[i]

# Ricker * Lognormal Process errors for recruitment

	LogRmean[i] <- log(Eggs[i]*alpha*exp(-beta*Eggs[i]))
	Jint[i+1] ~ dlnorm(LogRmean[i],tau)
	J[i] <- round(Jint[i]*surf)

	egg_juv_surv[i] <- Jint[i+1]/Eggs[i]

# Transition Juveniles 0+ --> pre-smolts PSm with survival s01

    PSm[i+1] <-  max(round(s01 * J[i]), 1)

# Transition to smolts 1+ and 2+ with life history choice theta_Sm1
# Survival of resident Parr1 = s12 gamma_Parr1

	Sm1[i]   <- max(round(theta_Sm1[i] * PSm[i]), 1)
	Parr1[i] <- max(PSm[i] - Sm1[i],1)

	Sm2[i+1] <- max(round(s12 * Parr1[i]), 1)

# Transition Smolt1 --> post-smolts (survival during the first year at sea)

	post.smolt1[i+1] <- max(round(ss11[i] * Sm1[i]), 1)
	post.smolt2[i+1] <- max(round(ss21[i] * Sm2[i]), 1)

# Maturation of post-smolts (1 and 2) as 1SW fish (with probability theta_m1)
# Maturing probability (theta_m1) is the same for post.smolts1 and post.smolts2
# and constant accross year

	Sp11[i] <- max(round(theta_m1 * post.smolt1[i]), 1)
	Sp21[i] <- max(round(theta_m1 * post.smolt2[i]), 1)

# Survival during the second year at sea

	Res1[i]   <- max(post.smolt1[i] - Sp11[i],1)
	Sp12[i+1] <- max(round(ss2 * Res1[i]),1)

	Res2[i]   <- max(post.smolt2[i] - Sp21[i],1)
	Sp22[i+1] <- max(round(ss2 * Res2[i]),1)

}  # end of the loop on i

mean_p_Eggs1 <- mean(p_Eggs1[])
mean_egg_juv_surv <- mean(egg_juv_surv[])


# ---------------------------------------------------------------------------
#                       OBSERVATIOn EQUATIONS
# ---------------------------------------------------------------------------

for( i in 1 : n )
{

# Smolts
# --------------------------------

# Catches

	Sm[i] <- Sm1[i]+Sm2[i]
	c_Sm[i] ~ dbin(pi_sm[i],Sm[i])

# Recaptures

	r_Sm[i] ~ dbin(pi_sm[i],m_Sm[i])

# Updating of river-age proportions in smolts runs

	p_Sm1[i] <- Sm1[i]/(Sm1[i]+Sm2[i])
	sample_Sm1[i] ~ dbin(p_Sm1[i],sample_Sm_age[i])


# Adults
# --------------------------------

# Updating total numbers

# Catches

	c_Sp[i] ~ dbin(pi_sp1[i],Sp[i])

# Recaptured marked

	rmad[i] ~ dbin(pi_sp2[i],mad[i])

# Recaptured unmarked (r_unm[i] among a total of escnet[i] unmarked fish)
# where escnet[i] are adults that escaped to the trap = Sp - c_Sp

	escnet[i] <- Sp[i] - c_Sp[i]
	r_unm[i] ~ dbin(pi_sp2[i], escnet[i])

# Updating the demographic structure

	p_Sp[i,1] <- Sp11[i]/Sp[i]
	p_Sp[i,2] <- Sp12[i]/Sp[i]
	p_Sp[i,3] <- Sp21[i]/Sp[i]
	p_Sp[i,4] <- Sp22[i]/Sp[i]

	p_Sp1[i] <- Sp1[i] / Sp[i]
	p_Sp11[i] <- Sp11[i] / Sp1[i]
	p_Sp12[i] <- Sp12[i] / Sp2[i]

	#x[i,1] <-  sample_Sp11[i]
	#x[i,2] <-  sample_Sp12[i]
	#x[i,3] <-  sample_Sp21[i]
	#x[i,4] <-  sample_Sp22[i]

	sample_Sp[i,1:4] ~ dmulti(p_Sp[i,1:4], sample_Sp_age[i])

# Updating female proportions in 1SW and 2SW

	sample_Sp1f[i] ~ dbin(pf1[i],sample_Sp1_sex[i])
	sample_Sp2f[i] ~ dbin(pf2[i],sample_Sp2_sex[i])

}  # end of the loop on i

	mean_p_Sm1 <- mean(p_Sm1[])

	mean_p_Sp1 <- mean(p_Sp1[])
	mean_p_Sp11 <- mean(p_Sp11[])
	mean_p_Sp12 <- mean(p_Sp12[])

}  # End of the model"


  inits1 <- source(file = "vignettes/articles/model_init/SalmonLifeCycle/inits1_SalmonLifeCycle.txt")$value
  inits <- list(inits1, inits1, inits1)

  t0j <- Sys.time()
  model <- jags.model(file = textConnection(model_str),
                      data = data, inits = inits1,
                      n.chains = 1)
  # Inferences
  t1j <- Sys.time()
  update(model, n.iter = 10000)
  t2j <- Sys.time()
  posterior_sample <- jags.samples(
    model = model,
    variable.names = c("alpha", "beta", "sigma_2", # Production
                       "s01", "s12", "ss2", "ss11", "ss21", #Survival rate gamma
                       "theta_Sm1", "delta_ss1", "theta_m1", # Migration rate
                       "pf1", "pf2", # Proportion of female
                       "pi_sm", "pi_sp1", "pi_sp2", # Trapping efficiency
                       "Eggs", "p_Eggs1", "J", "LogRmean", "egg_juv_surv",
                       "Jint", "PSm", "post.smolt1", "post.smolt2", # Juveniles and smolts
                       "Sm1", "Parr1", "Sm2", "Res1", "Sm",
                       "Sp11", "Sp12", "Sp21", "Sp22", "Sp1", "Sp2", "Sp", # Spawners
                       "mean_p_Sm1", "mean_p_Sp1", "mean_p_Sp11", "mean_p_Sp12"
    ),
    n.iter = 90000,
    thin = 1)
  t3j <- Sys.time()

  saveRDS(list(t0j, t1j, t2j, t3j, posterior_sample), "dev/save_jags.rds")
#===============================================================================
#  Stan                                                                        =
#===============================================================================


data_stan <-
  list(
    n = 16,
    # Wetted surface of the system
    surf = 25229,
    # Fecundity (number of eggs / female)
    fec1 = 4635,
    fec2 = 7965,
    # ADULTS
    # Numbers
    # captured at the trap
    c_Sp = c(130, 16, 226, 235, 15, 44, 31, 100, 32, 109, 70, 56, 34, 154, 53, 160),
    # Retrieved from the population
    x_Sp1=c(28, 3, 35, 31, 4, 0, 10, 17, 12, 6, 13, 19, 3, 5, 0, 1),
    x_Sp2=c(9, 1, 8, 5, 4, 0, 1, 2, 2, 1, 2, 3, 1, 1, 0, 0),
    # marked and released
    mad = c(93, 12, 183, 199, 7, 44, 20, 81, 18, 102, 55, 34, 30, 148, 53, 159),
    # recaptured marked
    rmad = c(5, 2, 12, 56, 2, 23, 4, 4, 1, 39, 25, 12, 6, 13, 4, 31),
    # recaptured unmarked
    r_unm = c(4+3, 22,  0+12,  0+12, 15,  1+4,  5,  3+2,  4+2,  7, 57,  3, 30, 22, 33,  4+4),

    # Demographic structure
    # adults examined for ageing (could be smaller than c_Sp)
    sample_Sp_age = c(111, 16, 197, 220, 9, 41, 28, 98, 29, 108, 60, 52, 28, 140, 51, 140),
    # 1SW issued from Sm1 among "sample_Sp_age"
    sample_Sp11 = c(61, 13, 85, 129, 3, 38, 22, 85, 24, 88, 48, 47, 22, 105, 45, 120),
    # 1SW issued from Sm2 among "sample_Sp_age"
    sample_Sp21 = c(19, 2, 74, 54, 2, 1, 4, 6, 3, 17, 9, 4, 5, 18, 2, 14),
    # 2SW issued from Sm1 among "sample_Sp_age"
    sample_Sp12 = c(24, 1, 36, 31, 3, 1, 2, 7, 2, 3, 2, 1, 1, 12, 2, 5),
    # 2SW issued from Sm2 among "sample_Sp_age"
    sample_Sp22 = c(7, 0, 2, 6, 1, 1, 0, 0, 0, 0, 1, 0, 0, 5, 2, 1),

    # Sex ratio
    # 1SW and 2 SW examined for sex
    sample_Sp1_sex = c(93, 15, 182, 197, 9, 42, 28, 93, 30, 106, 67, 55, 33, 136, 49, 151),
    sample_Sp2_sex = c(37, 1, 44, 38, 6, 2, 3, 7, 2, 3, 3, 1, 1, 18, 4, 9),
    # female among sex1 and sex2
    sample_Sp1f = c(31, 1, 63, 64, 3, 13, 11, 22, 18, 45, 27, 21, 10, 43, 26, 51),
    sample_Sp2f = c(26, 1, 31, 21, 4,  1,  2,  3,  2,  3,  3,  1,  1, 13, 2, 3),

    # SMOLTS
    # Catches
    c_Sm = c(887, 283, 307, 553, 746, 151, 580, 209, 329, 618, 767, 205, 511, 195, 1849, 688),
    # Smolts examined for river-ageing
    sample_Sm_age = c(887, 283, 307, 553, 746, 151, 580, 209, 329, 618, 767, 205, 511, 195,  1849, 688),
    sample_Sm1 = c(848, 146, 282, 495, 708, 101, 571, 171, 323, 541, 684, 186, 438, 43, 1835, 636),
    # Marked-released and recaptured
    m_Sm = c(135, 31, 59, 65, 38, 35, 50, 26, 17, 63, 76, 63, 91, 59, 300, 264),
    r_Sm = c(91, 24, 43, 43, 35, 27, 43, 24, 10, 53, 58, 31, 44, 45, 232, 123)
  )



library(cmdstanr)
check_cmdstan_toolchain(fix = TRUE, quiet = TRUE)
set_cmdstan_path(path = "~/cmdstan/")
t0s <- Sys.time()
mod <- cmdstan_model("./life_cycle.stan")
t1s <- Sys.time()
fit <- mod2$sample(data = data_no_na,
                  seed = 1234,
                  chains=1,
                  thin = 1,
                  iter_warmup = 10000,
                  iter_sampling = 90000,
                  init = lapply(seq(4), function(i) init_param))

t2s <- Sys.time()

t3s <- Sys.time()
