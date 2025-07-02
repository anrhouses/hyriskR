\name{plot_cdf}
\alias{plot_cdf}
\title{Depict the lower and upper CDFs}
\description{
Create a plot summarizing the uncertainty propagation in the form of a pair of lower and upper Cumulative Distribution Function CDFs.
}
\usage{
plot_cdf(Z0, new = TRUE, color1 = 1, color2 = 2, ...)
}
\arguments{
  \item{Z0}{
	Output of the uncertainty propagation function \emph{PROPAG()}.
}
  \item{new}{
	Logical (by default TRUE) to create a new plot or to add CDFs to an existing plot. By default \emph{new}=TRUE.
}
  \item{color1}{
	Color of the upper CDF. By default \emph{color1}=1.
}
  \item{color2}{
	Color of the lower CDF. By default \emph{color2}=2.
}
  \item{\dots}{
	Further arguments usually passed to the plot function (e.g. \emph{xlab}, \emph{ylab}, \emph{main}, etc.)
}
}
\seealso{\code{\link{propag}}}
\keyword{graphics}
