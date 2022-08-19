data {
  // remove first 2 years of data
  int<lower=0> n;
  //wetted surface of the system
  int surf;
  //Fecundity
  real fec1;
  real fec2;

  // Adults
  // Captured
  vector<lower=0>[n] c_Sp; // y_1^Sp
  // Retrieved
  vector<lower=0>[n] x_Sp1; // y_2^Sp
  vector<lower=0>[n] x_Sp2; // y_3^Sp
  // Marked and released
  array[n] int<lower=0> mad; // y_4^Sp
  // Recaptured marked
  array[n] int<lower=0> rmad; // y_5^Sp
  //Recaptured unmarked
  vector<lower=0>[n] r_unm; // y_6^Sp

  //Demographic structure

  // adults examined for ageing
  array[n] int<lower=0> sample_Sp_age; //y_7^Sp
  array[n] int<lower=0> sample_Sp11; // y_8^Sp
  array[n] int<lower=0> sample_Sp12; // y_9^Sp
  array[n] int<lower=0> sample_Sp21; // y_10^Sp
  array[n] int<lower=0> sample_Sp22; // y_11^Sp

  //Sex ratio
  // Examined for sex among SW1 and SW2
  array[n] int<lower=0> sample_Sp1_sex; // y_12^Sp
  array[n] int<lower=0> sample_Sp2_sex; // y_14^Sp
  // Female among sex1 and sex2
  array[n] int<lower=0, upper=sample_Sp1_sex> sample_Sp1f; // y_13^Sp
  array[n] int<lower=0, upper=sample_Sp2_sex> sample_Sp2f; // y_15^Sp

  //Smolts
  //Catches
  vector<lower=0>[n] c_Sm; //y_1^Sm
  // Smolts examined for river-ageing
  array[n] int<lower=0> sample_Sm_age; //y_4^sm
  array[n] int<lower=0> sample_Sm1; //y_5^sm
  // Marked-released and recaptured
  array[n] int<lower=0> m_Sm; //y_2^Sm
  array[n] int<lower=0, upper=m_Sm> r_Sm; //y_3^Sm
}

transformed data {
  array[n,4] int sample_Sp;

  sample_Sp[,1] = sample_Sp11;
  sample_Sp[,2] = sample_Sp12;
  sample_Sp[,3] = sample_Sp21;
  sample_Sp[,4] = sample_Sp22;
}

parameters {

  //
  // Observation process
  //
  // Eggs --> 0+ Juveniles (Ricker)
  real<lower=0, upper=1> prior_0p;
  real<lower=-10, upper=0> log_alpha;
  real beta;
  real<lower = -20, upper = 20> log_sigma2;
  vector[n] log_zerop_star; // No bound depending on Catched Spawners data possible
  // 0+ Juveniles --> Pre-Smolts
  real<lower=0, upper=1> gamma_0p;
  // Probability to smoltify as 1+ Smolts
  real<multiplier = 100> mu_theta_Sm1;
  real<lower=0 > sigma_theta_Sm1;
  vector<offset = mu_theta_Sm1, multiplier = sigma_theta_Sm1>[n] logit_theta_Sm1;
  // // 1+ Parrs --> 2+ Smolts
  real<lower=0, upper=1> gamma_Parr1;
  // // Survival 1+ Smolts
  real<multiplier = 100> mu_gamma_Sm1;
  real<lower=0 > sigma_gamma_Sm1;
  vector<offset = mu_gamma_Sm1, multiplier = sigma_gamma_Sm1>[n] logit_gamma_Sm1;
  // // Survival 2+ Smolts
  real<lower=0, upper=10> delta_gamma;
  // // Probability to mature as 1SW
  real<lower=0, upper=1> theta_m1;
  // // Survival of nonmaturing adults at sea
  real<lower=0, upper=1> gamma_Res;

  // // // Smolts capture probability
  real<multiplier=100> mu_pi_Sm;
  real<lower=0 > sigma_pi_Sm;
  vector<offset = mu_pi_Sm, multiplier = sigma_pi_Sm>[n] logit_pi_Sm;
  // // // Spawners capture probability
  real<multiplier = 100> mu_pi_Sp1;
  real<multiplier = 100> mu_pi_Sp2;
  real<lower=0 > sigma_pi_Sp1;
  real<lower=0 > sigma_pi_Sp2;
  vector<offset = mu_pi_Sp1, multiplier = sigma_pi_Sp1>[n] logit_pi_Sp1;
  vector<offset = mu_pi_Sp2, multiplier = sigma_pi_Sp2>[n] logit_pi_Sp2;
  // Proportion of female
  real<multiplier = 100> mu_pf1;
  real<multiplier = 100> mu_pf2;
  real<lower=0 > sigma_pf1;
  real<lower=0 > sigma_pf2;
  vector<offset = mu_pf1, multiplier = sigma_pf1>[n] logit_pf1;
  vector<offset = mu_pf2, multiplier = sigma_pf2>[n] logit_pf2;
  // //
  // Smolts
  real<lower=1, upper=10000> prior_PSm;
  real<lower=1, upper=1000> prior_PostSm1;
  real<lower=1, upper=1000> prior_PostSm2;
  // // Juveniles
  real<lower=1, upper=300> prior_Sm2;
  // // Spawners
  real<lower=1, upper=100> prior_Sp12;
  real<lower=1, upper=50> prior_Sp22;
}

