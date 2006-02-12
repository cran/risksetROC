\name{weightedKM}
\alias{weightedKM}
\title{Incident/Dynamic (I/D) ROC curve, AUC and integrated AUC (iAUC)
  estimation of censored survival data}
\description{This function estimates S(t) where sampling weights are
  permitted.  
  }

\usage{weightedKM(Stime, status, wt=NULL, entry=NULL) 
}
\arguments{
  \item{Stime}{Survival times when right censored data is considered. In
  case of interval censored data this is the end point for the time
  interval.}
  \item{status}{Survival status}
  \item{wt}{weight, default is unweighted}
  \item{entry}{entry times in case of interval censored data, default is
    \emph{NULL} when right censored data is considered}
}
\details{This function obtains survival function estimate where sampling
  weights are permitted.
}
\value{Returns a list of following items:
  \item{time}{ordered unique failure times}
  \item{survival}{survival estimate at the unique failure times}
}

\references{Heagerty, P.J., Zheng Y. (2005)
  Survival Model Predictive Accuracy and ROC curves
  \emph{Biometrics}, \bold{61}, 92 -- 105} 
\author{Patrick J. Heagerty }
\examples{
data(pbc)
## considering only randomized patients
pbc1 <- pbc[1:312,]
## create new censoring variable combine 0,1 as 0, 2 as 1
survival.status <- ifelse( pbc1$status==2, 1, 0)
survival.time <- pbc1$fudays
kout <- weightedKM(Stime=survival.time, status=survival.status)
KM.plot(kout$time,kout$survival)
}
\keyword{survival}

