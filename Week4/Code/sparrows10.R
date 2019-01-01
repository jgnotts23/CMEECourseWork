#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

# Stats with sparrows 10
rm(list=ls())

d <- read.table("../Data/SparrowSize.txt", header=TRUE)

# t-tests can be used to see if a calculated slope is different from 0
# Data can be standardised (e.g. z-transform) so the intercept becomes meaningful (mean of y)
plot(d$Mass~d$Tarsus, ylab="Mass (g)", xlab="Tarsus (mm)", pch=19, cex=0.4)
# From this plot, the slope and intercept and can guesstimated by looking at it
# yi = b0 +b1xi + epsiloni
# yi = 5 + 1.6xi + epsiloni
# The spread of the data is the ERROR (epsilon)
# There is one error term/residual for each observation (how far point is from actual line)

d1 <- subset(d, d$Mass!="NA")
d2 <- subset(d1, d1$Tarsus!="NA")
length(d2$Tarsus)

model1 <- lm(Mass~Tarsus, data=d2)
summary(model1) #1644 obs, 1642 df, due to 2 parameter estimations
# the R^2 is 0.23, this means 23% of the variance in mass is explained by variation in tarsus
# If R^2 equalled 1, you'd see a straight line:
hist(model1$residuals)

# With z-scores of Tarsus
d2$z.Tarsus <- scale(d2$Tarsus) #scale standardises
model3 <- lm(Mass~z.Tarsus, data=d2)
summary(model3)
plot(d2$Mass~d2$z.Tarsus, pch=19, cex=0.4)
abline(v = 0, lty = "dotted")

# What does the slope mean now?
d$Sex <- as.numeric(d$Sex)
par(mfrow = c(1,2))
plot(d$Wing ~ d$Sex.1, ylab="Wing(mm)")
plot(d$Wing ~ d$Sex, xlab="Sex", xlim=c(-0.1,1.1), ylab="")
abline(lm(d$Wing ~ d$Sex), lwd=2)
text(0.15, 76, "intercept")
text(0.9, 77.5, "slope", col="red")

# t-test for linear models
d4 <- subset(d, d$Wing!="NA")
m4 <- lm(Wing~Sex, data=d4)
t4 <- t.test(d4$Wing~d4$Sex, var.equal=TRUE)
summary(m4)
t4

# Are the residuals normally distributed?
par(mfrow=c(2,2))
plot(model3)
# top-left should show no pattern, top-right should be a stright line (standardised residuals)

par(mfrow=c(2,2))
plot(m4)
