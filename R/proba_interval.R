proba_interval <-
	function(Z0, threshold){
	e = Z0[1,]
	F1 = ecdf(e)(threshold)
	e = Z0[2,]
	F2 = ecdf(e)(threshold)	
	return(list(Plow = min(F1, F2), Pupp = max(F1, F2)))
}
