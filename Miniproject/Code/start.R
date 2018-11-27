#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Nov 2018

library("readxl")
library("ggplot2")
require("minpack.lm") 

options(repr.plot.width=6, repr.plot.height=5)

my_data <- read_excel("../Data/DeLong_data.xlsx", sheet = 1)

powMod <- function(x, a, b) {
    return(a * x^b)
}

#subset
#Data2Fit <- subset(my_Data,Suborder == "Anisoptera")
Data2Fit <- my_data[!is.na(my_data$Rate), ] # remove NA's
Data2Fit <- my_data[!is.na(my_data$Temp), ] # remove NA's

#plot
plot(Data2Fit$Temp, Data2Fit$Rate)

##model fitting
PowFit <- nlsLM(Rate ~ powMod(Temp, a, b), data = Data2Fit, start = list(a = .1, b = .1))