transformed parameters {
  // // Smolts
  vector<lower=0, upper=1>[n] pi_Sm;
  vector[n] Sm; //<lower=C_Sm>
  vector<lower=0, upper=1>[n] rho_Sm;
  // Spawners
  vector<lower=0>[n] Sp;
  array[n] simplex[4] rho_Sp;
  vector<lower=0, upper=1>[n] pi_Sp1;
  vector<lower=0, upper=1>[n] pi_Sp2;
  // Proportion of female
  vector<lower=0, upper=1>[n] pf1;
  vector<lower=0, upper=1>[n] pf2;

  // Eggs spawned
  real alpha;
  real sigma2;
  vector<lower=0>[n] W_star;
  vector[n] logR_star; // log of Ricker
  // vector[n] log_zerop_star;
  vector<lower=0>[n] zerop;
  // Juvelines
  vector<lower=0, upper=1>[n] theta_Sm1;
  vector[n] Parr1; //<lower=1>
  vector<lower=0, upper=1>[n] gamma_Sm1;
  vector<lower=0, upper=1>[n] gamma_Sm2;
  //
  vector<lower=0>[n] Res1;
  vector<lower=0>[n] Res2;

  // Reconstructing Smolts and Spawners vectors
  // deterministic relationship between Smolts, Post Smolts and Spawners
  vector[n] PSm;
  vector[n] Sm1;//, <lower=0,upper=PSm>[n] Sm1;
  vector[n] Sm2;
  vector[n] PostSm1;
  // vector<lower=0>[n] Sp11;// upper=PostSm1>[n] Sp11;
  vector[n] PostSm2;
  vector[n] Sp11;
  vector[n] Sp21;

  // vector<lower=0>[n] Sp21;//, upper=PostSm2>[n] Sp21;
  // vector<lower=0>[n-1] Sp12_2n;//, upper=Res1[1:(n-1)]>[n-1] Sp12_2n;
  vector[n] Sp12;
  // vector<lower=0>[n-1] Sp22_2n;//, upper=Res2[1:(n-1)]>[n-1] Sp22_2n;
  vector[n] Sp22;

  // Transforming priors and probability parameters
  pi_Sm = inv_logit(logit_pi_Sm);
  pi_Sp1 = inv_logit(logit_pi_Sp1);
  pi_Sp2 = inv_logit(logit_pi_Sp2);
  pf1 = inv_logit(logit_pf1);
  pf2 = inv_logit(logit_pf2);
  alpha = exp(log_alpha);
  sigma2 = exp(log_sigma2);
  // Porbability to smoltify
  theta_Sm1 = inv_logit(logit_theta_Sm1);
  gamma_Sm1 = inv_logit(logit_gamma_Sm1);
  gamma_Sm2 = inv_logit(logit_gamma_Sm1 + delta_gamma);



  zerop[1] = prior_0p*surf;
  zerop[2:n] = surf* exp(log_zerop_star[2:n]);

  PSm[1] = prior_PSm;
  PSm[2:n] = gamma_0p * zerop[1:(n-1)];

  Sm1 = theta_Sm1 .* PSm;
  Parr1 =  PSm - Sm1;
  Sm2[1] = prior_Sm2;
  Sm2[2:n] = gamma_Parr1 * Parr1[1:(n-1)];

  PostSm1[1] = prior_PostSm1;
  PostSm1[2:n] = Sm1[1:(n-1)] .* gamma_Sm1[1:(n-1)];

  Sp11 = PostSm1 * theta_m1;
  Res1 = PostSm1 - Sp11;

  Sp12[1] = prior_Sp12;
  Sp12[2:n] = Res1[1:(n-1)] * gamma_Res;

  PostSm2[1] = prior_PostSm2;
  PostSm2[2:n] = Sm2[1:(n-1)] .* gamma_Sm2[1:(n-1)];
  Sp21 = PostSm2 * theta_m1;

  Res2 = PostSm2 - Sp21;
  Sp22[1] = prior_Sp22;
  Sp22[2:n] = Res2[1:(n-1)] * gamma_Res;

  // Hierarchical priors on trapping facilities
  // Smolts

  Sm = Sm1 + Sm2;
  rho_Sm = Sm1 ./ Sm;
  // // Spawners

  Sp = Sp11 + Sp12 + Sp21 + Sp22;
  for (t in 1:n) {
    rho_Sp[t] = [Sp11[t]/Sp[t], Sp21[t]/Sp[t], Sp12[t]/Sp[t], Sp22[t]/Sp[t]]';
  }
  // Sex ratio



  // Rikert
  W_star = ((Sp11 + Sp21 - x_Sp1) .* pf1 * fec1 +
           (Sp12 + Sp22 - x_Sp2) .* pf2 * fec2)./surf;
  logR_star = log(W_star) + log_alpha - beta * W_star;
}

