#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

# Stats with sparrows 4
rm(list=ls())

# Standard deviation describes the spread and variability of a distribution
# Standard error describes the precision of the data (i.e. how precise is the sample mean?)
# se  = sqrt(variance / n)

# Calculating SE 
d <- read.table("../Data/SparrowSize.txt", header=TRUE)
Tarsus <- subset(d, d$Tarsus!="NA")
Mass <- subset(d, d$Mass!="NA")
Wing <- subset(d, d$Wing!="NA")
Bill <- subset(d, d$Bill!="NA")

sqrt(var(Tarsus$Tarsus)/length(Tarsus$Tarsus))
sqrt(var(Mass$Mass)/length(Mass$Mass))
sqrt(var(Wing$Wing)/length(Wing$Wing))
sqrt(var(Bill$Bill)/length(Bill$Bill))

d2001 <- subset(d, d$Year=="2001")
Tarsus2001 <- subset(d2001, d2001$Tarsus!="NA")
Mass2001 <- subset(d2001, d2001$Mass!="NA")
Wing2001 <- subset(d2001, d2001$Wing!="NA")
Bill2001 <- subset(d2001, d2001$Bill!="NA")

sqrt(var(Tarsus2001$Tarsus)/length(Tarsus2001$Tarsus))
sqrt(var(Mass2001$Mass)/length(Mass2001$Mass))
sqrt(var(Wing2001$Wing)/length(Wing2001$Wing))
sqrt(var(Bill2001$Bill)/length(Bill2001$Bill))

# 95% confidence intervals:
quantile(Tarsus$Tarsus, probs=c(0.025, 0.975))
quantile(Mass$Mass, probs=c(0.025, 0.975))
quantile(Wing$Wing, probs=c(0.025, 0.975))
quantile(Bill$Bill, probs=c(0.025, 0.975))

quantile(Tarsus2001$Tarsus, probs=c(0.025, 0.975))
quantile(Mass2001$Mass, probs=c(0.025, 0.975))
quantile(Wing2001$Wing, probs=c(0.025, 0.975))
quantile(Bill2001$Bill, probs=c(0.025, 0.975))

# Standard error is dependent on sample size so precision can be increased by increasing sample size
# To halve se, n must be increased by n^2
# 95CI = +/- 1.96 se (if N > 50)