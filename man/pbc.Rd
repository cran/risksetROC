\name{pbc}
\alias{pbc}
\title{Incident/Dynamic (I/D) ROC curve, AUC and integrated AUC (iAUC)
  estimation of censored survival data}
\description{This is Mayo PBC data as obtained from the website:
  http://lib.stat.cmu.edu/datasets/pbc 
}
\format{A data frame with 418 observations and 20 variables:
  \item{id}{patient id}
  \item{fudays}{follow-up days, number of days between registration and
    the earlier of death, transplantation, or study analysis time in July,
    1986} 
  \item{status}{survival status}
  \item{drug}{1 = D-penicillamine, 2 = placebo}
  \item{age}{age in days}
  \item{sex}{0 = male, 1 = female}
  \item{ascites}{presence of asictes: 0=no 1=yes}
  \item{hepatom}{presence of hepatomegaly: 0=no 1=yes}
  \item{spiders}{presence of spiders: 0=no 1=yes}
  \item{edema}{presence of edema:  0=no edema and no diuretic therapy for edema;
	.5 = edema present without diuretics, or edema resolved by diuretics;
	1 = edema despite diuretic therapy}
  \item{bili}{serum bilirubin in mg/dl}
  \item{chol}{serum cholesterol in mg/dl}
  \item{albumin}{albumin in gm/dl}
  \item{copper}{urine copper in ug/day}
  \item{alkphos}{alkaline phosphatase in U/liter}
  \item{sgot}{SGOT in U/ml}
  \item{trig}{triglicerides in mg/dl}
  \item{platelet}{platelets per cubic ml / 1000}
  \item{protime}{prothrombin time in seconds}
  \item{stage}{histologic stage of disease}
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
