% Generated by roxygen2 (4.0.1): do not edit by hand
\name{package_stub}
\alias{package_stub}
\title{Stub a function in a package by replacing it with something else.}
\usage{
package_stub(package_name, function_name, stubbed_value, expr)
}
\arguments{
\item{package_name}{character. The name of the package to look in.}

\item{function_name}{character. The name of the function to stub.}

\item{stubbed_value}{function. The function to temporarily replace this function with.}

\item{expr}{expression. An expression to evaluate with the stubbed changes.
The stubbing will be reverted after this expression is executed.}
}
\description{
Stubbing a function in a package can only be done in the context of
some expression (a block of code). Otherwise, dangerous things could happen!
(We are actually replacing the function in the package's namespace.)
}
\examples{
package_stub("methods", "new", function(...) 'test', stopifnot(new('example') == 'test'))
}

