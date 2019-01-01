#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

# Stats with sparrows 1
rm(list=ls()) #clear workspace

# Checking and setting working directory
getwd() # Check current directory
setwd("~/Documents/CMEECourseWork/Week4/Code") # Set working directory

# Basic calculator commands (bodmas applies)
2*2+1 #5
2*(2+1) #6
12/2^3 #1.5
(12/2)^3 #216

# Assigning variables
x <- 5
x

y <- 2
y

x2 <- x^2
x2 #25
x #still 5

a <- x2+x
a #30

y2 <- y^2
z2 <- x2 + y2
z <- sqrt(z2)
print(z) #prints to terminal

# Logical tests
3>2 #TRUE
3 >= 3 #TRUE
4<2 #FALSE

# Creating vectors
myNumericVector <- c(1.3,2.5,1.9,3.4,5.6,1.4,3.1,2.9) #c denotes a vector
myCharacterVector <- c("low","low","low","low","high","high","high","high")
myLogicalVector <- c(TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,FALSE,FALSE)

# Finding the structure of a variable
str(myNumericVector) #Returns datatype and how many terms
str(myCharacterVector)
str(myLogicalVector)

# If different datatypes are added to the same variable, R will coerce them
# Into the most basic mode that covers all:
myMixedVector <- c(1, TRUE, FALSE, 3, "help", 1.2, TRUE, "notwhatIplanned")
str(myMixedVector) #All have been coerced to characters

# Installing and loading packages
install.packages("lme4")
library(lme4)
require(lme4)

# Help
help(getwd)
help(log)

# There is some special notation in R
sqrt(4); 4^0.5; log(0); log(1); log(10); log(Inf) #Inf means infinity
exp(1) #exponential
pi #pi, R default is 7 digits max

# Reading in data
d <- read.table("../Data/SparrowSize.txt", header=TRUE) #read with headers included
str(d) #Gives column datatype and values