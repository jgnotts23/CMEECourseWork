#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

# Stats with sparrows 2
rm(list=ls())
require(modeest)

# Quartiles
# Q1 - 25% of the data is less/equal to this value
# Q2 - 50% of the data is less/equal to this value (Q2 = median)
# Q3 - 75% of the data is less/equal to this value
# Q4 - 100% of the data is less/equal to this value

# Variance is the squared deviation of a random variable from its mean
# It is calculated by summing the squared differences and dividing by n-1 (sample size -1)
# n-1 is used instead of n to reduce bias of sample mean vs. population mean
# Standard deviation is the square root of variance

# Read in sparrow data
d <- read.table("../Data/SparrowSize.txt", header=TRUE)

# Inspect data
str(d) #structure
names(d) #column names
head(d) #View first 6 rows

# Look at Tarsus distribution
length(d$Tarsus) #How many data
hist(d$Tarsus) #Histogram

# Normal distribution - a function that represents the distribution of many random variables
# as a symmetrical bell-shaped graph
# Parametric statistics is a branch of statistics that sample data from a population that follows
# a probability distribution based on a fixed set of parameters
# Centrality - e.g. mean, mode, median

# Centrality in normal data
mean(d$Tarsus) #Won't work because of NAs
mean(d$Tarsus, na.rm = TRUE) #Strip NAs, then compute
median(d$Tarsus, na.rm = TRUE)
mode(d$Tarsus) #returns description of object type because unlikely to be repeat values in continuous data

par(mfrow = c(2,2)) #sets subsequent figures to be plotted in a 2x2 grid
hist(d$Tarsus, breaks=3, col="grey") #breaks = no. bins
hist(d$Tarsus, breaks=10, col="grey")
hist(d$Tarsus, breaks=30, col="grey")
hist(d$Tarsus, breaks=100, col="grey")

mlv(d$Tarsus) #NAs still an issue
d2 <- subset(d, d$Tarsus!="NA") #subset with removed NAs
length(d$Tarsus)
length(d2$Tarsus) #85 values removed
mlv(d2$Tarsus) #Will get warnings but this is ok

# In a perfect normal distribution, mean, mode and median will be the same
# The more skewed, the more divergence of these 3 measures

range(d$Tarsus, na.rm=TRUE) #returns min and max
range(d2$Tarsus, na.rm=TRUE) #same
var(d$Tarsus, na.rm=TRUE) #returns variance
var(d$Tarsus, na.rm=TRUE) #same

# Long-hand version of what var() is doing:
sum((d2$Tarsus - mean(d2$Tarsus))^2)/(length(d2$Tarsus) -1)

# Standard deviation
sqrt(var(d2$Tarsus)) #long-hand of sd()
sd(d2$Tarsus) 

# Z-scores come from a standardised normal distibution with mean=0 and sd=1 (var=1 too)
# Data can be 'transformed' to a z-distribution by dividing the deviation from the mean by the sd
zTarsus <- (d2$Tarsus - mean(d2$Tarsus))/sd(d2$Tarsus)
var(zTarsus) #1
sd(zTarsus) #1
hist(zTarsus)

set.seed(123) #start random number gen sequence
znormal <- rnorm(1e+06)
hist(znormal, breaks=100)
summary(znormal) #find quartiles and averages
qnorm(c(0.025, 0.975)) #gives 2.5% and 97.5% quantiles from corresponding probability distribution
pnorm(.Last.value) #gives corresponding probabilities

par(mfrow = c(1,2))
hist(znormal, breaks=100)
abline(v = qnorm(c(0.25, 0.5, 0.75)), lwd=2) #adds lines, v= x-value of vertical line, QUARTILES
abline(v = qnorm(c(0.025, 0.975)), lwd = 2, lty = "dashed")
plot(density(znormal)) #insted of frequency, still same shape
abline(v = qnorm(c(0.25, 0.5, 0.75)), col = "gray")
abline(v = qnorm(c(0.025, 0.975)), lty = "dotted", col = "black")
abline(h = 0, lwd = 3, col = "blue")
text(2, 0.3, "1.96", col = "red", adj = 0)
text(-2, 0.3, "-1.96", col = "red", adj = 1)

# Example with sparrow data
# Sex.1 used as they're not numeric
# Boxplot shows range and quartiles 
boxplot(d$Tarsus~d$Sex.1, col=c("red", "blue"), ylab="Tarsus length (mm)")











