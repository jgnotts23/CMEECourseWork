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
neutral_step <- function(community){
    x <- choose_two(length(community))
    new <- replace(community, x[1], community[x[2]])
    return(new)
}

#6 - several steps
neutral_generation <- function(community){
    gentime <- ceiling(length(community)/2)
    for (i in (1:gentime)){
        community <- neutral_step(community)
    }
return(community)
}

#7 - S
neutral_time_series <- function(initial, duration){
    rich <- species_richness(initial)
    timeseries <- c(rich)
    for (i in (1:duration)){
        initial <- neutral_generation(initial)
        rich <- species_richness(initial)
        timeseries <- c(timeseries, rich)
    }
    return(timeseries)
}

#8 - time series graph
question_8 <- function(){
    plot((neutral_time_series(initialise_max(100), duration=200)), type="l", xlab="Generations", ylab="Species Richness")
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