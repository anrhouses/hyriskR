create_distr <-
	function(input, DISCR = 1000){
	INPUT = lapply(input, create_distr_fun, DISCR)
	for (i in 1:length(INPUT)){
		if (INPUT[[i]]$type == "impr proba"){
			for (j in INPUT[[i]]$param){
				INPUT[[j]]$level = 2
			}
		}
	}	
	return(INPUT)
}
