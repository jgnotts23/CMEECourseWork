#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

# Stats with sparrows 13
rm(list=ls())
require(dplyr)

d <- read.table("../Data/SparrowSize.txt", header=TRUE)

# ANOVA - analysis of variance, a test for differences of variances between groups
# Null hypothesis = groups are equal
# Idea being that variability between groups is larger than within groups
# Three requirements: within-group variation, between-group variation, total variation (sum of first 2)

# Within group:
ai <- c(1,1,2,1,1,1) # mu = 1.17, SS = 0.83, sig = 0.14
bi <- c(3,3,4,3,3,3) # mu = 3.17, SS = 0.83, sig = 0.14
ci <- c(5,5,4,5,5,1) # mu = 4.17, SS = 12.83, sig = 2.14

# Between group, mu = 2.84, SS = 28 (weigh each SS with n of group)
# Total stuff, mu = 2.83, SS = 42.5
anova(lm(ai~as.factor(ci)))

# Sparrow example
d1 <- subset(d, d$Wing!="NA")
summary(d1$Wing)
hist(d1$Wing) # appears to be some outliers, potentially young/moulting birds
model1 <- lm(Wing~Sex.1, data=d1)
summary(model1)
boxplot(d1$Wing~d1$Sex.1, ylab="Wing length (mm)")
anova(model1)
# The anova shows the SS for in-group variance and for the residuals. 
# It also shows the mean squares for within and between groups
# F-value is calculated by dividing the mean squares of the between-group estimate by the residual mean squares

# Now we know wing length differs between sexes, but by how much?
# t-test (analyses run after main analysis are called "post-hoc" tests)
t.test(d1$Wing~d1$Sex.1, var.equal=TRUE)

# What about when there is more than two groups?
# Each sparrow is measured multiple times, does their wing length change over time?
# Now BirdID becomes the factorial explanatory variable
boxplot(d1$Wing~d1$BirdID, ylab="Wing length (mm)")

tbl_df(d1)
glimpse(d1)
d$Mass %>% cor.test(d$Tarsus, na.rm=TRUE) # %>% pipes the first obkect into the function

d1 %>% 
  group_by(BirdID) %>% #group
  summarise (count=length(BirdID)) %>%
    count(count)

count(d1, BirdID) #quicker way but can't count(count)

model3 <- lm(Wing~as.factor(BirdID), data=d1)
anova(model3) #Can see there is more variation among groups(BirdID) than within groups(residuals)
# SO, t-test is about estimates, about difference in size
# ANOVA is about the difference in variance among groups vs. within groups

# What about mass variation by year?
boxplot(d$Mass~d$Year)
m2 <- lm(d$Mass~as.factor(d$Year))
anova(m2) #can see there is variation between years but between which ones?
summary(m2)
