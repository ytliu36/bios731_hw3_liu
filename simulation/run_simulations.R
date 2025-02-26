####################################################################
library(tidyverse)
library(here)
library(optparse)

# Define command-line arguments
option_list <- list(
  make_option(c("--scen"), type = "integer",, default = 1,
              help = "simulated_scenrio")
)
opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);
print(opt)
###############################################################
## define or source functions used in code below
###############################################################

source(here::here("source", "01_simulate_data.R"))
source(here::here("source", "02_apply_methods.R"))
source(here::here("source", "03_extract_estimates.R"))
###############################################################
## set simulation design elements
###############################################################
nsim = 475

n = c(20)
beta_true = c(0, 0.5)
eps_dist = c("normal", "gamma")

params = expand.grid(n = n,
                     n_sim = nsim,
                     beta_true = beta_true,
                     eps_dist = eps_dist)

###############################################################
## start simulation code
###############################################################
scenario = opt$scen
set.seed(2025)
params = params[scenario,]
# generate a random seed for each simulated dataset
seed = floor(runif(nsim, 1, 10000))
results = as.list(rep(NA, nsim))

for(i in 1:nsim){

  set.seed(seed[i])

  ####################
  # simulate data
  simdata = get_simdata(n = params$n,
                        beta_treat = params$beta_true,
                        eps_dist = params$eps_dist)

  ####################
  # apply method(s)
  start_w <- Sys.time()
  wald_res <- wald_CI(simdata)
  end_w <- Sys.time()

  start_np <- Sys.time()
  boot_np_res <- boot_np(simdata, 5000)
  end_np <- Sys.time()

  ####################
  # calculate estimates & store results, including estimates, speed, parameter scenarios
  results[[i]] = get_estimates(wald_res, boot_np_res, boot_t_res, params$beta_true, start_w, start_np, start_t, end_w, end_np, end_t)

}

####################
# save results

filename = paste0("scenario_", scenario, ".RDA")
save(results, file = here::here("data", filename))



