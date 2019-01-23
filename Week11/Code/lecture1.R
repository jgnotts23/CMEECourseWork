#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Jan 2019

rm(list=ls())
graphics.off()

# Read-in and inspect data
d <- read.table("../Data/SparrowSize.txt", header=TRUE)
str(d)
names(d)
head(d)

# Centrality and spread
par(mfrow=c(1,1))
hist(d$Tarsus, main="", xlab="Sparrow tarus length (mm)", col="grey")
mean(d$Tarsus, na.rm=TRUE) #18.52
var(d$Tarsus, na.rm=TRUE) #0.74
sd(d$Tarsus, na.rm=TRUE) #0.86
graphics.off()

# Remember 1 standard deviation = where 68.2% of the data lies

# Plotting probability density
par(mfrow=c(1,1))
hist(d$Tarsus, main="", xlab="Sparrow tarsus length (mm)", col="grey", prob=TRUE) # this argument tells R to plot density instead of frequency, you can see that on the y-axis 	
lines(density(d$Tarsus,na.rm=TRUE), lwd = 2)  # density plot 	
abline(v = mean(d$Tarsus, na.rm = TRUE), col = "red",lwd = 2) #vertical line mean	
abline(v = mean(d$Tarsus, na.rm = TRUE)-sd(d$Tarsus, na.rm = TRUE), col = "blue",lwd = 2, lty=5) #lower sd bound
abline(v = mean(d$Tarsus, na.rm = TRUE)+sd(d$Tarsus, na.rm = TRUE), col = "blue",lwd = 2, lty=5) #upper sd bound
graphics.off()

# There seems to be a slight divergence into two peaks, possibly because of sexual dimorphism 
# in tarsus length, this would be a goo avenue of further analysis
t.test(d$Tarsus~d$Sex) # p = 0.0002 (very significant) but equates to 0.14mm, could be type 2 error

par(mfrow=c(2,1)) 	
hist(d$Tarsus[d$Sex==1], main="", xlab="Male sparrow tarsus length (mm)", col="grey", prob=TRUE)
lines(density(d$Tarsus[d$Sex==1],na.rm=TRUE), lwd = 2) 	
abline(v = mean(d$Tarsus[d$Sex==1], na.rm = TRUE), col = "red",lwd = 2) 	
abline(v = mean(d$Tarsus[d$Sex==1], na.rm = TRUE)-sd(d$Tarsus[d$Sex==1], na.rm = TRUE), col = "blue",lwd = 2, lty=5) 	
abline(v = mean(d$Tarsus[d$Sex==1], na.rm = TRUE)+sd(d$Tarsus[d$Sex==1], na.rm = TRUE), col = "blue",lwd = 2, lty=5) 	

hist(d$Tarsus[d$Sex==0], main="", xlab="Female sparrow tarsus length (mm)", col="grey", prob=TRUE) 	
lines(density(d$Tarsus[d$Sex==0],na.rm=TRUE), lwd = 2) 	
abline(v = mean(d$Tarsus[d$Sex==0], na.rm = TRUE), col = "red",lwd = 2) 	
abline(v = mean(d$Tarsus[d$Sex==0], na.rm = TRUE)-sd(d$Tarsus[d$Sex==0], na.rm = TRUE), col = "blue",lwd = 2, lty=5) 	
abline(v = mean(d$Tarsus[d$Sex==0], na.rm = TRUE)+sd(d$Tarsus[d$Sex==0], na.rm = TRUE), col = "blue",lwd = 2, lty=5) 
graphics.off() 	
# the slight peak split still appears in the female graph so gender may not be the whole explanation
# This could be because un-molted males can be mistaken for females or perhaps instrumental error


##### Variance ####
# Variance is the sum of the squared deviations from the mean, over the sample size minus 1
# If two independent variables are summed, the variance of that summed variable is equal to
# the sum of the variance of each individual variable (ADDITIVE)
d1<-subset(d, d$Tarsus!="NA") 	
d1<-subset(d1, d1$Wing!="NA") 	
sumz<-var(d1$Tarsus)+var(d1$Wing) #variance then add
test<-var(d1$Tarsus+d1$Wing) 	#add then variance
sumz 	#6.58
test #8.17, they're not equal! Maybe the variables are not independent

