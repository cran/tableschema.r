% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/types.castNumber.R
\name{types.castNumber}
\alias{types.castNumber}
\title{Cast numbers of any kind including decimals}
\usage{
types.castNumber(
  format,
  value,
  options = {
 }
)
}
\arguments{
\item{format}{no options (other than the default)}

\item{value}{number to cast}

\item{options}{available options are "decimalChar", "groupChar" and "bareNumber", where
\describe{
\item{\code{decimalChar }}{A string whose value is used to represent a decimal point within the number. The default value is ".".}
\item{\code{groupChar }}{A string whose value is used to group digits within the number. The default value is null. A common value is "," e.g. "100,000".}
\item{\code{bareNumber }}{A boolean field with a default of \code{TRUE} If \code{TRUE} the physical contents of this field must follow 
the formatting constraints already set out. If \code{FALSE} the contents of this field may contain leading and/or 
trailing non-numeric characters (which implementors MUST therefore strip). The purpose of \code{bareNumber} is to allow publishers 
to publish numeric data that contains trailing characters such as percentages e.g. 95% or leading characters such as currencies 
e.g. €95 or EUR 95. Note that it is entirely up to implementors what, if anything, they do with stripped text.}
}}
}
\description{
Cast numbers of any kind including decimals.
}
\details{
The lexical formatting follows that of decimal in \href{https://www.w3.org/TR/xmlschema-2/#decimal}{XMLSchema}: a non-empty finite-length sequence 
of decimal digits separated by a period as a decimal indicator. An optional leading sign is allowed. If the sign is omitted, "+" is assumed. 
Leading and trailing zeroes are optional. If the fractional part is zero, the period and following zero(es) can be omitted. 
For example: '-1.23', '12678967.543233', '+100000.00', '210'.

The following special string values are permitted (case need not be respected):
\itemize{
\item{\code{NaN}: not a number}
\item{\code{INF}: positive infinity}
\item{\code{-INF}: negative infinity}
}

A number MAY also have a trailing:
\itemize{
\item{\code{exponent}: this \code{MUST} consist of an E followed by an optional + or - sign followed by one or more decimal digits (0-9)}
}
}
\examples{

types.castNumber(format = "default", value = 1)
types.castNumber(format = "default", value = "1.0")

# cast number with  percent sign
types.castNumber(format = "default", value = "10.5\%", options = list(bareNumber = FALSE))

# cast number with comma group character
types.castNumber(format = "default", value = "1,000", options = list(groupChar = ','))
types.castNumber(format = "default", value = "10,000.50", options = list(groupChar = ','))

# cast number with "#" group character and "&" as decimal character
types.castNumber(format = "default", value = "10#000&50", 
options = list(groupChar = '#', decimalChar = '&'))

}
\seealso{
\href{https://specs.frictionlessdata.io//table-schema/#number}{Types and formats specifications}
}
