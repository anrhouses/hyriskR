sensi_pinching <-
	function(Z0, Z0p, mode = "global", threshold = NULL, level = NULL, disc = 0.01){
	if (mode == "global"){
		unc0 = uncertainty(Z0, disc)
		unc = uncertainty(Z0p, disc)
	} else if (mode == "proba"){
		p0 = proba_interval(Z0, threshold)
		p = proba_interval(Z0p, threshold)
		unc0 = p0$Pupp-p0$Plow
		unc = p$Pupp-p$Plow
	} else if (mode == "quantile"){
		q0 = quan_interval(Z0, level)
		q = quan_interval(Z0p, level)
		unc0 = q0$Qupp-q0$Qlow
		unc = q$Qupp-q$Qlow
	}
	sensi = 100*(1-unc/unc0)
	return(sensi)
}