plot(jitter(d1$Wing),d1$Tarsus, pch=19, cex=0.4)
graphics.off()
# Clearly shows a relationship so they're not independent
# The solution here is to take the covariance into account
# Variance(tarsus + wing) = variance(tarsus) + variance(wing) + 2COVariance(tarsus + wing)

cov(d1$Tarsus,d1$Wing) 	#0.80
sumz<-var(d1$Tarsus)+var(d1$Wing)+2*cov(d1$Tarsus,d1$Wing) 	
test<-var(d1$Tarsus+d1$Wing) 	
sumz 	#8.18
test  #8.18, it works!
#This holds even if the variables are independent seeing as 2 x 0 is 0
# If two variables are collinear they are not independent


#### Linear models ####
uni<-read.table("../Data/RUnicorns.txt", header=T) 	
str(uni) 	
head(uni)
mean(uni$Bodymass) 	#10.39
sd(uni$Bodymass) 	#2.79
var(uni$Bodymass) 	#7.77
hist(uni$Bodymass)
mean(uni$Hornlength) #5.71
sd(uni$Hornlength)  #1.23
var(uni$Hornlength) #1.51
hist(uni$Hornlength)

# Model fitting
par(mfrow=c(1,1))
plot(uni$Bodymass~uni$Hornlength, pch=19, xlab="Unicorn horn length", ylab="Unicorn body mass", col="blue") 	
mod<-lm(uni$Bodymass~uni$Hornlength) 	#make model
abline(mod, col="red") 	#add model line
res <- signif(residuals(mod), 5) 	#signif rounds number to 5 in this case
pre <- predict(mod) 	
segments(uni$Hornlength, uni$Bodymass, uni$Hornlength, pre, col="black") 	#residual lines
graphics.off()

# We can add all covariates and fixed factors that account for variation then test which
# ones account for the most variation
hist(uni$Bodymass) 	#left-skewed normal
hist(uni$Hornlength) #semi-normal	but may be two peaks
hist(uni$Height) 	#not that normal

# What about collinearity?
cor.test(uni$Hornlength,uni$Height) #not much correlation
par(mfrow=c(1,1))
boxplot(uni$Bodymass~uni$Gender, ylab="Body mass")
graphics.off()
# females seem to be heavier and have greater variance, possibly due to pregnancy

par(mfrow=c(1,2)) 	
boxplot(uni$Bodymass~uni$Pregnant, xlab="Pregnant", ylab="Body mass") 
plot(uni$Hornlength[uni$Pregnant==0],uni$Bodymass[uni$Pregnant==0], pch=19, xlab="Horn length", ylab="Body mass", xlim=c(2,10), ylim=c(6,19)) 	
points(uni$Hornlength[uni$Pregnant==1],uni$Bodymass[uni$Pregnant==1], pch=19, col="red") 	
graphics.off()

par(mfrow=c(1,1)) 	
plot(uni$Hornlength[uni$Gender=="Female"],uni$Bodymass[uni$Gender=="Female"], pch=19, xlab="Horn length", ylab="Body mass", xlim=c(2,10), ylim=c(6,19)) 	
points(uni$Hornlength[uni$Gender=="Male"],uni$Bodymass[uni$Gender=="Male"],pch=19, col="red") 	
points(uni$Hornlength[uni$Gender=="Undecided"],uni$Bodymass[uni$Gender=="Undecided"],pch=19, col="green") 	
graphics.off()
# so gender and glizz are factors, lets make a model

# Running a model on multiple covariants
FullModel<-lm(uni$Bodymass~uni$Hornlength+uni$Gender+uni$Pregnant+uni$Glizz) 	
summary(FullModel) #fairly inconclusive

# Removing pregnancy as a factor as this is only relevant to females
u1<-subset(uni, uni$Pregnant==0) 	
FullModel<-lm(u1$Bodymass~u1$Hornlength+u1$Gender+u1$Glizz) 	
summary(FullModel) #better, but appears gender isn't necessary either

