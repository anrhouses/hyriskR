# hyriskR: a R package for hybrid uncertainty quantification in risk assessments

Uncertainty analysis is an unavoidable risk assessment task (for instance for natural hazards, or for environmental issues). In situations where data are scarce, incomplete or imprecise, the systematic and only use of probabilities can be debatable. Several alternative mathematical representation methods have been developed to handle in a more flexible manner the lack of knowledge related to input parameters of risk assessment models. We present here an R package `hyriskR` dedicated to jointly handling different mathematical representation tools, namely probabilities, possibility distributions and probability functions with imprecise parameters, for the different stages of uncertainty treatment in risk assessments (i.e,. uncertainty representation, propagation, sensitivity analysis and decision-making).

## Scientific documentation of the methods

-   [Guyonnet et al., 2003](https://doi.org/10.1061/(ASCE)0733-9372(2003)129:1(68))
-   [Baudrit et al., 2007](https://doi.org/10.1016/j.ijar.2006.07.001)

## Installation

This package can be installed directly by running:

``` r
devtools::install_github("anrhouses/hyriskR")
```

## Tutorial

Two tutorials are available
* on the use of probabilities and possibilities [R markdown available here](vignettes/possibility.Rmd)
* on the use of p-boxes [R markdown available here](vignettes/pbox.Rmd)
