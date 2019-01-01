#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

# Stats with sparrows 14
rm(list=ls())

d <- read.table("../Data/SparrowSize.txt", header=TRUE)

# Repeatability - how consistent something is within a group compared to the whole sample
# Its the ratio of among-group variance over the total variance
# E.g. measuring tarsus length isn't easy, often observers  measure 3 times and take the mean

d1 <- subset(d, d$Wing!="NA")
model3 <- lm(Wing~as.factor(BirdID), data=d1)
anova(model3)
# alternative explanation of what we found here would be that birds have consistent wing length
# They differ less from multiple measures than they do from each other
# Another way of saying this is saying that bird's wing length is REPEATABLE.
# The statistical term is called REPEATABILITY or r or INTRACLASS CORRELATION COEFFICIENT
# It can be used to assess the quality of a method, to test for individual observer repeatability
# It can be calculated using the SS and MS of an ANOVA