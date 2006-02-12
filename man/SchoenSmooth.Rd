\name{SchoenSmooth}
\alias{SchoenSmooth}
\title{Incident/Dynamic (I/D) ROC curve, AUC and integrated AUC (iAUC)
  estimation of censored survival data}
\description{This function smooths the Schoenfeld residuals using
  Epanechnikov's optimal kernel.  
  }

\usage{SchoenSmooth(fit, Stime, status, span=0.40, order=0, entry=NULL)
}
\arguments{
  \item{fit}{the result of fitting a Cox regression model, using the
    coxph function}
  \item{Stime}{Survival times in case of right censored data and exit
    time for left truncated data}
  \item{status}{Survival status}
  \item{span}{bandwidth parameter that controls the size of a local
    neighborhood}
  \item{order}{0 or 1, locally mean if 0 and local linear if 1}
  \item{entry}{entry time when left censored data is considered, default
  is NULL for only right censored data}

  }
\details{This function smooths the Schoenfeld residuals to get an
  estimate of time-varying effect of the marker using
  Epanechnikov's optimal kernel using either local mean or local
  linear smoother. 
}
\value{Returns a list of following items:
  \item{time}{failure times}
  \item{beta}{estimate of time-varying parameter \eqn{\beta(t)} at each
    unique failure time. }
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
pbc1$status1 <- survival.status
fit <- coxph( Surv(fudays,status1) ~ log(bili) +
                                     log(protime) +
                                     edema +
                                     albumin +
                                     age,
              data=pbc1 )
eta5 <- fit$linear.predictors
x <- eta5
nobs <- length(survival.time[survival.status==1])
span <- 1.5*(nobs^(-0.2))
fitCox5 <- coxph( Surv(survival.time,survival.status) ~ x )
bfnx1.1 <- SchoenSmooth( fit=fitCox5, Stime=survival.time, status=survival.status,
                       span=span, order=1)
bfnx1.0 <- SchoenSmooth( fit=fitCox5, Stime=survival.time, status=survival.status,
                       span=span, order=0)
plot(bfnx1.1$time, bfnx1.1$beta, type="l", xlab="Time", ylab="beta(t)")
lines(bfnx1.0$time, bfnx1.0$beta, lty=3)
}
\keyword{survival}
