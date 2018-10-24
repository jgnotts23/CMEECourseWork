#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Oct 2018

# Import data
load("../Data/KeyWestAnnualMeanTemperature.RData")
str(ats)
plot(ats)

# Create vectors
t1<-ats[1:98,2]
t2<-ats[2:99,2]

a = cor(t1, t2)

doit <- function(x,y){
    s1<-sample(x,length(x))
    s2<-sample(y,length(y))
    cor(s1,s2)
}

results <- lapply(1:10000,function(i) doit(t1,t2))

pval<-length(results[results>a])/length(results)


# Open a pdf file
pdf("../Data/rplot.pdf") 
# 2. Create a plot
myhist <- hist(as.numeric(results), xlab="Correlation", main="Correlation Histogram")
abline(v=a, col="red")
xfit <- seq(min(a), max(a), length = 50) 
yfit <- dnorm(xfit, mean = mean(a), sd = sd(a)) 
yfit <- yfit * diff(myhist$mids[1:2]) * length(a)
lines(xfit, yfit, col="black", lwd=2)
# Close the pdf file
dev.off() 

