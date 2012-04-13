\name{llCoxReg}
\alias{llCoxReg}
\title{Incident/Dynamic (I/D) ROC curve, AUC and integrated AUC (iAUC)
  estimation of censored survival data}
\description{
  This function estimates the time-varying parameter estimate
  \eqn{\beta(t)} of non-proportional 
  hazard model using local-linear Cox regression as discussed in
  Heagerty and Zheng, 2005. 
  }

\usage{llCoxReg(Stime, entry=NULL, status, marker, span=0.40, p=1, window="asymmetric") 
}
\arguments{
  \item{Stime}{For right censored data, this is the follow up time. For
    left truncated data, this is the ending time for the interval.}  
  \item{entry}{For left truncated data, this is the entry time of
    the interval. The default is set to NULL for right censored
    data.}  
  \item{status}{Survival status.}
  \item{marker}{Marker value.}
  \item{span}{bandwidth parameter that controls the size of a local
    neighborhood.} 
  \item{p}{1 if only the time-varying coefficient is of interest
    and 2  if the derivative of time-varying coefficient is also of interest,
    default is 1} 
  \item{window}{Either of "asymmetric" or "symmetric", default is asymmetric.}
  
}
\details{This function calculates the parameter estimate \eqn{\beta(t)}
  of non-proportional hazard model using local-linear Cox regression as
  discussed in Heagerty and Zheng, 2005. This estimation is based on a
  time-dependent Cox  model (Cai and Sun, 2003). For \emph{p=1}, the
  return item \emph{beta} has two columns, the first column is the
  time-varying parameter estimate, while the second column is the
  derivative. However, if the derivative of the time-varying parameter
  is of interest, then we suggest to use \emph{p=2}. In this case,
  \emph{beta} has four columns, the first two columns are the same when
  \emph{p=1}, while the last two columns estimates the coefficients of
  squared marker value and its derivative.
}
\value{Returns a list of following items:
  \item{time}{unique failure times}
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
span <- 1.0*(nobs^(-0.2))

\dontrun{
bfnx1 <- llCoxReg(Stime=survival.time, status=survival.status, marker=x,
                   span=span, p=1)
plot(bfnx1$time, bfnx1$beta[,1], type="l", xlab="Time", ylab="beta(t)")
}
}
\keyword{survival}
