\name{risksetROC}
\alias{risksetROC}
\title{Incident/Dynamic (I/D) ROC curve, AUC and integrated AUC (iAUC)
  estimation of censored survival data}
\description{This function creates risksetROC from a survival data set
}
\usage{risksetROC(Stime, entry=NULL, status, marker, predict.time, method="Cox",
                       span=NULL, order=1, window="asymmetric", prop=0.5,
                       plot=TRUE, type="l", xlab="FP", ylab="TP",
                       ...)  
}
\arguments{
  \item{Stime}{For right censored data, this is the follow up time. For
    left truncated data, this is the ending time for the interval.}  
  \item{entry}{For left truncated data, this is the entry time of
    the interval. The default is set to \it{NULL} for right censored
    data.}    
  \item{status}{survival status, 1 if had an event and 0 otherwise}
  \item{marker}{marker}
  \item{predict.time}{time point of interest}
  \item{method}{either of "Cox", "LocalCox" and "Schoenfeld", default is "Cox"}
  \item{span}{bandwidth parameter that controls the size of a local
    neighborhood, needed for \emph{method="LocalCox"} or
    \emph{method="Schoenfeld"}} 
  \item{order}{0 or 1, locally mean if 0 and local linear if 1, needed
    for method="Schoenfeld", default is 1}
  \item{window}{either of "asymmetric" or "symmetric", default is
    asymmetric, needed for method="LocalCox"}
  \item{prop}{what proportion of the time-interval to consider when
    doing a local Cox fitting at \emph{predict.time}, needed for \emph{method="LocalCox"},
    default is 0.5.}
  \item{plot}{TRUE or FALSE, default is TRUE}
  \item{type}{default is "l", can be either of "p" for points, "l" for
    line, "b" for both}
  \item{xlab}{label for x-axis}
  \item{ylab}{label for y-axis}
  \item{...}{additional plot arguments}
}
\details{This function creates and plots ROC based on incident/dynamic
  definition 
  of Heagerty, et. al. based on a survival data and marker values. If
  proportional hazard is assumed then method="Cox" can be used. In case
  of non-proportional hazard, either of "LocalCox" or "Schoenfeld" can
  be used. These two methods differ in how the smoothing is done. If
  \emph{plot="TRUE"} then the ROC curve is plotted with the diagonal
  line. Additional plot arguments can be supplied.
}

\value{Returns a list of the following items:
  \item{eta}{unique marker values for calculation of TP and FP}
  \item{TP}{True Positive values corresponding to unique marker values}
  \item{FP}{False Positive values corresponding to unique marker values}
  \item{AUC}{Area Under (ROC) Curve at time predict.time}
}

\seealso{llCoxReg(), SchoenSmooth(), CoxWeights()}

\references{Heagerty, P.J., Zheng Y. (2005)
  Survival Model Predictive Accuracy and ROC curves
  \emph{Biometrics}, \bold{61}, 92 -- 105} 

\author{Paramita Saha}

\examples{
library(MASS)
data(VA)
survival.time=VA$stime
survival.status=VA$status
score <- VA$Karn
cell.type <- factor(VA$cell)
tx <- as.integer( VA$treat==1 )
age <- VA$age
survival.status[survival.time>500 ] <- 0
survival.time[survival.time>500 ] <- 500
fit0 <- coxph( Surv(survival.time,survival.status)
        ~ score + cell.type + tx + age, na.action=na.omit )
eta <- fit0$linear.predictor

ROC.CC30=risksetROC(Stime=survival.time, status=survival.status,
                    marker=eta, predict.time=30, method="Cox",
                    main="ROC Curve", lty=2, col="red") 
}
\keyword{survival}

%  LocalWords:  Schoenfeld
