#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Nov 2018

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
    new <- replace(community, x[1], community[x[2]]) # Remove and replace
    return(community)
}

#6 - Perform several steps of a neutral simulation so that a generation has passed on a community vector
neutral_generation <- function(community){
    gentime <- ceiling(length(community)/2) # determines number of neutral_steps based on community size
    for (i in (1:gentime)){
        community <- neutral_step(community)
    }
return(community)
}

#7 - Perform neutral simulation and return time series of species richness in the system
#       Takes an initial community vector and duration (number of gens) as inputs
neutral_time_series <- function(initial, duration){
    rich <- species_richness(initial) # Record starting species richness
    timeseries <- c(rich) # Initiialise vector to store species richness in
    for (i in (1:duration)){
        initial <- neutral_generation(initial)
        rich <- species_richness(initial)
        timeseries <- c(timeseries, rich) # Add to timeseries vector each loop
    }
    return(timeseries)
}

#8 - Time series graph of neutral model simulation with a system of 100 individuals and
#       maximum starting diversity for 200 generations. No input parameters are required
question_8 <- function(){
    plot((neutral_time_series(initialise_max(100), duration=200)), type="l", 
         xlab="Generations", ylab="Species richness")
}

#9 - 
neutral_step_speciation <- function(community, v){
    p <- runif(1, 0, 1)
    if (p < v){
        neutral_step2(community)}
    else {
        neutral_step(community)}
}

neutral_step2 <- function(community){
    x <- choose_two(length(community))
    new <- replace(community, x[1], max(community)+10)
    return(new)
}

#10 - 
neutral_generation_speciation <- function(community, v){
    gentime <- ceiling(length(community)/2)
    for (i in (1:gentime)){
        community <- neutral_step_speciation(community, v)
    }
return(community)
}

#11
neutral_time_series_speciation <- function(community, v, duration){
    rich <- species_richness(community)
    timeseries <- c(rich)
    for (i in (1:duration)){
        community <- neutral_generation_speciation(community, v)
        rich <- species_richness(community)
        timeseries <- c(timeseries, rich)
    }
    return(timeseries)
}

#12
question_12 <- function(){
    plot((neutral_time_series_speciation(initialise_max(100), v=0.1, duration=200)), col="blue", type="l", xlab="Generations", ylab="Species Richness", ylim=c(0,100))
    lines((neutral_time_series_speciation(initialise_min(100), v=0.1, duration=200)), col="red")
}

#13
species_abundance <- function(community){
    sort(as.numeric(table(community)), decreasing = TRUE)
}

#14
octaves <- function(community){
    j <- tabulate(floor(log2(community)+1))
    return(j)
}

#15
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

#16 
question_16 <- function(community, v, duration){
    for (i in (1:200)){
        community <- neutral_generation_speciation(community, v)}
    abundance <- species_abundance(community)
    oct <- octaves(abundance)
    for (i in (1:duration)){
        community <- neutral_generation_speciation(community, v)
        if (i %% 20 == 0){
            abundance <- species_abundance(community)
            oct <- sum_vect(oct, octaves(abundance))
        }
    }
    ave <- oct/101
    red <- rgb(0, 0, 1, alpha=0.5)
    barplot(ave, names.arg=seq(1:length(oct)), col=red, xlab="Bin", ylab="No. of species")
}
system.time(a <- question_16(initialise_max(100), 0.1, 2000))

#17
#keep for Q17
# question_16 <- function(community, v, duration){
#     community <- neutral_generation_speciation(initialise_max(100), 0.1)
#     #abundance <- species_abundance(community)
#     oct <- octaves(abundance)
#     results <- list()
#     for (i in (1:duration)){
#         community <- neutral_generation_speciation(community, v)
#         if (i %% 20 == 0){
#             abundance <- species_abundance(community)
#             oct <- octaves(abundance)
#             results[[i]] <- oct
#             return(results)}
#     } #keep running total of sum and no. of averaging
# }

#### Fractals ####
#22
A <- c(0,0)
B <- c(3,4)
C <- c(4,1)

chaos_game <- function(A, B, C){
    j <- list(A, B, C)
    plot(NA, xlim=c(0,5), ylim=c(0,5), xlab="X", ylab="Y")
    X <- c(0,0)
    points(X[1], X[2], cex=0.1)
    for (i in 1:100000){
        y <- sample(1:3, 1)
        choice <- j[[y]]
        Xx <- (choice[1] - X[1]) / 2
        Xy <- (choice[2] - X[2]) / 2
        X <- X + c(Xx, Xy)
        points(X[1], X[2], cex=0.1)}
}

#23
plot(NA, xlim=c(-2,2), ylim=c(0,4), xlab="X", ylab="Y")

turtle <- function(start, direction, length){
    newx <- start[1] + (length * (cos(direction)))
    newy <- start[2] + (length * (sin(direction)))
    segments(start[1], start[2], newx, newy)
    newvec <- c(newx, newy)
    return(newvec)
}

#24
elbow <- function(start, direction, length){
    newvec <- turtle(start, direction, length)
    turtle(c(newvec[1], newvec[2]), direction - (pi/4), (0.95 * length))
}

#25
spiral <- function(start, direction, length){
    newvec <- turtle(start, direction, length)
    spiral(c(newvec[1], newvec[2]), direction - (pi/4), (0.95 * length))
}

#26
spiral_2 <- function(start, direction, length){
    newvec <- turtle(start, direction, length)
    if (length > 0.05){
        spiral_2(c(newvec[1], newvec[2]), direction - (pi/4), (0.95 * length))
    }
}

#27
tree <- function(start, direction, length){
    newvec <- turtle(start, direction, length)
    if (length > 0.05){
        tree(c(newvec[1], newvec[2]), direction - (pi/4), (0.65 * length))
        tree(c(newvec[1], newvec[2]), direction + (pi/4), (0.65 * length))
    }
}

#28
fern <- function(start, direction, length){
    newvec <- turtle(start, direction, length)
    if (length > 0.01){
        fern(c(newvec[1], newvec[2]), direction + (pi/4), (0.38 * length))
        fern(c(newvec[1], newvec[2]), direction, (0.87 * length))
    }
}

#29
fern_2 <- function(start, direction, length, dir=-1){
    newvec <- turtle(start, direction, length)
    if (length > 0.001){
        dir <- -dir
        fern_2(c(newvec[1], newvec[2]), direction + dir*(pi/4), (0.38 * length), -dir)
        fern_2(c(newvec[1], newvec[2]), direction, (0.87 * length),dir)
        }
}