propag <-
	function(N, input, FUN, choice_opt = "L-BFGS-B", param_opt = NULL, mode = "IRS", corr = 1.e-2, NL = 10, sampler = "lhs",return.r = FALSE){
	if (mode == "IRS"){
		d = length(input)
		if (sampler == "lhs"){
			rr = lhsDesign(N,d)$design*(1-corr)
		}else if(sampler == "strauss"){
			rr = straussDesign(n=N, dimension=d, RND=0.2, NMC=200,constraints1D=0, alpha=0, repulsion=0.01)$design*(1-corr)
		}else if(sampler == "base"){
			rr = matrix(runif(N*d,0,1-corr),ncol=d)
		}
		Z0 = apply(rr, 1, propag_fun, N, input, FUN, choice_opt, param_opt)
	}
	if (mode == "HYBRID"){
		d = length(input)
		rr = matrix(,nrow = N*NL, ncol = d)
		l = rep(seq(0, 1-corr, length = NL), each = N)
		allpossi=0
		for (i in 1:d){
			if (input[[i]]$type == "possi"|input[[i]]$type == "fixed"){
				rr[,i] = l
				allpossi = allpossi+1
			} else if (input[[i]]$type == "proba"|input[[i]]$type == "impr proba"){
				rr[,i] = runif(N*NL)
			}
		}
		if (allpossi == d){
			rr = matrix(rep(seq(0, 1-corr, length = N*NL), d), ncol = d)
		}
		Z0 = apply(rr, 1, propag_fun, N, input, FUN, choice_opt, param_opt)
	}
	if(return.r == FALSE){
		return(Z0)
	}else{
		return(list(Z=Z0,r=rr))
	}	
}
