#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Feb 2019

rm(list = ls())
graphics.off()

flowering <- read.table('../Data/flowering.txt', header=T)
names(flowering)
head(flowering)

# Inspect the data
par(mfrow=c(1,2))
plot(flowering$Flowers, flowering$State)
plot(flowering$Root, flowering$State)

# Logistic log-likelihood
logistic.log.likelihood <- function(parm, dat) {
  #define parameters
  a <- parm[1]
  b <- parm[2]
  c <- parm[3]
  
  #define response variable
  State <- dat[,1]
  
  #define explanatory variables
  Flowers <- dat[,2]
  Root <- dat[,3]
  
  #Model success probability
  p <- exp(a+b*Flowers+c*Root)/(1+exp(a+b*Flowers+c*Root))
  
  # The log-likelihood function
  log.like <- sum(State*log(p) + (1-State)*log(1-p))
  
  return(log.like)
}

#Try
logistic.log.likelihood(c(0,0,0), dat=flowering)

# Time to OPTIMISE THIS SHIT
M1 <- optim(par=c(0,0,0), fn=logistic.log.likelihood, dat=flowering, control=list(fnscale=-1))
M1

logistic.log.likelihood.int <- function(parm, dat) {
  #Define parameters
  a <- parm[1]
  b <- parm[2]
  c <- parm[3]
  d <- parm[4]
  
  #Response var
  State <- dat[,1]
  
  #Explanatory var
  Flowers <- dat[,2]
  Root <- dat[,3]
  
  #Model success probability
  p <- exp(a+b*Flowers+c*Root+d*Flowers*Root)/(1+exp(a+b*Flowers+c*Root+d*Flowers*Root))
  
  # The log-likelihood function
  log.like <- sum(State*log(p) + (1-State)*log(1-p))
  
  return(log.like)
}

logistic.log.likelihood.int(c(0,0,0,0), dat=flowering)

M2 <- optim(par=c(0,0,0,0), fn=logistic.log.likelihood.int, dat=flowering, control=list(fnscale=-1))
M2

# Likelihood-ratio test
D <- 2*(M2$value - M1$value)
D #look up in chi-squared table, it is significant the interaction so should be included

# Confirm with glm
glm.M1 <- glm(State~Flowers+Root, family=binomial, data=flowering)
glm.M2 <- glm(State~Flowers*Root, family=binomial, data=flowering)
anova(glm.M1, glm.M2, test='LRT')





