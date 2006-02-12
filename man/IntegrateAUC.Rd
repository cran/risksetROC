\name{IntegrateAUC}
\alias{IntegrateAUC}
\title{Incident/Dynamic (I/D) ROC curve, AUC and integrated AUC (iAUC)
  estimation of censored survival data}
\description{
  This function integrates AUC using weights
  \eqn{w(t) = 2*f(t)*S(t)}
  as discussed in Heagerty and Zheng, 2005.
  }

\usage{IntegrateAUC(AUC, utimes, St, tmax, weight="rescale")
}
\arguments{
  \item{AUC}{Area under ROC curve at utimes}
  \item{utimes}{Unique event times for subjects}
  \item{St}{Estimated survival probability at utimes}
  \item{tmax}{Maximum time length to be considered}
  \item{weight}{Either of "rescale" or "conditional"}
}
\details{This function estimates time-dependent concordance
  measure \deqn{P(M_i>M_j|T_i<t, T_i<tmax, T_j>t)} as discussed in the
  paper from AUC and weights derived from 
  the survival time distribution. The concordance measure is estimated
  under the assumption that smaller of the two event times happened
  before time \emph{tmax}. The resulting measure is an weighted sum of
  estimated AUC at each unique failure time where weights are
  proportional to \eqn{2*f(t)*S(t)}, and T is failure time of interest. 
  If weight="rescale", then the weights are rescaled so that the sum of
  the weights is one. If weight="conditional", it is assumed that both
  the events happened before \emph{tmax}.
}
\value{Returns the following item:
  \item{iAUC}{Integrated AUC using w(t) as above as weights}
}

\references{Heagerty, P.J., Zheng Y. (2005)
  Survival Model Predictive Accuracy and ROC curves
  \emph{Biometrics}, \bold{61}, 92 -- 105} 
\author{Patrick J. Heagerty }
\examples{
library(MASS)
data(VA)
survival.time <- VA$stime
survival.status <- VA$status
score <- VA$Karn
cell.type <- factor(VA$cell )
tx <- as.integer( VA$treat==1 )
age <- VA$age
survival.status[VA$stime > 500 ] <- 0
survival.time[VA$stime > 500 ] <- 500
library(survival)
## first find the estimated survival probabilities at unique failure times
surv.prob <- unique(survfit(Surv(survival.time,survival.status)~1)$surv)
fit0 <- coxph( Surv(survival.time,survival.status)
        ~ score + cell.type + tx + age, na.action=na.omit )
eta <- fit0$linear.predictor
model.score <- eta

utimes <- unique( survival.time[ survival.status == 1 ] )
utimes <- utimes[ order(utimes) ]

## find AUC at unique failure times
AUC <- rep( NA, length(utimes) )
for( j in 1:length(utimes) )
{
out <- CoxWeights( eta, survival.time, survival.status,utimes[j])
AUC[j] <- out$AUC
}
## integrated AUC to get concordance measure
iAUC <- IntegrateAUC( AUC, utimes, surv.prob, tmax=365 )
}
\keyword{survival}
