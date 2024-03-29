% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/constraints.R
\docType{class}
\name{Constraints}
\alias{Constraints}
\title{Constraints class}
\format{
\code{\link{R6Class}} object.
}
\value{
Object of \code{\link{R6Class}} .
}
\description{
R6 class with constraints.

The constraints property on Table Schema Fields can be used by consumers to list constraints for 
validating field values. For example, validating the data in a Tabular Data Resource against 
its Table Schema; or as a means to validate data being collected or updated via a data entry interface.

All constraints \code{MUST} be tested against the logical representation of data, and the physical 
representation of constraint values \code{MAY} be primitive types as possible in JSON, 
or represented as strings that are castable with the type and format rules of the field.
}
\section{Fields}{

\describe{
\item{\code{constraints}}{see Section See Also}
}}

\seealso{
\href{https://specs.frictionlessdata.io//table-schema/#constraints}{Constraints specifications},
\code{\link{constraints.checkEnum}}, 
\code{\link{constraints.checkMaximum}},
\code{\link{constraints.checkMaxLength}},
\code{\link{constraints.checkMinimum}},
\code{\link{constraints.checkMinLength}},
\code{\link{constraints.checkPattern}},
\code{\link{constraints.checkRequired}},
\code{\link{constraints.checkUnique}}
}
\keyword{data}
