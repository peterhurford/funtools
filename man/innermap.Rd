% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functionals.R
\name{innermap}
\alias{innermap}
\title{Iterate a function over each sublist in a list of lists.}
\usage{
innermap(xs, f, ...)
}
\arguments{
\item{xs}{list. The list-of-lists to iterate over.}

\item{f}{function. The function to apply.}

\item{...}{list. Additional optional arguments to pass to lapply.}
}
\description{
Iterate a function over each sublist in a list of lists.
}
