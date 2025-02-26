## Wald confidence
wald_CI<-function(data, alpha=0.05){
  model<-lm(y~x, data = data)
  if (dim(summary(model)$coefficients)[1] == 1){
    return(c(NA,NA,NA,NA))
  }
  else{
    mean = summary(model)$coefficients[2,1]
    sd = summary(model)$coefficients[2,2]
    lCI = mean+qnorm(alpha/2)*sd
    uCI = mean+qnorm(1-alpha/2)*sd
    return(c(mean, sd, lCI, uCI))
  }
}
## nonparametric percentile
boot_np<-function(data, B, alpha = 0.05){
  boot_mean = rep(NA, B)
  model1<-lm(y~x, data = data)
  if (dim(summary(model1)$coefficients)[1] == 1){
    return(c(NA,NA,NA,NA))
  }else{
  for (i in 1:B){
    repeat{
      index <- sample(1:dim(data)[1], dim(data)[1], replace = TRUE)
      model<-lm(y~x, data = data[index,])

      if (dim(summary(model)$coefficients)[1] > 1) {
        boot_mean[i] <- summary(model)$coefficients[2,1]
        break
      }
    }
  }
  return(c(mean(boot_mean), sd(boot_mean), quantile(boot_mean, probs = c(alpha/2,1-(alpha/2)))))
  }
}
