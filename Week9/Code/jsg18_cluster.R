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
    community <- replace(community, x[1], community[x[2]])
    return(community)
}

neutral_step2 <- function(community){
    x <- choose_two(length(community))
    community <- replace(community, x[1], max(community)+10)
    return(community)
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

#17 - Function for the cluster, requires speciation rate, community size, wall_time (time on HPC), 
#     interval_rich (generation interval to record species richness), interval_oct (interval to record octaves)
#     burn in generation time, and output file name
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name){
    community <- initialise_min(size) #initialise community with minimal diversity
    rich <- c() #vector to store species richness
    abundance <- list() #list to store species abundance
    i <- 0 #initialise iteration counter
    gens <- 0 #initialise generations
    ptm <- proc.time() #start timer
    time <- proc.time() - ptm
    while (as.numeric(time[3]) < wall_time*60){ #Only run while wall_time hasn't been reached
        community <- neutral_generation_speciation(community, speciation_rate)
        if (gens < burn_in_generations){ #Burn in generations
            if (gens %% interval_rich == 0){
                rich <- c(rich, species_richness(community))
            }
        }
        if (gens %% interval_oct == 0){ #record octaves throughout
            a <- species_abundance(community)
            a <- octaves(a)
            i = i + 1 #increment i
            abundance[[i]]=a
        }
        time <- proc.time() - ptm #update time
        gens = gens + 1 #increment gens
    }
    end_community <- species_abundance(community) #record final community 
    input_params <- list(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations)
    save(input_params, end_community, rich, abundance, file=output_file_name) #saving to output file
}

# A function to set the value of J based on iter (assigned by HPC)
set_J <- function(iter) {
  if ((iter-1) %% 4 == 0) {
    J <- 500
  }
  else if ((iter-2) %% 4 == 0) {
    J <- 1000
  } 
  else if ((iter-3) %% 4 ==0) {
    J <- 2500
  }
  else {
    J <- 5000
  }
}

iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX")) #assigned by HPC shell script
J <- set_J(iter) #set community size based on iter
set.seed(iter) #to control random number generation
output_file <- paste(c("Output", iter, ".rda"), collapse = "") #unique output file name

#To run on the cluster
cluster_run(speciation_rate = 0.004361, size=J, wall_time = 690, interval_rich = 1, interval_oct = (J/10), burn_in_generations = (8*J), output_file_name = output_file)



