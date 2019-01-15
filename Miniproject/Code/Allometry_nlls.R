#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Jan 2019

rm(list = ls())
graphics.off()
library("ggplot2")
library(repr)
options(repr.plot.width=6, repr.plot.height=5)
require("minpack.lm") # Levenerg-Marquardt nls fitting
#can deal with greater range of starting parameters

## Allometric scaling of traits ##
# The scaling of body weight vs. total body length
# in dragonfiles and damselflies
# y = a(x^b)
# Where x and y are morphological measures (body length and weight in this example)
# a is the value of y at body length x=1
# b is the scaling "exponent"
# Also called a power-law because y relates to x through a simple power

## Creating a function for the power law model:
powMod <- function(x, a, b) {
    return(a * x^b)
}

## Import data
MyData <- read.csv("../Data/GenomeSize.csv")

# Anisoptera = dragonflies
# Zygoptera = damselflies
# BodyWeight and TotalLength are variables of interest

## Subset and remove NAs:
Data2Fit <- subset(MyData, Suborder == "Anisoptera")
Data2Fit <- Data2Fit[!is.na(Data2Fit$TotalLength),]

## Preliminary inspection:
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
ggplot(Data2Fit, aes(x = TotalLength, y = BodyWeight)) + geom_point()

## Fit model to data using NLLS
PowFit <- nlsLM(BodyWeight ~ powMod(TotalLength, a, b), data = Data2Fit, start = list(a = .1, b = .1))
summary(PowFit)

## Visualising the fit
Lengths <- seq(min(Data2Fit$TotalLength),max(Data2Fit$TotalLength),len=200) #vector of body lengths

coef(PowFit)["a"] #extract coefficients
coef(PowFit)["b"]

Predic2PlotPow <- powMod(Lengths,coef(PowFit)["a"],coef(PowFit)["b"])

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight) #plot data
lines(Lengths, Predic2PlotPow, col = 'blue', lwd = 2.5) #and fitted model line

## Calculate confidence intervals
confint(PowFit)

### Exercises ###
## A - make same plot in ggplot ##
lm_eqn <- function(Data2Fit){
  eq <- substitute(italic(y) == a + b %.% italic(x), 
                   list(a = format(coef(PowFit)[1], digits = 3), 
                        b = format(coef(PowFit)[2], digits = 3)))
  as.character(as.expression(eq));                 
}

ggplot(Data2Fit, aes(x = TotalLength, y = BodyWeight)) + geom_point() +
  stat_smooth(method = 'nls', formula = 'y~a*(x^b)',
              method.args = list(start=c(a=0.1, b=0.1)), se=FALSE) +
  geom_text(x = 40, y = 0.3, label = lm_eqn(MyData), parse = TRUE)

## B - play with starting values are try to 'break' the fit (NLLS doesn't converge on solution) ##
PowFit <- nlsLM(BodyWeight ~ powMod(TotalLength, a, b), data = Data2Fit, start = list(a = 100, b = 100))
summary(PowFit) #no convergence

## C - Repeat using Zygoptera data ##
Data2Fit2 <- subset(MyData, Suborder == "Zygoptera")
Data2Fit2 <- Data2Fit[!is.na(Data2Fit$TotalLength),]

plot(Data2Fit2$TotalLength, Data2Fit2$BodyWeight)
ggplot(Data2Fit2, aes(x = TotalLength, y = BodyWeight)) + geom_point()

PowFit2 <- nlsLM(BodyWeight ~ powMod(TotalLength, a, b), data = Data2Fit2, start = list(a = .1, b = .1))
summary(PowFit2)

Lengths2 <- seq(min(Data2Fit2$TotalLength),max(Data2Fit2$TotalLength),len=200) #vector of body lengths

coef(PowFit2)["a"] #extract coefficients
coef(PowFit2)["b"]

Predic2PlotPow2 <- powMod(Lengths2,coef(PowFit2)["a"],coef(PowFit2)["b"])

plot(Data2Fit2$TotalLength, Data2Fit2$BodyWeight) #plot data
lines(Lengths2, Predic2PlotPow2, col = 'blue', lwd = 2.5) #and fitted model line

ggplot(Data2Fit2, aes(x = TotalLength, y = BodyWeight)) + geom_point() +
  stat_smooth(method = 'nls', formula = 'y~a*(x^b)',
              method.args = list(start=c(a=0.1, b=0.1)), se=FALSE) +
  geom_text(x = 40, y = 0.3, label = lm_eqn(MyData), parse = TRUE)

## D = using OLS ##
# bi-logarithmically transform the data
# log(y) = log(a) + blog(x)
out <- lm(log(BodyWeight)~log(TotalLength),data=Data2Fit)
summary(out)

logLengths <- seq(min(log(Data2Fit$TotalLength)),max(log(Data2Fit$TotalLength)),len=200) #vector of body lengths

coef(out)["a"] #extract coefficients
coef(out)["b"]

logPredic2PlotPow <- powMod(Lengths,coef(PowFit)["a"],coef(PowFit)["b"])

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight) #plot data
lines(Lengths, Predic2PlotPow, col = 'blue', lwd = 2.5)







