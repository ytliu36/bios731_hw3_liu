
get_estimates = function(res_wd, res_np, beta_true, start_wd, start_np, end_wd, end_np){
  bias = c(res_wd[1], res_np[1])-beta_true
  se = c(res_wd[2], res_np[2])
  cover = c((beta_true>=res_wd[3] & beta_true<=res_wd[4]), (beta_true>=res_np[3] & beta_true<=res_np[4]))
  cover0 = c((0>=res_wd[3] & 0<=res_wd[4]), (0>=res_np[3] & 0<=res_np[4]))
  time = as.numeric(c(end_wd-start_wd,end_np-start_np))
  return(c(bias, se, cover,cover0, time))
}
