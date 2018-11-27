#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Nov 2018

#Clear and import
rm(list = ls())
graphics.off()
library("ggplot2")
library(repr)

#for Levenberg-Marquardt NLLS fitting:
require("minpack.lm") 

#Change default plot size
options(repr.plot.width=6, repr.plot.height=5)

# Trait = any measurable feature of an individual organism
# e.g. body mass, respiration rate, feeding preference
# A trait is functional if it directly (e.g. mortality rate)
# or indirectly (e.g. growth rate) determines individual fitness

## Allometric scaling of traits ##
# Allometry is the relation between organism size and its traits:
# y = ax^b
# x and y are morphological measures (e.g. body length and weight)
# a = value of y at x=1 (constant)
# b = scaling 'exponent' (a.k.a power-law)

## Create function for power-law model ##
powMod <- function(x, a, b) {
    return(a * x^b)
}

## Import data ##
MyData <- read.csv("../Data/GenomeSize.csv")
head(MyData) # Anisoptera are dragonflies and Zygoptera are Damselflies

## Subset, remove NAs and plot ##
Data2Fit <- subset(MyData, Suborder == "Anisoptera")

Data2Fit <- Data2Fit[!is.na(Data2Fit$TotalLength),]

#or with ggplot
ggplot(Data2Fit, aes(x = TotalLength, y = BodyWeight)) + geom_point() #scatterplot

## Fitting model to data using NLLS ##
PowFit <- nlsLM(BodyWeight ~ powMod(TotalLength, a, b), data = Data2Fit, start = list(a = .1, b = .1))
summary(PowFit) #same as lm() fit object

## Visualisation ##
# Generate vector of body lengths for plotting (x-axis variable)
Lengths <- seq(min(Data2Fit$TotalLength), max(Data2Fit$TotalLength), len=200)

# Extract coefficient from model fit
A <- coef(PowFit)["a"]
B <- coef(PowFit)["b"]

Predic2PlotPow <- powMod(Lengths, coef(PowFit)["a"], coef(PowFit)["b"])

# Calculate confidence intervals on estimated parameters
confint(PowFit)

### Exercise 1 ###
p <- ggplot(Data2Fit, aes(x = TotalLength, y = BodyWeight)) + geom_point() #scatterplot
p +
  geom_smooth(colour = "blue",
              width = 1,
              se = FALSE,
              method = "loess",
              formula = y ~ x) # use 'adaptive' spline
p