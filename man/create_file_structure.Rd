% Generated by roxygen2 (4.0.1): do not edit by hand
\name{create_file_structure}
\alias{create_file_structure}
\alias{within_file_structure}
\title{Create a file structure for tests.}
\usage{
create_file_structure(files, expr, dir)

within_file_structure(files, expr, dir)
}
\arguments{
\item{files}{character or list or NULL. A nested file structure. The names of the
list will decide the names of the files, and the terminal nodes should be
strings which will populate the file bodies. One can also specify a
character (for example, \code{files = c('a','b','c')} will create three
files with those filenames). By default, \code{files = NULL} in which case
simply an empty directory will be created.}

\item{expr}{expression. An expression to evaluate within which the files
should exist, but outside of which the files should be unlinked. If
missing, the directory of the will be returned. Otherwise, the
value obtained in this expression will be returned.}

\item{dir}{character. The directory in which to create the files. If
missing, a temporary directory will be created instead using
the built-in \code{tempfile()} helper.}
}
\value{
the directory in which this file structure exists, if \code{expr}
   is not missing. If \code{expr} was provided, its return value will be
   returned instead.
}
\description{
A helper function for creating hierarchical file structures
when, e.g., testing functions which rely on presence of files.

An alias for create_file_structure that only allows expressions.
}
\details{
For example, when files need to be present for a function we are testing,
it would be very cumbersome to create these files manually. Instead, we can
do the following:

\code{test_dir <- create_file_structure(list(dir1 = list('file1',
   file2.r = 'print("Sample R code")'), file3.csv = "a,b,c\n1,2,3"))}

with the return value being a test directory containing these structured files.

An additional feature is that expressions can be evaluated within the scope
of the hierarchical files existing, with the files getting deleted after
the expression executes:

\code{create_file_structure(list(a = "hello\nworld"),
  cat(readLines(file.path(tempdir, 'a'))[[2]]))}

The above will print \code{"world"}. (\code{tempdir} is set automatically
within the scope of the expression to the directory that was created for
the temporary files.)
}
\examples{
\dontrun{
  library(testthat)
  test_dir <- create_file_structure(list(test = 'blah', 'test2'))
  # Now test_dir is the location of a directory containing a file 'test'
  # with the string 'blah' and an empty file 'test2'.

  test_dir <- create_file_structure(list(alphabet = as.list(LETTERS)))
  # Now test_dir is the location of a directory containing a subdirectory
  # 'alphabet' with the files 'A', 'B', ..., 'Z' (all empty).

  test_dir <- create_file_structure(list(a = 'hello'), {
    cat(readLines(file.path(tempdir, 'a')))
  })
}
library(testthat)
expect_output(within_file_structure(list(a = 'hello'), {
  cat(readLines(file.path(tempdir, 'a')))
}), 'hello')
# The above will create a directory with a file named "a" containing the string
# 'hello', print it by reading the file, and then unlink the directory.
}

