#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

rm(list=ls())
graphics.off()

genome <- read.csv("../Data/GenomeSize.csv")
head(genome)

# The 'pairs' function, creates grid of scatterplots between each variable
pairs(genome, col=genome$Suborder) #bit messy for this dataset, too many variables

# Re-acquainting with indices in dataframes
dat <- data.frame(A = c("a", "b", "c", "d", "e"), B = c(1, 2, 3, 4, 5))
dat[1, ] #row 1, all columns
dat[, 2] #all rows, column 2
dat[2,1] #row 2, column 

# Analysis
morpho_vars <- c(4, 7, 8, 12, 14) # store the indices of columns interested in
pairs(genome[, morpho_vars], col = genome$Suborder)

# Calculating correlation coefficients
# Pearson correlation looks at the difference of each point from the mean of each variable
# 'cor' calculates correlation between pairs of variables
# 'cor.test' can only compare a single pair of variables but uses a t-test to assess
# whether the correlation is significant
cor(genome[, morpho_vars], use = 'pairwise') #pairwise tells R to omit NAs and use complete pairs of obs
cor.test(genome$GenomeSize, genome$TotalLength, use = "pairwise") 
# So genome size and body length are correlated

genome$logGS <- log(genome$GenomeSize)
genome$logBW <- log(genome$BodyWeight)
genome$logTL <- log(genome$TotalLength)
genome$logFL <- log(genome$ForewingLength)
genome$logFA <- log(genome$ForewingArea)

str(genome) #find new column no.s
logmorpho <- c(17, 18, 19, 20, 21)

pairs(genome[, logmorpho], col=genome$Suborder)
cor(genome[, logmorpho], use="pairwise")
# This shows the log-transformations have successfully addressed the non-linearity
# due to allometric scaling between variables in the data

## Performing a regression analysis ##
myColours <- c('red', 'blue')
mySymbols <- c(1, 3)
colnames(genome)

plot(logBW ~ GenomeSize, data=genome,
     col = myColours[Suborder], pch = mySymbols[Suborder],
     xlab="Total length (mm)", ylab="Genome Size (pg)")
legend("topleft", legend=levels(genome$Suborder), 
       col=myColours, pch=mySymbols)

# Model fitting:
nullModelDragon <- lm(logBW ~ 1, data=genome, subset = Suborder == "Anisoptera")
genomeSizeModelDragon <- lm(logBW ~ logGS, data=genome, subset = Suborder == "Anisoptera")

summary(genomeSizeModelDragon) #to look at coefficients
# t-test shows the intercept and slope are significantly different from zero

# Look at terms with ANOVA:
anova(genomeSizeModelDragon)

# For Damselflies
genomeSizeModelDamsel <- lm(logBW ~ logGS, data=genome,subset=Suborder=='Zygoptera')
summary(genomeSizeModelDamsel)
anova(genomeSizeModelDamsel)

# Plotting fitted regression model
myCol <- c('red','blue')

plot(logBW ~ logGS, data=genome, col=myCol[Suborder], xlab='log Genome Size (pg)', ylab='log Body Weight (g)')
abline(genomeSizeModelDragon, col='red')
abline(genomeSizeModelDamsel, col='blue')

# Check if models are appropriate - diagnostic plots
par(mfrow = c(2,2), mar = c(5, 5, 1.5, 1.5))
plot(genomeSizeModelDragon)






