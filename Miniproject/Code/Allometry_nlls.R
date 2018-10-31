rm(list = ls())
graphics.off()
library("ggplot2")
library(repr)
options(repr.plot.width=6, repr.plot.height=5)

require("minpack.lm")

# allometric scaling of traits
powMod <- function(x, a, b) {
    return(a * x^b)
}

MyData <- read.csv("../Data/GenomeSize.csv")
head(MyData)

Data2Fit <- subset(MyData,Suborder == "Anisoptera")
Data2Fit <- Data2Fit[!is.na(Data2Fit$TotalLength),] # remove NA's

# Regular plot
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)

# Or using ggplot
ggplot(Data2Fit, aes(x = TotalLength, y = BodyWeight)) + geom_point()

PowFit <- nlsLM(BodyWeight ~ powMod(TotalLength, a, b), data = Data2Fit, start = list(a = .1, b = .1))
summary(PowFit)

# Visualising the fit
# Generate vector of body lengths
Lengths <- seq(min(Data2Fit$TotalLength),max(Data2Fit$TotalLength),len=200)

# Extract the coeffient from the model fit
coef(PowFit)["a"]
coef(PowFit)["b"]

Predic2PlotPow <- powMod(Lengths,coef(PowFit)["a"],coef(PowFit)["b"])

# Plot data with fitted line model
plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col = 'blue', lwd = 2.5)

# Calculate condidence intervals on estimated parameters
confint(PowFit)