#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

rm(list=ls())
graphics.off()

genome <- read.csv("../Data/GenomeSize.csv")
str(genome)

# Is the mean genome size for Odonata smaller than 1.25 which is the average for insects?
mean.gs <- mean(genome$GenomeSize) #mean
print(mean.gs)

var.gs <- var(genome$GenomeSize) #variance
print(var.gs)

n.gs <- length(genome$GenomeSize) #sample size
print(n.gs)

diff <- mean.gs - 1.25 #compare mean to reference value, in this case 1.25
print(diff)

se.gs <- sqrt(var.gs/n.gs) #standard error
print(se.gs)

t.gs <- diff/se.gs #t-value
print(t.gs) #very large, mean genome size for Odonata is different from insect average

# Using R's in-built t-test
t.test(genome$GenomeSize, mu = 1.25)

# Confidence intervals
tlim <- qt(c(0.025,0.975), df = 99) #qt = quantiles of t-distribution
print(tlim)

mean.gs + tlim * se.gs #confidence intervals

# Body weight exercise
t.test(genome$BodyWeight, mu = 0.045)

# F-test
par(mfrow=c(1,2))
boxplot(GenomeSize ~ Suborder, data=genome)
boxplot(BodyWeight ~ Suborder, data=genome)

var.test(GenomeSize ~ Suborder, data=genome) # variances are unequal
var.test(BodyWeight ~ Suborder, data=genome) # variances VERY unequal
# R does account for unequal variances to an extent with a df penalty
# e.g. in BodyWeight F-test the df used is 59 instead of 98

# Using log-transformations to normalise distributions:
genome$logBodyWeight <- log(genome$BodyWeight) #create log-transformed column
boxplot(logBodyWeight ~ Suborder, data=genome)

t.test(logBodyWeight ~ Suborder, data=genome) #significantly different means still
var.test(logBodyWeight ~ Suborder, data=genome) #still not equal to 1 but MUCH closer

## Non-parametric tests ##
# If the variable cannot be conveniently transformed that gives roughlt constant variation and variance
# Wilcoxon test to the rescue!
# Less likely to reveal significant differences, but robust test
wilcox.test(genome$GenomeSize, mu=1.25) 
t.test(genome$GenomeSize, mu = 1.25) #same conclusion but the t-test has higher confidence