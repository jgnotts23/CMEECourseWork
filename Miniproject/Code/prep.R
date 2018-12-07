#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Nov 2018
# Desc - Import data and prepare for NLLS fitting

# Clear and import
rm(list = ls())
graphics.off()
require("minpack.lm")

bio <- read.csv(file="../Data/BioTraits.csv")

### Data preparation ###
# Remove NAs and -ve
bio <- bio[!is.na(bio$OriginalTraitValue),]
bio <- bio[bio$OriginalTraitValue >= 0, ]
bio <- bio[!is.na(bio$AmbientTemp),]


# Convert to Kelvins
kelvin <- bio[bio$AmbientTemp > 250,]
celsius <- bio[bio$AmbientTemp < 250,]
Mannisto <- bio[bio$CitationID == "891",]

# Define polynomial
cubic <- function(x, B0, B1, B2, B3){
  return(B0 + (B1*x) + (B2*x^2) + (B3*x^3))
}

### Model fitting ###
plot(Mannisto$AmbientTemp, Mannisto$OriginalTraitValue)

cubfit <- nlsLM(OriginalTraitValue ~ cubic(AmbientTemp, B0, B1, B2, B3), data = Mannisto, start = list(B0 = .01, B1 = .01, B2 = .01, B3 = .01))
summary(cubfit)

# Generate vector of Temps
Lengths <- seq(min(Mannisto$AmbientTemp),max(Mannisto$AmbientTemp),len=200)

# Calculate predicted line
coef(cubfit)["B0"]
coef(cubfit)["B1"]
coef(cubfit)["B2"]
coef(cubfit)["B3"]

predic_cubfit <- cubic(Lengths,coef(cubfit)["B0"],coef(cubfit)["B1"],coef(cubfit)["B2"],coef(cubfit)["B3"])

# Plot data with fitted model line
plot(Mannisto$AmbientTemp, Mannisto$OriginalTraitValue)
lines(Lengths, predic_cubfit, col = 'blue', lwd = 2.5)

### Arrenhius ###
k <- 8.617*(10^-5)

arrenhius <- function(Temp, Ea, A0){
  return(A0*(exp(-(Ea/(k*Temp)))))
}

plot(Mannisto$AmbientTemp, Mannisto$OriginalTraitValue)

arrfit <- nlsLM(OriginalTraitValue ~ arrenhius(AmbientTemp, Ea, A0), data = Mannisto, start = list(Ea = .65, A0 = 1))
summary(arrfit)

coef(arrfit)["Ea"]
coef(arrfit)["A0"]

predic_arrfit <- arrenhius(Lengths,coef(arrfit)["Ea"],coef(arrfit)["A0"])

plot(Mannisto$AmbientTemp, Mannisto$OriginalTraitValue)
lines(Lengths, predic_arrfit, col = 'blue', lwd = 2.5)
















