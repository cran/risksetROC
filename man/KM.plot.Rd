\name{KM.plot}
\alias{KM.plot}
\title{Incident/Dynamic (I/D) ROC curve, AUC and integrated AUC (iAUC)
  estimation of censored survival data}
\description{This function creates Kaplan-Meier plot.
  }

\usage{KM.plot(Stime, survival, max.T=NULL, lty=NULL, all=TRUE, ...) 
}
\arguments{
  \item{Stime}{unique ordered event times}
  \item{survival}{estimates of survival probabilities at \emph{Stime}}
  \item{max.T}{maximum time to be considered for plotting, default is
    NULL which plots survival till  max(Stime)+1 units}
  \item{lty}{line type}
  \item{all}{TRUE or FALSE, default is TRUE}
  \item{...}{additional plot arguments}
}
\details{This function creates Kaplan-Meier plot. If \emph{all=TRUE}, then this
  creates a new plot. If \emph{all=FALSE}, it adds line to an existing plot and
  hence must be called after a plot() or similar call. 
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
