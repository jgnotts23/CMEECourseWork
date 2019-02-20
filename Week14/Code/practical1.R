#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Feb 2019

rm(list = ls())
graphics.off()

x <- 0:10

# Density of binomial distribution
# x = vector of quantiles, size = number of trials (>=0), prob = vector of probabilities
y <- dbinom(x, size=10, prob=0.4) 

# Plot of binomial probability mass function:
plot(x, y, pch=16, ylab='probability', xlab='outcome')

# Does the pmf sum up to one?
sum(y)

# Can simulate outcomes of binomial random variables using rbinom()
# n = number of observations
z <- rbinom(n=1000, size=10, prob=0.4)
z # 1000 random observaions of the binomial distribution
hist(z)

# How does this compare to the previous graph?
par(mfrow=c(1,2))
plot(x, y, pch=16, ylab='probability', xlab='outcome')
hist(z)

# What about mean and variance?
mean(x)
mean(z)
var(x)
var(z)

# Poisson distributions model number of events within a time interval with lambda the average
# rate of occurence
par(mfrow=c(1,1))
pois <- dpois(x, lambda=2)
plot(x, pois)

# Pr(X = 4)
pois[5]

# Pr(X <=3)
sum(pois[1:4])


# Let us consider the negative binomial distribution
y <- rnbinom(1000, 1, 0.2)
hist(y) #left-skewed

# Central limit theorem states the mean of samples will follow a normal distribution even for
# a skewed distribution like this.
y <- rnbinom(30*1000, 1, 0.2)

# put them in a 1000-by-30 matrix
y.matrix <- matrix(y, nr=1000, nc=30)

# Calculate mean for each row then plot
y.row.mean <- apply(y.matrix, 1, mean)
hist(y.row.mean)


