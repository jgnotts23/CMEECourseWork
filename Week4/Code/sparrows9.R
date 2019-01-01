#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

# Stats with sparrows 9
rm(list=ls())

# Sum of squares to assess goodness of fit
## Find b0 and b1 of a line that is positioned so that it minimises the sum of the 
## squared residuals (epsilon) for the data y and x

# R^2 - coefficient of determination, proportion of how much variance in y is explained by x
# R^2 = 1 - (SSresiduals / SStotal)
## SStotal = variance(in y) * (n-1)

x <- c(1, 2, 3, 4, 8)
y <- c(4, 3, 5, 7, 9)

model1 <- (lm(y~x))
model1
summary(model1)
anova(model1)
resid(model1)
cov(x,y)
var(x)
plot(y~x)
