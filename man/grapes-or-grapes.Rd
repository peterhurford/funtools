% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compose.R
\name{\%or\%}
\alias{\%or\%}
\title{Compose on NA, NULL, or lenth-0 (empty) values.}
\usage{
x \%or\% y
}
\arguments{
\item{x}{object. This object will be returned if non-NA, non-NULL, non-empty.}

\item{y}{object. This object will be returned if x is NA, NULL, or empty.}
}
\value{
either x or y.
}
\description{
Compose on NA, NULL, or lenth-0 (empty) values.
}