ReducedModel<-lm(u1$Bodymass~u1$Hornlength+u1$Glizz) 	
summary(ReducedModel) #both show p values less than 0.05

# Lets plot the reduced model
plot(u1$Hornlength[u1$Glizz==0],u1$Bodymass[u1$Glizz==0], pch=19, xlab="Hornlength", ylab="Body mass", xlim=c(2,10), ylim=c(6,19)) 	
points(u1$Hornlength[u1$Glizz==1],u1$Bodymass[u1$Glizz==1], pch=19, col="red") 	
abline(ReducedModel) #throws out a warning
# It only plots for the first two of three coefficients, so it didn't plot for Glizz

# Lets plot for Glizz instead
ModForPlot <- lm(u1$Bodymass ~ u1$Hornlength)
summary(ModForPlot)

plot(u1$Hornlength[u1$Glizz==0],u1$Bodymass[u1$Glizz==0], pch=19, xlab="Hornlength", ylab="Body mass", xlim=c(2,10), ylim=c(6,19)) 	
points(u1$Hornlength[u1$Glizz==1],u1$Bodymass[u1$Glizz==1], pch=19, col="red") 	
abline(ModForPlot) 	

# So, some variation in body mass is caused by pregnancy but this has been excluded as we are not
# interested in that for the time being. Some of the variation is caused by investment in Glizz (ornaments)
# Statistically, a lot of the variation can be explained by Glizz.
# The R^2 value for ModForPlot is 0.46 which indicates 46% of the variation is explained by horn length.
# The R^2 value of ReducedMod suggests 61% of the variation can be explained by both horn length AND glizz
# So we know glizz accounts for something, but how much? is it 61-46 = 15%?
# If Horn length and glizz are independent we could explain this (ADDITIVE variance)
# So lets check this:
boxplot(u1$Hornlength ~ u1$Glizz)
t.test(u1$Hornlength ~ u1$Glizz) #significant

# So while it seems unicorns with longer horns are more likely to wear Glizz, its not the cleanest
# relationship. It seems the variances differ betweens the groups, but the difference is significant.
# As the variables are not independent we cannot use the difference in R^2 to account for the 
# difference in variance. 
plot(ReducedModel) #Points 14, 6, and 12 seem odd
View(u1) #They don't seem that unusual, must be natural variation
# The sample size (and statistical power) is small so this doesn't
# However, we can be fairly confident is saying both glizz and horn length are positively
# associated with body mass. We'd also report the association between glizz and horn length
# We'd provide the plot where we indicate glizz with colored dots and the
# regression line from the reduced model
plot(u1$Hornlength[u1$Glizz==0],u1$Bodymass[u1$Glizz==0], pch=19, xlab="Hornlength", ylab="Body mass", xlim=c(3,8), ylim=c(6,15)) 	
points(u1$Hornlength[u1$Glizz==1],u1$Bodymass[u1$Glizz==1], pch=19, col="red") 	
abline(ReducedModel) 	

# Would need to include a legend explaining dot colour and where the regression line comes from
# Would also present a table with model in
# State regression line is from estiamte of horn length in this table
# Then in discussion, outline glizz accounts for some variation in body mass
# but representing it as a simple bimodal 'blizz or not' is probably not a good/true
# representation of this trait.
# It may be useful going forward to estimate the mass of the glizz so we can better account for it
# Would also discuss the association between horn length and glizz and this may
# indicate a phenomenon that needs to be investigated further


#### Linear models - interpretation of interactions ####
#### Two-level fixed factor and continuous variable ####

rm(list=ls())

dat <- read.table("../Data/data.txt", header=TRUE)
head(dat)
str(dat)

# This is fictional data about species richness of arthropods in grasslands. 
# Some grasslands have high diversity (up to 60 species), while others are very low (1 species)
# Half of samples were farmed with conventional measures and the other half was organic
# Question - effect of fertiliser on species richness
# Hypothesis - increasing amounts of fertilizer lead to lowers species richness

