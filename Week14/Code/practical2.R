#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Feb 2019

rm(list = ls())
graphics.off()

# Writing my own likelihood function
binomial.likelihood <- function(p){
  choose(10,7)*p^7*(1-p)^3
}

# Check likelihood value for p=0.1
binomial.likelihood(p=0.1)

# Plot for a range of p
p <- seq(0, 1, 0.01)
likelihood.values <- binomial.likelihood(p)
plot(p, likelihood.values, type='l')

# Log-likelihood
log.binomial.likelihood <- function(p){
  log(binomial.likelihood(p=p))
}

# Plot
p < -seq(0,1,0.01)
log.likelihood.values <- log.binomial.likelihood(p)
plot(p, log.likelihood.values, type='l')
abline(h=-1.92, col='red', lty=2)
abline(v=0.82, col='black', lty=2)
abline(v=0.52, col='black', lty=2)


# Both likelihood plots are optimised at about p=0.7

recapture.data <- read.csv("../Data/recapture.csv", header=T)

plot(recapture.data$day, recapture.data$length_diff)

# THE LOG-LIKELIHOOD FOR THE LINEAR REGRESSION
# PARAMETERS HAVE TO BE INPUT AS A VECTOR
regression.log.likelihood<-function(parm, dat)
{
  # DEFINE THE PARAMETERS parm
  # WE HAVE THREE PARAMETERS: a, b, sigma. BE CAREFUL OF THE ORDER
  a<-parm[1]
  b<-parm[2]
  sigma<-parm[3]
  # DEFINE THE DATA dat
  # FIRST COLUMN IS x, SECOND COLUMN IS y
  x<-dat[,1]
  y<-dat[,2]
  # DEFINE THE ERROR TERM
  error.term<-(y-a-b*x)
  # REMEMBER THE NORMAL pdf?
  density<-dnorm(error.term, mean=0, sd=sigma, log=T)
  # THE LOG-LIKELIHOOD IS THE SUM OF INDIVIDUAL LOG-DENSITY
  return(sum(density))
}

regression.log.likelihood(c(1,1,1), dat=recapture.data)
optim(par=c(1,1,1), regression.log.likelihood, method='L-BFGS-B',
      lower=c(-1000,-1000,0.0001), upper=c(1000,1000,10000),
      control=list(fnscale=-1), dat=recapture.data, hessian=T)

# THE LOG-LIKELIHOOD FUNCTION FOR M1 WITHOUT AN INTERCEPT
regression.no.intercept.log.likelihood<-function(parm, dat)
{
  # DEFINE THE PARAMETERS
  # NO INTERCEPT THIS TIME
  b<-parm[1]
  sigma<-parm[2]
  # DEFINE THE DATA
  # SAME AS BEFORE
  x<-dat[,1]
  y<-dat[,2]
  # DEFINE THE ERROR TERM, NO INTERCEPT HERE
  error.term<-(y-b*x)
  # REMEMBER THE NORMAL pdf?
  density<-dnorm(error.term, mean=0, sd=sigma, log=T)
  # LOG-LIKELIHOOD IS THE SUM OF THE DENSITIES
  return(sum(density))
}

# PERFORMING LIKELIHOOD-RATIO TEST
M1<-optim(par=c(1,1), regression.no.intercept.log.likelihood,
          dat=recapture.data, method='L-BFGS-B',
          lower=c(-1000,0.0001), upper=c(1000,10000),
          control=list(fnscale=-1), hessian=T)
M2<-optim(par=c(1,1,1), regression.log.likelihood,
          dat=recapture.data, method='L-BFGS-B',
          lower=c(-1000,-1000,0.0001), upper=c(1000,1000,10000),
          control=list(fnscale=-1), hessian=T)
# THE TEST STATISTIC D
D<-2*(M2$value-M1$value)
D

# DEFINE THE RANGE OF PARAMETERS TO BE PLOTTED
b<-seq(2, 4, 0.1)
sigma<-seq(2, 5, 0.1)
# THE LOG-LIKELIHOOD VALUE IS STORED IN A MATRIX
log.likelihood.value<-matrix(nr=length(b), nc=length(sigma))
# COMPUTE THE LOG-LIKELIHOOD VALUE FOR EACH PAIR OF PARAMETERS
for (i in 1:length(b))
{
  for (j in 1:length(sigma))
  {
    log.likelihood.value[i,j]<-
      regression.no.intercept.log.likelihood(parm=c(b[i],sigma[j]),dat=recapture.data)
  }
}
# WE ARE INTERESTED IN KNOWING THE LOG-LIKELIHOOD VALUE
# RELATIVE TO THE PEAK (MAXIMUM)
rel.log.likelihood.value<-log.likelihood.value-M1$value
# FUNCTION FOR 3D PLOT
persp(b, sigma, rel.log.likelihood.value, theta=30, phi=20,
      xlab='b', ylab='sigma', zlab='rel.log.likelihood.value',
      col='grey')

# CONTOUR PLOT
contour(b, sigma, rel.log.likelihood.value, xlab='b',
        ylab='sigma',
        xlim=c(2.5, 3.9), ylim=c(2.0, 4.3),
        levels=c(-1:-5, -10), cex=2)
# DRAW A CROSS TO INDICATE THE MAXIMUM
points(M1$par[1], M1$par[2], pch=3)

contour.line<-contourLines(b, sigma,
                           rel.log.likelihood.value, levels=-1.92)[[1]]
lines(contour.line$x, contour.line$y, col='red',
      lty=2, lwd=2)