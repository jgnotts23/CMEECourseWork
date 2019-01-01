#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

# Stats with sparrows 6/7/8
rm(list=ls())
library(pwr)

d <- read.table("../Data/SparrowSize.txt", header=TRUE)
d1 <- subset(d, d$Year==2001)

# Influence of df on t-test
t.test(d1$Tarsus~d1$Sex, na.rm=TRUE) #insignificant
t.test(d$Tarsus~d$Sex, na.rm=TRUE) #very significant due to large sample size (df)

# Type I error - effect detected but doesn't exist. Chance proportional to confidence interval (e.g. 5%)
# Type II error - no effect detected, but it does exist
# Type II depends on statistical power, bigger sample size will decrease the chances

# However, must consider biological relevance. Significant t-test above actually equates to a 0.5 mm
# difference in Tarsus length, potentially negligable

# Statistical power - probability to detect an effect of specific size
# To calculate:
## Mean in each group (make one 0, the other the difference, 0.16)
## N (sample size, what we want to find out)
## sd of combined groups (0.96)
## Power level (80% usually ok, type II error chance 20%)
pwr.t.test(d=(0-0.16)/0.96, power=.8, sig.level=.05, type="two.sample", alternative="two.sided")
# Gives n = 566, this is the number needed in each group
# For 90% power, n would need to be 758

# Cartesian coordinates - (x, y)
# Statistical convention - y is response variable, x is explanatory variable