# We know organic grassland probably has higher diversity so we add it as a fixed factor to the model
# We also assume amount of fertiliser affects conventional grassland and organic grassland differently
# Specifically, we expect fertilisers might affect organic grasslands less
# Therefore, we add an interaction to the model

fullmodel <- (lm(species_richness ~ fertilizer * method, data=dat))
summary(fullmodel) #significant reaction

# First, for conventional grassland, we can interpret directly because the reference level
# of the fixed factor (method) is conventional (the level that is NOT mentioned here)
# Per unit fertiliser more applied, we find 0.78 fewer species
# In organic, there are 1.19 more species (parameter estimate of the fixed factor for the level organic)
# The interaction tells us that in organic grassland, per unit fertiliser,
# there is 0.81 more species, IN ADDITION to the other effect
# Lets examine the formula:
# yi = bintercept + bfertilizerxi + bmethodxi + bmethodbfertilizerxi + ei
# Its clear what to plug in for fertiliser, but what about method?
# When a model is run in R with a categorical variable it is recoded into
# 0 and 1, in alphanumeric order (first = 0, next = 1)
# In this example, conventional = 0, organic = 1.
# So if method is 0 we can estimate expected values for conventional methods
# and if we plug in 1 we calculate for organic
# Then it needs to be ADDED to the first bit
# So to interpret an interaction term for another level, you have to
# ADD its parameter estimate to the slope of the main effect
# In this case thats 0.78 + 0.81 which is 0.03
# So with every unit of fertiliser more the species richness increases by 0.03
# This is a very positive relationship and significant
# However, the standard error is 0.1 so the effect size (0.03) is much smaller
# so we cannot conclude there is a significant effect in the organic grassland

plot(dat$species_richness[dat$method=="conventional"]~dat$fertilizer[dat$method=="conventional"], pch=16, xlim=c(0,50),ylim=c(0,70), col="grey", ylab="Species richness", xlab="Fertilizer(units)") 	
points(dat$fertilizer[dat$method=="organic"],dat$species_richness[dat$method=="organic"], pch=16, col="black") 	
# So clearly a difference
plot(fullmodel)


#### Linear models - interpretation of interactions ####
#### Three-level fixed factor and continuous variable ####

rm(list=ls()) 	

d<-read.table("../Data/Three-way-Unicorn.txt", header=TRUE) 	
str(d)
names(d)
head(d)

# Going to see if relationship between horn length and bodymass is different between the genders
# Hypothesis - only fat unicorns can grow a long horn
# hornlength = response, body mass = explanatory
# Unicorns have 3 genders, so analysis with three-level factor and continuous explanatory variable
mean(d$Bodymass) #86.22
sd(d$Bodymass) #5.30
var(d$Bodymass) #28.09

par(mfrow=c(1,2))
hist(d$Bodymass, main="")

mean(d$HornLength) #9.06
sd(d$HornLength) #3.00
var(d$HornLength) #8.99
hist(d$HornLength, main="")

# So, response is hornlength, bodymass is explanatory covariate and gender is our three-level fixed factor
dev.off() 	
plot(d$HornLength[d$Gender=="male"]~d$Bodymass[d$Gender=="male"], xlim=c(70,100),ylim=c(0,18), pch=19, xlab="Bodymass (kg)", ylab="Hornlength (cm)") 	
points(d$Bodymass[d$Gender=="female"],d$HornLength[d$Gender=="female"], col="red", pch=19) 	
points(d$Bodymass[d$Gender=="not_sure"],d$HornLength[d$Gender=="not_sure"], col="green", pch=19) 	

# Appears to be different means (mainly in bodymass), and different slope in males
# than in both females and undecided unicorns
mod<-lm(HornLength~Gender*Bodymass, data=d) 	
summary(mod)
# So, intercept doesn't tell us much as the data hasn't been standardised
# Female is reference category
# Interaction between male and bodymass is significant
# This means the difference between male slope and female slope (bodymass, 0.63)
# is statistically significant from zero
# Interaction for third gender is not significant but is close
# Hornlength(females) = -42.31 + 0.63*Bodymass









