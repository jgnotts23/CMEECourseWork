#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Jan 2019

rm(list=ls())
graphics.off()

d<-read.table("../Data/ObserverRepeatability.txt", header=T) 	
str(d) 	
hist(d$Tarsus)
hist(d$BillWidth) 	

# Remove error/outlier
d<-subset(d, d$Tarsus<=40) 	
d<-subset(d, d$Tarsus>=10) 	
hist(d$Tarsus) 	

summary(d$Tarsus)
var(d$Tarsus) 	#4.15
summary(d$BillWidth) 	
var(d$BillWidth) #0.75

# Is there more variation between different student measurements than between 
# different measures by the same student

# Lets run 2 mixed-effects linear models, one for tarsus and one for bill as reponses
# Student ID and group ID will be random effects on the intercept
# No fixed effects will be added, so intercept fixed to 1
# Likelihood ratio test to be used for testing significance of each random effect
# by testing a model including the effect against one without the effect

require(lme4)
require(lmtest)

mT1<-lmer(Tarsus~1+(1|StudentID), data=d) 	
mT2<-lmer(Tarsus~1+(1|StudentID)+(1|GroupN), data=d) 	
lrtest(mT1,mT2)	#likelihood ratio test

# The more complex model (mT2) does not explain the data better but it is close
summary(mT1)



#### Part 2 ####
rm(list=ls())
graphics.off()

d<-read.table("../Data/DataForMMs.txt", header=T) 	
str(d) 	
max(d$Individual) 	

# To treat individual as a factor not integer
d$Individual<-as.factor(d$Individual) 	
names(d)

par(mfrow=c(2,3)) 	
hist(d$LitterSize) 	
hist(d$Size) 	
hist(d$Hornlength) 	
hist(d$Bodymass) 	
hist(d$Glizz) 	
hist(d$SexualActivity)
graphics.off()

# Hypothesis 1 - There is sexual trimorphism in body mass, size and horn length
par(mfrow=c(1,3)) 	
boxplot(d$Bodymass~d$Sex) 	
boxplot(d$Size~d$Sex) 	
boxplot(d$Hornlength~d$Sex) 	

# Doesn't look like it but will analyse further to check
# There is pseudoreplication in this dataset (individual measured more than once)
# So a simple linear model is insufficient
# Fixed factors can't be used intuitively because theres so many factors 
# Need to run a linear mixed model and put individual as random effect on the intercept 
# as random effect on the intercept to account for pseudoreplication
h1m1<-lmer(Bodymass~Sex+(1|Individual), data=d) 	
summary(h1m1) 	
# No effect of sex on body mass

h1m2<-lmer(Bodymass~Sex+(1|Individual)+(1|Family), data=d) 	
summary(h1m2) 
# It seems family explain similar variation to individual but the SD is quite large

# Lets tets with a likelihood ratio test to see if the extra parameter improves the model
lrtest(h1m1,h1m2) # it does!








