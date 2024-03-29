% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/types.castDuration.R
\name{types.castDuration}
\alias{types.castDuration}
\title{Cast duration of time}
\usage{
types.castDuration(format = "default", value)
}
\arguments{
\item{format}{no options (other than the default)}

\item{value}{duration to cast}
}
\description{
Cast duration of time
}
\details{
We follow the definition of \href{https://www.w3.org/TR/xmlschema-2/#duration}{XML Schema duration datatype} 
directly and that definition is implicitly inlined here.

To summarize: the lexical representation for duration is the \href{https://en.wikipedia.org/wiki/ISO_8601#Durations}{ISO 8601}
extended format PnYnMnDTnHnMnS, where nY represents the number of years, nM the number of months, nD the number of days, 
'T' is the date/time separator, nH the number of hours, nM the number of minutes and nS the number of seconds. 
The number of seconds can include decimal digits to arbitrary precision. 
Date and time elements including their designator may be omitted if their value is zero, 
and lower order elements may also be omitted for reduced precision.
}
\examples{

types.castDuration(format = "default", value = durations(years= 10))

types.castDuration(format = "default", value = "P1Y10M3DT5H11M7S")
 
}
\seealso{
\href{https://specs.frictionlessdata.io//table-schema/#duration}{Types and formats specifications}, 
\code{\link[lubridate]{lubridate-package}}.
}
