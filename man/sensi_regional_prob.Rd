\name{sensi_regional_prob}
\alias{sensi_regional_prob}
\title{Regional sensitivity analysis for exceedance probability}
\description{
Function for conducting the regional sensitivity analysis developed by (Rohmer and Verdel, 2014) to identiy the range of input values that influence the most the exceedance probability.
}
\usage{
sensi_regional_prob(Z, T, input, w = 0.5, PLOT = FALSE)
}
\arguments{
  \item{Z}{
	Output of the \emph{propag} function with argument \emph{return.r}= TRUE
}
  \item{T}{
	Exceedance threshold.
}
  \item{input}{
	List of inputs as provided by the function \emph{create_input()}.
}
  \item{w}{
  Weight value used to summarise the pairs of CDFs with the function \emph{summary_1cdf()}
}
  \item{PLOT}{
	Option for plotting the results
}
}

\details{
The approach relies on an adaptation of the contribution to sample probability of failure denoted \emph{CFP} plot, which provides the evolution of the exceedance probability of interest as a function of the quantile level or alpha-cut of the input variable. The higher the deviation from the first bissector, the higher the influence of the corresponding input.
}

\value{
A liste of elements
  \itemize{
    \item The matrix of CFP values
    \item The quantile level or alpha-cut
    \item The exceedance probability for the threshold \emph{T}
}
}
\references{
Rohmer, J., & Verdel, T. (2014). Joint exploration of regional importance of possibilistic and probabilistic uncertainty in stability analysis. Computers and Geotechnics, 61, 308-315.
}
\seealso{
\code{\link{propag}}
\code{\link{summary_1cdf}}
}
\examples{
\dontrun{

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
input[[4]]=create_input(
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

#### PROPAGATION
Z0_IRS = propag(N = 500, input, FUN, choice_opt, param_opt, mode = "IRS", sampler="strauss", return.r=TRUE)

#### CFP PLOT
S = sensi_regional_prob(Z0_IRS, T=1e-5,input, w = 0.7, PLOT = TRUE)

}
}
