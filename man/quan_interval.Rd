\name{quan_interval}
\alias{quan_interval}
\title{
Interval of quantiles at a given level.
}
\description{
function for summarizing the uncertainty propagation's results in the form of an interval of quantiles at a given level. By default, the median value is provided (level = 0.5).
}
\usage{
quan_interval(Z0, level = 0.5)
}
\arguments{
  \item{Z0}{
	Output of the uncertainty propagation function propag()
}
  \item{level}{
	Value of the quantile level (e.g. 0.80 corresponds to the 80\% quantile).
}
}
\value{
	List with arguments \emph{Qlow} and \emph{Qupp} corresponding to lower and upper quantile values.
}

\details{
Details of the theory and the example in Dubois & Guyonnet (2011) 
Available at:
\url{https://hal-brgm.archives-ouvertes.fr/file/index/docid/578821/filename/Uncertainties_RA_09_l_dg.pdf}
}

\seealso{
\code{\link{propag}}
\code{\link{proba_interval}}
\code{\link{uncertainty}}
}

\examples{

#See example described for \emph{uncertainty}.
}


