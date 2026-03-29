\name{propag_meta}
\alias{propag_meta}
\title{Function for conducting joint propagation of uncertainty (probability and possibility) with kriging surrogate models}
\description{
Function for conducting joint propagation of probability, and possibilisty distributions (or intervals) by combining  IRS (Baudrit et al., 2006) and kriging surrogate models (Roustant et al., 2012) by following the approach of Lockwood et al. (2012).
}
\usage{
propag_meta = function(Z, r, N = 1000, corr = 0.01)
}
\arguments{
  \item{Z}{
	Matrix 2 x n of n precalculated lower and upper bounds of the target variable.
}
  \item{r}{
	Matrix n x d quantile levels or alpha-cuts at which the d inputs are sampled to calculate the lower and upper bounds of the target variable.
}
  \item{N}{
	Integer corresponding to the number of random samples. By default, \emph{N}=1000.
}
  \item{corr}{
	Tolerance to avoid empty alpha-cuts. By default, \emph{corr}=0.01.
}
}

\value{
	Matrix Z0 of 2 rows and \emph{N} columns.
	This corresponds to the set of random intervals (row Number 1: lower bound; row Number 2: upper bound), which can be summarized in different forms, see Baudrit et al. (2006).
}
\references{
	\itemize{
		\item Baudrit, C., Dubois, D., & Guyonnet, D. 2006. Joint propagation and exploitation of probabilistic and possibilistic information in risk assessment. IEEE transactions on fuzzy systems, 14(5), 593-608.
		\item Roustant, O., Ginsbourger, D., & Deville, Y. (2012). DiceKriging, DiceOptim: Two R packages for the analysis of computer experiments by kriging-based metamodeling and optimization. Journal of statistical software, 51, 1-55.
		\item Lockwood, B., Anitescu, M., & Mavriplis, D. (2012). Mixed aleatory/epistemic uncertainty quantification for hypersonic flows via gradient-based optimization and surrogate models. In 50th AIAA Aerospace Sciences Meeting Including the New Horizons Forum and Aerospace Exposition (p. 1254).
}
}
\seealso{
\code{\link{propag}}
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

#################################################
#### REFERENCE SOLUTION

#OPTIMZATION CHOICES
choice_opt=NULL #no optimization needed
param_opt=NULL
N = 500

#PROPAGATION RUN
Z0_IRS = propag(N = N, input, FUN, choice_opt, param_opt, mode = "IRS", return.r=FALSE)

#################################################
#### 50 PRECALCULATED SOLUTIONS
Z00 = propag(N = 50, input, FUN, choice_opt, param_opt, mode = "IRS", return.r=TRUE)

#################################################
#### SURROGATE MODELLING

Z0_META = propag_meta(Z00$Z, r = Z00$r)

# COMPARE
plot_cdf(Z0_IRS, xlab = "Z", ylab = "CDF", main = "", lwd=0.5)
plot_cdf(Z0_META, xlab = "Z", ylab = "CDF", main = "", lwd=5.5,new = FALSE, color1 = "grey",color2 = "tomato")


}
}
