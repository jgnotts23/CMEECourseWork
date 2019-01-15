#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Jan 2019

rm(list=ls())
graphics.off()

# ANOVA is a type of linear model and is often appropriate when the response variable is continuous
# and the predictor variable is categorical. Specifically, one-way ANOVA is used to compare means
# of two or more samples representing numerical, continuous data in response to a single categorical variable

mammals <- read.csv('../Data/MammalData.csv')
str(mammals)

summary(mammals)

plot(meanCvalue ~ TrophicLevel, data = mammals) #more spread in data above median than below

mammals$logCvalue <- log(mammals$meanCvalue)

## Function for standard error of mean ##
seMean <- function(x){ # get standard error of the mean from a set of values (x)
  x <- na.omit(x) # get rid of missing values
  
  se <- sqrt(var(x)/length(x)) # calculate the standard error
  
  return(se)  # tell the function to return the standard error
}

## Split into groups and calculate means then SE ##
trophMeans <- tapply(mammals$logCvalue, mammals$TrophicLevel, FUN = mean, na.rm = TRUE)
print(trophMeans)
  
trophSE <- tapply(mammals$logCvalue, mammals$TrophicLevel, FUN = seMean)
print(trophSE)


## Now plot ##
# get the upper and lower limits of the error bars
upperSE <- trophMeans + trophSE
lowerSE <- trophMeans - trophSE

# get a barplot
# - this function can report where the middle of the bars are on the x-axis
# - set the y axis limits to contain the error bars

barMids <- barplot(trophMeans, ylim=c(0, max(upperSE)), ylab = 'log C value (pg)')

# Now use the function to add error bars
# - draws arrows between the points (x0,y0) and (x1,y1)
# - arrow heads at each end (code=3) and at 90 degree angles

arrows(barMids, upperSE, barMids, lowerSE, ang=90, code=3)


### Ground-dwelling ###
GroundDwellingMeans <- tapply(mammals$logCvalue, mammals$GroundDwelling, FUN = mean, na.rm = TRUE)
print(GroundDwellingMeans)

GroundDwellingSE <- tapply(mammals$logCvalue, mammals$GroundDwelling, FUN = seMean)
print(GroundDwellingSE)

GupperSE <- GroundDwellingMeans + GroundDwellinghSE
GlowerSE <- GroundDwellingMeans - GroundDwellinghSE

GbarMids <- barplot(GroundDwellingMeans, ylim=c(0, max(GupperSE)), ylab = 'log C value (pg)')
arrows(GbarMids, GupperSE, GbarMids, GlowerSE, ang=90, code=3)

### Gplots package alternative ###
library(gplots)

# Get plots of group means and standard errors
par(mfrow=c(1,2))
plotmeans(logCvalue ~ TrophicLevel, data=mammals, p=0.95, connect=FALSE)
plotmeans(logCvalue ~ GroundDwelling, data=mammals, p=0.95, connect=FALSE)

## ANOVA ##
trophicLM <- lm(logCvalue ~ TrophicLevel, data=mammals)
anova(trophicLM)
summary(trophicLM)










  