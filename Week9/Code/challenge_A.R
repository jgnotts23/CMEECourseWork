#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Jan 2019

rm(list=ls())
graphics.off()


#1 - Measure species richness based on input community (as a vector)
#     For example, species_richness(c(1,4,4,5,1,6,1)) will return 4
species_richness <- function(community){
  return(length(unique(community))) #returns number of species
}

#2 - Generates initial state for simulation community with max species richness 
#     based on community size (an integer)
#     For example, initisalise_max(7) will return the vector c(1, 2, 3, 4, 5, 6, 7) 
initialise_max <- function(size){
  return(seq(1:size))
}

#3 - Generates initial state for simulation community with min species richness (monodominance)
#     based on community size (an integer)
#     For example, initisalise_min(4) will return the vector c(1, 1, 1, 1) 
initialise_min <- function(size){
  x <- rep(1, each=size)
  return(x)
}

#4 - Choose 2 random integers from 1 to the input parameter, x, from a uniform distribution
choose_two <- function(x){
  sample(1:x, 2, replace=F) # replace=F to ensure 2 different numbers are returned
}

#5 - Perform a single step of a neutral model simulation on a community vector
#       Selects an individual to die and another to replace at random
neutral_step <- function(community){
  x <- choose_two(length(community)) # Randomly selecting 2 individuals
  community <- replace(community, x[1], community[x[2]]) # Remove and replace
  return(community)
}

# The function neutral_step_speciation calls IF speciation occurs
neutral_step2 <- function(community){
  x <- choose_two(length(community))
  community <- replace(community, x[1], max(community)+10) # to ensure new species has new ID
  return(community)
}

#9 - Similar to neutral_step but a speciation probability, v, has now been included.
#     At each step of the model, the dead individual can either be replaced by a new species
#     or by another species that already exists in the system
neutral_step_speciation <- function(community, v){
  p <- runif(1, 0, 1) # picking a random number between 0 and 1 to determine if speciation has occured
  if (p < v){
    neutral_step2(community)} # speciation
  else {
    neutral_step(community)} # no speciation
}

#15 - Sums 2 vectors, regardless of length. Circumvents the recycling tendency of R by adding
#       0's to make the vectors the same length. This function is needed as the vectors that 
#       octaves() returns may not always be the same length
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


#Challenge A
neutral_step_timeseries <- function(community, v=0.1, steps) {
    rich <- species_richness(community)
    timeseries <- c(rich)
    for (i in (1:steps)){
      community <- neutral_step_speciation(community, v)
      rich <- species_richness(community)
      timeseries <- c(timeseries, rich)
    }
    
    return(timeseries)
}

neutral_step_timeseries_simulations <- function(community, steps, simulations) {
  total_timeseries <- c()
  for (i in (1:simulations)) {
    timeseries <- neutral_step_timeseries(community, 0.1, steps)
    total_timeseries <- sum_vect(total_timeseries, timeseries)
  }
  
  average <- total_timeseries / simulations
  return(average)
}


challenge_A <- function() {
  plot((neutral_step_timeseries_simulations(initialise_max(100), 4000, 200)), type="l", col="blue",
       xlab="Generations", ylab="Species richness", ylim=c(0, 100))
  lines(neutral_step_timeseries_simulations(initialise_min(100), 4000, 200), col="red")
}



