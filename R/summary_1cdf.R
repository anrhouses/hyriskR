summary_1cdf <-
	function(Z0, aversion = 0.5){
	Z = aversion*Z0[2,]+(1-aversion)*Z0[1,]
	return(Z)
}
