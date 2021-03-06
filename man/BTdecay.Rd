% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BTdecay.R
\name{BTdecay}
\alias{BTdecay}
\title{Bradley-Terry Model with Exponential Decayed weighted likelihood}
\usage{
BTdecay(dataframe, ability, decay.rate = 0, fixed = 1, iter = 100)
}
\arguments{
\item{dataframe}{Matrix with 5 columns. First column is the index of the home teams
(use numbers to denote teams).
Second column is the index of the away teams.
Third column is the number of wins of home teams (usually to be 0/1).
Fourth column is the number of wins of away teams (usually to be 0/1).
Fifth column is the scalar of time when the match is played until now (Time lag).
It can be generated using function BTdataframe.}

\item{ability}{A column vector of teams ability, the last row is the home parameter.
The row number is consistent with the team's index shown in dataframe.
It can be generated using function BTdataframe.}

\item{decay.rate}{The exponential decay rate. Usually ranging from (0, 0.1), A larger decay rate weights more
importance to most recent matches and the estimated parameters reflect more on recent behaviour.}

\item{fixed}{A teams index whose ability will be fixed as 0 (usually the team loss most which can be
generated using function BTdataframe).}

\item{iter}{Number of iterations used in L-BFGS-B algorithm.}
}
\value{
List contains estimated abilities and convergent code, 0 stands for convergency reaches,
1 stands for convergency not reaches. If 1 is returned, we suggest that decay rate should be set lower.
Bradley-Terry model fails to model the situation when a team wins or loses in all matches.
If a high decay rate is considered, a team who only loses or wins 1 matches long time ago will also casues the same problem.
\item{ability}{Estimated ability scores}
\item{convergence}{0 stands for convergent, 1 stands for not convergent}
}
\description{
Bradley-Terry Model with Exponential Decayed weighted likelihood
}
\details{
The objective likelihood function to be optimized is,
\deqn{\sum_{k=1}^{n}\sum_{i<j}\exp(-\alpha t_{k})\cdot(y_{ij}(\tau h_{ij}^{t_{k}}+\mu_{i}-\mu_{j})-\log(1+\exp(\tau h_{ij}^{t_{k}}+\mu_{i}-\mu_{j})))}
where n is the number of matches, \eqn{\alpha} is the exponential decay rate, \eqn{\tau} is the home parameter and 
\eqn{y_{ij}} takes 0 if i is defeated by j, 1 otherwise. \eqn{\mu_{i}} is the team i's ability score.
This likelihood function is optimized using L-BFGS-B method with package \bold{optimr}.
}
\examples{
##Initializing Dataframe
x <- BTdataframe(NFL2010)

##Standard Bradley-Terry Model optimization
y <- BTdecay(x$df, x$ability, decay.rate = 0, fixed = x$worstTeam)

##Dynamic approximation of current ability scores using exponetial decayed likelihood.
##If we take decay.rate = 0.005
##Match happens one month before will weight exp(-0.15)=0.86 on log-likelihood function
z <- BTdecay(x$df, x$ability, decay.rate = 0, fixed = x$worstTeam)
}
