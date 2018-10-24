#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Oct 2018

# A script demonstrating the use of preallocation in R to 
# speed up processes

# Not using preallocation
first <- function(a){
    a <- NA
    for (i in 1:100000) {
    a <- c(a, i)
    }
    print(a)
}

print(system.time(first(a)))

# Using preallocation
second <- function(b){
    b <- rep(NA, 100000)

    for (i in 1:100000) {
        b[i] <- i
    }
    print(b)
}

print(system.time(second(b)))