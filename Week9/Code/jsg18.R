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
    community <- replace(community, x[1], community[x[2]]) # Remove and replace
    return(community)
}

#6 - Perform several steps of a neutral simulation so that a generation has passed on a community vector
neutral_generation <- function(community){
    gentime <- ceiling(length(community)/2) # determines number of neutral_steps based on community size
    for (i in (1:gentime)){
        community <- neutral_step(community) #performs neutral steps until gentime is reached
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

# The function neutral_step_speciation calls IF speciation occurs
neutral_step2 <- function(community){
    x <- choose_two(length(community))
    community <- replace(community, x[1], max(community)+10) # to ensure new species has new ID
    return(community)
}

#10 - Similar to neutral_generation but now incorporates speciation probability, v,
#       by calling neutral_step_speciation
neutral_generation_speciation <- function(community, v){
    gentime <- ceiling(length(community)/2)
    for (i in (1:gentime)){
        community <- neutral_step_speciation(community, v)
    }
return(community)
}

#11 - Similar to neutral_time_series but now incorporates speciation rate, v
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

#12 - An example simulation which uses v=0.1, community size (J) = 100, and 200 generations.
#       The community is recorded as a timeseries and plotted. Both initialise_max and
#       initialise_min are used at the beginning for comparison purposes and plotted together
question_12 <- function(){
    plot((neutral_time_series_speciation(initialise_max(100), v=0.1, duration=200)), col="blue", 
         type="l", xlab="Generations", ylab="Species Richness", ylim=c(0,100), main="v = 0.1, J = 100, gens = 200")
    lines((neutral_time_series_speciation(initialise_min(100), v=0.1, duration=200)), col="red")
    legend(140, 95, legend=c("Initialise_max(100)", "Initialise_min(100)"),
           col=c("blue", "red"), lty=1:1, cex=0.8)
}

#13 - Determining species abundance from an input community vector
#       Returns vector with the number of the most abundant species first and decreasing thereafter
species_abundance <- function(community){
    sort(as.numeric(table(community)), decreasing = TRUE)
}

#14 - Bins species abundance into 'octave classes' based on log2(abundances)
octaves <- function(community){
    j <- tabulate(floor(log2(community)+1))
    return(j)
}

#15 - Sums 2 vectors, regardless of length. Circumvents the recycling tendency of R by adding
#       0's to make the vectors the same length. This function is needed as the vectors that 
#       octaves() returns may not always be the same length
sum_vect <- function(x,y){
    if (length(x) < length(y)){
        diff <- length(y) - length(x)
        z <- rep(0, diff) #fill difference with 0's
        x <- c(x, z)}
    if (length(y) < length(x)){
        diff <- length(x) - length(y)
        z <- rep(0, diff)
        y <- c(y, z)}
    return(x + y)
}

#16 - Neutral simulation with v=0.1, J=100, and a burn-in time of 200 generations.
#       After this, the species abundance octave is recorded and a further 2000 generations are
#       run. The octaves continue to be recorded every 20 generations and are plotted
question_16 <- function(community = initialise_max(100)){
    v <- 0.1 #speciation rate
    duration <- 2000 #generations after burn=in
    for (i in (1:200)){ #burn-in period
        community <- neutral_generation_speciation(community, v)
    }
    abundance <- species_abundance(community)
    oct <- octaves(abundance)
    for (i in (200:(duration+200))){ #post burn-in
        community <- neutral_generation_speciation(community, v)
        if (i %% 20 == 0){
            abundance <- species_abundance(community)
            oct <- sum_vect(oct, octaves(abundance))
        }
    }
   
    ave <- oct/101 #average octave bin values
    blue <- rgb(0, 0, 1, alpha=0.5)
    barplot(ave, names.arg=seq(1:length(oct)), col=blue, xlab="Bin", ylab="No. of species")
    
}

#Challenge A - Plotting mean species richness over time (measured in simulations steps) across
#     a large number (200) of repeat simulations
# This function performs a neutral-step timeseries for an input number of steps
neutral_step_timeseries <- function(community, v=0.1, steps) {
  rich <- species_richness(community)
  timeseries <- c(rich)
  for (i in (1:steps)){
    community <- neutral_step_speciation(community, v)
    rich <- species_richness(community)
    timeseries <- c(timeseries, rich)
  }
  
  return(timeseries) #returns timeseries of species richness for one simulation
}

# This function calls neutral_step_timeseries as many times as is specified by the input parameter
# 'simulations'. It returns an average across all the simulations performed
neutral_step_timeseries_simulations <- function(community, steps, simulations) {
  total_timeseries <- c()
  for (i in (1:simulations)) {
    timeseries <- neutral_step_timeseries(community, 0.1, steps)
    total_timeseries <- sum_vect(total_timeseries, timeseries)
  }
  
  average <- total_timeseries / simulations
  return(average) #an average richness over time (neutral steps)
}

# To plot the averaged simulations over time. The starting community species richness is 100,
# 200 simulations are run and each simulation contains 4000 neutral steps
# This is then compared with an identical simulation except the starting species richness is 1.
challenge_A <- function() {
  plot((neutral_step_timeseries_simulations(initialise_max(100), 4000, 200)), type="l", col="blue",
       xlab="Time (neutral steps)", ylab="Species richness", ylim=c(0, 100))
  lines(neutral_step_timeseries_simulations(initialise_min(100), 4000, 200), col="red")
  legend(2500, 95, legend=c("Initialise_max(100)", "Initialise_min(100)"),
         col=c("blue", "red"), lty=1:1, cex=0.8)
  }

#Challenge B - an extension fo challenge A with several different starting species richnesses
challenge_B <- function() {
  set.seed(123)
  com1 <- sample(1:25, 100, replace=TRUE) #choosing 100 integers between 1 and 25
  com2 <- sample(1:60, 100, replace=TRUE)
  com3 <- sample(1:250, 100, replace=TRUE)
  com4 <- sample(1:5, 100, replace=TRUE)
  
  plot((neutral_step_timeseries_simulations(com4, 2000, 200)), type="l", col="blue", lwd=2,
       xlab="Time (neutral steps)", ylab="Species richness", ylim=c(0, 100))
  lines(neutral_step_timeseries_simulations(com1, 2000, 200), col="red", lwd=2)
  lines(neutral_step_timeseries_simulations(com2, 2000, 200), col="green", lwd=2)
  lines(neutral_step_timeseries_simulations(com3, 2000, 200), col="yellow", lwd=2)
  legend(1500, 97, title="Initial species richness", legend=c("83", "48", "25", "5"),
         col=c("yellow", "green", "red", "blue"), lty=1:1, cex=0.8, lwd=2)
}

#20 - Reading in and analysing the HPC output files
myfiles <- list.files(path="../Data/", pattern="Output*") #make list of file paths

# Make lists of community sizes then loop through to assign to lists
size500 <- list()
size1000 <- list()
size2500 <- list()
size5000 <- list()

for(i in 1:length(myfiles)) {
  load(paste0("../Data/", myfiles[i]))
  if (input_params[2] == 500) { #checking community size
    size500 <- c(size500, myfiles[i]) #assign to list
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


# Looping through each community size and averaging abundances after burn-in
average_abundances <- function(sizelist) {
  sizeaverage <- c()
  for(i in (1:length(sizelist))) { #loop through files
    load(paste0("../Data/", sizelist[i]))
    total <- c()
    burn <- input_params[[6]] / input_params[[5]] #calculate burn-in
    for (i in (burn:length(abundance))) { #only use octaves recorded after burn-in
      total <- sum_vect(total, abundance[[i]]) #sum all octaves
    }
    average <- total / (length(abundance) - burn) #calculate average for each bin
    sizeaverage <- sum_vect(sizeaverage, average) #accumulate averages for each simulation
  }
  return(sizeaverage / length(sizelist)) #return average for all simulations in each size
}

#Raw data used to plot fraphs in question 20
size500averages <- average_abundances(size500)
size1000averages <- average_abundances(size1000)
size2500averages <- average_abundances(size2500)
size5000averages <- average_abundances(size5000)

# Function to plot all averaged octave classes
question_20 <- function () {
  colours <- colours()[c(552,652,28,49,466,499,1,265,611,258,368)] 
  bins <- c("1", "2", "4", "8", "16", "32", "64", "128", "256", "512", "1024")
  add.alpha <- function(cols, alpha) rgb(t(col2rgb(cols)/255), alpha = alpha)
  
  par(mfrow=c(2,2))
  par(oma = c(4, 4, 1, 0)) #make room in margins
  par(mar = c(2, 2, 1, 1))

  # Barplots of average octave classes for each size in a multi-panel plot
  barplot(size500averages, col = add.alpha(colours, 0.5), xlab = '', ylab = '', xaxt = 'n', main="J = 500")
  barplot(size1000averages, col = add.alpha(colours, 0.5), ylab = '', xaxt = 'n', main="J = 1000")
  barplot(size2500averages, col = add.alpha(colours, 0.5), xlab = '', ylab = '', main="J = 2500")
  barplot(size5000averages, col = add.alpha(colours, 0.5), xlab = '', ylab = '', main="J = 5000")
  legend(-5, 26, legend = bins, fill = add.alpha(colours, 0.6), xpd = "NA", cex=0.7)
  mtext('Min. species abundance (No. individuals)', side = 1, outer = TRUE, line = 2)
  mtext('Number of species', side = 2, outer = TRUE, line = 2)
}

#### Challenge Question C ####
average_richness <- function(sizelist) {
  total_richness <- c()
  for(i in (1:length(sizelist))) {
    load(paste0("../Data/", sizelist[i]))
    total_richness <- sum_vect(total_richness, rich)
  }
  
  return(total_richness / length(sizelist))
}

challenge_C <- function () {
  par(mfrow=c(1,1))
  plot(average_richness(size5000), type='l', xlim=c(0, 2000), ylab="Species richness (average)", xlab="Generation")
  lines(average_richness(size2500), type='l', col='blue')
  lines(average_richness(size1000), type='l', col='green')
  lines(average_richness(size500), type='l', col='red')
  legend(1650, 110, title="J value", legend = c("5000", "2500", "1000", "500"), col = c("black", "blue", "green", "red"), xpd="NA", cex=0.8, lwd=2)
}


#### Challenge Question D ####
coalescence <- function (v, J) {
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


challenge_D <- function (v=0.004361, J) {
  abundances <- c()
  abund <- c()
  ptm <- proc.time() #start timer
  time <- proc.time() - ptm
  for (i in 1:2000) {
    abund <- coalescence(v, J)
    abund <- sort(abund, decreasing = TRUE)
    abund <- octaves(abund)
    abundances <- sum_vect(abundances, abund)
  }
  
  time <- proc.time() - ptm
  print(time)
  average <- abundances / 20000
  return(average)
}


#### Fractals ####

#22 - The chaos game, draws a Sierpinski Gasket is the divisor is 2
A <- c(0,0)
B <- c(3,4)
C <- c(4,1)

par(mfrow=c(1,1))
plot(NA, xlim=c(0,5), ylim=c(0,5), xlab="X", ylab="Y") #blank plot

chaos_game <- function(A, B, C){
    j <- list(A, B, C)
    X <- c(0,0)
    points(X[1], X[2], cex=0.1)
    for (i in 1:5000){
        y <- sample(1:3, 1) #choose A B or C at random
        choice <- j[[y]]
        Xx <- (choice[1] - X[1]) / 2 #Move half way towards that point
        Xy <- (choice[2] - X[2]) / 2
        X <- X + c(Xx, Xy) 
        if (i < 10) { #plot new value of X
          points(X[1], X[2], cex=0.1) #to view initial points better
        }
        else {
          points(X[1], X[2], cex=0.1)
        }
    }
}

#23 - Drawing a line between two points on a graph. 
#     Requires start(vector), direction (in degrees), length(of the plotted line)
plot(NA, xlim=c(-2,2), ylim=c(0,4), xlab="X", ylab="Y") #blank plot

turtle <- function(start, direction, length){
    newx <- start[1] + (length * (cos(direction))) # adds length multiplied by angle to x coordianate
    newy <- start[2] + (length * (sin(direction)))
    segments(start[1], start[2], newx, newy) #draws line segment between two points
    newvec <- c(newx, newy)
    return(newvec) #returns new vector
}

#24 - Calls turtle twice to draw a pair of lines that join together
#     Requires start(vector), direction (in degrees), length(of the first line)
elbow <- function(start, direction, length){
    newvec <- turtle(start, direction, length)
    # Now runs turtle again from the new vector and applies the angle (pi/4) and reduces the length by 5%
    turtle(c(newvec[1], newvec[2]), direction - (pi/4), (0.95 * length))
}

#25 - Iterative function that draws a spiral
spiral <- function(start, direction, length){
    newvec <- turtle(start, direction, length) #calls turtle once
    # Now it calls itself - will throw an error due to the infinite recursion
    spiral(c(newvec[1], newvec[2]), direction - (pi/4), (0.95 * length))
}

#26 - Edit of 'spiral' that stops when the line length reaches a certain size, preventing the infinite recursion
spiral_2 <- function(start, direction, length, e){ #new variable e specifies line length limit
    newvec <- turtle(start, direction, length)
    if (length > e){ #condition preventing infinite recursion
        spiral_2(c(newvec[1], newvec[2]), direction - (pi/4), (0.95 * length), e)
    }
}

#27 - Similar to 'spiral_2' but now the function calls itself twice, once to the left and once
#     to the right, making a tree-like structure
tree <- function(start, direction, length, e){
    newvec <- turtle(start, direction, length)
    if (length > e){
        tree(c(newvec[1], newvec[2]), direction - (pi/4), (0.65 * length), e) #left
        tree(c(newvec[1], newvec[2]), direction + (pi/4), (0.65 * length), e) #right
    }
}

#28 - Similar to 'tree' but now one internal call goes 45 degrees to the left, while the other
#     goes straight on. The length multiples have been changed too and half a fern-like object should be plotted
fern <- function(start, direction, length, e){
    newvec <- turtle(start, direction, length)
    if (length > e){
        fern(c(newvec[1], newvec[2]), direction + (pi/4), (0.38 * length), e) #left
        fern(c(newvec[1], newvec[2]), direction, (0.87 * length), e) #straight on
    }
}

#29 - An extenstion of 'fern' that incorporates a new parameter 'dir'. This parameter decides
#     which side of the fern is plotted
fern_2 <- function(start, direction, length, e, dir=-1){
    ptm <- proc.time()
    time <- proc.time() - ptm
    newvec <- turtle(start, direction, length)
    if (length > e){
        dir <- -dir #change sign of dir each iteration
        fern_2(c(newvec[1], newvec[2]), direction + dir*(pi/4), (0.38 * length), e, -dir)
        fern_2(c(newvec[1], newvec[2]), direction, (0.87 * length), e, dir)
    }
    time <- proc.time() - ptm
    
    return(time)
}


#Challenge E - The chaos game with different values of X and divisor as input parameters
challenge_E <- function(A, B, C, X, divisor){
  j <- list(A, B, C)
  plot(NA, xlim=c(0,5), ylim=c(0,5), xlab="X", ylab="Y", main=paste("X = (", X[1], ",", X[2], "), divisor = ", divisor, sep = ""))
  points(X[1], X[2], cex=1.3, col="green", bg="green", pch=21)
  points(A[1], A[2], cex=1.3, col="blue", bg="red", pch=17) #plot A, B and C to help visualise
  points(B[1], B[2], cex=1.3, col="blue", bg="red", pch=17)
  points(C[1], C[2], cex=1.3, col="blue", bg="red", pch=17)
  
  for (i in 1:1500){
    y <- sample(1:3, 1)
    choice <- j[[y]]
    Xx <- (choice[1] - X[1]) / divisor #divisor is now an input parameter
    Xy <- (choice[2] - X[2]) / divisor
    X <- X + c(Xx, Xy)
    if (i < 10) {
      points(X[1], X[2], cex=1.3, col="red", bg="red", pch=21)
    }
    else {
      points(X[1], X[2], cex=0.1)
    }
  }
}


#Challenge F - Further analysis of 'fern_2' with different values of 'e'
challenge_F <- function(start, direction, length, e, dir=-1){
  graphics.off()
  par(mfrow=c(2,2))
  plot(NA, xlim=c(0,4), ylim=c(0,5), xlab="", ylab="Y", main=paste("e = ", e, ", system.time = 0.0132s", sep=""))
  time1 <- fern_2(start, direction, length, e, dir=-1)
  plot(NA, xlim=c(0,4), ylim=c(0,5), xlab="", ylab="", main=paste("e = ", e/2, ", system.time = 0.035s", sep=""))
  time2 <-fern_2(start, direction, length, e/2, dir=-1)
  plot(NA, xlim=c(0,4), ylim=c(0,5), xlab="X", ylab="Y", main=paste("e = ", e/4, ", system.time = 0.103s", sep=""))
  time3 <- fern_2(start, direction, length, e/4, dir=-1)
  plot(NA, xlim=c(0,4), ylim=c(0,5), xlab="X", ylab="", main=paste("e = ", e/8, ", system.time = 0.316s", sep=""))
  time4 <- fern_2(start, direction, length, e/8, dir=-1)

  times <- list(time1[3], time2[3], time3[3], time4[3])
  return(times)
}







