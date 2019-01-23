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
average_abundances <- function(sizelist) {
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
colours <- colours()[c(552,652,28,49,466,499,1,265,611,258,368)]
bins <- c("1", "2", "4", "8", "16", "32", "64", "128", "256", "512", "1024")
add.alpha <- function(cols, alpha) rgb(t(col2rgb(cols)/255), alpha = alpha)
          
par(mfrow=c(2,2))
par(oma = c(4, 4, 1, 0))
par(mar = c(2, 2, 1, 1))
barplot(size500averages, col = add.alpha(colours, 0.5), xlab = '', ylab = '', xaxt = 'n', main="J = 500")
barplot(size1000averages, col = add.alpha(colours, 0.5), ylab = '', xaxt = 'n', main="J = 1000")
barplot(size2500averages, col = add.alpha(colours, 0.5), xlab = '', ylab = '', main="J = 2500")
barplot(size5000averages, col = add.alpha(colours, 0.5), xlab = '', ylab = '', main="J = 5000")
legend(-5, 26, legend = bins, fill = add.alpha(colours, 0.6), xpd = "NA", cex=0.7)
mtext('Min. species abundance (No. individuals)', side = 1, outer = TRUE, line = 2)
mtext('Number of species', side = 2, outer = TRUE, line = 2)



#### Challenge Question C ####
par(mfrow=c(1,1))

average_richness <- function(sizelist) {
  total_richness <- c()
  for(i in (1:length(sizelist))) {
    load(paste0("../Data/", sizelist[i]))
    total_richness <- sum_vect(total_richness, rich)
  }
  
  return(total_richness / length(sizelist))
}

plot(average_richness(size5000), type='l', xlim=c(0, 2000))
lines(average_richness(size2500), type='l', col='blue')
lines(average_richness(size1000), type='l', col='green')
lines(average_richness(size500), type='l', col='red')



#### Challenge Question D ####
challenge_D <- function (v, J) {
  lineages <- c(rep(1, J))
  abundances <- c()
  N <- J
  theta <- v * ((J-1)/(1-v))
  while (N > 1) {
    j <- sample(1:(length(lineages)), 1)
    randnum <- runif(1, min = 0, max = 1)
    if (randnum < (theta/(theta + N - 1))) {
      abundances <- c(abundances, lineages[j])
    }
    else {
      i <- j
      while (i == j) {
        i <- sample(1:(length(lineages)), 1)
      }
    lineages[i] <- lineages[i] + lineages[j]
    }
    lineages <- lineages[-j]
    N <- N - 1
  }
  
  abundances <- c(abundances, lineages[1])
  return(abundances)
}


coalescence <- function (v=0.004361, J=500) {
  abundances <- c()
  abund <- c()
  for (i in 1:20000) {
    abund <- challenge_D(v, J)
    abund <- sort(abund, decreasing = TRUE)
    abund <- octaves(abund)
    abundances <- sum_vect(abundances, abund)
  }
  
  average <- abundances / 20000
  return(average)
}


abundance_matrix <- do.call(rbind, abundance)
colMeans(abundance_matrix)





