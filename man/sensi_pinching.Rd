\name{sensi_pinching}
\alias{sensi_pinching}
\title{
Sensitivity analysis using the pinching approach.
}
\description{
Function for conducting a sensitivity analysis using the pinching approach of Ferson and Tucker (2006). 
}
\usage{
sensi_pinching(Z0, Z0p, mode = "global", 
	       threshold = NULL, level = NULL, disc=0.01)
}
\arguments{
  \item{Z0}{
	Output of the uncertainty propagation function \emph{PROPAG()}.
}
  \item{Z0p}{
	Output of the pinching function \emph{pinching_fun()}.
}
  \item{mode}{
	String to specify the mode to represent the epistemic uncertainty: 
	\itemize{
		\item If "proba": interval of exceedance probability given the threshold.
		\item If "quantile": interval of quantile given the level.
		\item If "global": global indicator of uncertainty corresponding to the area between the upper and lower CDFs.
	}
}
  \item{threshold}{
	Threshold value to compute the interval of exceedance probabilities.
}
  \item{level}{
	Level value to compute the interval of quantiles.
}

  \item{disc}{
	discretisation value to compute the global indicator
}

}
\value{
A number between 0 and 100% representing the decrease of uncertainty. By default, emph{disc}=100.
}

\references{
Ferson, S., & Tucker, W. T. (2006). Sensitivity analysis using probability bounding. Reliability Engineering & System Safety, 91(10), 1435-1442.
}

\seealso{
\code{\link{pinching_fun}}
}
\examples{
\dontrun{
#################################################
#### EXAMPLE 1 of Dubois & Guyonnet (2011)
#### Probability and Possibility distributions
#################################################

#### Model function
FUN = function(X){
	UER = X[1]
	EF = X[2]
	I = X[3]
	C = X[4]
	ED = X[5]
	return(UER*I*C*EF*ED/(70*70*365))
}

ninput = 5 #Number of input parameters
input = vector(mode="list", length=ninput) # Initialisation

input[[1]] = create_input(
		name = "UER",
		type = "possi",
		distr = "triangle",
		param = c(2.e-2, 5.7e-2, 1.e-1),
		monoton = "incr"
		)
input[[2]] = create_input(
		name = "EF",
		type = "possi",
		distr = "triangle",
		param = c(200,250,350),
		monoton = "incr"
		)
input[[3]] = create_input(
		name = "I",
		type = "possi",
		distr = "triangle",
		param = c(1,1.5,2.5),
		monoton = "incr"
		)
input[[4]] = create_input(
		name = "C",
		type = "proba",
		distr = "triangle",
		param = c(5e-3,20e-3,10e-3)
		)
input[[5]] = create_input(
		name = "ED",
		type = "proba",
		distr = "triangle",
		param = c(10,50,30)
		)

####CREATION OF THE DISTRIBUTIONS ASSOCIATED TO THE PARAMETERS
input = create_distr(input)

####VISU INPUT
plot_input(input)

#################################################
#### PROPAGATION

#OPTIMZATION CHOICES
choice_opt=NULL #no optimization needed
param_opt=NULL

#PROPAGATION RUN
Z0_IRS = propag(N = 250, input, FUN, choice_opt, param_opt, mode = "IRS")

#################################################
#### PINCHING
Z0p = pinching_fun(
	which=1,##first input variable
	value = 5.7e-2, ##pinched at the scalar value of 5.7e-2
	N = 250,
	input,
	FUN,
	choice_opt,
	param_opt,
	mode="IRS"
	)

# VISU - PROPAGATION
plot_cdf(Z0_IRS, xlab = "Z", ylab = "CDF", main = "EX PINCHING", lwd=1.5)
plot_cdf(Z0p, color1 = 3, color2 = 4, new = FALSE, lwd = 1.5)

# sensitivity measure
sensi.global = sensi_pinching(Z0_IRS, Z0p)
print(paste("global sensitivity measure: ",sensi.global,sep=""))

}
}
