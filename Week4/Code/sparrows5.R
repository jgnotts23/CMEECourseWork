#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

# Stats with sparrows 5
rm(list=ls())

# t-test, does the sample mean represent the population mean?
# Convention says we should accept any mean iwthin 95% of the distribution (or error of 5%)
# CI95 = +/- 1.96(s / root(n))     (s = standard deviation), roughly twice the se!

# Tarsus - N=1685, se=0.02, mean=18.52
# Tarsus2001 - N=168, se=0.07, mean=18.19, 95%CI OR mean+-(2se) = 18.05 - 18.33
# The 95CI for Tarsus2001 does not span 18.52 so we can say it is not representative

# t-test, t = (samplemean - popmean)/sampleSE
# H0 = true mean = 18.5
# H1 = true mean != 18.5
# (18.19-18.5)/0.07 = t = -4.42
# Sample size is 168, thus df = 167
# Look up p-value, p = 0.000003961, this is the probability to be wrongly accepted
# Convention states a p value less than 0.05 (5%) is statistically significant
d <- read.table("../Data/SparrowSize.txt", header=TRUE)
d1 <- subset(d, d$Year==2001)
t.test(d1$Tarsus, mu=18.5, na.rm=TRUE)

# t can also be used to test for difference in mean:
# H0 = males and females have equal mean
# H1 = male and female mean is not equal

# Testing the difference is equal to testing for zero (difference)
t.test(d1$Tarsus~d1$Sex, na.rm=TRUE) #Welch two sample t-test
## df = n-2 ##

# t-distributions are dependent on degrees of freedom
# Therefore, bigger sample size increases chances of statistical differences

# How to report t-test results
# Text: Male and female tarsi did not differe in size(mean: 18.18, two sample t-test: 
# t=1.23, df=139, p<0.22)
# In table column headers: Variable (e.g. Tarsus), female mean, female N, male mean, male N, t, df, p




