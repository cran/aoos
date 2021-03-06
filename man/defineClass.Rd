% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DC-defineClass.R, R/DC-public-interfaces.R
\docType{methods}
\name{defineClass}
\alias{defineClass}
\alias{private}
\alias{private,public-method}
\alias{public}
\alias{public,function-method}
\alias{public,private-method}
\alias{public,public-method}
\title{Define a new class}
\usage{
defineClass(name, expr, contains = NULL)

private(x)

\S4method{private}{public}(x)

public(x = NULL, validity = function(x) TRUE)

\S4method{public}{`function`}(x = NULL, validity = function(x) TRUE)

\S4method{public}{private}(x = NULL, validity = function(x) TRUE)

\S4method{public}{public}(x = NULL, validity = function(x) TRUE)
}
\arguments{
\item{name}{character name of the class}

\item{expr}{expression}

\item{contains}{character name of class from which to inherit}

\item{x}{an object made public}

\item{validity}{function to check the validity of an object}
}
\description{
This is an experimental implementation of reference classes. Use \code{\link{defineRefClass}} or \code{\link{retList}} instead. \code{defineClass} has side effects. The constructor is the return value of \code{defineClass}.
}
\details{
\code{defineClass} creates a S4-Class which can be used for standard S4 method dispatch. It will also set the method 'initialize' which need not to be changed. If you want to have some operations carried out on initialization use a function definition named \code{init} as part of \code{expr}. The return value from \code{defineClass} is the constructor function. It has the argument \code{...} which will be passed to \code{init}.

All classes defined with \code{defineClass} inherit from class "aoos" which is a S4-class containing an environment. In that environment \code{expr} is evaluated; for inheritance, all \code{expr} from all parents will be evaluated first.

Everything in \code{expr} will be part of the new class definition. A leading dot in a name will be interpreted as private. You can use \code{public} and \code{private} to declare private and public members explicitly. If \code{x} in a call to \code{public} is a function it will be a public member function (method). For any other class the return value of \code{public} is a get and set method. If called without argument it will get the value, if called with argument it will set the value. You can define a validity function which will be called whenever the set method is called. Objects which inherit from class \code{environment} can be accessed directly, i.e. not via get/set methods. If you want to access fields without get/set methods, you can use the class \code{\link{Accessor-class}}.
}
\examples{
test <- defineClass("test", {
  x <- "Working ..."
  .y <- 0
  doSomething <- public(function() {
    self$.y <- .y + 1
    cat(x(), "\\n")
    invisible(self)
  })
})
instance <- test()
\dontrun{
instance$.y # error
}
instance$doSomething()$doSomething()
instance$x()
instance$x(2)
instance$x()

# Example for reference classes as field
MoreTesting <- defineClass("MoreTesting", {
  refObj <- test()
})
instance <- MoreTesting()
instance$refObj$x()
}
\seealso{
\code{\link{Accessor-class}}, \code{\link{Binary-class}}, \code{\link{Show-class}}
}
