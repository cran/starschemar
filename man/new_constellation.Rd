% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/constellation.R
\name{new_constellation}
\alias{new_constellation}
\title{\code{constellation} S3 class}
\usage{
new_constellation(lst = list(), name = NULL)
}
\arguments{
\item{lst}{A list of \code{star_schema} objects.}

\item{name}{A string.}
}
\value{
A \code{constellation} object.
}
\description{
Internal low-level constructor that creates new objects with the correct
structure.
}
\keyword{internal}
