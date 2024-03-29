#' Table Schema Package
#' @description Table class for working with data and schema
#' @docType package
#' 
#' @section Introduction:
#' 
#' Table Schema is a simple language- and implementation-agnostic way to declare a schema for tabular data. 
#' Table Schema is well suited for use cases around handling and validating tabular data in text formats 
#' such as CSV, but its utility extends well beyond this core usage, towards a range of applications 
#' where data benefits from a portable schema format.
#' 
#' @section Concepts:
#' #
#' @section Tabular data:
#' Tabular data consists of a set of rows. Each row has a set of fields (columns). 
#' We usually expect that each row has the same set of fields and thus we can talk about 
#' the fields for the table as a whole.
#' 
#' In case of tables in spreadsheets or CSV files we often interpret the first row as a header row, 
#' giving the names of the fields. By contrast, in other situations, e.g. tables in SQL databases, 
#' the field names are explicitly designated.
#'   
#' @section Physical and logical representation:
#' 
#' In order to talk about the representation and processing of tabular data from text-based sources, 
#' it is useful to introduce the concepts of the \emph{physical} and the \emph{logical} representation of data.
#' 
#' The \emph{physical representation} of data refers to the representation of data as text on disk, 
#' for example, in a CSV or JSON file. This representation may have some type information 
#' (JSON, where the primitive types that JSON supports can be used) or not 
#' (CSV, where all data is represented in string form).
#' 
#' The \emph{logical representation} of data refers to the "ideal" representation of the data 
#' in terms of primitive types, data structures, and relations, all as defined by the specification. 
#' We could say that the specification is about the logical representation of data, 
#' as well as about ways in which to handle conversion of a physical representation to a logical one.
#' 
#' In this document, we'll explicitly refer to either the \emph{physical} or \emph{logical} representation 
#' in places where it prevents ambiguity for those engaging with the specification, especially implementors.
#' 
#' For example, \code{constraints} should be tested on the logical representation of data, 
#' whereas a property like \code{missingValues} applies to the physical representation of the data.
#' 
#' 
#' @section Descriptor:
#' 
#' A Table Schema is represented by a descriptor. The descriptor \code{MUST} be a JSON \code{object} 
#' (JSON is defined in \href{https://www.ietf.org/rfc/rfc4627.txt}{RFC 4627}).
#' 
#' It \code{MUST} contain a property \code{fields}. \code{fields} \code{MUST} be an array/list where each entry 
#' in the array/list is a field descriptor (as defined below). The order of elements in \code{fields} array/list 
#' \code{MUST} be the order of fields in the CSV file. The number of elements in \code{fields} array/list 
#' \code{SHOULD} be exactly the same as the number of fields in the CSV file.
#' 
#' The descriptor \code{MAY} have the additional properties set out below and \code{MAY} contain 
#' any number of other properties (not defined in this specification).
#' 
#' 
#' @section Field Descriptors:  
#' See \code{\link{Field}} Class
#' 
#' @section Types and Formats:
#' See \code{\link{Types}} Class
#' 
#' @section Constraints:
#' See \code{\link{Constraints}} Class
#' 
#' @section Other Properties:
#' In additional to field descriptors, there are the following "table level" properties.
#' 
#' @section Missing Values:
#' 
#' Many datasets arrive with missing data values, either because a value was not collected or 
#' it never existed. Missing values may be indicated simply by the value being empty in other 
#' cases a special value may have been used e.g. -, NaN, 0, -9999 etc.
#' 
#' \code{missingValues} dictates which string values should be treated as null values. 
#' This conversion to null is done before any other attempted type-specific string conversion. 
#' The default value \code{list("")} means that empty strings will be converted to null before any other 
#' processing takes place. Providing the empty list means that no conversion to null will 
#' be done, on any value.
#' 
#' \code{missingValues} \code{MUST} be a list where each entry is a string.
#' 
#' \strong{Why strings}: \code{missingValues} are strings rather than being the data type of the particular field. 
#' This allows for comparison prior to casting and for fields to have missing value which are not 
#' of their type, for example a \code{number} field to have missing values indicated by -.
#' 
#' Examples:
#' \itemize{
#' \item{missingValues = list("")}
#' \item{missingValues = list("-")}
#' \item{missingValues = list("NaN", "-")}
#' }
#' 
#' @section Primary Key:
#' A primary key is a field or set of fields that uniquely identifies each row in the table.
#' 
#' The \code{primaryKey} entry in the schema \code{object} is optional. If present it specifies the primary key for this table.
#' 
#' The \code{primaryKey}, if present, \code{MUST} be:
#' \itemize{
#' \item{Either: an array of strings with each string corresponding to one of the field \code{name} values in the \code{fields} array 
#' (denoting that the primary key is made up of those fields). It is acceptable to have an array with a single value 
#' (indicating just one field in the primary key). Strictly, order of values in the array does not matter. 
#' However, it is RECOMMENDED that one follow the order the fields in the \code{fields} has as client applications may 
#' utitlize the order of the primary key list (e.g. in concatenating values together).
#' }
#' \item{Or: a single string corresponding to one of the field \code{name} values in the \code{fields} array/list 
#' (indicating that this field is the primary key). Note that this version corresponds to the array form 
#' with a single value (and can be seen as simply a more convenient way of specifying a single field primary key).
#' }
#' }
#'
#'  
#' @section Foreign Keys:
#' A foreign key is a reference where values in a field (or fields) on the table ('resource' in data package terminology) 
#' described by this Table Schema connect to values a field (or fields) on this or a separate table (resource). 
#' They are directly modelled on the concept of foreign keys in SQL.
#' 
#' The \code{foreignKeys} property, if present, \code{MUST} be a list Each entry in the array must be a \code{foreignKey}. 
#' A \code{foreignKey} \code{MUST} be a object and \code{MUST} have the following properties:
#' 
#' \itemize{
#' \item{\code{fields} - \code{fields} is a string or array specifying the field or fields on this resource that form the source part 
#' of the foreign key. The structure of the string or array is as per \code{primaryKey} above.}
#' 
#' \item{\code{reference} - \code{reference} \code{MUST} be a object. The object
#' \itemize{
#' 
#' \item{\code{MUST} have a property \code{resource} which is the name of the resource within the current data package 
#' (i.e. the data package within which this Table Schema is located). For self-referencing foreign keys, 
#' i.e. references between fields in this Table Schema, the value of \code{resource} \code{MUST} be \code{""} (i.e. the empty string).}
#' 
#' \item{\code{MUST} have a property \code{fields} which is a string if the outer \code{fields} is a string, 
#' else an array of the same length as the outer \code{fields}, describing the field (or fields) references 
#' on the destination resource. The structure of the string or array is as per \code{primaryKey} above.}
#' }
#' 
#' }
#' }
#' 
#' 
#' \strong{Comment}: Foreign Keys create links between one Table Schema and another Table Schema, 
#' and implicitly between the data tables described by those Table Schemas. If the foreign key is referring to 
#' another Table Schema how is that other Table Schema discovered? The answer is that a Table Schema will 
#' usually be embedded inside some larger descriptor for a dataset, in particular as the schema for a resource 
#' in the resources array of a href{http://frictionlessdata.io/specs/data-package/}{Data Package}. 
#' It is the use of Table Schema in this way that permits a meaningful use of a non-empty \code{resource} 
#' property on the foreign key.
#' 
#' 
#' @section Details:
#' 
#' \href{https://CRAN.R-project.org/package=jsonlite}{Jsolite package} is internally used to convert json data to list objects. The input parameters of functions could be json strings, 
#' files or lists and the outputs are in list format to easily further process your data in R environment and exported as desired. 
#' More details about handling json you can see jsonlite documentation or vignettes \href{https://CRAN.R-project.org/package=jsonlite}{here}.
#' 
#' \href{https://CRAN.R-project.org/package=future}{Future package} is also used to load and create Table and Schema classes asynchronously. 
#' To retrieve the actual result of the loaded Table or Schema you have to use \code{\link[future]{value}} function to the variable you stored the loaded Table/Schema. 
#' More details about future package and sequential and parallel processing you can find \href{https://CRAN.R-project.org/package=future}{here}.
#' 
#' Examples section of each function show how to use \code{jsonlite} and \code{future} packages with \code{tableschema.r}. 
#' 
#' Term array refers to json arrays which if converted in R will be \code{\link[base:list]{list objects}}.
#' 
#' @section Language:
#' The key words \code{MUST}, \code{MUST NOT}, \code{REQUIRED}, \code{SHALL}, \code{SHALL NOT}, 
#' \code{SHOULD}, \code{SHOULD NOT}, \code{RECOMMENDED}, \code{MAY}, and \code{OPTIONAL} 
#' in this package documents are to be interpreted as described in \href{https://www.ietf.org/rfc/rfc2119.txt}{RFC 2119}.
#' 
#' 
#' @name tableschema.r-package
#' 
#' @seealso 
#' \href{https://specs.frictionlessdata.io//table-schema/}{Table Schema Specifications}
#' 
NULL