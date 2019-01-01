#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Dec 2018

rm(list=ls())
graphics.off()

#1 - Measure species richness based on input vector
species_richness <- function(community){
    return(length(unique(community)))
}

#3 - Initialise min
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

neutral_step2 <- function(community){
    x <- choose_two(length(community))
    new <- replace(community, x[1], max(community)+10)
    return(new)
}

#9 - Neutral step with speciation
neutral_step_speciation <- function(community, v){
    p <- runif(1, 0, 1)
    if (p < v){
        neutral_step2(community)}
    else {
        neutral_step(community)}
}

#10 - Neutral generation with speciation
neutral_generation_speciation <- function(community, v){
    gentime <- ceiling(length(community)/2)
    for (i in (1:gentime)){
        community <- neutral_step_speciation(community, v)
    }
return(community)
}

#13 - Species abundance
species_abundance <- function(community){
    sort(as.numeric(table(community)), decreasing = TRUE)
}

#14 - Bins
octaves <- function(community){
    j <- tabulate(floor(log2(community)+1))
    return(j)
}

#17 - Cluster
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name){
    input_params <- list(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations)
    community <- initialise_min(size)
    rich <- c()
    abundance <- list()
    i <- 0
    gens <- 0
    ptm <- proc.time()
    time <- proc.time() - ptm
    while (as.numeric(time[3]) < wall_time*60){
        community <- neutral_generation_speciation(community, speciation_rate)
        if (gens <= burn_in_generations){
            if (gens %% interval_rich == 0){
                rich <- c(rich, species_richness(community))
            }
        }
        if (gens %% interval_oct == 0){
            a <- species_abundance(community)
            i = i + 1
            abundance[[i]]=a
        }
        time <- proc.time() - ptm
        gens = gens + 1
    }
    save(rich, abundance, community, wall_time, input_params, file = output_file_name)
}


#cluster_run(speciation_rate=0.1, size=100, wall_time=1, interval_rich=1, interval_oct=10, burn_in_generations=200, output_file_name="my_test_file_1.rda")

## a way to time an R expression
# ptm <- proc.time()
# for (i in 1:50){
#     mad(stats::runif(500))
#     a <- proc.time() - ptm
#         while (as.numeric(a[3]) < 10){
#             print("Hello!")
#             a <- proc.time() - ptm
#     }
# }