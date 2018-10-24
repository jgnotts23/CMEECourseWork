#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Oct 2018

## run a simulation that involves sampling from a population

x <- rnorm(50) #Generate your population
doit <- function(x){
    x <- sample(x, replace = TRUE)
    if(length(unique(x)) > 30) { #only take mean if sample was sufficient
        print(paste("Mean of this sample was:", as.character(mean(x))))
        }
    }

## Run 100 iterations using vectorisation:
result <- lapply(1:100, function(i) doit(x))

## Or using a for loop:
result <- vector("list", 100) #Pre-allocate/initialise
for(i in 1:100) {
    result[[i]] <- doit(x)
}