propag_meta = function(Z, r, N = 1000, corr = 0.01){
  km0 = DiceKriging::km(~.,response=Z[1,],design = r)
  km1 = DiceKriging::km(~.,response=Z[2,],design = r)
  d = ncol(r)
  rr = matrix(runif(N*d,0,1-corr),ncol=d)
  pred0 = predict(km0, rr, type="UK", checkNames = FALSE, light.return = TRUE)
  pred1 = predict(km1, rr, type="UK", checkNames = FALSE, light.return = TRUE)
  Z0_META = rbind(pred0$mean,pred1$mean)
  return(Z0_META)
}
