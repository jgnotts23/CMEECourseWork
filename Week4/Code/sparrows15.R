#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Jan 2019

# Stats with sparrows 15
rm(list=ls())

## Linear Models ##
d <- read.table("../Data/SparrowSize.txt", header=TRUE)

# Run a linear model to test whether relationship between bill length (response)
# and tarsus differs between sexes in sparrows
lm(Bill ~ Tarsus, data=d)
