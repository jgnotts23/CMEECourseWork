#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Nov 2018

rm(list=ls())
graphics.off()

#1 - measure species richness based on input vector
species_richness <- function(community){
    return(length(unique(community)))
}

#2 - function to define max possible species in community
initialise_max <- function(size){
    return(seq(1:size))
}

#3 - Monodominance
initialise_min <- function(size){
    x <- rep(1, each=size)
    return(x)
}

#4 - Generating two random integers
choose_two <- function(x){
    sample(1:x, 2, replace=F)
}

#5 - single step of neutral model sim
neutral_step <- function(y){
    x <- choose_two(length(y))
    new <- replace(y, x[1], y[x[2]])
    return(new)
}

#6 - several steps
neutral_generation <- function(a){
    gentime <- ceiling(sum(a)/2)
    for (i in (1:gentime)){
        a <- neutral_step(a)
    }
return(a)
}

#7 - S
neutral_time_series <- function(initial, duration){
    for (i in (1:duration)){
        initial <- neutral_generation(initial)
        print(initial)
    }
}