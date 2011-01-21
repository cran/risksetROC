\name{CoxWeights}
\alias{CoxWeights}
\title{Incident/Dynamic (I/D) ROC curve, AUC and integrated AUC (iAUC)
  estimation of censored survival data}
\description{
  This function estimates of TP and FP based on a Cox
  model as discussed in Heagerty and Zheng, 2005, for incident/dynamic
  ROC curve. TP is estimated as Equation (1) and FP is estimated as
  Equation (2) of the paper.
  }

\usage{CoxWeights(marker, Stime, status, predict.time, entry)
}
\arguments{
  \item{marker}{estimated linear predictor from a set of covariates. Note
    that this linear predictor can be obtained from any model.}
  \item{Stime}{For right censored data, this is the follow up time. For
    left truncated data, this is the ending time for the interval.}
  \item{status}{Indicator of status, 1 if death or event, 0 otherwise.}
  \item{predict.time}{Time point of the ROC curve.}
  \item{entry}{For left truncated data, this is the entry time of
    the interval. The default is set to NULL for right censored
    data.}
}
\details{Suppose we have censored survival data (right censored or both
  left-truncated and right censored data) along with a
  marker value and  we want to see how well the marker predicts the 
  survival time for the subjects in the dataset using Incident/dynamic
  definition of ROC curve. In particular,
  suppose we have survival times in days and  we want to see how well the
  marker predicts the one-year survival (predict.time=365 days). This
  function CoxWeights(), returns the unique marker values, TP (True
  Positive), FP (False Positive)  and AUC (Area under (ROC) curve)
  corresponding to the  time point of interest (predict.time). Note that
  the linear predictor \emph{marker} can be obtained from any model,
  specifically, the survival model may be based on either a PH
   or a time-varying Cox model.
}
\value{Returns a list of the following items:
  \item{eta}{unique marker values for calculation of TP and FP}
  \item{TP}{True Positive values corresponding to unique marker values}
  \item{FP}{False Positive values corresponding to unique marker values}
  \item{AUC}{Area Under (ROC) Curve at time predict.time}
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
fit0 <- coxph( Surv(survival.time,survival.status)
        ~ score + cell.type + tx + age, na.action=na.omit )
summary(fit0)
eta <- fit0$linear.predictor
AUC <- NULL
out <- CoxWeights(marker=eta, Stime=survival.time, status=survival.status,
predict.time=30)
## to see how well the marker predicts one-month survival
AUC <- out$AUC
}
\keyword{survival}
