sensi_regional_prob = function(Z, T, input, w = 0.5, PLOT = FALSE){
  Z1 = summary_1cdf(Z$Z,w)
  Pf = length(which(Z1>T))
  N = nrow(Z$r)
  d = ncol(Z$r)
  CFP = matrix(0,N,d)
  q = matrix(0,N,d)
  Name = NULL
  for (j in 1:d){
    Name[j] = paste(input[[j]]$name,input[[j]]$type)
    oo = order(Z$r[,j])
    Z1o = Z1[oo]
    q[,j] = Z$r[oo,j]
    for (i in 1:N){
      CFP[i,j] = sum(ifelse(Z1o[1:i] >T,1,0))
    }
  }
  CFP = CFP / Pf
  Pf = Pf / N
  if (PLOT == TRUE){
    for (j in 1:d){
      if (j==1){
        plot(q[,1],CFP[,1],
             col=j,ty="l",lwd=2,
             xlim=c(0,1.5),ylim=c(0,1),
             xlab="q",ylab="CFP",main=paste("Exceedance threshold",T)
        );abline(0,1)
      }else{
        lines(q[,j],CFP[,j],col=j,lwd=2)
      }
    }
    legend("bottomright",Name,lty=1,bty="n",col=1:d)
  }
  return(list(CFP=CFP,q=q,Pf=Pf))
}
