#!/usr/bin/Rscript
# Author - Jacob Griffiths, jacob.griffiths18@imperial.ac.uk
# Date - Oct 2018
# Desc - How to plot in R


# Load dataframe
MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

# Check size of dataframe
dim(MyDF)

# Predator mass vs. Prey mass
plot(MyDF$Predator.mass,MyDF$Prey.mass)

# Try logs
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass))

# Change 'p'lot 'ch'aracters, 'pch'
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),pch=20)

# Add labels
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),pch=20, xlab = "Predator Mass (kg)", ylab = "Prey Mass (kg)")


### Histograms ###

# How about a histogram?
hist(MyDF$Predator.mass)

# Try logs again
hist(log(MyDF$Predator.mass), xlab = "Predator Mass (kg)", ylab = "Count")

# Change bar and borders colour
hist(log(MyDF$Predator.mass), xlab = "Predator Mass (kg)", ylab = "Count", 
    col = "lightblue", border = "pink")

# Do the same for Prey
hist(log(MyDF$Prey.mass), xlab = "Predator Mass (kg)", ylab = "Count", 
    col = "lightblue", border = "pink")


### Subplots ###

par(mfcol=c(2,1)) #initialize multi-paneled plot
par(mfg = c(1,1)) #specify which sub-plot to use first
hist(log(MyDF$Predator.mass),
    xlab = "Predator Mass (kg)", ylab = "Count", 
    col = "lightblue", border = "pink", 
    main = "Predator") #Add title
par(mfg = c(2,1)) #second sub-plot
hist(log(MyDF$Prey.mass),
    xlab = "Prey Mass (kg)", ylab = "Count",
    col = "lightgreen", border = "pink",
    main = "Prey")


### Overlaying plots ###

hist(log(MyDF$Predator.mass), 
    xlab = "Body Mass (kg)", ylab = "Count",
    # rgb specifies amount of red, green, and blue for a colour in a plot
    # the fourth value, alpha, specifies transparency level
    col = rgb(1, 0, 0, 0.5), 
    main = "Predator-prey size Overlap")
hist(log(MyDF$Prey.mass), col = rgb(0, 0, 1, 0.5), add = T) #Plot grey
legend("topleft", c("Predators", "Prey"), #Add legend
    fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) #Define legend colours


### Boxplots ###

boxplot(log(MyDF$Predator.mass), xlab = "Location", ylab = "Predator Mass", main = "Predator Mass")

# Sort by location
# Tilde, '~', tells R to subdivide analysis and plot by the location
boxplot(log(MyDF$Predator.mass) ~ MyDF$Location,
    xlab = "Location", ylab = "Predator Mass",
    main = "Predator Mass by Location")

# Sort by feeding interaction type
boxplot(log(MyDF$Predator.mass) ~ MyDF$Type.of.feeding.interaction,
    xlab = "Location", ylab = "Predator Mass",
    main = "Predator mass by feeding interaction type")


### Combining Plot Types ###

# Adding boxplots of the marginal variables to the scatterplot
par(fig=c(0,0.8,0,0.8)) # specify figure size as proportion
 plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass), xlab = "Predator Mass (kg)", ylab = "Prey Mass (kg)") # Add labels
 par(fig=c(0,0.8,0.4,1), new=TRUE)
 boxplot(log(MyDF$Predator.mass), horizontal=TRUE, axes=FALSE)
 par(fig=c(0.55,1,0,0.8),new=TRUE)
 boxplot(log(MyDF$Prey.mass), axes=FALSE)
 mtext("Fancy Predator-prey scatterplot", side=3, outer=TRUE, line=-3)


 ### Lattice Plots ###

 library(lattice)

 densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=MyDF)


### Saving Graphics ###

pdf("../Results/Pred_Prey_Overlay.pdf", # Open blank pdf page 
    11.7, 8.3) # These numbers are page dimensions in inches
hist(log(MyDF$Predator.mass), # Plot predator histogram (note 'rgb')
    xlab="Body Mass (kg)", ylab="Count", col = rgb(1, 0, 0, 0.5), main = "Predator-Prey Size Overlap") 
hist(log(MyDF$Prey.mass), # Plot prey weights
    col = rgb(0, 0, 1, 0.5), 
    add = T)  # Add to same plot = TRUE
legend('topleft',c('Predators','Prey'), # Add legend
    fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) 
graphics.off(); #you can also use dev.off()