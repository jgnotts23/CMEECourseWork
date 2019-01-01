#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

# Stats with sparrows 11/12
rm(list=ls())


# Maximum likelihood estimation - another way to estimate parameters
# Maximises the likelihood that the data you have comes from the model you assume

# Bayesian inference uses likelihood and previous knowledge, solution is not uniform
# Many solutions provided with different probabilities

# Bootstrapping - re-sampling data to get estimates
# Jack-knife - aggregates the estimates of each sub-sized sample (i.e. n-1, n-2, ...)
# Sensitivity analysis - systematically exclude datasets

# Covariance - how two variables change together. Population: joint probability distribution
# Calculated by multiplying the deviations in x by those in y and dividing by n-1
# The correlation coefficient is the covariance divided by the product of the standard deviations
## That is, it is the standardised version of the covariance (between -1 and 1)
cov(d$Mass, d$Tarsus, use="complete.obs") #covariance
cor(d$Mass, d$Tarsus, use="complete.obs") #correlation

# Convert to cm
cov(d$Mass, (d$Tarsus/10), use="complete.obs") #affected by units
cor(d$Mass, (d$Tarsus/10), use="complete.obs") #unaffected by units (due to being standardised)

