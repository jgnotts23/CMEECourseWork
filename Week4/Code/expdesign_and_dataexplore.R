#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

rm(list=ls())
graphics.off()

MySample <- rnorm(10, m=0, sd=1) #10 normally-distributed numbers with mean 0 and deviation 1
MySample
hist(MySample)

# Probability of getting a value of 1 or -1 from a normally-distributed random number
# with mean 0 and sd = 1:
dnorm(1, m=0, sd=1)
dnorm(-1, m=0, sd=1) #same

# Probability of getting large value with same distribution:
dnorm(10, m=0, sd=1) #very small
dnorm(100, m=0, sd=1) #zero!

# In general, while designing experiments, and sampling from a population, 
# there are two key (and simple) rules:
    # 1. The more you sample, the more your sample's distribution 
    # will look like the population distribution (obviously!)

    # 2. The more you sample, the closer will your sample statistic be to the population's 
    # statistical parameter (the central limit theorem; when the statistical parameter is the mean, 
    # this is the "law of large numbers")

# Testing rule 1 using R:
MySample5 <- rnorm(5, m=0, sd=1)
MySample10 <- rnorm(10, m=0, sd=1) 
MySample20 <- rnorm(20, m=0, sd=1) 
MySample40 <- rnorm(40, m=0, sd=1)
MySample80 <- rnorm(80, m=0, sd=1)
MySample160 <- rnorm(160, m=0, sd=1)

# Visualise these 'samples':
graphics.off()
par(mfcol = c(2,3)) #initialize multi-paneled plot
par(mfg = c(1,1)); hist(MySample5, col = rgb(1,1,0), main = 'n = 5') 
par(mfg = c(1,2)); hist(MySample10, col = rgb(1,1,0), main = 'n = 10') 
par(mfg = c(1,3)); hist(MySample20, col = rgb(1,1,0), main = 'n = 20') 
par(mfg = c(2,1)); hist(MySample40, col = rgb(1,1,0), main = 'n = 40') 
par(mfg = c(2,2)); hist(MySample80, col = rgb(1,1,0), main = 'n = 80') 
par(mfg = c(2,3)); hist(MySample160, col = rgb(1,1,0), main = 'n = 160')
# This shows how increased sampling tends towards the population distribution

# Testing rule 2:
mean(MySample5)
mean(MySample10)
mean(MySample20)
mean(MySample40)
mean(MySample80)
mean(MySample160) # tending towards 0
sd(MySample5)
sd(MySample10)
sd(MySample20)
sd(MySample40)
sd(MySample80)
sd(MySample160) # tending towards 1

# Could also perform a power analysis to determine the minimum sample size to be able to detect
# and effect of a given size (while minimising Type I error)