model {
  // Priors for population dynamics

  beta ~ normal(0,.01);
  gamma_0p ~ beta(15,15);
  mu_theta_Sm1 ~ normal(0, 100);
  mu_gamma_Sm1 ~ normal(0,100);
  sigma_theta_Sm1 ~ cauchy(0,2.5);
  sigma_gamma_Sm1 ~ cauchy(0,2.5);
  logit_theta_Sm1 ~ normal(mu_theta_Sm1, sigma_theta_Sm1);
  logit_gamma_Sm1 ~ normal(mu_gamma_Sm1, sigma_gamma_Sm1);
  gamma_Parr1 ~ beta(20,10);
  theta_m1 ~ beta(3,2);
  gamma_Res ~ beta(3,2);

  // Priors for observation model
  mu_pi_Sm ~ normal(0, 100);
  mu_pi_Sp1 ~ normal(0, 100);
  mu_pi_Sp2 ~ normal(0, 100);
  mu_pf1 ~ normal(0,100);
  mu_pf2 ~ normal(0,100);

  sigma_pi_Sm ~ cauchy(0,2.5);
  sigma_pi_Sp1 ~ cauchy(0,2.5);
  sigma_pi_Sp2 ~ cauchy(0,2.5);
  sigma_pf1 ~ cauchy(0,2.5);
  sigma_pf2  ~ cauchy(0,2.5);


  logit_pi_Sm ~ normal(mu_pi_Sm, sigma_pi_Sm);
  logit_pi_Sp1 ~ normal(mu_pi_Sp1, sigma_pi_Sp1);
  logit_pi_Sp2 ~ normal(mu_pi_Sp2, sigma_pi_Sp2);
  logit_pf1 ~ normal(mu_pf1, sigma_pf1);
  logit_pf2 ~ normal(mu_pf2, sigma_pf2);

  // Process for hidden population dynamics
  // Spawners --> Eggs --> Juveniles
 // log_zerop_star_raw ~ std_normal();
  for (t in 1:(n-1)) {
    log_zerop_star[t+1] ~  normal(logR_star[t], sqrt(sigma2));
  }

  // Observation model
  // // Smolt run
  c_Sm ~ normal(Sm .* pi_Sm, sqrt(Sm .* pi_Sm .*(1-pi_Sm))); //approx binomial
  r_Sm ~ binomial(m_Sm, pi_Sm);
  // // Spawner run
  c_Sp ~ normal(Sp .* pi_Sp1, sqrt(Sp .* pi_Sp1 .* (1 - pi_Sp1)));  //approx binomial
  r_unm ~ normal((Sp - c_Sp) .* pi_Sp2,
             sqrt(((Sp - c_Sp) .* pi_Sp2 .* (1 - pi_Sp2))));//approx binomial
  rmad ~ binomial(mad, pi_Sp2) ;  // n is oberved.
  // // River age
  sample_Sm1 ~ binomial(sample_Sm_age, rho_Sm);
  for (t in 1:n) {
    sample_Sp[t] ~ multinomial(rho_Sp[t]); // N = sum(sample_Sp[t])
  }
  // Sex ratio in spawner run
  sample_Sp1f ~ binomial(sample_Sp1_sex, pf1);
  sample_Sp2f ~ binomial(sample_Sp2_sex, pf2);
}

