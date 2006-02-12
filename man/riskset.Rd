\name{riskset}
\alias{riskset}
\title{Incident/Dynamic (I/D) ROC curve, AUC and integrated AUC (iAUC)
  estimation of censored survival data}
\description{
  This function creates risk set at each unique failure time from a
  survival data set.
}
\usage{riskset(dat, entry=FALSE)
}
\arguments{
  \item{dat}{survival dataset with at least three variables:
    survival.times, survival.status and marker, in that order. The
    survival data set may have additional variables. In case of interval
    censored data, the first four columns are: entry time, exit time,
    status at exit and marker }
  \item{entry}{default is FALSE indicating right censored data. TRUE if
    left truncated data}
}
\details{This function creates risk set at each unique failure time from
  a survival data set and is needed for llCoxReg(). The function can
  handle both right censored and interval censored data.
}
\value{Returns a new data set with columns as follows: start, finish,
  newStatus and other variables from the original dataset except
  survival time and status. The first two columns correspond to the
  start and end of time intervals considered and the newStatus
  corresponds to the survival status of the patient corresponding to
  this interval, i.e. the status is 1 if the patient had event during
  this interval (start, finish] and 0 otherwise. Note that the survival time need to be
  in ascending order.
}

\references{Heagerty, P.J., Zheng Y. (2005)
  Survival Model Predictive Accuracy and ROC curves
  \emph{Biometrics}, \bold{61}, 92 -- 105} 
\author{Patrick J. Heagerty }
\examples{
library(MASS)
data(VA)
## need to order the data in ascending order of survival time
new.VA=VA[order(VA$stime),]
risket.VA=riskset(new.VA)

}
\keyword{survival}
