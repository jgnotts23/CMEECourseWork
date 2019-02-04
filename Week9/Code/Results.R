#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Jan 2019

rm(list=ls())
graphics.off()

myfiles <- list.files(path="../Data/", pattern="Output*")

#make lists of sizes then loop through to graph
size500 <- list()
size1000 <- list()
size2500 <- list()
size5000 <- list()


sum_vect <- function(x,y){
  if (length(x) < length(y)){
    diff <- length(y) - length(x)
    z <- rep(0, diff)
    x <- c(x, z)}
  if (length(y) < length(x)){
    diff <- length(x) - length(y)
    z <- rep(0, diff)
    y <- c(y, z)}
  return(x + y)
}


for(i in 1:length(myfiles)) {
  load(paste0("../Data/", myfiles[i]))
  if (input_params[2] == 500) {
    size500 <- c(size500, myfiles[i])
  }
  else if (input_params[2] == 1000) {
    size1000 <- c(size1000, myfiles[i])
  }
  else if (input_params[2] == 2500) {
    size2500 <- c(size2500, myfiles[i])
  }
  else {
    size5000 <- c(size5000, myfiles[i])
  }
}


## Sum all then average ##
average_abundances <- function(sizelist, J) {
  sizeaverage <- c()
  for(i in (1:length(sizelist))) {
    load(paste0("../Data/", sizelist[i]))
    total <- c()
    burn <- input_params[[6]] / input_params[[5]]
    for (i in (burn:length(abundance))) {
      total <- sum_vect(total, abundance[[i]])
    }
    average <- total / (length(abundance) - burn)
    sizeaverage <- sum_vect(sizeaverage, average)
  }
  return(sizeaverage / length(sizelist))
}


size500averages <- average_abundances(size500)
size1000averages <- average_abundances(size1000)
size2500averages <- average_abundances(size2500)
size5000averages <- average_abundances(size5000)

## Plotting ##
colours <- colors()[c(552,652,28,49,466,499,1,265,611,258,368)]
bins <- c("1", "2", "4", "8", "16", "32", "64", "128", "256", "512", "1024")
          
par(mfrow=c(2,2))
par(oma = c(4, 4, 1, 0))
par(mar = c(1, 2, 1, 1))
barplot(size500averages, col = alpha(colours, 0.6), xlab = '', ylab = '', xaxt = 'n', main="J = 500", ylim=c(0, 2))
barplot(size1000averages, col = alpha(colours, 0.6), ylab = '', xaxt = 'n', main="J = 1000")
barplot(size2500averages, col = alpha(colours, 0.6), xlab = '', ylab = '', main="J = 2500")
barplot(size5000averages, col = alpha(colours, 0.6), xlab = '', ylab = '', main="J = 5000")
legend(-5, 24, legend = bins, fill = alpha(colours, 0.6), xpd = "NA", cex=0.7)
mtext('Min. species abundance (No. individuals)', side = 1, outer = TRUE, line = 2)
mtext('Number of species', side = 2, outer = TRUE, line = 2)




