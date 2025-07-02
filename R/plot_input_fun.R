plot_input_fun <-
	function(rr, which, input, choice_opt, param_opt){
	Xr = NULL
	inp = input[[which]]
	Xr = samp_proba2levels(inp, rr[which], input[inp$param], rr[inp$param], choice_opt, param_opt)
	return(Xr)
}